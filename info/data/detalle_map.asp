<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<%
if not session("pw_ws").accesoDisponibilidad then %>
<button type="button" class="close" id="closeDisponMapa"><span aria-hidden="true">×</span></button>
<p><img src="/img/lock.svg" width="14" height="14"/> Lo sentimos, pero esta informaci&oacute;n s&oacute;lo est&aacute; disponible para <a href="#" onclick="registro();">clientes</a>.</p>
<script>
function registro() {
	$("#ModalBox").load(
		"/acceso/password.asp",
		"#",
		function(recibe, textStatus, xhr) { $("#ModalBox").modal("show") }
	);
	return false;
}
$("#closeDisponMapa").on('click',function(){
	$(this).parent().hide("slow", "", function() {$("#myMapDisp").html("")});
});
</script><%
	response.End()
end if

rId=request.form("id")
if not(isnumeric(rId)) then response.End()

set rsInm = Server.CreateObject("ADODB.Recordset")

rsInm.Open "SELECT * FROM c_inmuebles WHERE id=" & rId, session("connPW")


set rsDetalle = Server.CreateObject("ADODB.Recordset")
sql = "SELECT * FROM c_inmuebles_plantas WHERE id_inmueble=" & rId
'sql = sql & " AND disponible_superficie IS NOT NULL AND disponible_superficie>0"
sql = sql & " ORDER BY orden DESC"
rsDetalle.Open sql, session("connPW")

c_fecha = rsInm("disponible_fecha")
if isdate(c_fecha) then
	mm = month(c_fecha)
	if len(cstr(mm))<2 then mm = "0" & mm
	
	yy = mid(year(c_fecha), 3, 2)
	
	c_fecha = mm & "/" & yy
else
	c_fecha = ""
end if
%>
<button type="button" class="close" id="closeDisponMapa"><span aria-hidden="true">×</span></button>

<div class="dispA">
	<div class="dispA-img mapa" data-content="<%= rsInm("fotos") %>">
		<%
		img = "" & rsInm("fotos")
		
		if img<>"" then
			if instr(img, "&") then img = left(img, instr(img, "&")-1)
			
			img = "/lib/showThumb.aspx?ImgWd=45&img=/fotos/inmuebles/" & img
			'img = "/fotos/inmuebles/" & img
			%><img src="<%= img %>" class="img-responsive"><%
		end if %>
	</div>  
	<div class="dispA-intermediario">
		<table><tr>
		<%	
		set rsAg = Server.CreateObject("ADODB.Recordset")
		sql = "SELECT id_inmueble, id_empresa, empresa, tipo, logotipo FROM c_inmuebles_agentes WHERE id_inmueble=" & rId
		sql = sql & " AND TIPO='comerc' "
		sql = sql & " AND fecha_hasta IS NULL "
		rsAg.Open sql, session("connPW")
		
		do while not rsAg.eof
			if rsAg("logotipo")<>"" then
				%><td><img  class="img-responsive" style="max-height: 23px;" src="/_inc/javier/img/empresas/<%= rsAg("logotipo") %>"></td><% 
			end if
			rsAg.movenext
		loop
		
		rsAg.close
		set rsAg=nothing
		%></tr></table>
		<span class="icon-circle-down"></span>
	</div>
    <%
	dir = rsInm("nombre_calle") & " " & rsInm("numero_calle")
	'dir = rsInm("nombre")


'planta_lng,logo,planta_disp_sup,planta_disp_fecha,planta_disp_renta,orden,planta_sup,planta,planta_id_Secc,planta_secc 

	%>
    <div class="dispA-direccion"><%= dir %></div> 
    <div class="dispA-localidad"><%= lcase(rsInm("localidad")) %></div> 
    <div class="dispTitu" style="width: 100%;">
		

	</div>
    <div class="dispB" onclick="AbrirEdificio(<%=rsInm("id") %> );" >

        <div class="tb-despliega">
            <table class="tbDispon">
				<thead>
					<tr class="cabeza" style="text-align: center;border-bottom:lightskyblue 1px dashed;" >
						<th class="tbDisp-Tipo"  style="text-align: center;border-bottom:lightskyblue 1px dashed;" colspan="4"><%=rsInm("nombre_calc") %></th>
					</tr>
					<tr class="cabeza">
						<th class="tbDisp-Plta"  style="text-align: center;"></th>
						<th class="tbDisp-Tipo" style="text-align: center;">Tipo</th>
						<th class="tbDisp-Tipo" style="text-align: center;">Ocupante</th>
						<th class="tbDisp-Tipo" style="text-align: center;">Superficie</th>
					</tr>
					</thead>
				<% 
				renta_min = 0
				renta_max = 0
				xx=""
				do while not rsDetalle.eof
					c_planta = rsDetalle("planta")
					c_sup = rsDetalle("disponible_superficie")
					c_renta = rsDetalle("disponible_renta")
					%>
	                <tr>
	   	              <td class="tbDisp-Plta" style="text-align: center;">PT <%= c_planta %></th>
	   	              <td class="tbDisp-Tipo" style="text-align: center;"><%= lcase(rsDetalle("seccion")) %></td>
					  <td class="tbDisp-Tipo" style="text-align: center;"><%= lcase(rsDetalle("logo")) %></td>
					  <td class="tbDisp-Tipo" style="text-align: center;"><%= lcase(rsDetalle("superficie")) %> m&sup2;</td>
	                </tr>
				<% rsDetalle.movenext
				loop %>
				<% 
				set rsInmP = Server.CreateObject("ADODB.Recordset")
				rsInmP.Open "SELECT * FROM View_Inmuebles_Prop WHERE id_edificio=" & rId & " AND agencia_fecha_hasta IS NULL ", session("connPW")
	'response.write("SELECT * FROM View_Inmuebles_Prop WHERE id_edificio=" & rId & " AND (agencia_fecha_hasta IS NULL)")
				do while not rsInmP.eof
					c_prop_tipo=rsInmP("agencia_tipo")

					if rsInmP("agencia_tipo")="prop" then
						'c_prop_tipo="Propietario:"
						c_prop=""
					else
						if rsInmP("agencia_tipo")="comerc" then
							c_prop_tipo="Comercialización:"
						end if
						if rsInmP("agencia_tipo")="gest" then
							c_prop_tipo="Gestión:"
						end if	
						c_prop = c_prop_tipo & " " & rsInmP("agencia_nombre")
						if len(rsInmP("TLF1"))>0 then
							c_prop = c_prop & " Telf:" & rsInmP("TLF1") 
						end if	
						if len(rsInmP("TLF2"))>0 then
							c_prop = c_prop & " Telf:" & rsInmP("TLF2") 
						end if	
						if len(rsInmP("FAX"))>0 then
							c_prop = c_prop & " FAX:" & rsInmP("FAX") 
						end if	
					end if		
												


					%>
	                <tr>
	   	              <td colspan="8" style="text-align: left;"><%= c_prop %></td>

	                </tr>
				<% rsInmP.movenext
				loop %>				
            </table>
			

        </div>
   </div>
</div><!-- :: disA/ --> 
<% 
rsDetalle.close
set rsDetalle=nothing

'resp_regArticulo = session("pw_ws").RegArticulo("dis", "dis", cdbl(rsInm("id")))
rsInmP.close
set rsInmP=nothing

rsInm.close
set rsInm=nothing


%>
<script>
$(document).ready(function(){
	
	$("#closeDisponMapa").on('click',function(){
		//divDisponMapa
		//console.log($(this).parent(), "> hide");
		$(this).parent().hide("slow", "", function() {$("#myMapDisp").html("")});
		
	});
	


	$(".dispA-img.mapa").click(function(e) {
		e.stopPropagation();
		var fotos = [];
		var ff = $(this).attr("data-content").split("&").filter(function(n){return n;});
		
		$.each(ff, function(ii, val) { 
			var foto = {href : "/fotos/inmuebles/" + val} 
			fotos.push(foto);
		});
		
		$.fancybox.open(fotos,
			{
				padding: 0,

				openEffect : 'elastic',
				openSpeed  : 150,

				closeEffect : 'elastic',
				closeSpeed  : 150,

				closeClick : true,

				helpers : {
					overlay : null
				}
			}
		);
	
	});


				
	<% if 1=2 then
	'if request.Cookies("dev")<>"" then %>
    $.get("/articulos/contador.asp?t=dis", function(recibe){
        $("*[data-toggle='contador_leidos'][data-content='dis']").text(recibe)
    });
    <% end if %>
});
</script>