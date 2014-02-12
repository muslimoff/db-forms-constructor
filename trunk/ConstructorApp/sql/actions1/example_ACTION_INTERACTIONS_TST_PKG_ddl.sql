CREATE OR REPLACE 
PACKAGE action_interactions_tst_pkg As
   Procedure p_test1 (p_num In Out Varchar2, p_message In Out Varchar2);
End;
/


CREATE OR REPLACE 
PACKAGE BODY action_interactions_tst_pkg As
   Procedure p_test1 (p_num In Out Varchar2, p_message In Out Varchar2) Is
      l_msg_btn   Varchar2 (10) := p_message;
   Begin
      --
      If l_msg_btn Is Null Then
         p_message    := '������?: ' || p_num || '`��`���`�� ����`����������';
         Return;
      End If;

      If l_msg_btn = 0 Then
         p_message    := Null;
         Return;
      End If;

      If l_msg_btn = 1 Then
         p_message    := '�� ������ ������ "���"?`��`���';
         Return;
      End If;

      If l_msg_btn = 2 Then
         p_message    := '�� �� ������?`�� ����...';
         Return;
      End If;

      If l_msg_btn = 3 Then
         p_message    := Null;
         raise_application_error (-20099, '����������...');
         Return;
      End If;
   End p_test1;
End;
/

