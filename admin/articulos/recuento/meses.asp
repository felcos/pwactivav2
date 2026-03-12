<% 
Set rs = Server.CreateObject("ADODB.Recordset")
yy = request.QueryString("yy")

if yy=2015 then
	desde = month(date)
else
	desde = 12
end if

for mm = desde to 1 step -1
	c_not = 0
	c_web = 0
	c_est = 0
	c_dem = 0
	c_ope = 0
	c_sub = 0
	c_vencim = 0
	c_ofe = 0
	
	if mm=12 then
		yyf = yy+1
		mmf =1
	else
		yyf = yy
		mmf =  mm+1
	end if
	'tabla NOTICIAS_INMOBILIARIAS	
	sql = "SELECT TIPO_NOTICIA, COUNT(ID) AS articulos FROM NOTICIAS_INMOBILIARIAS "
	sql = sql & "WHERE (FECHA_ACTUALIZACION >= CONVERT(DATETIME, '" & yy & "-" & mm & "-01 00:00:00', 102) AND FECHA_ACTUALIZACION < CONVERT(DATETIME, '" & yyf & "-" & mmf & "-01 00:00:00', 102)) "
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
	sql = sql & "WHERE (FECHA_ACTUALIZACION >= CONVERT(DATETIME, '" & yy & "-" & mm & "-01 00:00:00', 102) AND FECHA_ACTUALIZACION < CONVERT(DATETIME, '" & yyf & "-" & mmf & "-01 00:00:00', 102)) "
	rs.Open sql, session("connPW")	',1,1
	c_ope = rs("articulos")
	rs.close
	
	'VENCIMIENTOS
	sql = "SELECT COUNT(ID) AS articulos FROM OPERACIONES "
	sql = sql & "WHERE (FECHA_PUBLICACION_VENCIMIENTO >= CONVERT(DATETIME, '" & yy & "-" & mm & "-01 00:00:00', 102) AND FECHA_PUBLICACION_VENCIMIENTO < CONVERT(DATETIME, '" & yyf & "-" & mmf & "-01 00:00:00', 102)) "
	rs.Open sql, session("connPW")	',1,1
	c_vencim = rs("articulos")
	rs.close
	
	'CONCURSOS
	sql = "SELECT COUNT(ID) AS articulos FROM concursos "
	sql = sql & "WHERE (fecha_actualizacion >= CONVERT(DATETIME, '" & yy & "-" & mm & "-01 00:00:00', 102) AND fecha_actualizacion < CONVERT(DATETIME, '" & yyf & "-" & mmf & "-01 00:00:00', 102)) "
	rs.Open sql, session("connPW")	',1,1
	c_sub = rs("articulos")
	rs.close
	
	'OFERTAS
	sql = "SELECT COUNT(ID) AS articulos FROM ofertas "
	sql = sql & "WHERE (FECHA_ACTUALIZACION >= CONVERT(DATETIME, '" & yy & "-" & mm & "-01 00:00:00', 102) AND FECHA_ACTUALIZACION < CONVERT(DATETIME, '" & yyf & "-" & mmf & "-01 00:00:00', 102)) "
	rs.Open sql, session("connPW")	',1,1
	c_ofe = rs("articulos")
	rs.close
	%>
<div class="tabla">
<a href="/admin/articulos/recuento/dias.asp?yy=<%= yy %>&amp;mm=<%= mm %>" class="mm">
<div class="fila">
    <div class="col_tit"><strong><span style="padding-left:20px;"><%= MonthName(mm) %></span></strong></div>
    <div class="col"><strong><%= FormatNumber(c_not, 0) %></strong></div>
    <div class="col"><strong><%= FormatNumber(c_web, 0) %></strong></div>
    <div class="col"><strong><%= FormatNumber(c_ope, 0) %></strong></div>
    <div class="col"><strong><%= FormatNumber(c_est, 0) %></strong></div>
    <div class="col"><strong><%= FormatNumber(c_sub, 0) %></strong></div>
    <div class="col"><strong><%= FormatNumber(c_dem, 0) %></strong></div>
    <div class="col"><strong><%= FormatNumber(c_vencim, 0) %></strong></div>
    <div class="col"><strong><%= FormatNumber(c_ofe, 0) %></strong></div>
    <div class="separa"></div>
    <div class="col_informa"></div>
</div>
</a>
</div>

<div id="mm_<%= yy %>_<%= mm %>" style="display:Znone;"></div>
<% next %>

<script type="text/javascript">
$(document).ready(function() { 
	$('.tabla').hover(
		function(){
			$(this).css("background-color","#FFC");
		},
		function(){
			$(this).css("background-color","#FFF");
		}
	);
	
	$('.mm').click(function (e) {
		var href = this.href.split("?");
		var sURL = href[1].split("&");
		
		for (var i = 0; i < sURL.length; i++) {
			var sParams = sURL[i].split("=");
			if (sParams[0] == "yy") {
				var yy = sParams[1]
			} else if (sParams[0] == "mm") {
				var mm = sParams[1]
			};
		};
		//console.log("mm_"+yy+"_"+mm);
		
		var dest = "#mm_"+yy+"_"+mm;
		var destino = $(dest);
		
		if (destino.html()=="") {
			$.ajax({
				url: this.href,
				success:function(result) {
					destino.html(result);
					//destino.replaceWith(result);
					//console.log('cargada data dias');
				}
			});
		
		} else {
			destino.toggle();
		};
			
		return false;
		
	});	
}); 
</script>