<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% 
on error resume next

starttime = Timer() 

FechaI = request("Fecha")
FechaF = DateAdd("d", 1, FechaI)

if request("titulos")="" then
	ver_titulos=false
else
	ver_titulos=true
end if

Set rs = Server.CreateObject("ADODB.Recordset")
Set rsArt = Server.CreateObject("ADODB.Recordset")

sql = "(fecha>='" & FechaI & "' AND fecha<'" & FechaF & "')" & sql

'sql = "SELECT * FROM reg_articulos WHERE (" & sql & ") ORDER BY id DESC"	'		fecha DESC, hora DESC"
sql = "SELECT articulo_tipo, articulo_id, vars, COUNT(id) AS visitas FROM reg_articulos WHERE (" & sql & ") GROUP BY articulo_tipo, articulo_id, vars ORDER BY COUNT(id) DESC"

'test_inyeccion_sql sql
rs.Open sql, session("connPWAcesos") 

if request.Cookies("dev")("sql")<>"" then %>
	<p class="med"><%= sql %></p>
	<hr />
<% 'response.End()
end if

if request.Cookies("dev")("request")<>"" then 
	if request.QueryString<>"" then %>
        <p>QueryString: &nbsp; <%
        for each elto in request.QueryString
            %><strong><%= elto %></strong>: <%= request.QueryString(elto) %>&nbsp; <%
        next
        %></p><%
	end if
	if request.Form<>"" then
		%><p>Form: &nbsp; <%
		for each elto in request.Form
			%><strong><%= elto %></strong>: <%= request.Form(elto) %>&nbsp; <%
		next
		%></p><%
	end if
	%><hr /><%
end if %>
<table width="100%" class="reg">
  <tr>
    <th style="width:25px;">nn</th>
    <th style="width:10px;"></th>
    <th style="text-align:left;">titulo</th>
    <th style="width:70px; text-align:left;">f. actualiz.</th>
    <th style="width:10px;"></th>
    
    <th style="width:50px;">art.</th>
    <th colspan="3">visitas</th>
    
  </tr>
<%
inexistentes = ""
articulos = "#"
nn = 0
visitas=0

do while not rs.eof 
	nn = nn+1
	'hora = rs("hora")
	'hora = mid(hora, instr(hora, " ")+1, len(hora))
	titulo = ""
	
	articulo = rs("articulo_tipo") & rs("articulo_id") & "_" & rs("session_id")
	
	articulos = articulos & articulo & "#"
	visitas = visitas + rs("visitas")
	articulo_ver = articulo
	
	'if ver_titulos then
		select case rs("articulo_tipo")
		case "not", "rum", "est", "dem"
			sqlArt = "SELECT * FROM NOTICIAS_INMOBILIARIAS WHERE ID=" & rs("articulo_id")
		case "ope", "ven"
			sqlArt = "SELECT * FROM OPERACIONES WHERE ID=" & rs("articulo_id")
		case "sub"
			sqlArt = "SELECT * FROM CONCURSOS WHERE ID=" & rs("articulo_id")
		case "empr"
			sqlArt = "SELECT ID, NOMBRE AS TITULO FROM EMPRESAS WHERE ID=" & rs("articulo_id")
		case "inm"
			sqlArt = "SELECT ID, NOMBRE AS TITULO FROM c_inmuebles WHERE ID=" & rs("articulo_id")
		case else
			sqlArt = ""
		end select
		
		if sqlArt="" then 
			titulo = rs("vars")
			fecha = ""
		else
			rsArt.Open sqlArt, session("connPW")
			if rsArt.eof then 
				titulo = "[[ FALTA ]]"
				if inexistentes<>"" then inexistentes = inexitentes & ", "
				inexistentes = inexistentes & rs("articulo_tipo") & rs("articulo_id")
				fecha = ""
			else
				titulo = rsArt("titulo")
				select case rs("articulo_tipo")
				case "inm", "empr", "dir"
					fecha = ""
				case else
					fecha = rsArt("fecha_actualizacion")
				end select
			end if
			rsArt.close
			
		end if
		titulo = replace(titulo, """", "&quot;")
	'end if
	
	'url = "uid=" & cliente_id & "&u=" & cliente & "&lid=" & rs("id_licencia") & "&l=" & rs("licencia")	
	
	strin = left(rs("articulo_tipo"), 3)
	link_articulo = "/articulos/?" & strin  &"=" & rs("articulo_id")
	%>
<tr>
	<td class="dra"><%= nn %></td>
    <td></td>
    <td><a href="t=<%= rs("articulo_tipo") %>&id=<%= rs("articulo_id") %>&f=<%= FechaI %>" class="ver_detalles" id="<%= nn %>"><%= titulo %></a></td>
    <td class="med"><%= fecha %></td>
    <td></td>
    <td class="peq"><a href="<%= link_articulo %>" class="simplemodal"><%= rs("articulo_tipo") %>&nbsp;<%= FormatNumber(rs("articulo_id"), 0) %></a></td>
    <td style="width:10px;"></td>
    <td style="width:40px;" align="right"><a href="t=<%= rs("articulo_tipo") %>&id=<%= rs("articulo_id") %>&f=<%= FechaI %>" class="ver_detalles" id="<%= nn %>"> &nbsp; <%= rs("visitas") %> &nbsp; </a></td>
    <td style="width:5px;"></td>
</tr>
<tr id="row<%= nn %>" style="display:none;">
    <td colspan="8" id="art<%= nn %>" style="padding:0 10px 10px 20px; background-color:#EEEEEE;"></td>
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

if request.Cookies("dev")<>"" then  %>
	<div class="dev" style="margin-top:18px;">
        <li>tiempo: <%= FormatNumber((endtime-starttime),3 ) %> seg.</li>
        <% if inexistentes<>"" then %>
        <li>inexistentes: <%= inexistentes %></li>
        <% end if %>
        <li>articulos visitados: <%= visitas %></li>
    </div>
<% end if %>
<script language="javascript">	
$(document).ready(function(){
	$('#contador_articulos').html('(<%= visitas %>)');
	
	$('.ver_detalles').click(function (e) {
		var id=this.getAttribute("id");
		
		var fila=document.getElementById('row'+id);
		
		if (fila.style.display=='') {
			fila.style.display='none';
		} else {
			fila.style.display='';
		};
		
		var ncelda='#art'+id;
		var celda = $(ncelda);
		
		if (celda.html()=='') {
			$.ajax({
				url: '/admin/accesos/datos/articulos_visitas.asp?'+this.getAttribute("href"),
				data: '',
				beforeSend: function() {
					celda.html('<img src="/img/camera-loader.gif">');
				},
				success: function(data, status, xhr){
					celda.html(data);
				},
				error: function(xhr, status, err) {}
			});
		}
		
		//console.log($(celda).html());
		return false;
	})
	
});

jQuery(function ($) {
	$('.simplemodal').click(function (e) {
		alert("modal!!");
		return false;
	});	
});
</script>
