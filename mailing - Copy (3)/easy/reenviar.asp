<% 'variables 
if request.QueryString("origen")="easy" then
	session("easy")="old"
else
	session("easy")="new"
end if
if request.QueryString<>"" then	
	if request.QueryString("vivienda")<>"" then
		session("easy_tipo")="vivienda"
		session("easy_id")=request.QueryString("vivienda")
	elseif request.QueryString("oficina")<>"" then
		session("easy_tipo")="oficina"
		session("easy_id")=request.QueryString("oficina")
	elseif request.QueryString("parque") <>"" then
		session("easy_tipo")="parque"
		session("easy_id")=request.QueryString("parque")
	elseif request.QueryString("solar") <>"" then
		session("easy_tipo")="solar"
		session("easy_id")=request.QueryString("solar")
	elseif request.QueryString("poligono")<>"" then
		session("easy_tipo")="poligono"
		session("easy_id")=request.QueryString("poligono")
	elseif request.QueryString("hotel") <>"" then
		session("easy_tipo")="hotel"
		session("easy_id")=request.QueryString("hotel")
	elseif request.QueryString("naves") <>"" then
		session("easy_tipo")="naves"
		session("easy_id")=request.QueryString("naves")
	elseif request.QueryString("local") <>"" then
		session("easy_tipo")="local"
		session("easy_id")=request.QueryString("local")
	elseif request.QueryString("centro")<>"" then
		session("easy_tipo")="centro"
		session("easy_id")=request.QueryString("centro")
	else
		response.Write "<p>Sin datos SUFICIENTES.</p>"
		response.End()
	end if
else	
	response.Write "<p>Sin datos.</p>"
	response.End()
end if
%>
<head>
<title>mostrar</title>
</head>
<body onLoad="reenvia();">
  <%  
  if 1=2 then %>
    <p>session("easy_tipo") = <%= session("easy_tipo") %></p>
	<p>session("easy_id") = <%= session("easy_id") %></p>
    <p>session("easy") = <%= session("easy") %></p>
	<hr>
	<p><strong>origen</strong>: <%= request("origen") %></p>
	<hr>
    <br><br>
	<p>continuar a... <a href="/easy/visor.asp">/easy/visor.asp</a></p>
    <br><br>
  <% end if %>
</body>
</html>

<script language="javascript">
<!--
function reenvia() {
	var ventana = window.self; 
	//ventana.location='/easy/visor.asp'
	alert('reenviar...')
}
//-->
</script>
