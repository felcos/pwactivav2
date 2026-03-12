<%
articulos = split(trim(replace(session("pw_ws").ArticulosLeidos(), "#", " ")))
response.Write(ubound(filter(articulos, request.QueryString("t")))+1)
%>