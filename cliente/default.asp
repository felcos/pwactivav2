<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<% call AccesoPrivado %>
<!DOCTYPE html>
<html>
<head>
	<title>PropertyWeb - Cliente</title>
    <!--#include virtual="/inc/head.asp" -->
	
<% if request.Cookies("dev")="" then %>
    <link href="/lib/bootstrap/css/bs.css" rel="stylesheet" type="text/css">
    <link href="/css/animate.css" rel="stylesheet" type="text/css">
<% end if %>
    
</head>
<body>
<!--#include virtual="/inc/body-header.asp" -->
<div class="container">

<section id="s_buscador" class="row">
	<div class="caja">
	    <h1 class="heading">informaci&oacute;n de cliente</h1>
    </div>
</section>
<section id="s_control" class="row">
    <div class="row">
        <div class="col-sm-8">
			<div class="row">
            	<div class="col-sm-6"><!--#include virtual="/cliente/inc/cookie_licencia.asp" --></div>
            	<div class="col-sm-6"><!--#include virtual="/cliente/inc/pw_ws.asp" --></div>
            </div>
            
            <div class="panel-group">
	            <div class="panel panel-primary">
                    <div class="panel-heading">
                        <a data-toggle="collapse" href="#panel-leidos"><h4 class="panel-title">Articulos Le&iacute;dos <span class="pull-right icon icon-minus"></span> <span class="badge pull-right" style="margin-right:25px;"><%'= ubound(ArticulosLeidos)+1 %></span></h4></a>
                    </div>
                    <div id="panel-leidos" class="panel-collapse collapse in">
	                  <div class="panel-body">
                        <div class="row">
                            <div class="col-sm-6"><div class="alert alert-info" style=""><!--#include virtual="/cliente/quotas.asp" --></div></div>
                            <div class="col-sm-6"><div class="alert alert-info" style="margin-bottom:0; padding-bottom:0;"><!--#include virtual="/cliente/leidos.asp" --></div></div>
                        </div>
    	              </div>
                      <div class="panel-footer"><% 
						for each elto in ArticulosLeidos
							tipo = mid(elto, instr(elto, "$")+1, instr(elto, ":")-instr(elto, "$")-1)
							art = mid(elto, instr(elto, ":")+1)
							secc = left(elto, instr(elto, "$")-1)
							if secc=tipo then 
								secc = ""
							else
								secc = secc & "&nbsp;"
							end if
							
							ii=ii+1
							
							if isnumeric(art) then
								art = FormatNumber(art, 0)
							else
								calle = ""
								zona = ""
								num = ""
								ciudad = ""
								for each dir in split(art, "&")
									if instr(dir, "=")>0 then
										campo = left(dir, instr(dir, "=")-1)
										valor = mid(dir, instr(dir, "=")+1)
										
										select case campo
										case "l"
											ciudad = trim(lcase(valor))
										case "calle"
											calle = trim(lcase(valor))
										case "numerocalle"
											num = trim(lcase(valor))
										case "zona"
											zona = trim(lcase(valor))
										end select
										
										xx = ""
										if calle="" then
											xx = "[" & zona & "][" & ciudad & "][" & num & "]"
										else
											xx = calle
											if num<>"" then xx = xx & " " & num
										end if
										if ciudad<>"" then
											if instr(ciudad, " ") then ciudad = left(ciudad, instr(ciudad, " ")-1)
											if xx<>"" then xx=xx & ", "
											xx = xx & ciudad
										end if
									end if
								next
								art = xx
							end if
							
                            %><span class="badge"><%= secc %><%= tipo %>: <%= art %></span> <%
                        next
                      %></div>
                    </div>
            	</div>
            </div>
            
        </div>
        <div class="col-sm-4">
			<div class="panel-group">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h4 class="panel-title"><a data-toggle="collapse" href="#panel-permisos">Permisos Cliente <span class="pull-right icon icon-minus"></span></a></h4>
                    </div>
                    <div id="panel-permisos" class="panel-collapse collapse in">
                        <div class="panel-body"><% call popover_empresa %></div>
                    </div>
                </div>
            </div>
            <!--#include virtual="/cliente/inc/navegador.asp" -->
        </div>
    </div>
    
    <% if request.Cookies("dev")<>"" then %>
    <div class="row">
    	<div class="col-sm-8"><!--#include virtual="/dev/inc/clientes.asp" --><div id="informa"></div></div>
        <div class="col-sm-4"></div>
    </div>
    <% end if %>
    
</section>
    
</div>
<!--#include virtual="/inc/body-footer.asp" -->
</body>
</html>
<script type="text/javascript">
$(document).ready(function () {
	
});
</script>