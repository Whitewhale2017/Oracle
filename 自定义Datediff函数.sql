Create Or Replace Function CDate(Datechar In Varchar2) Return Date Is
  ReallyDo Date;
Begin
  Select to_date(to_char(to_date(to_char(Datechar), 'YYYY-MM-DD HH24:MI:SS'),
                         'YYYY-MM-DD'),
                 'YYYY-MM-DD')
    Into ReallyDo
    From Dual;
  Return(ReallyDo);
End CDate;

Create Or Replace Function CDateTime(Datechar In Varchar2) Return Date Is
  ReallyDo Date;
Begin
  Select to_date(to_char(to_date(to_char(Datechar), 'YYYY-MM-DD HH24:MI:SS'),
                         'YYYY-MM-DD HH24:MI:SS'),
                 'YYYY-MM-DD HH24:MI:SS')
    Into ReallyDo
    From Dual;
  Return(ReallyDo);
End CDateTime;

Create Or Replace Function Datediff(Datepart  In Varchar2,
                                    StartDate In Varchar2,
                                    EndDate   In Varchar2) Return Number Is
  ReallyDo Numeric;
Begin
  Select Case Upper(Datepart)
           When 'YYYY' Then
            Trunc(Extract(Year From CDate(EndDate)) -
                  Extract(Year From CDate(StartDate)))
           When 'M' Then
            Datediff('YYYY', StartDate, EndDate) * 12 +
            (Extract(Month From CDate(EndDate)) -
             Extract(Month From CDate(StartDate)))
           When 'D' Then
            Trunc(CDate(EndDate) - CDate(StartDate))
           When 'H' Then
            Datediff('D', StartDate, EndDate) * 24 +
            (to_Number(to_char(CDateTime(EndDate), 'HH24')) -
             to_Number(to_char(CDateTime(StartDate), 'HH24')))
           When 'N' Then
            Datediff('D', StartDate, EndDate) * 24 * 60 +
            (to_Number(to_char(CDateTime(EndDate), 'MI')) -
             to_Number(to_char(CDateTime(StartDate), 'MI')))
           When 'S' Then
            Datediff('D', StartDate, EndDate) * 24 * 60 * 60 +
            (to_Number(to_char(CDateTime(EndDate), 'SS')) -
             to_Number(to_char(CDateTime(StartDate), 'SS')))
           Else
            -29252888
         End
    Into ReallyDo
    From Dual;
  Return(ReallyDo);
End Datediff;

----≤‚ ‘-------
begin
  dbms_output.put_line(Datediff('h','2018-04-01 00:00:00','2018-04-02 00:00:00')); --–° ±
   dbms_output.put_line(Datediff('n','2018-04-01 00:00:00','2018-04-02 00:00:00')); --∑÷÷”
   dbms_output.put_line(Datediff('s','2018-04-01 00:00:00','2018-04-02 00:00:00')); --√Î
  end;
