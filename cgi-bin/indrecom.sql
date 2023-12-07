set heading off
set feedback off
set verify off
set lines 200 pages 200
set serveroutput on
begin
for idx3 in (select distinct child_number,count(*) AS "CNT1" from v$sql_plan where sql_id='&&1' and timestamp=(select max(timestamp) from v$sql_plan where sql_id='&&1') and rownum<2 group by child_number union all select 0,0 from dual where not exists(select distinct child_number,count(*) AS "CNT1" from v$sql_plan where sql_id='&&1' and timestamp=(select max(timestamp) from v$sql_plan where sql_id='&&1') and rownum<2 group by child_number))
loop
if idx3.CNT1!=0   then
  for idx4 in (select plan_table_output   From table(dbms_xplan.display_Cursor('&&1',idx3.child_number)))
loop
dbms_output.put_line('<pre>');
dbms_output.put_line(idx4.plan_table_output);
dbms_output.put_line('</pre>');
end loop;
else
dbms_output.put_line('<pre>');
dbms_output.put_line('No Plan available');
dbms_output.put_line('</pre>');
end if;
end loop;
end;
/
exit
/
