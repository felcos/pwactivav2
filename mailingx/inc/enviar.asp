<%
'To		
enviar_to = "design@propertyweb.eu"
if request.Cookies("dev")<>"" then enviar_to = "informatica@propertyweb.eu"

'block to
block_to = false
if request.Cookies("dev")<>"" then block_to = false

'Fecha	
mm = month(cFecha)
if mm<10 then
	mm = "0" & cstr(mm)
end if

dd = day(cFecha)
if dd<10 then
	dd = "0" & cstr(dd)
end if

enviar_fecha = year(cFecha) & "-"  & mm & "-" & dd

'From	
enviar_from = "pw"
'if request.Cookies("design")<>"" then enviar_from = "informatica"

%>
<form name="frmEnviarMail" id="frmEnviarMail" method="get" action="/mailing/bin/enviar.asp" target="_blank">

<label for="dest">Para:</label>
<input name="dest" type="text" id="dest" value="<%= enviar_to %>" equired="required" <% if 1=2 then 'block_to then %>readonly="readonly"<% end if %> >

<label for="">fecha:</label>
<input name="fecha" type="text" id="fecha" value="<%= cFecha %>" size="10">

<% 'if request.Cookies("dev")="" then response.Write("style='display:none;'") %>
<label for="from">From:</label>
<select name="from" id="from">
	<option value="pw" <% if enviar_from="pw" then %>selected="selected"<% end if %> >pw</option>
	<option value="comercial" <% if enviar_from="comercial" then %>selected="selected"<% end if %> >comercial</option>
    <% if request.Cookies("dev")<>"" or request.Cookies("design")<>"" then %>
	<option value="informatica" selected="selected">informatica</option>
    <% end if %>
</select>

<label for="pag">P&aacute;g:</label>
<select name="pag" id="pag">
    <option value="disponibilidad2" selected="selected">disponibilidad 2</option>
    <option value="flash">PW Daily Flash</option>
    <option value="design_modelo">mailing test</option>
    <option value="report"> report</option>
    <option value="pda"> PDA</option>
    <option value="operaciones">Operaciones</option>
    
</select>

<input type="button" id="enviar" value="Enviar" class="btn"/><div class="buscando"><div id="buscando"><img src="/img/loading.gif"></div></div></td>
<div id="informaEnviarMail"></div>
</form>

<script type="text/javascript">
$(document).ready(function() { 
	var opciones= {
		beforeSubmit: beforeSend, 
		success: mostrarRespuesta,
	};
	
	$("#enviar").click(function(){ 
		$.ajax({
			url: "/mailing/bin/enviar.asp",
			data: $('#frmEnviarMail').serialize(),
			beforeSend: beforeSend,
			success: mostrarRespuesta
		});
		
		return false;
	});
	
	function beforeSend(){
		$("#enviar").prop("disabled","disabled");
		$("#enviar").val("Enviando...");
		$("#enviar").addClass("disabled");
		
		$("#buscando").show();
		
		
		
		var ErrSubmit = "";
		if ($("#dest").val()=="") {ErrSubmit="Indicar Destinatario"};
		//if (document.frm_actualidad.busq.value=="") {ErrSubmit="<span id='result_noencontrado'>* Debe indicar alg&uacute;n criterio de b&uacute;squeda.</span>"};
		
		if (ErrSubmit=="") {
			
			$("#informaEnviarMail").html("Enviando...");
		} else {
			
			$("#informaEnviarMail").html("Error: " + ErrSubmit);
			
			$("#enviar").removeProp("disabled");
			$("#enviar").val("Enviar");
			$("#enviar").removeClass("disabled");
			$("#buscando").hide();
			
			return false;
		};
		
	};
	
	
	function mostrarRespuesta (responseText){ 
		//console.log(responseText);
		$("#informaEnviarMail").html(responseText);
		
		$("#enviar").removeProp("disabled");
		$("#enviar").val("Enviar");
		$("#enviar").removeClass("disabled");
		$("#buscando").hide();
	};
});


</script>
