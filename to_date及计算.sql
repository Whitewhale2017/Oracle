begin
--dbms_output.put_line(ROUND(TO_NUMBER(to_date('2018-04-04 10:00:10','YYYY-MM-DD HH24:MI:SS') -to_date( '2018-04-04 10:00:00','YYYY-MM-DD HH24:MI:SS')) * 24 * 60 * 60 * 60));
--dbms_output.put_line(ROUND(TO_NUMBER(to_date('2018-04-04 10:00:30','YYYY-MM-DD HH24:MI:SS') -to_date( '2018-04-04 10:00:10','YYYY-MM-DD HH24:MI:SS'))));---计算单位是天
 dbms_output.put_line(round(to_number((to_date('2018-04-04 10:00:20','YYYY-MM-DD HH24:MI:SS') -to_date( '2018-04-04 10:00:10','YYYY-MM-DD HH24:MI:SS'))*24*60*60)));
end;
