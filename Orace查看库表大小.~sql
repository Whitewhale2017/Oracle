---查看单表大小---------
select round(BYTES/1024/1024,2)||'M' as M_size,round(BYTES/1024/1024/1024,2)||'G' as G_size 
from user_segments where segment_name='PBOMLIB'; --segment_name参数为表名

----统计某个用户下表所占用大小
----方式一：
SELECT
  owner,
  segment_name,
  round( sum( bytes / 1024 / 1024 / 1024 ), 2 ) gb_size 
FROM
  dba_segments 
WHERE
  owner = 'SSPLM'  ----SSPLM为用户名
  AND segment_type = 'TABLE' -- 如果是分区表, 则 segment_type = 'TABLE PARTITION'
GROUP BY
  owner,
  segment_name 
ORDER BY
  3 DESC;
----方式二：
  SELECT
  table_name,
  nvl ( bytes, 0 ),
	nvl ( bytes / 1024, 0 ) KB,
	nvl ( bytes / 1024 / 1024, 0 ) MB,
  nvl ( bytes / 1024 / 1024/1024, 0 ) GB 
FROM
	dba_tables
	LEFT JOIN dba_segments ON table_name = segment_name 
	AND segment_type = 'TABLE' -- 如果是分区表, 则 segment_type = 'TABLE PARTITION'
	AND dba_segments.OWNER = 'SSPLM' 
WHERE
	dba_tables.OWNER = 'SSPLM' 
ORDER BY
	nvl ( bytes, 0 ) DESC;

