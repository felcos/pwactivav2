<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% if request.QueryString("id")<>"" then %>
	<form method="post" action="/inversores/empresa/" id="redir" name="redir">
    <input type="hidden" name="id" value="<%= request.QueryString("id") %>">
    <input type="hidden" name="y" value="<%= request.QueryString("y") %>">
    <input type="hidden" name="z" value="<%= request.QueryString("z") %>">
    <input type="hidden" name="t" value="<%= request.QueryString("t") %>">
	</form>
<script>document.redir.submit()</script>
<% response.End()
end if %>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<!--#include virtual="/inversores/operaciones.asp" -->
<%
swMostrarDetalles = false
if session("pw_ws").accesoInfoEmpresa then
	swMostrarDetalles = true
end if

'swMostrarDetalles = false
%>
<%
r_id=request.form("id")
if r_id="" then response.Redirect("/inversores/")
if not isnumeric(r_id) then response.Redirect("/inversores/")

'Año
if request.form("y")="" then 'response.Redirect("/inversores")
	r_year = "2016"
else
	r_year=left(request.form("y"),4)
end if
if r_year="" then r_year="2016"
if not isnumeric(r_year) then r_year="2016"
if r_year>2016 then r_year="2016"
if r_year<1996 then r_year="1996"

f_desde = r_year & "-01-01" 
f_hasta = r_year & "-12-31" 

'zona:		España, Resto, Todo
if request.form("z")="" then
	c_zona = "t"
else
	c_zona = left(request.form("z"), 1)
end if
select case c_zona
case "e"
	txt_zona = "en Espa&ntilde;a"
case "r"
	txt_zona = "fuera de Espa&ntilde;a"
case "t"
	txt_zona = "globalmente"
end select

set rsEmpresa = Server.CreateObject("ADODB.Recordset")
sql = "SELECT * FROM directorio_empresas WHERE ID=" & r_id

test_inyeccion_sql sql
rsEmpresa.Open sql, session("connPW")

'otros nombres	
otros_nombres2 = rsEmpresa("OTROS_NOMBRES")
if otros_nombres2<>"" then 
	otros_nombres2 = replace(otros_nombres2, vbcrlf, "#")
	otros_nombres2 = "#" & otros_nombres2 & "#"
end if

otros_nombres3 = otros_nombres2
if otros_nombres3<>"" then 
	otros_nombres3 = replace(otros_nombres3, "#" & rsEmpresa("NOMBRE") & "#", "")
end if

otros_nombres = rsEmpresa("OTROS_NOMBRES")
if otros_nombres<>"" then 
	otros_nombres = replace(otros_nombres, rsEmpresa("NOMBRE"), "")
	otros_nombres = replace(otros_nombres, vbcrlf, "<br>")
end if

'dirección		
direccion = ""
IF rsEmpresa("EDIFICIO")<>"N/D" AND rsEmpresa("EDIFICIO")<>"" THEN
	direccion =  "Edificio "
	direccion = direccion & VERSALITA_TODO(rsEmpresa("EDIFICIO"))
	coma ="<br>"
END IF
		
IF rsEmpresa("NOMBRE_CALLE")<>"N/D"  and rsEmpresa("NOMBRE_CALLE")<>"" THEN
	IF rsEmpresa("TIPO_DIRECCION")<>"N/D" and rsEmpresa("TIPO_DIRECCION")<>"" THEN
		direccion = direccion & coma & VERSALITA_TODO(rsEmpresa("TIPO_DIRECCION"))
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

sec_actual = "/inversores/"

'if direccion<>"" then %>
<!DOCTYPE html>
<html lang="es">
<head>
    <title>PropertyWeb - Inversores</title>
	<!--#include virtual="/inc/head.asp" -->
    
    <link href="/css/css-pags/tabs02.css" rel="stylesheet" type="text/css">
</head>
<body>
<!--#include virtual="/inc/body-header.asp" -->
<%
insert_reg_articulo "inv", "inv", rsEmpresa("id")
%>
<div class="container">
<section id="s_empresa" class="row">
    <div class="">
        <h1 class="heading caja"><%= rsEmpresa("NOMBRE") %></h1>
    </div>
        

    <div class="col-md-8 caja">
<div>
<p><b><%= rsEmpresa("ACTIVIDAD") %></b></p>
<hr>
<% 
if rsEmpresa("id_pais_origen")>0 then %>
    <img align="right" src="/img/paises/32/<%= rsEmpresa("id_pais_origen") %>.png">
    <p>Pa&iacute;s de origen: <%= rsEmpresa("pais_origen") %> (<%= rsEmpresa("id_pais_origen") %>)</p>
<% end if %>
<p>Direcci&oacute;n:</p>
	<%= direccion %>
<% if rsEmpresa("WEB")<>"" then 
	link=lcase(rsEmpresa("WEB"))
	if left(link, 7)<>"https://" then link = "https://" & link
	%>
    <hr>
	<p>Web:&nbsp;<a href="<%= link %>" target="_blank" class="negro"><%= lcase(rsEmpresa("WEB")) %></a></p>
<% end if %>

<% 
set rsSucursales = Server.CreateObject("ADODB.Recordset")
sql = "SELECT * FROM directorio_sucursales WHERE ID_EMPRESA=" & rsEmpresa("id")
rsSucursales.open sql, session("connPW")
if not(rsSucursales.eof) then 
%>
<hr>
<p><b>Sucursales:</b></p>
<% do while not(rsSucursales.eof) %>
	<li><%= rsSucursales("NOMBRE") %></li>
	<% rsSucursales.movenext
loop %>
<% end if
rsSucursales.close
set rsSucursales = nothing 
%>
</div>
	</div>

    <div class="col-md-4">
        <div class="caja">
            <p>Resumen por a&ntilde;os</p>
            <!-- include virtual="/inversores/empresa/resumen.asp" -->
            <form action="/inversores/empresa/" method="post" name="frmopts" id="frmopts">
        <input name="id" type="hidden" value="<%= request.Form("id") %>">
        <table border="0">
        <tr>
        <td>A&ntilde;o: </td>
        <td><select name="y" id="y" onChange="frmopts.submit();" style="width:75px;">
        <% 
        for ii=2016 to 1996 step -1 %>
        <option value="<%= ii %>" <% if r_year=cstr(ii) then %>selected<% end if %>><%= ii %></option>
        <% next %>
        </select></td>
        </tr>
        <tr>
        <td>Regi&oacute;n: </td>
        <td><select name="z" id="z" onChange="frmopts.submit();" style="width:150px;">
        <option value="e" <% if c_zona="e" then %>selected<% end if %>>Espa&ntilde;a</option>
        <option value="r" <% if c_zona="r" then %>selected<% end if %>>Resto del mundo</option>
        <option value="t" <% if c_zona="t" then %>selected<% end if %>>Todo</option>
        </select></td>
        </tr>
        </table>
        </form>
        </div>
        
	</div>	

</section>

<section id="s_titulos" class="row clearfix">
    <div class="caja">
    <% if swMostrarDetalles then %>
    <form name="frm_titulos" id="frm_titulos" method="post" action="/articulos/">
    	<input type="hidden" name="origen" value="invers">
        <h2>Operaciones</h2>
        <div id="PwTabs">
            <ul class="nav nav-tabs" style="" id=""><!-- class: + submenu lineNavs -->
            	<li class="active"><a href="#tab_compras" data-toggle="tab" aria-expanded="true">Adquisiciones</a></li>
				<li><a href="#tab_ventas" data-toggle="tab" aria-expanded="false">Ventas</a></li>
                <!--
                <span style="float:right; position:relative; left:-10px; font-size:11px;">	
                    <input type="checkbox" id="check_all" onChange="marcar()" style="position:relative; top:3px;"> seleccionar todos los art&iacute;culos
                </span>
                -->
            </ul>
            <div class="tab-content">
                <div class="tab-pane active" id="tab_compras"><% call TablaOperaciones(r_id, "C", c_zona, r_year) %></div>
                <div class="tab-pane" id="tab_ventas"><% call TablaOperaciones(r_id, "P", c_zona, r_year) %></div>
            </div>
        </div>
        <p style="clear:both;">&nbsp;</p>
        <div style="text-align:center; margin-bottom:20px;">
            <input type="submit" id="submit" name="submit" value="Leer Art&iacute;culos Seleccionados" class="btn">
        </div>
    </form>
    <% else 
        %><h2>Operaciones</h2><%
        call TablaResumen(r_id)
    end if %>
    </div>
</section>

</div>
<!--#include virtual="/inc/body-footer.asp" -->
</body>
</html>

<script type="text/javascript">
	function marcar(){ 
		if(document.getElementById("check_all").checked==true){
		   for (i=0;i<document.frm_titulos.elements.length;i++) 
			  if(document.frm_titulos.elements[i].type == "checkbox") 
				 document.frm_titulos.elements[i].checked=1; 
	   }else{
			for (i=0;i<document.frm_titulos.elements.length;i++) 
			  if(document.frm_titulos.elements[i].type == "checkbox") 
				 document.frm_titulos.elements[i].checked=0
	   };
	   return false;
	}
</script>



