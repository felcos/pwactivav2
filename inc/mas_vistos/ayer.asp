<%
'on error resume next

pFechaF = dateadd("d", -1, date)

if weekday(pFechaF, 0)=7 then pFechaF = dateadd("d", -2, pFechaF)
if weekday(pFechaF, 0)=6 then pFechaF = dateadd("d", -1, pFechaF)

pFechaI = pFechaF

set rsTmp = Server.CreateObject("ADODB.Recordset")

sql = "SELECT TOP 5 articulo_tipo, articulo_id, COUNT(id) AS accesos FROM reg_articulos WHERE (articulo_tipo IN ('not', 'rum', 'est', 'ope', 'dem', 'sub') AND "
sql = sql & "fecha BETWEEN CONVERT(DATETIME, '" & pFechaI & "', 103) AND CONVERT(DATETIME, '" & pFechaF & "', 103)"
sql = sql & ") GROUP BY articulo_tipo, articulo_id ORDER BY COUNT(id) DESC"
'response.Write(sql)
rsTmp.Open sql, session("connPWAcesos")
do while not rsTmp.eof 
	%><li class="masvisto"><img src="/img/apunta.gif" style="position:relative;top:2px;">&nbsp;&nbsp;<% TituloArticulo(rsTmp) %><% if request.Cookies("dev")<>"" then %> (<%= rsTmp("articulo_tipo") %>-<%= rsTmp("articulo_id") %>)<% end if %></li><%
	rsTmp.movenext
loop 

'rsTmp.close
'set rsTmp=nothing

function TituloArticulo(byRef pRS)
	set rsArt = Server.CreateObject("ADODB.Recordset")
	select case pRS("articulo_tipo")
	case "not", "rum", "est", "dem"
		sql = "SELECT ID, TITULO, FECHA_ACTUALIZACION AS fecha FROM C_NOTICIAS_INMOBILIARIAS WHERE ID=" & pRS("articulo_id")
	case "ope"
		sql = "SELECT ID, TITULO, FECHA_ACTUALIZACION AS fecha FROM C_OPERACIONES WHERE ID=" & pRS("articulo_id")
	end select
	
	link = pRS("articulo_tipo") & "=" & pRS("articulo_id")
	link = link & "&origen=top_day"
	
	rsArt.Open sql, session("connPW")
	
	if not rsArt.eof then
		%><span class="enlace_masvisto"><a href="/articulos/?<%= link %>" class="simplemodal"><%= rsArt("TITULO") %></a></span><%
	end if
	rsArt.close
	set rsArt=nothing
end function %>