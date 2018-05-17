create or replace function f_bmqc(v_id integer)
return varchar2 is
v_res varchar2(300);
v_supdepid integer;
v_temp varchar2(200);
begin 
  select departmentname into v_res from HrmDepartment where id=v_id;
  select supdepid into v_supdepid from HrmDepartment where id=v_id;
  while  v_supdepid<>0 loop
     select departmentname into v_temp from HrmDepartment where id=v_supdepid;
     v_res := v_temp||'>'||v_res;
     select supdepid into v_supdepid from HrmDepartment where id=v_supdepid;
  end loop ;
  return (v_res);
end ;

--select f_bmqc(id) from HRMDEPARTMENT where ROWNUM<=10;

create or replace function f_gsqc(v_id integer)
  return varchar2 is
  v_res varchar2(200);
  v_supcomid integer;
  v_temp varchar2(200);
  begin
    select SUBCOMPANYNAME into v_res from HRMSUBCOMPANY where id = v_id;
    select SUPSUBCOMID into v_supcomid from HRMSUBCOMPANY where id = v_id;
    while v_supcomid<>0 loop
      select SUBCOMPANYNAME into v_temp from HRMSUBCOMPANY where id = v_id;
      v_res := v_temp||'>'||v_res;
      select SUPSUBCOMID into v_supcomid from HRMSUBCOMPANY where id = v_supcomid;
    end loop;
    return v_res;
  end;

 select LASTNAME,SUBCOMPANYID1,DEPARTMENTID,f_gsqc(SUBCOMPANYID1)||'||'||f_bmqc(DEPARTMENTID)
  from HRMRESOURCE where rownum <=100;
