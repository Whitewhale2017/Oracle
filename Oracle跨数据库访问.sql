-- 准备工作：
-- 本地安装Oracle客户端后，配置远程Oracle服务的tnsnames.ora记录：
-- 找到本地文件tnsnames.ora（文件位置为Oracle安装目录*\network\admin下），新增远程服务如：
-- OADB=
--   (DESCRIPTION =
--     (ADDRESS = (PROTOCOL = TCP)(HOST = 10.254.41.52)(PORT = 1521))
--     (CONNECT_DATA =
--       (SERVER = DEDICATED)
--       (SERVICE_NAME = oadb)
--     )

create database link ecology8 connect to ecology identified by "ecology"
  using 'OADB';

drop database link ecology8;

select * from hrmresource@ecology8;

select * from uf_kqsj@ecology8;

-------------------------------------------------------------------------------------------------

create database link ecology82 connect to ecology identified by "ecology"
  using '(DESCRIPTION =
(ADDRESS = (PROTOCOL = TCP)(HOST = 10.254.41.53)(PORT = 1521))
(CONNECT_DATA =
(SERVER = DEDICATED)
(SERVICE_NAME = oadb)
)
)'

select * from uf_kqsj;

create table uf_kqsj as select * from uf_kqsj@ecology82;