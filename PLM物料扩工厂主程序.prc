create or replace procedure proc_expand_main(v_pbompkgid varchar2,v_operator nvarchar2) ----扩展主程序
as
r_werks NVARCHAR2(4);
r_id NVARCHAR2(999);
begin
  select id into r_id from pbompkg where objtype='SIPM4' and regexp_like(objno,'^[DJP][YR]') and id = v_pbompkgid;
  
if r_id is not null then
      select F_JSPBOMWSERKS(v_pbompkgid) into r_werks from dual;
      if  r_werks = '1001' then
          delete from sipm170 where pbompkgid = v_pbompkgid;
          delete from bom7 where pbompkgid = v_pbompkgid;
          delete from SIPM171 where pbompkgid = v_pbompkgid;
         
          dbms_output.put_line('开始扩展物料 ：'||to_char(sysdate,'yyyy-mm-dd hh24:mi:ss'));
          proc_expand_1806(v_pbompkgid,v_operator);
          dbms_output.put_line('物料扩展结束 ：'||to_char(sysdate,'yyyy-mm-dd hh24:mi:ss'));
           
          dbms_output.put_line('开始扩展后继物料 ：'||to_char(sysdate,'yyyy-mm-dd hh24:mi:ss'));
          proc_expand_nf_1806(v_pbompkgid,v_operator);
          dbms_output.put_line('后继物料扩展结束 ：'||to_char(sysdate,'yyyy-mm-dd hh24:mi:ss'));
           
          dbms_output.put_line('开始扩展PBOM ：'||to_char(sysdate,'yyyy-mm-dd hh24:mi:ss'));
          proc_expand_pbom_1806(v_pbompkgid,v_operator);
          dbms_output.put_line('PBOM扩展结束 ：'||to_char(sysdate,'yyyy-mm-dd hh24:mi:ss'));
          
          dbms_output.put_line('开始扩展工艺路线 ：'||to_char(sysdate,'yyyy-mm-dd hh24:mi:ss'));
          proc_expand_processlib_1806(v_pbompkgid,v_operator);
          dbms_output.put_line('工艺路线扩展结束 ：'||to_char(sysdate,'yyyy-mm-dd hh24:mi:ss'));
          
          commit;
      elsif r_werks = '1002' then
         delete from sipm170 where pbompkgid = v_pbompkgid;
         delete from bom7 where pbompkgid = v_pbompkgid;
         delete from SIPM171 where pbompkgid = v_pbompkgid;
               return;
               --proc_expand_1906(v_pbompkgid);
       end if;
end if;
end;
/
