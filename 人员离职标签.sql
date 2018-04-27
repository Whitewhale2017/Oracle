create or replace trigger tri_lz_bq  --导致死锁
  after update of status
  on hrmresource 
  for each row
  DECLARE
 PRAGMA AUTONOMOUS_TRANSACTION; --申明自治事务
begin  
      if :new.status=5 then
         update hrmresource set lastname= replace(:old.lastname,'(LZ)','') where id= :new.id;
         update hrmresource set lastname=lastname||'(LZ)' where id = :new.id;
      else
         update hrmresource set lastname= replace(:old.lastname,'(LZ)','') where id= :new.id;
       end if;
       commit;  --提交自治事务
end tri_lz_bq;

create or replace trigger tri_lz_bq
  after update of status
  on hrmresource 
begin  
      if :new.status=5 then
         update hrmresource set lastname= replace(:old.lastname,'(LZ)','') where id= :new.id;
         update hrmresource set lastname=lastname||'(LZ)' where id = :new.id;
      else
         update hrmresource set lastname= replace(:old.lastname,'(LZ)','') where id= :new.id;
       end if;

end tri_lz_bq;




select id,lastname,status,seclevel from hrmresource where rownum <=10;

update hrmresource set status=5 where id=193;
