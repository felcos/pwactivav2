<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- include virtual="/inc/js.asp" -->
<style>
.abierto {
	/* background-color:#CCC; */
	font-weight:bold;
	/* height:2em; 
	vertical-align:top; */
}
.meses {
	background-color:#EFEFEF;
}

.separador {
	height:3px;
}
</style>
<% 
if request.Cookies("dev")("request")<>"" then
	%><p>QueryString: &nbsp; <%
	for each elto in request.QueryString
		%><strong><%= elto %></strong>: <%= request.QueryString(elto) %>&nbsp; <%
	next
	%></p><%
	
	%><p>Form: &nbsp; <%
	for each elto in request.Form
		%><strong><%= elto %></strong>: <%= request.Form(elto) %>&nbsp; <%
	next
	%></p><hr />
    <% if 1=2 then %><p>connPWAcesos.CommandTimeout: <%= session("connPWAcesos").CommandTimeout %></p><hr /><% end if
end if 

cliente = request("u")
cliente_id = request("uid")
licencia = request("l")
licencia_id = request("lid")

yy = request("yy")
if yy = "" then yy = YEAR(DATE)

if cliente_id="" or cliente="" then
	%>sin datos<%
	response.End()
else
	sqlW = "reg_accesos.cookie_uid=" & cliente_id & " AND "
	sqlW = sqlW & "reg_accesos.cookie_u='" & cliente & "'"
end if

if licencia_id="" then
	if licencia<>"" then
		if sqlW<>"" then sqlW = sqlW & " AND "
		sqlW = sqlW & "reg_accesos.cookie_l='" & licencia & "'"
	end if
else
	if sqlW<>"" then sqlW = sqlW & " AND "
	sqlW = sqlW & "reg_accesos.cookie_lid=" & licencia_id
end if

sqlW = "(" & sqlW & ")"	

Set rs = Server.CreateObject("ADODB.Recordset")

IF 1=2 THEN

sql = "SELECT YEAR(reg_pags.date) AS yy, COUNT(reg_pags.id) AS pags, COUNT(DISTINCT reg_pags.session_id) AS sesiones "
sql = sql & "FROM reg_pags LEFT OUTER JOIN reg_accesos ON reg_pags.session_id = reg_accesos.session_id "
sql = sql & "WHERE (" & sqlW & ") "
sql = sql & "GROUP BY YEAR(reg_pags.date)"

if request.Cookies("dev")("sql")<>"" then
	%><p class="peq"><%= sql %></p><%
end if

'session("connPWAcesos").CommandTimeout = 120
rs.Open sql, session("connPWAcesos")
%>
<table class="reg" id="tabla" style="margin-bottom:24px;">
  <tr>
    <td width="60"><strong>a&ntilde;o</strong></td>
    <td><strong>sesiones</strong></td>
    <td><strong>p&aacute;ginas</strong></td>
  </tr>
<% do while not rs.eof %>
<tr>
	<td class="dra" width="50"><strong><a href="<%= rs("yy") %>" class="yy_accesos"><%= rs("yy") %></a></strong></td>
    <td class="dra"><%= FormatNumber(rs("sesiones"), 0) %></td>
    <td class="dra"><%= FormatNumber(rs("pags"), 0) %></td>
</tr>
		<% 
		rs.movenext
	loop
	%>
</table>
<%
rs.close 

END IF 
%>
<%
sql = "SELECT YEAR(reg_articulos.fecha) AS yy, MONTH(reg_articulos.fecha) AS mm, reg_articulos.articulo_tipo, COUNT(reg_articulos.articulo_id) AS articulos "
sql = sql & "FROM reg_articulos LEFT OUTER JOIN reg_accesos ON reg_articulos.session_id = reg_accesos.session_id "
sql = sql & "WHERE (" & sqlW & ") "
sql = sql & "GROUP BY YEAR(reg_articulos.fecha), MONTH(reg_articulos.fecha), reg_articulos.articulo_tipo "
sql = sql & "ORDER BY YEAR(reg_articulos.fecha), MONTH(reg_articulos.fecha)"

rs.Open sql, session("connPWAcesos")

dim years()
dim months()
dim noticias()
dim rumores()
dim estudios()
dim operaciones()
dim subastas()
dim demandas()
dim vencimientos()


'years(0) = act_yy

if rs.eof then
	%><p><strong>Sin Art&iacute;culos</strong></p><%
else
	'min_mm = rs("mm")
	nn = 0
	'act_mm = rs("mm")
	do while not rs.eof
		if act_yy<>rs("yy") or act_mm<>rs("mm") then
			act_yy = rs("yy")
			act_mm = rs("mm")
			nn = nn+1
			redim preserve years(nn+1)
			redim preserve months(nn+1)
			redim preserve noticias(nn+1)
			redim preserve rumores(nn+1)
			redim preserve estudios(nn+1)
			redim preserve operaciones(nn+1)
			redim preserve subastas(nn+1)
			redim preserve demandas(nn+1)
			redim preserve vencimientos(nn+1)
			
			years(nn) = rs("yy")
			months(nn) = rs("mm")
			
			noticias(nn)=0
			rumores(nn)=0
			estudios(nn)=0
			operaciones(nn)=0
			subastas(nn)=0
			demandas(nn)=0
			vencimientos(nn)=0

		end if
		
		'valores
		select case rs("articulo_tipo")
		case "not"
			noticias(nn)=rs("articulos")
		case "rum"
			rumores(nn)=rs("articulos")
		case "est"
			estudios(nn)=rs("articulos")
		case "ope"
			operaciones(nn)=rs("articulos")
		case "sub"
			subastas(nn)=rs("articulos")
		case "dem"
			demandas(nn)=rs("articulos")
		case "ven"
			vencimientos(nn)=rs("articulos")
		end select
		
		rs.movenext
	loop
	max_mm = act_mm
%>
<p><strong><a href="*" class="yy_articulos">Art&iacute;culos</a></strong></p>
<% if request.Cookies("dev")("sql")<>"" then %>
	<p class="peq"><%= sql %></p>
<% end if %>
<table border="0" class="reg" style="margin-bottom:12px;">
    <tr>
        <th width="115">Fecha</th>
        <th width="5"></th>
        <th width="45">Not.</th>
        <th width="45">Rum.</th>
        <th width="45">Est.</th>
        <th width="45">Oper.</th>
        <th width="45">Venc.</th>
        <th width="45">Dem.</th>
        <th width="45">Sub.</th>
        <th width="5"></th>
        <th width="50">Total</th>
    </tr>
<% 
yy_noticias=0
yy_rumores=0
yy_estudios=0
yy_operaciones=0
yy_vencimientos=0
yy_subastas=0
yy_demandas=0
primero = true
mostrado_resumen = false

for ii=nn to 1 step -1 
	yy_noticias = yy_noticias + noticias(ii)
	yy_rumores = yy_rumores + rumores(ii)
	yy_estudios = yy_estudios + estudios(ii)
	yy_operaciones = yy_operaciones + operaciones(ii)
	yy_vencimientos = yy_vencimientos + vencimientos(ii)
	yy_subastas = yy_subastas + subastas(ii)
	yy_demandas = yy_demandas + demandas(ii)
	%>
    <% if primero then %><tr class="separador<%= years(ii) %> separador" style="display:none;"><td colspan="11"></td></tr><% end if %>
    
    <tr class="meses<%= years(ii) %> meses" style="display:none;">
        <td> &nbsp; <a href="<%= years(ii) %>-<%= months(ii) %>" class="detalles_mm"><%= monthname(months(ii)) %> &nbsp; <span class="peq"><%= years(ii) %></span></a></td>
        <td></td>
        <td class="dra"><%= FormatNumber(noticias(ii), 0) %></td>
        <td class="dra"><%= FormatNumber(rumores(ii), 0) %></td>
        <td class="dra"><%= FormatNumber(estudios(ii), 0) %></td>
        <td class="dra"><%= FormatNumber(operaciones(ii), 0) %></td>
        <td class="dra"><%= FormatNumber(vencimientos(ii), 0) %></td>
        <td class="dra"><%= FormatNumber(demandas(ii), 0) %></td>
        <td class="dra"><%= FormatNumber(subastas(ii), 0) %></td>
        <td></td>
        <td class="dra"><strong><%= FormatNumber(noticias(ii)+rumores(ii)+estudios(ii)+operaciones(ii)+vencimientos(ii)+demandas(ii)+subastas(ii), 0) %></strong></td>
    </tr>
	<% 
	primero = false
	
	if months(ii)=1 then 
		mostrado_resumen = true %>
  <tr id="yy<%= years(ii) %>" class="years">
        <td><a href="<%= years(ii) %>" class="meses_show" id="meses_show_<%= years(ii) %>"><%= years(ii) %></a></td>
      	<td></td>
        <td class="dra"><%= FormatNumber(yy_noticias, 0) %></td>
        <td class="dra"><%= FormatNumber(yy_rumores, 0) %></td>
        <td class="dra"><%= FormatNumber(yy_estudios, 0) %></td>
        <td class="dra"><%= FormatNumber(yy_operaciones, 0) %></td>
        <td class="dra"><%= FormatNumber(yy_vencimientos, 0) %></td>
        <td class="dra"><%= FormatNumber(yy_demandas, 0) %></td>
        <td class="dra"><%= FormatNumber(yy_subastas, 0) %></td>
        <td></td>
        <td class="dra"><strong><%= FormatNumber(yy_noticias+yy_rumores+yy_estudios+yy_operaciones+yy_vencimientos+yy_demandas+yy_subastas, 0) %></strong></td>
    </tr>
  <tr class="separador<%= years(ii) %>" style="display:none;" height="10px;"><td colspan="11"></td></tr>
    	<% 
		primero = true
		yy_noticias=0
		yy_rumores=0
		yy_estudios=0
		yy_operaciones=0
		yy_vencimientos=0
		yy_subastas=0
		yy_demandas=0
	end if
	
next %>
<% if not mostrado_resumen then %>
  <tr id="yy<%= years(1) %>" class="years">
        <td><a href="<%= years(1) %>" class="meses_show" id="meses_show_<%= years(1) %>"><%= years(1) %></a></td>
      	<td></td>
        <td class="dra"><%= FormatNumber(yy_noticias, 0) %></td>
        <td class="dra"><%= FormatNumber(yy_rumores, 0) %></td>
        <td class="dra"><%= FormatNumber(yy_estudios, 0) %></td>
        <td class="dra"><%= FormatNumber(yy_operaciones, 0) %></td>
        <td class="dra"><%= FormatNumber(yy_vencimientos, 0) %></td>
        <td class="dra"><%= FormatNumber(yy_demandas, 0) %></td>
        <td class="dra"><%= FormatNumber(yy_subastas, 0) %></td>
        <td></td>
        <td class="dra"><strong><%= FormatNumber(yy_noticias+yy_rumores+yy_estudios+yy_operaciones+yy_vencimientos+yy_demandas+yy_subastas, 0) %></strong></td>
    </tr>
  <tr class="separador<%= years(1) %>" style="display:none;" height="10px;"><td colspan="11"></td></tr>
<% end if %>
</table>
<% end if	'eof

rs.close
set rs=nothing
%>
<script type="text/javascript">
$(document).ready(function(){
	var t = $('#tabla tbody').eq(0);
	var r = t.find('tr');
	var cols= r.length;
	var rows= r.eq(0).find('td').length;
	var cell, next, tem, i = 0;
	var tb= $('<tbody></tbody>');
	
	while(i<rows){
		cell= 0;
		tem= $('<tr></tr>');
		while(cell<cols){
			next= r.eq(cell++).find('td').eq(0);
			tem.append(next);
		}
		tb.append(tem);
		++i;
	};
	
	$('#tabla').append(tb);
	$('#tabla').show();
});

$(document).ready(function () {
	$(".meses_show").click(function(e) {
		var filas = ".meses" + this.getAttribute("href");
		var yy = "#yy" + this.getAttribute("href");
		var separadores = ".separador" + this.getAttribute("href");
		//$(".meses").hide();
		//$(".years").removeClass("abierto");
		
		$(filas).toggle("fast");
		$(separadores).toggle("fast");
		$(yy).toggleClass("abierto");
		
		//$(yy). .toggle("slow");
		
		return false;
	})
	
	$(".meses_hide").click(function(e) {
		var filas = ".meses" + this.getAttribute("href");
		var yy = "#yy" + this.getAttribute("href");
		
		
		$(".meses").hide();
		$(".years").removeClass("abierto");
		
		$(filas).toggle("fast");
		$(yy).toggleClass("abierto");
		
		//$(yy). .toggle("slow");
		
		return false;
	})
	
	$("#meses_show_2015").click();
	
	$('.detalles_mm').click(function(e) {
		var href = this.getAttribute("href");
		var yy = href.substring(0,4);
		var mm = href.substring(5);
		
		if (mm<9) {
			mmm = "0" + mm.toString()
		} else {
			mmm = mm.toString()
		}
		
		if (mm<12) {
			nm = mm
		} else {
			nm = 0
		}
		
		var fecha = new Date()
		fecha.setFullYear(yy, nm, 1);		
		fecha.setDate(fecha.getDate()-1);
		
		//console.log(fecha);
		//console.log(fecha.getDate());
		
		$('#FechaI').val('01/' + mmm + '/' + yy);
		$('#FechaF').val(fecha.getDate() + '/' + mmm + '/' + yy);
		
		$('#frm_detalles').submit();
		/*
		$('#contador_accesos').html('');
		*/
		$('#tabData ul.resp-tabs-list li:nth-child(2)').click();
		
		
		/*
		$.ajax({
			url: '/admin/accesos/ip/reg.asp',
			data: $('#frm_accesos').serialize(),
			beforeSend: function() {
				$('#loading_reg').show();
				$('#result_reg').html('');
			},
			success: function(data, status, xhr){
				$('#result_reg').html(data);
				$('#loading_reg').hide();
			},
			error: function(xhr, status, err) {}
		});
		*/
		/*
		$.ajax({
			url: '/admin/accesos/cliente/accesos.asp',
			data: $('#frm_accesos').serialize(),
			beforeSend: function() {
				$('#loading_accesos').show();
				$('#result_accesos').html('');
			},
			success: function(data, status, xhr){
				$('#result_accesos').html(data);
				$('#loading_accesos').hide();
			},
			error: function(xhr, status, err) {}
		});
		*/
		return false;
	});
	
	$('.yy_articulos_').click(function(e) {
		var yy = this.getAttribute("href");
		if (yy=='*') {
			$('#FechaI').val('');
			$('#FechaF').val('');
		} else {
			$('#FechaI').val('01/01/' + yy);
			$('#FechaF').val('31/12/' + yy);
		}
		
		$('#contador_articulos').html('');
		$('#tabData ul.resp-tabs-list li:nth-child(2)').click();
		
		$.ajax({
			url: '/admin/accesos/cliente/articulos.asp',
			data: $('#frm_accesos').serialize(),
			beforeSend: function() {
				$('#loading_articulos').show();
				$('#result_articulos').html('');
			},
			success: function(data, status, xhr){
				$('#result_articulos').html(data);
				$('#loading_articulos').hide();
			},
			error: function(xhr, status, err) {}
		});
		
		return false;
	});
})


</script>