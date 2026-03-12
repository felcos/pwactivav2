<div class="dev mini">
Form: &nbsp; <% for each elto in request.Form 
    'if request.Form(elto)<>"" then 
		%>[<b><%= elto %></b> = <%= request.Form(elto) %>]&nbsp;<%
	'end if 
next %><br />
QueryString: &nbsp; <% for each elto in request.QueryString
    'if request.QueryString(elto)<>"" then 
		%>[<b><%= elto %></b> = <%= request.QueryString(elto) %>]&nbsp;<% 
	'end if 
next %>
</div>