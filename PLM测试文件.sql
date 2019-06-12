select * from pbompkg where no ='21001000052019061103';

---21001000052019060501
---21001000082019060501
---
select id from pbompkg where objtype='SIPM4' and regexp_like(objno,'^[DJP][YR]') and id = '01_8A8E775EE271AB6CE050A8C062042CF4';
-----------------------------------------------------------------------

declare v_id NVARCHAR2(99);
begin
  select id into v_id from pbompkg where no ='21001000052019061103';
  proc_expand_main(v_id,'wyy');
end;
  
 -----------------------------------------------------------------------
  delete from sipm170 where pbompkgid = '01_8AF2659590327685E050A8C06204355B'; 
 
  select pbompkgid,no,werks,sobsl,beskz,sbdkz,berid,dispr 
  from sipm170 where pbompkgid='01_8A8C70C565E75D20E050A8C062047AA7' ;
  truncate table sipm170;
  
  select pbompkgid,no,werks,sobsl,beskz,sbdkz,berid,dispr 
  from sipm170 where no ='V100100009'
  
  
  select * from bom7;
  truncate table bom7;
  
  select * from SIPM171;
  truncate table SIPM171;
  
  select * from SIPM171;
  truncate table SIPM171;
  commit;
  
 select pbompkgid,pno,cno,werks from pbomlib 
 where pbompkgid=(select id from pbompkg where no ='21001000052019061103') and (cno like 'V%' or pno like 'V%');
  
  select no,pbompkgid,publishid,ordernum,werks,sobsl,beskz,sbdkz,berid,dispr,nfwerks  from sipm190 t 
where publishid =(select id from pbompkg where no ='21001000052019061103') and no ='V100100009';

select no from (
select no,pbompkgid,publishid,ordernum,werks,sobsl,beskz,sbdkz,berid,dispr,nfwerks  from sipm170 t 
where pbompkgid =(select id from pbompkg where no ='21001000052019061103')
) t
group by NO having count(1)>1
;
  

              
              
              
              
         

              
              
