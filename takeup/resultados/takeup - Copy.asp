<% 
'select case rsBusq("id_tipo_operacion")
'case 1, 3 
'	titulo_importe = "Precio"
'case 2, 4
'	titulo_importe = "Renta"
'end select
titulo_importe = "Precio/Renta"
%>
<div class="tabla ">
    <div class="fila cabecera">
        <div class="deals_contador tit"></div>
        <div class="deals_titulo tit">Direcci&oacute;n</div>
        <div class="deals_superf tit">Superficie</div>
        <div class="deals_precio tit"><%= titulo_importe %></div>
        <div class="deals_tipoprecio tit"></div>
        <div class="deals_fecha tit">Fecha Op.</div>
    </div>
</div>
<% 
'on error resume next
localidad = trim(lcase(request.form("ciudad")))
agencia = request.form("agencia")

if localidad="" then 
	busqueda_ver = "ESPA&Ntilde;A "
	agentes_ver = "ESPA&Ntilde;A"
	
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

'response.Write(sql)
'response.End()

'''''''''''''
sqlw = "web_es<>0"
sqlw = sqlw & " AND (ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=2)"
sqlw = sqlw & " AND seccion LIKE '%oficinas%'"

yy = request.form("year")
if yy="" then yy = "2017"
sqlw = sqlw & " AND FECHA_OPERACION BETWEEN CONVERT(DATETIME, '01/01/" & yy & "', 103) AND CONVERT(DATETIME, '31/12/" & yy & "', 103)"

if localidad="" then
	sqlw = sqlw & " AND id_pais = 1"
else
	sqlw = sqlw & " AND "
	if localidad = "madrid" then
		sqlw = sqlw & "id_provincia = 2"
	elseif localidad = "barcelona" then
		sqlw = sqlw & "id_provincia = 3"
	else
		sqlw = sqlw & "localidad = '" & localidad & "'"
	end if
end if


if request.form("id_subzona")<>"" then
	sqlw = sqlw & " AND id_subzona=" & request.form("id_subzona")

elseif request.form("id_zona")<>"" then
	sqlw = sqlw & " AND id_area=" & request.form("id_zona")
	
end if

if agencia<>"" then
	sqlw = sqlw & " AND id IN ("
	sqlw = sqlw & "SELECT id_operacion FROM OPERACIONES_CONTACTOS WHERE tipo LIKE '%I' AND id_empresa=" & agencia
	sqlw = sqlw & ")"
end if

sql_ops = "SELECT * FROM dirs_w_ops WHERE " & sqlw

if request.Cookies("dev")<>"" then %>
	<div style="font-size:12px; border-top: 1px solid red; margin:2px 0;">
    	<a href="#" onclick="$('#sql-dev').slideToggle('fast'); return false;"><strong>take up:</strong></a>
        <div class="dev" style="margin:6px 0 0 6px; border:#CCC 1px solid; font-size:11px"><%= sql_ops %></div>
	</div><% 	
end if

'response.End()

counter = 0
count_alq = 0
count_ocup = 0
superf_total = 0
superf_alq = 0
superf_ocup = 0

verAlq = false
verOcup = false

select case request.form("datos")
case "alq"
	verAlq = true
case "ocup"
	verOcup = true
case else
	verAlq = true
	verOcup = true
end select

rsBusq.open sql_ops, session("connPW")

'if request.form("zona")<>"" then
'	busqueda_ver = busqueda_ver & rsBusq("area") & "&nbsp;"
'end if
'if request.form("subzona")<>"" then
'	busqueda_ver = busqueda_ver & rsBusq("subzona") & "&nbsp;"
'end if
if swMostrarDetalles then
	%><div class="tabla"><%
	do while not rsBusq.eof 
		select case rsBusq("id_tipo_operacion")
		case 1	'venta
			count_ocup = count_ocup + 1
			superf_ocup = superf_ocup + cdbl(rsBusq("METROS_CUADRADOS"))
			
			if verOcup then 
				superf_total = superf_total + cdbl(rsBusq("METROS_CUADRADOS"))
				counter = counter + 1
				call LineaTakeUp
			end if
		case 2	'alquiler
			count_alq = count_alq + 1
			superf_alq = superf_alq + cdbl(rsBusq("METROS_CUADRADOS"))
			
			if verAlq then 
				superf_total = superf_total + cdbl(rsBusq("METROS_CUADRADOS"))
				counter = counter + 1
				call LineaTakeUp
			end if
		end select
		
		rsBusq.movenext
		
	loop
	%></div><%
	if counter>0 then 
		%><div style="text-align:center; margin-top:2.5em;">
			<input type="submit" id="titSubmit" value="Leer Artículos Seleccionados" class="btn_3">
		</div><%
	 end if
else	'swMostrarDetalles	
	'calculamos los detalles
	do while not rsBusq.eof
		counter = counter + 1
		select case rsBusq("id_tipo_operacion")
		case 1	'venta
			count_ocup = count_ocup + 1
			superf_ocup = superf_ocup + cdbl(rsBusq("METROS_CUADRADOS"))
		case 2	'alquiler
			count_alq = count_alq + 1
			superf_alq = superf_alq + cdbl(rsBusq("METROS_CUADRADOS"))
		end select
		rsBusq.movenext
	loop
	
	if session("IniCliente")=0 then
		call SinAcceso("Take Up")
	else
		call NoCliente
	end if
	
end if	
rsBusq.close
%>

<script type="text/javascript">
	iconoActivo = "/img/ico-azul02.png";
	
	function op_edificio( id_edif ) {
		for (var i = 0; i < datos.length; i++) {
			if (datos[i].ID_EDIFICIO == id_edif) {
				return datos[i];
			}
		}
		//console.log("operacion no encontrada: " + id);
	}
	
	function AsociarDatos() {
		//console.log("AsociarDatos", "CANCELADO")
		//return false;
		//var t0 = new Date;
		$.each(datos, function(ii,op){
			op.agentes = [];
		})
		
		if (agentes_todos) {
			$.each(agentes_todos, function(jj, agente) {
				var op = operacion(agente.ID);
				if (op) {
					op.agentes.push( { NOMBRE: agente.NOMBRE, logotipo: agente.logotipo} )
					if (agente.logotipo === null) {
						//console.log("FALTA logotipo: " + agente.NOMBRE)
					} else {
						img =  new Image();
						img.src = "/_inc/javier/img/empresas/" + agente.logotipo;
						images.push(img);
					}
				}
			});
		}
		
		//$.each(edif_markers, function(ii, marker) {
		//	//console.log(ii, marker.id, op_edificio(marker.id)==undefined);
		//	marker.setVisible(op_edificio(marker.id)==undefined);
		//})
		
		//var t1 = new Date();
		//console.log("AsociarDatos [ops.]:", t1-t0 + " ms");
		
		$("#cmd-asociar").addClass("blancoHover");
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
		
		<% if session("pw_ws").accesoTakeUp then  %>
			moneda = operacion["TIPO_PRECIO"].toLowerCase().replace("m2", "m&sup2;").replace("€", "&euro;");
			importe = operacion["PRECIO_EUR"];
			superf = operacion["METROS_CUADRADOS"];
			
			if (operacion["ID_TIPO_OPERACION"]=="1" | operacion["ID_TIPO_OPERACION"]=="3") {
				if (operacion["ID_TIPO_PRECIO"]=="8") {
					if (superf>0) {
						importe = Math.round(importe/superf);
						moneda = moneda + "/m&sup2;";
					}
					if (importe!=null) {
						importe = importe.toLocaleString("es", { maximumFractionDigits: 0})
					}
				}
			} else {
				if (importe!=null) {
					importe = importe.toLocaleString("es", { maximumFractionDigits: 2});
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
		
		var res = '<div class="infoboxPosition" data-id="' + operacion["ID"] + '">';
		var res = res + '<div class="popover top" id="">';
		
		res = res + '<div class="popover-check">';
		res = res + '<button type="button" id="chkMap' + operacion["ID"] + '" class="btn btnCheck' + marcado + '" onClick="sel_op(' + operacion["ID"] + ');"></button>';
		res = res + '</div>';
		
		res = res + '<a onClick="javascript:ver_op(' + operacion["ID"] + ')" id="maplink' + operacion["ID"] + '" class="leer">';
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
		if (operacion.agentes) {
			for (var jj=0; jj<operacion.agentes.length; jj++) {
				if (operacion.agentes[jj].logotipo === null) {
					//console.log("FALTA img: " + operacion.agentes[jj].NOMBRE)
				} else {
					res = res + '<img src="/_inc/javier/img/empresas/' + operacion.agentes[jj].logotipo + '">';
					//res = res + operacion.agentes[jj].logotipo + ' ';
				}
			};
		}
		res = res + '</td></tr>';
		
		
		res = res + '</tbody>';
		res = res + '</table>';
		res = res + '</a>';
		
		res = res + '<div class="arrow" style="left: 47.6449%;"></div>';
		
		
		res = res + '</div>';
		res = res + '</div>';
		
		return(res);
	}
	
$(document).ready(function() {
	$("#limite_seleccion").html(limite_seleccion);
	
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
	<% select case request.Form("datos")
	case "takeup"
		msg_datos = "Alq.+Ocup.Prop."
	case "alq"
		msg_datos = "Alq."
	case "ocup"
		msg_datos = "Ocup.Prop."
	end select %>
	$("#informa-tipo-busq").html("Take Up (<%= msg_datos %>), ");
	
	$("#informa_resultados #informa-tit-busq").html(busqueda_ver);
	$("#informa-busq").html(busqueda_ver);
	$("#informa-agencias").html(agentes_ver);
	
	$("#frm_preguntas input[name='orden']").val("<%= request.form("orden") %>");
	$("#frm_preguntas input[name='ordent']").val("<%= request.form("ordent") %>");
	//console.log("frmInfo_busq > ")
	//$("#frm_titulos input[name='frmInfo_busq']").html("< %= busqueda_ver %>")
	
	<% if (counter)>0 then %>
		$("#informa_resultados #informa-total-sup-busq").html(", con un total de <%= FormatNumber(superf_total, 0) %> m&sup2;");
	<% else %>
		$("#informa_resultados #informa-total-sup-busq").html("");
		//map.setCenter({lat: 40.45509438392602, lng: -3.692486281662004});
		//map.setCenter(opciones.center);
		//map.setZoom(opciones.zoom);
	<% end if %>
	
	<% select case (counter)
	case 0 %>
		$("#informa_resultados #informa-num-busq").html("");
		$("#informa_resultados #informa-total-sup-busq").html($("#msg-vacio").html());
		
		$("#depura").html($("#msg-vacio").html());
		$("#depura").slideDown(300);
		
	<% case 1 %>
		$("#informa_resultados #informa-num-busq").html(" 1 operaci&oacute;n");
		
	<% case else %>
		$("#informa_resultados #informa-num-busq").html(" " + <%= counter %> + " operaciones");
		
	<% end select %>
	
	<% if swMostrarDetalles then %>
		$("#of-alq").html("<%= count_alq %>");
		$("#sup-alq").html("<%= FormatNumber(superf_alq, 0) %>");
		$("#of-ocup").html("<%= count_ocup %>");
		$("#sup-ocup").html("<%= FormatNumber(superf_ocup, 0) %>");
		$("#of-takeup").html("<%= count_alq + count_ocup %>");
		$("#sup-takeup").html("<%= FormatNumber(superf_alq+superf_ocup, 0) %>");
		
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
	
	//console.log($("#frm_preguntas").serialize());
	<%
	if request.form("datos")="alq" then
		sqlw = sqlw & " AND ID_TIPO_OPERACION=2"
	elseif request.form("datos")="ocup" then
		sqlw = sqlw & " AND ID_TIPO_OPERACION=1"
	end if
	
	sql_ops = "SELECT * FROM dirs_w_ops WHERE " & sqlw
	%>
	//console.log("sql: < %= sql %>");
	datos = <%= QueryToJSON(session("connPW"), sql_ops).Flush %>;
	//console.log("operaciones cargadas: " + datos.length);
	
	<% if session("pw_ws").accesoTakeUp then 
		sql_agencias = "SELECT ID, NOMBRE, logotipo FROM C_OPERACIONES_INTERMEDIARIOS WHERE ID IN (SELECT ID FROM dirs_w_ops WHERE " & sqlw & ")"
		sql_agencias = sql_agencias & " AND TIPO LIKE '%I'"
		sql_agencias = sql_agencias & " AND ID_ACTIVIDAD=28"
		%>
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
						console.log("FALTA img", agente.id_empresa, agente.empresa);
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
	
<% if request.form("ope")<>"" then %>
	//console.log("MARCAMOS:")
	var sel_str = "<%= request.form("ope") %>";
	var sel_arr = sel_str.split(",").map(
		function(x) {
			return parseInt(x, 10)
		});
	
	$.each(sel_arr, function(ii, elto) {
		<% if request.form("ordenando")="" then %>
		$("#chkOp" + elto).click();
		<% else %>
		$("#chkOp" + elto).prop("checked", true)
		<% end if %>
	})
<% end if %>

});
</script><%
	if (count_alq+count_ocup)=0 then %>
		<div style="padding:10px; margin:15px 2px;">
			<p id="msg-vacio"><%= BusquedaVacia() %></p>
			<p>&nbsp;</p>
			<p>Por favor, depure la b&uacute;squeda.</p>
		</div>
	<% end if
'FORM //


sub LineaTakeUp()	
	
	direccion = ""
	if isnull(rsBusq("id_edificio")) or rsBusq("id_edificio")=0 then
		linea = ""
	else
		linea = rsBusq("nombre") & ", "
	end if
	
	linea = ""
	if rsBusq("NOMBRE_CALLE")<>"" then
		'if request.Cookies("dev")<>"" then
		'	if rsBusq("TIPO_DIRECCION")<>"N/D" and rsBusq("TIPO_DIRECCION")<>"" then
		'		linea = linea & rsBusq("TIPO_DIRECCION") & " "
		'	end if
		'	if rsBusq("nombre_calle_pre")<>"" then
		'		linea = linea & rsBusq("nombre_calle_pre") & " "
		'	end if
		'end if
		
		linea = linea & rsBusq("NOMBRE_CALLE")
		
		if request.Cookies("dev")<>"" then
			if rsBusq("NUMERO_CALLE")<>"N/D" and rsBusq("NUMERO_CALLE")<>"0" and rsBusq("NUMERO_CALLE")<>"" then
				linea = linea & " " & rsBusq("NUMERO_CALLE")
			end if
		end if
		if linea<>"" then direccion = direccion & linea
		
		if rsBusq("LOCALIDAD")<>"N/D" and rsBusq("LOCALIDAD")<>"" then
			localidad = rsBusq("LOCALIDAD")
			'localidad = UCase(Left(localidad,1)) & LCase(Right(localidad, Len(localidad) - 1))
			direccion = direccion & " <span>(" & localidad & ")</span>"
		end if
		
		if request.Cookies("dev")<>"" then
			direccion = direccion & " [<span class='dev'>" & rsBusq("id_edificio") & "</span>]"
		end if
	else
		linea = linea & rsBusq("NOMBRE_ZONA")
		if linea<>"" then direccion = direccion  & linea & ", "
		if rsBusq("LOCALIDAD")<>"N/D" and rsBusq("LOCALIDAD")<>"" then
			direccion = direccion  & rsBusq("LOCALIDAD")
		else
			direccion = direccion & rsBusq("PAIS")
		end if
	end if
	
	direccion = trim(direccion)
	c_nombre = direccion
	
	'if session("pw_ws").accesoDisponibilidad and ini=0 then
		c_numcalle = rsBusq("numero_calle")
	'else
	'	c_numcalle = ""
	'end if
	
	c_localidad = lcase(rsBusq("localidad"))
	if len(c_localidad)>18 then
		c_localidad = "<acronym title='" & replace(c_localidad, "'", "&#39;") & "'>" & left(c_localidad, 15) & "...</acronym>"
	end if
	
	precio = 0 
	if IsNumeric(rsBusq("PRECIO_EUR")) then
		precio = rsBusq("PRECIO_EUR") 
	end if
	
	if precio = 0 then
		precio_ver = ""
		tipoprecio = ""
	else
		if precio>1000 then 
			precio_ver = FormatNumber(rsBusq("PRECIO_EUR"), 0)
		'	'precio_ver = resultado("PRECIO_EUR")
		else
		'	'if isnumeric(resultado("PRECIO_EUR")) then
				precio_ver = FormatNumber(rsBusq("PRECIO_EUR"), 2)
		'		'precio_ver = resultado("PRECIO_EUR")
		'	'end if
		end if
		
		if rsBusq("ID_TIPO_PRECIO")=0 then 
			tipoprecio = ""
		else
			tipoprecio = lcase(rsBusq("TIPO_PRECIO"))
			tipoprecio = replace(tipoprecio, "€", "&euro;")
			tipoprecio = replace(tipoprecio, "m2", "m&sup2;")
		end if
	end if
	
	superf = FormatNumber(rsBusq("METROS_CUADRADOS"), 0)
	if superf>0 then 
		superf = superf & "&nbsp;<span style='font-size:85%;'>m&sup2;</span>"
	else
		superf = ""
	end if
	
	'if rsBusq("id_tipo_inmueble")=0 then
		c_secc = rsBusq("seccion")
		if len(c_secc)>25 then 
			ver_secc = lcase(c_secc)
			c_secc = "<acronym title='" & c_secc & "'>" & left(ver_secc, 21) & "...</acronym>"
		end if
		c_tipo = lcase(c_secc)
	'end if
	
	if isnull(rsBusq("lat")) then 
		clase_warning = "pw-warning"
	else
		clase_warning = ""
	end if
	
	enlace = "/articulos/?ope=" & rsBusq("ID")
	
	'& "&origen=takeup"
	'tab=list&
	for each elto in request.Form
		if request.Form(elto)<>"" then
			select case elto
			case "zoom", "lat", "lng", "tab"
			case else
				enlace = enlace & "&" & elto & "=" & request.Form(elto)
			end select
		end if
	next
	
	%>
<div class="fila <%= clase_warning %>">
	<div class="deals_check"><input type="checkbox" name="ope" value="<%= rsBusq("ID") %>" <% if checked="true" then %>checked<% end if %> class="chexbox" id="chkOp<%= rsBusq("ID") %>"/></div>
    <div class="deals_contador"><%= counter %></div>
    <a class="leer" id="op<%= rsBusq("ID") %>" onclick="ver_op(<%= rsBusq("ID") %>);">
    <div class="deals_titulo"><% if request.Cookies("dev")<>"" then %>[<span class="dev"><%= rsBusq("id") %></span>] <% end if %><%= c_nombre %></div>
    <div class="deals_superf"><%= superf %></div>
    <div class="deals_precio"><%= precio_ver %></div>
    <div class="deals_tipoprecio"><%= tipoprecio %></div>
    <div class="deals_fecha"><%= rsBusq("FECHA_OPERACION") %></div>
    </a>
</div>
<% end sub %>
