<% if 1=2 then 'if (isnull(rsOferta("map_longitud")) or isnull(rsOferta("map_latitud"))) then %>
	<script type="text/javascript">
		function GUnload() {}
		function load_mapa() {}
	</script>
<% else %>
<table id="tblPlano" width="100%" border="0" cellspacing="0" cellpadding="0" class="">
          <tr>
            <td height="15" valign="top" bgcolor="#DCDCDC">&nbsp;&nbsp;&nbsp;<a href="javascript:frmGoogleMaps.submit();" class="style2">Pulse aqu&iacute; para ampliar plano</a></td>
          </tr>
		  <tr><td height="3"></td></tr>
          <tr>
            <td align="center" bgcolor="#FFFFFF">
			<div align="center" id="div_mapa" style="width: 221px; height: 196px">
<% if (isnull(rsOferta("map_longitud")) or isnull(rsOferta("map_latitud"))) then %>
<script type="text/javascript">
	//function GUnload() {}
	//function load_mapa() {}
</script> 
	<a href="javascript:frmGoogleMaps.submit();"><img src="mapa/noplano.gif" alt="plano" border="0" /></a>
<% else 
	lng=Replace(cstr(rsOferta("map_longitud")), ",", ".")
	lat=Replace(cstr(rsOferta("map_latitud")), ",", ".")
%>
<script src="https://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAgF6cheH-DOnmwecTUkLRFBTZigVrLvXLB7iNUlfK4jwZGNs_kBTHUGI3v1T03KJU3XlvSxUzGhff0g"
  type="text/javascript"></script>
<script type="text/javascript">
//<![CDATA[
function load_mapa() {
  if (GBrowserIsCompatible()) {
	var map = new GMap2(document.getElementById("div_mapa"));
	map.setCenter(new GLatLng(<%=lat%>,<%=lng%>), <% if request.QueryString("oficina")="5332" then %>14<% else %>18<% end if %>);
  }
}
//]]>
//load_mapa()
//onUnload="GUnload()"
//onload="load_mapa()" onUnload="GUnload()"
</script> 
<% end if %>
			</div>			</td>
          </tr>
</table>
<% end if %>