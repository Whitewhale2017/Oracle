create or replace function f_bmqc(v_id integer) return varchar2 is
  FunctionResult varchar2(200);
  v_supdeptid integer;
  Tempres varchar2(200);
begin
  select departmentname into FunctionResult from hrmdepartment where id = v_id;
  select supdepid into v_supdeptid from hrmdepartment where id = v_id;
  while v_supdeptid<>0
    loop
      select departmentname into Tempres from hrmdepartment where id = v_supdeptid;
      select supdepid into v_supdeptid from hrmdepartment where id = v_supdeptid;
      FunctionResult :=Tempres||'>'||FunctionResult;  
      end loop;
  return(FunctionResult);
end f_bmqc;
/
