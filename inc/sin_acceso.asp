<% 
public sub SinAccesoN(pSeccion, byRef pRS) 
	select case pSeccion
	case "empr"
		seccion = "Info-Empresas" 
		
		%>
        <br>
        <div class="alert azul" style="width:100%;">
            <div>
                <p>Se ha<% if counter>1 then %>n<% end if %> encontrado <% if pRS("nn")>1 then %>un total de <% end if %><strong><%= pRS("nn") %> empresas</strong>.</p>
                <hr>
                <% if request.Cookies("licencia")="" then %>
                    <p>El listado completo de s&oacute;lo est&aacute; disponible para <strong>clientes</strong>.</p>
                    <p>Si quieres acceder a los contenidos, por favor, ponte en contacto con Property.</p>
                    <p style="margin-top:10px;"><a href="#" class="simplemodal">M&aacute;s informaci&oacute;n</a>.</p>
                    
                <% else 
                    if ini=0 then %>
                        <p>Para acceder a los contenidos <strong><%= request.Cookies("licencia")("u") %></strong> debe tener contratada la secci&oacute;n <strong>Info-Empresas</strong>.</p>
                        <p>Puedes ponerte en contacto con <strong>PropertyWeb</strong> llamando al <strong>914.295.143</strong>.</p>
                        
                    <% else %>
                        <p>Tu ordenador ha sido identificado por PROPERTY WEB pero tu licencia no es v&aacute;lida.</p>
                        <p>Para acceder a los contenidos debes disponer de una licencia v&aacute;lida.</p>
                        <p style="margin-top:10px;"><a href="#" class="simplemodal">M&aacute;s informaci&oacute;n</a>.</p>
                        
                    <% end if %>
                <% end if %>
                <br>
            </div>
        </div>
        <div style="clear:both !important;"></div>
	
	<% case else 
		'counter = counter + pRS("nn")
		select case pSeccion
		case "edif"
			if counter=1 then
				ver_tipo = "edificio o direcci&oacute;n"
			else
				ver_tipo = "edificios y direcciones"
			end if
			
		case "hot"
			if counter=1 then
				ver_tipo = "hotel"
			else
				ver_tipo = "hoteles"
			end if 
			
		case "cc"
			if counter=1 then
				ver_tipo = "centro comercial"
			else
				ver_tipo = "centros comerciales"
			end if 
		end select %>
        <br>
        <div class="alert azul" style="width:100%;">
            <div>
                <p>Se ha<% if counter>1 then %>n<% end if %> encontrado <% if counter>1 then %>un total de <% end if %><strong><%= counter %>&nbsp;<%= ver_tipo %></strong>.</p>
                <hr>
                <% if request.Cookies("licencia")="" then %>
                    <p>El listado completo s&oacute;lo est&aacute; disponible para clientes.</p>
                    <p>Si quieres acceder a los contenidos, por favor, ponte en contacto con Property.</p>
                    <p style="margin-top:10px;"><a href="#" class="simplemodal">M&aacute;s informaci&oacute;n</a>.</p>
                    
                <% else 
                    if ini=0 then %>
                        <p>Para acceder a los contenidos <strong><%= request.Cookies("licencia")("u") %></strong> debe tener contratado <strong>Info-Inmuebles</strong>.</p>
                        <p>Puedes ponerte en contacto con <strong>PropertyWeb</strong> llamando al <strong>914.295.143</strong>.</p>
                        
                    <% else %>
                        <p>Tu ordenador ha sido identificado por PROPERTY WEB pero tu licencia no es v&aacute;lida.</p>
                        <p>Para acceder a los contenidos debes disponer de una licencia v&aacute;lida.</p>
                        <p style="margin-top:10px;"><a href="#" class="simplemodal">M&aacute;s informaci&oacute;n</a>.</p>
                        
                    <% end if %>
                <% end if %>
                <br>
            </div>
        </div>
        <div style="clear:both !important;"></div>
		
	<% end select
end sub
%>