CREATE OR REPLACE FUNCTION FUNC_GETLASTN(string_source nvarchar2, v_length int)
  RETURN nvarchar2
AS
  v_lengthFact int;
BEGIN
/*����:��ȡ�ַ������v_lengthλ
����:SK
����:2017-05-11
���Խű�:select FUNC_GETLASTN('12345',6), func_getlaststr('123456',6), func_getlaststr('1234567',6) from dual;
*/
    if length(string_source) < v_length then
      v_lengthFact:=-1*length(string_source);
    else
      v_lengthFact:=-1*v_length;
    end if;

    return substr(string_source, v_lengthFact); -- ��ȡ���Nλ
END;
