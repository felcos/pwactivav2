<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%><% 

cargar=false

if request.Form("historico_noticias")<>"" then cargar=true
if request.Form("historico_rumores")<>"" then cargar=true
if request.Form("historico_estudios")<>"" then cargar=true
if request.Form("historico_inversion")<>"" then cargar=true
if request.Form("historico_alquiler")<>"" then cargar=true

if not(cargar) then response.End()

if request.Form("historico_estudios")<>"" then act_tab="estudios"
if request.Form("historico_rumores")<>"" then act_tab="rumores"
if request.Form("historico_noticias")<>"" then act_tab="noticias"
if request.Form("historico_inversion")<>"" then act_tab="inversion"
if request.Form("historico_alquiler")<>"" then act_tab="alquiler"

set resultado = Server.CreateObject("ADODB.Recordset")
session("connPW").CommandTimeout = 120
%>
<!--#include virtual="/info/inc/calcular_sql.asp" -->
<!--#include virtual="/info/inc/lib_titulos_informe.asp" -->
<form method="post" id="frm_titulos" name="frm_titulos" action="/articulos/">
<% if request.Cookies("dev")<>"" then 
	%><span class="dev"><%
	for each elto in request.Form
		%>[<%= elto %>: <%= request.Form(elto) %>] <%
	next
	%></span><%
end if%>
<div >

  
		<% if request.Form("historico_alquiler")<>"" then %><div id="tab_alquiler" ><h2 style="color:#0973AE">Operaciones de Alquiler</h2><% call operaciones("alquiler") %></div><% end if %>
		<% if request.Form("historico_inversion")<>"" then %><div id="tab_inversion"><h2 style="color:#0973AE">Operaciones de Inversi&oacute;n</h2><% call operaciones("inversion") %></div><% end if %>
		<% if request.Form("historico_noticias")<>"" then %><div id="tab_noticias"><h2 style="color:#0973AE">Noticias</h2><% call noticias %></div><% end if %>
		<% if request.Form("historico_rumores")<>"" then %><div id="tab_rumores"><h2 style="color:#0973AE">Rumores</h2><% call cotilleos %></div><% end if %>
		<% if request.Form("historico_estudios")<>"" then %><div id="tab_estudios"><h2 style="color:#0973AE">Estudios</h2><% call estudios %></div><% end if %>
		
		<% if 1=2 then %><div class="tab-pane" id="tab_ofertas"><% call ofertas %><br></div><% end if %>

	
</div>
<div style="clear:both;"></div>
<!-- input type="hidden" name="origen" value="< %= request.Form("frmInfo_tipo") %>" -->
<% for each elto in request.Form
	select case elto
	case "not", "rum", "est", "ope", "ven", "sub", "dem"
	case else
		%><input type="hidden" name="<%= elto %>" value="<%= request.Form(elto) %>" /><%
	end select
next %>
	
</form>
<% if request.Cookies("dev")("request")<>"" then %>
<div style="background:#FFFFCC; font-size:11px; margin:2px;border:#000000 1px solid;">
	form: &nbsp; <% for each elto in request.Form
		if request.Form(elto)<>"" then
			%><%= elto %>:[<%= request.Form(elto) %>]&nbsp;<%
		end if
	next %>
</div>
<% end if %>
<script type="text/javascript">
$(document).ready(function () {
	
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
			});
			
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