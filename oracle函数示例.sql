create or replace procedure sp_formatdate(
i_tblname varchar2)is
v_tblname varchar2;
v_strsql varchar2;
v_strslct varchar2;
begin
  v_tblname:=i_tblname;
  v_strslct:='select launchdate from '||v_tblnm;
  strsql:='update '||v_tblnm||' SET launchdate =replace('||v_strslct||','.','')';
 
  --update tb_dw_tempdata set launchdate=replace(launchdate,'.','');  --修改起飞日期，将‘.’去掉
  execute immediate strsql
  --commit;
end
end sp_formatdate;

---模板---
create?or?replace?function?get_user???
return?varchar2???
is???
Result?varchar2(50);?--定义变量??
begin???
select?username?into?Result?from?user_users;???
return(Result);?--返回值??
end?get_user;??