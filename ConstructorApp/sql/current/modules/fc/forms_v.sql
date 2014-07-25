create or replace view forms_v as
Select A.Apps_Code
      ,A.Export_Order
      ,A.Form_Code
      ,A.Hot_Key
      ,A.Sql_Text
      ,Nvl(A.Form_Name, A.Form_Code) As Form_Name
      ,A.Description
      ,A.Form_Type
      ,A.Show_Tree_Root_Node
      ,A.Icon_Id
      ,A.Form_Width
      ,A.Form_Height
      ,Nvl(A.Bottom_Tabs_Orientation, 'T') As Bottom_Tabs_Orientation
      ,Nvl(A.Side_Tabs_Orientation, 'T') As Side_Tabs_Orientation
      ,Nvl(A.Show_Bottom_Toolbar, 'Y') Show_Bottom_Toolbar
      ,A.Object_Version_Number
      ,A.Default_Column_Width
      ,Double_Click_Action_Code
      ,Lookup_Width
      ,Lookup_Height
      ,Applications_Pkg.Get_Fc_Schema() As Fc_Schema
      ,Dragdrop_Action_Code
      ,Data_Page_Size
      ,Nvl(Sql_Count_Text
          ,'select count(1) cnt from (' || A.Sql_Text || ')') Sql_Count_Text
  From Forms a
 Where 1 = 1
/*      And (   SYS_CONTEXT ('USERENV', 'SESSION_USER') = applications_pkg.get_fc_schema ()
 Or a.form_code In (Select ap.form_code
                      From apps_privs ap, APPLICATIONS a
                     Where a.apps_code = ap.apps_code
                       And (a.schema_name = User))
)*/;
