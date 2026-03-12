<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- include virtual="/inc/reg_accesos.asp" -->
<%
nn=0
Set rs = Server.CreateObject("ADODB.Recordset")
sql = "SELECT * FROM directorio WHERE directorio=1 ORDER BY ACTIVIDAD, NOMBRE"

rs.open sql, session("connPW")	
%>
<div>
<% 
seccion=""
do while not rs.eof
	nn=nn+1
	if seccion<>rs("ACTIVIDAD") then
		seccion=rs("ACTIVIDAD")
		ver_seccion=seccion
		if ver_seccion="N/D" then ver_seccion="OTRAS ACTIVIDADES"
		%><div class="pagsum_apartados"><span class="txt_h1_naranja"><b><%= ver_seccion %></b></span></div><%
	end if
	link = "/inversores/empresa/?id=" & rs("id")
	%><li><a href="<%= link %>" class="negro"><%= rs("nombre") %></a></li><%
	rs.movenext
loop
rs.Close %>
</div>
<script>$("#div_instrucciones").html("<span style='color:#ffffff;padding:5px;position:relative;right:20px;border-bottom:1px solid #ededed;background-color:#F47C04;border-radius:3px;-moz-border-radius:3px;-webkit-border-radius:3px;font-family:ruda;'>* Encontradas <%= nn %> empresas</span>");</script>
<% 
Set rs = Nothing 
%>