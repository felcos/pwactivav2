<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
sql = "SELECT * FROM clientes_control WHERE (activo=1 AND id>2) ORDER BY ultimo_acceso DESC"	
%>
<table class="reg">
    <tr>
        <th style="text-align:left; width:15px;"></td>
        <th style="text-align:left; width:200px;">cliente</th>
        <th style="text-align:left; width:30px;">id</td>
        <th style="text-align:left;">empresa</th>
        <th style="text-align:left; width:50px;">licencias</th>
        <th style="text-align:right; width:120px;">&uacute;ltimo acceso</th>
        <th></th>
        <th style="text-align:left; width:100px;"></th>
    </tr>
<% 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, session("connPWAcesos")

nn = 0
do while not rs.eof 
	nn=nn+1
	licencias = rs("LICENCIAS_ENVIADAS") & "/" & rs("NUM_LICENCIAS")
	
	avisar=false
	if isnull(rs("ultimo_acceso")) or datediff("d", rs("ultimo_acceso"), date)>15 then avisar=true
	%>
    <tr <% if avisar then %>class="avisar"<% end if %>>
		<td align="right"><a href="/admin/clientes/datos/cliente.asp?id=<%= rs("ID") %>&e=<%= rs("id_empresa") %>&s=<%= rs("id_sucursal") %>" class="ver_detalles" id="<%= rs("ID") %>"><%= nn %></a></td>
		<td><a href="/admin/clientes/datos/cliente.asp?id=<%= rs("ID") %>&e=<%= rs("id_empresa") %>&s=<%= rs("id_sucursal") %>" class="ver_detalles" id="<%= rs("ID") %>"><%= rs("EMPRESA") %></a></td>
        <td class="peq"><a href="/admin/clientes/datos/cliente.asp?id=<%= rs("ID") %>&e=<%= rs("id_empresa") %>&s=<%= rs("id_sucursal") %>" class="ver_detalles" id="<%= rs("ID") %>"><%= rs("ID") %></a></td>
		<td><a href="/admin/clientes/datos/cliente.asp?id=<%= rs("ID") %>&e=<%= rs("id_empresa") %>&s=<%= rs("id_sucursal") %>" class="ver_detalles" id="<%= rs("ID") %>"><%= rs("NOMBRE_EMPRESA") %></a></td>
        <td style="text-align:right;"><%= licencias %></td>
		<td style="text-align:right;" <% if avisar then %>class="avisar"<% end if %>><%= rs("ultimo_acceso") %></td>
        <td></td>
        <td class="mini"><% if request.Cookies("dev")<>"" then %><a href="/admin/accesos/cliente/?uid=<%= rs("ID") %>&u=<%= rs("EMPRESA") %>" target="_blank">registro</a><% end if %></td>
	</tr>
    <tr id="row<%= rs("ID") %>" style="display:none; background-color:#EEEEEE;">
    	<td colspan="8" id="u<%= rs("ID") %>"></td>
    </tr>
    <% rs.movenext
loop 

rs.close
set rs=nothing
%>
</table>

<script language="javascript">	
$(document).ready(function(){
	$('.ver_detalles').click(function (e) {
		var id=this.getAttribute("id");
		
		var fila=document.getElementById('row'+id);
		
		if (fila.style.display=='') {
			fila.style.display='none';
		} else {
			fila.style.display='';
		};
		
		var ncelda='#u'+id;
		var celda = $(ncelda);
		
		if (celda.html()=='') {
			$.ajax({
				url: this.getAttribute("href"),
				data: '',
				beforeSend: function() {
					celda.html('<img src="/img/camera-loader.gif">');
				},
				success: function(data, status, xhr){
					celda.html(data);
				},
				error: function(xhr, status, err) {}
			});
		}
		
		//console.log($(celda).html());
		return false;
	})
})
</script>

