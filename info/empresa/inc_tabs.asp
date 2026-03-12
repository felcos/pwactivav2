<% 
set rsSucursales = Server.CreateObject("ADODB.Recordset")
sql = "SELECT * FROM directorio_sucursales WHERE ID_EMPRESA=" & rsEmpresa("id")
rsSucursales.open sql, session("connPW")
%>
<div class="PwTabs">
    <ul class="nav nav-tabs" style="" id=""><!-- class: + submenu lineNavs -->
    	<li class="active"><a href="#tab_contacto" data-toggle="tab" aria-expanded="true">Contacto</a></li>
		<% if not(rsSucursales.eof) then %><li><a href="#tab_sucursales" data-toggle="tab" aria-expanded="false">Sucursales</a></li><% end if %>
    </ul>
    
    <div class="tab-content">
    	<div class="tab-pane active" id="tab_contacto" >
<% if rsEmpresa("id_pais")>0 then %>
    <img align="right" src="/img/paises/32/<%= rsEmpresa("id_pais") %>.png">
    <p>Pa&iacute;s de origen: <%= rsEmpresa("pais") %> (<%= rsEmpresa("id_pais") %>)</p>
<% end if %>

<% if 1=2 then	'rsEmpresa("TLF1")<>"" then %>
	<p>Tel&eacute;fono:&nbsp;<%= rsEmpresa("TLF1") %>&nbsp;<%= rsEmpresa("TLF2") %></p>
<% end if %>

<% if rsEmpresa("WEB")<>"" then 
	link=lcase(rsEmpresa("WEB"))
	if left(link, 7)<>"https://" then link = "https://" & link
	%>
    <hr>
	<p>Web:&nbsp;<a href="<%= link %>" target="_blank" class="negro"><%= lcase(rsEmpresa("WEB")) %></a></p>
<% end if %>
<hr>

<h3>Direcci&oacute;n</h3>
<% 'dirección		
direccion = ""
IF rsEmpresa("EDIFICIO")<>"N/D" AND rsEmpresa("EDIFICIO")<>"" THEN
	direccion =  "Edificio "
	direccion = direccion & VERSALITA_TODO(rsEmpresa("EDIFICIO"))
	coma ="<br>"
END IF
		
IF rsEmpresa("NOMBRE_CALLE")<>"N/D"  and rsEmpresa("NOMBRE_CALLE")<>"" THEN
	IF rsEmpresa("TIPODIRECCION")<>"N/D" and rsEmpresa("TIPODIRECCION")<>"" THEN
		direccion = direccion & coma & VERSALITA_TODO(rsEmpresa("TIPODIRECCION"))
		coma=" "
	END IF	
	direccion = direccion &  coma & VERSALITA_TODO(rsEmpresa("NOMBRE_CALLE"))
	coma=" "
END IF
IF rsEmpresa("NUMERO_PORTAL")<>"N/D" and rsEmpresa("NUMERO_PORTAL")<>"0" and rsEmpresa("NUMERO_PORTAL")<>"" THEN
	direccion = direccion & coma & rsEmpresa("NUMERO_PORTAL")
	coma = "<br>"
END IF
if coma <> "" then coma ="<br>"

IF rsEmpresa("NOMBRE_ZONA")<>"N/D" AND rsEmpresa("NOMBRE_ZONA")<>"" THEN
	if rsEmpresa("TIPOZONA")<>"N/D" and rsEmpresa("TIPOZONA")<>"" then 
		if rsEmpresa("ID_TIPO_ZONA")=1 then
			direccion = direccion & coma & "Parque "
		elseif rsEmpresa("ID_TIPO_ZONA")=2 then
			direccion = direccion & coma & "Pol&iacute;gono "
		end if
	end if
	direccion = direccion & VERSALITA_TODO(rsEmpresa("NOMBRE_ZONA"))
	coma ="<br>"
END IF
if coma <> "" then coma ="<br>"

'if coma <> "" then coma ="<br>"
'IF rsEmpresa("CODIGO_POSTAL")<>"N/D" and  len(rsEmpresa("CODIGO_POSTAL"))>3 THEN
'	direccion = direccion &  coma & rsEmpresa("CODIGO_POSTAL")
'	coma = " "
'END IF
IF rsEmpresa("PROVINCIA")<>"N/D" THEN
	'IF rsEmpresa("LOCALIDAD")<>"N/D" THEN
	'	direccion = direccion & coma & VERSALITA_TODO(rsEmpresa("LOCALIDAD"))
	'	'coma="<br>"
	'	coma = " "
	'END IF		
	if ucase(rsEmpresa("PROVINCIA"))=ucase(rsEmpresa("LOCALIDAD")) THEN
		direccion = direccion & coma & rsEmpresa("PROVINCIA")
	else
		direccion = direccion & coma & VERSALITA_TODO(rsEmpresa("LOCALIDAD")) & " &nbsp; (" & rsEmpresa("PROVINCIA") & ")"
	end if
END IF

if rsEmpresa("id_pais")<>1 then
	direccion = direccion & " &nbsp;(" & rsEmpresa("pais") & ")"
end if

'if direccion<>"" then %>
<%= direccion %>
        </div>
    	<% if not(rsSucursales.eof) then %>
        <div class="tab-pane" id="tab_sucursales" >
			<ul><% do while not(rsSucursales.eof) %>
                <li><%= rsSucursales("NOMBRE") %></li>
                <% rsSucursales.movenext
            loop %></ul>
    	</div>
        <% end if %>
    </div>
</div>
<%
rsSucursales.close
set rsSucursales = nothing 
%>