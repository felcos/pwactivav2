<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<% 

'Recordsets		
set rsTmp = Server.CreateObject("ADODB.Recordset")
%>
<!DOCTYPE html>
<html lang="es">
<head>
<title>PropertyWeb - TEST</title>
<!--#include virtual="/inc/head.asp" -->

<link href="/lib/autocomplete/autocomplete.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/lib/autocomplete/jquery.autocomplete.js"></script>

<script>

function cambiopais() {
	$("#busqlocalidad").unautocomplete();
	
	var frm_destino = "/dealanalysis/q/localidades_buscar_con_id.asp"
	if ($("#pais").val!=1) {
		frm_destino = frm_destino + "?p=" + $("#pais").val()
	};
	
	$("#busqlocalidad").autocomplete(
		frm_destino, 
		{
			width: 260,
			selectFirst: true,
			matchContains: true,
			minChars: 1
		}
	);
	
	$("#busqlocalidad").result(function(event, data, formatted) {
		if (data) {
			$("#id_localidad").value=data[1];
		}
	});
	
}

$(document).ready(function(){
	
	function log(event, data, formatted) {$("<li>").html( !data ? "No match!" : "Selected: " + formatted).appendTo("#result");}
	
	function formatItem(row) {return row[0] + " (<strong>id: " + row[1] + "</strong>)";}
	function formatResult(row) {return row[0].replace(/(<.+?>)/gi, '');}
	
	$("#busqlocalidad").autocomplete("/dealanalysis/q/localidades_buscar_con_id.asp", {
		width: 260,
		selectFirst: true,
		matchContains: true,
		minChars: 1
	});
	
	$("#busqlocalidad").result(function(event, data, formatted) {
		if (data) {
			console.log(data);
			$("#id_localidad").val(data[1]);
		}
	});

});

</script>
</head>
<body>
<!--#include virtual="/inc/body-header.asp" -->

<div class="container">
  <section id="s_buscador" class="row">
    <div class="">
      <h1 class="heading caja">Test autocomplete</h1>
    </div>
    <div id="div_formulario" name="div_formulario" class="caja col-md-8">
      <form id="frm" name="frm" class="form-horizontal" action="" method="post" autocomplete="off" target="_blank">        
        
        <div class="form-group">
            <div id="div_localidad">
            	<label for="busqlocalidad" class="control-label col-sm-2">Localidad:</label>
                <div class="col-sm-4">
                  <input type="textfield" name="busqlocalidad" id="busqlocalidad" value="<%= r_busqlocalidad %>" placeholder="e.g. madrid barcelona" class="form-control" autocomplete="off">
                </div>
            </div>
            
            <div id="div_pais" >
				<% 'País		
                        rsTmp.open "SELECT * FROM PAISES WHERE ID>1 ORDER BY NOMBRE", session("connPW")
                        ' onChange="document.forms['busfrm'].submit();"
                        %>
                <label for="pais" class="control-label col-sm-2">Pa&iacute;s:</label>
                <div class="col-sm-4">
                  <select name="pais" id="pais" onChange="cambiopais();" class="form-control">
                    <option value="1" <% if r_pais="1" then %>selected<% end if %>>espa&ntilde;a</option>
                    <% do while not rsTmp.eof %>
                    <option value="<%= rsTmp("ID") %>" <% if r_pais=cstr(rsTmp("ID")) then %>selected<% end if %>><%= lcase(rsTmp("NOMBRE")) %></option>
                    <% rsTmp.movenext()
                        loop %>
                  </select>
                  <%
                        rsTmp.close
                        %>
                </div>
             </div>
            
        </div>
        
        
        <div class="form-botones clearfix">
          <div class="buscando" style="display:inline-block;"><div id="buscando" style="display:none;"><img src="/img/loading.gif"></div></div>
          <!-- input name="reset" type="button" value="restablecer" onClick="" --> 
          <input type="submit" value="consultar" id="buscar">
        </div>
      </form>
    </div>
    <div class="col-md-4 caja">
    	<div>id_localidad: <input type="text" name="id_localidad" id="id_localidad" value="" ></div>
    </div>
  </section>
  
  <section id="s_resumen" class="row" >
    <div name="div_instrucciones" id="div_instrucciones" class="caja">
          <p><strong>NOTA</strong>:</p>
          <p>Para efectuar una b&uacute;squeda en esta seccion de <strong>Noticias</strong>:</p>
          <p> &nbsp; 1. En primer lugar, utilizar palabras en singular, como CENTRO COMERCIAL, PROYECTO, etc... en vez de CENTROS COMERCIALES, PROYECTOS, etc...</p>
          <p> &nbsp; 2. Nombres de empresa simples; por ejemplo AUTONOMY, no AUTONOMY CAPITAL, o BLACKSTONE en vez del nombre completo BLACKSTONE INVESTMENT PARTNERS.</p>
    </div>    
  </section>
 
  
  <section id="s_titulos" class="row">
    <div id="div_result" class="caja" style="display:none;"><div id="result"></div></div>
  </section>
  
</div>

<!--#include virtual="/inc/body-footer.asp" -->
</body>
</html>
