<div class="panel panel-<% if request.Cookies("dev")="" then %>info<% else %>danger <% end if %>">
    <div class="panel-heading">
    	<span style="float:right;" class="peq"><% 
		if request.Cookies("dev")="" then %><a href="/dev/bin/cookie_dev.asp?act=crear">crear</a><% 
		else %><a href="/dev/bin/cookie_dev.asp?act=eliminar">eliminar</a><% 
		end if
		%></span>
    	cookie. <strong>DEV</strong>
    </div>
	
<% if request.Cookies("dev")="" then %>
    <div class="panel-body">No existe</div>
<% else %>
    
    <ul class="list-group">
    	<li class="list-group-item"><!-- sql -->
            <div class="row">
                <div class="col-xs-4">sql:</div>
                <div class="col-xs-3"><% if request.Cookies("dev")("sql")<>"" then %>visible<% else %> - <% end if %></div>
                <div class="col-xs-5"><% 
if request.Cookies("dev")("sql")="" then 
	%><a href="/dev/bin/cookie_dev.asp?act=mostrar_sql">mostrar</a><% 
else 
	%><a href="/dev/bin/cookie_dev.asp?act=ocultar_sql">ocultar</a><% 
end if %></div>
            </div>
        </li>
        
        <li class="list-group-item"><!-- request -->
            <div class="row">
                <div class="col-xs-4">request:</div>
                <div class="col-xs-3"><% if request.Cookies("dev")("request")<>"" then %>visible<% else %> - <% end if %></div>
                <div class="col-xs-5"><% 
if request.Cookies("dev")("request")="" then 
	%><a href="/dev/bin/cookie_dev.asp?act=mostrar_request">mostrar</a><% 
else 
	%><a href="/dev/bin/cookie_dev.asp?act=ocultar_request">ocultar</a><% 
end if %></div>
            </div>
        </li>
        
        <li class="list-group-item"><!-- log. accesos -->
            <div class="row">
                <div class="col-xs-4">css bs:</div>
                <div class="col-xs-3"><% if request.Cookies("dev")("css")="" then %>-<% else %>cargada<% end if %></div>
                <div class="col-xs-5"><% if request.Cookies("dev")("css")="" then %><a href="/dev/bin/cookie_dev.asp?act=css_bs">load</a><% else %><a href="/dev/bin/cookie_dev.asp?act=css_none">x</a><% end if %></div>
            </div>
        </li>
        
        <li class="list-group-item"><!-- log. accesos -->
            <div class="row">
                <div class="col-xs-4">log. accesos:</div>
                <div class="col-xs-3"><% if request.Cookies("dev")("log")<>"" then %><strong><font color="#990000">NO log</font></strong><% else %>log<% end if %></div>
                <div class="col-xs-5"><a href="/dev/bin/cookie_dev.asp?act=log">log</a>&nbsp;|&nbsp;<a href="/dev/bin/cookie_dev.asp?act=no_log">no-log</a>&nbsp;<% if request.Cookies("dev")("log")<>"" then %><a href="/dev/bin/cookie_dev.asp?act=log">x</a><% end if %></div>
            </div>
        </li>
    </ul>

	<div class="panel-footer">
		<% for each elto in request.Cookies("dev")
            if request.Cookies("dev")(elto)<>"" then 
                %><%= elto %>: <%= request.Cookies("dev")(elto) %> // <%
            end if
        next %>
    </div>
<% end if %>

</div>