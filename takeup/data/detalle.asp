<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<%
if session("pw_ws").accesoTakeUp then 
	Set rsPl = Server.CreateObject("ADODB.Recordset")
	sql = "SELECT * FROM c_inmuebles_plantas WHERE id_inmueble=" & request.form("id")
	sql = sql & " AND disponible_superficie IS NOT NULL AND disponible_superficie>0 ORDER BY orden DESC"
	'test_inyeccion_sql sql
	rsPl.Open sql, session("connPW")
	%>
	<table class="tbDispon">
	<% do while not rsPl.eof %>
	    <tr>
    	    <td class="tbDisp-Plta">PT <%= rsPl("planta") %></th>
	       	<td class="tbDisp-Tipo"><%= lcase(rsPl("seccion")) %></td>
    	    <td class="tbDisp-Min"></td>
	        <td class="tbDisp-Max"><%= formatnumber(rsPl("disponible_superficie"), 0) %></td>
        	<td class="tbDisp-Renta"><%= rsPl("disponible_renta") %></td>
    	    <td class="tbDisp-Fecha"></td>
	    </tr>
    	<% rsPl.movenext
	loop
	
	rsPl.close
	set rsPl = nothing
	
	'resp_regArticulo = session("pw_ws").RegArticulo("takeup", "dis", cdbl(request.queryString("id")))
	secc = request.form("secc")
	if secc = "disponibilidad" then secc = "takeup"
	
	insert_reg_articulo secc, "edif", request.form("id")
	
	%>
	</table>
    <% if request.Cookies("dev")<>"" then %>
	<script>
    $(document).ready(function() {
        $.get("/articulos/contador.asp?t=dis", function(recibe){
            $("*[data-toggle='contador_leidos'][data-content='dis']").text(recibe)
        });
        
    });
    </script>
	<% end if
	
else %>
	<p><img src="/img/lock.svg" width="14" height="14"/> Lo sentimos, pero esta informaci&oacute;n s&oacute;lo est&aacute; disponible para <a href="#" class="simplemodal">clientes</a>.</p>
<% end if %>