create or replace procedure prc_syqsj(v_rid int, v_rqid int)
as
  v_sjlj float;
  v_status int;
  begin
    select STATUS into v_status from hrmresource where id = v_rid;
    if ( v_status = 0 ) then
      select sum(LEAVEDAYS) into v_sjlj from Bill_BoHaiLeave where NEWLEAVETYPE = 29 and RESOURCEID = v_rid;
      if v_sjlj > 5.0
      then
        update Bill_BoHaiLeave set field_1641842880 = 0 where REQUESTID = v_rqid;
      else
        update Bill_BoHaiLeave set field_1641842880 = 1 where REQUESTID = v_rqid;
      end if;
    else
      update Bill_BoHaiLeave set field_1641842880 = 1 where REQUESTID = v_rqid;
    end if;
  end;
-------------------------------------
  call prc_syqsj(1,10254);
---------------------------------------
select RESOURCEID,NEWLEAVETYPE,LEAVEDAYS from Bill_BoHaiLeave where NEWLEAVETYPE = 29 and RESOURCEID = 1;

select sum(LEAVEDAYS) from Bill_BoHaiLeave where NEWLEAVETYPE = 29 and RESOURCEID = 1;

select * from Bill_BoHaiLeave order by FROMDATE asc;

select status from hrmresource where lastname = '王阳阳'