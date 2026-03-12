<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<form action="/articulos/" method="post" name="frm_titulos" id="frm_titulos"><% 
if request.Form<>"" then
	for each elto in request.Form
		%><input type="hidden" name="<%= elto %>" value="<%= request.Form(elto) %>" /><%
	next 
else
	for each elto in request.QueryString
		%><input type="hidden" name="<%= elto %>" value="<%= request.QueryString(elto) %>" /><%
	next 
end if %>
</form>
<script>
document.frm_titulos.submit()
</script>
<% response.End()


'variables	
listaNavegar=""

if request.Form<>"" then 
	pag_origen=request.form("origen")
	if request.Form("f")<>"" then
		pag_origen = pag_origen & " " & request.Form("f")
	end if
	
	call AgregarValores(request.Form("notici"),"not")
	call AgregarValores(request.Form("not"),"not")
	call AgregarValores(request.Form("rumores"),"rum")
	call AgregarValores(request.Form("rum"),"rum")
	call AgregarValores(request.Form("web"),"rum")
	call AgregarValores(request.Form("estudios"),"est")
	call AgregarValores(request.Form("est"),"est")
	call AgregarValores(request.Form("operac"),"ope")
	call AgregarValores(request.Form("ope"),"ope")
	call AgregarValores(request.Form("sub"),"sub")
	call AgregarValores(request.Form("dem"),"dem")
	'call AgregarVencimientos(request.Form("ven"))
	call AgregarValores(request.Form("ven"),"ven")
	
	session("leer_articulos")=true
	
elseif request.QueryString<>"" then	
	pag_origen=request.QueryString("origen")
	if request.QueryString("f")<>"" then
		pag_origen = pag_origen & " " & request.QueryString("f")
	end if
	
	call AgregarValores(request.QueryString("notici"),"not")
	call AgregarValores(request.QueryString("not"),"not")
	call AgregarValores(request.QueryString("rumores"),"rum")
	call AgregarValores(request.QueryString("rum"),"rum")
	call AgregarValores(request.QueryString("web"),"rum")
	call AgregarValores(request.QueryString("estudios"),"est")
	call AgregarValores(request.QueryString("est"),"est")
	call AgregarValores(request.QueryString("operac"),"ope")
	call AgregarValores(request.QueryString("ope"),"ope")
	call AgregarValores(request.QueryString("sub"),"sub")
	call AgregarValores(request.QueryString("dem"),"dem")
	'call AgregarVencimientos(request.QueryString("ven"))
	call AgregarValores(request.QueryString("ven"),"ven")
	
	session("leer_articulos")=true
	
else
	
end if
session("ArticulosSeleccionados") = listaNavegar
'session("fecha_pagsum") = request("R1")
session("origen") = pag_origen

if session("modo")="javier" or session("modo")="" then 
	response.Redirect("/articulos/")
else
	response.Redirect("/")
end if
%>
<% 'if request.Cookies("dev")<>"" then %>
<hr />
	<p><strong>session(ArticulosSeleccionados)</strong>:</p>
	<%= replace(session("ArticulosSeleccionados"), ",", ",<br>") %>
	<p><strong>session origen</strong>: <%= pag_origen %></p>
	<p><a href="/">continuar a... /</a></p>
<% 'end if %>

<% Sub AgregarValores(lista, apartado)	
	on error resume next
	if lista<>"" then
		tmpLista=split(lista,",")
		mm=ubound(tmpLista)
		if listaNavegar<>"" then listaNavegar=listaNavegar & ","
		for ii=0 to mm
			listaNavegar=listaNavegar & apartado & "=" & clng(tmpLista(ii))
			if ii <> mm then listaNavegar=listaNavegar & ","
		next
	end if
End sub %>

<% Sub AgregarVencimientos(lista)	
	on error resume next
	session("lista_vencimientos")=""
	if lista<>"" then
		tmpLista=split(lista,",")
		mm=ubound(tmpLista)
		if listaNavegar<>"" then listaNavegar = listaNavegar & ","
		listaNavegar = listaNavegar & "ven=" & mm+1
		for ii=0 to mm
			session("lista_vencimientos") = session("lista_vencimientos") & clng(tmpLista(ii))
			if ii <> mm then session("lista_vencimientos") = session("lista_vencimientos") & ","
		next
	end if
End sub %>
