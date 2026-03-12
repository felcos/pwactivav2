<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<%
public busq
busq=ucase(trim(request("busq")))
if len(busq)>0 then busq=replace(busq, "%", "")

nn=0
busq=replace(busq, "'", "''")

Set rsEmpresas = Server.CreateObject("ADODB.Recordset")
sql = "SELECT * FROM directorio WHERE "
sql = sql & "(NOMBRE LIKE '%" & busq & "%' OR OTROS_NOMBRES LIKE '%" & busq & "%')"

if request("actividad")="" or request("actividad")="*" then
	sql = sql & " AND directorio=1"
else
	sql = sql & " AND ID_ACTIVIDAD=" & request("actividad")
end if

sql = sql & " ORDER BY ACTIVIDAD, NOMBRE"

test_inyeccion_sql sql
rsEmpresas.open sql, session("connPW")	
%>
<% if 1=2 then %>
<table width="100%" border="1" cellspacing="0" cellpadding="0">
  <tr>
    <td width="50%">form<br />
<% for each elto in request.Form %>
	<li><%= elto %>: <%= request.Form(elto) %></li>
<% next %>
    </td>
    <td>querystring<br />
<% for each elto in request.querystring %>
	<li><%= elto %>: <%= request.querystring(elto) %></li>
<% next %>
    </td>
  </tr>
  <tr>
    <td colspan="2"><%= sql %></td>
  </tr>
</table>
<% end if %>
	<% if not rsEmpresas.eof then %>
<div>
    <% 
if request("actividad")="" or request("actividad")="*" then
    seccion=""
    do while not rsEmpresas.eof
        nn=nn+1
        if seccion<>rsEmpresas("ACTIVIDAD") then
            seccion=rsEmpresas("ACTIVIDAD")
            ver_seccion=seccion
            if ver_seccion="N/D" then ver_seccion="OTRAS ACTIVIDADES"
            %><div class="pagsum_apartados"><span class="txt_h1_naranja"><b><%= ver_seccion %></b></span></div><%
        end if
		if session("pw_ws").LicenciaId=0 then
			%><li><%= rsEmpresas("nombre") %></li><%
		else
			link = "/inversores/empresa/?id=" & rsEmpresas("id") & "&y=2026&t=c&z=e"
			%><li><a href="<%= link %>" class="negro"><%= rsEmpresas("nombre") %></a></li><%
		end if
        rsEmpresas.movenext
    loop
else
	do while not rsEmpresas.eof
        nn=nn+1
        link = "/inversores/empresa/?id=" & rsEmpresas("id")
        %><li><a href="<%= link %>" class="negro"><%= rsEmpresas("nombre") %></a></li><%
        rsEmpresas.movenext
    loop
end if

rsEmpresas.Close
%>
</div><span style="">
	<% end if %>
<script>$("#div_instrucciones").html("<div style='color:#ffffff;margin-top:16px;margin-bottom:16px; padding:5px;border-bottom:1px solid #ededed;background-color:#F47C04;border-radius:3px;-moz-border-radius:3px;-webkit-border-radius:3px;font-family:ruda;'> * encontradas <%= nn %> empresas</div>");</script>
<% Set rsEmpresas = Nothing %>