<script language="javascript" runat="server">	
	function jsUTC(yy, mm, dd) {
		var d = Date.UTC(yy, mm-1, dd);
		return d;
	};
</script>[<%
Set rs = Server.CreateObject("ADODB.Recordset")

nn = 0

'sql = "SELECT DATEADD(d, 1 - DATEPART(dw, fecha), fecha) AS wd, COUNT(id) AS articulos "
'sql = sql & "FROM reg_articulos "
'sql = sql & "GROUP BY DATEADD(d, 1 - DATEPART(dw, fecha), fecha) "
'sql = sql & "ORDER BY DATEADD(d, 1 - DATEPART(dw, fecha), fecha)"

sql = "SELECT fecha, COUNT(id) AS articulos FROM reg_articulos GROUP BY fecha ORDER BY fecha"

rs.Open sql, session("connPWAcesos")

do while not rs.eof 
	if nn>0 then %>, <% end if
	%>[<%= jsUTC(year(rs("fecha")), month(rs("fecha")), day(rs("fecha"))) %>, <%= rs("articulos") %>]<%
	nn=nn+1
	rs.movenext
loop

rs.close
set rs=nothing
%>]