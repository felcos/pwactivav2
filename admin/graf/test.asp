<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Documento sin título</title>
	
</head>
<body>
<script language="javascript">
	var number = 123456.789;
	console.log(number.toLocaleString('es-ES'))
</script>

<%
if 1=2 then
	Set rs = Server.CreateObject("ADODB.Recordset")
	
	'sql = "SELECT * FROM regTodo( )"
	sql = "SELECT * FROM regFechas('2015-03-01', '2015-03-31')"
	rs.Open sql, session("connPWAcesos")
	
	do while not rs.eof
		%><li><%= rs("fecha") %></li><%
		rs.movenext
	loop
	
	rs.close
	set rs=nothing
end if
%>

</body>
</html>

