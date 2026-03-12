<% sub TopInversores(zona) 
	set rsTmp = Server.CreateObject("ADODB.Recordset")
	
	sql = "SELECT TOP 25 OPERACIONES_CONTACTOS.id_empresa, OPERACIONES_CONTACTOS.id_sucursal, EMPRESAS.NOMBRE, EMPRESAS.id_pais, SUM(C_OPERACIONES.PRECIO_EUR) AS euros "
	sql = sql & "FROM OPERACIONES_CONTACTOS INNER JOIN EMPRESAS ON OPERACIONES_CONTACTOS.id_sucursal = EMPRESAS.ID INNER JOIN "
	sql = sql & "C_OPERACIONES ON OPERACIONES_CONTACTOS.id_operacion = C_OPERACIONES.ID LEFT OUTER JOIN "
	sql = sql & "TIPOS_DE_ACTIVIDADES ON EMPRESAS.ID_ACTIVIDAD = TIPOS_DE_ACTIVIDADES.ID "
	sql = sql & " WHERE "
	sql = sql & "(C_OPERACIONES.ID_TIPO_OPERACION = 3) AND (TIPOS_DE_ACTIVIDADES.directorio = 1) AND "
	sql = sql & "(OPERACIONES_CONTACTOS.tipo IN ('C', 'P')) AND "
	sql = sql & "(C_OPERACIONES.FECHA_OPERACION >= CONVERT(DATETIME, '2015-01-01 00:00:00', 102)) AND "
	if zona="es" then
		sql = sql & "(C_OPERACIONES.ID_PAIS = 1) "
	else
		sql = sql & "(C_OPERACIONES.id_region IN (2, 3, 5)) "
	end if
	sql = sql & "GROUP BY OPERACIONES_CONTACTOS.id_empresa, OPERACIONES_CONTACTOS.id_sucursal, EMPRESAS.NOMBRE, EMPRESAS.id_pais "
	sql = sql & "ORDER BY SUM(C_OPERACIONES.PRECIO_EUR) DESC, EMPRESAS.NOMBRE"
	
	rsTmp.Open sql, session("connPW")
%>
<%'= sql %>
<% 'select case session("modo")
'case "normal", ""
if 1=2 then
%>
    <table class="tbl_bordered">
    <thead>
        <tr>
    <th colspan="2">inversores m&aacute;s activos<br /> &nbsp; <% if zona="es" then %>Espa&ntilde;a<% else %>resto Europa<% end if %> 2015</th>
    <th valign="bottom">M &euro;</th>
        </tr>
    </thead>
    <tbody>
    <% for ii=1 to 5 
        if rsTmp.eof then exit for %>
    <tr>
        <td><%= ii %></td>
        <td><%= rsTmp("NOMBRE") %></td>
        <td align="right"><%= FormatNumber(rsTmp("euros")/1000000,0) %></td>
    </tr>
        <% rsTmp.movenext
	next %>
    </tbody></table>
    <div style="float:right;margin-bottom:10px;"><a href="/inversores/"><< Ver m&aacute;s</a></div>
	<hr />

<% else %>
    <div class="invcont">
        <div class="boxerhead">
            <div class="filatit">
                <div class="box1tit" style="text-align:left;"><% if zona="es" then %>Espa&ntilde;a<% else %>Resto de Europa<% end if %></div>
                <div class="box2tit">M &euro;</div>
            </div>
        </div>
        
        <div class="boxer">
    	    <% for ii=1 to 5 
	    	    if rsTmp.eof then exit for %>
<div class="box-row">
    <div class="box1"><%= ii %></div>
    <div class="box2"><%= lcase(rsTmp("NOMBRE")) %></div>
    <div class="box3"><img src="/img/paises/32/<%= rsTmp("id_pais") %>.png" width="16" height="10" border="0"></div>
    <div class="box4"><%= FormatNumber(rsTmp("euros")/1000000,0) %></div>
</div>
        	    <% rsTmp.movenext
		    next %>
        </div>
        
        <div class="boxerfoot"><a href="/inversores/">Ver m&aacute;s</a></div>
    
    </div>
<% end if 

rsTmp.close
set rsTmp=nothing %>
<% end sub %>


