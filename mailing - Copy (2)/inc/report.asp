<h2 class="titdev">PropertyWeb report</h2>
<form name="frmEnvio" method="get" action="/mailing/report.asp" target="_blank">
<table width="100%" cellpadding="6" cellspacing="6" border="0">
  <tr>
    <td valign="top">
<table border="0">
	<tr>
		<td>Fecha:&nbsp;</td>
		<td width="20" valign="top"><input name="f" type="text" id="f" value="<%= cFecha %>" size="10"></td>
		</tr>
	<tr>
	  <td>Hasta:</td>
	  <td valign="top"><input name="fto" type="text" id="fto" value="" size="10"></td>
	  </tr>
	<tr>
	  <td>pw:&nbsp;</td>
	  <td valign="top"><select name="pw" id="pw" disabled><option value="es" selected="selected">Espa&ntilde;a</option></select></td>
	  </tr>
	<tr>
	  <td></td>
	  <td valign="top">&nbsp;</td>
	  </tr>
	<tr>
	  <td colspan="2">internacional:
	    <input type="checkbox" name="internacional" value="1" checked></td>
	  </tr>
</table>
    </td>
    <td valign="top">
<table border="0">
	    <tr>
	      <td>Actualidad</td>
	      <td>&nbsp;</td>
	      <td align="center"><input type="checkbox" name="actualidad" value="1" checked></td>
	      <td align="center" width="20">&nbsp;</td>
	      <td>Subastas</td>
	      <td>&nbsp;</td>
	      <td align="center"><input type="checkbox" name="subastas" value="1" checked></td>
	      </tr>
	    <tr>
	      <td>Web ha o&iacute;do...</td>
	      <td>&nbsp;</td>
	      <td align="center"><input type="checkbox" name="rumores" value="1" checked></td>
	      <td align="center">&nbsp;</td>
	      <td>Demandas</td>
	      <td>&nbsp;</td>
	      <td align="center"><input type="checkbox" name="demandas" value="1" checked></td>
	      </tr>
	    <tr>
	      <td>Estudios</td>
	      <td>&nbsp;</td>
	      <td align="center"><input type="checkbox" name="estudios" value="1" checked></td>
	      <td align="center">&nbsp;</td>
	      <td>Vencimientos</td>
	      <td>&nbsp;</td>
	      <td align="center"><input type="checkbox" name="vencimientos" value="1" checked></td>
	      </tr>
	    <tr>
	      <td>Deal Analysis</td>
	      <td>&nbsp;</td>
	      <td align="center"><input type="checkbox" name="operaciones" value="1" checked></td>
	      <td align="center">&nbsp;</td>
	      <td align="center">&nbsp;</td>
	      <td align="center">&nbsp;</td>
	      <td align="center">&nbsp;</td>
	      </tr>
	    <tr>
	      <td>&nbsp;</td>
	      <td>&nbsp;</td>
	      <td align="center">&nbsp;</td>
	      <td align="center">&nbsp;</td>
	      <td align="center">&nbsp;</td>
	      <td align="center">&nbsp;</td>
	      <td align="center">&nbsp;</td>
	      </tr>
	    <tr>
	      <td>Ofertas</td>
	      <td>&nbsp;</td>
	      <td align="center"><input type="checkbox" name="ofertas" value="1" disabled="disabled"></td>
	      <td align="center">&nbsp;</td>
	      <td align="center">&nbsp;</td>
	      <td align="center">&nbsp;</td>
	      <td align="center">&nbsp;</td>
	      </tr>
	    </table>
    </td>
  </tr>
  <tr>
    <td><table border="0">
      <tr>
        <td>Mostrar &Iacute;ndice</td>
        <td><input type="checkbox" name="ver_indice" value="1"></td>
      </tr>
    </table></td>
    <td align="right"><input type="submit" id="Enviar" value="Ver Report" style="width:120px"></td>
  </tr>
</table>
</form>