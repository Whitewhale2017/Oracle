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
Result?varchar2(50);--定义变量??
begin???
select?username?into?Result?from?user_users;???
return(Result);--返回值??
end?get_user;

------------------------------------
CREATE OR REPLACE FUNCTION testFunc (num1 IN NUMBER, num2 IN NUMBER)
RETURN NUMBER
AS
   num3 number;
   num4 number;
   num5 number;
BEGIN
   num3 := num1 + num2;
   num4 := num1 * num2;
   num5 := num3 * num4; 
   RETURN num5;
END;  

begin
num number(38,0);
num := testfunc(1,2));
dbms_output.put_line(num);
end;

 