create or replace procedure sp_formatdate(
i_tblname varchar2)is
v_tblname varchar2;
v_strsql varchar2;
v_strslct varchar2;
begin
  v_tblname:=i_tblname;
  v_strslct:='select launchdate from '||v_tblnm;
  strsql:='update '||v_tblnm||' SET launchdate =replace('||v_strslct||','.','')';
 
  --update tb_dw_tempdata set launchdate=replace(launchdate,'.','');  --�޸�������ڣ�����.��ȥ��
  execute immediate strsql
  --commit;
end
end sp_formatdate;

---ģ��---
create?or?replace?function?get_user???
return?varchar2???
is???
Result?varchar2(50);?--�������??
begin???
select?username?into?Result?from?user_users;???
return(Result);?--����ֵ??
end?get_user;??