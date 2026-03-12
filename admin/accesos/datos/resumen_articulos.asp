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

Set rs = Server.CreateObject("ADODB.Recordset")

FechaI = request("FechaI")
FechaF = request("FechaF")
if FechaF="" then 
	FechaF = DateAdd("d", 1, FechaI)
else
	FechaF = DateAdd("d", 1, FechaF)
end if

sqlW = ""
select case request.Form("ver")
case "conlicencia"
	sqlW = "cliente_id IS NOT NULL"
case "sinlicencia"
	sqlW = "cliente_id IS NULL"
end select

if sqlW<>"" then sqlW = " AND (" & sqlW & ")"
sqlW = "(session_start>='" & FechaI & "' AND session_start<'" & FechaF & "')" & sqlW

sql = "SELECT CONVERT(VARCHAR(24), reg_accesos.session_start, 103) AS fecha, reg_articulos.articulo_tipo, COUNT(reg_articulos.articulo_id) AS articulos "
sql = sql & "FROM reg_articulos LEFT OUTER JOIN reg_accesos ON reg_articulos.session_id = reg_accesos.session_id "
sql = sql & "WHERE (" & sqlW & ") "
sql = sql & "GROUP BY CONVERT(VARCHAR(24), reg_accesos.session_start, 103), reg_articulos.articulo_tipo "
sql = sql & "ORDER BY CONVERT(VARCHAR(24), reg_accesos.session_start, 103)"

if request.Cookies("dev")("sql")<>"" then
	%><p class="peq"><%= sql %></p><%
end if

rs.Open sql, session("connPWAcesos")

dim fechas()
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
	'act_dd = rs("yy")
	'min_dd = act_yy

	for dd=FechaI to FechaF
		redim preserve fechas(nn+1)
		redim preserve noticias(nn+1)
		redim preserve rumores(nn+1)
		redim preserve estudios(nn+1)
		redim preserve operaciones(nn+1)
		redim preserve subastas(nn+1)
		redim preserve demandas(nn+1)
		redim preserve vencimientos(nn+1)
		
		fechas(nn)=rs("fecha")
		
		noticias(nn)=0
		rumores(nn)=0
		estudios(nn)=0
		operaciones(nn)=0
		subastas(nn)=0
		demandas(nn)=0
		vencimientos(nn)=0
		
		do while dd=rs("fecha")
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
				'max_yy=yy
				exit do
			end if
		loop
		
		nn=nn+1
	next
%>
	<p><strong><a href="*" class="yy_articulos">Art&iacute;culos</a></strong> <%= DateDiff("d", FechaF, FechaI) %></p>
    <table border="0" class="reg" style="margin-bottom:12px;">
        <tr>
            <th width="30">Fecha</th>
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
	<% for ii=0 to DateDiff("d", FechaI, FechaF) 
		ff=DateAdd("d", ii, FechaI)
		%>
        <tr>
            <td class="dra"><strong><a href="<%= fechas(ii) %>" class="yy_articulos"><%= fechas(ii) %></a></strong></td>
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
/*
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
*/
$(document).ready(function () {
	
	$('.ff_accesos').click(function(e) {
		var ff = this.getAttribute("href");
		$('#FechaI').val(ff);
		$('#FechaF').val(ff);
		
		$('#contador_reg').html('');
		$('#tabData ul.resp-tabs-list li:nth-child(1)').click();
		
		$.ajax({
			url: '/admin/accesos/datos/reg.asp',
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
		
		/*
		$.ajax({
			url: '/admin/accesos/datos/accesos.asp',
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
			url: '/admin/accesos/datos/articulos.asp',
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