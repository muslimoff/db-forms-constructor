Create Or Replace Package Xxfnd_Apps_Utils_Pkg Is
  G_Responsibility_Id Number;
  G_Fc_Module_Name Constant Varchar2(64) := 'BAS Form Constructor';

  Procedure Launch;

  Function Validate_Ebs_Login(P_Username   Varchar2
                             ,P_Password   Varchar2
                             ,P_Url_Params Varchar2) Return Varchar2;
  Function Session_Timedout(P_Url_Params Varchar2) Return Varchar2;
  Procedure Reset_Session(P_Url_Params Varchar2);
End Xxfnd_Apps_Utils_Pkg;
/
Create Or Replace Package Body Xxfnd_Apps_Utils_Pkg Is

  Function Get_Transaction_Id(P_Url_Params Varchar2) Return Number As
  Begin
    Return To_Number(Regexp_Substr(Regexp_Substr(P_Url_Params
                                                ,'transactionid=[0-9]+')
                                  ,'[0-9]+'));
  End Get_Transaction_Id;

  Function Get_Session_Id(P_Url_Params Varchar2) Return Number As
    L_Transaction_Id Number;
    L_Session_Id     Number;
  Begin
    L_Transaction_Id := Get_Transaction_Id(P_Url_Params);
    Select Session_Id
      Into L_Session_Id
      From Icx_Transactions t
     Where Transaction_Id = L_Transaction_Id;
    Return L_Session_Id;
  End Get_Session_Id;

  Procedure Launch Is
    L_Url            Varchar2(256) := Fnd_Web_Config.Jsp_Agent ||
                                      'ConstructorApp.html';
    L_Transaction_Id Number;
    L_User_Name      Fnd_User.User_Name%Type;
  Begin
    If (Icx_Sec.Validatesession) Then
      Select Nvl(Max(A.Transaction_Id), -1), Max(U.User_Name)
        Into L_Transaction_Id, L_User_Name
        From Icx_Transactions a, Icx_Sessions b, Fnd_User u
       Where A.Session_Id = Icx_Sec.G_Session_Id
         And A.Session_Id = B.Session_Id
         And B.User_Id = U.User_Id;
    
      L_Url := L_Url || '?transactionid=' || L_Transaction_Id;
      L_Url := L_Url || '&' || 'app.serverID=2&' || 'app.userName=' ||
               L_User_Name || '&' || 'app.pwd=x&' || 'locale=ru_RU';
      Owa_Util.Redirect_Url(L_Url);
    End If;
  End Launch;

  Function Apps_Initialize(P_Transaction_Id            Number
                          ,P_Valid_Transacts_Only_Flag Varchar2 Default 'Y'
                          ,P_User_Name                 Fnd_User.User_Name%Type Default Null)
    Return Varchar2 Is
    Pragma Autonomous_Transaction;
    L_Success                Varchar2(1) := 'N';
    L_Session_Id             Icx.Icx_Sessions.Session_Id%Type;
    L_User_Id                Icx.Icx_Sessions.User_Id%Type;
    L_Responsibility_Appl_Id Icx.Icx_Sessions.Responsibility_Application_Id%Type;
    L_Responsibility_Id      Icx.Icx_Sessions.Responsibility_Id%Type;
    L_Nls_Language           Icx.Icx_Sessions.Nls_Language%Type;
    L_Security_Group_Id      Icx.Icx_Sessions.Security_Group_Id%Type;
    L_Node_Id                Icx.Icx_Sessions.Node_Id%Type;
    L_Login_Id               Icx.Icx_Sessions.Login_Id%Type;
    L_Application_Short_Name Fnd_Application.Application_Short_Name%Type;
    L_Username               Fnd_User.User_Name%Type;
  Begin
    --выходим при пустом значении p_transaction_id
    If P_Transaction_Id Is Null Then
      Return L_Success;
    End If;
  
    Begin
      --
      Select B.Session_Id
            ,B.User_Id
            ,B.Responsibility_Application_Id
            ,B.Responsibility_Id
            ,B.Nls_Language
            ,B.Security_Group_Id
            ,B.Node_Id
            ,B.Login_Id
            ,C.Application_Short_Name
            ,D.User_Name
        Into L_Session_Id
            ,L_User_Id
            ,L_Responsibility_Appl_Id
            ,L_Responsibility_Id
            ,L_Nls_Language
            ,L_Security_Group_Id
            ,L_Node_Id
            ,L_Login_Id
            ,L_Application_Short_Name
            ,L_Username
        From Icx_Transactions a
            ,Icx_Sessions     b
            ,Fnd_Application  c
            ,Fnd_User         d
       Where 1 = 1
         And B.User_Id = D.User_Id
         And A.Transaction_Id = P_Transaction_Id
         And A.Session_Id = B.Session_Id
         And C.Application_Id = B.Responsibility_Application_Id
            --And b.disabled_flag != 'Y'
         And A.Disabled_Flag !=
             Decode(P_Valid_Transacts_Only_Flag, 'Y', 'Y', '#')
         And D.User_Name = Nvl(P_User_Name, D.User_Name);
    
      Dbms_Session.Set_Identifier(L_Username);
      Dbms_Application_Info.Set_Module(G_Fc_Module_Name || '; APP:' ||
                                       L_Application_Short_Name ||
                                       '; RESP:' || L_Responsibility_Id
                                      ,'LOGIN');
      --         DBMS_APPLICATION_INFO.set_client_info ('FC APP:' || l_application_short_name || '');
      G_Responsibility_Id := L_Responsibility_Id;
      Apps.Fnd_Global.Apps_Initialize(User_Id           => L_User_Id
                                     ,Resp_Id           => L_Responsibility_Id
                                     ,Resp_Appl_Id      => L_Responsibility_Appl_Id
                                     ,Security_Group_Id => L_Security_Group_Id
                                     ,Server_Id         => L_Node_Id);
      Apps.Fnd_Global.Initialize(Fnd_Const.Login_Id, L_Login_Id);
      /*Сбрасываем сессию (disabled_flag = 'Y') после успешного логина для предотвращения повторного входа без пароля
       Update icx_sessions s
          Set s.disabled_flag = 'Y'
        Where s.session_id = l_session_id;
      */ --fnd_session_management.removetransaction (p_transaction_id);
      Icx_Sec.Removetransaction(P_Transaction_Id);
      L_Success := 'Y';
    
      Execute Immediate 'alter session set nls_language=''' ||
                        L_Nls_Language || '''';
    
      Begin
        Mo_Global.Init(P_Appl_Short_Name => L_Application_Short_Name);
      Exception
        When Others Then
          Null;
      End;
    
      Dt_Fndate.Set_Effective_Date(Trunc(Sysdate));
    
      -- dos08102013
      Declare
        b Boolean;
      Begin
        b := Fnd_Profile.Save_User('XXFC_CURRENT_RESP_ID'
                                  ,L_Responsibility_Id);
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
    Return L_Success;
  End;

  Function Validate_Ebs_Login(P_Username   Varchar2
                             ,P_Password   Varchar2
                             ,P_Url_Params Varchar2) Return Varchar2 Is
    L_Transaction_Id Number;
    L_Res            Varchar2(1) := 'N';
  Begin
    L_Transaction_Id := Get_Transaction_Id(P_Url_Params);
    L_Res            := Apps_Initialize(L_Transaction_Id);
  
    If L_Res = 'N' Then
      L_Res := Fnd_Web_Sec.Validate_Login(P_Username, P_Password);
    
      If L_Res = 'Y' Then
        L_Res := Apps_Initialize(L_Transaction_Id, 'N', Upper(P_Username));
      End If;
    End If;
  
    Return L_Res;
  End Validate_Ebs_Login;

  Function Session_Timedout(P_Url_Params Varchar2) Return Varchar2 As
    L_Session_Id      Number;
    L_Disabled_Flag   Varchar2(1);
    L_Session_Timeout Number := Fnd_Profile.Value('ICX_SESSION_TIMEOUT');
    L_Last_Connect    Date;
    L_Limit_Connects  Number;
    L_Counter         Number;
  Begin
    L_Session_Id      := Get_Session_Id(P_Url_Params);
    L_Session_Timeout := To_Number(Fnd_Profile.Value('ICX_SESSION_TIMEOUT')) / 60 / 24;
    Select Nvl(S.Disabled_Flag, 'N')
          ,S.Last_Connect
          ,S.Limit_Connects
          ,S.Counter
      Into L_Disabled_Flag, L_Last_Connect, L_Limit_Connects, L_Counter
      From Icx_Sessions s
     Where Session_Id = L_Session_Id;
    If L_Disabled_Flag = 'Y' Or
       L_Last_Connect + L_Session_Timeout <= Sysdate Or
       L_Counter >= L_Limit_Connects Then
      Return 'Y';
    Else
      Return 'N';
    End If;
  End Session_Timedout;

  Procedure Reset_Session(P_Url_Params Varchar2) As
    L_Session_Id Number;
  Begin
    L_Session_Id := Get_Session_Id(P_Url_Params);
    Fnd_Session_Management.Reset_Session(L_Session_Id);
  End Reset_Session;
End Xxfnd_Apps_Utils_Pkg;
/
