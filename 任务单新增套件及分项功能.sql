select custompage,* from workflow_base where formid in ('-328','-329','-366','-307') order by id 

--任务单认证申请
select * from formtable_main_193

--任务单申请（工程部-延保、维修类项目）
select * from formtable_main_328
select * from formtable_main_328_dt2
select * from formtable_main_328_dt3

--任务单申请(样品投标类)
select * from formtable_main_329
select * from formtable_main_329_dt1
select * from formtable_main_329_dt2
select * from formtable_main_329_dt3
select * from formtable_main_329_dt4

--研发类任务单
select * from 	formtable_main_366
select * from 	formtable_main_366_dt1
select * from 	formtable_main_366_dt2
select * from 	formtable_main_366_dt3

--产品套件
select * from 	uf_taojzhushjta

--产品分项
select chanptaojs from uf_actibity_mapping group by chanptaojs having count(chanptaojs)>1
select * from uf_actibity_mapping where chanptaojs = '2000100004'