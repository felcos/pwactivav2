<%
'on error resume next
'variables globales
'Dim Actual Actual = CDate("01/01/2001") 

Actual = Now()
ActualYYYY=Year(Actual) 
ActualMM=Month(Actual) 

rtipo = "empr"

busqueda = trim(request.Form("frmInfo_busq"))
if busqueda="" then 
	if request.Cookies("dev")="" then response.Redirect("/")
	response.Write("<p>falta busqueda</p>")
	response.Write("[" & busqueda & "]")
end if
busqueda = replace(busqueda, "'", "''")

sw_nac = true

set rsBusq = Server.CreateObject("ADODB.Recordset")

if session("informa")="" then
	if request.Cookies("dev")="" then
		informa = false
	else
		informa = true
	end if
else
	informa = session("informa")
end if

counter = 0

if informa then 
	if request.Cookies("dev")<>"" then %><div class="dev mini">
        <li>accesoInfoEmpresa: <%= session("pw_ws").accesoInfoEmpresa %></li>
    </div><% end if
	
	if request.Cookies("dev")("request")<>"" then %>
    <div class="dev mini">
    	Form: &nbsp; <% 
		for each elto in request.Form 
        	if request.Form(elto)<>"" then %>[<b><%= elto %></b> = <%= request.Form(elto) %>]&nbsp;<% end if 
	    next %>
    </div>
	<% end if
end if %>
<div class="miga">
     <h2 class="tit_miga02">Empresa</h2>
</div>
<div class="inm_tbl cabecera">
    <div class="inm_row">
        <div class="inm_contador"></div>
        <div class="inm_nombre">Empresa</div>
        <div class="inm_pais">Pa&iacute;s</div>
    </div>
</div>
<% 
if len(busqueda)>0 then 
	busqueda=replace(busqueda, "%", "")
	busqueda=replace(busqueda, "'", "''")
end if
sqlW = "(NOMBRE LIKE '%" & busqueda & "%' OR OTROS_NOMBRES LIKE '%" & busqueda & "%')"

sql = ""
if session("pw_ws").accesoInfoEmpresa then
	sql = sql & "SELECT * FROM infoempresas_busq WHERE (" & sqlW & ") ORDER BY NOMBRE;"
else
	sql = sql & "SELECT COUNT(*) AS nn FROM infoempresas_busq WHERE (" & sqlW & ");"
end if

test_inyeccion_sql sql

if request.Cookies("dev")<>"" then
	%><div class="dev" style="font-size:10px"><%= sql %></div><% 	
end if

rsBusq.open sql, session("connPW")
%>
<div class="inm_tbl"><%
if session("pw_ws").accesoInfoEmpresa then
	do while not rsBusq.eof 
		link = "/info/empresa/?id=" & rsBusq("id") & "&empresa=" & rsBusq("nombre") 
		counter = counter + 1
		if  rsBusq("ID_ACTIVIDAD") = 0 then
			actividad = ""
		else
			actividad = lcase(rsBusq("ACTIVIDAD"))
		end if
		%>
        <div class="inm_row">
            <div class="inm_contador">
                <%= counter %>
                <form id="emp<%= rsBusq("id") %>" method="post" action="/info/empresa/">
                    <input type="hidden" name="frmInfo_tipo" value="empr">
                    <input type="hidden" name="frmInfo_busq" value="<%= frmInfo_busq %>">
                    <input type="hidden" name="id" value="<%= rsBusq("id") %>" />
                    <input type="hidden" name="empresa" value="<%= rsBusq("nombre") %>" />
                    <input type="hidden" name="secc" value="empr">
                </form>
            </div>
            <a href="#" onclick="$('#emp<%= rsBusq("id") %>').submit();return false;">
                <div class="inm_nombre"><%= rsBusq("nombre") %></div>
                <div class="inm_pais"><% if rsBusq("id_pais")>0 then %><img src="/img/paises/32/<%= rsBusq("id_pais") %>.png" height="16"/><% end if %></div>
            </a>
        </div>
		<% rsBusq.movenext
	loop
	
else
	call SinAccesoN("empr", rsBusq)
end if
%></div><%

set rsBusq=nothing 
%>