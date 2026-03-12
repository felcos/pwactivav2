<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% 
'on error resume next
if request.QueryString("id")<>"" then 
	id = request.QueryString("id")
	
	set rs = Server.CreateObject("ADODB.Recordset")
	rs.open "SELECT * FROM dirs_w_inmuebles WHERE id=" & id, session("connPW")
	
	if rs.eof then response.Redirect("/")
	
	select case rs("id_tipo_inmueble")
	case 0
		tipo = ""
	case 1
		tipo = "cc"
	case 2
		tipo = "hot"
	end select
	%>
	<form id="frm" method="post" action="/info/edificio/">
		<input type="text" name="frmInfo_tipo" value="<%= request.QueryString("frmInfo_tipo") %>">
		<% if request.QueryString("frmInfo_tipo")="prop" then 
			%><input type="text" name="frmInfo_propietario" value="<%= request.QueryString("frmInfo_propietario") %>"><%
		else
			%><input type="text" name="frmInfo_busq" value="<%= request.QueryString("frmInfo_busq") %>"><%
		end if %>
        <input type="text" name="seltipo" value="<%= request.QueryString("seltipo") %>">
        <input type="text" name="id_edificio" value="<%= rs("id") %>">
        <!--
        <input type="hidden" name="edificio" value="< %= rs("nombre") %>">
        <input type="hidden" name="calle" value="< %= rs("nombre_calle") %>">
        <input type="hidden" name="numerocalle" value="< %= rs("numero_calle") %>">
        <input type="hidden" name="d" value="< %= rs("dir1") %>">
        <input type="hidden" name="l" value="< %= rs("localidad") %>">
        -->
        <input type="submit" value="submit">
    </form>
	<%
	rs.close
	set rs=nothing
	%><script>//document.getElementById("frm").submit();</script><% 
	response.End()
	
end if %>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<% 
'sec_actual = "/info/"

dim busqueda
dim vari(20)
dim minisql
%>
<!DOCTYPE html>
<html lang="es">
<head>
	<title>PropertyWeb - Info</title>
	<!--#include virtual="/inc/head.asp" -->
<style>
<% if request.Cookies("dev")<>"" then %>
.popover {
	max-width:none;
	width:400px;
	/*left:730px !important;*/
}
<% end if %>
</style>
<% 
frmInfo_busq = request.form("frmInfo_busq")
frmInfo_tipo = request.form("frmInfo_tipo")	
frmInfo_propietario = request.form("frmInfo_propietario")

dim contador_paso
dim ids_actual
%>
</head>
<body>
<!--#include virtual="/inc/body-header.asp" -->
<%
set rsBusq = Server.CreateObject("ADODB.Recordset")
%>
<div class="container">
	<section id="s_titulos" class="row">
		<div id="result" class="caja">
        	<!--#include virtual="/inc/sin_acceso.asp" -->
			<% if request.Cookies("dev")("request")<>"" then %>
                <div class="dev peq">
                    Form: &nbsp; <% 
                    for each elto in request.Form 
                        if request.Form(elto)<>"" then %>[<b><%= elto %></b> = <%= request.Form(elto) %>]&nbsp;<% end if 
                    next %>
                </div>
            <% end if %>
			<% select case frmInfo_tipo
			case "prop"
				%><!--#include virtual="/info/busq/prop.asp" --><%
			case "cc"
				%><!--#include virtual="/info/busq/cc.asp" --><%
			case "ni"
				%><!--#include virtual="/info/busq/ni.asp" --><%
			case "hot"
				%><!--#include virtual="/info/busq/hotel.asp" --><%
			case "edif"
				%><!--#include virtual="/info/busq/edif.asp" --><%
			case "empr"
				%><!--#include virtual="/info/busq/empr.asp" --><%
			end select %>
        </div>
	</section>
</div>
<%
set rsBusq=nothing 
%>
<!--#include virtual="/inc/body-footer.asp" -->
</body>
</html>
