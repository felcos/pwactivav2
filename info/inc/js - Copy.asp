<script type="text/javascript">
function CargarHistorico() {
	$.ajax({
		type: "POST",
		url: "/info/data/historico_edificio.asp",
		data: $("#frm_resumen").serialize(),
		beforeSend: function() {
			//$("#cargar-articulos").hide();
			//$("#ver_articulos").hide();
			//$("#loading").fadeIn("slow");
		},
		success: function(recibe, txtStatus, jqSHR) {
			data = $.parseJSON(recibe);
			
			$.each(data, function(tipo, valor) {
				if (tipo=="not") { 
					$("[data-content='historico_noticias']").html(valor);
					<% if acceso_seccion then %>
					$("#historico_noticias").attr("checked", valor>0);
					$("#historico_noticias").attr("disabled", valor==0);
					<% end if %>
				};
				if (tipo=="rum") {
					$("[data-content='historico_rumores']").html(valor);
					<% if acceso_seccion then %>
					$("#historico_rumores").attr("checked", valor>0);
					$("#historico_rumores").attr("disabled", valor==0);
					<% end if %>
				};
				if (tipo=="est") {
					$("[data-content='historico_estudios']").html(valor);
					<% if acceso_seccion then %>
					$("#historico_estudios").attr("checked", valor>0);
					$("#historico_estudios").attr("disabled", valor==0);
					<% end if %>
				};
				if (tipo=="op_alq") {
					$("[data-content='historico_alquiler']").html(valor);
					<% if acceso_seccion then %>
					$("#historico_alquiler").attr("checked", valor>0);
					$("#historico_alquiler").attr("disabled", valor==0);
					<% end if %>
				};
				if (tipo=="op_inv") {
					$("[data-content='historico_inversion']").html(valor);
					<% if acceso_seccion then %>
					$("#historico_inversion").attr("checked", valor>0);
					$("#historico_inversion").attr("disabled", valor==0);
					<% end if %>
				};
				
				<%' if instr(request.Form , "historico_")>0 then %>
				//	$("#frm_resumen").submit();
				<%' end if %>
				
			})
			
			$("#loading").hide();
			$("#ver_articulos").fadeIn("fast");
			
		}
	})
	
	<% 'if 1=2 then
	if request.Cookies("dev")("sql")<>"" then %>
	$.ajax({
		type: "POST",
		url: "/info/data/historico_edificio.asp",
		data: $("#frm_resumen").serialize() + "&informa=sql",
		dataType: "html",
		success: function(recibe, txtStatus, jqSHR) {
			//console.log(recibe)
			$("#informa_historico").html(recibe)
		}
	});
	<% end if %>
}

$(document).ready(function() { 
	CargarHistorico();
	
	$(".simplemodal").click(function(e) {
		var href = $(this).attr("href");
		$("#ModalBox").load(
			"/acceso/password.asp",
			href,
			function(recibe, textStatus, xhr) { $("#ModalBox").modal("show") }
		);
		return false;
		
	});
	
	$("#frm_resumen").ajaxForm({
		beforeSubmit: comprobarForm, 
		success: mostrarRespuesta,
	}) ; 
	
	function comprobarForm(){
		var ErrSubmit="seleccione los art"+'\u00ed'+"culos que desea consultar";
		
		if (document.frm_resumen.historico_noticias.checked) {ErrSubmit=""};
		if (document.frm_resumen.historico_rumores.checked) {ErrSubmit=""};
		if (document.frm_resumen.historico_estudios.checked) {ErrSubmit=""};
		if (document.frm_resumen.historico_inversion.checked) {ErrSubmit=""};
		if (document.frm_resumen.historico_alquiler.checked) {ErrSubmit=""};
		
		if (ErrSubmit=="") {
			$("#ver_articulos").hide();
			$("#loading").fadeIn("slow");
			//$("#div_result").fadeOut("fast");
		} else {
			$("#avisoForm").modal("show");
			//$("#ModalBox").load(
			//	"/articulos/nada_seleccionado.asp",
			//	function(recibe, textStatus, xhr) { $("#avisoForm").modal("show"); }
			//);
			//alert(ErrSubmit);
			return false;
		}
	};
	function mostrarRespuesta (responseText){
		//console.log("recite: ", responseText);
		
		$("#loading").hide();
		$("#ver_articulos").fadeIn("fast");
		$("#result").html(responseText);
		$("#div_result").fadeIn("slow");
		<% if request.Form("presentacion")="" then %>
			$.scrollTo("#s_titulos", 800);
		<% end if %>
	};
	
	//google.maps.event.addDomListener(window, "load", initialize);
	//initialize();
	
	$("#complejo").click(function(e) {
        $("#frmComplejo").submit();
		return false;
    });
	$(".detalles-complejo").click(function(e) {
		var id = $(this).attr("id");
		$("#frmEdif" + id).submit();
		return false;
    });
	
    
	<% if request.Form("presentacion")="informe" then %>
		$("#frm_resumen").submit()
	<% end if %>
});
</script>