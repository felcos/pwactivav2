<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
'on error resume next
'for each elto in request.QueryString
'	if request.QueryString(elto)<>"" then
'		response.Write("<li>" & elto & ": " & request.QueryString(elto) & "</li>")
'	end if 
'next

set rsQ = Server.CreateObject("ADODB.Recordset")

localidad = trim(lcase(request("ciudad")))
agencia = request("agencia")

sel_yy = request("year")
if sel_yy="" then sel_yy = "2018"

if request("datos")="disp" then
	'sqlw	
	sqlw = "id_tipo_inmueble=0"
	if sel_yy="2018" then
		sqlw = sqlw & " AND disponible_fecha IS NOT NULL AND disponible_min>0"
	end if
	
	if localidad<>"" then
		sqlw = sqlw & " AND "
		if localidad = "madrid" then
			sqlw = sqlw & "id_provincia = 2"
		elseif localidad = "barcelona" then
			sqlw = sqlw & "id_provincia = 3"
		elseif localidad = "londres" then
			sqlw = sqlw & "id_provincia = 60"
		else
			sqlw = sqlw & "localidad = '" & localidad & "'"
		end if
	end if
	
	'if agencia<>"" then
	'	sqlw = sqlw & " AND id_edificio IN "
	'	sqlw = sqlw & "(SELECT DISTINCT id_inmueble FROM inmuebles_agentes WHERE (id_empresa = " & agencia & " AND tipo = 'comerc'))"
	'end if
	
	if request("id_subzona")<>"" then
		sqlw = sqlw & " AND id_subzona=" & request("id_subzona")
	elseif request("id_zona")<>"" then
		sqlw = sqlw & " AND id_area=" & request("id_zona")
	end if
	
	'total	
	if sel_yy="2016" then
		sqltot = "SELECT SUM(disponible_max) AS total FROM dirs_w_inmuebles WHERE (" & sqlw & ") "
		
	else
		sqltot = "SELECT SUM(t1.superficie) AS total "
		sqltot = sqltot & "FROM inmuebles_disponibilidad t1 "
		sqltot = sqltot & "INNER JOIN (SELECT id_inmueble, MAX(fecha) AS MaxDate FROM inmuebles_disponibilidad WHERE fecha <= '31/12/" & sel_yy & "' GROUP BY id_inmueble) t2 "
		sqltot = sqltot & "ON t1.id_inmueble = t2.id_inmueble AND t1.fecha = t2.MaxDate "
		sqltot = sqltot & "LEFT OUTER JOIN dirs_w_inmuebles "
		sqltot = sqltot & "ON t1.id_inmueble = dirs_w_inmuebles.id_edificio "
		sqltot = sqltot & "WHERE (" & sqlw & ") "
		
	end if
	
	'agrupados	
	if sel_yy="2016" then
		sql = "SELECT agencia_id_empresa, agencia_nombre, sum(disponible_max) AS disponible, COUNT(id_edificio) AS nn "
		sql = sql & "FROM dirs_w_inmuebles_agencias WHERE (" & sqlw & ") "
		sql = sql & "GROUP BY agencia_id_empresa, agencia_nombre "
		sql = sql & "ORDER BY SUM(disponible_max) DESC"
		
	else
		sql = "SELECT t3.id_empresa AS agencia_id_empresa, t3.NOMBRE AS agencia_nombre, t3.logotipo AS agencia_logotipo, "
		sql = sql & "COUNT(DISTINCT dirs_w_inmuebles.id) AS nn, SUM(t1.superficie) AS disponible "
		sql = sql & "FROM dirs_w_inmuebles RIGHT OUTER JOIN inmuebles_disponibilidad t1 INNER JOIN "
		sql = sql & "(SELECT id_inmueble, MAX(fecha) AS MaxDate FROM inmuebles_disponibilidad WHERE fecha <= '31/12/" & sel_yy & "' GROUP BY id_inmueble) t2 "
		sql = sql & "ON t1.id_inmueble = t2.id_inmueble AND t1.fecha = t2.MaxDate "
		sql = sql & "ON dbo.dirs_w_inmuebles.id_edificio = t1.id_inmueble "
		sql = sql & "LEFT OUTER JOIN "
		sql = sql & "(SELECT inmuebles_agentes.id_inmueble, inmuebles_agentes.id_empresa, inmuebles_agentes.fecha_desde, inmuebles_agentes.fecha_hasta, EMPRESAS.NOMBRE, EMPRESAS.logotipo "
		sql = sql & "FROM inmuebles_agentes INNER JOIN EMPRESAS ON inmuebles_agentes.id_empresa = EMPRESAS.ID "
		sql = sql & "WHERE EMPRESAS.ID_ACTIVIDAD = 28 AND inmuebles_agentes.tipo = 'comerc' AND inmuebles_agentes.fecha_desde <= '01/01/" & sel_yy & "' AND "
		sql = sql & "(inmuebles_agentes.fecha_hasta > '31/12/" & sel_yy & "' OR inmuebles_agentes.fecha_hasta IS NULL)"
		sql = sql & ") t3 "
		sql = sql & "ON dirs_w_inmuebles.id_edificio = t3.id_inmueble "
		sql = sql & "WHERE (t1.superficie>0 AND t3.id_empresa IS NOT NULL AND " & sqlw & ") "
		sql = sql & "GROUP BY t3.id_empresa, t3.NOMBRE, t3.logotipo "
		sql = sql & "ORDER BY SUM(t1.superficie) DESC"
		
	end if
	
	
else
	'sqlw	
	sqlw = "web_es<>0"
	if request("datos")="alq" then
		sqlw = sqlw & " AND ID_TIPO_OPERACION=2"
	elseif request("datos")="ocup" then
		sqlw = sqlw & " AND ID_TIPO_OPERACION=1"
	else 
		sqlw = sqlw & " AND (ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=2)"
	end if
	
	sqlw = sqlw & " AND seccion LIKE '%oficinas%'"
	
	sqlw = sqlw & " AND FECHA_OPERACION BETWEEN CONVERT(DATETIME, '01/01/" & sel_yy & "', 103) AND CONVERT(DATETIME, '31/12/" & sel_yy & "', 103)"
	
	if localidad="" then
		sqlw = sqlw & " AND id_pais = 1"
	else
		sqlw = sqlw & " AND "
		if localidad = "madrid" then
			sqlw = sqlw & "id_provincia = 2"
		elseif localidad = "barcelona" then
			sqlw = sqlw & "id_provincia = 3"
		else
			sqlw = sqlw & "localidad = '" & localidad & "'"
		end if
	end if
	
	if request("id_subzona")<>"" then
		sqlw = sqlw & " AND id_subzona=" & request("id_subzona")
	elseif request("id_zona")<>"" then
		sqlw = sqlw & " AND id_area=" & request("id_zona")
	end if
	
	'if agencia<>"" then
	'	sqlw = sqlw & " AND id IN ("
	'	sqlw = sqlw & "SELECT id_operacion FROM OPERACIONES_CONTACTOS WHERE tipo LIKE '%I' AND id_empresa=" & agencia
	'	sqlw = sqlw & ")"
	'end if
	
	'total	
	sqltot = "SELECT SUM(METROS_CUADRADOS) AS total FROM dirs_w_ops t1 WHERE " & sqlw
	
	'agrupados	
	'sql = "SELECT * FROM dirs_w_ops WHERE " & sql
	sql = "SELECT id_empresa, NOMBRE, SUM(METROS_CUADRADOS) AS superf, COUNT(ID) AS ops FROM C_OPERACIONES_INTERMEDIARIOS "
	sql = sql & "WHERE (ID_ACTIVIDAD=28 AND (tipo LIKE '%I') AND " & sqlw & ") "
	sql = sql & "GROUP BY id_empresa, NOMBRE"
	sql = sql & " ORDER BY SUM(METROS_CUADRADOS) DESC, id_empresa, NOMBRE"
	
	
end if

'response.Write(sqltot)
'response.End()

rsQ.open sqltot, session("connPW")
total_superficie = rsQ("total")
rsQ.close
%>
<table class="tabla tbFiltros tbagencias">
<caption>Agencias m&aacute;s activas: <span id="informa-agencias"></span><% if request.Cookies("dev")<>"" then %> &nbsp; <span class="dev">[<%= request("datos") %>]</span><% end if %></caption>
<thead class="">
	<tr class="trFiltros">
		<th><% if request.Cookies("dev")<>"" then %><span class="dev"><%= total_superficie %></span><% end if %></th>
		<th>N&deg;</th>
		<th>M<sup>2</sup></th>
        <th>%</th>
		<th></th>
		<th>Filtrar</th>
	</tr>
</thead>
<tbody class="">
<%
hay_mas = false
nn = 1

'response.Write(sql)
'response.End()

rsQ.open sql, session("connPW")

do while not rsQ.eof 
	if nn>3 then hay_mas=true 
	clase = "" 
	
	if request("datos")="disp" then
		id = rsQ("agencia_id_empresa")
		nombre = rsQ("agencia_nombre")
		
		if session("pw_ws").accesoTakeUp then
			cuenta = rsQ("nn")
			superficie = FormatNumber(rsQ("disponible"), 0)
			if isnull(rsQ("disponible")) then 
				porcentaje = "N/D"
			else
				'porcentaje = FormatNumber(100*cdbl(rsQ("disponible"))/cdbl(total_superficie), 2)
				num = 100*cdbl(rsQ("disponible"))/cdbl(total_superficie)
				if num<1 then
					porcentaje = FormatNumber(num, 1) & "%"
				else
					porcentaje = FormatNumber(num, 0) & "%"
				end if
			end if
			'if agencia<>"" then
				'if cstr(rsQ("agencia_id_empresa"))=agencia then
				'	clase = "activo"
				'end if
			'end if 
		else
			cuenta = "<img src='/img/lock.svg' width='14' height='14'/>"
			superficie = "<img src='/img/lock.svg' width='14' height='14'/>"
			porcentaje = "<img src='/img/lock.svg' width='14' height='14'/>"
		end if
		
	else
		id = rsQ("id_empresa")
		nombre = rsQ("nombre")
		
		if session("pw_ws").accesoTakeUp then
			cuenta = rsQ("ops")
			superficie = FormatNumber(rsQ("superf"), 0)
			if isnull(rsQ("superf")) then 
				porcentaje = "N/D"
			else
				num = 100*cdbl(rsQ("superf"))/cdbl(total_superficie)
				if num<1 then
					porcentaje = FormatNumber(num, 1) & "%"
				else
					porcentaje = FormatNumber(num, 0) & "%"
				end if
			end if
			'if agencia<>"" then
				if cstr(rsQ("id_empresa"))=agencia then
					clase = "activo"
				end if
			'end if 
		else
			cuenta = "<img src='/img/lock.svg' width='14' height='14'/>"
			superficie = "<img src='/img/lock.svg' width='14' height='14'/>"
			porcentaje = "<img src='/img/lock.svg' width='14' height='14'/>"
		end if
		
	end if %>
    <tr class="trFiltros <%= clase %> <% if hay_mas then %>hide<% end if %>">
        <td><%= nombre %></td>
        <td><%= cuenta %></td>
        <td><%= superficie %></td>
        <td class="agencias_percent"><%= porcentaje %></td>
        <td></td>
        <td><a href="#" class="btFiltros btnAgencia <%= clase %>" data-agencia="<%= id %>" data-name="<%= nombre %>"><span class="icon-checkmark"></span></a></td>
    </tr>
	<% rsQ.movenext
	nn = nn + 1
loop

rsQ.close

if hay_mas then %>
    <tr class="trFiltros trVerTodas">
        <td colspan="6"><a href="#" class="btFiltros" id="bt-VerTodasAgencias"> <span id="swVerAgencias">+</span> <span id="txtVerAgencias">Ver todas</span></a></td>
    </tr>
<% end if

if 1=2 then
'if request.Cookies("dev")("sql")<>"" then %>
	<tr>
        <td colspan="6" style="font-size:12px;"><%= sql %></td>
    </tr>
<% end if %>
</tbody>
</table>
<%
set rsQ=nothing
%>
<script>
	$("#bt-VerTodasAgencias").click(function(e) {
		//alert("asdf");
		if ($("#swVerAgencias").html()=="+") {
			$("#swVerAgencias").html("-");
			$("#txtVerAgencias").html("Ver menos");
			$(".tbagencias tr").each(function(ii) {
				$(".tbagencias tr").eq(ii).removeClass("hide");
			});
		} else {
			$("#swVerAgencias").html("+");
			$("#txtVerAgencias").html("Ver todas");
			$(".tbagencias tr").each(function(ii) {
				if (ii>3) {
					$(".tbagencias tr").eq(ii).addClass("hide");
				}
			});
		}
		
		return false;
	
	})
	
	
	$(".btnAgencia").click(function(e) {
		//console.log(".btnAgencia");
		var agencia = $(this).data("agencia");
		
		//$("#tabla-agencias tr.trFiltros.activo").each(function(index, tr) {
        //    $(tr).removeClass("activo");
        //});
		
		$.each( $(".btnAgencia"), function(ii, boton) {
			if ($(boton).data("agencia")==agencia) {
				if ($(boton).data("agencia")==$("#frm_preguntas input[name='agencia']").val()) {
					$(boton).removeClass("activo");
					$(boton).closest("tr.trFiltros").removeClass("activo");
				} else {
					$(boton).addClass("activo");
					$(boton).closest("tr.trFiltros").addClass("activo");
				}
			} else {
				$(boton).removeClass("activo");
				$(boton).closest("tr.trFiltros").removeClass("activo");
			}
		})
		
		if (agencia==$("#frm_preguntas input[name='agencia']").val()) {
			$("#frm_preguntas input[name='agencia']").val("");
			$("#frm_preguntas input[name='agencia_nombre']").val("");
		} else {
			$("#frm_preguntas input[name='agencia']").val(agencia);
			$("#frm_preguntas input[name='agencia_nombre']").val($(this).data("name"));
		}
		
		CargarDatos();
		
		return false;
	});
	
</script>