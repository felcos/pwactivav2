<h1>suscribe mailing</h1>
<h3>Datos recibidos</h3>
<p>QueryString:</p>
<% for each elto in request.QueryString %>
<li><%= elto %>: <%= request.QueryString(elto) %></li>
<% next %>
<hr />
<p>Form:</p>
<% for each elto in request.Form %>
<li><%= elto %>: <%= request.Form(elto) %></li>
<% next %>
<hr />
<%


%>