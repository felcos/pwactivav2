<!DOCTYPE html>
<html lang="es">
<head>
<link href="/favicon.ico" rel="shortcut icon" type="image/x-icon"/>

<title>PropertyWeb</title>
<!--#include virtual="/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="../../../css/css-pags/tabs02.css">



<script>
$(document).ready(function() {



$(".clickNavegadores").click(function(){
	
	$(".sinMargen ").slideToggle();
/*	 alert("hola");*/
	});

});	

</script>



</head><body>
<!--#include virtual="/inc/body-header.asp" --> 



<div class="container">
	    

          <div class="alert alert-warning alert-dismissible rojo" >
              <div>
          <button type="button" class="close btn rojo" data-dismiss="alert" aria-label="Close">
          <span aria-hidden="true">&times;</span></button>
            <span class="icon-warning"></span>
          <h4>La versión que esta utilizado de su navegador esta obsoleta</h4>
          <p>Esto puede provocar que algunos elementos de la página se carguen se manera incorrecta o no se carguen. Puede actualizar o descargarse cualquiera <a href="#" class="clickNavegadores">de estos navegadores:</a></p>
          
           </div>
          <div class="sinMargen ">
            <ul class="clearfix">

            <li><a href="https://windows.microsoft.com/es-es/internet-explorer/download-ie" target="_blank"><img src="../img/gnral/nav-exp.jpg"></a></li>
            <li><a href="https://www.google.com/chrome/browser/desktop/index.html" target="_blank"><img src="../img/gnral/nav-chr.jpg"></a></li>
            <li><a href="https://www.mozilla.org/es-ES/firefox/new/?utm_source=firefox-com&utm_medium=referral" target="_blank"><img src="../img/gnral/nav-fx.jpg"></a></li>
            <li><a href="https://www.apple.com/safari/"><img src="../img/gnral/nav-saf.jpg" target="_blank"></a></li>
            <li><a href="https://www.opera.com/es"><img src="../img/gnral/nav-ope.jpg" target="_blank"></a></li>

            </ul>
          </div>
       
             <!--<div class="alert alert-success" role="alert">
                    <p>Puede provocar que algunos elementos de la página se carguen se manera incorrecta o no se carguen. Le recomendamos descargar una de estas opciones:</p>
                    </div>-->
      </div>
</div>

<!--  : fin alert-->


<!-- :: container  --> 

<!--#include virtual="/inc/body-footer.asp" -->
</body>
</html>
