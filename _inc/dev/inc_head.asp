<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="robots" content="noindex, nofollow">
<% select case request.Cookies("config")("css") %>
<% case "foldy" %>
	<link href="/_inc/dev/foldy/base.css" rel="stylesheet" type="text/css">
    
    <link href="/_inc/dev/foldy/grid.css" rel="stylesheet" type="text/css">
    <link href="/_inc/dev/foldy/grid-cols.css" rel="stylesheet" type="text/css">
    
    <link href="/_inc/dev/bootstrap/bootstrap.css" rel="stylesheet" type="text/css">
    <link href="/_inc/dev/bootstrap/grid.css" rel="stylesheet" type="text/css">
    <link href="/_inc/dev/bootstrap/panels.css" rel="stylesheet" type="text/css">
    <link href="/_inc/dev/bootstrap/list_groups.css" rel="stylesheet" type="text/css">
    
    <link href="/_inc/dev/foldy/estilos.css" rel="stylesheet" type="text/css">
    
    <link href="/_inc/dev/foldy/elements.css" rel="stylesheet" type="text/css">
	
	<% if request.cookies("config")("estilos2")<>"" then %>
        <link href="/_inc/dev/foldy/estilos2.css" rel="stylesheet" type="text/css">
        <link href="/_inc/dev/foldy/forms2.css" rel="stylesheet" type="text/css">
        <% if request.cookies("config")("sombras")<>"" then %>
            <link href="/_inc/dev/foldy/sombras.css" rel="stylesheet" type="text/css">
        <% end if %>

    <% end if %>
    
    <link href="/_inc/dev/javier-titulos_info.css" rel="stylesheet" type="text/css"/>
    <link href="/_inc/dev/javier-titulos.css" rel="stylesheet" type="text/css"/>
    
<% case "javier" %>
	<link href="/_inc/dev/javier/base.css" rel="stylesheet" type="text/css">
    <link href="/_inc/dev/javier/estilos.css" rel="stylesheet" type="text/css">
    
    <link href="/_inc/javier/form_boots.css" rel="stylesheet" type="text/css">
    
    <link href="/_inc/javier/titulos.css" rel="stylesheet" type="text/css"/>
    <link href="/_inc/javier/titulos_info.css" rel="stylesheet" type="text/css"/>
    
    <link href="/_inc/javier/leer_javier.css" rel="stylesheet" type="text/css"/><!-- css en articulos pasado a mi carpeta -->
    
    <!-- 
    <link href="/_inc/dev/foldy/grid.css" rel="stylesheet" type="text/css">
    <link href="/_inc/dev/foldy/grid-cols.css" rel="stylesheet" type="text/css">
    <link href="/_inc/dev/foldy/elements.css"/ rel="stylesheet" type="text/css">
     -->
     
    <link href="/css/fonts/fuentes.css" rel="stylesheet" type="text/css">
	<link href="/css/fonts/icomoon.css" rel="stylesheet" type="text/css"> <!--  borrar? -->
    
	<link href="/_inc/dev/bootstrap/js-components.css" rel="stylesheet" type="text/css">
    <link href="/_inc/dev/bootstrap/panels.css" rel="stylesheet" type="text/css">
    <link href="/_inc/dev/bootstrap/tables.css" rel="stylesheet" type="text/css">
    <link href="/_inc/dev/bootstrap/list_groups.css" rel="stylesheet" type="text/css">
    
    <!-- link href="/_inc/javier/header.css" rel="stylesheet" type="text/css"/ -->
    <!-- link href="/_inc/javier/footer.css" rel="stylesheet" type="text/css" -->
    
<% case "squared" %>
	<!--link href="/_inc/dev/foldy/base.css" rel="stylesheet" type="text/css"-->
    
    <link href="/_inc/dev/bootstrap/bootstrap.css" rel="stylesheet" type="text/css">
    <link href="/_inc/dev/bootstrap/bootstrap-javier.css" rel="stylesheet" type="text/css">
    <link href="/_inc/dev/bootstrap/bootstrap-round.css" rel="stylesheet" type="text/css">
    <!--  
    <link href="/_inc/dev/bootstrap/comun.css" rel="stylesheet" type="text/css">
	<link href="/_inc/dev/bootstrap/base.css" rel="stylesheet" type="text/css">
    <link href="/_inc/dev/bootstrap/base-padding.css" rel="stylesheet" type="text/css">
    <link href="/_inc/dev/bootstrap/grid.css" rel="stylesheet" type="text/css">
    <link href="/_inc/dev/bootstrap/tables.css" rel="stylesheet" type="text/css">
    <link href="/_inc/dev/bootstrap/forms.css" rel="stylesheet" type="text/css">
    <link href="/_inc/dev/bootstrap/buttons.css" rel="stylesheet" type="text/css">
    -->
    
    <link href="/_inc/dev/foldy/grid.css" rel="stylesheet" type="text/css">
    <link href="/_inc/dev/foldy/grid-cols.css" rel="stylesheet" type="text/css">
    
    <link href="/_inc/dev/bootstrap/panels.css" rel="stylesheet" type="text/css">
    <link href="/_inc/dev/bootstrap/list_groups.css" rel="stylesheet" type="text/css">
    
    <link href="/_inc/dev/bootstrap/js-components.css" rel="stylesheet" type="text/css">
    
    <!-- link href="/_inc/dev/foldy/estilos.css" rel="stylesheet" type="text/css" -->
    <link href="/_inc/dev/bootstrap/estilos.css" rel="stylesheet" type="text/css">
    
    <link href="/_inc/dev/foldy/elements.css" rel="stylesheet" type="text/css">
    
    <link href="/_inc/dev/squared/base.css" rel="stylesheet" type="text/css">
    <link href="/_inc/dev/squared/estilos.css" rel="stylesheet" type="text/css">
    <link href="/_inc/dev/squared/elements.css"/ rel="stylesheet" type="text/css">
    
    <% if request.cookies("config")("estilos2")<>"" then %>
        <link href="/_inc/dev/squared/estilos2.css" rel="stylesheet" type="text/css">
        <link href="/_inc/dev/squared/forms2.css" rel="stylesheet" type="text/css">
    <% end if %>
    
	<% if request.cookies("config")("sombras")<>"" then %>
        <link href="/_inc/dev/squared/sombras.css" rel="stylesheet" type="text/css">
    <% end if %>
	
    <link href="/_inc/dev/javier-titulos_info.css" rel="stylesheet" type="text/css"/>
    <link href="/_inc/dev/javier-titulos.css" rel="stylesheet" type="text/css"/>
    
<% case "bootstrap" %>
	<!-- link href="/_inc/dev/bootstrap/normalize.css" rel="stylesheet" type="text/css" -->
	
    <link href="/_inc/dev/bootstrap/bootstrap.css" rel="stylesheet" type="text/css">
    <link href="/_inc/dev/bootstrap/bootstrap-javier.css" rel="stylesheet" type="text/css">
    <!-- link href="/_inc/dev/bootstrap/bootstrap-round.css" rel="stylesheet" type="text/css" -->
    <!-- -->
    <link href="/_inc/dev/bootstrap/panels.css" rel="stylesheet" type="text/css">
    <link href="/_inc/dev/bootstrap/list_groups.css" rel="stylesheet" type="text/css">
    
    <link href="/_inc/dev/bootstrap/js-components.css" rel="stylesheet" type="text/css">
    
    <link href="/_inc/dev/javier-titulos_info.css" rel="stylesheet" type="text/css"/>
    <link href="/_inc/dev/javier-titulos.css" rel="stylesheet" type="text/css"/>
    
    <!-- -->
    <link href="/_inc/dev/bootstrap/estilos.css" rel="stylesheet" type="text/css">
    
    
    <!--link href="/_inc/dev/bootstrap/grid_foldy.css" rel="stylesheet" type="text/css"-->
    
    <!-- link href="/_inc/dev/bootstrap/estilos.css" rel="stylesheet" type="text/css" -->
    <!-- link href="/_inc/dev/bootstrap/elements.css" rel="stylesheet" type="text/css" -->
    
<% end select %>



<% select case request.Cookies("config")("modo")
case "foldy__", "old__" %>
	<link href="/_inc/dev/bootstrap/bootstrap.css" rel="stylesheet" type="text/css">
    
    <link href="/_inc/dev/bootstrap/panels.css" rel="stylesheet" type="text/css">
    <link href="/_inc/dev/bootstrap/list_groups.css" rel="stylesheet" type="text/css">
    
    <link href="/_inc/dev/bootstrap/estilos.css" rel="stylesheet" type="text/css">
    
<% end select %>


<link href="/css/fonts/icomoon.css"/ rel="stylesheet" type="text/css">
<link href="/_inc/jp/iconos.css"/ rel="stylesheet" type="text/css">

<% 
select case request.cookies("config")("nav") 
case "jetmenu" %><link href="/inc/body/jetmenu.css" rel="stylesheet" type="text/css"><% 
case else %><link href="/inc/body/simple.css" rel="stylesheet" type="text/css"><% 
end select 
%>

<% if request.Cookies("config")("headfoot")<>"" then %><link href="/_inc/<%= session("modo") %>/fix.css" rel="stylesheet" type="text/css"><% end if %>

<!--#include virtual="/inc/js.asp" -->
<script type="text/javascript">
$(document).ready(function() {
	$(".simplemodal").click(function(e) {
		e.preventDefault();
		
		var data = $(this).attr("href");
		data = data.substr( data.indexOf("?")+1, data.length);
		
		
		var conds = getCookie("condiciones");
		if ( conds=="" ) {
			//console.log("conds==''");
			
			$("#ModalBox").load(
				"/acceso/password.asp",
				data,
				function(recibe, textStatus, xhr) {
					$("#ModalBox").modal("show");
				}
			);
			
			return false;
			
		} else {
			//console.log(data)
			
			return false;
			$("<form action='/articulos/' method='post'>" + data + "</form>").appendTo("body").submit();
			
		}
		
			
	});
	
	
	
});
</script>