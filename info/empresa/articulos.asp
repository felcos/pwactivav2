<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%><%

cargar=false


if request.Form("historico_noticias")<>"" then cargar=true
if request.Form("historico_rumores")<>"" then cargar=true
if request.Form("historico_estudios")<>"" then cargar=true
if request.Form("historico_inversion")<>"" then cargar=true
if request.Form("historico_alquiler")<>"" then cargar=true


if not(cargar) then 
	
	response.End()
end if

if request.Form("historico_estudios")<>"" then act_tab="estudios"
if request.Form("historico_rumores")<>"" then act_tab="rumores"
if request.Form("historico_noticias")<>"" then act_tab="noticias"
if request.Form("historico_inversion")<>"" then act_tab="inversion"
if request.Form("historico_alquiler")<>"" then act_tab="alquiler"

set resultado = Server.CreateObject("ADODB.Recordset")
session("connPW").CommandTimeout = 120
%>
<!--#include virtual="/lib/funciones.asp" -->
<!--#include virtual="/info/empresa/calcular_sql.asp" -->
<!--#include virtual="/info/inc/lib_titulos.asp" -->
<!-- include virtual="/inc/js.asp" -->
<style>
#info_tit{
	/* 
	margin-top: 6px; 
	margin-bottom: 10px;
	*/
	margin-top: 3px; 
	font-family: Arial;
	font-size: 12px;
	border-bottom:1px dotted #dbdbdb;
}

.info_seccion {
	color:#000000;
	font-family:'ruda',sans-serif;
	border-radius: 3px
	;-moz-border-radius:3px;
	-webkit-border-radius:3px;
	font-size:20px;
	background-color:#e9e9e9;
	padding:10px;
}

.info_apartado {
	padding: 3px;
	font-size: 15px;
	color: #5b5b5b;
	border-radius:5px;
	-moz-border-radius:5px;
	-webkit-border-radius:5px;
	text-transform: uppercase;
	margin-bottom: 5px;
	background: white url(/img/trama_puntos_claros.png) repeat 0 0;
	margin-top:15px;
}
</style>
<% 'if 1=2 then
if request.Cookies("dev")<>"" then '("request")%>
<div style="background:#FFFFCC; font-size:11px; margin:2px;border:#000000 1px solid;">
form: &nbsp; <% for each elto in request.Form
	if request.Form(elto)<>"" then
		%><%= elto %>:[<%= request.Form(elto) %>]&nbsp;<%
	end if
next %>
</div>
<% end if %>
<form method="post" id="frm_titulos" name="frm_titulos" action="/articulos/">
<div class="PwTabs">
    <ul class="nav nav-tabs " style="" id=""><!-- class: + submenu lineNavs -->
        <% if request.Form("historico_alquiler")<>"" then %><li <% if act_tab="alquiler" then %>class="active"<% end if %>><a href="#tab_alquiler" data-toggle="tab" aria-expanded="true">Alquiler</a></li><% end if %>
		<% if request.Form("historico_inversion")<>"" then %><li <% if act_tab="inversion" then %>class="active"<% end if %>><a href="#tab_inversion" data-toggle="tab" aria-expanded="false">Inversi&oacute;n</a></li><% end if %>
        
        <% if request.Form("historico_noticias")<>"" then %><li <% if act_tab="noticias" then %>class="active"<% end if %>><a href="#tab_noticias" data-toggle="tab" aria-expanded="false">Noticias</a></li><% end if %>
        <% if request.Form("historico_rumores")<>"" then %><li <% if act_tab="rumores" then %>class="active"<% end if %>><a href="#tab_rumores" data-toggle="tab" aria-expanded="false">Web ha o&iacute;do...</a></li><% end if %>
        <% if request.Form("historico_estudios")<>"" then %><li <% if act_tab="estudios" then %>class="active"<% end if %>><a href="#tab_estudios" data-toggle="tab" aria-expanded="false">Estudios</a></li><% end if %>
        <% if 1=2 then
		'if request.Form("ofertas")<>"" then %><li>Ofertas</li>
        <span style="float:right; margin-top:8px;"><input type="checkbox" id="check_all" onChange="marcar()" style="float:right; margin-top:3px;"><% if request.Cookies("dev")<>"" then %>[<%= origen %>] <% end if %>seleccionar todos los art&iacute;culos</span><% end if %>
    </ul>
    
	<div class="tab-content">
		<% if request.Form("historico_alquiler")<>"" then %><div class="tab-pane <% if act_tab="alquiler" then %>active<% end if %>" id="tab_alquiler" ><% call operaciones("alquiler") %></div><% end if %>
		<% if request.Form("historico_inversion")<>"" then %><div class="tab-pane <% if act_tab="inversion" then %>active<% end if %>" id="tab_inversion"><% call operaciones("inversion") %></div><% end if %>
		<% if request.Form("historico_noticias")<>"" then %><div class="tab-pane <% if act_tab="noticias" then %>active<% end if %>" id="tab_noticias"><% call noticias %></div><% end if %>
		<% if request.Form("historico_rumores")<>"" then %><div class="tab-pane <% if act_tab="rumores" then %>active<% end if %>" id="tab_rumores"><% call cotilleos %></div><% end if %>
		<% if request.Form("historico_estudios")<>"" then %><div class="tab-pane <% if act_tab="estudios" then %>active<% end if %>" id="tab_estudios"><% call estudios %></div><% end if %>
		<% if 1=2 then 		'if request.Form("ofertas")<>"" then %><div><% call ofertas %></div><% end if %>
    </div>
</div>

<div style="clear:both;"></div>
	<input type="hidden" name="origen" value="info-empresa">
    <input type="hidden" name="secc" value="empr">
	<% for each elto in request.Form
        select case elto
        case "origen"
        case "not", "rum", "est", "ope", "ven", "sub", "dem"
        'case "noticias", "rumores", "estudios", "op_inversion", "op_alquiler"
        case else
            %><input type="hidden" name="<%= elto %>" value="<%= request.Form(elto) %>" /><%
        end select
    next %>
    <div style="text-align:center; margin: 40px;"><input type="submit" id="submit" value="Leer Art&iacute;culos Seleccionados" class="btn"></div>
</form>

<script type="text/javascript">
jQuery(function ($) {

	$(".articulos").click(function(e) {
		//e.preventDefault();
		var href = $(this).attr("href");
		href = href.substr( href.indexOf("?")+1, href.length);
		
		if ( getCookie("condiciones")=="" ) {
			$("#ModalBox").load(
				"/acceso/password.asp",
				href,
				function(recibe, textStatus, xhr) { $("#ModalBox").modal("show"); }
			);
			return false;
			
		} else {
			/*
			var inputs = href.split("&")
			var frm = jQuery("<form>", {"action": "/articulos/", "method": "post"})
			
			inputs.forEach(function (elem, index, array) {
					var datos = elem.split("=")
					
					frm.append(jQuery("<input>", {
						"name": datos[0],
						"value": datos[1],
						"type": "hidden"
					}))
				})
			
			frm.submit();
			*/
		}
			
	});
	
	$("#frm_titulos").submit(function(){
		if ($("#frm_titulos input:checkbox:checked").length<=0) {
			//alert("Debe seleccionar algún artículo. \n\nMarque los artículos que quiera leer y vuelva a intentarlo.\n");
			$("#ModalBox").load(
				"/articulos/nada_seleccionado.asp",
				function(recibe, textStatus, xhr) { $("#ModalBox").modal("show"); }
			);
			return false;
		};
		
		if ( getCookie("condiciones")=="" ) {
			$("#ModalBox").load(
				"/acceso/password.asp",
				$("#frm_titulos").serialize(),
				function(recibe, textStatus, xhr) {}
			);
			
			$("#ModalBox").modal("show");
			
			return false;
			
		} else {}
		
	});
	
});

function marcar() { 
	if(document.getElementById("check_all").checked==true){
	   for (i=0;i<document.frm_titulos.elements.length;i++) 
		  if(document.frm_titulos.elements[i].type == "checkbox") 
			 document.frm_titulos.elements[i].checked=1; 
   }else{
		for (i=0;i<document.frm_titulos.elements.length;i++) 
		  if(document.frm_titulos.elements[i].type == "checkbox") 
			 document.frm_titulos.elements[i].checked=0
   };
   return false;
}


</script>
