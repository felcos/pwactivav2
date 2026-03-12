<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<!--#include virtual="/inversores/lib_anunciar_inversores.asp" -->
<%
sec_actual = "/inversores/"

r_year=left(request.form("y"),4)
if r_year="" then r_year="2016"
if not isnumeric(r_year) then r_year="2016"
if r_year>2016 then r_year="2016"
if r_year<1996 then r_year="1996"

%>
<!DOCTYPE html>
<html lang="es">
<head>
<title>PropertyWeb - Inversores</title>

<!--#include virtual="/inc/head.asp" -->

<link href="/inversores/inversores_javier.css" rel="stylesheet" type="text/css">

<!--#include virtual="/inversores/inc/inversores.asp" -->
<% sec_actual = "/inversores/" %>
</head>
<body>
<!--#include virtual="/inc/body-header.asp" -->

<div class="container">
  <section id="s_buscador" class="row">
    <div class="col-sm-8 caja">
      <h1 class="heading">Inversores</h1>
    </div>
    
    <div class="col-sm-4 lateral-inversores hidden-xs ">
      <div class="caja">
      <p>Publicidad</p>
      
        <% call publicar_inversores %>
      </div>
    </div>
    
    <div class="col-sm-8 caja">
      <div>
          <div id="div_formulario" name="div_formulario">
            <p>Escriba el nombre de la empresa que busca, o parte de &eacute;l, para localizar las empresas que concuerden:</p>
            <form id="frm_directorio" name="frm_directorio" action="/inversores/qry_inversores.asp" method="post" autocomplete="off" target="_blank">
            
            
            
              <div class="form-group clearfix">
              <input id="busq" class="form-control" type="text" name="busq" value="<%= busqueda %>" placeholder="buscar empresas" autofocus maxlength="50" />
              <% if 1=2 then %>
              </div>
              
              
              <SELECT id="actividad" name="actividad" size="1" onChange="$('#frm_directorio').submit();">
                <%
    Set rsActividades = Server.CreateObject("ADODB.Recordset")
    sql = "SELECT * FROM TIPOS_DE_ACTIVIDADES WHERE (ACTIVO=1 AND ID>0 AND directorio=1) ORDER BY nombre" '  AND directorio=0
    rsActividades.open sql, session("connPW")
    
    r_actividad=request("actividad")
    if not isnumeric(r_actividad) then r_actividad="*" 
    if r_actividad="" then r_actividad="*"
    %>
                <option value="*" <% if r_actividad="*" then %>selected="selected"<% end if %>>INVERSORES</option>
                <% do while not rsActividades.eof 
        actividad = lcase(rsActividades("nombre"))
        if len(actividad)>40 then
            actividad=left(actividad, 38) & "..."
        end if
        if cstr(rsActividades("id"))=cstr(request("actividad")) then
            seleccionado=true
        else
            seleccionado=false
        end if
        %>
                <option value="<%= rsActividades("id") %>" <% if seleccionado then %>selected="selected"<% end if %>><%= actividad %></option>
                <%
        rsActividades.movenext
    loop
    rsActividades.Close
    set rsActividades=nothing
    %>
              </SELECT>
              <% end if %>
              <br style="clear: both;"/>
              <div style="margin-top:20px; display:none;">
                <input id="btn_suscribete_prefooter_seccion" name="reset" type="button" value="Restablecer"  onClick="location.assign('/inversores/');">
                <input id="btn_suscribete_prefooter_seccion" type="submit" value="buscar" class="btn_suscribete_prefooter_seccion">
                <input type="hidden" name="origen" value="directorio">
              </div>
            </form>
          </div>
          <!-- div_formulario : FIN --> 
          
      </div>
      
      <div>
        <div name="div_instrucciones" id="div_instrucciones"></div>
        <div id="result"></div>
      </div>
    </div>
  </section>
  
  <section id="s_inversores_activos" class="row">
      <div class="col-sm-12">
      <div> <span style="float:right;">
        <form action="" method="post" name="frmopts" id="frmopts">
          <select name="y" id="y" onChange="enviar_frmopts()" <% if session("pw_ws").LicenciaId=0 then %>disabled<% end if %>>
        <% for ii=2016 to 1996 step -1 %>
            <option value="<%= ii %>" <% if r_year=cstr(ii) then %>selected<% end if %>><%= ii %></option>
            <% next %>
          </select>
        </form>
        </span>
        <h2 class="sub-heading">Inversores m&aacute;s activos</h2>
        <div>
          <div class="row">
            <div class="col-sm-6">
              <div class="caja sombra">
                <% call TopInversores("c", "e", r_year) %>
              </div>
            </div>
            <div class="col-sm-6">
              <div class="caja sombra">
                <% call TopInversores("v", "e", r_year) %>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-6">
              <div class="caja sombra">
                <% call TopInversores("c", "r", r_year) %>
              </div>
            </div>
            <div class="col-sm-6">
              <div class="caja sombra">
                <% call TopInversores("v", "r", r_year) %>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  
</div>

<!--#include virtual="/inc/body-footer.asp" -->
</body>
</html>

<script type="text/javascript">
$(document).ready(function() { 
	var timerid;

	var opciones= {
		beforeSubmit: mostrarLoader, 
		success: mostrarRespuesta,
	};
	
	$('#frm_directorio').ajaxForm(opciones) ; 
	
	function mostrarLoader(){
		//$("#loader_gif").fadeIn("slow");
		
		$("#div_result").fadeIn("slow");
		
		var ErrSubmit="";
		//if (document.frm_directorio.actividad.value=='*') {
			if (document.frm_directorio.busq.value.length<2) {
				ErrSubmit="<span id='result_noencontrado'>* Debe escribir al menos 2 caracteres para realizarla b&uacute;squeda."
			}
		//} else {}
		
		;
		//document.frm_directorio.actividad
		//alert(document.frm_directorio.actividad.value)
		//alert(ErrSubmit)
		if (ErrSubmit=="") {
			$("#result").html("");
			//$("#div_instrucciones").html("&nbsp;");
			
		} else {
			$("#div_instrucciones").html("&nbsp;");
			$("#result").html(ErrSubmit);
			return false;
		}
	};
	function mostrarRespuesta (responseText){ 
		//$("#div_result").fadeIn("slow");
		//if (responseText=='') {
		//	$("#div_instrucciones").html('<p>Escriba el nombre de la empresa que busca, o parte de &eacute;l, para localizar las empresas que concuerden.</p>');
		//} else {
			$("#result").html(responseText);
		//}
	};
	
	$('#busq').keydown(function() {
		clearTimeout(timerid);
		timerid = setTimeout(function() { $('#frm_directorio').submit(); }, 450);
	});
	
});

function fLeft(str, n) {
	if (n > String(str).length) return str;
	else return String(str).substring(0,n);
}

</script>

<script language="javascript">
function mostrar_formulario() {
	if (document.getElementById('result').innerHTML!='') {
		$("#div_formulario").slideToggle("slow");
	}
}
</script>

<script language="javascript">
	function enviar_frmopts() {frmopts.submit()}
</script>
