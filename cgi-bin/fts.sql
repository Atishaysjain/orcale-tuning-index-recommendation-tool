set serveroutput on
set feedback off
exec OWA.num_cgi_vars := 0
BEGIN
dbms_output.put_line('<HTML>');
dbms_output.put_line('<BODY BGCOLOR="#F5FFFA">');
dbms_output.put_line('<H4>FULL TABLE SCAN QUERIES </H4>');
dbms_output.put_line('<TABLE BORDER="1 ">');dbms_output.put_line('<TR><TH>SQL_ID</TH><TH>SQLTEXT</TH><TH>USER</TH></TH></TR>');
for idxfull in (select distinct sql_id AS "SQ",operation,options,object_owner as "OWN" from v$sql_plan  where  operation='TABLE ACCESS' and options='FULL' and object_owner='DBLOADGEN')
loop
for idxtxt in (select substr(REGEXP_REPLACE(sql_text,'\s*</?\w+((\s+\w+(\s*=\s*(".*?"|''.*?''|[^''">\s]+))?)+\s*|\s*)/?>\s*',NULL,1,0,'im'),1,4000) SQLTXT from dba_hist_Sqltext where sql_id=idxfull.SQ and sql_text not like '%SQL Analyze%' and sql_text not like '%dbms_stats cursor_sharing_exact%' and sql_Text not like '%no_sql_tune no_monitoring optimizer%' and upper(sql_text) not like '%DBMS_STATS.GATHER_DATABASE_STATS%')
loop
if idxtxt.SQLTXT not like '%dynamic_sampling(0)%' and idxtxt.SQLTXT not like '%<td class%' then
DBMS_OUTPUT.PUT_LINE('<TR BGCOLOR="#99ff00">');
dbms_output.put_line('<TD align=left>'||idxfull.SQ||'</TD>');
dbms_output.put_line('<TD align=left>'||idxtxt.SQLTXT||'</TD>');
dbms_output.put_line('<TD align=left>'||idxfull.OWN||'</TD>');
DBMS_OUTPUT.PUT_LINE('</TR>');
end if;
end loop;
end loop;
dbms_output.put_line('</TABLE>');
    dbms_output.put_line('</BODY>');
    dbms_output.put_line('</HTML>');
  end;
/
exit
/
