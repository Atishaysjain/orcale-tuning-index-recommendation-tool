create or replace procedure test_proc1_run as
a number;
b number;
begin
for i in 1..10
loop
select count(*) into a from testbitmap where ready='Y';
select count(*) into b from testbitmap where ready='N';
end loop;
end;
