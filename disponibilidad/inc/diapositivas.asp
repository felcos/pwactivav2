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