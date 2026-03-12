<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<!--#include virtual="/articulos/sin_acceso.asp" -->
<!--#include virtual="/vencimientos/lib_vencimientos.asp" -->
<% 
'swMostrarListado = false

'if session("es_cliente") then
'	if session("pw_ws").accesoVencimientos and session("acceso_activo") then
'		swMostrarListado = true
'	else
'		call SinAcceso("Vencimientos de Contrato")
'	end if
'else
'	call NoCliente
'end if

'if swMostrarListado then
	call vencimientos 
'end if
%>
<script type="text/javascript">
jQuery(function ($) {
	$(".simplemodal").click(function(e) {
		//e.preventDefault();
		var href = $(this).attr("href");
		href = href.substr( href.indexOf("?")+1, href.length);
		
		if ( getCookie("condiciones")=="" ) {
			$("#ModalBox").load(
				"/acceso/password.asp",
				href,
				function(recibe, textStatus, xhr) {}
			);
			
			$("#ModalBox").modal("show");
			
			return false;
			
		} else {}
			
	});
	
	$("#frm_titulos").submit(function() {
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

</script>
