CREATE OR REPLACE FUNCTION FUNC_GETLASTN(string_source nvarchar2, v_length int)
  RETURN nvarchar2
AS
  v_lengthFact int;
BEGIN
/*功能:获取字符串最后v_length位
作者:SK
日期:2017-05-11
测试脚本:select FUNC_GETLASTN('12345',6), func_getlaststr('123456',6), func_getlaststr('1234567',6) from dual;
*/
    if length(string_source) < v_length then
      v_lengthFact:=-1*length(string_source);
    else
      v_lengthFact:=-1*v_length;
    end if;

    return substr(string_source, v_lengthFact); -- 截取最后N位
END;
