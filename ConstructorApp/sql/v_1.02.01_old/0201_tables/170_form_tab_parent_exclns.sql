Create Table fc22.form_tab_parent_exclns
    (form_code                      Varchar2(4000),
    tab_code                       Varchar2(4000),
    parent_form_code               Varchar2(4000),
    included_flag                  Varchar2(2),
    excln_id                       Number)
/

Comment On Table fc22.form_tab_parent_exclns Is 'Select a.child_form_code As form_code, a.tab_code, a.form_code As parent_form_code, ''Y'' As included_flag From form_tabs a Where a.child_form_code = ''INS_INS_INSURED'''
/
Comment On Column fc22.form_tab_parent_exclns.excln_id Is 'ID'
/
