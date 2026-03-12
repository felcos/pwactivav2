<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% 'ON ERROR RESUME NEXT %>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<!--#include virtual="/dealanalysis/inc/sql.asp" -->
<!--#include virtual="/articulos/sin_acceso.asp" -->
<!--#include virtual="/lib/aspjson/JSON_2.0.4.asp" -->
<!--#include virtual="/lib/aspjson/JSON_UTIL_0.1.1.asp" -->
<!-- include virtual="/inc/js.asp" -->
<style type="text/css"> 
	#myMap {float:left; width: 100%; height: 480px;}
	.leer {
		cursor:pointer;	
	}
	<% if request.Cookies("dev")<>"" then %>
	.popover-check{
		display:block !important;
	}
	<% end if %>
</style>
<%
'Permisos de la licencia	
swMostrarDetalles = false
if session("pw_ws").accesoOperacionesHoy or session("pw_ws").accesoOperaciones then swMostrarDetalles = true	

swCargarMapa=false
settab = "list"

if not(session("navegador")="old") then 
	if request("sec")="oficinas" then swCargarMapa=true
end if
if swCargarMapa then settab = "map"

if request.form("tab")<>"" then 
	settab = request.Form("tab")
end if

limite_seleccion = LimiteSeleccionar(request.Form("sec"), request.Form("operacion"))

'requiere tener definida la variable sqlW
'Variables globales
public num_titulo 
public enlace
public target
public hoy

ver_dir = false

bloque="ope"
titulo="Operaciones"
'if request.Cookies("dev")="" then 
'	limite=300		'1500	300
'else
	limite=5000
'end if

strin="ope"
'origen="dealanalysis"

Set resultado = Server.CreateObject("ADODB.Recordset")

'recuento	
if intermediario="%" and vendedor="%" and comprador="%" then 
	sql = "SELECT *, seccion AS APARTADO FROM C_OPERACIONES WHERE (" & sqlW & ") "
else
	sql = "SELECT *, seccion AS APARTADO FROM C_OPERACIONES_AGENTES WHERE (" & sqlW & ") "	
end if

maps_sql = "SELECT ID, ID_TIPO_OPERACION, METROS_CUADRADOS, SuperficieSR, SuperficieBR, PRECIO_EUR, ID_TIPO_PRECIO, TIPOPRECIO, "
maps_sql = maps_sql & "inmueble, lat, lng, "
maps_sql = maps_sql & "TIPODIRECCION, nombre_calle_pre, NOMBRE_CALLE, NUMERO_CALLE, NOMBRE_ZONA "
maps_sql = maps_sql & "FROM C_OPERACIONES WHERE (" & sqlW & ") "

r_orden = request("orden")
r_ordent = request("ordent")

select case r_orden
case ""
	sql = sql & "ORDER BY seccion, FECHA_OPERACION DESC"
	r_ordent = ""
case "titulo"
	sql = sql & "ORDER BY TITULO"
	
case "fechaop"
	sql = sql & "ORDER BY FECHA_OPERACION"
case "superf"
	sql = sql & "ORDER BY METROS_CUADRADOS"
case "precio"
	sql = sql & "ORDER BY PRECIO_EUR"
case "fecha"
	'sql = sql & "ORDER BY FECHA_ACTUALIZACION"
	sql = sql & "ORDER BY FECHA_OPERACION"
	
case "dir"
	sql = sql & "ORDER BY NOMBRE_CALLE"
end select
if r_ordent="desc" then sql = sql & " DESC"

'orden = superf][ordent = desc

'response.Write(sql)
'response.End()

test_inyeccion_sql sql

resultado.Open sql, session("connPW"), 1, 1

if resultado.EOF and resultado.EOF then 
	ErrMesage = "<p>No Existe ning&uacute;n resultado.</p><p>Afine los criterios de su b&uacute;squeda.</p>"
'elseif resultado.recordcount=0 then
'	ErrMesage = "No Existe ning&uacute;n resultado. Afine los criterios de su b&uacute;squeda."
else
	resultado.movelast
	'resultado.movefirst
	
	if limite <= resultado.recordcount then 
		swMostrarDetalles=false
		ErrMesage = "Se han encontrado " & resultado.recordcount & " art&iacute;culos."
		ErrMesage = ErrMesage & "<br>El l&iacute;mite para las operaciones es de " & limite & ". Depure la b&uacute;squeda.<br>"
	end if
	
end if 

if ErrMesage<>"" then	
	%><script language="javascript">
		var informa = '' + '<%= ErrMesage %>'
		
		informa = informa + '<p style="float:right; font-size:14px;">'
		informa = informa + '<a href="#" onclick="subir();" style="color:#f47c04;"><strong>Cambiar Consulta</strong></a></p>'
		
		document.getElementById('div_instrucciones').innerHTML = informa;
    </script><%
	response.End()
end if
%>
<% if request.Cookies("dev")("request")<>"" then %>
<div class="caja dev">
	<% for each elto in request.Form 
        if request.Form(elto)<>"" then 
			'if elto="tab" or elto="lat" or elto="lng" then %>[<b><%= elto %></b> = <%= request.Form(elto) %>] &nbsp; <% 'end if
		end if 
    next %>
</div>
<% end if 

%>
<div class="miga"><h2 class="tit_miga02">Resultados</h2></div>
<div class="tit_resultados">
	<p id="div_informa"></p>
</div>
<form name="frm_opts" id="frm_opts" method="post" action="/dealanalysis/resultados/resultados.asp" target="_blank" autocomplete="off">
	<% for each elto in request.form 
		if elto<>"orden" and elto<>"ordent" and elto<>"origen" and elto<>"secc" then %>
			<input type="hidden" name="<%= elto %>" value="<%= request.form(elto) %>"/>
		<% end if
	next %>
    <input type="hidden" name="orden" value="<%= request.form("orden") %>"/>
    <input type="hidden" name="ordent" value="<%= request.form("ordent") %>"/>
    
</form>
<div class="PwTabs">
    <ul class="nav nav-tabs lineNavs" style="" id="">
        <li <% if settab="list" then %>class="active"<% end if %>><a href="#list" data-id="list" data-toggle="tab" aria-expanded="false">Listado</a></li>
        <% if request("sec")="oficinas" then %><li <% if settab="map" then %>class="active"<% end if %>><a href="#map" data-id="map" data-toggle="tab" aria-expanded="true">Mapa</a></li><% end if %>
        <li <% if settab="agencias" then %>class="active"<% end if %>><a href="#agencias" data-id="agencias" data-toggle="tab" aria-expanded="false">Agencias</a></li>
        <% if request("sec")="oficinas" then %><li <% if settab="distribucion" then %>class="active"<% end if %>><a href="#distribucion" data-id="distribucion" data-toggle="tab">Distribución</a></li><% end if %>
    </ul>
    <div id="sticky-marcador"></div>
    <div class="divCajaCheck" style=" background-color:#FFF;display:none;">
        <div class="contadorSelect"><!-- style="margin-top:-45px;"  -->
            <div  class="contadorSelectGris"style="background-color:#dedede">
                <span class="numero" id="sel-count">0</span>
                <span class="icon-checkmark"></span>
            </div>
            <input id="cmd-read-sel" type="button" value="Ver fichas" class="btn btn-sm">
            <input id="cmd-clear-sel" type="button" value="Borrar" class="btn blancoHover btn-sm">
            <p class="hidden alert" id="informa-limite">El l&iacute;mite es <span id="limite_seleccion">0</span> </p>
        </div>
    </div>
	<div class="tab-content">
    	<div class="tab-pane <% if settab="list" then %>active<% end if %>" id="list" >
            <%
            superficie=0
            ids=""
            contador=0
            num_titulo=0
            color="#FFF"
            %>
            <% if swMostrarDetalles then %>
            <div id="div_titulos" >
            <form name="frm_titulos" id="frm_titulos" method="post" action="/articulos/">
				<input type="hidden" data-form="busq" name="lat" value=""/>
                <input type="hidden" data-form="busq" name="lng" value=""/>
                <input type="hidden" data-form="busq" name="zoom" value=""/>
                <input type="hidden" data-form="busq" name="tab" value="<%= settab %>"/>

				<% for each elto in request.Form
					select case elto
					case "selected", "ope"
					case "lat", "lng", "zoom"
					case "tab"
					case else
						if request.Form(elto)<>"" then
							%><input type="hidden" data-form="busq" name="<%= elto %>" value="<%= request.Form(elto) %>"/><%
						end if
					end select
                next %>
                <!-- input type="hidden" data-form="busq" name="origen" value="dealanalysis"/ -->
                <!--#include virtual="/dealanalysis/resultados/inc_titulos.asp" -->
                
                <div style="text-align:center; margin-top:2.5em;">
                    <hr style="margin-bottom:1em;">
                    <input type="submit" id="submit" name="submit" value="Leer Art&iacute;culos Seleccionados" class="btn_3">
                </div>
                
                <% if request.Cookies("dev")("sql")<>"" then %>
                    <div class="dev mini"><%= sql %></div>
                <% end if %>
            </form>
            </div>
            <%
			informa = "<span class='tit_numero'>"
			if contador=1 then
				'informa = "Se ha encontrado 1 operaci&oacute;n"
				informa = informa & "1 operaci&oacute;n,"
			else
				'informa = "Se han encontrado " & contador & " operaciones"
				informa = contador & " operaciones,"
			end if
			informa = informa & "</span>"
			if superficie>0 then
				informa = informa & "<span class='tit_metros'>"
				'informa = informa & ", con un total de " & formatnumber(superficie,0) & " m&sup2;.</p>"
				informa = informa & " con un total de " & formatnumber(superficie,0) & " m&sup2;."
				informa = informa & "</span>"
			end if
			'<span class="tit_busqueda">XXXX </span>
			%>
            <script language="javascript">
                var informa;
                informa = "<%= informa %>"; 
				
                <% if ErrMesage="" then %>
                    //informa = informa + '<p style="float:right; font-size:14px;" ><a href="#" onclick="mostrar_formulario();" style="color:#f47c04;"><strong>Cambiar Consulta</strong></a></p>';
                <% else %>
                    informa = informa + '<%= ErrMesage %>';
                <% end if %>
                
                informa = informa + '</div>';
                /* onClick="document.getElementById('veroperaciones').click();" */
                //document.getElementById('div_instrucciones').innerHTML = informa;
                document.getElementById('div_informa').innerHTML = informa;
                document.getElementById('div_instrucciones').innerHTML = "";
            </script>
            <% else 	'swMostrarDetalles	
                'calculamos los detalles
                do while not resultado.eof
                    num_titulo=num_titulo+1
                    contador=contador+1
                    superficie = superficie + resultado("METROS_CUADRADOS")
                    
                    resultado.movenext
                loop
                
                if session("es_cliente") then
                    if session("acceso_activo") then
                        if not session("acceso_operaciones") then
                            call SinAcceso("Deal Analysis")
                        end if
                    else
                        call SinAcceso("Deal Analysis")
                    end if
                else
                    call NoCliente
                end if
            end if		'swMostrarDetalles %>
        <% if request.Cookies("dev")<>"" then '("sql") %>
        <div class="caja dev"><%= sql %></div>
        <% end if %>
        </div>
        <!-- / Titulos -->
		
        <% if request("sec")="oficinas" then %>
        <div class="tab-pane <% if settab="map" then %>active<% end if %>" id="map">
            <div id="myMap" class="myMap">
                <div class="alert alert-warning alert-dismissible rojo" >
                      <div>
                      <button type="button" class="close btn rojo" data-dismiss="alert" aria-label="Close">
                      <span aria-hidden="true">&times;</span></button>
                        <span class="icon-warning"></span>
                      <h4>La versión que esta utilizado de su navegador esta obsoleta</h4>
                      <p>Esto puede provocar que algunos elementos de la página se carguen se manera incorrecta o no se carguen. Puede actualizar o descargarse cualquiera <a href="#" class="clickNavegadores">de estos navegadores:</a></p>
                      
                       </div>
                      <div class="sinMargen ">
                        <ul class="clearfix">
                
                        <li><a href="https://windows.microsoft.com/es-es/internet-explorer/download-ie" target="_blank"><img src="/_inc/javier/img/gnral/nav-exp.jpg"></a></li>
                        <li><a href="https://www.google.com/chrome/browser/desktop/index.html" target="_blank"><img src="/_inc/javier/img/gnral/nav-chr.jpg"></a></li>
                        <li><a href="https://www.mozilla.org/es-ES/firefox/new/?utm_source=firefox-com&utm_medium=referral" target="_blank"><img src="/_inc/javier/img/gnral/nav-fx.jpg"></a></li>
                        <li><a href="https://www.apple.com/safari/"><img src="/_inc/javier/img/gnral/nav-saf.jpg" target="_blank"></a></li>
                        <li><a href="https://www.opera.com/es"><img src="/_inc/javier/img/gnral/nav-ope.jpg" target="_blank"></a></li>
                
                        </ul>
                      </div>
                   
                         <!--<div class="alert alert-success" role="alert">
                                <p>Puede provocar que algunos elementos de la página se carguen se manera incorrecta o no se carguen. Le recomendamos descargar una de estas opciones:</p>
                                </div>-->
                </div>
            </div>
            <div style="clear:both;"></div>
            <% if request.Cookies("dev")<>"" then %>
            <div class="caja dev">
            	<input type="button" id="VerMarkers" value="Muestra Markers" onclick="MuestraMarkers();"/> &nbsp;
                <input type="button" id="OcultarMarkers" value="Oculta Markers" onclick="OcultaMarkers();"/> &nbsp;
                
                <input type="button" value="Muestra Boxes" onclick="MuestraBoxes();"/> &nbsp;
                <input type="button" value="Oculta Boxes" onclick="OcultaBoxes();"/> &nbsp;
                // 
                <input type="button" value="loading" onclick="$('#cargando').fadeToggle();"/> &nbsp;
                // 
                <input type="button" value="block" onclick="bloquea();"/> &nbsp; - &nbsp; 
                <input type="button" value="reload" onclick="recarga();"/>
                <hr />
                
                <input type="button" value="seleccionados" onclick="ver_seleccionados();"/>
            </div>
    		<% end if %>
        </div>
        <% end if %>
        <!-- / Mapa -->
		
        <div class="tab-pane <% if settab="agencias" then %>active<% end if %>" id="agencias"><!--#include virtual="/dealanalysis/resultados/inc_agencias.asp" --></div><!-- / Agencias -->
		
		<% if request("sec")="oficinas" then %>
        <div class="tab-pane <% if settab="distribucion" then %>active<% end if %>" id="distribucion"><!--#include virtual="/dealanalysis/resultados/inc_distribucion.asp" --></div>
        <% end if %><!-- / Distribución -->

	</div><!-- FIN resp-tabs-container -->
</div>
<%
set resultado=nothing
%>
<% if request.Cookies("dev")<>"" then %>
    <div class="caja dev">
        <li>Limite Seleccion: <%= limite_seleccion %> &nbsp; // &nbsp; <%= request.Form("sec") %> &nbsp; // &nbsp; <%= request.Form("operacion") %></li>
        <li>zoom: <span id="map-zoom">[map-zoom]</span> // <span id="map-zoom2">[map-zoom2]</span> &nbsp; <span id="cargando" style="display:none;"><img src="/img/loading.gif"></span></li>
        <br />
    	<li>Total Ops mapa: <span id="total_ops"></span></li>
    	<li>Ops sin coords: <span id="faltan_ops"></span><span><ul id="markersFaltanOps"></ul></span></li>
    </div>
    <!-- 
    <div class="caja med">
        <div class="demo">
            <p class="alert">container</p>
        </div>
    </div>
    -->
    
    <% if ErrMesage<>"" then %>
    	<div style="background:#FFFFCC; padding:3px; margin-top:3px;font-size:11px;border:#000000 1px solid;">ErrMesage: <%= ErrMesage %></div>
    <% end if %>
    
<% end if %>

<% sub MuestraError(msg) %>
	<div name="div_aviso_error" id="div_aviso_error" class="caja_ancha" style="border:#900 0px solid; padding:20px; font-size:18px;">
		<%= ErrMesage %>
    </div>
<% end sub %>

<% function PrecioRenta(byRef pRS)	
	'devuelve un precio/renta homogéneo.
	' si es alquiler, en €/m2/mes
	' si no es alquiler, en €/m2
	' devuelve 0 si precio/renta no está disponible o calculable
	PrecioRenta=0
	
	if pRS("id_tipo_operacion")=2 then		' RENTA		€/m2/mes
		select case pRS("id_tipo_precio")
		case 1, 11
			PrecioRenta=pRS("PRECIO_EUR")
		case 2, 10, 9
			if pRS("METROS_CUADRADOS")>0 then
				PrecioRenta=pRS("PRECIO_EUR")/pRS("METROS_CUADRADOS")
			end if
		end select
	else									' PRECIO	€/m2
		select case pRS("id_tipo_precio")
		case 4, 10
			PrecioRenta=pRS("PRECIO_EUR")
		case 5, 8
			if pRS("METROS_CUADRADOS")>0 then
				PrecioRenta=pRS("PRECIO_EUR")/pRS("METROS_CUADRADOS")
			end if
		case 12
			PrecioRenta=pRS("PRECIO_EUR") * 1000000
		end select
	end if
	
end function %>

<% function CalcularSeccionOp(pIds)	
	cIds = "," & pIds
	
	Set rsSecc = Server.CreateObject("ADODB.Recordset")
	rsSecc.open "SELECT * FROM TIPOS_DE_SECCIONES_OPERACIONES", session("connPW")	', 1, 1
	do while not rsSecc.eof
		
    	cIds = replace(cIds, "," & rsSecc("ID") & ",", lcase(rsSecc("NOMBRE")) & ",")
		rsSecc.movenext
	loop
	
	rsSecc.close
	set rsSecc=nothing
	
	'cIds = replace(cIds, ",", "/")
	'cIds = cIds & "/"
	'cIds = replace(cIds, "//", "")
	cIds = replace(cIds, ",", "")
	
	CalcularSeccionOp=cIds 
	
end function %>

<% sub div_orden(p_orden) 
	select case p_orden
	case "dir"
		c_desc = "Ordenar por Direcci&oacute;n"
	case "superf"
		c_desc = "Ordenar por Superficie"
	case "precio"
		c_desc = "Ordenar por Precio"
	case "fecha"
		c_desc = "Ordenar por Fecha de Operaci&oacute;n"
	end select
	
	if r_orden=p_orden then
		if r_ordent="desc" then 
			img = "/img/sort_asc.png"
			n_ordent = ""
			n_orden = ""
			
		elseif r_ordent="asc" then
			img = "/img/sort_asc.png"
			n_ordent = "desc"
			n_orden = p_orden
			
		elseif r_ordent="" then
			img = "/img/sort_desc.png"
			n_ordent = "desc"
			n_orden = p_orden
			
		else
			response.End()
		end if
	else
		img = "/img/sort_both.png"
		n_ordent = ""
		n_orden = p_orden
	end if

	
	if p_orden="null" then %>
		<img src="/img/transparent.png" width="1" height="19" />
    <% else %>
		<a href="javascript:ordena('<%= n_orden %>', '<%= n_ordent %>');"><img src="<%= img %>" width="19" height="19" alt="Ordenar" longdesc="<%= c_desc %>" /></a>
    <% end if 
end sub %>

<script type="text/javascript">

function envia () {
	$("#frm_deal").submit();
};

function ordena(ord, ordt) {
	document.frm_deal.orden.value=ord;
	document.frm_deal.ordent.value=ordt;
	$("#frm_deal").submit();
};

function resetea() {
	/*
	alert('aaaa');
	*/
	document.frm_deal.orden.value="";
	document.frm_deal.ordent.value="";
	/*
	$('#orden').value(''); 
	$('#ordent').value(''); 
	$('#frm_deal').submit();
	*/
	return false;
}


function ver_op(op) {
	//var href = $("#op" + op).attr("href");
	//href = href.substr( href.indexOf("?")+1, href.length);
	var href = "ope=" + op;
	
	var opts = $("#frm_titulos>input[data-form='busq']");
	
	href = href + "&" + opts.serialize();
	
	if ( getCookie("condiciones")=="" ) {
		$("#ModalBox").load(
			"/acceso/password.asp",
			href,
			function(recibe, textStatus, xhr) {}
		);
		
		$("#ModalBox").modal("show");
		
		return false;
		
	} else {
		href = "/articulos/?" + href;
		window.location = href;
	}
	
}
var limite_seleccion = <%= limite_seleccion %>;

$(document).ready(function () {
	$("#limite_seleccion").html(limite_seleccion);
	
	$("#sel-count").html("0");
	$(".divCajaCheck").hide();
	
	$("#frm_titulos input:checkbox").change(function(e) {
        console.log("checkbox change");
		
		var lista = $("#frm_titulos input:checkbox:checked");
		$("#sel-count").html(lista.length);
		
		if (lista.length==0) {
			$(".divCajaCheck").slideUp();
			$(".divCajaCheck .contadorSelect").animate({marginTop:'-45px'})
		} else {
			$(".divCajaCheck").slideDown();
			$(".divCajaCheck .contadorSelect").animate({marginTop:'0px'})
		}
		
		if (limite_seleccion>0) {
			
			if (lista.length>=(limite_seleccion-1)) {
				$("#informa-limite").removeClass("hidden");
			} else {
				$("#informa-limite").addClass("hidden");
			}
			
			
		}
		
		$(".popover-check>button").removeClass("checked")
		var xxx = [];
		$.each(lista, function(ii, val) { 
			xxx.push(val.value);
			$("#chkMap" + val.value).addClass("checked");
		});
		//console.log(xxx);
		
		if (lista.length>=limite_seleccion) {
			$("#frm_titulos input:checkbox:not(:checked)").attr("disabled", "disabled");
			var yyy = ["limite alcanzado: "];
			$.each( $(".btnCheck"), function(ii, val) {
				if ($(val).hasClass("checked")) {
					//console.log($(val).attr("id"))
					//yyy.push($(val).attr("id"));
					//yyy.push(val);
				} else {
					$(val).hide();
				}
			});
			console.log(yyy);
			//return false;
			
		} else {
			$("#frm_titulos input:checkbox:not(:checked)").removeAttr("disabled");
			$(".btnCheck").show();
			
		}
		
		
		return false;
		
    });
	
	$(".deals_a").click(function(e) {
		e.preventDefault();
	});
	
	$("#frm_titulos").submit(function(){
	//$("#frm_titulos").submit(function(){
		if ($("#frm_titulos input:checkbox:checked").length<=0) {
			$("#ModalBox").load(
				"/articulos/nada_seleccionado.asp",
				function(recibe, textStatus, xhr) { $("#ModalBox").modal("show"); }
			);
			return false;
		};
		
		//if ( getCookie("condiciones")=="" ) {
		//	$("#ModalBox").load(
		//		"/acceso/password.asp",
		//		$("#frm_titulos").serialize(),
		//		function(recibe, textStatus, xhr) {}
		//	);
		//	
		//	$("#ModalBox").modal("show");
		//	
		//	return false;
		//	
		//} else {
		//	$("#submit").click();
		//}
		
	});
	
	$("a[data-toggle='tab']").on("shown.bs.tab", function (e) {
		var tab = $(e.target).data("id");
		
		$("#frm_titulos input[name='tab']").val( tab );
		console.log( "change tab: " + tab );
		
		<% if swCargarMapa then %>
		if (reload_map) {
			console.log("RELOAD MAP")
			
			google.maps.event.trigger(map, "resize");
			reload_map = false;
			
			<% if request.Form("lat")="" then %>
				console.log("set center", "def", "def")
				map.setCenter( {lat: 40.45509438392602, lng: -3.692486281662004} );
				map.setZoom(11);
			<% else %>
				console.log("set center", <%= request.Form("lat") %>, <%= request.Form("lng") %>)
				map.setCenter( {lat:<%= request.Form("lat") %>, lng:<%= request.Form("lng") %>} );
				map.setZoom(<%= request.Form("zoom") %>);
			<% end if %>
		}
		<% end if %>
		
	});
	
	<% if request.Form("selected")<>"" then %>
		var sel_str = "<%= request.Form("selected") %>";
		var sel_arr = sel_str.split(",").map(
			function(x) {
				return parseInt(x,10)
			});
		$.each(sel_arr, function(ii, elto) {
			console.log(ii, elto);
			$("#chkOp" + elto).click();
		})
	<% end if %>
	
});

<% if swCargarMapa then %>
	var reload_map = false;
	
	var act_map = {'zoom':0, 'lat': 0, 'lng': 0}
	var act_zoom = 0;
	
	var datos_cargados = "";
	var mapa_bloqueado = false;
	
	var agentes_todos;
	var images = new Array();
	var startTime = new Date()
	
	$.ajax({
		url: "/dealanalysis/resultados/q_agencias.asp",
		data: "sqlw=<%= sqlW %>",
		async:false,
		success: function(recibe) {
			//console.log("recibe: " + recibe)
			agentes_todos = $.parseJSON(recibe)
			
			/*
			if ( jQuery.isEmptyObject(recibe) ) {
				//console.log(" - " + operacion["ID"])
				agentes = []
			} else {
				agentes = $.parseJSON(recibe)
			}
			*/
		},
		error: function(xhr, status, err) {
			console.log("ERR: " + err)
		}
	});
	
	var opciones;
	
	<% if request.Form("zoom")="" then %>
	opciones = {zoom: 11, center: {lat: 40.45509438392602, lng: -3.692486281662004}};
	<% else %>
	opciones = {zoom: <%= request.Form("zoom") %>, center: {lat:<%= request.Form("lat") %>, lng:<%= request.Form("lng") %>}};
	<% end if %>
	
	<% if request.cookies("dev")<>"" then %>
	opciones.scrollwheel = false
	<% end if %>
	
	var map = new google.maps.Map(document.getElementById("myMap"), opciones);
	
	google.maps.event.addListener(map, "bounds_changed", function() {
		//console.log("bounds_changed");	//zoom_changed
		if (act_map.zoom==map.getZoom() & act_map.lat==map.getCenter().lat() & act_map.lng==map.getCenter().lng()) {return}	//act_zoom
		
		act_map.zoom = map.getZoom();
		act_map.lat = map.getCenter().lat();
		act_map.lng = map.getCenter().lng();
		
		$("#frm_titulos input[name='zoom']").val(act_map.zoom);
		$("#frm_titulos input[name='lat']").val(act_map.lat);
		$("#frm_titulos input[name='lng']").val(act_map.lng);
		
		$("#map-zoom2").html(act_zoom);
		
		if (map.getZoom()<13) {
			//if (datos_cargados=="boxes") {
				OcultaBoxes();
				MuestraMarkers()
			//}
			
		} else {				
			//if (datos_cargados=="markers") {
				OcultaMarkers();
				MuestraBoxes();
			//}
		};
	});
	
	var bounds = new google.maps.LatLngBounds();
	
	var counter = 0;
	var faltan_ops = 0;
	
	var operaciones = <%= QueryToJSON(session("connPW"), maps_sql).Flush %>
	
	var markerList = [];
	var infoboxesList = [];
	
	var img;
	
	$.each(operaciones, function(ii,operacion){
		operacion.agentes = [];
		
		//console.log(agentes_todos)
		
		$.each(agentes_todos, function(jj, agente) {
			if (agente.ID == operacion.ID) {
				operacion.agentes.push( { NOMBRE: agente.NOMBRE, logotipo: agente.logotipo} )
				if (agente.logotipo === null) {
					console.log("falta img: " + agente.NOMBRE)
				} else {
					img =  new Image();
					img.src = "/_inc/javier/img/empresas/" + agente.logotipo;
					images.push(img);
				}
			}
		});
		
		if (operacion["lat"]==null) {
			var listItem = $("<li/>").text("op : " +  operacion["ID"]);
			faltan_ops++;
			$("#markersFaltanOps").append(listItem);
			
		} else  {
			loadMarker(operacion);
			CargaInfoBox(operacion);
			
			counter++;
			
		};
		
		$("#faltan_ops").html( faltan_ops )
		$("#total_ops").html( counter )
		
	});
	
	function fitMap() {
		<% 'if request.Cookies("dev")="" then %>
		$.each(
			markerList, 
			function(i,item){
				//console.log(item.getPosition());
				bounds.extend(item.getPosition());
			}
		);
		map.fitBounds(bounds);
		<% 'end if %>
	}
	
	function loadMarker(op) {
		var myLatlng = new google.maps.LatLng(op["lat"], op["lng"]);
		
		var marker = new google.maps.Marker({
			id: op["ID"],
			map: map, 
			title: op["TITULO"],
			position: myLatlng,
			icon: "/img/ico-mapa02.png",
			visible:false
			
		});
		markerList[counter] = marker;
		
		//trigger
		//https://stackoverflow.com/questions/12102598/trigger-event-with-infowindow-or-infobox-on-click-google-map-api-v3
		
		<% if request.form("zoom")="" then %>
		bounds.extend(myLatlng);
		map.fitBounds(bounds);
		<% end if %>
		
	}
	
	function CargaInfoBox( operacion ) {
		//console.log( "  CargaInfoBox: " + operacion["ID"] );
		var myLatlng = new google.maps.LatLng(operacion["lat"], operacion["lng"]);
		
		var infobox = new InfoBox({
			content: contenidoInfoBox( operacion ),	//document.getElementById("infobox")
			disableAutoPan: true,
			//enableEventPropagation: true,
			enableEventPropagation: false,
			maxWidth: 150,
			//pixelOffset: new google.maps.Size(-40, -45),
			zIndex: 1000,
			closeBoxURL: "",
			position: myLatlng,
			isHidden: true
		});
		infobox.open(map);
		
		//infoboxesList.push( infobox )
		infoboxesList[counter] = infobox;
	}
	
	function contenidoInfoBox( operacion ) {
		var moneda;
		var importe;
		var superf;
		var lista = $("#frm_titulos input:checkbox:checked");
		
		var marcado = "";
		
		$.each(lista, function(ii, val) {
			if ( val.value==operacion.ID) {
				console.log(val.value, operacion.ID);
				marcado = " checked";
			}
		//	$("#chkMap" + val.value).addClass("checked");
		//	$("#chkMap" + val.value).hasClass("checked");
		//$("#chkMap" + operacion).addClass("checked");
		});
		
		<% if swMostrarDetalles then
		'if session("pw_ws").accesoInfoInmuebles then  %>
			moneda = operacion["TIPOPRECIO"].toLowerCase().replace("m2", "m&sup2;").replace("€", "&euro;");
			importe = operacion["PRECIO_EUR"];
			superf = operacion["METROS_CUADRADOS"];
			
			if (operacion["ID_TIPO_OPERACION"]=="1" | operacion["ID_TIPO_OPERACION"]=="3") {
				if (operacion["ID_TIPO_PRECIO"]=="8") {
					if (superf>0) {
						importe = Math.round(importe/superf);
						moneda = moneda + "/m&sup2;";
					}
					if (importe!=null) {
						importe = importe.toLocaleString("eu+", { maximumFractionDigits: 0})
					}
				}
			} else {
				if (importe!=null) {
					importe = importe.toLocaleString("eu+", { maximumFractionDigits: 2});
				}
			}
			if (importe==0) {
				importe = "N/D";
				moneda = "&euro;/m&sup2;";
			}
		<% else %>
			moneda = "";	//	'&euro;/m&sup2;
			importe = "<img src='/img/lock.svg' width='14' height='14'/>";
			superf = "<img src='/img/lock.svg' width='14' height='14'/>";
		<% end if %>
		//console.log(operacion["PRECIO_EUR"], operacion["TIPOPRECIO"], operacion["METROS_CUADRADOS"], " > ", importe.toLocaleString("eu+", { maximumFractionDigits: 2}), moneda)
		
		var res = '<div class="infoboxPosition" data-id="' + operacion["ID"] + '">';
		var res = res + '<div class="popover top" id="">';
		
		res = res + '<div class="popover-check">';
		res = res + '<button type="button" id="chkMap' + operacion["ID"] + '" class="btn btnCheck' + marcado + '" onClick="sel_op(' + operacion["ID"] + ');"></button>';
		res = res + '</div>';
		
		res = res + '<a onClick="javascript:ver_op(' + operacion["ID"] + ')" id="maplink' + operacion["ID"] + '" class="leer">';
		//res = res + '<a href="/articulos/?ope=' + operacion["ID"] + '" id="maplink' + operacion["ID"] + '" onClick="ver_op(' + operacion["ID"] + ');" class="deal_map_a">';
		res = res + '<table class="popover-tb01">';	// onclick="ver_op(' + operacion["ID"] + ')"
		res = res + '<tbody>';
		
		<% if request.Cookies("dev")<>"" then %>
		res = res + '<tr>';
		res = res + '<td>id: </td>';
		res = res + '<td nowrap>' + operacion["ID"] + '</td>';
		res = res + '</tr>';
		
		res = res + '<tr>';
		res = res + '<td nowrap colspan="2">';
		res = res + operacion["NOMBRE_CALLE"] + ', ' + operacion["NUMERO_CALLE"] + '</td>';
		res = res + '</tr>';
		
		<% end if %>
		
		res = res + '<tr>';
		res = res + '<td nowrap>' + importe + '</td>';
		res = res + '<td>' + moneda + '</td>';
		res = res + '</tr>';
		
		if (operacion["ID_TIPO_OPERACION"]=="2" | operacion["ID_TIPO_OPERACION"]=="4") {
			res = res + '<tr>';
			res = res + '<td>' + superf.toLocaleString() + '</td>';
			res = res + '<td>m&sup2;</td>';
			res = res + '</tr>';
		}
		
		res = res + '<tr><td colspan="2">';
		for (var jj=0; jj<operacion.agentes.length; jj++) {
			if (operacion.agentes[jj].logotipo === null) {
				//console.log("falta img: " + operacion.agentes[jj].NOMBRE)
			} else {
				res = res + '<img src="/_inc/javier/img/empresas/' + operacion.agentes[jj].logotipo + '">';
				//res = res + operacion.agentes[jj].logotipo + ' ';
			}
		};
		res = res + '</td></tr>';
		
		
		res = res + '</tbody>';
		res = res + '</table>';
		res = res + '</a>';
		
		res = res + '<div class="arrow" style="left: 47.6449%;"></div>';
		
		
		res = res + '</div>';
		res = res + '</div>';
		
		return(res);
	}
	
	function MuestraMarkers() {
		for (ii=0; ii<markerList.length; ii++) {
			markerList[ii].setVisible(true);
		}
		datos_cargados = "markers";
	}
	
	function OcultaMarkers() {
		for (ii=0; ii<markerList.length; ii++) {
			markerList[ii].setVisible(false);
		}
	}
	
	function MuestraBoxes() {
		for (ii=0; ii<infoboxesList.length; ii++) {
			infoboxesList[ii].setVisible(true);
		}
		datos_cargados = "boxes";
	}
	
	function OcultaBoxes() {
		for (ii=0; ii<infoboxesList.length; ii++) {
			infoboxesList[ii].setVisible(false);
		}
	}
	
	function bloquea() {
		if (mapa_bloqueado) {
			//$( "#myMap" ).isLoading( "hide" );
			mapa_bloqueado=false;
		} else {
			//$( "#myMap" ).isLoading({
			//	text:       "Cargando... &nbsp; <img src='/img/busy.gif'>",
			//	position:   "overlay"
			//});
			mapa_bloqueado=true;
		}
		
	}
	
	function recarga() {
		
		$('#frm_deal').submit();
	}
	
	function ver_seleccionados() {
		OcultaMarkers();
		//MuestraBoxes();
		datos_cargados = "boxes";
		
		for (ii=0; ii<markerList.length; ii++) {
			var chk = "#chkOp" + $(infoboxesList[ii].content_).data("id")
			
			infoboxesList[ii].setVisible( $(chk).is(":checked") );
			markerList[ii].setVisible( $(chk).is(":checked") );
		}
	}
	
	function sel_op(op) {
		$("#chkOp" + op).click();
		return false;
	}
	
	$(document).ready(function () {
		actZoom = map.getZoom();
		$("#map-zoom").html(actZoom);
		
		if (actZoom<13) {
			MuestraMarkers()
		} else {
			MuestraBoxes()
		};
		
		
		//$(".deals_check").click(function(e){
		//	$(this).children("input:checkbox").click();
		//	e.stopPropagation();
		//});
		
		<% if settab <> "map" then %>
			console.log("tabmap <> map")
			reload_map = true
		<% end if
		
		'if request.Form("tab")<>"" then 
		if 1=2 then
			select case request.Form("tab")
			case "list"
				tab = "#operaciones"
			case else
				tab = request.Form("tab")
			end select %>
			var tab_href = "<%= tab %>"
			console.log("set tab: " + tab_href);
			$(".PwTabs .nav-tabs a[href='" + tab_href + "']").tab("show");
			//$(".nav-tabs a[href='#home']").tab("show")
		<% end if %>
		
		//console.log("ready2")
		/*
		google.maps.event.addListener(map, "bounds_changed", function() {
			console.log("bounds_changed")
			
			//$("#map-zoom2").html(map.getZoom());
			//$("#cargando").fadeOut();
			if (datos_cargados=="boxes") {
				OcultaBoxes();
				MuestraBoxes();
			}
		});
		*/
		
		//$( "#myMap" ).isLoading( "hide" );
		
		$("#cmd-clear-sel").click(function(e) {
			$("#frm_titulos input:checkbox").removeAttr("disabled");
			$("#frm_titulos input:checkbox").removeAttr("checked");
			
			$(".popover-check>button").removeClass("checked")
			$(".btnCheck").show();
			
			//$("#sel-count").html("0");
			$(".divCajaCheck").slideUp();
			$(".divCajaCheck .contadorSelect").animate({marginTop:"-45px"})
		});
		
		$("#cmd-read-sel").click(function(e) {
			console.log("cmd-read-sel");
			//$("#frm_titulos").submit();
			$("#submit").click();
		});
		
	})
	
$(window).scroll(recolocarContador);
recolocarContador();

function recolocarContador() {
	var window_top = $(window).scrollTop();
	var div_top = $("#sticky-marcador").offset().top;
	if (window_top > div_top) {
		//alert("salta")
	   $(".divCajaCheck").addClass("stick");
	} else {
	   $(".divCajaCheck").removeClass("stick");
	}
}
</script>
<% end if %>
