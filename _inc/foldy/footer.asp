<% if request.Cookies("config")("footer")="" then %>
<footer class="pie">
	<div class="row">
        
        <% IF 1=2 THEN %>
        <div class="grid-1 peq">head/foot: 
        <% if request.Cookies("dev")("headfoot")="" then 
            %><a href="https://www.propertyweb.eu/dev/bin/cookie_dev.asp?act=fixheadfoot" class="destaca">fix</a><% 
        else 
            %><a href="https://www.propertyweb.eu/dev/bin/cookie_dev.asp?act=unfixheadfoot" class="destaca">unfix</a><% 
        end if %>
        </div>
        
        <div class="grid-1 peq">estilos2: 
        <% if request.Cookies("dev")("estilos2")="" then 
            %><a href="https://www.propertyweb.eu/dev/bin/cookie_dev.asp?act=load_estilos2" class="destaca">load</a><% 
        else 
            %><a href="https://www.propertyweb.eu/dev/bin/cookie_dev.asp?act=unload_estilos2" class="destaca">unload</a><% 
        end if %>
        </div>
        <% END IF %>
	</div>
	<div style="clear:both;"></div>
</footer>
<% end if %>