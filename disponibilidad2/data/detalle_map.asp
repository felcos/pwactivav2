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

sql = "SELECT MIN(disponible_renta) AS [min], MAX(disponible_renta) AS [max] FROM inmuebles_plantas WHERE (id_inmueble=" & rId
sql = sql & ") AND (NOT (disponible_superficie IS NULL))"
rsDetalle.Open sql, session("connPW")
	if isnull(rsDetalle("max")) then
		c_renta = ""
	else
		c_renta_max = rsDetalle("max")
		c_renta_min = rsDetalle("min")
		
		c_renta=c_renta_min
		if cdbl(c_renta_min)<cdbl(c_renta_max) then
			c_renta = c_renta & "/" & c_renta_max
		end if

	end if
	
rsDetalle.close

sql = "SELECT * FROM c_inmuebles_plantas WHERE id_inmueble=" & rId
sql = sql & " AND disponible_superficie IS NOT NULL AND disponible_superficie>0"
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
<div class="dispTitu">
	<table class="tbDispon">
		<thead>
		<tr class="cabeza">
			<th class="tbDisp-Plta">Planta</th>
			<th class="tbDisp-Tipo">Tipo</th>
			<th class="tbDisp-Min">M&iacute;n</th>
			<th class="tbDisp-Max">M&aacute;x</th>
			<th class="tbDisp-Renta">Renta<br>Salida</th>
			<th class="tbDisp-Fecha">@Fecha</th>
		</tr>
		</thead>
	</table>
</div>
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
		<%	
		set rsAg = Server.CreateObject("ADODB.Recordset")
		sql = "SELECT id_inmueble, id_empresa, empresa, tipo, logotipo FROM c_inmuebles_agentes WHERE id_inmueble=" & rId
		sql = sql & " AND TIPO='comerc'"
		sql = sql & " AND fecha_hasta IS NULL"
		rsAg.Open sql, session("connPW")
		
		do while not rsAg.eof
			if rsAg("logotipo")<>"" then
				%><img src="/_inc/javier/img/empresas/<%= rsAg("logotipo") %>"><% 
			end if
			rsAg.movenext
		loop
		
		rsAg.close
		set rsAg=nothing
		%>
		<span class="icon-circle-down"></span>
	</div>
    <%
	dir = rsInm("nombre_calle") & " " & rsInm("numero_calle")
	%>
    <div class="dispA-direccion"><%= dir %></div> 
    <div class="dispA-localidad"><%= lcase(rsInm("localidad")) %></div> 
    
    <div class="dispB">
    	<table class="tbDispon">
            <tr>
              <td class="tbDisp-Plta"></th>
              <td class="tbDisp-Tipo">TOTAL:</td>
              <td class="tbDisp-Min"><%= FormatNumber(rsInm("disponible_min"), 0) %></td>
              <td class="tbDisp-Max"><%= FormatNumber(rsInm("disponible_max"), 0) %></td>
              <td class="tbDisp-Renta"><%= c_renta %></td>
              <td class="tbDisp-Fecha"><%= c_fecha %></td>
            </tr>
         </table>
        <div class="tb-despliega">
            <table class="tbDispon">
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
	   	              <td class="tbDisp-Plta">PT <%= c_planta %></th>
	   	              <td class="tbDisp-Tipo"><%= lcase(rsDetalle("seccion")) %></td>
            	      <td class="tbDisp-Min"></td>
    	              <td class="tbDisp-Max"><%= FormatNumber(c_sup, 0) %></td>
        	          <td class="tbDisp-Renta"><%= c_renta %></td>
                	  <td class="tbDisp-Fecha"></td>
	                </tr>
				<% rsDetalle.movenext
				loop %>
            </table>
        </div>
   </div>
</div><!-- :: disA/ --> 
<% 
rsDetalle.close
set rsDetalle=nothing

'resp_regArticulo = session("pw_ws").RegArticulo("dis", "dis", cdbl(rsInm("id")))

rsInm.close
set rsInm=nothing

secc = request.form("secc")
if secc = "disponibilidad" then secc = "dis"

insert_reg_articulo secc, "edif", request.form("id")
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