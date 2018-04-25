create or replace function f_gsqc(v_id integer) return varchar2 is
  FunctionResult varchar2(200);
  v_supsubcomid integer;
  Tempres varchar2(200);
begin
  select subcompanyname into FunctionResult from hrmsubcompany where id = v_id;
  select supsubcomid into v_supsubcomid from hrmsubcompany where id = v_id;
  while v_supsubcomid<>0
    loop
      select subcompanyname into Tempres from hrmsubcompany where id = v_supsubcomid;
      select supsubcomid into v_supsubcomid from hrmsubcompany where id = v_supsubcomid;
      FunctionResult :=Tempres||'>'||FunctionResult;  
      end loop;
  return(FunctionResult);
end f_gsqc;
/
