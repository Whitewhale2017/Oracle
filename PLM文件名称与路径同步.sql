select ID,FNAME,Location,PFNAME,Plocation from sipm2 where id='59670';

update sipm2 set FNAME='DA1800475N¸½¼þ.pdf',
location='/oadata/filesystem/201808/K/2910c476-f401-4688-aef6-8b030b2df6c8'
where id='59670';

update sipm2 set PFNAME='',Plocation='' where id='59670';
commit;

create or replace trigger TRIG_SIPM2
  before insert or update of fname,location
  on SIPM2
  for each row
  begin
     :new.PFNAME := :new.FNAME;
     :new.Plocation := :new.location;
  end;
  
  
  select * from WK_SIPM91;

select ID,FNAME,Location,PFNAME,Plocation from sipm11;

select ID,FNAME,Location,PFNAME,Plocation from sipm10;

select ID,FNAME,Location,PFNAME,Plocation from sipm12;

select ID,FNAME,Location,PFNAME,Plocation from sipm16;