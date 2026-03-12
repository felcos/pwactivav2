<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
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
	%></p><hr /><%
end if

ip = request.QueryString("ip")
if ip="" then response.End()

Set rs = Server.CreateObject("ADODB.Recordset")

sql = "SELECT YEAR(reg_pags.date) AS yy, COUNT(reg_pags.id) AS pags, COUNT(DISTINCT reg_pags.session_id) AS sesiones "
sql = sql & "FROM reg_pags LEFT OUTER JOIN reg_accesos ON reg_pags.session_id = reg_accesos.session_id "
sql = sql & "WHERE (reg_accesos.remote_host = '" & ip & "') "
sql = sql & "GROUP BY YEAR(reg_pags.date)"

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
%>

<%
sql = "SELECT YEAR(reg_articulos.fecha) AS yy, reg_articulos.articulo_tipo, COUNT(reg_articulos.articulo_id) AS articulos "
sql = sql & "FROM reg_articulos LEFT OUTER JOIN reg_accesos ON reg_articulos.session_id = reg_accesos.session_id "
sql = sql & "WHERE (reg_accesos.remote_host = '" & ip & "') "
sql = sql & "GROUP BY YEAR(reg_articulos.fecha), reg_articulos.articulo_tipo "
sql = sql & "ORDER BY YEAR(reg_articulos.fecha)"

rs.Open sql, session("connPWAcesos")

dim years()
dim noticas()
dim rumores()
dim estudios()
dim operaciones()
dim subastas()
dim demandas()
dim vencimientos()

nn = 0

'years(0) = act_yy

if rs.eof then
	%><p><strong>Sin Art&iacute;culos consultados</strong></p><%
else
	act_yy = rs("yy")
	min_yy = act_yy

	for yy=min_yy to 2015
		redim preserve years(nn+1)
		redim preserve noticias(nn+1)
		redim preserve rumores(nn+1)
		redim preserve estudios(nn+1)
		redim preserve operaciones(nn+1)
		redim preserve subastas(nn+1)
		redim preserve demandas(nn+1)
		redim preserve vencimientos(nn+1)
		
		years(nn)=rs("yy")
		
		noticias(nn)=0
		rumores(nn)=0
		estudios(nn)=0
		operaciones(nn)=0
		subastas(nn)=0
		demandas(nn)=0
		vencimientos(nn)=0
		
		do while yy=rs("yy")
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
			
			if rs.eof then 
				max_yy=yy
				exit do
			end if
		loop
		
		nn=nn+1
	next
%>
	<p><strong><a href="*" class="yy_articulos">Art&iacute;culos</a></strong></p>
    <table border="0" class="reg" style="margin-bottom:12px;">
        <tr>
            <th width="30">A&ntilde;o</th>
            <th width="10"></th>
            <th width="50">Noticias</th>
            <th width="50">Rum.</th>
            <th width="50">Operac.</th>
            <th width="50">Estudios</th>
            <th width="50">Demand.</th>
            <th width="50">Subast</th>
            <th width="50">Vencim.</th>
            <th width="5"></th>
            <th width="50">Total</th>
        </tr>
	<% for ii=0 to (max_yy-min_yy) %>
        <tr>
            <td class="dra"><strong><a href="<%= years(ii) %>" class="yy_articulos"><%= years(ii) %></a></strong></td>
            <td></td>
            
            <td class="dra"><%= FormatNumber(noticias(ii), 0) %></td>
            <td class="dra"><%= FormatNumber(rumores(ii), 0) %></td>
            <td class="dra"><%= FormatNumber(operaciones(ii), 0) %></td>
            <td class="dra"><%= FormatNumber(estudios(ii), 0) %></td>
            <td class="dra"><%= FormatNumber(demandas(ii), 0) %></td>
            <td class="dra"><%= FormatNumber(subastas(ii), 0) %></td>
            <td class="dra"><%= FormatNumber(vencimientos(ii), 0) %></td>
            
            <td></td>
            <td class="dra"><strong><%= FormatNumber(noticias(ii)+rumores(ii)+operaciones(ii)+estudios(ii)+demandas(ii)+subastas(ii)+vencimientos(ii), 0) %></strong></td>
        </tr>
    <% next %>
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
	$('.yy_accesos').click(function(e) {
		var yy = this.getAttribute("href");
		$('#FechaI').val('01/01/' + yy);
		$('#FechaF').val('31/12/' + yy);
		
		$('#contador_accesos').html('');
		$('#tabData ul.resp-tabs-list li:nth-child(3)').click();
		
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
		
		$.ajax({
			url: '/admin/accesos/ip/accesos.asp',
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
	
		return false;
	});
	
	$('.yy_articulos').click(function(e) {
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
			url: '/admin/accesos/ip/articulos.asp',
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