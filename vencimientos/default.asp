<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<%
'on error resume next

'Variables			
Public Total
Public Resultado
Public FechaI
Public FechaF

Public navArticulo
public string1
public formul
public empresa
public password
public contador
public Palabra(500)
Public ingles
Public titulo
public color
public bloque

swMostrarListado=false
if request.Form="" then
	f_desde=date
	f_hasta=dateadd("m", 4, date)
else
	f_desde=cdate(Request.Form("FechaI"))
	f_hasta=cdate(Request.Form("FechaF"))
end if

'Fechas		
fecha=request.form("fecha")
fechai=formatdatetime(fecha,2)
fechaf=formatdatetime(dateadd("m", -1, fecha), 2)

r_localidad=request.Form("localidad")
r_busqlocalidad=request.Form("busqlocalidad")

%>
<!DOCTYPE html>
<html lang="es">
<head>
<title>PropertyWeb - Posibles Vencimientos de Contrato</title>
	<!--#include virtual="/inc/head.asp" -->
    <link href="/lib/bootstrap-datepicker/bootstrap-datepicker3.css" rel="stylesheet" type="text/css">
    <script src="/lib/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
    <script src="/lib/bootstrap-datepicker/bootstrap-datepicker.es.js"></script>
    <% sec_actual = "/vencimientos/" %>

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
    <div class="caja">
      <h1 class="heading">Vencimientos de Contrato</h1>
    </div>
    <div class="col-md-8 caja">
      <div id="div_formulario" name="div_formulario" >
        <form method="post" action="/vencimientos/resultados.asp" target="_blank" name="frm_busq" id="frm_busq" class="form-horizontal">
          <input type="hidden" name="secc" value="vencimientos" >
          
          <div  class="form-group clearfix">
          
          <div id="frm_vencim_provincia">
            <label for="busqlocalidad" class="col-sm-2 control-label">Localidad: </label>
            
            <div class="col-sm-4">
              <input type="textfield" name="busqlocalidad" id="busqlocalidad" value="<%= r_busqlocalidad %>" placeholder="e.g. madrid barcelona" onKeyDown="borrabusq();" class="form-control">
              <input name="localidad" type="hidden" value="<%= r_localidad %>" readonly>
            </div>
            
            <div name="frm_vencim_provincia" >
              <label for="provincia" class="col-sm-2 control-label">Provincia:</label>
              <%
response.flush
r_provincia=request.Form("provincia")
if r_provincia="" then r_provincia="%"
set rsProvincias = Server.CreateObject("ADODB.Recordset")

sql = "SELECT * FROM PROVINCIAS WHERE id_pais=1 ORDER BY NOMBRE"
rsProvincias.Open sql, session("connPW")
'onChange="CargarComboLocalidades(document.busfrm.provincia.value,document.busfrm.localidad)"
%>
             
              <div class="col-sm-4">
                <select name="provincia" onChange="sel_provincia();" class="form-control">
                  <option value="%" <% if r_provincia="%" then %>selected<% end if %>>cualquiera</option>
                  <% do while not(rsProvincias.EOF) %>
                  <option value="<%= rsProvincias("ID") %>" <% if r_provincia=cstr(rsProvincias("ID")) then %>selected<% end if %>><%= rsProvincias("NOMBRE") %></option>
                  <% rsProvincias.MoveNext()
	loop %>
                </select>
              </div>
              <%
rsProvincias.close
set rsProvincias=nothing
%>
            </div>
          </div></div>

          <div id="frm_vencim_zona_inmobiliaria" name="frm_vencim_zona_inmobiliaria" style="display:none;">
            <p class="ancho">
              <label for="zonainmobiliaria" class="ancho">Zona Inmobiliaria: </label>
              <%
r_zonainmobiliaria=request.Form("zonainmobiliaria")
if r_zonainmobiliaria="" then r_zonainmobiliaria="%"
set zonarecordset = Server.CreateObject("ADODB.Recordset")
sql = "SELECT * FROM TIPOS_DE_AREAS WHERE ACTIVO<>0 AND ID>0 ORDER BY TIPOS_DE_AREAS.NOMBRE"
zonarecordset.Open sql, session("connPW")
%>
              <select name="zonainmobiliaria">
                <option <% if r_zonainmobiliaria="%" then %>selected<% end if %> value="%">cualquiera</option>
                <% do while not zonarecordset.EOF %>
                <option <% if r_zonainmobiliaria=cstr(zonarecordset("ID")) then %>selected<% end if %> value="<%= zonarecordset("ID") %>"><%= zonarecordset("NOMBRE") %></option>
                <% zonarecordset.MoveNext
	loop %>
              </select>
            </p>
          </div>

          <div ></div>


  
          
    <!-- superficie-->
     <!--     <div class="form-group clearfix">
           <div name="frm_vencim_superficie"> 
            <label for="m2i" class="col-sm-2 control-label">Superficie:</label>
                      
            <%
r_m2i = request.Form("m2i")
r_m2f = request.Form("m2f")
%>
            <span class="col-sm-2"> min:&nbsp; </span>
            
              <div class="col-sm-3">
            <input type="text" name="m2i" size="9" maxlength="12" value="<%= r_m2i %>" class="form-control">
            </div>
            
            <span class="col-sm-1">max:&nbsp; </span>
            
              <div class="col-sm-3">
            <input type="text" name="m2f" size="9" maxlength="12" value="<%= r_m2f %>" class="form-control">
              </div>
              
            <span class="col-sm-1" >&nbsp;m&sup2;</span>
    
           </div>
          </div>
          
      Prueba -->

    
   <div class="form-group">
   
    <label class="col-sm-2 control-label" for="exampleInputAmount">Superficie: </label> 
     <div class="col-sm-10">
    <div class="input-group compuesto">      
      <div class="input-group-addon">min:</div>  
      <input type="text" class="form-control" name="m2i" placeholder="min" value="<%= request.Form("m2i") %>">
      <div class="input-group-addon">max:</div>
       <input type="text" class="form-control" name="m2f" placeholder="max" value="<%= request.Form("m2f") %>">
      <div class="input-group-addon">m²</div>
    </div>
     </div>
  </div>      
          
          
       <!--  fin superficie-->
          
          
     
          <div class="form-group clearfix">
            <label for="FechaI" class="col-sm-2 control-label">Per&iacute;odo de:</label>
            <div class="col-sm-4">
              <input type="text" name="FechaI" id="FechaI" value="<%= f_desde %>" maxlength="10" class="form-control">
            </div>
            <label for="FechaI" class="col-sm-2 control-label">hasta:</label>
            <div class="col-sm-4">
              <input type="text" name="FechaF" id="FechaF" value="<%= f_hasta %>" maxlength="10" class="form-control">
            </div>
          </div>
          
     
          <div class="form-botones clearfix">
            <input name="reset" type="button" class="btn grisB" onClick="location.assign('/vencimientos/');" value="restablecer">
            <input type="submit" name="buscar" value="buscar" class="btn">
            <div class="buscando">
              <div id="buscando" style="display:none;"><img src="/img/loading.gif"></div>
            </div>
          </div>
        </form>
      </div>
    </div>
    
    <div class="col-md-4 hidden-sm hidden-xs"><!--#include virtual="/inc/publicidad/suscribe_flash.asp" --></div>
    <!--fin publi-->
    
    <div name="div_aviso_error" id="div_aviso_error" class=""> </div>
  </section>
  
  
  <section id="s_titulos" class="row">
    <div name="div_result" id="div_result" class="caja" style="display:none;">
      <div id="result"></div>
    </div>
  </section>
</div>

<!--#include virtual="/inc/body-footer.asp" -->
</body>
</html>

<link href="/lib/autocomplete/autocomplete_javier.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/lib/autocomplete/jquery.autocomplete.js"></script>
<script type="text/javascript">
function sel_provincia() {
	document.frm_busq.localidad.value=""
	document.frm_busq.busqlocalidad.value=""
	document.frm_busq.busqlocalidad.placeholder="e.g. madrid barcelona";
	
	document.getElementById('result').innerHTML=""
	$("#frm_busq").submit();
	document.frm_busq.busqlocalidad.focus();
}

function borrabusq() {
	if (document.frm_busq.localidad.value!="") {
		if (document.frm_busq.busqlocalidad.value!="") {
			document.frm_busq.provincia.value="%"
			document.frm_busq.localidad.value=""
			
			document.getElementById('result').innerHTML=""	 //alert("borra todo")
		}
	}
}

function __enviarform() {
	var ErrSubmit="";
	
	//document.frm_busq.enviar2.click();
	
	if ((document.frm_busq.localidad.value=="") && (document.frm_busq.sec_group.value=="%")) {
		ErrSubmit="Debe indicar algun criterio para realizar la busqueda.\nSeleccione una seccion, indique una localidad o provincia, o bien algun limite para la suerficie.";
	}
	//alert(document.frm_busq.sec_group.value)
	//alert(ErrSubmit);
	if (ErrSubmit=="") {
		//document.frm_busq.submit();
		alert("enviamos...");
	} else {
		//alert(ErrSubmit);
		document.getElementById('result').innerHTML=ErrSubmit;
	}

}

var act_loc=document.frm_busq.localidad.value
//if (act_loc=="") {$("#frm_vencim_direccion").css({ display: 'none', });}
//if (act_loc!=1 && act_loc!=16) {$("#frm_vencim_zona_inmobiliaria").css({ display: 'none', });}
document.frm_busq.busqlocalidad.focus();
//$("#div_usosolar").css({ display: 'none', });


$(document).ready(function() { 
	/* frm_busq */
	$("#frm_busq").ajaxForm({
		beforeSubmit: mostrarLoader, 
		success: mostrarRespuesta,
	}) ; 
	
	function mostrarLoader(){
		
		var ErrSubmit="";
		if ((document.frm_busq.localidad.value=="") && (document.frm_busq.provincia.value=="%")) {

			ErrSubmit="Debe indicar algun criterio para realizar la busqueda.<br>"
			ErrSubmit=ErrSubmit+"Seleccione una seccion, indique una localidad o seleccione una provincia.";
		}
		
		if (ErrSubmit=="") {
			$("#buscando").fadeIn("fast");
		} else {
			$("#result").html(ErrSubmit);
			$("#div_result").fadeIn("slow");
			return false;
		}
	};
	function mostrarRespuesta (responseText){ 
		$("#result").html(responseText);
		$("#div_result").fadeIn("slow");
		//$("#div_deal2").slideToggle("slow");
		$("#buscando").fadeOut("fast");
	};
	
	
	/* auto complete */
	function log(event, data, formatted) {$("<li>").html( !data ? "No match!" : "Selected: " + formatted).appendTo("#result");}
	
	function formatItem(row) {return row[0] + " (<strong>id: " + row[1] + "</strong>)";}
	function formatResult(row) {return row[0].replace(/(<.+?>)/gi, '');}
	
	$("#busqlocalidad").autocomplete("/dealanalysis/q/localidades_buscar_con_id.asp", {
		width: 260,
		selectFirst: true,
		matchContains: true,
		minChars: 1
	});
	
	$("#busqlocalidad").result(function(event, data, formatted) {
		if (data) {
			document.frm_busq.localidad.value=data[1];
			document.getElementById('result').innerHTML=""
			
			document.frm_busq.provincia.value=""
			
			$("#frm_busq").submit();
		} 
	});
	
	
	/* fechas */
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
	
	
	
	<% if request.Form<>"" then %>
		$("#frm_busq").submit();
	<% end if %>
});	
	

</script>
