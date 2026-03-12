<%
on error resume next

pFechaF = date
pFechaI = dateadd("d", -7, pFechaF)

set rsTmp = Server.CreateObject("ADODB.Recordset")

sql = "SELECT TOP 5 articulo_tipo, articulo_id, COUNT(id) AS accesos FROM reg_articulos WHERE (articulo_tipo IN ('not', 'rum', 'ope', 'est', 'dem', 'sub') AND "
sql = sql & "fecha BETWEEN CONVERT(DATETIME, '" & pFechaI & "', 103) AND CONVERT(DATETIME, '" & pFechaF & "', 103)"
sql = sql & ") GROUP BY articulo_tipo, articulo_id ORDER BY COUNT(id) DESC"
'response.Write(sql)
rsTmp.Open sql, session("connPWAcesos")
do while not rsTmp.eof 
	%><li class="masvisto"><img src="/img/apunta.gif" style="position:relative;top:2px;">&nbsp;&nbsp;<% TituloArticulo2(rsTmp) %></li><%
	rsTmp.movenext
loop 

'rsTmp.close
'set rsTmp=nothing

function TituloArticulo2(byRef pRS)
	'response.Write(pRS.source)
	set rsArt = Server.CreateObject("ADODB.Recordset")
	select case pRS("articulo_tipo")
	case "not", "rum", "est", "dem"
		sql = "SELECT ID, TITULO, FECHA_ACTUALIZACION AS fecha FROM C_NOTICIAS_INMOBILIARIAS WHERE ID=" & pRS("articulo_id")
	case "ope"
		sql = "SELECT ID, TITULO, FECHA_ACTUALIZACION AS fecha FROM C_OPERACIONES WHERE ID=" & pRS("articulo_id")
	case "sub"
		sql = "SELECT ID, TITULO, FECHA_ACTUALIZACION AS fecha FROM C_Concursos WHERE ID=" & pRS("articulo_id")
	end select
	
	link = pRS("articulo_tipo") & "=" & pRS("articulo_id")
	link = link & "&origen=top_week"
	
	rsArt.Open sql, session("connPW")
		%><span class="enlace_masvisto"><a href="/articulos/?<%= link %>" class="simplemodal"><%= rsArt("TITULO") %></a></span> &nbsp; (<%= rsArt("fecha") %>)<%
	rsArt.close
	set rsArt=nothing
end function %>