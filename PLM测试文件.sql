select * from pbompkg where no ='21001001732019060603';

---21001000052019060501
---21001000082019060501
---
select id from pbompkg where objtype='SIPM4' and regexp_like(objno,'^[DJP][YR]') and id = '01_8A8E775EE271AB6CE050A8C062042CF4';
-----------------------------------------------------------------------

declare v_id NVARCHAR2(99);
begin
  select id into v_id from pbompkg where no ='21001000052019060601';
  proc_expand_main(v_id,'wyy');
end;
  
 -----------------------------------------------------------------------
  
  select * from sipm170 where pbompkgid='01_8A8C70C565E75D20E050A8C062047AA7' ;
  truncate table sipm170;
  
  select * from bom7;
  truncate table bom7;
  
  select * from SIPM171;
  truncate table SIPM171;
  
  select * from SIPM171;
  truncate table SIPM171;
  commit;
  
  

              
              
              
              
         

              
              
