SELECT CEIL((TO_DATE('2016-07-19 10:10:10' , 'YYYY-MM-DD HH24-MI-SS') - TO_DATE('2016-07-19 10:07:50' , 'YYYY-MM-DD HH24-MI-SS')) * 24*60  )  as minutes FROM DUAL;

SELECT CEIL((TO_DATE('2016-07-19 15:10:10' , 'YYYY-MM-DD HH24-MI-SS') - TO_DATE('2016-07-19 10:07:50' , 'YYYY-MM-DD HH24-MI-SS')) * 24 )  AS hours FROM DUAL;

SELECT floor((TO_DATE('2016-07-20 15:10:10' , 'YYYY-MM-DD HH24-MI-SS') - TO_DATE('2016-07-19 10:07:50' , 'YYYY-MM-DD HH24-MI-SS')))  AS days FROM DUAL;

SELECT floor((TO_DATE('2016-07-20 15:10:10' , 'YYYY-MM-DD HH24-MI-SS') - TO_DATE('' , 'YYYY-MM-DD HH24-MI-SS')))  AS days FROM DUAL;

