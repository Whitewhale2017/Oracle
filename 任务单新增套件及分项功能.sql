select custompage,* from workflow_base where formid in ('-328','-329','-366','-307') order by id 

--������֤����
select * from formtable_main_193

--�������루���̲�-�ӱ���ά������Ŀ��
select * from formtable_main_328
select * from formtable_main_328_dt2
select * from formtable_main_328_dt3

--��������(��ƷͶ����)
select * from formtable_main_329
select * from formtable_main_329_dt1
select * from formtable_main_329_dt2
select * from formtable_main_329_dt3
select * from formtable_main_329_dt4

--�з�������
select * from 	formtable_main_366
select * from 	formtable_main_366_dt1
select * from 	formtable_main_366_dt2
select * from 	formtable_main_366_dt3

--��Ʒ�׼�
select * from 	uf_taojzhushjta

--��Ʒ����
select chanptaojs from uf_actibity_mapping group by chanptaojs having count(chanptaojs)>1
select * from uf_actibity_mapping where chanptaojs = '2000100004'