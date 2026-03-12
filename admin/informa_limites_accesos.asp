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
    <link href="/_inc/foldy/foldy.css" rel="stylesheet" type="text/css">
</head>
<%
set rs = Server.CreateObject("ADODB.Recordset")
%>
<body>
<section id="content">
<div class="contenedor">
<li><%= request.QueryString("email") %></li>
<li><%= session("pw_ws").login %></li>
<p>session(bloqueos): <%= session("bloqueos") %></p>
<% 
	rFecha = date
	rEmail = request.QueryString("email")
	
	if rEmail = "" then rEmail = request.Cookies("licencia")("n")
	
	'contadores
	dim tmpContador(5, 2)
	dim tmpVenc
	
	for ii=0 to 4	
		for jj=0 to 1
			tmpContador(ii, jj)=0
		next
	next
	
	'recuento por accesos, sólo vencimientos
	sql = "SELECT COUNT(DISTINCT(articulo_id)) AS nn FROM reg_articulos WHERE articulo_tipo = 'ven' AND "
	sql = sql & "licencia = '" & rEmail & "' AND "
	sql = sql & "fecha = '" & rFecha & "' "
	'sql = sql & "GROUP BY ARTICULO_TIP"
	response.Write(sql)
	response.Write("<hr>")
	rs.open sql, session("connPWAcesos")
	tmpVenc = rs("nn")
	rs.close
	
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
			if instr(rs("seccion"), "OFICINAS") then 
				nn=1
				tmpContador(nn, mm) = tmpContador(nn, mm)+1
			end if
			if instr(rs("seccion"), "LOCALES") then 
				nn=2
				tmpContador(nn, mm) = tmpContador(nn, mm)+1
			end if
			
			if instr(rs("seccion"), "HOTELES") then 
				nn=3
				tmpContador(nn, mm) = tmpContador(nn, mm)+1
			end if
			
			if instr(rs("seccion"), "NAVES") then 
				nn=4
				tmpContador(nn, mm) = tmpContador(nn, mm)+1

			end if
			if nn<0 then
				tmpContador(0, mm) = tmpContador(0, mm)+1
			end if			
		rs.movenext
		loop
		
		rs.close
	end if	'ids<>""
	
	'alerta(s)
	alerta = false
	
	'oficinas
	'if tmpContador(1,0)>=LimitesOps(1,0) then call Avisar("oficinas inversion", rEmail, rFecha)
	'if tmpContador(1,1)>=LimitesOps(1,1) then call Avisar("oficinas alquiler", rEmail, rFecha)
	
	'locales
	'if tmpContador(2,0)>=LimitesOps(2,0) then call Avisar("locales inversion", rEmail, rFecha)
	'if tmpContador(2,1)>=LimitesOps(2,1) then call Avisar("locales alquiler", rEmail, rFecha)
	
	'hoteles
	'if tmpContador(3,0)>=LimitesOps(3,0) then call Avisar("hoteles inversion", rEmail, rFecha)
	'if tmpContador(3,1)>=LimitesOps(3,1) then call Avisar("hoteles alquiler", rEmail, rFecha)
	
	'naves
	'if tmpContador(4,0)>=LimitesOps(4,0) then call Avisar("naves inversion", rEmail, rFecha)
	'if tmpContador(4,1)>=LimitesOps(4,1) then call Avisar("naves alquiler", rEmail, rFecha)
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
    
    <td align="right"<% if tmpContador(1, 0)>=LimitesOps(1, 0) then %> class="txtRojo"<% end if %> width="60"><%= tmpContador(1, 0) %></td>
    <td width="60"><span class="peq" style="padding-left:20px;">max. <%= LimitesOps(1, 0) %></span></td>
    <td align="right"<% if tmpContador(1, 1)>=LimitesOps(1, 1) then %> class="txtRojo"<% end if %> width="60"><%= tmpContador(1, 1) %></td>
    <td width="60"><span class="peq" style="padding-left:20px;">max. <%= LimitesOps(1, 1) %></span></td>
  </tr>
  <tr>
    <td>locales</td>
    <td bgcolor="#CCCCCC">4</td>
    <td align="right"<% if tmpContador(2, 0)>=LimitesOps(2, 0) then %> class="txtRojo"<% end if %>><%= tmpContador(2, 0) %></td>
    <td width="60"><span class="peq" style="padding-left:20px;">max. <%= LimitesOps(2, 0) %></span></td>
    <td align="right"<% if tmpContador(2, 1)>=LimitesOps(2, 1) then %> class="txtRojo"<% end if %>><%= tmpContador(2, 1) %></td>
    <td width="60"><span class="peq" style="padding-left:20px;">max. <%= LimitesOps(2, 1) %></span></td>
  </tr>
  <tr>
    <td>hoteles</td>
    <td bgcolor="#CCCCCC">2</td>
    <td align="right"<% if tmpContador(3, 0)>=LimitesOps(3 ,0) then %> class="txtRojo"<% end if %>><%= tmpContador(3, 0) %></td>
    <td width="60"><span class="peq" style="padding-left:20px;">max. <%= LimitesOps(3, 0) %></span></td>
    <td align="right"<% if tmpContador(3, 1)>=LimitesOps(3, 1) then %> class="txtRojo"<% end if %>><%= tmpContador(3, 1) %></td>
    <td width="60"><span class="peq" style="padding-left:20px;">max. <%= LimitesOps(3, 1) %></span></td>
  </tr>
  <tr>
    <td>naves</td>
    <td bgcolor="#CCCCCC">3</td>
    <td align="right"<% if tmpContador(4, 0)>=LimitesOps(4, 0) then %> class="txtRojo"<% end if %>><%= tmpContador(4, 0) %></td>
    <td width="60"><span class="peq" style="padding-left:20px;">max. <%= LimitesOps(4, 0) %></span></td>
    <td align="right"<% if tmpContador(4, 1)>=LimitesOps(4, 1) then %> class="txtRojo"<% end if %>><%= tmpContador(4, 1) %></td>
    <td width="60"><span class="peq" style="padding-left:20px;">max. <%= LimitesOps(4, 1) %></span></td>
  </tr>
  <tr>
    <td>resto</td>
    <td bgcolor="#CCCCCC">&nbsp;</td>
    <td bgcolor="#CCCCCC" align="right"><%= tmpContador(0, 0) %></td>
    <td bgcolor="#CCCCCC"></td>
    <td bgcolor="#CCCCCC" align="right"><%= tmpContador(0, 1) %></td>
    <td bgcolor="#CCCCCC"></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td>vencim.</td>
    <td>&nbsp;</td>
    <td align="right"><%= tmpVenc %></td>
    <td><span class="peq" style="padding-left:20px;">max. <%= LimitesVenc %></span></td>
    <td align="right">&nbsp;</td>
    <td><%= tmpVenc>=LimitesVenc %></td>
  </tr>
</table>

</div>
</section>
</body>
</html>
<%
set rs = nothing
%>