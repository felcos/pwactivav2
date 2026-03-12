<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/lib/aspjson/JSON_2.0.4.asp" -->
<!--#include virtual="/lib/aspjson/JSON_UTIL_0.1.1.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<%
if request.Cookies("dev")<>"" then
	for each elto in request.Form
		response.Write(elto & ":" & request.Form(elto) & " // ")
	next
end if

set rsBusq = Server.CreateObject("ADODB.Recordset")
%><!--#include virtual="/nidisp/titulos.asp" --><% 
set rsBusq=nothing 
%>
<script>
//console.log("ajax recibe")
</script>