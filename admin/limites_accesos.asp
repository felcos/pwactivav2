<%@ LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
pasa = false

if request.Cookies("dev")<>"" then pasa=true
if request.Cookies("licencia")("client_id")="1" then pasa=true
if request.Cookies("licencia")("client_id")="2" then pasa=true

if not(pasa) then response.Redirect("/")
%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>PropertyWeb - Admin</title>
    <link href="/_inc/foldy/base.css" rel="stylesheet" type="text/css">
    <link href="/_inc/foldy/estilos.css" rel="stylesheet" type="text/css">
	<!--#include virtual="/inc/js.asp" -->
    <link href="/lib/datepicker/datepicker.css" rel="stylesheet" type="text/css" />
    <script src="/lib/datepicker/datepicker.js" type="text/javascript"></script>
</head>
<%
set rs = Server.CreateObject("ADODB.Recordset")
%>
<body>
<!--#include virtual="/inc/simple/body-header.asp" -->
<section id="content">
<div class="contenedor">

<section id="introp" class="cf">

	<div class="grid-full">
    	<h1 class="heading">admin</h1>
	</div>
    
    <div class="grid-4">
        <div class="caja">
<% if request.QueryString="" then 
	rEmail = ""
	rFecha = date
	%>
	<p>SIN REQUEST</p>
<% else
	rFecha = request.QueryString("fecha")
	rEmail = request.QueryString("email")
	
	'contadores
	'dim contador(5, 2)
	'dim limites(5, 2)
	
	limites(1,0)=30
	limites(1,1)=50
	
	limites(2,0)=8 
	limites(2,1)=20 
	
	limites(3,0)=10
	limites(3,1)=10
	
	limites(4,0)=8
	limites(4,1)=20
	
	for ii=0 to 4	
		for jj=0 to 1
			contador(ii, jj)=0
		next
	next
	
	'recuento por accesos, sólo operaciones
	sql = "SELECT articulo_id FROM reg_articulos WHERE articulo_tipo = 'ope' AND "
	sql = sql & "licencia = '" & rEmail & "' AND "
	sql = sql & "fecha = '" & rFecha & "'"
	
	'response.Write(sql)
	'response.Write("<hr>")
	
	nn = 0
	ids = ""
	rs.open sql, session("connPWAcesos")
	
	do while not rs.eof
		nn=nn+1
		if ids<>"" then ids=ids & ", "
		ids = ids & rs("articulo_id")
		rs.movenext
	loop
	
	rs.close
	
	'clasificar las operaciones
	if ids<>"" then
		sql = "SELECT * FROM C_OPERACIONES WHERE ID IN (" & ids & ")"
		'response.Write(sql)
		'response.Write("<hr>")
		
		rs.open sql, session("connPW")
		
		do while not rs.eof
			
			select case rs("ID_TIPO_OPERACION")
			case 1, 3	'inversion / oc. propia
				mm = 0
			case 2, 4	'alquiler / traspaso
				mm = 1
			case else
				mm = -1
			end select
			
			nn = -1
			if instr(rs("seccion"), "OFICINAS") then nn=1
			if instr(rs("seccion"), "LOCALES") then nn=2
			if instr(rs("seccion"), "HOTELES") then nn=3
			if instr(rs("seccion"), "NAVES") then nn=4
			
			IF 1=2 THEN
			select case rs("id_seccion")
			case 16		'oficinas
				nn = 0
			case 4		'locales
				nn = 1
			case 2		'hoteles
				nn = 2
			case 8		'naves
				nn = 3
			case else
				nn = -1
			end select
			END IF
			
			if 1=2 then %><li><%= rs("TIPOOPERACION") %> / <%= rs("seccion") %></li><% end if
			
			if nn>=0 and mm>=0 then
				contador(nn, mm) = contador(nn, mm)+1
			else
				contador(0, mm) = contador(0, mm)+1
			end if
			
		rs.movenext
		loop
		
		rs.close
	end if	'ids<>""
	
	'alerta(s)
	alerta = false
	
	'oficinas
	'if contador(1,0)>=limites(1,0) then call Avisar("oficinas inversion", rEmail, rFecha)
	'if contador(1,1)>=limites(1,1) then call Avisar("oficinas alquiler", rEmail, rFecha)
	
	'locales
	'if contador(2,0)>=limites(2,0) then call Avisar("locales inversion", rEmail, rFecha)
	'if contador(2,1)>=limites(2,1) then call Avisar("locales alquiler", rEmail, rFecha)
	
	'hoteles
	'if contador(3,0)>=limites(3,0) then call Avisar("hoteles inversion", rEmail, rFecha)
	'if contador(3,1)>=limites(3,1) then call Avisar("hoteles alquiler", rEmail, rFecha)
	
	'naves
	'if contador(4,0)>=limites(4,0) then call Avisar("naves inversion", rEmail, rFecha)
	'if contador(4,1)>=limites(4,1) then call Avisar("naves alquiler", rEmail, rFecha)
	%>
<table border="1" cellspacing="0" cellpadding="3">
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">invers. / oc.propia</td>
    <td colspan="2">alquiler/traspaso</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td bgcolor="#CCCCCC">&nbsp;</td>
    <td bgcolor="#CCCCCC" colspan="2" class="peq">1 / 3</td>
    <td bgcolor="#CCCCCC" colspan="2" class="peq">2 / 4</td>
  </tr>
  <tr>
    <td>oficinas</td>
    <td bgcolor="#CCCCCC">16</td>
    
    <td align="right"<% if contador(1, 0)>=limites(1, 0) then %> class="txtRojo"<% end if %> width="60"><%= contador(1, 0) %></td>
    <td width="60"><span class="peq" style="padding-left:20px;">max. <%= limites(1, 0) %></span></td>
    <td align="right"<% if contador(1, 1)>=limites(1, 1) then %> class="txtRojo"<% end if %> width="60"><%= contador(1, 1) %></td>
    <td width="60"><span class="peq" style="padding-left:20px;">max. <%= limites(1, 1) %></span></td>
  </tr>
  <tr>
    <td>locales</td>
    <td bgcolor="#CCCCCC">4</td>
    <td align="right"<% if contador(2, 0)>=limites(2, 0) then %> class="txtRojo"<% end if %>><%= contador(2, 0) %></td>
    <td width="60"><span class="peq" style="padding-left:20px;">max. <%= limites(2, 0) %></span></td>
    <td align="right"<% if contador(2, 1)>=limites(2, 1) then %> class="txtRojo"<% end if %>><%= contador(2, 1) %></td>
    <td width="60"><span class="peq" style="padding-left:20px;">max. <%= limites(2, 1) %></span></td>
  </tr>
  <tr>
    <td>hoteles</td>
    <td bgcolor="#CCCCCC">2</td>
    <td align="right"<% if contador(3, 0)>=limites(3 ,0) then %> class="txtRojo"<% end if %>><%= contador(3, 0) %></td>
    <td width="60"><span class="peq" style="padding-left:20px;">max. <%= limites(3, 0) %></span></td>
    <td align="right"<% if contador(3, 1)>=limites(3, 1) then %> class="txtRojo"<% end if %>><%= contador(3, 1) %></td>
    <td width="60"><span class="peq" style="padding-left:20px;">max. <%= limites(3, 1) %></span></td>
  </tr>
  <tr>
    <td>naves</td>
    <td bgcolor="#CCCCCC">3</td>
    <td align="right"<% if contador(4, 0)>=limites(4, 0) then %> class="txtRojo"<% end if %>><%= contador(4, 0) %></td>
    <td width="60"><span class="peq" style="padding-left:20px;">max. <%= limites(4, 0) %></span></td>
    <td align="right"<% if contador(4, 1)>=limites(4, 1) then %> class="txtRojo"<% end if %>><%= contador(4, 1) %></td>
    <td width="60"><span class="peq" style="padding-left:20px;">max. <%= limites(4, 1) %></span></td>
  </tr>
  <tr>
    <td>resto</td>
    <td bgcolor="#CCCCCC">&nbsp;</td>
    <td bgcolor="#CCCCCC" align="right"><%= contador(0, 0) %></td>
    <td bgcolor="#CCCCCC"></td>
    <td bgcolor="#CCCCCC" align="right"><%= contador(0, 1) %></td>
    <td bgcolor="#CCCCCC"></td>
  </tr>
</table>
 
<% end if %>

        </div>
	</div>
    
    <div class="grid-2 grid-flow-opposite">
        <div class="caja med">
<form method="get" action="" id="frm">
<p><input name="email" type="text" value="<%= rEmail %>" style="width:360px;"></p>
<p><input type="text" name="fecha" id="fecha" value="<%= rFecha %>" maxlength="10" class="fecha"></p>
<p><a href="/admin/limites_accesos.asp">reset</a> &nbsp; &nbsp; <input value="consultar" type="submit"></p>
</form>

        </div>
        <div class="caja med" style="margin-top:8px; background-color:#CCC" id="informa_email"></div>
        <% if request.QueryString<>"" then %>
        <div class="caja med" style="margin-top:8px;">
<% for each elto in request.QueryString 
	%><li><%= elto %>: <%= request.QueryString(elto) %></li><%
next %>
        </div>
        <% end if %>
    </div>
    
    <div class="grid-4">
<div class="caja" style="height:300px; overflow-y:scroll;">
<%
sql = "SELECT licencia, fecha, COUNT(articulo_id) AS ops FROM reg_articulos WHERE "
sql = sql & "articulo_tipo = 'ope' AND fecha > '2015/01/01' "
sql = sql & "GROUP BY licencia, fecha "
sql = sql & "HAVING (licencia LIKE '%@%' AND COUNT(articulo_id)>30)"
sql = sql & "ORDER BY COUNT(articulo_id) DESC"

'response.Write(sql)
rs.open sql, session("connPWAcesos")
nn=1
%>
<table width="100%" border="0" cellspacing="0" cellpadding="2">
    <tr>
        <td width="20" style="border-bottom:1px solid grey;"><strong>nn</strong></td>
        <td width="30" style="border-bottom:1px solid grey;"><strong>ops.</strong></td>
        <td width="20" style="border-bottom:1px solid grey;"></td>
        <td style="border-bottom:1px solid grey;"><strong>licencia</strong></td>
        <td width="70" style="border-bottom:1px solid grey;"><strong>fecha</strong></td>
    </tr>
<% do while not rs.eof %>
    <tr>
        <td style="border-bottom:1px solid grey;" align="right" class="peq"><%= nn %></td>
        <td style="border-bottom:1px solid grey;" align="right"><%= rs("ops") %></td>
        <td style="border-bottom:1px solid grey;"></td>
        <td style="border-bottom:1px solid grey;"><a href="/admin/limites_accesos.asp?email=<%= rs("licencia") %>&fecha=<%= rs("fecha") %>"><%= rs("licencia") %></a></td>
        <td style="border-bottom:1px solid grey;"><%= rs("fecha") %></td>
    </tr>
    <% rs.movenext
	nn = nn+1
loop 
rs.close
%>
</table>

</div>
    </div>
    <div class="clear" style="height:10px;"></div>
</section>

</div>
</section>


</body>
</html>
<%
set rs = nothing
%>
<script language="javascript">
$(document).ready(function(){
	$("#fecha").DatePicker({
		format: 'd/m/Y',
		date: $('#fecha').val(),
		current: $('#fecha').val(),
		
		calendars: 1,
		starts: 1,
		//position: 'r',
		
		onBeforeShow: function(){
			$('#fecha').DatePickerSetDate($('#fecha').val(), true);
		},
		onChange: function(formated, dates){
			ant_date=$('#fecha').val();
			$('#fecha').val(formated);
			if (ant_date!=$('#fecha').val()) {
				$('#fecha').DatePickerHide();
				$('#frm').submit();
			}
		}
	});
});
</script>