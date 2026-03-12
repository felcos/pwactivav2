<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Documento sin título</title>
</head>
<body>
<script type="text/javascript" src="/js/jquery.js"></script>

<script language="javascript" runat="server">	
	function jsUTC(yy, mm, dd) {
		var d = Date.UTC(yy, mm, dd);
		return d;
	};
</script>

<p>hola</p>
<%
fecha = date
%>
<p><%= fecha %></p>
<p><%= jsUTC(year(fecha), month(fecha), day(fecha)) %></p>
<hr />
<p id="informa">xxx</p>

</body>
</html>

<script type="text/javascript">
var data = [
	Date.UTC(<%= year(fecha) %>, <%= month(fecha) %>, <%= day(fecha) %>)
];

$("#informa").html(data.toString().split(","));

</script>