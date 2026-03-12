

<!DOCTYPE html>
<html lang="es">
<head>
	<title>PropertyWeb - Disponibilidad</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=2">

<link href="/css/base.css" rel="stylesheet" type="text/css">
<link href="/css/estilos.css" rel="stylesheet" type="text/css">
<link href="/css/fuentes.css" rel="stylesheet" type="text/css">

<link href="/css/form_boots.css" rel="stylesheet" type="text/css">
<link href="/css/titulos.css" rel="stylesheet" type="text/css"/> <!--  comenta -->
<link href="/css/titulos_info.css" rel="stylesheet" type="text/css"/><!--  info/info_javier.asp -->
<link href="/css/titulos_operaciones.css" rel="stylesheet" type="text/css"/><!--  info/info_javier.asp -->
<link href="/css/leer_javier.css" rel="stylesheet" type="text/css"/><!-- css en articulos pasado a mi carpeta -->
<link href="/css/js-components.css" rel="stylesheet" type="text/css"><!-- css temporal, estilos por defecto bt-->

<link href="/css/header.css" rel="stylesheet" type="text/css"/>
<link href="/css/footer.css" rel="stylesheet" type="text/css">
<link href="/css/estilo_imprimir.css" rel="stylesheet" type="text/css" media="print">


<script src="/lib/jquery/jquery-1.11.3.min.js" type="text/javascript"></script>
<script src="/lib/bootstrap/bootstrap.min.js" type="text/javascript"></script>

<script src="/lib/scrollTo/jquery.scrollTo.js" type="text/javascript"></script>

<script src="/js/jquery.form.js" type="text/javascript"></script>
<script src="/js/modernizr.js" type="text/javascript"></script>



<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
<script src="/js/support/html5shiv.min.js"></script>
<script src="/js/support/respond.min.js"></script>
<![endif]-->
<script type="text/javascript">
var winW;
var winH;

function dimensionesPantalla() {
	if (document.body && document.body.offsetWidth) {
		winW = document.body.offsetWidth;
		winH = document.body.offsetHeight;
	}
	if (document.compatMode=='CSS1Compat' && document.documentElement && document.documentElement.offsetWidth ) {
		winW = document.documentElement.offsetWidth;
		winH = document.documentElement.offsetHeight;
	}
	if (window.innerWidth && window.innerHeight) {
		winW = window.innerWidth;
		winH = window.innerHeight;
	}
	
	informaPantalla()
}

function informaPantalla() {
	//dimensionesPantalla();
	$(".informa_width").html(winW);
	$(".informa_height").html(winH);
}

dimensionesPantalla();
if (winW<=768) {
	$("#frmInfo-tip").removeClass("right");
	$("#frmInfo-tip").addClass("bottom");
} else {
	$("#frmInfo-tip").addClass("right");
	$("#frmInfo-tip").removeClass("bottom");
}
window.onresize=function() {
	//$("#head_div_busq").removeClass("despliegaDiv");
	//$("#head_div_info").removeClass("despliegaDiv");
	
	
	if (winW<=768) {
		$("#frmInfo-tip").removeClass("right");
		$("#frmInfo-tip").addClass("bottom");
	} else {
		$("#frmInfo-tip").addClass("right");
		$("#frmInfo-tip").removeClass("bottom");
	}
};


function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i=0; i<ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1);
        if (c.indexOf(name) == 0) return c.substring(name.length,c.length);
    }
    return "";
}



$(document).ready(function() {
	
	
	if (Modernizr.touchevents) {
		$(".informa_touch").html("touch&nbsp;-&nbsp;");
	} else {
		$(".informa_touch").html("");
	}
	
	$("#frmInfo_busq").focus(function(e) {
		var rtipo = $("input:radio[name=frmInfo_tipo]:checked").val();
		if (rtipo!="disp" && rtipo!="nidisp") {
			$("#frmInfo-tip").show();
	    }
    });
	$("#frmInfo_propietario").focus(function(e) {
		$("#frmInfo-tip").show();
    });
	
	//.focusout(function(e) {
	$("#frmInfo_busq").blur(function() {
		$("#frmInfo-tip").hide();
    });
	
	$("#frmInfo_propietario").blur(function() {
        $("#frmInfo-tip").hide();
    });
	
	$("#frmInfo_busq").change(function() {
		$("#frmInfo-tip").hide();
    });
	
	$(".frmInfo_tipo").click(function () {
		var rtipo = $("input:radio[name=frmInfo_tipo]:checked").val();
		
		$(".lblInfo").removeClass("activo");
		
		if (rtipo=="disp") {
			window.location.href = "/disponibilidad/";
		} 
		if (rtipo=="nidisp") {
			window.location.href = "/nidisp/";
		} 
		if (rtipo=="takeup") {
			window.location.href = "/takeup/";
		} 
		/*if (rtipo=="edif") {
			window.location.href = "/info/";
		} 
			if (rtipo=="cc" || rtipo=="hot"  || rtipo=="ni") {
			$("#frmInfo_busq").val("");
			$("#frmInfo").submit();
		} */

		if (rtipo=="cc" || rtipo=="hot" || rtipo=="edif" || rtipo=="ni") {
			$("#frmInfo_busq").val("");
			$("#frmInfo").submit();
		}	
		
		
		$("#frmInfo").attr("action", "/info/");
		
		if (rtipo=="prop") {
			$("#info-buscar").hide();
			$("#info-propietarios").show();
			
			$("#frmInfo_propietario").removeAttr("disabled");
			$("#frmInfo_busq").attr("disabled", true);
			
			$("#frmInfo_propietario").focus();
			//$("#frmInfo_propietario").select();
			
		} else {
			$("#info-propietarios").hide();
			$("#info-buscar").show();
			
			$("#frmInfo_propietario").attr("disabled", true);
			
			if (rtipo=="disp" | rtipo=="takeup" | rtipo=="nidisp") {
				$("#frmInfo_busq").attr("disabled", true);
			} else {
				$("#frmInfo_busq").removeAttr("disabled");
				$("#frmInfo_busq").focus();
			}
			//$("#frmInfo_busq").select();
		}
		
		//tips
		var title, content;
		if (rtipo=="edif") {
			title = "Para buscar un <span class='naranjaB'>Edificio</span>: introducir el nombre del edificio <u>o</u> el nombre de la calle con Nº.";
			content = "Ej: atenas, diagonal 00, torre litoral, generali, testa, diagonal 60, gracia 16, torre espacio, cristalia, "
			content = content + "piramide, atica, castellana 35, hernani 59, principe de vergara 108, etc...";
			$("#frmInfo_busq").attr("placeholder", "Edificio o Dirección");
			$("#lblInfo_edif").addClass("activo");
		} else if (rtipo=="ni") {	
			title = "Para buscar un <span class='naranjaB'>Nave/Poligono Industrial</span>: introducir el nombre del edificio <u>o</u> el nombre de la calle con Nº.";
			content = "Ej: atenas, diagonal 00, torre litoral, generali, testa, diagonal 60, gracia 16, torre espacio, cristalia, "
			content = content + "piramide, atica, castellana 35, hernani 59, principe de vergara 108, etc...";
			$("#frmInfo_busq").attr("placeholder", "Edificio/Dirección/Propietario/Inquilino");
			$("#lblInfo_ni").addClass("activo");
		} else if (rtipo=="nidisp") {	
			title = "Para buscar un <span class='naranjaB'>Nave/Poligono Industrial</span>: introducir el nombre del edificio <u>o</u> el nombre de la calle con Nº.";
			content = "Ej: atenas, diagonal 00, torre litoral, generali, testa, diagonal 60, gracia 16, torre espacio, cristalia, "
			content = content + "piramide, atica, castellana 35, hernani 59, principe de vergara 108, etc...";
			$("#frmInfo_busq").attr("placeholder", "");
			$("#lblInfo_nidisp").addClass("activo");
		} else if (rtipo=="disp") {
			title = "<span class='naranjaB'>Disponibilidad</span> por <span class='naranjaB'>edificio</span> y/o <span class='naranjaB'>calle</span>";
			content = "- para conseguir diponibilidad <strong>dentro de un edificio</strong>, indicar el nombre de la calle y el n&ordm;;<br>";
			content = content + "Ej: castellana 110, gracia 35, etc...<br>";
			content = content + "- para conseguir la disponibilidad en <strong>toda una calle</strong>, introducir el nombre<br>";
			content = content + "Ej: castellana, juan ignacio luca de tena, europa, diagonal, gracia, consell de cents, etc...<br>";
			content = content + "- para conseguir la disponibilidad <strong>por zonas</strong>, introducir su nombre<br>";
			content = content + "Ej: 22@, mendez alvaro, campo de las naciones, azca, etc...";
			$("#frmInfo_busq").attr("placeholder", "");
			$("#lblInfo_disponib").addClass("activo");
			
		} else if (rtipo=="cc") {
			title = "Para buscar un <span class='naranjaB'>Centro</span> o <span class='naranjaB'>Parque Comercial</span> introducir el nombre";
			content = "Ej: bonaire, tres aguas, islazul, tormes, etc...";
			$("#frmInfo_busq").attr("placeholder", "Centro Comercial");
			$("#lblInfo_cc").addClass("activo");
			
		} else if (rtipo=="hot") {
			title = "Para buscar un <span class='naranjaB'>Hotel</span> solamente debe introducir el nombre";
			content = "Ej: <span style='font-weight:bold;'>jardines</span>, <span style='font-weight:bold;'>castilla</span>, rocamar, ritz, etc...";
			$("#frmInfo_busq").attr("placeholder", "Hotel");
			$("#lblInfo_hot").addClass("activo");
			
		} else if (rtipo=="retail") {
			title = "";
			content = "";
			content = content + "";
			
		} else if (rtipo=="empr") {
			title = "Para buscar una <span class='naranjaB'>Empresa</span> introducir el nombre o parte de &eacute;l";
			content = "Por ejemplo: <span style='font-weight:bold;'>autonomy</span> o bien <span style='font-weight:bold;'>autonomy capital</span>, ";
			content = content + "<span style='font-weight:bold;'>ohl</span>, <span style='font-weight:bold;'>savills</span>, talus, etc...";
			$("#frmInfo_busq").attr("placeholder", "Empresa");
			$("#lblInfo_empr").addClass("activo");
			
		} else if (rtipo=="prop") {
			title = "Seleccionar un propietario";
			content = "Para obtener los inmuebles de los que es propietario.<br>";
			//content = content + "";
			$("#lblInfo_prop").addClass("activo");
			
		}
		
		$("#frmInfo-tip-title").html("<p>" + title + "</p>");
		$("#frmInfo-tip-content").html("<p class='azulB'>" + content + "</p>");
		
	});
	
	$("#frmInfo_propietario").change(function() {
		//console.log($("#frmInfo_propietario").val());
		if ($("#frmInfo_propietario").val()) {
			$("#frmInfo").submit();
		}
	});
	
	$("#frmInfo").submit(function() {
		if ($($("#frmInfo input:radio:checked")).val()=="disp") {return false}
		if ($($("#frmInfo input:radio:checked")).val()=="nidisp") {return false}
		if ($($("#frmInfo input:radio:checked")).val()=="takeup") {return false}


		if ($("#frmInfo input:radio:checked").length==0) {
			if ($("#frmInfo_busq").val()!="") {
				$("#frmInfo-tip-title").html("<p>Seleccionar <strong>Tipo de B&uacute;squeda</strong></p>");
				$("#frmInfo-tip-content").html("<p class='azulB'>Debes indicar un <span class='naranjaB'>Tipo de B&uacute;squeda</span> para realizar la consulta en Info</p>");
			}
			$("#frmInfo_busq").focus();
			return false;
			
		} else {
			var rtipo = $("#frmInfo input:radio[name=frmInfo_tipo]:checked").val();
			if (rtipo=="disp") {
				console.log("form validate")
				if (parseInt($("#filtro_min").val())>parseInt($("#filtro_max").val())) {
					$("#filtro_max").focus();
					//$.scrollTo("#filtro_max",800);
					return false;
				}
			} else {
				if (rtipo=="prop") {
					//console.log("[" + $("#frmInfo_propietario").val() + "]")
					if ($("#frmInfo_propietario").val()=="") {
						$("#frmInfo_propietario").focus();
						//$.scrollTo("#filtro_max",800);
						return false;	
					}
				} else {
				//	if ($("#frmInfo_busq").val()=="") {
						$("#frmInfo_busq").focus();
				//		return false;
				//	}
				}
			}
		}
	});
	
	$("#frmInfo-submit").click(function(e) {
        e.preventDefault();
		var rtipo = $("#frmInfo input:radio[name=frmInfo_tipo]:checked").val();
		
		if (rtipo=="disp" ) {
			$("#frmInfo input[name='lat']").val("");
			$("#frmInfo input[name='lng']").val("");
			$("#frmInfo input[name='zoom']").val("");
		};
		
		$("#frmInfo").submit();
			
    });
	
	function test_frmInfo(){
		if ($("#frmInfo input:radio:checked").length==0) {
			$("#frmInfo-tip").show();
			return false;
			
		} else {
			var rtipo = $("#frmInfo input:radio[name=frmInfo_tipo]:checked").val();
		
			if (rtipo=="prop") {
				console.log("[" + $("#frmInfo_propietario").val() + "]")
				if ($("#frmInfo_propietario").val()=="") {
					//console.log("[" + $("#frmInfo_busq").val() + "]")
					$("#frmInfo-tip").show();
					return false;	
				};
				
			} else {
				if ($("#frmInfo_busq").val()=="") {
					//console.log("[" + $("#frmInfo_busq").val() + "]")
					$("#frmInfo-tip").show();
					return false;	
				};
				
			}
		};
		
		return true;
	};
	
	
	$(".simplemodal").click(function(e) {
		//console.log(".simplemodal.click")
		
		var href = $(this).attr("href");
		if (href=="#") {
			$("#ModalBox").load(
				"/acceso/password.asp",
				href,
				function(recibe, textStatus, xhr) { $("#ModalBox").modal("show") }
			);
			return false;
			
		} else {
			href = href.substr( href.indexOf("?")+1, href.length);
			
			if ( getCookie("condiciones")=="" ) {
				$("#ModalBox").load(
					"/acceso/password.asp",
					href,
					function(recibe, textStatus, xhr) { $("#ModalBox").modal("show") }
				);
				return false;
				
			} else {}
		}
	});
	
	$("#footer_suscribe").submit(function(e) {
		return false;
		
		e.preventDefault();
		//console.log( $("#footer_suscribe").serialize() );
		
		$.ajax({
			type: "POST",
			url: "/mailing/suscribe.asp",
			data: $("#footer_suscribe").serialize(),
			beforeSend: function() {}, /* test_footer_suscribe */
			success: function(data, txtStatus, jqSHR) {
				$("#ModalBox").html(data);
				$("#ModalBox").modal("show");
			}
		})
		
		return false;
	})
	
	function test_footer_suscribe() {
		var ErrSubmit = "";
		var emailReg = new RegExp(/^(("[\w-\s]+")|([\w-]+(?:\.[\w-]+)*)|("[\w-\s]+")([\w-]+(?:\.[\w-]+)*))(@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][0-9]\.|1[0-9]{2}\.|[0-9]{1,2}\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\]?$)/i);
		
		var email = $("#footer_suscribe_email").val();
		
		if(!(emailReg.test(email))) {ErrSubmit="<p class='destaca'>El email introducido no es v&aacute;lido</p>"};
		if (email=="") {ErrSubmit="<p class='destaca'>Tienes que introducir tu email.</p>"};
		
		if (ErrSubmit=="") {
		} else {
			console.log(ErrSubmit);
			return false;
		};
	};
	
    $("[data-toggle='popover']").popover();
	
	
	
	$("[data-toggle='tooltip']").tooltip({container: "body"});
	
	$(".collapse")
		.on("shown.bs.collapse", function() {
			$(this)
			.parent()
			.find(".icon-plus")
			.removeClass("icon-plus")
			.addClass("icon-minus");
		})
		.on("hidden.bs.collapse", function() {
			$(this)
			.parent()
			.find(".icon-minus")
			.removeClass("icon-minus")
			.addClass("icon-plus");
		});
	
	$("[data-toggle='notify']").click(function(e) {
		var txt = $(this).html();
		$.get($(this).data("load"), function(recibe){
			$.notify(
				{
				title: "<h3 style='border-bottom:1px solid #3c763d; margin-top:0'>" + txt + "</h3>",
				message: recibe
				}, 
				{
					//element: "#containerHeader",
					type: "success",
					animate: {
						enter: "animated fadeInDown",
						exit: "animated fadeOutUp"
					},
					placement: {
						from: "top",
						align: "left"
					}, 
					newest_on_top: true,
					showProgressbar: true,
					delay: 10000,
					timer: 250,
					mouse_over: "pause"
				}
			);
	
		});
    });
	
	
	$("#head_btn_info").click(function(e) {
		$("#head_div_busq").removeClass("despliegaDiv");
		$("#head_div_info").toggleClass("despliegaDiv");
	})
	$("#head_btn_busq").click(function(e) {
		$("#head_div_info").removeClass("despliegaDiv");
		$("#head_div_busq").toggleClass("despliegaDiv");
	});
	
	$(".bindev").click(function(e) {
        var url = $(this).prop("href");
		$.get(url, "", function(data, txtStatus, jqXHR) {
			location.reload();
		})
		return false;
    });
	
	$(".bin").click(function (e) {
		e.preventDefault();
		$.post(
			this.href,
			function(data) {
				//console.log(data);
				location.reload(true);
			}
		);
	});
	
});


/*	jQuery deprecated	*/
// .curCSS
jQuery.curCSS = jQuery.css;

// .browser
var matched, browser;

jQuery.uaMatch = function( ua ) {
    ua = ua.toLowerCase();

    var match = /(chrome)[ \/]([\w.]+)/.exec( ua ) ||
        /(webkit)[ \/]([\w.]+)/.exec( ua ) ||
        /(opera)(?:.*version|)[ \/]([\w.]+)/.exec( ua ) ||
        /(msie) ([\w.]+)/.exec( ua ) ||
        ua.indexOf("compatible") < 0 && /(mozilla)(?:.*? rv:([\w.]+)|)/.exec( ua ) ||
        [];

    return {
        browser: match[ 1 ] || "",
        version: match[ 2 ] || "0"
    };
};

matched = jQuery.uaMatch( navigator.userAgent );
browser = {};

if ( matched.browser ) {
    browser[ matched.browser ] = true;
    browser.version = matched.version;
}

// Chrome is Webkit, but Webkit is also Safari.
if ( browser.chrome ) {
    browser.webkit = true;
} else if ( browser.webkit ) {
    browser.safari = true;
}
jQuery.browser = browser;

</script>

<script type="text/javascript">window.$crisp=[];window.CRISP_WEBSITE_ID="3753ee9d-19f6-4fa8-b940-f6deea4545a6";(function(){d=document;s=d.createElement("script");s.src="https://client.crisp.chat/l.js";s.async=1;d.getElementsByTagName("head")[0].appendChild(s);})();</script>



    
    <link href="/css/css-pags/mapaCoord.css" rel="stylesheet" type="text/css">
	<link href="/css/css-pags/tabs031-izq.css" rel="stylesheet" type="text/css">
	<!-- EXTRA  -->
	<link href="/css/css-pags/elementosForm.css" rel="stylesheet" type="text/css">
	<link href="/css/css-pags/elementosResultados.css" rel="stylesheet" type="text/css">
    <link href="/css/css-pags/filtrosForm.css" rel="stylesheet" type="text/css">
    
	<link href="/lib/fancyBox/jquery.fancybox.css" type="text/css" rel="stylesheet">
	<!-- link href="/lib/block/blockUI/block.css" rel="stylesheet" type="text/css" -->
    
<script src="/lib/fancyBox/jquery.fancybox.pack.js"></script>
<script src="/lib/block/jquery.blockUI.min.js"></script>	

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC_5kUZnI4pDgH19ptKkMuneHuz0tJ5P6g&region=ES"></script>

<script src="/lib/maps/infobox.js" type="text/javascript"></script>
<!-- script src="/_inc/javier/js/javier.js"></script -->
<script src="/js/selectDrop.js"></script>
<script>
	var startTime = new Date();
	var endTime = new Date();
	var FechaHoy = new Date();
	

	var inmuebles = [];
	var markerList = [];
	var infoboxesList = [];
	var seleccionados = [];
	var rentas_todas;
	var agentes_todos;
	
	var localidades = [];
	
	var limite_seleccion = 50;
	var centrarMapa = false;
	
	//var cargando = true;
	//var frm_data = "frmInfo_disp_tab=&lat=&lng=&zoom=&orden=&ordent=&ciudad=&min=&max=&agencia=&zona=&subzona=&calle=";
	var cargando = false;
	var frm_data = "";
	
	var faltan_inmuebles = 0;
	
	var counter = 0;
	//var calc_renta;
	
	var images = new Array();
	var img;
	
	var poligono;
	var markersZona = [];
	
	
	var block_opts = {
		message: "<img src='/img/ajax-loader.gif'>",
		css: {
			border: "none", 
			padding: "0px", 
			backgroundColor: "none",
			opacity: .8, 			
			left: "0px", 
			right: "0px",
			/*
			opacity: .5, 
			*/
			/*
			backgroundColor: "#000", 
			"-webkit-border-radius": "10px", 
			"-moz-border-radius": "10px", 

			color: "#fff" 
			*/
			width: "none"
		},
		overlayCSS: {
			backgroundColor: "#fff",
			opacity: 0.3,
			margin: "auto"
		}	
	};
	/*
	var block_opts = {
		message: "<img src='/img/ajax-loader.gif'>",
		css: { 
			border: "none", 
			padding: "0px", 
			backgroundColor: "none",
			//backgroundColor: "#000", 
			//"-webkit-border-radius": "10px", 
			//"-moz-border-radius": "10px", 
			//opacity: .5, 
			//color: "#fff" 
			width: "none"
		},
		overlayCSS: { backgroundColor: "#00f" }
	}
	*/
	var swMostrarDiapositivas = true;
	
	var reload_map = false;
	
	
	var act_map = {'zoom':0, 'lat': 0, 'lng': 0}
	var act_zoom = 0;
	
</script>

<style type="text/css">
	#myMap {
		width: 100%;
		height: 480px;
		z-index: 0;
		position: relative;
	}
	
	input.warning {
		color:red;
	}
	
	#depura {
		clear:both;
		display:block;
		font-size: 14px;
		margin: 3px;
		color: #C94307;
		display: none;
	}
	.depura-filtros {
		clear:both;
		display:block;
		font-size: 14px;
		margin: 3px;
		color: #C94307;
		display: none;
	}
	
	
</style>


<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-143927921-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-143927921-1');
</script>

</head>
<body>
	
<div class="container ">
	<div id="containerHeader" class="row">
		<header class="containerHeader clearfix">

			<div class="col-sm-9 izquierda">
				<div class="row">
					<!--logoPW-->
					<div class=" col-sm-12 col-md-4 logoPW">
						<a href="/"><img src="/_inc/javier/img/logoPW.png" class="logo"></a> 
						<div class="visible-xs-inline-block tlfOculto">
							
								<span class="icon-phone"></span> 914 295 143 
							
						</div><!-- //tlfOculto -->    
						<div class="aboutUs">
							<ul>
								<li class="li-movil"><a href="/flash/" class="PWhoy"><img src="/img/shared/newsPaper.png"/><p><span class="icoLogo"></span>PW News Summary</p></a></li>
								<li class="li-movil"><a href="/presenta/" target="_blank"><span class="icon-user-tie"></span><p>Con&oacute;zcanos</p></a></li>
								<li class="visible-xs-inline-block"><a href="#" id="head_btn_info"><span class="icon-search"></span><p>Info</p></a></li>
								<li class="visible-xs-inline-block"><a href="#" id="head_btn_busq"><span class="icon-list"></span><p>Busquedas</p></a></li> 
							</ul>
						</div><!-- //aboutUs -->
            
					</div>
					
					<div class="col-sm-12 col-md-8">
						<div class="row buscadores">
							<div class="col-sm-6 colInfo" id="head_div_info">
								<h1>Seleccionar Info:</h1>
                                
								<form action="/disponibilidad/" method="post" id="frmInfo">
									<ul>
                                        <li>
											<input name="frmInfo_tipo" type="radio" class="infoRadio frmInfo_tipo" value="prop" id="frmInfo_prop" />
											<label for="frmInfo_prop" id="lblInfo_prop" class="lblInfo "><span class="icon-key"></span> Propietario Actual</label>
											
										</li>
										<li>
											<input name="frmInfo_tipo" type="radio" class="infoRadio frmInfo_tipo" value="cc" id="frmInfo_cc" />
											<label for="frmInfo_cc" id="lblInfo_cc" class="lblInfo "><span class="icon-coin-euro"></span>Centro/Parque/Nave Comercial</label>
											
										</li>
										<li>
											<input name="frmInfo_tipo" type="radio" class="infoRadio frmInfo_tipo" value="ni" id="frmInfo_ni" />
											<label for="frmInfo_ni" id="lblInfo_ni" class="lblInfo "><span class="icon-folder"></span> Industrial/Logistica</label>
											
										</li>
										<li class="indent">
											<input name="frmInfo_tipo" type="radio" class="infoRadio frmInfo_tipo" value="nidisp" id="frmInfo_nidisp" />
											<label for="frmInfo_nidisp" id="lblInfo_nidisponib" class="lblInfo "><span class="icon-checkmark"></span> Disponibilidad</label>
											
										</li>
										
										<li>
											<input name="frmInfo_tipo" type="radio" class="infoRadio frmInfo_tipo" value="hot" id="frmInfo_hot" />
											<label for="frmInfo_hot" id="lblInfo_hot" class="lblInfo "><span class="icon-home"></span> Hotel</label>
											
										</li>
										<li>
											<input name="frmInfo_tipo" type="radio" class="infoRadio frmInfo_tipo" value="edif" id="frmInfo_edif" />
											<label for="frmInfo_edif" id="lblInfo_edif" class="lblInfo "><span class="icon-office"></span> Edificio o Dirección</label>
											
										</li>
										<li class="indent">
											<input name="frmInfo_tipo" type="radio" class="infoRadio frmInfo_tipo" value="disp" id="frmInfo_disp" checked/>
											<label for="frmInfo_disp" id="lblInfo_disponib" class="lblInfo activo"><span class="icon-checkmark"></span> Disponibilidad</label>
											
										</li>
                                        <li class="indent">
											<input name="frmInfo_tipo" type="radio" class="infoRadio frmInfo_tipo" value="takeup" id="frmInfo_takeup" />
											<label for="frmInfo_takeup" id="lblInfo_takeup" class="lblInfo "><span class="icon-checkmark"></span> Take Up</label>
											
										</li>
										<li>
											<input name="frmInfo_tipo" type="radio" class="infoRadio frmInfo_tipo" value="empr" id="frmInfo_empr" />
											<label for="frmInfo_empr" id="lblInfo_empr" class="lblInfo "><span class="icon-briefcase"></span> Empresa</label>
											
										</li>
										<li style="display:none;">
											<input name="frmInfo_tipo" type="radio" class="infoRadio frmInfo_tipo" value="retail" id="frmInfo_retail" disabled="disabled"/>
											<label for="frmInfo_retail" id="lblInfo_retail" class="lblInfo "><span class="icon-road"></span> Info - Calle <span class="enconstruccion">(en construcción)</span></label>
										</li>
										<li>
											<div class="inputField">
												<div class="input-group info-buscar" id="info-buscar" >
													<input type="text" class="form-control" value="" placeholder="" id="frmInfo_busq" name="frmInfo_busq" disabled="disabled"  autocomplete="off">
													<span class="input-group-btn"><button class="btn btn-default icon-search disabled" type="submit" id="frmInfo-submit" > </button></span>
												</div>
												<div id="info-propietarios" style="display:none;">
													
														<select id="frmInfo_propietario" name="frmInfo_propietario" disabled class="form-control info-buscar ">
                                                            <option value="" selected>Seleccione Propietario</option>
                                                            <option value="27647" >1ZONE CAPITAL</option><option value="28092" >22HQ</option><option value="11065" >3GT</option><option value="1388" >3M ESPAÑA</option><option value="24473" >90 NORTH REAL ESTATE PARTNERS</option><option value="25005" >9HOTEL COLLECTION</option><option value="27783" >A CONTRACORRIENTE FILMS</option><option value="27450" >A&O HOSTELS</option><option value="26830" >AA HOTELES</option><option value="24208" >ABAC CAPITAL</option><option value="24885" >ABANCA</option><option value="28453" >ABDULHADI MANA AL-HAJRI</option><option value="6316" >ABERDEEN ASSET MANAGEMENT</option><option value="26526" >ABERDEEN STANDARD LIFE</option><option value="26672" >ABYS</option><option value="8485" >AC ITAROA</option><option value="25362" >ACCELERATE PROPERTY FUND</option><option value="1417" >ACCIONA</option><option value="3234" >ACCOR</option><option value="11826" >ACEK</option><option value="10496" >ACM. </option><option value="27582" >ACOSTA MATOS</option><option value="102" >ACS DRAGADOS</option><option value="21075" >ACTA HOTELS</option><option value="27529" >ACTIU</option><option value="22387" >ACTIV-GROUP</option><option value="16008" >ACTIVITAS</option><option value="25804" >ACTIVOS EMPRESARIALES</option><option value="16538" >ACTIVUM SG</option><option value="26202" >ACTUAL CAPITAL</option><option value="19347" >ADDINGTON CAPITAL</option><option value="2381" >ADESLAS</option><option value="24741" >ADF ASSET MANAGEMENT</option><option value="13366" >ADIF</option><option value="14534" >ADLER REAL ESTATE</option><option value="24262" >ADO</option><option value="28185" >ADRIANO CARE</option><option value="24984" >ADVENIS INVESTMENT MANAGERS</option><option value="28259" >ADVERO</option><option value="27075" >AEGILA CAPITAL MANAGEMENT</option><option value="5265" >AENA</option><option value="17632" >AERIUM</option><option value="15471" >AEW EUROPE</option><option value="21463" >AFIAA INVESTMENT FOUNDATION FOR PROPERTY INVESTMENTS ABROAD</option><option value="28015" >AFINIPO</option><option value="1461" >AFINSA</option><option value="22395" >AG REAL ESTATE</option><option value="11019" >AG2R LA MONDIALE</option><option value="25479" >AGA KHAN</option><option value="24936" >AGALEGA DIRECTORSHIP</option><option value="21951" >AGC EQUITY PARTNERS</option><option value="1467" >AGF UNION FENIX</option><option value="7835" >Agora Inversiones Patrimoniales</option><option value="25954" >AGROLAB</option><option value="1478" >AGROLIMEN</option><option value="21908" >AGRUPACION DE INTERES URBANISTICO ALFAFAR PARC</option><option value="7700" >AGRUPACION MUTUA</option><option value="23696" >AGUILAS PLAZA</option><option value="4" >AGUIRRE NEWMAN</option><option value="1504" >AHORRAMAS (GRUPO)</option><option value="5" >AHORRO FAMILIAR</option><option value="10786" >AIG</option><option value="25628" >AINA HOSPITALITY</option><option value="27540" >AIP ASSET MANAGEMENT</option><option value="16144" >AIXA</option><option value="23455" >AJA INVERSIONES</option><option value="20718" >AKELIUS </option><option value="23877" >AKM INMUEBLES</option><option value="27087" >AL RAFIDAIN</option><option value="25962" >AL SRAIYA</option><option value="26246" >AL ZAYANI INVESTMENTS</option><option value="26380" >ALAMEDA CAPITAL</option><option value="21359" >ALANTRA</option><option value="25178" >ALASKA PERMANENT FUND CORPORATION </option><option value="25463" >ALCALA 120 PROMOCIONES Y GESTION INMOBILIARIA</option><option value="7" >ALCAMPO</option><option value="1057" >ALDI</option><option value="24785" >ALDUWALIYA ASSET MANAGEMENT</option><option value="23073" >ALECTA</option><option value="28410" >ALEGRIA HOTELS</option><option value="1058" >ALFALAND</option><option value="23466" >ALFREDO COTO</option><option value="25219" >ALFREDO MORALES</option><option value="24016" >ALFREDO VILLALBA</option><option value="17290" >ALGONQUIN </option><option value="26654" >ALIGRUPO</option><option value="27139" >ALIMENTPECUAR</option><option value="23341" >ALIUS PLAZA DE ANDALUCIA</option><option value="28007" >ALL IRON RE</option><option value="15249" >ALLEGRA HOLDING</option><option value="1581" >ALLIANZ RAS SEGUROS</option><option value="132" >ALLIANZ REAL ESTATE</option><option value="7511" >ALLOGA</option><option value="26648" >ALLREAL</option><option value="27880" >ALMAGRO CAPITAL</option><option value="28346" >ALONDRA SERVICIOS INMOBILIARIOS</option><option value="13607" >ALPHA REAL CAPITAL</option><option value="16477" >ALPINA REAL ESTATE</option><option value="26212" >ALTA PREMIUM</option><option value="23399" >ALTADENA INVEST</option><option value="28003" >ALTAMAR</option><option value="16839" >ALTAMIRA REAL ESTATE</option><option value="11442" >ALTAREA</option><option value="28131" >ALTER</option><option value="8534" >ALTING</option><option value="26060" >ALVOTEL</option><option value="1066" >ALZA REAL ESTATE</option><option value="17870" >AM ALPHA</option><option value="27884" >AM GESTIO</option><option value="13094" >AM LOCALES</option><option value="26652" >AM LOCALES PROPERTY</option><option value="16793" >AMAT</option><option value="5402" >AMAZON</option><option value="24255" >AMCORP PROPERTIES</option><option value="28076" >AMERICAN AXLE & MANUFACTURING</option><option value="23303" >AMF REAL ESTATE</option><option value="24498" >AMID ACHI FADUL</option><option value="27493" >AMREST</option><option value="27098" >AMRO REAL ESTATE</option><option value="19088" >AMUNDI REAL ESTATE</option><option value="23081" >AMURA CAPITAL</option><option value="23113" >AMVEST</option><option value="21399" >ANACAP</option><option value="23684" >ANBANG</option><option value="22741" >ANDERSSON REAL ESTATE INVESTMENT MANAGEMENT </option><option value="26566" >ANGELA LEONG</option><option value="18401" >ANGELO GORDON</option><option value="23991" >ANIMUA</option><option value="7101" >ANJOCA</option><option value="25667" >ANTESOR INVERSIONES</option><option value="21549" >ANTIRION</option><option value="26545" >ANTONIO CARRILLO</option><option value="28234" >Antonio Serrano Aznar</option><option value="27456" >AOM</option><option value="17159" >AP3</option><option value="27370" >AP67 SOCIMI</option><option value="24760" >APEIRON CAPITAL</option><option value="17111" >APG INVESTMENTS</option><option value="21114" >APOLLO </option><option value="18486" >APRIROSE REAL ESTATE INVESTMENT</option><option value="27467" >AQ ACENTOR</option><option value="24146" >AQUILA CAPITAL</option><option value="22999" >ARAB BANK CORPORATION</option><option value="24901" >ARAX PROPERTIES</option><option value="27166" >ARC REAL ESTATE PARTNERS</option><option value="15862" >ARCANO</option><option value="23713" >ARCCO BERRI</option><option value="25608" >ARCH COMMERCIAL ENTERPRISE</option><option value="20099" >ARCTIC SECURITIES</option><option value="27307" >ARDIAN REAL ESTATE</option><option value="26954" >AREA INDUSTRIAL & LOGISTICS</option><option value="1094" >ARENAL</option><option value="25545" >ARES CAPITAL</option><option value="12468" >ARES MANAGEMENT</option><option value="17250" >ARGAN</option><option value="1654" >ARGENTARIA</option><option value="27367" >ARIMA SOCIMI</option><option value="16533" >ARISTEAS</option><option value="1659" >ARMANDO ALVAREZ</option><option value="17462" >ARMINIUS</option><option value="5905" >ARNAIZ</option><option value="11644" >ARNEDO</option><option value="26408" >AROUNDTOWN</option><option value="25470" >ARREY HOTELS</option><option value="28066" >ARROW CAPITAL PARTNERS</option><option value="24369" >ART INVEST REAL ESTATE</option><option value="1103" >ARTHUR ANDERSEN</option><option value="24544" >ARTIEM HOTELS</option><option value="24914" >ARZAN WEALTH</option><option value="28017" >ARZOBISPADO DE BARCELONA</option><option value="27210" >ARZTEVERSORGUNG WESTFALEN-LIPPE</option><option value="25714" >ASCENCIO</option><option value="9611" >ASEFA</option><option value="1674" >ASEMAS, MUTUA DE SEGUROS A PRIMA FIJA</option><option value="22265" >ASHBY CAPITAL</option><option value="27073" >ASIA PACIFIC REAL ESTATE</option><option value="25806" >ASIAN GROWTH PROPERTIES</option><option value="1681" >ASISA</option><option value="26161" >ASOCIACION ESPAÑOLA DE CAJAS RURALES</option><option value="8210" >ASOCIACION MULTISECTORIAL DE EMPRESAS</option><option value="21763" >ASR REAL ESTATE DEVELOPMENT</option><option value="1689" >ASSISTENCIA SANITARIA COLEGIAL</option><option value="21200" >ASSURANCES DU CREDIT MUTUEL</option><option value="28263" >ASTONQUER</option><option value="24746" >ASUA GRUPO INMOBILIARIO</option><option value="27668" >ATALAYA</option><option value="27794" >ATARLOQUI</option><option value="19320" >ATITLAN</option><option value="25917" >ATLANTICA PROPERTIES</option><option value="25491" >ATLAS RESIDENTIAL</option><option value="26974" >ATOM HOTELES</option><option value="22503" >ATP REAL ESTATE</option><option value="13402" >ATRIUM EUROPEAN REAL ESTATE</option><option value="24041" >ATRIUM LJUNGBERG</option><option value="28005" >ATTESTOR CAPITAL</option><option value="27315" >ATTICA 21 HOTELES</option><option value="5915" >AUCHAN</option><option value="22039" >AUREC CAPITAL</option><option value="22618" >AURELIS</option><option value="1709" >AUTOLICA</option><option value="21492" >AUTONOMY CAPITAL</option><option value="24422" >AUTORIDAD PORTUARIA DE SEVILLA</option><option value="27907" >AVALON PROPERTIES</option><option value="25970" >AVANT CAPITAL PARTNERS</option><option value="11859" >AVANTIS</option><option value="27203" >AVENUE</option><option value="25226" >AVIGNON CAPITAL</option><option value="10940" >AVIVA INVESTORS</option><option value="25335" >AVWL</option><option value="11017" >AXA REAL ESTATE</option><option value="25575" >AXACTOR</option><option value="28056" >AYC HOMES</option><option value="5738" >AYUNTAMIENTO DE BARCELONA</option><option value="23648" >AYUNTAMIENTO DE CEE</option><option value="23653" >AYUNTAMIENTO DE FERROL</option><option value="1369" >AYUNTAMIENTO DE MADRID</option><option value="6740" >AYUNTAMIENTO DE MALAGA</option><option value="13159" >AYUNTAMIENTO DE MECO</option><option value="15510" >AYUNTAMIENTO DE PALMA DE MALLORCA</option><option value="14310" >AYUNTAMIENTO DE TORREJON</option><option value="27589" >AYUNTAMIENTO ES CASTELL</option><option value="27690" >AZA VALENCIA INMUEBLES</option><option value="27347" >AZARIA RENTAL</option><option value="14324" >AZORA</option><option value="27955" >AZULINEHOTELS</option><option value="1757" >AZUR </option><option value="14622" >AZURELAU</option><option value="26394" >BADEN-WURTTEMBERG FOUNDATION</option><option value="22572" >BAECH BIENES</option><option value="27683" >BAEZA</option><option value="7396" >BAIN CAPITAL</option><option value="7957" >BALLESTER INMOBILIARIA</option><option value="27947" >BALLON INVESTMENTS</option><option value="24394" >BALMES PADUA</option><option value="13345" >BALUARTE GRUPO INMOBILIARIO</option><option value="22124" >BALZAC REIM</option><option value="21261" >BAMBOO INVESTMENTS</option><option value="1825" >BANC SABADELL</option><option value="1782" >BANCA MARCH</option><option value="24311" >BANCA PRIVADA DE ANDORRA</option><option value="2103" >BANCO CAM</option><option value="1195" >BANCO CEISS</option><option value="7934" >BANCO DE ESPAÑA</option><option value="1863" >BANCO OCCIDENTAL</option><option value="1129" >BANCO POPULAR</option><option value="1872" >BANCO SANTANDER</option><option value="182" >BANCO VITALICIO</option><option value="1130" >BANESTO</option><option value="184" >BANIF INMOBILIARIA</option><option value="185" >BANK OF AMERICA MERRILL LYNCH</option><option value="1199" >BANKIA</option><option value="1891" >BANKINTER</option><option value="24147" >BARAKA GLOBAL INVEST</option><option value="1136" >BARCELO</option><option value="11797" >BARCELO HOTELES</option><option value="27692" >BARCELONA HOUSING SYSTEMS</option><option value="25924" >BARCELONESA DE INMUEBLES</option><option value="26786" >Barcino SOCIMI</option><option value="25729" >BARINGS REAL ESTATE</option><option value="6582" >BATIPART</option><option value="9144" >BAUHAUS</option><option value="26679" >BAY HOTELS&LEISURE</option><option value="27863" >BAYERISCHE ARTZEVERSORGUNG</option><option value="1142" >BBK</option><option value="196" >BBVA</option><option value="16514" >BBVA PROPIEDAD</option><option value="17728" >BBVA RENTING</option><option value="13211" >BCN GODIA</option><option value="25550" >BCP ASSET MANAGEMENT</option><option value="14765" >BD PROMOTORS</option><option value="28303" >BECORP</option><option value="25039" >BEIJING SHOKAI</option><option value="27260" >BELFAST HARBOUR</option><option value="28450" >BELTERRA INVESTMENTS</option><option value="1951" >BENETTON</option><option value="14524" >BENI STABILI</option><option value="15312" >BENSON ELLIOT </option><option value="19295" >BEOS</option><option value="6217" >BERNA</option><option value="24376" >BESSE SIGNATURE</option><option value="28297" >BESTPRICE</option><option value="15950" >BGP INVESTMENT</option><option value="28049" >BIDAFARMA</option><option value="28161" >BIG COLOMBO</option><option value="24836" >BIGGEST HAUSE REAL ESTATE</option><option value="8897" >BIGMAT PROMAESPAÑA</option><option value="27946" >Bilball Centre </option><option value="12757" >BIMBA Y LOLA</option><option value="1975" >BIMBO</option><option value="17705" >BINICALAF NOU</option><option value="23451" >BIOESFERA</option><option value="24062" >BISBEL HISPANIA</option><option value="17038" >BLACKROCK</option><option value="1162" >BLACKSTONE</option><option value="22785" >BLAS HERRERO</option><option value="22605" >BLUE ASSET MANAGEMENT </option><option value="26599" >BLUE COLIBRI CAPITAL</option><option value="27256" >BLUE NOBLE</option><option value="22544" >BLUE SEA HOTELS & RESORTS</option><option value="22732" >BLUEROCK</option><option value="12463" >BLUESPACE</option><option value="19561" >BMO REAL ESTATE</option><option value="12" >BNP PARIBAS REAL ESTATE</option><option value="18967" >BNP PARIBAS REAL ESTATE INVESTMENT MANAGEMENT</option><option value="25358" >BOES</option><option value="16220" >BOGARIS</option><option value="28120" >BOISSEE FINANCES</option><option value="2000" >BON PREU</option><option value="24597" >BONAVISTA DEVELOPMENTS</option><option value="7484" >BOUWFONDS REIM</option><option value="6918" >BOUWINVEST</option><option value="210" >BOUYGUES</option><option value="11663" >BOUYGUES IMOBILIÁRIA</option><option value="21977" >BQ HOTELES</option><option value="27615" >BRAUN LEBERFINGER LUDWIG</option><option value="27446" >BREOGAN PARK S.L.</option><option value="27827" >BREP</option><option value="28382" >BRICKBRO</option><option value="27304" >BRICKSTOCK SOCIMI</option><option value="9146" >BRICORAMA</option><option value="2016" >BRITISH AMERICAN TOBACCO</option><option value="1174" >BRITISH LAND</option><option value="12670" >BRITISH PETROLEUM PENSION FUND</option><option value="20016" >BROCKTON CAPITAL</option><option value="25795" >BROMLEY COUNTY COUNCIL</option><option value="17107" >BROOKFIELD PROPERTY PARTNERS</option><option value="23067" >BROTHER IBERIA</option><option value="28281" >BROWNFIELDS</option><option value="27566" >BS COMPANY</option><option value="20253" >BUFETE ESCURA</option><option value="23484" >BUILDING CENTER CAIXABANK</option><option value="13869" >BUNCH, ARQUITECTURA Y PROYECTOS</option><option value="2038" >BURGER KING</option><option value="25113" >BURNELL II INVESTMENT</option><option value="25799" >BUSINESS TRADING COMPANY</option><option value="9450" >BUSQUETS & GALVEZ</option><option value="18163" >BVK BAYERISCHE VERSORGUNGSKAMMER</option><option value="25961" >BWT</option><option value="27561" >BYBROOK CAPITAL</option><option value="1182" >C&A</option><option value="15816" >CA IMMO</option><option value="5271" >CABOEL</option><option value="27588" >CABOT FINANCIAL</option><option value="7404" >CADE SA</option><option value="23116" >CADENA DESARROLLOS</option><option value="28197" >CADENA Q</option><option value="14004" >CAELUM</option><option value="24994" >Caerus Investment Management</option><option value="5288" >CAFE & TE</option><option value="23652" >CAFEL INVERSIONES 2008</option><option value="27365" >CAIN INTERNATIONAL</option><option value="23028" >CAIRN CAPITAL</option><option value="1188" >CAISSE DE DEPOT</option><option value="6006" >CAISSE DES DEPÔTS</option><option value="1189" >CAIXA CATALUNYA</option><option value="20585" >CAIXABANK</option><option value="2068" >CAIXALEASING Y FACTORING</option><option value="1194" >CAJA DUERO</option><option value="25322" >CAJA POSTAL</option><option value="24012" >CALE STREET PARTNERS</option><option value="20951" >CALEDONIAN</option><option value="19738" >CALEUS CAPITAL INVESTORS</option><option value="27559" >CALPE INVEST</option><option value="25498" >CAMBRIDGE CITY COUNCIL</option><option value="2330" >CAMPER</option><option value="18106" >CANADIAN PENSION PLAN INVESTMENT BOARD</option><option value="27996" >CANFOTO</option><option value="27183" >CANICA EIENDOM</option><option value="20238" >CANMOOR</option><option value="23603" >CAPIHUELO INMOBILIARIA</option><option value="13852" >CAPITAL & COUNTIES</option><option value="10703" >CAPITAL 7</option><option value="25754" >CAPITAL BAY</option><option value="17289" >CAPITAL FRANCE HOTEL</option><option value="25730" >CAPITAL INDUSTRIAL</option><option value="27094" >CAPITALAND</option><option value="22461" >CAPMAN REAL ESTATE</option><option value="26771" >CAPREON</option><option value="19001" >CAPTIVA</option><option value="10708" >CARDIFF DREAMS</option><option value="23170" >CARMILA</option><option value="239" >CARREFOUR</option><option value="12202" >CARREFOUR PROPERTY</option><option value="16127" >CARVAL</option><option value="27189" >CARYSFORT CAPITAL</option><option value="24360" >CASA LABRA</option><option value="244" >CASER</option><option value="2200" >CASH LEPE</option><option value="27441" >CASSA FORENSE</option><option value="18011" >CASTELLANA DF BY AMSTEL</option><option value="17052" >CASTELLANA GESTION PATRIMONIAL</option><option value="26391" >CASTELLANA PROPERTIES (SOCIMI)</option><option value="13781" >CASTELLANO LEONESA DE URBANISMO</option><option value="11358" >CASTELLVI </option><option value="22378" >CASTLELAKE</option><option value="9783" >CASTMOR</option><option value="25320" >CASUAL HOTELES</option><option value="15951" >CAT REAL ESTATE</option><option value="28448" >CATALAN GRUPO EMPRESARIAL</option><option value="2212" >CATALANA OCCIDENTE</option><option value="23717" >CATALINAS ISLANDS</option><option value="3296" >CATALONIA HOTELS</option><option value="15108" >CATALYST CAPITAL</option><option value="20000" >CATELLA AM</option><option value="25710" >CAVENDO</option><option value="28324" >CAYCO</option><option value="82" >CBRE</option><option value="6438" >CBRE GLOBAL INVESTORS</option><option value="26066" >CC LAND HOLDING</option><option value="25065" >CCLA</option><option value="28262" >CDC INVESTISSEMENT IMMOBILIER</option><option value="26386" >CDL HOSPITALITY TRUSTS</option><option value="9709" >CECOSA</option><option value="27293" >CEDRUS INVEST BANK</option><option value="17088" >CEE</option><option value="21681" >Ceetrus</option><option value="25832" >CEFC</option><option value="25712" >CEGEREAL</option><option value="25975" >CELLS GROUP</option><option value="25607" >CELLS PROPERTY INVESTORS</option><option value="23789" >CENTENE CORPORATION / RIBERA SALUD</option><option value="27603" >CENTER CORUÑA HOTELES</option><option value="21938" >CENTERBRIDGE</option><option value="25789" >CENTERSCAPE</option><option value="2243" >CENTRO ASEGURADOR</option><option value="23383" >CENTRO COMERCIAL CIUDAD DE AYAMONTE</option><option value="27607" >CENTRO COMERCIAL CONSTITUCION 102</option><option value="14599" >CENTRO INTERMODAL LOGISTICO SA</option><option value="6167" >CENTURION</option><option value="25468" >CEOS</option><option value="19033" >CERBERUS </option><option value="28184" >CETIL MEDICION Y TRANSPORTE</option><option value="9103" >CEVASA</option><option value="25988" >CG GROUP</option><option value="13113" >CGI - COMMERZ GRUNDBESITZ INVESTMENTGESELLCHAFT</option><option value="27835" >CHARENT</option><option value="305" >CHELVERTON</option><option value="26748" >CHEUNG KEI GROUP</option><option value="22493" >CHINA INVESTMENT CORPORATION</option><option value="23318" >CHINA LIFE INSURANCE</option><option value="27691" >CHINA NATIONAL BUILDING MATERIAL</option><option value="26317" >CHINA RESOURCES LAND</option><option value="24864" >CHINA VANKE</option><option value="19163" >CHINESE ESTATES</option><option value="24318" >CHONGQING KANGDE INDUSTRIAL</option><option value="28367" >CHRISTIAN HANNOVER</option><option value="24484" >CHT</option><option value="18275" >CILOGER</option><option value="28202" >CINARA PROPERTIES</option><option value="2379" >CINESA</option><option value="19436" >CINESUR</option><option value="26174" >CIRKUIT PLANET</option><option value="15997" >CITI PROPERTY INVESTORS</option><option value="24985" >CITY DEVELOPMENTS LIMITED</option><option value="17183" >CITYCON</option><option value="16" >CITYGROVE </option><option value="13782" >CIVITAS</option><option value="27157" >CK ASSET HOLDINGS</option><option value="27542" >CK CAPITAL PARTNERS</option><option value="12178" >CLAPE</option><option value="14818" >CLARION GRAMERCY</option><option value="23744" >CLASICA URBANA DES. INMOBILIARIO</option><option value="22550" >CLEARBELL CAPITAL</option><option value="27887" >CLINIC DE BARCELONA</option><option value="24477" >CLOSA HOSTELERIA Y RESTAURACION</option><option value="16963" >CLOVER GROUP</option><option value="16331" >CLS HOLDING</option><option value="1244" >CNP</option><option value="25581" >CNP PARNERS</option><option value="17254" >COBLILAC</option><option value="2377" >COCA COLA</option><option value="12095" >COFINIMMO</option><option value="25570" >COIMA RES</option><option value="24660" >COJAB</option><option value="28475" >COLCAP</option><option value="27232" >COLEGIO DE ARQUITECTOS DE MADRID</option><option value="6093" >COLEGIO DE REGISTRADORES</option><option value="27824" >COLEGIO PROFESIONAL DE ECONOMISTAS DE SEVILLA</option><option value="27321" >COLISEE</option><option value="574" >COLONIAL</option><option value="7601" >COLONY NORTHSTAR</option><option value="27860" >COMATEL</option><option value="25941" >COMER GROUP</option><option value="23633" >COMERCIAL COCENTAINA 9</option><option value="23402" >COMERCIALIA</option><option value="2363" >COMERCIANTES DEL PONIENTE</option><option value="21274" >COMISION DE TELECOMUNICACIONES</option><option value="5451" >COMISION NACIONAL DE LA ENERGIA</option><option value="7927" >COMISION NACIONAL MERCADO DE VALORES</option><option value="15973" >COMMERZ REAL</option><option value="2368" >COMMERZBANK AG</option><option value="26363" >COMMODUS</option><option value="28277" >COMMODUS REAL ESTATE</option><option value="26784" >COMPANYIA GENERAL CARNIA</option><option value="18541" >COMPOSTELA BEACH</option><option value="2426" >COMSA</option><option value="273" >COMUNIDAD DE MADRID</option><option value="16790" >COMUNIDAD DE PROPIETARIOS</option><option value="22647" >CONCEPTA</option><option value="25441" >CONEI COMPAÑIA INTERNACIONAL DE INVERSIONES</option><option value="13723" >CONFIDENCIAL</option><option value="2439" >CONFORAMA</option><option value="26095" >CONSEIL NATIONAL DE L’ORDRE DES MEDECINS</option><option value="24886" >CONSEJO GENERAL DE ECONOMISTAS</option><option value="26130" >CONSEJO GENERAL DEL NOTARIADO</option><option value="18731" >CONSELL DE L’AUDIOVISUAL DE CATALUNYA</option><option value="7615" >CONSORCIO DE COMPENSACION DE SEGUROS</option><option value="23655" >CONSORCIO DE LA ZONA FRANCA DE VIGO</option><option value="2449" >CONSORCIO ZONA FRANCA BARCELONA</option><option value="12776" >CONSTRUCCIONES GOMASPER</option><option value="25986" >CONSTRUCCIONES LOS CAMPOS</option><option value="27512" >CONSTRUCCIONES RICARDO SANCHEZ</option><option value="23441" >CONSTRUCCIONES Y PROMOCIONES ANGOCA</option><option value="26854" >CONSTRUCTORA CALPENSE</option><option value="22246" >CONSULTING DE REFORMAS HOTELERAS</option><option value="26360" >CONSUS COMMERCIAL PROPERTY</option><option value="17880" >CONTINENTAL PROPERTY INVESTMENTS</option><option value="1259" >CONTINENTE</option><option value="27032" >CONTINUUM CAPITAL INVESTMENT MANAGEMENT</option><option value="27893" >CONTINUUM HOTEL SERVICES</option><option value="1262" >CONVEX</option><option value="17092" >CONWERT IMMOBILIEN INVEST</option><option value="26935" >COPENAV</option><option value="8268" >COPRUSA</option><option value="27074" >COQUINE SA</option><option value="27830" >CORAL HOTELS</option><option value="21877" >CORDATUS REAL ESTATE</option><option value="24263" >CORDING REAL ESTATE</option><option value="6030" >CORE INVESTMENTS</option><option value="16930" >CORE PROPERTY </option><option value="25295" >COREM</option><option value="25606" >CORENDON</option><option value="18537" >CORESTATE</option><option value="93" >CORIO</option><option value="22172" >CORNERSTONE REAL ESTATE ADVISERS</option><option value="25586" >CORP PROMOTORS</option><option value="19345" >CORPFIN CAPITAL REAL ESTATE</option><option value="296" >CORPORACION FINANCIERA ALBA</option><option value="17410" >CORPUS SIREO INVESTMENT MANAGEMENT</option><option value="23760" >CORUM AM</option><option value="26571" >COSBEL</option><option value="11544" >COSMANI</option><option value="22065" >COSTASOL DE HIPERMERCADOS</option><option value="27482" >COSTASOL DE HIPERMERCADOS</option><option value="23093" >COSTCO</option><option value="8463" >COTI</option><option value="21222" >COVEA</option><option value="2525" >COVIRAN</option><option value="28255" >COVIVIO</option><option value="24058" >CP AMENABAR</option><option value="18979" >CPI GROUP</option><option value="26450" >CREDIPAS</option><option value="1892" >CREDIT AGRICOLE</option><option value="17217" >CREDIT AGRICOLE ASSET MANAGEMENT REAL ESTATE</option><option value="2583" >CREDIT SUISSE</option><option value="19247" >CREDIT SUISSE REAL ESTATE </option><option value="2584" >CREDITO Y CAUCION</option><option value="13341" >CRESA PATRIMONIAL</option><option value="10609" >CRIBER</option><option value="26340" >CROMWELL PROPERTY GROUP</option><option value="21315" >CROSSTREE REAL ESTATE PARTNERS</option><option value="25331" >CRYO TERUEL</option><option value="25812" >CSOIP BANKIA</option><option value="24055" >CTH CAPITAL</option><option value="24727" >CTP</option><option value="26962" >CV GROUP SOCIMI</option><option value="6447" >CVC CAPITAL PARTNERS</option><option value="25202" >CYCAS HOSPITALITY</option><option value="3867" >DACSA</option><option value="27574" >DADELOS</option><option value="22616" >DADES</option><option value="27255" >DAELLOS</option><option value="308" >DAFOR</option><option value="27877" >DAISHIN SECURITIES</option><option value="22258" >DAKOTA BUILDING CENTER</option><option value="24818" >DALATA</option><option value="22015" >DALIAN WANDA GROUP</option><option value="27483" >DANICA PENSION</option><option value="28147" >DANIEL MATE</option><option value="28489" >DARTRIVER</option><option value="311" >DAS WERK</option><option value="28375" >DASHA LIVING SPACE</option><option value="27078" >DAVID REUBEN / SIMON REUBEN (REUBEN BROTHERS)</option><option value="22198" >DAVIDSON KEMPNER CAPITAL</option><option value="26327" >DAVIGAL REAL ESTATE</option><option value="25972" >DC VALUES</option><option value="16663" >DCB</option><option value="27499" >DCN</option><option value="27704" >DEA CAPITAL REAL ESTATE</option><option value="23707" >DECATHLON</option><option value="2649" >DECOEXSA</option><option value="28040" >Decor II</option><option value="27842" >DECOR II PROYECTOS INMOBILIARIOS</option><option value="26320" >DEDEMAN</option><option value="6444" >DEKA</option><option value="14682" >DELANCEY REAL ESTATE</option><option value="22122" >DELIN PROPERTY</option><option value="24563" >DEMIRE DEUTSCHE MITTELSTAND REAL ESTATE</option><option value="2648" >DENSO BARCELONA</option><option value="315" >DERBY HOTELS</option><option value="23602" >DESARROLLO DE PROYECTOS MARTINSA GRUPO NORTE</option><option value="22356" >DESARROLLOS HOTELEROS BARCELONA 2004</option><option value="11937" >DESIGUAL</option><option value="25306" >DETRIAVALL</option><option value="15315" >DEUTSCHE ASSET & WEALTH MANAGEMENT</option><option value="26674" >DEUTSCHE ASSET ONE</option><option value="3428" >DEUTSCHE BANK</option><option value="18222" >DEUTSCHE EUROSHOP</option><option value="26191" >DEUTSCHE FINANCE GROUP</option><option value="27206" >DEUTSCHE FINANCE INTERNATIONAL</option><option value="22612" >DEUTSCHE FONDSVERMOGEN DFV</option><option value="26387" >Deutsche Immobilien</option><option value="28487" >DEUTSCHE KONSUM</option><option value="24122" >DEUTSCHE OFFICE</option><option value="20446" >DEUTSCHE WOHNEN</option><option value="23657" >DG CENTER ATLANTICO</option><option value="319" >DGI</option><option value="1311" >DHL</option><option value="17078" >DIC ASSET</option><option value="10366" >DICO</option><option value="27357" >DICTATOR</option><option value="8302" >DIDRA</option><option value="27578" >DIGITAL LONDON</option><option value="11966" >DINTEL</option><option value="25554" >DIOFA</option><option value="28253" >DIOK REALESTATE</option><option value="26506" >DIP</option><option value="19520" >DISFRIMUR</option><option value="25950" >DNB SCANDINAVIAN PROPERTY FUND</option><option value="23340" >DOCOJESA</option><option value="2719" >DOGA</option><option value="25198" >DOGUS TOURISM GROUP</option><option value="10871" >DOMO</option><option value="27905" >DOMUS VI</option><option value="26442" >DONAUHOF IMMOBILIEN</option><option value="14569" >DRAGO CAPITAL</option><option value="23562" >DREAM GLOBAL REIT </option><option value="27903" >DREAM MOUNTAIN</option><option value="28321" >DREAMPLACE</option><option value="25593" >DREEF BEHEER</option><option value="25480" >DSR DEUTSCHE INVESTMENT</option><option value="17211" >DTZ INVESTORS</option><option value="26834" >DUNCAN STUTTERHEIM</option><option value="26273" >DUNTSTONE</option><option value="19317" >DWS</option><option value="19571" >DWS INVESTMENTS </option><option value="25629" >EASTERN PROPERTY HOLDINGS</option><option value="25084" >EASYHOTEL</option><option value="12917" >EBROSA</option><option value="17188" >ECE</option><option value="6171" >ECHO INVESTMENT (POLONIA)</option><option value="25952" >ECKE INMOBILIEN</option><option value="25517" >ECOL INVESTMENT</option><option value="28233" >EDIFICIOS MESTALLA</option><option value="24487" >EDISTON PROPERTY</option><option value="7222" >EDOCUSA</option><option value="1465" >EFE</option><option value="22078" >EFTEN CAPITAL</option><option value="26996" >EGMONT</option><option value="5563" >EGUARA</option><option value="26326" >EKOS PROPERTIES</option><option value="6528" >EL CASTILLO</option><option value="347" >EL CORTE INGLES</option><option value="28397" >EL MOSCA</option><option value="26876" >ELAIA SOCIMI</option><option value="25580" >ELANDIS</option><option value="25193" >ELBA HOTELES</option><option value="16917" >ELETRES</option><option value="28457" >ELIER GOÑI</option><option value="27505" >ELITE PARTNERS CAPITAL</option><option value="25036" >Elite Zaida</option><option value="23296" >ELIX</option><option value="28070" >ELIX SOCIMI</option><option value="25216" >ELO MUTUAL</option><option value="7013" >EMASA</option><option value="19177" >EMBAJADA DE EMIRATOS ARABES</option><option value="23474" >EMBAJADA DE HOLANDA</option><option value="23472" >EMBAJADA DE JAPON</option><option value="24555" >EMBRAN TRADE</option><option value="8965" >EMESA</option><option value="27825" >EMILIO CASTILLEJOS</option><option value="22501" >EMIN CAPITAL</option><option value="24972" >EMPERADOR</option><option value="23920" >EMPEROR GROUP</option><option value="19172" >EMPLOYEE PROVIDENT FUND OF MALAYSIA</option><option value="20615" >EMPLOYEES PENSION FUND OF MALAYSIA</option><option value="24033" >EMPLOYEES PROVIDENT FUND</option><option value="8358" >ENFOREX</option><option value="23616" >ENPAM</option><option value="24573" >ENRIQUE PLA</option><option value="22535" >ENTRECAMPOS CUATRO SOCIMI</option><option value="22430" >EON FONDO DE PENSIONES</option><option value="27247" >EPP</option><option value="25215" >EQ</option><option value="24082" >EQT PARTNERS</option><option value="6547" >EQUIDOSA</option><option value="23037" >EQUILIS</option><option value="17868" >EQUINIX</option><option value="23338" >EQUIPAMIENTO FAMILIAR Y DE SERVICIOS</option><option value="8589" >ERGO</option><option value="26732" >ERHAN NEWCO</option><option value="369" >EROSKI</option><option value="18990" >Erste Asset Management</option><option value="27475" >ERWE IMMOBILIEN</option><option value="25565" >ESAS PROPERTIES</option><option value="26843" >ESPACIO MEDINA</option><option value="14277" >ESPACIO ZONA PRIME</option><option value="23636" >ESPACIO, COMERCIO Y OCIO</option><option value="25395" >ESPAFI</option><option value="27002" >ESPAIS BLAUS HABITATGE</option><option value="17209" >ESPARELLE</option><option value="28469" >Espiga Alfa Virginis</option><option value="26800" >ESTABONA MANAGEMENT</option><option value="23490" >ESTADO DE JAPON</option><option value="24964" >ESTEPARK</option><option value="27758" >ESTRELLA GALICIA</option><option value="24749" >ESTUDIO OLIVER</option><option value="26208" >ETNIA</option><option value="12027" >ETOILE PROPERTIES</option><option value="27296" >EUFIDES</option><option value="28244" >EUGENE INVESTMENT & SECURITIES</option><option value="2924" >EULEN</option><option value="24568" >EURAZEO</option><option value="27962" >EURESVA</option><option value="25967" >EURO CEVANTES</option><option value="24127" >EURO HOTEL</option><option value="375" >EUROCOMERCIAL</option><option value="6543" >EUROCOMMERCIAL</option><option value="23480" >EUROCONSELL ECONOMIC LEGAL</option><option value="21672" >EUROFONDO PROPIEDAD</option><option value="81" >EUROFUND </option><option value="12024" >EUROPA CAPITAL</option><option value="25493" >EUROPE HOTELS</option><option value="26167" >EUROPEAN COMMERCIAL REAL ESTATE</option><option value="8434" >EUROSAZOR</option><option value="16294" >EUROSIC</option><option value="25316" >EUROSTARS</option><option value="25304" >EUROSTONE</option><option value="26836" >EUROVALYS</option><option value="22195" >EVAN RANDALL</option><option value="13501" >EVANS RANDALL</option><option value="26665" >EXACORP ONE</option><option value="21783" >EXCEM</option><option value="23605" >EXCOSO</option><option value="11423" >EXINA</option><option value="13427" >EXMOOR</option><option value="25459" >EXPLOTACIONES AH 1895</option><option value="26336" >EXPLOTACIONES ROSOTEL</option><option value="382" >EXPO AN</option><option value="10649" >EXPO HOTELES & RESORTS</option><option value="25983" >EXTENSA GROUP</option><option value="20095" >F&C COMMERCIAL PROPERTY TRUST</option><option value="384" >FABREGA</option><option value="25136" >FABRICA SGR</option><option value="2977" >FADESA</option><option value="26660" >Faeton Capital </option><option value="25912" >FAIRVIEW HOTELS</option><option value="28280" >FAJOVI</option><option value="19905" >FAMILIA ASENSIO</option><option value="25290" >FAMILIA BALAÑA</option><option value="24753" >FAMILIA BATALLA CHORNET</option><option value="18373" >FAMILIA BERNAT</option><option value="25900" >FAMILIA BHATIA</option><option value="28171" >FAMILIA BRUGEROLLES</option><option value="26628" >FAMILIA CARCASSONA</option><option value="13167" >FAMILIA CAVERO</option><option value="27234" >FAMILIA COMA-CROS</option><option value="21136" >FAMILIA DE ANDRES PUYOL</option><option value="17385" >FAMILIA DIAZ ESTRADA</option><option value="24613" >FAMILIA DOMINGO RUBIES</option><option value="24889" >FAMILIA ECHEVERRIA</option><option value="20032" >FAMILIA FERNANDEZ SOMOZA</option><option value="390" >FAMILIA FIGUERAS</option><option value="22012" >FAMILIA GARCIA AZPIROZ</option><option value="11300" >FAMILIA GRASSET</option><option value="25963" >FAMILIA GRIFOLS</option><option value="19056" >FAMILIA LLADO</option><option value="28038" >FAMILIA MALDANELL</option><option value="17180" >FAMILIA MARAÑON</option><option value="27174" >FAMILIA MOYA YOLDI</option><option value="23627" >FAMILIA NORTEAMERICANA</option><option value="27226" >FAMILIA O'LEARY</option><option value="10840" >FAMILIA PECHUAN</option><option value="26690" >FAMILIA PINO PEREZ</option><option value="26297" >FAMILIA PLA Y PLANAS</option><option value="16070" >FAMILIA PORTABELLA</option><option value="21553" >FAMILIA POZZO</option><option value="15894" >FAMILIA PUIG</option><option value="27618" >FAMILIA QUESADA</option><option value="17606" >FAMILIA REYZABAL</option><option value="23183" >FAMILIA RUBIRALTA GIRALT</option><option value="24539" >FAMILIA SANTOS</option><option value="20635" >FAMILIA SEBRANGO</option><option value="23983" >FAMILIA SERRA</option><option value="23931" >FAMILIA SOLDEVILA FERRER</option><option value="24728" >FAMILIA WILKE</option><option value="25994" >FAMILIA ZAPATA</option><option value="28413" >FAMILY CASH</option><option value="18412" >FAMILY OFFICE DE LA CAV</option><option value="12139" >FANCAR INVERSIONES</option><option value="27363" >FANUC</option><option value="21939" >FASTIGHETS AB BALDER</option><option value="21811" >FATTAL HOTELS</option><option value="25482" >FDM MANAGEMENT</option><option value="27651" >FEDEFARMA</option><option value="25415" >FEDERACIO CATALANA DE PATINATGE</option><option value="10591" >FEDEX</option><option value="24881" >FERCA RENTAL</option><option value="25998" >FERNANDO VI 10</option><option value="25511" >FERRER HOTELS</option><option value="13307" >FETINI</option><option value="3020" >FEU VERT</option><option value="26983" >FG ASSET MANAGEMENT</option><option value="3024" >FIATC </option><option value="406" >FIATC</option><option value="22467" >FIDELITY REAL ESTATE</option><option value="26241" >FIDUCIARY CAPITAL</option><option value="409" >FILASA</option><option value="25359" >FIMALAC</option><option value="20979" >FINANCIERA INMOBILIARIA PROINOVA</option><option value="5415" >FINCAS CORRAL</option><option value="24280" >FINCH PROPERTIES ASSET MANAGEMENT</option><option value="16519" >FIRST PROPERTY GROUP</option><option value="24136" >FIRST SPONSOR</option><option value="16742" >FISA 74</option><option value="27440" >FISCALGES</option><option value="25488" >FITBOX</option><option value="417" >FITENI</option><option value="23228" >FLE SICAV</option><option value="23586" >FLECONS OBRAS</option><option value="9910" >FLOIRAC</option><option value="25210" >FLOREAT</option><option value="14503" >FM LOGISTIC</option><option value="25494" >FOLKSAM</option><option value="23753" >FOM REAL ESTATE</option><option value="17189" >FONCIERE DES MURS - GROUPE FONCIERE DES REGIONS</option><option value="6581" >FONCIERE DES REGIONS</option><option value="17324" >FONCIERE EURIS</option><option value="7347" >FONSAGRADA</option><option value="26271" >FONTEPAZO</option><option value="26818" >FORE PARTNERSHIP</option><option value="22240" >FORMAX</option><option value="28229" >FORT PARTNERS</option><option value="25762" >FORTE GROUP</option><option value="3080" >FORTIS BANK</option><option value="27972" >FORTITER</option><option value="23343" >FORTIUS PARTNER</option><option value="16199" >FORTRESS</option><option value="6421" >FORUM</option><option value="23123" >FOSUN </option><option value="424" >FOUSA</option><option value="14199" >FRAI DESARROLLOS INMOBILIARIOS</option><option value="26023" >FRANKLIN TEMPLETON</option><option value="23875" >FRASERS CENTREPOINT</option><option value="25465" >FRASERS HOSPITALITY</option><option value="27108" >FRASERS PROPERTY</option><option value="3103" >FREMAP</option><option value="17599" >FREO GROUP</option><option value="15272" >FREY INVEST</option><option value="3107" >FRIGICOLL</option><option value="11493" >FROGMORE</option><option value="28405" >FROST-TROL</option><option value="18944" >FTI</option><option value="23818" >FUBON LIFE</option><option value="7645" >FUERTE</option><option value="27995" >FUND GRUBE</option><option value="26389" >FUNDACION CAJA DE EXTREMADURA</option><option value="23861" >FUNDACION DE LA CAIXA DE CATALUNYA</option><option value="27438" >FUNDACION ENCUENTRO</option><option value="3130" >FUNDACION JIMENEZ DIAZ</option><option value="20198" >FUNDACION MAPFRE</option><option value="17279" >FUNDACION PRIVADA VILA CASAS</option><option value="26946" >FUNDAMENTA</option><option value="24667" >FX INICIATIVAS</option><option value="27851" >G. ELIAS Y MUÑOZ ABOGADOS</option><option value="6128" >GALCO</option><option value="20528" >GALENICUM</option><option value="27225" >GALIL CAPITAL</option><option value="27531" >GALIMMO</option><option value="3148" >GALLEGA DE DISTRIBUIDORES ALIMENTACION</option><option value="26647" >GAR & CIA</option><option value="24952" >GARAETA</option><option value="24892" >GARBE LOGISTIC</option><option value="3166" >GAS NATURAL FENOSA</option><option value="21406" >GATEWAY REAL ESTATE</option><option value="27847" >GAULAGA RESIDENCIAL</option><option value="6772" >GAZELEY</option><option value="12696" >GE REAL ESTATE</option><option value="11193" >GECINA</option><option value="13179" >GEINSOL</option><option value="8245" >GENERAL DE GALERIAS COMERCIALES</option><option value="22607" >GENERAL MEDITERRANEAN HOLDINGS</option><option value="11629" >GENERALE CONTINENTALE INVESTISSEMENTS</option><option value="1688" >GENERALI</option><option value="17108" >GENERALI REAL ESTATE</option><option value="474" >GENERALITAT DE CATALUNYA</option><option value="475" >GENERALITAT VALENCIANA</option><option value="11147" >GENESTA PROPERTY NORDIC</option><option value="9008" >GENTALIA</option><option value="27507" >GEOSAN DEVELOPMENT</option><option value="25568" >GERCH DEVELOPMENT</option><option value="25214" >GERMAN ESTATE GROUP</option><option value="5692" >GESFESA</option><option value="24270" >GESIMO</option><option value="25072" >GESIURIS REAL ESTATE</option><option value="16019" >GESTILAR</option><option value="23427" >GESTION Y DESARROLLO INMOBILIARIO PROMAPAN</option><option value="487" >GIC REAL ESTATE</option><option value="489" >GILMAR</option><option value="23580" >GINGKO TREE INVESTMENT</option><option value="24503" >GIT HOTELES</option><option value="22632" >GIUSEPPE CIPRIANI</option><option value="7481" >GLL REAL ESTATE</option><option value="27761" >GLO PROPERTIES</option><option value="23371" >GLOBAL ASSET CAPITAL</option><option value="7517" >GLOBAL DE INVERSIONES</option><option value="27342" >GLOBAL GATE CAPITAL</option><option value="23214" >GLOBAL PHOBOS</option><option value="26368" >GLOBAL STUDENT ACCOMMODATION</option><option value="17732" >GLOBAL SWITCH</option><option value="27408" >GLOBAL TALKE</option><option value="15338" >GLOBAL TRADE CENTRE</option><option value="23561" >GLOBALWORTH REAL ESTATE INVESTMENTS</option><option value="27192" >GLOBE INVEST</option><option value="27826" >GLP</option><option value="6782" >GLUAL MADRID</option><option value="27583" >GM FOOD</option><option value="497" >GMP</option><option value="9367" >GOBIERNO DE ARAGON</option><option value="14409" >GOBIERNO DE ESPAÑA</option><option value="27417" >GODEWIND</option><option value="27623" >GOLDACRE</option><option value="25732" >GOLDEN STAR ESTATE</option><option value="27587" >GOLDENTREE</option><option value="498" >GOLDMAN SACHS</option><option value="12959" >GONSI</option><option value="23461" >GONZALEZ VIERA PROMOCIONES</option><option value="16045" >GOODMAN</option><option value="10196" >GOOGLE</option><option value="18909" >GORBEA ARRENDAMIENTOS</option><option value="7125" >GOVADE</option><option value="6634" >GOVERNMENT OF SINGAPORE INVESTMENT CORPORATION</option><option value="25514" >GPEP</option><option value="28252" >GPF REAL ESTATE</option><option value="27359" >GRAN BULEVAR ESPACIO RESIDENCIAL</option><option value="24172" >GRAN ROQUE CAPITAL</option><option value="10692" >GRAND MAUSOL</option><option value="26789" >GRAPHIR</option><option value="15264" >GREAT PORTLAND ESTATES</option><option value="26146" >GREENBAY</option><option value="24173" >GREENMAN INVESTMENTS</option><option value="22855" >GREENOAK</option><option value="25408" >GREENRIDGE</option><option value="24734" >GREMI DE FORNERS</option><option value="26396" >GREMIAL DE TAXIS</option><option value="21802" >GREYCOAT</option><option value="22380" >GREYSTAR REAL ESTATE PARTNERS</option><option value="1371" >GROSVENOR</option><option value="3244" >GROUPAMA</option><option value="27516" >GROVEWORLD</option><option value="23207" >GRR REAL ESTATE MANAGEMENT</option><option value="5652" >GRUMALEX</option><option value="24747" >GRUP TERRAZA</option><option value="12538" >GRUPO ABADES</option><option value="23647" >GRUPO ALONSO</option><option value="22025" >GRUPO ALVORES</option><option value="27659" >GRUPO AS</option><option value="27648" >GRUPO ASA</option><option value="23134" >GRUPO AZA VALENCIA</option><option value="9892" >GRUPO BALLESTER</option><option value="25743" >GRUPO CARRILLO</option><option value="25736" >GRUPO CASADO</option><option value="23632" >GRUPO CIVICA</option><option value="21447" >GRUPO DE RIGO</option><option value="28039" >GRUPO FAGRA</option><option value="519" >GRUPO GOSA</option><option value="3291" >GRUPO GRIFOLS</option><option value="14161" >GRUPO HORO</option><option value="1360" >GRUPO HOTELES BARAJAS</option><option value="14331" >GRUPO IBSA</option><option value="521" >GRUPO INMOBILIARIO DELTA</option><option value="23864" >GRUPO INNMOBILIARIO GAUDIR</option><option value="23615" >GRUPO INVERSOR MC-2</option><option value="8226" >GRUPO KANDA</option><option value="525" >GRUPO LAR</option><option value="23642" >GRUPO MARTI</option><option value="28369" >GRUPO MAS</option><option value="12760" >GRUPO MASAVEU</option><option value="18886" >GRUPO MILLENIUM</option><option value="5665" >GRUPO MYRAMAR</option><option value="28221" >GRUPO NUMERO 1</option><option value="26143" >GRUPO ÑARUCOLA</option><option value="4189" >GRUPO ORTIZ</option><option value="3311" >GRUPO PLANETA</option><option value="22411" >GRUPO QUERALTO</option><option value="28267" >GRUPO RESIDE</option><option value="7312" >GRUPO REVILLA</option><option value="15757" >GRUPO ROSALES</option><option value="25706" >GRUPO SADE</option><option value="21182" >GRUPO SAMCO</option><option value="8870" >GRUPO SAN JOSE</option><option value="25165" >GRUPO SEGURA</option><option value="24661" >GRUPO SEVILLA (MEXICANO)</option><option value="5657" >GRUPO SOCIEDAD AZUCARERA LARIOS</option><option value="20245" >GRUPO SOLUCIONES</option><option value="21152" >GRUPO VILLAR MIR</option><option value="18419" >GRUPO WERFEN</option><option value="3330" >GRUPO ZETA</option><option value="7071" >GSE</option><option value="26810" >GUANGZHOU R&F PROPERTIES</option><option value="28485" >GUARDATODO</option><option value="19068" >GUBEL</option><option value="27841" >GULF ISLAMIC INVESTMENTS</option><option value="24896" >GUSTAVO ENRIQUE CASTELLANO / HASSAN EID R. ALBUAINAIN</option><option value="25409" >GUY IVESHA / CAIN HOY</option><option value="21704" >GWM</option><option value="23208" >GWM GROUP</option><option value="25915" >GXP GERMAN PROPERTIES</option><option value="537" >H10</option><option value="27134" >HABITAT INMOBILIARIA</option><option value="26350" >HADLEY INVESTMENTS SOCIMI</option><option value="17204" >HAHN GROUP</option><option value="27079" >HAKIM ORGANIZATION</option><option value="19740" >HAMBORNER</option><option value="20610" >HAMBURG TRUST</option><option value="24530" >HAMMER AG</option><option value="11748" >HAMMERSON</option><option value="27223" >HANA FINANCIAL INVESTMENTS</option><option value="13073" >HANNOVER LEASING</option><option value="15759" >HANSA INVEST</option><option value="540" >HANSA URBANA</option><option value="15841" >HANSAINVEST</option><option value="25205" >HANSEMERKUR</option><option value="23733" >HANWHA UND KYOBO LIFE</option><option value="26824" >HAO TIAN </option><option value="12412" >HARBERT MANAGEMENT CORPORATION</option><option value="9851" >HARD ROCK</option><option value="9854" >HARMONIA</option><option value="26950" >HAROLD MCPIKE</option><option value="25609" >HARTENBERG</option><option value="23098" >HAYFIN CAPITAL MANAGEMENT</option><option value="24495" >HAYTHAN ALHAJ</option><option value="23418" >HB CAPITAL</option><option value="12476" >HB REAVIS</option><option value="3359" >HD COVALCO</option><option value="26057" >HEALTHCARE ACTIVOS</option><option value="27743" >HEETON HOLDINGS</option><option value="26377" >HEIMSTADEN</option><option value="11038" >HEITMAN</option><option value="25889" >HELENA RIVERO</option><option value="22104" >HELIX PROPERTY ADVISORS</option><option value="16755" >HELVETIA SEGUROS</option><option value="25857" >HENDERSON PARK</option><option value="22947" >HENLEY</option><option value="26437" >HERCACLES</option><option value="26668" >HERCESA</option><option value="3374" >HERMANDAD FARMACEUTICA DEL MEDITERRANEO</option><option value="3377" >HERMANDAD NACIONAL DE ARQUITECTOS</option><option value="25508" >HERMANOS COLONQUES</option><option value="24612" >HERMANOS MARIA, PERE Y JOSEP CUSCO RAMONEDA</option><option value="548" >HERMANOS REVILLA</option><option value="5643" >HERMES</option><option value="15744" >HERMES REAL ESTATE</option><option value="27218" >HERMINIO GARCIA BAQUERO</option><option value="23670" >HERON CITY MADRID</option><option value="23641" >HERON CITY PATERNA</option><option value="3442" >HESPERIA</option><option value="24580" >HI PARTNERS</option><option value="22952" >HIBERNIA REIT</option><option value="11368" >HIDAFA</option><option value="22094" >HIG CAPITAL</option><option value="27006" >HIGHBROOK INVESTORS</option><option value="555" >HINES</option><option value="3413" >HIPER USERA-GILARRANZ</option><option value="3414" >HIPERCOR</option><option value="23499" >HISPANIA RETAIL PROPERTIES</option><option value="23036" >HISPANIA SOCIMI</option><option value="26570" >HISPAVIMA</option><option value="19685" >HM HOSPITALES</option><option value="10120" >HM HOTELS</option><option value="25318" >HNA HOTEL GROUP</option><option value="23815" >HO BEE LAND</option><option value="11952" >HOGALIA</option><option value="21095" >HOLDINGS HIGHGATE</option><option value="27185" >HOME INVEST</option><option value="25218" >HOMESTEAD</option><option value="25999" >HONGKONG & SHANGHAI HOTELS</option><option value="24575" >HOPOSA HOTELS</option><option value="28136" >HORACIO HIDALGO</option><option value="28010" >HORMICONSA</option><option value="25194" >HORTENSIA HERRERO</option><option value="26366" >HOSPITALES IMED</option><option value="17684" >HOST HOTELS</option><option value="27752" >HOSTELBO</option><option value="24955" >HOTEL INVESTMENTS PARTNERSHIP</option><option value="427" >HOTELES CATALONIA</option><option value="25870" >HOTELES DE PALMA</option><option value="25254" >HOTELES DEL QUEILES</option><option value="10375" >HOTELES GARGALLO</option><option value="6339" >HOTELES GLOBALES</option><option value="25864" >HOTELES RIO AZOR</option><option value="430" >HOTELES SANTOS</option><option value="20018" >HOTELES SERVIGROUP</option><option value="8103" >HOTUSA</option><option value="25603" >HS GROUP</option><option value="20686" >HSBC ALTERNATIVE INVESTMENTS LIMITED</option><option value="27781" >HSBC REIM</option><option value="19542" >HUNTER PROPERTY FUND MANAGEMENT</option><option value="25217" >HYPROP</option><option value="27164" >HYUNDAI INVESTMENT ASSET MANAGEMENT</option><option value="24275" >IACSA</option><option value="25171" >IAD</option><option value="22473" >IBA CAPITAL PARTNERS</option><option value="25576" >IBEMETEX</option><option value="25786" >IBERBRO</option><option value="1632" >IBERDROLA INMOBILIARIA</option><option value="24330" >IBEREBRO</option><option value="25319" >IBERFINCAPITAL</option><option value="7154" >IBERFINDIM</option><option value="26126" >IBERIA COOP</option><option value="27626" >IBERIAN CAPITAL CORPORATION</option><option value="23604" >IBERIAN SHOPPING CENTRES HOLDING</option><option value="6995" >IBERINVE</option><option value="3473" >IBERMUTUAMUR</option><option value="28377" >Ibero Capital Management </option><option value="3298" >IBEROSTAR</option><option value="27100" >IC IMMOBILIEN </option><option value="14104" >ICADE</option><option value="27628" >ICC</option><option value="10681" >ICYESA</option><option value="14481" >IDL</option><option value="22728" >IFR</option><option value="10817" >IGD</option><option value="23694" >IGIS ASSET MANAGEMENT</option><option value="25499" >IKANO</option><option value="3490" >IKEA</option><option value="26980" >IKOS RESORTS</option><option value="18321" >ILG FONDS</option><option value="3491" >ILITURGITANA DE HIPERMERCADOS</option><option value="24996" >ILMARINEN</option><option value="24343" >ILUNION GROUP</option><option value="23385" >ILUTURGITANA DE HIPERMERCADOS</option><option value="23034" >IM PROPERTIES</option><option value="22606" >IMMOBILIEN EUROPA DIREKT</option><option value="18847" >IMMOBILIERE DASSAULT</option><option value="13844" >IMMOFINANZ</option><option value="16158" >IMMOVALOR</option><option value="21088" >IMOCOMPARTNERS</option><option value="27636" >IMPAR</option><option value="3496" >IMPORTACO</option><option value="11290" >INASTAR</option><option value="23442" >INBARINTER</option><option value="450" >INBISA</option><option value="22013" >INCUS CAPITAL</option><option value="12100" >INDICESA</option><option value="24317" >INDICESA L'ILLA</option><option value="26727" >INDIGO CAPITAL</option><option value="25976" >INDIGO INVEST</option><option value="26614" >INDIGO PARKING</option><option value="3508" >INDITEX</option><option value="28326" >INDUSTRIAL FACILITIES SAGUNTO</option><option value="3525" >INDUSTRIAS CARNICAS LORIENTE PIQUERAS</option><option value="25965" >INDUSTRIENS PENSION</option><option value="19916" >INFINEON TECNOLOGY</option><option value="51" >INFINORSA</option><option value="568" >INFOINVEST</option><option value="19526" >INFRARED CAPITAL PARTNERS</option><option value="15595" >ING BANK </option><option value="13955" >ING INSURANCE</option><option value="10732" >ING INVESTMENT MANAGEMENT</option><option value="24259" >INGENIERIA ENCOFRADOS Y SERVICIOS</option><option value="27632" >INGOMAR</option><option value="26346" >INLET</option><option value="27228" >INLET PACK</option><option value="9244" >INMARK</option><option value="28366" >Inmark Asset Management</option><option value="28230" >INMOBEL</option><option value="3568" >INMOBILIARIA ALCAZAR</option><option value="10070" >INMOBILIARIA ALHAMBRA</option><option value="28226" >INMOBILIARIA ALTABIX</option><option value="8985" >INMOBILIARIA BETANCOR</option><option value="23607" >INMOBILIARIA BULMES</option><option value="10607" >INMOBILIARIA CHAMARTIN</option><option value="23587" >INMOBILIARIA DE VISTAHERMOSA</option><option value="3571" >INMOBILIARIA DEL SUR</option><option value="485" >INMOBILIARIA ESPACIO</option><option value="23710" >INMOBILIARIA GONURI HARIZARTEAN</option><option value="582" >INMOBILIARIA OSUNA</option><option value="18726" >INMOBILIARIA SUSANA</option><option value="27706" >INMOCAIXA</option><option value="6115" >INMOCARAL</option><option value="26852" >INMOCHAN</option><option value="13712" >INMOLEVANTE</option><option value="591" >INMOSEGUROS</option><option value="593" >INMOUNO</option><option value="13726" >INMUEBLES BELFASA</option><option value="27993" >INMUEBLES CALCHETAS</option><option value="13731" >INOVALIS </option><option value="23086" >INSO</option><option value="25797" >INSTITUT CATALA DE RECERCA DE L'AIGUA</option><option value="25502" >INTEA</option><option value="3593" >INTEL </option><option value="21333" >INTERCENTROS BALLESOL</option><option value="6706" >INTERFAM</option><option value="23643" >INTERINVER</option><option value="14645" >INTERMEDIATE CAPITAL GROUP</option><option value="19278" >INTERNOS GLOBAL INVESTORS</option><option value="25594" >INTOWN GELEEN</option><option value="27528" >INTRUM</option><option value="18425" >INTU PROPERTIES</option><option value="23843" >INVERAVANTE</option><option value="26743" >INVERLIN</option><option value="8105" >INVERSEGUROS</option><option value="27061" >INVERSION EN PROINDIVISOS</option><option value="23724" >INVERSIONES ABUIN</option><option value="23364" >INVERSIONES AREA SUR</option><option value="27564" >INVERSIONES ASTURIANAS SL</option><option value="28081" >INVERSIONES CARNEY</option><option value="19102" >INVERSIONES DEL NOROESTE</option><option value="24225" >INVERSIONES DOALCA (SOCIMI)</option><option value="24306" >INVERSIONES GREEN ROCK</option><option value="7842" >INVERSIONES IBOSA</option><option value="23395" >INVERSIONES LAURON</option><option value="11069" >INVERSIONES MALLEO</option><option value="24207" >INVERSIONES MONTEPINO</option><option value="24880" >INVERSIONES RENTARAGON</option><option value="23361" >INVERSIONES SOCIETARIAS ALHSUR</option><option value="9585" >INVERSIONES SUBEL</option><option value="9460" >INVERSIONES SUNLITE</option><option value="27799" >INVERSIONES VEGAS ROMERO</option><option value="26316" >INVERSIONES Y PATRIMONIO CASTELLANA</option><option value="606" >INVESCO</option><option value="8707" >INVESTA ESTATE</option><option value="26395" >INVESTCORP</option><option value="14626" >INVISTA </option><option value="22345" >INVIVAS</option><option value="27592" >INYECCION DE MATERIALES TECNICOS</option><option value="13204" >IOSA INMUEBLES</option><option value="23570" >IREIT GLOBAL</option><option value="12470" >IRISH LIFE</option><option value="23667" >IRUS European Retail Property Fund</option><option value="6584" >IVANHOE CAMBRIDGE</option><option value="27253" >J&T REAL ESTATE</option><option value="25241" >JABA INVERSIONES INMOBILIARIAS (SOCIMI)</option><option value="26949" >JACKYL</option><option value="22604" >JARGONNANT PARTNERS</option><option value="26620" >JERRY O'REILLY</option><option value="19338" >JESTHISA DESARROLLOS INMOBILIARIOS</option><option value="25991" >JESUS ANTUNEZ</option><option value="24216" >JEVASO</option><option value="27361" >JOAQUIM ZAMACOIS</option><option value="27169" >JOH JOHANNSON EIENDOM</option><option value="27198" >JOIN CONTRACT</option><option value="23075" >JOINT TREASURE</option><option value="24877" >JORGE SANDOVAL</option><option value="25300" >JOSE IGNACIO RODRIGO</option><option value="25666" >JOYPAZAR</option><option value="5568" >JP MORGAN</option><option value="27343" >JR AMC</option><option value="25476" >JUAN LUIS GOMEZ-TRENOR</option><option value="9773" >JUMIN</option><option value="12889" >JUNTA DE ANDALUCIA</option><option value="13124" >JUNTA DE COMPENSACION DE PARQUE DE VALDEBEBAS (MADRID)</option><option value="27599" >KAIZER</option><option value="25865" >KALDOX</option><option value="11120" >KANAM</option><option value="24026" >KAPITAL ANLAGE GESELLSCHAFT MBH SIEMENS</option><option value="26136" >KARCHER</option><option value="22009" >KARLIN REAL ESTATE</option><option value="27621" >KARUZELA</option><option value="23217" >KATARA HOSPITALITY</option><option value="21064" >KATOEN NATIE</option><option value="19994" >KENNEDY WILSON</option><option value="26829" >KESSE INVEST</option><option value="19581" >KEYSTONE & PARTNERS</option><option value="27748" >KEYTRON</option><option value="18463" >KGAL</option><option value="21016" >KGK RAMBLAS</option><option value="64" >KIABI</option><option value="23223" >KILDARE PARTNERS</option><option value="5488" >KINEPOLIS</option><option value="22512" >KING STREET CAPITAL MANAGEMENT</option><option value="26777" >KINGBOARD INVESTMENTS</option><option value="22748" >KINTYRE INVESTMENTS</option><option value="27519" >KIWOOMAM</option><option value="28013" >KIWOON</option><option value="21748" >KKH</option><option value="21135" >KKR</option><option value="23333" >KLECAR FONCIER</option><option value="6766" >KLEPIERRE</option><option value="27501" >KLESCH</option><option value="22790" >KLOVERN</option><option value="25038" >KLP EIENDOM</option><option value="22573" >KNIGHT FRANK INVESTMENT MANAGEMENT</option><option value="22045" >KNIGHTSBRIDGE STUDENT HOUSING</option><option value="9514" >KONECTA TECNOLOGY</option><option value="27495" >KORAMCO</option><option value="25719" >KOREA POST</option><option value="20074" >KOREAN INVESTMENT CORPORATION</option><option value="27604" >KORIAN</option><option value="19767" >KRONBERG INTERNATIONAL</option><option value="24336" >KRONOS REAL ESTATE</option><option value="26178" >KRYALOS</option><option value="27804" >KTB</option><option value="2144" >LA CAIXA</option><option value="20948" >LA CANTERANA</option><option value="21138" >LA COMPAGNIE DE PHALSBOURG</option><option value="24725" >LA FRANÇAISE FORUM REAL ESTATE PARTNERS</option><option value="19886" >LA FRANÇAISE REM</option><option value="12629" >LA IGLESIA</option><option value="27797" >LA PEÑITA</option><option value="24359" >LA SADE</option><option value="7469" >LA ZAGALETA</option><option value="24175" >LABCO</option><option value="27454" >LABE ABOGADOS</option><option value="26476" >LABORATORIOS DIATER</option><option value="28080" >LABORATORIOS ENTEMA</option><option value="9136" >LABORATORIOS NORMON</option><option value="3761" >LACTEAS GARCIA BAQUERO</option><option value="25475" >LAGARDERE</option><option value="26745" >LAGUNE</option><option value="25773" >LAITH THARSON</option><option value="25897" >LALCO HOTEL GROUP</option><option value="637" >LAMPARAS OWAL</option><option value="27859" >LAND CAPITAL</option><option value="14559" >LAND SECURITIES</option><option value="18165" >LANDON INVESTMENTS</option><option value="28327" >LANNUTI</option><option value="27595" >LANZASUIZA</option><option value="23007" >LAR ESPAÑA SOCIMI</option><option value="6796" >LAR GROSVENOR</option><option value="5988" >LARMAG</option><option value="25868" >LARRAIN</option><option value="645" >LASALLE INVESTMENT MANAGEMENT</option><option value="28023" >LATEM ALUMINIUM</option><option value="649" >LAYETANA</option><option value="15329" >LAZARI</option><option value="27104" >LB ASSET MANAGEMENT</option><option value="15619" >LBBW</option><option value="22620" >LCN CAPITAL PARTNERS</option><option value="15959" >LEASINVEST</option><option value="3783" >LECLERC</option><option value="21932" >LEG IMMOBILIEN</option><option value="11497" >LEGAL & GENERAL PROPERTY</option><option value="25314" >LEOMANT INVESTMENTS</option><option value="24611" >LEONARDO HOTELS</option><option value="27289" >LERMA INVESTMENTS</option><option value="3792" >LEROY MERLIN</option><option value="17871" >L'ETOILE PROPERTIES</option><option value="3797" >LEVITT BOSCH AYMERICH</option><option value="25625" >LGT CAPITAL PARTNERS</option><option value="14999" >LHI LEASING</option><option value="23918" >LIBERBANK</option><option value="5983" >LIBERTAS 7</option><option value="27613" >LIBERTY MANAGEMENT</option><option value="658" >LICO INMUEBLES</option><option value="19711" >LIDERBANK</option><option value="659" >LIDL</option><option value="25192" >LIMESTONE INVESTORS</option><option value="27158" >LINCOLN MGT</option><option value="3812" >LINEA DIRECTA ASEGURADORA</option><option value="11228" >LINK FINANCIAL</option><option value="27190" >LION FUND MANAGEMENT</option><option value="26335" >LIONEL MESSI</option><option value="27188" >LIP INVEST</option><option value="25957" >LIVEN</option><option value="26440" >LKK</option><option value="28279" >LOCALES EMA</option><option value="27788" >LOCARE</option><option value="23239" >LOGICOR BLACKSTONE</option><option value="28368" >LOGIKA EUROPEAN PARTNERS</option><option value="28403" >LOGISTICS CAPITAL PARTNERS</option><option value="26436" >LOGITRAVEL</option><option value="25869" >Loiola Gestion Inmobiliaria </option><option value="17022" >LONDON & REGIONAL PROPERTIES</option><option value="21689" >LONDONMETRIC PROPERTY</option><option value="20344" >LONE STAR</option><option value="24054" >LORETO MUTUA</option><option value="22064" >LOTHBURY INVESTMENT MANAGEMENT</option><option value="9908" >LSGIE</option><option value="1055" >LUALCA INMOBILIARIA</option><option value="5720" >LUBASA</option><option value="23654" >LUGO RETAIL GALLERY</option><option value="12430" >LURESA</option><option value="21332" >LUVALOR</option><option value="28421" >LUWIN REAL ESTATE MANAGERS</option><option value="3844" >LUXOTTICA </option><option value="25886" >LYSHA</option><option value="26049" >M AUTOMOCION</option><option value="8296" >M&G REAL ESTATE</option><option value="24411" >M&L HOSPITALITY</option><option value="25547" >M.S. TRADING ESPAÑA</option><option value="22488" >M7 REAL ESTATE</option><option value="25583" >MABEL RE</option><option value="25741" >MACIA HOTELES</option><option value="28365" >MACIFIMO</option><option value="26979" >MACKINTOSH MALL</option><option value="13707" >MACQUARIE</option><option value="25049" >MACSA</option><option value="22546" >MADISON INTERNATIONAL REALTY</option><option value="25572" >MAGNIFICENT HOTEL INVESTMENTS</option><option value="682" >MAHOU SAN MIGUEL</option><option value="3873" >MAKRO</option><option value="25705" >MALCER INMUEBLES</option><option value="28059" >MAN TRUCK & BUS / EUROCAM</option><option value="12929" >MANDARIN ORIENTAL HOTEL GROUP</option><option value="24482" >MANEL ADELL</option><option value="686" >MANGO</option><option value="23591" >MANILEX AVILA</option><option value="25074" >MANSOUR AL NAHYAN</option><option value="28458" >MANUEL COSME</option><option value="5901" >MANUFACTURAS BALMES VIVES</option><option value="2556" >MAPFRE</option><option value="8739" >MAPFRE INMUEBLES</option><option value="16844" >MAPFRE SALUD</option><option value="3903" >MAPFRE VIDA</option><option value="25472" >MAPLETREE</option><option value="28162" >MAQ ADMINISTRACION URBANAS</option><option value="23001" >MARATHON ASSET MANAGEMENT</option><option value="28383" >MARAVILLAS 1882</option><option value="16471" >MARCO ALDANY</option><option value="24602" >MARCONFORT</option><option value="26959" >MARESYTEREY</option><option value="7187" >MARINA PLAZA 2000</option><option value="26653" >MARKWINS</option><option value="26403" >MARLOLAN</option><option value="8457" >MARQUES DE COMILLAS</option><option value="18314" >MARSET</option><option value="24858" >MARTELL INVESTMENTS</option><option value="25913" >MAS REAL ESTATE</option><option value="16998" >MASSENA CAPITAL PARTNERS</option><option value="27977" >MASTERN INVESTMENT MANAGEMENT</option><option value="27379" >MATA CAPITAL</option><option value="24668" >MATCH POINT NAVARRA</option><option value="26290" >MAUTOMOCION</option><option value="5645" >MAX MARA</option><option value="27004" >MAXIMUS VENTURES</option><option value="20243" >MAYDON INVERSIONES</option><option value="23681" >MAYFAIR CAPITAL</option><option value="23853" >MAYOR 90</option><option value="17979" >MAZABI </option><option value="12848" >MCARTHURGLEN</option><option value="69" >MCDONALDS</option><option value="18505" >MDR INVERSIONES</option><option value="24646" >MDSR INVESTMENTS</option><option value="26675" >MEADOW PARTNERS</option><option value="6540" >MEAG</option><option value="11947" >MECARIO LLORENTE</option><option value="27460" >MEDCAP REAL ESTATE</option><option value="17676" >MEDCAPITAL</option><option value="23777" >MEDICAL PROPERTIES TRUST</option><option value="26365" >MEDICOS SIN FRONTERAS</option><option value="26204" >MEDITERRANEAN CAPITAL</option><option value="23426" >MEGAOCIO</option><option value="1356" >MELIA</option><option value="3967" >MERCADONA</option><option value="23558" >MERCANTIL DE OBRAS Y VIVIENDAS DE TENERIFE</option><option value="7293" >MERCAPITAL</option><option value="7740" >MERCASA</option><option value="15863" >MERIDIA CAPITAL</option><option value="23389" >MERIDIONAL DE INVERSIONES</option><option value="27879" >MERITZ FINANCIAL GROUP</option><option value="23057" >MERLIN PROPERTIES SOCIMI</option><option value="28206" >MEROPE</option><option value="26651" >METAUTO MOTOR</option><option value="24428" >METEOLOGICA</option><option value="23590" >METEORE ALCALA</option><option value="14776" >METRO BALTIC HORIZONS</option><option value="17210" >METROINVEST</option><option value="704" >METROPOLIS</option><option value="3989" >METROPOLIS CIA. NAL. DE SEGUROS Y REASEGUROS</option><option value="706" >METROVACESA</option><option value="17138" >MEYER BERGMAN</option><option value="27682" >MGI</option><option value="25045" >MGM MUTHU HOTELS</option><option value="7699" >MGS</option><option value="26619" >MHL</option><option value="10010" >MIBANSA</option><option value="25183" >MIDSTAR</option><option value="27985" >MIFARMA</option><option value="4004" >MIGUELEZ</option><option value="22037" >MILLENIUM HOTELS INVESTORS</option><option value="25792" >MIM</option><option value="12879" >MINISTERIO DE FOMENTO</option><option value="23393" >MINISTERIO DE HACIENDA</option><option value="6225" >MINISTERIO DE TRABAJO Y ASUNTOS SOCIALES</option><option value="27970" >MIRATRES</option><option value="2905" >MIRO</option><option value="24636" >MISHTE GROUP</option><option value="27163" >MISIONEROS COMBONIANOS</option><option value="26591" >MITELOS</option><option value="24585" >MITISKA</option><option value="14860" >MITSUBISHI ESTATES</option><option value="27178" >MITTELDEUTSCHE RUNDFUNK (MDR)</option><option value="24966" >MIXTA</option><option value="25100" >MIXTO</option><option value="25845" >MK MADISON</option><option value="26269" >MK PREMIUM</option><option value="26406" >MK2</option><option value="22673" >MO DUSSELDORF IMMERMANNSTRASSE GMBH & CO KG</option><option value="26048" >MOHARI LIMITED</option><option value="23769" >MOMENI</option><option value="27543" >MONARCH ALTERNATIVE CAPITAL</option><option value="13215" >MONTEBALITO</option><option value="11169" >MONTHISA</option><option value="4040" >MONTORO E HIJOS</option><option value="28241" >MOONLAKE CAPITAL</option><option value="23711" >MOREA INVERSIONES</option><option value="27181" >MOREGA PREMIUM</option><option value="19233" >MORGAN STANLEY</option><option value="722" >MORGAN STANLEY REAL ESTATE</option><option value="12632" >MORILLAS BRAND DESIGN</option><option value="4042" >MOSTOLES INDUSTRIAL</option><option value="4046" >MOTORPRESS IBERICA</option><option value="25363" >MOUNTPARK</option><option value="25617" >MPA NEWDAY</option><option value="26945" >MUEBLES LA ABADIA</option><option value="7164" >MUEBLES LA FABRICA</option><option value="23454" >MULTICINES ATLANTIDA LANZAROTE</option><option value="23628" >MULTICINES LA ESTACION (LA DEHESA)</option><option value="24888" >MULTIPROPIEDAD</option><option value="25513" >MUNICH INVESTMENT MANAGER COMPETO CAPITAL PARTNERS</option><option value="2463" >MURIAS</option><option value="728" >MUSAAT</option><option value="8576" >MUTUA DE PROPIETARIS</option><option value="4067" >MUTUA MADRILEÑA </option><option value="20429" >MUTUAL MEDICA DE CATALUNYA I BALEARS</option><option value="4074" >MUTUALIDAD DE ABOGACIA</option><option value="25299" >MUTUALIDAD DE PREVISION SOCIAL DE LOS PROCURADORES DE LOS TRIBUNALES DE ESPAÑA</option><option value="26006" >MYKOMUNA</option><option value="26147" >MYR</option><option value="0" >N/D</option><option value="24499" >NADLAN BCN</option><option value="25501" >NADLER HOTELS</option><option value="23678" >NAN FUNG GROUP</option><option value="27814" >NARCISO BARCELO</option><option value="14530" >NAROPA PROPERTIES</option><option value="25542" >NARVAEZ 34</option><option value="25564" >NAS INVEST</option><option value="28237" >NASUVINSA</option><option value="27686" >NATIONAL BANK OF KUWAIT</option><option value="26068" >NATIONAL GRID PENSION FUND</option><option value="14929" >NATIXIS</option><option value="12789" >NATURA</option><option value="735" >NAVES Y URBANAS ANDALUCIA</option><option value="21539" >NAVISA</option><option value="28395" >NBK CAPITAL</option><option value="6423" >NCH</option><option value="6149" >NECSA</option><option value="7344" >NECSO INMOBILIARIA</option><option value="26328" >NEGUS JARDINES</option><option value="739" >NEINVER</option><option value="26446" >NEO CAPITAL</option><option value="26621" >NEPI ROCKCASTLE</option><option value="26339" >NEVERDAL</option><option value="20146" >NEW EUROPE PROPERTY INVESTMENTS</option><option value="21491" >NEW WINDS GROUP</option><option value="18494" >NEWRIVER RETAIL</option><option value="5467" >NEXITY</option><option value="27805" >NEXO RESIDENCIAS / HARRISON STREET</option><option value="13386" >NIAM</option><option value="27585" >NIDOM</option><option value="28319" >NIELS PAGH LOGISTICS</option><option value="20652" >NIEVA BEIERSDORF</option><option value="28200" >NITSBA</option><option value="8058" >NORAPEX</option><option value="24493" >NORAT</option><option value="16225" >NORDIC REAL ESTATE PARTNERS</option><option value="12885" >NORFIN</option><option value="18995" >NORGES BANK INVESTMENT MANAGEMENT</option><option value="27069" >NORGES BANK REAL ESTATE MANAGEMENT</option><option value="24124" >NORTHERN HORIZON CAPITAL</option><option value="24011" >NORTHSTAR REALTY FINANCE</option><option value="22385" >NORTHWOOD INVESTORS</option><option value="24874" >NOTARIA DE DON CARLOS DEL MORAL CARRO</option><option value="27998" >NOU CENTRE EL MASNOU</option><option value="27649" >NOU MEDITERRANI</option><option value="27498" >NOVALLORET</option><option value="762" >NOZAR</option><option value="24392" >NOZUL HOTELS & RESORTS</option><option value="22470" >NSI</option><option value="27346" >NUBIAN PROPERTIES</option><option value="24750" >NUEVA COFISA</option><option value="766" >NUÑEZ Y NAVARRO</option><option value="6108" >Nuveen Real Estate</option><option value="12092" >NYESA</option><option value="26609" >OAK HILL ADVISORS</option><option value="20386" >OAKTREE CAPITAL </option><option value="4155" >OCASO</option><option value="28311" >OCIBAR</option><option value="27689" >OCTAGON S2</option><option value="24590" >OD GROUP</option><option value="26774" >OD HOTELS</option><option value="2820" >ODEON</option><option value="27197" >OFFICE MADRID</option><option value="5283" >OHL</option><option value="27455" >OJIREL</option><option value="25828" >OLAV THON</option><option value="22778" >OLAYAN</option><option value="5586" >OLIVETTI LEXICOM ESPAÑA</option><option value="23876" >OLOZAGA RESIDENCIAL</option><option value="17532" >OMAN INVESTMENT FUND</option><option value="7290" >OMEGA CAPITAL</option><option value="23674" >OMICRON PLUS REALTY</option><option value="25752" >ONAHOTELS</option><option value="4181" >ONCE</option><option value="21526" >O'NEILL</option><option value="24765" >ONIKU</option><option value="26695" >ONIX CAPITAL PARTNERS</option><option value="26905" >OPTIMA GLOBAL</option><option value="25352" >OPTIMUM RE SOCIMI</option><option value="24723" >ORANGE CAPITAL PARTNERS</option><option value="17354" >ORCHARD STREET INVESTMENT MANAGEMENT</option><option value="14269" >ORDISA</option><option value="26157" >ORES SOCIMI</option><option value="27997" >ORGANIZACION MARTINEZ</option><option value="8817" >ORION CAPITAL</option><option value="26177" >OTP PRIME</option><option value="27966" >OW GLOBAL</option><option value="23774" >OXENWOOD REAL ESTATE</option><option value="19506" >OXFORD PROPERTIES</option><option value="22719" >OXYGEN ASSET MANAGEMENT</option><option value="24120" >P3 LOGISTIC PARKS</option><option value="27992" >PACIFIC EAGLE</option><option value="23585" >PADIEL XXI</option><option value="22300" >PALLADIUM HOTEL GROUP</option><option value="26939" >PALM CAPITAL</option><option value="17194" >PALMER CAPITAL PARTNERS</option><option value="4203" >PAMPLONA DISTRIBUCION</option><option value="15920" >PANATTONI </option><option value="16123" >PANDION REAL ESTATE</option><option value="18869" >PANDOX</option><option value="25189" >PARACUGA</option><option value="27504" >PAREF GESTION</option><option value="27558" >PARETO SECURITIES</option><option value="6735" >PARJE</option><option value="23712" >PARQUE COMERCIAL ECHABARRI-VIÑA</option><option value="19684" >PARQUE MEDITERRANEO</option><option value="23397" >PARQUE MIRAMAR</option><option value="23424" >PARQUE SJ</option><option value="28490" >PARQUE TECNOLOGICO DE ANDALUCIA</option><option value="21287" >PARQUES INDUSTRIALES GRAN EUROPA</option><option value="782" >PARQUESOL</option><option value="5298" >PARTICULAR</option><option value="13266" >PARTIDO POPULAR</option><option value="16669" >PARTIDO SOCIALISTA</option><option value="22578" >PARTNERS GROUP</option><option value="27509" >PAT CREAN & PARTNERS</option><option value="27593" >PATATAS HIJOLUSA</option><option value="23863" >PATRIMONIOS INDUSTRIALES ARROYO</option><option value="24485" >PATRIMONIUM</option><option value="10813" >PATRIRENT</option><option value="17683" >PATRIZIA</option><option value="6920" >PATRON CAPITAL PARTNERS</option><option value="4232" >PAVASAL</option><option value="24335" >PDI</option><option value="17887" >PEACH PROPERTY GROUP</option><option value="19523" >PEAKSIDE CAPITAL</option><option value="25172" >PEDRO CHAPOTE</option><option value="21822" >PEDRO TRAPOTE</option><option value="19045" >PEEL GROUP</option><option value="27572" >PELAYO CAPITAL</option><option value="4243" >PELAYO MUTUA DE SEGUROS</option><option value="27580" >PEMBREY</option><option value="20342" >PENSAM</option><option value="22699" >PENSIONDANMARK</option><option value="23634" >PENTA KOLA BUSINESS</option><option value="18911" >PERELLA WEINBERG</option><option value="27258" >PERFUMERIAS AVENIDA</option><option value="22526" >PERIAL ASSET MANAGEMENT</option><option value="20229" >PERMODALAN NASIONAL BERHAD</option><option value="24324" >PERMOSA EXPLOTACIONES HOTELERAS</option><option value="28194" >PESCADOS LA ASTORGANA</option><option value="5907" >PESTANA HOTELS & RESORTS</option><option value="26330" >PETER SHARE INVESTMENTS</option><option value="25987" >PETERSON GROUP</option><option value="9945" >PETRUS</option><option value="20341" >PFA PENSION</option><option value="4269" >PFIZER</option><option value="6632" >PGGM</option><option value="25591" >PGIM REAL ESTATE</option><option value="21165" >PHI INDUSTRIAL</option><option value="4271" >PHILIP MORRIS</option><option value="25311" >PHN</option><option value="25091" >PHOENIX</option><option value="27573" >PHYSICIANS FUND LOWER SAXONY / SAXONY-ANHALT / MECKLENBURG-WESTERN-POMERANIA / VETINARY FUND OF LOWE</option><option value="28051" >PICTET</option><option value="5222" >PIERRE & VACANCES</option><option value="26951" >PIERRE PLUS SCPI ACTIVOS COMERCIALES</option><option value="21499" >PIMCO</option><option value="27458" >PINTURAS MOLTO</option><option value="11013" >PITCH PROMOTION</option><option value="10272" >PKU</option><option value="10971" >PLANIGER</option><option value="26372" >PLASTICOSUR</option><option value="22854" >PLATINUM ESTATES</option><option value="22569" >PLATZER</option><option value="18201" >PLENIUM PARTNERS</option><option value="20394" >PLP HOLDING</option><option value="4304" >PLUS ULTRA</option><option value="27828" >PODEMOS</option><option value="7475" >POLAR INMUEBLES</option><option value="25847" >POLYNUX</option><option value="7103" >PONTEGADEA INMOBILIARIA</option><option value="4315" >PORCELANOSA</option><option value="25098" >PORT</option><option value="24091" >PORTO DOLC</option><option value="25407" >PORTUS RETAIL</option><option value="25078" >POSEIDON DE BENIDORM</option><option value="27654" >POSTE VITA</option><option value="24458" >POSTUA</option><option value="27457" >POWER ELECTRONICS</option><option value="25023" >POYATOS EXPORT</option><option value="8166" >PRADA</option><option value="5567" >PRADERA</option><option value="25780" >PRAKITK</option><option value="12399" >PRAMERICA REAL ESTATE INVESTORS</option><option value="531" >PRASA</option><option value="23658" >PRAZADOURO</option><option value="18213" >PREMAAT</option><option value="26993" >PREMICO</option><option value="18455" >PREMIER INN</option><option value="4340" >PREVISION SANITARIA NACIONAL SOCIMI</option><option value="75" >PRIMA INMOBILIARIA</option><option value="12336" >PRIMARK</option><option value="25914" >PRIME KAPITAL</option><option value="20051" >PRIMONIAL REIM</option><option value="25592" >PRIMOTEL</option><option value="12484" >PRINCETON INVESTMENTS</option><option value="8382" >PRINCIPADO DE ASTURIAS</option><option value="17163" >PRINCIPAL GLOBAL INVESTORS</option><option value="17148" >PRINCIPAL REAL ESTATE INVESTORS</option><option value="76" >PROCISA</option><option value="27195" >PRODIEL</option><option value="14101" >PROEMIO</option><option value="9678" >PROFUSA</option><option value="834" >PROLOGIS</option><option value="6855" >PROMAMOF</option><option value="23650" >PROMOCION DE SUELOS Y SUPERFICIES</option><option value="23459" >PROMOCIONES FARO</option><option value="23041" >PROMOCIONES HOTELERAS</option><option value="26197" >PROMOCIONES TIOIRA</option><option value="24846" >PROMOCIONES TURISTICAS CALA MILLOR</option><option value="28308" >PROMOIMSA</option><option value="23278" >PROPRIUM CAPITAL PARTNERS</option><option value="27200" >PROTERME</option><option value="26432" >PROXIMUS REAL ESTATE</option><option value="28422" >PROYECTOS E INVERSIONES BINAH</option><option value="9082" >PRYCONSA</option><option value="27908" >PRYGESA</option><option value="22023" >PSP INVESTMENTS</option><option value="23373" >PUBLITY</option><option value="26382" >PUCHAL</option><option value="23339" >PUENTE GENIL RETAIL ASSETS SL</option><option value="23743" >PUERTO CALERO MARINAS</option><option value="23457" >PUERTO CIUDAD DE LAS PALMAS</option><option value="4399" >PULLMANTUR</option><option value="27597" >PULSAR IBERIA LOGISTICS</option><option value="25946" >PUNTA NA</option><option value="27470" >PYGMALION CAPITAL ADVISERS</option><option value="26093" >PYRAMID SHANGHAI</option><option value="26990" >Q PRIME</option><option value="17376" >QATAR INVESTMENT AUTHORITY</option><option value="14647" >QATARI DIAR </option><option value="6295" >QUABIT</option><option value="25764" >QUADORO REAL ESTATE</option><option value="27491" >QUADREAL</option><option value="26209" >QUAERO</option><option value="28380" >QUALISERVEI 2006 / GUIVERNAU</option><option value="24615" >QUANTUM CAPITAL PARTNERS</option><option value="16454" >QUANTUM IMMOBILIEN</option><option value="18780" >QUEENSWAY PROPERTIES</option><option value="26433" >QUEST INVESTMENT PARTNERS</option><option value="26375" >QUILVEST</option><option value="26426" >QUINCAP</option><option value="3295" >QUIRON SALUD</option><option value="25604" >QUONIA SOCIMI</option><option value="26187" >R&F PROPERTIES</option><option value="27135" >R+V VERSICHERUNG</option><option value="5605" >RAFAEL HOTELES</option><option value="24729" >RAFAEL LUQUE</option><option value="28441" >RAMPHASTOS REAL ESTATE</option><option value="26173" >RAMSTEDT HOLDING</option><option value="26812" >RASMALA</option><option value="6282" >RATISBONA</option><option value="18761" >RCP GROUP</option><option value="28409" >REAL AUTOMOVIL CLUB DE CATALUNYA</option><option value="23589" >REAL DE OLIAS</option><option value="6777" >REAL IS</option><option value="4443" >REALE SEGUROS GENERALES</option><option value="5292" >REALIA</option><option value="20333" >REALSTAR</option><option value="28439" >REALTERM</option><option value="28189" >RECABA INVERSIONES TURISTICAS</option><option value="24951" >RECAMBIOS MARINOS</option><option value="4446" >RECREATIVOS FRANCO</option><option value="23360" >RED AREAS PARQUE</option><option value="9922" >RED.ES</option><option value="19489" >REDEFINE</option><option value="6504" >REDEVCO</option><option value="16786" >REDOS REAL ESTATE</option><option value="26163" >REDSTONE REAL ESTATE</option><option value="24876" >REFORMA DE PISOS</option><option value="27923" >REGATO</option><option value="26650" >REGENERO</option><option value="19747" >REGENT STREET PARTNERSHIP</option><option value="26504" >REICO</option><option value="22953" >REIß & CO. REAL ESTATE MUNCHEN</option><option value="26657" >RELAIS TERMAL</option><option value="25906" >RELAXIA RESORTS</option><option value="6500" >REMVISION</option><option value="26992" >RENGER INVESTMENT MANAGEMENT</option><option value="24628" >RENT PROFIT</option><option value="870" >RENTA CORPORACION</option><option value="9939" >RENTAMAR</option><option value="7496" >RENTAURO</option><option value="8732" >RENTUR</option><option value="4484" >REPSOL</option><option value="6934" >RESA</option><option value="26145" >RESILIENT</option><option value="7507" >RESOLUTION PROPERTY</option><option value="17579" >RESOURCE CAPITAL PARTNERS</option><option value="18728" >RETAIL ESTATES</option><option value="20329" >RETAIL PROPERTY FUND</option><option value="28477" >RETAIN PROSPER LIMITED</option><option value="17424" >RETORTA INMOBILIARIA</option><option value="16980" >REVCAP</option><option value="26801" >REVETAS</option><option value="2468" >REYAL</option><option value="14888" >REYAL URBIS</option><option value="17607" >REYZA 2006</option><option value="23735" >RFR GROUP</option><option value="12762" >RFR HOLDING</option><option value="27066" >RGA RURAL VIDA</option><option value="24240" >RGA SEGUROS</option><option value="26671" >RH HOTELES</option><option value="28001" >RIBELLES</option><option value="11576" >RIBERA DEL PISUERGA</option><option value="19378" >RICHEMONT</option><option value="28196" >RIFAAT AL ASSAD</option><option value="15718" >RIGEL 2005</option><option value="20037" >RILAFE</option><option value="885" >RIOFISA</option><option value="4499" >RIU</option><option value="25927" >RIVERVIAL</option><option value="26536" >RJB GROUP OF COMPANIES</option><option value="26052" >RLI INVESTORS</option><option value="23337" >ROC HOTELES</option><option value="16900" >ROCK CAPITAL</option><option value="24236" >ROCKCASTLE</option><option value="27235" >RODAMIENTOS Y SERVICIOS</option><option value="25877" >ROEBUCK ASSET MANAGEMENT</option><option value="27116" >ROSA ESTEVA</option><option value="26501" >ROSETTE MERCHANT BANK</option><option value="15983" >ROSP CORUNNA </option><option value="22602" >ROUND HILL CAPITAL</option><option value="27999" >ROVI</option><option value="17993" >ROYAL LONDON ASSET MANAGEMENT</option><option value="890" >ROYAL METROPOLITAN</option><option value="6464" >ROYAL PREMIER</option><option value="23635" >RPPSE USURBIL</option><option value="2865" >RTVE</option><option value="27774" >RYA RESIDENCIAS</option><option value="24720" >RYNDA PROPERTY INVESTORS</option><option value="15283" >S.A. PROMOCION Y EDICIONES</option><option value="16801" >S+B GRUPPE</option><option value="2120" >SA NOSTRA</option><option value="18482" >SABA</option><option value="894" >SACRESA</option><option value="20398" >SAFRA GROUP</option><option value="23781" >SAINT CROIX SOCIMI</option><option value="27360" >SALAMANDRA LIMITED</option><option value="26861" >SALETA CARE</option><option value="26592" >SALOMON 1992</option><option value="5656" >SALSA PATRIMONIO</option><option value="25007" >SALTOKI</option><option value="21444" >SAMBIL</option><option value="25801" >SAMHÄLLSBYGGNADSBOLLAGET</option><option value="26065" >SAMPENSION</option><option value="22133" >SAMSUNG ASSET MANAGEMENT</option><option value="23689" >SANCHEZ ROMERO INMOBILIARIA</option><option value="898" >SANITAS</option><option value="24778" >SANT JORDI 2000</option><option value="23583" >SANTA CRUZ SIGLO XXI</option><option value="4561" >SANTA LUCIA</option><option value="9301" >SANTANDER BANIF INMOBILIARIO</option><option value="5884" >SANTANDER REAL ESTATE</option><option value="28047" >SAPHIR</option><option value="24875" >SARASOLA</option><option value="21250" >SAREB</option><option value="17735" >SATO</option><option value="22656" >SAVANNA REAL ESTATE</option><option value="11555" >Savills Investment Management</option><option value="10758" >SB HOTELS</option><option value="4576" >SCANIA HISPANIA</option><option value="25553" >SCHAUINSLAND-REISEN</option><option value="14938" >SCHRODER PROPERTY INVESTMENT</option><option value="24571" >SCHRODER REAL ESTATE </option><option value="20399" >SCHRODER REAL ESTATE INVESTMENT</option><option value="27076" >SEAFORTH LAND</option><option value="22827" >SECTIE5 INVESTMENTS</option><option value="27380" >SEDCO CAPITAL</option><option value="14610" >SEGRO</option><option value="25538" >SEGRO EUROPEAN LOGISTICS PARTNERSHIP</option><option value="18544" >SEGURCAIXA ADESLAS</option><option value="913" >SEGURFONDO INVERSION</option><option value="27452" >SELENTA</option><option value="25663" >SEMAF</option><option value="4607" >SEMARK AC GROUP</option><option value="8174" >SENATOR HOTELS</option><option value="27605" >SENIORS</option><option value="7684" >SEPI</option><option value="5262" >SERCOTEL</option><option value="28282" >SERNEKE GROUP</option><option value="24163" >SERVATUR</option><option value="25312" >SERVICIOS Y DESARROLLOS TURISTICOS</option><option value="9496" >SERVIHABITAT</option><option value="25102" >SES SPAR EUROPEAN SHOPPING CENTERS</option><option value="4621" >SEUR</option><option value="26624" >SEVA</option><option value="14218" >SHAFTESBURY</option><option value="25767" >SHAFTSBURY ASSET MANAGEMENT</option><option value="28258" >SHEIKH HAMAD BIN JASSIM AL THANI</option><option value="25349" >SHEIKH MANSOUR BIN SAYED</option><option value="25115" >SHELBORN ASSET MANAGEMENT</option><option value="27535" >SHINHAN</option><option value="26820" >SHROPSHIRE COUNCIL</option><option value="23571" >SHYAM ASWANI</option><option value="13325" >SIAM</option><option value="27808" >SIAMESE DREAM</option><option value="924" >SIEMENS</option><option value="25863" >SIGLA</option><option value="15583" >SIGNA PROPERTY</option><option value="18704" >SIGNA PROPERTY FUNDS</option><option value="26150" >SIGNAL CAPITAL</option><option value="24340" >SIGNITURE CAPITAL</option><option value="26767" >SILICIUS SOCIMI</option><option value="929" >SILKEN</option><option value="25777" >SIMAYKA</option><option value="4647" >SIMON</option><option value="23334" >SIRIGIYA INVERSIONES SL</option><option value="24010" >SIRIUS REAL ESTATE</option><option value="25055" >SISTEMA CAPITAL PARTNERS</option><option value="21758" >SJM HOLDING</option><option value="8254" >SKANDIA</option><option value="15512" >SKIPPER CAPITAL</option><option value="25775" >SLATE ASSET MANAGEMENT</option><option value="27896" >SMART HOST</option><option value="11589" >SOANE INMOBILIARIA</option><option value="23649" >SOCIEDAD DE FOMENTO Y DESARROLLO TURISTICO</option><option value="23704" >SOCIEDAD INDUSTRIAL CARTAGENERA DE DESARROLLO</option><option value="23718" >SOCIEDAD MIXTA MERCADO DE SAN MARTIN</option><option value="15327" >SOCIETE DE LA TOUR EIFFEL</option><option value="10372" >SOCIETE FONCIERE LYONNAISE</option><option value="4711" >SOCIETE GENERALE</option><option value="26643" >SOCIOS DEL CLUB GOLF VALDERRAMA</option><option value="19453" >SOFIDY</option><option value="12264" >SOFINSA</option><option value="19718" >SOGECAP</option><option value="23625" >SOGESTIN</option><option value="28126" >SOHO BOUTIQUE HOTELS</option><option value="25772" >SOHO HOUSE</option><option value="23431" >SOLCAMPO</option><option value="23960" >SOLSTRA CAPITAL PARTNERS</option><option value="26600" >SOLUCIONES REUNIDAS</option><option value="17243" >SOLVIA</option><option value="25540" >SOM HOTELS</option><option value="941" >SONAE SIERRA</option><option value="10297" >SOPRA</option><option value="4735" >SORIGUE</option><option value="9148" >SORLI DISCAU</option><option value="944" >SOTOHENAR</option><option value="25985" >SOVEREIGN CENTROS</option><option value="26184" >SPARINVEST PROPERTY INVESTORS</option><option value="26808" >SPEAR STREET CAPITAL</option><option value="28386" >SPEARVEST</option><option value="25918" >SPECIALFASTIGHETER</option><option value="14788" >SPONDA</option><option value="27461" >SPORT CAPITAL PARTNERS</option><option value="23378" >SPORTS DIRECT</option><option value="10374" >SPP</option><option value="26796" >SPRING HOTELS</option><option value="7238" >SPRINTER </option><option value="23907" >SQUIRCLE CAPITAL</option><option value="26384" >SRLEV</option><option value="11158" >STAM EUROPE</option><option value="27959" >STAMFORD LAND CORPORATION</option><option value="949" >STANDARD LIFE INVESTMENTS</option><option value="27311" >STAPLES SOLUTIONS</option><option value="10223" >STARBOARD</option><option value="24282" >STARCO INVEST</option><option value="951" >STARWOOD CAPITAL</option><option value="26423" >STOFORD DEVELOPMENTS</option><option value="26999" >STONESHIELD CAPITAL</option><option value="25224" >STONEWEG</option><option value="18164" >STRABAG REAL ESTATE</option><option value="28065" >STRATEGIC INDUSTRIAL REAL ESTATE</option><option value="26369" >STREAM FIELD INVESTMENTS</option><option value="27242" >STRONGTERRA</option><option value="26547" >STUDENT PROPERTIES SPAIN</option><option value="6845" >SUDEUROPA</option><option value="16481" >SUMMIT GERMANY</option><option value="10579" >SUPERCO</option><option value="5249" >SUPERCOR</option><option value="26537" >SUPERMARKET INCOME REIT</option><option value="19560" >SUPERMERCADOS HIPERBER</option><option value="4784" >SUPERMERCADOS MARCIAL</option><option value="1381" >SUPERMERCADOS SABECO</option><option value="4788" >SUPERMERCADOS SANCHEZ ROMERO</option><option value="28466" >SVAN ELECTRO</option><option value="19306" >SVEAFASTIGHETER</option><option value="25731" >SVEITSI KIINTEISTORAHASTO</option><option value="24007" >SVP GLOBAL</option><option value="4795" >SWISS LIFE</option><option value="23595" >SWISS LIFE REIM </option><option value="24532" >SWISS PARTNERS GROUP</option><option value="27199" >SWISS PRIME SITE</option><option value="7309" >SWISS RE</option><option value="18695" >TAKEDA</option><option value="27511" >TALISMAN CAPITAL</option><option value="23669" >TALUS REAL ESTATE</option><option value="26915" >TANDER SOCIMI</option><option value="23121" >TAURO REAL ESTATE</option><option value="12021" >TCN</option><option value="21969" >TECHNOPOLIS</option><option value="26189" >TECNOPOLIS</option><option value="27800" >TECTUM REAL ESTATE INVESTMENTS</option><option value="27614" >TEL SUN DEUTSCHLAND</option><option value="4865" >TELEFONICA</option><option value="27513" >TELENO REAL ESTATE</option><option value="27451" >TEMPORE</option><option value="22014" >TEMPRANO</option><option value="18322" >TEN BRINKE</option><option value="25872" >TENIGLA REAL ESTATE</option><option value="28125" >TERRALPA</option><option value="28331" >TERRAS DO SAR</option><option value="1330" >TESTA</option><option value="24057" >THE ABILITY GROUP</option><option value="15066" >THE ASCOTT GROUP</option><option value="19286" >THE BAUPOST GROUP</option><option value="1212" >THE CARLYLE GROUP</option><option value="17846" >THE CROWN ESTATE</option><option value="26987" >THE MAYORS OFFICE FOR POLICING AND CRIME</option><option value="28089" >The Sandman Hotel Group</option><option value="22933" >THE STUDENT HOTEL</option><option value="12381" >THERUS INVEST</option><option value="27411" >THESIZE SURFACES</option><option value="27616" >THOMAS COOK HOTEL INVESTMENTS</option><option value="26997" >THOMAS MEYER</option><option value="18958" >THOR EQUITIES</option><option value="18827" >THREADNEEDLE INVESTMENTS</option><option value="27248" >THREESTONES CAPITAL</option><option value="12840" >TIKEHAU CAPITAL PARTNERS</option><option value="24923" >TILAD</option><option value="27609" >TIMELESS</option><option value="9463" >TIMERCO</option><option value="984" >TISHMAN SPEYER</option><option value="27670" >TITAN</option><option value="14122" >TK DEVELOPMENT</option><option value="21410" >TLG IMMOBILIEN</option><option value="25348" >TM GRUPO INMOBILIARIO</option><option value="23624" >TOMAS OLIVO</option><option value="28459" >TOP RECAMBIOS</option><option value="16740" >TOPLAND</option><option value="10862" >TORIMBIA</option><option value="23593" >TORIODIS</option><option value="803" >TORRE RIOJA</option><option value="24634" >TORRONS VICENS</option><option value="5644" >TOUS</option><option value="4946" >TOYS "R" US</option><option value="21678" >TPG Real Estate</option><option value="25925" >TQ-MR FAMILY</option><option value="19162" >TRADEINN</option><option value="24783" >TRAJANO SOCIMI</option><option value="26726" >TRAMWAY</option><option value="25518" >TRANS INVESTMENT</option><option value="6989" >TRANS WORLD CORPORATION</option><option value="28175" >TRANSPORTES JAYLO</option><option value="18400" >TRISTAN CAPITAL PARTNERS</option><option value="22199" >TRITAX</option><option value="23578" >TRITAX BIG BOX REIT</option><option value="17740" >TRITON CAPITAL</option><option value="90" >TRIZECHAHN</option><option value="27594" >TROPHAEUM</option><option value="23414" >Trophi Fastighets</option><option value="26379" >TROPICANA ATLANTICO</option><option value="25334" >TSB</option><option value="22364" >TWENTY TWO REAL ESTATE</option><option value="26670" >TWIN PEAKS</option><option value="26070" >U CITY</option><option value="13488" >UBS REAL ESTATE</option><option value="24073" >UK & EUROPEAN INVESTMENTS</option><option value="22071" >UK COMMERCIAL PROPERTY TRUST LIMITED</option><option value="11244" >ULLOA OPTICA</option><option value="85" >UNIBAIL RODAMCO</option><option value="27184" >UNICA REAL ESTATE</option><option value="27556" >UNIFERSA</option><option value="23396" >UNION DE INICIATIVAS DE MARINA DE LA FAROLA</option><option value="26605" >UNION EIENDOMSKAPITAL</option><option value="14501" >UNION INVESTMENT REAL ESTATE</option><option value="23412" >UNITE UK STUDENT ACCOMMODATION FUND</option><option value="26932" >UNITY RE</option><option value="25333" >UNIVERSAL HOTELS</option><option value="25179" >UNIVERSAL INVESTMENT</option><option value="28151" >UNIVERSIDAD ANTONIO DE NEBRIJA</option><option value="25630" >UNIVERSIDAD REY JUAN CARLOS</option><option value="17895" >UNIVERSITAT OBERTA DE CATALUNYA ( UOC )</option><option value="25899" >URBAN INDUSTRIAL</option><option value="15618" >URBAN INTEREST REAL ESTATE</option><option value="27374" >URBANIA INTERNATIONAL</option><option value="7067" >URBANITAS</option><option value="27766" >URBANIZADORA ANGLOIBERICA</option><option value="23709" >URBANO DIVERTIA</option><option value="994" >URBIS</option><option value="24131" >URBISA</option><option value="5067" >URENDE</option><option value="9002" >URIACH</option><option value="6458" >URTASUN</option><option value="5073" >UVESCO</option><option value="23584" >VAL GENERAL</option><option value="16364" >VALAD PROPERTY GROUP</option><option value="28320" >VALEBIAN XXI</option><option value="19588" >VALENCIA RESIDENCIAL</option><option value="26982" >VALESCO</option><option value="28029" >VALGIME</option><option value="27217" >VALOR REAL ESTATE PARTNERS</option><option value="5349" >VALUE RETAIL</option><option value="19935" >VARDE PARTNERS</option><option value="5091" >VARMA</option><option value="22733" >VARMA MUTUAL PENSION INSURANCE COMPANY</option><option value="12782" >VASAKRONAN</option><option value="419" >VASTNED</option><option value="25949" >VBARE SOCIMI</option><option value="23906" >VELAPI</option><option value="1000" >VEMUSA</option><option value="23682" >VERACRUZ PROPERTIES</option><option value="26604" >VESTAS INVESTMENT MANAGEMENT</option><option value="22001" >VGP</option><option value="15632" >VIA CELERE</option><option value="23873" >VIA OUTLETS</option><option value="5113" >VIAJES MARSANS</option><option value="6403" >VIAPOL</option><option value="22671" >VICTORIA PARK</option><option value="27323" >VIKA PROJECT FINANCE</option><option value="23613" >VILA DE BADALONA</option><option value="28228" >VILLA PADIERNA</option><option value="24089" >VILLAR SOBA INVERSIONES</option><option value="14955" >VINCI IMMOBILIER</option><option value="27560" >VISOCAN (GOBIERNO DE CANARIAS)</option><option value="28186" >VITA STUDENT</option><option value="22169" >VITHAS</option><option value="5154" >VITRUVIO</option><option value="19791" >VIUDA DE BLANCO VILLEGAS</option><option value="26358" >VIVENIO</option><option value="25735" >VIVIENDAS DE VIZCAYA CONSTRUCTORA BENEFICA</option><option value="28256" >VIVION</option><option value="28086" >VOGUE 84</option><option value="24246" >VOLKSBANK</option><option value="5168" >VOLVO TRUCKS</option><option value="26345" >VOSTOK</option><option value="21804" >VP HOTELES</option><option value="26390" >VUKILE</option><option value="27858" >VUSA</option><option value="22100" >VVT KIINTEISTOSIJOITUS</option><option value="26352" >VYOSA</option><option value="27515" >W REAL ESTATE</option><option value="25512" >W2 DEVELOPMENT</option><option value="26731" >WALKERS</option><option value="19975" >WALTON STREET CAPITAL</option><option value="22159" >WARBURG HIH</option><option value="15138" >WAREHOUSES DE PAUW</option><option value="27586" >WATERFALL</option><option value="10673" >WCM</option><option value="19572" >WEALTHCAP</option><option value="27976" >WEALTHCORE INVESTMENT MANAGEMENT</option><option value="20565" >WELLS FARGO BANK</option><option value="26399" >WENAASGRUPPEN</option><option value="27008" >WEST MIDLANDS PENSION FUND</option><option value="22373" >WESTBROOK PARTNERS</option><option value="25152" >WESTGATE OXFORD ALLIANCE</option><option value="6594" >WESTINVEST</option><option value="26837" >WESTMINSTER REAL ESTATE</option><option value="25066" >WESTON HILL</option><option value="26376" >WEWORK</option><option value="23429" >WH NERVION PLAZA</option><option value="22579" >WHITE CITY VENTURES</option><option value="28328" >WHITE INVESTING</option><option value="26597" >WHITE LAND</option><option value="24567" >WIHLBORGS</option><option value="26113" >WINCHE</option><option value="27250" >WINGENIA</option><option value="27798" >WINTERHALTER INMOBILIEN</option><option value="3329" >WINTERTHUR</option><option value="26443" >WIREFOX</option><option value="23723" >WIT RETAIL</option><option value="26325" >WOKANO</option><option value="26751" >WOKING BOROUGH COUNCIL</option><option value="25878" >WOLFE ASSET MANAGEMENT</option><option value="25785" >WOOD & COMPANY</option><option value="23934" >WOONINVESTERINGSFONDS</option><option value="23857" >WORKSPACE</option><option value="12863" >WP CAREY</option><option value="24106" >WSF GROUP</option><option value="21497" >WURTTEMBERGISCHEN LEBENSVERSICHERUNG</option><option value="25770" >XAVIER NIEL</option><option value="27067" >XIOR STUDENT HOUSING</option><option value="27675" >YAIZA TRUST</option><option value="27696" >YBARRA Y COMPAÑIA</option><option value="5242" >YELMO</option><option value="26190" >YOO CAPITAL</option><option value="24915" >YORK CAPITAL MANAGEMENT</option><option value="27041" >YTL</option><option value="23460" >YUDAYA</option><option value="28199" >ZAKA INVESTMENTS</option><option value="27416" >ZAMBUDIO</option><option value="15962" >ZAPHIR ASSET MANAGEMENT</option><option value="13516" >ZARAGOZA URBANA</option><option value="25317" >ZATERIAL</option><option value="27191" >ZC RONOGIL</option><option value="23662" >ZENOR OVERSEAS</option><option value="21057" >ZENTRAL BODEN IMMOBILIEN</option><option value="25329" >ZEUS CAPITAL</option><option value="25776" >ZIKOTZ</option><option value="18148" >ZRISER</option><option value="28163" >ZUMMO</option><option value="1032" >ZURICH</option>
                                                        </select>
													
												</div>

												<div class="tip-caja fade right in " role="" id="frmInfo-tip">
													<div class="arrow"></div>
													<div class="tip-title" id="frmInfo-tip-title">Para comenzar la b&uacute;squeda</div>
													<div class="tip-content" id="frmInfo-tip-content">Por favor, chequea una <span class="naranjaB">opci&oacute;n</span> antes </div>
												</div>
												
											</div><!--inputField : fin-->
										</li>
									</ul>
								</form>
							</div><!-- // colInfo -->
							<div class="col-sm-6 colBusqueda" id="head_div_busq">
								<h1>B&uacute;squedas:</h1>
								<ul>
									<li><a href="/dealanalysis/">Deal Analysis</a></li>
									<li><a href="/actualidad/">News Data Base </a></li>
									<li><a href="/estudios/">Estudio de mercado</a></li>
									<li><a href="/inversores/">Inversores</a></li>
									<li><a href="/demandas/">Demandas</a></li>
									<li><a href="/vencimientos/">Vencimientos de contrato</a></li>
									<li><a href="/subastas/">Subastas/Concursos</a></li>
									<li><a href="https://www.easyproperty.es/" target="_blank" class="logEasy"><img src="/img/shared/EasyProperty.png" alt=""/>EasyProperty</a></li>
								</ul>
							</div><!-- // colBusquedas -->
						</div>
					</div>
				
				</div>
			</div><!-- // col-sm-9 izquierda -->
			
			<div class="col-sm-3 derecha">
				<!--usuario-->
				
				<div class="user hidden-xs">
					<ul>
						<li>
							<span class="icon-user"></span>
							
								Bienvenido:
							
							<p id="header_licencia">
								comercial
							</p>
						</li>
						<li class="userGtr"><span class="icon-briefcase"></span>
							Empresa:
							<p id="header_cliente">PW</p>
						</li>
						
						
						<li><span class="icon-user-tie"></span> Tu gestor:
							<p>Andy G.</p>
						</li>
						
					</ul>
				</div>
				
				<!--contacto-->
				
				<div class="contact">
					<ul>
						<li class="tlf hidden-xs"><span class="icon-phone"></span> 914 295 143</li>
						<li class="hidden-xs"><a href="mailto:pw@propertyweb.eu"><span class="icon-mail4"></span> E-mail</a></li>
						<li><span class="miembro">Miembro de: </span><a href="javascript:void(0);"><img src="/img/shared/ricsPartner.png" alt="Rics"></a></li>
					</ul>
				</div>
				
				
			</div><!-- // col-sm-3 derecha -->

		</header>
	</div>
</div>
<div id="ModalBox" class="modal fade" tabindex="-1"></div>
<div style="clear:both;"></div>




<script type="text/javascript">

	$crisp.push(["set", "user:nickname", ["comercial@propertyweb.eu"]])
	$crisp.push(["set", "user:company", ["PW"]])	
	$crisp.push(["set", "user:phone", [""]])
	$crisp.push(["set", "user:email", ["comercial@propertyweb.eu"]])



</script>
<div class="container">
    	<section id="s_titulos" class="row">
		  <div class="caja">

<a id="scrollmap"></a>
<div class="miga"><h2 class="tit_miga02">Disponibilidad</h2></div>

<div class="tit_resultados" id="informa_resultados">
	<p><span class="tit_busqueda"></span><span class="tit_metros"><!--con un total de XXXX m2--></span><span class="tit_numero"><!--XXX resultados, --></span></p> 
</div>
<!--include virtual="/disponibilidad/preguntas_jp.asp" -->
<div class="PwTabs">
	
	<a id="verSubmenu" href="" class="btn bt_lupa animaHide" ><span class="ico icon-cross"></span><span class="hidden-xs"> ZONAS/SUBZONAS</span></a>
    
	<ul class="nav nav-tabs clearfix lineNavs" style="">
		<li id="li-tab-map" class="active"><a href="#map" data-toggle="tab" aria-expanded="true" data-id="map"><span class="icon-map2"></span> Mapa</a></li>
		<li id="li-tab-list" ><a href="#list" data-toggle="tab" aria-expanded="false" data-id="list"><span class="icon-menu"></span> Listado</a></li>
	</ul>
    
	<div id="sticky-marcador"></div>
	<div class="divCajaCheck" style=" background-color:#FFF; display:none;">
		<div class="contadorSelect"><!-- style="margin-top:-45px;"  -->
			<div  class="contadorSelectGris"style="background-color:#dedede">
				<span class="numero" id="sel-count">0</span>
				<span class="icon-checkmark"></span>
			</div>
			<input id="cmd-read-sel" type="button" value="Ver fichas" class="btn btn-sm">
			<input id="cmd-clear-sel" type="button" value="Borrar" class="btn blancoHover btn-sm">
			<p class="hidden alert" id="informa-limite">El l&iacute;mite es <span id="limite_seleccion">0</span> </p>
		</div>
	</div>
	
	
    
	<div class="tab-content">
    	
		
<div class="filtros-navs" > 
	<div class="tab-content">
		<div class="tab-pane active" id="busqueda">
<form id="frm_preguntas" class="filtrosForm" action="/disponibilidad/data/ajax.asp" method="post" target="_blank">
    <input type="hidden" id="frmInfo_disp_tab" name="frmInfo_disp_tab" value=""/>
    <input type="hidden" name="lat" value="" id="frmInfo_disp_lat"/>
    <input type="hidden" name="lng" value="" id="frmInfo_disp_lng"/>
    <input type="hidden" name="zoom" value="" id="frmInfo_disp_zoom"/>
    <input type="hidden" name="orden" value="" id="frmInfo_disp_orden"/>
    <input type="hidden" name="ordent" value="" id="frmInfo_disp_ordent"/>
    <input type="hidden" name="secc" value="disponibilidad"/>
    

<!--
<br />
<a href="javascript:$('#frm_preguntas').submit();">_blank</a> &nbsp; <a href="javascript:CargarDatos();">filtrar</a>
 &nbsp; <a href="javascript:CargaAgencias();">agencias</a>
<hr />
-->
<!-- ciudad-->
<div class="form-group">
	<label for="ciudad-filtro">¿En qué ciudad de Europa?</label>
	<input type="text" id="ciudad-filtro" name="ciudad" class="form-control" placeholder="Ej. Madrid" autocomplete="off" value=""><!--  onchange="CambiaLocalidad();" -->
    <div class="depura-filtros ciudad">xxx</div>
</div>

<div class="tit_resultados" id="">
	<div class="tb-Gral-cont">
<table class="tabla tbFiltros" id="tblResumen">
<caption id="informa-busq"></caption>
<thead class="">
<tr class="trFiltros">
	<th></th>
	<th>Nº</th>
	<th>M<sup>2</sup></th>
	<th></th>
	<th colspan="2">Ver</th>
</tr>
</thead>
<tbody class="">
<tr class="trFiltros">
	<td>Of. Disponibles</td>
	<td id="of-disp"></td>
	<td id="sup-disp"></td>
	<td></td>
	<td><a href="#" class="btFiltros activo" data-tab="map"><span class="icon-location"></span></a></td>
	<td><a href="#" class="btFiltros " data-tab="list"><span class="icon-menu"></span></a></td>
</tr>
<tr class="trFiltros">
	<td>Of. Registradas</td>
	<td id="of-total"></td>
	<td id="sup-total"></td>
	<td></td>
	<td><!-- <a href="#" class="btFiltros"><span class="icon-location"></span></a> --></td>
	<td><!-- <a href="#" class="btFiltros"><span class="icon-menu"></span></a> --></td>
</tr>

<tr class="trTotalAlquilado">
	<td>Total Alquilado:</td>
	<td colspan="5"><span class="alquilado-porcentaje" style="font-weight:bold;"></span> <span class="totalAlquilado">@16/05/2020</span></td>
</tr>
</tbody>
</table>
	</div>
</div>

<!-- m2-->
<div class="form-group clearfix periodo"> 
	<label for="metros-filtro">¿Qué M<sup>2</sup> buscas?</label>
	<input type="text" name="min" id="frmInfo_disp_min" class="form-control bl50" placeholder="Desde..." value="" autocomplete="off">
	<input type="text" name="max" id="frmInfo_disp_max" class="form-control bl50" placeholder="Hasta" value="" autocomplete="off">
    <div class="depura-filtros periodo">Los valores no son v&aacute;lidos</div>
</div>

<!-- agencia-->
<div class="form-group">
	<label for="agencia">Agencia:</label>
	<div class="dropdown selectDrop" id="dropdown-agencias"><!--include virtual="/disponibilidad/data/select_agencias.asp" --></div>
</div>

<div id="filtrosDisponibilidad">
	<input type="hidden" name="id_zona" id="id_zona" value="">
    <input type="hidden" name="zona" id="zona" value="">
    <input type="hidden" name="id_subzona" id="id_subzona" value="">
    <input type="hidden" name="subzona" id="subzona" value="">
    
    <label>Area:</label>
    <ul class="nav nav-pills" id="nav-filtros">
		<!-- Zonas -->
        <li class="dropdown">
			<a class="dropdown-toggle" data-toggle="dropdown" href="#">Zonas <span class="caret"></span> </a>
			<ul class="dropdown-menu" id="ul-zonas">
	            <li data-id=""><a href="#zonas" data-toggle="tab" onclick="CambiaZona();">Todas las Zonas</a></li>
				<li data-id="6"><a href="#zonas" data-toggle="tab" onclick="CambiaZona(6);">PRIME</a></li>
				<li data-id="1"><a href="#zonas" data-toggle="tab" onclick="CambiaZona(1);">A1</a></li>
				<li data-id="2"><a href="#zonas" data-toggle="tab" onclick="CambiaZona(2);">A2</a></li>
				<li data-id="3"><a href="#zonas" data-toggle="tab" onclick="CambiaZona(3);">A3</a></li>
				<li data-id="7"><a href="#zonas" data-toggle="tab" onclick="CambiaZona(7);">DEC</a></li>
				<li data-id="5"><a href="#zonas" data-toggle="tab" onclick="CambiaZona(5);">OUT</a></li>
			</ul>
		</li>
		<!-- Subzonas -->
		<li class="dropdown" id="li-subzonas">
        	<a class="dropdown-toggle" data-toggle="dropdown" href="#">Subzonas <span class="caret"></span> </a>
			<!-- include virtual="/disponibilidad/data/ul_subzonas.asp" -->
		</li>
		<!-- Calle(s) -->
		<li><a href="#calle" data-toggle="tab">Calle</a></li>
	</ul>
	
	<div class="tab-content">
		<div class="tab-pane" id="zonas">
			<!--
			<div class="tit_resultados" id="informa_resultados">
				<p><span class="tit_busqueda">ZONA </span><span class="tit_numero">XXX inmuebles</span><span class="tit_metros">, con un total de YYY m²</span></p>
			</div>
			-->
		</div>
		<div class="tab-pane" id="subzonas"> 
			<!--
			<div class="tit_resultados" id="informa_resultados">
				<p><span class="tit_busqueda">SUBZONA </span><span class="tit_numero">XXX inmuebles</span><span class="tit_metros">, con un total de YYY m²</span></p>
			</div>
			-->
		</div>
		<div class="tab-pane" id="calle">
			<input type="text" class="calle-filtro form-control" name="calle" placeholder="Ej. Castellana">
			<div class="bts-mascalles periodo clearfix">
				<span class="bl50"><button class="btn gris bt-mascalles" type="button">+ Añadir calles</button></span>
				<span class="bl50" ><button class="btn bt-calleMapa" type="button" disabled id="bt-enviar"> Ver en mapa</button></span>
			</div>
			<!--
			<div class="tit_resultados" id="informa_resultados">
				<p><span class="tit_busqueda"></span><span class="tit_numero">XXX inmuebles</span><span class="tit_metros">, con un total de YYY m²</span></p> 
			</div>
			-->
		</div>
	</div>
</div>
</form>
		</div>
	</div>
</div>
<script>
	$("#filtrosDisponibilidad").hide();
	
	function LimpiaCalles() {
		$.each($(".div-calle-filtro"), function(ii, elto) {
			$(elto).remove();
		})
		$($("#calle .calle-filtro")[0]).val("");
		$("#bt-enviar").attr("disabled", true);
	}
	
	function filtros_CiudadOK() {
		console.log("filtros_CiudadOK");
		
		if ($.trim($("#ciudad-filtro").val())=="") {
			$(".depura-filtros.ciudad").text("Hay que rellenar el campo");
			$(".depura-filtros.ciudad").slideDown();
			return false;
			
		} else {
			if (CiudadDisponible($("#ciudad-filtro").val())) {
				$(".depura-filtros.ciudad").slideUp();
				return true;
			} else {
				$(".depura-filtros.ciudad").text("Sin disponibilidad para esta búsqueda");
				$(".depura-filtros.ciudad").slideDown();
				return false;
			}
		}
		
	}
	
	function filtros_RangoOK() {
		var pasa = false;
		
		if ($("#frmInfo_disp_min").val()=="" || $("#frmInfo_disp_max").val()=="") {
			pasa = true;
		} else {
			if (parseInt($("#frmInfo_disp_min").val())<=parseInt($("#frmInfo_disp_max").val())) {
				pasa = true;
			} else {
				pasa = false;
			}
		}
		
		if (pasa) {
			//$("#depura").slideUp(300);
		} else {
			$(".depura-filtros.periodo").slideDown(300);
			//$("#frmInfo_disp_min").focus();
		}
		
		console.log("filtros_RangoOK: ", pasa);
		//console.log($("#desde").val(), $("#hasta").val(), "RangoOK: "+pasa);
		return pasa;
	}

$(document).ready(function() {
	$("#verSubmenu").data("clicks", false);
	btSubmenu($("#verSubmenu"));
	
	$("#tblResumen .btFiltros").click(function(e) {
		console.log(this)
		
		$("#tblResumen .btFiltros").removeClass("activo");
		$(this).addClass("activo");
		
        var tabActual = $(".PwTabs > .nav-tabs .active > a").data("id");
		var tabClick = $(this).data("tab");
		
		console.log("tabActual: " + tabActual, ">>", "tabClick: " + tabClick)
		if (tabActual==tabClick) {
			console.log("cancelado, mismo tab");
		} else {
			$(".PwTabs .nav-tabs a[href='#" + tabClick + "']").tab("show");
			//$(".PwTabs .nav-tabs a[href='#" + tabClick + "']").click();
		}
		return false;
	})
	
	$("#verSubmenu").on("click", function (e) {
	     btSubmenu($(this));
		 e.preventDefault();
	});
	
	$("#frmInfo_disp_min, #frmInfo_disp_max").keydown(function (e) {
		if (e.keyCode == 13 || e.keyCode == 9) {	//
			var campo = $(this).closest("input[type='text']")[0];
			
			if ( filtros_RangoOK() ) {
				
				//if (filtros_CiudadOK()) {
					if (frm_data != $("#frm_preguntas").serialize()) {
						CargaAgencias();
						CargarDatos();
					}
					//console.log( $(campo).prop("id") )
				//}
			}
			
			return false;
		}
		
		// Allow: backspace, delete, escape, tab 
		// , 13
        if ($.inArray(e.keyCode, [46, 8, 27, 110, 9]) !== -1 ||
             // Allow: Ctrl+A
            (e.keyCode == 65 && e.ctrlKey === true) ||
             // Allow: Ctrl+C
            (e.keyCode == 67 && e.ctrlKey === true) ||
             // Allow: Ctrl+X
            (e.keyCode == 88 && e.ctrlKey === true) ||
             // Allow: Ctrl+V
            (e.keyCode == 86 && e.ctrlKey === true) ||
             // Allow: home, end, left, right
            (e.keyCode >= 35 && e.keyCode <= 39)) {
                 //console.log(e.keyCode)
                 return;
        }
        // Ensure that it is a number and stop the keypress
        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
            e.preventDefault();
        }
    });
	
	$("#frmInfo_disp_min").blur(function(e) {
		console.log("frmInfo_disp_min blur");
		if (filtros_RangoOK()) {
			$(".depura-filtros.periodo").slideUp(300);
		} else {
			$(".depura-filtros.periodo").slideDown(300);
		};
    });
	$("#frmInfo_disp_max").blur(function(e) {
		console.log("frmInfo_disp_max blur");
		if (filtros_RangoOK()) {
			$(".depura-filtros.periodo").slideUp(300);
		} else {
			$(".depura-filtros.periodo").slideDown(300);
		}
    });
	
	$("#ciudad-filtro").keydown(function (e) {
		//console.log("ciudad-filtro keydown [" + e.keyCode + "]")
        //e.preventDefault();
		
		if (e.keyCode == 13 || e.keyCode == 9) {	//
			//console.log("filtros_CiudadOK", filtros_CiudadOK)
			if (filtros_CiudadOK()) {
				
				if (filtros_RangoOK()) {
					// ?? $("#frm_preguntas input[name='min']").val( $("#desde").val() );
					// ?? $("#frm_preguntas input[name='max']").val( $("#hasta").val() );
					if (frm_data != $("#frm_preguntas").serialize()) {
						CambiaLocalidad();
					}
				} else {
					$("#frmInfo_disp_min").focus();
				}
				
			} else {
				if (frm_data != $("#frm_preguntas").serialize()) {
					CambiaLocalidad();
				}
			}
			return false;
		}
		
    });
	
	
	/*  cerrar depuraAA*/
	$("#bt-enviar").on("click",function() {
		console.log("bt-enviar");
		if ($("[aria-label='ciudad']").val()=="") {
			console.log(" ==''");
		    $("[aria-label='ciudad']").css({"border-color": "red"});
			//$(this).css({"border": "red"});
			$(".depuraAA").text("Tienes que rellenar este campo");
			$(".depuraAA").slideToggle();
			//alert("hola");
			return false;
		}
		CargarDatos();
		
	});
	
	/*  bt masCalles >  añade camposinput .calle-filtro para introducir más calles */
	$(".bt-mascalles").on("click", function() {
		var nCalles = $("#calle .calle-filtro").length;
		var cadenaCalles =  "<div class='div-calle-filtro'><input type='text' class='calle-filtro form-control' name='calle' placeholder='Añade otra calle'><span class='borrarInput'><a href='#' class='btn'><span class='icon-cross'></span></a></span></div>"
		
		if (nCalles <9) {
			$(".bts-mascalles ").before(cadenaCalles);
		} else if ( nCalles == 9) {
			$(".bts-mascalles ").before(cadenaCalles);
			//$('#calle .calle-filtro').attr("placeholder","Añade otra calle");
			// alert($('#calle .calle-filtro').eq(9).html());
			$("#calle .calle-filtro").eq(9).attr("placeholder", "Añade la última calle");
		} else {
			return false;
		}
		
		//OLD
		//if ( nCalles <9) {
		//	$(".bts-mascalles ").before("<div><input type='text' class='calle-filtro form-control' name='calle' placeholder='Añade otra calle'><span class='borrarInput'><a href='#' class='btn'><span class='icon-cross'></span></a></span></div>");
		//} else if ( nCalles < 10 ) {
		//	$(".bts-mascalles ").before("<div><input type='text' class='calle-filtro form-control' name='calle' placeholder='Añade la última calle'><span class='borrarInput'><a href='#' class='btn'><span class='icon-cross'></span></a></span></div>");	
		//} else if (( nCalles == 10 )&& ( $('p.info-filtro').length )) {
		//	return false;
		//} else {
		//	$(".calle-filtro:last").parent().append("<p class='info-filtro'> Has llegado al límite de <strong>10 calles</strong> seleccionables<p>");
		//	//$(".bts-mascalles").before("<p class='info-filtro'> Has llegado al límite de <strong>10 calles</strong> seleccionables<p>");
		//}
		
	});
	
	$("#calle").on("click", ".borrarInput>a", function(e) {
		if ( $("#calle .calle-filtro").length == 10) {
			$("#calle .calle-filtro").attr("placeholder", "Añade otra calle");
		}
		$(this).closest("div").remove();
		e.preventDefault();
	});

	/* activa el bt-calleMapa  */				
	$("#calle").on("change", ".calle-filtro", function() {
		if( $(".bt-calleMapa").attr("disabled")){
			$(".bt-calleMapa").removeAttr("disabled");
			$(".bt-calleMapa").addClass("btnAzul");
		}
	});
	
})
</script>
        
		<div class="tab-pane active" id="map">
			<script type="text/javascript">
	var diapositiva = 1;
	var diapositivas_data = "";
	
	function btSubmenu(elemento) {
		var clicks = elemento.data("clicks");
		if (clicks) {
			$(".filtros-navs").addClass("activo");
			elemento.find("span.ico").removeClass("icon-search").addClass("icon-cross giro"); //icon-arrow-left2 
			$(".PwTabs>.tab-content").addClass("confiltros");
		} else {
			$(".filtros-navs").removeClass("activo");
			elemento.find("span.ico").removeClass("icon-cross giro").addClass("icon-search"); //icon-arrow-left2 
			$(".PwTabs>.tab-content").removeClass("confiltros");
		}
		elemento.data("clicks", !clicks);
		setTimeout( function () {
			console.log("map resize")
			google.maps.event.trigger(map, "resize");
			f_bounds_edificios();
		}, 350 );
		
	}
	function btSubmenu_OLD(elemento) {
		var clicks = elemento.data("clicks");
		
		if (clicks) {
			$(".filtros-navs").animate({   "right" : "0"   });
			elemento.find("span.ico").removeClass("icon-search").addClass("icon-cross giro"); //icon-arrow-left2 
		} else {
			$(".filtros-navs").animate({   "right" : "-330px"   });
			elemento.find("span.ico").removeClass("icon-cross giro").addClass("icon-search"); //icon-arrow-left2 
		}
		elemento.data("clicks", !clicks);
	}
	
	function preguntaSiguiente(i) {
		console.log("preguntaSiguiente [ i = " + i + " ]")
		//$(".depura").removeClass("activo");
		$("#depura").slideUp(300);
		
		$(".navPuntos span").removeClass("checked"); 
		$(".navPuntos span").eq(i).addClass("checked");		 
		var ii = i * -100;
		$(".contTodo").css({"left": ii + "%" });
	}
	
	function qCiudadOK() {
		console.log("qCiudadOK");
		
		if( $.trim($("#qCiudad").val()) == "" ) {
			$("#depura").text("hay que rellenar el campo");
			//$("#depura").slideDown(300);
			return false;
			
		} else {
			for (var i = 0; i < localidades.length; i++) {
				//console.log(i, localidades[i])
				if (localidades[i].localidad == $.trim($("#qCiudad").val()).toUpperCase()) {
					return true;
				}
			}
			
			$("#depura").text("ciudad sin disponibilidad");
			return false;
		}
		
	}
	
	function RangoOK() {
		var pasa = false;
		
		if ($("#desde").val()=="" || $("#hasta").val()=="") {
			//$("#depura").removeClass("activo");
			pasa = true;
			//return;
		} else {
			//console.log($("#desde").val(), $("#hasta").val(), parseInt($("#desde").val())<=parseInt($("#hasta").val()))
			if (parseInt($("#desde").val())<=parseInt($("#hasta").val())) {
				pasa = true;
			} else {
				pasa = false;
			}
		}
		
		if (pasa) {
			//$("#depura").slideUp(300);
			
		} else {
			$("#depura").html("Rango incorrecto");
			//$("#depura").slideDown(300);
			//return false;
		}
		console.log("RangoOK: ", pasa);
		//console.log($("#desde").val(), $("#hasta").val(), "RangoOK: "+pasa);
		return pasa;
	}
	
	function EnviarDiapositivas() {
		var tmp_data;
		tmp_data = "ciudad=" + $.trim($("#qCiudad").val()).toUpperCase() + "&";
		tmp_data = tmp_data + "min=" + $.trim($("#desde").val()) + "&";
		tmp_data = tmp_data + "max=" + $.trim($("#hasta").val());
		
		if (diapositivas_data == tmp_data) {
			console.log("EnviarDiapositivas: cancelado, sin cambios")
			return false;
			
		} else {
			diapositivas_data = tmp_data;
			$("#ciudad-filtro").val( $("#qCiudad").val() );
			$("#frm_preguntas input[name='min']").val( $("#desde").val() );
			$("#frm_preguntas input[name='max']").val( $("#hasta").val() );
		}
		
		CambiaLocalidad();
	}
	
$(document).ready(function() {
	//$(".divPreguntas").addClass("activo");
	
	$("#CloseDiapo").on("click",function() {
		$(".divPreguntas").removeClass("activo");    //cierra preguntas
		$("#verSubmenu").removeClass("animaHide");   // bton  verSubmenu lo hace visible
	});
	
	$(".btCiudad_JAVIER").on("click",function(e) {
		var diapos =  $(".contTodo .cont").length;  
		var i = $(".btCiudad").index($(this))+1;
		 // alert(i);
		 				 //   alert( i + " :::: " +  $(".contTodo .cont").length  + " :::: " +   $(".btCiudad").text()   )
		  
		if( $("#qCiudad").val().length < 1){     	//  $(this).val().length < 1)
				$(this).parent("cont").css({"color": "red"});		
				$(".depura").addClass("activo");    	
				$(".depura").text("Hay que rellenar campo");
				//alert("vacio")
			}else if( $(this).text()=="NO" ) { 
				cerrarPreguntas();
			}else if( $(this).text()=="SI" ) { 
				// alert("HOLA");
				//$(".divPreguntas").removeClass("activo");
				$("#verSubmenu").data("clicks", true);
				cerrarPreguntas();
							
				setTimeout( function () {
			 		btSubmenu($("#verSubmenu"));
				}, 600 );	
				
				//btSubmenu($("#verSubmenu"));
				
			}else {
				//alert($(".btCiudad").index());
				preguntaSiguiente(i);
				}
			
		e.preventDefault();
	});
	
	$(".btCiudad").on("click", function(e) {
		e.preventDefault();
		var i = $(".btCiudad").index($(this))+1;
		console.log("btCiudad.click", "i=" + i);
		
		if (i==1 || i==2) {
			if (qCiudadOK()) {
				if (RangoOK()) {
					$("#ciudad-filtro").val( $("#qCiudad").val() );
					$("#frm_preguntas input[name='min']").val( $("#desde").val() );
					$("#frm_preguntas input[name='max']").val( $("#hasta").val() );
					CambiaLocalidad();
					preguntaSiguiente(2);
					
					//$("#desde").focus();
					
				} else {
					preguntaSiguiente(1);
					$("#depura").slideDown(300);
					//$("#desde").focus();
					return false;
				}
				
			} else {
				if (i==2) preguntaSiguiente(0);
				$("#qCiudad").focus();
				$("#depura").slideDown(300);
				return false;
			}
			
		} else {
			//console.log(this.text);
			$(".divPreguntas").removeClass("activo");
			$("#verSubmenu").removeClass("animaHide");
			
			if (this.text=="SI") {
				$("#verSubmenu").click();
				//$("#verSubmenu").data("clicks", true);
			}
		}
		
		return false;
		
	})
	
	
	$(".navPuntos span").on("click",function() {
		preguntaSiguiente($(this).index());
		 // preguntaSiguienteBIS($(this));  $(event.delegateTarget)
	});
	
	$("#desde, #hasta").keydown(function (e) {
		if (e.keyCode == 13) {
			var campo = $(this).closest("input[type='text']")[0];
			//console.log(e);
			//console.log( $(campo).attr("id") );
			//return false;
						
			//if ( $("#desde").val()=="" || $("#hasta").val()=="" ) {
			if ( $(campo).val()=="" ) {
				if (qCiudadOK()) {
					EnviarDiapositivas();
					if ($(campo).attr("id")=="desde") {
						$("#hasta").focus();
					} else {
						preguntaSiguiente(2);
					}
					//console.log("SUBMIT");
				} else {
					preguntaSiguiente(0);
					$("#qCiudad").focus();
					$("#depura").slideDown(300);
					return false;
				}
				
			} else {
				
				if ( RangoOK() ) {
					
					if (qCiudadOK()) {
						EnviarDiapositivas();
						//console.log( $(campo).prop("id") )
						if ($(campo).prop("id")=="desde") {
							$("#hasta").focus();
						} else {
							//$("#desde").focus();
							preguntaSiguiente(2);
						}
						
					} else {
						
						preguntaSiguiente(0);
						$("#qCiudad").focus();
						$("#depura").slideDown(300);
					}
					
				} else {
					$("#depura").slideDown(300);
					console.log("rango mal !");
				}
				
			}
			
			//if (RangoOK()) {}
			return false;
		}
		
		// Allow: backspace, delete, tab, escape, enter 
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110]) !== -1 ||
             // Allow: Ctrl+A
            (e.keyCode == 65 && e.ctrlKey === true) ||
             // Allow: Ctrl+C
            (e.keyCode == 67 && e.ctrlKey === true) ||
             // Allow: Ctrl+X
            (e.keyCode == 88 && e.ctrlKey === true) ||
             // Allow: Ctrl+V
            (e.keyCode == 86 && e.ctrlKey === true) ||
             // Allow: home, end, left, right
            (e.keyCode >= 35 && e.keyCode <= 39)) {
                 //console.log(e.keyCode)
                 return;
        }
        // Ensure that it is a number and stop the keypress
        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
            e.preventDefault();
        }
    });
	
	$("#desde").blur(function(e) {
		console.log("desde blur");
		if (RangoOK()) {
			$("#depura").slideUp(300);
		} else {
			$("#depura").slideDown(300);
		};
    });
	$("#hasta").blur(function(e) {
		console.log("hasta blur");
		if (RangoOK()) {
			$("#depura").slideUp(300);
		} else {
			//$("#desde").focus();
			$("#depura").slideDown(300);
		}
    });
	
	
	$("#qCiudad").change(function() {
		console.log("qCiudad.change")
		//var i = $(".btCiudad").index($(this)) + 1;
		
		if (qCiudadOK()) {
			EnviarDiapositivas();
			preguntaSiguiente(1);
		}
		return false;
	})
	$("#qCiudad_JAVIER").change(function() {
		//var i = $(".btCiudad").index($(this)) + 1;
		if( $("#qCiudad").val().length < 1){
			$(".depura").addClass("activo");
			$(".depura").text("hay que rellenar campo");
			//alert("vacio")
		} else {
			$(".tit_busqueda").text($("#qCiudad").val());
			preguntaSiguiente(1);
			//alert("relleno")
		}
	})
	
	$("#qCiudad").keydown(function (e) {
		//console.log("qCiudad keydown [" + e.keyCode + "]")
        if (e.keyCode == 13) { 
			if ( $.trim($("#qCiudad").val()).toLowerCase() == $.trim($("#ciudad-filtro").val()).toLowerCase() ) {
			//if ( $.trim($("#qCiudad").val()).toLowerCase() == $.trim($("#frmInfo_busq").val()).toLowerCase() ) {	
				console.log("qCiudad: sin cambios");
				preguntaSiguiente(1);
				
			} else {
				EnviarDiapositivas();
				if (qCiudadOK()) {
					if (RangoOK()) {
						preguntaSiguiente(1);
						//$("#desde").focus();
					} else {
						preguntaSiguiente(1);
						$("#depura").slideDown(300);
						//$("#desde").focus();
						return false;
					}
				
				} else {
					$("#depura").slideDown(300);
				}
				
			}
			return false;
			//
			e.preventDefault();
		}
    });
	
	
	
});
</script>
<div class="divPreguntas">
	<button type="button" class="close" id="CloseDiapo"><span aria-hidden="true">×</span></button>
	<div class="contTodo">
		<div id="cont01" class="cont fCiudad">
			<label for="qCiudad">¿En qué ciudad?</label>
			<div> 
				<span class="icon-location"></span>
				<input id="qCiudad" type="text" class="qCiudad" >
				<a href="#" class="btn transparente btCiudad pull-right" ><span class="icon-arrow-right2"></span></a> 
			</div>
			<!-- div class="depura">hola</div -->
		</div><!--  : contenedor 1   -->
		
		<div id="cont02" class="cont fMetros">
			<label for="">¿Qué M<sup>2</sup> buscas?</label>
			<div class="periodo">
				<div class="bl47">
					<span class="icon-arrow-right"></span> 
					<input  type="text" class="" id="desde" placeholder="desde...">
				</div>
				<div class="bl47">
					<span class="icon-arrow-left  icon-right"></span>         
					<input  type="text" class="" id="hasta" placeholder=" hasta">
				</div>
			</div>
			<a href="#" class="btn transparente btCiudad pull-right"><span class="icon-arrow-right2"></span></a><!--btCiudad-->
			<!-- div class="depura">hola</div -->
		</div><!--  : cont02   -->
		
		<div id="cont03" class="cont fFiltros">
			<label for="qFiltros">¿Más filtros?</label>
			<div class=""> 
				<a href="#" class="btn blancoHover col-xs-5 btCiudad">SI</a> <a href="#" class="btn blancoHover col-xs-5 col-xs-offset-1 btCiudad">NO</a> 
			</div>
			<!-- div class="depura">hola</div -->
		</div><!--  : contenedor 1   -->
	</div> <!--  : contTodo   --> 
	
    <div id="depura"></div>
	<div class="navPuntos">
		<span class="checked"></span>
		<span></span>
		<span></span>
	</div>
    
</div>
			<div id="myMap" class="myMap"></div>
            <div class="divDisponMapa" id="myMapDisp"></div>
            <div class="dev" style="padding:4px; display:none;">
            	<span id="map-zoom"></span> // <span id="map-bounds"></span>
            </div>
            <div class="dev" style="padding:4px; display:none;">
            	<!--
            	
            	<input type="button" value="filtros" onClick="btSubmenu($('#verSubmenu'))" class="btn btn-sm"> &nbsp; 
            	<input type="button" value="xx" onClick="xx();" class="btn btn-sm"> &nbsp; 
                <input type="button" value="xx" onClick="xx();" class="btn btn-sm"> &nbsp; 
                -->fit: 
                <input type="button" value="ini" onClick="f_bounds_ini();" class="btn btn-sm"> &nbsp; 
                <input type="button" value="spain" onClick="f_bounds_spain();" class="btn btn-sm"> &nbsp; 
                <input type="button" value="edificios" onClick="f_bounds_edificios();" class="btn btn-sm"> &nbsp; 
                // &nbsp; 
                block: 
                <input id="blockButtonDef" type="button" value="default" class="btn btn-sm blancoHover"> &nbsp; 
                <input id="blockButtonActual" type="button" value="actual" class="btn btn-sm blancoHover"> &nbsp; 
                <input id="blockButton1" type="button" value="block 1" class="btn btn-sm blancoHover"> &nbsp; 
                <input id="blockButton2" type="button" value="block 2" class="btn btn-sm blancoHover"> &nbsp; 
                <input id="unblockButton" type="button" value="unblock" class="btn btn-sm blancoHover">
            </div>
		</div>
		<div class="tab-pane " id="list">
        	
			<div class="caja-operaciones">
            	
            	<div class="divDispon clearfix">
                	<div class="dispTitu">  <!--col-sm-8     -->
                        <table class="tbDispon">
                        <thead>
                            <tr class="cabeza">
								
                                <th class="tbDisp-Plta">Planta</th>
                                <th class="tbDisp-Tipo">Tipo</th>
                                <th class="tbDisp-Min"><a href="javascript:ordenar('min');" data-field="min">M&iacute;n</a></th>
                                <th class="tbDisp-Max"><a href="javascript:ordenar('max');" data-field="max">M&aacute;x</a></th>
                                <th class="tbDisp-Renta">Renta<br>Salida</th> 
                                <th class="tbDisp-Fecha">@Fecha</th> 
                            </tr>
                        </thead>
                        </table>
                	</div>
                    <form name="frm_titulos" id="frm_titulos" method="post" action="/articulos/">
                    <div id="div_titulos"><!--include virtual="/disponibilidad/titulos.asp" --></div>
                    </form>
            	</div>
            </div>
            
		</div>
	</div>
    
</div><!-- // PwTabs --> 
  
			</div>
		</section>
        
	</div>
    <div class="container">
<div class="row comunicacion"> <!-- * comunicacion  -->
	<div class="col-sm-4">
    	<div class="ico"><img src="/img/telf.png"></div>
    	<h5>¿tienes alguna duda?</h5>
    	<h5>¿Quieres una demo?</h5>
    </div>
    <div class="col-sm-4">
		<div class="ico"><img src="/img/suscr.png"></div>
    	<h5><a href="mailto:pw@propertyweb.eu?subject=Solicitud de alta a PW Flash&body=Deseo comenzar a recibir diariamente PW Flash en mi email.">suscríbete a nuestro PW Flash</a></h5>
    </div>
    <div class="col-sm-4">
		<div class="ico"><img src="/img/iphone.png"></div>
    	<h5>ahora en tu smartphone</h5>
        <h6>Toda la información favorita</h6>
	</div>
    
    
    
</div>
<!--  comunicación  -->

<div class="row grupoPW"><!-- * grupoPW  -->
	<div class="col-sm-5 col-sm-push-7">
    	<div class="andy clearfix">
            <div class="foto-andy"><img src="/_inc/javier/img/logos/andy02.jpg"></div>
            <div class="txt-andy">
                <p class="mencion">    "Pero siempre será necesario el consejo de profesionales"</p>
                 <p  class="extracto">Extracto del periódico Expansión 12/09/2002</p>
                <p class="fundador">Andy Godwin BSC (HONS) (EST MAN) MRICS <br>
            fundador de PropertyWeb
            en 1995 y propietario</p>
                </div>
            </div>
        </div>
    <div class="col-sm-7 col-sm-pull-5 empresas"><!--  empresas  -->
    
        <p >Propertyweb es un servicio de información inmobiliaria sobre el mercado Español con base de datos y un punto de contacto entre inversores, promotores,
    agencias, bancos, fondos y particulares.</p>
	<div class="logos">
    	<span><img src="/_inc/javier/img/logos/easylogo-02.png"></span>
    	<span><img src="/_inc/javier/img/logos/showtime-02.png"></span>
    	<span><img src="/_inc/javier/img/logos/logo03.png"></span>
    	<span><img src="/_inc/javier/img/logos/t4aclogo-02.png"></span>
    	<span><img src="/_inc/javier/img/logos/thecomcomlogo-02.png"></span>
    </div>
    </div>
</div>
<!--  grupoPW  -->


<footer class=""><!-- style="margin-right:0px" * mapa  -->
	<nav class="mapaFo">
        <p class="" >
            <a href="/actualidad/" class="enlace_blanco" style="color:white;">Actualidad Inmobiliaria</a> 
            <a href="/estudios/" class="enlace_blanco" style="color:white;">Estudios de Mercado</a> 
            <a href="/dealanalysis/" class="enlace_blanco" style="color:white;">Deal Analysis</a>
            <a href="/demandas/" class="enlace_blanco" style="color:white;">Anuncios de Demandas</a>
        </p>
        <p class="" >
            <a href="/inversores/" class="enlace_blanco" style="color:white;">Inversores</a> 
            <a href="/vencimientos/" class="enlace_blanco" style="color:white;">Posibles Vencimientos de Contratos</a> 
            <a href="/subastas/" class="enlace_blanco" style="color:white;">Subastas/Concursos</a>
        </p>
        <p class="" >
        <span class="mapaInfo">Info:</span>
            <a href="#" class="enlace_blanco" style="color:white;">Inmuebles</a> 
            <a href="#" class="enlace_blanco" style="color:white;">Centros Comerciales</a>
            <a href="#" class="enlace_blanco" style="color:white;">Hoteles</a> 
            <a href="#" class="enlace_blanco" style="color:white;">Empresas</a>
        </p>
	</nav>
</footer>
<!-- fn mapa  -->


<div class="row grupoPW"><!-- * grupoPW_LOPD  -->
        <p style="font-size:smaller;" align="justify">CONFIDENCIALIDAD. Recuerde que todos sus datos serán tratados con la máxima confidencialidad según las vigentes leyes 15/1999 de protección de datos de carácter personal (LOPD) y 34/2002 de Servicios de la sociedad de la información y de comercio electrónico (LSSI-CE).</p>
        <p style="font-size:smaller;" align="justify">Su dirección de correo electrónico junto a los demás datos personales que Ud. nos ha facilitado, constan en un fichero responsabilidad de PROPERTY WEB S.L. cuyas finalidades son mantener la gestión de las comunicaciones que como Usuario, Cliente o que como resultado de nuestra relación profesional o de colaboración se deriven, o para la gestión y atención de los correos entrantes y de las peticiones de información o sugerencias que se formulen a través de nustra web, siempre al amparo de LOPD.</p>
	<p style="font-size:smaller;" align="justify">Podrá ejercer sus derechos de acceso, rectificación, cancelación y oposición ante el Responsable del Fichero en la dirección lopd@propertyweb.eu, debiéndose identificar mediante DNI o equivalente, indicando en el asunto “PROTECCIÓN DE DATOS”. Si no desea recibir más información vía Email nuestra, conforme a la LSSI-CE, le rogamos que nos devuelva este correo indicando en el asunto ‘BAJA’.
</p>

</div>
<!--  grupoPW_LOPD  -->


</div> <!-- fn container  -->
<script>
	/**********************************************/
	var datos_mapa = "";
	var datos_cargados = false;
	
	
		//opciones = {zoom: 6, center: {lat: 40.45509438392602, lng: -3.692486281662004}};	//peninsulas
		opciones = {zoom: 4, center: {lat: 36.095226722498644, lng: -6.59621130000005}};	//europa
		//opciones = {zoom: 4, center: {lat: 40.50785648293567, lng: -3.692621014788756}};	//mad
		//opciones = {zoom: 4, center: {lat: 41.434695065809805, lng: 2.135699999999929}};	//bcn
	
	var map = new google.maps.Map(document.getElementById("myMap"), opciones );
	console.log("cargando mapa...")
	//$("#myMap").block(block_opts);
	
	var bounds_all = new google.maps.LatLngBounds();
	var bounds = new google.maps.LatLngBounds();
	
	google.maps.event.addListener(map, "bounds_changed", function() {
		if (act_map.zoom==map.getZoom() & act_map.lat==map.getCenter().lat() & act_map.lng==map.getCenter().lng()) {return}	//act_zoom
		if (map.getZoom()==0) {
			return false;
		}

		if (cargando) {
			console.log("bounds_changed cancelado (cargando)");
			return false;
		}

		$("#map-bounds").html(map.getBounds().toString());
		$("#map-zoom").html(map.getZoom());
		
		act_map.zoom = map.getZoom();
		act_map.lat = map.getCenter().lat();
		act_map.lng = map.getCenter().lng();
		
		//$("#frm_preguntas input[name='lat']").val(act_map.lat);
		//$("#frm_preguntas input[name='lng']").val(act_map.lng);
		//$("#frm_preguntas input[name='zoom']").val(act_map.zoom);
		
		//console.log("counter < %= counter %>", datos_mapa)
		
		
		if (map.getZoom()<13) {
			if (datos_mapa=="boxes") {
				//console.log(".getZoom()<13");
				OcultaBoxes();
				MuestraMarkers();
			}
			
		} else {				
			if (datos_mapa=="markers") {
				//console.log(".getZoom()>=13");
				OcultaMarkers();
				MuestraBoxes();	
			}
		};
		
	})
	
	google.maps.event.addListener(map, "idle", function() {
		if (!cargando) {
			return false;
		}
		
		var tt0 = new Date();
	  	
		//CargarDatos();
		
		var tt1 = new Date();
		console.log("idle:", tt1-tt0 + " ms");
		
	})
	
	/**********************************************/
	
	
	function recolocarContador() {
		var window_top = $(window).scrollTop();
		var div_top = $("#sticky-marcador").offset().top;
		if (window_top > div_top) {
			//alert("salta")
		   $(".divCajaCheck").addClass("stick");
		} else {
		   $(".divCajaCheck").removeClass("stick");
		}
	}
	
	$(window).scroll(recolocarContador);
	recolocarContador();
	
	function sel_inm(inm) {
		//console.log("sel_inm", inm);
		$("#chkDisp" + inm).click();
		//mapalista(inm);
		return false;
	}
	
	function CargarDatos() {
		//alert("cargando !");
		var t0 = new Date;
		if (cargando) {
			console.log("CargarDatos: cancelado (cargando=true)");
			return false;
		}
		var tmp_data = $("#frm_preguntas").serialize();
		if (frm_data==tmp_data) {
			console.log("CargarDatos: cancelado (frm_preguntas sin cambios)");
			return false;
		}
		
		//console.log("CargarDatos");
		$("#myMap").block(block_opts);
		cargando = true;
		frm_data = tmp_data;
		//map.setCenter({lat: 40.45509438392602, lng: -3.692486281662004});
		//map.setZoom(6);
		
		$("#myMapDisp.divDisponMapa").hide("fast", "", function() {$("#myMapDisp").html("")});
		//if (poligono) poligono.setMap(null);
		
		$.each(markerList, function(ii, marker) {
			marker.setMap(null);
		});
		$.each(infoboxesList, function(ii, infobox) {
			//console.log("close" + ii, infobox)
			infobox.hide();
			infobox.close;
		});
		markerList = [];
		infoboxesList = [];
		
		inmuebles = [];
		seleccionados = [];
		
		//$("#div_titulos").html("");
		cargando = true;
		
		if ($("#frmInfo_disp_tab").val()=="list") {
			reload_map = true;
			console.log("tabmap <> map => reload_map=" + reload_map);
		}
		
		$.ajax({
			url: "/disponibilidad/data/ajax.asp",
			data: $("#frm_preguntas").serialize(),
			type: "POST",
			success: function(recibe) {
				//rentas_todas = $.parseJSON(recibe)
				$("#div_titulos").html(recibe);
				generar();
				$("#cmd-cargar").addClass("blancoHover");
				//$("#myMap").unblock();	//ya desbloqueamos al terminar carga ¿?
				if ($("#id_subzona").val()!="") {
					EdificiosSubzona();
				}
			},
			error: function(xhr, status, err) {
				console.log("ERR: " + err)
			}
		});
		
		var t1 = new Date();
		console.log("CargarDatos:", t1-t0 + " ms");
		
		
		return false;
	}
	
	function CambiaLocalidad() {
		console.log("CambiaLocalidad")
		//$("#zona>option").each(function(index, elto) {
		//	$(elto).prop("selected", null)
		//});
		map.setCenter(opciones.center);
		map.setZoom(opciones.zoom);
		
		CargaSubzonas();
		CargaAgencias();
		$("#id_zona").val("");
		$("#zona").val("");
		
		LimpiaCalles();
		
		if ($("#ciudad-filtro").val().trim().toLowerCase()=="madrid" | $("#ciudad-filtro").val().trim().toLowerCase()=="barcelona") {
			$("#filtrosDisponibilidad").show();
		} else {
			$("#filtrosDisponibilidad").hide();
		}
		
		CargarDatos();
		
	}

	function CargaSubzonas() {
		$("#id_subzona").val("");
		$("#subzona").val("");
		//console.log("CargaSubzonas", $("#frm_preguntas").serialize());
		$("#li-subzonas").load(
			"/disponibilidad/data/ul_subzonas.asp", 
			$("#frm_preguntas").serialize(), 
			function(recibe) {
				//console.log("li-subzonas, recibido")
			}
		);
	}
	
	function CargaAgencias() {
		//console.log("CargaAgencias");
		$("#dropdown-agencias").load(
			"/disponibilidad/data/select_agencias.asp", 
			$("#frm_preguntas").serialize(), 
			function(recibe) {
				$("#dropdown-agencias").fnSelectDrop();
				$(window).on("resize", function(){ $("#dropdown-agencias").fnSelectDrop();});
				//$(".selectDrop").fnSelectDrop();/*"red"*/
				//$(window).on('resize', function(){ $(".selectDrop").fnSelectDrop();}); /*"yellow"*/
			}
		);
	}
	
	function CambiaZona(id) {
		//var xxx = $($("#ul-zonas>li[class='active']>a")[0]).data("value");
		//console.log("CambiaZona", xxx)
		
		$("#id_zona").val( id );
		var z = $("#ul-zonas>[data-id='" + id + "']>a").text();
		$("#zona").val( z );
		
		$("#id_subzona").val("");
		$("#subzona").val("");
		
		if (poligono) poligono.setMap(null);
		var tmp_coords = [];
		$.each(markersZona, function(ii, marker) {
			marker.setMap(null);
		})
		markersZona = [];
		
		CargarDatos();
	}
	
	function EdificiosSubzona() {
		console.log("EdificiosSubzona", $("#id_subzona").val());
		var ids = [];
		$.each($(".dispA"), function (ii) {
			ids.push($(this).data("id"));
		})
		var datos = { id: $("#id_subzona").val(), ids: ids.join(",") };
		//console.log(ids);
		
		$.ajax({
			url: "/disponibilidad/data/subzona-edificios.asp",
			data: datos,
			type: "POST",
			success: function(recibe) {
				//console.log(recibe);
				counter = 0;
				var points = $.parseJSON(recibe);
				$.each(points, function(ii, punto) {
					//console.log(ii, punto);
					var myLatlng = new google.maps.LatLng(punto.lat, punto.lng);
					var marker = new google.maps.Marker({
						map: map, 
						
						visible:true,
						position: myLatlng,
						icon: "/img/mapa.png"
						
					});
					markersZona[counter] = marker;
					
					counter++;
				});
			}
		});
	}
	
	function CambiaSubzona(id) {
		//xxx = $("#ul-subzonas>li[class='active']>a")[0];
		//console.log("CambiaSubzona");
		//console.log(id);
		
		$("#id_subzona").val( id );
		var sz = $("#ul-subzonas>[data-id='" + id + "']>a").text();
		//console.log("subzona", id, sz)
		$("#subzona").val( sz );
		$("#id_zona").val("");
		$("#zona").val("");
		
		//CargarDatos();
		
		if (poligono) poligono.setMap(null);
		var tmp_coords = [];
		console.log("CambiaSubzona", markersZona.length)
		$.each(markersZona, function(ii, marker) {
			marker.setMap(null);
		})
		markersZona = [];
		
		if (id=="") {
			console.log("sin subzona")
			return false;
		}
		var nbounds = new google.maps.LatLngBounds();
		//nbounds = map.getBounds();
		
		$.ajax({
			url: "/disponibilidad/data/subzonas-coordenadas.asp",
			data: "id=" + id,
			type: "POST",
			success: function(recibe) {
				//console.log(recibe);
				puntos = $.parseJSON(recibe);
				$.each(puntos, function(ii, punto) {
					//console.log(ii, punto);
					tmp_coords.push(punto);
					var p = new google.maps.LatLng(punto);
					//console.log(nbounds);
					nbounds.extend(p);
				});
				//console.log(tmp_coords);
				
				poligono = new google.maps.Polygon({
					paths: tmp_coords,
					strokeColor: "#000000",	//sz.color_zona, // "blue"
					strokeOpacity: .9,
					strokeWeight: 1,
					fillColor: "#52aaec",
					fillOpacity: 0.7  //0.2
				});
				poligono.setMap(map);
				map.fitBounds(nbounds);
				
				//EdificiosSubzona();
				
				CargarDatos();
				
				
			},
			error: function(xhr, status, err) {
				console.log("ERR: " + err)
			}
		});
		
	}
	
	function f_bounds_spain() {
		console.log("bounds_spain: NADA");
		//console.log(bounds_spain);
		//map.fitBounds(bounds_spain);
	}
	function f_bounds_ini() {
		//console.log("opciones.center")
		map.setCenter(opciones.center);
		//map.panTo(opciones.center);
		map.setZoom(opciones.zoom);
	}
	function f_bounds_edificios() {
		if (inmuebles.length==0) {
			console.log("sin edificios");
			return false;
		}
		var tmp_bounds = new google.maps.LatLngBounds();
		$.each(inmuebles, function(ii, inmueble) {
			var myLatlng = new google.maps.LatLng(inmueble.lat, inmueble.lng);
			tmp_bounds.extend(myLatlng);
			map.fitBounds(tmp_bounds);
			//map.panToBounds(tmp_bounds);
		});
		//map.fitBounds(tmp_bounds);
		//map.panToBounds(tmp_bounds);
	}
	
	function f_ver_filtros() {
		btSubmenu($('#verSubmenu'));
	}
	
	function CiudadDisponible(ciudad) {
		for (var i = 0; i < localidades.length; i++) {
			//console.log(i, localidades[i])
			if (localidades[i].localidad == $.trim(ciudad).toUpperCase()) {
				return true;
			}
		}
		return false;
	}
	
	function generar() {
		//if (!cargando) {
		//	console.log("generar CANCELADO (!cargando)");	
		//	return false
		//};
		
		counter=0;
		var t0 = new Date;
		
		//actZoom = map.getZoom();
		//console.log("sql_inmuebles: ")
		
		//bounds_all = new google.maps.LatLngBounds();
		$.each(inmuebles, function(ii, inmueble) {
			if ( inmueble.lat==null ) {
				//var listItem = $("<li/>").text(inmueble.id + ', ' + inmueble.nombre);
				//faltan_inmuebles++;
				//$("#faltan_inm").append(listItem);
				console.log("FALTAN coordenadas: ", inmueble.id + ', ' + inmueble.nombre)
				
			} else {
				var myLatlng = new google.maps.LatLng(inmueble.lat, inmueble.lng);
				
//				if ( $("#frm_preguntas input[name='lat']").val()=="" ) {
				//	console.log("centrando mapa")
				//	bounds_all.extend(myLatlng);
				//	map.fitBounds(bounds_all);
				//	//map.panToBounds(bounds_all);
//				}
				
				var icono;
				var hoyhoy = new Date();
				var hoydd = hoyhoy.getDate();
				var hoymm = hoyhoy.getMonth()+1;
				var hoyyyyy = hoyhoy.getFullYear();

				if(hoydd<10) {
					hoydd='0'+hoydd;
				} 
				
				if(hoymm<10) {
					hoymm='0'+hoymm;
				} 

				hoyhoy = hoydd+'/'+hoymm+'/'+hoyyyyy;
				var strDF = inmueble.disponible_fecha;
				var resDF = strDF.split("/");
				var fecha_texto = resDF[2]+"-"+resDF[1]+"-"+resDF[0];
				var strDF2 = hoyhoy;
				var resDF2 = strDF2.split("/");
				var fecha_texto2 = resDF2[2]+"-"+resDF2[1]+"-"+resDF2[0];

 				ms = Date.parse(fecha_texto);
				if(Date.parse(fecha_texto)<Date.parse(fecha_texto2)){icono="/img/ico-mapa02.png";}else{icono="/img/ico-mapa-naranja.png";}
				icono="/img/ico-mapa01.png"; // quitar esta linea para diferenciar disponibilidad futura
				//console.log("inm:"+ inmueble.id + "-"+Date.parse(fecha_texto)+" hoy:"+Date.parse(fecha_texto2));
				var marker = new google.maps.Marker({
					id: inmueble.id,
					map: map, 
					title: inmueble.nombre_completo,
					visible:false,
					position: myLatlng,
					icon:  icono
					
				});
				markerList[counter] = marker;
				
				counter++;
				
			}
			
			
		});
		
		//$(".divPreguntas").addClass("activo");
		if ($("#id_subzona").val()=="") {
			f_bounds_edificios();
		}
		AsociarDatos();
		
		actZoom = map.getZoom();
		//console.log(" mostrar desde generar: " + actZoom);
				
		if (actZoom<13) {
			MuestraMarkers();
		} else {
			//OcultaMarkers();
			MuestraBoxes();
		}	
		
		
		/*
		$.each(rentas_todas, function(jj, renta) {
			var inm = inmueble(renta.id_inmueble);
			if (inm) {
				inm.renta = { min: renta.renta_min, max: renta.renta_max, media: renta.renta_media} 
				var calc_renta = "" + inm.renta.min;
				if (inm.renta.max!=inm.renta.min) {
					calc_renta = calc_renta + "/" + inm.renta.max;
				}
				calc_renta = calc_renta.replace(".", ",");
				//calc_renta = calc_renta + " <span>&euro;/m&sup2;</sup>";
				$(".tbDisp-Renta[data-id='" + inm.id + "']").html( calc_renta )
			}
		});
		
		$.each(agentes_todos, function(jj, agente) {
			var inm = inmueble(agente.id_inmueble);
			if (inm) {
				if (!inm.agentes) inm.agentes = [];
				
				inm.agentes.push( { nombre: agente.empresa, id: agente.id_empresa, tipo: agente.tipo, logotipo: agente.logotipo} );
				
				var res = "";
				if (agente.logotipo === null) {
					if (agente.nombre=="PROPIEDAD") {
						res = "Propiedad";
					} else {
						$("#faltan_img").append( $("<li/>").text(agente.id_empresa + ', ' + agente.empresa) )
					}
					
				} else {
					img =  new Image();
					img.src = "/_inc/javier/img/empresas/" + agente.logotipo;
					images.push(img);
					
					res = '<img src="/_inc/javier/img/empresas/' + agente.logotipo + '">';
				}
				$("#inm_" + inm.id + "-intermediario").append(res);
				
			}
		});
		*/
		
		
		cargando = false;
		$("#myMap").unblock();
		
		var t1 = new Date();
		console.log("generar:", t1-t0 + " ms");
		
		$("#cmd-generar").addClass("blancoHover");
		
	}	
	
	function AsociarDatos() {
		//console.log("AsociarDatos", "CANCELADO")
		//return false;
		var t0 = new Date;
		
		if (rentas_todas) {
			$.each(rentas_todas, function(jj, renta) {
				var inm = inmueble(renta.id_inmueble);
				if (inm) {
					inm.renta = { min: renta.renta_min, max: renta.renta_max, media: renta.renta_media} 
					var calc_renta = "" + inm.renta.min;
					if (inm.renta.max!=inm.renta.min) {
						calc_renta = calc_renta + "/" + inm.renta.max;
					}
					calc_renta = calc_renta.replace(".", ",");
					//calc_renta = calc_renta + " <span>&euro;/m&sup2;</sup>";
					$(".tbDisp-Renta[data-id='" + inm.id + "']").html( calc_renta )
				}
			});
		}
		
		if (agentes_todos) {
			$.each(agentes_todos, function(jj, agente) {
				var inm = inmueble(agente.id_inmueble);
				if (inm) {
					if (!inm.agentes) inm.agentes = [];
					
					inm.agentes.push( { nombre: agente.empresa, id: agente.id_empresa, tipo: agente.tipo, logotipo: agente.logotipo} );
					
					var res = "";
					if (agente.logotipo === null) {
						if (agente.nombre=="PROPIEDAD") {
							res = "Propiedad";
						} else {
							$("#faltan_img").append( $("<li/>").text(agente.id_empresa + ', ' + agente.empresa) )
						}
						
					} else {
						img =  new Image();
						img.src = "/_inc/javier/img/empresas/" + agente.logotipo;
						images.push(img);
						
						res = '<img src="/_inc/javier/img/empresas/' + agente.logotipo + '">';
					}
					$("#inm_" + inm.id + "-intermediario").append(res);
					
				}
			});
		}
		
		var t1 = new Date();
		console.log("AsociarDatos:", t1-t0 + " ms");
		
		$("#cmd-asociar").addClass("blancoHover");
	}
	
	
	function inmueble( id ) {
		for (var i = 0; i < inmuebles.length; i++) {
			if (inmuebles[i].id == id) {
				return inmuebles[i];
			}
		}
		console.log("inmueble no encontrado: " + id);
	}
	
	function contenidoInfoBox( inmueble ) {
		var precio;
		var msg1="";
		var msg2="";
		
		var marcados = $("#frm_titulos input:checkbox:checked");
		var marcado = "";
		$.each(marcados, function(ii, val) {
			if (val.value==inmueble.id) {
				marcado = " checked";
				return false;
			}
		});
		
		
		if (inmueble.renta) {
			precio = "" + inmueble.renta.min;
			if (inmueble.renta.max!=inmueble.renta.min) {
				precio = precio + "/" + inmueble.renta.max;
			}
			precio = precio.replace(".", ",");
			precio = precio + "</span> <span>&euro;/m&sup2;</sup>";
		} else {
			msg1 = "sin rentas";
			precio = "N/D ";
		}
		
		
		if (!(inmueble.agentes) || inmueble.agentes.length==0) {
			msg2 = "sin agencia";
			//console.log("   sin agencia, id_inmueble: " + inmueble.id + ' - ' + inmueble.nombre)
		}
		if (msg1 + msg2!="") {
			if (msg1!="") { if (msg2!="") {msg2 = ", " + msg2} }
			//$("#informa").append( $("<li/>").text(inmueble.id + ' - ' + inmueble.nombre + ' : ' + msg1 + msg2) )
			//console.log( inmueble.id + ' - ' + inmueble.nombre + ' : ', msg1, msg2)
		}
		
		var res = '';
		res = res + '<div class="infoboxPosition" data-id="' + inmueble.id + '">';
		res = res + '<div class="popover top disp" id="">';
		
		res = res + '<div class="popover-check">';
		res = res + '<button type="button" id="chkMap' + inmueble.id + '" class="btn btnCheck' + marcado + '" onClick="sel_inm(' + inmueble.id + ');"></button>';
		res = res + '</div>';
		
		res = res + '<table class="popover-tbDisp" onclick="mapalista(' + inmueble.id + ')">';
		res = res + '<tbody>';
		
		
			var sup_min = inmueble.disponible_min.toLocaleString("es", { maximumFractionDigits: 0});
			var sup_max = inmueble.disponible_max.toLocaleString("es", { maximumFractionDigits: 0});
		
		
		res = res + '<tr>';
		res = res + '<td><span>min</span><span>' + sup_min + '</span></td>';
		res = res + '<td><span>max</span><span>' + sup_max + '</span></td>';
		res = res + '</tr>';
		
		res = res + '<tr>';
		res = res + '<td colspan="2"><span>Renta Salida</span><span>' + precio + '</span></td>';
		res = res + '</tr>';
		
		
		res = res + '<tr><td colspan="2">';
		if (inmueble.agentes) {
			for (var jj=0; jj<inmueble.agentes.length; jj++) {
				if (inmueble.agentes[jj].logotipo === null) {
					if (inmueble.agentes[jj].nombre=="PROPIEDAD") {
						res = res + 'Propiedad';
					} else {
						//console.log("falta img: " + inmueble.agentes[jj].nombre)
					}
				} else {
					res = res + '<img src="/_inc/javier/img/empresas/' + inmueble.agentes[jj].logotipo + '">';
				}
			};
		}
		res = res + '</td></tr>';
		
		
		res = res + '</tbody>';
		res = res + '</table>';
		
		res = res + '<div class="arrow" style="left: 47.6449%;"></div>';
		
		res = res + '</div>';
		res = res + '</div>';
		
		return(res);
	}
	
	function MuestraMarkers() {
		for (ii=0; ii<markerList.length; ii++) {
			markerList[ii].setVisible(true);
		}
		datos_mapa = "markers";
		$("#datos_mapa").val(datos_mapa);
	}
	
	function OcultaMarkers() {
		for (ii=0; ii<markerList.length; ii++) {
			markerList[ii].setVisible(false);
		}
	}
	
	function MuestraBoxes() {
		if (infoboxesList.length==0) {
			GenerarInfoBoxes();
			
		} else {
			for (ii=0; ii<infoboxesList.length; ii++) {
				infoboxesList[ii].setVisible(true);
			}
		}
		
		for (ii=0; ii<infoboxesList.length; ii++) {
			infoboxesList[ii].setVisible(true);
		}
		datos_mapa = "boxes";
		$("#datos_mapa").val(datos_mapa);
		//console.log("MuestraBoxes");
	}
	
	function OcultaBoxes() {
		for (ii=0; ii<infoboxesList.length; ii++) {
			infoboxesList[ii].hide();
		}
	}
	
	function GenerarInfoBoxes() {
		console.log("  GenerarInfoBoxes")
		var tt0 = new Date();
		for (ii=0; ii<inmuebles.length; ii++) {
			var myLatlng = new google.maps.LatLng(inmuebles[ii].lat, inmuebles[ii].lng);
			var infobox = new InfoBox({
				content: contenidoInfoBox( inmuebles[ii] ),	//document.getElementById("infobox")
				//visible:false,
				disableAutoPan: true,
				//enableEventPropagation: true,
				maxWidth: 150,
				//pixelOffset: new google.maps.Size(-40, -45),
				zIndex: 1000,
				closeBoxURL: "",
				position: myLatlng
			});
			infobox.open(map);
			
			infoboxesList.push( infobox )
			
		}
			
		var tt1 = new Date();
		console.log("GenerarInfoBoxes()", tt1-tt0 + " ms");
	}
	
	function mapalista(inm) {
		//$(".infoboxPosition[data-id='" + inm + "']").parent().css("z-index", 2000 );
		console.log("mapalista [" + inm + "]");
		/*
		$("#myMapDisp").load(
			"/disponibilidad/data/detalle_map.asp", 
			"id="+inm, 
			function(response) {
				$("#myMapDisp").show("slow");
			}
		)
		*/
		$.ajax({
			type: "POST",
			url: "/disponibilidad/data/detalle_map.asp",
			data: {'id':inm, 'secc':'disponibilidad'},
			success: function(data, txtStatus, jqSHR) {
				$("#myMapDisp").html(data);
				$("#myMapDisp").show("slow");
			}
		})
	}
	
	function ver_seleccionados() {
		//console.log("ver_seleccionados");
		OcultaMarkers();
		//MuestraBoxes();
		datos_mapa = "boxes";
		$("#datos_mapa").val(datos_mapa);
		
		for (ii=0; ii<markerList.length; ii++) {
			var chk = "#chkDisp" + $(infoboxesList[ii].content_).data("id")
			//console.log(chk, $(chk).is(":checked"))
			infoboxesList[ii].setVisible( $(chk).is(":checked") );
			markerList[ii].setVisible( $(chk).is(":checked") );
		}
	}
	
	function centerMap() {
		if (cargando) {
			console.log("centerMap: EXIT [CARGANDO]");
			return false
		} else {
			console.log("centerMap")
		}
		
		bounds = new google.maps.LatLngBounds();
		
		var marcados = $("#frm_titulos input:checkbox:checked");
		console.log(marcados)
		
		$.each(marcados, function(ii, checkbox) {
			var inm = inmueble( $(checkbox).val() )
			var myLatLng = new google.maps.LatLng(inm.lat, inm.lng);
			console.log(ii, inm.lat, inm.lng)
			bounds.extend(myLatLng);
		})
		map.fitBounds(bounds);
		//map.panToBounds(bounds);
		
		$("#map-bounds").html(map.getBounds().toString());
		$("#map-zoom").html(map.getZoom());
		
	}
	
	function FitMap() {
		console.log("FitMap");
		
		if (reload_map) {
			console.log("FitMap", "reload_map: TRUE")
			google.maps.event.trigger(map, "resize");
			
			
				console.log("set center", "def", "def", "¿?")
				//map.setCenter( {lat: 40.45509438392602, lng: -3.692486281662004} );
				//map.setZoom(6);
				
				console.log("fit map");;
				
				map.fitBounds(bounds_all);
				
			
			
			reload_map = false;
			
		}
		
		if (centrarMapa) {
			console.log("FitMap", "centrarMapa: TRUE");
			centerMap();
			centrarMapa=false;
		}
		
	}
	
	function ordenar(ord) {
		console.log("ordenar")
		
		var altura = $("#div_titulos").height();
		$("#div_titulos").css("min-height", altura + "px");
		
		if ($("#frm_preguntas input[name='orden']").val()==ord) {
			if ($("#frm_preguntas input[name='ordent']").val()=="asc") {
				$("#frm_preguntas input[name='ordent']").val("desc")
				
			} else if ($("#frm_preguntas input[name='ordent']").val()=="desc") {
				$("#frm_preguntas input[name='orden']").val("")
				$("#frm_preguntas input[name='ordent']").val("")
				
			} else {
				$("#frm_preguntas input[name='ordent']").val("asc")
				
			};
			
		} else {
			$("#frm_preguntas input[name='orden']").val(ord);
			$("#frm_preguntas input[name='ordent']").val("asc")
		}
		
		//$("#frm_preguntas").submit();
		
		var datos = $("#frm_preguntas").serialize() + "&ordenando=true"
		var sel_arr = $("#frm_titulos input:checkbox:checked");
		$.each(sel_arr, function(ii, elto) {
			datos = datos + "&dis=" + $(elto).val();
			//$("#chkDisp" + elto).click();
		})
		//console.log(datos)
		
		$.ajax({
			url: "/disponibilidad/data/ajax.asp",
			data: datos,
			type: "POST",
			success: function(recibe) {
				$("#div_titulos").html(recibe);
				$("#div_titulos").css("min-height", "");
			},
			error: function(xhr, status, err) {
				console.log("ERR: " + err)
			}
		});
		
	}
	
	
$(document).ready(function() {
	console.log("ini document.ready")
	
	$("ul.lineNavs>li>a[data-toggle='tab']").on("shown.bs.tab", function (e) {
		var tab = $(e.target).data("id");
		
		console.log("tab change - " + tab )
		$("#frmInfo_disp_tab").val(tab);
		$("#frm_titulos input[name='tab']").val( tab );
		
		
		if (tab=="map") {
			FitMap()
		}
		
	});
	
	$("ul#nav-filtros>li>a[data-toggle='tab']").on("shown.bs.tab", function (e) {
		$("#zona").val("");
		$("#subzona").val("");
		//if (poligono) poligono.setMap(null);
		//CargarDatos();
	});
	
	
	$("#blockButtonActual").click(function() {
		$("#myMap").block( block_opts ); 
	});
	$("#blockButtonDef").click(function() {
		$("#myMap").block(); 
	});
	$("#blockButton1").click(function() {
		$("#myMap").block({
			message: "<img src='/img/ajax-loader.gif'>",
			css: {
				border: "none", 
				padding: "0px", 
				backgroundColor: "none",
				opacity: .8,
				left: "0px", 
				right: "0px", 
				/*
				opacity: .5, 
				*/
				/*
				backgroundColor: "#000", 
				"-webkit-border-radius": "10px", 
				"-moz-border-radius": "10px", 

				color: "#fff" 
				*/
				width: "none"
        	},
			overlayCSS: {
				backgroundColor: "#fff",
				opacity: 0.3,
				margin: "auto"
				}
		});
	});
	
	/*   jj  */
	
	$("#blockButton2").click(function() {
		$("#myMap").block({
			css: { 
				border: "none", 
				padding: "15px", 
				backgroundColor: "#000", 
				"-webkit-border-radius": "10px", 
				"-moz-border-radius": "10px", 
				opacity: .5, 
				color: "#fff" 
        	},
			overlayCSS: { backgroundColor: "#00f" }
		}); 
	});
	$("#unblockButton").click(function() {
		$("#myMap").unblock(); 
	});
	
	CargaSubzonas();
	CargaAgencias();
	
	if (swMostrarDiapositivas) {
		if (!($(".divPreguntas").hasClass("activo"))) {
			setTimeout( function () {
				$(".divPreguntas").addClass("activo");
				//$("#qCiudad").focus();
				//CargarDatos();
				//setTimeout( function () {
				//	generar();
				//}, 1000 );
				
			}, 1000 );
		}
	}
	//setTimeout( function () {
	//	generar();
	//}, 1000 );
	
	
	
	$.ajax({
		url: "/disponibilidad/data/ciudades.asp",
		type: "POST",
		success: function(recibe) {
			localidades = $.parseJSON(recibe);
			//console.log("localidades FIN");
		},
		error: function(xhr, status, err) {
			console.log("ERR localidades: " + err)
		}
	});
	//console.log("localidades INI");
	//localidades = < %= QueryToJSON(session("connPW"), "SELECT DISTINCT localidad FROM dirs_w_inmuebles WHERE (id_tipo_inmueble = 0) AND (disponible_fecha IS NOT NULL) AND (disponible_min > 0)").Flush %>;
	//console.log("localidades FIN");
	
	CargarDatos();
	//generar();
});
CambiaLocalidad('madrid');
CambiaSubzona(84);
</script>

</body>
</html>