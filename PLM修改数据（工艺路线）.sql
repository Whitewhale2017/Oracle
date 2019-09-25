select * from pbompkg where no ='V2000148622019092301';

select * from processlib where pbompkgid='01_932F413A444A9978E050A8C087044FBF' and partno='1100109879X003'


update processlib set partno='1100109879X003' where pbompkgid='01_932F413A444A9978E050A8C087044FBF' and partno='1100109879X004'

---21001000052019060501
---21001000082019060501
---
select id from pbompkg where objtype='SIPM4' and regexp_like(objno,'^[DJP][YR]') and id = '01_8A8E775EE271AB6CE050A8C062042CF4';
-----------------------------------------------------------------------

declare v_id NVARCHAR2(99);
begin
  select id into v_id from pbompkg where no ='V2000107082019062001';
  
end;
  

              
              
              
         

              
              
