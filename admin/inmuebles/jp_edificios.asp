<%@ LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
Response.Buffer = False
%>
<style>
table.listado, table.listado th, table.listado td {
	border-bottom:1px solid #c1c1c1;
	padding: 2px 4px;
	
	}
	
table.listado {
    border-collapse: collapse;
	/* table-layout: fixed; */
	}
table.listado th {
	/* text-align:left; */
	}
table.listado td {
    vertical-align: top;
	}

table.listado tr:hover {
	background-color:#EEEEEE;
	cursor:pointer;
	}
table.inmueble tr:hover {
	background-color:#FFF;
	cursor:default;
	}
table.inmueble, table.inmueble th, table.inmueble td {
	border-bottom:1px solid #c1c1c1;
	padding: .5em;
	}
	
table.inmueble {
	cursor: inherit;
	background-color:#FFF;
	border-collapse: collapse;
	width:100%;
	/* margin:.5em; */
	/* table-layout: fixed; */
	}
table.inmueble th {
	/* text-align:left; */
	}
table.inmueble td {
    vertical-align: top;
	}

.actual {
	background-color: #EEEEEE;
	}

.resalta {
	font-weight:bold;
	}
</style>
<%
set rsBusq = Server.CreateObject("ADODB.Recordset")

counter = 0

'búsqueda	
busqueda = trim(request.Form("busq"))
busqueda = replace(busqueda, "'", "''")

'nacional/internacional	
'if request.Form("nacional")="" then
'	sw_nac = false
'else
'	sw_nac = true
'end if
'if request.Form("internacional")="" then
'	sw_int = false
'else
'	sw_int = true
'end if
'if not(sw_nac) and not(sw_int) then 
'	sw_nac = true
'	sw_int = true
'end if

'tipo búsqueda	
sw_edif = false
sw_cc = false
sw_hot = false
if request.Form("edif")<>"" then sw_edif = true
if request.Form("cc")<>"" then sw_cc = true
if request.Form("hotel")<>"" then sw_hot = true

'sql	
if busqueda<>"" then
	sqlw = "(("
	sqlw = sqlw & "nombre_completo LIKE '%" & busqueda & "%'"
	sqlw = sqlw & " OR nombre_alt LIKE '%" & busqueda & "%'"
	'sqlw = sqlw & " OR localidad LIKE '%" & busqueda & "%'"
	sqlw = sqlw & ") OR ("
	sqlw = sqlw & "dir1 LIKE '%" & busqueda & "%' OR "
	sqlw = sqlw & "dir2 LIKE '%" & busqueda & "%' OR "
	sqlw = sqlw & "dir3 LIKE '%" & busqueda & "%' OR "
	sqlw = sqlw & "dir4 LIKE '%" & busqueda & "%' OR "
	sqlw = sqlw & "dir5 LIKE '%" & busqueda & "%'"
	sqlw = sqlw & "))"
end if

'if not(sw_nac and sw_int) then
'	if sqlw<>"" then sqlw = sqlw & " AND "
'	if sw_int then
'		sqlw = sqlw & "id_pais<>1"
'	else
'		sqlw = sqlw & "id_pais=1"
'	end if
'end if

sqlt = ""
if (sw_edif and sw_cc and sw_hot) then
	
else
	if sw_hot then
		if sqlt<>"" then sqlt = sqlt & " OR "
		sqlt = sqlt & "id_tipo_inmueble=2"
	end if
	if sw_cc then
		if sqlt<>"" then sqlt = sqlt & " OR "
		sqlt = sqlt & "id_tipo_inmueble=1"
	end if
	if sw_edif then
		if sqlt<>"" then sqlt = sqlt & " OR "
		sqlt = sqlt & "id_tipo_inmueble NOT IN (1, 2)"
	end if
	
	if sqlt<>"" then
		if sqlw<>"" then sqlw = sqlw & " AND "
		sqlw = sqlw & "(" & sqlt & ")"
	end if
end if

'if sqlw<>"" then sqlw = sqlw & " AND "
'sqlw = sqlw & "tiene_coords=1"

'if sqlw<>"" then sqlw = sqlw & " AND "
'sqlw = sqlw & "tiene_dir=1"

if sqlw<>"" then sqlw = sqlw & " AND "
sqlw = sqlw & "id_pais=1"

if sqlw="" then
	response.Write(sql)
	response.End()
	
else
	select case request.Form("tiene_dir")
	case "1"
		if sqlw<>"" then sqlw = sqlw & " AND "
		sqlw = sqlw & "tiene_dir=1"
	case "0"
		if sqlw<>"" then sqlw = sqlw & " AND "
		sqlw = sqlw & "tiene_dir=0"
	end select
	
	select case request.Form("tiene_coords")	
	case "1"
		if sqlw<>"" then sqlw = sqlw & " AND "
		sqlw = sqlw & "tiene_coords=1"
	case "0"
		if sqlw<>"" then sqlw = sqlw & " AND "
		sqlw = sqlw & "tiene_coords=0"
	end select
	
	select case request.Form("tiene_plantas")	
	case "1"
		if sqlw<>"" then sqlw = sqlw & " AND "
		sqlw = sqlw & "id IN (SELECT DISTINCT id_inmueble FROM inmuebles_plantas)"
	case "0"
		if sqlw<>"" then sqlw = sqlw & " AND "
		sqlw = sqlw & "id NOT IN (SELECT DISTINCT id_inmueble FROM inmuebles_plantas)"
	end select
	
	select case request.Form("tiene_disponibl")	
	case "1"
		if sqlw<>"" then sqlw = sqlw & " AND "
		sqlw = sqlw & "disponible_fecha IS NOT NULL"
	case "0"
		if sqlw<>"" then sqlw = sqlw & " AND "
		sqlw = sqlw & "disponible_fecha IS NULL"
	end select
	
	select case request.Form("tiene_latlng")
	case "1"
		if sqlw<>"" then sqlw = sqlw & " AND "
		sqlw = sqlw & "(lat IS NOT NULL)"
	case "0"
		if sqlw<>"" then sqlw = sqlw & " AND "
		sqlw = sqlw & "(lat IS NULL)"
	end select
	
	sqlw = " WHERE (" & sqlw & ")"
end if

if request.Form("top")="" then
	sql = "SELECT * "
else
	sql = "SELECT TOP(25) * "
end if
sql = sql & "FROM dirs_w_inmuebles" & sqlw 	& " ORDER BY nombre"	'localidad, nombre_calle, numero_calle_ord, numero_calle

if not(sw_edif OR sw_cc OR sw_hot) then response.End()

rsBusq.open sql, session("connPW")
%>
<table width="100%" class="listado">
<tbody>
<%
do while not rsBusq.eof 
	contador_paso = contador_paso + 1
	counter = counter + 1
	
	c_nombre = rsBusq("nombre_completo")
	
	c_id = rsBusq("id")
	
	c_tipo = rsBusq("tipo_inmueble")
	if rsBusq("id_tipo_inmueble")=0 then
		c_secc = rsBusq("seccion")
		if c_secc = "MIXTO" then c_sec = rsBusq("id_seccion")
		if len(c_secc)>30 then c_sec = left(c_sec,25) & "..."
		'c_tipo = c_tipo & " &nbsp; <span class='inm_uso'>[" & c_secc & "]"
		c_tipo = c_secc
	end if
	
	c_disp_fecha = "" & rsBusq("disponible_fecha")
	
	if c_disp_fecha = "" then
		c_disp_fecha = "<span class='inm_uso' style='padding-left: 20px;'>N/D</span>"
	end if
	
	
	dir = rsBusq("dir3") 
	
	if rsBusq("dir4")<>"" then
		if dir<>"" then dir = dir & ", "
		dir = dir & rsBusq("dir4")
	end if
	if rsBusq("dir5")<>"" then
		if dir<>"" then dir = dir & ", "
		dir = dir & rsBusq("dir5")
	end if
	
	gdir = rsBusq("dir3") 
	if rsBusq("dir5")<>"" then
		if gdir<>"" then gdir = gdir & ", "
		gdir = gdir & rsBusq("dir5")
	end if 
	if gdir<>"" then
		gmap = Replace(gdir, " ", "+")
		gmap = "https://www.google.es/maps/place/" & gmap
	end if
	
	tiene_latlng=true
	if isnull(rsBusq("lat")) or isnull(rsBusq("lng")) then
		tiene_latlng = false
	end if
	
	otros_nombres = "" & rsBusq("nombre_alt")
	otros_nombres = replace(otros_nombres, chr(13), "<br>")
	%>
<tr id="tr<%= rsBusq("id") %>">
<td class="peq" style="padding-top:5px; width:25px;"><a href="#" onclick="inmueble_ver(<%= rsBusq("id") %>)"><%= counter %></a>
<form id="frm<%= counter %>" method="post" action="/info/inmueble/" target="_blank">
    <input type="hidden" name="q" value="<%= rsBusq("nombre_completo") %>">
    <input type="hidden" name="seltipo" value="inmueble">
    <input type="hidden" name="tipo" value="<%= tipo %>">
	<input type="hidden" name="id_edificio" value="<%= rsBusq("id") %>">
	<input type="hidden" name="edificio" value="<%= rsBusq("nombre_completo") %>">
	<input type="hidden" name="calle" value="<%= rsBusq("nombre_calle") %>">
	<input type="hidden" name="numerocalle" value="<%= rsBusq("numero_calle") %>">
	<input type="hidden" name="d" value="<%= rsBusq("dir3") %>">
	<input type="hidden" name="l" value="<%= rsBusq("localidad") %>">
</form>
</td>
<td id="nombre<%= rsBusq("id") %>" onclick="inmueble_ver_mapa(<%= rsBusq("id") %>)"><%= c_nombre %></td>
<td class="peq" align="center" style="width:30px;"><input type="checkbox" id="tiene_coords_<%= rsBusq("id") %>" name="tiene_coords" value="1" <% if rsBusq("tiene_coords") then %>checked<% end if %> disabled="disabled"  onclick="cambia_tienecoords(<%= rsBusq("id") %>)" class="confirmar_coordenadas"/></td>
<td class="peq" align="center" style="width:25px;"><input type="checkbox" id="tiene_dir_<%= rsBusq("id") %>" name="tiene_dir" value="1" <% if rsBusq("tiene_dir") then %>checked<% end if %> disabled="disabled" onclick="cambia_tienedir(<%= rsBusq("id") %>)" /></td>
<td class="peq" align="center" style="width:25px;"><input type="checkbox" id="tiene_latlng_<%= rsBusq("id") %>" name="tiene_latlng" value="1" <% if tiene_latlng then %>checked<% end if %> disabled="disabled"/></td>
	</tr>
	<tr id="detalles_<%= rsBusq("id") %>" style="display:none; background-color:#EEEEEE;">
	  <td colspan="5" style="padding:.4em 6px 1em;">
      
<table class="inmueble">
	<tr>
	  <td valign="bottom"><span class="mini">id</span>: <strong><%= rsBusq("id") %></strong></td>
	  <td></td>
	  <td></td>
	  <td align="right"><a href="<%= gmap %>" target="_blank" class="mini">google</a></td>
	  <td style="width:45px;" align="right"><a href="/info/inmueble/" class="mini" onclick="$('#frm<%= counter %>').submit();return false;">pw info</a></td>
    </tr>
    <tr><td class="mini">otros nombres:</td><td colspan="4"><strong><%= otros_nombres %></strong></td></tr>
    <tr><td colspan="5"><%= dir %></td></tr>
	<tr>
		<td class="mini">dir:</td>
        <td colspan="4">
            <li><%= rsBusq("dir3") %></li>
            <li><%= rsBusq("dir4") %></li>
            <li><%= rsBusq("dir5") %></li>
        </td>
	</tr>
	<tr>
        <td class="mini">coords: </td>
        <td colspan="4">
<form method="get" action="/inmuebles/bin/coords.asp" target="_blank" id="frminm<%= rsBusq("id") %>" class="confirmar">
<input type="hidden" name="id" value="<%= rsBusq("id") %>">
<%
lat = "" & rsBusq("lat")
lat = replace(lat, ",", ".")

lng = "" & rsBusq("lng")
lng = replace(lng, ",", ".")
%>
<table border="0" cellspacing="0" cellpadding="0">
	<tr>
	  <td class="mini" style="padding:1px; border:none;">lat:</td>
	  <td class="mini" style="padding:1px; border:none;"><input id="lat<%= rsBusq("id") %>" type="text" disabled="disabled" name="lat" value="<%= lat %>" style="width:140px; font-size:10px; text-align:right;"></td>
	  <td class="mini" style="padding:1px; border:none;"><input id="glat<%= rsBusq("id") %>" type="text" name="lat" value="<%= glat %>" style="width:140px; font-size:10px; text-align:right;"></td>
<!-- <a href="#" onclick="$('#frminm< %= rsBusq("id") %>').submit(); return false;" id="< %= rsBusq("id") %>">confirmar mapa</a>  -->
      <td class="mini" style="padding:1px 0 1px 30px; border:none;" rowspan="2" width="150">
<span id="guardar_mapa_<%= rsBusq("id") %>"><input class="mini" style="border:none; background:none!important; cursor: pointer;" value="guardar" type="button" onclick="guardar(<%= rsBusq("id") %>)"/> &nbsp;</span> 
<span id="confirmar_mapa_<%= rsBusq("id") %>"><input class="mini confirmar_coordenadas" style="border:none; background:none!important; cursor: pointer;" value="confirmar" type="button" onclick="confirmar(<%= rsBusq("id") %>)"/></span>
      </td>
    </tr>
	<tr>
	  <td class="mini" style="padding:1px; border:none;">lng: </td>
      <td class="mini" style="padding:1px; border:none;"><input id="lng<%= rsBusq("id") %>" type="text" disabled="disabled" name="lng" value="<%= lng %>" style="width:140px; font-size:10px; text-align:right;"></td>
	  <td class="mini" style="padding:1px; border:none;"><input id="glng<%= rsBusq("id") %>" type="text" name="lng" value="<%= glng %>" style="width:140px; font-size:10px; text-align:right;"></td>
	 </tr>
	<tr>
	  <td class="mini" style="padding:1px; border:none;">&nbsp;</td>
	  <td class="mini" align="center" style="padding:1px; border:none;"><span id="quita_coords<%= rsBusq("id") %>" <% if not tiene_latlng then %>style="display:none;"<% end if %>>
<a href="#" onclick="quita_coords(<%= rsBusq("id") %>);" >quita coords</a></span>
	</td>
	  <td class="mini" align="center" style="padding:1px; border:none;"><span id="grabar_coords_<%= rsBusq("id") %>" style="display:none;"><a href="#">grabar</a></span></td>
	  <td class="mini" style="padding:1px 0 1px 20px; border:none; vertical-align:middle;">&nbsp;</td>
	  </tr>
	<tr><td colspan="4" class="mini" style="border:none;"></td></tr>
    <tr>
	  <td class="mini" style="padding:1px; border:none;">place:</td>
	  <td colspan="2" class="mini" style="padding:1px; border:none;"><input id="placeid<%= rsBusq("id") %>" type="text" name="placeid" value="<%= rsBusq("place_id") %>" style="width:288px; font-size:10px;"></td>
      <td class="mini" style="padding:1px 0 1px 30px; border:none;"><span id="quita_placeid<%= rsBusq("id") %>"><input class="mini" style="border:none; background:none!important; cursor: pointer;" value="quita place_id" type="button" onclick="quita_placeid(<%= rsBusq("id") %>)"/></span></td>
  </tr>
</table>
</form>
		</td>
	</tr>
    
    <tr><td colspan="5" class="peq" id="recibe_place<%= rsBusq("id") %>" style="display:none;"></td></tr>
    
	<tr>
    	<td class="mini" style="border-bottom:none;">geocoder: </td>
        <td colspan="3" class="peq" style="border-bottom:none;">
<input id="inm<%= rsBusq("id") %>" type="text" name="q" value="<%= gdir %>" style="width:100%; border:none;"></td>
    	<td class="mini" style="width:45px; border-bottom:none;" align="right" valign="bottom"><span id="obtener_geocodes<%= rsBusq("id") %>"><a href="#" onclick="obtener_geocodes(<%= rsBusq("id") %>); return false;">consultar</a></span></td>
	</tr>
    <tr><td colspan="5" class="peq" id="recibe_geocoder<%= rsBusq("id") %>"></td></tr>
</table>
	  
      </td>
    </tr>
	<%
	rsBusq.movenext
loop
%>
</tbody>
</table>
<%
'informa
x = ""
for each elto in request.form
	if x<>"" then x = x & " // "
	x = x & elto & ": <strong>" & request.form(elto) & "</strong>"
next
informa_form = x

informa_sql = rsBusq.source

rsBusq.close

set rsBusq=nothing 
%>
<script language="javascript">	
//$(document).ready(function(){
	$("#informa-sql").html("<%= informa_sql %>");
	$("#informa-busq").html("<%= informa_form %>");
	<% if request.Form("top")="" then %>
	$("#contador_articulos").html("(<%= counter %>)")
	<% end if %>
//})
</script>