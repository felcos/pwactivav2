<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% 
'on error resume next

if request.QueryString("id")<>"" then 
	id = request.QueryString("id")
	
	set rs = Server.CreateObject("ADODB.Recordset")
	rs.open "SELECT * FROM dirs_w_inmuebles WHERE id=" & id, session("connPW")
	
	if rs.eof then response.Redirect("/")
	
	select case rs("id_tipo_inmueble")
	case 0
		tipo = ""
	case 1
		tipo = "cc"
	case 2
		tipo = "hot"
	end select
	%>
	<form id="frm" method="post" action="/info/edificio/">
        <input type="text" name="frmInfo_tipo" value="edif">
        <input type="text" name="frmInfo_busq" value="<%= rs("nombre") %>">
        <input type="text" name="seltipo" value="inmueble">
        
        <input type="text" name="id_edificio" value="<%= rs("id") %>">
        <input type="text" name="edificio" value="<%= rs("nombre") %>">
        <input type="text" name="calle" value="<%= rs("nombre_calle") %>">
        <input type="text" name="numerocalle" value="<%= rs("numero_calle") %>">
        <input type="text" name="d" value="<%= rs("dir1") %>">
        <input type="text" name="l" value="<%= rs("localidad") %>">
        
        <input type="submit" value="submit">
    </form>
	<%
	rs.close
	set rs=nothing
	%><script>//document.getElementById("frm").submit();</script><% 
	response.End()
	
end if %>
>> /INFO/EDIFICIOS/
<%
RESPONSE.END()

if request.form("id_edificio")="" then 
	response.Redirect("/info/") 
end if %>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
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

dim supSR
dim supBR
%>
<%
public acceso_cliente
public acceso_seccion
'resp = session("PW_WS").IniCliente(Request.Cookies("licencia")("n"), Request.Cookies("licencia")("u"), Request.Cookies("licencia")("p"))
'resp = session("pw_ws").Comprobar_Licencia(request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("n"), request.Cookies("licencia")("user_id"))
'
'resp = session("PW_WS").Comprobar_Licencia(request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("n"), request.Cookies("licencia")("movil"), request.Cookies("licencia")("user_id"))

select case resp
case 0		'cliente activo, licencia válida
	acceso_cliente = true
	if session("pw_ws").accesoInfoEdificio then
		acceso_seccion = true
	else
		acceso_seccion = false
	end if
case 1		'no es cliente
	acceso_cliente = false
	acceso_seccion = false
case 2		'cliente no activo
	acceso_cliente = false
	acceso_seccion = false
end select

if request.form("presentacion")="informe" then
	acceso_seccion = true
end if

'TRANSACTIONAL
'registro
'if request.Cookies("dev")("reg")="" and request.Cookies("licencia")("log")="" then
'	if instr(session("articulos"), "#inm" & request.form("id_edificio") & "#")=0 then 
'		session("articulos") = session("articulos") & "inm" & request.form("id_edificio") & "#"
'		
'		'reg articulos	
'		sqlReg = "INSERT INTO reg_articulos (session_id, fecha, hora, articulo_tipo, articulo_id, id_licencia, licencia, id_cliente, cliente) VALUES ("
'		sqlReg = sqlReg & "'" & session.SessionID & "', '" & date & "', '" & time & "', "
'		sqlReg = sqlReg & "'inm', " & request.form("id_edificio")  & ", "
'		
'		sqlReg = sqlReg & session("pw_ws").LicenciaId & ", '" & session("pw_ws").Licencia & "', "
'		sqlReg = sqlReg & session("pw_ws").ClienteId & ", '" & session("pw_ws").Cliente & "'"
'		
'		sqlReg = sqlReg & ")"
'		
'		session("connPWAcesos").execute sqlReg
'	end if
'end if
'TRANSACTIONAL

set rsInmueble = Server.CreateObject("ADODB.Recordset")

rsInmueble.Open "SELECT * FROM c_inmuebles WHERE id=" & rId, session("connPW")

idInmueble = rsInmueble("id")

'dirGoogleMaps=""
if 1=2 then
	if len(rsInmueble("NOMBRE_CALLE"))>3 then	' AND rsInmueble("id_pais")=1
		if rsInmueble("id_tipo_direccion")>0 then
			dirGoogleMaps = rsInmueble("tipo_direccion") & "&nbsp;" 
		end if
		dirGoogleMaps = dirGoogleMaps & rsInmueble("NOMBRE_CALLE")
	'	if rsInmueble("id_seccion")<>128  then		'solares 
	'	'and rsInmueble("id_seccion")<>1 then 'centros comerciales
			dirGoogleMaps = dirGoogleMaps & "&nbsp;" & rsInmueble("NUMERO_CALLE")
	'	end if
		dirGoogleMaps = dirGoogleMaps & ", "
	end if 
	dirGoogleMaps = dirGoogleMaps & rsInmueble("LOCALIDAD") 
	if rsInmueble("id_pais")=1 then
		if rsInmueble("CODIGO_POSTAL")<>"" and len(rsInmueble("CODIGO_POSTAL"))=5 then 
			dirGoogleMaps = dirGoogleMaps & ", " & rsInmueble("CODIGO_POSTAL")
		end if
	end if
end if

dirGoogleMaps = rsInmueble("dir1")
'if rsInmueble("dir2")<>"" then
'	dirGoogleMaps = dirGoogleMaps & "," & rsInmueble("dir2")
'end if
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
<% 'if request.form("id_edificio")="" then response.Redirect("/") %>
<!DOCTYPE html>
<html lang="es"><head>
<title>PropertyWeb - Tu servicio de Informaci&oacute;n Inmobiliaria</title>
	<!--#include virtual="/inc/head.asp" -->
    <!--#include virtual="/lib/aspjson/JSON_2.0.4.asp" -->
    <!--#include virtual="/lib/aspjson/JSON_UTIL_0.1.1.asp" -->
    <link href="/info/inmueble.css" rel="stylesheet">
    <% if request.Form("presentacion")<>"informe" then %>
    <link href="/css/css-pags/tabs02.css" rel="stylesheet" type="text/css">
    <% end if %>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC_5kUZnI4pDgH19ptKkMuneHuz0tJ5P6g&region=ES"></script>
    
	<script src="/lib/fancyBox/jquery.fancybox.js" type="text/javascript"></script>
	<link href="/lib/fancyBox/jquery.fancybox.css" media="screen" rel="stylesheet" type="text/css" />
    <% if request.Form("presentacion")="informe" then %>
    <link href="/css/estilos_jm-ok.css" media="screen" rel="stylesheet" type="text/css" />
    <% end if %>
    
	<% if rsInmueble("id_tipo_inmueble")=0 then %>
    <!--#include virtual="/lib/jqplot/inc_jqplot.asp" -->
    <% end if %>
    
</head>
<body>
<!--#include virtual="/inc/body-header.asp" -->
<% if 1=2 then
	for each elto in request.Form
		%><li><%= elto %>: <%= request.Form(elto) %></li><%
	next 
end if %>
<div id="" class="container">
	<% if request.Form("presentacion")="" then %>
	<nav class="barraNav">
        <form action="/info/" method="post" name="frm_volver" style="display:inline-block;">
        	<input name="frmInfo_tipo" type="hidden" value="<%= request.Form("frmInfo_tipo") %>">
			<% if request.Form("frmInfo_tipo")="prop" then 
                %><input type="hidden" name="frmInfo_propietario" value="<%= request.Form("frmInfo_propietario") %>"><%
            else
                %><input type="hidden" name="frmInfo_busq" value="<%= request.Form("frmInfo_busq") %>"><%
            end if %>
            <% if request.Form("zoom")<>"" then %>
            	<input type="hidden" id="setcoords_zoom" name="zoom" value="<%= request.Form("zoom") %>"><% if request.Cookies("dev")<>"" then %>zoom: <%= request.Form("zoom") %><% end if %>
                <input type="hidden" id="setcoords_lat" name="lat" value="<%= request.Form("lat") %>"><% if request.Cookies("dev")<>"" then %>lat: <%= request.Form("lat") %><% end if %>
                <input type="hidden" id="setcoords_lng" name="lng" value="<%= request.Form("lng") %>"><% if request.Cookies("dev")<>"" then %>lng: <%= request.Form("lng") %><% end if %>
			<% end if %>
            <%
			informa = "<ul>"
			informa = informa & "<li>frmInfo_tipo: " & request.Form("frmInfo_tipo") & "</li>"
			if request.Form("frmInfo_tipo")="prop" then 
				informa = informa & "<li>frmInfo_propietario: " & request.Form("frmInfo_propietario") & "</li>"
			else
				informa = informa & "<li>frmInfo_busq: " & request.Form("frmInfo_busq") & "</li>"
			end if
			if request.Form("zoom")<>"" then
				informa = informa & "<li>zoom: " & request.Form("zoom") & "</li>"
				informa = informa & "<li>lat: " & request.Form("lat") & "</li>"
				informa = informa & "<li>lng: " & request.Form("lng") & "</li>"
			end if
			'informa = informa & "<li>" &  & "</li>"
			informa = informa & "</ul>"
			%>
	        <a class="btn blanco" onClick="javascript:frm_volver.submit();" <% if request.Cookies("dev")<>"" then %>data-toggle="popover" data-html="true" data-trigger="hover" data-content="<%= informa %>" data-placement="right" data-original-title="<%= url %>"<% end if %> >
               <span class="icon icon-arrow-left2"></span>
               <span class="lineLeft">Volver</span>
	        </a>
        </form>
        <% if request.Cookies("licencia")("u")="PW" or request.Cookies("licencia")("u")="JP" then %>
        <div class="btnsSiguiente">
            <a href="/info/informe/?id=<%= request.Form("id_edificio") %>" target="_blank" class="btn <% if rsInmueble("es_complejo") then %>disabled<% end if %>">Informe</a>
        </div>
        <% end if %>
    </nav>
	<% end if %>
<section id="s_inmueble" class="caja info"><!-- id = inmueble -->
    <div class="row">
    		<%
			select case request.Form("frmInfo_tipo")
			case "prop"
				miga = "Propietario Actual"
			case "edif"
				if isnull(rsInmueble("id_tipo_edificio")) then
					miga = "Edificio"
				else
					miga = rsInmueble("tipo_edificio")
				end if
			case "ni"
				if isnull(rsInmueble("id_tipo_edificio")) then
					miga = "Edificio"
				else
					miga = rsInmueble("tipo_edificio")
				end if
			case "hot"
				miga = "Hotel"
			case "cc"
				'miga = "Centro Comercial"
				if isnull(rsInmueble("id_tipo_edificio")) then
					miga = "Centro Comercial"
				else
					miga = rsInmueble("tipo_edificio")
				end if
			end select
			
			'if rsInmueble("id_tipo_inmueble")=1 then
				nombre = rsInmueble("nombre")
			'else
			'	nombre = rsInmueble("nombre_completo")
			'end if
    		%>
            <div class="col-sm-7">
            	<div class="miga">
					 <% if request.Cookies("dev")<>"" then %><span class="dev" style="float:right;">[<%= rsInmueble("id") %>]</span><% end if %>
                     <h2 class="tit_miga02"><%= miga %></h2>
				</div>
                <h1 class="heading"><span class="tipo">EDIFICIO </span><span class="nombreH"><%= nombre %></span></h1>
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
                            <li><span>A&ntilde;o Construcci&oacute;n :</span><span><%= rsInmueble("fecha_edif") %></span></li>
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
    
	
    <div class="row detalles">
		
        <div class="historico clearfix" id="historico_articulos">
            <%
			frm_url = "/info/inmueble/articulos.asp"
			if request.Form("presentacion")="informe" then frm_url = "/info/informe/articulos.asp"
			
			seltipo = request.Form("seltipo")
			%>
			<form method="POST" id="frm_resumen" name="frm_resumen" action="<%= frm_url %>" target="_blank">
				<input type="text" name="seltipo" value="<%= request.Form("seltipo") %>">
				<input type="text" name="frmInfo_tipo" value="<%= request.Form("frmInfo_tipo") %>">
				<input type="text" name="frmInfo_busq" value="<%= request.Form("frmInfo_busq") %>"><br />
				origen: <input type="text" name="origen" value="<%= request.Form("frmInfo_tipo") %>"><br />
				<% select case seltipo 
				case "inmueble" %>
					<input type="text" name="id_edificio" value="<%= rsInmueble("id") %>">
					<input type="text" name="edificio" value="<%= rsInmueble("nombre") %>">
					<input type="text" name="l" value="<%= rsInmueble("localidad") %>">
					<input type="text" name="calle" value="<%= rsInmueble("nombre_calle") %>">
					<input type="text" name="numerocalle" value="<%= rsInmueble("numero_calle") %>">
					<input type="text" name="d" value="<%= rsInmueble("dir1") %>">
					<% if not isnull(rsInmueble("id_complejo")) then %>	
						<input type="text" name="id_complejo" value="<%= rsInmueble("id_complejo") %>">
						<input type="text" name="complejo" value="<%= rsInmueble("complejo") %>">
					<% end if %>
				<% case "direccion" %>
					<input type="text" name="l" value="<%= request.Form("l") %>">
					<input type="text" name="tipovia" value="<%= request.Form("tipovia") %>">
					<input type="text" name="calle" value="<%= request.Form("calle") %>">
					<input type="text" name="numerocalle" value="<%= request.Form("numerocalle") %>">
					<input type="text" name="d" value="<%= request.Form("d") %>">
				<% case "zona" %>
					<input type="text" name="zona" value="<%= request.Form("zona") %>">
				<% end select %>
			
			<div class="cab">
				<h3>Archivo Hist&oacute;rico</h3>
			</div>
			
			<div class="col-sm-4">
			  <ul class="">
				<li class="operaciones">Operaciones:</li>
				<li>
				  <span class="num" data-content="op_alquiler"></span>
				  <input id="op_alquiler" name="op_alquiler" type="checkbox"/>
				  <label for="op_alquiler">Alquiler:</label>
				</li>
				<li>
				  <span class="num" data-content="op_inversion"></span>
				  <input id="op_inversion" name="op_inversion" type="checkbox"/>
				  <label for="op_inversion">Inversi&oacute;n:</label>
				</li>
			  </ul>
			</div>
			<div class="col-sm-4">
			  <ul class="ul2">
				<li>
				  <span class="num" data-content="noticias"></span>
				  <input id="noticias" name="noticias" type="checkbox"/>
				  <label  for="noticias">Noticias Inmobiliarias</label>
				</li>
				<li>
				  <span class="num" data-content="rumores"></span>
				  <input id="rumores" name="rumores" type="checkbox"/>
				  <label for="rumores">&quot;Web" ha o&iacute;do...: </label>
				</li>
				<li>
				  <span class="num" data-content="estudios"></span>
				  <input id="estudios" name="estudios" type="checkbox"/>
				  <label for="estudios">Estudios de Mercado</label>
				</li>
			  </ul>
			</div>
			
			
			<% if acceso_seccion then %>
					<div class="col-sm-4 bloqBotontes">
						<button style="display:none;" id="ver_articulos" type="submit" class="btn btnAzul" <% if request.Form("presentacion")="informe" then %>disabled="disabled"<% end if %>><span class="icon icon-arrow-right2"></span> Mostrar Articulos</button>
						<span id="loading"><img src="/img/ajax-loader.gif"><% if request.Cookies("dev")<>"" then %><br><a href="javascript:CargarHistorico();">cargar</a><% end if %></span>
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
'registro
'select case frmInfo_tipo
'case "prop"
'if session("pw_ws").accesoInfoEdificio then
select case rsInmueble("id_tipo_inmueble")
case 0
	inm_tipo = "edif"
case 1
	inm_tipo = "cc"
case 2
	inm_tipo = "hot"
end select
insert_reg_articulo inm_tipo, inm_tipo, rsInmueble("id")

rsInmueble.close
set rsInmueble=nothing

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
<script type="text/javascript">
function CargarHistorico() {
	$.ajax({
		type: "POST",
		url: "/info/inmueble/data/edificio.asp",
		data: $("#frm_resumen").serialize(),
		beforeSend: function() {
			//$("#cargar-articulos").hide();
			//$("#ver_articulos").hide();
			//$("#loading").fadeIn("slow");
		},
		success: function(recibe, txtStatus, jqSHR) {
			data = $.parseJSON(recibe);
			//console.log(recibe);
			
			$.each(data, function(tipo, valor) {
				console.log(tipo, valor);
				if (tipo=="not") { $("[data-content='noticias']").html(valor) };
				if (tipo=="rum") { $("[data-content='rumores']").html(valor) };
				if (tipo=="est") { $("[data-content='estudios']").html(valor) };
				
				if (tipo=="op_alq") { $("[data-content='op_alquiler']").html(valor) };
				if (tipo=="op_inv") { $("[data-content='op_inversion']").html(valor) };
				
			})
			
			$("#loading").hide();
			$("#ver_articulos").fadeIn("fast");
			
		}
	})
	
	<% 'if 1=2 then
	if request.Cookies("dev")("sql")<>"" then %>
	$.ajax({
		type: "POST",
		url: "/info/inmueble/data/edificio.asp",
		data: $("#frm_resumen").serialize() + "&informa=sql",
		dataType: "html",
		success: function(recibe, txtStatus, jqSHR) {
			//console.log(recibe)
			$("#informa_historico").html(recibe)
		}
	});
	<% end if %>
}

$(document).ready(function() { 
	CargarHistorico();
	
	$(".simplemodal").click(function(e) {
		var href = $(this).attr("href");
		$("#ModalBox").load(
			"/acceso/password.asp",
			href,
			function(recibe, textStatus, xhr) { $("#ModalBox").modal("show") }
		);
		return false;
		
	});
	
	
	$("#frm_resumen").ajaxForm({
		beforeSubmit: comprobarForm, 
		success: mostrarRespuesta,
	}) ; 
	
	function comprobarForm(){
		console.log("frm_resumen");
		var ErrSubmit="seleccione los art"+'\u00ed'+"culos que desea consultar";
		
		if (document.frm_resumen.noticias.checked) {ErrSubmit=""};
		if (document.frm_resumen.rumores.checked) {ErrSubmit=""};
		if (document.frm_resumen.estudios.checked) {ErrSubmit=""};
		if (document.frm_resumen.op_inversion.checked) {ErrSubmit=""};
		if (document.frm_resumen.op_alquiler.checked) {ErrSubmit=""};
		
		if (ErrSubmit=="") {
			$("#ver_articulos").hide();
			$("#loading").fadeIn("slow");
			//$("#div_result").fadeOut("fast");
		} else {
			$("#avisoForm").modal("show");
			//$("#ModalBox").load(
			//	"/articulos/nada_seleccionado.asp",
			//	function(recibe, textStatus, xhr) { $("#avisoForm").modal("show"); }
			//);
			//alert(ErrSubmit);
			return false;
		}
	};
	function mostrarRespuesta (responseText){ 
		console.log("mostrarRespuesta");
		console.log(responseText);
		
		$("#loading").hide();
		$("#ver_articulos").fadeIn("fast");
		$("#result").html(responseText);
		$("#div_result").fadeIn("slow");
		<% if request.Form("presentacion")="" then %>
			$.scrollTo("#s_titulos", 800);
		<% end if %>
	};
	
	//google.maps.event.addDomListener(window, "load", initialize);
	//initialize();
	
	$("#complejo").click(function(e) {
        $("#frmComplejo").submit();
		return false;
    });
	$(".detalles-complejo").click(function(e) {
		var id = $(this).attr("id");
		$("#frmEdif" + id).submit();
		return false;
    });
	
    
	<% if request.Form("presentacion")="informe" then %>
		$("#frm_resumen").submit()
	<% end if %>
	
	initMap();
	
	//historico_articulos
});
</script>
