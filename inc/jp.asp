<!DOCTYPE html>
<html lang="es">
<head>

<title>PropertyWeb </title>
<!--#include virtual="/inc/head.asp" -->

<style type="text/css">
.info-buscar span button {              /* cambiar  form_boots.css  */
	color: #fff;
	background: #2B4E61 ;
	width: 40px;
	height: 34px;
}

.info-buscar span button.icon-notification {
	background: #A94442;
}

</style>

<script type="text/javascript">
$(document).ready(function(){     
	 //	Quitar EL MENSAJE QUE SALE y sustituir por: " por favor chequea una opción antes "

	$("#frmInfo_busq").focus(function(){    //añadir condición si ya esta seleccionado on o
		
		 $(this).siblings("span").find("button").removeClass("icon-search").addClass("icon-notification");
		 $(this).parent().addClass("has-error");
		//alert("hola");
	});
	
	$("#frmInfo_busq").blur(function(){   
		
		 $(this).siblings("span").find("button").removeClass("icon-notification").addClass("icon-search");
		 $(this).parent().removeClass("has-error");

	});
	

});	



</script>
</head>

<body>
<!--#include virtual="/inc/body-header.asp" -->
<div class="container">
	<h1>Property</h1>
	<div class="col-sm-12">
    	<div class="inputField">

<div class="input-group info-buscar" id="info-buscar">
	<input type="text" class="form-control" value="" placeholder="" id="frmInfo_busq" name="frmInfo_busq" autocomplete="off">
	<span class="input-group-btn">
		<button class="btn btn-default icon-search" type="submit" id="frmInfo-submit"> </button>
	</span> 
</div>

		</div>    
    </div>
</div>
<!--#include virtual="/inc/body-footer.asp" -->
</body>
</html>
