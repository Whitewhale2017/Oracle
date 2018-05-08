create or replace trigger tri_lz_bq
  before update of status on hrmresource
  for each row
DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION; --声明自治事务
begin
  if :new.status = 5 and :old.status <>5 then
    --:new.lastname := replace(:old.lastname, '(LZ)', ''); --有问题
    :new.lastname := :old.lastname || '(LZ)';
  elsif :new.status = 5 and :old.status = 5 then
    return;    
   else
    :new.lastname := replace(:old.lastname, '(LZ)', '');
  end if;
  commit; --提交自治事务
end tri_lz_bq;

drop trigger tri_lz_bq;


select id, lastname, status, seclevel from hrmresource where rownum <= 10;


--update hrmresource set lastname=replace(lastname,'(LZ)','') where id = 193;

update hrmresource set status=5 where id = 193;

update hrmresource set status=1 where id = 193;

create or replace trigger tri_log
  before update of status on hrmresource
  for each row
DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION; --声明自治事务
begin
  insert into Temp_log values(:old.lastname,:new.lastname);
  :new.lastname := replace(:old.lastname,'(LZ)','');
  insert into Temp_log values(:old.lastname,:new.lastname);
  commit; --提交自治事务
end tri_lz_bq;



create table Temp_log(old varchar2(200),new varchar2(200));
insert into Temp_log values('1','2');
select * from Temp_log;
truncate table Temp_log;
drop table Temp_log;
