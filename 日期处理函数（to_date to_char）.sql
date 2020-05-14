/*oracle��to_date��ϸ�÷�ʾ��(oracle���ڸ�ʽת��)
1. ���ں��ַ�ת�������÷���to_date,to_char��*/

select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') as nowTime from dual;  --����ת��Ϊ�ַ���  
select to_char(sysdate,'yyyy')  as nowYear   from dual;   --��ȡʱ�����  
select to_char(sysdate,'mm')    as nowMonth  from dual;   --��ȡʱ�����  
select to_char(sysdate,'dd')    as nowDay    from dual;   --��ȡʱ�����  
select to_char(sysdate,'hh24')  as nowHour   from dual;   --��ȡʱ���ʱ  
select to_char(sysdate,'mi')    as nowMinute from dual;   --��ȡʱ��ķ�  
select to_char(sysdate,'ss')    as nowSecond from dual;   --��ȡʱ�����

/* 2. �ַ�����ʱ�以ת*/

select to_date('2004-05-07 13:23:44','yyyy-mm-dd hh24:mi:ss') from dual
select to_char( to_date(222,'J'),'Jsp') from dual;--��ʾTwo Hundred Twenty-Two    

/*3.��ĳ�������ڼ�*/

select to_char(to_date('2002-08-26','yyyy-mm-dd'),'day') from dual;     --����һ     
select to_char(to_date('2002-08-26','yyyy-mm-dd'),'day',
'NLS_DATE_LANGUAGE = American') from dual;   -- monday   
--������������     
ALTER SESSION SET NLS_DATE_LANGUAGE='AMERICAN';     
--Ҳ��������     
TO_DATE ('2002-08-26', 'YYYY-mm-dd', 'NLS_DATE_LANGUAGE = American')

/*4. �������ڼ������*/

select floor(sysdate - to_date('20020405','yyyymmdd')) from dual

/*5. ʱ��Ϊnull���÷�*/

select id, active_date from table1     
UNION     
select 1, TO_DATE(null) from dual;  --ע��Ҫ��TO_DATE(null) 

/*6.�·ݲ�*/

a_date between to_date('20011201','yyyymmdd') and to_date('20011231','yyyymmdd')     
--��ô12��31������12��֮���12��1�ŵ�12��֮ǰ�ǲ������������Χ֮�ڵġ�     
--���ԣ���ʱ����Ҫ��ȷ��ʱ�򣬾���to_char���Ǳ�Ҫ��

/*7. ���ڸ�ʽ��ͻ����
����ĸ�ʽҪ���㰲װ��ORACLE�ַ���������, ����: US7ASCII, date��ʽ�����;���: '01-Jan-01'*/

alter system set NLS_DATE_LANGUAGE = American     
alter session set NLS_DATE_LANGUAGE = American     
--������to_date��д     
select to_char(to_date('2002-08-26','yyyy-mm-dd'),
   'day','NLS_DATE_LANGUAGE = American') from dual;     
--ע������ֻ�Ǿ���NLS_DATE_LANGUAGE����Ȼ���кܶ࣬�ɲ鿴     
select * from nls_session_parameters     
select * from V$NLS_PARAMETERS    

/*8.��ѯ������������*/

select count(*)     
from ( select rownum-1 rnum     
   from all_objects     
   where rownum <= to_date('2002-02-28','yyyy-mm-dd') - to_date('2002-     
   02-01','yyyy-mm-dd')+1    
  )     
where to_char( to_date('2002-02-01','yyyy-mm-dd')+rnum-1, 'D' )     
    not in ( '1', '7' )     

--����2002-02-28��2002-02-01�������һ���ߵ�����     
--��ǰ��ֱ����DBMS_UTILITY.GET_TIME, �ú󽫽�����(�õ�����1/100��, �����Ǻ���)

/* 9. �����·�*/

select months_between(to_date('01-31-1999','MM-DD-YYYY'),
to_date('12-31-1998','MM-DD-YYYY')) "MONTHS" FROM DUAL;     
--���Ϊ��1     
select months_between(to_date('02-01-1999','MM-DD-YYYY'),
to_date('12-31-1998','MM-DD-YYYY')) "MONTHS" FROM DUAL;     
--���Ϊ��1.03225806451613
/*
10. Next_day���÷�*/

Next_day(date, day)     
Monday-Sunday, for format code DAY     
Mon-Sun, for format code DY     
1-7, for format code D    

/*11.���Сʱ��*/

--extract()�ҳ����ڻ���ֵ���ֶ�ֵ
SELECT EXTRACT(HOUR FROM TIMESTAMP '2001-02-16 2:38:40') from offer     
select sysdate ,to_char(sysdate,'hh') from dual;     

SYSDATE               TO_CHAR(SYSDATE,'HH')     
-------------------- ---------------------     
2003-10-13 19:35:21   07    

select sysdate ,to_char(sysdate,'hh24') from dual;     

SYSDATE               TO_CHAR(SYSDATE,'HH24')     
-------------------- -----------------------     
2003-10-13 19:35:21   19   

/*12.�����յĴ���*/

SELECT
  older_date,
  newer_date,
  years,
  months,
  ABS (
    TRUNC (
      newer_date - ADD_MONTHS (older_date, years * 12 + months)
    )
  ) days
FROM
  (
    SELECT
      TRUNC (
        MONTHS_BETWEEN (newer_date, older_date) / 12
      ) YEARS,
      MOD (
        TRUNC (
          MONTHS_BETWEEN (newer_date, older_date)
        ),
        12
      ) MONTHS,
      newer_date,
      older_date
    FROM
      (
        SELECT
          hiredate older_date,
          ADD_MONTHS (hiredate, ROWNUM) + ROWNUM newer_date
        FROM
          emp
      )
  )   
/*13.�����·����������İ취*/

select to_char(add_months(last_day(sysdate) +1, -2), 'yyyymmdd'),last_day(sysdate) from dual    

/*
14.�ҳ����������*/

select add_months(trunc(sysdate,'year'), 12) - trunc(sysdate,'year') from dual    
 --����Ĵ�����     
to_char( last_day( to_date('02'    | | :year,'mmyyyy') ), 'dd' )     
 --�����28�Ͳ������� 
 

/*15.yyyy��rrrr������*/

YYYY99  TO_C     
------- ----     
yyyy 99 0099    
rrrr 99 1999    
yyyy 01 0001    
rrrr 01 2001  
 
/*16.��ͬʱ���Ĵ���*/

select to_char( NEW_TIME( sysdate, 'GMT','EST'), 'dd/mm/yyyy hh:mi:ss') ,
sysdate   from dual;    
 
/*17. 5����һ�����*/
Select TO_DATE(FLOOR(TO_CHAR(sysdate,'SSSSS')/300) * 300,'SSSSS') ,
TO_CHAR(sysdate,'SSSSS')   from dual    
--2002-11-1 9:55:00 35786     
--SSSSS��ʾ5λ����    

/*18.һ��ĵڼ���*/

select TO_CHAR(SYSDATE,'DDD'),sysdate from dual   
--310  2002-11-6 10:03:51    

/*19.����Сʱ,��,��,����*/
SELECT
   Days,
   A,
   TRUNC (A * 24) Hours,
   TRUNC (A * 24 * 60 - 60 * TRUNC(A * 24)) Minutes,
   TRUNC (
     A * 24 * 60 * 60 - 60 * TRUNC (A * 24 * 60)
   ) Seconds,
   TRUNC (
     A * 24 * 60 * 60 * 100 - 100 * TRUNC (A * 24 * 60 * 60)
   ) mSeconds
 FROM
   (
     SELECT
       TRUNC (SYSDATE) Days,
       SYSDATE - TRUNC (SYSDATE) A
     FROM
       dual
   ) SELECT
     *
   FROM
     tabname
   ORDER BY
     DECODE (MODE, 'FIFO', 1 ,- 1) * TO_CHAR (rq, 'yyyymmddhh24miss')

--   floor((date2-date1) /365) ��Ϊ��     
--  floor((date2-date1, 365) /30) ��Ϊ��     
--  d(mod(date2-date1, 365), 30)��Ϊ��.
 

/*20.next_day����*/
--�����¸����ڵ�����,dayΪ1-7��������-������,1��ʾ������
next_day(sysdate,6)�Ǵӵ�ǰ��ʼ��һ�������塣����������Ǵ������տ�ʼ����     
-- 1  2  3  4  5  6  7     
--�� һ �� �� �� �� ��   
select (sysdate-to_date('2003-12-03 12:55:45','yyyy-mm-dd hh24:mi:ss'))*24*60*60 from dual
--���� ���ص����� Ȼ�� ת��Ϊss
 

/*21,round[���뵽��ӽ�������](day:���뵽��ӽ���������)*/

select sysdate S1,
round(sysdate) S2 ,
round(sysdate,'year') YEAR,
round(sysdate,'month') MONTH ,
round(sysdate,'day') DAY from dual
 

/*22,trunc[�ضϵ���ӽ�������,��λΪ��] ,���ص�����������*/

select sysdate S1,                    
  trunc(sysdate) S2,                 --���ص�ǰ����,��ʱ����
  trunc(sysdate,'year') YEAR,        --���ص�ǰ���1��1��,��ʱ����
  trunc(sysdate,'month') MONTH ,     --���ص�ǰ�µ�1��,��ʱ����
  trunc(sysdate,'day') DAY           --���ص�ǰ���ڵ�������,��ʱ����
from dual
 

/*23,���������б����������� */

select greatest('01-1��-04','04-1��-04','10-2��-04') from dual
 
/*
24.����ʱ���
ע:oracleʱ�����������Ϊ��λ,���Ի��������,��*/
 select floor(to_number(sysdate-to_date('2007-11-02 15:55:03',
 'yyyy-mm-dd hh24:mi:ss'))/365) as spanYears from dual        --ʱ���-��
 select ceil(moths_between(sysdate-to_date('2007-11-02 15:55:03',
 'yyyy-mm-dd hh24:mi:ss'))) as spanMonths from dual           --ʱ���-��
 select floor(to_number(sysdate-to_date('2007-11-02 15:55:03',
 'yyyy-mm-dd hh24:mi:ss'))) as spanDays from dual             --ʱ���-��
 select floor(to_number(sysdate-to_date('2007-11-02 15:55:03',
 'yyyy-mm-dd hh24:mi:ss'))*24) as spanHours from dual         --ʱ���-ʱ
 select floor(to_number(sysdate-to_date('2007-11-02 15:55:03',
 'yyyy-mm-dd hh24:mi:ss'))*24*60) as spanMinutes from dual    --ʱ���-��
 select floor(to_number(sysdate-to_date('2007-11-02 15:55:03',
 'yyyy-mm-dd hh24:mi:ss'))*24*60*60) as spanSeconds from dual --ʱ���-��
 

/*25.����ʱ��*/

--oracleʱ��Ӽ���������Ϊ��λ,��ı���Ϊn,���Ի��������,��
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss'),
   to_char(sysdate+n*365,'yyyy-mm-dd hh24:mi:ss') as newTime from dual        --�ı�ʱ��-��
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss'),
    add_months(sysdate,n) as newTime from dual                                 --�ı�ʱ��-��
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss'),
    to_char(sysdate+n,'yyyy-mm-dd hh24:mi:ss') as newTime from dual            --�ı�ʱ��-��
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss'),
    to_char(sysdate+n/24,'yyyy-mm-dd hh24:mi:ss') as newTime from dual         --�ı�ʱ��-ʱ
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss'),
    to_char(sysdate+n/24/60,'yyyy-mm-dd hh24:mi:ss') as newTime from dual      --�ı�ʱ��-��
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss'),
    to_char(sysdate+n/24/60/60,'yyyy-mm-dd hh24:mi:ss') as newTime from dual   --�ı�ʱ��-��
 

/*26.�����µĵ�һ��,���һ��*/

  SELECT Trunc(Trunc(SYSDATE, 'MONTH') - 1, 'MONTH') First_Day_Last_Month,
    Trunc(SYSDATE, 'MONTH') - 1 / 86400 Last_Day_Last_Month,
    Trunc(SYSDATE, 'MONTH') First_Day_Cur_Month,
    LAST_DAY(Trunc(SYSDATE, 'MONTH')) + 1 - 1 / 86400 Last_Day_Cur_Month
FROM dual;
