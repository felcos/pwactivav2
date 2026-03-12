<p style="font-family:'ruda',sans-serif; font-size:15px; font-weight:bold;">Transacciones Registradas en Espa&ntilde;a y Europa</p>
<%
r_year = 2026
r_zona = "eu+"
r_op = "3"
%>
<form id="frm_resumen" name="frm_resumen" action="" method="post" autocomplete="off" target="_blank">
<p style="font-family:'ruda',sans-serif; font-size:13px; font-weight:bold;">
<input type="hidden" name="resumen_zona" value="eu+" />
<select name="resumen_op" id="resumen_op" onChange="$('#frm_resumen').submit();" style="padding-left:5px; border:0px; font-family:'ruda',sans-serif; font-size:13px; font-weight:bold;">
    <option value="venta" <% if r_op="venta" then %>selected<% end if %>>Inversi&oacute;n/Ocupaci&oacute;n Propia</option>	
    <option value="alquiler" <% if r_op="alquiler" then %>selected<% end if %>>Alquiler/Traspaso</option>
</select>
&nbsp; 
<select name="resumen_y" onChange="$('#frm_resumen').submit();" style="padding-left:5px; border:0px; font-family:'ruda',sans-serif; font-size:13px; font-weight:bold;">
  
    <option selected><%= r_year %></option>
    
</select>
</p>
</form>
<div id="tabla_resumen"><img src="/img/camera-loader.gif" style="margin: 24px;"/></div>
<script type="text/javascript">
$("#frm_resumen").submit();
$(document).ready( function() {
	$("#frm_resumen").submit(function(){
		$.ajax({
			type: "POST",
			url: "/flash2/resumen/datospw.asp",
			data: $(this).serialize(),
			beforeSend: function(){
				$("#tabla_resumen").html("<img src='/img/camera-loader.gif' style='margin: 24px;'/>");
			},
			success: function(data, status, xhr){
				$("#tabla_resumen").html(data);
			},
			error: function(xhr, status, err) {
				$("#tabla_resumen").html(status + ": " + err);
				console.log("error...");
			}
		});
		return false;
	});
	
	
});

</script>