<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
public busq_orig
public busq
public empresas_vistas
dim mostrar_semejantes

busq_orig=ucase(trim(request("busq")))
busq=busq_orig

if len(busq)>0 then busq=replace(busq, "%", "")

call consultar_parecidos

%>
	
<% sub busq_2_letras %>
<hr>
<div style="background-color:#FFFFCC; margin-top:20px;">
	<span id="result_noencontrado">B&uacute;squeda no v&aacute;lida</span>
	<span id="result_noencontrado">Debe escribir al menos dos letras del nombre de la empresa que pretende localizar en nuestro Directorio de Empresas para realizar la b&uacute;squeda.s</span>
</div>
<% end sub %>

<% sub busq_mal %>
<hr>
<div style="background-color:#FFFFCC; margin-top:20px;">
    <h2><strong>B&uacute;squeda no v&aacute;lida</strong></h2>
    <p>No tenemos registrada ninguna empresa denominada <b><%= busq_orig %></b>.</p>
    <p>Para acceder a la informaci&oacute;n sobre una empresa, debe realizar la b&uacute;squeda exacta de su nombre.</p>
</div>
<% end sub %>

<% sub consultar_empresa 
	link_submit = "/inversores/empresa.asp?id=" & rsBusq("id") & "&busq=" & busq & "&actividad="& request("actividad")
	link_submit = link_submit & "&secc=inversores"
	if request("origen")<>"" then link_submit = link_submit & "&origen=" & request("origen")
	%>
<div>
<br />
<h1><span class="txt_h1_naranja">Consultar Empresa</strong>:</span></h1>
<div style="border-style:solid; border-width:1px; background-color:#FC6; margin:10px; padding:6px;">
	<b><%= rsBusq("NOMBRE") %></b>
    <li><%= rsBusq("ACTIVIDAD") %></li>
<input type="button" name="Button" value="Ver Empresa" onClick="document.location.href='<%= link_submit %>';" style="float:right">
<br>
</div>
</div>
<% end sub %>

<% sub consultar_parecidos 
	'if not mostrar_semejantes then exit sub
	'if request.QueryString("busq")="" then exit sub
	if len(busq_orig)<2 or len(busq)<2 then exit sub
	buscarempresa=replace(busq, "'", "''")
	if len(buscarempresa)<2 then exit sub
	
	Set rsBusqAprox = Server.CreateObject("ADODB.Recordset")
	sql = "SELECT * FROM directorio WHERE "
	sql = sql & "("
	'sql = sql & "NOMBRE LIKE '%" & buscarempresa & "' OR "
	'sql = sql & "NOMBRE LIKE '" & buscarempresa & "%' OR "
	sql = sql & "NOMBRE LIKE '%" & buscarempresa & "%' OR "
	'sql = sql & "OTROS_NOMBRES LIKE '" & BUSCAREMPRESA & "' OR "
	'sql = sql & "OTROS_NOMBRES LIKE '%" & BUSCAREMPRESA & "' OR "
	'sql = sql & "OTROS_NOMBRES LIKE '" & BUSCAREMPRESA & "%' OR "
	sql = sql & "OTROS_NOMBRES LIKE '%" & BUSCAREMPRESA & "%'"
	'sql = sql & ") "
	sql = sql & ") AND (NOMBRE_CALLE IS NOT NULL) "		' AND NOMBRE_CALLE<>''
	
	sql = sql & " AND directorio=1 "
	
	'if empresas_vistas<>"" then sql = sql & "AND ID NOT IN (" & empresas_vistas & ") "
	sql = sql & "ORDER BY ACTIVIDAD, NOMBRE"
	
	rsBusqAprox.open sql, session("connPW")	
	
	if not rsBusqAprox.eof then %>
<div>
    <% 
    seccion=""
    nn=0
    do while not rsBusqAprox.eof
        nn=nn+1
        if seccion<>rsBusqAprox("ACTIVIDAD") then
            seccion=rsBusqAprox("ACTIVIDAD")
            ver_seccion=seccion
            if ver_seccion="N/D" then ver_seccion="OTRAS ACTIVIDADES"
            %><div class="pagsum_apartados"><span class="txt_h1_naranja"><b><%= ver_seccion %></b></span></div><%
        end if
		link = "/inversores/empresa.asp?id=" & rsBusqAprox("id")
        %><li><a href="<%= link %>" class="negro"><%= rsBusqAprox("nombre") %></a></li><%
        rsBusqAprox.movenext
    loop
    rsBusqAprox.Close %>
    <script>$("#div_instrucciones").html("<span style='color:#ffffff;padding:5px;position:relative;right:20px;border-bottom:1px solid #ededed;background-color:#F47C04;border-radius:3px;-moz-border-radius:3px;-webkit-border-radius:3px;font-family:ruda;'>* Encontradas <%= nn %> empresas</span>");</script>
</div>
	<% end if
	
	Set rsBusqAprox = Nothing 
end sub %>