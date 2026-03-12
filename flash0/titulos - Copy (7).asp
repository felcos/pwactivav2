<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<!--#include virtual="/flash/lib.asp" -->
<%
set resultado = Server.CreateObject("ADODB.Recordset")

pFecha = request.Form("fecha")
if not(isdate(pFecha)) then response.End()

if request.Cookies("dev")="" then
	if datediff("d", pFecha, date)>7 or datediff("d", pFecha, date)<0 then pFecha = date
end if

origen = "&origen=flash"
'if pFecha<>date then 
	origen = origen & "&f=" & pFecha
'end if
%>
<form id="frm_flash" name="frm_flash" action="/articulos/" method="post">
<input name="origen" type="hidden" value="flash" />
<% 'if pFecha<>date then %><input name="f" type="hidden" value="<%= pFecha %>" /><% 'end if %>
<div class="row">
    <div class="col-md-6">
    
        <h2 class="tit_box"><span class="icon icon-arrow-down-right2"></span>PW News Summary  <img src="https://www.propertyweb.eu/rrss/gratis1.png" width="85px"  /></h2>
        <% 'Actualidad	
        bloque="not"
        strin="not"
        ErrMesage=""
        num_titulo=0
        apart= ""
        seccion2=""
        
        SQL_SELECT = "SELECT TITULO, ID, FECHA_ACTUALIZACION, TIPOSECCION AS APARTADO, TITULO_ING AS TITULO_AUX,"
        SQL_SELECT = SQL_SELECT & "icono_seccion FROM C_NOTICIAS_INMOBILIARIAS "
        
        SQL_WHERE = " WHERE "
        SQL_WHERE = SQL_WHERE & "(FECHA_NOTICIA >= CONVERT(DATETIME, '" & pFecha & "', 103) AND FECHA_ACTUALIZACION <= CONVERT(DATETIME, '" & pFecha & "', 103)) "	
        'SQL_WHERE = SQL_WHERE & "(FECHA_NOTICIA BETWEEN  CONVERT(DATETIME, '" & pFecha & "', 103) AND CONVERT(DATETIME, '" & pFecha & "', 103) OR "
        'SQL_WHERE = SQL_WHERE & "FECHA_ACTUALIZACION BETWEEN CONVERT(DATETIME, '" & pFecha & "', 103) AND CONVERT(DATETIME, '" & pFecha & "', 103)) "	
    
        SQL_WHERE = SQL_WHERE & "AND web_es <> 0 "
        SQL_WHERE = SQL_WHERE & "AND TIPO_NOTICIA = 'N' "
        
        SQL_ORDER = "ORDER BY TIPOSECCION "
        
        'test_inyeccion_sql (sql_select & sql_where)
        primero = true
        %>
        <div class="box_blanco">
            <% 'nacional	
            SQL = SQL_SELECT & SQL_WHERE & " AND nacional=1 " & SQL_ORDER
            resultado.Open sql, session("connPW")	',1,1
            if not resultado.eof then %>
                <div class="bloque_ubic<% if primero then %> primero<% end if %>"><img src="/img/drop.png">&nbsp;Nacional</div>
                <% call BloqueTitulos()
                primero = false
            end if
            resultado.close %>
            <% 'internacional	
            SQL = SQL_SELECT & SQL_WHERE & " AND (nacional<>1 OR nacional IS NULL) " & SQL_ORDER	
            resultado.Open sql, session("connPW")
            if not resultado.eof then %>
                <% if not(primero) then %><div class="ubicacion_separador"></div><% end if %>
                <div class="bloque_ubic<% if primero then %> primero<% end if %>"><img src="/img/drop.png">&nbsp;Internacional</div>
                <% call BloqueTitulos()
            end if
            resultado.close %>
        </div>
        
        
        <h2 class="tit_box"><span class="icon icon-arrow-down-right2"></span>Vencimientos de Contrato</h2>
        <%' Vencimientos	
        bloque="ven"
        strin="ven"	'vencimientos
        ErrMesage=""
        num_titulo=0
        apart= ""
        seccion2="VENCIMIENTOS"
        enlace_base = "/articulos/?"
        
        sql_vencim = "SELECT ID, TITULO, TITULO_pt AS TITULO_AUX, FECHA_ACTUALIZACION,  SECCION AS APARTADO, "
        sql_vencim = sql_vencim & "LOCALIDAD, PROVINCIA, TIPOACTIVIDAD, METROS_CUADRADOS, ID_TIPO_OPERACION "
        sql_vencim = sql_vencim & "FROM C_OPERACIONES WHERE "
        sql_vencim = sql_vencim & "(FECHA_PUBLICACION_VENCIMIENTO BETWEEN  CONVERT(DATETIME, '" & pFecha & "', 103) AND CONVERT(DATETIME, '" & pFecha & "', 103)) "	
        sql_vencim = sql_vencim & "AND web_es <> 0"
        sql_vencim = sql_vencim & " ORDER BY SECCION"
        
        'test_inyeccion_sql sql_vencim
        primero = true
        
        resultado.Open sql_vencim, session("connPW")	',1,1
        %>
        <% if not resultado.eof then %>
        <div class="box_blanco"><% call BloqueVencimientos(resultado) %></div>
        <% end if
        resultado.close %>
        
        
        <h2 class="tit_box"><span class="icon icon-arrow-down-right2"></span>Ofertas<img src="https://www.propertyweb.eu/rrss/gratis1.png" width="85px"  /></h2>
        <%' Ofertas	
        bloque="ofe"
        strin="ofe"
        ErrMesage=""
        num_titulo=0
        apart= ""
        
        sql = "SELECT * FROM anuncios_envio "
        sql = sql & "WHERE ("
        
        sql = sql & "(web_es<>0) AND ("
        sql = sql & "(FECHA_PUBLICACION BETWEEN  CONVERT(DATETIME, '" & pFecha & "', 103) AND CONVERT(DATETIME, '" & pFecha & "', 103))"
        sql = sql & " OR "
        sql = sql & "(FECHA_ACTUALIZACION BETWEEN CONVERT(DATETIME, '" & pFecha & "', 103) AND CONVERT(DATETIME, '" & pFecha & "', 103)) "
        sql = sql & "OR "
        sql = sql & "NOT(FechaVisibleHasta < CONVERT(DATETIME, '" & pFecha & "', 103) OR FechaVisibleDesde > CONVERT(DATETIME, '" & pFecha & "', 103)) "
        sql = sql & ")"
        sql = sql & ") ORDER BY id_seccion, id_pais, provincia desc"
        
        'test_inyeccion_sql sql
        resultado.Open sql, session("connPW")	',1,1
        
        if not resultado.eof then %>
        <div class="box_blanco">
            <div class="seccion_tit">
                <span style="float:right; font-size:11px; line-height:normal; margin-top:26px;">
                <p>Publica totalmente gratis <br>
                tus <strong>anuncios</strong> y <strong>ofertas</strong></p>
                <p style="margin-top:8px; font-size:11px;"><a href="mailto:anuncios@easyproperty.es?Subject=EasyProperty - publicar anuncio" style="color:#F47C04;"><strong>Haz click aquí</strong></a></p>
                </span>
                <a href="https://www.easyproperty.es" target="_new"><img src="/img/logos/easylogo.png"></a>
                <span style="display:block; font-size:10px; margin:-10px 170px 0 170px;"><a href="https://www.easyproperty.es" target="_new">acceso gratuito</a></span>
            </div>
            <% call BloqueTitulosEasy() %>
        </div>
        <% end if
        resultado.close %>
        
    </div>

    <div class="col-md-6">
    
        <h2 class="tit_box"><span class="icon icon-arrow-down-right2"></span>Web ha o&iacute;do...</h2>
        <% 'Rumores		
        bloque="rum"
        strin="rum"
        ErrMesage=""
        num_titulo=0
        apart= ""
        seccion2=""
        
        swMostrar = true
        
        SQL_SELECT = "SELECT TITULO, ID, FECHA_ACTUALIZACION, TIPOSECCION AS APARTADO, TITULO_ING AS TITULO_AUX,"
        SQL_SELECT = SQL_SELECT & "icono_seccion FROM C_NOTICIAS_INMOBILIARIAS "
        
        SQL_WHERE = " WHERE "
        SQL_WHERE = SQL_WHERE & "(FECHA_NOTICIA >= CONVERT(DATETIME, '" & pFecha & "', 103) AND FECHA_ACTUALIZACION <= CONVERT(DATETIME, '" & pFecha & "', 103)) "
        SQL_WHERE = SQL_WHERE & "AND web_es <> 0 "
        SQL_WHERE = SQL_WHERE & "AND TIPO_NOTICIA = 'W' "
        
        SQL_ORDER = "ORDER BY TIPOSECCION "
        
        'test_inyeccion_sql (sql_select & sql_where)
        primero = true
        %>
        <div class="box_blanco">
            <% 'nacional		
            SQL = SQL_SELECT & SQL_WHERE & " AND nacional=1 " & SQL_ORDER
            resultado.Open sql, session("connPW")	',1,1
            if not resultado.eof then %>
                <div class="bloque_ubic<% if primero then %> primero<% end if %>"><img src="/img/drop.png">&nbsp;Nacional</div>
                <% call BloqueTitulos()
                primero = false
            end if
            resultado.close %>
            <% 'internacional	
            SQL = SQL_SELECT & SQL_WHERE & " AND (nacional<>1 OR nacional IS NULL) " & SQL_ORDER
            resultado.Open sql, session("connPW")
            if not resultado.eof then %>
                <% if not(primero) then %><div class="ubicacion_separador"></div><% end if %>
                <div class="bloque_ubic<% if primero then %> primero<% end if %>"><img src="/img/drop.png">&nbsp;Internacional</div>
                <% call BloqueTitulos()
            end if
            resultado.close %>
        </div>
        
        
        <h2 class="tit_box"><span class="icon icon-arrow-down-right2"></span>Deal Analysis</h2>
        <%' Operaciones	
        bloque="ope"		'dan
        strin="ope"			'dan
        ErrMesage=""
        num_titulo=0
        apart= ""
        
        SQL_SELECT = "SELECT ID, TITULO,TITULO_pt AS TITULO_AUX, FECHA_ACTUALIZACION, seccion AS APARTADO, icono_seccion "
        SQL_SELECT = SQL_SELECT & "FROM w_OPERACIONES "
        
        SQL_WHERE = " WHERE "
        SQL_WHERE = SQL_WHERE & "web_es <> 0"
        SQL_WHERE = SQL_WHERE & " AND (FECHA_PUBLICACION >= CONVERT(DATETIME, '" & pFecha & "', 103) AND FECHA_ACTUALIZACION <= CONVERT(DATETIME, '" & pFecha & "', 103))"
        'SQL_WHERE = SQL_WHERE & "(FECHA_PUBLICACION BETWEEN  CONVERT(DATETIME, '" & pFecha & "', 103) AND CONVERT(DATETIME, '" & pFecha & "', 103) OR "
        'SQL_WHERE = SQL_WHERE & "FECHA_ACTUALIZACION BETWEEN CONVERT(DATETIME, '" & pFecha & "', 103) AND CONVERT(DATETIME, '" & pFecha & "', 103)) "	
        
        SQL_ORDER = "ORDER BY seccion "
        
        'test_inyeccion_sql sql
        primero = true
        %>
        <div class="box_blanco">
            <% 'nacional		
            sql = SQL_SELECT & SQL_WHERE & " AND id_pais=1 " & SQL_ORDER
            resultado.Open sql, session("connPW")	',1,1
            if not resultado.eof then %>
                <div class="bloque_ubic<% if primero then %> primero<% end if %>"><img src="/img/drop.png"><span class="ubic">nacional</span></div>
                <% call BloqueTitulos()
                primero = false
            end if
            resultado.close %>
            <% 'internacional	
            SQL = SQL_SELECT & SQL_WHERE & " AND (id_pais<>1 OR id_pais IS NULL) " & SQL_ORDER
            resultado.Open sql, session("connPW")	',1,1
            if not resultado.eof then %>
                <% if not(primero) then %><div class="ubicacion_separador"></div><% end if %>
                <div class="bloque_ubic<% if primero then %> primero<% end if %>"><img src="/img/drop.png"><span class="ubic">internacional</span></div>
                <% call BloqueTitulos()
            end if
            resultado.close %>
        </div>
        
        
        <h2 class="tit_box"><span class="icon icon-arrow-down-right2"></span> Time4aChange <img src="https://www.propertyweb.eu/rrss/gratis1.png" width="85px"  /></h2>

  <% 
		
	
        bloque="t4a"
        strin="t4a"		'dema
        ErrMesage=""
        Seccion2="t4a"
        num_titulo=0
        apart= ""
        
        swMostrar = true

        SQL_SELECT = "SELECT * FROM View_Time4Change "
   
        
        SQL_WHERE = "  WHERE vivo=1 and (fecha >= CONVERT(DATETIME, '" & pFecha & "', 103) AND fecha <= CONVERT(DATETIME, '" & pFecha & "', 103)) "
        SQL_WHERE = SQL_WHERE & "AND Vivo <> 0 "

        
        SQL_ORDER = "  "
        


sql = "SELECT * FROM View_Time4Change WHERE vivo=1 and (fecha >= CONVERT(DATETIME, '" & pFecha & "', 103) AND fecha <= CONVERT(DATETIME, '" & pFecha & "', 103)) "
        
        

 	resultado.Open sql, session("connPW")	',1,1

        if not resultado.eof then %>
        <div class="box_blanco">
            <div class="seccion_tit">
                <span style="float:right; font-size:11px; line-height:normal; margin-top:26px;">
                <p>Quieres contarnos de tu cambio? <br>
                manda un email a <strong>andyg@propertyweb.eu</strong><br> o llamame a: <strong>617835023</strong></p>
                <p style="margin-top:8px; font-size:11px;"><a href="mailto:andyg@propertweb.eu?Subject=Time4Achange - publicar cambio" style="color:#F47C04;"><strong>Haz click aquí</strong></a></p>
                </span>
                <img src="https://www.propertyweb.eu/img/logos/logoT4AC2.png" width="266" >
                <span style="display:block; font-size:10px; margin:-10px 170px 0 156px;">acceso gratuito</span>
            </div>
            <% call BloqueTitulosT4ac() %>
        </div>
        <% end if
        resultado.close %>







        <h2 class="tit_box"><span class="icon icon-arrow-down-right2"></span>Estudios de Mercado</h2>
        <% 'Estudios	
        bloque="est"
        strin="est"
        ErrMesage=""
        num_titulo=0
        apart= ""
        seccion2=""
        
        swMostrar = true
        
        SQL_SELECT = "SELECT TITULO, ID, FECHA_ACTUALIZACION, TIPOSECCION AS APARTADO, TITULO_ING AS TITULO_AUX,"
        SQL_SELECT = SQL_SELECT & "icono_seccion FROM C_NOTICIAS_INMOBILIARIAS "
        
        SQL_WHERE = " WHERE "
        SQL_WHERE = SQL_WHERE & "(FECHA_NOTICIA >= CONVERT(DATETIME, '" & pFecha & "', 103) AND FECHA_ACTUALIZACION <= CONVERT(DATETIME, '" & pFecha & "', 103)) "
        SQL_WHERE = SQL_WHERE & "AND TIPO_NOTICIA = 'E' "
        
        SQL_ORDER = "ORDER BY TIPOSECCION "
        
        'test_inyeccion_sql (sql_select & sql_where)
        primero = true
        %>
        <div class="box_blanco">
            <% 'nacional		
            SQL = SQL_SELECT & SQL_WHERE & " AND nacional=1 " & SQL_ORDER
            resultado.Open sql, session("connPW")
            if not resultado.eof then %>
                <div class="bloque_ubic<% if primero then %> primero<% end if %>"><img src="/img/drop.png"><span class="ubic">nacional</span></div>
                <% call BloqueTitulos()
                primero = false
            end if
            resultado.close %>
            <% 'internacional	
            SQL = SQL_SELECT & SQL_WHERE & " AND (nacional<>1 OR nacional IS NULL) " & SQL_ORDER
            resultado.Open sql, session("connPW")
            if not resultado.eof then %>
                <% if not(primero) then %><div class="ubicacion_separador"></div><% end if %>
                <div class="bloque_ubic<% if primero then %> primero<% end if %>"><img src="/img/drop.png"><span class="ubic">internacional</span></div>
                <% call BloqueTitulos()
            end if
            resultado.close %>
        </div>
        
        <h2 class="tit_box"><span class="icon icon-arrow-down-right2"></span>Web "Tit Bits"</h2>

  
		



<% 
		
	
        bloque="t4a"
        strin="t4a"		'dema
        ErrMesage=""
        Seccion2="t4a"
        num_titulo=0
        apart= ""
        
        swMostrar = true

        SQL_SELECT = "SELECT * FROM View_Noticias_Comentrios "
   
        
        SQL_WHERE = "  WHERE (vivo1=1 or vivo2=1)  "
      

        
        SQL_ORDER = "  "
        


sql = "SELECT * FROM View_Noticias_Comentrios "
        
        

 	resultado.Open sql, session("connPW")	',1,1

        if not resultado.eof then %>
        <div class="box_blanco">
            <div class="seccion_tit">
                <span style="float:right; font-size:11px; line-height:normal; margin-top:26px;">
                <p>Quieres dejar tus comentarios? <br>
                manda un email a <strong>andyg@propertyweb.eu</strong><br> o llamame a: <strong>617835023</strong></p>
                <p style="margin-top:8px; font-size:11px;"><a href="mailto:andyg@propertweb.eu?Subject=WebTitBits " style="color:#F47C04;"><strong>Haz click aquí</strong></a></p>
                </span>
                <img src="https://www.propertyweb.eu/img/webtitbits.png" width="156" >
                <span style="display:block; font-size:10px; margin:-10px 170px 0 156px;">acceso gratuito</span>
            </div>
            <% call BloqueTitulosWTB() %>
        </div>
        <% end if
        resultado.close %>




        
        <h2 class="tit_box"><span class="icon icon-arrow-down-right2"></span>Subastas/Concursos</h2>
        <%' Subastas	
        bloque="sub"
        strin="sub"
        ErrMesage=""
        num_titulo=0
        apart= ""
        
        sql = "SELECT TITULO, Id_Concurso AS ID, FECHA_ACTUALIZACION, tipo_concurso AS APARTADO, icono_seccion "
        sql = sql & "FROM C_CONCURSOS_DETALLE "
        sql = sql & "WHERE ("
        sql = sql & "web_es<>0"
        sql = sql & " AND (FECHA_PUBLICACION >= CONVERT(DATETIME, '" & dateadd("d",-7, pFecha) & "', 103) AND FECHA_ACTUALIZACION <= CONVERT(DATETIME, '" & pFecha & "', 103))"
    
        'sql = sql & "FECHA_PUBLICACION BETWEEN CONVERT(DATETIME, '" & dateadd("d",-7, pFecha) & "', 103) AND CONVERT(DATETIME, '" & pFecha & "', 103) OR "
        'sql = sql & "FECHA_ACTUALIZACION BETWEEN CONVERT(DATETIME, '" & dateadd("d",-7, pFecha) & "', 103) AND CONVERT(DATETIME, '" & pFecha & "', 103)"
        sql = sql & ") "
        
        sql = sql & " ORDER BY APARTADO "
        
        'test_inyeccion_sql sql
        primero = true
        
        resultado.Open sql, session("connPW")	',1,1
        %>
        <% if not resultado.eof then %>
        <div class="box_blanco"><% call BloqueTitulos() %></div>
        <% end if
        resultado.close %>
        
        
        <h2 class="tit_box"><span class="icon icon-arrow-down-right2"></span>Demandas</h2>
        <% 'Demandas	
        bloque="dem"
        strin="dem"		'dema
        ErrMesage=""
        Seccion2="DEMANDAS"
        num_titulo=0
        apart= ""
        
        swMostrar = true
        
        SQL_SELECT = "SELECT TITULO, ID, FECHA_ACTUALIZACION, TIPOSECCION AS APARTADO, TITULO_ING AS TITULO_AUX,"
        SQL_SELECT = SQL_SELECT & "icono_seccion FROM C_NOTICIAS_INMOBILIARIAS "
        
        SQL_WHERE = " WHERE "
        SQL_WHERE = SQL_WHERE & "(FECHA_NOTICIA >= CONVERT(DATETIME, '" & pFecha & "', 103) AND FECHA_ACTUALIZACION <= CONVERT(DATETIME, '" & pFecha & "', 103)) "
        SQL_WHERE = SQL_WHERE & "AND web_es <> 0 "
        SQL_WHERE = SQL_WHERE & "AND TIPO_NOTICIA = 'B' "
        
        SQL_ORDER = "ORDER BY TIPOSECCION "
        
        sql = SQL_SELECT & SQL_WHERE & SQL_ORDER
        
        'test_inyeccion_sql (sql_select & sql_where)
        primero = true
        
        resultado.Open sql, session("connPW")	',1,1
        %>
        <% if not resultado.eof then %>
        <div class="box_blanco"><% call BloqueTitulos() %></div>
        <% end if
        resultado.close %>
        





    </div>
</div>

<div style="clear:both;"></div>
<!--
<div style="text-align:center; margin:3em;">
	<input type="submit" class="btn" id="submit" value="Leer art&iacute;culos seleccionados">
</div>
-->
</form>
<%
set resultado = nothing

function FormatFecha(rFecha) 
	FormatFecha = FormatDateTime(rFecha, 1)
end function

function FormatFechaCorta(rFecha) 
	tmp = weekdayname(weekday(rFecha)) &  ", "
	FormatFechaCorta = tmp & FormatDateTime(rFecha, 2)
end function
%>
<script type="text/javascript">
$(document).ready(function() { 
	//$("#submit").unbind();
	$(".simplemodal").unbind();
		
	$("#fecha_actual").text("<%= FormatFecha(pFecha) %>");
	$("#fecha_actual_corta").text("<%= FormatFechaCorta(pFecha) %>");
	
	
	$(".simplemodal").click(function (e) {
		//e.preventDefault();
		var href = $(this).attr("href");
		href = href.substr( href.indexOf("?")+1, href.length);
		
		//var conds = getCookie("condiciones");
		if ( getCookie("condiciones")=="" ) {
			$("#ModalBox").load(
				"/acceso/password.asp",
				href,
				function(recibe, textStatus, xhr) { $("#ModalBox").modal("show") }
			);
			return false;	
		}
		
	});
	
	$("#frm_flash").submit(function() {
		if ($("#frm_flash input:checkbox:checked").length<=0) {
			//alert("Debe seleccionar algún artículo. \n\nMarque los artículos que quiera leer y vuelva a intentarlo.\n");
			$("#ModalBox").load(
				"/articulos/nada_seleccionado.asp",
				function(recibe, textStatus, xhr) { $("#ModalBox").modal("show"); }
			);
			return false;
		};
				
		if ( getCookie("condiciones")=="" ) {
			$("#ModalBox").load(
				"/acceso/password.asp",
				$("#frm_flash").serialize(),
				function(recibe, textStatus, xhr) {}
			);
			
			$("#ModalBox").modal("show");
			
			return false;
			
		}
		
	});
	
})
</script>




















