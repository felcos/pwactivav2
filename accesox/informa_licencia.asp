<p>request.cookies(&quot;<b>licencia</b>&quot;)&nbsp;:&nbsp;<b><% if request.Cookies("licencia")="" then %>NO <% end if %></b>existe</p>
<form id="frmCookieLicencia" name="frmCookieLicencia" method="post" action="/dev/bin/cookie_licencia.asp" class="noMargin">
<input name="pw" type="hidden" id="pw" value="<%= ext_serv %>" />
<li style="font-size:12px;"> &nbsp; .Comprobar_Empresa: <%= session("PW_WS").Comprobar_Empresa(request.Cookies("licencia")("u"),request.Cookies("licencia")("p")) %></li>
<li style="font-size:12px;"> &nbsp; .Comprobar_Licencia: <%= session("PW_WS").Comprobar_Licencia(request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("n"),request.Cookies("licencia")("user_id")) %></li>

<% if request.Cookies("licencia")<>"" then %>
    <input name="cmdCookieLicencia" type="submit" id="cmdCookieLicencia" value="borrar" style="float:right;">
<% end if %>
</form>