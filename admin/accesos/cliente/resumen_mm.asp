<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% 
'if request.Cookies("dev")("request")<>"" then
if 1=2 then
	%><p>QueryString: &nbsp; <%
	for each elto in request.QueryString
		%><strong><%= elto %></strong>: <%= request.QueryString(elto) %>&nbsp; <%
	next
	%></p><%
	
	%><p>Form: &nbsp; <%
	for each elto in request.Form
		%><strong><%= elto %></strong>: <%= request.Form(elto) %>&nbsp; <%
	next
	%></p><% 
end if 

cliente = request("u")
cliente_id = request("uid")
licencia = request("l")
licencia_id = request("lid")

yy = request("y")
'if yy = "" then yy = YEAR(DATE)

if cliente_id="" or cliente="" OR yy="" then
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

fini = cdate("01/01/" & yy)
ffin = cdate("31/12/" & yy)
sqlW = sqlW & " AND (fecha>='" & fini & "' AND fecha<='" & ffin & "')"

sqlW = "(" & sqlW & ")"

Set rs = Server.CreateObject("ADODB.Recordset")

sql = "SELECT MONTH(reg_articulos.fecha) AS mm, reg_articulos.articulo_tipo, COUNT(reg_articulos.articulo_id) AS articulos "
sql = sql & "FROM reg_articulos LEFT OUTER JOIN reg_accesos ON reg_articulos.session_id = reg_accesos.session_id "
sql = sql & "WHERE " & sqlW 
sql = sql & " GROUP BY MONTH(reg_articulos.fecha), reg_articulos.articulo_tipo "
sql = sql & " ORDER BY MONTH(reg_articulos.fecha)"

response.Write(sql)
response.End()

rs.Open sql, session("connPWAcesos")

dim meses()

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
	min_mm = rs("mm")
	nn = 0
	'act_yy = rs("yy")
	do while not rs.eof
		if act_mm <> rs("mm") then
			act_mm = rs("mm")
			nn = nn+1
			redim preserve months(nn+1)
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
			
			months(nn)=rs("mm")
			
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
	max_mm = act_mm
%>
<% if 1=2 then
'if request.Cookies("dev")("sql")<>"" then %>
	<p class="peq"><%= sql %></p>
<% end if %>
<table width="100%" border="0" class="reg" style="margin-bottom:12px; background-color:#FAFAFA;">
<% if 1=2 then %>
<tr>
    <th>Mes</th>
    <th></th>
    <th>Not.</th>
    <th>Rum.</th>
    <th>Ope.</th>
    <th>Est.</th>
    <th>Dem.</th>
    <th>Sub.</th>
    <th>Ven.</th>
    <th></th>
    <th>Inm.</th>
    <th>Dir.</th>
    <th>Empr.</th>
    <th></th>
    <th>Total</th>
</tr>
<% end if %>
<% for ii=(max_mm-min_mm+1) to 1 step -1
	if months(ii)<>"" then %>
    <tr>
        <td style="padding-left:20px;"><a href="javascript:mm_ver(<%= yy %>, <%= months(ii) %>)"><%= monthname(months(ii)) %></a></td>
        <td style="width:11px;"></td>
        <td style="width:45px;" class="dra"><%= FormatNumber(noticias(ii), 0) %></td>
        <td style="width:43px;" class="dra"><%= FormatNumber(rumores(ii), 0) %></td>
        <td style="width:48px;" class="dra"><%= FormatNumber(operaciones(ii), 0) %></td>
        <td style="width:43px;" class="dra"><%= FormatNumber(estudios(ii), 0) %></td>
        <td style="width:44px;" class="dra"><%= FormatNumber(demandas(ii), 0) %></td>
        <td style="width:43px;" class="dra"><%= FormatNumber(subastas(ii), 0) %></td>
        <td style="width:44px;" class="dra"><%= FormatNumber(vencimientos(ii), 0) %></td>
        <td style="width:10px;"></td>
        <td style="width:43px;" class="dra"><%= FormatNumber(inmuebles(ii), 0) %></td>
        <td style="width:44px;" class="dra"><%= FormatNumber(direcciones(ii), 0) %></td>
        <td style="width:43px;" class="dra"><%= FormatNumber(empresas(ii), 0) %></td>
        <td style="width:10px;"></td>
        <td style="width:52px;" class="dra"><strong><%= FormatNumber(noticias(ii)+rumores(ii)+operaciones(ii)+estudios(ii)+demandas(ii)+subastas(ii)+vencimientos(ii)+inmuebles(ii)+direcciones(ii)+empresas(ii), 0) %></strong></td>
    </tr>
	<% end if
next %>
</table>
<% end if	'eof
rs.close
set rs=nothing
%>
<script type="text/javascript">
function mm_ver(yy, mm) {
	var mi = mm;
	if (mi<10) {mi = '0' + mi};
	
	$('#FechaI').val('01/' + mi + '/' + yy);
	
	var fechaf = new Date(yy, mm, 0);
	
	var df = fechaf.getDate();
	var mf = fechaf.getMonth()+1;
	if (mf<10) {mf = '0' + mf};
	var yf = fechaf.getFullYear();
	
	$('#FechaF').val(df + '/' + mf + '/' + yf);
	
	$('#contador_articulos').html('');
	$('#frm_detalles').submit();
	
	$('#tabData ul.resp-tabs-list li:nth-child(2)').click();
	
}


</script>