<% 
'on error resume next

'if request.Form="" then response.Redirect("/info/inmuebles/")


dirGoogleMaps = request.Form("d") & ", " & request.Form("l")
mapaGoogleMaps = dirGoogleMaps
if instr(mapaGoogleMaps, "'") then
	mapaGoogleMaps = replace(mapaGoogleMaps, "'", " ")
end if

tiene_coords = false


if request.Form("seltipo")="dir" then
	tipo = "DIRECCI&Oacute;N"
	dir = request.Form("d") & ", " & request.Form("l")
	
else
	tipo = "ZONA"
	dir = request.Form("zona")
	
end if

select case request.Form("frmInfo_tipo")
case "edif"
	if request.Form("seltipo")="dir" then
		miga = "Direcci&oacute;n"
	else
		miga = "Zona"
	end if
case "cc"
	miga = "Centro Comercial"
end select
%>
<div class="row">
    <div class="col-sm-7">
        <div class="miga">
             <h2 class="tit_miga02"><%= miga %></h2>
        </div>
        <h1 class="heading"><span class="tipo"><%= tipo %> </span><span class="nombreH"><%= dir %></span></h1>
        <p class="direInfo"><%= dir %></p>
    </div>
    
</div>

<div class="separador02"></div>

<div class="detalles clearfix">
    <div class="bloqueLeft ">
        <% if request.Form("seltipo")="direccion" then %>
        <div class="cajaImg"><!--#include virtual="/info/inc/shared/mapa.asp" --></div>
        <div class="pieImg"><p>MAPA/STREET VIEW<img src="/_inc/javier/img/info/muneco.gif" /></p></div>
        <% end if %>
    </div>
    <div class="bloqueRight">
        <% if request.Cookies("dev")<>"" then 
            if request.QueryString<>"" then
                request_tipo = "QUERYSTRING"
            elseif request.Form<>"" then
                request_tipo = "FORM"
            else
                request_tipo = "-"
            end if
            %>
            <div class="descripcion superficie dev">
                <h3>request. <%= request_tipo %></h3>
                <% if request.QueryString<>"" then 
                    for each elto in request.QueryString
                        %><li><strong><%= elto %></strong>: <%= request.QueryString(elto) %></li><%
                    next
                elseif request.Form<>"" then 
                    for each elto in request.Form
                        %><li><strong><%= elto %></strong>: <%= request.Form(elto) %></li><%
                    next
                else
                    %>-<%
                end if %>
      </div>
        <% end if %>
        
        <% if 1=2 then %>
        <div class="descripcion superficie">
            <h3>DESCRIPCI&Oacute;N</h3>
            <p>No hay datos aportados</p>
            
            <h3>COMENTARIOS</h3>
            <p>No hay datos aportados</p>
        </div>
        <% end if %>
    </div>
</div>
<%
insert_reg_articulo request.Form("secc"), "zona", "zona=" & request.Form("zona")
%>