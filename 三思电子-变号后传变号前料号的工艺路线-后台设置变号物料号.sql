-- 按PBOM包编号,获取PBOM包ID
select * from pbompkg where no = 'V2000132452019071601'; -- 01_8DC8172B5665E773E050A8C087045C1D

-- 按PBOM包ID,目视检查拟调整狴犴号物料的分布情况
select * from wk_partlib where pbompkgid = '01_8DC8172B5665E773E050A8C087045C1D'-- and no = '1100108514X004';
select * from partlib where pbompkgid = '01_8DC8172B5665E773E050A8C087045C1D' and no = '1100108514X004';
select * from pbomlib where pbompkgid = '01_8DC8172B5665E773E050A8C087045C1D' and pno = '1100108514X004';
select * from pbomlib where pbompkgid = '01_8DC8172B5665E773E050A8C087045C1D' and cno = '1100108514X004';

select * from processlib where pbompkgid = '01_8DC8172B5665E773E050A8C087045C1D' and partno = '1100109211X002';

-- 逐项替换变号物料
update wk_partlib set no = '1100108514X003' where pbompkgid = '01_8CE609056588C541E050A8C087042CD3' and no = '1100108514X004';
update partlib set no = '1100108514X003' where pbompkgid = '01_8CE609056588C541E050A8C087042CD3' and no = '1100108514X004';
update pbomlib set pno = '1100108514X003' where pbompkgid = '01_8CE609056588C541E050A8C087042CD3' and pno = '1100108514X004';
update pbomlib set cno = '1100108514X003' where pbompkgid = '01_8CE609056588C541E050A8C087042CD3' and cno = '1100108514X004';

update processlib set partno = '1100109211X001' where pbompkgid = '01_8DC8172B5665E773E050A8C087045C1D' and partno = '1100109211X002';

commit;
