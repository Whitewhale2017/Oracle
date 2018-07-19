select * from 	uf_ygjqjcsj;
select id,lastname,workcode from hrmresource where subcompanyid1 in (922,923,901);
select * from 	Bill_BoHaiLeave;

select ygbh,b.ID as xm,nf,fdnj,sllj,dxbj
from uf_ygjqjcsj a
left join HRMRESOURCE b
on a.ygbh = b.workcode
left join ();

select resourceid,NEWLEAVETYPE,sum(LEAVEDAYS) from Bill_BoHaiLeave
where (fromdate >= '2018-03-01') and (todate <= '2018-12-31')
group by resourceid,NEWLEAVETYPE;

select a.REQUESTID,a.RESOURCEID,a.NEWLEAVETYPE,a.FROMDATE,b.CREATEDATE,b.CREATETIME from Bill_BoHaiLeave a
  left join WORKFLOW_REQUESTBASE b
 on a.REQUESTID = b.REQUESTID
where b.CREATEDATE >= '2018-07-10'
order by CREATETIME desc;

--  28 病假 -12带薪病假 -6法定年假 29事假 -13调休 33丧假 36婚假 34哺乳假 39工伤假 35产假及看护假 40司龄年假

select NEWLEAVETYPE from Bill_BoHaiLeave group by NEWLEAVETYPE;

select * from workflow_requestbase;
