select * from dba_directories;

select * from v$pdbs;

alter session set container=orclpdb;
alter session set container=CDB$ROOT  

SELECT tablespace_name,
file_id,
file_name,
round(bytes / (1024 * 1024), 0) "total_space(M)"
FROM dba_data_files
ORDER BY tablespace_name;

---/u01/app/oracle/oradata/orcl/SSPLM_ATSPACE2.dbf
create tablespace SSPLM_TSPACE
 datafile '/u01/app/oracle/oradata/orcl/SSPLM_ATSPACE.dbf'
 size 50m
 autoextend on
 next 50m 
 extent management local;
 
 create user SSPLM identified by SSPLM 
 default tablespace SSPLM_TSPACE 
 temporary tablespace TEMP; 
 
 grant connect,resource,dba to SSPLM;
 grant read,write on directory DATA_PUMP_DIR to SSPLM;
 
 SELECT privilege, directory_name, DIRECTORY_PATH FROM user_tab_privs t, all_directories d
 WHERE t.table_name(+) = d.directory_name ORDER BY 2, 1;
 
 ---select * from v$version where rownum=1;
 
impdp sys/Wyy123456@orclpdb directory=DATA_PUMP_DIR dumpfile=SSPLM20191205.DMP remap_tablespace=SSPLM_ATSPACE:SSPLM_TSPACE remap_schema=SSPLM:SSPLM EXCLUDE=USER TABLE_EXISTS_ACTION=replace  version='11.2.0.1.0' 
 --transform=segment_attributes:n
 
 select a.name,b.username, b.password,b.created   
 from v$pdbs a    
 left join cdb_users b 
 on a.con_id = b.con_id   
 where a.con_id in(3,4,5) and to_char(b.created,'yyyymmdd')!='20140911'    
 order by 1;

