create or replace function f_bmqc(v_id in number(38,0))
return varchar2 is
v_res varchar2(300);
v_supdepid number(38,0);
begin 
v_res:=(select departmentname from HrmDepartment where id=v_id);
v_supdepid:=(select supdepid from HrmDepartment where id=v_id);
while  v_supdepid!=0
begin
v_res:=(select departmentname from HrmDepartment where id=v_supdepid)+'>'+v_res;
v_supdepid:=(select supdepid from HrmDepartment where id=v_supdepid);
end; 
return (v_res);
end; 

create function f_gsqc(v_id int) --查询公司全称
returns varchar(300)
as 
begin 
declare v_res varchar(300)
declare v_supsubcomid int
set v_res=(select subcompanyname from HrmSubCompany where id=v_id)
set v_supsubcomid=(select supsubcomid from HrmSubCompany where id=v_id)
while  v_supsubcomid!=0
begin
set v_res=(select subcompanyname from HrmSubCompany where id=v_supsubcomid)+'>'+v_res
set v_supsubcomid=(select supsubcomid from HrmSubCompany where id=v_supsubcomid)
end 
return v_res
end 

select dbo.f_gsqc(id),id,subcompanyname from HrmSubCompany

