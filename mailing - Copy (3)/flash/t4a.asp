<%
        bloque="t4a"
        strin="t4a"		
        ErrMesage=""
        Seccion2="t4a"
        num_titulo=0
        apart= ""


        
        swMostrar = true

        SQL_SELECT = "SELECT * FROM View_Time4Change "
   
        
        SQL_WHERE = "  WHERE  vivo=1 and (fecha >= CONVERT(DATETIME, '" & pFecha & "', 103) AND fecha <= CONVERT(DATETIME, '" & pFecha & "', 103)) "
        SQL_WHERE = SQL_WHERE & "AND Vivo <> 0 "

        
        SQL_ORDER = "  "
        


sql = "SELECT * FROM View_Time4Change  WHERE vivo=1 and (fecha >= CONVERT(DATETIME, '" & pFecha & "', 103) AND fecha <= CONVERT(DATETIME, '" & pFecha & "', 103)) "
        


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

        num_titulo=num_titulo+1
        enlace = enlace_base & "?" & strin & "=" & resultado("id") & "&origen=DailyFlash&f=" & pFecha
        %>
        <tr><!-- artículo -->
            <td width="22" valign="top" class="cuadro"><input type="checkbox" name="<%=strin%>" value="<%= Resultado("id") %>"></td>
            <td class="enlace"><a href="<%= enlace %>" target="_blank"><% Titulot4ac(resultado) %></a></td>
        </tr>
        <% resultado.movenext
    loop %>
	
</table>
<% end if
resultado.close %>

<% sub Titulot4ac(byRef pRS)	
	IF len(resultado("TITULO"))<3 OR isnull(resultado("TITULO")) THEN 
		response.write pRS("Apellidos") & " " & pRS("Nombres")
	ELSE
		response.write pRS("TITULO")
	END IF
end sub %>