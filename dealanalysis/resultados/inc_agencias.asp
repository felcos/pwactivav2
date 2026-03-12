<div id="div_info_agentes" name="div_info_agentes" style="padding:10px; margin-top:5px;">
    <%
    Set rsTmp = Server.CreateObject("ADODB.Recordset")
    'sql = "SELECT TOP 15 id_empresa, id_sucursal, NOMBRE, SUM(METROS_CUADRADOS) AS superf FROM C_OPERACIONES_INTERMEDIARIOS WHERE ID IN (" & ids & ") "
    sql = "SELECT id_empresa, NOMBRE, SUM(METROS_CUADRADOS) AS superf, COUNT(ID) AS ops FROM C_OPERACIONES_INTERMEDIARIOS WHERE ("
    sql = sql & "(tipo LIKE '%I') AND (" & sqlW & " AND ID_ACTIVIDAD=28)) "
    'sql = sql & " (" & sqlW & " )) "
    sql = sql & "GROUP BY id_empresa, NOMBRE ORDER BY SUM(METROS_CUADRADOS) DESC"
    
    rsTmp.Open sql, session("connPW")
    if not rsTmp.eof then 
    color="#CCC"
    nn=1
    'response.Write(sql)
    %>
    <div class="tabla">
    <div class="fila cabecera">
        <div class="agentes_ranking tit">#</div>
        <div class="agentes_nombre tit">Agencia</div>
        <div class="agentes_ops tit">Ops.</div>
        <div class="agentes_superf tit">Total M&sup2;</div>
    </div>
    
    <% do while not rsTmp.eof 
        'if rsTmp("ID_TIPO_SUCURSAL")=0 then
            c_nombre = rsTmp("NOMBRE")	' & " " & rsTmp("NOMBRE")
        'else
        '	c_nombre = rsTmp("NOMBRE_EMPRESA")
        'end if
        %>
    <div class="fila">
        <div class="agentes_ranking"><%= nn %></div>
        <div class="agentes_nombre"><%= c_nombre %></div>
        <div class="agentes_ops"><%= rsTmp("ops") %></div>
        <div class="agentes_superf"><%= FormatNumber(rsTmp("superf"), 0) %> m&sup2;</div>
    </div>
        <%
        rsTmp.movenext
        nn=nn+1
    loop %>
    
    </div>
	<% end if
    rsTmp.close
    set rsTmp=nothing
    %>
    <br>
</div>

<% if request.Cookies("dev")("sql")<>"" then %>
<div class="dev mini">
    <%= sql %>
</div>
<% end if %>
