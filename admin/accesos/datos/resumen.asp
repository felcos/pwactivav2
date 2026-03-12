<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<style>
.separador {
	border-bottom:0px solid;
	height:12px;
}
table.reg, table.reg th, table.reg td {
	padding-left: 2px;
	padding-right: 2px;
	
	}
</style>
<% 
if request.Cookies("dev")("request")<>"" then
	if request.QueryString<>"" then
		%><p>QueryString: &nbsp; <%
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
end if

FechaI = request("FechaI")
if FechaI="" then
	FechaI = date
end if

FechaF = request("FechaF")
if FechaF="" then 
	FechaF = FechaI
end if

DiaI = FechaI
do while datepart("w", DiaI, 2)>1
	DiaI=DateAdd("d", -1, DiaI)
loop
weekI = Datepart("ww", DiaI, 2)

DiaF = FechaF
do while datepart("w", DiaF, 2)<7
	DiaF=DateAdd("d", 1, DiaF)
loop
'DiaF=DateAdd("d", -1, DiaF)
weekF = Datepart("ww", DiaF, 2) 

sems = DateDiff("ww", DiaI, DiaF)
dias = DateDiff("d", DiaI, DiaF)

IF 1=2 THEN %>
    <li>FechaI: <%= FechaI %> [<%= Datepart("ww", FechaI, 2) %>] [<%= WeekdayName(Datepart("w", FechaI)) %>] &gt;&gt; DiaI: <%= DiaI %> [<%= weekI %>] [<%= WeekdayName(Datepart("w", DiaI)) %>]</li>
    <li>FechaF: <%= FechaF %> [<%= Datepart("ww", FechaF, 2) %>] [<%= WeekdayName(Datepart("w", FechaF)) %>] &gt;&gt; DiaF: <%= DiaF %> [<%= weekF %>] [<%= WeekdayName(Datepart("w", DiaF)) %>]</li>
    <p>dias: <%= dias %> // sems: <%= sems %></p>
    <hr />
<% END IF

Set rs = Server.CreateObject("ADODB.Recordset")

dim valores()
redim valores(dias+1, 7)
for dd=0 to dias
	dia = DateAdd("d", dd, DiaI)
	valores(dd, 0) = dia
	valores(dd, 1) = Datepart("ww", dia, 2) 
	valores(dd, 2) = 0		'reg_accesos	con licencia
	valores(dd, 3) = 0		'reg_pags		con licencia
	valores(dd, 4) = 0		'reg_accesos	todos
	valores(dd, 5) = 0		'reg_pags		todos
	valores(dd, 6) = 0		'reg_articulos
next 

sql = "SELECT CONVERT(VARCHAR(24), reg_accesos.session_start, 103) AS fecha, COUNT(reg_pags.id) AS pags, COUNT(DISTINCT reg_accesos.session_id) AS sesiones "
sql = sql & "FROM reg_pags RIGHT OUTER JOIN reg_accesos ON reg_pags.session_id = reg_accesos.session_id "
sql = sql & "WHERE ((cookie_lid IS NOT NULL) AND (session_start>='" & DiaI & "' AND session_start<'" & dateadd("d", 1, DiaF) & "')) "
sql = sql & "GROUP BY CONVERT(VARCHAR(24), reg_accesos.session_start, 103) "
sql = sql & "ORDER BY CONVERT(VARCHAR(24), reg_accesos.session_start, 103) DESC"

if request.Cookies("dev")("sql")<>"" then
	%><p class="peq"><%= sql %></p><%
end if

rs.Open sql, session("connPWAcesos")
do while not rs.eof 
	dia = rs("fecha")
	dd = DateDiff("d", DiaI, dia)
	valores(dd, 2) = rs("sesiones")
	valores(dd, 4) = rs("pags")
	rs.movenext
loop
rs.close 


sql = "SELECT CONVERT(VARCHAR(24), reg_accesos.session_start, 103) AS fecha, COUNT(reg_pags.id) AS pags, COUNT(DISTINCT reg_accesos.session_id) AS sesiones "
sql = sql & "FROM reg_pags RIGHT OUTER JOIN reg_accesos ON reg_pags.session_id = reg_accesos.session_id "
sql = sql & "WHERE ((session_start>='" & DiaI & "' AND session_start<'" &  dateadd("d", 1, DiaF) & "')) "
sql = sql & "GROUP BY CONVERT(VARCHAR(24), reg_accesos.session_start, 103) "
sql = sql & "ORDER BY CONVERT(VARCHAR(24), reg_accesos.session_start, 103) DESC"

if request.Cookies("dev")("sql")<>"" then
	%><p class="peq"><%= sql %></p><%
end if

rs.Open sql, session("connPWAcesos")
do while not rs.eof 
	dia = rs("fecha")
	dd = DateDiff("d", DiaI, dia)
	valores(dd, 3) = rs("sesiones")
	valores(dd, 5) = rs("pags")
	rs.movenext
loop
rs.close 

'articulos
sql = "SELECT CONVERT(VARCHAR(24), fecha, 103) as f, COUNT(id) AS accesos FROM reg_articulos WHERE fecha >= '" & DiaI & "' AND fecha < '" & dateadd("d", 1, DiaF) & "'"
sql = sql & "GROUP BY fecha "
sql = sql & "ORDER BY fecha DESC"

if request.Cookies("dev")("sql")<>"" then
	%><p class="peq"><%= sql %></p><%
end if

rs.Open sql, session("connPWAcesos")
do while not rs.eof 
	dia = rs("f")
	dd = DateDiff("d", DiaI, dia)
	valores(dd, 6) = rs("accesos")
	rs.movenext
loop
rs.close 

if request.Cookies("dev")("sql")<>"" then
	%><hr /><%
end if
set rs=nothing
%>
<table class="reg">
  <tr>
    <th width="85"></th>
    <th width="10"></th>
    <th colspan="3">L</th>
    <th width="15"></th>
    <th colspan="3">M</th>
    <th width="15"></th>
    <th colspan="3">X</th>
    <th width="15"></th>
    <th colspan="3">J</th>
    <th width="15"></th>
    <th colspan="3">V</th>
    <th width="15"></th>
    <th colspan="3">S</th>
    <th width="15"></th>
    <th colspan="3">D</th>
  </tr>
  <% for ss=(sems-1) to 0 step -1 %>
  <tr class="titsem">
    <td class="peq">sem <%= valores(7*ss, 1) %>&nbsp; <%= Year(valores(7*ss, 0)) %></td>
    <td class="peq"></td>
    <td class="mini" colspan="3" align="center"><a href="<%= valores(7*ss, 0) %>" class="accesos_todos"><%= valores(7*ss, 0) %></a></td>
    <td class="peq"></td>
    <td class="mini" colspan="3" align="center"><a href="<%= valores(7*ss+1, 0) %>" class="accesos_todos"><%= valores(7*ss+1, 0) %></a></td>
    <td class="peq"></td>
    <td class="mini" colspan="3" align="center"><a href="<%= valores(7*ss+2, 0) %>" class="accesos_todos"><%= valores(7*ss+2, 0) %></a></td>
    <td class="peq"></td>
    <td class="mini" colspan="3" align="center"><a href="<%= valores(7*ss+3, 0) %>" class="accesos_todos"><%= valores(7*ss+3, 0) %></a></td>
    <td class="peq"></td>
    <td class="mini" colspan="3" align="center"><a href="<%= valores(7*ss+4, 0) %>" class="accesos_todos"><%= valores(7*ss+4, 0) %></a></td>
    <td class="peq"></td>
    <td class="mini" colspan="3" align="center"><a href="<%= valores(7*ss+5, 0) %>" class="accesos_todos"><%= valores(7*ss+5, 0) %></a></td>
    <td class="peq"></td>
    <td class="mini" colspan="3" align="center"><a href="<%= valores(7*ss+6, 0) %>" class="accesos_todos"><%= valores(7*ss+6, 0) %></a></td>
  </tr>
  <tr>
    <td>art&iacute;culos</td>
    <td></td>
    <td class="dra"><a href="<%= valores(7*ss, 0) %>" class="articulos"><%= FormatNumber(valores(7*ss, 6), 0) %></a></td>
    <td></td><td></td>
    <td></td>
    <td class="dra"><a href="<%= valores(7*ss+1, 0) %>" class="articulos"><%= FormatNumber(valores(7*ss+1, 6), 0) %></a></td>
    <td></td><td></td>
    <td></td>
    <td class="dra"><a href="<%= valores(7*ss+2, 0) %>" class="articulos"><%= FormatNumber(valores(7*ss+2, 6), 0) %></a></td>
    <td></td><td></td>
    <td></td>
    <td class="dra"><a href="<%= valores(7*ss+3, 0) %>" class="articulos"><%= FormatNumber(valores(7*ss+3, 6), 0) %></a></td>
    <td></td><td></td>
    <td></td>
    <td class="dra"><a href="<%= valores(7*ss+4, 0) %>" class="articulos"><%= FormatNumber(valores(7*ss+4, 6), 0) %></a></td>
    <td></td><td></td>
    <td></td>
    <td class="dra"><a href="<%= valores(7*ss+5, 0) %>" class="articulos"><%= FormatNumber(valores(7*ss+5, 6), 0) %></a></td>
    <td></td><td></td>
    <td></td>
    <td class="dra"><a href="<%= valores(7*ss+6, 0) %>" class="articulos"><%= FormatNumber(valores(7*ss+6, 6), 0) %></a></td>
    <td></td><td></td>
  </tr>
  <tr>
    <td>accesos </td>
    <td></td>
    
    <td class="dra"><a href="<%= valores(7*ss, 0) %>" class="accesos_conlicencia"><%= FormatNumber(valores(7*ss, 2), 0) %></a></td>
    <td class="peq">/</td>
    <td class="dra peq"><a href="<%= valores(7*ss, 0) %>" class="accesos_sinlicencia"><%= FormatNumber(valores(7*ss, 3)-valores(7*ss, 2), 0) %></a></td>
    
    <td></td>
    
    <td class="dra"><a href="<%= valores(7*ss+1, 0) %>" class="accesos_conlicencia"><%= FormatNumber(valores(7*ss+1, 2), 0) %></a></td>
    <td class="peq">/</td>
    <td class="dra peq"><a href="<%= valores(7*ss+1, 0) %>" class="accesos_sinlicencia"><%= FormatNumber(valores(7*ss+1, 3)-valores(7*ss+1, 2), 0) %></a></td>
    
    <td></td>
    
    <td class="dra"><a href="<%= valores(7*ss+2, 0) %>" class="accesos_conlicencia"><%= FormatNumber(valores(7*ss+2, 2), 0) %></a></td>
    <td class="peq">/</td>
    <td class="dra peq"><a href="<%= valores(7*ss+2, 0) %>" class="accesos_sinlicencia"><%= FormatNumber(valores(7*ss+2, 3)-valores(7*ss+2, 2), 0) %></a></td>
    
    <td></td>
    
    <td class="dra"><a href="<%= valores(7*ss+3, 0) %>" class="accesos_conlicencia"><%= FormatNumber(valores(7*ss+3, 2), 0) %></a></td>
    <td class="peq">/</td>
    <td class="dra peq"><a href="<%= valores(7*ss+3, 0) %>" class="accesos_sinlicencia"><%= FormatNumber(valores(7*ss+3, 3)-valores(7*ss+3, 2), 0) %></a></td>
    
    <td></td>
    
    <td class="dra"><a href="<%= valores(7*ss+4, 0) %>" class="accesos_conlicencia"><%= FormatNumber(valores(7*ss+4, 2), 0) %></a></td>
    <td class="peq">/</td>
    <td class="dra peq"><a href="<%= valores(7*ss+4, 0) %>" class="accesos_sinlicencia"><%= FormatNumber(valores(7*ss+4, 3)-valores(7*ss+4, 2), 0) %></a></td>
    
    <td></td>
    
    <td class="dra"><a href="<%= valores(7*ss+5, 0) %>" class="accesos_conlicencia"><%= FormatNumber(valores(7*ss+5, 2), 0) %></a></td>
    <td class="peq">/</td>
    <td class="dra peq"><a href="<%= valores(7*ss+5, 0) %>" class="accesos_sinlicencia"><%= FormatNumber(valores(7*ss+5, 3)-valores(7*ss+5, 2), 0) %></a></td>
    
    <td></td>
    
    <td class="dra"><a href="<%= valores(7*ss+6, 0) %>" class="accesos_conlicencia"><%= FormatNumber(valores(7*ss+6, 2), 0) %></a></td>
    <td class="peq">/</td>
    <td class="dra peq"><a href="<%= valores(7*ss+6, 0) %>" class="accesos_sinlicencia"><%= FormatNumber(valores(7*ss+6, 3)-valores(7*ss+6, 2), 0) %></a></td>
  </tr>
  <tr>
    <td>pags</td>
    <td></td>
    
    <td class="dra peq"><a href="<%= valores(7*ss, 0) %>" class="accesos_conlicencia"><%= FormatNumber(valores(7*ss, 4), 0) %></a></td>
    <td class="peq">/</td>
    <td class="dra peq"><a href="<%= valores(7*ss, 0) %>" class="accesos_sinlicencia"><%= FormatNumber(valores(7*ss, 5)-valores(7*ss, 4), 0) %></a></td>
    
    <td></td>
    
    <td class="dra peq"><a href="<%= valores(7*ss+1, 0) %>" class="accesos_conlicencia"><%= FormatNumber(valores(7*ss+1, 4), 0) %></a></td>
    <td class="peq">/</td>
    <td class="dra peq"><a href="<%= valores(7*ss+1, 0) %>" class="accesos_sinlicencia"><%= FormatNumber(valores(7*ss+1, 5)-valores(7*ss+1, 4), 0) %></a></td>
    
    <td></td>
    
    <td class="dra peq"><a href="<%= valores(7*ss+2, 0) %>" class="accesos_conlicencia"><%= FormatNumber(valores(7*ss+2, 4), 0) %></a></td>
    <td class="peq">/</td>
    <td class="dra peq"><a href="<%= valores(7*ss+2, 0) %>" class="accesos_sinlicencia"><%= FormatNumber(valores(7*ss+2, 5)-valores(7*ss+2, 4), 0) %></a></td>
    
    <td></td>
    
    <td class="dra peq"><a href="<%= valores(7*ss+3, 0) %>" class="accesos_conlicencia"><%= FormatNumber(valores(7*ss+3, 4), 0) %></a></td>
    <td class="peq">/</td>
    <td class="dra peq"><a href="<%= valores(7*ss+3, 0) %>" class="accesos_sinlicencia"><%= FormatNumber(valores(7*ss+3, 5)-valores(7*ss+3, 4), 0) %></a></td>
    
    <td></td>
    
    <td class="dra peq"><a href="<%= valores(7*ss+4, 0) %>" class="accesos_conlicencia"><%= FormatNumber(valores(7*ss+4, 4), 0) %></a></td>
    <td class="peq">/</td>
    <td class="dra peq"><a href="<%= valores(7*ss+4, 0) %>" class="accesos_sinlicencia"><%= FormatNumber(valores(7*ss+4, 5)-valores(7*ss+4, 4), 0) %></a></td>
    
    <td></td>
    
    <td class="dra peq"><a href="<%= valores(7*ss+5, 0) %>" class="accesos_conlicencia"><%= FormatNumber(valores(7*ss+5, 4), 0) %></a></td>
    <td class="peq">/</td>
    <td class="dra peq"><a href="<%= valores(7*ss+5, 0) %>" class="accesos_sinlicencia"><%= FormatNumber(valores(7*ss+5, 5)-valores(7*ss+5, 4), 0) %></a></td>
    
    <td></td>
    
    <td class="dra peq"><a href="<%= valores(7*ss+6, 0) %>" class="accesos_conlicencia"><%= FormatNumber(valores(7*ss+6, 4), 0) %></a></td>
    <td class="peq">/</td>
    <td class="dra peq"><a href="<%= valores(7*ss+6, 0) %>" class="accesos_sinlicencia"><%= FormatNumber(valores(7*ss+6, 5)-valores(7*ss+6, 4), 0) %></a></td>
  </tr>
  
  <tr>
    <td colspan="29" class="separador"></td>
  </tr>
  
  <% next %>
</table>
<p class="peq"><strong>* accesos</strong>: [con licencia] / [sin licencia]</p>
<%
dim ajax_data(4)


for ii=0 to dias
	if DateDiff("d", valores(ii, 0), date)<0 then exit for
	
	if datepart("w", valores(ii, 0), 2)<6 then
		if ajax_data(0)<>"" then ajax_data(0) = ajax_data(0) & ", "
		ajax_data(0) = ajax_data(0) & "'" & valores(ii, 0) & "'"
		
		if ajax_data(1)<>"" then ajax_data(1) = ajax_data(1) & ", "
		ajax_data(1) = ajax_data(1) & valores(ii, 2)
		
		if ajax_data(2)<>"" then ajax_data(2) = ajax_data(2) & ", "
		ajax_data(2) = ajax_data(2) & valores(ii, 4)
		
	end if
	
next

ajax_data(0) = "[" & ajax_data(0) & "]"

ajax_data(1) = "{ name: 'accesos', data: [" & ajax_data(1) & "] }"
	
ajax_data(2) = "{ name: 'pags.', data: [" & ajax_data(2) & "] }"
	
ajax_data(3) = "{ name: 'articulos', data: [3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8] }"
%>
<script type="text/javascript">
$(document).ready(function () {
	
	$('.accesos_todos').click(function(e) {
		var ff = this.getAttribute("href");
		$('#Fecha').val(ff);
		$('#ver').val('*');
		//$('#tabData ul.resp-tabs-list li:nth-child(1)').click();
		$('#frm_detalles').submit();
		
		return false;
	});
	
	$('.accesos_conlicencia').click(function(e) {
		var ff = this.getAttribute("href");
		$('#Fecha').val(ff);
		$('#ver').val('conlicencia');
		//$('#tabData ul.resp-tabs-list li:nth-child(1)').click();
		$('#frm_detalles').submit();
		
		return false;
	});
	
	$('.accesos_sinlicencia').click(function(e) {
		var ff = this.getAttribute("href");
		$('#Fecha').val(ff);
		$('#ver').val('sinlicencia');
		//$('#tabData ul.resp-tabs-list li:nth-child(1)').click();
		$('#frm_detalles').submit();
		
		return false;
	});
	
	$('.articulos').click(function(e) {
		var ff = this.getAttribute("href");
		$('#Fecha').val(ff);
		$('#ver').val('*');
		//$('#tabData ul.resp-tabs-list li:nth-child(1)').click();
		$('#frm_detalles').submit();
		
		return false;
	});
	
	// graf
	/*
	$('#container').highcharts({
		series: [ < %= ajax_data(1) %>, < %= ajax_data(2) %> ],
		xAxis: {
			categories: < %= ajax_data(0) %>
		}
	});
	*/
});

</script>