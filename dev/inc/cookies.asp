<div class="panel-group">
	<div class="panel panel-primary">
    	<div class="panel-heading">
        	<h4 class="panel-title"><a data-toggle="collapse" href="#panel-cookies">cookies <span class="pull-right icon icon-minus"></span></a></h4>
        </div>
    	<div id="panel-cookies" class="panel-collapse collapse in">
            <ul class="list-group"><%
            for each cookie in request.Cookies 
                if cookie = "licencia" then
                    val = request.Cookies("licencia")("n")
                    val = val & "&nbsp; ("
                    val = val & request.Cookies("licencia")("u")
                    val = val & ")"
                elseif left(cookie, 1) = "_" then
                    val = ""
                else
                    val = request.Cookies(cookie)
                    val = replace(val, "&", " / ")
                end if
                
                if val<>"" then %>
                    <li class="list-group-item"><%= cookie %>: &nbsp; <span class="mini"><%= val %></span></li>
                <% end if
            next
            %></ul>
            
        </div>
	</div>
</div>