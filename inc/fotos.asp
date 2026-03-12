<% if sFotos<>"" then %>
<!-- Add fancyBox main JS and CSS files -->
<script src="/lib/fancyBox/jquery.fancybox.js" type="text/javascript"></script>
<link href="/lib/fancyBox/jquery.fancybox.css" media="screen" rel="stylesheet" type="text/css" />

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
<style type="text/css">
	.fancybox-custom .fancybox-skin {
		box-shadow: 0 0 50px #222;
	}
</style>
<%
	sFotos=left(sFotos, len(sFotos)-1)
	lFoto=split(sFotos,"&")
%>
<p align="center">
<% for ii=0 to ubound(lFoto) 
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
	%>
<a class="fancybox" href="<%= lFoto(ii) %>" data-fancybox-group="gallery" title=""><img src="<%= lFoto(ii) %>" alt="" height="60" hspace="6" align="absmiddle" /></a>
<% next %>
</p>
<% end if %>