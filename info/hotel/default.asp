<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% 
'if request.form("id_edificio")="" then response.Redirect("/info/") 
%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<% 'if request.form("id_edificio")="" then response.Redirect("/") %>
<!DOCTYPE html>
<html lang="es">
<head>
<title>PropertyWeb - Tu servicio de Informaci&oacute;n Inmobiliaria</title>
    <% if request.Form("presentacion")<>"informe" then %>
    <link href="/css/estilos_jm-ok.css" media="screen" rel="stylesheet" type="text/css" />
    <link href="/css/css-pags/tabs02.css" rel="stylesheet" type="text/css">
    <% end if %>
	<!--#include virtual="/inc/head.asp" -->
    <!--#include virtual="/lib/aspjson/JSON_2.0.4.asp" -->
    <!--#include virtual="/lib/aspjson/JSON_UTIL_0.1.1.asp" -->
    <link href="/info/inmueble.css" rel="stylesheet">
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC_5kUZnI4pDgH19ptKkMuneHuz0tJ5P6g&region=ES"></script>
    
	<script src="/lib/fancyBox/jquery.fancybox.js" type="text/javascript"></script>
	<link href="/lib/fancyBox/jquery.fancybox.css" media="screen" rel="stylesheet" type="text/css" />
    
</head>
<body>
<!--#include virtual="/inc/body-header.asp" -->
<%
rId = request.form("id_edificio")

'response.Write(request.Form)
'response.End()

sec_actual = "/info/"
Actual = Now()
ActualYYYY=Year(Actual) 
ActualMM=Month(Actual) 
ActualYYYY2= (ActualYYYY * 100) + ActualMM

public limitenoticias
public limiteestudios
public limiterumores
public limiteoperaciones
public ErrMesage

public resultado
public idedificio
public inmu	

dim sql

Public strin		'Pasara el codigo del link del tipo de artículo
public bloque

public acceso_seccion
acceso_seccion = false

if session("IniCliente")=0 then
	select case request.Form("secc")
	case "hot"
		if session("pw_ws").accesoInfoHotel then acceso_seccion = true
	case "prop"
		if session("pw_ws").accesoInfoPropietario then acceso_seccion = true
	end select
end if

if request.form("presentacion")="informe" then
	acceso_seccion = true
end if

set rsInmueble = Server.CreateObject("ADODB.Recordset")
%>
<div id="" class="container">
	<% if 1=2 then %><div class="dev"><%
        for each elto in request.Form
            %>[<strong><%= elto %></strong>: <%= request.Form(elto) %>] <%
        next %>
    </div><% end if %>
	<% if request.Form("presentacion")="" then %><!--#include virtual="/info/inc/nav.asp" --><% end if %>
       
    <section id="s_inmueble" class="caja info">
    	<% 
		'on error resume next
		
		rId = request.form("id_edificio")
		rsInmueble.Open "SELECT * FROM c_inmuebles WHERE id=" & rId, session("connPW")
		
		idInmueble = rsInmueble("id")
		c_fecha_edif=rsInmueble("fecha_edif")
	dispo=rsInmueble("disponible_superficie")

		if request.Cookies("dev")("request")<>"" then %>
		<div class="dev">
			<% for each elto in request.Form
				response.Write("[<strong>" & elto & "</strong>: " & request.Form(elto) & "] ")
			next %>
		</div>
		<% end if
		
		'dirGoogleMaps=""
		dirGoogleMaps = rsInmueble("dir1")
		dirGoogleMaps = dirGoogleMaps & ", " & rsInmueble("dir3")
		
		if rsInmueble("id_pais")>1 then
			dirGoogleMaps = dirGoogleMaps & " (" & rsInmueble("pais") & ")"
		end if
		
		if rsInmueble("id_tipo_inmueble")=1 then
			dirGoogleMaps = rsInmueble("nombre") & " " & dirGoogleMaps
		end if
		
		mapaGoogleMaps = dirGoogleMaps
		mapaGoogleMaps = replace(mapaGoogleMaps, "'", " ")
		mapaGoogleMaps = replace(mapaGoogleMaps, "Á", "A")
		mapaGoogleMaps = replace(mapaGoogleMaps, "É", "E")
		mapaGoogleMaps = replace(mapaGoogleMaps, "Í", "I")
		mapaGoogleMaps = replace(mapaGoogleMaps, "Ó", "O")
		mapaGoogleMaps = replace(mapaGoogleMaps, "Ú", "U")
		mapaGoogleMaps = replace(mapaGoogleMaps, "Ñ", "N")
		
		if not isnull(rsInmueble("lat")) then
			coordsGoogleMaps="@"  & rsInmueble("lat") & "," & rsInmueble("lng")
		end if
		
		sFotos = "" & rsInmueble("fotos")
		
		if isnull(rsInmueble("lat")) then
			tiene_coords = false
		else
			tiene_coords = true
			lat = replace(rsInmueble("lat"), ",", ".")
			lng = replace(rsInmueble("lng"), ",", ".")
		end if
		
		if NOT ISNULL(rsInmueble("id_complejo")) then
			
		end if
		
		%>
		
		<div class="row">
			<%
			'if rsInmueble("id_tipo_inmueble")=1 then
				nombre = rsInmueble("nombre")
			'else
			'	nombre = rsInmueble("nombre_completo")
			'end if
			%>
			<div class="col-sm-7">
				<!--#include virtual="/info/inc/miga.asp" -->
				<h1 class="heading"><span class="tipo">HOTEL </span><span class="nombreH"><%= nombre %></span></h1>
				<% if not(isnull(rsInmueble("id_complejo"))) then 
					 set rsCompl = Server.CreateObject("ADODB.Recordset")
					 sql = "SELECT * FROM c_inmuebles WHERE id=" & rsInmueble("id_complejo")
					 rsCompl.Open sql, session("connPW")
					%>
					<p class="parqueInfo">
					<form class="pagsum_detalle" id="frmComplejo" method="post" action="/info/inmueble/">
						<input type="hidden" name="frmInfo_tipo" value="<%= request.Form("frmInfo_tipo") %>">
						<input type="hidden" name="frmInfo_busq" value="<%= request.Form("frmInfo_busq") %>">
						<input type="hidden" name="seltipo" value="inmueble">
						
						<input type="hidden" name="id_edificio" value="<%= rsCompl("id") %>">
						<input type="hidden" name="edificio" value="<%= rsCompl("nombre") %>">
						<input type="hidden" name="calle" value="<%= rsCompl("nombre_calle") %>">
						<input type="hidden" name="numerocalle" value="<%= rsCompl("numero_calle") %>">
						<input type="hidden" name="d" value="<%= rsCompl("dir1") %>">
						<input type="hidden" name="l" value="<%= rsCompl("localidad") %>">
					</form>
					<% if not isnull(rsCompl("id_tipo_edificio")) then %><span><%= rsCompl("tipo_edificio") %>: </span> <% end if %>
					 <a href="/info/inmueble/" id="complejo"><%= rsCompl("nombre") %></a>
					</p>
					<% rsCompl.close
					set rsCompl = nothing
				end if %>
			  <p class="direInfo"><%= rsInmueble("dir1") %>
				<% if rsInmueble("dir2")<>"" then %><br><%= rsInmueble("dir2") %><% end if %><br>
			  <%= rsInmueble("dir3") %></p>
			</div>
			
			<div class="col-sm-5">
				<!--#include virtual="/info/inc/shared/agentes.asp" -->
			</div>
		
		</div>
		
		<div class="separador02"></div>
		
		<div class="detalles clearfix">
			  <div class="bloqueLeft slider01"> 
				<% if sFotos="" then %><img src="/_inc/javier/img/gnral/default-edif.jpg" width="373" height="209"/>
				<% else %><!--#include virtual="/inc/fotos_carousel.asp" -->
				<% end if %>
				<div class="separator"></div>
			  </div>
			  
			  <!--#include virtual="/info/inc/shared/superficies.asp" -->
			  
		</div>
		
		<div class="detalles clearfix">
			<div class="bloqueLeft ">
				<div class="cajaImg"><!--#include virtual="/info/inc/shared/mapa.asp" --></div>
				<div class="pieImg"><p>MAPA/STREET VIEW<img src="/_inc/javier/img/info/muneco.gif" /></p></div>
				
			</div>
			<div class="bloqueRight">
				<h3>DESCRIPCI&Oacute;N</h3>
					<% if acceso_seccion then
						txtDescripcion = "" & trim(rsInmueble("descripcion"))
						txtComentarios = "" & trim(rsInmueble("comentarios"))
						%>
						<div class="descripcion">
							<ul class="ulTabla">
							<% if rsInmueble("id_tipo_inmueble")=2 then %>
								<% if not isnull(rsInmueble("habitaciones")) then %>
									<li><span>N&uacute;mero de Habitaciones :</span><span><%= rsInmueble("habitaciones") %></span></li>
								<% end if %>
								<% if not isnull(rsInmueble("id_categoria")) then %>
									<li><span>Categor&iacute;a :</span><span><%= rsInmueble("categoria") %></span></li>
								<% end if %>
								
								<li><span class="separador02"></span><span  class="separador02"></span></li>
							<% end if %>
							
							<% if not isnull(rsInmueble("fecha_edif")) then %>
								<li 
								<% if c_fecha_edif>10000 then 
                            if c_fecha_edif>ActualYYYY2 then  %> style="background-color:#CCCCCC;" <% end if 
                            else 
                            if c_fecha_edif>ActualYYYY then  %> style="background-color:#CCCCCC;" <% end if 
                            end if %>
								><span>A&ntilde;o Construcci&oacute;n :</span><span>
									<% if c_fecha_edif>10000 then
									response.write mid(c_fecha_edif,5,2) + "/" + mid(c_fecha_edif,1,4)
									else
									response.write rsInmueble("fecha_edif")
									end if %>
									<% if c_fecha_edif>10000 then 
									if c_fecha_edif>ActualYYYY2 then  %> &nbsp;<img src="/img/underc.png" width="25"/> <% end if 
									else 
									if c_fecha_edif>ActualYYYY then  %> &nbsp;<img src="/img/underc.png" width="25"/> <% end if 
									end if %>
								</span></li>
							<% end if %>
							<% if not isnull(rsInmueble("fecha_renov")) then %>
								<li><span>A&ntilde;o Renovaci&oacute;n :</span><span><%= rsInmueble("fecha_renov") %></span></li>
							<% end if %>
							<li><span class="separador02"></span><span  class="separador02"></span></li>
							</ul>
							<% if txtDescripcion="" then %>
								<p>No hay datos aportados</p>
							<% else
								texto = txtDescripcion
								lista = split(texto, chr(13))
								
								for each elto in lista
									
									for ii=1 to 3
										if len(elto)<1 then exit for
										char = asc(mid(elto, 1,1))
										if char=10 or char=45 or char=32 then		 'or char=46	"."
											elto = mid(elto, 2, len(elto)-1)
										end if
									next
									if elto<>"" then
										%><p><%= elto %></p><%
									end if
								next %>
							<% end if %>
						</div>
						
						<% if txtDescripcion<>"" and txtComentarios<>"" then %><hr><% end if %>
						
						<h3>COMENTARIOS</h3>
						<div class="descripcion">
							<% if txtComentarios="" then 
								%><p>No hay datos aportados</p><%
							else
								texto = txtComentarios
								lista = split(texto, chr(13))
								
								for each elto in lista
									
									for ii=1 to 3
										if len(elto)<1 then exit for
										char = asc(mid(elto, 1,1))
										if char=10 or char=45 or char=32 then		 'or char=46	"."
											elto = mid(elto, 2, len(elto)-1)
										end if
									next
									if elto<>"" then
										%><p><%= elto %></p><%
									end if
								next
							end if %>
						</div>
						<% if rsInmueble("es_complejo") then %>
						<!--#include virtual="/info/inc/shared/complejo.asp" -->
						<% end if %>
		
					<% else %>
						<div class="alert azul">
							<div>
								<p>Para ver las caracteristicas del inmueble, conocer los distintos usos y superficies, la distribución de plantas, etc... debe tener contratado <strong>Info-Inmuebles</strong>.</p>
								<p style="margin-top:10px;">Póngase en <a href="#" class="simplemodal">contacto con PropertyWeb</a>.</p>
							</div>
						</div>
					<% end if %>
							
					<% if rsInmueble("id_tipo_inmueble")=0 then %>
						<% 'histórico disponibilidad 
						if rsInmueble("id_tipo_inmueble")=0 then
							
							set rsDispH = Server.CreateObject("ADODB.Recordset")
							rsDispH.Open "SELECT * FROM inmuebles_disponibilidad WHERE id_inmueble=" & rsInmueble("id"), session("connPW")
							if not rsDispH.eof then 
								if txtDescripcion<>"" or txtComentarios<>"" then %><hr><% end if %>
								<h3>ARCHIVO HIST&Oacute;RICO DE DISPONIBILIDAD</h3>
								<table class="tb-Gral tb-dispoHistorico">  
									<thead>  
										<tr>
											<th>Fecha</th>
											<th>Disponibilidad<span class="breakPalabra"></span>/M<sup>2</sup></th>	
											<th>% Vac&iacute;o</th>	
											<th>Renta M&iacute;n (&euro;/M<sup>2</sup>/Mes)</th>
											<th>Renta M&aacute;x (&euro;/M<sup>2</sup>/Mes)</th>
											<th>Notas</th>
										</tr>
									</thead> 
									<tbody>
										<% do while not rsDispH.eof
											disp_fecha = FechaCorta(rsDispH("fecha"))
											disp_superficie = FormatNumber(rsDispH("superficie"), 0)
											disp_porcentaje = rsDispH("porcentaje")
											
											disp_renta_min = rsDispH("renta_min")
											if disp_renta_min<>"" then disp_renta_min = FormatNumber(disp_renta_min, 2)
											disp_renta_max = rsDispH("renta_max")
											if disp_renta_max<>"" then disp_renta_max = FormatNumber(disp_renta_max, 2)
											
											disp_notas = rsDispH("notas")
											%>
											<tr>
												<td><%= disp_fecha %></td>
												<td><%= disp_superficie %></td>
												<td><%= disp_porcentaje %></td>
												<td><%= disp_renta_min %></td>
												<td><%= disp_renta_max %></td>
												<td><%= disp_notas %></td>
											</tr>
											<% rsDispH.movenext
										loop %>
									</tbody> 
								</table>
							<% end if
							rsDispH.close
							set rsDispH=nothing
						end if
					end if %>
				
			</div>
		</div> 
		
		<% if acceso_seccion and rsInmueble("id_tipo_inmueble")=0 then %>
		<div class="row detalles">
			
			<div class="col-sm-6 col-sm-offset-3">
				<!-- h3>Evoluci&oacute;n de Rentas (&euro;/m&sup2;/mes)</h3 -->
				<div id="graf_rentas"></div>
			</div>
			
			<% IF 1=2 THEN %>
			<div class="col-sm-6"></div>
			<div class="col-sm-6">
				<h3>evolucion de Precio (€/m2)</h3>
				<div class="grafica01"><img src="/_inc/javier/img/info/tabla-evolucion.jpg" class="mapa01Img"></div>
			</div>
			<% END IF %>
		</div>
		<!--#include virtual="/info/inc/shared/historico_precios.asp" -->
		<% end if %>
		
		<% if acceso_seccion and rsInmueble("id_tipo_inmueble")=1 then %>
		<!--#include virtual="/info/inc/shared/inquilinos.asp" -->
		<% end if %>
		
		<% if rsInmueble("id_tipo_inmueble")=0 then %>
			<!--#include virtual="/lib/jqplot/inc_jqplot.asp" -->
		<% end if %>
		
        <div class="row detalles">
            <div class="historico clearfix" id="historico_articulos">
                <%
                frm_url = "/info/data/titulos.asp"
                if request.Form("presentacion")="informe" then frm_url = "/info/informe/articulos.asp"
                
                seltipo = request.Form("seltipo")
				
				checkAll = false
				if acceso_seccion and instr(request.Form, "historico_")=0 then checkAll=true
				
                %>
                <form method="POST" id="frm_resumen" name="frm_resumen" action="<%= frm_url %>" target="_blank">
                    <input type="hidden" name="seltipo" value="<%= request.Form("seltipo") %>">
                    <input type="hidden" name="frmInfo_tipo" value="<%= request.Form("frmInfo_tipo") %>">
                    <% if request.Form("frmInfo_tipo")="prop" then 
						%><input type="hidden" name="frmInfo_propietario" value="<%= request.Form("frmInfo_propietario") %>"><%
					else
						%><input type="hidden" name="frmInfo_busq" value="<%= request.Form("frmInfo_busq") %>"><%
					end if %>
                    <input type="hidden" name="secc" value="<%= request.Form("secc") %>">
                    <% select case seltipo 
                    case "edif" %>
						<input type="hidden" name="origen" value="edif:<%= rsInmueble("id") %>">
                        <input type="hidden" name="id_edificio" value="<%= rsInmueble("id") %>">
                        <input type="hidden" name="edificio" value="<%= rsInmueble("nombre") %>">
                        <input type="hidden" name="l" value="<%= rsInmueble("localidad") %>">
                        <input type="hidden" name="calle" value="<%= rsInmueble("nombre_calle") %>">
                        <input type="hidden" name="numerocalle" value="<%= rsInmueble("numero_calle") %>">
                        <input type="hidden" name="d" value="<%= rsInmueble("dir1") %>">
                        <% if not isnull(rsInmueble("id_complejo")) then %>	
                            <input type="hidden" name="id_complejo" value="<%= rsInmueble("id_complejo") %>">
                            <input type="hidden" name="complejo" value="<%= rsInmueble("complejo") %>">
                        <% end if %>
                    <% case "dir" %>
                        <input type="hidden" name="l" value="<%= request.Form("l") %>">
                        <input type="hidden" name="tipovia" value="<%= request.Form("tipovia") %>">
                        <input type="hidden" name="calle" value="<%= request.Form("calle") %>">
                        <input type="hidden" name="numerocalle" value="<%= request.Form("numerocalle") %>">
                        <input type="hidden" name="d" value="<%= request.Form("d") %>">
                    <% case "zona" %>
                        <input type="hidden" name="zona" value="<%= request.Form("zona") %>">
                    <% end select %>
                
                <div class="cab">
                    <h3>Archivo Hist&oacute;rico</h3>
                </div>
                
                <div class="col-sm-4">
                  <ul class="">
                    <li class="operaciones">Operaciones:</li>
                    <li>
                      <span class="num" data-content="historico_alquiler"></span>
                      <input id="historico_alquiler" name="historico_alquiler" type="checkbox" <% if request.Form("historico_alquiler")<>"" or checkAll then %>checked<% end if %> disabled/>
                      <label for="historico_alquiler">Alquiler:</label>
                    </li>
                    <li>
                      <span class="num" data-content="historico_inversion"></span>
                      <input id="historico_inversion" name="historico_inversion" type="checkbox" <% if request.Form("historico_inversion")<>"" or checkAll then %>checked<% end if %> disabled/>
                      <label for="historico_inversion">Inversi&oacute;n:</label>
                    </li>
                  </ul>
                </div>
                <div class="col-sm-4">
                  <ul class="ul2">
                    <li>
                      <span class="num" data-content="historico_noticias"></span>
                      <input id="historico_noticias" name="historico_noticias" type="checkbox" <% if request.Form("historico_noticias")<>"" or checkAll then %>checked<% end if %> disabled/>
                      <label  for="historico_noticias">Noticias Inmobiliarias</label>
                    </li>
                    <li>
                      <span class="num" data-content="historico_rumores"></span>
                      <input id="historico_rumores" name="historico_rumores" type="checkbox" <% if request.Form("historico_rumores")<>"" or checkAll then %>checked<% end if %> disabled/>
                      <label for="historico_rumores">&quot;Web" ha o&iacute;do...: </label>
                    </li>
                    <li>
                      <span class="num" data-content="historico_estudios"></span>
                      <input id="historico_estudios" name="historico_estudios" type="checkbox" <% if request.Form("historico_estudios")<>"" or checkAll then %>checked<% end if %> disabled/>
                      <label for="historico_estudios">Estudios de Mercado</label>
                    </li>
                  </ul>
                </div>
                
                <% if acceso_seccion then %>
                        <div class="col-sm-4 bloqBotontes">
                            <button style="display:none;" id="ver_articulos" type="submit" class="btn btnAzul" <% if request.Form("presentacion")="informe" then %>disabled="disabled"<% end if %>><span class="icon icon-arrow-right2"></span> Mostrar Articulos</button>
                            <span id="loading"><img src="/img/ajax-loader.gif"></span>
                        </div>
                    <% else %>    
                        <div class="col-sm-4 ">
                        <div class="alert azul">
                            <div>
                              <p>Para acceder a los contenidos del <strong>Archivo Histórico</strong> debe ser cliente</p>
                              <p style="margin-top:10px;">Póngase en <a href="#" class="simplemodal">contacto con PropertyWeb</a>.</p>
                            </div>
                          </div>
                        
                    </div>
                <% end if %>
                </form>
                <% if request.Cookies("dev")<>"" then %>
                    <div class="clearfix"></div>
                    <div class="dev peq" id="informa_historico"></div>
                    <div class="clearfix"></div>
                <% end if %>
                <!-- Modal -->
                <div class="modal fade" id="avisoForm" role="dialog">
                    <div class="modal-dialog">
                      <!-- Modal content-->
                      <div class="modal-content">
                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                          <h4 class="modal-title">Nada seleccionado</h4>
                        </div>
                        <div class="modal-body">
                          <p>Debes seleccionar alg&uacute;n apartado para cargar el archivo hist&oacute;rico.</p>
                          <p>Marca las secciones que quieras ver y vuelve a intentarlo.</p>
                          <!-- 
                          <div class="botones">
                              <button type="button" class="btn" data-dismiss="modal">Aceptar</button>
                          </div>
                          -->
                        </div>
                        <div class="modal-footer">
                          <button type="button" class="btn" data-dismiss="modal">Aceptar</button>
                        </div>
                      </div>
                      
                    </div>
                </div>
            </div>
        </div>
        
	</section>
	<%
    clase = "caja"
    if request.Form("presentacion")="informe" then clase=""
    %>
    <section id="s_titulos" class="row clearfix">
        <div id="div_result" class="<%= clase %>" style="display:none;">
            <div id="result"></div>
        </div>
    	
		<% if request.Form("presentacion")="informe" then %>
            <!-- br /-->
            <div id="__separator_line" style="clear:both"></div>
            <p class="copyright_articulo">&copy; Property Web España</p>
        <% end if %>
    </section>
</div>
<!--#include virtual="/inc/body-footer.asp" -->
</body>
</html>
<%
insert_reg_articulo request.Form("secc"), "edif", rsInmueble("id")

rsInmueble.close
set rsInmueble=nothing
%>
<!--#include virtual="/info/inc/js.asp" -->
<script>
$(document).ready(function() { 
	initMap();
})
</script>