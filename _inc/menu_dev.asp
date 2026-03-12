www: <%= lcase(application("servidor_web")) %> - 
bd: <%= lcase(application("servidor")) %> 
<% 
'usuario = request.Cookies("licencia")("n")
'if instr(usuario, "@")>0 then'
'	usuario = left(usuario, instr(usuario, "@"))
'end if 
%>
<br />
<span id="informa_width">0</span> x <span id="informa_height">0</span>
<% if request.Cookies("dev")("reg")<>"" then %> &nbsp;-&nbsp; <span class="destaca">NO log</span><% end if %>
<% if session("movil") then %> - <span class="destaca">MOVIL</span><% end if %>
&nbsp;-&nbsp;
<a href="/acceso/session_abandon.asp">Abandon</a> 
<br />
<a href="/dev/">dev</a> - 
<a href="/admin/">admin</a> // 
<a href="/admin/informa_limites_accesos.asp" target="_blank">limites</a>&nbsp;