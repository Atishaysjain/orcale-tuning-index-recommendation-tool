Begin 
 For i in 1..100 
 Loop 
 Insert into testbitmap values(dbms_random.string('U',10),'N' ); 
 If mod(i, 100) = 0 then 
 Commit; 
 End if; 
 End loop; 
 End; 
/
exit
/
