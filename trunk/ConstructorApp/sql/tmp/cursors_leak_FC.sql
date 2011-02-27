/* Formatted on 2010/11/03 20:07 (Formatter Plus v4.8.7) */
SELECT *
  FROM dict d
 WHERE d.table_name LIKE '%CURSOR%'
/
SELECT s.status, s.SID, s.serial#, s.username,
       REPLACE
             (REPLACE ('alter system kill session ''&sid&, &serial&'';',
                       '&sid&',
                       s.SID
                      ),
              '&serial&',
              s.serial#
             ) txt
  FROM v$session s
 WHERE s.username NOT IN ('SYS')
   AND s.program NOT IN ('SQLNav5.exe')
   AND s.status NOT IN ('KILLED')
/
SELECT c.*
  FROM v$open_cursor c, v$session s
 WHERE c.user_name NOT IN ('SYS', 'SYSMAN', 'DBSNMP')
   AND c.SID = s.SID
   AND c.saddr = s.saddr
   AND s.program NOT IN ('SQLNav5.exe')
   AND s.status NOT IN ('KILLED')
--   AND c.SID NOT IN (25, 23, 24, 21, 26, 22)
/
SELECT a.VALUE, s.username, s.SID, s.serial#, b.*
  FROM v$sesstat a, v$statname b, v$session s
 WHERE a.statistic# = b.statistic#
   AND s.SID = a.SID
--   AND s.SID = 15
   AND b.NAME = 'opened cursors current';

