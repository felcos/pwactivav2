<%@ LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->

<!DOCTYPE html>
<html>
<head>
    <title>PropertyWeb - DESARROLLO</title>
    <!-- include virtual="/inc/inc_head.asp" -->
    <script src="/js/jquery.js"></script>
    
    <link href="/lib/bootstrap/bootstrap.css" rel="stylesheet" type="text/css">
    <script src="/lib/bootstrap/bootstrap.js"></script>
    
    <script src="/lib/typeahead/dist/typeahead.bundle.min.js"></script>
    
    <link rel="stylesheet" type="text/css" href="/lib/typeahead/examples.css">
    
<script type="text/javascript">
$(document).ready(function(){
	
	var sugerencias = new Bloodhound({
		datumTokenizer: function (d) {
			return Bloodhound.tokenizers.whitespace(d.value);
		},
		queryTokenizer: Bloodhound.tokenizers.whitespace,
		//prefetch: "/lib/typeahead/post_1960.asp",
		remote: {
			url: "/lib/typeahead/post_1960.asp?q=%QUERY",
			wildcard: "%QUERY"
		}
	});
	
	$("#busq__Z").typeahead([
		{
			name: "buscar",
			remote: "/lib/typeahead/post_1960.asp?%QUERY",
			valueKey: "value", //or car_model
			template: "<p><strong>{{value}} {{nombre}}</strong></p>"
			//engine: Hogan
			
		}
	])
	
	$("#busq").typeahead(null, {
		name: "buscar",
		valueKey: "value",
		display: "nombre",
		
		source: sugerencias
	})
	.on("typeahead:selected", function (obj, datum, name) {
		//console.log(obj);
		console.log(datum.value);
	});

});  
</script>
</head>
<body>
<!-- include virtual="/inc/body-header.asp" -->
<div class="container">

<section id="s_1" class="clearfix">
    <h1 class="heading">Twiter Typehead</h1>
    <p><a href="https://mycodde.blogspot.com.es/2014/12/typeaheadjs-autocomplete-suggestion.html">https://mycodde.blogspot.com.es/2014/12/typeaheadjs-autocomplete-suggestion.html</a></p>
    <% if request.QueryString<>"" then 
		for each elto in request.QueryString 
			%><li><%= elto %>: <%= request.QueryString(elto) %></li><%
		next
	end if %>
	<div id="div_formulario" name="div_formulario" class="caja col-md-8"><!---->
      
<p class="frm_informa">Permite interesantes consultas como, por ejemplo, nuevos barrios/&aacute;reas de expansi&oacute;n, proyectos, etc...</p>
<form id="frm_busq" name="frm_busq" class="form-horizontal" action="" method="post" autocomplete="off" target="_blank">
    <div class="form-group clearfix">
        <label for="busq"  class="col-sm-2 control-label">Buscar:</label>
        <div class="col-sm-10">
            <input id="busq" type="text" class="form-control" name="busq" value="" required autofocus maxlength="50" />
        </div>
    </div>
        
    <div class="form-botones clearfix">
        <input name="reset" type="button" value="restablecer"  onClick="location.assign('./.');">
        <input type="submit" value="consultar">
        <div class="buscando">
        	<div id="buscando" style="display:none;"><img src="/img/loading.gif"></div>
        </div>
    </div>
</form>

    </div>
    <div class="col-md-4">xxx</div>

</section>

</div>
<!--include virtual="/inc/body-footer.asp" -->
</body>
</html>

