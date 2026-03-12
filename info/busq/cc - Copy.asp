<%
'on error resume next
'variables globales
'Dim Actual Actual = CDate("01/01/2001") 

Actual = Now()
ActualYYYY=Year(Actual) 
ActualMM=Month(Actual) 
ActualYYYY2= (ActualYYYY * 100) + ActualMM
rtipo = "cc"
complejo_activo = 0

busqueda = trim(request.Form("frmInfo_busq"))
busqueda = replace(busqueda, "'", "''")

set rsBusq = Server.CreateObject("ADODB.Recordset")

var_tipo_busq = ""
var_titulo_busq = ""

counter = 0
session("origen")=""

if request.Cookies("dev")<>"" then %><div class="dev mini">
	<li>accesoInfoCentroComercial: <%= session("pw_ws").accesoInfoCentroComercial %></li>
	<li>acceso_seccion: [<%= acceso_seccion %>]</li>
	Form: &nbsp; <% 
	for each elto in request.Form 
		if request.Form(elto)<>"" then %>[<b><%= elto %></b> = <%= request.Form(elto) %>]&nbsp;<% end if 
	next %>
</div>
<% end if %>
<!--
<div class="miga">
     <h2 class="tit_miga02">Centro Comercial</h2>
</div>
-->
<div class="inm_tbl cabecera">
    <div class="inm_row">
        <div class="inm_contador"></div>
        <div class="inm_nombre"><span ><!--Direcci&oacute;n / Inmueble-->Nombre</span></div>
        <div class="inm_tipo"><span>Tipo</span></div>
        <div class="inm_ubic"><span>Localidad</span></div>
		<div class="inm_disp_total"><span></span></div>
		<div class="inm_disp_total"></div>
        <div class="inm_pais"><span>Pa&iacute;s</span></div>
    </div>
</div>
<div class="inm_tbl">
	<% 
	if recibe_paso <= 2 then 
		var_paso = 2	'inmuebles, semejantes	
		var_tipo_busq = "edif"
		var_titulo_busq = "inmuebles: Semejantes"
		call AbreRecordSetCC()
	end if
	
	if recibe_paso <= 4 then 
		var_paso = 4	'zonas semejantes	
		var_tipo_busq = "zona"
		var_titulo_busq = "zonas: Semejantes"
		call AbreRecordSetCC()
	end if
	
	if counter=0 then %>
		<div style="padding:10px; margin:2px;">
			<p>No se ha encontrado ninguna coincidencia.</p>
			<p>&nbsp;</p>
			<p>Depure la b&uacute;squeda.</p>
		</div><% 
	end if 
	
	if not session("pw_ws").accesoInfoCentroComercial then %>
		<br>
        <div class="alert azul" style="width:100%;">
            <div>
                <p>Se ha<% if counter>1 then %>n<% end if %> encontrado <strong><%= counter %>&nbsp;Centro<% if counter>1 then %>s<% end if %> Comercial<% if counter>1 then %>es<% end if %></strong>.</p>
                <hr>
                <% if request.Cookies("licencia")="" then %>
                    <p>El listado completo s&oacute;lo est&aacute; disponible para clientes.</p>
                    <p>Si quieres acceder a los contenidos, por favor, ponte en contacto con Property.</p>
                    <p style="margin-top:10px;"><a href="#" class="simplemodal">M&aacute;s informaci&oacute;n</a>.</p>
                    
                <% else 
                    if session("IniCliente")=0 then %>
                        <p>Para acceder al listado completo, <strong><%= request.Cookies("licencia")("u") %></strong> debe tener contratado <strong>Info-Centro Comercial</strong>.</p>
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
	<% end if %>
    
</div>
<% set rsBusq=nothing %>


<% sub LineaInmuebleCC() 

	select case var_tipo_busq
    case "edif" 
		data_id = rsBusq("id")
		c_fecha_edif=rsBusq("fecha_edif")
		dispo=rsBusq("disponible_superficie")

		if Not IsNull(rsBusq("fecha_edif")) then c_fecha_edif = rsBusq("fecha_edif") else  c_fecha_edif = 0 end if
		if Not IsNull(rsBusq("fecha_edifM")) then c_fecha_edifM = rsBusq("fecha_edifM") else  c_fecha_edifM = 0 end if
		c_fecha_edif = (c_fecha_edif * 100) + c_fecha_edifM

		if Not IsNull(rsBusq("fecha_renov")) then c_fecha_renov = rsBusq("fecha_renov") else  c_fec_fecha_renovcha_edif = 0 end if
		if Not IsNull(rsBusq("fecha_renovM")) then c_fecha_renovM = rsBusq("fecha_renovM") else  c_fecha_renovM = 0 end if
		c_fecha_renov = (c_fecha_renov * 100) + c_fecha_renovM


	case else
		data_id = ""
	end select
	%>
<div class="inm_row <% if var_tipo_busq="edif" then
		if isnull(rsBusq("lat")) then response.Write("pw-warning") end if 
	end if %>" 
	<% if c_fecha_edif>10000 or c_fecha_renov>10000  then 
	if c_fecha_edif>ActualYYYY2 or c_fecha_renov>ActualYYYY2 then  %> style="background-color:#CCCCCC;" <% end if 
	else 
	if c_fecha_edif>ActualYYYY or c_fecha_renov>ActualYYYY then  %> style="background-color:#CCCCCC;" <% end if 
	end if %>
					>
	<div class="inm_check">
<form class="pagsum_detalle" id="frm<%= counter %>" method="post" action="/info/centro/" data-id="<%= data_id %>">
	<input type="hidden" name="frmInfo_tipo" value="<%= frmInfo_tipo %>">
	<input type="hidden" name="frmInfo_busq" value="<%= frmInfo_busq %>">
    <input type="hidden" name="secc" value="cc">
    <input type="hidden" name="seltipo" value="<%= var_tipo_busq %>">
    <% select case var_tipo_busq
    case "edif" 
		if rsBusq("es_complejo") then
			complejo_activo = rsBusq("id")
		end if
		
		c_nombre = rsBusq("nombre")
		if not(isnull(rsBusq("tipo_edificio"))) and rsBusq("add_tipo_inmueble") then
			c_nombre = rsBusq("tipo_edificio") & "&nbsp;" & c_nombre
		end if
		if not(isnull(rsBusq("id_complejo"))) then
			'if not(isnull(rsBusq("tipo_edificio"))) and rsBusq("add_tipo_inmueble") then
			'	c_nombre = rsBusq("tipo_edificio") & "&nbsp;" & c_nombre
			'end if
			if rsBusq("id_complejo") = complejo_activo then
				c_nombre = "&nbsp;&nbsp;&nbsp;" & c_nombre
			else
				c_nombre = c_nombre & "&nbsp;<span class='padre'><b>(" & rsBusq("complejo") & ")</b></span>"
			end if
		end if
		
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
		
		if isnull(rsBusq("id_tipo_edificio")) then
			c_tipo = rsBusq("tipo_inmueble")
		else
			c_tipo = rsBusq("tipo_edificio")
		end if
		
		if rsBusq("id_tipo_inmueble")=0 then
			c_secc = rsBusq("seccion")
			if len(c_secc)>25 then 
				c_secc = "<acronym title='" & c_secc & "'>" & left(c_secc, 22) & "...</acronym>"
			end if
			c_tipo = c_secc
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
		end if %>
        <input type="hidden" name="id_edificio" value="<%= rsBusq("id") %>">
        <input type="hidden" name="edificio" value="<%= rsBusq("nombre_completo") %>">
        <input type="hidden" name="calle" value="<%= rsBusq("nombre_calle") %>">
        <input type="hidden" name="numerocalle" value="<%= rsBusq("numero_calle") %>">
        <input type="hidden" name="d" value="<%= rsBusq("dir1") %>">
        <input type="hidden" name="l" value="<%= rsBusq("localidad") %>">
        
    <% case "zona" 
        'c_nombre = rsBusq("dir4")
		c_nombre = rsBusq("nombre_zona")
        c_localidad = rsBusq("localidad")
		if len(c_localidad)>18 then
			c_localidad = "<acronym title='" & replace(c_localidad, "'", "&#39;") & "'>" & left(c_localidad, 15) & "...</acronym>"
		end if
		
        c_id = ""
		
		c_tipo = rsBusq("tipo_zona")
		if len(c_tipo)>14 then 
			c_tipo = "<acronym title='" & c_tipo & "'>" & left(c_tipo, 16) & "...</acronym>"
		end if
		
		if rsBusq("id_pais")=0 then
			bandera = false
		else
			bandera = true
			c_bandera = rsBusq("id_pais") & ".png"
		end if
		
		if request.Cookies("dev")<>"" then
			pop_title = rsBusq("nombre_zona")
			
			pop_content = "<table border='0' cellspacing='0' cellpadding='2'>"
			
			pop_content = pop_content & "<tr><td>zona:&nbsp;</td><td>" & rsBusq("nombre_zona") & "</td></tr>"
			
			'pop_content = pop_content & "<tr><td>tipo via</td><td>" & rsBusq("tipo_direccion") & "</td></tr>"
			
			pop_content = pop_content & "<tr style='border-bottom: 1px solid black;'><td colspan='2'></td></tr>"
			
			pop_content = pop_content & "<tr><td nowrap='nowrap'>tipo zona:&nbsp;</td><td nowrap='nowrap'>" & rsBusq("tipo_zona") & "</td></tr>"
			pop_content = pop_content & "<tr><td>l:&nbsp;</td><td>" & rsBusq("localidad") & "</td></tr>"
			pop_content = pop_content & "<tr><td nowrap='nowrap'>dir4:&nbsp;</td><td nowrap='nowrap'>" & rsBusq("dir4") & "</td></tr>"
			
			pop_content = pop_content & "</table>"
		end if %>
        <input type="hidden" name="zona" value="<%= rsBusq("nombre_zona") %>">
        
    <% end select %>
</form>
    </div>
<a href="/info/centro/" onclick="$('#frm<%= counter %>').submit();return false;" <% if request.Cookies("dev")<>"" then %>data-toggle="popover" data-trigger="hover" title="<%= pop_title %>" data-content="<%= pop_content %>" data-placement="bottom" data-html="true"<% end if %>>
    <div class="inm_contador"><% if request.Cookies("dev")<>"" then %><span class="dev"><%= counter %></span><% end if %></div>
    <div class="inm_nombre"><%= c_nombre %><% if request.Cookies("dev")<>"" and var_tipo_busq="edif" then %><span class="dev peq" style="margin-left:15px;"><%= rsBusq("id") %></span><% end if %></div>
    <div class="inm_tipo"><%= lcase(c_tipo) %></div>
    <div class="inm_ubic"><%= lcase(c_localidad) %></div>
	<div class="inm_disp_total"><span class="<% 
		'response.write("xxxDispo:" & dispo)
		if Not IsNull(dispo)  then 
		'response.write("xxxxDispo:" & dispo)
			if CInt(dispo)>=1 then
				 %>icon-checkbox-checked<%
			end if 
		end if  %>"></span></div>
	<div class="inm_disp_total"><% 
		if c_fecha_edif>10000 or c_fecha_renov>10000  then 
		if c_fecha_edif>ActualYYYY2 or c_fecha_renov>ActualYYYY2 then  %> &nbsp;<img src="/img/underc.png" width="25"/> <% end if 
		else 
		if c_fecha_edif>ActualYYYY or c_fecha_renov>ActualYYYY then  %> &nbsp;<img src="/img/underc.png" width="25"/> <% end if 
		end if
		 %></div>
    <div class="inm_pais"><% if bandera then %><img src="/img/paises/32/<%= c_bandera %>" height="14"/><% end if %></div>
</a>
</div>
<% end sub %>

<% sub AbreRecordSetCC() 	
	ids_actual = ids
	
	select case var_paso
	case 2	'inmuebles, semejante ó Dir. exacta	
		sqlw = "("
		sqlw = sqlw & "("
		sqlw = sqlw & "nombre COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI"
		sqlw = sqlw & " OR nombre_calc COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI"
		sqlw = sqlw & " OR nombre_completo COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI"
		sqlw = sqlw & " OR nombre_alt COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI"
		sqlw = sqlw & " OR localidad COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI"
		'sqlw = sqlw & ") OR ("
		sqlw = sqlw & ") "
		'sqlw = sqlw & "dir1 LIKE '%" & busqueda & "%' OR "
		'sqlw = sqlw & "dir2 COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI OR "
		'sqlw = sqlw & "dir3 COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI OR "
		'sqlw = sqlw & "dir4 COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI"
		'sqlw = sqlw & ")"
		sqlw = sqlw & ")"
		
		sqlw = sqlw & " AND "
		sqlw = sqlw & "id_tipo_inmueble=1"
		sqlw = sqlw & " AND (id_region IS NOT NULL AND id_region<>7)"
		
		sql = "SELECT * FROM dirs_w_inmuebles WHERE (" & sqlw & ") ORDER BY id_pais, id_provincia, id_localidad,  nombre_calc"
		'sql = "SELECT * FROM dirs_w_inmuebles WHERE (" & sqlw & ") ORDER BY id_pais, id_provincia, id_localidad, complejo_orden, es_complejo DESC, nombre"
		
		sql_datos = "SELECT * FROM dirs_w_inmuebles WHERE (" & sqlw & ")"
		%>
		<script>
			datos = <%= QueryToJSON(session("connPW"), sql_datos).Flush %>;
			//console.log("[< %= sql_datos %>]")
		</script>
		<%
	case 4	'zonas semejantes	
		sqlw = "("
		sqlw = sqlw & "nombre_zona COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI AND "	' AND id_tipo_zona=3)"
		sqlw = sqlw & "id_tipo_zona IN (3, 9)"
		
		if ids<>"" then 
			sqlw = sqlw & " AND id_edificio NOT IN (" & ids & ")"
		end if
		sqlw = sqlw & ")"
		
		if sw_edif then
			sqlw = sqlw & " AND NOT ("
			sqlw = sqlw & "(dir2 COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI "
			sqlw = sqlw & "OR dir3 COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI) "
			sqlw = sqlw & "AND (numero_calle IS NOT NULL AND numero_calle<>'')"
		sqlw = sqlw & ")"	
		end if
		
		sqlg = "GROUP BY dir4, localidad, id_tipo_zona, tipo_zona, nombre_zona, id_pais, pais"
		
		sql = "SELECT dir4, localidad, id_tipo_zona, tipo_zona, nombre_zona, id_pais, pais "
		' estaba asi: 
		sql = sql & "FROM dirs_w WHERE (" & sqlw & ") " & sqlg & " ORDER BY dir4"
		'sql = sql & "FROM dirs_w_inmuebles WHERE (" & sqlw & ") " & sqlg & " ORDER BY dir4"
		
	end select
	
	if request.Cookies("dev")<>"" then
		%><div style="font-size:12px; border-top: 1px solid red; margin:2px 0;"><a href="#" onclick="$('#sql<%= var_paso %>').slideToggle('fast'); return false;">
			<strong>paso: <%= var_paso %></strong> &nbsp; <%= var_titulo_busq %>
			<span class="peq" style="float:right;"><span id="timer<%= var_paso %>">0</span> ms</span></a>
			<div id="sql<%= var_paso %>" style="display:none; margin:6px 0 0 6px; border:#CCC 1px solid; font-size:9px"><%= sql %></div>
		</div><% 	
	end if
	
	rsBusq.open sql, session("connPW")
	
	do while not rsBusq.eof 
		select case var_paso
		case 2
			if ids<>"" then ids=ids & ", "
			ids = ids & rsBusq("id")
		end select
		
		counter = counter + 1
		if session("pw_ws").accesoInfoCentroComercial then
			call LineaInmuebleCC()
		end if
		
		rsBusq.movenext
	loop
	
	rsBusq.close
	
end sub %>
