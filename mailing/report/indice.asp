<% 'Noticias		
if request.QueryString("actualidad")<>"" then
	sql = "SELECT * FROM C_NOTICIAS_INMOBILIARIAS WHERE TIPO_NOTICIA='N' AND web_es=1 "
	if not request.QueryString("internacional")<>"" then
		sql = sql & " AND nacional<>0"
	end if
	sql = sql & " AND ((FECHA_NOTICIA BETWEEN " & desde & " AND " & hasta & ") OR (FECHA_ACTUALIZACION BETWEEN " & desde & " AND " & hasta & "))"
	sql = sql & " ORDER BY nacional DESC, TIPOSECCION"
		
	test_inyeccion_sql sql
	set resultado = session("connPW").execute(sql) 
	
	if not resultado.eof then %><h3>Actualidad Inmobiliaria</h3><% end if
	
	do while not resultado.eof 
		%><li><a href="#not<%= resultado("id") %>"><%= resultado("titulo") %></a></li><%
		resultado.movenext
	loop
	resultado.close
end if
%>
<% 'Rumores			
if request.QueryString("rumores")<>"" then
	sql = "SELECT * FROM C_NOTICIAS_INMOBILIARIAS WHERE TIPO_NOTICIA='W' AND web_es=1 "
	if not request.QueryString("internacional")<>"" then
		sql = sql & " AND nacional<>0"
	end if
	sql = sql & " AND ((FECHA_NOTICIA BETWEEN " & desde & " AND " & hasta & ") OR (FECHA_ACTUALIZACION BETWEEN " & desde & " AND " & hasta & "))"
	sql = sql & " ORDER BY nacional DESC, TIPOSECCION"
	
	test_inyeccion_sql sql
	set resultado = session("connPW").execute(sql) 
	
	if not resultado.eof then %><h3>Rumores & New Business</h3><% end if
	
	do while not resultado.eof 
		%><li><a href="#web<%= resultado("id") %>"><%= resultado("titulo") %></a></li><%
		resultado.movenext
	loop
	resultado.close
end if
%>
<% 'Estudios		
if request.QueryString("estudios")<>"" then 
	sql = "SELECT * FROM C_NOTICIAS_INMOBILIARIAS WHERE TIPO_NOTICIA='E' AND web_es=1 "
	if not request.QueryString("internacional")<>"" then
		sql = sql & " AND nacional<>0"
	end if
	sql = sql & " AND ((FECHA_NOTICIA BETWEEN " & desde & " AND " & hasta & ") OR (FECHA_ACTUALIZACION BETWEEN " & desde & " AND " & hasta & "))"
	sql = sql & " ORDER BY nacional DESC, TIPOSECCION"
	
	test_inyeccion_sql sql
	set resultado = session("connPW").execute(sql) 
	
	if not resultado.eof then %><h3>Estudios de Mercado</h3><% end if
	
	do while not resultado.eof 
		%><li><a href="#est<%= resultado("id") %>"><%= resultado("titulo") %></a></li><%
		resultado.movenext
	loop
	resultado.close
end if
%>
<% 'Operaciones		
if request.QueryString("operaciones")<>"" then
	sqlWop = "SELECT DISTINCT ID FROM C_OPERACIONES_TODO WHERE web_es=1 "
	if not request.QueryString("internacional")<>"" then
		sqlWop = sqlWop & " AND ID_PAIS=1"
	end if
	'sqlWop = sqlWop & " AND (FECHA_ACTUALIZACION BETWEEN " & desde & " AND " & hasta & ")"
	sqlWop = sqlWop & " AND ((FECHA_PUBLICACION BETWEEN " & desde & " AND " & hasta & ") OR (FECHA_ACTUALIZACION BETWEEN " & desde & " AND " & hasta & "))"
	
	sql = "SELECT *, CASE WHEN ID_PAIS = 1 THEN 1 ELSE 0 END AS nacional FROM C_OPERACIONES WHERE ID IN (" & sqlWop & ")"
	sql = sql & " ORDER BY nacional DESC, id"
	
	test_inyeccion_sql sql
	set resultado = session("connPW").execute(sql)
	
	if not resultado.eof then %><h3>Deal Analysis</h3><% end if
	
	do while not resultado.eof 
		%><li><a href="#ope<%= resultado("id") %>"><%= resultado("titulo") %></a></li><%
		resultado.movenext
	loop
	resultado.close
end if
%>
<% 'Demandas		
if request.QueryString("demandas")<>"" then
	sql = "SELECT * FROM C_NOTICIAS_INMOBILIARIAS WHERE TIPO_NOTICIA='B' AND web_es=1 "
	if not request.QueryString("internacional")<>"" then
		sql = sql & " AND nacional<>0"
	end if
	sql = sql & " AND ((FECHA_NOTICIA BETWEEN " & desde & " AND " & hasta & ") OR (FECHA_ACTUALIZACION BETWEEN " & desde & " AND " & hasta & "))"
	sql = sql & " ORDER BY nacional DESC, TIPOSECCION"
	
	test_inyeccion_sql sql
	Set resultado = session("connPW").execute(sql) 
	
	if not resultado.eof then %><h3>Demandas</h3><% end if
	
	do while not resultado.eof 
		%><li><a href="#dem<%= resultado("id") %>"><%= resultado("titulo") %></a></li><%
		resultado.movenext
	loop
	resultado.close
end if
%>
<% 'Subastas		
if request.QueryString("subastas")<>"" then
	sql = "SELECT * FROM C_CONCURSOS WHERE web_es=1 AND "
	sql = sql & "(FECHA_PUBLICACION BETWEEN CONVERT(DATETIME, '" & dateadd("d",-7, fecha) & "', 103) AND CONVERT(DATETIME, '" & fecha & "', 103) OR "
	sql = sql & "FECHA_ACTUALIZACION BETWEEN CONVERT(DATETIME, '" & dateadd("d",-7, fecha) & "', 103) AND CONVERT(DATETIME, '" & fecha & "', 103) )"
	sql = sql & " ORDER BY tipo_concurso"
	
	test_inyeccion_sql sql
	Set resultado = session("connPW").execute(sql) 
	
	if not resultado.eof then %><h3>Subastas</h3><% end if
	
	do while not resultado.eof 
		%><li><a href="#sub<%= resultado("id") %>"><%= resultado("titulo") %></a></li><%
		resultado.movenext
	loop
	resultado.close
end if
%>
<% 'Vencimientos	
if request.QueryString("vencimientos")<>"" then
	sql = "SELECT * "
	sql = sql & "FROM C_OPERACIONES WHERE "
	sql = sql & "(FECHA_PUBLICACION_VENCIMIENTO BETWEEN " & desde & " AND " & hasta & ")"	
	if not request.QueryString("internacional")<>"" then
		sql = sql & " AND ID_PAIS=1"
	end if
	sql = sql & " AND web_es <> 0"
	
	test_inyeccion_sql sql
	set resultado = session("connPW").execute(sql)
	
	if not resultado.eof then
		%><h3><a href="#vencim">Posibles Vencimientos de Contrato</a></h3><%
	end if
		
	resultado.close
end if
%>