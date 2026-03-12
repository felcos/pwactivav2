<% 'IF 1=2 THEN %>
<input type="hidden" data-form="busq" name="zoom" value="<%= request.Form("zoom") %>" />
<input type="hidden" data-form="busq" name="lat" value="<%= request.Form("lat") %>" />
<input type="hidden" data-form="busq" name="lng" value="<%= request.Form("lng") %>" />
<input type="hidden" data-form="busq" name="tab" value="<%= settab %>"/>
<input type="hidden" name="min" value="<%= filtro_min %>"/>
<input type="hidden" name="max" value="<%= filtro_max %>"/>
<input type="hidden" name="secc" value="disponibilidad"/>
<% 
	for each elto in request.Form
		select case elto
		case "selected", "dis"
		case "ordenando", "origen", "secc"
		case "lat", "lng", "zoom"
		case "tab", "frmInfo_disp_tab"
		case "min", "max", "filtro_min", "filtro_max"
		case else
			%><input type="hidden" name="<%= elto %>" value="<%= request.Form(elto) %>"/><%
		end select
	next 
'END IF

'on error resume next

localidad = trim(lcase(request.form("ciudad")))
agencia = request.form("agencia")

if localidad="" then 
	busqueda_ver = "ESPA&Ntilde;A "
else
	busqueda_ver = localidad
	if request.Form("zona")<>"" then 
		busqueda_ver = busqueda_ver & ", " & request.Form("zona")
	else
		if request.Form("subzona")<>"" then
			busqueda_ver = busqueda_ver & ", " & request.Form("subzona")
		else
			busqueda_ver = busqueda_ver + " "
		end if
	end if
end if

counter = 0
'max_regs = 50
max_regs = 500

total_superficie = 0
ids = ""

'FORM
t_ini = timer 

ids_actual = ids

sqlw = calcular_sql(true)
	
sql = "SELECT * FROM dirs_w_inmuebles WHERE (" & sqlw & ") ORDER BY "
'sql = "SELECT * FROM dirs_w_inmuebles WHERE (" & calcular_sql(true) & ") ORDER BY "

select case request.Form("orden")
case "min"
	sql = sql & "disponible_min"
	if request.Form("ordent")="desc" then sql = sql & " DESC"
	
case "max"
	sql = sql & "disponible_max"
	if request.Form("ordent")="desc" then sql = sql & " DESC"
				
case "__renta"
	
case else
	sql = sql & "localidad, nombre_calle, numero_calle_ord, numero_calle, nombre_completo"
end select

'response.Write(sql)
'response.End()

sql_inmuebles = sql

if request.Cookies("dev")<>"" then %>
	<div style="font-size:12px; border-top: 1px solid red; margin:2px 0;" class="dev"><a href="#" onclick="$('#sql-dev').slideToggle('fast'); return false;">
		<strong>disponibilidad:</strong>
		<span class="peq" style="float:right;"><span id="timer">0</span> ms</span></a>
		<div id="sql-dev" style="display:none_; margin:6px 0 0 6px; border:#CCC 1px solid; font-size:9px"><%= sql %></div>
		<div id="sql-request" style="display:none; margin:6px 0 0 6px; border:#CCC 1px solid; font-size:9px">
		<% if request.Cookies("dev")<>"" then
			for each elto in request.Form 
				%>[<strong><%= elto %></strong>: <%= request.Form(elto) %>] <% 
			next
		end if %>
        </div>
	</div><% 	
end if

'response.End()
rsBusq.open sql, session("connPW")

'if request.form("zona")<>"" then
'	busqueda_ver = busqueda_ver & rsBusq("area") & "&nbsp;"
'end if
'if request.form("subzona")<>"" then
'	busqueda_ver = busqueda_ver & rsBusq("subzona") & "&nbsp;"
'end if

do while not rsBusq.eof 
	call Linea
	rsBusq.movenext
loop

rsBusq.close
t_fin = timer

if session("pw_ws").accesoDisponibilidad then 
	
	sqlw = "SELECT ID FROM dirs_w_inmuebles WHERE " & sqlw
	
	'agencias
	sql_agencias = "SELECT id_inmueble, id_empresa, empresa, tipo, logotipo FROM c_inmuebles_agentes WHERE id_inmueble IN (" & sqlw & ")"
	sql_agencias = sql_agencias & " AND TIPO='comerc'"
	'sql_agencias = sql_agencias & " AND TIPO='prop'"
	sql_agencias = sql_agencias & " AND fecha_hasta IS NULL"
	
	'rentas
	sql_rentas = "SELECT id_inmueble, MIN(disponible_renta) AS renta_min, MAX(disponible_renta) AS renta_max, AVG(disponible_renta) AS renta_media "
	sql_rentas = sql_rentas & "FROM inmuebles_plantas WHERE ("
	sql_rentas = sql_rentas & "id_inmueble IN (" & sqlw & ") "
	sql_rentas = sql_rentas & "AND (disponible_renta IS NOT NULL) "
	sql_rentas = sql_rentas & "AND (seccion_operacion = 1)"
	sql_rentas = sql_rentas & ") "
	sql_rentas = sql_rentas & "GROUP BY id_inmueble"
	
end if %>
<script type="text/javascript">
	$("#cmd-asociar").removeClass("blancoHover");
	$("#cmd-generar").removeClass("blancoHover");
	$("#cmd-cargar").removeClass("blancoHover");
	
$(document).ready(function() {
	
	//console.log("titulos ready");
  <% if request.Form("ordenando")="" then %>
	
	if ( $("#sel-count").html() != "0" ) {
		console.log("vaciar seleccionados");
		$("#sel-count").html("0");
		$(".divCajaCheck").slideUp();
		$(".divCajaCheck .contadorSelect").animate({marginTop:"-45px"})
	}
	$("#myMapDisp").hide("slow", "", function() {$("#myMapDisp").html("")});
	
	var busqueda_ver = "<%= busqueda_ver %>";
	console.log("busqueda_ver", "zona: <%= request.Form("zona") %>", "subzona: <%= request.Form("subzona") %>")
	
	$("#informa_resultados .tit_busqueda").html(busqueda_ver);
	$("#informa-busq").html(busqueda_ver);
	
	$("#frmInfo_disp_min").val("<%= request.Form("min") %>");
	$("#frmInfo_disp_max").val("<%= request.Form("max") %>");
	$("#frm_preguntas input[name='orden']").val("<%= request.Form("orden") %>");
	$("#frm_preguntas input[name='ordent']").val("<%= request.Form("ordent") %>");
	//console.log("frmInfo_busq > ")
	//$("#frm_titulos input[name='frmInfo_busq']").html("< %= busqueda_ver %>")
	
	$("#timer").html("<%= formatnumber(t_fin-t_ini, 3) %>");
	
	<% if counter>0 then %>
		$("#informa_resultados .tit_metros").html(", con un total de <%= FormatNumber(total_superficie, 0) %> m&sup2;");
	<% else %>
		$("#informa_resultados .tit_metros").html("");
		//map.setCenter({lat: 40.45509438392602, lng: -3.692486281662004});
		//map.setCenter(opciones.center);
		//map.setZoom(opciones.zoom);
	<% end if %>
	
	<% select case counter
	case 0 %>
		$("#informa_resultados .tit_numero").html("");
		$("#informa_resultados .tit_metros").html($("#msg-vacio").html());
		//$("#informa_resultados .tit_numero").html("No tenemos disponibilidad para esta b&uacute;squeda.");
		
		$("#depura").html($("#msg-vacio").html());
		$("#depura").slideDown(300);
		
	<% case 1 %>
		$("#informa_resultados .tit_numero").html(" 1 inmueble");
		//preguntaSiguiente(1);
		//$(".contTodo").css({"left": "-100%" });
		
	<% case else %>
		$("#informa_resultados .tit_numero").html(" " + <%= counter %> + " inmuebles");
		//preguntaSiguiente(1);
		//$(".contTodo").css({"left": "-100%" });
		//$(".navPuntos span")[0].removeClass("checked");
		//$(".navPuntos span")[1].addClass("checked");
		
	<% end select %>
	
	$("#of-disp").html("<%= counter %>")
	$("#sup-disp").html("<%= FormatNumber(total_superficie, 0) %>")
	
	$.ajax({
		type: "POST",
		url: "/disponibilidad/data/total_registrados.asp",
		data: $("#frm_preguntas").serialize(),
		success: function(recibe, txtStatus, jqSHR) {
			var data = JSON.parse(recibe);
			$("#of-total").html(data.inmuebles);
			$("#sup-total").html(data.sba_total);
			
			var sup_disp = $("#sup-disp").html().split('.').join('');
			var sup_tot = data.sba_total.split('.').join('');
			//console.log(sup_tot)
			//console.log(sup_disp/sup_tot)
			var percent = 100*sup_disp/sup_tot
			
			$(".alquilado-porcentaje").html(percent.toFixed(2) + "% ")
		}
	})
	
	//console.log("sql_inmuebles: < %= sql_inmuebles %>");
	inmuebles = <%= QueryToJSON(session("connPW"), sql_inmuebles).Flush %>;
	console.log("inmuebles cargados: " + inmuebles.length);
	
	<% if session("pw_ws").accesoDisponibilidad then %>
	//console.log("sqlw: < %= sqlw %>");
	rentas_todas = <%= QueryToJSON(session("connPW"), sql_rentas).Flush %>;
	agentes_todos = <%= QueryToJSON(session("connPW"), sql_agencias).Flush %>;
	<% end if %>
	<% 'if request.Form("frmInfo_busq")="" then %>
		////preguntaSiguiente(0);
	<% 'else %>
		//console.log("titulos > pregunta siguiente")
		<% 'if request.Form("min")="" or request.Form("max")="" then %>
		//	console.log("min o max = ''")
		//	preguntaSiguiente(0);
		<% 'else %>
		//	console.log("min o max else")
		//	preguntaSiguiente(1);
		<% 'end if %>
	<% 'end if %>
	
  <% else %>
	console.log("ordenando")
	$.each(inmuebles, function(jj, inm) {
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

//$(document).ready(function() {
	<% if session("pw_ws").accesoDisponibilidad then %>
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
		
		$("#frm_titulos > input[name='min']").val( $("#filtro_min").val() )
		$("#frm_titulos > input[name='max']").val( $("#filtro_max").val() )
		
		if ( getCookie("condiciones")=="" ) {
			$("#ModalBox").load(
				"/acceso/password.asp",
				$("#frm_titulos").serialize(),
				function(recibe, textStatus, xhr) {}
			);
			
			$("#ModalBox").modal("show");
			
			return false;
			
		} else {
			$("#submit").click();
		}
		
	});
	
	$("#cmd-read-sel").click(function(e) {
		console.log("cmd-read-sel");
		
		//$("#frm_titulos input[name='zoom']").val(map.getZoom());
		//$("#frm_titulos input[name='lat']").val(map.getCenter().lat());
		//$("#frm_titulos input[name='lng']").val(map.getCenter().lng());
		if (act_map.zoom>0) {
			$("#frm_titulos input[name='zoom']").val(act_map.zoom);
			$("#frm_titulos input[name='lat']").val(act_map.lat);
			$("#frm_titulos input[name='lng']").val(act_map.lng);
			
			//$("#frm_titulos input[name='orden']").val( $("#frm_preguntas input[name='orden']").val() );
			//$("#frm_titulos input[name='ordent']").val( $("#frm_preguntas input[name='ordent']").val() );
		}
		
		//console.log("tab: ",  $(".PwTabs ul.nav>li.active a").data("id") );
		$("#frm_titulos input[name='tab']").val($(".PwTabs ul.nav>li.active a").data("id"));
		//console.log("frm_titulos:", $("#frm_titulos input[name='tab']").val() );
		
		//alert("continuar a leer...");
		//return false;
		$("#frm_titulos").submit();
		
	});
	
	$("#cmd-clear-sel").click(function(e) {
		//console.log("cmd-clear-sel");
		$("#frm_titulos input:checkbox").removeAttr("disabled");
		$("#frm_titulos input:checkbox").removeAttr("checked");
		
		$(".popover-check>button").removeClass("checked")
		$(".btnCheck").show();
		
		//$("#sel-count").html("0");
		$(".divCajaCheck").slideUp();
		$(".divCajaCheck .contadorSelect").animate({marginTop:"-45px"})
		
		$("#myMapDisp").hide("slow", "", function() {$("#myMapDisp").html("")});
		
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
					//async: false,
					url: "/disponibilidad/data/detalle.asp",
					data: {'id':id, 'secc':'disponibilidad'},
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
	
	<% if request.Form("dis")<>"" then %>
		console.log("MARCAMOS:")
		var sel_str = "<%= request.Form("dis") %>";
		var sel_arr = sel_str.split(",").map(
			function(x) {
				return parseInt(x, 10)
			});
		
		$.each(sel_arr, function(ii, elto) {
			//console.log(ii, elto);
			<% if request.Form("ordenando")="" then %>
			$("#chkDisp" + elto).click();
			<% else %>
			$("#chkDisp" + elto).prop("checked", true)
			<% end if %>
				
		})
		
		console.log("ocultar diapositivas y mostrar filtros")
		swMostrarDiapositivas = false;
		$(".divPreguntas").removeClass("activo");    //cierra preguntas
		$("#verSubmenu").removeClass("animaHide");
		$("#verSubmenu").click();
		
		if ($("#ciudad-filtro").val().trim().toLowerCase()=="madrid") {
			$("#filtrosDisponibilidad").show();
		} else if ($("#ciudad-filtro").val().trim().toLowerCase()=="barcelona") {
			$("#filtrosDisponibilidad").show();
		} else {
			$("#filtrosDisponibilidad").hide();
		}
		
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
'FORM //

function calcular_sql(swFiltros) 
	dim tmp_sql
	
	tmp_sql = tmp_sql & "id_tipo_inmueble=0 AND "
	tmp_sql = tmp_sql & "disponible_fecha IS NOT NULL"
	
	if swFiltros then
		if localidad<>"" then
			tmp_sql = tmp_sql & " AND "
			if localidad = "madrid" then
				tmp_sql = tmp_sql & "id_provincia = 2"
			elseif localidad = "barcelona" then
				tmp_sql = tmp_sql & "id_provincia = 3"
			else
				tmp_sql = tmp_sql & "localidad = '" & localidad & "'"
			end if
		end if
		
		if agencia<>"" then
			tmp_sql = tmp_sql & " AND id IN "
			tmp_sql = tmp_sql & "(SELECT DISTINCT id_inmueble FROM inmuebles_agentes WHERE (id_empresa = " & agencia & " AND tipo = 'comerc'))"
		end if
		
		if request.Form("min")="" then 
			min = 0
		else
			min = request.Form("min")
		end if
		if request.Form("max")="" then 
			max = 0
		else
			max = request.Form("max")
		end if
		
		if min=0 and max=0 then
			tmp_sql = tmp_sql & " AND disponible_min>0"
		else
			'tmp_sql = tmp_sql & " AND disponible_min>=" & min
			tmp_sql = tmp_sql & " AND id IN (SELECT DISTINCT id_inmueble FROM inmuebles_plantas WHERE "
			tmp_sql = tmp_sql & "disponible_superficie>=" & min
			if max>0 then
				tmp_sql = tmp_sql & " AND disponible_superficie<=" & request.Form("max")
			end if
			tmp_sql = tmp_sql & ")"
		end if
		
		if request.Form("id_subzona")<>"" then
			tmp_sql = tmp_sql & " AND id_subzona=" & request.Form("id_subzona")
		
		elseif request.Form("id_zona")<>"" then
			tmp_sql = tmp_sql & " AND id_area=" & request.Form("id_zona")
			
		end if
		
		If request("calle")<>"" then	
			sql_dir = ""
			
			calles = request("calle")
			calles = split(trim(calles), ",")
			
			for each elto in calles 
				'response.Write("<li>[" & elto & "]</li>")
				if trim(elto)<>"" then
					if sql_dir <> "" then sql_dir = sql_dir & " OR "
					'sql_dir = sql_dir & "NOMBRE_CALLE LIKE '%" & trim(elto) & "%'"
					sql_dir = sql_dir & "NOMBRE_CALLE COLLATE Latin1_General_CI_AI LIKE '%" & trim(elto) & "%' COLLATE Latin1_General_CI_AI"
					
					'"nombre COLLATE Latin1_General_CI_AI = '" & busqueda & "' COLLATE Latin1_General_CI_AI "
					'sql = sql & "OR nombre_completo COLLATE Latin1_General_CI_AI = '" & busqueda & "' COLLATE Latin1_General_CI_AI)
				end if
			next
			if sql_dir<>"" then
				sql_dir = " AND (" & sql_dir & ")"
			end if
			tmp_sql = tmp_sql &  sql_dir
			
		end if
		
	else
		tmp_sql = tmp_sql & " AND disponible_min>0"
		
	end if
		
	calcular_sql = tmp_sql
	
end function

function BusquedaVacia()	
	BusquedaVacia = "No tenemos disponibilidad para esta b&uacute;squeda."
	exit function
	
	rsBusq.open "SELECT COUNT(*) AS nn FROM dirs_w_inmuebles WHERE " & calcular_sql(false), session("connPW")
	
	if rsBusq("nn")=0 then
		BusquedaVacia = "No tenemos disponibilidad para esta b&uacute;squeda."
		'<style>
        '.contTodo { left: 0 !important }
        '</style>%><%
	else
		BusquedaVacia = "No hay disponibilidad aplicando estos filtros."
	end if
	
	if request.Cookies("dev")<>"" then BusquedaVacia = BusquedaVacia & " <span class='dev'>sin filtros "  & rsBusq("nn") & " inmuebles</span>"
	
	rsBusq.close
	
end function

sub Linea()	
	'if ids<>"" then ids=ids & ", "
	'ids = ids & rsBusq("id")
	counter = counter + 1 
	
	'c_nombre = "" & rsBusq("dir1")
	c_nombre = rsBusq("nombre_calle")
	
	if session("pw_ws").accesoDisponibilidad and ini=0 then
		c_numcalle = rsBusq("numero_calle")
	else
		c_numcalle = ""
	end if
	
	c_localidad = lcase(rsBusq("localidad"))
	if len(c_localidad)>18 then
		c_localidad = "<acronym title='" & replace(c_localidad, "'", "&#39;") & "'>" & left(c_localidad, 15) & "...</acronym>"
	end if
	
	c_id = rsBusq("id")
	c_link = "inmueble"
	
	if isnull(rsBusq("id_pais")) or rsBusq("id_pais")=0 then
		bandera = false
	else
		bandera = true
		c_bandera = rsBusq("id_pais") & ".png"
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
	
	total_superficie = total_superficie + cdbl(rsBusq("disponible_max"))
	
	if session("pw_ws").accesoDisponibilidad then 
		c_disp_fecha = FechaCorta(rsBusq("disponible_fecha"))
		if c_disp_fecha <> "" then
			c_disp_min = formatnumber(rsBusq("disponible_min"), 0)
			c_disp_max = formatnumber(rsBusq("disponible_max"), 0)
		end if
	else
		c_disp_fecha = "<img src='/img/lock.svg' width='14' height='14'/>" 
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
                <td class="tbDisp-Min"><%= c_disp_min %></td>
                <td class="tbDisp-Max"><%= c_disp_max %></td>
                <td class="tbDisp-Renta" data-id="<%= rsBusq("id") %>" id="inm_<%= rsBusq("id") %>-renta"><% if session("pw_ws").accesoDisponibilidad then %><span class="nd">N/D</span><% else %><img src="/img/lock.svg" width="14" height="14"/><% end if %></td>
                <td class="tbDisp-Fecha"><%= c_disp_fecha %></td>
            </tr>
        </table>
        <div class="tb-despliega" id="inm_<%= rsBusq("id") %>-detalles"><% if not session("pw_ws").accesoDisponibilidad then 
            %><p><img src="/img/lock.svg" width="14" height="14"/> Lo sentimos, pero esta informaci&oacute;n s&oacute;lo est&aacute; disponible para <a href="#" class="simplemodal">clientes</a>.</p><%
        end if %></div>
    </div>
    
</div>
<% end sub %>
