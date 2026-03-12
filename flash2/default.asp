<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->

<head>
    


    <script src="PV110_player/video.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript">
		// Add VideoJS to all video tags on the page when the DOM is ready
		VideoJS.setupAllWhenReady({
		controlsBelow: false, // Display control bar below video instead of in front of
		controlsHiding: true, // Hide controls when mouse is not over the video
		defaultVolume: 0.85, // Will be overridden by user's last volume if available
		flashVersion: 9, // Required flash version for fallback
		linksHiding: true, // Hide download links when video is supported
        autoplay:true
    });

	</script>
	<link rel="stylesheet" href="PV110_player/video-js.css" type="text/css" media="screen" title="Video JS">
</head>
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


Public busPT4ac
Public busET4ac
Public AbrirT4ac
Public txtT4ac
AbrirT4ac=0
busPT4ac=0
busET4ac=0
busPT4ac=request.querystring("busPT4ac")
busET4ac=request.querystring("busET4ac")
txtT4ac=request.querystring("txt")
if busET4ac<>0 then
	set xt4ac = Server.CreateObject("ADODB.Recordset")
	sqlt4ac = "SELECT * FROM View_Time4Change where vivo=1 and ( E1_ID=" & busET4ac & " or E2_ID=" & busET4ac & " ) ORDER BY fecha DESC"
	xt4ac.Open sqlt4ac, session("connPW")	',1,1
	AbrirT4ac=1
else
	if busPT4ac<>0 then
		set xt4ac = Server.CreateObject("ADODB.Recordset")
		sqlt4ac = "SELECT * FROM View_Time4Change where vivo=1 and ( id_persona=" & busPT4ac & " ) ORDER BY fecha DESC"
		xt4ac.Open sqlt4ac, session("connPW")	',1,1
		AbrirT4ac=2
	else

set xt4ac = Server.CreateObject("ADODB.Recordset")
sqlt4ac = "SELECT TOP 3 * FROM View_Time4Change where vivo=1 ORDER BY fecha DESC"
xt4ac.Open sqlt4ac, session("connPW")	',1,1

	end if
end if



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

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-143927921-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-143927921-1');
</script>

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
                                    foto: (item.Foto=="https://www.propertyweb.eu/rrss/" || item.Foto=="https://www.propertyweb.eu/_inc/javier/img/empresas_/" ) ? "https://www.propertyweb.eu/fotoEmpresa.png" : item.Foto.split("&", 1), 
					target: "_self",
					url: (item.Persona=="1") ? "/flash?busPT4ac=" + item.Id + "&txt=" + item.Nombre : "/flash?busET4ac=" + item.Id + "&txt=" + item.Nombre
					
                                   // url: "https://www.propertyweb.eu"
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
            <div class="col col-md-12 caja clearfix">			
                <a href="https://segro-los-gavilanes.330e.brandcast.io/" target="_blank"><img src="/img/banner-segro.gif" width="280" style="margin:0px;padding:0px;" ></a>
                <a href="https://www.dracorion.com/" target="_blank" ><img src="publi1.png" width="280"  style="margin:0px;padding:0px;margin-left: 0px;"  /></a>
 
                <a href="https://www.hollisglobal.com/?utm_source=Property%20Web&utm_medium=Link&utm_campaign=Advert" target="_blank" ><img src="/img/banners/mh.png" width="280"  style="margin:0px;padding:0px;" /></a>            
                <a href="https://www.catella.com/" target="_blank" ><img src="BannerPW.png" width="280" style="margin:0px;padding:0px;"   /></a>

            </div>
        </section>

        <section id="fechas2" class="fechas row clearfix">  
            <div class="col-md-6 caja "  >            
                <h1 class="heading PWsemana aMetodoToggleV"><span class="icoLogo"></span> Andy da las claves de Hoy en vivo!<span class="icon icon-arrow-down2"></span></h1>
                <div id="divMetodoToggleV" style="display:inline-block;">
                    <iframe src="https://www.youtube.com/embed/<%= xvideo("link") %>" width="350" align="left" style="margin:0px;padding:0px;" allowfullscreen="allowfullscreen"></iframe>
                </div>
            </div>
            <div class="col-md-6 caja "  >   
                <div class="col-md-8"  >          
                <h1 class="heading PWsemana aMetodoToggleV" style="font-size:large;"><span class="icoLogo"></span>&nbsp;Principe de Vergara 110, Madrid</h1>
                    <div class="video-js-box">
                        <video 
                            id="video_1" 
                            class="video-js" 
                            width="334" 
                            height="168" 
                            controls autoplay muted loop  
                            preload="auto" 
                            poster="PV110_player/preview.png">
                                <source src="PV110.mp4" type='video/mp4; codecs="avc1.42E01E, mp4a.40.2"' />                  
                                <!-- Flash Fallback. Use any flash video player here. Make sure to keep the vjs-flash-fallback class. -->
                                <object id="flash_fallback_1" class="vjs-flash-fallback" width="334" height="168" type="application/x-shockwave-flash"
                                data="PV110_player/flowplayer-3.2.3.swf">
                                <param name="movie" value="PV110_player/flowplayer-3.2.3.swf" />
                                <param name="allowfullscreen" value="true" />
                                <param name="flashvars" value='config={"playlist":["PV110_player/preview.png", {"url": "PV110.mp4","autoPlay":true, "autoBuffering":true, "scaling": "orig"}]}' />
                                <!-- Image Fallback. Typically the same as the poster image. -->
                                <img src="PV110_player/preview.png" width="334" height="168" alt="Poster Image" title="No video playback capabilities." />
                                </object>
                        </video>

  
                    </div>
                </div>
                    <div class="col-md-4">
                        <form class="pagsum_detalle" id="frm5" method="post" action="/info/edificio/" data-id="5093">
                            <input type="hidden" name="frmInfo_tipo" value="edif">
                            <input type="hidden" name="frmInfo_busq" value="principe de vergara">
                            <input type="hidden" name="secc" value="edif">
                            <input type="hidden" name="seltipo" value="edif">
                            
                                <input type="hidden" name="id_edificio" value="5093">     
                            
                        </form>
                        <form class="pagsum_detalle" id="frm1_pg89" method="post" action="/info/edificio/" data-id="5921">
                            <input type="hidden" name="frmInfo_tipo" value="edif">
                            <input type="hidden" name="frmInfo_busq" value="PASEO GRACIA 89">
                            <input type="hidden" name="secc" value="edif">
                            <input type="hidden" name="seltipo" value="edif">
                            <input type="hidden" name="id_edificio" value="5921">
                        </form>
                        <a href="/info/edificio/" onclick="$('#frm5').submit();return false;" >
                            <div class="inm_nombre"><span style="color: #ff6701;" class="icon-office"></span>&nbsp;¿Quieres saberlo todo?</div>
                        </a>
                        <a href="https://www.propertyweb.eu/articulos/?ope=34538&seltipo=edif&frmInfo_tipo=edif&frmInfo_busq=principe%20de%20vergara&historico_alquiler=on&historico_inversion=on&historico_noticias=on&historico_rumores=on&historico_estudios=on&secc=edif&origen=edif:5093&id_edificio=5093&edificio=PRINCIPE%20DE%20VERGARA%20110&calle=PRINCIPE%20DE%20VERGARA&l=MADRID&numerocalle=110&d=CALLE%20PRINCIPE%20DE%20VERGARA%20110"  >
                            <div class="inm_nombre"><span style="color: #ff6701;" class="icon-newspaper"></span>&nbsp;¿Quieres saber que ha pasado?</div>
                        </a>
                            <ul>
                        <a >
                            <input name="frmInfo_tipo" type="hidden" class="infoRadio frmInfo_tipo" value="disp" id="frmInfo_disp" <% if frmInfo_tipo="disp" then %>checked<% end if %>/>
                            <label style="font-weight: normal;" for="frmInfo_disp" id="lblInfo_disponib" ><span style="color: #ff6701;" class="icon-database"></span>&nbsp;¿Buscas disponibilidad?<% if ver_contadores then %> <span data-toggle="contador_leidos" data-content="dis"><%= ubound(filter(ArticulosLeidos, "dis"))+1 %></span><% end if %></label>
                        </a></ul>
                        <a href="https://www.propertyweb.eu/dealanalysis/default.asp?xOrigen=1" ><div class="inm_nombre"><span style="color: #ff6701;" class="icon-equalizer"></span>&nbsp;¿Quieres saber que operaciones hay en la zona?</div></a>
                    </div>
                    
            </div>
        </section>
        <section id="fechas3" class="fechas row">
            <div class="col-md-12 caja " >	
                <h1 class="heading PWsemana aMetodoToggle2"><span class="icoLogo"></span>Mas videos...<span class="icon icon-arrow-down2"></span>
                </h1> 
                <p style=" color: #2B4E61;">Y si tienes algo para nosotros, llamame... Movil:617.835.023 o andyg@propertyweb.eu</p>
                <div id="divMetodoToggle2" style="display:none;">
                <% 
                    do while not xvideo.eof 
                %><iframe src="https://www.youtube.com/embed/<%= xvideo("link") %>" width="300"  allowfullscreen="allowfullscreen"></iframe>
                <%
                    xvideo.movenext
                    loop
                %>
                </div>
            </div>
        </section>

    <section id="fechas4" class="fechas row">
  
  	<div class="col col-md-8  caja clearfix">
	    <h1 class="heading PWsemana aMetodoToggle3" ><span class="icoLogo"></span>Mas Time4aChange<span class="icon icon-arrow-down2"></span></h1>
        <div>
            <h2 class="tit_box" >  <span class="icon icon-search"></span>  Buscar los Time4aChange de una Persona o de una Empresa</h2>
            <div class="ubicacion_separador"></div>
                <input id="txtSearch" name="searchTerm" placeholder="Escriba el nombre de la empresa o persona para buscar..." class="tb form-control long-mytextbox"  />
                <% if AbrirT4ac<>0 then %>
                <br>
                <h1>Resultado de la busqueda: <%=txtT4ac %> </h1>
                <% end if %>
            </div>     
    <div id="divMetodoToggle3" <% if AbrirT4ac=0 then %> style="display:none;" <% else %> style="display:block;" <% end if %> 
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
        

        
        	<div class="col-md-3  ">      <!-- col-xs-pull-6-->      			
             <h1 class="heading PWsemana aMetodoToggle"><span class="icoLogo"></span>PW Semana <span class="icon icon-arrow-down2"></span></h1>
             <div id="divMetodoToggle" style="display:inline-block;">
             <!-- jj-->
             <p style="font-weight: bold; color: #2B4E61;"><%= FormatDateTime(pFecha, 1) %></p>
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
			url: "/flash2/titulos.asp",
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

    //document.getElementById('video_1').play();
    //console.log(document.getElementById('video_1'));

});


</script>







<script type="text/javascript">
        //var myPlayer = document.getElementById('video_1')
        var myPlayer = VideoJS.getPlayer('video_1');
  myPlayer.on('loadedmetadata',function() {
    var promise = myPlayer.play();
    if (promise !== undefined) {
      promise.then(function() {
        alert("Autoplay started!");
      }).catch(function(error) {
        alert("Autoplay was prevented.");
      });
    }
  });

  
 // document.getElementById('video_1').play();
  </script>













