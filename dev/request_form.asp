<script type="text/javascript" src="/lib/jquery/jquery-1.11.3.min.js"></script>
<% for each elto in request.form 
	%><li><%= elto %>: <%= request.form(elto) %></li><%
next %>
<hr>
<script type="application/javascript">
	
	var str = "<%= request.Form("selected") %>";
	var arr = str.split(",").map(
		function(x) {
			return parseInt(x,10)
		});
	
	document.write(arr);
	document.write("<hr>");
	
	
$(document).ready(function(){
	$.each(arr, function(ii, elto) {
		console.log(ii, elto)
	})
	
})


</script>