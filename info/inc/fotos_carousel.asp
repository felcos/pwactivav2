<% if sFotos<>"" then
	sFotos=left(sFotos, len(sFotos)-1)
	lFoto=split(sFotos,"&")
	%>
	<link href="/css/css-bootstrap/carousel-javier.css" rel="stylesheet" type="text/css">
	<style type="text/css">
		.fancybox-custom .fancybox-skin {
			box-shadow: 0 0 50px #222;
		}
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
	
			$('.fancybox').fancybox({
				padding: 0,
	
				openEffect : 'elastic',
				openSpeed  : 150,
	
				closeEffect : 'elastic',
				closeSpeed  : 150,
	
				closeClick : true,
	
				helpers : {
					overlay : null
				}
			});
	
			/*
			 *  Button helper. Disable animations, hide close button, change title type and content
			 */
	
			$('.fancybox-buttons').fancybox({
				openEffect  : 'none',
				closeEffect : 'none',
	
				prevEffect : 'none',
				nextEffect : 'none',
	
				closeBtn  : false,
	
				helpers : {
					title : {
						type : 'inside'
					},
					buttons	: {}
				},
	
				afterLoad : function() {
					this.title = 'Image ' + (this.index + 1) + ' of ' + this.group.length + (this.title ? ' - ' + this.title : '');
				}
			});
	
			/*
			 *  Thumbnail helper. Disable animations, hide close button, arrows and slide to next gallery item if clicked
			 *  Media helper. Group items, disable animations, hide arrows, enable media and button helpers.
			*/
			
		});
	</script>
	<div id="carousel01" class="carousel slide" data-pause="true" ><!--data-ride="carousel"  carousel-example-generic-->
	<ol class="carousel-indicators">
		<% 
		for ii=0 to ubound(lFoto)
			if instr(lFoto(ii), "/")>0 then
				lFoto(ii)="/fotos/" & lFoto(ii)
			else
				if instr(lFoto(ii), "\")=0 then
					lFoto(ii) = replace(lFoto(ii), "\", "/")
					lFoto(ii)="/fotos/inmuebles/" & lFoto(ii)
				else
					lFoto(ii)="/fotos/" & lFoto(ii)
				end if
			end if
			
			clase = ""
			if ii=0 then clase = "active"
			%><li data-target="#carousel01" data-slide-to="<%= ii %>" class="<%= clase %>"></li><% 
		next %>
	</ol>
	<div class="carousel-inner" role="listbox">
		<% for ii=0 to ubound(lFoto)
			clase = ""
			if ii=0 then clase = "active"
			
			img = lFoto(ii)
			archivo = lFoto(ii)
			
			ruta = server.MapPath("/fotos/inmuebles/") & "\" 
			ruta_f = "/fotos/inmuebles/"
			
			'set arch = fso.GetFile(ruta & archivo)
			'set myImg = loadpicture(ruta & archivo)
			
			my_num = Int((rnd*1000))
			
			img = "/lib/showThumb.aspx?maxsize=450&amp;img=" & img & "&amp;rnd=" & my_num
			'img = ruta_f & archivo
			
			%><div class="item <%= clase %>"><a class="fancybox" href="<%= lFoto(ii) %>" data-fancybox-group="gallery" title=""><img src="<%= img %>" alt=""></a></div><% 
		next %>
	</div>
	<a class="left carousel-control" href="#carousel01" role="button" data-slide="prev"> <span class="icon-prev icon icon-arrow-left" aria-hidden="true"></span><!-- icon-prev ¿?--> 
	<span class="sr-only">Anterior</span> </a> <a class="right carousel-control" href="#carousel01" role="button" data-slide="next"> <span class="icon-next icon icon-arrow-right" aria-hidden="true"></span><!-- icon-prev ¿?--> 
	<span class="sr-only">Siguiente</span> </a> </div>
<% end if %>