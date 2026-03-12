<%
'on error resume next
'Dim Actual Actual = CDate("01/01/2001") 

Actual = Now()
ActualYYYY=Year(Actual) 
ActualMM=Month(Actual) 
ActualYYYY2= (ActualYYYY * 100) + ActualMM
'Response.Write "Actual2:" & ActualYYYY2
busqueda = trim(request.Form("frmInfo_busq"))
busqueda = replace(busqueda, "'", "''")

set rsBusq = Server.CreateObject("ADODB.Recordset")

counter = 0

if request.Cookies("dev")<>"" then %>
<div class="dev mini">
	<li>accesoInfoHotel: <%= session("pw_ws").accesoInfoHotel %></li>
    <li>acceso_seccion: <%= acceso_seccion %></li>
	Form: &nbsp; <% 
	for each elto in request.Form 
		if request.Form(elto)<>"" then %>[<b><%= elto %></b> = <%= request.Form(elto) %>]&nbsp;<% end if 
	next %>
</div>
<% end if
%>
<!--<div class="miga"><h2 class="tit_miga02">Hotel</h2></div>-->
<div class="inm_tbl cabecera">
    <div class="inm_row">
        <div class="inm_contador"></div>
        <div class="inm_nombre"><span >Direcci&oacute;n / Inmueble</span></div>
		<div class="inm_tipo"><span>Tipo</span></div>
		<div class="inm_ubic"><span>Localidad</span></div>
		<div class="inm_tipo"><span></span></div>
        <div class="inm_pais"><span>Pa&iacute;s</span></div>
    </div>
</div>
<%
sqlw = sqlw & "("
sqlw = sqlw & "("
sqlw = sqlw & "(nombre COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI"
sqlw = sqlw & " OR nombre_completo COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI"
sqlw = sqlw & " OR nombre_calc COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI"
sqlw = sqlw & " OR nombre_alt COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI"
sqlw = sqlw & " OR localidad COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI"
sqlw = sqlw & ")"
sqlw = sqlw & " OR ("
sqlw = sqlw & "dir2 COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI OR "
sqlw = sqlw & "dir3 COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI OR "
sqlw = sqlw & "dir4 COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI)"
sqlw = sqlw & ")"

sqlw = sqlw & " AND id_tipo_inmueble=2"

sqlw = sqlw & " AND (id_region IS NOT NULL AND id_region<>7)"

sqlw = sqlw & ")"

if request.Cookies("dev")<>"" then
	%><div id="sql" style="font-size:10px"><%= sqlw %></div><% 	
end if

sql_datos = "SELECT * FROM dirs_w_inmuebles WHERE (" & sqlw & ")"
%>
<div class="inm_tbl">
	<% if session("pw_ws").accesoInfoHotel then
		sql = "SELECT * FROM dirs_w_inmuebles WHERE (" & sqlw & ") ORDER BY id_pais, localidad, nombre_calle, numero_calle_ord, numero_calle, nombre_completo"
		rsBusq.open sql, session("connPW")
		
		do while not rsBusq.eof 
			counter = counter + 1
			'c_fecha_edif=rsBusq("fecha_edif")
			c_fecha_edif = 0
			if Not IsNull(rsBusq("fecha_edif")) then c_fecha_edif = rsBusq("fecha_edif") else  c_fecha_edif = 0 end if
			if Not IsNull(rsBusq("fecha_edifM")) then c_fecha_edifM = rsBusq("fecha_edifM") else  c_fecha_edifM = 0 end if
			c_fecha_edif = (c_fecha_edif * 100) + c_fecha_edifM
			c_fecha_renov = 0
			if Not IsNull(rsBusq("fecha_renov")) then c_fecha_renov = rsBusq("fecha_renov") else  c_fec_fecha_renovcha_edif = 0 end if
			if Not IsNull(rsBusq("fecha_renovM")) then c_fecha_renovM = rsBusq("fecha_renovM") else  c_fecha_renovM = 0 end if
			c_fecha_renov = (c_fecha_renov * 100) + c_fecha_renovM

			c_nombre = rsBusq("nombre_completo")
			
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
			
			c_tipo = rsBusq("tipo_inmueble")
			
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
			
			if isnull(rsBusq("lat")) then
				row_class = "pw-warning"
			else
				row_class = ""
			end if
			
			data_id = rsBusq("id")
			%>
			<div class="inm_row <%= row_class %>" 
				<% if c_fecha_edif>10000 or c_fecha_renov>10000  then 
				if c_fecha_edif>ActualYYYY2 or c_fecha_renov>ActualYYYY2 then  %> style="background-color:#CCCCCC;" <% end if 
				else 
				if c_fecha_edif>ActualYYYY or c_fecha_renov>ActualYYYY then  %> style="background-color:#CCCCCC;" <% end if 
				end if  %> >
				<div class="inm_check">
					<form class="pagsum_detalle" id="frm<%= counter %>" method="post" action="/info/hotel/" data-id="<%= data_id %>">
						<input type="hidden" name="frmInfo_tipo" value="hot">
						<input type="hidden" name="frmInfo_busq" value="<%= frmInfo_busq %>">
						<input type="hidden" name="secc" value="hot">
						<input type="hidden" name="seltipo" value="edif">
						<input type="hidden" name="id_edificio" value="<%= rsBusq("id") %>">
						<!--
						<input type="hidden" name="edificio" value="< %= rsBusq("nombre_completo") %>">
						<input type="hidden" name="calle" value="< %= rsBusq("nombre_calle") %>">
						<input type="hidden" name="numerocalle" value="< %= rsBusq("numero_calle") %>">
						<input type="hidden" name="d" value="< %= rsBusq("dir1") %>">
						<input type="hidden" name="l" value="< %= rsBusq("localidad") %>">
						-->
					</form>
				</div>
				<a href="inmueble" onclick="$('#frm<%= counter %>').submit();return false;" <% if request.Cookies("dev")<>"" then %>data-toggle="popover" data-trigger="hover" title="<%= pop_title %>" data-content="<%= pop_content %>" data-placement="bottom" data-html="true"<% end if %>>
					<div class="inm_contador"><%= counter %></div>
					<div class="inm_nombre"><%= c_nombre %></div>
					<div class="inm_tipo"><%= lcase(c_tipo) %></div>
					<div class="inm_ubic"><%= lcase(c_localidad) %></div>
					<div class="inm_tipo"><% 
						if c_fecha_edif>10000 or c_fecha_renov>10000  then 
						if c_fecha_edif>ActualYYYY2 or c_fecha_renov>ActualYYYY2 then  %> &nbsp;<img src="/img/underc.png" width="25"/> <% end if 
						else 
						if c_fecha_edif>ActualYYYY or c_fecha_renov>ActualYYYY then  %> &nbsp;<img src="/img/underc.png" width="25"/> <% end if 
						end if  %>
						</div>
					<div class="inm_pais"><% if bandera then %><img src="/img/paises/32/<%= c_bandera %>" height="14"/><% end if %></div>
				</a>
			</div>
			<% rsBusq.movenext
		loop
		
		rsBusq.close
		
		if counter=0 then %>
            <div style="padding:10px; margin:2px;">
                <p>No se ha encontrado ninguna coincidencia.</p>
                <p>&nbsp;</p>
                <p>Depure la b&uacute;squeda.</p>
            </div><% 
        end if
		
		session("origen")=""
		
	else
		sql = "SELECT COUNT(*) AS nn FROM dirs_w_inmuebles WHERE " & sqlw
		rsBusq.open sql, session("connPW")
		nn = rsBusq("nn")
		%>
        <br>
        <div class="alert azul" style="width:100%;">
            <div>
                <p>Se ha<% if nn>1 then %>n<% end if %> encontrado <strong><%= nn %>&nbsp;hotel<% if nn>1 then %>es<% end if %></strong>.</p>
                <hr>
                <% if request.Cookies("licencia")="" then %>
                    <p>El listado completo s&oacute;lo est&aacute; disponible para clientes.</p>
                    <p>Si quieres acceder a los contenidos, por favor, ponte en contacto con Property.</p>
                    <p style="margin-top:10px;"><a href="#" class="simplemodal">M&aacute;s informaci&oacute;n</a>.</p>
                    
                <% else 
                    if session("IniCliente")=0 then %>
                        <p>Para acceder al listado completo, <strong><%= request.Cookies("licencia")("u") %></strong> debe tener contratado <strong>Info-Hotel</strong>.</p>
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
<%
set rsBusq=nothing 
%>
<script>
	inmuebles = <%= QueryToJSON(session("connPW"), sql_datos).Flush %>;
</script>