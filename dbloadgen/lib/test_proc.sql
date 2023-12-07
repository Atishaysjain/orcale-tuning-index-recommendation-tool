create or replace procedure test_proc is
begin
for idx in (select distinct tran_id,merchant_name from transaction_no_comp where rownum<5)
loop
for idx1 in (select BUYER_FIRST_NAME from DBLOADGEN.TRANSACTION_NO_COMP where tran_id=idx.tran_id and merchant_name=idx.merchant_name)
loop
dbms_output.put_line(idx1.BUYER_FIRST_NAME);
end loop;
end loop;
end;
