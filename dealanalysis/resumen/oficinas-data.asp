<table  class="tabla"> 
<thead class="">
	<tr class="filaLat-cabecera">
		<th></th>
		<th>Ops</th>
		<th>M€</th>
		<th>M<sup>2</sup></th>
	</tr>
</thead> 
<tbody  class="">

<tr class="filaLat titu">
<td><a href="#" id="op26485">Inversión/Ocup. Prop.</a></td>
	<td><%= request.Form("y") %></td>
	<td>100</td>
	<td>100</td>
</tr>

<tr class="filaLat">
	<td><a href="#" id="op2648t">Inversión</a></td>
	<td>50</td>
	<td>50</td>
	<td>50</td>
</tr> 

<tr class="filaLat verFila">
<td><a href="#" id="op2648e">Ocupaci&oacute;n Propia</a></td>
<td>50</td>
<td>50</td>
<td>50</td>
</tr> 

<tr class="filaLat titu">
	<td><a href="#" id="op26485">Take Up</a></td>
	<td>100</td>
	<td>100</td>
	<td>100</td>
</tr>

<tr class="filaLat">
	<td><a href="#" id="op2648t">Alquiler</a></td>
	<td>50</td>
	<td>50</td>
	<td>50</td>
</tr>
 
<tr class="filaLat">
	<td><a href="#" id="op2648e">Ocupaci&oacute;n Propia</a></td>
	<td>50</td>
	<td>50</td>
	<td>50</td>
</tr>

</tbody>
</table>
<% for each elto in request.Form
	%><li><%= elto %>: <%= request.Form(elto) %></li><%
next %>