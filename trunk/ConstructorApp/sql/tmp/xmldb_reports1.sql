--UNDER_PATH EQUALS_PATH PATH DEPTH
Select r.res.getClobVal () xmlval, EXTRACTVALUE (res, '//DisplayName') As display_name
      ,EXTRACTVALUE (res, '//ContentType') As content_type
      ,Extract (res, '//Contents/text/text()').getClobVal () As contents_
                                                                         --
       , any_path
  From resource_view r
 Where 1 = 1
--   And UNDER_PATH (res, '/public/reports') = 1
--   And EXTRACTVALUE (res, 'Resource/DisplayName') = 'xdbconfig.xml'
/

Declare
   v_xml_dir              Varchar2 (30) := '/public/reports';
   l_folder_exists_flag   Varchar2 (1)  := 'N';
   l_retb                 Boolean;
   l_clob                 Clob;
Begin
   --create folder
   Begin
      --DBMS_XDB.deleteresource (v_xml_dir);
      Select DECODE (Count (*), 0, 'N', 'Y')
        Into l_folder_exists_flag
        From resource_view r
       Where EQUALS_PATH (res, '/public/reports') = 1;

      DBMS_OUTPUT.put_line (SUBSTR ('Value of l_folder_exists_flag=' || l_folder_exists_flag, 1, 255));

      If     'N' = l_folder_exists_flag
         And DBMS_XDB.CreateFolder (v_xml_dir) Then
         --DBMS_XDB.setAcl (v_xml_dir, '/sys/acls/bootstrap_acl.xml');
         --DBMS_XDB.setAcl (v_xml_dir, '/sys/acls/all_owner_acl.xml');
         --DBMS_XDB.setAcl (v_xml_dir, '/sys/acls/ro_all_acl.xml');
         DBMS_OUTPUT.put_line ('Success');
      Else
         DBMS_OUTPUT.put_line ('FAILED!');
      End If;

      Commit;
   End;

   DBMS_XDB.deleteresource (v_xml_dir || '/file1.txt');
   l_retb    := DBMS_XDB.createresource (v_xml_dir || '/file1.txt', 'First line' || CHR (10) || 'Second line');

   Select a.clob_content
     Into l_clob
     From reports a
    Where a.report_id = -1;

--   DBMS_XDB.deleteresource (v_xml_dir || '/file4.rtf');
   l_retb    := DBMS_XDB.createresource (v_xml_dir || '/andrew11.rtf', l_clob);
   Commit;
End;

