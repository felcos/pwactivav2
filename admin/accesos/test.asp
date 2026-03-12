<% for each elto in request.Form
	%><%= elto %>:<strong><%= request.Form(elto) %></strong> &nbsp; <%
next 

if fecha="" then fecha=date
%>
<hr>
<li>yy: <%= year(fecha) %></li>
<li>month: <%= month(fecha) %></li>
<li>day: <%= day(fecha) %></li>
<li>week: <%= DatePart("ww", fecha) %></li>
