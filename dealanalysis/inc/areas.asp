<%
set rsAreas = Server.CreateObject("ADODB.Recordset")
link_areas = ""
for each elto in request.QueryString
	select case elto
	case "crit", "show"
	case else
		if link_areas<>"" then link_areas = link_areas & "&"
		link_areas = link_areas & elto & "=" & request.QueryString(elto)
	end select
next
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr><td>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="50"><strong>&Aacute;reas</strong></td>
    <td width="15"></td>
    <td id="titulo_areas"><strong>Principales calles de la zona</strong></td>
  </tr>
  <tr height="1" bgcolor="#333333">
    <td colspan="3"></td>
  </tr>
  <tr>
    <td valign="top"><table cellspacing="0" cellpadding="2" width="100%">
      <%
sql = "SELECT * FROM TIPOS_DE_AREAS WHERE ACTIVO<>0 AND ID>0 ORDER BY TIPOS_DE_AREAS.NOMBRE"
rsAreas.open sql, session("connPW")
do while not rsAreas.EOF %>
      <tr onMouseOver="this.bgColor='#F0F0F0';" style="CURSOR: hand" onMouseOut="this.bgColor='#FFFFFF';">
        <td onMouseOver="muestra('<%= rsAreas("NOMBRE") %>');" class="titpis">&nbsp;<strong><%= rsAreas("NOMBRE") %></strong></td>
      </tr>
      <% rsAreas.MoveNext 
loop 
rsAreas.close
%>
    </table></td>
    <td></td>
    <td valign="top"><table cellspacing="2" cellpadding="0" width="100%">
      <tr>
        <td><p id="texto">seleccionar para mostrar<br>
        </p>
              <% 'A1	
    sql = "SELECT TOP 12 ID_TIPO_AREA, TIPOAREA, NOMBRE_CALLE, COUNT(ID) AS ops FROM C_OPERACIONES WHERE ("
    sql = sql & "ID_LOCALIDAD=" & request.QueryString("localidad") & " AND ID_TIPO_AREA=1 AND "
    sql = sql & "(FECHA_PUBLICACION BETWEEN CONVERT(DATETIME, '01/01/2008', 103) AND CONVERT(DATETIME, '31/12/2010', 103))"
    sql = sql & ") GROUP BY NOMBRE_CALLE, ID_TIPO_AREA, TIPOAREA "
    sql = sql & "ORDER BY COUNT(ID) DESC"
	'response.Write(sql)
	'response.End()
	
    rsAreas.Open sql, session("connPW")
	texto0 = ""
	texto1 = ""
	texto2 = ""
	nn=0
	do while not rsAreas.eof
		if trim(rsAreas("NOMBRE_CALLE"))<>"" then
			select case nn mod 3
			case 0
				if texto0<>"" then texto0 = texto0 & "<br>"
				texto0 = texto0 & rsAreas("NOMBRE_CALLE")
			case 1
				if texto1<>"" then texto1 = texto1 & "<br>"
				texto1 = texto1 & rsAreas("NOMBRE_CALLE")
			case 2
				if texto2<>"" then texto2 = texto2 & "<br>"
				texto2 = texto2 & rsAreas("NOMBRE_CALLE")
			end select
		end if
		rsAreas.movenext
		nn=nn+1
	loop
	%>
          <p id="A1" style="display:none">  
          <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr valign="top">
              <td width="33%"><%= texto0 %></td>
              <td width="33%"><%= texto1 %></td>
              <td width="33%"><%= texto2 %></td>
            </tr>
          </table>
          <p></p>
          <%
	rsAreas.close
	%>
              <% 'A2	
    sql = "SELECT TOP 12 ID_TIPO_AREA, TIPOAREA, NOMBRE_CALLE, COUNT(ID) AS ops FROM C_OPERACIONES WHERE ("
    sql = sql & "ID_LOCALIDAD=" & request.QueryString("localidad") & " AND ID_TIPO_AREA=2 AND "
    sql = sql & "(FECHA_PUBLICACION BETWEEN CONVERT(DATETIME, '01/01/2008', 103) AND CONVERT(DATETIME, '31/12/2010', 103))"
    sql = sql & ") GROUP BY NOMBRE_CALLE, ID_TIPO_AREA, TIPOAREA "
    sql = sql & "ORDER BY COUNT(ID) DESC"
	test_inyeccion_sql sql
    rsAreas.Open sql, session("connPW")
	texto0 = ""
	texto1 = ""
	texto2 = ""
	nn=0
	do while not rsAreas.eof
		if trim(rsAreas("NOMBRE_CALLE"))<>"" then
			select case nn mod 3
			case 0
				if texto0<>"" then texto0 = texto0 & "<br>"
				texto0 = texto0 & rsAreas("NOMBRE_CALLE")
			case 1
				if texto1<>"" then texto1 = texto1 & "<br>"
				texto1 = texto1 & rsAreas("NOMBRE_CALLE")
			case 2
				if texto2<>"" then texto2 = texto2 & "<br>"
				texto2 = texto2 & rsAreas("NOMBRE_CALLE")
			end select
		end if
		rsAreas.movenext
		nn=nn+1
	loop
	%>
          <p id="A2" style="display:none">  
          <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr valign="top">
              <td width="33%"><%= texto0 %></td>
              <td width="33%"><%= texto1 %></td>
              <td width="33%"><%= texto2 %></td>
            </tr>
          </table>
          <p></p>
          <%
	rsAreas.close
	%>
              <% 'A3	
    sql = "SELECT TOP 12 ID_TIPO_AREA, TIPOAREA, NOMBRE_CALLE, COUNT(ID) AS ops FROM C_OPERACIONES WHERE ("
    sql = sql & "ID_LOCALIDAD=" & request.QueryString("localidad") & " AND ID_TIPO_AREA=4 AND "
    sql = sql & "(FECHA_PUBLICACION BETWEEN CONVERT(DATETIME, '01/01/2008', 103) AND CONVERT(DATETIME, '31/12/2010', 103))"
    sql = sql & ") GROUP BY NOMBRE_CALLE, ID_TIPO_AREA, TIPOAREA "
    sql = sql & "ORDER BY COUNT(ID) DESC"
    test_inyeccion_sql sql
	rsAreas.Open sql, session("connPW")
	texto0 = ""
	texto1 = ""
	texto2 = ""
	nn=0
	do while not rsAreas.eof
		if trim(rsAreas("NOMBRE_CALLE"))<>"" then
			select case nn mod 3
			case 0
				if texto0<>"" then texto0 = texto0 & "<br>"
				texto0 = texto0 & rsAreas("NOMBRE_CALLE")
			case 1
				if texto1<>"" then texto1 = texto1 & "<br>"
				texto1 = texto1 & rsAreas("NOMBRE_CALLE")
			case 2
				if texto2<>"" then texto2 = texto2 & "<br>"
				texto2 = texto2 & rsAreas("NOMBRE_CALLE")
			end select
		end if
		rsAreas.movenext
		nn=nn+1
	loop
	%>
          <p id="A3" style="display:none">  
          <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
              <td width="33%"><%= texto0 %></td>
              <td width="33%"><%= texto1 %></td>
              <td width="33%"><%= texto2 %></td>
            </tr>
          </table>
          <p></p>
          <%
	rsAreas.close
	%>
              <% 'DEC	
    sql = "SELECT TOP 12 ID_TIPO_AREA, TIPOAREA, NOMBRE_CALLE, COUNT(ID) AS ops FROM C_OPERACIONES WHERE ("
    sql = sql & "ID_LOCALIDAD=" & request.QueryString("localidad") & " AND ID_TIPO_AREA=7 AND "
    sql = sql & "(FECHA_PUBLICACION BETWEEN CONVERT(DATETIME, '01/01/2008', 103) AND CONVERT(DATETIME, '31/12/2010', 103))"
    sql = sql & ") GROUP BY NOMBRE_CALLE, ID_TIPO_AREA, TIPOAREA "
    sql = sql & "ORDER BY COUNT(ID) DESC"
    test_inyeccion_sql sql
	rsAreas.Open sql, session("connPW")
	texto0 = ""
	texto1 = ""
	texto2 = ""
	nn=0
	do while not rsAreas.eof
		if trim(rsAreas("NOMBRE_CALLE"))<>"" then
			select case nn mod 3
			case 0
				if texto0<>"" then texto0 = texto0 & "<br>"
				texto0 = texto0 & rsAreas("NOMBRE_CALLE")
			case 1
				if texto1<>"" then texto1 = texto1 & "<br>"
				texto1 = texto1 & rsAreas("NOMBRE_CALLE")
			case 2
				if texto2<>"" then texto2 = texto2 & "<br>"
				texto2 = texto2 & rsAreas("NOMBRE_CALLE")
			end select
		end if
		rsAreas.movenext
		nn=nn+1
	loop
	%>
          <p id="DEC" style="display:none">  
          <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr valign="top">
              <td width="33%"><%= texto0 %></td>
              <td width="33%"><%= texto1 %></td>
              <td width="33%"><%= texto2 %></td>
            </tr>
          </table>
          <p></p>
          <%
	rsAreas.close
	%>
              <% 'OUT	
    sql = "SELECT TOP 12 ID_TIPO_AREA, TIPOAREA, NOMBRE_CALLE, COUNT(ID) AS ops FROM C_OPERACIONES WHERE ("
    sql = sql & "ID_LOCALIDAD=" & request.QueryString("localidad") & " AND ID_TIPO_AREA=5 AND "
    sql = sql & "(FECHA_PUBLICACION BETWEEN CONVERT(DATETIME, '01/01/2008', 103) AND CONVERT(DATETIME, '31/12/2010', 103))"
    sql = sql & ") GROUP BY NOMBRE_CALLE, ID_TIPO_AREA, TIPOAREA "
    sql = sql & "ORDER BY COUNT(ID) DESC"
    test_inyeccion_sql sql
	rsAreas.Open sql, session("connPW")
	texto0 = ""
	texto1 = ""
	texto2 = ""
	nn=0
	do while not rsAreas.eof
		if trim(rsAreas("NOMBRE_CALLE"))<>"" then
			select case nn mod 3
			case 0
				if texto0<>"" then texto0 = texto0 & "<br>"
				texto0 = texto0 & rsAreas("NOMBRE_CALLE")
			case 1
				if texto1<>"" then texto1 = texto1 & "<br>"
				texto1 = texto1 & rsAreas("NOMBRE_CALLE")
			case 2
				if texto2<>"" then texto2 = texto2 & "<br>"
				texto2 = texto2 & rsAreas("NOMBRE_CALLE")
			end select
		end if
		rsAreas.movenext
		nn=nn+1
	loop
	%>
          <p id="OUT" style="display:none">  
          <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr valign="top">
              <td width="33%"><%= texto0 %></td>
              <td width="33%"><%= texto1 %></td>
              <td width="33%"><%= texto2 %></td>
            </tr>
          </table>
          <p></p>
          <%
	rsAreas.close
	%>
	<% 'PRIME	
    sql = "SELECT TOP 12 ID_TIPO_AREA, TIPOAREA, NOMBRE_CALLE, COUNT(ID) AS ops FROM C_OPERACIONES WHERE ("
    sql = sql & "ID_LOCALIDAD=" & request.QueryString("localidad") & " AND ID_TIPO_AREA=6 AND "
    sql = sql & "(FECHA_PUBLICACION BETWEEN CONVERT(DATETIME, '01/01/2008', 103) AND CONVERT(DATETIME, '31/12/2010', 103))"
    sql = sql & ") GROUP BY NOMBRE_CALLE, ID_TIPO_AREA, TIPOAREA "
    sql = sql & "ORDER BY COUNT(ID) DESC"
    test_inyeccion_sql sql
	rsAreas.Open sql, session("connPW")
	texto0 = ""
	texto1 = ""
	texto2 = ""
	nn=0
	do while not rsAreas.eof
		if trim(rsAreas("NOMBRE_CALLE"))<>"" then
			select case nn mod 3
			case 0
				if texto0<>"" then texto0 = texto0 & "<br>"
				texto0 = texto0 & rsAreas("NOMBRE_CALLE")
			case 1
				if texto1<>"" then texto1 = texto1 & "<br>"
				texto1 = texto1 & rsAreas("NOMBRE_CALLE")
			case 2
				if texto2<>"" then texto2 = texto2 & "<br>"
				texto2 = texto2 & rsAreas("NOMBRE_CALLE")
			end select
		end if
		rsAreas.movenext
		nn=nn+1
	loop
	%>
          <p id="PRIME" style="display:none">  
          <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr valign="top">
              <td width="33%"><%= texto0 %></td>
              <td width="33%"><%= texto1 %></td>
              <td width="33%"><%= texto2 %></td>
            </tr>
          </table>
          <p></p>
          <%
	rsAreas.close
	%>
      </td>
      </tr>
    </table></td>
  </tr>
</table>
	</td>
  </tr>
</table>
<%
set rsAreas = nothing

sub test_inyeccion_sql(xx)
end sub
%>
<script language="javascript">
function muestra(rArea) {
	document.getElementById('texto').innerHTML = document.getElementById(rArea).innerHTML
	document.getElementById('titulo_areas').innerHTML = '<strong>Principales calles de la zona  ' + rArea + '</strong>'
}
</script>
