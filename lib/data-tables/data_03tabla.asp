<%@ LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<table id="example" class="display compact" cellspacing="0" width="100%">
<thead>
    <tr>
        <th></th>
        <th class="dt-head-left">Name</th>
        <th class="dt-head-left">Position</th>
        <th class="dt-head-left">Office</th>
        <th class="dt-head-left">Salary</th>
        <th class="dt-head-left">Office</th>
        <th class="dt-head-left">Salary</th>
    </tr>
</thead>
<tbody>
<%
Set rs = Server.CreateObject("ADODB.Recordset")

sql = "SELECT * FROM clientes_control WHERE (activo=1)"	
rs.Open sql, session("connPWAcesos")

nn = 0

do while not rs.eof 
	nn=nn+1
%>
<tr>
<td></td>
<td class="dt-head-left"><%= rs("NOMBRE_EMPRESA") %></td>
<td class="dt-head-left"><%= rs("EMPRESA") %></td>
<td class="dt-head-left"><%= rs("LICENCIAS_ENVIADAS") %></td>
<td class="dt-head-left"><%= rs("NUM_LICENCIAS") %></td>
<td class="dt-head-left"><%= rs("ultimo_acceso") %></td>
<td class="dt-head-left"><%= rs("ID") %></td>
</tr>
<% 
	rs.movenext
loop

rs.close
set rs=nothing
%>
</tbody>
</table>