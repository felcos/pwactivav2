<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Property Web</title>
</head>
<body>
<%
if request.QueryString("id")="" then response.Redirect("/")
id = request.QueryString("id")
'id = 6518

set rs = Server.CreateObject("ADODB.Recordset")
rs.open "SELECT * FROM dirs_w_inmuebles WHERE id=" & id, session("connPW")


select case rs("id_tipo_inmueble")
case 0
	tipo = ""
case 1
	tipo = "cc"
case 2
	tipo = "hot"
end select
%>
<form id="frm" method="post" action="/info/inmueble/">
	
	<input type="hidden" name="presentacion" value="informe">
    
	<input type="hidden" name="frmInfo_tipo" value="edif">
	<input type="hidden" name="frmInfo_busq" value="<%= rs("nombre") %>">
    <input type="hidden" name="seltipo" value="inmueble">
    
    <input type="hidden" name="id_edificio" value="<%= rs("id") %>">
    <input type="hidden" name="edificio" value="<%= rs("nombre") %>">
    <input type="hidden" name="calle" value="<%= rs("nombre_calle") %>">
    <input type="hidden" name="numerocalle" value="<%= rs("numero_calle") %>">
    <input type="hidden" name="d" value="<%= rs("dir1") %>">
    <input type="hidden" name="l" value="<%= rs("localidad") %>">
    <!--  
	<input type="submit" value="Ver Inmueble">
    /-->
</form>
<%
rs.close
set rs=nothing
%>
<script>
document.getElementById("frm").submit();
</script>
</body>
</html>
