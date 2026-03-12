<%'@ LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<%
pasa = false

if request.Cookies("dev")<>"" then pasa=true
if request.Cookies("licencia")("client_id")="1" then pasa=true
if request.Cookies("licencia")("client_id")="2" then pasa=true

if not(pasa) then response.Redirect("/")
%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="robots" content="noindex, nofollow">
    <title>PropertyWeb - Admin</title>
    
    <link href="/_inc/foldy/base.css" rel="stylesheet" type="text/css">
    <link href="/_inc/foldy/estilos.css" rel="stylesheet" type="text/css">
    <!--#include virtual="/inc/dev.asp" -->
	<!--#include virtual="/inc/js.asp" -->
</head>
<body>
<!--#include virtual="/inc/body-header.asp" -->

<section id="content">
<div class="contenedor">

<section id="introp" class="cf">

	<div class="grid-6">
    	<h1 class="heading">Inmuebles</h1>
	</div>
    <div class="grid-3 grid-flow-opposite">
		<div class="caja">xxx</div>
    </div>
    
	<div class="grid-3">
        <div class="caja">
<%
set rsTmp = Server.CreateObject("ADODB.Recordset")
%>

<table border="1" cellspacing="0" cellpadding="2" width="100%">
    <tr>
      <td rowspan="2"></td>
      <td width="70" rowspan="2" align="center">Total</td>
      <td width="70" rowspan="2" align="center">OK</td>
      <td width="20" rowspan="2"></td>
      <td colspan="3" class="med" align="center">pendientes</td>
      </tr>
    <tr>
        <td width="50" class="med" align="center">confirm.</td>
        <td width="60" class="med" align="center">coords.</td>
        <td width="60" class="med" align="center">dir.</td>
    </tr>
    
    <tr>
        <td>Centros Comerciales</td>
        <%
		sql = "SELECT COUNT(*) AS nn FROM inmuebles WHERE id_pais=1 AND id_tipo_inmueble=1"
		rsTmp.open sql, session("connPW")
		val = rsTmp("nn")
		rsTmp.close
		%>
        <td align="right"><%= val %></td>
        <%
		sql = "SELECT COUNT(*) AS nn FROM inmuebles WHERE id_pais=1 AND id_tipo_inmueble=1 AND lat IS NOT NULL"	'tiene_coords=1
		rsTmp.open sql, session("connPW")
		val = rsTmp("nn")
		rsTmp.close
		%>
        <td align="right"><%= val %></td>
        <td></td>
        <%
		sql = "SELECT COUNT(*) AS nn FROM inmuebles WHERE id_pais=1 AND id_tipo_inmueble=1 AND lat IS NOT NULL AND tiene_coords=0"
		rsTmp.open sql, session("connPW")
		val = rsTmp("nn")
		rsTmp.close
		%>
        <td align="right" class="med"><%= val %></td>
        <%
		sql = "SELECT COUNT(*) AS nn FROM inmuebles WHERE id_pais=1 AND id_tipo_inmueble=1 AND tiene_dir=1 AND lat IS NULL"
		rsTmp.open sql, session("connPW")
		val = rsTmp("nn")
		rsTmp.close
		%>
        <td align="right" class="med"><%= val %></td>
        <%
		sql = "SELECT COUNT(*) AS nn FROM inmuebles WHERE id_pais=1 AND id_tipo_inmueble=1 AND tiene_dir=0"
		rsTmp.open sql, session("connPW")
		val = rsTmp("nn")
		rsTmp.close
		%>
        <td align="right" class="med"><%= val %></td>
    </tr>

    <tr>
        <td>Hoteles</td>
        <%
		sql = "SELECT COUNT(*) AS nn FROM inmuebles WHERE id_pais=1 AND id_tipo_inmueble=2"
		rsTmp.open sql, session("connPW")
		val = rsTmp("nn")
		rsTmp.close
		%>
        <td align="right"><%= val %></td>
        <%
		sql = "SELECT COUNT(*) AS nn FROM inmuebles WHERE id_pais=1 AND id_tipo_inmueble=2 AND lat IS NOT NULL"
		rsTmp.open sql, session("connPW")
		val = rsTmp("nn")
		rsTmp.close
		%>
        <td align="right"><%= val %></td>
        <td></td>
        <%
		sql = "SELECT COUNT(*) AS nn FROM inmuebles WHERE id_pais=1 AND id_tipo_inmueble=2 AND lat IS NOT NULL AND tiene_coords=0"
		rsTmp.open sql, session("connPW")
		val = rsTmp("nn")
		rsTmp.close
		%>
        <td align="right" class="med"><%= val %></td>
        <%
		sql = "SELECT COUNT(*) AS nn FROM inmuebles WHERE id_pais=1 AND id_tipo_inmueble=2 AND tiene_dir=1 AND lat IS NULL"
		rsTmp.open sql, session("connPW")
		val = rsTmp("nn")
		rsTmp.close
		%>
        <td align="right" class="med"><%= val %></td>
        <%
		sql = "SELECT COUNT(*) AS nn FROM inmuebles WHERE id_pais=1 AND id_tipo_inmueble=2 AND tiene_dir=0"
		rsTmp.open sql, session("connPW")
		val = rsTmp("nn")
		rsTmp.close
		%>
        <td align="right" class="med"><%= val %></td>
    </tr>
    
    <tr>
        <td>Edificios con Disponibilidad</td>
        <%
		sql = "SELECT COUNT(*) AS nn FROM inmuebles WHERE id_pais=1 AND id_tipo_inmueble=0 AND disponible_fecha IS NOT NULL"
		rsTmp.open sql, session("connPW")
		val = rsTmp("nn")
		rsTmp.close
		%>
        <td align="right"><%= val %></td>
        <%
		sql = "SELECT COUNT(*) AS nn FROM inmuebles WHERE id_pais=1 AND id_tipo_inmueble=0 AND disponible_fecha IS NOT NULL AND lat IS NOT NULL"
		rsTmp.open sql, session("connPW")
		val = rsTmp("nn")
		rsTmp.close
		%>
        <td align="right"><%= val %></td>
        <td></td>
        <%
		sql = "SELECT COUNT(*) AS nn FROM inmuebles WHERE id_pais=1 AND id_tipo_inmueble=0 AND disponible_fecha IS NOT NULL AND lat IS NOT NULL AND tiene_coords=0"
		rsTmp.open sql, session("connPW")
		val = rsTmp("nn")
		rsTmp.close
		%>
        <td align="right" class="med"><%= val %></td>
        <%
		sql = "SELECT COUNT(*) AS nn FROM inmuebles WHERE id_pais=1 AND id_tipo_inmueble=0 AND disponible_fecha IS NOT NULL AND tiene_dir=1 AND lat IS NULL"
		rsTmp.open sql, session("connPW")
		val = rsTmp("nn")
		rsTmp.close
		%>
        <td align="right" class="med"><%= val %></td>
        <%
		sql = "SELECT COUNT(*) AS nn FROM inmuebles WHERE id_pais=1 AND id_tipo_inmueble=0 AND disponible_fecha IS NOT NULL AND tiene_dir=0"
		rsTmp.open sql, session("connPW")
		val = rsTmp("nn")
		rsTmp.close
		%>
        <td align="right" class="med"><%= val %></td>
    </tr>
</table>


        </div>
        
	</div>
    
    <div class="clear" style="height:10px;"></div>

</section>

</div>
</section>

<!--#include virtual="/inc/body-footer.asp" -->

</body>
</html>
