<% sub VerSubasta(byRef pRS) 
	'''insert_reg_articulo "sub", pRS("ID") %>
<a name="sub<%= pRS("ID") %>" id="sub<%= pRS("ID") %>"></a>
<div id="contenedor_articulos">
	<h3 class="encabezado_subastas">Subastas</h3>
	<h1 class="titulo_noticia"><%= pRS("TITULO") %></h1>
	<p style="font-family: georgia;">&nbsp;</p>
	
	<div id="descar_imprim">
		<span class="txt_gris_claro" style="font-weight:bold;font-size:12px;">nacional</span>&nbsp;&nbsp;<img src="/img/artic_nacional.png">
	</div>
    
    <span class="txt_gris_claro" style="font-style: oblique;font-weight: bold;font-size:12px;position:relative;bottom:10px;"><%= pRS("fecha_actualizacion") %></span>

<div class="cuerpo">

    <div style="padding:10px; border-bottom:3px #CCCCCC solid; border-top:3px #CCCCCC solid;">
        <% if isnull(pRS("texto")) then
            tmpTxt=""
        else
            tmpTxt=replace(pRS("texto"),vbcrlf, "<br>")
        end if %>
        <%= tmpTxt %>
    </div>

</div>
</div>

<!-- detalles -->
<div class="caja_ancha">
<div style="padding-bottom:20px;">
<% 'detalles	
set rsItems = Server.CreateObject("ADODB.Recordset")
sql = "SELECT * FROM C_Concursos_Detalle_todo WHERE id_concurso=" & pRS("ID")
rsItems.Open sql, session("connPW")
if not rsItems.eof then %>
Detalles del concurso:
<table width="100%" cellspacing="0" cellpadding="0" class="tbl_jp" style="font-size:12px;">
	<tr>
		<th width="100">Direcci&oacute;n</th>
		<th width="10"></th>
		<th>Seccion</th>
		<th width="10"></th>
		<th>Superficie</th>
		<th width="10"></th>
		<th>Uso</th>
		<th width="10"></th>
		<th>Sup. Edificable:</th>
		<th width="10"></th>
		<th>Precio:</th>
		<th width="10"></th>
		<th>Comentarios:</th>
	</tr>
	<% do while not rsItems.eof 
		'sección		
		if rsItems("seccion")="" or isnull(rsItems("seccion")) then
			txtSeccion = "abierto"
		else
			txtSeccion = rsItems("seccion")
		end if
		'superficie		
		if rsItems("superficie")="" or isnull(rsItems("superficie")) then
			txtSuperficie = ""
		else
			txtSuperficie = formatnumber(rsItems("superficie"),0) & " M &sup2;"
		end if
		'superficie edificable	
		if rsItems("superficie_edificable")="" or isnull(rsItems("superficie_edificable")) then
			txtSuperficieEdificable = ""
		else
			txtSuperficieEdificable = formatnumber(rsItems("superficie_edificable"),0) & " M &sup2;"
		end if
		'precio			
		if rsItems("precio")="" or isnull(rsItems("precio")) then
			txtPrecio = ""
		else
			txtPrecio = formatnumber(rsItems("precio"),2) & rsItems("tipo_precio")
		end if
		%>
		<tr>
    <td><%= rsItems("direccion") %></td>
    <td></td>
    <td><%= rsItems("seccion") %></td>
    <td></td>
    <td><%= txtSuperficie %></td>
    <td></td>
    <td><%= txtSeccion %></td>
    <td></td>
    <td><%= txtSuperficieEdificable %></td>
    <td></td>
    <td><%= txtPrecio %></td>
    <td></td>
    <td><%= rsItems("texto_lote") %></td>
        </tr>
		<% rsItems.movenext
	loop
end if %>
	<tr>
		<td></td>
        <td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
	</tr>
</table>
<%
rsItems.Close
Set rsItems = Nothing
%>
</div>
</div>

<div id="contenedor_articulos" style="margin-top:6px;">

<!-- contacto -->
<div>
	Informaci&oacute;n / contacto:
	<table width="98%"  cellspacing="0" cellpadding="2" align="center">
		<tr>
		  <td><%= pRS("entidad_nombre") %></td>
		  </tr>
		<tr>
		  <td>
		  <table width="85%" border="0" align="center" cellpadding="1" cellspacing="0" bordercolor="#FFFFFF">
		<tr>
			<td colspan="4" class="<%=color%>" bordercolor="#89892E"></td>
		</tr>
		<tr>
			<td width="1%" bordercolor="#FFFFFF">&nbsp;</td>
			<td class="<%=color%>" bordercolor="#FFFFFF"><span >Tlf. Principal:</span></td>
			<td width="1%" bordercolor="#FFFFFF">&nbsp;</td>
			<td width="65%" bordercolor="#89892E">
			<span class="txtTabla">
			<table width="100%">
				<tr>
<% if pRS("entidad_tlf2")="" then %>
			<td><%= pRS("entidad_tlf1") %></td>
<% else %>
			<td width="50%"><%= pRS("entidad_tlf1") %></td>
			<td width="50%"><%= pRS("entidad_tlf2") %></td>
<% end if %>
				</tr>
			</table>
			</span>
			</td>
		</tr>
<% if pRS("entidad_fax")<>"" then %>
		<tr>
		  <td width="1%" bordercolor="#FFFFFF">&nbsp;</td>
		  <td class="<%=color%>" bordercolor="#FFFFFF">Fax:</td>
		  <td bordercolor="#FFFFFF">&nbsp;</td>
		  <td width="75%" bordercolor="#89892E"><span class="txtTabla"><%= pRS("entidad_fax") %></span></td>
		</tr>
<% end if %>
<% if pRS("entidad_email")<>"" then %>
		<tr>
		  <td width="1%" bordercolor="#FFFFFF">&nbsp;</td>
		  <td class="<%=color%>" bordercolor="#FFFFFF">e-mail:</td>
		  <td bordercolor="#FFFFFF">&nbsp;</td>
		  <td width="75%" bordercolor="#89892E"><span class="txtTabla"><%= pRS("entidad_email") %></span></td>
		</tr>
<% end if %>
<% if pRS("entidad_web")<>"" then %>
		<tr>
		  <td width="1%" bordercolor="#FFFFFF">&nbsp;</td>
		  <td class="<%=color%>" bordercolor="#FFFFFF">Web:</td>
		  <td bordercolor="#FFFFFF">&nbsp;</td>
		  <td width="75%" bordercolor="#89892E"><span class="txtTabla"><%= pRS("entidad_web") %></span></td>
		</tr>
<% end if %>
	</table>
		  </td>
		  </tr>
		<tr>
		  <td>Informaci&oacute;n:
  <% if pRS("inf_direccion")<>"" then %>
<table border="0" cellspacing="0" cellpadding="2">
  <tr>
    <td></td>
    <td colspan="3"><%= pRS("inf_direccion") %></td>
    </tr>
</table>
  <% end if %>
<table border="0" cellspacing="0" cellpadding="2">
    <td width="5"></td>
    <td>Tel&eacute;fono:</td>
    <td width="5"></td>
    <td><%= pRS("inf_tlf1") %></td>
  </tr>
  <% if pRS("inf_tlf2")<>"" then %>
  <tr>
    <td></td>
    <td>Tel&eacute;fono:</td>
    <td></td>
    <td><%= pRS("inf_tlf2") %></td>
  </tr>
  <% end if %>
</table>
		  </td>
		  </tr>
		<tr> 
			<td> 
<%
if pRS("inf_adicional")="" or isnull(pRS("inf_adicional")) then
	tmpTxT=pRS("inf_adicional")
else
	tmpTxt=replace(pRS("inf_adicional"),vbcrlf, "<br>")
end if
RESPONSE.Write tmpTxt
%>
		</td>
		</tr>
	</table>
</div>

<div id="separador"></div>

<div>Fecha l&iacute;mite de presentaci&oacute;n de ofertas:
	<table width="98%" border="0" cellspacing="0" cellpadding="2" align="center">
		<tr> 
			<td class="txtTabla"> 
				<span class="txtTabla"><%=pRS("lim_prop_fecha")%>				</span>			</td>
		</tr>
		<tr> 
			<td class="txtTabla"> 
				<span class="txtTabla">
<%
if not isnull(pRS("lim_prop_lugar")) then
	tmpTxt=replace(pRS("lim_prop_lugar"),vbcrlf, "<br>")
else
	tmpTxt=""
end if
RESPONSE.Write tmpTxt
%>
				</span>
			</td>
		</tr>
	</table>
</div>
<div id="separador"></div>
<div>Fecha/Lugar de apertura de ofertas:
	<table width="98%" cellspacing="0" cellpadding="2">
		<tr> 
			<td class="txtTabla"> 
				<span class="txtTabla"><%=pRS("ap_plicas_fecha")%>	</span>			</td>
		</tr>
<% if not isnull(pRS("ap_plicas_lugar")) and pRS("ap_plicas_lugar")<>"" then %>
		<tr> 
			<td class="txtTabla"> 
				<span class="txtTabla">
<%
tmpTxt=replace(pRS("ap_plicas_lugar"),vbcrlf, "<br>")
RESPONSE.Write tmpTxt
%>
				</span>
			</td>
		</tr>
<% end if %>
	</table>
</div>
<br />

<div id="separator_line"></div>

<table width="100%" border="0">
  <tr>
    <td><span class="txt_fecha">Fecha Publicaci&oacute;n:</span> <span class="txt_negrita" style="font-size: 10px;position: relative;bottom: 11px;left: 5px;"><%= pRS("fecha_publicacion") %></span></td>
    <td><span class="txt_fecha">Fecha Actualizaci&oacute;n:</span> <span class="txt_negrita" style="font-size: 10px;position: relative;bottom: 11px;left:100px;"><%= pRS("fecha_actualizacion") %></span></td>
  </tr>
</table>
<font size="1pt" style="font-family: Georgia;position: relative;left: 200px;top: 10px;font-size: 12px;">&copy; Property Web España</font>

<p>&nbsp;</p>
</div>

<% end sub %>
