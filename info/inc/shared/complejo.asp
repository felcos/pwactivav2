<%
set rsEdifs = Server.CreateObject("ADODB.Recordset")
set rsAgs = Server.CreateObject("ADODB.Recordset")

sqlEdifs = "SELECT * FROM c_inmuebles WHERE id_complejo=" & rsInmueble("id") & " ORDER BY tipo_edificio, nombre"
rsEdifs.Open sqlEdifs, session("connPW")

pEdif = ""
fecha_disp = "xxx"	'rsInmueble("disponible_fecha")
total_sup_disp = 0
%>
<table class="tb-Gral tb-naves">
<thead>          
<tr>
<th></th>
<th><strong>OCUPACI&Oacute;N</strong></th>
<th><strong>propiedad</strong></th>
</tr>
</thead>
<tbody>
<%
primero = true
nn = 1
do while not rsEdifs.eof
	nombre = rsEdifs("nombre")
	if rsEdifs("id_tipo_edificio")<>"" then
		nombre = rsEdifs("tipo_edificio") & " " & nombre
	end if
	%>
	<tr class="detalles-complejo" id="<%= rsEdifs("id") %>">
        <td><%= nn %></td>
		<td><%= nombre %></td>
        <td>
<%
sql = "SELECT * FROM c_inmuebles_agentes WHERE id_inmueble=" & rsEdifs("id")
sql = sql & " AND tipo='prop' AND fecha_hasta IS NULL"

rsAgs.Open sql, session("connPW")
if rsAgs.eof then
	agentes = "Perteneciente al Complejo"
else
	agentes = ""
	do while not rsAgs.eof
		if agentes <>"" then txt = txt & ", "
		agentes = agentes & rsAgs("empresa")
		rsAgs.movenext
	loop
end if 

select case rsEdifs("id_tipo_inmueble")
case 0
	url = "/info/edificio/"
case 1
	url = "/info/centro/"
case 2
	url = "/info/hotel/"
end select
rsAgs.close %>
<%= agentes %>
<form class="pagsum_detalle" id="frmEdif<%= rsEdifs("id") %>" method="post" action="<%= url %>">
    <input type="hidden" name="frmInfo_tipo" value="<%= request.Form("frmInfo_tipo") %>">
    <% if request.Form("frmInfo_tipo")="prop" then 
		%><input type="hidden" name="frmInfo_propietario" value="<%= request.Form("frmInfo_propietario") %>"><%
	else
		%><input type="hidden" name="frmInfo_busq" value="<%= request.Form("frmInfo_busq") %>"><%
	end if %>
    <input type="hidden" name="seltipo" value="edif">
    <input type="hidden" name="id_edificio" value="<%= rsEdifs("id") %>">
    
    <!--
    <input type="hidden" name="edificio" value="< %= rsEdifs("nombre") %>">
    <input type="hidden" name="calle" value="< %= rsEdifs("nombre_calle") %>">
    <input type="hidden" name="numerocalle" value="< %= rsEdifs("numero_calle") %>">
    <input type="hidden" name="d" value="< %= rsEdifs("dir1") %>">
    <input type="hidden" name="l" value="< %= rsEdifs("localidad") %>">
    -->
    <input type="hidden" name="secc" value="<%= request.Form("secc") %>">
    <!-- 
    <input type="hidden" name="id_edificio" value="< %= rsEdifs("id") %>">
    -->
</form>
        </td>
	</tr>
	<% rsEdifs.movenext
	nn = nn + 1
loop
	%>
</table>
<%
if request.Cookies("dev")("sql")<>"" then
	%><div class="dev peq"><%= sqlEdifs %></div><%
end if

rsEdifs.close
set rsEdifs = nothing
%>