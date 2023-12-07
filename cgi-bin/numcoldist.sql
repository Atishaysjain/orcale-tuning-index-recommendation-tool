set feedback off
set verify off
set heading off
select num_distinct from dba_tab_col_Statistics where table_name='&&1' and column_name='&&2'
/
exit
/
