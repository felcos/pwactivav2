<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<% 
Public xUser
if Request.QueryString("xUser")<>"" then
   xUser = Request.QueryString("xUser")
   if xUser<>"Salir" and xUser<>"" then
      Session("xUser")=xUser
   else
      Session("xUser")=""
      Response.Cookies("xUser")=""
   end if
else
   Session("xUser")=Request.Cookies("xUser")
end if


sec_actual = "flash"
pag_actual = "flash" 

origen="flash"

actFecha=date
set flash = Server.CreateObject("ADODB.Recordset")
sql = "SELECT * FROM mailing_log WHERE (tipo='Flash ES' AND sending_init IS NOT NULL AND fecha>=DATEADD(w, -7, '" & date & "')) ORDER BY fecha DESC"
flash.Open sql, session("connPW")	',1,1

set xvideo = Server.CreateObject("ADODB.Recordset")
sqlvideo = "SELECT * FROM VideosLists where PWhoy=1 ORDER BY fecha DESC"
xvideo.Open sqlvideo, session("connPW")	',1,1

set xt4ac = Server.CreateObject("ADODB.Recordset")
sqlt4ac = "SELECT TOP 3 * FROM View_Time4Change where vivo=1 ORDER BY fecha DESC"
xt4ac.Open sqlt4ac, session("connPW")	',1,1

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
        <style>


 
        .loading {
            display: none;
            width: 16px;
            height: 16px;
            background-image: url(loading.gif);
            vertical-align: text-bottom;
        }
        /* autocomplete adds the ui-autocomplete-loading class to the textbox when it is _busy_, use general sibling combinator ingeniously */
        #autocomplete.ui-autocomplete-loading ~ .loading {
            display: inline-block;
        }

        .ui-autocomplete .m-name {
            margin-right: 1em;
            font-size: larger;
            color:#006699;
        }

        .ui-autocomplete .m-year {
            float: right;
            margin-right: 1em;
            font-size: smaller;
            color:darkgrey;
        }
        .ui-autocomplete .m-foto {
            float: right;
            font-size: larger;
        }

        .ui-autocomplete .m-cast {
            display: block;
            font-size: smaller;
        }
        /* Rotten Tomatoes Branding */
        .ui-autocomplete .rt-main {
            display: block;
            margin-left: 1em;
            font-size: smaller;
        }

        .ui-autocomplete .rt-ico {
            display: inline-block;
            margin-right: .5em;
            width: 16px;
            height: 16px;
            background-image: url(rt-icons.png);
            vertical-align: bottom;
        }

            .ui-autocomplete .rt-ico.fresh {
                background-position: 0 0;
            }

            .ui-autocomplete .rt-ico.rotten {
                background-position: -16px 0;
            }

            .ui-autocomplete .rt-ico.certified_fresh {
                background-position: -32px 0;
            }

        .ui-autocomplete .rt-val {
            display: inline-block;
            margin-right: .5em;
        }

        .ui-autocomplete .rt-bar {
            display: inline-block;
            margin-right: .5em;
            width: 10em;
            height: 1em;
            background-color: #ECE4B5;
        }

            .ui-autocomplete .rt-bar span {
                display: block;
                height: 1em;
            }

            .ui-autocomplete .rt-bar.fresh span, .ui-autocomplete .rt-bar.certified_fresh span {
                background-color: #C91B22;
            }

            .ui-autocomplete .rt-bar.rotten span {
                background-color: #94B13C;
            }



        .imgRedonda {
            width: 155px;
            height: 155px;
            border-radius: 155px;
            border: 6px solid #ff6701;
            box-shadow: 0 0 25px #ff6701;
            margin: 7px;
        }

        #tablaFicha {
            border-top-left-radius: 21px;
            border-top-right-radius: 101px;
            border-bottom-right-radius: 21px;
            border-bottom-left-radius: 21px;
            border: 6px double #ff6701;
            padding: 5px;
            width: 1140px;
            background-color: #ffeabf;
	    color:#2B4E61;
        }

        #capaLogo {
            box-shadow: 0 0 25px #ff6701;
            margin: 7px;
	    max-width:221px;
	    text-align:center;
        }

        #TextoNombre {
            font-family: Helvetica, Arial, sans-serif;
            font-weight: bold;
            font-size: xx-large;
            color: #006699;
            text-transform: uppercase;
        }
	#TextoT4ac {
            font-family: Helvetica, Arial, sans-serif;
            font-weight: bold;
            color: #006699;
        }
        #TextoPosition1 {
            font-family: Helvetica, Arial, sans-serif;
            
            text-transform: uppercase;
        }
	#TextoPosition2 {
            font-family: Helvetica, Arial, sans-serif;
            font-weight: bold;
            
            color: #006699;
            text-transform: uppercase;
        }
    </style>




</head>

<head runat="server">
    <link href="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.1/themes/ui-darkness/jquery-ui.min.css" rel="stylesheet">
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.1/jquery-ui.min.js"></script>
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.1/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />



<script>


        $(function () {
            $("#txtSearch").autocomplete({
                source: '@Url.Action("../../DataEntry/View_Time4Change/BusquedaWeb")',
                minLength: 1
            });

        });




        $(document).ready(function () {
            $("#txtSearch").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: "../DataEntry/Time4Change/BusquedaWeb",
                        type: "POST",
                        dataType: "json",
                        data: { term: request.term },
                        success: function (data) {
                            response($.map(data, function (item) {
                                return {
                                    label: item.Nombre,
                                    value: item.Nombre,
                                    cast: (item.Direccion==null) ? " " : item.Direccion ,
                                    rating: (item.Direccion==null) ? " " : item.Direccion,
                                    icon: item.Nombre,
                                    foto: item.Foto.split("&", 1), 
					//url: (item.Persona=="1") ? "../Personas/Edit/" + item.Id : "../Empresas/Edit/" + item.Id
                                    url: "https://www.propertyweb.eu"
                                };
                            }))

                        },

                    })
                }, focus: function (event, ui) {
                    // prevent autocomplete from updating the textbox
                    event.preventDefault();
                },
                select: function (event, ui) {
                    // prevent autocomplete from updating the textbox
                    event.preventDefault();
                    // navigate to the selected item's url
                    window.open(ui.item.url);
                }

            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                var $a = $("<a></a>");
                $("<img class='m-foto' id='mi_imagen'  src='img/origen_1.jpg' style='max-height:50px;'/>").attr("src", item.foto).appendTo($a);
                $("<span class='m-year'></span>").text(item.year).appendTo($a);
                $("<span class='m-name'></span>").text(item.label).appendTo($a);
                $("<span class='m-cast'></span>").text(item.cast).appendTo($a);
                return $("<li></li>").append($a).appendTo(ul);
            };
        })


    </script>

</head>

<body>
<!--#include virtual="/inc/body-header.asp" -->

  <div class="container">
      <section id="fechas" class="fechas row">
	<div class="caja clearfix">
          			
            <h1 class="heading PWsemana aMetodoToggleV"><span class="icoLogo"></span> Andy da las claves de Hoy en vivo!<span class="icon icon-arrow-down2"></span></h1>
          <div id="divMetodoToggleV" style="display:block;">
            <!-- jj-->

	    <iframe src="https://www.youtube.com/embed/<%= xvideo("link") %>" width="200" align="left" style="margin:0px;padding:0px;" allowfullscreen="allowfullscreen"></iframe>
<a href="https://www.catella.com/" target="_blank" ><img src="BannerPW.png" style="margin:0px;padding:0px;" align="middle"  /></a>
<a href="https://www.dracorion.com/" target="_blank" ><img src="publi1.png"  style="margin:0px;padding:0px;" align="middle" /></a>
<a href="https://www.malcolmhollis.com/" target="_blank" ><img src="MHPropertyWebLogo-300x150.jpg" align="right"  style="margin:0px;padding:0px;"  /></a>
   
<p class="select_all">Y si tienes algo para nosotros, llamame... Movil:617.835.023 o andyg@propertyweb.eu</p>


		
            
            

         </div>
         </div>
      <section id="fechas2" class="fechas row">
	<div class="caja clearfix">
          			
            <h1 class="heading PWsemana aMetodoToggle2"><span class="icoLogo"></span>Mas videos...<span class="icon icon-arrow-down2"></span></h1>
          <div id="divMetodoToggle2" style="display:none;">
            <!-- jj-->
            <% 
do while not xvideo.eof 
	%><iframe src="https://www.youtube.com/embed/<%= xvideo("link") %>" width="300"  allowfullscreen="allowfullscreen"></iframe>
<%
	xvideo.movenext
loop
%>
         </div>
         </div>


  
  	<div class="caja clearfix">
	<h1 class="heading PWsemana aMetodoToggle3" ><span class="icoLogo"></span>Mas Time4aChange<span class="icon icon-arrow-down2"></span></h1>
<div>
<input id="txtSearch" name="searchTerm" placeholder="Escriba el nombre de la empresa o persona para buscar..." class="tb form-control long-mytextbox"  />
</div>     
     <div id="divMetodoToggle3" style="display:none;">

		
            <!-- jj-->
						<% 
            do while not xt4ac.eof 
                %>

     <div id="tablaFicha">
            <table style="width:1100px;" >

                <tr>

                    <td>
                        <img src="https://www.propertyweb.eu/img/logos/logoT4AC.png" width="155" style="margin:21px" />
                        <p>Fecha: <%= FormatDateTime(xt4ac("fecha"), 2)  %></p>


                    </td>

                    <td>
                        <div id="TextoNombre">  <%= xt4ac("Nombres") %>&nbsp;<%= xt4ac("Apellidos") %></div>
                        <p>
                        <% if Len(xt4ac("Linkedin"))>0 then %> 
                        <a href="<%= xt4ac("Linkedin") %>" target="_blank"><img src="https://www.propertyweb.eu/rrss/in.png" width="25" /></a>
            			<% end if %>
                        <% if Len(xt4ac("Facebook"))>0 then %> 
                        <a href="<%= xt4ac("Facebook") %>" target="_blank"><img src="https://www.propertyweb.eu/rrss/facebook.png" width="25" /></a>
            			<% end if %>
                        <% if Len(xt4ac("Twitter"))>0 then %> 
                        <a href="<%= xt4ac("Twitter") %>" target="_blank"><img src="https://www.propertyweb.eu/rrss/twitter.png" width="25" /></a>
            			<% end if %>
                        <% if Len(xt4ac("Instagram"))>0 then %> 
                        <a href="<%= xt4ac("Instagram") %>" target="_blank"><img src="https://www.propertyweb.eu/rrss/instagram.png" width="25" /></a>
            			<% end if %>
                        <% if Len(xt4ac("Telefono1"))>0 then %> 
                        <a href="<%= xt4ac("Telefono1") %>" target="_blank"><img src="https://www.propertyweb.eu/rrss/whatsapp.png" width="25" /></a>
            			<% end if %>
                        </p>
                    </td>

                    <td align="center">
                        <% if Len(xt4ac("Foto"))>0 then %> 
						<img src="<%= xt4ac("Foto") %>" class="imgRedonda" />
            			<%end if %>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <div id="TextoPosition2"><%= xt4ac("Posicion1") %></div><p>Desde: <%= FormatDateTime(xt4ac("fecha1"), 2)  %></p>
                    </td>
                    <td>
			<div ><p style="width:600px;"><strong><%= xt4ac("Titulo") %></strong></p>
                       <p style="width:600px;" align="justify"><%= xt4ac("Texto") %></p></div>
                        
                    </td>
                    <td align="center">
                        <div id="TextoPosition2"><%= xt4ac("Posicion2") %></div><p>Desde: <%= FormatDateTime(xt4ac("fecha2"), 2)  %></p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <% if Len(xt4ac("E1_logotipo"))>0 then %> 
                        <p>
                            <div id="capaLogo">
                                <img style="max-width:221px;"  src="https://www.propertyweb.eu/_inc/javier/img/empresas_/<%= xt4ac("E1_logotipo") %>" />

                            </div>
                        </p>
						<% Else %>
						<p><% = xt4ac("E1_Nombre") %></p>
                        <% End If %>
                    </td>
                    <td style="text-align:center">
                        <p><img src="https://www.propertyweb.eu/rrss/flecha.png" /></p>
                    </td>
                    <td>
                        <% if Len(xt4ac("E2_logotipo"))>0 then %> 
                        <p>
                            <div id="capaLogo">
                                <img style="max-width:221px;"  src="https://www.propertyweb.eu/_inc/javier/img/empresas_/<%= xt4ac("E2_logotipo") %>" />

                            </div>
                        </p>
						<% Else %>
						<p><% = xt4ac("E2_Nombre") %></p>  
                        <% End If %>
                    </td>
                </tr>
            </table>
        </div> 
        <p></p>


            <%
                xt4ac.movenext
            loop
            %>
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
	$(".aMetodoToggle3").click(function(e) {
		$("#divMetodoToggle3").toggle(400);
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





















