<!DOCTYPE html>
<html lang="es">
<head>
	<title>PropertyWeb - Clientes</title>
    
	<link href="/pw/style_common.css" type="text/css" rel="stylesheet" />
    <link href="/pw/style8.css" type="text/css" rel="stylesheet" />
    
    <!--#include virtual="/inc/head.asp" -->
    
</head>

<body>
<!--#include virtual="/inc/body-header.asp" -->
<div class="container">

	<div class="row">
        <div class="col-md-12">

<% 
set rsClientes = Server.CreateObject("ADODB.Recordset")
rsClientes.open "SELECT * FROM w_clientes WHERE (activo=1) ORDER BY id_cliente", session("connPW")	' AND foto IS NOT NULL

do while not rsClientes.eof
'for i=1 to 12
%>
<div class="view view-eighth" style="width: 150px;height: 120px;border:8px solid white;">
	<a href="https://<%= rsClientes("web") %>" target="_blank">
    <img width="150" src="/img/clientes/<%= rsClientes("logotipo") %>" />
    <div class="mask">
        <h2 style="position: relative;right: 50px;bottom: 20px;color:white;font-weight:bold;font-family:questrial;"><%= rsClientes("empresa") %></h2>
        
    </div>
    </a>
</div>

<% 
	rsClientes.movenext
loop

rsClientes.close
set rsClientes=nothing
'next 
%>

        </div>
    </div>

</div>
<!--#include virtual="/inc/body-footer.asp" -->
</body>
</html>

