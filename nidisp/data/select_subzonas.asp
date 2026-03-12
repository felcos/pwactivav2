<% set rsQ = Server.CreateObject("ADODB.Recordset")

r_ciudad = trim(lcase(request.QueryString("ciudad")))
select case r_ciudad
case "madrid"
	sql = "id_provincia=2"
case "barcelona"
	sql = "id_provincia=3"
case else
	sql = "id_provincia IS NULL"
end select

sql = "SELECT * FROM aux_subzonas WHERE " & sql & " ORDER BY nombre"

'response.Write(sql)
'response.End()
%>
<select id="subzona" name="subzona" onChange="CambiaSubzona();">
    <option value="" <% if request.Form("subzona")="" then %>selected<% end if %>>Todas las Subzonas</option>
	<% 
	rsQ.open sql, session("connPW")
	do while not rsQ.eof
        %><option value="<%= rsQ("id") %>"><%= lcase(rsQ("nombre")) %></option><%
        rsQ.movenext
    loop
    rsQ.close
    %>
</select>
<%
set rsQ = nothing
%>