--以下几个为相关表
SELECT * FROM v$lock;
SELECT * FROM v$sqlarea;
SELECT * FROM v$session;
SELECT * FROM v$process ;
SELECT * FROM v$locked_object;
SELECT * FROM all_objects;
SELECT * FROM v$session_wait;

--锁定一个表的语句：
LOCK TABLE tablename IN EXCLUSIVE MODE;--将锁定整个表

--查看被锁的表 
select b.owner,b.object_name,a.session_id,a.locked_mode from v$locked_object a,dba_objects b where b.object_id = a.object_id;

--查看哪个用户那个进程照成死锁
select b.username,b.sid,b.serial#,logon_time from v$locked_object a,v$session b where a.session_id = b.sid order by b.logon_time;

--查看连接的进程 
SELECT sid, serial#, username, osuser FROM v$session;

--查看是哪个session引起的锁表（以此为准）
 select b.username,b.sid,b.serial#,logon_time from  v$locked_object a,v$session b 
 where a.session_id = b.sid order by b.logon_time;
 
 --查出锁定表的sid, serial#,os_user_name, machine_name, terminal，锁的type,mode
SELECT s.sid, s.serial#, s.username, s.schemaname, s.osuser, s.process, s.machine,
s.terminal, s.logon_time, l.type
FROM v$session s, v$lock l
WHERE s.sid = l.sid
AND s.username IS NOT NULL
ORDER BY sid;

--杀掉进程 sid,serial#
alter system kill session'961,24351';