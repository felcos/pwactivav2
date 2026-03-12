<!DOCTYPE html>
<html>
<head>
	<!-- meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /-->
	<link rel="stylesheet" href="/_inc/jm/reset.css" media="all" />
	<link rel="stylesheet" href="/_inc/jm/global.css">
	<link rel="stylesheet" href="/_inc/jm/estilos.css" type="text/css">
	<title>PropertyWeb - licencia</title>
	<!--#include virtual="/inc/js.asp" -->
    
<script type="text/javascript">
$(document).ready(function() { 
	// esperamos que el DOM cargue
	// definimos las opciones del plugin AJAX FORM
	var opciones= {
		beforeSubmit: mostrarLoader, //funcion que se ejecuta antes de enviar el form
		success: mostrarRespuesta, //funcion que se ejecuta una vez enviado el formulario
	};
	
	//asignamos el plugin ajaxForm al formulario frm_login y le pasamos las opciones
	$('#frm_login').ajaxForm(opciones) ; 
	
	//lugar donde defino las funciones que utilizo dentro de "opciones"
	function mostrarLoader(){
		//$("#loader_gif").fadeIn("slow");
		var ErrSubmit="";
		
		if (document.frm_login.password.value=="") {ErrSubmit="Tiene que introducir la clave de acceso.";}
		if (document.frm_login.cliente.value=="") {ErrSubmit="Tiene que introducir el nombre de cliente de su empresa.";}
		if (document.frm_login.usuario.value=="") {ErrSubmit="Tiene que introducir su nombre.";}
		
		if (ErrSubmit=="") {
			//$("#div_instrucciones").css({ display: 'none', });
		} else {
			informa(ErrSubmit);
			//$("#div_instrucciones").fadeIn("slow");
			return false;
			//elto.focus();
		}
	};
	function mostrarRespuesta (responseText){ 
		//$("#loader_gif").fadeOut("slow");
		$("#result").html(responseText);
	};
}); 

function informa(texto) {
	$("#div_instrucciones").html(texto);
	//if (texto=="") {$("#div_instrucciones").fadeOut("slow");}
}
</script>
<script language="javascript">
function comprobar_licencia(){	
	var variable_post="comprobar licencia";
	$.post("/acceso/informa_licencia.asp", { variable: variable_post }, function(data){
		$("#informa_licencia").html(data);
	});			
};

function comprobar_condiciones(){
	var variable_post="comprobar condiciones";
	$.post("/acceso/informa_condiciones.asp", { variable: variable_post }, function(data){
		$("#informa_condiciones").html(data);
	});
}

</script>

<!--#include virtual="/inc/reg_accesos.asp" -->
</head>
<body>
<div id="centrado">
   
<div id="contenedor_left">

<section id="noticias">
	<!--#include virtual="/acceso/password.asp" -->
    <% if session("PW_WS").boolAceptadasCondiciones then %>
    	<p>Ya han sido Aceptadas las Condiciones de Uso.</p>
		<p>&nbsp;</p>
		<p>&nbsp;</p>
		<p>&nbsp;</p>
        <div align="center"><input id="cierra" type="button" value="Cerrar"></div>
	<% end if %>
</section>


</div><!-- FIN: contenedor_left -->

<div id="contenedor_right">

<% if request.Cookies("dev")<>"" then %>
  <div id="mibloque" style="margin-bottom:10px; clear:both;">
    <div id="mibloque2" style="margin-bottom:10px; clear:both;">
      <!--#include virtual="/acceso/inc/informa_cliente.asp" -->
    </div>
  </div>
  
<div id="mibloque">
    <div id="informa_licencia" style="display:inline;">
    	<p>request.cookies(&quot;<b>licencia</b>&quot;)&nbsp;:&nbsp;<b><% if request.Cookies("licencia")="" then %>NO <% end if %></b>existe</p>
    </div>
    <span style="font-size:10px; padding-top:4px;"><a href="javascript:void();" onclick="javascript:comprobar_licencia();">comprobar licencia</a></span>
</div>
<% end if %>

<% if request.Cookies("dev")<>"" then %>
	<div id="mibloque" style="margin-bottom:10px; clear:both;">
        form: <%= request.form %><br>
        querystring: <%= request.QueryString %>
	</div>
<% end if %>

<div id="mibloque" style="margin-bottom:10px; clear:both;">
	<p><a href="/acceso/registro.asp">Registro sin JavaScript</a></p>
    <p>navegador: <%= left(request.ServerVariables("HTTP_USER_AGENT"), 11) %></p>
</div>

</div><!-- FIN: contenedor_right -->	


</div><!-- FIN: centrado -->

</body>
</html>

<script type="text/javascript">
//comprobar_licencia()
//comprobar_condiciones()

$(document).ready(function() { 
	//close ¿¿??
	$('#cierra').click(function(e) {
		parent.$.modal.close();
		return false;
    });
});
</script>