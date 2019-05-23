
--------------创建三个新增对象的数据结构，可参考各自对应的传SAP日志表---------------------
create table SIPM170 as select * from SIPM190 where 1=2; --研发物料

create table BOM7 as select * from BOM10 where 1=2; --研发BOM

create table SIPM171 as select * from SIPM191 where 1=2; --研发工艺路线


----------------
select id,pbompkgid,pno,werks,cno,bnum
from PBOMLIB 
--where pbompkgid = '01_6CC16A2F0C98EC28E050A8C08704144E'
order by pno,werks,cno


create or replace function F_JSPBOMWSERKS(v_pbompkgid in varchar2) ---计算PBOM根节点是否存在1001、1002工厂，如果存在则返回工厂号
return varchar2
as
 v_res varchar2(4);
begin
   select werks into v_res from (
        select 
        werks from PBOMLIB a
        where not exists (select 1 from PBOMLIB B where b.pbompkgid = v_pbompkgid and a.pbompkgid = b.pbompkgid and  a.pno = b.cno)
        and a.pbompkgid = v_pbompkgid
        group by pbompkgid,pno,werks
        ) t 
        where t.werks in ('1001','1002')
      ;
   return v_res;
 end;
 
 --select F_JSPBOMWSERKS('01_7C42AFC36A9CDA52E050A8C087044E73') from dual

select pbompkgid from pbompkg where objtype='SIPM4' and regexp_like(objno,'^[DJP]Y') and 

select * from sipm190_last --- SIPM170

select * from PBOMLIB --- BOM7 用PBOMPKGID检索

select * from PROCESSLIB --- SIPM171 用PBOMPKGID检索

