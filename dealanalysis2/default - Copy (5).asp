<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<% '
swLoadGMap=true
if session("navegador")="old" then swLoadGMap=false

swMostrarDetalles = false
if  session("pw_ws").accesoOperacionesHoy or session("pw_ws").accesoOperaciones then swMostrarDetalles = true	

sec_actual = "/dealanalysis/"

dim FechaI
dim FechaF
public sql
dim ErrMesage
dim MensajeError

'Recordsets		
set rsTmp = Server.CreateObject("ADODB.Recordset")

r_pais=request.Form("pais")
'if r_pais="" then r_pais="1"
r_localidad=request.Form("localidad")
r_busqlocalidad=request.Form("busqlocalidad")

'Operación		
r_operacion=request("operacion")
if r_operacion="" then 
	ErrMesage = "Falta Operaci&oacute;n."
end if

'Sección		
r_seccion=request("sec")
if r_seccion="" then 
	ErrMesage = "Falta Uso."
end if

'Fechas			
r_TipoFecha = request("tipofecha")
if r_TipoFecha = "" then r_TipoFecha = "op"

if Request("FechaF")="" then
	FechaF = date
else
	FechaF = cdate(Request("FechaF"))
end if

if Request("FechaI")="" then 
	FechaI = dateadd("m", -3, date)
else
	FechaI = cdate(Request("FechaI"))
end if 
%>
<!DOCTYPE html>
<html lang="es">
<head>
<title>PropertyWeb - Deal Analysis</title>
	<!--#include virtual="/inc/head.asp" -->
    
	<% if swLoadGMap then %>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC_5kUZnI4pDgH19ptKkMuneHuz0tJ5P6g&region=ES"></script>
    <script src="/lib/maps/infobox.js" type="text/javascript"></script>
    <% end if %>
    
    <link href="/dealanalysis/resumen/tabla.css" rel="stylesheet" type="text/css">
    
    <link href="/lib/qtip/jquery.qtip.css" type="text/css" rel="stylesheet" />
    <script src="/lib/qtip/jquery.qtip.js" type="text/javascript"></script>
	
    <link href="/lib/bootstrap-datepicker/bootstrap-datepicker3.css" rel="stylesheet" type="text/css">
    <script src="/lib/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
    <script src="/lib/bootstrap-datepicker/bootstrap-datepicker.es.js"></script>
    
    <link href="/css/css-pags/mapaCoord.css" rel="stylesheet" type="text/css">
    <link href="/css/css-pags/tabs02.css" rel="stylesheet" type="text/css">
	
    <link href="/css/css-pags/elementosForm.css" rel="stylesheet" type="text/css">
    <!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-143927921-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-143927921-1');
</script>
</head>
<body>
<!--#include virtual="/inc/body-header.asp" -->
<div class="container">
	<section id="s_buscador" class="row">
		<div class="col-md-8 caja"><h1 class="heading">Deal Analysis</h1></div>
		<div class="col-md-4 lateral">
			<div class="caja sombra"><!--#include virtual="/dealanalysis/resumen/tabla.asp" --></div>
		</div>
		
		<div class="col-md-8">
<form name="frm_deal" id="frm_deal" method="post" action="/dealanalysis/resultados/resultados.asp" target="_blank" autocomplete="off" class="form-horizontal row">
  
  <div id="div_formulario" name="div_formulario">
    <div class="caja clearfix">
    <!-- input type="hidden" name="frm" value="frm_deal" -->
    <input type="hidden" name="secc" value="ope">
    <% if request.Form("zoom")<>"" then %>
    	<input type="hidden" id="setcoords_zoom" name="zoom" value="<%= request.Form("zoom") %>">
        <input type="hidden" id="setcoords_lat" name="lat" value="<%= request.Form("lat") %>">
        <input type="hidden" id="setcoords_lng" name="lng" value="<%= request.Form("lng") %>">
    <% end if %>
    <input type="hidden" id="settab" name="tab" value="<%= request.Form("tab") %>">
    <div class="form-group" ><!-- pais form-group-->
      <div id="div_pais" >
        <% 'País		
                rsTmp.open "SELECT * FROM PAISES WHERE ID>=0 ORDER BY NOMBRE", session("connPW")
                ' onChange="document.forms['busfrm'].submit();"
                %>
        <label for="pais" class="control-label col-sm-2">Pa&iacute;s:</label>
        <div class="col-sm-4">
          <select name="pais" id="pais" onChange="cambiopais();" class="form-control">
            <option value="1" <% if r_pais="1" then %>selected<% end if %>>espa&ntilde;a</option>
            <% do while not rsTmp.eof %>
            <option value="<%= rsTmp("ID") %>" <% if r_pais=cstr(rsTmp("ID")) then %>selected<% end if %>><%= lcase(rsTmp("NOMBRE")) %></option>
            <% rsTmp.movenext()
                loop %>
          </select>
          <%
                rsTmp.close
                %>
        </div>
      </div>
      <div name="frm_deal_provincia" id="frm_deal_provincia" >
        <label for="provincia" class="control-label col-sm-2 opcional">Provincia:<sup><span style="color:#f47c04;">*</span></sup></label>
        <%
                response.flush
                r_provincia=request.Form("provincia")
                
                sql = "SELECT * FROM PROVINCIAS WHERE id_pais=1 AND cod IS NOT NULL ORDER BY NOMBRE"
                rsTmp.Open sql, session("connPW")
                'onChange="CargarComboLocalidades(document.busfrm.provincia.value,document.busfrm.localidad)"
                %>
        <div class="col-sm-4">
          <select name="provincia" id="provincia" onChange="cambioprovincia();" class="form-control">
            <option value="" <% if r_provincia="" then %>selected<% end if %>> </option>
            <% do while not(rsTmp.EOF) %>
            <option value="<%= rsTmp("ID") %>" <% if r_provincia=cstr(rsTmp("ID")) then %>selected<% end if %>><%= lcase(rsTmp("NOMBRE")) %></option>
            <% rsTmp.MoveNext()
                loop %>
            <option value="%" <% if r_provincia="%" then %>selected<% end if %>>Todas las provincias</option>
          </select>
          <%
                rsTmp.close
                %>
        </div>
      </div>
    </div>   <!-- fin form-group -->
    <div class="form-group"><!-- localidad form-group -->
      <div id="div_localidad">
        <label for="busqlocalidad" class="control-label col-sm-2">Localidad:</label>
        <div class="col-sm-4">
          <input type="textfield" name="busqlocalidad" id="busqlocalidad" value="<%= r_busqlocalidad %>" placeholder="ej. madrid barcelona" class="form-control" autocomplete="off">
          <input type="hidden" name="localidad" id="localidad" value="<%= r_localidad %>" style="width:20px; background-color:#FFFFCC; margin-top:8px;">
        </div>
      </div>
      <div class="col-sm-6"><!-- ;   return expandir('frm_deal_dir');    DESPLEGAR--> 
        <a href="javascript:void(0);" onclick="expande();" ><span class="icon-circle-down"></span> <span id="mas_dir">m&aacute;s</span> filtros de direcci&oacute;n</a> </div>
    </div>    <!-- fin form-group -->
    
    
    <hr class="clearfix">    
    <div class="form-group" ><!--  frm_deal_zona_inmobiliaria  -->
      <div id="frm_deal_zona_inmobiliaria" name="frm_deal_zona_inmobiliaria" class="" style="display:none;">
        <label class="control-label col-sm-3"> &Aacute;rea Inmobiliaria:&nbsp;</label>
        <div class="col-sm-4 ">
          <select name="zonainmobiliaria" onChange="$('#frm_deal').submit();" class="form-control ">
            <%
                    r_zonainmobiliaria=request.Form("zonainmobiliaria")
                    if r_zonainmobiliaria="" then r_zonainmobiliaria="%"
                    set zonarecordset = Server.CreateObject("ADODB.Recordset")
                    sql = "SELECT * FROM TIPOS_DE_AREAS WHERE ACTIVO<>0 AND ID>0 ORDER BY TIPOS_DE_AREAS.NOMBRE"
                    zonarecordset.Open sql, session("connPW")
                    %>
            <option <% if r_zonainmobiliaria="%" then %>selected<% end if %> value="%">Cualquiera</option>
            <% do while not zonarecordset.EOF %>
            <option <% if r_zonainmobiliaria=cstr(zonarecordset("ID")) then %>selected<% end if %> value="<%= zonarecordset("ID") %>"><%= zonarecordset("NOMBRE") %></option>
            <% zonarecordset.MoveNext
                    loop 
                    zonarecordset.close
                    set zonarecordset = nothing
                    %>
          </select>
        </div>
      </div>
    </div> <!-- fin form-group -->
    
   
      <div id="div_deal2 clearfix">  
        <div id="frm_deal_dir" style="display:none; "  > <!--  oculto    -->
          <div class="form-group">                         <!-- oculto form-group -->
            <label class="control-label col-sm-3">Buscar: </label>
            
            <div class="col-sm-3">
              <input type="radio" value="calle" checked name="R1" >
              Calle<br>
              <input type="radio" name="R1" value="zona">
              Zona<br>
              <input type="radio" name="R1" value="codigopostal">
              C.Postal 
            </div>

          <div class="col-sm-5">
            <textarea name="valores" id="valores" rows="5" onChange="$('#frm_deal').submit();" class="form-control"><%= request.Form("valores") %></textarea>
          </div>
          
        </div><!-- fin form-group -->        
          <div class="form-group">   <!-- texto form-group -->
              <div class="col-sm-12"> Puede indicar hasta 10 nombres de calle, c&oacute;digos postales o zonas para realizar la b&uacute;squeda.<br>
                Separe los valores por comas o saltos de l&iacute;nea.
              </div>
              <div class="col-sm-12 form-botones">
              <input name="consulta" type="submit" value="Buscar">
              </div>
          </div>    <!-- fin form-group-->
		  <hr class="clearfix">
                 
        </div><!--  fin oculto    -->
      </div><!--  finid="div_deal2     -->
      
    <!--</div> ????   fin div-formulario -->
   
    <div class="form-group"> <!--  form-group -->
      
      <label for="sec" class="control-label col-sm-2">Uso:</label>
      
      <div class="col-sm-4">
        <select name="sec" id="sec" size="8" onChange="cambioseccion();" class="form-control">
        <%		
                        rsTmp.open "SELECT * FROM secciones_operaciones WHERE simple=1 AND ACTIVO=1 ORDER BY orden", session("connPW")
                        ' onChange="document.forms['busfrm'].submit();"
                        do while not rsTmp.eof 
                            %>
        <option value="<%= lcase(rsTmp("nombre")) %>" <% if r_seccion=lcase(rsTmp("nombre")) then %>selected<% end if %>><%= lcase(rsTmp("nombre")) %></option>
        <%
                            rsTmp.movenext
                            loop
                        rsTmp.close 
                        %>
        </select>
      </div>
      
      <label for="operacion" class="control-label col-sm-2">Tipo de Operaci&oacute;n:</label>
      
      <div class="col-sm-4">
        <select name="operacion" id="operacion" size="2" onChange="cambiooperacion();" class="form-control">
          <option value="venta" <% if r_operacion="venta" then %>selected<% end if %>>inversi&oacute;n/ocupaci&oacute;n propia </option>
          <option value="alquiler" <% if r_operacion="alquiler" then %>selected<% end if %>>alquiler/traspaso</option>
        </select>
      </div>
      
      <div id="div_usosolar" style="margin-top:8px; display:none;"> Uso del solar:<br>
        <select name="uso_solar" style="width:240px; margin-left:8px;" class="frm_textos">
          <option value="" <% if r_uso_solar="" then %>selected<% end if %>>cualquiera</option>
          <%	
                        sql = "SELECT * FROM TIPOS_DE_USOS_SOLAR ORDER BY NOMBRE"
                        rsTmp.Open sql , session("connPW")
                        do while not rsTmp.EOF
                            %>
          <option value="<%= rsTmp("ID") %>" <% if r_uso_solar=cstr(rsTmp("ID")) then %>selected<% end if %>><%= lcase(rsTmp("NOMBRE")) %></option>
          <% 
                            rsTmp.MoveNext 
                        Loop
                        rsTmp.Close
                        %>
        </select>
      </div>
      
    </div>   <!-- fin form-group-->    
    <div class="form-group"> <!--  form-group style="background-color:red" -->
      
      <label for="FechaI" class="col-sm-2 control-label">Per&iacute;odo de:</label>
      <div class="col-sm-4">
        <input type="text" name="FechaI" id="FechaI" value="<%= FechaI %>" maxlength="10" class="form-control">
      </div>
      <label for="FechaI" class="col-sm-2 control-label">hasta:</label>
      <div class="col-sm-4">
        <input type="text" name="FechaF" id="FechaF" value="<%= FechaF %>" maxlength="10" class="form-control">
      </div>
    </div>   <!-- fin form-group-->
    
    
    <!-- <label for="FechaI" class="control-label col-sm-2" >Per&iacute;odo:</label>
          <% if 1=2 then %>
       <select name="fecha" class="">
            <option value="trim">&Uacute;ltimo Trimestre</option>
            <option value="sem">&Uacute;ltimo Semestre</option>
            <option value="yy">&Uacute;ltimo A&ntilde;o</option>
            <option value="yy_act">A&ntilde;o Actual</option>
            <option value="rango">Rango de Fechas</option>
          </select>--> 
    <!--
          de
          <select name="tipofecha" onChange="$('#frm_deal').submit();">
            <option value="op">operaci&oacute;n</option>
            <option value="pub">publicaci&oacute;n</option>
          </select>
          <% end if %>
          <input type="text" name="FechaI" id="FechaI" value="<%= FechaI %>" maxlength="10" class="fecha">
          &nbsp;-&nbsp;
          <input type="text" name="FechaF" id="FechaF" value="<%= FechaF %>" maxlength="10" class="fecha"> -->
    
      <div> 
         <a href="javascript:void(0);" onclick="ver_avanzado();" ><span class="icon-circle-down"></span> formulario <span id="lbl_avanzado">avanzado</span></a>
      </div>
  </div>
  
  
  </div>
  <!-- fin col-8 --> 
  <!-- clase form--> 
  
  <!-- INI : form_avanzado -->
  <div id="frm_deal_avanzado" class="caja" style="display:none;">
  
    <!-- jj -->
    <%
r_TipoPrecio  = request("TipoPrecio")
if r_TipoPrecio="" then r_TipoPrecio="euro"

r_TipoRenta  = request("TipoRenta")
if r_TipoRenta="" then r_TipoRenta="euro/m2/mes"

%>
    <div class="camposOpcionales"><span >*</span> Campos Opcionales</div>
    <p id="lblPrecioRenta">Precio/Renta<span> (debe seleccionar un Tipo de Operaci&oacute;n)</span></p>
    
    <!-- superior a -->
    
		<!--<div class="form-group">-->
         <div class="form-group">
            <div class="input-group ">
              <div class="input-group-addon superiora">Superior a: </div>
              <input type="text" class="form-control" name="pvpi" id="pvpi" maxlength="12" size="10" value="<%= request("pvpi") %>">
              <div class="input-group-addon">y/o inferior a:</div>
              <input type="text" class="form-control" name="pvpf" id="pvpf" maxlength="12" size="10" value="<%= request("pvpf") %>">
              <div class="input-group-addon">
                <select id="TipoPrecioRenta"  class="form-basico" disabled></select>
                
                <select name="TipoPrecio" id="TipoPrecio" class="form-basico" style="display:none;">
                  <option value="euro" <% if r_TipoPrecio="euro" then %>selected<% end if %>>&euro;</option>
                  <option value="euro/m2" <% if r_TipoPrecio="euro/m2" then %>selected<% end if %>>&euro;/m2</option>
                </select>
                
                <select name="TipoRenta" id="TipoRenta" class="form-basico" style="display:none;">
                  <% if 1=2 then %>
                  <option value="euro/ano" <% if r_TipoRenta="euro/ano" then %>selected<% end if %>>&euro;/a&ntilde;o</option>
                  <option value="euro/m2/ano" <% if r_TipoRenta="euro/m2/ano" then %>selected<% end if %>>&euro;/m2/a&ntilde;o</option>
                  <% end if %>
                  <option value="euro/m2" <% if r_TipoRenta="euro/m2" then %>selected<% end if %>>&euro;/mes</option>
                  <option value="euro/m2/mes" <% if r_TipoRenta="euro/m2/mes" then %>selected<% end if %>>&euro;/m2/mes</option>
                </select>
                
        		<input type="hidden" name="TipoPrecioHide" value="&euro;">
              </div>
              <!--m²   aaa --> 
            </div>
          </div> <!-- fin form-group-->


    <!-- PROGRAMACION SUPERIOR  //////////////////// -->
    
    <% IF 1=2 THEN %>
    <div class="form-group clearfix" style="display:none;">
      <div class="col-sm-4">
      	
        
        
           
        <select name="TipoRenta" id="TipoRenta" class="col-sm-3" >
          <option value="euro/ano" <% if r_TipoRenta="euro/ano" then %>selected<% end if %>>&euro;/a&ntilde;o</option>
          <option value="euro/m2/ano" <% if r_TipoRenta="euro/m2/ano" then %>selected<% end if %>>&euro;/m2/a&ntilde;o</option>
          <option value="euro/m2" <% if r_TipoRenta="euro/m2" then %>selected<% end if %>>&euro;/mes</option>
          <option value="euro/m2/mes" <% if r_TipoRenta="euro/m2/mes" then %>selected<% end if %>>&euro;/m2/mes</option>
        </select>
        
        
      </div>
    </div>
    <% END IF %>
    <!-- hr style="margin-top:20px;" -->
    
    <div class="form-group clearfix">
      <label for="superf" class="control-label col-sm-2">Superficie:</label>
      <div class="col-sm-4">
        <select name="superf" id="superf" class="form-control">
          <option value="*">cualquiera</option>
          <option value="0">&lt; 300 m&sup2;</option>
          <option value="300"> &nbsp; de 300 a 699 m&sup2;</option>
          <option value="700"> &nbsp; de 700 a 1.499 m&sup2;</option>
          <option value="1500"> &nbsp; de 1.500 a 3.000 m&sup2;</option>
          <option value="3000">&gt; 3.000 m&sup2;</option>
        </select>
      </div>
    </div>  <!-- fin form-group-->
    
    <hr >
    <div ><!-- comercialización -->
      <div class="camposOpcionales"><span>*</span>&nbsp; Campos Opcionales</div>
      <p>Comercializaci&oacute;n</p>
      <%
    r_intermediario = left(request("intermediario"), 100)
    r_comprador = left(request("comprador"), 100)
    r_vendedor = left(request("vendedor"), 100)
    r_tipocomprador = left(request("tipocomprador"), 10)
    if r_tipocomprador = "" then r_tipocomprador = "%"
    %>

      <div class="form-group clearfix">
        <label for="vendedor" class="col-sm-4 control-label ">Vendedor/Arrendador:</label>
        <div class="col-sm-8">
        <input type="text" name="vendedor" id="vendedor" size="30" class="form-control"  value="<%= r_vendedor %>" >
        </div>

        <label for="comprador"  class="col-sm-4 control-label ">Comprador/Inquilino:</label>
         <div class="col-sm-8">
        <input type="text" name="comprador" id="comprador" size="25" class="form-control"  value="<%= r_comprador %>" >
        </div>

        <label for="intermediario"  class="col-sm-4 control-label ">Intermediario:</label>
         <div class="col-sm-8">
        <input type="text" name="intermediario" id="intermediario" size="25" class="form-control"  value="<%= r_intermediario %>" >
        </div>
      </div> <!-- fin form-group-->
    </div>
    <!--  fin comercialización --> 
    
    <!--  none -->
    <div name="div_orden" id="div_orden">
      <% 
            r_orden=request("orden")
            r_ordent=request("ordent")
            
            'if r_orden="" then r_orden="fecha"
            'if r_ordent="" then r_orden="desc"
            if r_ordent="" then r_ordent="asc"
            %>
      
      <input type="hidden" id="orden" name="orden" value="">
      <input type="hidden" id="ordent" name="ordent" value="">
    </div>
    
    <!--  fin none -->
    </div><!-- FIN : form_avanzado -->
    
    <div class="caja "> 
      <!--   botones -->
      <div id="div_buscar" class="form-botones clearfix">
        
        <% if request.Form("ope")<>"" then 
			'ops = split(request.Form("ope"), ",")
			'for ii=0 to ops.length %>
				<input id="selected" type="hidden" name="selected" value="<%= request.Form("ope") %>">
			<% 'next
		end if %>
        <input type="button" value="restablecer" class="btn grisB" onClick="location.assign('/dealanalysis/');">
        <input name="consulta" type="submit" value="buscar" class="btn">
        <div  class="divBuscando">
          <div id="buscando" style="display:none;"><img src="/img/loading.gif"></div>
        </div>
      </div> <!--   fin botones --> 
      <div id="div_instrucciones"><p >Para comenzar, indique una localidad o provincia.</p></div>
      <!--div_instruccionesi-->
      
    </div><!--fin div_instrucciones-->
    <!--fin caja-->
    

  </form>
		</div>
	</section>
	
	<section id="s_titulos" class="row clearfix">
		<div id="div_result" class="caja" style="display:none;">
			<div id="result"></div>
		</div>
	</section>
</div>
<!--#include virtual="/inc/body-footer.asp" --> 
<%
set rsTmp=nothing
%>
<script type="text/javascript">
function EstadoForm() {
	
	clearVolver();
	
	//console.log("EstadoForm");
	//oper=document.frm_deal.operacion.options[document.frm_deal.operacion.selectedIndex].value;
	oper = document.frm_deal.operacion.value
	sec = document.frm_deal.sec.value
	loc = document.frm_deal.localidad.value
	prov = document.frm_deal.provincia.value
	
	// uso	
	if (sec=="oficinas") {
		if ((loc==1 || loc==16) || (prov==2 || prov==3)) {
			$("#frm_deal_zona_inmobiliaria").slideDown("fast");
		} else {
			$("#frm_deal_zona_inmobiliaria").slideUp("fast");
		};
		$("#div_usosolar").fadeOut("fast");
	} else {
		if (sec=="solares") {
			//$("#div_usosolar").slideDown("slow");
			$("#div_usosolar").fadeIn("fast");
		} else {
			//$("#div_usosolar").slideUp("slow");
			$("#div_usosolar").fadeOut("fast");
		};
		$("#frm_deal_zona_inmobiliaria").slideUp("fast");
	};
	
	//operación
	document.frm_deal.pvpi.disabled=false;
	document.frm_deal.pvpf.disabled=false;
	$("#TipoPrecioRenta").css({ display: 'none' });
		
	if(oper=="alquiler"){
		//document.frm_deal.TipoPrecio.disabled=true;
		//document.frm_deal.TipoRenta.disabled=false;
		
		document.getElementById('lblPrecioRenta').innerHTML = "Renta";
		
		$("#TipoPrecio").css({ display: 'none' });
		$("#TipoRenta").css({ display: 'block' });
		
		//document.busfrm.TipoPrecioHide.value="€"
	} else {
		//document.frm_deal.TipoRenta.disabled=true;
		//document.frm_deal.TipoPrecio.disabled=false;
		
		document.getElementById('lblPrecioRenta').innerHTML = "Precio";
		
		$("#TipoPrecioRenta").css({ display: 'none' });
		$("#TipoRenta").css({ display: 'none' });
		$("#TipoPrecio").css({ display: 'block' });
		
		//document.busfrm.TipoPrecioHide.value="€/AÑO"
	} ;
	
	//$('#frm_deal').submit();
}

function fLeft(str, n) {
	if (n > String(str).length) return str;
	else return String(str).substring(0,n);
}

function resetform() {
	console.log("resetform");
	
	$("#busqlocalidad").val("");
	$("#localidad").val("");
	
	$("#FechaI").val("<%= dateadd("m", -3, date) %>");
	$("#FechaF").val("<%= date %>");
	
	$("#valores").val("");
	$("#zonainmobiliaria").val("");
	$("#uso_solar").val("*");
	
	$("input[name='R1']").removeProp("checked");
	$("input[name='R1'][value='calle']").prop("checked", true);
	
	//TipoPrecio
	
	$("#pvpi").val("");
	$("#pvpf").val("");
	$("#superf").val("*");
	
	$("#vendedor").val("");
	$("#comprador").val("");
	$("#intermediario").val("");
}

function clearVolver() {
	$("#setcoords_zoom").remove();
	$("#setcoords_lat").remove();
	$("#setcoords_lng").remove();
	
	$("#selected").remove();
	
}

function cambioseccion() {
	EstadoForm();
	comprobarForm();
}

function cambiooperacion() {
	EstadoForm();
	comprobarForm();
}

function cambiopais() {
	console.log("cambiopais")
	document.frm_deal.localidad.value="";
	document.frm_deal.busqlocalidad.value="";
	document.frm_deal.provincia.value="";
	
	
	$("#busqlocalidad").unautocomplete();
	var frm_destino = "/dealanalysis/q/localidades_buscar_con_id.asp"
	if (document.frm_deal.pais.value==1) {
		$("#frm_deal_provincia").fadeIn();
	} else {
		$("#frm_deal_provincia").fadeOut();
		frm_destino = frm_destino + "?p=" + document.frm_deal.pais.value
	};
	
	$("#busqlocalidad").autocomplete(
		frm_destino, 
		{
			width: 260,
			selectFirst: true,
			matchContains: true,
			minChars: 1
		}
	);
	
	$("#busqlocalidad").result(function(event, data, formatted) {
		console.log(data)
		if (data) {
			document.frm_deal.localidad.value=data[1];
			//document.frm_deal.provincia.value="";
			//document.frm_deal.sec.focus();
			
			$("#boton_ver_dir").fadeIn("slow");
			
			EstadoFormulario();
			comprobarForm();
			
//			$("#frm_deal").submit();
		}
	});
	
//if ((document.frm_deal.localidad.value=="") && ((document.frm_deal.provincia.value=="") || (document.frm_deal.provincia.value=="%")))
	
	
	$("#frm_deal").submit();
}

function cambioprovincia() {
	//document.frm_deal.localidad.value=""
	//document.frm_deal.busqlocalidad.value=""
	
	EstadoForm();
	
	comprobarForm();
	//$("#frm_deal_zona_inmobiliaria").slideUp("slow");
}

function cambioorden() {
	if (document.frm_deal.orden.value=="") {$("#ordent").fadeOut("fast");} else {$("#ordent").fadeIn("fast");}
	$("#frm_deal").submit();
}

function expande() {
	//$("#frm_deal_dir").slideToggle("slow");
	if (document.getElementById("mas_dir").innerHTML=="menos") {
		document.getElementById("mas_dir").innerHTML="m&aacute;s";
		//$("#frm_deal_dir").fadeOut();
		$("#frm_deal_dir").slideUp();
	} else {
		document.getElementById("mas_dir").innerHTML="menos";
		$("#frm_deal_dir").fadeIn();
	}
};

function expandir(zap) {
	if (document.getElementById) {
		var abra = document.getElementById(zap).style;
		if (abra.display == "block") {abra.display = "none";}
		else {abra.display = "block";};
		return false
	} else {
		return true
	}
}

function subir() {
	//$.scrollTo("#frm_deal",800);
	
	return false;
}

function ver_avanzado() {
//$("#avanzado").click(function(){);
	if ($("#lbl_avanzado").html()=="avanzado") {
		$("#lbl_avanzado").html("simple")
	} else {
		$("#lbl_avanzado").html("avanzado")
	};
	
	$("#frm_deal_avanzado").slideToggle("slow");

}

function comprobarForm(){
		console.log("comprobarForm");
		
		var ErrSubmit="";
		if (document.frm_deal.operacion.value=="") {
			ErrSubmit="Seleccione un Tipo de Operaci&oacute;n";
			//if (document.frm_deal.provincia.value=="")	{
				//$("#operacion").focus();
			//} else {
			//	$("#busqlocalidad").focus();
			//}
			
		};
		if (document.frm_deal.sec.value=="") {
			ErrSubmit="Seleccione un Uso";
			//$("#sec").focus();
		};
		
		//|| (document.frm_deal.provincia.value=="%")
		//console.log(document.frm_deal.pais.value);
		if (document.frm_deal.pais.value==1) {
			if ((document.frm_deal.localidad.value=="") && (document.frm_deal.provincia.value=="")) {
				ErrSubmit="Indique una localidad o provincia" 
				//$("#busqlocalidad").focus();
			} else {
				if ( document.frm_deal.localidad.value=="" ) {
					//$("#busqlocalidad").focus();
				}
			}
		};
		//$("#div_instrucciones").html(ErrSubmit);
		if (ErrSubmit=="") {
			//$("#buscando").fadeIn("fast");
			//$("#buscando").css({ display: "none", });
			//$("#div_instrucciones").fadeOut("fast");
			//$("#div_instrucciones").css({ display: "none", });
		} else {
			$("#div_instrucciones").html(ErrSubmit);
//			$("#div_instrucciones").fadeIn("slow");
			return false;
		}
	};
	
$(document).ready(function(){
	
	//fechas
	var ant_date;
	$("#FechaI, #FechaF").datepicker({
		language: "es",
		format: "dd/mm/yyyy",
		autoclose: true
	})
	.on("show", function(e) {
		ant_date=this.value;
		//console.log(ant_date);
    })
	.on("changeDate", function(e) {
		if (this.value!=ant_date) {
			//console.log(this.value);
			//$("#f_desde").val(this.value)
			$("#frm_busq").submit();
		}
    })
	
	// formulario
	$("#frm_deal__").ajaxForm({
		beforeSubmit: comprobarForm, 
		success: mostrarRespuesta
	}); 
	
	$("#frm_deal").submit(function(){
		$(".divCajaMapa").hide();
		
		$.ajax({
			type: "POST",
			dataType: "html",
			url: "/dealanalysis/resultados/resultados.asp",
			data: $("#frm_deal").serialize(),
			beforeSend: comprobarForm,
			success: mostrarRespuesta,
			error: function(xhr, status, err) { }
		})
		return false;
	});
	
	function mostrarRespuesta (responseText, status, xhr){ 
		//console.log("mostrarRespuesta");
		if (fLeft(responseText,9)=="err_vacio") {
			$("#div_result").fadeOut("fast");
			$("#div_instrucciones").fadeIn("fast");
			$("#div_instrucciones").html("No Existe ning&uacute;n resultado.<br>Afine los criterios de su b&uacute;squeda.");
			$("#result").html("");		
		} else if (fLeft(responseText,3)=="err") {
		} else {
			$("#result").html(responseText);
			$("#div_result").fadeIn("fast");
			<% 'if 1=2 then 'request.Cookies("dev")<>"" then %>$.scrollTo("#div_instrucciones",800);<% 'end if %>
		};
		//$("#buscando").css({ display: "none"});
		$("#buscando").fadeOut("fast");
	};
	
	// qtip
	$(".opcional").qtip({ // Grab some elements to apply the tooltip to
		content: "Campo opcional",
		position: {my: "bottom left"}
	});
	
	
	
	
	<% if request.Form<>"" then %>
		$("#frm_deal").submit();
	<% end if %>
	
	$("#frm_resumen").submit();
	
	//$("#frm_resumen_ops").submit();
})
</script>
<!--#include virtual="/dealanalysis/autocomplete.asp" -->
</body>
</html>