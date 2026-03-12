<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% 
'if request.Cookies("dev")("request")<>"" then
	%><p>QueryString: &nbsp; <%
	for each elto in request.QueryString
		%><strong><%= elto %></strong>: <%= request.QueryString(elto) %>&nbsp; <%
	next
	%></p><%
	
	%><p>Form: &nbsp; <%
	for each elto in request.Form
		%><strong><%= elto %></strong>: <%= request.Form(elto) %>&nbsp; <%
	next
'end if 

Set rs = Server.CreateObject("ADODB.Recordset")

sql = "SELECT id_cliente, DATEPART(ww, fecha) AS ww, DATEADD(d, 1 - DATEPART(dw, fecha), fecha) AS wd, COUNT(id) AS articulos "
sql = sql & "FROM reg_articulos "
sql = sql & "WHERE (fecha>='05/01/2015') "
sql = sql & "GROUP BY id_cliente, DATEPART(ww, fecha), DATEADD(d, 1 - DATEPART(dw, fecha), fecha) "
'sql = sql & "ORDER BY id_cliente, DATEADD(d, 1 - DATEPART(dw, fecha), fecha)"

dim nombres(400)
dim fechas(45)
dim vals(400, 45)

'if request.Cookies("dev")("sql")<>"" then
	%><p class="peq"><%= sql %></p><%
'end if

'response.End()

rs.Open sql, session("connPWAcesos")

ww_max = 0
ww_min = 45

do while not rs.eof 
	fechas(rs("ww")) = rs("wd")
	nombres(rs("id_cliente")) = rs("id_cliente")
	vals(rs("id_cliente"), rs("ww")) = rs("articulos")
	
	if rs("ww")>ww_max then ww_max=rs("ww")
	if rs("ww")<ww_min then ww_min=rs("ww")
	
	rs.movenext
	
loop

rs.close 
set rs=nothing
%>

<table border="1" cellspacing="0" cellpadding="2">
<tr>
    <td>&nbsp;</td>
    <% for jj=ww_min to ww_max %>
    <td><%= fechas(jj) %></td>
    <% next %>
</tr>
<tr>
    <td>&nbsp;</td>
    <% for jj=ww_min to ww_max %>
    <td><%= jj %></td>
    <% next %>
</tr>
<%
for ii=0 to 400
	if nombres(ii)<>"" then %>
<tr>
    <td><%= ii %></td>
    <% for jj=ww_min to ww_max 
		if vals(ii, jj)="" then vals(ii, jj)=0
	%>
    <td><%= vals(ii, jj) %></td>
    <% next %>
</tr>
	<% end if
next
%>
</table>
<script type="text/javascript">
$(document).ready(function () {
	$('.yy_accesos').click(function(e) {
		var yy = this.getAttribute("href");
		$('#FechaI').val('01/01/' + yy);
		$('#FechaF').val('31/12/' + yy);
		
		$('#contador_accesos').html('');
		$('#tabData ul.resp-tabs-list li:nth-child(1)').click();
		
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
		
	});
	
	
})


</script>