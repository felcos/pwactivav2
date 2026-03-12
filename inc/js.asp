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
	<% if request.Cookies("dev")<>"" then %>
	dimensionesPantalla();
	<% end if %>
	
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

<% if request.Cookies("licencia")("u")<>"JP" and request.Cookies("licencia")("u")<>"PW" and request.Cookies("dev")="" then %>
if (Modernizr.touchevents) {
	//console.log("touchevents.-")
} else {
	function anular() {
		//console.log("anular");
		return false;
	};
	document.oncontextmenu=anular;
	document.ondragstart=anular;
	document.onselectstart=anular;
	//document.onmousedown=anular;
	
	function derecha(e)	{
		//console.log("derecha", navigator.appName);
		if (navigator.appName == 'Netscape' && (e.which == 3 || e.which == 2)) {
			return false;
		}
		else if (navigator.appName == 'Microsoft Internet Explorer' && (event.button == 2)) {}
	}
	document.onmousedown=derecha;
}
<% end if %>

$(document).ready(function() {
	<% if request.Cookies("dev")<>"" then %>
		informaPantalla();
	<% end if %>
	
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
		
		if (rtipo=="cc" || rtipo=="hot" || rtipo=="edif" || rtipo=="ni" ) {
			//window.alert("hola");
			$("#frmInfo_busq").val("");
			$("#frmInfo").attr("action", "/info/");
			$("#frmInfo").submit();
		}	
		else
		{
			if (rtipo=="disp") {
				window.location.href = "/disponibilidad/";
			} 
			if (rtipo=="nidisp") {
				window.location.href = "/nidisp/";
			}
			
			if (rtipo=="takeup") {
				//window.alert("hola")
				window.location.href = "/takeup/";
			} 
		}

		/*if (rtipo=="edif") {
			window.location.href = "/info/";
		} 
			if (rtipo=="cc" || rtipo=="hot"  || rtipo=="ni") {
			$("#frmInfo_busq").val("");
			$("#frmInfo").submit();
		} */


		
		
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
			
			if (rtipo=="disp" || rtipo=="takeup" || rtipo=="nidisp") {
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
			content = "Ej: atenas, diagonal 00, torre litoral, generali, testa, diagonal 60, gracia 16, torre espacio, cristalia, ";
			content = content + "piramide, atica, castellana 35, hernani 59, principe de vergara 108, etc...";
			$("#frmInfo_busq").attr("placeholder", "Edificio o Dirección");
			$("#lblInfo_edif").addClass("activo");
			
		} else if (rtipo=="ni") {	
			title = "Para buscar un <span class='naranjaB'>Nave/Poligono Industrial</span>: introducir el nombre del edificio <u>o</u> el nombre de la calle con Nº.";
			content = "Ej: atenas, diagonal 00, torre litoral, generali, testa, diagonal 60, gracia 16, torre espacio, cristalia, ";
			content = content + "piramide, atica, castellana 35, hernani 59, principe de vergara 108, etc...";
			$("#frmInfo_busq").attr("placeholder", "Nave/Poligono Industrial");
			$("#lblInfo_ni").addClass("activo");
		} else if (rtipo=="nidisp") {	
			title = "Para buscar un <span class='naranjaB'>Nave/Poligono Industrial</span>: introducir el nombre del edificio <u>o</u> el nombre de la calle con Nº.";
			content = "Ej: atenas, diagonal 00, torre litoral, generali, testa, diagonal 60, gracia 16, torre espacio, cristalia, ";
			content = content + "piramide, atica, castellana 35, hernani 59, principe de vergara 108, etc...";
			$("#frmInfo_busq").attr("placeholder", "Nave/Poligono Industrial");
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
			$("#lblInfo_disp").addClass("activo");
			
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
		//if ($($("#frmInfo input:radio:checked")).val()=="nidisp") {return false}
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