Begin
   For cur In (With t As
                    (Select o.object_name, o.object_type, SIGN (INSTR (o.object_type, 'BODY')) is_body
                       From user_objects o
                      Where o.status = 'INVALID')
               Select t.*
                     ,    'alter '
                       || Replace (t.object_type, 'BODY', '')
                       || ' "'
                       || t.object_name
                       || '" compile'
                       || DECODE (is_body, 1, ' body') txt
                 From t) Loop
      Execute Immediate (cur.txt);
   End Loop;
End;
/
