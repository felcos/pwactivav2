<div class="tabla">
<% 
Set rs = Server.CreateObject("ADODB.Recordset")
yy = request.QueryString("yy")
mm = request.QueryString("mm")

dia = "01/" & mm & "/" & yy


if yy=2015 and mm=1 then
	diaf = day(date)
else
	diaf = day(dateadd("d", -1, dateadd("m", 1, dia)))
end if

for dd = diaf to 1 step -1
	c_not = 0
	c_web = 0
	c_est = 0
	c_dem = 0
	c_ope = 0
	c_sub = 0
	c_vencim = 0
	c_ofe = 0
	
	'tabla NOTICIAS_INMOBILIARIAS	
	sql = "SELECT TIPO_NOTICIA, COUNT(ID) AS articulos FROM NOTICIAS_INMOBILIARIAS "
	sql = sql & "WHERE ( FECHA_ACTUALIZACION = CONVERT(DATETIME, '" & yy & "-" & mm & "-" & dd & " 00:00:00', 102) ) "
	sql = sql & "GROUP BY TIPO_NOTICIA "
	'sql = sql & "ORDER BY TIPO_NOTICIA"
	'response.Write(sql)
	
	rs.Open sql, session("connPW")	',1,1
	do while not rs.eof
		select case rs("TIPO_NOTICIA")
		case "N"
			c_not =  rs("articulos")
		case "W"
			c_web = rs("articulos")
		case "E"
			c_est = rs("articulos")
		case "B"
			c_dem = rs("articulos")
		end select
		
		rs.movenext
	loop
	rs.close
	
	'OPERACIONES
	sql = "SELECT COUNT(ID) AS articulos FROM OPERACIONES "
	sql = sql & "WHERE (FECHA_ACTUALIZACION = CONVERT(DATETIME, '" & yy & "-" & mm & "-" & dd & " 00:00:00', 102) ) "
	rs.Open sql, session("connPW")	',1,1
	c_ope = rs("articulos")
	rs.close
	
	'VENCIMIENTOS
	sql = "SELECT COUNT(ID) AS articulos FROM OPERACIONES "
	sql = sql & "WHERE (FECHA_PUBLICACION_VENCIMIENTO = CONVERT(DATETIME, '" & yy & "-" & mm & "-" & dd & " 00:00:00', 102) ) "
	rs.Open sql, session("connPW")	',1,1
	c_vencim = rs("articulos")
	rs.close
	
	
	'CONCURSOS
	sql = "SELECT COUNT(ID) AS articulos FROM concursos "
	sql = sql & "WHERE (fecha_actualizacion = CONVERT(DATETIME, '" & yy & "-" & mm & "-" & dd & " 00:00:00', 102) ) "
	rs.Open sql, session("connPW")	',1,1
	c_sub = rs("articulos")
	rs.close
	
	
	'OFERTAS
	sql = "SELECT COUNT(ID) AS articulos FROM ofertas "
	sql = sql & "WHERE (FECHA_ACTUALIZACION = CONVERT(DATETIME, '" & yy & "-" & mm & "-" & dd & " 00:00:00', 102) ) "
	rs.Open sql, session("connPW")	',1,1
	c_ofe = rs("articulos")
	rs.close
	
	'******
	
	falta = ""
	if c_not=0 then falta = falta & "not "
	if c_web=0 then falta = falta & "rum "
	if c_est=0 then falta = falta & "est "
	if c_dem=0 then falta = falta & "dem "
	if c_ope=0 then falta = falta & "ope "
	if c_vencim=0 then falta = falta & "vencim "
	if c_sub=0 then falta = falta & "sub "
	if c_dem=0 then falta = falta & "ofe "
	
	ver_falta=""
	if falta="not rum est dem ope vencim sub ofe " then 
		falta = "*"
		ver_falta = "<span class='informa destaca'><strong>*</strong></span>"
	else
		ver_falta = "<span class='informa'>" & trim(falta) & "</span>"
	end if 
	
	dia = CDate(dd & "/" & mm & "/" & yy)
	select case Weekday(CDate(dia))
	case 2
		n_dia="lunes"
	case 3
		n_dia="martes"
	case 4
		n_dia="miercoles"
	case 5
		n_dia="jueves"
	case 6
		n_dia="viernes"
	case 7, 1
		n_dia = ""
	end select
	
	if n_dia<>"" then 'or falta="*" then %>
<a href="/flash/?f=<%= dia %>" target="_blank">
<div class="fila filadia">
    <div class="col_tit"><span style="padding-left:35px;"><%= dia %> &nbsp; <span style="font-size:80%;"><%= n_dia %></span></span></div>
    <div class="col"><%= FormatNumber(c_not, 0) %></div>
    <div class="col"><%= FormatNumber(c_web, 0) %></div>
    <div class="col"><%= FormatNumber(c_ope, 0) %></div>
    <div class="col"><%= FormatNumber(c_est, 0) %></div>
    <div class="col"><%= FormatNumber(c_sub, 0) %></div>
    <div class="col"><%= FormatNumber(c_dem, 0) %></div>
    <div class="col"><%= FormatNumber(c_vencim, 0) %></div>
    <div class="col"><%= FormatNumber(c_ofe, 0) %></div>
    <div class="separa"></div>
    <div class="col_informa"><%= ver_falta %></div>
</div>
</a>
	<% end if
next %>
</div>

<script type="text/javascript">
$(document).ready(function() { 
	$('.filadia').hover(
		function(){
			$(this).css("background-color","#FFC");
		},
		function(){
			$(this).css("background-color","#FFF");
		}
	);
		
}); 
</script>
