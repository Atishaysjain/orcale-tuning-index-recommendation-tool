set heading off
set feedback off
set verify off
select num_distinct,sample_size from dba_tab_col_Statistics where table_name='&&1' and column_name='&&2'
/
exit
/
