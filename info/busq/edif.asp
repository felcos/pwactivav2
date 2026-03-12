<%
'on error resume next
'variables globales
'Dim Actual Actual = CDate("01/01/2001") 


Actual = Now()
ActualYYYY=Year(Actual) 
ActualMM=Month(Actual) 
ActualYYYY2= (ActualYYYY * 100) + ActualMM




busqueda = trim(request.Form("frmInfo_busq"))
rtipo = request.Form("frmInfo_tipo")
id_propietario = request.Form("frmInfo_propietario")

sw_disponibilidad = false

'tipo busqueda	
if rtipo = "" then
	'response.Write("<p>falta tipo</p>")
	response.Redirect("/")
	
else
	select case rtipo
	case "edif", "disp", "prop"
		sw_disponibilidad = true
	end select
	
end if

complejo_activo = 0

'busqueda
if id_propietario="" and rtipo="prop" then 
	if request.Cookies("dev")="" then response.Redirect("/")
	response.Write("<p>falta propietario</p>")
end if

busqueda = replace(busqueda, "'", "''")

'nacional/internacional	
sw_nac = true

set rsBusq = Server.CreateObject("ADODB.Recordset")

if session("informa")="" then
	if request.Cookies("dev")="" then
		informa = false
	else
		informa = true
	end if
else
	informa = session("informa")
end if

var_paso = 0
var_tipo_busq = ""
var_titulo_busq = ""
var_hay_mas = false

counter = 0
ids = ""
recibe_paso=0
recibe_offset = 0

if informa then 
	'if request.Cookies("dev")("request")<>"" then %>
    <div class="dev mini">
    	Form (busq_edif.asp): &nbsp; <% 
		for each elto in request.Form 
        	if request.Form(elto)<>"" then %>[<b><%= elto %></b> = <%= request.Form(elto) %>]&nbsp;<% end if 
	    next %>
    </div>
	<% 'end if
end if 

frmInfo_tipo = request.form("frmInfo_tipo")	
frmInfo_busq = request.form("frmInfo_busq")

miga = "Edificio o Direcci&oacute;n"
%>
<div class="miga"> 
     <h2 class="tit_miga02"><%= miga %></h2>
</div>
<div class="inm_tbl cabecera">
    <div class="inm_row">
        <div class="inm_contador"></div>
        <div class="inm_nombre"><span >Direcci&oacute;n / Inmueble</span></div>
        <div class="inm_tipo"><span>Tipo</span></div>
        <div class="inm_ubic"><span>Localidad</span></div>
		<div class="inm_disp_total"><% if sw_disponibilidad then %><span>disponibilidad</span><% end if %></div>
		<div class="inm_disp_total"></div>
        <div class="inm_pais"><% 'if not sw_disponibilidad then %><span>Pa&iacute;s</span><% 'end if %></div>
    </div>
</div>
<%
if recibe_paso <= 2 then 
	var_paso = 2	'inmuebles, semejantes	
	var_tipo_busq = "edif"
	var_titulo_busq = "inmuebles: Semejantes"
	call AbreRecordSet()
end if

'IF 1=2 THEN
if frmInfo_busq<>"" then

	if recibe_paso <= 3 then 
		'if sw_edif then 
		select case frmInfo_tipo
		case "cc", "hot"
		case "disp"
		case else
			var_paso = 3	'direcciones semejantes	
			var_tipo_busq = "dir"
			var_titulo_busq = "direcciones: Semejante"
			call AbreRecordSet()
		end select
	end if
	
	if recibe_paso <= 4 then 
		select case frmInfo_tipo
		case "hot"
		case "disp"
		case else
			var_paso = 4	'zonas semejantes	
			var_tipo_busq = "zona"
			var_titulo_busq = "zonas: Semejantes"
			call AbreRecordSet()
		end select
		
	end if

end if

if counter=0 then %>
	<div style="padding:10px; margin:2px;">
		<p>No se ha encontrado ninguna coincidencia.</p>
		<p>&nbsp;</p>
		<p>Depure la b&uacute;squeda.</p>
	</div><% 
end if


if acceso_seccion then
else
	call SinAccesoN(frmInfo_tipo, rsBusq) 
end if

set rsBusq=nothing 
%>

<% sub LineaInmueble() 
	select case var_tipo_busq
    case "edif" 
		data_id = rsBusq("id")
		dispo=rsBusq("disponible_superficie")

	

	case else
		data_id = ""
	end select
	%>
<div class="inm_row <% if var_tipo_busq="edif" then
		if isnull(rsBusq("lat")) then response.Write("pw-warning") end if 
	end if %>" 
	<% if rsBusq("EnConstruccion")  then  %> style="background-color:#CCCCCC;" <% end if 
	 %>
					>
	<div class="inm_check">
<form class="pagsum_detalle" id="frm<%= counter %>" method="post" action="/info/edificio/" data-id="<%= data_id %>">
	<input type="hidden" name="frmInfo_tipo" value="<%= frmInfo_tipo %>">
	<input type="hidden" name="frmInfo_busq" value="<%= frmInfo_busq %>">
    <input type="hidden" name="secc" value="edif">
    <input type="hidden" name="seltipo" value="<%= var_tipo_busq %>">

	<% 



	select case var_tipo_busq
    case "edif" 
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
				if instr(c_nombre, rsBusq("nombre"))=0 then
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
							'xxx c_nombre = "<b>" & rsBusq("tipo_edificio") & "&nbsp;" & c_nombre & "</b>"
							c_nombre = "<b>" &  c_nombre & "</b>"
						else
							'xxx c_nombre = rsBusq("tipo_edificio") & "&nbsp;" & c_nombre
							
						end if	
				end if

				'esto de abajo se pone
				'c_nombre = rsBusq("tipo_edificio") & "&nbsp;" & c_nombre
			end if
		end if
		
		if not(isnull(rsBusq("id_complejo"))) then
			'c_nombre = "&nbsp;&nbsp;&nbsp;" & c_nombre
			if rsBusq("id_complejo") = complejo_activo then
				' nuevo c_nombre = "&nbsp;&nbsp;&nbsp;" & c_nombre 

				if InStr(rsBusq("nombre_calc"),rsBusq("complejo_nombre_completo"))<>0 then
					c_nombre=Replace(rsBusq("nombre_calc"),rsBusq("complejo_nombre_completo")," ")
				else
					c_nombre= rsBusq("nombre_calc")
				end if
				if not(isnull(rsBusq("nombre_complejo_completo"))) then
					if InStr(c_nombre,rsBusq("nombre_complejo_completo"))<>0 then
						c_nombre=Replace(c_nombre,rsBusq("nombre_complejo_completo")," ")
					end if
				end if
				if not(isnull(rsBusq("tipo_edificio"))) then
					if InStr(c_nombre,rsBusq("tipo_edificio"))<>0 then
						c_nombre=Replace(c_nombre,rsBusq("tipo_edificio"),"")
					end if
				end if

				if rsBusq("es_complejo") then

					c_nombre = "<b>" & c_nombre & "</b>"
				end if	

				'xxx c_nombre= rsBusq("nombre_calc")
			else
				complejo_activo=rsBusq("id_complejo")


				if InStr(rsBusq("nombre_calc"),rsBusq("complejo_nombre_completo"))<>0 then
					c_nombre=Replace(rsBusq("nombre_calc"),rsBusq("complejo_nombre_completo")," ")
				else
					c_nombre= rsBusq("nombre_calc")
				end if
				if not(isnull(rsBusq("nombre_complejo_completo"))) then
					if InStr(c_nombre,rsBusq("nombre_complejo_completo"))<>0 then
						c_nombre=Replace(c_nombre,rsBusq("nombre_complejo_completo")," ")
					end if
				end if
				if not(isnull(rsBusq("tipo_edificio"))) then
					if InStr(c_nombre,rsBusq("tipo_edificio"))<>0 then
						c_nombre=Replace(c_nombre,rsBusq("tipo_edificio"),"")
					end if
				end if
				if rsBusq("es_complejo") then

					c_nombre = "<b>" & c_nombre & "</b>"
				end if	


				'c_nombre = rsBusq("complejo") & " " & c_nombre

				'nuevo c_nombre = "&nbsp;<span class='padre'><b>" & rsBusq("complejo") & "</b></span><br>&nbsp;&nbsp;&nbsp;" & c_nombre  
				
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
			c_secc = rsBusq("seccion")
			if len(c_secc)>25 then 
				c_secc = "<acronym title='" & c_secc & "'>" & left(c_secc, 22) & "...</acronym>"
			end if
			c_tipo = c_secc
		else
			c_tipo = rsBusq("tipo_edificio")
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
		end if %>
        <input type="hidden" name="id_edificio" value="<%= rsBusq("id") %>">
        
        <!-- 
        <input type="hidden" name="edificio" value="< %= rsBusq("nombre_completo") %>">
        <input type="hidden" name="calle" value="< %= rsBusq("nombre_calle") %>">
        <input type="hidden" name="numerocalle" value="< %= rsBusq("numero_calle") %>">
        <input type="hidden" name="d" value="< %= rsBusq("dir1") %>">
        <input type="hidden" name="l" value="< %= rsBusq("localidad") %>">
        -->
        
    <% case "dir" 
        c_nombre = rsBusq("dir1")
        
		if rsBusq("id_pais")=0 then
			bandera = false
		else
			bandera = true
			c_bandera = rsBusq("id_pais") & ".png"
			
			if rsBusq("id_pais")=1 then
				c_localidad = rsBusq("localidad")
				if len(c_localidad)>18 then
					c_localidad = "<acronym title='" & replace(c_localidad, "'", "&#39;") & "'>" & left(c_localidad, 15) & "...</acronym>"
				end if
			else
				c_localidad = rsBusq("pais")
				if rsBusq("id_localidad")>0 then
					c_localidad = c_localidad & " (" & rsBusq("localidad") & ")"
				end if
			end if

		end if
		
		c_tipo = "DIRECCION"
        c_id = ""
		
		if acceso_seccion then 
			c_disponibilidad = "&nbsp;"
		else
			c_disponibilidad = "icon-lock"
		end if
		
		if request.Cookies("dev")<>"" then
			pop_title = rsBusq("dir1")
			
			pop_content = "<table border='0' cellspacing='0' cellpadding='2'>"
			
			pop_content = pop_content & "<tr><td>calle:&nbsp;</td><td>" & rsBusq("nombre_calle") & "</td></tr>"
			pop_content = pop_content & "<tr><td>tipo via:&nbsp;</td><td>" & rsBusq("tipo_direccion") & "</td></tr>"
			pop_content = pop_content & "<tr><td>n&deg;:&nbsp;</td><td>" & rsBusq("numero_calle") & "</td></tr>"
			pop_content = pop_content & "<tr><td>d:&nbsp;</td><td>" & rsBusq("dir1") & "</td></tr>"
			pop_content = pop_content & "<tr><td>l:&nbsp;</td><td>" & rsBusq("localidad") & "</td></tr>"
			
			pop_content = pop_content & "<tr style='border-bottom: 1px solid black;'><td colspan='2'></td></tr>"
			
			pop_content = pop_content & "<tr><td nowrap='nowrap'>dir2:&nbsp;</td><td nowrap='nowrap'>" & rsBusq("dir2") & "</td></tr>"
			pop_content = pop_content & "<tr><td nowrap='nowrap'>dir3:&nbsp;</td><td nowrap='nowrap'>" & rsBusq("dir3") & "</td></tr>"
			
			pop_content = pop_content & "</table>"
		end if %>
        <input type="hidden" name="calle" value="<%= rsBusq("nombre_calle") %>">
        <input type="hidden" name="tipovia" value="<%= rsBusq("tipo_direccion") %>">
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
		
		if acceso_seccion then 
			c_disponibilidad = "&nbsp;"
		else
			c_disponibilidad = "icon-lock"
		end if
		'c_disp_min = "&nbsp;"
		'c_disp_max = "&nbsp;"
		'c_disp_fecha = "&nbsp;"
		
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
<a href="/info/edificio/" onclick="$('#frm<%= counter %>').submit();return false;" <% if request.Cookies("dev")<>"" then %>data-toggle="popover" data-trigger="hover" title="<%= pop_title %>" data-content="<%= pop_content %>" data-placement="bottom" data-html="true"<% end if %>>
    <div class="inm_contador"><%= counter %></div>
    <div class="inm_nombre"><%= c_nombre %></div>
    
    <div class="inm_tipo"><%= lcase(c_tipo) %></div>
    <div class="inm_ubic"><%= lcase(c_localidad) %></div>
    
	<div class="inm_disp_total"><span class="<%= c_disponibilidad %>"></span></div>
	<div class="inm_disp_total"><% 
	if rsBusq("EnConstruccion") then  %> &nbsp;<img src="/img/underc.png" width="25"/> <% end if 
	
	%></div>
    
    <div class="inm_pais"><% if bandera then %><img src="/img/paises/32/<%= c_bandera %>" height="14"/><% end if %></div>
</a>
</div>
<% end sub %>

<% function calcular_sql()	
	select case rtipo
	case "prop" 
		
		sqlw = "id IN ("
		sqlw = sqlw & "SELECT id_inmueble FROM inmuebles_agentes WHERE id_empresa=" & id_propietario
		sqlw = sqlw & " AND tipo='prop' AND (fecha_hasta IS NULL)"	' AND fecha_desde IS NOT NULL
		sqlw = sqlw & ")"
		
		sql = "SELECT * FROM dirs_w_inmuebles WHERE " & sqlw & " ORDER BY id_pais, id_provincia, id_localidad, nombre_calc"
		
		sql_datos = "SELECT id, nombre_calc, lat,lng FROM dirs_w_inmuebles WHERE " & sqlw & " AND lat IS NOT NULL"
		
	case else			'rtipo	
		select case var_paso
		case 2	'inmuebles, semejante ó Dir. exacta	
			
			sqlw = "("
			sqlw = sqlw & "("
			sqlw = sqlw & "nombre COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI"
			sqlw = sqlw & " OR nombre_completo COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI"
			sqlw = sqlw & " OR nombre_calc COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI"
			sqlw = sqlw & " OR nombre_alt COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI"
			'if sw_edif then
				sqlw = sqlw & " OR localidad COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI"
			'end if
			sqlw = sqlw & ")"
			'if sw_edif then
				sqlw = sqlw & " OR ("
				'sqlw = sqlw & "dir1 LIKE '%" & busqueda & "%' OR "
				sqlw = sqlw & "dir2 COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI OR "
				sqlw = sqlw & "dir3 COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI OR "
				sqlw = sqlw & "dir4 COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI"
				sqlw = sqlw & ")"
			'end if
			sqlw = sqlw & ")"
			
			'sqlw = sqlw & " AND id_pais=1 AND "
			sqlw = sqlw & " AND id_tipo_inmueble=0"
			
			sqlw = sqlw & " AND (id_region IS NOT NULL AND id_region<>7)"
			
			'if acceso_seccion then
				sql = "SELECT * FROM dirs_w_inmuebles WHERE (" & sqlw & ") "

				sql = sql & " ORDER BY id_pais, id_provincia, id_localidad,  nombre_calc"

				'sql = sql & " ORDER BY id_pais, ISNULL(id_localidad,9999), id_provincia, id_localidad, complejo_orden, es_complejo DESC, nombre"
				
				'sql = sql & " ORDER BY localidad, nombre_calle, numero_calle_ord, numero_calle, nombre_completo"
			'else
			'	sql = "SELECT COUNT(*) AS nn FROM dirs_w_inmuebles WHERE (" & sqlw & ")"
			'end if
			
			sql_datos = "SELECT id, nombre_calc, lat,lng, en_proyecto, EnConstruccion FROM dirs_w_inmuebles WHERE " & sqlw & " AND lat IS NOT NULL"
			sql_datos_mapa = "SELECT id, nombre_calc, lat,lng, en_proyecto, EnConstruccion  FROM dirs_w_inmuebles_mapa WHERE " & sqlw & " AND lat IS NOT NULL"
			
			%><script>
				inmuebles = <%= QueryToJSON(session("connPW"), sql_datos).Flush %>;
				//console.log("[<%= sql_datos %>]")
			</script><%
		case 3	'direcciones semejante	
			'if acceso_seccion then
				sql = "SELECT dir1, dir2, dir3, dir5, id_pais, pais, id_localidad, localidad, tipo_direccion, nombre_calle, numero_calle, fecha_renov, fecha_edif,EnConstruccion "
			'else
			'	sql = "SELECT COUNT(*) AS nn "
			'end if
			' No veo porque apunta a esta consulta si es de operaciones: sql = sql & "FROM dirs_w WHERE "
			sql = sql & "FROM dirs_w_inmuebles WHERE "  ' lo dejo con esta 
			sql = sql & "(("
			'sql = sql & "dir1 LIKE '%" & busqueda & "%' OR "
			sql = sql & "dir2 COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI OR "
			sql = sql & "dir3 COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI))"
			
			sql = sql & " AND (numero_calle IS NOT NULL AND numero_calle<>'')"
			
			'sql = sql & " AND id_pais=1"
			
			sql = sql & " AND ("
			sql = sql & "seccion LIKE '%OFICINAS%' OR seccion LIKE '%INDUSTRIAL%' OR "
			sql = sql & "seccion LIKE '%DEUDA%' OR seccion LIKE '%HOSPITAL%' OR "
			sql = sql & "seccion LIKE '%SOLAR%' OR seccion LIKE '%RESIDENCIAL%' OR "
			sql = sql & "seccion LIKE '%OCIO%' OR seccion LIKE '%ALMACENES%' OR "
			sql = sql & "seccion LIKE '%ESCUELA%' OR seccion LIKE '%PARKING%' OR "
			sql = sql & "seccion LIKE '%RESIDENCIA%'"
			sql = sql & ")"
			
			if ids<>"" then 
				sql = sql & " AND id_edificio NOT IN (" & ids & ")"
			end if
			'quitado el group para probar 5/4/20'
			'sql = sql & " GROUP BY dir1, dir2, dir3, dir5, id_pais, pais, id_localidad, localidad, tipo_direccion, nombre_calle, numero_calle"
			
			if acceso_seccion then
				sql = sql & " ORDER BY localidad, nombre_calle, numero_calle"
				'sql = sql & " ORDER BY nombre_calle, numero_calle_ord, numero_calle"
			end if
			
		case 4	'zonas semejantes	
			'if session("pw_ws").accesoInfoEdificio and ini=0 then
				sql = "SELECT dir4, localidad, id_tipo_zona, tipo_zona, nombre_zona, id_pais, pais, fecha_renov, fecha_edif, EnConstruccion "
			'else
			'	sql = "SELECT COUNT(*) AS nn "
			'end if
			
			'sql = sql & "FROM dirs_w WHERE "
			sql = sql & "FROM dirs_w_inmuebles WHERE "
			sql = sql & "("
			sql = sql & "nombre_zona COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI AND "	' AND id_tipo_zona=3)"
			
			select case rtipo
			case "cc"
				sql = sql & "id_tipo_zona IN (3, 9)"
			case "hot"
				sql = sql & "id_tipo_zona=42"
			case else
				sql = sql & "id_tipo_zona NOT IN (42, 3, 9)"
			end select
			
			'sql = sql & " AND id_pais=1"
			
			sql = sql & " AND ("
			sql = sql & "seccion LIKE '%OFICINAS%' OR seccion LIKE '%INDUSTRIAL%' OR "
			sql = sql & "seccion LIKE '%DEUDA%' OR seccion LIKE '%HOSPITAL%' OR "
			sql = sql & "seccion LIKE '%SOLAR%' OR seccion LIKE '%RESIDENCIAL%' OR "
			sql = sql & "seccion LIKE '%OCIO%' OR seccion LIKE '%ALMACENES%' OR "
			sql = sql & "seccion LIKE '%ESCUELA%' OR seccion LIKE '%PARKING%' OR "
			sql = sql & "seccion LIKE '%RESIDENCIA%'"
			sql = sql & ")"
			
			if ids<>"" then 
				sql = sql & " AND id_edificio NOT IN (" & ids & ")"
			end if
			sql = sql & ")"
			
			if sw_edif then
				sql = sql & " AND NOT ("
				sql = sql & "(dir2 COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI "
				sql = sql & "OR dir3 COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI) "
				sql = sql & "AND (numero_calle IS NOT NULL AND numero_calle<>'')"
			sql = sql & ")"	
			end if
			'if ids<>"" then 
			'	sql = sql & " AND id_edificio NOT IN (" & ids & ")"
			'end if
			'quitado el group para probar 5/4/20'
			'sql = sql & " GROUP BY dir4, localidad, id_tipo_zona, tipo_zona, nombre_zona, id_pais, pais"
			
			if acceso_seccion then
				sql = sql & " ORDER BY dir4"
			end if
		end select
		
	end select			'rtipo
	
	test_inyeccion_sql sql
	calcular_sql = sql


end function %>

<% sub AbreRecordSet() 	
	t_ini = timer 
	contador_paso = 0
	
	ids_actual = ids
	tmp_sql = calcular_sql
	
	'if informa then 
		if request.Cookies("dev")<>"" then
			%><div style="font-size:12px; border-top: 1px solid red; margin:2px 0;"><a href="#" onclick="$('#sql<%= var_paso %>').slideToggle('fast'); return false;">
				<% if cint(recibe_paso)=cint(var_paso) then %>... continuaci&oacute;n...<% else %><strong>paso: <%= var_paso %></strong> &nbsp; <%= var_titulo_busq %><% end if %>
				<span class="peq" style="float:right;"><span id="timer<%= var_paso %>">0</span> ms</span></a>
				<div id="sql<%= var_paso %>" style="display:none; margin:6px 0 0 6px; border:#CCC 1px solid; font-size:9px"><%= tmp_sql %></div>
			</div><% 	
		end if
	'end if
	rsBusq.open tmp_sql, session("connPW")
	%>
<div class="inm_tbl"><%
select case rtipo
case "empr"	
	if session("pw_ws").accesoInfoEdificios then	'and ini=0 then
		do while not rsBusq.eof 
			call LineaEmpresa(rsBusq)
			rsBusq.movenext
		loop
		
	else
		call SinAccesoN(rtipo, rsBusq)
	end if
	
case else
	
	do while not rsBusq.eof 
		select case var_paso
		case 1, 2
			if ids<>"" then ids=ids & ", "
			ids = ids & rsBusq("id")
		end select
		
		contador_paso = contador_paso + 1
		counter = counter + 1
		
		if acceso_seccion then
			call LineaInmueble()
		end if
		
		rsBusq.movenext

		if counter>=300 then %>
		<div class="inm_row edif pw-warning">

			<a href="#">
				<div class="inm_contador">n...</div>
				<div class="inm_nombre">--- Defina un criterio de busqueda para obtener el resultado deseado... </div>
				
				<div class="inm_tipo">---</div>
				<div class="inm_ubic">---</div>
				
				<div class="inm_disp_total">---</div>
				<div class="inm_disp_total">---</div>
				
				<div class="inm_pais">---</div>
			</a>
			
		</div> <%
		 exit do
		end if

	loop
	'call SinAccesoN(rtipo, rsBusq)
	
	
end select

IF 1=2 THEN
	do while not rsBusq.eof 
		select case rtipo
		case "empr"
			if acceso_seccion then
				call LineaEmpresa(rsBusq)
			else
				call SinAccesoN(rtipo, rsBusq)
			end if
			
		case else
			if acceso_seccion then
				call LineaInmueble()
			else
				call SinAccesoN(rtipo, rsBusq)
			end if
			
		end select
		
		rsBusq.movenext
	loop
END IF
	
%></div><%
	
	rsBusq.close
	t_fin = timer
	
	%><script type="text/javascript">
		$('#timer<%= var_paso %>').html('<%= formatnumber(t_fin-t_ini, 3) %>');
	</script><%
	
end sub %>
