<input type="submit" id="titSubmit" value="Leer Artículos Seleccionados" style="display:none;">
<%
'on error resume next

sel_year = request.form("year")
if sel_year="" then sel_year = "2018"

localidad = trim(lcase(request.form("ciudad")))
agencia = request.form("agencia")

if localidad="" then 
	busqueda_ver = "ESPA&Ntilde;A "
	'busqueda_ver = "EUROPA "
	agentes_ver = "ESPA&Ntilde;A "
	
else
	busqueda_ver = localidad
	agentes_ver = localidad
	
	if request.form("zona")<>"" then 
		busqueda_ver = request.form("zona") & ", " & busqueda_ver
		agentes_ver = request.form("zona")
	else
		if request.form("subzona")<>"" then
			busqueda_ver = request.form("subzona") & ", " & busqueda_ver
			agentes_ver = request.form("subzona")
		else
			busqueda_ver = busqueda_ver + " "
		end if
	end if
end if

if request.Form("agencia_nombre")<>"" then
	busqueda_ver = busqueda_ver & ", " & request.form("agencia_nombre")
end if

counter = 0
total_superficie = 0

sqlw = "id_tipo_inmueble=0"

if sel_year="2018" then
	sqlw = sqlw & " AND disponible_fecha IS NOT NULL AND disponible_min>0"
else
	sqlw = sqlw & " AND disponible_fecha IS NOT NULL "
	sqlw = sqlw & " AND t1.superficie>0"
end if

if localidad="" then
	sqlw = sqlw & " AND id_pais = 1"
else
	sqlw = sqlw & " AND "
	if localidad = "madrid" then
		sqlw = sqlw & "id_provincia = 2"
	elseif localidad = "barcelona" then
		sqlw = sqlw & "id_provincia = 3"
	elseif localidad = "londres" then
		sqlw = sqlw & "id_provincia = 60"
	else
		sqlw = sqlw & "localidad = '" & localidad & "'"
	end if
end if

if agencia<>"" then
	sqlw = sqlw & " AND dirs_w_inmuebles.id IN "
	'sqlw = sqlw & " AND id_edificio IN "
	sqlw = sqlw & "(SELECT DISTINCT id_inmueble FROM inmuebles_agentes WHERE (id_empresa = " & agencia & " AND tipo = 'comerc'))"
end if

if request.form("id_subzona")<>"" then
	sqlw = sqlw & " AND id_subzona=" & request.form("id_subzona")

elseif request.form("id_zona")<>"" then
	sqlw = sqlw & " AND id_area=" & request.form("id_zona")
	
end if

if session("pw_ws").accesoTakeUp then 
	if sel_year="2018" then
		sql_agencias = "SELECT id_edificio AS id_inmueble, agencia_id_empresa AS id_empresa, agencia_nombre as empresa, agencia_logotipo AS logotipo "
		sql_agencias = sql_agencias & "FROM dirs_w_inmuebles_agencias WHERE (" & sqlw & ") "
		
		'rentas
		sql_rentas = "SELECT id_inmueble, MIN(disponible_renta) AS renta_min, MAX(disponible_renta) AS renta_max, AVG(disponible_renta) AS renta_media "
		sql_rentas = sql_rentas & "FROM inmuebles_plantas WHERE ("
		sql_rentas = sql_rentas & "id_inmueble IN (SELECT ID FROM dirs_w_inmuebles WHERE " & sqlw & ") "
		sql_rentas = sql_rentas & "AND (disponible_renta IS NOT NULL) "
		sql_rentas = sql_rentas & "AND (seccion_operacion = 1)"
		sql_rentas = sql_rentas & ") "
		sql_rentas = sql_rentas & "GROUP BY id_inmueble"
		
	else
		sql_agencias = "SELECT t3.id_inmueble AS id_inmueble, t3.id_empresa AS agencia_id_empresa, t3.NOMBRE AS agencia_nombre, t3.logotipo AS agencia_logotipo "
		sql_agencias = sql_agencias & "FROM dirs_w_inmuebles RIGHT OUTER JOIN inmuebles_disponibilidad t1 INNER JOIN "
		sql_agencias = sql_agencias & "(SELECT id_inmueble, MAX(fecha) AS MaxDate FROM inmuebles_disponibilidad WHERE fecha <= '31/12/" & sel_year & "' GROUP BY id_inmueble) t2 "
		sql_agencias = sql_agencias & "ON t1.id_inmueble = t2.id_inmueble AND t1.fecha = t2.MaxDate "
		sql_agencias = sql_agencias & "ON dbo.dirs_w_inmuebles.id_edificio = t1.id_inmueble "
		'sql_agencias = sql_agencias & "LEFT OUTER JOIN "
		sql_agencias = sql_agencias & "INNER JOIN "
		sql_agencias = sql_agencias & "(SELECT inmuebles_agentes.id_inmueble, inmuebles_agentes.id_empresa, inmuebles_agentes.fecha_desde, inmuebles_agentes.fecha_hasta, EMPRESAS.NOMBRE, EMPRESAS.logotipo "
		sql_agencias = sql_agencias & "FROM inmuebles_agentes INNER JOIN EMPRESAS ON inmuebles_agentes.id_empresa = EMPRESAS.ID "
		sql_agencias = sql_agencias & "WHERE EMPRESAS.ID_ACTIVIDAD = 28 AND inmuebles_agentes.tipo = 'comerc' AND inmuebles_agentes.fecha_desde <= '01/01/" & sel_year & "' AND "
		sql_agencias = sql_agencias & "(inmuebles_agentes.fecha_hasta > '31/12/" & sel_year & "' OR inmuebles_agentes.fecha_hasta IS NULL)"
		sql_agencias = sql_agencias & ") t3 "
		sql_agencias = sql_agencias & "ON dirs_w_inmuebles.id_edificio = t3.id_inmueble "
		sql_agencias = sql_agencias & "WHERE (" & sqlw & ") "
		
	end if
end if 

if sel_year="2018" then
	sql = "SELECT * FROM dirs_w_inmuebles WHERE (" & sqlw & ") ORDER BY localidad, nombre_calle, numero_calle_ord, numero_calle, nombre_completo"
	
else
	sql = "SELECT dirs_w_inmuebles.*, t1.fecha AS hist_fecha, t1.superficie AS hist_superficie, "
	sql = sql & "t1.renta_min AS hist_renta_min, t1.renta_max AS hist_renta_max, t1.porcentaje AS int_porcentaje "
	sql = sql & "FROM inmuebles_disponibilidad t1 INNER JOIN "
	sql = sql & "(SELECT id_inmueble, MAX(fecha) AS MaxDate FROM inmuebles_disponibilidad WHERE "
	sql = sql & "fecha <= '31/12/" & sel_year & "' "
	sql = sql & "GROUP BY id_inmueble) t2 ON "
	sql = sql & "t1.id_inmueble = t2.id_inmueble AND t1.fecha = t2.MaxDate LEFT OUTER JOIN dbo.dirs_w_inmuebles ON "
	sql = sql & "t1.id_inmueble = dbo.dirs_w_inmuebles.id_edificio "
	
	sql = sql & "WHERE (" & sqlw & ") ORDER BY localidad, nombre_calle, numero_calle_ord, numero_calle, nombre_completo"
	
end if
sql_inmuebles = sql
%>
<div class="dispTitu">
    <table class="tbDispon">
    <thead>
        <tr class="cabeza">
            <th class="tbDisp-Plta">Planta</th>
            <th class="tbDisp-Tipo">Tipo</th>
            <% if sel_year="2018" then %>
            <th class="tbDisp-Min">M&iacute;n</th><!-- <a href="javascript:ordenar('min');" data-field="min"></a> -->
            <th class="tbDisp-Max">M&aacute;x</th><!-- <a href="javascript:ordenar('max');" data-field="max"></a> -->
            <% else %>
            <th class="tbDisp-Max">Superf.</th><!-- <a href="javascript:ordenar('sup');" data-field="sup"></a> -->
            <% end if %>
            <th class="tbDisp-Renta">Renta<br>Salida</th> 
            <th class="tbDisp-Fecha">@Fecha</th> 
        </tr>
    </thead>
    </table>
</div>
<%
if request.Cookies("dev")<>"" then %>
	<div style="font-size:12px; border-top: 1px solid red; margin:2px 0;"><a href="#" onclick="$('#sql-dev').slideToggle('fast'); return false;">
		<strong>disponibilidad:</strong>
		<span class="peq" style="float:right;"><span id="timer">0</span> ms</span></a>
		<div id="sql-dev" style="display:none_; margin:6px 0 0 6px; border:#CCC 1px solid; font-size:9px"><%= sql %></div>
		<div id="sql-request" style="display:none; margin:6px 0 0 6px; border:#CCC 1px solid; font-size:9px">
		<% if request.Cookies("dev")<>"" then
			for each elto in request.form 
				%><%= elto %>: <%= request.form(elto) %> // <% 
			next
		end if %>
        </div>
	</div><% 	
end if

'response.Write(sql)
rsBusq.open sql, session("connPW")

if swMostrarDetalles then
	do while not rsBusq.eof 
		call LineaDisp
		rsBusq.movenext
	loop
else	'swMostrarDetalles
	'calculamos los detalles
	do while not rsBusq.eof
		counter = counter + 1
		rsBusq.movenext
	loop
	if session("IniCliente")=0 then
		call SinAcceso("Take Up")
	else
		call NoCliente
	end if
end if
rsBusq.close
t_fin = timer
%>
<script type="text/javascript">
	iconoActivo = "/img/ico-mapa02.png";
	
	$("#cmd-asociar").removeClass("blancoHover");
	$("#cmd-generar").removeClass("blancoHover");
	$("#cmd-cargar").removeClass("blancoHover");
	
	//console.log("< %= sql_agencias %>")
	
	function AsociarDatos() {
		//console.log("AsociarDatos", "CANCELADO")
		//return false;
		//var t0 = new Date;
		
		<% if sel_year="2018" then %>
		if (rentas_todas) {
			$.each(rentas_todas, function(jj, renta) {
				var inm = inmueble(renta.id_inmueble);
				if (inm) {
					inm.renta = { min: renta.renta_min, max: renta.renta_max, media: renta.renta_media} 
					var calc_renta = "" + inm.renta.min;
					if (inm.renta.max!=inm.renta.min) {
						calc_renta = calc_renta + "/" + inm.renta.max;
					}
					calc_renta = calc_renta.replace(".", ",");
					//calc_renta = calc_renta + " <span>&euro;/m&sup2;</sup>";
					$(".tbDisp-Renta[data-id='" + inm.id + "']").html( calc_renta )
				}
			});
		}
		<% end if %>
		
		if (agentes_todos) {
			$.each(agentes_todos, function(jj, agente) {
				var inm = inmueble(agente.id_inmueble);
				if (inm) {
					if (!inm.agentes) inm.agentes = [];
					<% if sel_year="2018" then %>
						inm.agentes.push( { nombre: agente.empresa, id: agente.id_empresa, logotipo: agente.logotipo} );
						var res = "";
						if (agente.logotipo === null) {
							if (agente.nombre=="PROPIEDAD") {
								res = "Propiedad";
							} else {
								console.log("falta img:", '[' + agente.id_empresa + '] ' + agente.empresa)
							}
							
						} else {
							img =  new Image();
							img.src = "/_inc/javier/img/empresas/" + agente.logotipo;
							images.push(img);
							
							res = '<img src="/_inc/javier/img/empresas/' + agente.logotipo + '">';
						}
						$("#inm_" + inm.id + "-intermediario").append(res);
						
					<% else %>
						inm.agentes.push( { nombre: agente.agencia_nombre, id: agente.agencia_id_empresa, logotipo: agente.agencia_logotipo} );
												var res = "";
						if (agente.agencia_logotipo === null) {
							if (agente.agencia_nombre=="PROPIEDAD") {
								res = "Propiedad";
							} else {
								console.log("FALTA img:", '[' + agente.agencia_id_empresa + '] ' + agente.agencia_nombre)
							}
							
						} else {
							img =  new Image();
							img.src = "/_inc/javier/img/empresas/" + agente.agencia_logotipo;
							images.push(img);
							
							res = '<img src="/_inc/javier/img/empresas/' + agente.agencia_logotipo + '">';
						}
						$("#inm_" + inm.id + "-intermediario").append(res);
						
					<% end if %>					
				}
			});
		}
		
		
		//$.each(edif_markers, function(ii, marker) {
		//	//console.log(ii, inmueble(marker.id)==undefined, marker.id);
		//	marker.setVisible(inmueble(marker.id)==undefined);
		//})
		
		//var t1 = new Date();
		//console.log("AsociarDatos [inms.]:", t1-t0 + " ms");
		
		$("#cmd-asociar").addClass("blancoHover");
	}
	
	function contenidoInfoBox( inmueble ) {
		var precio;
		var msg1="";
		var msg2="";
		
		var marcados = $("#frm_titulos input:checkbox:checked");
		var marcado = "";
		$.each(marcados, function(ii, val) {
			if (val.value==inmueble.id) {
				marcado = " checked";
				return false;
			}
		});
		
		<% if session("pw_ws").accesoTakeUp then  %>
		if (inmueble.renta) {
			precio = "" + inmueble.renta.min;
			if (inmueble.renta.max!=inmueble.renta.min) {
				precio = precio + "/" + inmueble.renta.max;
			}
			precio = precio.replace(".", ",");
			precio = precio + "</span> <span>&euro;/m&sup2;</sup>";
		} else {
			msg1 = "sin rentas";
			precio = "N/D ";
		}
		<% else %>
			precio = "<img src='/img/lock.svg' width='14' height='14'/>";
		<% end if %>
		
		if (!(inmueble.agentes) || inmueble.agentes.length==0) {
			msg2 = "sin agencia";
		}
		if (msg1 + msg2!="") {
			if (msg1!="") { if (msg2!="") {msg2 = ", " + msg2} }
		}
		
		var res = '';
		res = res + '<div class="infoboxPosition" data-id="' + inmueble.id + '">';
		res = res + '<div class="popover top disp" id="">';
		
		res = res + '<div class="popover-check">';
		res = res + '<button type="button" id="chkMap' + inmueble.id + '" class="btn btnCheck' + marcado + '" onClick="sel_inm(' + inmueble.id + ');"></button>';
		res = res + '</div>';
		
		res = res + '<table class="popover-tbDisp" onclick="mapalista(' + inmueble.id + ')">';
		res = res + '<tbody>';
		
		<% if session("pw_ws").accesoTakeUp then  %>
			var sup_min = inmueble.disponible_min.toLocaleString("es", { maximumFractionDigits: 0});
			var sup_max = inmueble.disponible_max.toLocaleString("es", { maximumFractionDigits: 0});
		<% else %>
			var sup_min = "<img src='/img/lock.svg' width='14' height='14'/>";
			var sup_max = "<img src='/img/lock.svg' width='14' height='14'/>";
		<% end if %>
		
		<% if request.Cookies("dev")<>"" then %>
		res = res + '<tr>';
		res = res + '<td colspan="2">id: ' + inmueble.id + '</td>';
		res = res + '<tr>';
		res = res + '</tr>';
		res = res + '<td colspan="2">' + inmueble.nombre_completo + '</td>';
		res = res + '</tr>';
		<% end if %>
		
		res = res + '<tr>';
		res = res + '<td><span>min</span><span>' + sup_min + '</span></td>';
		res = res + '<td><span>max</span><span>' + sup_max + '</span></td>';
		res = res + '</tr>';
		
		res = res + '<tr>';
		res = res + '<td colspan="2"><span>Renta Salida</span><span>' + precio + '</span></td>';
		res = res + '</tr>';
		
		<% if session("pw_ws").accesoTakeUp then  %>
		res = res + '<tr><td colspan="2">';
		if (inmueble.agentes) {
			for (var jj=0; jj<inmueble.agentes.length; jj++) {
				if (inmueble.agentes[jj].logotipo === null) {
					if (inmueble.agentes[jj].nombre=="PROPIEDAD") {
						res = res + 'Propiedad';
					} else {
						console.log("FALTA img: " + inmueble.agentes[jj].nombre)
					}
				} else {
					res = res + '<img src="/_inc/javier/img/empresas/' + inmueble.agentes[jj].logotipo + '">';
				}
			};
		}
		res = res + '</td></tr>';
		<% end if %>
		
		res = res + '</tbody>';
		res = res + '</table>';
		
		res = res + '<div class="arrow" style="left: 47.6449%;"></div>';
		
		res = res + '</div>';
		res = res + '</div>';
		
		return(res);
	}
	
$(document).ready(function() {
	
<% if request.form("ordenando")="" then %>
	
	if ( $("#sel-count").html() != "0" ) {
		console.log("vaciar seleccionados");
		$("#sel-count").html("0");
		$(".divCajaCheck").slideUp();
		$(".divCajaCheck .contadorSelect").animate({marginTop:"-45px"})
	}
	$("#myMapDisp").hide("slow", "", function() {$("#myMapDisp").html("")});
	
	var busqueda_ver = "<%= busqueda_ver %>";
	var agentes_ver = "<%= agentes_ver %>"
	//console.log("busqueda_ver", "zona: < %= request.form("zona") %>", "subzona: < %= request.form("subzona") %>")
	
	$("#informa-tipo-busq").html("Disponibilidad, ");
	
	$("#informa_resultados #informa-tit-busq").html(busqueda_ver);
	$("#informa-busq").html(busqueda_ver);
	$("#informa-agencias").html(agentes_ver);
	
	$("#frmInfo_disp_min").val("<%= request.form("min") %>");
	$("#frmInfo_disp_max").val("<%= request.form("max") %>");
	$("#frm_preguntas input[name='orden']").val("<%= request.form("orden") %>");
	$("#frm_preguntas input[name='ordent']").val("<%= request.form("ordent") %>");
	
	$("#timer").html("<%= formatnumber(t_fin-t_ini, 3) %>");
	
	<% if counter>0 then %>
		$("#informa_resultados #informa-total-sup-busq").html(", con un total de <%= FormatNumber(total_superficie, 0) %> m&sup2;");
	<% else %>
		$("#informa_resultados #informa-total-sup-busq").html("");
		//map.setCenter({lat: 40.45509438392602, lng: -3.692486281662004});
		//map.setCenter(opciones.center);
		//map.setZoom(opciones.zoom);
	<% end if %>
	
	<% select case counter
	case 0 %>
		$("#informa_resultados #informa-num-busq").html("");
		$("#informa_resultados #informa-total-sup-busq").html($("#msg-vacio").html());
		//$("#informa_resultados #informa-num-busq").html("No tenemos disponibilidad para esta b&uacute;squeda.");
		
		$("#depura").html($("#msg-vacio").html());
		$("#depura").slideDown(300);
		
	<% case 1 %>
		$("#informa_resultados #informa-num-busq").html(" 1 inmueble");
		//preguntaSiguiente(1);
		//$(".contTodo").css({"left": "-100%" });
		
	<% case else %>
		$("#informa_resultados #informa-num-busq").html(" " + <%= counter %> + " inmuebles");
		//preguntaSiguiente(1);
		//$(".contTodo").css({"left": "-100%" });
		//$(".navPuntos span")[0].removeClass("checked");
		//$(".navPuntos span")[1].addClass("checked");
		
	<% end select %>
	
	<% if session("pw_ws").accesoTakeUp then %>
		//$("#of-disp").html("<%= counter %>");
		//$("#sup-disp").html("<%= FormatNumber(total_superficie, 0) %>");
		
		$("#of-alq").html("0");
		$("#sup-alq").html("0");
		$("#of-ocup").html("0");
		$("#sup-ocup").html("0");
				$.ajax({
			type: "GET",
			url: "/takeup/data/resumen_disponibilidad.asp",
			data: $("#frm_preguntas").serialize(),
			success: function(recibe, txtStatus, jqSHR) {
				var data = JSON.parse(recibe)[0];
				$("#of-disp").html(formatear(data.inmuebles));
				if (data.disponible==null) {
					$("#sup-disp").html("0");
				} else {
					$("#sup-disp").html(formatear(data.disponible));
				}
			}
		})
		$.ajax({
			type: "GET",
			url: "/takeup/data/resumen_takeup.asp",
			data: $("#frm_preguntas").serialize(),
			success: function(recibe, txtStatus, jqSHR) {
				var data = JSON.parse(recibe);
				var tot_ops = 0;
				var tot_sup = 0;
				$.each(data, function(ii, fila) {
					if (fila.ID_TIPO_OPERACION==1) {
						//venta
						$("#of-ocup").html(formatear(fila.operaciones));
						$("#sup-ocup").html(formatear(fila.superficie));
						
					} else if (fila.ID_TIPO_OPERACION==2) {
						//alquiler
						$("#of-alq").html(formatear(fila.operaciones));
						$("#sup-alq").html(formatear(fila.superficie));
						
					}
					tot_ops = tot_ops + parseInt(fila.operaciones);
					tot_sup = tot_sup + parseInt(fila.superficie);
					
				})
				
				//console.log("tot:", tot_ops, tot_sup );
				$("#of-takeup").html(formatear(tot_ops));
				$("#sup-takeup").html(formatear(tot_sup));
			}
		});
		
	<% else %>
		$("#of-alq").html("<img src='/img/lock.svg' width='14' height='14'/>");
		$("#sup-alq").html("<img src='/img/lock.svg' width='14' height='14'/>");
		$("#of-ocup").html("<img src='/img/lock.svg' width='14' height='14'/>");
		$("#sup-ocup").html("<img src='/img/lock.svg' width='14' height='14'/>");
		$("#of-takeup").html("<img src='/img/lock.svg' width='14' height='14'/>");
		$("#sup-takeup").html("<img src='/img/lock.svg' width='14' height='14'/>");
		$("#sup-disp").html("<img src='/img/lock.svg' width='14' height='14'/>");
		$("#of-disp").html("<img src='/img/lock.svg' width='14' height='14'/>");
	<% end if %>
	
	datos = <%= QueryToJSON(session("connPW"), sql_inmuebles).Flush %>;
	
	<% if session("pw_ws").accesoTakeUp then %>
		<% if sel_year="2018" then %>
		rentas_todas = <%= QueryToJSON(session("connPW"), sql_rentas).Flush %>;
		<% end if %>
		agentes_todos = <%= QueryToJSON(session("connPW"), sql_agencias).Flush %>;
	<% end if %>
	
<% else %>
	console.log("ordenando")
	$.each(datos, function(jj, inm) {
		if (inm.renta) {
			var calc_renta = "" + inm.renta.min;
			if (inm.renta.max!=inm.renta.min) {
				calc_renta = calc_renta + "/" + inm.renta.max;
			}
			calc_renta = calc_renta.replace(".", ",");
			//calc_renta = calc_renta + " <span>&euro;/m&sup2;</sup>";
			$(".tbDisp-Renta[data-id='" + inm.id + "']").html( calc_renta )
		}
		
		if (inm.agentes) {
			$.each(inm.agentes, function(jj, agente) {
				var res = "";
				if (agente.logotipo === null) {
					if (agente.nombre=="PROPIEDAD") {
						res = "Propiedad";
					} else {
						//$("#faltan_img").append( $("<li/>").text(agente.id_empresa + ', ' + agente.empresa) )
					}
					
				} else {
					//img =  new Image();
					//img.src = "/_inc/javier/img/empresas/" + agente.logotipo;
					//images.push(img);
					res = '<img src="/_inc/javier/img/empresas/' + agente.logotipo + '">';
				}
				$("#inm_" + inm.id + "-intermediario").append(res);
			})
		}
	})
	
<% end if %>

<% if session("pw_ws").accesoTakeUp then %>
	$(".dispA-img").click(function(e) {
		e.stopPropagation();
		
		var fotos = [];
		var ff = $(this).attr("data-content").split("&").filter(function(n){return n;});
		
		$.each(ff, function(ii, val) { 
			var foto = {href : "/fotos/inmuebles/" + val} 
			fotos.push(foto);
		});
		
		$.fancybox.open(fotos, 
			{
				padding: 0,

				openEffect : 'elastic',
				openSpeed  : 150,

				closeEffect : 'elastic',
				closeSpeed  : 150,

				closeClick : true,

				helpers : {
					overlay : null
				}
			}
		);
	});
<% end if %>
	
	$("#frm_titulos").submit(function() {
		if ($("#frm_titulos input:checkbox:checked").length<=0) {
			$("#ModalBox").load(
				"/articulos/nada_seleccionado.asp",
				function(recibe, textStatus, xhr) { $("#ModalBox").modal("show"); }
			);
			return false;
		};
		
		if (act_map.zoom>0) {
			$("#frm_titulos input[name='zoom']").val(act_map.zoom);
			$("#frm_titulos input[name='lat']").val(act_map.lat);
			$("#frm_titulos input[name='lng']").val(act_map.lng);
		}
		
		if ( getCookie("condiciones")=="" ) {
			$("#ModalBox").load(
				"/acceso/password.asp",
				$("#frm_titulos").serialize(),
				function(recibe, textStatus, xhr) {}
			);
			
			$("#ModalBox").modal("show");
			
			return false;
			
		} else {
			$("#titSubmit").click();
		}
		
	});
	
	$(".dispA_check input[type='checkbox']").click(function(e) {
		//console.log("click .dispA_check");
		e.stopPropagation();
		
		if (!cargando) {
			centrarMapa = true
		}
		
		$(this).parent().parent().find(".numcalle").show();
		
		var lista = $("#frm_titulos input:checkbox:checked");
		//console.log(lista);
		$("#sel-count").html(lista.length);
		
		if (lista.length==0) {
			$(".divCajaCheck").slideUp();
			$(".divCajaCheck .contadorSelect").animate({marginTop:'-45px'});
			centrarMapa = false;
		} else {
			$(".divCajaCheck").slideDown();
			$(".divCajaCheck .contadorSelect").animate({marginTop:'0px'});
			//centrarMapa = true;
		}
		
		if (limite_seleccion>0) {
			
			if (lista.length>=(limite_seleccion-1)) {
				$("#informa-limite").removeClass("hidden");
			} else {
				$("#informa-limite").addClass("hidden");
			}
			
			
		}
		
		$(".popover-check>button").removeClass("checked");
		var xxx = [];
		$.each(lista, function(ii, val) {
			$("#chkMap" + val.value).addClass("checked");
		});
		
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
			//console.log(yyy);
			//return false;
			
		} else {
			$("#frm_titulos input:checkbox:not(:checked)").removeAttr("disabled");
			$(".btnCheck").show();
			
		}
		
		
	});
	$(".dispA_check").click(function(e) {
		$(this).children("input:checkbox").click();
		e.stopPropagation();
	});
	
	<% if request.Form("year")="2018" then %>
	$(".dispA").click(function(e) {
		var t0 = new Date;
		
		var id = $(this).data("id");
		var fila = $(this);
		
		if (fila.find(".tb-despliega").hasClass("activo")) {
			//console.log("cierra");
			fila.find(".tb-despliega").slideUp("swing").removeClass("activo");
			fila.find(".dispA-direccion").removeClass("activo");
			fila.find(".numcalle").hide();
			
		} else {
			//console.log("abre");
			if ( $("#inm_" + id + "-detalles").html()=="" ) {
				//console.log("block");
				fila.block({ message: null });
			}
			$(".dispA").find(".tb-despliega.activo").slideUp("swing").removeClass("activo");
			$(".dispA").find(".dispA-direccion.activo").removeClass("activo");
			$(".dispA").find(".numcalle").hide();
			
			if ( $("#inm_" + id + "-detalles").html()=="" ) {
				$.ajax({
					type: "POST",
					url: "/takeup/data/detalle.asp",
					data: {'id':id, 'secc':'takeup'},
					success: function(data, txtStatus, jqSHR) {
						$("#inm_" + id + "-detalles").html(data);
						fila.find(".tb-despliega").slideDown("swing").addClass("activo");
						fila.find(".dispA-direccion").addClass("activo"); 
						fila.find(".numcalle").show();
						fila.unblock();
					}
				})
			} else {
				fila.find(".tb-despliega").slideDown("swing").addClass("activo");
				fila.find(".dispA-direccion").addClass("activo"); 
				fila.find(".numcalle").show();
			}
		}
		
		var t1=new Date;
		console.log(".dispA.click: ", t1-t0 + " ms");
	});
	<% end if %>
	
	<% if request.form("dis")<>"" then %>
		console.log("MARCAMOS:")
		var sel_str = "<%= request.form("dis") %>";
		var sel_arr = sel_str.split(",").map(
			function(x) {
				return parseInt(x, 10)
			});
		$.each(sel_arr, function(ii, elto) {
			//console.log(ii, elto);
			<% if request.form("ordenando")="" then %>
			$("#chkDisp" + elto).click();
			<% else %>
			$("#chkDisp" + elto).prop("checked", true)
			<% end if %>
		})
		
	<% end if %>
});
</script><%
if counter=0 then %>
    <div style="padding:10px; margin:15px 2px;">
		<p id="msg-vacio"><%= BusquedaVacia() %></p>
		<p>&nbsp;</p>
		<p>Por favor, depure la b&uacute;squeda.</p>
	</div>
<% end if

sub LineaDisp()	
	counter = counter + 1 
	c_id = rsBusq("id")
	
	c_nombre = rsBusq("nombre_calle")
	'if session("pw_ws").accesoTakeUp and ini=0 then
		c_numcalle = rsBusq("numero_calle")
	'else
	'	c_numcalle = ""
	'end if
	
	c_localidad = lcase(rsBusq("localidad"))
	if len(c_localidad)>18 then
		c_localidad = "<acronym title='" & replace(c_localidad, "'", "&#39;") & "'>" & left(c_localidad, 15) & "...</acronym>"
	end if
	
	c_tipo = rsBusq("tipo_inmueble")
	
	if rsBusq("id_tipo_inmueble")=0 then
		c_secc = rsBusq("seccion")
		if len(c_secc)>25 then 
			ver_secc = lcase(c_secc)
			c_secc = "<acronym title='" & c_secc & "'>" & left(ver_secc, 21) & "...</acronym>"
		end if
		c_tipo = lcase(c_secc)
	end if
	
	if not(isnull(rsBusq("disponible_max"))) then
		total_superficie = total_superficie + cdbl(rsBusq("disponible_max"))
	end if
	
	if session("pw_ws").accesoTakeUp then 
		if sel_year="2018" then
			c_disp_fecha = FechaCorta(rsBusq("disponible_fecha"))
			c_disp_renta = "N/D"
			if c_disp_fecha <> "" then
				c_disp_min = formatnumber(rsBusq("disponible_min"), 0)
				c_disp_max = formatnumber(rsBusq("disponible_max"), 0)
			end if
		else
			c_disp_fecha = FechaCorta(rsBusq("hist_fecha"))
			c_disp_renta = ""
			if not(isnull(rsBusq("hist_renta_min")) or rsBusq("hist_renta_min")="") then
				c_disp_renta = c_disp_renta & rsBusq("hist_renta_min")
			end if
			if not(isnull(rsBusq("hist_renta_max")) or rsBusq("hist_renta_max")="") then
				if rsBusq("hist_renta_min")<>rsBusq("hist_renta_max") then
					if c_disp_renta<>"" then c_disp_renta = c_disp_renta & "/"
					c_disp_renta = c_disp_renta & rsBusq("hist_renta_max")
				end if
			end if
			c_disp_min = ""
			if isnull(rsBusq("hist_superficie")) or rsBusq("hist_superficie")="" then
				c_disp_max = "N/D"
			else
				c_disp_max = formatnumber(rsBusq("hist_superficie"), 0)
			end if
		end if
	else
		c_disp_fecha = "[" & sel_year & "]<img src='/img/lock.svg' width='14' height='14'/>" 
		c_disp_min = "<img src='/img/lock.svg' width='14' height='14'/>" 
		c_disp_max = "<img src='/img/lock.svg' width='14' height='14'/>" 
	end if
	
	foto = "" & rsBusq("fotos")
	if instr(foto, "&")>0 then
		foto = left(foto, instr(foto, "&")-1)
	end if
	%>
<div class="dispA" data-id="<%= rsBusq("id") %>">
    <div class="dispA_check"><% if request.Cookies("dev")<>"" then response.Write(counter) end if %><input type="checkbox" name="dis" value="<%= rsBusq("id") %>" class="chexbox" id="chkDisp<%= rsBusq("id") %>" ></div>
    
    <div class="dispA-img" data-content="<%= rsBusq("fotos") %>">
        <% if foto<>"" then 
            img = "/lib/showThumb.aspx?ImgWd=62&img=/fotos/inmuebles/" & foto & "&rnd=" & Int((rnd*1000))
            %><img src="<%= img %>" class="img-responsive"><% 
        end if %>
    </div>
    
    <div class="dispA-intermediario" data-id="<%= rsBusq("id") %>" id="inm_<%= rsBusq("id") %>-intermediario"></div>
    
    <div class="dispA-direccion"><%= c_nombre %> <span class="numcalle"><%= c_numcalle %></span><% if request.Cookies("dev")<>"" then %> [<%= rsBusq("id") %>]<% end if %></div> 
    <div class="dispA-localidad"><%= c_localidad %></div> 
    
    <div class="dispB">
        <table class="tbDispon">
            <tr>
                <td class="tbDisp-Plta"></th>
                <td class="tbDisp-Tipo"><%= c_tipo %></td>
                <% if sel_year="2018" then %><td class="tbDisp-Min"><%= c_disp_min %></td><% end if %>
                <td class="tbDisp-Max"><%= c_disp_max %></td>
                <td class="tbDisp-Renta" data-id="<%= rsBusq("id") %>" id="inm_<%= rsBusq("id") %>-renta"><% if session("pw_ws").accesoTakeUp then %><span class="nd"><%= c_disp_renta %></span><% else %><img src="/img/lock.svg" width="14" height="14"/><% end if %></td>
                <td class="tbDisp-Fecha"><%= c_disp_fecha %></td>
            </tr>
        </table>
        <div class="tb-despliega" id="inm_<%= rsBusq("id") %>-detalles"><% if not session("pw_ws").accesoTakeUp then 
            %><p><img src="/img/lock.svg" width="14" height="14"/> Lo sentimos, pero esta informaci&oacute;n s&oacute;lo est&aacute; disponible para <a href="#" class="simplemodal">clientes</a>.</p><%
        end if %></div>
    </div>
    
</div>
<% end sub %>
