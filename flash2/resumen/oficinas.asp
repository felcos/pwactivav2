<%
r_year = request.Form("oficinas_y")
'if r_year = "" then r_year = year(date)
if r_year = "" then r_year = 2019
'if request.Cookies("dev")<>"" then r_year = 2019
%>
<div class="col-selec"> <!--  select -->
	<div class="dropdown selectDrop">
		<form id="frm_resumen_ops" name="frm_resumen_ops" action="" method="post" autocomplete="off" target="_blank">
    	    <select id="oficinas_y" name="y" class="hide">
				<% for yy=2019 to 1996 step -1 %>
					<option <% if yy=r_year then %>selected<% end if %>><%= yy %></option>
				<% next %>
			</select>
            <input type="hidden" name="oficinas_yy" value="<%= r_year %>" id="oficinas_yy">
            <!-- input type="submit" value="submit"/ -->
        </form>
		<div class="dropdown-toggle form-control selecFecha" data-toggle="dropdown" id="paisDrop" aria-expanded="false">
			<span class="paisNombre"><%= r_year %></span>
			<span class="icon-arrow-down2 separadorSpan"></span>
		</div>
		
		<ul class="dropdown-menu" role="menu"></ul>
	</div>
</div> <!-- : select -->

<div class="col-titu"> 
	<h3 class="tit_mod ">Oficinas Madrid</h3><!--<span style="font-weight:normal"></span>-->
</div>
<div class="tb-Gral-cont" id="tabla_oficinas_mad"><img src="/img/camera-loader.gif" style="margin: 24px;"/></div>

<hr>

<div class="col-titu"> 
	<h3 class="tit_mod ">Oficinas Barcelona</h3><!--<span style="font-weight:normal"></span>-->
</div>
<div class="tb-Gral-cont" id="tabla_oficinas_bcn"><img src="/img/camera-loader.gif" style="margin: 24px;"/></div>
   
<script type="text/javascript">

$(document).ready(function(){
/*
$(".cabecera-sub").on("click", function (){
	     var pepe = $(this).find("a").attr("id");
		alert(pepe);*/
/* ////   TABLA   */		
$(".filaLat").on("click", function (){   /*  para que nos de el id al pinchar  la tabla */
	     var pepe = $(this).find("a").attr("id");
});

/* ////   ESTRUCTURA Y SELECT  */	
	
fnMovil();	
$(window).resize(fnMovil);

function fnMovil() {                         /*oculta/muestra menu con css según movil/escritorio*/

	if  ($(window).width()>=750)  {     /*escritorio */
		if($("ul.dropdown-menu li").length<1){ //  IMPORTANTE:  crea elemento en ul.dropdown-menu LI de forma automatica (se podría hacer manual y quitar esta parte)
				$("#oficinas_y > option").each(function(){
					$("ul.dropdown-menu").append("<li><a href='#'> "+ $(this).text() + "</a></li>");
				 });
				$(".dropdown-menu li a").on("click",function(e){
					e.preventDefault();
					$("#paisDrop .paisNombre").text($(this).text());
					$("#oficinas_yy").val($(this).text( $("#frm_resumen_ops").submit() ));
				});
			 }
			
//			$("#oficinas_y").addClass("hide");
//			$(".selectDrop .dropdown-menu").removeClass("hide");
		} else {                 /* if (($(window).width()<=750) &&  (esMovil !=1 )) */
			$("ul.dropdown-menu").empty();    // borra elementos de ul.dropdown-menu
//			$("#oficinas_y").removeClass("hide");
//			$(".selectDrop .dropdown-menu").addClass("hide");
		}
	}


$("#oficinas_y").change(function(){
	$("#paisDrop .paisNombre").text($(this).val());
	$("#oficinas_yy").val($(this).val());
	
	$("#frm_resumen_ops").submit();
});

	
/* :: Solo para movil*/
	$(".selectDrop").on("mouseenter",function(){    //selectDrop para hacer el efecto over (movil)
		$(".selectDrop").addClass("focus");
	});
	$(".selectDrop").on("mouseleave",function(){
			$(".selectDrop").removeClass("focus");
	});
	

/*  si se utiliza el DropSelect se puede suprimir este script que sirve solo para que se vea la flechita en android 4.l*/
$(function () {
  var nua = navigator.userAgent
  var isAndroid = (nua.indexOf('Mozilla/5.0') > -1 && nua.indexOf('Android ') > -1 && nua.indexOf('AppleWebKit') > -1 && nua.indexOf('Chrome') === -1)
  if (isAndroid) {
  //$('select.form-control').removeClass('form-control').css('width', '100%');
    $('select.form-control').removeClass('form-control').css({"width": "100%"}); //cualquier estilo no lo coge
	$('.form-control.selectCaja').addClass('androidBr');   //para que no añada sombra y haga bien el scroll
	$('.form-control.selectCaja ul').removeClass('selectTipo').addClass('selectAnd'); ; //para que no haga over
  }
})


/* ////  interactividad */

	
$(".vermas").click(function(){   
	$(".verFila").toggleClass("verFilaDown");
	//$(this).next().fadeToggle();
	//alert(".verFila a");
	});
	

})<!--:jQ-->


$(document).ready( function() {
	$("#frm_resumen_ops").submit(function(){
		$.ajax({
			type: "POST",
			url: "/dealanalysis/resumen/oficinas-data.asp",
			data: $(this).serialize() + "&ubic=mad",
			beforeSend: function(){
				//$("#tabla_oficinas_mad").html("<img src='/img/camera-loader.gif' style='margin: 24px;'/>");
			},
			success: function(data, status, xhr){
				$("#tabla_oficinas_mad").html(data);
			},
			error: function(xhr, status, err) {
				$("#tabla_oficinas_mad").html(status + ": " + err);
			}
		});
		
		$.ajax({
			type: "POST",
			url: "/dealanalysis/resumen/oficinas-data.asp",
			data: $(this).serialize() + "&ubic=bcn",
			beforeSend: function(){
				//$("#tabla_oficinas_bcn").html("<img src='/img/camera-loader.gif' style='margin: 24px;'/>");
			},
			success: function(data, status, xhr){
				$("#tabla_oficinas_bcn").html(data);
			},
			error: function(xhr, status, err) {
				$("#tabla_oficinas_bcn").html(status + ": " + err);
			}
		});
		
		return false;
	});
});
</script>