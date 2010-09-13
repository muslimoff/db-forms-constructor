Create Or Replace 
Package apps.xxfnd_apps_utils_pkg Is
   Function validate_ebs_login (p_username Varchar2, p_password Varchar2, p_url_params Varchar2)
      Return Varchar2;
End xxfnd_apps_utils_pkg;
/


Create Or Replace 
PACKAGE BODY apps.xxfnd_apps_utils_pkg Is
   Function apps_initialize (p_transaction_id Number)
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
   Begin
      Begin
         --
         Select b.session_id, b.user_id, b.responsibility_application_id, b.responsibility_id, b.nls_language
               ,b.security_group_id, b.node_id
           Into l_session_id, l_user_id, l_responsibility_appl_id, l_responsibility_id, l_nls_language
               ,l_security_group_id, l_node_id
           From icx_transactions a, icx_sessions b
          Where 1 = 1
            And transaction_id = p_transaction_id
            And a.session_id = b.session_id
            And b.disabled_flag != 'Y';

         apps.fnd_global.apps_initialize (user_id                => l_user_id
                                         ,resp_id                => l_responsibility_id
                                         ,resp_appl_id           => l_responsibility_appl_id
                                         ,security_group_id      => l_security_group_id
                                         ,server_id              => l_node_id
                                         );
         l_success    := 'Y';
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

--      DBMS_OUTPUT.put_line (SUBSTR ('Value of l_transaction_id=' || l_transaction_id, 1, 255));
      If l_transaction_id Is Not Null Then
         l_res    := apps_initialize (l_transaction_id);
      End If;

      If l_res = 'N' Then
         l_res    := fnd_web_sec.validate_login (p_username, p_password);
      End If;

      Return l_res;
   End validate_ebs_login;
End xxfnd_apps_utils_pkg;
/

