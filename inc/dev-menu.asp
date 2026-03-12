www: <%= lcase(session("pw_ws").ServidorWeb) %> - 
bd: <%= lcase(session("pw_ws").ServidorBD) %> 
<% 
'usuario = request.Cookies("licencia")("n")
'if instr(usuario, "@")>0 then'
'	usuario = left(usuario, instr(usuario, "@"))
'end if 
%>
<br />
<span id="informa_width">0</span> x <span id="informa_height">0</span>
<% if session("movil") then %> - <span class="destaca">MOVIL</span><% end if %>
&nbsp;-&nbsp;<%= session("pw_ws").version() %>&nbsp;-&nbsp;
<a href="/acceso/session_abandon.asp">Abandon</a> 
<br />
RegAccesos: <% if session("pw_ws").IniciadoRegAccesos then %>iniciado<% else %>!<% end if %> - 
<a href="javascript:void(0);" data-toggle="notify" data-load="/cliente/quotas.asp">quotas</a> - 
<a href="javascript:void(0);" data-toggle="notify" data-load="/cliente/leidos.asp">leidos</a> &nbsp;-&nbsp; 
<% if session("pw_ws").NoTrack then %><span class="destaca">NO TRACK</span><% else %><span>track</span><% end if %>
<br />
<a href="/dev/">dev</a> - 
<a href="/admin/">admin</a> - 
<a href="/cliente/">cliente</a>&nbsp;