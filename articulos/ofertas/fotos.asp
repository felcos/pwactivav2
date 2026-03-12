<% if rsOferta("NUMERO_FOTOS")>0 then %>
<div class="tblDetalle">
<%
select case rsOferta("NUMERO_FOTOS")
case 1 
	txtTitular = "1 foto"
case else
	txtTitular = rsOferta("NUMERO_FOTOS") & " fotos"
end select
strFotos=rsOferta("FOTOS")
%>
    <div class="tblDetalle_titulo"><b><%= txtTitular %></b></div>
<table border="0" width="100%" cellpadding="0" cellspacing="0">
	<tr><td align="center" valign="middle">
<% for a= 1 to rsOferta("NUMERO_FOTOS")
  	pathFoto = "/fotos/" & Left(strFotos, InStr(1, strFotos, "&") - 1)
   	strFotos = Right(strFotos, Len(strFotos) - InStr(1, strFotos, "&"))
	numFotos = rsOferta("NUMERO_FOTOS")
	anchoFotos = 90
	%>
	<% if 1=2 then %>
	<a href="javascript:" onclick="javascript:window.open('/pagfoto/verFoto.asp?num=<%= rsOferta("NUMERO_FOTOS") %>&<%= rsOferta("FOTOS") %>','Fotos','scrollbars=no,resizable=no,width=300,height=300')"><img src="<%= pathFoto %>" name="img<%= a %>" width="<%= anchoFotos %>" hspace="5" vspace="0" border="0" align="right" id="img<%= a %>2" /></a><a href="javascript:" onclick="javascript:window.open('/pagfoto/verFoto.asp?num=<%= rsOferta("NUMERO_FOTOS") %>&<%= rsOferta("FOTOS") %>','Fotos','scrollbars=no,resizable=no,width=300,height=300')"></a>
	<% end if %>
	<% if left(session("pag_actual"), 17)="/ofertas/edit.asp" then 
        link = session("pag_actual") & "&pag=img&img=" & pathFoto %>
        <a href="<%= link %>"><img src="<%= pathFoto %>" name="img<%= a %>" width="<%= anchoFotos %>" hspace="5" vspace="0" border="0" id="img<%= a %>" /></a>
    <% else %>
        <a href="<%= pathFoto %>" target="_blank"><img src="<%=pathFoto%>" name="img<%=a%>" width="<%= anchoFotos %>" hspace="5" vspace="0" border="0" id="img<%=a%>" /></a>
    <% end if %>
<% next %>
		</td></tr>
<% if 1=2 then %>
    <tr><td align="right"><a href="javascript:"onclick="javascript:window.open('../pagfoto/verFoto.asp?num=<%=rsOferta("NUMERO_FOTOS")%>&amp;<%=rsOferta("FOTOS")%>','Fotos','scrollbars=no,resizable=no,width=300,height=300')"><img src="/img/tablas/ver_galeria.jpg" border="0" /></a></td></tr>
<% end if %>
</table>
</div>
<% end if %>