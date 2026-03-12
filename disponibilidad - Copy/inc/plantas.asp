<%
if request.Cookies("dev")="" then on error resume next
pIdInm = pRS("id")

pEdif = ""
fecha_disp = pRS("disponible_fecha")
''
set rsPlantas = Server.CreateObject("ADODB.Recordset")

total_sup_disp = 0


sql = "SELECT * FROM c_inmuebles_plantas WHERE id_inmueble=" & pIdInm
if pEdif="" then
	sql = sql & " AND (edificio IS NULL OR edificio='')"
else
	sql = sql & " AND (edificio='" & pEdif & "')"
end if

sql = sql & " AND disponible_superficie IS NOT NULL AND disponible_superficie>0"

sql = sql & " ORDER BY orden DESC"
rsPlantas.Open sql, session("connPW")

'rsPlantas.close
'set rsPlantas = nothing

'set rsPlDisp = nothing

'https://www.adipalaz.com/experiments/jquery/expand.html

if not rsPlantas.eof then %>
<div class="row">
  <div class="col-sm-8">
<table class="tb-Gral tb-info">
<thead>
    <tr>
        <th>&nbsp;</th>
        <th></th>
    </tr>
    <tr>
        <th>Plt</th>				
        <th>Uso</th>
    </tr>
</thead>
<tbody>
<% do while not rsPlantas.eof
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
        <td><%= cPlanta %></td>
        <td><%= lcase(rsPlantas("seccion")) %></td>
        <!-- td><%'= rsPlantas("plazas") %></td -->
    </tr>
<% rsPlantas.movenext
loop

sbaTotal = sbaBR + sbaSR
if sbaTotal = 0 then 
	if isnull(pRS("superf_br_alq")) then 
		sbaTotal = "&nbsp;"
	else
		sbaTotal = FormatNumber(pRS("superf_br_alq"), 0)
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
    </tr>
<% 'resumen
IF 1=2 THEN

set rsResumen = Server.CreateObject("ADODB.Recordset")
'sql = "SELECT id_seccion, seccion, SobreRasante, SUM(Superficie) AS total_sba, SUM(scons) AS total_cons, SUM(plazas) AS total_plazas, seccion_orden FROM c_inmuebles_plantas"
sql = "SELECT id_seccion, seccion, SobreRasante, SUM(disponible_superficie) AS total_disponible, SUM(plazas) AS total_plazas, seccion_orden FROM c_inmuebles_plantas"
sql = sql & " WHERE id_inmueble=" & pIdInm
if pEdif="" then
	sql = sql & " AND (edificio IS NULL OR edificio='')"
else
	sql = sql & " AND (edificio='" & pEdif & "')"
end if

sql = sql & " AND disponible_superficie IS NOT NULL AND disponible_superficie>0"

sql = sql & " GROUP BY id_seccion, seccion, SobreRasante, seccion_orden"
sql = sql & " ORDER BY seccion_orden, SobreRasante DESC"

rsResumen.Open sql, session("connPW")

do while not rsResumen.eof 
	secc = lcase(rsResumen("seccion"))
	etiqueta = ""
	
	'total_sba = rsResumen("total_sba")
	total_disponible = rsResumen("total_disponible")
	'total_cons = rsResumen("total_cons")
	
	'if total_sba>0 or total_cons>0 then
	if total_disponible>0 then
		etiqueta = "&nbsp;m&sup2; "
	end if
	if rsResumen("SobreRasante") then
		etiqueta = etiqueta & "&nbsp;S/R" 
	else
		etiqueta = etiqueta & "&nbsp;B/R" 
	end if
	
	if total_disponible=0 or isnull(total_disponible) then
		total_disponible = "&nbsp;"
	else
		total_disponible = FormatNumber(total_disponible, 0)
	end if
	
	'if total_sba=0 or isnull(total_sba) then
	'	total_sba = "&nbsp;"
	'else
	'	total_sba = FormatNumber(total_sba, 0)
	'end if
	'
	'if total_cons=0 or isnull(total_cons) then
	'	total_cons = "&nbsp;"
	'else
	'	total_cons = FormatNumber(total_cons, 0)
	'end if
%>
<tr class="total02">
    <td></td>
    <td><%= secc %></td>
    <!-- td><%'= total_disponible %></td -->
</tr>
<% if rsResumen("total_plazas")>0 then 
	'select case secc
	'case "parking"
	'	etiqueta = "plazas"
	'case "hotel"
	'	etiqueta = "habitaciones"
	'end select
	
	%>
<tr class="total02">
    <td></td>
    <td><%= rsResumen("total_plazas") %></td>
</tr>
<% end if
	rsResumen.movenext
loop 
END IF 'resumen
%>
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
<% do while not rsPlantas.eof 
  	
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
	%>
    <tr>
        <td><%= sup_disp %></td>
        <td><%= renta_disp %></td>
    </tr>
	<% rsPlantas.movenext
loop %>
<% 
if pRS("disponible_fecha")="" or isnull(pRS("disponible_fecha")) then
	ver_porcentaje = false
else
	'if pRS("disponible_superficie")="" or isnull(pRS("disponible_superficie")) then
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
		'porcentaje = pRS("superf_br_alq")
		if isnull(pRS("superf_br_alq")) then 
			porcentaje = 100 - 100 * clng(total_sup_disp/sup_tot)
			porcentaje_informa = "100 - 100 * clng(total_sup_disp/sup_tot)"
		else
			porcentaje = 100 - 100 * clng(total_sup_disp)/clng(pRS("superf_br_alq"))
			porcentaje_informa = "100 - 100 * clng(total_sup_disp)/clng(pRS('superf_br_alq'))"
		end if
	'end if

end if %>
	<!-- total-->
    <tr >
        <td colspan="2" class="total-disp">
        <p><% if fecha_disp<>"" then %><%= FormatNumber(pRS("disponible_max"), 0) %> m² disponibles @ <%= fecha_disp %><% end if %></p>
        <p><%= FormatNumber(porcentaje, "0") %>&nbsp;% alquilado</p>
        <p>
        	<% if not(isnull(pRS("disponible_min") )) then %>
            <span>m&iacute;n: <strong><%= FormatNumber(pRS("disponible_min"), 0) %> m&sup2;</strong></span> 
            <% end if %>
            
            <% if not(isnull(pRS("disponible_max") )) then %>
            <span>m&aacute;x.: <strong><%= FormatNumber(pRS("disponible_max"), 0) %> m&sup2;</strong></span>
            <% end if %>
        </p>
        </td>
    </tr>
    
	<% if request.Cookies("dev")="_" then %>
    <tr >
        <td colspan="2" class="total-disp">
        	<p><%= porcentaje_informa %> = <%= porcentaje %></p>
            <p><%= clng(100*(1-clng(total_sup_disp)/clng(pRS("superf_br_alq")))) %></p>
            <p>sup_tot: <%= sup_tot %></p>
        	<p>bd.superf_br_alq: <%= pRS("superf_br_alq") %></p>
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