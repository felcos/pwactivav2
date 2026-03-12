<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%><% 
if request.form("id")="" then response.Redirect("/info/") %>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<!-- include virtual="/info/lib_tablatitulos.asp" -->
<!-- include virtual="/info/empresa/articulos_resumen.asp" -->
<!-- include virtual="/info/empresa/calcular_sql.asp" -->
<%
sec_actual = "/info/empresas/"

public limitenoticias
public limiteestudios
public limiterumores
public limiteoperaciones
public limiteofertas

public acceso_cliente
public acceso_seccion

DIM N 
DIM E 
DIM R
DIM OP
DIM TOT

'dim empres(20)
'dim minisql

Public strin
public bloque

'resp = session("pw_ws").IniCliente(request.Cookies("licencia")("n"), request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("user_id"), request.Cookies("licencia")("movil"))
'resp = session("pw_ws").Comprobar_Licencia(request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("n"), request.Cookies("licencia")("movil"), request.Cookies("licencia")("user_id"))
'select case resp
'case 0		'cliente activo, licencia válida
'	acceso_cliente = true
'	if session("pw_ws").accesoInfoEmpresa then
'		acceso_seccion = true
'	else
'		acceso_seccion = false
'	end if
'case 1		'no es cliente
'	acceso_cliente = false
'	acceso_seccion = false
'case 2		'cliente no activo
'	acceso_cliente = false
'	acceso_seccion = false
'end select


'annoi = request.form("vMin")
'annof = request.form("vMax")
'
'empresa=request.form("nombreempresa")
'empresa_id=request.form("empresa")
'periodo = request.form("periodo")
'if empresa="" then empresa=request.form("buscarempresa")

Set rsEmpresa = Server.CreateObject("ADODB.Recordset")
rsEmpresa.Open "SELECT * FROM c_empresas WHERE id=" & request.form("id"), session("connPW")

empresa=rsEmpresa("nombre")

%>
<!DOCTYPE html>
<%' if request.form("id_edificio")="" then response.Redirect("/") %>
<html lang="es">
<head>
	<title>PropertyWeb - Info-Inmuebles</title>
    <!--#include virtual="/inc/head.asp" -->
    
    <link href="/info/inmueble.css" rel="stylesheet" type="text/css">
    <link href="/css/css-pags/tabs02.css" rel="stylesheet" type="text/css">
    
    <!-- link href="/lib/ion-rangeSlider/normalize.min.css" rel="stylesheet" / -->
    <link href="/lib/ion-rangeSlider/ion.rangeSlider.css" rel="stylesheet" />
    <link href="/lib/ion-rangeSlider/ion.rangeSlider.skinNice.css" rel="stylesheet" />
    <script src="/lib/ion-rangeSlider/ion.rangeSlider.min.js"></script>

</head>
<body>
<!--#include virtual="/inc/body-header.asp" -->
<div class="container">
    <% if request.Form("presentacion")="" then %><!--#include virtual="/info/inc/nav.asp" --><% end if %>
    
    <section id="empresa" class="row">

<div class="col-md-8 caja">
    <% if 1=1 then %><div class="dev"><%
        for each elto in request.Form
            %>[<strong><%= elto %></strong>: <%= request.Form(elto) %>] <%
        next %>
    </div><% end if %>
    
    <div class="miga">
         <h2 class="tit_miga02"><!--<span class="icon icon-arrow-down-right2">-->Info / Empresa</h2>
    </div>
    <h1 class="heading"><span class="nombreH"><%= rsEmpresa("nombre") %></span></h1>
    <br>
    <p class="direInfo"><%= rsEmpresa("TIPOACTIVIDAD") %></p>
    <br>
    <div>
    
<!--  -->	
<%
'otros nombres	
otros_nombres2 = rsEmpresa("OTROS_NOMBRES")
if otros_nombres2<>"" then 
	otros_nombres2 = replace(otros_nombres2, vbcrlf, "#")
	otros_nombres2 = "#" & otros_nombres2 & "#"
end if

otros_nombres3 = otros_nombres2
if otros_nombres3<>"" then 
	otros_nombres3 = replace(otros_nombres3, "#" & rsEmpresa("NOMBRE") & "#", "")
end if

otros_nombres = rsEmpresa("OTROS_NOMBRES")
if otros_nombres<>"" then 
	otros_nombres = replace(otros_nombres, rsEmpresa("NOMBRE"), "")
	otros_nombres = replace(otros_nombres, vbcrlf, "<br>")
end if
%>
<%' otros_nombres %>

<%'= rsEmpresa("visible_en_web") %>
<!--#include virtual="/info/empresa/inc_tabs.asp" -->


    </div>
</div>

<div class="col-md-4">
    <div id="archivo_historico" class="caja sombra">
<form action="/info/empresa/articulos_resumen.asp" id="frm_carga_resumen" method="POST">
<% for each elto in request.Form %>
	<input type="hidden" name="<%= elto %>" value="<%= request.Form(elto) %>">
<% next %>
<% if request.Form("intervalo")="" then %><input type="hidden" name="intervalo" value="2012;2016"><% end if %>
</form>
    </div>
    
    <% if 1=2 then
	'if session("pw_ws").cliente="PW" or session("pw_ws").cliente="JP" then %>
	<figure style="margin-top:10px;" class="mini">
        <li>acceso_cliente: <%= request.Cookies("licencia")<>"" %></li>
        <li>acceso_seccion: <%= session("pw_ws").accesoInfoEmpresa %></li>
    </figure>
    
    <figure style="margin-top:10px;" class="mini">
<% for each elto in request.Form %>
	<li><%= elto %>: <%= request.Form(elto) %></li>
<% next %>
    </figure>
    <% end if %>
</div>

<div class="col-md-8">
	<% if request.Cookies("dev")("request")<>"" then %>
    <div style="background:#FFFFCC; font-size:11px; margin:2px;border:#000000 1px solid;">
    form: &nbsp; <% for each elto in request.Form
        if request.Form(elto)<>"" then
            %><%= elto %>:[<%= request.Form(elto) %>]&nbsp;<%
        end if
    next %>
    </div>
    <% end if %>
    
    <a name="resumen"></a>

    
</div>

	</section>

	<!-- articulos -->
    <section id="s_titulos" class="row clearfix">
        <div id="div_result" class="caja" style="display:none;">
            <div id="result"></div>
        </div>
    </section>
	<!-- / articulos -->

</div>

<!--#include virtual="/inc/body-footer.asp" -->
</body>
</html>

<%
'registro
insert_reg_articulo "empr", "empr", rsEmpresa("id")

rsEmpresa.close
set rsEmpresa=nothing
%>
<script type="text/javascript">
$(document).ready(function() { 
	
	
	function onDataReceived_jp(recibe, textStatus, jqXHR) {
		$("#archivo_historico").html(recibe);
		//$("#loader").fadeOut("slow");
		// intervalo
	}
	
	function onError_jp() {
		alert('err');
	}
		
	function carga_resumen () {
		
		$.ajax({
			url: "/info/empresa/articulos_resumen.asp",
			data: $("#frm_carga_resumen").serialize(),
			type: "POST",
			//dataType: "html",
			success: onDataReceived_jp,
			error: onError_jp
		});
	};
	 
	carga_resumen();
	
	<% if request.Cookies("dev")<>"" then %>
    $.get("/articulos/contador.asp?t=empr", function(recibe){
		console.log("empr")
        $("*[data-toggle='contador_leidos'][data-content='empr']").text(recibe)
    });
    <% end if %>
	
}); 
</script>


