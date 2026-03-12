<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
on error resume next
r_year = request.Form("resumen_y")
r_zona = request.Form("resumen_zona")
r_op = request.Form("resumen_op")

mes_reporte=11

if r_year = "" then r_year = 2021
if r_op = "" then r_op = "venta"
if r_zona = "" then r_zona = "eu+"

sql = "SELECT secciones_operaciones.NOMBRE AS seccion, secciones_operaciones.id, "		'OPERACIONES_DETALLE.id_seccion, 
sql = sql & "COUNT(DISTINCT OPERACIONES_DETALLE.id_operacion) AS ops, SUM(OPERACIONES_DETALLE.Superficie) AS sup "
sql = sql & "FROM OPERACIONES INNER JOIN "
sql = sql & "OPERACIONES_DETALLE ON OPERACIONES.ID = OPERACIONES_DETALLE.id_operacion INNER JOIN "
sql = sql & "TIPOS_DE_OPERACIONES ON OPERACIONES.ID_TIPO_OPERACION = TIPOS_DE_OPERACIONES.ID INNER JOIN "
sql = sql & "secciones_operaciones ON OPERACIONES_DETALLE.id_seccion = secciones_operaciones.ID LEFT OUTER JOIN "
sql = sql & "Paises ON OPERACIONES.ID_PAIS = Paises.Id "
sql = sql & "WHERE "
sql = sql & "(web_es = 1)  and "
sql = sql & "(OPERACIONES_DETALLE.seccion_operacion = 1) AND "	' 

sql = sql & "(OPERACIONES.ID_TIPO_OPERACION IN "
select case r_op
case "venta"
	sql = sql & "(1, 3)"	
case "alquiler"
	sql = sql & "(2, 4)"
end select
sql = sql & ") AND "

sql = sql & "(OPERACIONES.FECHA_PUBLICACION BETWEEN CONVERT(DATETIME, '2021-01-01 00:00:00', 102) AND CONVERT(DATETIME, '2021-02-01 00:00:00', 102)) AND "

select case r_zona
case "es"
	sql = sql & "(OPERACIONES.ID_PAIS = 1) "

case "eu"
	
	'sql = sql & "(OPERACIONES.ID_PAIS <> 60000) "

	sql = sql & "(Paises.id_region IN (2, 3, 5)) "
case "eu+"
	'sql = sql & "(OPERACIONES.ID_PAIS <> 60000) "
 	sql = sql & " (Paises.id_region IN (1, 2, 3, 5)) "

case "mad"
	sql = sql & "(OPERACIONES.ID_PROVINCIA = 2) "
case "bcn"
	sql = sql & "(OPERACIONES.ID_PROVINCIA = 3) "
case "otc"
	'sql = sql & "(OPERACIONES.ID_PROVINCIA <> 2) and (OPERACIONES.ID_PROVINCIA <> 3) and (OPERACIONES.ID_PROVINCIA <> 0) and (Paises.id_region IN (1, 2, 3, 5)) "	
	sql = sql & "(OPERACIONES.ID_PROVINCIA <> 2) and (OPERACIONES.ID_PROVINCIA <> 3) and (OPERACIONES.ID_PROVINCIA <> 0) and (Paises.id_region = 1 ) "	
case "otX"
	'sql = sql & " (Paises.id_region<>1 and Paises.id_region<>2 and Paises.id_region<>3 and Paises.id_region<>5) "	
	sql = sql & " (Paises.id_region<>1 ) "
end select

sql = sql & "GROUP BY secciones_operaciones.orden, secciones_operaciones.NOMBRE, secciones_operaciones.id "
sql = sql & "ORDER BY secciones_operaciones.orden"

ver_sql = sql
response.Write(sql)
'response.End()

set rs=Server.CreateObject("ADODB.recordset")
rs.Open sql, session("connPW")
nn=0
total_ops=0
total_sup=0
total_euros=0
%>
<div class="tbl_resum">
<div class="fila_resumt">
	<div class="resum_seccion"><b>USO</b></div>
    <div class="resum_ops"><b>OPS</b></div>
    <% if r_op="venta" then %><div class="resum_ops"><b>M &euro;</b></div><% end if %>
    <div class="resum_superf"><b>M&sup2;</b></div>
</div>

<% do until rs.EOF 
	total_ops=total_ops+rs("ops")
	total_sup=total_sup+rs("sup")
	nn = nn+1
	%>
	<% if request.Cookies("licencia")="" then %>
        <div class="fila_resum">
            <div class="resum_seccion"><a href="('<%= lcase(rs("seccion")) %>', '<%= r_year %>')" onclick="resumenSeccion('<%= lcase(rs("seccion")) %>', '<%= r_year %>'); return false;"><%= lcase(rs("seccion")) %></a></div>
            <div class="resum_ops"><%= rs("ops") %></div>
            <% if r_op="venta" then %><div class="resum_eur">...</div><% end if %>
            <div class="resum_superf">...</div>
        </div>
    <% else %>
        <div class="fila_resum">
            <div class="resum_seccion"><a href="('<%= lcase(rs("seccion")) %>', '<%= r_year %>')" onclick="resumenSeccion('<%= lcase(rs("seccion")) %>', '<%= r_year %>'); return false;"><%= lcase(rs("seccion")) %></a></div>
            <div class="resum_ops"><%= rs("ops") %></div>
            <% if r_op="venta" then %><div class="resum_eur"><%= CalculaMEuros(r_op, lcase(rs("seccion")), r_year, r_zona) %></div><% end if %>
            <div class="resum_superf"><%= formatnumber(rs("sup"), 0) %></div>
        </div>
    <% end if %>
	<% 
	secc = lcase(rs("seccion"))
	select case secc
	case "oficinas", "locales comerciales", "viviendas residenciales", "centros comerciales", "hoteles", "naves industriales", "solares", "ocio"
		call MadridBarcelona(rs("id"))
	end select
	rs.MoveNext
loop %>

<% if request.Cookies("licencia")="" then %>
    <div class="fila_resum">
        <div class="resum_seccion tot" style="padding-right:1em; text-align:right;">Total:</div>
        <div class="resum_ops tot"><%= total_ops %></div>
        <% if r_op="venta" then %><div class="resum_eur tot">...</div><% end if %>
        <div class="resum_superf tot">...</div>
    </div>
<% else %>
    <div class="fila_resum">
        <div class="resum_seccion tot" style="padding-right:1em; text-align:right;">Total:</div>
        <div class="resum_ops tot"><%= total_ops %></div>
        <% if r_op="venta" then %><div class="resum_eur tot"><%= formatnumber(total_euros, 0) %></div><% end if %>
        <div class="resum_superf tot"><%= formatnumber(total_sup, 0) %></div>
    </div>
<% end if %>
</div>

<% if 1=2 then
'if request.Cookies("dev")("sql")<>"" then %><div class="mini"><%= ver_sql %></div>
<% end if %>
<% rs.close

sub MadridBarcelona(rSec) 
	set rsMadBcn = Server.CreateObject("ADODB.recordset")
	
	'sql = "SELECT CASE WHEN LOCALIDADES.id_provincia = 2 THEN 2 ELSE CASE WHEN LOCALIDADES.id_provincia = 3 THEN 3 ELSE CASE WHEN (LOCALIDADES.id_provincia <> 3 and LOCALIDADES.id_provincia <> 2 and Paises.id_region<>1 and Paises.id_region<>1 and Paises.id_region<>2 and Paises.id_region<>3 and Paises.id_region<>5 ) THEN 50000 ELSE 10000 END END end as id_provincia,  "
	sql = "SELECT CASE WHEN LOCALIDADES.id_provincia = 2 THEN 2 ELSE CASE WHEN LOCALIDADES.id_provincia = 3 THEN 3 ELSE CASE WHEN (LOCALIDADES.id_provincia <> 3 and LOCALIDADES.id_provincia <> 2 and Paises.id_region<>1  ) THEN 50000 ELSE 10000 END END end as id_provincia,  "
	
	'sql = "SELECT  LOCALIDADES.id_provincia as id_provincia,  "

	sql = sql & "COUNT(DISTINCT OPERACIONES_DETALLE.id_operacion) AS ops, SUM(OPERACIONES_DETALLE.Superficie) AS sup "
	sql = sql & "FROM OPERACIONES INNER JOIN "

	sql = sql & "OPERACIONES_DETALLE ON OPERACIONES.ID = OPERACIONES_DETALLE.id_operacion INNER JOIN "
	sql = sql & "TIPOS_DE_OPERACIONES ON OPERACIONES.ID_TIPO_OPERACION = TIPOS_DE_OPERACIONES.ID INNER JOIN "
	sql = sql & "secciones_operaciones ON OPERACIONES_DETALLE.id_seccion = secciones_operaciones.ID LEFT OUTER JOIN "
	
	sql = sql & "LOCALIDADES ON OPERACIONES.ID_LOCALIDAD = LOCALIDADES.id INNER JOIN  "
	
sql = sql & "Paises ON OPERACIONES.ID_PAIS = Paises.Id "

	sql = sql & "WHERE (web_es <>0)  and "
	sql = sql & "(OPERACIONES_DETALLE.seccion_operacion = 1) AND "

'sql = sql & "(Paises.id_region IN (1, 2, 3, 5)) AND "
	

	sql = sql & "(OPERACIONES.ID_TIPO_OPERACION IN "
	select case r_op
	case "venta"
		sql = sql & "(1, 3)"	
	case "alquiler"
		sql = sql & "(2, 4)"
	end select
	sql = sql & ") AND "
	sql = sql & "(OPERACIONES.FECHA_PUBLICACION BETWEEN CONVERT(DATETIME, '2021-01-01 00:00:00', 102) AND CONVERT(DATETIME, '2021-02-01 00:00:00', 102)) AND "

	

	sql = sql & "(OPERACIONES_DETALLE.id_seccion = "
	sql = sql & rSec
	sql = sql & ") "
	'sql = sql & "GROUP BY  LOCALIDADES.id_provincia  "
	'sql = sql & "GROUP BY CASE WHEN LOCALIDADES.id_provincia = 2 THEN 2 ELSE CASE WHEN LOCALIDADES.id_provincia = 3 THEN 3 ELSE CASE WHEN (LOCALIDADES.id_provincia <> 3 and LOCALIDADES.id_provincia <> 2 and Paises.id_region<>1 and Paises.id_region<>1 and Paises.id_region<>2 and Paises.id_region<>3 and Paises.id_region<>5 ) THEN 50000 ELSE 10000 END END end "
	sql = sql & "GROUP BY CASE WHEN LOCALIDADES.id_provincia = 2 THEN 2 ELSE CASE WHEN LOCALIDADES.id_provincia = 3 THEN 3 ELSE CASE WHEN  (LOCALIDADES.id_provincia <> 3 and LOCALIDADES.id_provincia <> 2 and Paises.id_region<>1  ) THEN 50000 ELSE 10000 END END end "

' WHEN LOCALIDADES.id_provincia = 2 THEN 2 ELSE CASE WHEN LOCALIDADES.id_provincia = 3 THEN 3 ELSE 10000 END END "
	'FC
	'sql = sql & "HAVING (LOCALIDADES.id_provincia IN (2, 3)) "
	sql = sql & "ORDER BY LOCALIDADES.id_provincia"
	
	'if request.Cookies("dev")("sql")<>"" then response.Write(sql)
	'response.Write(sql)
	rsMadBcn.Open sql, session("connPW")
	do until rsMadBcn.eof 
		if rsMadBcn("id_provincia")=2 then
			ver_madbcn = "Madrid"
			madbcn = "mad"
		end if 
			if rsMadBcn("id_provincia")=3 then 
				ver_madbcn = "Barcelona"
				madbcn = "bcn"
			end if 
			if rsMadBcn("id_provincia")=10000 then
				ver_madbcn = "Otras Ciudades"
				madbcn = "otc"
			end if
			if rsMadBcn("id_provincia")=50000 then
				ver_madbcn = "Internacional"
				madbcn = "otX"
			end if
		
		select case cint(rSec)
		case 16
			p_sec = "oficinas"
		case 4
			p_sec = "locales comerciales"
		case 256
			p_sec = "vivienda/coliving"

		case 1024
			p_sec = "ocio"
		case 1
			p_sec = "centros comerciales"
		case 8
			p_sec = "naves industriales"
		case 128
			p_sec = "solares"
		case 2
			p_sec = "hoteles"
		end select
		%>
    <% if request.Cookies("licencia")="" then %>
        <div class="fila_resum">
            <div class="resum_seccion madbcn" style="padding-left:5px;">&gt; <%= ver_madbcn %></div>
            <div class="resum_ops madbcn"><%= rsMadBcn("ops") %></div>
    	    <% if r_op="venta" then %><div class="resum_ops madbcn">...</div><% end if %>
            <div class="resum_superf madbcn">...</div>
        </div>
    <% else %>
        <div class="fila_resum">
	<% if madbcn="otcX" then %>
            <div class="resum_seccion madbcn" style="padding-left:5px;">&gt; <%= ver_madbcn %></div>

            <div class="resum_ops madbcn"><%= rsMadBcn("ops") %></div>
            <% if r_op="venta" then %><div class="resum_ops madbcn"><%= CalculaMEuros(r_op, p_sec, r_year, madbcn) %></div><% end if %>
            <div class="resum_superf madbcn"><%= formatnumber(rsMadBcn("sup"), 0) %></div>
	<% else %>
            <div class="resum_seccion madbcn" style="padding-left:5px;">&gt; <a href="('<%= p_sec %>', '<%= madbcn %>', '<%= r_year %>')" onclick="resumenMadBcn('<%= p_sec %>', '<%= madbcn %>', '<%= r_year %>'); return false;"><%= ver_madbcn %></a></div>
            <div class="resum_ops madbcn"><%= rsMadBcn("ops") %></div>
            <% if r_op="venta" then %><div class="resum_ops madbcn"><%= CalculaMEuros(r_op, p_sec, r_year, madbcn) %></div><% end if %>
            <div class="resum_superf madbcn"><%= formatnumber(rsMadBcn("sup"), 0) %></div>
	<% end if %>

        </div>
    <% end if %>
		<% rsMadBcn.movenext
	loop
end sub %>

<% function CalculaMEuros(p_op, p_sec, p_year, p_zona)
	
	if request.Cookies("licencia")="" then
		CalculaMEuros = "..."
		exit function
	end if
	
	set rsTmp = Server.CreateObject("ADODB.recordset")
	
	sql = "SELECT SUM("
	sql = sql & "CASE WHEN ID_TIPO_PRECIO = 5 THEN PRECIO_EUR WHEN ID_TIPO_PRECIO = 8 THEN PRECIO_EUR WHEN ID_TIPO_PRECIO = 4 THEN CASE WHEN METROS_CUADRADOS > 0 THEN PRECIO_EUR * METROS_CUADRADOS ELSE 0 END WHEN ID_TIPO_PRECIO = 10 THEN CASE WHEN METROS_CUADRADOS > 0 THEN PRECIO_EUR * METROS_CUADRADOS ELSE 0 END ELSE 0 END"
	'sql = sql & "METROS_CUADRADOS"
	sql = sql & ") AS euros "
	sql = sql & "FROM C_OPERACIONES_TODO WHERE "
	
	sql = sql & "(web_es<>0) AND "
	
	sql = sql & "(ID_TIPO_OPERACION IN "
	select case p_op
	case "venta"
		sql = sql & "(1, 3)"	
	case "alquiler"
		sql = sql & "(2, 4)"
	end select
	sql = sql & ") AND "
	
	sql = sql & "(seccion LIKE '%" & p_sec & "%') AND "
	

	sql = sql & "(FECHA_PUBLICACION BETWEEN CONVERT(DATETIME, '2021-01-01 00:00:00', 102) AND CONVERT(DATETIME, '2021-02-01 00:00:00', 102)) AND "

	'sql = sql & "(id_region IN (1, 2, 3, 5)) AND "

	select case p_zona
	case "es"
		sql = sql & "(ID_PAIS = 1) "
	
	case "eu"
		sql = sql & "(id_region IN (2, 3, 5)) "
	case "eu+"
		sql = sql & "(id_region IN (1, 2, 3, 5)) "
	
	case "mad"
		sql = sql & "(ID_PROVINCIA = 2) "
	case "bcn"
		sql = sql & "(ID_PROVINCIA = 3) "
	case "otc"
		'sql = sql & "( ID_PROVINCIA<> 3 and ID_PROVINCIA<> 2  ) and (id_region IN (1, 2, 3, 5)) "
		sql = sql & "( ID_PROVINCIA<> 3 and ID_PROVINCIA<> 2  ) and (id_region = 1 ) "
	case "otX"
		'sql = sql & " (id_region<>1 and id_region<>2 and id_region<>3 and id_region<>5) "
		sql = sql & " (id_region<>1 ) "
	end select
	
	ver_sql = sql
	
	rsTmp.Open sql, session("connPW")
	
	CalculaMEuros = FormatNumber(rsTmp("euros")/1000000, 0)
'	CalculaMEuros = err.number
	
	if  Err.Description<>"" then
		%><script>console.log('<%= err.number %>: <%= err.Description %>')</script><%
	end if
	if p_zona="eu+" then
		total_euros = total_euros + CalculaMEuros
	end if
	if p_zona="es" then
		total_euros = total_euros + CalculaMEuros
	end if	
	rsTmp.close
	set rsTmp=nothing
	
end function %>

<% sub CalculaEurosZ 
	sql = "SELECT DISTINCT OPERACIONES_DETALLE.id_operacion "
	sql = sql & "FROM OPERACIONES INNER JOIN "
	sql = sql & "OPERACIONES_DETALLE ON OPERACIONES.ID = OPERACIONES_DETALLE.id_operacion INNER JOIN "
	sql = sql & "TIPOS_DE_OPERACIONES ON dbo.OPERACIONES.ID_TIPO_OPERACION = dbo.TIPOS_DE_OPERACIONES.ID INNER JOIN "
	sql = sql & "secciones_operaciones ON dbo.OPERACIONES_DETALLE.id_seccion = dbo.secciones_operaciones.ID LEFT OUTER JOIN "
	sql = sql & "Paises ON dbo.OPERACIONES.ID_PAIS = dbo.Paises.Id "
	sql = sql & "WHERE "
	sql = sql & "(OPERACIONES_DETALLE.seccion_operacion = 1) AND "
	
	sql = sql & "(OPERACIONES.ID_TIPO_OPERACION IN "
	select case r_op
	case "venta"
		sql = sql & "(1, 3)"	
	case "alquiler"
		sql = sql & "(2, 4)"
	end select
	sql = sql & ") AND "
	
	sql = sql & "(OPERACIONES.FECHA_PUBLICACION BETWEEN CONVERT(DATETIME, '2021-01-01 00:00:00', 102) AND CONVERT(DATETIME, '2021-02-01 00:00:00', 102)) AND "
	
	select case r_zona
	case "es"
		sql = sql & "(OPERACIONES.ID_PAIS = 1) "
	
	case "eu"
		sql = sql & "(Paises.id_region IN (2, 3, 5)) "
	case "eu+"
		sql = sql & "(Paises.id_region IN (1, 2, 3, 5)) "
	
	case "mad"
		sql = sql & "(OPERACIONES.ID_PROVINCIA = 2) "
	case "bcn"
		sql = sql & "(OPERACIONES.ID_PROVINCIA = 3) "
	case "otc"
		'sql = sql & "( OPERACIONES.ID_PROVINCIA<> 3 and OPERACIONES.ID_PROVINCIA<> 2  and (id_region IN (1, 2, 3, 5))  ) "
		sql = sql & "( OPERACIONES.ID_PROVINCIA<> 3 and OPERACIONES.ID_PROVINCIA<> 2  and (id_region = 1 )  ) "
	case "otX"
		'sql = sql & " (Paises.id_region<>1 and Paises.id_region<>2 and Paises.id_region<>3 and Paises.id_region<>5) "
		sql = sql & " (Paises.id_region<>1 ) "

	end select
	
	sql = "SELECT id, SUPERFICIE, PRECIO_EUR, ID_TIPO_PRECIO FROM OPERACIONES WHERE ID IN (" & sql & ")"
	
	%><div><%= sql %></div><%

end sub %>
<script language="javascript">
function resumenSeccion (seccion, yy) {
	resetform();
	
	$("#setcoords_zoom").val("");
	$("#setcoords_lat").val("");
	$("#setcoords_lng").val("");
	
	$("#FechaI").val("01/11/" + yy);
	$("#FechaF").val("01/12/" + yy);
	
	$("#provincia").val("%");
	$("#pais").val("1");
	
	var op = $("#resumen_op").val();
	$("#operacion").val(op);
	
	$("#sec").val(seccion);
	
	if (seccion=="solares") {
		$("#div_usosolar").fadeIn("slow");
	} else {
		$("#div_usosolar").fadeOut("slow");
	};
	
	$('#frm_deal').submit();
	
}


function resumenMadBcn(secc, madbcn, yy) {
	//$("#setcoords_zoom").val("");
	//$("#setcoords_lat").val("");
	//$("#setcoords_lng").val("");
	
	$("#FechaI").val("01/11/" + yy);
	$("#FechaF").val("01/12/" + yy);
	
	
	
	if (madbcn=="mad") {
		$("#pais").val("1");
		$("#provincia").val("2");
	} else {
		if (madbcn=="bcn") {
			$("#pais").val("1");
			$("#provincia").val("3");
		} else {
			if (madbcn=="otc") {
				$("#pais").val("0");
				$("#provincia").val("2");
			};
			if (madbcn=="otX") {
				$("#pais").val("0");
				$("#provincia").val("3");
			};
		};
		
	};
	
	var op = $("#resumen_op").val();
	$("#operacion").val(op);
	
	$("#sec").val(secc);
	
	EstadoForm()
	
	$('#frm_deal').submit();
	
}

//resumenMadBcn('oficinas', 'bcn', '2015');

</script>


<script>if (xOrigen==1) {resumenMadBcn('oficinas', 'mad', '2021');}</script>
