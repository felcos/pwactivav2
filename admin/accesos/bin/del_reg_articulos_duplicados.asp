<% 
if 1=2 then
	for each elto in request.Form
		%><%= elto %>:<strong><%= request.Form(elto) %></strong> &nbsp; <%
	next 
end if
%>
<p><a href="/admin/articulos/duplicados.asp">volver</a></p>
<hr />
<%
sql="DELETE FROM reg_articulos WHERE id IN (" & request.Form("duplicados") & ")"
session("connPWAcesos").execute sql

response.Redirect("/admin/accesos/articulos/duplicados.asp")
%>
<%= sql %>
<hr />
<p><a href="/admin/articulos/duplicados.asp">volver</a></p>