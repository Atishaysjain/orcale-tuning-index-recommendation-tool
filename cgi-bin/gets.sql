set heading off
set feedback off
set verify off
set lines 200 pages 200
set serveroutput on
begin
dbms_output.put_line('<TABLE BORDER="1 ">');
dbms_output.put_line('<TR><TH>PLAN_HASH_VALUE</TH><TH>BUFFERGETS/EXEC</TH><TH>EXECS</TH><TH>CHILDNO</TH><TH>TIME(SEC)</TH><TH>SQLPROFILE</TH></TR>');
for idx in (select plan_hash_value,buffer_gets/executions "IO",executions "EX",child_number "CNO",(elapsed_time/executions)/1000000 "TIM",sql_profile "PROF" from gv$sql where sql_id='&&1')
loop
dbms_output.put_line('<TR>');
dbms_output.put_line('<TD align=left>'||idx.plan_hash_value||'</TD>');
dbms_output.put_line('<TD align=left>'||idx.IO||'</TD>');
dbms_output.put_line('<TD align=left>'||idx.EX||'</TD>');
dbms_output.put_line('<TD align=left>'||idx.CNO||'</TD>');
dbms_output.put_line('<TD align=left>'||idx.TIM||'</TD>');
dbms_output.put_line('<TD align=left>'||idx.PROF||'</TD>');
dbms_output.put_line('</TR>');
end loop;
dbms_output.put_line('</TABLE>');
  for idx4 in (select plan_table_output   From table(dbms_xplan.display_awr('&&1')))
loop
dbms_output.put_line('<pre>');
dbms_output.put_line(idx4.plan_table_output);
dbms_output.put_line('</pre>');
end loop;
end;
/
exit
/
