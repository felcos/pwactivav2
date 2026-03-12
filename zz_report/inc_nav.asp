<style type="text/css">
	.divMisArticulos {
		/* margin: 0px auto; */
		min-height: 100px;
		/*width: 100%;*/
		box-shadow: 0 2px 5px #666666; 
		padding: 5px;
		font-size:10px;
		/*display:none;*/
	}

</style>
<div id="divMisArticulos" class="divMisArticulos">
<a href="/articulos/?nav=<%= navIdAnt %>">anterior</a> &nbsp; <a href="/articulos/?nav=<%= navIdSig %>">siguiente</a>
<br>
<br />
<%
'
'on error resume next
Set rsArticulos = Server.CreateObject("ADODB.Recordset")
listNav=split(session("ArticulosSeleccionados"), ",")
%>
<!-- Noticias -->	
<div class="apartadoBarraNav"><img src="/img/apunta.gif">&nbsp;Noticias:</div>
<% if instr(session("ArticulosSeleccionados"), "not") then %>
	<div id="txt_nav">
		<% for kk=0 to ubound(listNav)
	        if left(listNav(kk),3)="not" then %>
	    <div class="tit_articulo" id="not">
          <% call MiTitulo("C_NOTICIAS_INMOBILIARIAS", kk, "noticias") %>
	    </div>
	        <% end if
	    next %>
	</div>
<% end if %>

<!-- Rumores -->
<div class="apartadoBarraNav"><img src="/img/apunta.gif">&nbsp;&quot;Web" ha o&iacute;do...</div>
<% if instr(session("ArticulosSeleccionados"), "rum") then %>
    <div id="txt_nav">
		<% for kk=0 to ubound(listNav)
				if left(listNav(kk),3)="rum" then %>
			<div class="tit_articulo" id="rum">
			  <% call MiTitulo("C_NOTICIAS_INMOBILIARIAS", kk, "rumores") %>
			</div>
		<% end if
			next %>
	</div>
<% end if %>

<!-- Estudios -->	
<div class="apartadoBarraNav"><img src="/img/apunta.gif">&nbsp;Estudios:</div>
<% if instr(session("ArticulosSeleccionados"), "est") then %>
	<div id="txt_nav">
		<% for kk=0 to ubound(listNav)
				if left(listNav(kk),3)="est" then %>
			<div class="tit_articulo" id="est">
				<% call MiTitulo("C_NOTICIAS_INMOBILIARIAS", kk, "estudios") %>
			</div>
		<% end if
			next %>
    </div>
<% end if %>

<!-- Operacs. -->	
<div class="apartadoBarraNav"><img src="/img/apunta.gif">&nbsp;Operaciones:</div>
<% if instr(session("ArticulosSeleccionados"), "ope") then %>
	<div id="txt_nav">
		<% for kk=0 to ubound(listNav)
				if left(listNav(kk),3)="ope" then %>
			<div class="tit_articulo" id="operaciones">
				<% call MiTitulo("OPERACIONES", kk, "ope") %>
			</div>
		<% end if
			next %>
	</div>	
<% end if %>

<!-- Vencimientos -->	
<% if instr(session("ArticulosSeleccionados"), "ven") then
	for kk=0 to ubound(listNav)
		if left(listNav(kk),3)="ven" then
			link = "/articulos/?cons=" & listNav(kk) & "&nav=" &  kk
		end if
	next %>
	<div class="apartadoBarraNav"><a href="<%= link %>"><img src="/img/apunta.gif">&nbsp;Vencimientos</a>
    </div>
<% end if %>

<!-- Subastas -->	
<div class="apartadoBarraNav"><img src="/img/apunta.gif">&nbsp;Subastas:</div>
<% if instr(session("ArticulosSeleccionados"), "sub") then %>
	<div id="txt_nav">
		<% for kk=0 to ubound(listNav)
		        if left(listNav(kk),3)="sub" then %>
		    <div class="tit_articulo" id="subastas">
		        <% call MiTitulo("concursos", kk, "sub") %>
		    </div>
		<% end if
		    next %>
	</div>	
<% end if %>

<!-- Demandas -->
<div class="apartadoBarraNav"><img src="/img/apunta.gif">&nbsp;Demandas:</div>
<% if instr(session("ArticulosSeleccionados"), "dem") then %>
	<div id="txt_nav">
		<% for kk=0 to ubound(listNav)
			if left(listNav(kk),3)="dem" then 
				%><div class="tit_articulo" id="demandas"><% call MiTitulo("C_NOTICIAS_INMOBILIARIAS", kk, "demandas") %></div><% 
			end if
		next %>
    </div>
<% end if %>


<br />
</div>
<% sub MiTitulo(tbl, num, apartado)	
		mm=instr(listNav(num),"=")
		valor=right(listNav(num),len(listNav(num))-mm)
		sql= "SELECT ID, TITULO, TITULO_PT FROM "& tbl & " WHERE ID = " & valor
		
		rsArticulos.Open sql, session("connPW"), 1, 1
		if rsArticulos.eof and rsArticulos.bof then
			%>Art&iacute;culo Inexistente<br><%
		else
			texto=lcase(rsArticulos("TITULO"))
			texto=replace(texto, "'", "´")
			texto="<acronym title='" & texto & "'>" & left(texto,35) & "...</acronym>"
			urlEnlace="/articulos/?cons=" & listNav(num) & "&nav=" &  num 
			'& "&mostrar=" & apartado 'left(listNav(num),mm-1)
			%><a href=<%= urlEnlace %> class="nuevo" id="<%= replace(listNav(kk),"=","") %>"><%= texto %></a><%
		end if
		rsArticulos.close
end sub %>