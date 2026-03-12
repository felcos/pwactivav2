<!--#include virtual="/articulos/titulos/libb1.asp" -->
<% if request.Cookies("dev")("request")<>"" then %>
	<div class="dev peq"> 
		Form: &nbsp; <% 
		for each elto in request.Form 
			if request.Form(elto)<>"" then 
				%>[<b><%= elto %></b> = <%= request.Form(elto) %>]&nbsp;<% 
			end if 
		next %>
	</div>
<% end if %>

<form method="post" action="/articulos/" id="frm_titulos" name="frm_titulos">
<% for each elto in request.Form
	%><input type="hidden" name="<%= elto %>" value="<%= request.Form(elto) %>"/><%
next %>
<!-- Noticias	-->
<% 'Permisos		
'resp = session("pw_ws").IniCliente(request.Cookies("licencia")("n"), request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("user_id"), request.Cookies("licencia")("movil"))


'select case request.Form("secc")
dim que_tipo_articulos
que_tipo_articulos="actualidad"

select case que_tipo_articulos
case "actualidad"	
	
	if session("pw_ws").accesoActivo then
		'noticias
		if session("pw_ws").accesoNoticiasHoy or session("pw_ws").accesoNoticias then
			call TablaTitulos("not")
		else
			call SinAcceso("Noticias")
		end if
		
		'Web ha oído
		if session("pw_ws").accesoRumoresHoy or session("pw_ws").accesoRumores then
			call TablaTitulos("rum")
		else
			call SinAcceso("Web ha o&iacute;do")
		end if
		
	else
		call NoCliente
		'ClienteInactivo(pCliente)
	end if
	
	
case "estudios"		
	swMostrarListado = false
	
	if session("pw_ws").accesoEstudiosHoy or session("pw_ws").accesoEstudios then
		swMostrarListado = true
	else
		if session("pw_ws").accesoActivo then
			call SinAcceso("Estudios")
		else
			call NoCliente
		end if
	end if
	
	if swMostrarListado then
		call TablaTitulos("est")
	end if
	
case "demandas"		
	swMostrarListado = false
	
	if session("pw_ws").accesoDemandas then
		swMostrarListado = true
	else
		if session("pw_ws").accesoActivo then
			call SinAcceso("Demandas")
		else
			call NoCliente
		end if
	end if
	
	if swMostrarListado then
		call TablaTitulos("dem")
	end if
	

case "subastas"
	swMostrarListado = false
	if session("pw_ws").accesoSubastas then
		swMostrarListado = true
	else
		if session("pw_ws").accesoActivo then
			call SinAcceso("Subastas")
		else
			call NoCliente
		end if
	end if
	
	if swMostrarListado then
		call TablaTitulos("sub")
		
	end if

end select %>
</form>

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
	
	$("#frm_titulos").submit(function() {
		
		console.log($("#frm_titulos").serialize());
		
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

