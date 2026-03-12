<div class="bloqueRight">
	<div class="tablas tb-Gral-cont">
<%
' tabla tb-Gral-cont
'CLASS = tablas


pIdInm = rsInmueble("id")

pEdif = ""
fecha_disp = rsInmueble("disponible_fecha")
''
set rsPlantas = Server.CreateObject("ADODB.Recordset")

total_sup_disp = 0


sql = "SELECT * FROM c_inmuebles_plantas WHERE id_inmueble=" & pIdInm
if pEdif="" then
	sql = sql & " AND (edificio IS NULL OR edificio='')"
else
	sql = sql & " AND (edificio='" & pEdif & "')"
end if
sql = sql & " ORDER BY orden DESC"
rsPlantas.Open sql, session("connPW")

'rsPlantas.close
'set rsPlantas = nothing

'set rsPlDisp = nothing

'https://www.adipalaz.com/experiments/jquery/expand.html

if not rsPlantas.eof then %>
<h3>Plantas y Disponibilidad:</h3>
<div class="row">
  <div class="col-sm-8">
<table class="tb-Gral tb-info">
<thead>
    <tr>
        <th>&nbsp;</th>
        <th></th>
        <th></th>
        <th></th>
        <th></th>
		<th></th>
		<th></th>
    </tr>
    <tr>
        <th>Plt</th>				
        <th>Uso</th>
        <th>M&sup2; SBA</th>
        <th>M&sup2; Catastro</th>
		<th>SubTotal</th>
        <th>plzs/habs.</th>
		<th>Ocupante</th>
    </tr>
</thead>
<tbody>
<%
primero = true

do while not rsPlantas.eof
  	cPlanta="" & rsPlantas("planta")
  	'if isnumeric(cPlanta) or trim(dPlanta)="BAJA" then
	'	cPlanta = "Planta " & cPlanta
	'end if
	
	'SBA	
	if isnull(rsPlantas("Superficie")) then
		ver_sba = "&nbsp;"
	else
		ver_sba = rsPlantas("Superficie")
		if ver_sba>0 then 
			ver_sba = FormatNumber(ver_sba, 0)
			if rsPlantas("SobreRasante") then
				sbaSR = sbaSR + rsPlantas("Superficie")
			else
				sbaBR = sbaBR + rsPlantas("Superficie")
			end if

		else
			ver_sba = "&nbsp;"
		end if
	end if
	
	'S.Cons	
	if isnull(rsPlantas("scons")) then
		ver_cons = "&nbsp;"
	else
		ver_cons = rsPlantas("scons")
		if ver_cons>0 then 
			ver_cons = FormatNumber(ver_cons, 0)
			if rsPlantas("SobreRasante") then
				consSR = consSR  + rsPlantas("scons")
			else
				consBR = consBR + rsPlantas("scons")
			end if
		else
			ver_cons = "&nbsp;"
		end if
	end if
		
	'disponibles
	if ver_disponibles then
		
		sup_disp = ""
		renta_disp = ""
		fecha_ver = ""
		
		sup_disp = rsPlantas("disponible_superficie")
		if sup_disp>0 then 
			sup_disp=FormatNumber(sup_disp, 0)
			total_sup_disp = total_sup_disp + rsPlantas("disponible_superficie")
		end if
		'if sup_disp<>"" then sup_disp = sup_disp & "&nbsp;m&sup2;"
		
		renta_disp = rsPlantas("disponible_renta")
		if renta_disp<>"" then renta_disp = FormatNumber(renta_disp, 2) & "&nbsp;&euro;/m&sup2;"
		
		if sup_disp<>"" or renta_disp<>"" then fecha_ver = fecha_disp
		
	end if
	if rsPlantas("plazas")<>"" then
		total_plazas = total_plazas + rsPlantas("plazas")
	end if
	
	if rsPlantas("SobreRasante") then
		clase = ""
    else
		clase = "bjRasante"
		if primero then
			clase = clase & " first"
			primero = false
		end if
    end if 
	%>
    <tr class="<%= clase %>">
        <td><%= cPlanta %><% if rsPlantas("logo")<>"" then %> <img width="21" src="../../fotos/inquilinos/<%=rsPlantas("logo")%>.png" /> <%end if %></td>
        <td><%= lcase(rsPlantas("seccion")) %></td>
        <td><%= ver_sba %></td>
        <td><%= ver_cons %></td>
		<td><%= rsPlantas("subtotal") %></td>
        <td><%= rsPlantas("plazas") %></td>
		<td><small><%=rsPlantas("logo")%></small></td>
        <!-- td><%
	'if rsPlantas("SobreRasante") then
	'	response.Write("&nbsp;")
    'else
	'	response.Write("B/R")
    'end if 
    %></td -->
    </tr>
<% rsPlantas.movenext
loop

sbaTotal = sbaBR + sbaSR
if sbaTotal = 0 then 
	if isnull(rsInmueble("superf_br_alq")) then 
		sbaTotal = "&nbsp;"
	else
		sbaTotal = FormatNumber(rsInmueble("superf_br_alq"), 0)
	end if
else
	sbaTotal = FormatNumber(sbaTotal, 0)
end if

consTotal = consBR + consSR
if consTotal = 0 then 
	consTotal = "&nbsp;"
else
	consTotal = FormatNumber(consTotal, 0)
end if
%>
    <tr class="total">
        <td>TOTAL:</td>
        <td></td>
        <td><%= sbaTotal %></td>
        <td><%= consTotal %></td>
        <td></td>
    </tr>
	<tr class="total01">
        <td>Total S/R:</td>
        <td></td>
        <td><%= FormatNumber(sbaSR, 0) %></td>
        <td></td>
        <td></td>
    </tr>
    <tr class="total01">
        <td>Total B/R:</td>
        <td></td>
        <td><%= FormatNumber(sbaBR, 0) %></td>
        <td><%'= consTotal %></td>
        <td></td>
    </tr>
<%''''''''''''''
set rsResumen = Server.CreateObject("ADODB.Recordset")
sql = "SELECT id_seccion, seccion, SUM(Superficie) AS total_sba, SUM(scons) AS total_cons, SUM(plazas) AS total_plazas, seccion_orden FROM c_inmuebles_plantas"
', SobreRasante
sql = sql & " WHERE id_inmueble=" & pIdInm
if pEdif="" then
	sql = sql & " AND (edificio IS NULL OR edificio='')"
else
	sql = sql & " AND (edificio='" & pEdif & "')"
end if
sql = sql & " GROUP BY id_seccion, seccion, seccion_orden"	', SobreRasante
sql = sql & " ORDER BY seccion_orden"	', SobreRasante DESC

rsResumen.Open sql, session("connPW")

do while not rsResumen.eof 
	secc = lcase(rsResumen("seccion"))
	etiqueta = ""
	
	total_sba = rsResumen("total_sba")
	total_cons = rsResumen("total_cons")
	
	if total_sba>0 or total_cons>0 then
		etiqueta = "&nbsp;m&sup2; "
	end if
	'if rsResumen("SobreRasante") then
	'	etiqueta = etiqueta & "&nbsp;S/R" 
	'else
	'	etiqueta = etiqueta & "&nbsp;B/R" 
	'end if
	
	if total_sba=0 or isnull(total_sba) then
		total_sba = "&nbsp;"
	else
		total_sba = FormatNumber(total_sba, 0)
	end if
	
	if total_cons=0 or isnull(total_cons) then
		total_cons = "&nbsp;"
	else
		total_cons = FormatNumber(total_cons, 0)
	end if
%>
<tr class="total02">
    <td></td>
    <td><%= secc %></td>
    <td><%= total_sba %></td>
    <td><%= total_cons %></td>
    <td><%= rsResumen("total_plazas") %></td>
</tr>
	<%
	rsResumen.movenext
loop %>
</table>
  </div>
  <div class="col-sm-4">
<%
rsPlantas.movefirst

'on error resume next
%>
<!-- disponiblilidad -->
<table class="tb-Gral dispon">
<thead>
    <tr>
    	<th colspan="2">Disponibilidad</th>
    </tr>
    <tr>
        <th>M&sup2;</th>
        <th>Renta salida</th>
    </tr>
</thead>
<tbody>    
<% 
primero = true
do while not rsPlantas.eof 
  	
	'sup_ver = rsPlantas("Superficie")
	'if sup_ver>0 then 
	'	sup_ver = FormatNumber(sup_ver, 0)
	'else
	'	sup_ver = "&nbsp;"
	'end if
	
	'disponibles
	sup_disp = ""
	renta_disp = ""
	fecha_ver = ""
	
	sup_disp = rsPlantas("disponible_superficie")
	if sup_disp>0 then 
		sup_disp=FormatNumber(sup_disp, 0)
		total_sup_disp = total_sup_disp + rsPlantas("disponible_superficie")
	else
		sup_disp=""
	end if
	'if sup_disp<>"" then sup_disp = sup_disp & "&nbsp;m&sup2;"
	
	renta_disp = rsPlantas("disponible_renta")
	if renta_disp<>"" then renta_disp = FormatNumber(renta_disp, 2) & "&nbsp;&euro;/m&sup2;"
	
	if sup_disp<>"" or renta_disp<>"" then fecha_ver = fecha_disp
	
	if rsPlantas("SobreRasante") then
		clase = ""
    else
		clase = "bjRasante"
		if primero then
			clase = clase & " first"
			primero = false
		end if
    end if 
	%>
    <tr class="<%= clase %>">
        <td><%= sup_disp %></td>
        <td><%= renta_disp %></td>
    </tr>
	<% rsPlantas.movenext
loop %>
<% 
if rsInmueble("disponible_fecha")="" or isnull(rsInmueble("disponible_fecha")) then
	ver_porcentaje = false
else
	'if rsInmueble("disponible_superficie")="" or isnull(rsInmueble("disponible_superficie")) then
	'	if (sbaBR+sbaSR)=0 then
	'		ver_porcentaje = false
	'	else
	'		ver_porcentaje = true
	'		porcentaje = 100 - 100 * total_sup_disp/(sbaBR+sbaSR)
	'		porcentaje_informa = "100 - 100 * total_sup_disp/(sbaBR+sbaSR)"
	'		
	'	end if
	'else
		ver_porcentaje = true
		sup_tot = sbaBR + sbaSR
		if sup_tot=0 then sup_tot = consSR + consBR 
		'porcentaje = rsInmueble("superf_br_alq")
		if isnull(rsInmueble("superf_br_alq"))then 
			porcentaje = 100 - 100 * clng(total_sup_disp/sup_tot)
			porcentaje_informa = "100 - 100 * clng(total_sup_disp/sup_tot)"
		else
			porcentaje = 100 - 100 * clng(total_sup_disp)/clng(rsInmueble("superf_br_alq"))
			porcentaje_informa = "100 - 100 * clng(total_sup_disp)/clng(rsInmueble('superf_br_alq'))"
			
		end if
	'end if
end if %>
	<!-- total-->
    <tr>
        <td colspan="2" class="total-disp">
        <% if rsInmueble("disponible_fecha")="" or isnull(rsInmueble("disponible_fecha")) then %>
        	<p>N/D</p>
        <% else %>
            <p><% if fecha_disp<>"" then %><%= FormatNumber(rsInmueble("disponible_max"), 0) %> m² disponibles @ <%= fecha_disp %><% end if %></p>
            <p><%= FormatNumber(porcentaje, "0") %>&nbsp;% alquilado</p>
            <p>
        	<% if not(isnull(rsInmueble("disponible_min") )) then %>
            <span>m&iacute;n: <strong><%= FormatNumber(rsInmueble("disponible_min"), 0) %> m&sup2;</strong></span> 
            <% end if %>
            
            <% if not(isnull(rsInmueble("disponible_max") )) then %>
            <span>m&aacute;x.: <strong><%= FormatNumber(rsInmueble("disponible_max"), 0) %> m&sup2;</strong></span>
            <% end if %>
        	</p>
        <% end if %>
        </td>
    </tr>
    
	<% if request.Cookies("dev")="__" then %>
    <tr >
        <td colspan="2" class="total-disp">
        	<p><%= porcentaje_informa %> = <%= porcentaje %></p>
            <p><%= clng(100*(1-clng(total_sup_disp)/clng(rsInmueble("superf_br_alq")))) %></p>
            <p>sup_tot: <%= sup_tot %></p>
        	<p>bd.superf_br_alq: <%= rsInmueble("superf_br_alq") %></p>
        	<p>total_sup_disp: <%= total_sup_disp %></p>
        </td>
    </tr>
    <% end if %>
    
</tbody>
</table>
<!-- disponiblilidad -->
  </div>
</div><!--ROW-->
<% end if 

' ¿¿¿???? da error en inmuebles cuando no hay tabla de plantas
'rsResumen.close
'set rsResumen=nothing
%>
	</div>
</div>

<% sub zzz__ResumenPlantas	
set rsResumen = Server.CreateObject("ADODB.Recordset")
sql = "SELECT id_seccion, seccion, SobreRasante, SUM(Superficie) AS total_sba,  SUM(scons) AS total_cons, SUM(plazas) AS total_plazas, seccion_orden FROM c_inmuebles_plantas"
sql = sql & " WHERE id_inmueble=" & pIdInm
if pEdif="" then
	sql = sql & " AND (edificio IS NULL OR edificio='')"
else
	sql = sql & " AND (edificio='" & pEdif & "')"
end if
sql = sql & " GROUP BY id_seccion, seccion, SobreRasante, seccion_orden"
sql = sql & " ORDER BY seccion_orden"

rsResumen.Open sql, session("connPW")
%>
<table class="tblPlantas" cellspacing="0" width="100%">
<% do while not rsResumen.eof 
	secc = lcase(rsResumen("seccion"))
	
	valor = rsResumen("total_sba")
	if valor>0 then
		etiqueta = "&nbsp;m&sup2; "
	end if
	if rsResumen("SobreRasante") then
		etiqueta = etiqueta & "&nbsp;S/R" 
	else
		etiqueta = etiqueta & "&nbsp;B/R" 
	end if
	
	valor = FormatNumber(valor, 0)
%>
<tr>
    <td width="113" nowrap="nowrap"><%= secc %></td>
    <td width="40" align="right"><%= valor %></td>
    <td nowrap="nowrap"><%= etiqueta %></td>
</tr>
<% if rsResumen("total_plazas")>0 then 
		select case secc
		case "parking"
			etiqueta = "&nbsp;plazas"
		case "hotel"
			etiqueta = "&nbsp;habitaciones"
		end select
		%>
<tr>
    <td></td>
    <td align="right"><%= rsResumen("total_plazas") %></td>
    <td><%= etiqueta %></td>
</tr>
<% end if
	rsResumen.movenext
loop %>
</table>

<% 
rsResumen.close
set rsResumen=nothing
end sub %>