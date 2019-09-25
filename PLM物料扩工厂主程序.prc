create or replace procedure proc_expand_main(v_pbompkgid varchar2,v_operator nvarchar2) ----À©Õ¹Ö÷³ÌÐò
as
r_werks NVARCHAR2(4);
r_objtype NVARCHAR2(50);
r_objno NVARCHAR2(50);
begin
  select objtype,objno into r_objtype,r_objno from pbompkg where id = v_pbompkgid; 
if r_objtype='SIPM4' and regexp_like(r_objno,'^[JP][YR]') then
      select F_JSPBOMWSERKS(v_pbompkgid) into r_werks from dual;
      if  r_werks = '1001' then
          delete from sipm170 where pbompkgid = v_pbompkgid;
          delete from bom7 where pbompkgid = v_pbompkgid;
          delete from SIPM171 where pbompkgid = v_pbompkgid;
           proc_expand_1806_yh(v_pbompkgid,v_operator);
           proc_expand_nf_1806_yh(v_pbompkgid,v_operator);
           proc_expand_pbom_1806_yh(v_pbompkgid,v_operator);
           proc_expand_processlib_1806_yh(v_pbompkgid,v_operator);
          commit;
      elsif r_werks = '1002' then
         delete from sipm170 where pbompkgid = v_pbompkgid;
         delete from bom7 where pbompkgid = v_pbompkgid;
         delete from SIPM171 where pbompkgid = v_pbompkgid; 
         proc_expand_1906_yh(v_pbompkgid,v_operator);
         proc_expand_nf_1906_yh(v_pbompkgid,v_operator);
         proc_expand_pbom_1906_yh(v_pbompkgid,v_operator);
         proc_expand_processlib_1906_yh(v_pbompkgid,v_operator);
         commit;
       end if;
       elsif  r_objtype='PRODUCT' and regexp_like(r_objno,'^[V]') then
          delete from SIPM171 where pbompkgid = v_pbompkgid;
         proc_expand_processlib_1806_yh(v_pbompkgid,v_operator);
         proc_expand_processlib_1906_yh(v_pbompkgid,v_operator);
         commit;
end if;
end;
/
