一、 会话临时表

--创建会话临时表
create global temporary table tmp_user_session(user_id int, user_name varchar2(20),user_email varchar2(30)) 
--这句表示 当事务提交时 保留数据
on commit preserve rows

--向临时表中插入数据
insert into tmp_user_session(user_id,user_name,user_email) values(1,'孙业宝','948987600@qq.com')
insert into tmp_user_session(user_id,user_name,user_email) values(1,'王丽莎','934560@qq.com')
commit
--查询 有数据
select * from tmp_user_session
--重新打开 一个sql窗口 再次查询 则无数据了 select * from tmp_user_session 说明此插入的数据 只为本窗口会话存在



二、创建事务临时表
--创建事务临时表
create global temporary table tmp_users_transaction (user_id int,user_name varchar2(20),user_email varchar2(30))
--这句表示 当事务提交时 删除数据
 on commit delete rows
 
 --向临时表中插入数据
insert into tmp_users_transaction(user_id,user_name,user_email) values(1,'孙业宝','948987600@qq.com');
insert into tmp_users_transaction(user_id,user_name,user_email) values(1,'王丽莎','934560@qq.com')

--查询 有数据
select * from tmp_users_transaction
--提交下语句 或者回滚事务 rollback  再次查询   select * from tmp_users_transaction  就没有数据了 因为事务临时表 就是在事务提交时 就数据清空了
commit;rollback;

--查看临时表的表空间，其实他们的表空间为空
  select table_name, tablespace_name
    from user_tables
   where table_name = 'T_USERS'
      or table_name = 'TMP_USERS_SESSION'
      or table_name = 'TMP_USERS_TRANSACTION'
