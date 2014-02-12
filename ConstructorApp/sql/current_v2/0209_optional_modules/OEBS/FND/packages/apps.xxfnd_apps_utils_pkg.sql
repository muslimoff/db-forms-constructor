-- Start of DDL Script for Package APPS.XXFND_APPS_UTILS_PKG
-- Generated 17.11.2013 2:58:14 from APPS@KZM_HRDEV

Create Or Replace Package xxfnd_apps_utils_pkg Is
   g_responsibility_id         Number;
   g_fc_module_name   Constant Varchar2 (64) := 'BAS Form Constructor';

   Procedure launch;

   Function validate_ebs_login (p_username Varchar2, p_password Varchar2, p_url_params Varchar2)
      Return Varchar2;
End xxfnd_apps_utils_pkg;
/

Create Or Replace Package Body xxfnd_apps_utils_pkg Is
   Procedure launch Is
      l_url              Varchar2 (256)            := fnd_web_config.JSP_AGENT || 'ConstructorApp.html';
      l_transaction_id   Number;
      l_user_name        fnd_user.user_name%Type;
   Begin
      If (icx_sec.validatesession) Then
         Select NVL (Max (a.transaction_id), -1), Max (u.user_name)
           Into l_transaction_id, l_user_name
           From icx_transactions a, icx_sessions b, fnd_user u
          Where a.session_id = icx_sec.g_session_id
            And a.session_id = b.session_id
            And b.user_id = u.user_id;

         l_url    := l_url || '?transactionid=' || l_transaction_id;
         l_url    :=
            l_url || '&' || 'app.serverID=2&' || 'app.userName=' || l_user_name || '&' || 'app.pwd=x&' || 'locale=ru_RU';
         OWA_UTIL.redirect_url (l_url);
      End If;
   End launch;

   Function apps_initialize (
      p_transaction_id              Number
     ,p_valid_transacts_only_flag   Varchar2 Default 'Y'
     ,p_user_name                   fnd_user.user_name%Type Default Null
   )
      Return Varchar2 Is
      Pragma Autonomous_transaction;
      l_success                  Varchar2 (1)                                          := 'N';
      l_session_id               icx.icx_sessions.session_id%Type;
      l_user_id                  icx.icx_sessions.user_id%Type;
      l_responsibility_appl_id   icx.icx_sessions.responsibility_application_id%Type;
      l_responsibility_id        icx.icx_sessions.responsibility_id%Type;
      l_nls_language             icx.icx_sessions.nls_language%Type;
      l_security_group_id        icx.icx_sessions.security_group_id%Type;
      l_node_id                  icx.icx_sessions.node_id%Type;
      l_login_id                 icx.icx_sessions.login_id%Type;
      l_application_short_name   fnd_application.application_short_name%Type;
      l_username                 fnd_user.user_name%Type;
   Begin
      --выходим при пустом значении p_transaction_id
      If p_transaction_id Is Null Then
         Return l_success;
      End If;

      Begin
         --
         Select b.session_id, b.user_id, b.responsibility_application_id, b.responsibility_id, b.nls_language
               ,b.security_group_id, b.node_id, b.login_id, c.application_short_name, d.user_name
           Into l_session_id, l_user_id, l_responsibility_appl_id, l_responsibility_id, l_nls_language
               ,l_security_group_id, l_node_id, l_login_id, l_application_short_name, l_username
           From icx_transactions a, icx_sessions b, fnd_application c, fnd_user d
          Where 1 = 1
            And b.user_id = d.user_id
            And a.transaction_id = p_transaction_id
            And a.session_id = b.session_id
            And c.application_id = b.responsibility_application_id
            And b.disabled_flag != 'Y'
            And a.disabled_flag != DECODE (p_valid_transacts_only_flag, 'Y', 'Y', '#')
            And d.user_name = NVL (p_user_name, d.user_name);

         DBMS_SESSION.set_identifier (l_username);
         DBMS_APPLICATION_INFO.set_module (   g_fc_module_name
                                           || '; APP:'
                                           || l_application_short_name
                                           || '; RESP:'
                                           || l_responsibility_id
                                          ,'LOGIN'
                                          );
--         DBMS_APPLICATION_INFO.set_client_info ('FC APP:' || l_application_short_name || '');
         g_responsibility_id    := l_responsibility_id;
         apps.fnd_global.apps_initialize (user_id                => l_user_id
                                         ,resp_id                => l_responsibility_id
                                         ,resp_appl_id           => l_responsibility_appl_id
                                         ,security_group_id      => l_security_group_id
                                         ,server_id              => l_node_id
                                         );
         apps.fnd_global.initialize (fnd_const.login_id, l_login_id);
         /*Сбрасываем сессию (disabled_flag = 'Y') после успешного логина для предотвращения повторного входа без пароля
           Update icx_sessions s
              Set s.disabled_flag = 'Y'
            Where s.session_id = l_session_id;
          */--fnd_session_management.removetransaction (p_transaction_id);
         icx_sec.removetransaction (p_transaction_id);
         l_success              := 'Y';

         Execute Immediate 'alter session set nls_language=''' || l_nls_language || '''';

         Begin
            mo_global.init (p_appl_short_name => l_application_short_name);
         Exception
            When Others Then
               Null;
         End;

         Dt_Fndate.Set_Effective_Date (TRUNC (SYSDATE));

         -- dos08102013
         Declare
            b   Boolean;
         Begin
            b    := fnd_profile.SAVE_USER ('XXFC_CURRENT_RESP_ID', l_responsibility_id);
         Exception
            When Others Then
               Null;
         End;
      Exception
         When Others Then
            Null;
--            DBMS_OUTPUT.put_line (SQLERRM);
      End;

      Commit;
      Return l_success;
   End;

   Function validate_ebs_login (p_username Varchar2, p_password Varchar2, p_url_params Varchar2)
      Return Varchar2 Is
      l_transaction_id   Number;
      l_res              Varchar2 (1) := 'N';
   Begin
      l_transaction_id    := REGEXP_SUBSTR (REGEXP_SUBSTR (p_url_params, 'transactionid=[0-9]+'), '[0-9]+');
      l_res               := apps_initialize (l_transaction_id);

      If l_res = 'N' Then
         l_res    := fnd_web_sec.validate_login (p_username, p_password);

         If l_res = 'Y' Then
            l_res    := apps_initialize (l_transaction_id, 'N', UPPER (p_username));
         End If;
      End If;

      Return l_res;
   End validate_ebs_login;
End xxfnd_apps_utils_pkg;
/

-- End of DDL Script for Package APPS.XXFND_APPS_UTILS_PKG

