<h1 class="heading">Transacciones Registradas en Espa&ntilde;a y Europa </h1>
<%
r_year = request.Form("resumen_y")
'if r_year = "" then r_year = year(date)
if r_year = "" then r_year = 2022
if request.Cookies("dev")<>"" then r_year = 2022

r_zona = request.Form("resumen_zona")
if r_zona = "" then r_zona = "eu+"
r_op = request.Form("resumen_op")
if r_op = "" then r_op = "3"	'inversion
%>
<form   style="background-color:#ecf3f7;" id="frm_resumen" name="frm_resumen" action="" method="post" autocomplete="off" target="_blank">
<p style="font-family:'ruda',sans-serif; font-size:13px; font-weight:bold;">
<input type="hidden" name="resumen_zona" value="eu+" />
<select name="resumen_op" id="resumen_op" onChange="$('#frm_resumen').submit();" style="padding-left:8px; border:0px; font-family:'ruda',sans-serif; font-size:14px; font-weight:bold;background-color: transparent;">
    <option value="venta" <% if r_op="venta" then %>selected<% end if %>>Inversi&oacute;n/Ocupaci&oacute;n Propia</option>	
    <option value="alquiler" <% if r_op="alquiler" then %>selected<% end if %>>Alquiler/Traspaso</option>
</select>
&nbsp; 
	
	<select name="resumen_y" onChange="$('#frm_resumen').submit();" style="padding-left:5px; border:0px; font-family:'ruda',sans-serif; font-size:13px; font-weight:bold;background-color: transparent;"">
		<% for yy=2022 to 1996 step -1 %>
		<option <% if yy=r_year then %>selected<% end if %>><%= yy %></option>
		<% next %>
	</select>


</p>
</form>
<div id="tabla_resumen" style="border: lightsteelblue;border-style:outset;border-spacing: 0px;"><img src="/img/camera-loader.gif" style="margin: 24px;"/></div>
<script type="text/javascript">
$(document).ready( function() {
	$("#frm_resumen").submit(function(){
		$.ajax({
			type: "POST",
			url: "/dealanalysis/resumen/datos.asp",
			data: $(this).serialize(),
			beforeSend: function(){
				$("#tabla_resumen").html("<img src='/img/camera-loader.gif' style='margin: 24px;'/>");
			},
			success: function(data, status, xhr){
				$("#tabla_resumen").html(data);
			},
			error: function(xhr, status, err) {
				$("#tabla_resumen").html(status + ": " + err);
			}
		});
		return false;
	});
});
</script>