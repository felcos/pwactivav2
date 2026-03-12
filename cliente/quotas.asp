<style>
.tbl-quotas tr {
	border-bottom:1px solid #CCC;
}

.tbl-quotas tr.separador {
	height: 10px;
	border-bottom:none !important;
}
.quota {
	font-size:10px;
}
</style>
<table border="0" cellspacing="0" cellpadding="2" class="tbl-quotas table-hover">
<tr>
  <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">alquiler &nbsp; </td>
    <td colspan="2">inversion &nbsp; </td>
  </tr>
<tr>
	<td>operaciones &nbsp; </td>
    <td>oficinas</td>
    <td align="right"><%= session("pw_ws").GetLeidos("oficinas alquiler") %>&nbsp;</td>
    <td class="quota"> / <%= session("pw_ws").GetQuota("oficinas alquiler") %></td>
    <td align="right"><%= session("pw_ws").GetLeidos("oficinas inversion") %>&nbsp;</td>
    <td class="quota"> / <%= session("pw_ws").GetQuota("oficinas inversion") %></td>
</tr>
<tr>
	<td></td>
    <td>locales</td>
    <td align="right"><%= session("pw_ws").GetLeidos("locales alquiler") %>&nbsp;</td>
    <td class="quota"> / <%= session("pw_ws").GetQuota("locales alquiler") %></td>
    <td align="right"><%= session("pw_ws").GetLeidos("locales inversion") %>&nbsp;</td>
    <td class="quota"> / <%= session("pw_ws").GetQuota("locales inversion") %></td>
</tr>
<tr>
	<td></td>
    <td>naves</td>
    <td align="right"><%= session("pw_ws").GetLeidos("naves alquiler") %>&nbsp;</td>
    <td class="quota"> / <%= session("pw_ws").GetQuota("naves alquiler") %></td>
    <td align="right"><%= session("pw_ws").GetLeidos("naves inversion") %>&nbsp;</td>
    <td class="quota"> / <%= session("pw_ws").GetQuota("naves inversion") %></td>
</tr>
<tr>
	<td></td>
    <td>hoteles</td>
    <td align="right"><%= session("pw_ws").GetLeidos("hoteles alquiler") %>&nbsp;</td>
    <td class="quota"> / <%= session("pw_ws").GetQuota("hoteles alquiler") %></td>
    <td align="right"><%= session("pw_ws").GetLeidos("hoteles inversion") %>&nbsp;</td>
    <td class="quota"> / <%= session("pw_ws").GetQuota("hoteles inversion") %></td>
</tr>
<tr>
	<td colspan="2">vencimientos</td>
    <td align="right"><%= session("pw_ws").GetLeidos("vencimientos") %>&nbsp;</td>
    <td class="quota"> / <%= session("pw_ws").GetQuota("vencimientos") %></td>
    <td></td>
    <td></td>
</tr>
</table>
<% if len(session("pw_ws").Bloqueos)>1 then 
'margin-bottom:6px; 
%>
<div style="margin-top:12px; border:1px solid red">
<strong>bloqueos</strong>: <% 
for each elto in split(session("pw_ws").Bloqueos, "#") 
	if elto<>"" then %><span class="label label-danger"><%= elto %></span> <% end if 
next 
%></div>
<% end if %>