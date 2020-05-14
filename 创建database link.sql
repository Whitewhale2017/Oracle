create database link dg4msql --dblink名称  
connect to sa --用户名  
identified by "Sansi123"  --密码，用引号括起来  
using 'dg4msql'; 

drop database link dg4msql;

select * from test@dg4msql;  

-- Create database link 
create database link db_1   
  connect to db_2_user 
  identified by "db_2_user_password"
  using 'DEMO =
  (DESCRIPTION =
    (ADDRESS_LIST =
      (ADDRESS = (PROTOCOL = TCP)(HOST = db_2_ip)(PORT = 1521))
    )
    (CONNECT_DATA =
      (SERVICE_NAME = db_2_server)
    )
  )'; 
 ---------------------
 create database link PLMPRD 
 connect to SSPLM 
 identified by "SSPLM"
 using 'PLMPRD';
 
 drop database link PLMPRD;
 
 select * from SIPM3@PLMPRD;----报错

