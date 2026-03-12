<% if acceso_seccion then
	select case rsInmueble("id_tipo_inmueble") 
	case 1		'Centro Comercial % ><!-- include virtual="/infoinmuebles/inc/sup_cc.asp" -->< % 
		call superficies_cc
	case 2		'Hotel % ><!-- include virtual="/infoinmuebles/inc/sup_hotel.asp" -->< % 
		%><!--#include virtual="/info/inc/shared/estructura.asp" --><% 
		call superficies_hotel
	case 0		'Mixto 
			%><!--#include virtual="/info/inc/shared/estructura.asp" --><% 
	end select 
else %>
	<div class="bloqueRight ">
    	<h3>Plantas y Disponibilidad:</h3>
		<div class="alert azul">
			<div>
            	<p><img src="/img/lock.svg" width="14" height="14"/> Lo sentimos, pero esta informaci&oacute;n s&oacute;lo est&aacute; disponible para <a href="#" onclick="registro();">clientes</a>.</p>
                <p style="margin-top:10px;">Para ver las caracteristicas del inmueble, conocer los distintos usos y superficies, la distribución de plantas, etc... debe tener contratado <strong>Info-Inmuebles</strong>.</p>
				<p style="margin-top:10px;"><a href="#" class="simplemodal">M&aacute;s informaci&oacute;n &nbsp; &raquo; </a></p>
			</div>
		</div>
	</div>
<% end if %>

<% sub superficies_cc 
	if isnull(rsInmueble("superf_construida")) and isnull(rsInmueble("superf_br_alq")) and isnull(rsInmueble("plantas")) and isnull(rsInmueble("fecha_edif")) and isnull(rsInmueble("locales_ext")) then exit sub
	%>
<div class="bloqueRight superficie">
    <h3>Superficie</h3>
    <ul class="ulTabla">
		<% if not isnull(rsInmueble("superf_construida")) and rsInmueble("superf_construida")<>"" then %>
        <li><span>Superficie Construida:</span><span> <%= FormatNumber(rsInmueble("superf_construida"), 0) %> m&sup2;</span></li>
        <% end if %>
		<% if not isnull(rsInmueble("superf_br_alq")) and rsInmueble("superf_br_alq")<>"" then %>
        <li><span>Superficie Bruta Alquilable:</span><span> <%= FormatNumber(rsInmueble("superf_br_alq"), 0) %> m&sup2;</span></li>
        <% end if %>
		<% if not isnull(rsInmueble("superf_construida")) and  not isnull(rsInmueble("superf_br_alq")) then %>
        <li><span class="separador02"></span><span  class="separador02"></span></li>
        <% end if %>
		
        <% if not isnull(rsInmueble("plantas")) then
			if rsInmueble("plantas")<>"" and rsInmueble("plantas")>0 then %>
			<li><span>N&uacute;mero de Plantas:</span><span><%= rsInmueble("plantas") %></span></li>
			<li><span class="separador02"></span><span  class="separador02"></span></li>
			<% end if
		end if %>
        <% 
        Actual = Now()
        ActualYYYY=Year(Actual) 
        ActualMM=Month(Actual) 
        ActualYYYY2= (ActualYYYY * 100) + ActualMM
        c_fecha_edif=rsInmueble("fecha_edif")
        dispo=rsInmueble("disponible_superficie")

        if not isnull(rsInmueble("fecha_edif")) and rsInmueble("fecha_edif")<>"" then
        


        %>
        <li
        <% if c_fecha_edif>10000 then 
                            if c_fecha_edif>ActualYYYY2 then  %> style="background-color:#CCCCCC;" <% end if 
                            else 
                            if c_fecha_edif>ActualYYYY then  %> style="background-color:#CCCCCC;" <% end if 
                            end if %>
                            >
        <span>A&ntilde;o Apertura:</span><span>
                <% if c_fecha_edif>10000 then
                response.write mid(c_fecha_edif,5,2) + "/" + mid(c_fecha_edif,1,4)
                else
                response.write rsInmueble("fecha_edif")
                end if %>
                <% if c_fecha_edif>10000 then 
                if c_fecha_edif>ActualYYYY2 then  %> &nbsp;<img src="/img/underc.png" width="25"/> <% end if 
                else 
                if c_fecha_edif>ActualYYYY then  %> &nbsp;<img src="/img/underc.png" width="25"/> <% end if 
                end if %>

            </span></li>
         <% end if %>
        <% if not isnull(rsInmueble("fecha_renov")) and rsInmueble("fecha_renov")<>"" then %>
        <li><span>Fecha Remodelaci&oacute;n&nbsp;:</span><span><%= rsInmueble("fecha_renov") %></span></li>
        <% end if %>
        <li><span class="separador02"></span><span  class="separador02"></span></li>
        
        <% if not isnull(rsInmueble("fecha_ampliacion")) and rsInmueble("fecha_ampliacion")<>"" then %>
        <li><span>&Uacute;ltima Ampliaci&oacute;n:</span><span><%= rsInmueble("fecha_ampliacion") %></span></li>
        <li><span>Superficie Ampliada:</span><span><%= FormatNumber(rsInmueble("superf_ampliacion"), 0) %>&nbsp;m<sup>2</sup></span></li>
        <li><span class="separador02"></span><span  class="separador02"></span></li>
        <% end if %>
</ul>
<% if not (isnull(rsInmueble("locales_int")) or isnull(rsInmueble("locales_ext"))) then %>
<table class="tb-Gral tb-Superf">
<thead>
    <tr>
        <th></th>
        <th>interior</th>
        <th>exterior</th>
        <th>totales</th>        
    </tr>
</thead>
<tbody>
	
    <tr>
        <td>Locales Comerciales:</td>
        <td><%= FormatNumber(rsInmueble("locales_int"),0) %></td>
        <td><%= FormatNumber(rsInmueble("locales_ext"),0) %></td>
        <td><strong><%= FormatNumber(rsInmueble("locales_int") + rsInmueble("locales_ext"),0) %></strong></td>
    </tr>
    <% if (rsInmueble("parking_int")>0 AND rsInmueble("parking_ext")>0) then %>
    <tr>
        <td>Plazas de Parking:</td>
        <td><%= FormatNumber(rsInmueble("parking_int"),0) %></td>
        <td><%= FormatNumber(rsInmueble("parking_ext"),0) %></td>
        <td><strong><%= FormatNumber(rsInmueble("parking_int") + rsInmueble("parking_ext"),0) %></strong></td>
    </tr>
    <% end if %>
</tbody>
</table>
<% end if %>
</div>
<% end sub %>

<% sub superficies_hotel %>
<div class="bloqueRight superficie">
    <h3>Superficie</h3>
    <ul class="ulTabla">
		<% if not isnull(rsInmueble("superf_construida")) and rsInmueble("superf_construida")<>"" then %>
        <li><span>Superficie Construida:</span><span> <%= FormatNumber(rsInmueble("superf_construida"), 0) %> m&sup2;</span></li>
        <% end if %>
		<% if not isnull(rsInmueble("superf_br_alq")) and rsInmueble("superf_br_alq")<>"" then %>
        <li><span>Superficie Bruta Alquilable:</span><span> <%= FormatNumber(rsInmueble("superf_br_alq"), 0) %> m&sup2;</span></li>
        <% end if %>
		<% if not isnull(rsInmueble("superf_construida")) and  not isnull(rsInmueble("superf_br_alq")) then %>
        <li><span class="separador02"></span><span  class="separador02"></span></li>
        <% end if %>
		
		<% if not isnull(rsInmueble("plantas")) then
			if rsInmueble("plantas")<>"" and rsInmueble("plantas")>0 then %>
			<li><span>N&uacute;mero de Plantas:</span><span><%= rsInmueble("plantas") %></span></li>
			<li><span class="separador02"></span><span  class="separador02"></span></li>
			<% end if
		end if %>
        
        <% if not isnull(rsInmueble("fecha_ampliacion")) and rsInmueble("fecha_ampliacion")<>"" then %>
        <li><span>&Uacute;ltima Ampliaci&oacute;n:</span><span><%= rsInmueble("fecha_ampliacion") %></span></li>
        <li><span>Superficie Ampliada:</span><span><%= FormatNumber(rsInmueble("superf_ampliacion"), 0) %>&nbsp;m<sup>2</sup></span></li>
        <li><span class="separador02"></span><span  class="separador02"></span></li>
        <% end if %>
	</ul>
<% IF 1=2 THEN %>
    <!--
    <tr>
        <td>Locales Comerciales:</td>
        <%
		if isnull(rsInmueble("locales_int")) then
			locales_int = ""
		else
			locales_int = FormatNumber(rsInmueble("locales_int"),0)
		end if
		
		if isnull(rsInmueble("locales_ext")) then
			locales_ext = ""
		else
			locales_ext = FormatNumber(rsInmueble("locales_ext"),0)
		end if
		
		%>
        <td><%= locales_int %></td>
        <td><%= locales_ext %></td>
        <td><strong><%= locales_int + locales_ext %></strong></td>
    </tr>
    -->
    <%
		if isnull(rsInmueble("parking_int")) then
			parking_int = ""
		else
			parking_int = FormatNumber(rsInmueble("parking_int"),0)
		end if
		
		if isnull(rsInmueble("parking_ext")) then
			parking_ext = ""
		else
			parking_ext = FormatNumber(rsInmueble("parking_ext"),0)
		end if
		%>
    <% if parking_int<>"" then %>
    <table class="tb-Gral tb-Superf">
<thead>
    <tr>
        <th></th>
        <th>interior</th>
        <th>exterior</th>
        <th>totales</th>        
    </tr>
</thead>
<tbody>
    <tr>
        <td>Plazas de Parking:</td>
        <td><%= parking_int %></td>
        <td><%= parking_ext %></td>
        <td><strong><%= parking_int + parking_ext %></strong></td>
    </tr>
    <% end if %>
</tbody>
</table>

<% END IF %>
</div>
<% end sub %>

<% sub superficies_mixto 
end sub %>
