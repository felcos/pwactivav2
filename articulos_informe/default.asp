<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% if request.QueryString<>"" then %>
<form action="/articulos_informe/" method="post" id="frm_articulos">
	<% for each elto in request.QueryString 
		if request.QueryString(elto)<>"" then %>
			<input type="hidden" name="<%= elto %>" value="<%= request.QueryString(elto) %>" />
			
		<% 
		end if
	next %>
    <input id="submit" type="submit" style="display:none;"/>
</form>
<script>document.getElementById("submit").click();</script><%
response.End()
end if %>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<!-- meta charset="utf-8" -->


<%
'session("origen") = ""
if request.Form<>"" then 
	listaNavegar=""
	
	pag_origen=request.Form("origen")
	select case pag_origen
	case "flash", "DailyFlash"
		if request.Form("f")<>"" then
			pag_origen = pag_origen & " " & request.Form("f")
		end if
	end select
	session("origen") = pag_origen
	
	session("secc") = request.Form("secc")
	
	
	call AgregarValores(request.Form("not"), "not")
	'call AgregarValores(request.Form("notici"),"not")
	
	call AgregarValores(request.Form("rum"), "rum")
	'call AgregarValores(request.Form("rumores"),"rum")
	call AgregarValores(request.Form("web"),"rum")
	
	call AgregarValores(request.Form("est"), "est")
	'call AgregarValores(request.Form("estudios"),"est")
	
	call AgregarValores(request.Form("ope"), "ope")
	'call AgregarValores(request.Form("operac"),"ope")
	
	call AgregarValores(request.Form("ven"), "ven")
	call AgregarValores(request.Form("sub"), "sub")
	call AgregarValores(request.Form("dem"), "dem")
	'call AgregarValores(request.Form("ofe"), "ofe")
	
	call AgregarValores(request.Form("dis"), "dis")

	call AgregarValores(request.Form("t4a"), "t4a")
	
	session("ArticulosSeleccionados") = listaNavegar
	'session("fecha_pagsum")=request("R1")
	
end if

lista = split(session("ArticulosSeleccionados"), ",")
max = ubound(lista)


if session("ArticulosSeleccionados")="" then 
	if request.Cookies("dev")="" then response.Redirect("/")
	'else
	response.Write("sin nada seleccionado")
	
	if request.Cookies("dev")<>"" then %>
    	<p>QueryString</p>
        <% for each elto in request.QueryString %>
	    	<li><%= elto %>: <%= request.QueryString(elto) %></li>
        <% next %>
        
      	<p>Form</p>
        <% for each elto in request.Form %>
	    	<li><%= elto %>: <%= request.Form(elto) %></li>
        <% next %>
	<% end if
	
	response.End()
end if

'''''''
''''dim resultado
%>
<!DOCTYPE html>
<html lang="es">
<head>
<title>PropertyWeb - Tu servicio de Informaci&oacute;n Inmobiliaria</title>
	<!--#include virtual="/inc/head.asp" -->
	<link href="/css/estilos_jm-ok.css" rel="stylesheet" type="text/css">
    
	<script src="/lib/fancyBox/jquery.fancybox.js" type="text/javascript"></script>
	<link href="/lib/fancyBox/jquery.fancybox.css" media="screen" rel="stylesheet" type="text/css" />
    
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC_5kUZnI4pDgH19ptKkMuneHuz0tJ5P6g&region=ES"></script>
    <!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-143927921-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-143927921-1');
</script>
</head>
<body>

<div id="" class="container">
    <% 
    'on error resume next
    Set rsArticulos = Server.CreateObject("ADODB.Recordset")
    listNav=split(session("ArticulosSeleccionados"), ",")
    
	swVolver = true
    volver_simple = false
    origen = request.Form("origen")
	
    select case request.Form("origen")
	case "ope"
		url = "/dealanalysis/"
	
    case "top_day", "top_week"
        url = "/"
        volver_simple = true
        origen = "home"
		
    case "flash", "DailyFlash"
        url = "/flash/"
        'if datediff("d", request.Form("f"), date)=0 then volver_simple = true
        'if request.Form("f")="" then volver_simple = true
        
    case "info-inmuebles", "info-inmueble"
        url = "/info/edificio/"
    case "info-empresas", "info-empresa"
        url = "/info/empresa/"
        
	case "mailDeals"
		swVolver=false
		url = "/"
		
    case else
		'origen
		select case request.Form("secc")
		case "edif"
			url = "/info/edificio/"
		case "cc"
			url = "/info/centro/"
		case "hot"
			url = "/info/hotel/"
		
		case "empr"
			url = "/info/empresa/"
		
		case "ope"
			url = "/dealanalysis/"
		
		case "prop"
			select case request.Form("tipoedificio")
			case "0"
				url = "/info/edificio/"
			case "1"	
				url = "/info/centro/"
			case "2"
				url = "/info/hotel/"
			end select
			'url = request.ServerVariables("HTTP_REFERER")
		case else
	        url = "/" & request.Form("secc") & "/"
		end select
    end select
    
    
    informa = ""
    %>
    <nav class="barraNav">

        <% if request.Cookies("dev")<>"" then %>
        <button type="submit" class="btn blanco" disabled="disabled"/>origen <span class="lineLeft"><%= session("origen") %></span></button>
        <% end if %>
        
        <% if max<1 then	'and request.Cookies("dev")="" then 
		else %>
            <div class="btnsSiguiente">
                <a href="#" id="navPrev" class="btn blancoHover <% if max=0 then %>disabled<% end if %>">
                    <span class="icon icon-arrow-left"></span>
                    <span class="lineLeft hidden-xs">anterior</span>
                </a>
                <a class="btn blancoHover" id="shMisArticulos">
                    <span class="icon icon-file-text visible-xs-inline"></span> 
                    <span class="hidden-xs">seleccionados</span>
                    <span class="icon icon-arrow-down2 lineLeft"></span>
                </a>
                <a href="#" id="navNext" class="btn blancoHover <% if max=0 then %>disabled<% end if %>">
                    <span class="hidden-xs">siguiente</span>
                    <span class="icon icon-arrow-right lineLeft "></span>
                </a>
            </div>
            <div id="divMisArticulos" class="seleccionados">
            <% if left(session("ArticulosSeleccionados"), 3)="dis" then %>
                <!-- Disponibilidad -->
                <div><img src="/img/apunta.gif">&nbsp;Disponibilidad</div>
                <div id="txt_nav">
                    <% for kk=0 to ubound(listNav)
                        if left(listNav(kk),3)="dis" then 
                            %><div id="disponibilidad"><% call MiTitulo("disponibilidad", kk, "disponibilidad") %></div><% 
                        end if
                    next %>
                </div>
            <% else %>
                <!-- Noticias -->
                <div><img src="/img/apunta.gif">&nbsp;Noticias</div>
                <% if instr(session("ArticulosSeleccionados"), "not") then %>
                    <div id="txt_nav">
                        <% for kk=0 to ubound(listNav)
                            if left(listNav(kk),3)="not" then %>
                        <div id="not">
                          <% call MiTitulo("C_NOTICIAS_INMOBILIARIAS", kk, "noticias") %>
                        </div>
                            <% end if
                        next %>
                    </div>
                <% end if %>
                
                <!-- Rumores -->
                <div><img src="/img/apunta.gif">&nbsp;&quot;Web" ha o&iacute;do...</div>
                <% if instr(session("ArticulosSeleccionados"), "rum") then %>
                    <div id="txt_nav">
                        <% for kk=0 to ubound(listNav)
                                if left(listNav(kk),3)="rum" then %>
                            <div id="rum">
                              <% call MiTitulo("C_NOTICIAS_INMOBILIARIAS", kk, "rumores") %>
                            </div>
                        <% end if
                            next %>
                    </div>
                <% end if %>
                

                <!-- t4a-->
                <div><img src="/img/apunta.gif">&nbsp;&quot; Time4aChange</div>
                <% if instr(session("ArticulosSeleccionados"), "t4a") then %>
                    <div id="txt_nav">
                        <% for kk=0 to ubound(listNav)
                                if left(listNav(kk),3)="t4a" then %>
                            <div id="t4a">
                              <% call MiTitulot4ac("View_Time4Change", kk, "t4a") %>
                            </div>
                        <% end if
                            next %>
                    </div>
                <% end if %>



                <!-- Estudios -->
                <div><img src="/img/apunta.gif">&nbsp;Estudios</div>
                <% if instr(session("ArticulosSeleccionados"), "est") then %>
                    <div id="txt_nav">
                        <% for kk=0 to ubound(listNav)
                                if left(listNav(kk),3)="est" then %>
                            <div id="est">
                                <% call MiTitulo("C_NOTICIAS_INMOBILIARIAS", kk, "estudios") %>
                            </div>
                        <% end if
                            next %>
                    </div>
                <% end if %>
                
                <!-- Operacs. -->	
                <div><img src="/img/apunta.gif">&nbsp;Deal Analysis</div>
                <% if instr(session("ArticulosSeleccionados"), "ope") then %>
                    <div id="txt_nav">
                        <% for kk=0 to ubound(listNav)
                                if left(listNav(kk),3)="ope" then %>
                            <div id="operaciones">
                                <% call MiTitulo("OPERACIONES", kk, "ope") %>
                            </div>
                        <% end if
                            next %>
                    </div>	
                <% end if %>
                
                <!-- Vencimientos -->
                <div><img src="/img/apunta.gif">&nbsp;Vencimientos</div>
                <% if instr(session("ArticulosSeleccionados"), "ven") then %>
                    <div id="txt_nav">
                        <% for kk=0 to ubound(listNav)
                            if left(listNav(kk),3)="ven" then %>
                            <div id="vencimientos">
                                <% call MiTitulo("c_vencimientos", kk, "ven") %>
                            </div>
                            <% end if
                            next %>
                    </div>	
                <% end if %>
                
                <!-- Subastas -->
                <div><img src="/img/apunta.gif">&nbsp;Subastas/Concursos</div>
                <% if instr(session("ArticulosSeleccionados"), "sub") then %>
                    <div id="txt_nav">
                        <% for kk=0 to ubound(listNav)
                                if left(listNav(kk),3)="sub" then %>
                            <div id="subastas">
                                <% call MiTitulo("concursos", kk, "sub") %>
                            </div>
                        <% end if
                            next %>
                    </div>	
                <% end if %>
                
                <!-- Demandas -->
                <div><img src="/img/apunta.gif">&nbsp;Demandas</div>
                <% if instr(session("ArticulosSeleccionados"), "dem") then %>
                    <div id="txt_nav">
                        <% for kk=0 to ubound(listNav)
                            if left(listNav(kk),3)="dem" then 
                                %><div id="demandas"><% call MiTitulo("C_NOTICIAS_INMOBILIARIAS", kk, "demandas") %></div><% 
                            end if
                        next %>
                    </div>
                <% end if %>
                
            <% end if %>
            </div>
        <% end if %>
    </nav>
    
	<!-- barra navegacion::-->
    <% if request.Cookies("dev")<>"" then %>
    <div class="row jj_articulos">
        <div class="caja dev">Form: 
        <% for each elto in request.Form 
            if request.Form(elto)<>"" then %>[<b><%= elto %></b> = <%= request.Form(elto) %>] &nbsp; <% end if 
        next %>
        </div>
    </div>
    <% end if %>
    
    <div class="row jj_articulos">
        <article>
        	<% if left(session("ArticulosSeleccionados"),3)="dis" then %>
				<div id="" class="container"><section class="caja info" id="contenido-articulo"></section></div>
            <% else %>
				<div class="caja_articulos" id="contenido-articulo" style="min-height:450px;"></div>
            <% end if %>
        </article>
    </div>
    
</div>

</body>
</html>

<%
''''set resultado = nothing
sub MiTitulo(tbl, num, apartado)	
		mm=instr(listNav(num),"=")
		valor=right(listNav(num),len(listNav(num))-mm)
		sql= "SELECT ID, TITULO FROM "& tbl & " WHERE ID = " & valor
		
		rsArticulos.Open sql, session("connPW")
		if rsArticulos.eof and rsArticulos.bof then
			%>Art&iacute;culo Inexistente<br><%
		else
			texto=lcase(rsArticulos("TITULO"))
			texto=replace(texto, "'", "´")
			if request.Cookies("dev")<>"" then texto = "[" & rsArticulos("id") & "] " & texto
			if len(texto)>38 then texto = trim(left(texto,35)) & "..."
			
			texto="<acronym title='" & lcase(rsArticulos("TITULO")) & "'>" & texto & "</acronym>"
			
			'urlEnlace="/articulos/?cons=" & listNav(num) & "&nav=" &  num 
			urlEnlace="/articulos/?" & listNav(num) 
			'listNav(kk)
			%><a href="<%= urlEnlace %>" class="carga-articulo" data-id="<%= num %>" id="<%= replace(listNav(kk),"=","") %>"><%= texto %></a><%
		end if
		rsArticulos.close
end sub 

sub MiTitulot4ac(tbl, num, apartado)	
		mm=instr(listNav(num),"=")
		valor=right(listNav(num),len(listNav(num))-mm)
		sql= "SELECT * FROM "& tbl & " WHERE id = " & valor
		
		rsArticulos.Open sql, session("connPW")
		if rsArticulos.eof and rsArticulos.bof then
			%>Art&iacute;culo Inexistente<br><%
		else
			texto=lcase(rsArticulos("Titulo"))
			texto=replace(texto, "'", "´")
			if request.Cookies("dev")<>"" then texto = "[" & rsArticulos("id") & "] " & texto
			if len(texto)>38 then texto = trim(left(texto,35)) & "..."
			
			texto="<acronym title='" & lcase(rsArticulos("Titulo")) & "'>" & texto & "</acronym>"
			
			'urlEnlace="/articulos/?cons=" & listNav(num) & "&nav=" &  num 
			urlEnlace="/articulos/?" & listNav(num) 
			'listNav(kk)
			%><a href="<%= urlEnlace %>" class="carga-articulo" data-id="<%= num %>" id="<%= replace(listNav(kk),"=","") %>"><%= texto %></a><%
		end if
		rsArticulos.close
end sub 

Sub AgregarValores(lista, apartado)	
	'on error resume next
	if lista<>"" then
		'tmpLista = OrdenarArr(lista)
		tmpLista = split(OrdenaList(lista), ",")
		'tmpLista = OrdenarArr(tmpLista)
		mm=ubound(tmpLista)
		if listaNavegar<>"" then listaNavegar=listaNavegar & ","
		for ii=0 to mm
			listaNavegar=listaNavegar & apartado & "=" & clng(tmpLista(ii))
			if ii <> mm then listaNavegar=listaNavegar & ","
		next
	end if
End sub

Sub AgregarVencimientos(lista)	
	on error resume next
	session("lista_vencimientos")=""
	if lista<>"" then
		tmpLista=split(lista,",")
		mm=ubound(tmpLista)
		if listaNavegar<>"" then listaNavegar = listaNavegar & ","
		listaNavegar = listaNavegar & "vencim=" & mm+1
		for ii=0 to mm
			session("lista_vencimientos") = session("lista_vencimientos") & clng(tmpLista(ii))
			if ii <> mm then session("lista_vencimientos") = session("lista_vencimientos") & ","
		next
	end if
End sub

Function OrdenaList(pList)	
	arr = split(pList, ",")
	Max=ubound(arr)
	
	for i=0 to Max 
		arr(i)=trim(arr(i))
	next
	
	for i=0 to Max  
	   for j=i+1 to Max  
	      if arr(i)>arr(j) then 
	          TmpValue=arr(i) 
	          arr(i)=arr(j) 
	          arr(j)=TmpValue 
	     end if 
	   next  
	next
	OrdenaList = Join(arr, ",")
End Function

Function OrdenaArr(pList)	
	arr = split(pList, ",")
	Max=ubound(arr)
	For i=0 to Max  
	   For j=i+1 to Max  
	      If arr(i)>arr(j) Then 
	          TmpValue=arr(i) 
	          arr(i)=arr(j) 
	          arr(j)=TmpValue 
	     End if 
	   Next  
	Next
	OrdenaArr = arr
End Function
%>

<script language="javascript">
function imprimir() {
	window.print();
}

var nav=0;

function carga_articulo(nn) {
	$("#divMisArticulos").slideUp();
	
	var url = "nav=" + nn;
	<% if request.form("origen")<>"" then %>
	url = url + "&origen=<%= request.form("origen") %>"
	<% end if %>
	$("#contenido-articulo").load(
		"/articulos/articulo.asp",
		url
	);
}

$(document).ready(function() {
	
	$("#shMisArticulos").click(function(e) {
        e.preventDefault();
		$("#divMisArticulos").slideToggle();
    });
	
	/*
	$("#shMisArticulos").mouseover(function(e) {
        e.preventDefault();
		$("#divMisArticulos").slideDown();
    });
	$("#divMisArticulos").mouseout(function(e) {
        e.preventDefault();
		$("#divMisArticulos").slideUp();
    });
	*/
	
	
	$(".carga-articulo").click(function(e) {
        e.preventDefault()
		console.log($(this).data("id"));
		carga_articulo($(this).data("id"));
		/*
		nav = $(this).data("id");
		$("#contenido-articulo").load(
			"/articulos/articulo.asp",
			"nav=" + nav
		);
		*/
    });
	
	$("#navNext").click(function(e) {
		e.preventDefault()
		if (nav==<%= max %>) {
			nav = 0
		} else {
			nav = nav+1
		}
		//console.log(nav)
		carga_articulo(nav)
	})
	$("#navPrev").click(function(e) {
		e.preventDefault()
		if (nav==0) {
			nav = <%= max %>
		} else {
			nav = nav-1
		}
		//console.log(nav)
		carga_articulo(nav)
	})
	
	carga_articulo(nav)
	
<% 'if request.Cookies("condiciones")="true" then %>
	//carga_articulo(nav)
<% 'else
IF 1=2 THEN
'if session("IniCliente")>0 then %>
	var frm = jQuery("<form>", {"action": "/articulos/", "method": "post"})
	var inputs;
	
	<% if request.Form<>"" then
		for each elto in request.Form %>
		frm.append(jQuery("<input>", {
			"name": "<%= elto %>",
			"value": "<%= request.Form(elto) %>",
			"type": "hidden"
		}))
		<% next
	elseif request.QueryString<>"" then
		for each elto in request.QueryString %>
		frm.append(jQuery("<input>", {
			"name": "<%= elto %>",
			"value": "<%= request.QueryString(elto) %>",
			"type": "hidden"
		}))
		<% next 
	else %>
		alert("sin nada seleccionado");
		return false;
	<% end if %>
	
	$("#ModalBox").load(
		"/acceso/password.asp",
		frm.serialize(),
		function(recibe, textStatus, xhr) { 
			$("#ModalBox").modal("show");
		}
	);
	
<% end if %>
})
</script>
