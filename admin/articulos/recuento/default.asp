<!DOCTYPE html>
<html lang="es">
<head>
    <title>PropertyWeb - Daily Flash</title>
    <!--#include virtual="/inc/simple/head.asp" -->
    
<style>
/* tabla */
.tabla {
	/* width: 100%; */
	display: table;
	margin-left:18px;
	}
.fila  {
	display: table-row;
	}

.col_tit {
	display: table-cell;
	width:180px;
	border-bottom: 1px solid #c1c1c1;
}
.col_informa {
	display: table-cell;
	width:200px;
	border-bottom: 1px solid #c1c1c1;
	}
.col {
	display: table-cell;
	width:80px;
	text-align:right;
	border-bottom: 1px solid #c1c1c1;
	}
.separa {
	display: table-cell;
	width:20px;
	border-bottom: 1px solid #c1c1c1;
	}

.tabla a:active, .tabla a:visited, .tabla a:link {
	color:#000;
	}
.tabla a:hover {color:#F47C04;}
.informa {
	font-size:10px;
	}
</style>
<%
Set rs = Server.CreateObject("ADODB.Recordset")

sec_actual = "flash"
pag_actual = "recuento" 
%>
</head>
<body>
<!--#include virtual="/inc/simple/body-header.asp" -->
<div id="content">
<div class="contenedor">
	
    <section id="s_titulo" class="cf">
        <div class="grid-full titulo"><h1 class="heading">PW Flash</h1></div>
        <div class="grid-full titulo"><h2 class="subheading">Recuento de Art&iacute;culos Publicados</h2></div>
    </section>
    
    <section id="s_datos" class="cf">
    	
        <div class="grid-full">
            <div class="caja">
                <div class="tabla">
                    <div class="fila">
                        <div class="col_tit">&nbsp;</div>
                        <div class="col">Noticias</div>
                        <div class="col">Rumores</div>
                        <div class="col">Deals</div>
                        <div class="col">Estudios</div>
                        <div class="col">Subastas</div>
                        <div class="col">Demandas</div>
                        <div class="col">Vencim.</div>
                        <div class="col">Ofertas</div>
                        <div class="separa"></div>
                        <div class="col_informa">informa</div>
                    </div>
                </div>
            
				<% for yy=2015 to 2010 step -1
                    call fila(yy)
                next %>
            
                <div style="clear:both;"><br></div>
            </div>
            
        </div><!-- grid full -->
    
    </section>

</div>
</div>

</body>
</html>
<%
Set rs = nothing
%>
<% sub fila(p_yy)
	c_not = 0
	c_web = 0
	c_est = 0
	c_dem = 0
	c_ope = 0
	c_sub = 0
	c_vencim = 0
	c_ofe = 0
	
	'tabla NOTICIAS_INMOBILIARIAS	
	sql = "SELECT TIPO_NOTICIA, COUNT(ID) AS articulos FROM C_NOTICIAS_INMOBILIARIAS "
	sql = sql & "WHERE (FECHA_ACTUALIZACION >= CONVERT(DATETIME, '" & p_yy & "-01-01 00:00:00', 102) AND FECHA_ACTUALIZACION < CONVERT(DATETIME, '" & (p_yy+1) & "-01-01 00:00:00', 102)) "
	sql = sql & "GROUP BY TIPO_NOTICIA "
	'sql = sql & "ORDER BY TIPO_NOTICIA"
	
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
	sql = sql & "WHERE (FECHA_ACTUALIZACION >= CONVERT(DATETIME, '" & p_yy & "-01-01 00:00:00', 102) AND FECHA_ACTUALIZACION < CONVERT(DATETIME, '" & (p_yy+1) & "-01-01 00:00:00', 102)) "
	rs.Open sql, session("connPW")	',1,1
	c_ope = rs("articulos")
	rs.close
	
	'VENCIMIENTOS
	sql = "SELECT COUNT(ID) AS articulos FROM OPERACIONES "
	sql = sql & "WHERE (FECHA_PUBLICACION_VENCIMIENTO >= CONVERT(DATETIME, '" & p_yy & "-01-01 00:00:00', 102) AND FECHA_PUBLICACION_VENCIMIENTO < CONVERT(DATETIME, '" & (p_yy+1) & "-01-01 00:00:00', 102)) "
	rs.Open sql, session("connPW")	',1,1
	c_vencim = rs("articulos")
	rs.close
	
	'CONCURSOS
	sql = "SELECT COUNT(ID) AS articulos FROM concursos "
	sql = sql & "WHERE (fecha_actualizacion >= CONVERT(DATETIME, '" & p_yy & "-01-01 00:00:00', 102) AND fecha_actualizacion < CONVERT(DATETIME, '" & (p_yy+1) & "-01-01 00:00:00', 102)) "
	rs.Open sql, session("connPW")	',1,1
	c_sub = rs("articulos")
	rs.close
	
	'OFERTAS
	sql = "SELECT COUNT(ID) AS articulos FROM ofertas "
	sql = sql & "WHERE (FECHA_ACTUALIZACION >= CONVERT(DATETIME, '" & p_yy & "-01-01 00:00:00', 102) AND FECHA_ACTUALIZACION < CONVERT(DATETIME, '" & (p_yy+1) & "-01-01 00:00:00', 102)) "
	rs.Open sql, session("connPW")	',1,1
	c_ofe = rs("articulos")
	rs.close
	%>
    <div class="tabla">
        <a href="/admin/articulos/recuento/meses.asp?yy=<%= yy %>" class="yy">
        <div class="fila">
            <div class="col_tit"><strong><%= p_yy %></strong></div>
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
    <div id="yy_<%= p_yy %>"></div>
<% end sub %>
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
	
	$('.yy').click(function (e) {
		var url = this.href;
		yy = url.substr(url.length-4 ,4);
		var dest = "#yy_"+yy;
		var destino = $(dest);
		
		
		//console.log(destino.html());
		
		if (destino.html()=="") {
			$.ajax({
				url: url,
				success:function(result) {
					destino.html(result);
					//destino.replaceWith(result);
					//console.log('cargada data');
				}
			});
		
		} else {
			destino.toggle();
		};
		//console.log('toggle');
		//jjj.toggle();
		
		return false;
	});	

}); 

</script>

