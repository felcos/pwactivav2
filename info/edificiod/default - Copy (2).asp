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
	case "edif"
		if session("pw_ws").accesoInfoEdificio then acceso_seccion = true
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
	
	<% if request.Form("presentacion")="" then %><!--#include virtual="/info/inc/nav.asp" --><% end if %>
       
    <section id="s_inmueble" class="caja info">
    	<% select case request.Form("seltipo")
		case "edif" 
			%><!--#include virtual="/info/inc/edificio.asp" --><%
		case "dir"
			%><!--#include virtual="/info/inc/direccion.asp" --><%
		case "zona" 
			%><!--#include virtual="/info/inc/zona.asp" --><%
		end select %>
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
                    <% if request.Form("tipoedificio")<>"" then %>
                    <input type="hidden" name="tipoedificio" value="<%= request.Form("tipoedificio") %>">
                    <% end if %>
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

'rsInmueble.close
set rsInmueble=nothing
%>
<!--#include virtual="/info/inc/js.asp" -->