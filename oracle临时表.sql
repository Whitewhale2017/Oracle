һ�� �Ự��ʱ��

--�����Ự��ʱ��
create global temporary table tmp_user_session(user_id int, user_name varchar2(20),user_email varchar2(30)) 
--����ʾ �������ύʱ ��������
on commit preserve rows

--����ʱ���в�������
insert into tmp_user_session(user_id,user_name,user_email) values(1,'��ҵ��','948987600@qq.com')
insert into tmp_user_session(user_id,user_name,user_email) values(1,'����ɯ','934560@qq.com')
commit
--��ѯ ������
select * from tmp_user_session
--���´� һ��sql���� �ٴβ�ѯ ���������� select * from tmp_user_session ˵���˲�������� ֻΪ�����ڻỰ����



��������������ʱ��
--����������ʱ��
create global temporary table tmp_users_transaction (user_id int,user_name varchar2(20),user_email varchar2(30))
--����ʾ �������ύʱ ɾ������
 on commit delete rows
 
 --����ʱ���в�������
insert into tmp_users_transaction(user_id,user_name,user_email) values(1,'��ҵ��','948987600@qq.com');
insert into tmp_users_transaction(user_id,user_name,user_email) values(1,'����ɯ','934560@qq.com')

--��ѯ ������
select * from tmp_users_transaction
--�ύ����� ���߻ع����� rollback  �ٴβ�ѯ   select * from tmp_users_transaction  ��û�������� ��Ϊ������ʱ�� �����������ύʱ �����������
commit;rollback;

--�鿴��ʱ��ı�ռ䣬��ʵ���ǵı�ռ�Ϊ��
  select table_name, tablespace_name
    from user_tables
   where table_name = 'T_USERS'
      or table_name = 'TMP_USERS_SESSION'
      or table_name = 'TMP_USERS_TRANSACTION'
