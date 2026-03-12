<a class="dropdown-toggle" data-toggle="dropdown" href="#">Subzonas <span class="caret"></span> </a>
<% set rsQ = Server.CreateObject("ADODB.Recordset")

r_ciudad = trim(lcase(request.QueryString("ciudad")))
select case r_ciudad
case "madrid"
	sql = "id_provincia=2"
case "barcelona"
	sql = "id_provincia=3"
case "londres"
	sql = "id_provincia=60"
case else
	sql = "id_provincia IS NULL"
end select

sql = "SELECT * FROM c_subzonas WHERE " & sql & " ORDER BY tipo, nombre"

'response.Write(sql)
'response.End()
tipo = ""
%>
<ul class="dropdown-menu dropdown-subzonas" id="ul-subzonas">
<li data-id=""><a href="#subzonas" data-toggle="tab" onclick="CambiaSubzona();">Todas las Subzonas</a></li>
<% 
rsQ.open sql, session("connPW")
do while not rsQ.eof
	if rsQ("tipo")<>tipo then
		tipo = rsQ("tipo")
		%><li><h6><%= ucase(tipo) %></h6></li><%
	end if
	
	%><li data-id="<%= rsQ("id") %>"><a href="#subzonas" data-toggle="tab" onclick="CambiaSubzona(<%= rsQ("id") %>);"><%= rsQ("nombre") %></a></li><%
	rsQ.movenext
loop
rsQ.close
%>
</ul>
<%
set rsQ = nothing
%>