<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<%
sec_actual = "/inversores/"

'Año
if request.QueryString("y")="" then 'response.Redirect("/inversores")
	r_year = "2017"
else
	r_year=left(request.QueryString("y"),4)
end if
if r_year="" then r_year="2017"
if not isnumeric(r_year) then r_year="2017"
if r_year>2017 then r_year="2017"
if r_year<1996 then r_year="1996"

f_desde = r_year & "-01-01" 
f_hasta = r_year & "-12-31" 

if request.QueryString("t")="" then 'response.Redirect("/inversores")
	c_tipo="t"
else
	c_tipo = left(request.QueryString("t"), 1)
end if

'zona:		España, Resto, Todo
if request.QueryString("z")="" then
	c_zona = "t"
else
	c_zona = left(request.QueryString("z"), 1)
end if

select case c_zona	
case "e"
	txt_zona = "en Espa&ntilde;a"
case "r"
	txt_zona = "fuera de Espa&ntilde;a"
case "t"
	txt_zona = "globalmente"
end select
%>
<%
set rsTmp = Server.CreateObject("ADODB.Recordset")

sql = "SELECT OPERACIONES_CONTACTOS.id_empresa, OPERACIONES_CONTACTOS.id_sucursal, EMPRESAS.NOMBRE, COUNT(C_OPERACIONES.ID) AS ops, SUM(C_OPERACIONES.PRECIO_EUR) AS euros "
sql = sql & ", EMPRESAS.ID_PAIS, Paises.Nombre AS PAIS "


sql = sql & "FROM TIPOS_DE_ACTIVIDADES RIGHT OUTER JOIN "
sql = sql & "Paises RIGHT OUTER JOIN "
sql = sql & "OPERACIONES_CONTACTOS INNER JOIN "
sql = sql & "EMPRESAS ON OPERACIONES_CONTACTOS.id_sucursal = EMPRESAS.ID INNER JOIN "
sql = sql & "C_OPERACIONES ON OPERACIONES_CONTACTOS.id_operacion = C_OPERACIONES.ID "
sql = sql & "ON Paises.Id = EMPRESAS.ID_PAIS ON "
sql = sql & "TIPOS_DE_ACTIVIDADES.ID = EMPRESAS.ID_ACTIVIDAD "



sql = sql & " WHERE "
sql = sql & "(C_OPERACIONES.ID_TIPO_OPERACION = 3) AND (TIPOS_DE_ACTIVIDADES.directorio = 1) AND "

select case c_tipo	
case "c"
	sql = sql & "(OPERACIONES_CONTACTOS.tipo = 'C') AND "
case "v"
	sql = sql & "(OPERACIONES_CONTACTOS.tipo = 'P') AND "
case "t"
	sql = sql & "(OPERACIONES_CONTACTOS.tipo = 'C' OR OPERACIONES_CONTACTOS.tipo = 'P') AND "
end select

sql = sql & "(C_OPERACIONES.FECHA_OPERACION BETWEEN CONVERT(DATETIME, '" & f_desde & " 00:00:00', 102) AND "
sql = sql & "CONVERT(DATETIME, '" & f_hasta & " 00:00:00', 102)) "

select case c_zona	
case "e"
	sql = sql & "AND (C_OPERACIONES.ID_PAIS = 1) "
case "r"
	sql = sql & "AND (C_OPERACIONES.ID_PAIS <> 1) "
case "t"
end select

sql = sql & "GROUP BY OPERACIONES_CONTACTOS.id_empresa, OPERACIONES_CONTACTOS.id_sucursal, EMPRESAS.NOMBRE "
sql = sql & ", EMPRESAS.ID_PAIS, Paises.Nombre "

sql = sql & "ORDER BY SUM(C_OPERACIONES.PRECIO_EUR) DESC"

'response.Write(sql)
'response.End()

test_inyeccion_sql sql
rsTmp.Open sql, session("connPW")
ii=1
%>
<!DOCTYPE html>
<html lang="es">
<head>
	<title>PropertyWeb - Inversores</title>
    <!--#include virtual="/inc/head.asp" -->
    <!--include virtual="/busq/lib_titulos.asp" -->
    <!-- include virtual="/lib/funciones.asp" -->
    <!--#include virtual="/inversores/lib_anunciar_inversores.asp" -->   
</head>
<body>
<!--#include virtual="/inc/body-header.asp" -->
<div class="container">

	<section id="empresa" class="clearfix">
        <div class="">
        	<h1 class="heading caja"><% if c_tipo="c" then %>Compradores<% elseif c_tipo="v" then %>Vendedores<% else %>Inversores<% end if %> m&aacute;s activos <%= txt_zona %>, a&ntilde;o <%= r_year %></h1>
        </div>
        
		<div class="caja col-md-8">
        
<table class="bordered" width="100%">
<thead>
    <tr>
        <th></th>
        <th>Empresa</th>
        <th>Pa&iacute;s</th>
        <th>N&deg; ops</th>
        <th>M &euro;</th>
    </tr>
</thead>
<tbody>
<% for ii=1 to 150
    if rsTmp.eof then exit for
    valor=FormatNumber(rsTmp("euros")/1000000,0)
    if valor=0 then valor=""
    %>
    <tr>
        <td align="right" width="20"><%= ii %></td>
        <td align="left"><a href="/inversores/empresa/?t=<%= c_tipo %>&z=<%= c_zona %>&y=<%= r_year %>&id=<%= rsTmp("id_empresa") %>"><%= rsTmp("NOMBRE") %></a></td>
        <td align="center"><img title="<%= rsTmp("pais") %>" src="/img/paises/32/<%= rsTmp("id_pais") %>.png" width="16" height="10" border="0" alt="<%= rsTmp("pais") %>"/></td>
        <td align="right"><%= rsTmp("ops") %></td>
        <td align="right"><%= valor %></td>
    </tr>
    <% rsTmp.movenext
next %>
</tbody>
</table>
        
        </div>
		<div class="col-md-4 caja">
			<form action="" method="get" name="frmopts" id="frmopts">
                    <table border="0">
                        <tr>
                            <td>A&ntilde;o: </td>
                            <td>
                            <select name="y" id="y" onChange="enviar_frmopts()" style="width:75px;">
                                <% for ii=2016 to 1996 step -1 %>
                                <option value="<%= ii %>" <% if r_year=cstr(ii) then %>selected<% end if %>><%= ii %></option>
                                <% next %>
                            </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Regi&oacute;n: </td>
                            <td>
                            <select name="z" id="z" onChange="enviar_frmopts()" style="width:150px;">
                                <option value="e" <% if c_zona="e" then %>selected<% end if %>>Espa&ntilde;a</option>
                                <option value="r" <% if c_zona="r" then %>selected<% end if %>>Resto del mundo</option>
                                <option value="t" <% if c_zona="t" then %>selected<% end if %>>Todo</option>
                            </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Tipo:</td>
                            <td>
                            <select name="t" id="t" onChange="enviar_frmopts()" style="width:120px;">
                                <option value="c" <% if c_tipo="c" then %>selected<% end if %>>Compradores</option>
                                <option value="v" <% if c_tipo="v" then %>selected<% end if %>>Vendedores</option>
                                <option value="t" <% if c_tipo="t" then %>selected<% end if %>>Todos</option>
                            </select>
                            </td>
                        </tr>
                    </table>
            	</form>
		</div>
        
    </section>
</div>
<!--#include virtual="/inc/body-footer.asp" -->
</body>
</html>

<%
rsTmp.close
set rsTmp=nothing %>
<script language="javascript">
	function enviar_frmopts() {frmopts.submit()}
</script>
