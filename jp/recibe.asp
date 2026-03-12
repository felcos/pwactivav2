<!--
<h1>request</h1>
<p>Recepcion de datos de formularios</p>
<hr />
-->
<% if request.QueryString<>"" then %>
<p><strong>QueryString</strong>:</p>
<ul>
<% for each elto in request.QueryString %>
	<li><%= elto %>: <%= request.QueryString(elto) %></li>
<% next %>
</ul>
<% end if %>

<% if request.Form<>"" then %>
<p><strong>Form</strong>:</p>
<ul>
<% for each elto in request.Form %>
	<li><%= elto %>: <%= request.Form(elto) %></li>
<% next %>
</ul>
<% end if %>