<%
'on error resume next
'Dim Actual Actual = CDate("01/01/2001") 

Actual = Now()
ActualYYYY=Year(Actual) 
ActualMM=Month(Actual) 
ActualYYYY2= (ActualYYYY * 100) + ActualMM
id_propietario = request.Form("frmInfo_propietario")
propietario = request.Form("frmInfo_propietario_nombre")

if id_propietario="" then 
	if request.Cookies("dev")="" then response.Redirect("/")
	response.Write("<p>falta propietario</p>")
	response.Write("[" & id_propietario & "]")
end if
'complejo_activo = 0
sqlw = "id IN ("
sqlw = sqlw & "SELECT id_inmueble FROM inmuebles_agentes WHERE id_empresa=" & id_propietario
sqlw = sqlw & " AND tipo='prop' AND fecha_hasta IS NULL"
sqlw = sqlw & ")"

sql_datos = "SELECT * FROM dirs_w_inmuebles WHERE " & sqlw
%>
<script>
	inmuebles = <%= QueryToJSON(session("connPW"), sql_datos).Flush %>;
	//console.log("[< %= sql_datos %>]")
</script>
<div class="miga">
     <h2 class="tit_miga02">Propietario Actual <%= propietario %></h2>
</div>
<% 'if session("pw_ws").accesoInfoPropietario then %>
<div class="inm_tbl cabecera">
    <div class="inm_row">
        <div class="inm_contador"></div>
        <div class="inm_nombre"><span >Direcci&oacute;n / Inmueble</span></div>
        <div class="inm_tipo"><span>Tipo</span></div>
        <div class="inm_ubic"><span>Localidad</span></div>
		<div class="inm_disp_total"><span>disponibilidad</span></div>
		<div class="inm_disp_total"></div>
        <div class="inm_pais"><span>Pa&iacute;s</span></div>
    </div>
</div>
<% 'end if %>
<% if request.Cookies("dev")("sql")<>"" then %>
<div class="dev peq" id="sql" style="display:znone; margin:6px 0 0 6px;"><%= sqlw %></div>
<% end if %>
<div class="inm_tbl">
	<% if session("pw_ws").accesoInfoPropietario then
		sql = "SELECT * FROM dirs_w_inmuebles WHERE (" & sqlw & ") ORDER BY  id_pais, id_seccion, nombre_calc "
		rsBusq.open sql, session("connPW")
		
		do while not rsBusq.eof 
			counter = counter + 1
			if isnull(rsBusq("lat")) then
				row_class = "pw-warning"
			else
				row_class = ""
			end if
			c_fecha_edif=rsBusq("fecha_edif")
			dispo=rsBusq("disponible_superficie")

	' NUEVA PARTE DE CALCULAR CNOMBRE
		if rsBusq("es_complejo") then
			complejo_activo = rsBusq("id")
		end if
		
		if isnull(rsBusq("id_tipo_edificio")) then
			c_nombre = "" & rsBusq("dir1")
		
			if trim(c_nombre) = "" then		'OR isnull(c_nombre) then
				c_nombre = rsBusq("nombre_completo")
				'nuevo abajo
				if rsBusq("es_complejo") then
					c_nombre = "<b>" & rsBusq("nombre_completo") & "</b>"
				end if	
			else
				'if instr(c_nombre, rsBusq("nombre_completo"))=0 then
				'	c_nombre = c_nombre & ", " & rsBusq("nombre_completo")
				'end if
				if instr(c_nombre, rsBusq("nombre"))=0 or len(rsBusq("nombre"))<4 then
					c_nombre = c_nombre & ", " & rsBusq("nombre")
				end if
				'nuevo abajo
				if rsBusq("es_complejo") then
					c_nombre = "<b>" & c_nombre & ", " & rsBusq("nombre") & "</b>"
				end if	
			end if
		
		else
			c_nombre = rsBusq("nombre")
				'nuevo abajo
				if rsBusq("es_complejo") then
					c_nombre = "<b>" & rsBusq("nombre") & "</b>"
				end if				
			if rsBusq("tipo_edificio_add_to_name") then
				'esto d abajo se quita
				if instr(c_nombre, rsBusq("tipo_edificio"))=0 then
					'c_nombre = rsBusq("tipo_edificio") & "&nbsp;" & c_nombre
						'nuevo abajo
						if rsBusq("es_complejo") then
							c_nombre = "<b>" & rsBusq("tipo_edificio") & "&nbsp;" & c_nombre & "</b>"
						else
							c_nombre = rsBusq("tipo_edificio") & "&nbsp;" & c_nombre
						end if	
				end if

				'esto de abajo se pone
				'c_nombre = rsBusq("tipo_edificio") & "&nbsp;" & c_nombre
			end if
		end if
		
		if not(isnull(rsBusq("id_complejo"))) then
			'c_nombre = "&nbsp;&nbsp;&nbsp;" & c_nombre
			if rsBusq("id_complejo") = complejo_activo then
				c_nombre = "&nbsp;&nbsp;&nbsp;" & c_nombre 
			else
				complejo_activo = rsBusq("id_complejo")
				'c_nombre = rsBusq("complejo") & " " & c_nombre
				if InStr(c_nombre,rsBusq("complejo"))<>0 then
					 c_nombre=Replace(c_nombre,rsBusq("complejo"),"")
				end if
				c_nombre = "&nbsp;<span class='padre'><b>" & rsBusq("complejo") & "</b></span><br>&nbsp;&nbsp;&nbsp;" & c_nombre  
			end if
		end if
	'FIN NUEVA PARTE		
			c_localidad = rsBusq("localidad")
			if len(c_localidad)>18 then
				c_localidad = "<acronym title='" & replace(c_localidad, "'", "&#39;") & "'>" & left(c_localidad, 15) & "...</acronym>"
			end if
			
			c_id = rsBusq("id")
			
			if isnull(rsBusq("id_pais")) or rsBusq("id_pais")=0 then
				bandera = false
			else
				bandera = true
				c_bandera = rsBusq("id_pais") & ".png"
			end if
			'c_tipo = rsBusq("tipo_inmueble")
			if rsBusq("id_tipo_inmueble")=1 then
				if isnull(rsBusq("id_tipo_edificio")) then
					c_tipo = rsBusq("tipo_inmueble")
				else
					c_tipo = rsBusq("tipo_edificio")
				end if
			else
				c_tipo = rsBusq("tipo_inmueble")
			end if
			
			if rsBusq("id_tipo_inmueble")=0 then
				c_secc = rsBusq("seccion")
				if len(c_secc)>25 then 
					c_secc = "<acronym title='" & c_secc & "'>" & left(c_secc, 22) & "...</acronym>"
				end if
				c_tipo = c_secc
			end if
			
			c_disp_fecha = "" & rsBusq("disponible_fecha")
			if acceso_seccion then 
				if c_disp_fecha = "" then
					c_disponibilidad = ""
				else
					c_disponibilidad = "icon-checkbox-checked"
				end if
			else
				c_disponibilidad = "icon-lock"
			end if
			
			if request.Cookies("dev")<>"" then
				pop_title = rsBusq("nombre_completo")
				
				pop_content = "<table border='0' cellspacing='0' cellpadding='2' width='100%'>"
				'pop_content = rsBusq("nombre_completo") & "<br>"
				
				pop_content = pop_content & "<tr><td>id:&nbsp;</td><td>" & rsBusq("id") & "</td></tr>"
				pop_content = pop_content & "<tr><td>calle:&nbsp;</td><td>" & rsBusq("nombre_calle") & "</td></tr>"
				pop_content = pop_content & "<tr><td>n&deg;:&nbsp;</td><td>" & rsBusq("numero_calle") & "</td></tr>"
				pop_content = pop_content & "<tr><td>d:&nbsp;</td><td>" & rsBusq("dir1") & "</td></tr>"
				pop_content = pop_content & "<tr><td>l:&nbsp;</td><td>" & rsBusq("localidad") & "</td></tr>"
				
				pop_content = pop_content & "<tr style='border-bottom: 1px solid black;'><td colspan='2'></td></tr>"
				
				pop_content = pop_content & "<tr><td nowrap='nowrap'>tipo via:&nbsp;</td><td nowrap='nowrap'>" & rsBusq("tipo_direccion") & "</td></tr>"
				pop_content = pop_content & "<tr><td nowrap='nowrap'>dir2:&nbsp;</td><td nowrap='nowrap'>" & rsBusq("dir2") & "</td></tr>"
				pop_content = pop_content & "<tr><td nowrap='nowrap'>dir3:&nbsp;</td><td nowrap='nowrap'>" & rsBusq("dir3") & "</td></tr>"
				
				pop_content = pop_content & "</table>"
			end if
			
			select case rsBusq("id_tipo_inmueble")
			case 0
				url = "/info/edificio/"
			case 1
				url = "/info/centro/"
			case 2
				url = "/info/hotel/"
			end select
			
			data_id = rsBusq("id")
			%>
            <div class="inm_row <%= row_class %>"
					<% if c_fecha_edif>10000 then 
					if c_fecha_edif>ActualYYYY2 then  %> style="background-color:#CCCCCC;" <% end if 
					else 
					if c_fecha_edif>ActualYYYY then  %> style="background-color:#CCCCCC;" <% end if 
					end if %>
				>
                <div class="inm_check">
                    <form class="pagsum_detalle" id="frm<%= counter %>" method="post" action="<%= url %>" data-id="<%= data_id %>">
                        <input type="hidden" name="frmInfo_tipo" value="prop<%'= frmInfo_tipo %>">
                        <input type="hidden" name="frmInfo_propietario" value="<%= frmInfo_propietario %>">
                        <input type="hidden" name="seltipo" value="edif">
                        <input type="hidden" name="id_edificio" value="<%= rsBusq("id") %>">
                        <input type="hidden" name="origen" value="edif:<%= rsBusq("id") %>">
                        <input type="hidden" name="secc" value="prop">
                        <input type="hidden" name="tipoedificio" value="<%= rsBusq("id_tipo_inmueble") %>">
                        
                        <!--
                        <input type="hidden" name="edificio" value="< %= rsBusq("nombre_completo") %>">
                        <input type="hidden" name="calle" value="< %= rsBusq("nombre_calle") %>">
                        <input type="hidden" name="numerocalle" value="< %= rsBusq("numero_calle") %>">
                        <input type="hidden" name="d" value="< %= rsBusq("dir1") %>">
                        <input type="hidden" name="l" value="< %= rsBusq("localidad") %>">
                        -->
                    </form>
                </div>
                <a href="<%= url %>" onclick="$('#frm<%= counter %>').submit();return false;" <% if request.Cookies("dev")<>"" then %>data-toggle="popover" data-trigger="hover" title="<%= pop_title %>" data-content="<%= pop_content %>" data-placement="bottom" data-html="true"<% end if %>>
                    <div class="inm_contador"><%= counter %></div>
                    <div class="inm_nombre"><%= c_nombre %></div>
                    <div class="inm_tipo"><%= lcase(c_tipo) %></div>
                    <div class="inm_ubic"><%= lcase(c_localidad) %></div>
					<div class="inm_disp_total"><span class="<%= c_disponibilidad %>"></span></div>
					<div class="inm_disp_total">
						<% if c_fecha_edif>10000 then 
						if c_fecha_edif>ActualYYYY2 then  %> &nbsp;<img src="/img/underc.png" width="25"/> <% end if 
						else 
						if c_fecha_edif>ActualYYYY then  %> &nbsp;<img src="/img/underc.png" width="25"/> <% end if 
						end if %>
					</div>
                    <div class="inm_pais"><% if bandera then %><img src="/img/paises/32/<%= c_bandera %>" height="14"/><% end if %></div>
                </a>
            </div>
			<% rsBusq.movenext
        loop
    	
		rsBusq.close
		
		session("origen")=""
        insert_reg_articulo "prop", "empr", request.form("frmInfo_propietario")
		
    else 
		sql = "SELECT COUNT(*) AS nn FROM inmuebles WHERE " & sqlw
		rsBusq.open sql, session("connPW")
		nn = rsBusq("nn")
		%>
        <br>
        <div class="alert azul" style="width:100%;">
            <div>
                <p>Se ha<% if nn>1 then %>n<% end if %> encontrado <strong><%= nn %>&nbsp;inmueble<% if nn>1 then %>s<% end if %></strong>.</p>
                <hr>
                <% if request.Cookies("licencia")="" then %>
                    <p>El listado completo s&oacute;lo est&aacute; disponible para clientes.</p>
                    <p>Si quieres acceder a los contenidos, por favor, ponte en contacto con Property.</p>
                    <p style="margin-top:10px;"><a href="#" class="simplemodal">M&aacute;s informaci&oacute;n</a>.</p>
                    
                <% else 
                    if session("IniCliente")=0 then %>
                        <p>Para acceder al listado completo, <strong><%= request.Cookies("licencia")("u") %></strong> debe tener contratado <strong>Info-Propietario</strong>.</p>
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
		<% 
		rsBusq.close
	end if %>
</div>