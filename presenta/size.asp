<%
'response.Write("<li>session(presenta_font_size): " & session("presenta_font_size") & "</li>")
'response.Write("<hr>")
 
select case request.QueryString("letra")
	case "reset"
		session("presenta_font_size") = 5
	case "aumentar"
		if session("presenta_font_size")<9 then session("presenta_font_size") = session("presenta_font_size")+1
	case "disminuir"
		if session("presenta_font_size")>0 then session("presenta_font_size") = session("presenta_font_size")-1
end select

'response.Write("<li>session(presenta_font_size): " & session("presenta_font_size") & "</li>")

'redir = request.ServerVariables("HTTP_REFERER")
redir = "/presenta/?p=" & request.QueryString("p")
response.Redirect(redir)
%>
<hr>
<% for each elto in request.QueryString 
	%><li><%= elto %>: <%= request.QueryString(elto) %></li><%
next %>
<hr />
Continuar a.... <a href="<%= redir %>"><%= redir %></a>