<%' Estudios	
bloque="est"
strin="est"
ErrMesage=""
num_titulo=0
apart= ""

SQL_SELECT = "SELECT TITULO, ID, FECHA_ACTUALIZACION, TIPOSECCION AS APARTADO, TITULO_ING AS TITULO_AUX,"
SQL_SELECT = SQL_SELECT & "icono_seccion FROM C_NOTICIAS_INMOBILIARIAS "

SQL_WHERE = " WHERE "
SQL_WHERE = SQL_WHERE & "(FECHA_NOTICIA BETWEEN  CONVERT(DATETIME, '" & pFecha & "', 103) AND CONVERT(DATETIME, '" & pFecha & "', 103) OR "
SQL_WHERE = SQL_WHERE & "FECHA_ACTUALIZACION BETWEEN CONVERT(DATETIME, '" & pFecha & "', 103) AND CONVERT(DATETIME, '" & pFecha & "', 103)) "	
SQL_WHERE = SQL_WHERE & "AND TIPO_NOTICIA = 'E' "

SQL_ORDER = "ORDER BY TIPOSECCION "
%>
<table width="100%"  border="0" cellpadding="0" cellspacing="0"  ><!-- interior-->     
    <!--  <tr>
        <td width="22" style="width:22px"></td>
        <td class=""></td>
    </tr>-->
    
    <% 'nacional			
	SQL = SQL_SELECT & SQL_WHERE & "AND web_es <> 0 AND nacional=1 " & SQL_ORDER
	
	test_inyeccion_sql sql
	resultado.Open sql, session("connPW")	',1,1
	
	if not resultado.eof then %>
	<tr><!-- nacional -->
        <td colspan="2" valign="top" style="text-align: right; padding-bottom:5px;" class="line">
        <img src="/img/drop.png" style="vertical-align: top;"><span class="nacional"> Nacional</span>
        </td>
    </tr>
	<% apart=""
    do while not resultado.EOF
        if apart<>resultado("APARTADO") and resultado("APARTADO")<>"NO" then 
            %><tr><!-- sección -->
                <td colspan="2"><h3 class="tit_buscadores2"><%= resultado("APARTADO") %></h3></td>
            </tr><%
		end if
		apart=resultado("APARTADO")
        num_titulo=num_titulo+1
        enlace = enlace_base & "?" & strin & "=" & resultado("ID") & "&origen=DailyFlash&f=" & pFecha
        %>
        <tr><!-- artículo -->
            <td width="22" valign="top" class="cuadro"><input type="checkbox" name="<%=strin%>" value="<%= Resultado("ID") %>"></td>
            <td class="enlace"><a href="<%= enlace %>" target="_blank"><% Titulo(resultado) %></a></td>
        </tr>
        <% resultado.movenext
    loop %>
	<% end if
	resultado.close %>
    
    <% 'internacional		
	SQL = SQL_SELECT & SQL_WHERE & "AND web_es <> 0 AND (nacional<>1 OR nacional IS NULL) " & SQL_ORDER
	
	test_inyeccion_sql sql
	resultado.Open sql, session("connPW")	',1,1
	
	if not resultado.eof then %>
	<tr><!-- internacional -->
    	<td colspan="2" valign="top" style="text-align: right; padding-bottom:5px; " class="line">
        	<img src="/img/drop.png" style="vertical-align: top;"> <span class="nacional">Internacional</span>
        </td>
    </tr> 
    
	<% apart=""
	do while not resultado.EOF
		if apart<>resultado("APARTADO") and resultado("APARTADO")<>"NO" then 
			%><tr><!-- sección -->
                <td colspan="2"><h3 class="tit_buscadores2"><%= resultado("APARTADO") %></h3></td>
            </tr><%
		end if
		apart=resultado("APARTADO")
		num_titulo=num_titulo+1
		enlace = enlace_base & "?" & strin & "=" & resultado("ID") & "&origen=DailyFlash&f=" & pFecha
		%>
		<tr><!-- artículo -->
            <td width="22" valign="top" class="cuadro"><input type="checkbox" name="<%=strin%>" value="<%= Resultado("ID") %>"></td>
            <td class="enlace"><a href="<%= enlace %>" target="_blank"><% Titulo(resultado) %></a></td>
        </tr>
		<% resultado.movenext
	loop %>
    
	<% end if
    resultado.close %>

</table>
