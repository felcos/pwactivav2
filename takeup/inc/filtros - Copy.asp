<!--
jp PENDIENTE

hay varios	id="informa_resultados"		>	data-content

-->
<%
localidad = trim(lcase(request.form("ciudad")))

datos = request.form("datos")
if datos="" then datos = "takeup"

yy = request.Form("year")
if yy="" then yy = "2017"
'datos = "disp"

row_activa =request.Form("datos")
if row_activa="" then row_activa = "takeup"
vista_activa = request.Form("tab")
if vista_activa="" then vista_activa="map"

tab = "map"
if request.form("tab")<>"" then tab = request.form("tab")
%>
<div class="filtros-navs activo" > 
	<div class="tab-content">
		<div class="tab-pane active" id="busqueda">
<form id="frm_preguntas" class="filtrosForm filtrosTakeUp" action="" method="POST" target="_blank">
	<input type="hidden" id="tab" name="tab" value="<%= tab %>"/>
    <input type="hidden" name="lat" value="<%= request.form("lat") %>"/>
    <input type="hidden" name="lng" value="<%= request.form("lng") %>"/>
    <input type="hidden" name="zoom" value="<%= request.form("zoom") %>"/>
    <input type="hidden" name="orden" value="<%= request.form("orden") %>"/>
    <input type="hidden" name="ordent" value="<%= request.form("ordent") %>"/>
    <% if request.form("dis")<>"" then %><input type="hidden" name="dis" value="<%= request.form("dis") %>"/><% end if %>
    <% if request.form("ope")<>"" then %><input type="hidden" name="ope" value="<%= request.form("ope") %>"/><% end if %>
    <input type="hidden" name="secc" value="takeup"/>
	<input type="hidden" name="datos" value="<%= datos %>" />
    
	<div class="col-xs-8 paddingR5">
		<div class="form-group">
			<label for="ciudad-filtro">Ciudad:</label>
            <div class="dropdown selectDrop" id="dropdown-ciudad">
    	        <select id="ciudad-filtro" name="ciudad" onchange="CambiaLocalidad();">
                	<option value="" <% if localidad="" then %>selected<% end if %>>Toda Espa&ntilde;a</option>
        	        <option value="madrid" <% if localidad="madrid" then %>selected<% end if %>>Madrid</option>
            	    <option value="barcelona" <% if localidad="barcelona" then %>selected<% end if %>>Barcelona</option>
        	    </select>
            	<div class="dropdown-toggle form-control" data-toggle="dropdown" id="" aria-expanded="false">
                	<span class="dropdown-txt paisNombre"></span> 
	                <span class="icon-arrow-down2 separadorSpan"></span>
    	        </div>
        	    <ul class="dropdown-menu" role="menu" ></ul>
	        </div>
		</div>
	</div>
	<div class="col-xs-4 paddingL5">
    	<div class="form-group">
        	<label for="year-filtro">Año:</label>
	        <div class="dropdown selectDrop" id="dropdown-year">
    	        <select id="year-filtro" name="year" onchange="CargarDatos();">
        	        <option value="2017" <% if yy="2017" then %>selected<% end if %>>2017</option>
			<option value="2016" <% if yy="2016" then %>selected<% end if %>>2016</option>
            	    	<option value="2015" <% if yy="2015" then %>selected<% end if %>>2015</option>
                	<option value="2014" <% if yy="2014" then %>selected<% end if %>>2014</option>
	                <option value="2013" <% if yy="2013" then %>selected<% end if %>>2013</option>
    	            <option value="2012" <% if yy="2012" then %>selected<% end if %>>2012</option>
        	    </select>
            	<div class="dropdown-toggle form-control" data-toggle="dropdown" id="" aria-expanded="false">
                	<span class="dropdown-txt paisNombre"></span> 
	                <span class="icon-arrow-down2 separadorSpan"></span>
    	        </div>
        	    <ul class="dropdown-menu" role="menu" ></ul>
	        </div>
    	</div>
	</div>
    
	<div id="filtrosDisponibilidad">
        <input type="hidden" name="id_zona" id="id_zona" value="<%= request.form("id_zona") %>">
        <input type="hidden" name="zona" id="zona" value="<%'= request.form("zona") %>">
        <input type="hidden" name="id_subzona" id="id_subzona" value="<%= request.form("id_subzona") %>">
        <input type="hidden" name="subzona" id="subzona" value="<%'= request.form("subzona") %>">
        
        <label>Area:</label>
        <ul class="nav nav-pills" id="nav-filtros">
            <!-- Zonas -->
            <li class="dropdown" id="li-zonas">
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
            </li>
        </ul>
        
        <div class="tab-content">
            <div class="tab-pane" id="zonas"></div>
            <div class="tab-pane" id="subzonas"></div>
        </div>
    </div>
    
    <div class="tb-Gral-cont" id="resumenGeneral">
<table  class="tabla tbFiltros">
    <caption id="informa-busq"></caption>
    <thead class="">
      <tr class="trFiltros">
        <th></th>
        <th>N&ordm;</th>
        <th>M<sup>2</sup></th>
        <th></th>
        <th colspan="2">Ver</th>
      </tr>
    </thead>
    
    <tbody  class="">
    
      <tr class="trFiltros <% if row_activa="disp" then %>activo<% end if %>">
		<td><span class="icoMapas"><img src="/img/ico-mapa02.png"></span> Disponibilidad</td>
		<td id="of-disp">&nbsp;</td>
		<td id="sup-disp">&nbsp;</td>
		<td></td>
		<td><a href="#" class="btFiltros <% if row_activa="disp" and vista_activa="map" then %>activo<% end if %>" data-tab="map" data-type="disp"><span class="icon-location"></span></a></td>
		<td><a href="#" class="btFiltros <% if row_activa="disp" and vista_activa="list" then %>activo<% end if %>" data-tab="list" data-type="disp"><span class="icon-menu"></span></a></td>
      </tr>
      <tr class="trFiltros <% if row_activa="takeup" then %>activo<% end if %>">
      	<td><span  class="icoMapas"><img src="/img/ico-azul02.png"></span> Take Up</td>
        <td id="of-takeup">&nbsp;</td>
		<td id="sup-takeup">&nbsp;</td>
        <td></td>
        <td><a href="#" class="btFiltros <% if row_activa="takeup" and vista_activa="map" then %>activo<% end if %>" data-tab="map" data-type="takeup"><span class="icon-location"></span></a></td>
        <td><a href="#" class="btFiltros <% if row_activa="takeup" and vista_activa="list" then %>activo<% end if %>" data-tab="list" data-type="takeup"><span class="icon-menu"></span></a></td>
      </tr>
      
      <tr class="trFiltros desglose <% if row_activa="alq" then %>activo<% end if %>">
        <td><span class="bolo">·</span> Alquiler</td>
        <td id="of-alq">&nbsp;</td>
		<td id="sup-alq">&nbsp;</td>
        <td></td>
        <td><a href="#" class="btFiltros <% if row_activa="alq" and vista_activa="map" then %>activo<% end if %>" data-tab="map" data-type="alq"><span class="icon-location"></span></a></td>
        <td><a href="#" class="btFiltros <% if row_activa="alq" and vista_activa="list" then %>activo<% end if %>" data-tab="list" data-type="alq"><span class="icon-menu"></span></a></td>
      </tr>
      
      <tr class="trFiltros desglose <% if row_activa="ocup" then %>activo<% end if %>">
        <td><span class="bolo">·</span> Ocup. prop.</td>
        <td id="of-ocup">&nbsp;</td>
		<td id="sup-ocup">&nbsp;</td>
        <td></td>
        <td><a href="#" class="btFiltros <% if row_activa="ocup" and vista_activa="map" then %>activo<% end if %>" data-tab="map" data-type="ocup"><span class="icon-location"></span></a></td>
        <td><a href="#" class="btFiltros <% if row_activa="ocup" and vista_activa="map" then %>activo<% end if %>" data-tab="list" data-type="ocup"><span class="icon-menu"></span></a></td>
      </tr> 
      <% 'if request.Cookies("dev")<>"" then %>
      <tr class="trFiltros">
        <td><span class="icoMapas"><img src="/img/mapa.png"></span> Edif. Regs.</td>
        <td id="of-total">&nbsp;</td>
		<td id="sup-total">&nbsp;</td>
        <td></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <% 'end if %>
    </tbody>
</table>
	</div> 
    <input type="hidden" name="agencia" value="<%= request.Form("agencia") %>" />
    <input type="hidden" name="agencia_nombre" value="<%= request.Form("agencia_nombre") %>" />
	<div id="tabla-agencias" class="tb-Gral-cont">
		<table class="tabla tbFiltros tbagencias">
		<caption>Agencias m&aacute;s activas</caption>
		<thead class="">
			<tr class="trFiltros">
				<th></th>
				<th>N&deg;</th>
				<th>M<sup>2</sup></th>
        		<th>%</th>
				<th></th>
				<th>Filtrar</th>
			</tr>
		</thead>
		<tbody class=""></tbody>
		</table>
    </div>
    
</form>

		</div>
	</div>
</div>
<script>
$(document).ready(function() {
//	$("#verSubmenu").data("clicks", false);
//	btSubmenu($("#verSubmenu"));
	
	$("#verSubmenu").on("click", function (e) {
	     btSubmenu($(this));
		 e.preventDefault();
	});
	
	$("#resumenGeneral .btFiltros").click(function(e) {
		$("#resumenGeneral .btFiltros").removeClass("activo");
		$(this).addClass("activo");
		
		$.each($("#resumenGeneral tr.trFiltros"), function(ii, fila) {
			$(fila).removeClass("activo")
		})
		$(this).closest("tr.trFiltros").addClass("activo");
		
        var tabActual = $(".PwTabs > .nav-tabs .active > a").data("id");
		var tabClick = $(this).data("tab");
		if (tabActual==tabClick) {
			//console.log("cancelado, mismo tab");
		} else {
			$(".PwTabs .nav-tabs a[href='#" + tabClick + "']").tab("show");
		}
		
		var tipoActual = $("#frm_preguntas input[name='datos']").val();
		var tipoClick = $(this).data("type");
		
		if (tipoActual==tipoClick) {
			//console.log("cancelado, mismo tipo")
		} else {
			$("#frm_preguntas input[name='datos']").val(tipoClick);
			$("#frm_preguntas input[name='agencia']").val("");
			$("#frm_preguntas input[name='agencia_nombre']").val("");
			CargarDatos();
		}
		return false;
		
    });
	
})
</script>