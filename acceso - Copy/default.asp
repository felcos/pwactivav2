<!--#include virtual="/inc/reg_accesos.asp" -->


<!--#include virtual="/acceso/acceso_foldy.asp" -->
<!-- include virtual="/acceso/acceso_jm.asp" -->
<% 
'navegador = left(lcase(request.ServerVariables("HTTP_USER_AGENT")), 11)
'if navegador="mozilla/4.0" then
	%><!-- include virtual="/acceso/registro.asp" --><%
'end if
%>

<script type="text/javascript">
$(document).ready(function() { 
	
	$('#frm_login').ajaxForm({
		beforeSubmit: mostrarLoader, 
		success: mostrarRespuesta,
	});
	
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
	}
	function mostrarRespuesta (responseText){
		//$("#loader_gif").fadeOut("slow");
		$("#result").html(responseText);
	}
}); 

function informa(texto) {
	$("#div_instrucciones").html(texto);
	//if (texto=="") {$("#div_instrucciones").fadeOut("slow");}
}

<!-- otras funciones -->

function comprobar_licencia() {	
	var variable_post="comprobar licencia";
	$.post("/acceso/informa_licencia.asp", { variable: variable_post }, function(data){
		$("#informa_licencia").html(data);
	});			
}

function comprobar_condiciones() {
	var variable_post="comprobar condiciones";
	$.post("/acceso/informa_condiciones.asp", { variable: variable_post }, function(data){
		$("#informa_condiciones").html(data);
	});
}

</script>

