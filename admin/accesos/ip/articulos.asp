<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% 
'on error resume next
Response.Buffer = False 

starttime = Timer() 

FechaI = request("FechaI")
FechaF = request("FechaF")
if FechaF<>"" then FechaF=DateAdd("d", 1, FechaF)

ip = request("ip")

if request("titulos")="" then
	ver_titulos=false
else
	ver_titulos=true
end if

Set rs = Server.CreateObject("ADODB.Recordset")
Set rsArt = Server.CreateObject("ADODB.Recordset")

sqlW = "reg_accesos.remote_host='" & ip & "'"

if sqlW<>"" then sqlW = "(" & sqlW & ")"

if FechaI<>"" then
	sqlF = "reg_articulos.fecha>='" & FechaI & "'"
end if
if FechaF<>"" then
	if sqlF<>"" then sqlF = sqlF & " AND "
	sqlF = sqlF & "reg_articulos.fecha<'" & FechaF & "'"
end if
if sqlF<>"" then sqlF = " AND (" & sqlF & ")"

sqlW = sqlW & sqlF

sql = "SELECT reg_articulos.* FROM reg_articulos LEFT OUTER JOIN reg_accesos ON reg_articulos.session_id = reg_accesos.session_id WHERE (" & sqlW & ") ORDER BY reg_articulos.id DESC"	'		fecha DESC, hora DESC"
'test_inyeccion_sql sql
rs.Open sql, session("connPWAcesos")

if request.Cookies("dev")("sql")<>"" then %>
	<p class="med"><%= sql %></p>
	<hr />
<% end if %>
<table width="100%" class="reg">
  <tr>
    <th style="width:30px;">nn</th>
    <th style="width:45px;">id</th>
    <th style="width:75px;">fecha</th>
    <th style="width:55px;">hora</th>
    
    <th style="width:10px;"></th>
    <th style="width:150px;">cliente</td>
    <th style="width:200px;">licencia</td>
    
    <th style="width:50px; ">art&iacute;culo</th>
    
    <th style="width:10px;"></th>
    <th style="text-align:left;">titulo</th>
    <th style="text-align:left; width:150px;">-</th>
  </tr>
<%
duplicados = ""
inexistentes = ""
articulos = "#"
nn = 0
duplicados_n = 0
articulos_n=0

do while not rs.eof 
	nn = nn+1
	hora = rs("hora")
	hora = mid(hora, instr(hora, " ")+1, len(hora))
	titulo = ""
	
	articulo = rs("articulo_tipo") & rs("articulo_id") & "_" & rs("session_id")
	'if instr(articulos, "#" & articulo & "#") then
	'	if duplicados<>"" then duplicados = duplicados & ", "
	'	duplicados = duplicados & rs("id")
	'	duplicados_n = duplicados_n + 1
	'	articulo_ver = "repetido"
	'else
		articulos = articulos & articulo & "#"
		articulos_n = articulos_n + 1
		articulo_ver = articulo
		
		if ver_titulos then
			select case rs("articulo_tipo")
			case "not", "rum", "est", "dem"
				sqlArt = "SELECT * FROM NOTICIAS_INMOBILIARIAS WHERE ID=" & rs("articulo_id")
			case "ope"
				sqlArt = "SELECT * FROM OPERACIONES WHERE ID=" & rs("articulo_id")
			case else
				'titulo = ""
			end select
			
			rsArt.Open sqlArt, session("connPW")
			if rsArt.eof then 
				titulo = "[[ FALTA ]]"
				if inexistentes<>"" then inexistentes = inexitentes & ", "
				inexistentes = inexistentes & rs("articulo_tipo") & rs("articulo_id")
			else
				titulo = rsArt("titulo")
			end if
			rsArt.close
			titulo = replace(titulo, """", "&quot;")
		end if
		
	'end if
	
	url_c = "uid=" & rs("id_cliente") & "&u=" & rs("cliente")
	url_l = "&lid=" & rs("id_licencia") & "&l=" & rs("licencia")
	
	strin = left(rs("articulo_tipo"), 3)
	link_articulo = "/articulos/?" & strin  &"=" & rs("articulo_id")
	%>
<tr>
	<td class="dra"><%= nn %></td>
    <td class="dra peq"><%= rs("id") %></td>
    <td class="dra"><%= rs("fecha") %></td>
    <td class="dra"><%= hora %></td>
    
    <td></td>
    <td><a href="/admin/accesos/cliente/?<%= url_c %>" target="_blank"><%= rs("cliente") %> <span class="peq"><%= rs("id_cliente") %></span></a></td>
    <td><a href="/admin/accesos/cliente/?<%= url_c & url_l %>" target="_blank"><%= rs("licencia") %> <span class="peq"><%= rs("id_licencia") %></span></a></td>
    
    <td><a href="<%= link_articulo %>" class="simplemodal"><%= rs("articulo_tipo") %>&nbsp;<%= FormatNumber(rs("articulo_id"), 0) %></a></td>
    <td></td>
    <td><a href="<%= link_articulo %>" class="simplemodal"><%= articulo %></a></td>
    
    <td class="peq"><%= articulo_ver %></td>
</tr>
	<% 
	rs.movenext
loop
%>
</table>
<%
rs.close
set rs=nothing
set rsArt=nothing

endtime = Timer() 

if request.Cookies("dev")<>"" then %>
    <div class="dev" style="margin-top:18px;">
        <li>tiempo: <%= FormatNumber((endtime-starttime),3 ) %> seg.</li>
        <% if inexistentes<>"" then %>
        <li>inexistentes: <%= inexistentes %></li>
        <% end if %>
        <li>articulos visitados: <%= articulos_n %></li>
    </div>
<% end if %>
<script language="javascript">	
$(document).ready(function(){
	$('#contador_articulos').html('(<%= articulos_n %>)');
});


jQuery(function ($) {
	$('.simplemodal').click(function (e) {
		alert("modal!!");
		return false;
	});	
});
</script>

