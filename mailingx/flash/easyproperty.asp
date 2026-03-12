<%' Ofertas	
bloque="ofe"
strin="ofe"
ErrMesage=""
num_titulo=0
apart= ""

sql = "SELECT * FROM anuncios_envio "
sql = sql & "WHERE ("

sql = sql & "(web_es<>0) AND ("
sql = sql & "(FECHA_PUBLICACION BETWEEN  CONVERT(DATETIME, '" & pFecha & "', 103) AND CONVERT(DATETIME, '" & pFecha & "', 103))"
sql = sql & " OR "
sql = sql & "(FECHA_ACTUALIZACION BETWEEN CONVERT(DATETIME, '" & pFecha & "', 103) AND CONVERT(DATETIME, '" & pFecha & "', 103)) "
sql = sql & "OR "
sql = sql & "NOT(FechaVisibleHasta < CONVERT(DATETIME, '" & pFecha & "', 103) OR FechaVisibleDesde > CONVERT(DATETIME, '" & pFecha & "', 103)) "
sql = sql & ")"
sql = sql & ") ORDER BY id_seccion, id_pais, provincia desc"

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
        enlace = "https://www.easyproperty.es/ofertas/?id=" & resultado("id") & "&origen=DailyFlash&f=" & pFecha
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