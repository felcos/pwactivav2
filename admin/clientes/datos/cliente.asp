<%@ LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
pasa = false

if request.Cookies("dev")<>"" then pasa=true
if request.Cookies("licencia")("client_id")="1" then pasa=true
if request.Cookies("licencia")("client_id")="2" then pasa=true

if not(pasa) then response.Redirect("/")
%>
<link href="/lib/autocomplete/autocomplete_foldy.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/lib/autocomplete/jquery.autocomplete.js"></script>
<%
id=request.QueryString("id")
Set rs = Server.CreateObject("ADODB.Recordset")
nn = 0
%>
<div id="tab<%= id %>" style="padding:2px 0 10px 0;">
    <ul class="resp-tabs-list">
        <li>Licencias</li>
        <li>Empresa</li>
    </ul>
    <div class="resp-tabs-container">
        <div>
<table class="reg">
    <tr>
        <th style="text-align:left; width:20px;" colspan="2">licencia</th>
        <th style="width:15px;"></th>
        <th style="text-align:left; width:300px;">nombre</th>
        <th style="text-align:left; width:80px;" colspan="2">registrado</th>
        <th style="text-align:right; width:120px;" nowrap="nowrap">&uacute;ltimo acceso</th>
        <th style="width:10px;"></th>
        <th></th>
    </tr>
<% 
sql = "SELECT * FROM licencias_control WHERE ID_EMPRESA=" & id & " ORDER BY NUMERO_LICENCIA DESC"
rs.Open sql, session("connPWAcesos")

do while not rs.eof 
	nn=nn+1
	
	url_usuario = "uid=" & rs("id_empresa") & "&u=" & rs("usuario")
	url_licencia = url_usuario & "&lid=" & rs("id") &  "&l=" & rs("nombre")
	
	avisar=false
	if isnull(rs("ultimo_acceso")) or datediff("d", rs("ultimo_acceso"), date)>15 then avisar=true
	%>
	<tr <% if avisar then %>class="avisar"<% end if %>>
		<td style="text-align:right;"><%= rs("NUMERO_LICENCIA") %></td>
        <td style="text-align:right;" class="peq">/<%= rs("NUM_LICENCIAS") %></td>
        <td class="med"></td>
		<td><a href="/admin/accesos/cliente/?<%= url_licencia %>" target="_blank" ><%= rs("NOMBRE") %></a></td>
        <td class="med"><%= rs("FECHA") %></td>
        <td class="med"><%= rs("HORA") %></td>
		<td style="text-align:right;"><%= rs("ultimo_acceso") %></td>
        <td></td>
        <td class="mini"><a href="/admin/accesos/cliente/?uid=<%= rs("ID_EMPRESA") %>&u=<%= rs("USUARIO") %>&lid=<%= rs("Id") %>&l=<%= rs("NOMBRE") %>">registro</a></td>
	</tr>
    <% rs.movenext
loop
rs.close
%>
</table>
        </div>
        
        <div>
<%
for each elto in request.QueryString
	%><li><%= elto %>: <%= request.QueryString(elto) %><%
next
sql = "SELECT * FROM EMPRESAS"
%>
        </div>
    </div>
</div>
<%
set rs=nothing
%>
<script type="text/javascript">
$(document).ready(function () {
	$('#tab<%= id %>').easyResponsiveTabs({
		type: 'default', //Types: default, vertical, accordion           
		width: 'auto', //auto or any width like 600px
		fit: true,   // 100% fit in a container
		closed: 'accordion', // Start closed if in accordion view
		activate: function(event) { // Callback function if tab is switched
			//var $tab = $(this);
			//var $info = $('#tabInfo');
			//var $name = $('span', $info);

			//$name.text($tab.text());

			//$info.show();
		}
	});
	
});
</script>
