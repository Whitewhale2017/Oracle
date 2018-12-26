--���¼���Ϊ��ر�
SELECT * FROM v$lock;
SELECT * FROM v$sqlarea;
SELECT * FROM v$session;
SELECT * FROM v$process ;
SELECT * FROM v$locked_object;
SELECT * FROM all_objects;
SELECT * FROM v$session_wait;

--����һ�������䣺
LOCK TABLE tablename IN EXCLUSIVE MODE;--������������

--�鿴�����ı� 
select b.owner,b.object_name,a.session_id,a.locked_mode from v$locked_object a,dba_objects b where b.object_id = a.object_id;

--�鿴�ĸ��û��Ǹ������ճ�����
select b.username,b.sid,b.serial#,logon_time from v$locked_object a,v$session b where a.session_id = b.sid order by b.logon_time;

--�鿴���ӵĽ��� 
SELECT sid, serial#, username, osuser FROM v$session;

--�鿴���ĸ�session����������Դ�Ϊ׼��
 select b.username,b.sid,b.serial#,logon_time from  v$locked_object a,v$session b 
 where a.session_id = b.sid order by b.logon_time;
 
 --����������sid, serial#,os_user_name, machine_name, terminal������type,mode
SELECT s.sid, s.serial#, s.username, s.schemaname, s.osuser, s.process, s.machine,
s.terminal, s.logon_time, l.type
FROM v$session s, v$lock l
WHERE s.sid = l.sid
AND s.username IS NOT NULL
ORDER BY sid;

--ɱ������ sid,serial#
alter system kill session'961,24351';