Create Table lookups
    (lookup_code                    Varchar2(255),
    lookup_name                    Varchar2(255),
    apps_code                      Varchar2(255),
    search_mode_code               Varchar2(1),
    description                    CLOB)
/


-- Comments for LOOKUPS

Comment On Column lookups.apps_code Is '������������� ���������� (��� ������������ ��������)'
/
Comment On Column lookups.description Is '�������� (��� ������������)'
/
Comment On Column lookups.lookup_code Is '��������� ������������ (ID)'
/
Comment On Column lookups.lookup_name Is '���������������� ���'
/
Comment On Column lookups.search_mode_code Is '����� ������'
/

-- End of DDL Script for Table FC22.LOOKUPS

