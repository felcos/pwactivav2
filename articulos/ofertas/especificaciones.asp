<% select case pRS("id_tipo_oferta") %>
<% case "1"	'CENTROS_COMERCIALES" %>
    <table border="0" cellspacing="2" cellpadding="0">
    <% if pRS("ANO_CONSTRUCCION")<> "" and pRS("ANO_CONSTRUCCION")<> 0 then %>
      <tr>
        <td><div align="right">A&ntilde;o construcci&oacute;n</div></td>
        <td><div align="right">
    <% numero=pRS("ANO_CONSTRUCCION")
    if numero =0 then
        response.write "n/d"
    else
        response.write formatnumber(numero,0)
    end if %>
        </div>
        </td>
      </tr>
    <% end if 'ANO_CONSTRUCCION %>
    
    <% if pRS("NUMERO_LOCALES")<>"0" then %> 
      <tr>
        <td><div align="right">N&uacute;mero locales:</div></td>
        <td><div align="right"><%=pRS("NUMERO_LOCALES")%></div></td>
      </tr>
    <% End if %> 
    <% if pRS("NUMERO_GARAJES")<>"0" then %>
      <tr>
        <td><div align="right">Plazas de garaje:</div></td>
        <td><div align="right"><%=pRS("NUMERO_GARAJES")%></div></td>
      </tr>
    <% End if %>
    <% if pRS("HIPERMERCADO")=true then %> 
      <tr>
        <td><div align="right">Hipermercado:</div></td>
        <td><div align="right"><img src="/img/tablas/ok.gif" width="14" height="10"></div></td>
      </tr>
    <% End if %>
    <% if pRS("MULTICINES")=true then %>
      <tr>
        <td><div align="right">Multicines:</div></td>
        <td><div align="right"><img src="/img/tablas/ok.gif" width="14" height="10"></div></td>
      </tr>
    <% End if %>
    
    </table>
<% case "2"	'HOTELES" %>
    <table border="0" cellspacing="2" cellpadding="0">
    <% if pRS("ANO_CONSTRUCCION")<> "" and pRS("ANO_CONSTRUCCION")<> 0 then %>
      <tr>
        <td align="right">A&ntilde;o construcci&oacute;n:</td>
        <td width="10"></td>
        <td><% numero=pRS("ANO_CONSTRUCCION")
    if numero =0 then
        response.write "n/d"
    else
        response.write formatnumber(numero,0)
    end if %></td>
      </tr>
    <% end if 'ANO_CONSTRUCCION %>
    <% if pRS("CATEGORIA") <> "" And pRS("CATEGORIA") <> "N/D" Then %> 
      <tr>
        <td align="right">Categor&iacute;a:</td>
        <td></td>
        <td><%=pRS("CATEGORIA")%></td>
      </tr>
    <% End if %> 
    <% if pRS("NUMERO_HABITACIONES")<>"0" then %>
    <tr>
        <td align="right">N&uacute;mero de habitaciones:</td>
        <td></td>
        <td><%=pRS("NUMERO_HABITACIONES")%></td>
      </tr>
    <% End if %> 
    <% if pRS("RESTAURANTE")=true then %>
      <tr>
        <td align="right">Restaurante:</td>
        <td></td>
        <td><img src="/img/tablas/ok.gif" width="14" height="10"></div></td>
      </tr>
    <% End if %>
    <% if pRS("AIRE_ACONDICIONADO")=true then %>
      <tr>
        <td align="right">Aire acondicionado:</td>
        <td></td>
        <td><img src="/img/tablas/ok.gif" width="14" height="10"></td>
      </tr>
    <% End if %>  
    </table>
	
<% case "3"	'LOCALES_COMERCIALES" %>
    <table border="0" cellspacing="2" cellpadding="0">
    <% if pRS("ANO_CONSTRUCCION")<> "" and pRS("ANO_CONSTRUCCION")<> 0 then %>
      <tr>
        <td><div align="right">A&ntilde;o construcci&oacute;n</div></td>
        <td><div align="right">
    <% numero=pRS("ANO_CONSTRUCCION")
    if numero =0 then
        response.write "n/d"
    else
        response.write formatnumber(numero,0)
    end if %>
        </div></td>
      </tr>
    <% end if 'ANO_CONSTRUCCION %>
    <% if pRS("AIRE_ACONDICIONADO")=true then %> 
      <tr>
        <td><div align="right">Aire acondicionado:</div></td>
        <td><div align="right"><img src="/img/tablas/ok.gif" width="14" height="10"></div></td>
      </tr>
    <% End if %> 
    <% if pRS("SALIDA_HUMOS")=true then %> 
      <tr>
        <td><div align="right">Salida humos:</div></td>
        <td><div align="right"><img src="/img/tablas/ok.gif" width="14" height="10"></div></td>
      </tr>
    <% End if %>
    <% if pRS("FACHADA")=true then %> 
      <tr>
        <td><div align="right">Fachada:</div></td>
        <td><div align="right"><img src="/img/tablas/ok.gif" width="14" height="10"></div></td>
      </tr>
    <% End if %>  
    
    </table>
	
<% case "4"	'NAVES_INDUSTRIALES" %>
    <table border="0" cellspacing="2" cellpadding="0">
    <% if pRS("ANO_CONSTRUCCION")<> "" and pRS("ANO_CONSTRUCCION")<> 0 then %>
      <tr>
        <td align="right">A&ntilde;o construcci&oacute;n: </td>
        <td width="4"></td>
        <td>
    <% numero=pRS("ANO_CONSTRUCCION")
    if numero =0 then
        response.write "n/d"
    else
        response.write formatnumber(numero,0)
    end if %>	</td>
      </tr>
    <% end if 'ANO_CONSTRUCCION %>
    <% if pRS("CARGA_DESCARGA")=true then %>  
      <tr>
        <td align="right">Carga y descarga: </td>
        <td></td>
        <td><img src="/img/tablas/ok.gif" width="14" height="10"></td>
      </tr>
    <% End if %> 
    <% if pRS("NUMERO_PUERTAS_CARGA_DESCARGA")<>"0" then %>
      <tr>
        <td align="right">Puertas carga y descarga: </td>
        <td></td>
        <td><%=pRS("NUMERO_PUERTAS_CARGA_DESCARGA")%></td>
      </tr>
    <%End if%>
    <%if pRS("ALTURA_INFERIOR")<>"0" then%>
      <tr>
        <td align="right">Altura inferior: </td>
        <td></td>
        <td><%=pRS("ALTURA_INFERIOR")%>&nbsp;m</td>
      </tr>
    <% End if %>
    <% if pRS("ALTURA_SUPERIOR")<>"0" then %>
      <tr>
        <td align="right">Altura superior: </td>
        <td></td>
        <td><%=pRS("ALTURA_SUPERIOR")%>&nbsp;m</td>
      </tr>
    <% End if %> 
    <% if pRS("ALTURA_LIBRE")<>"0" then %> 
      <tr>
        <td align="right">Altura libre: </td>
        <td></td>
        <td><%=pRS("ALTURA_LIBRE")%>&nbsp;m</div></td>
      </tr>
    <% End if %> 
    <% if pRS("AIRE_ACONDICIONADO")=true then %>
      <tr>
        <td align="right">Aire acondicionado: </td>
        <td></td>
        <td><img src="/img/tablas/ok.gif" width="14" height="10"></td>
      </tr>
    <% End if %> 
    </table>
	
<% case "5"	'OFICINAS" %>
<table border="0" cellspacing="2" cellpadding="0">
	<% if 1=2 then %><tr><td colspan="3">OFICINAS</td></tr><% end if %>
    <% if pRS("ANO_CONSTRUCCION")<> "" and pRS("ANO_CONSTRUCCION")<> 0 then %>
      <tr>
        <td align="right">A&ntilde;o construcci&oacute;n:</td>
        <td width="10"></td>
        <td><% numero=pRS("ANO_CONSTRUCCION")
    if numero =0 then
        response.write "n/d"
    else
        response.write formatnumber(numero,0)
    end if %></td>
      </tr>
    <% end if 'ANO_CONSTRUCCION %>
    <% if pRS("AIRE_ACONDICIONADO")=true then %>  
      <tr>
        <td align="right">Aire acondicionado:</td>
        <td></td>
        <td><img src="/img/tablas/ok.gif" width="14" height="10"></td>
      </tr>
    <% end if 	'AIRE_ACONDICIONADO %>
    <% if pRS("FALSO_TECHO")=true then %>
      <tr>
        <td align="right">Falso techo::</td>
        <td></td>
        <td><img src="/img/tablas/ok.gif" width="14" height="10"></td>
      </tr>
    <% End if %>
    <% if pRS("SUELO_TECNICO")=true then %>
      <tr>
        <td align="right">Suelo T&eacute;cnico:</td>
        <td></td>
        <td><img src="/img/tablas/ok.gif" width="14" height="10"></td>
      </tr>
    <% End if %>
    <% if pRS("EDIFICIO_EXCLUSIVO")=true then %> 
      <tr>
        <td align="right">Edificio exclusivo:</td>
        <td></td>
        <td><img src="/img/tablas/ok.gif" width="14" height="10"></td>
      </tr>
    <% End if %>
    <% if pRS("SEGURIDAD_24H")=true then %> 
      <tr>
        <td align="right">Seguridad 24h:</td>
        <td></td>
        <td><img src="/img/tablas/ok.gif" width="14" height="10"></td>
      </tr>
    <% End if %>
    <% if pRS("EXTERIOR")=true then %> 
      <tr>
        <td align="right">Exterior:</td>
        <td></td>
        <td><img src="/img/tablas/ok.gif" width="14" height="10"></td>
      </tr>
    <% End if %>
    </table>
    
<% case "6"	'PARQUES_COMERCIALES" %>
<table border="0" cellspacing="2" cellpadding="0">
	<% if pRS("ANO_CONSTRUCCION")<> "" and pRS("ANO_CONSTRUCCION")<> 0 then %>
      <tr>
        <td align="right">A&ntilde;o construcci&oacute;n: </td>
        <td width="4"></td>
        <td>
    <% numero=pRS("ANO_CONSTRUCCION")
    if numero =0 then
        response.write "n/d"
    else
        response.write formatnumber(numero,0)
    end if %>
        </td>
      </tr>
    <% end if 'ANO_CONSTRUCCION %>
    </table>
    
<% case "7"	'POLIGONOS_INDUSTRIALES" %>
    <table border="0" cellspacing="2" cellpadding="0">
    <% if pRS("ANO_CONSTRUCCION")<> "" and pRS("ANO_CONSTRUCCION")<> 0 then %>
      <tr>
        <td align="right">A&ntilde;o construcci&oacute;n: </td>
        <td width="4"></td>
        <td>
    <% numero=pRS("ANO_CONSTRUCCION")
    if numero =0 then
        response.write "n/d"
    else
        response.write formatnumber(numero,0)
    end if %>
        </td>
      </tr>
    <% end if 'ANO_CONSTRUCCION %>
    </table>
    
<% case "8"	'SOLARES %>
    <table border="0" cellspacing="2" cellpadding="0">
      <tr>
        <td align="right">Superficie total: </td>
        <td width="4"></td>
        <td>
    <% numero=pRS("METROS_CUADRADOS")
    if numero =0 then
        response.write "n/d"
    else
        response.write formatnumber(numero,0)& "&nbsp;M2"
    end if %>	</td>
      </tr>
    <% 'if not(isnull(pRS("SUPERFICIE_EDIFICABLE"))) and pRS("SUPERFICIE_EDIFICABLE")<>"" and pRS("SUPERFICIE_EDIFICABLE")>0 then %>
      <tr>
        <td align="right" nowrap="nowrap">Superficie edificable: </td>
        <td></td>
        <td>
    <% 
    if isnull(pRS("SUPERFICIE_EDIFICABLE")) or pRS("SUPERFICIE_EDIFICABLE")="" then
        response.write "n/d"
    else
        numero=pRS("SUPERFICIE_EDIFICABLE")
        if numero =0 then
            response.write "n/d"
        else
            response.write formatnumber(numero,0)& "&nbsp;M2"
        end if
    end if
    %>
        </td>
      </tr>
    <% 'end if 'SUPERFICIE_EDIFICABLE %>
    <% if pRS("ID_TIPO_USO")>0 then 
        txt=txtBD(pRS("TIPOUSO"))
        txt=replace(txt, "/", " / ")
        txt=VERSALITA_TODO(txt)
        %>
      <tr>
        <td align="right" valign="top">Uso: </td>
        <td></td>
        <td><%= txt %></td>
      </tr>
    <% end if 'TIPOUSO %>
    </table>
    
<% case "9"	'VIVIENDAS_RESIDENCIALES %>
    <table border="0" cellspacing="2" cellpadding="0">
    <% if pRS("tipo_vivienda_es")<> "N/D" then %>
      <tr>
        <td align="right">Tipo de vivienda:</td>
        <td width="10"></td>
        <td><%= pRS("tipo_vivienda_es") %></td>
      </tr>
    <% end if 'TIPO VIVIENDA %>
    <% 'if pRS("ANO_CONSTRUCCION")<> "" and pRS("ANO_CONSTRUCCION")<> 0 then %>
      <tr>
        <td align="right">A&ntilde;o construcci&oacute;n:</td>
        <td width="10"></td>
        <td>
    <% 
    numero=pRS("ANO_CONSTRUCCION")
    if numero=0 or isnull(numero) then
        response.write "n/d"
    else
        response.write formatnumber(numero,0)
    end if %>
        </td>
      </tr>
    <% 'end if 'ANO_CONSTRUCCION %>
    <% if pRS("NUMERO_HABITACIONES")<>"0" then %>
      <tr>
        <td align="right">N&uacute;mero de habitaciones:</td>
        <td width="10"></td>
        <td><%=pRS("NUMERO_HABITACIONES")%></td>
      </tr>
    <% End if %>
    <% IF 1=2 THEN %>
    <% if pRS("NUMERO_BANOS")<>"0" then %>
    <tr>
        <td align="right">N&uacute;mero de Ba&ntilde;os: </td>
        <td width="10"></td>
        <td><%=pRS("NUMERO_BANOS")%></td>
      </tr>
    <% End if %> 
    <% END IF %>
    <% if pRS("SUELOS")=true then %>
    <tr>
        <td align="right">Suelos:</td>
        <td width="10"></td>
        <td><img src="/img/tablas/ok.gif" width="14" height="10"></td>
      </tr>
    <% End if %>
    <% if pRS("AIRE_ACONDICIONADO")=true then %>
      <tr>
        <td align="right">Aire acondicionado:</td>
        <td width="10"></td>
        <td><img src="/img/tablas/ok.gif" width="14" height="10"></td>
      </tr>
    <% end if 	'AIRE_ACONDICIONADO %>
    <% if pRS("EXTERIOR")=true then %> 
      <tr>
        <td align="right">Exterior:</td>
        <td width="10"></td>
        <td><img src="/img/tablas/ok.gif" width="14" height="10"></td>
      </tr>
    <% End if %>
    <% if pRS("CALEFACCION_CENTRAL")=true then %> 
      <tr>
        <td align="right">Calef.Central:</td>
        <td width="10"></td>
        <td><img src="/img/tablas/ok.gif" width="14" height="10"></td>
      </tr>
    <% End if %>
    <% if pRS("PORTERO_AUTOMATICO")=true then %> 
      <tr>
        <td align="right">Portero Automático:</td>
        <td width="10"></td>
        <td><img src="/img/tablas/ok.gif" width="14" height="10"></td>
      </tr>
    <% End if %>
    <% if pRS("VIDEOPORTERO")=true then %> 
      <tr>
        <td align="right">Videoportero:</td>
        <td width="10"></td>
        <td><img src="/img/tablas/ok.gif" width="14" height="10"></td>
      </tr>
    <% End if %>
    <% if pRS("PLAZA_GARAJE")=true then %> 
      <tr>
        <td align="right">Plaza Garage:</td>
        <td width="10"></td>
        <td><img src="/img/tablas/ok.gif" width="14" height="10"></td>
      </tr>
    <% End if %>
    
    </table>
    
<% end select %>