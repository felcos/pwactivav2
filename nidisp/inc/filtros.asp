<%
'jp PENDIENTE
'hay varios	id="informa_resultados"		>	data-content

vista_activa = request.Form("tab")
if vista_activa="" then vista_activa="map"
%>
<div class="filtros-navs" > 
	<div class="tab-content">
		<div class="tab-pane active" id="busqueda">
<form id="frm_preguntas" class="filtrosForm" action="/nidisp/data/ajax.asp" method="post" target="_blank">
    <input type="hidden" id="frmInfo_disp_tab" name="frmInfo_disp_tab" value="<%= act_tab %>"/>
	<input type="hidden" name="frmInfo_busq" value="<%= frmInfo_busq %>">
    <input type="hidden" name="lat" value="<%= request.Form("lat") %>" id="frmInfo_disp_lat"/>
    <input type="hidden" name="lng" value="<%= request.Form("lng") %>" id="frmInfo_disp_lng"/>
    <input type="hidden" name="zoom" value="<%= request.Form("zoom") %>" id="frmInfo_disp_zoom"/>
    <input type="hidden" name="orden" value="<%= request.Form("orden") %>" id="frmInfo_disp_orden"/>
    <input type="hidden" name="ordent" value="<%= request.Form("ordent") %>" id="frmInfo_disp_ordent"/>
    <input type="hidden" name="secc" value="nidisp"/>
    <% if request.Form("dis")<>"" then %><input type="hidden" name="dis" value="<%= request.Form("dis") %>"/><% end if %>

<!--
<br />
<a href="javascript:$('#frm_preguntas').submit();">_blank</a> &nbsp; <a href="javascript:CargarDatos();">filtrar</a>
 &nbsp; <a href="javascript:CargaAgencias();">agencias</a>
<hr />
-->
<!-- ciudad-->
<div class="form-group">
	<label for="ciudad-filtro">¿En qué ciudad de Europa?</label>
	<input type="text" id="ciudad-filtro" name="ciudad" class="form-control" placeholder="Ej. Madrid" autocomplete="off" value="<%= trim(ucase(request.form("ciudad"))) %>"><!--  onchange="CambiaLocalidad();" -->
    <div class="depura-filtros ciudad">xxx</div>
</div>

<div class="tit_resultados" id="">
	<div class="tb-Gral-cont">
<table class="tabla tbFiltros" id="tblResumen">
<caption id="informa-busq"></caption>
<thead class="">
<tr class="trFiltros">
	<th></th>
	<th>Nº</th>
	<th>M<sup>2</sup></th>
	<th></th>
	<th colspan="2">Ver</th>
</tr>
</thead>
<tbody class="">
<tr class="trFiltros">
	<td>Of. Disponibles</td>
	<td id="of-disp"></td>
	<td id="sup-disp"></td>
	<td></td>
	<td><a href="#" class="btFiltros <% if vista_activa="map" then %>activo<% end if %>" data-tab="map"><span class="icon-location"></span></a></td>
	<td><a href="#" class="btFiltros <% if vista_activa="list" then %>activo<% end if %>" data-tab="list"><span class="icon-menu"></span></a></td>
</tr>
<tr class="trFiltros">
	<td>Of. Registradas</td>
	<td id="of-total"></td>
	<td id="sup-total"></td>
	<td></td>
	<td><!-- <a href="#" class="btFiltros"><span class="icon-location"></span></a> --></td>
	<td><!-- <a href="#" class="btFiltros"><span class="icon-menu"></span></a> --></td>
</tr>

<tr class="trTotalAlquilado">
	<td>Total Alquilado:</td>
	<td colspan="5"><span class="alquilado-porcentaje" style="font-weight:bold;"></span> <span class="totalAlquilado">@<%= date() %></span></td>
</tr>
</tbody>
</table>
	</div>
</div>

<!-- m2-->
<div class="form-group clearfix periodo"> 
	<label for="metros-filtro">¿Qué M<sup>2</sup> buscas?</label>
	<input type="text" name="min" id="frmInfo_disp_min" class="form-control bl50" placeholder="Desde..." value="<%= request.Form("min") %>" autocomplete="off">
	<input type="text" name="max" id="frmInfo_disp_max" class="form-control bl50" placeholder="Hasta" value="<%= request.Form("max") %>" autocomplete="off">
    <div class="depura-filtros periodo">Los valores no son v&aacute;lidos</div>
</div>

<!-- agencia-->
<div class="form-group">
	<label for="agencia">Agencia:</label>
	<div class="dropdown selectDrop" id="dropdown-agencias"><!--include virtual="/nidisp/data/select_agencias.asp" --></div>
</div>

<div id="filtrosDisponibilidad">
	<input type="hidden" name="id_zona" id="id_zona" value="<%= request.Form("id_zona") %>">
    <input type="hidden" name="zona" id="zona" value="<%= request.Form("zona") %>">
    <input type="hidden" name="id_subzona" id="id_subzona" value="<%= request.Form("id_subzona") %>">
    <input type="hidden" name="subzona" id="subzona" value="<%= request.Form("subzona") %>">
    
    <label>Area:</label>
    <ul class="nav nav-pills" id="nav-filtros">
		<!-- Zonas -->
        <li class="dropdown">
			<a class="dropdown-toggle" data-toggle="dropdown" href="#">Zonas <span class="caret"></span> </a>
			<ul class="dropdown-menu" id="ul-zonas">
	            <li data-id=""><a href="#zonas" data-toggle="tab" onclick="CambiaZona();">Todas las Zonas</a></li>
				<li data-id="6"><a href="#zonas" data-toggle="tab" onclick="CambiaZona(6);">PRIME</a></li>
				<li data-id="1"><a href="#zonas" data-toggle="tab" onclick="CambiaZona(1);">A1</a></li>
				<li data-id="2"><a href="#zonas" data-toggle="tab" onclick="CambiaZona(2);">A2</a></li>
				<li data-id="3"><a href="#zonas" data-toggle="tab" onclick="CambiaZona(3);">A3</a></li>
				<li data-id="7"><a href="#zonas" data-toggle="tab" onclick="CambiaZona(7);">DEC</a></li>
				<li data-id="5"><a href="#zonas" data-toggle="tab" onclick="CambiaZona(5);">OUT</a></li>
			</ul>
		</li>
		<!-- Subzonas -->
		<li class="dropdown" id="li-subzonas">
        	<a class="dropdown-toggle" data-toggle="dropdown" href="#">Subzonas <span class="caret"></span> </a>
			<!-- include virtual="/nidisp/data/ul_subzonas.asp" -->
		</li>
		<!-- Calle(s) -->
		<li><a href="#calle" data-toggle="tab">Calle</a></li>
	</ul>
	
	<div class="tab-content">
		<div class="tab-pane" id="zonas">
			<!--
			<div class="tit_resultados" id="informa_resultados">
				<p><span class="tit_busqueda">ZONA </span><span class="tit_numero">XXX inmuebles</span><span class="tit_metros">, con un total de YYY m²</span></p>
			</div>
			-->
		</div>
		<div class="tab-pane" id="subzonas"> 
			<!--
			<div class="tit_resultados" id="informa_resultados">
				<p><span class="tit_busqueda">SUBZONA </span><span class="tit_numero">XXX inmuebles</span><span class="tit_metros">, con un total de YYY m²</span></p>
			</div>
			-->
		</div>
		<div class="tab-pane" id="calle">
			<input type="text" class="calle-filtro form-control" name="calle" placeholder="Ej. Castellana">
			<div class="bts-mascalles periodo clearfix">
				<span class="bl50"><button class="btn gris bt-mascalles" type="button">+ Añadir calles</button></span>
				<span class="bl50" ><button class="btn bt-calleMapa" type="button" disabled id="bt-enviar"> Ver en mapa</button></span>
			</div>
			<!--
			<div class="tit_resultados" id="informa_resultados">
				<p><span class="tit_busqueda"></span><span class="tit_numero">XXX inmuebles</span><span class="tit_metros">, con un total de YYY m²</span></p> 
			</div>
			-->
		</div>
	</div>
</div>
</form>
		</div>
	</div>
</div>
<script>
	$("#filtrosDisponibilidad").hide();
	
	function LimpiaCalles() {
		$.each($(".div-calle-filtro"), function(ii, elto) {
			$(elto).remove();
		})
		$($("#calle .calle-filtro")[0]).val("");
		$("#bt-enviar").attr("disabled", true);
	}
	
	function filtros_CiudadOK() {
		console.log("filtros_CiudadOK");
		
		if ($.trim($("#ciudad-filtro").val())=="") {
			$(".depura-filtros.ciudad").text("Hay que rellenar el campo");
			$(".depura-filtros.ciudad").slideDown();
			return false;
			
		} else {
			if (CiudadDisponible($("#ciudad-filtro").val())) {
				$(".depura-filtros.ciudad").slideUp();
				return true;
			} else {
				$(".depura-filtros.ciudad").text("Sin disponibilidad para esta búsqueda");
				$(".depura-filtros.ciudad").slideDown();
				return false;
			}
		}
		
	}
	
	function filtros_RangoOK() {
		var pasa = false;
		
		if ($("#frmInfo_disp_min").val()=="" || $("#frmInfo_disp_max").val()=="") {
			pasa = true;
		} else {
			if (parseInt($("#frmInfo_disp_min").val())<=parseInt($("#frmInfo_disp_max").val())) {
				pasa = true;
			} else {
				pasa = false;
			}
		}
		
		if (pasa) {
			//$("#depura").slideUp(300);
		} else {
			$(".depura-filtros.periodo").slideDown(300);
			//$("#frmInfo_disp_min").focus();
		}
		
		console.log("filtros_RangoOK: ", pasa);
		//console.log($("#desde").val(), $("#hasta").val(), "RangoOK: "+pasa);
		return pasa;
	}

$(document).ready(function() {
	$("#verSubmenu").data("clicks", false);
	btSubmenu($("#verSubmenu"));
	
	$("#tblResumen .btFiltros").click(function(e) {
		console.log(this)
		
		$("#tblResumen .btFiltros").removeClass("activo");
		$(this).addClass("activo");
		
        var tabActual = $(".PwTabs > .nav-tabs .active > a").data("id");
		var tabClick = $(this).data("tab");
		
		console.log("tabActual: " + tabActual, ">>", "tabClick: " + tabClick)
		if (tabActual==tabClick) {
			console.log("cancelado, mismo tab");
		} else {
			$(".PwTabs .nav-tabs a[href='#" + tabClick + "']").tab("show");
			//$(".PwTabs .nav-tabs a[href='#" + tabClick + "']").click();
		}
		return false;
	})
	
	$("#verSubmenu").on("click", function (e) {
	     btSubmenu($(this));
		 e.preventDefault();
	});
	
	$("#frmInfo_disp_min, #frmInfo_disp_max").keydown(function (e) {
		if (e.keyCode == 13 || e.keyCode == 9) {	//
			var campo = $(this).closest("input[type='text']")[0];
			
			if ( filtros_RangoOK() ) {
				
				//if (filtros_CiudadOK()) {
					if (frm_data != $("#frm_preguntas").serialize()) {
						CargaAgencias();
						CargarDatos();
					}
					//console.log( $(campo).prop("id") )
				//}
			}
			
			return false;
		}
		
		// Allow: backspace, delete, escape, tab 
		// , 13
        if ($.inArray(e.keyCode, [46, 8, 27, 110, 9]) !== -1 ||
             // Allow: Ctrl+A
            (e.keyCode == 65 && e.ctrlKey === true) ||
             // Allow: Ctrl+C
            (e.keyCode == 67 && e.ctrlKey === true) ||
             // Allow: Ctrl+X
            (e.keyCode == 88 && e.ctrlKey === true) ||
             // Allow: Ctrl+V
            (e.keyCode == 86 && e.ctrlKey === true) ||
             // Allow: home, end, left, right
            (e.keyCode >= 35 && e.keyCode <= 39)) {
                 //console.log(e.keyCode)
                 return;
        }
        // Ensure that it is a number and stop the keypress
        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
            e.preventDefault();
        }
    });
	
	$("#frmInfo_disp_min").blur(function(e) {
		console.log("frmInfo_disp_min blur");
		if (filtros_RangoOK()) {
			$(".depura-filtros.periodo").slideUp(300);
		} else {
			$(".depura-filtros.periodo").slideDown(300);
		};
    });
	$("#frmInfo_disp_max").blur(function(e) {
		console.log("frmInfo_disp_max blur");
		if (filtros_RangoOK()) {
			$(".depura-filtros.periodo").slideUp(300);
		} else {
			$(".depura-filtros.periodo").slideDown(300);
		}
    });
	
	$("#ciudad-filtro").keydown(function (e) {
		//console.log("ciudad-filtro keydown [" + e.keyCode + "]")
        //e.preventDefault();
		
		if (e.keyCode == 13 || e.keyCode == 9) {	//
			//console.log("filtros_CiudadOK", filtros_CiudadOK)
			if (filtros_CiudadOK()) {
				
				if (filtros_RangoOK()) {
					// ?? $("#frm_preguntas input[name='min']").val( $("#desde").val() );
					// ?? $("#frm_preguntas input[name='max']").val( $("#hasta").val() );
					if (frm_data != $("#frm_preguntas").serialize()) {
						CambiaLocalidad();
					}
				} else {
					$("#frmInfo_disp_min").focus();
				}
				
			} else {
				if (frm_data != $("#frm_preguntas").serialize()) {
					CambiaLocalidad();
				}
			}
			return false;
		}
		
    });
	
	
	/*  cerrar depuraAA*/
	$("#bt-enviar").on("click",function() {
		console.log("bt-enviar");
		if ($("[aria-label='ciudad']").val()=="") {
			console.log(" ==''");
		    $("[aria-label='ciudad']").css({"border-color": "red"});
			//$(this).css({"border": "red"});
			$(".depuraAA").text("Tienes que rellenar este campo");
			$(".depuraAA").slideToggle();
			//alert("hola");
			return false;
		}
		CargarDatos();
		
	});
	
	/*  bt masCalles >  añade camposinput .calle-filtro para introducir más calles */
	$(".bt-mascalles").on("click", function() {
		var nCalles = $("#calle .calle-filtro").length;
		var cadenaCalles =  "<div class='div-calle-filtro'><input type='text' class='calle-filtro form-control' name='calle' placeholder='Añade otra calle'><span class='borrarInput'><a href='#' class='btn'><span class='icon-cross'></span></a></span></div>"
		
		if (nCalles <9) {
			$(".bts-mascalles ").before(cadenaCalles);
		} else if ( nCalles == 9) {
			$(".bts-mascalles ").before(cadenaCalles);
			//$('#calle .calle-filtro').attr("placeholder","Añade otra calle");
			// alert($('#calle .calle-filtro').eq(9).html());
			$("#calle .calle-filtro").eq(9).attr("placeholder", "Añade la última calle");
		} else {
			return false;
		}
		
		//OLD
		//if ( nCalles <9) {
		//	$(".bts-mascalles ").before("<div><input type='text' class='calle-filtro form-control' name='calle' placeholder='Añade otra calle'><span class='borrarInput'><a href='#' class='btn'><span class='icon-cross'></span></a></span></div>");
		//} else if ( nCalles < 10 ) {
		//	$(".bts-mascalles ").before("<div><input type='text' class='calle-filtro form-control' name='calle' placeholder='Añade la última calle'><span class='borrarInput'><a href='#' class='btn'><span class='icon-cross'></span></a></span></div>");	
		//} else if (( nCalles == 10 )&& ( $('p.info-filtro').length )) {
		//	return false;
		//} else {
		//	$(".calle-filtro:last").parent().append("<p class='info-filtro'> Has llegado al límite de <strong>10 calles</strong> seleccionables<p>");
		//	//$(".bts-mascalles").before("<p class='info-filtro'> Has llegado al límite de <strong>10 calles</strong> seleccionables<p>");
		//}
		
	});
	
	$("#calle").on("click", ".borrarInput>a", function(e) {
		if ( $("#calle .calle-filtro").length == 10) {
			$("#calle .calle-filtro").attr("placeholder", "Añade otra calle");
		}
		$(this).closest("div").remove();
		e.preventDefault();
	});

	/* activa el bt-calleMapa  */				
	$("#calle").on("change", ".calle-filtro", function() {
		if( $(".bt-calleMapa").attr("disabled")){
			$(".bt-calleMapa").removeAttr("disabled");
			$(".bt-calleMapa").addClass("btnAzul");
		}
	});
	
})
</script>