-- ��PBOM�����,��ȡPBOM��ID
select * from pbompkg where no = 'V2000132452019071601'; -- 01_8DC8172B5665E773E050A8C087045C1D

-- ��PBOM��ID,Ŀ�Ӽ���������������ϵķֲ����
select * from wk_partlib where pbompkgid = '01_8DC8172B5665E773E050A8C087045C1D'-- and no = '1100108514X004';
select * from partlib where pbompkgid = '01_8DC8172B5665E773E050A8C087045C1D' and no = '1100108514X004';
select * from pbomlib where pbompkgid = '01_8DC8172B5665E773E050A8C087045C1D' and pno = '1100108514X004';
select * from pbomlib where pbompkgid = '01_8DC8172B5665E773E050A8C087045C1D' and cno = '1100108514X004';

select * from processlib where pbompkgid = '01_8DC8172B5665E773E050A8C087045C1D' and partno = '1100109211X002';

-- �����滻�������
update wk_partlib set no = '1100108514X003' where pbompkgid = '01_8CE609056588C541E050A8C087042CD3' and no = '1100108514X004';
update partlib set no = '1100108514X003' where pbompkgid = '01_8CE609056588C541E050A8C087042CD3' and no = '1100108514X004';
update pbomlib set pno = '1100108514X003' where pbompkgid = '01_8CE609056588C541E050A8C087042CD3' and pno = '1100108514X004';
update pbomlib set cno = '1100108514X003' where pbompkgid = '01_8CE609056588C541E050A8C087042CD3' and cno = '1100108514X004';

update processlib set partno = '1100109211X001' where pbompkgid = '01_8DC8172B5665E773E050A8C087045C1D' and partno = '1100109211X002';

commit;
