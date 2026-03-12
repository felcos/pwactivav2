<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
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
    <% if 1=2 then %><p>cnxAccesos.CommandTimeout: <%= session("cnxAccesos").CommandTimeout %></p><hr /><% end if
end if 

cliente = request("u")
cliente_id = request("uid")
licencia = request("l")
licencia_id = request("lid")

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

sql = "SELECT YEAR(reg_articulos.fecha) AS yy, reg_articulos.articulo_tipo, COUNT(reg_articulos.articulo_id) AS articulos "
sql = sql & "FROM reg_articulos LEFT OUTER JOIN reg_accesos ON reg_articulos.session_id = reg_accesos.session_id "
sql = sql & "WHERE (" & sqlW & ") "
sql = sql & "GROUP BY YEAR(reg_articulos.fecha), reg_articulos.articulo_tipo "
sql = sql & "ORDER BY YEAR(reg_articulos.fecha)"

rs.Open sql, session("connPWAcesos")

dim years()

dim noticias()
dim rumores()
dim estudios()
dim operaciones()
dim subastas()
dim demandas()
dim vencimientos()

dim empresas()
dim inmuebles()
dim direcciones()

'years(0) = act_yy

if rs.eof then
	%><p><strong>Sin Art&iacute;culos</strong></p><%
else
	min_yy = rs("yy")
	nn = 0
	'act_yy = rs("yy")
	do while not rs.eof
		if act_yy <> rs("yy") then
			act_yy = rs("yy")
			nn = nn+1
			redim preserve years(nn+1)
			redim preserve noticias(nn+1)
			redim preserve rumores(nn+1)
			redim preserve estudios(nn+1)
			redim preserve operaciones(nn+1)
			redim preserve subastas(nn+1)
			redim preserve demandas(nn+1)
			redim preserve vencimientos(nn+1)
			redim preserve empresas(nn+1)
			redim preserve inmuebles(nn+1)
			redim preserve direcciones(nn+1)
			
			years(nn)=rs("yy")
			
			noticias(nn)=0
			rumores(nn)=0
			estudios(nn)=0
			operaciones(nn)=0
			subastas(nn)=0
			demandas(nn)=0
			vencimientos(nn)=0
			empresas(nn)=0
			inmuebles(nn)=0
			direcciones(nn)=0
			
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
		case "empr"
			empresas(nn)=rs("articulos")
		case "inm"
			inmuebles(nn)=rs("articulos")
		case "dir", "zona"
			direcciones(nn)=rs("articulos")
		end select
		
		rs.movenext
	loop
	max_yy = act_yy
%>
<p><strong><a href="*" class="yy_articulos">Art&iacute;culos</a></strong></p>
<% if request.Cookies("dev")("sql")<>"" then %>
	<p class="peq"><%= sql %></p>
<% end if %>
<table border="0" class="reg" style="margin-bottom:12px;">
    <tr>
        <th style="width:100px;">A&ntilde;o</th>
        <th style="width:15px;"></th>
        <th style="width:60px;">Not.</th>
        <th style="width:60px;">Rum.</th>
        <th style="width:60px;">Ops.</th>
        <th style="width:60px;">Est.</th>
        <th style="width:60px;">Dem.</th>
        <th style="width:60px;">Sub.</th>
        <th style="width:60px;">Ven.</th>
        <th style="width:15px;"></th>
        <th style="width:60px;">Inm.</th>
        <th style="width:60px;">Dir.</th>
        <th style="width:60px;">Empr.</th>
        <th style="width:15px;"></th>
        <th style="width:65px;">Tot</th>
    </tr>
<% for ii=nn to 1 step -1 '??? %>
    <tr id="yy<%= years(ii) %>">
        <td><strong><a href="<%= years(ii) %>" class="yy_ver" <% if years(ii)=2015 then %>id="yy_actual"<% end if %>><%= years(ii) %></a></strong></td>
        <td></td>
        <td class="dra"><%= FormatNumber(noticias(ii), 0) %></td>
        <td class="dra"><%= FormatNumber(rumores(ii), 0) %></td>
        <td class="dra"><%= FormatNumber(operaciones(ii), 0) %></td>
        <td class="dra"><%= FormatNumber(estudios(ii), 0) %></td>
        <td class="dra"><%= FormatNumber(demandas(ii), 0) %></td>
        <td class="dra"><%= FormatNumber(subastas(ii), 0) %></td>
        <td class="dra"><%= FormatNumber(vencimientos(ii), 0) %></td>
        <td></td>
        <td class="dra"><%= FormatNumber(inmuebles(ii), 0) %></td>
        <td class="dra"><%= FormatNumber(direcciones(ii), 0) %></td>
        <td class="dra"><%= FormatNumber(empresas(ii), 0) %></td>
        <td></td>
        <td class="dra"><strong><%= FormatNumber(noticias(ii)+rumores(ii)+operaciones(ii)+estudios(ii)+demandas(ii)+subastas(ii)+vencimientos(ii)+inmuebles(ii)+direcciones(ii)+empresas(ii), 0) %></strong></td>
    </tr>
    <tr><td colspan="15" style="padding:0; margin:0; border:0; display:none; min-height:20px;" id="datos<%= years(ii) %>"></td></tr>
<% next %>
</table>
<% end if	'eof
rs.close
set rs=nothing
%>
<script type="text/javascript">
$(document).ready(function () {
	$(".yy_ver").click(function(e) {
		
		var yy = this.getAttribute("href");
		
		var tr = $("#yy"+yy);
		var td = $("#datos"+yy);

		if (td.html()=="") {
			$.ajax({
				url: "/admin/accesos/cliente/resumen_mm.asp",
				data: $("#frm_general").serialize() + "&y="+yy,
				beforeSend: function() {},
				success: function(data, status, xhr){
					td.html(data);
					tr.toggleClass("abierto");
					td.toggle("fast");
				},
				error: function(xhr, status, err) {}
			});
		} else {
			tr.toggleClass("abierto");
			td.toggle("fast");
		}
		/*
		$('#contador_articulos').html('');
		$('#tabData ul.resp-tabs-list li:nth-child(2)').click();
		*/
		/*
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
		*/
		return false;
	});
	
	$("#yy_actual").click();
	
})


</script>