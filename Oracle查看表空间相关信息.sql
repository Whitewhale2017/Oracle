

---查询数据库中所有的表空间以及表空间所占空间的大小
select * from dba_tablespaces;

SELECT t.tablespace_name, round(SUM(bytes / (1024 * 1024)), 0) "ts_size(M)"
FROM dba_tablespaces t, dba_data_files d
WHERE t.tablespace_name = d.tablespace_name
GROUP BY t.tablespace_name;

---查看表空间物理文件的名称及大小   
select * from dba_data_files;

SELECT tablespace_name,
file_id,
file_name,
round(bytes / (1024 * 1024), 0) "total_space(M)"
FROM dba_data_files
ORDER BY tablespace_name;

select tablespace_name,  round(sum(bytes)/(1024*1024)) as "ts_size(M)" 
from dba_data_files group by tablespace_name;

--查询所有表空间以及每个表空间的大小，已用空间，剩余空间，使用率和空闲率，直接执行语句就可以了：
select a.tablespace_name, total, free, total-free as used, substr(free/total * 100, 1, 5) as "FREE%", substr((total - free)/total * 100, 1, 5) as "USED%" from 
(select tablespace_name, sum(bytes)/1024/1024 as total(M) from dba_data_files group by tablespace_name) a, 
(select tablespace_name, sum(bytes)/1024/1024 as free(M) from dba_free_space group by tablespace_name) b
where a.tablespace_name = b.tablespace_name
order by a.tablespace_name;

--询某个具体的表所占空间的大小，把“TABLE_NAME”换成具体要查询的表的名称就可以了：
select * from dba_segments;

select t.segment_name, t.segment_type, sum(t.bytes / 1024 / 1024) "占用空间(M)"
from dba_segments t
where t.segment_type='TABLE' 
--and owner='SSPLM'
--and t.segment_name='TABLE_NAME'
group by OWNER, t.segment_name, t.segment_type;


