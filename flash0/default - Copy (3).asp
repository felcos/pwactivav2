<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<% 
sec_actual = "flash"
pag_actual = "flash" 

origen="flash"

actFecha=date
set flash = Server.CreateObject("ADODB.Recordset")
sql = "SELECT * FROM mailing_log WHERE (tipo='Flash ES' AND sending_init IS NOT NULL AND fecha>=DATEADD(w, -7, '" & date & "')) ORDER BY fecha DESC"
flash.Open sql, session("connPW")	',1,1

if request.Form("f")="" then
	pFecha = flash("fecha")
	'if datediff("d", pFecha, actFecha)>0 then
		'response.End()
	'end if
else
	pFecha = request.Form("f")
	if request.Cookies("dev")="" then
		if datediff("d", pFecha, date)>7 or datediff("d", pFecha, date)<0 then pFecha = flash("fecha")
	end if
end if
%>
<!DOCTYPE html>
<html lang="es">
<head>
	<title>PropertyWeb-Daily Flash</title>
	<!--#include virtual="/inc/head.asp" -->
	<link href="/flash/flash.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<!--#include virtual="/inc/body-header.asp" -->

  <div class="container">
      <section id="fechas" class="fechas row">
	<div class="caja clearfix">
          			
            <h1 class="heading PWsemana aMetodoToggleV"><span class="icoLogo"></span> Andy da las claves de Hoy en vivo!<span class="icon icon-arrow-down2"></span></h1>
          <div id="divMetodoToggleV" style="display:block;">
            <!-- jj-->

	    <iframe src="//www.youtube.com/embed/hdIpspqtoC0" width="300"  allowfullscreen="allowfullscreen"></iframe>
            <a href="https://www.catella.com/" target="_blank"><img src="BannerPW.png" align="right"/></a>
	   <p class="select_all">Y si tienes algo para nosotros, llamame... Movil: 617.835.023 o andyg@propertyweb.eu</p>


            
            

         </div>
         </div>
      <section id="fechas2" class="fechas row">
	<div class="caja clearfix">
          			
            <h1 class="heading PWsemana aMetodoToggle2"><span class="icoLogo"></span>Mas videos...<span class="icon icon-arrow-down2"></span></h1>
          <div id="divMetodoToggle2" style="display:none;">
            <!-- jj-->
            
            <iframe src="//www.youtube.com/embed/nq2bgQX-hkM" width="300"  allowfullscreen="allowfullscreen"></iframe>
            <iframe src="//www.youtube.com/embed/uRuQSNfrfUc" width="300"  allowfullscreen="allowfullscreen"></iframe>
            <iframe src="//www.youtube.com/embed/fT5Sa-FNkLI" width="300"  allowfullscreen="allowfullscreen"></iframe>
            <iframe src="//www.youtube.com/embed/NJj4_9p0kVg" width="300"  allowfullscreen="allowfullscreen"></iframe>
            <iframe src="//www.youtube.com/embed/hj6B_aLnfc8" width="300"  allowfullscreen="allowfullscreen"></iframe>
            <iframe src="//www.youtube.com/embed/BVF7lWWuocI" width="300"  allowfullscreen="allowfullscreen"></iframe>
                                    	    	    
            
            

         </div>
         </div>
        <div class="caja clearfix">
        

        
        	<div class="col-xs-6  ">      <!-- col-xs-pull-6-->      			
             <h1 class="heading PWsemana aMetodoToggle"><span class="icoLogo"></span>PW Semana <span class="icon icon-arrow-down2"></span></h1>
             <div id="divMetodoToggle" style="display:none;">
             <!-- jj-->
             
            <form method="post" id="frm_fecha">
              <input id="fecha" name="fecha" type="hidden" value="<%= pFecha %>">
            </form>
            <table border="0" cellpadding="2" style="margin-top:.6em;">
              <tr>
                <!--<td valign="top">&nbsp; Fecha:  &nbsp; </td>-->
                <td nowrap><ul class="listado_fechas"><% 
do while not flash.eof 
	%><li><a href="<%= flash("fecha") %>" class="fechas_pwflash"><span class="azul2"><%= FormatDateTime(flash("fecha"), 1) %></span></a></li><%
	flash.movenext
loop
%></ul></td>
              </tr>
              <!-- DEV: ini -->
              <% if request.Cookies("dev")<>"" then %>
              <tr>
                <td nowrap>
                     Otra: <input type="text" name="pickFecha" id="pickFecha" value="<%= pFecha %>" maxlength="10" class="fecha">
                  </td>
              </tr>
            <% end if %>
              <!-- DEV: fin -->
            </table>
          </div>
            </div>
            
              <div class="col-xs-6   "><!-- col-xs-push-6 fecha actual -->
            <h2 id="fecha_actual" class="aMetodoToggle fecha_actual"></h2>
            <h2 id="fecha_actual_corta" class="aMetodoToggle fecha_actual">&nbsp;</h2>
            </div>          
            
            
            
         	<!--<div class="col-sm-6 col-md-4 col-md-pull-4 ">
               <h1 class="heading PWhoy"><span class="icoLogo"></span>PW Hoy</h1>     fin cols-sm6
           </div> -->       
        

            
            
            
            
            <!--
           <div class="col-sm-12"> 
              <div  class="otraSeleccion">
              <input type="checkbox" id="check_all" style="display:none;">
              <input type="checkbox" id="check_all_checkbox" class="select_all">
              <label for="check_all_checkbox">seleccionar todos</label>
              </div>  
            </div>-->
                 
           

    
        </div>
      </section>
      <!-- nav check -->
       <!--<div class="row">-->
        <div class="nav-check clearfix">
        	 <!--<div class="col-sm-12"> -->
             
             <!-- <div  class="otraSeleccion">
              <input type="checkbox" id="check_all" style="display:none;">
              <input type="checkbox" id="check_all_checkbox" class="select_all">
              <label for="check_all_checkbox">seleccionar todos</label>
              </div>  -->
              
               <p class="explica-01 hidden-xs">Selecciona los articulos deseados con <span class="icon icon-checkmark azul"></span> y pulsa <span class="icon icon icon-arrow-right2 azul"></span> para leer</p>   
               <div class="bts-selecciona">
               
               <label class="btn blanco" ><input type="checkbox" class="select_all"> Seleccionar todos</label>
               <button type="button" value="Leer Seleccionados" class="btn blancoHover leer" ><span class="icon icon-arrow-right2"></span> Leer Seleccionados </button>
              
				</div>

             <!--</div>-->  
       	 </div>
        <!--</div> nav check:: -->
      
      
      
		<section id="flash" class="clearfix flash"></section>
      
      
        <div class="tabla-botones" style="margin-top:2em; margin-bottom:2em;"> <!--id="tabla-botones"-->
            <input type="checkbox" id="check_all" style="display:none;">
            <label class="btn blanco" ><input type="checkbox" class="select_all"> Seleccionar todos</label>
            <button type="button" value="Leer Seleccionados" class="btn btnAzul leer" ><span class="icon icon-arrow-right2"></span> Leer Seleccionados </a></button>
        </div>
        
  </div><!-- fin container --> 
  
<!-- fin content -->
 
<!--#include virtual="/inc/body-footer-mail.asp" -->
</body>
</html>
<%
flash.close
set flash = nothing
%>
<% if request.Cookies("dev")<>"" then %>
<link href="/lib/bootstrap-datepicker/bootstrap-datepicker3.css" rel="stylesheet" type="text/css">
<script src="/lib/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
<script src="/lib/bootstrap-datepicker/bootstrap-datepicker.es.js"></script>
<% end if %>
<script type="text/javascript">
$(document).ready(function() { 
	$("#frm_fecha").submit(function(){
		$.ajax({
			url: "/flash/titulos.asp",
			type: "POST",
			data: $('#frm_fecha').serialize(),
			beforeSend: function () {
				//$("#flash").html('<img src="/img/ajax-loader.gif"/>')
			},
			success: function(data, status, xhr) {
				$("#flash").html(data);
				jQuery('#divMetodoToggle').hide(400);
			}
		});
		return false;
	});
	
	$(".select_all").change(function(e) {
		$("#check_all").prop("checked", $(this).is(":checked") )
		$(".select_all").prop("checked", $("#check_all").is(":checked") )
		$("#frm_flash input:checkbox").prop("checked", $("#check_all").is(":checked") )
	})
	
	
	$(".leer").click(function(e) {
        $("#frm_flash").submit();
    });
	
	$(".aMetodoToggle").click(function(e) {
		$("#divMetodoToggle").toggle(400);
		return false;
	});
	$(".aMetodoToggleV").click(function(e) {
		$("#divMetodoToggleV").toggle(400);
		return false;
	});	
	$(".aMetodoToggle2").click(function(e) {
		$("#divMetodoToggle2").toggle(400);
		return false;
	});
	$(".fechas_pwflash").click(function(e) {
		e.preventDefault();
		
		$("#fecha").val($(this).attr("href"))
		$("#pickFecha").val($("#fecha").val());
		$("#frm_fecha").submit();
		
	});
	
	
	$("#frm_fecha").submit();
	
	
	<% if request.Cookies("dev")<>""  then %>
	//var ant_date;
	$("#pickFecha").datepicker({
		language: "es",
		format: "dd/mm/yyyy",
		//todayBtn: true,
		autoclose: true
	})
	.on("changeDate", function(e) {
		$("#fecha").val(this.value)
		$("#frm_fecha").submit();
	})
	<% end if %>
	
});
</script>



















