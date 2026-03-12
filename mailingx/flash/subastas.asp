<%' Subastas	
bloque="sub"
strin="sub"
ErrMesage=""
num_titulo=0
apart= ""

sql = "SELECT TITULO, Id_Concurso AS ID, FECHA_ACTUALIZACION, tipo_concurso AS APARTADO, icono_seccion "
sql = sql & "FROM C_CONCURSOS_DETALLE "
sql = sql & "WHERE ("
sql = sql & "FECHA_PUBLICACION BETWEEN CONVERT(DATETIME, '" & dateadd("d",-7, pFecha) & "', 103) AND CONVERT(DATETIME, '" & pFecha & "', 103) OR "
sql = sql & "FECHA_ACTUALIZACION BETWEEN CONVERT(DATETIME, '" & dateadd("d",-7, pFecha) & "', 103) AND CONVERT(DATETIME, '" & pFecha & "', 103)"
sql = sql & ") "

sql = sql & "AND web_es<>0"
sql = sql & " ORDER BY APARTADO "

test_inyeccion_sql sql
resultado.Open sql, session("connPW")	',1,1

if not resultado.eof then %>
<table width="100%"  border="0" cellpadding="0" cellspacing="0"  ><!-- interior-->     
    <!--  <tr>
        <td width="22" style="width:22px"></td>
        <td class=""></td>
    </tr>-->
    
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
	
</table>
<% end if
resultado.close %>