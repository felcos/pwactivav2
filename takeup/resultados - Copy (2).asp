<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/lib/aspjson/JSON_2.0.4.asp" -->
<!--#include virtual="/lib/aspjson/JSON_UTIL_0.1.1.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<!--#include virtual="/articulos/sin_acceso.asp" -->
<input type="hidden" name="submit" value="submit"/>
<% if request.Cookies("dev")="" then %>
    <input type="hidden" data-form="busq" name="zoom" value="<%= request.form("zoom") %>"/>
    <input type="hidden" data-form="busq" name="lat" value="<%= request.form("lat") %>"/>
    <input type="hidden" data-form="busq" name="lng" value="<%= request.form("lng") %>" />
    <input type="hidden" data-form="busq" name="tab" value="<%= request.form("tab") %>"/>
    <input type="hidden" name="origen" value="takeup"/>
    <input type="hidden" name="datos" value="<%= request.form("datos") %>"/>
<% else %>
    [zoom:<input type="text" data-form="busq" name="zoom" value="<%= request.form("zoom") %>" class="dev" />] 
    [latlng:<input type="text" data-form="busq" name="lat" value="<%= request.form("lat") %>" class="dev"/><input type="text" data-form="busq" name="lng" value="<%= request.form("lng") %>" class="dev" />] 
    [tab:<input type="text" data-form="busq" name="tab" value="<%= request.form("tab") %>" class="dev"/>] 
    [origen:<input type="text" name="origen" value="takeup"/>] 
    [datos:<input type="text" name="datos" value="<%= request.form("datos") %>" class="dev"/> ]
<% end if

for each elto in request.form
	select case elto
	case "origen", "datos", "tab", "submit"
	case "selected", "dis", "ope"
	case "ordenando"
	case "lat", "lng", "zoom"
	case "min", "max", "filtro_min", "filtro_max"
	case else
		if request.Cookies("dev")="" then
			%><input type="hidden" name="<%= elto %>" value="<%= request.form(elto) %>"/><%
		else
			%>[<%= elto %>:<input type="text" name="<%= elto %>" value="<%= request.form(elto) %>"/>]<%
		end if
	end select
next 

'Permisos de la licencia	
swMostrarDetalles = false
if session("pw_ws").accesoTakeUp then swMostrarDetalles = true	

if request.Cookies("dev")<>"" then
	for each elto in request.form
		response.Write("<strong>" & elto & "</strong>:" & request.form(elto) & " // ")
	next
end if

'response.End()
'dim tmp_sql
set rsBusq = Server.CreateObject("ADODB.Recordset")

if request.form("datos")="disp" then
	%><!--#include virtual="/takeup/resultados/disponibilidad.asp" --><% 
else
	%><!--#include virtual="/takeup/resultados/takeup.asp" --><% 
end if
%><!--include virtual="/takeup/resultados.asp" --><%

set rsBusq=nothing 


function BusquedaVacia()
	select case request.Form("datos")
	case "disp"
		BusquedaVacia = "No tenemos disponibilidad para esta b&uacute;squeda."
	case else
		BusquedaVacia = "No tenemos operaciones para esta b&uacute;squeda."
	end select
	
	exit function
	
	rsBusq.open "SELECT COUNT(*) AS nn FROM dirs_w_inmuebles WHERE id<0", session("connPW")
	
	if rsBusq("nn")=0 then
		BusquedaVacia = "No tenemos disponibilidad para esta b&uacute;squeda."
	else
		BusquedaVacia = "No hay disponibilidad aplicando estos filtros."
	end if
	
	if request.Cookies("dev")<>"" then BusquedaVacia = BusquedaVacia & " <span class='dev'>sin filtros "  & rsBusq("nn") & " inmuebles</span>"
	
	rsBusq.close
	%><script>
		console.log("if (poligono)...");
		if (poligono) poligono.setMap(null);
	</script><%
end function
%>