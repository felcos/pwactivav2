<% 
'on error resume next

'if request.form("id_edificio")="" then response.Redirect("/info/") 

rId = request.form("id_edificio")

'response.Write(request.Form)
'response.End()

sec_actual = "/info/"

Actual = Now()
ActualYYYY=Year(Actual) 
ActualMM=Month(Actual) 
ActualYYYY2= (ActualYYYY * 100) + ActualMM

dim supSR
dim supBR

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

<div class="row">
    <%
    'if rsInmueble("id_tipo_inmueble")=1 then
        nombre = rsInmueble("nombre")
    'else
    '	nombre = rsInmueble("nombre_completo")
    'end if
	if request.Form("secc")="prop" then
		nombre = rsInmueble("tipo_edificio") & " " & nombre
	end if
    %>
    <div class="col-sm-7">
        <!--#include virtual="/info/inc/miga.asp" -->
        <h1 class="heading"><span class="tipo">EDIFICIO </span><span class="nombreH"><%= nombre %></span></h1>
        <% if not(isnull(rsInmueble("id_complejo"))) then 
            set rsCompl = Server.CreateObject("ADODB.Recordset")
            sql = "SELECT * FROM c_inmuebles WHERE id=" & rsInmueble("id_complejo")
            rsCompl.Open sql, session("connPW")
			
			select case rsCompl("id_tipo_inmueble")
			case 0
				action = "/info/edificio/"
			case 1
				action = "/info/centro/"
			case 2
				action = "/info/hotel/"
			end select
            %>
            <p class="parqueInfo">
            <form class="pagsum_detalle" id="frmComplejo" method="post" action="<%= action %>">
                <input type="hidden" name="frmInfo_tipo" value="<%= request.Form("frmInfo_tipo") %>">
                <% if request.Form("frmInfo_tipo")="prop" then %>
                	<input type="hidden" name="frmInfo_propietario" value="<%= request.Form("frmInfo_propietario") %>">
				<% else %>
                	<input type="hidden" name="frmInfo_busq" value="<%= request.Form("frmInfo_busq") %>">
				<% end if %>
                <input type="hidden" name="seltipo" value="edif">
                <input type="hidden" name="id_edificio" value="<%= rsCompl("id") %>">
                <input type="hidden" name="secc" value="<%= request.Form("secc") %>">
                <!--
                <input type="hidden" name="edificio" value="< %= rsCompl("nombre") %>">
                <input type="hidden" name="calle" value="< %= rsCompl("nombre_calle") %>">
                <input type="hidden" name="numerocalle" value="< %= rsCompl("numero_calle") %>">
                <input type="hidden" name="d" value="< %= rsCompl("dir1") %>">
                <input type="hidden" name="l" value="< %= rsCompl("localidad") %>">
                -->
            </form>
            <% if not isnull(rsCompl("id_tipo_edificio")) then %><span><%= rsCompl("tipo_edificio") %>: </span> <% end if %>
             <a href="#" id="complejo" onclick="$('#frmComplejo').submit();"><%= rsCompl("nombre") %></a>
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
<%
insert_reg_articulo request.Form("secc"), "edif", rsInmueble("id")
%>
<script>
$(document).ready(function() { 
	initMap();
})
</script>