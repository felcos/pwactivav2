<%
dim tmpLeidos()
ii=0
for each elto in split(session("pw_ws").ArticulosLeidos(), "#")
	if elto<>"" then
		redim preserve tmpLeidos(ii)
		tmpLeidos(ii) = elto
		ii=ii+1
	end if
next
%>
<table width="100%" border="0">
<tr>
    <td width="50%" valign="top" class="tbl-quotas-left">
    
<table border="0" cellspacing="0" cellpadding="2" width="100%" class="tbl-quotas table-hover">
<tr><td colspan="2"></td></tr>
<tr>
  <td>noticias&nbsp;</td>
  <td align="right"><%= ubound(filter(tmpLeidos, "not"))+1 %></td>
</tr>
<tr>
  <td>web ha o&iacute;do...&nbsp;</td>
  <td align="right"><%= ubound(filter(tmpLeidos, "rum"))+1 %></td>
  </tr>
<tr>
  <td>estudios&nbsp;</td>
  <td align="right"><%= ubound(filter(tmpLeidos, "est"))+1 %></td>
</tr>
<tr>
  <td>operaciones&nbsp;</td>
  <td align="right"><%= ubound(filter(tmpLeidos, "ope"))+1 %></td>
</tr>
<tr>
  <td>vencimientos&nbsp;</td>
  <td align="right"><%= ubound(filter(tmpLeidos, "ven"))+1 %></td>
</tr>
<tr>
  <td>subastas&nbsp;</td>
  <td align="right"><%= ubound(filter(tmpLeidos, "sub"))+1 %></td>
  </tr>
<tr>
  <td>demandas&nbsp;</td>
  <td align="right"><%= ubound(filter(tmpLeidos, "dem"))+1 %></td>
  </tr>
<tr>
  <td>Inversores&nbsp;</td>
  <td align="right"><%= ubound(filter(tmpLeidos, "inv"))+1 %></td>
</tr>
</table>

    </td>
    <td width="50%" valign="top" class="tbl-quotas-rigth">

<table border="0" cellspacing="0" cellpadding="2" width="100%" class="tbl-quotas table-hover">
<tr><td colspan="3"></td></tr>
  <td colspan="2">Disponibilidad&nbsp;</td>
  <td align="right"><%= ubound(filter(tmpLeidos, "dis"))+1 %></td>
</tr>
<tr>
  <td colspan="2">Take Up</td>
  <td align="right"><%= ubound(filter(tmpLeidos, "tup"))+1 %></td>
</tr>
<tr>
  <td colspan="2">Info&nbsp;</td>
  <td align="right">&nbsp;</td>
</tr>
<tr>
  <td style="width:15px;"></td>
  <td>Edif./Dir.</td>
  <td align="right"><%= ubound(filter(tmpLeidos, "edif"))+ubound(filter(tmpLeidos, "dir"))+2 %></td>
</tr>
<tr>
  <td>&nbsp;</td>
  <td>C. Com.&nbsp;</td>
  <td align="right"><%= ubound(filter(tmpLeidos, "cc"))+1 %></td>
  </tr>
<tr>
  <td>&nbsp;</td>
  <td>Hotel&nbsp;</td>
  <td align="right"><%= ubound(filter(tmpLeidos, "hot"))+1 %></td>
  </tr>
<tr>
  <td>&nbsp;</td>
  <td>Propietario&nbsp;</td>
  <td align="right"><%= ubound(filter(tmpLeidos, "prop"))+1 %></td>
</tr>
<!--
<tr>
  <td>&nbsp;</td>
  <td>Calle&nbsp;</td>
  <td align="right">< %= ubound(filter(tmpLeidos, "calle"))+1 %></td>
</tr>
-->
<tr>
  <td>&nbsp; </td>
  <td>Empresa&nbsp;</td>
  <td align="right"><%= ubound(filter(tmpLeidos, "empr"))+1 %></td>
</tr>
</table>

    </td>
</tr>
</table>
<br />