<% '
resp = session("PW_WS").Comprobar_Licencia(request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("n"),request.Cookies("licencia")("user_id"))
'resp = session("PW_WS").Comprobar_Licencia(request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("n"), request.Cookies("licencia")("movil"), request.Cookies("licencia")("user_id"))
if not (session("pw_ws").accesoInversores and resp=0) then %>
<div class="grid-2 grid-flow-opposite">
	<figure>
	<% select case resp
    case 0	'cliente activo %>
        <p>Para tener acceso a los contenidos debe tener contratada la secci&oacute;n <strong>Inversores</strong>.</p>
    <% case 1	'no es cliente %>
        <p>Usted no es cliente de Property Web.</p>
        <p>Para tener acceso a los contenidos debe ser cliente.</p>
    <% case 2	'licencia no activa %>
        <p><strong><%= request.Cookies("licencia")("u") %></strong> no tiene acceso a los contenidos restringidos.</p>
    <% end select %>
    <br>
    <p>Para m&aacute;s informaci&oacute;n, <a href="/pw/contacto.asp">contacte con PropertyWeb</a>.</p>
    <br>
    </figure>
</div>
<% end if %>

<div  class="dev">
    <p>accesoInversores: <%= session("pw_ws").accesoInversores %></p>
    <p>Comprobar_Licencia: <%= session("PW_WS").Comprobar_Licencia(request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("n"),request.Cookies("licencia")("user_id")) %></p>
    <%'= session("PW_WS").Comprobar_Licencia(request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("n"), request.Cookies("licencia")("movil"), request.Cookies("licencia")("user_id")) %>
</div>
