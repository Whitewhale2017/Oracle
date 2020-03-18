CREATE OR REPLACE Function Func_CDate(Datechar In Varchar2) Return Date Is
    ReallyDo Date;
Begin
    Select to_date(to_char(to_date(to_char(Datechar), 'YYYY-MM-DD HH24:MI:SS'),
                           'YYYY-MM-DD'),
                   'YYYY-MM-DD')
    Into ReallyDo
    From Dual;
    Return(ReallyDo);
End Func_CDate;
----------------------------
CREATE OR REPLACE Function Func_CDateTime(Datechar In Varchar2) Return Date Is

    ReallyDo Date;
Begin
    Select to_date(to_char(to_date(to_char(Datechar), 'YYYY-MM-DD HH24:MI:SS'),
                           'YYYY-MM-DD HH24:MI:SS'),
                   'YYYY-MM-DD HH24:MI:SS')
    Into ReallyDo
    From Dual;
    Return(ReallyDo);
End Func_CDateTime;
-----------------------------
CREATE OR REPLACE Function Func_Datediff
(
    Datepart  In Varchar2,
    StartDate In Varchar2,
    EndDate   In Varchar2
) Return Number Is
    ReallyDo Numeric;
Begin
    Select Case Upper(Datepart)
               When 'YYYY' Then
                Trunc(Extract(Year From Func_CDate(EndDate)) -
                      Extract(Year From Func_CDate(StartDate)))
               When 'M' Then
                Func_Datediff('YYYY', StartDate, EndDate) * 12 +
                (Extract(Month From Func_CDate(EndDate)) -
                 Extract(Month From Func_CDate(StartDate)))
               When 'D' Then
                Trunc(Func_CDate(EndDate) - Func_CDate(StartDate))
               When 'H' Then
                Func_Datediff('D', StartDate, EndDate) * 24 +
                (to_Number(to_char(Func_CDateTime(EndDate), 'HH24')) -
                 to_Number(to_char(Func_CDateTime(StartDate), 'HH24')))
               When 'MI' Then
                Func_Datediff('D', StartDate, EndDate) * 24 * 60 +
                (to_Number(to_char(Func_CDateTime(EndDate), 'HH24')) - to_Number(to_char(Func_CDateTime(StartDate), 'HH24')))*60 +
                (to_Number(to_char(Func_CDateTime(EndDate), 'MI')) - to_Number(to_char(Func_CDateTime(StartDate), 'MI')))
               When 'SS' Then
                Func_Datediff('D', StartDate, EndDate) * 24 * 60 * 60 +
                (to_Number(to_char(Func_CDateTime(EndDate), 'SS')) -
                 to_Number(to_char(Func_CDateTime(StartDate), 'SS')))
               Else
                -29252888
           End
    Into ReallyDo
    From Dual;
    Return(ReallyDo);
End Func_Datediff;

----test-------
begin
  dbms_output.put_line(Datediff('h','2018-04-01 00:00:00','2018-04-02 00:00:00')); --–° ±
   dbms_output.put_line(Datediff('n','2018-04-01 00:00:00','2018-04-02 00:00:00')); --∑÷÷”
   dbms_output.put_line(Datediff('s','2018-04-01 00:00:00','2018-04-02 00:00:00')); --√Î
  end;
