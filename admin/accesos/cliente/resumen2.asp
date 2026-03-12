<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% 
'if request.Cookies("dev")("request")<>"" then
	%><p>QueryString: &nbsp; <%
	for each elto in request.QueryString
		%><strong><%= elto %></strong>: <%= request.QueryString(elto) %>&nbsp; <%
	next
	%></p><%
	
	%><p>Form: &nbsp; <%
	for each elto in request.Form
		%><strong><%= elto %></strong>: <%= request.Form(elto) %>&nbsp; <%
	next
'end if 
%>
<%
uid = request.QueryString("uid")

yy_act = year(date)
yy = request.QueryString("y")


if uid="" then uid=31
if yy="" then yy=yy_act-1

fi = cdate("01/01/" & yy)
ff = cdate("31/12/" & yy)

%><hr><%
%><li><%= fi %> [<%= datepart("w", fi, 2) %>] ww:<%= datepart("ww", fi, 2) %></li><%
%><li><%= ff %> [<%= datepart("w", ff, 2) %>] ww:<%= datepart("ww", ff, 2) %></li><%

fi = dateadd("d", 7+1-datepart("w", fi, 2), fi)
ff = dateadd("d", 7-datepart("w", ff, 2), ff)

%><hr><%
%><li><%= fi %> [<%= datepart("w", fi, 2) %>] ww:<%= datepart("ww", fi, 2) %></li><%
%><li><%= ff %> [<%= datepart("w", ff, 2) %>] ww:<%= datepart("ww", ff, 2) %></li><%

%><hr>

<%
Set rs = Server.CreateObject("ADODB.Recordset")

dim currYear
dim prevYear

dim valores_act(55)
dim valores_ant(55)

ww_max = 0
ww_min = 55
%>
<%
'act_y
fi = cdate("01/01/" & yy_act)
ff = cdate("31/12/" & yy_act)
fi = dateadd("d", 7+1-datepart("w", fi, 2), fi)
ff = dateadd("d", 7-datepart("w", ff, 2), ff)

sql = "SELECT DATEADD(d, 1 - DATEPART(dw, fecha), fecha) AS wd, COUNT(id) AS articulos "
sql = sql & "FROM reg_articulos "
sql = sql & "WHERE (fecha>='" & fi & "' AND fecha<='" & ff & "' AND id_cliente=" & uid & ") " 
sql = sql & "GROUP BY DATEADD(d, 1 - DATEPART(dw, fecha), fecha) "
sql = sql & "ORDER BY DATEADD(d, 1 - DATEPART(dw, fecha), fecha)"
'if request.Cookies("dev")("sql")<>"" then
	%><p class="peq"><%= sql %></p><%
'end if
'response.End()
rs.Open sql, session("connPWAcesos")

do while not rs.eof 
	
	valores_act(datepart("ww", rs("wd"))) = rs("articulos")
	if datepart("ww", rs("wd"))>ww_max then ww_max=datepart("ww", rs("wd"))
	'if rs("ww")<ww_min then ww_min=rs("ww")
	
	if currYear<>"" then
		currYear = currYear & ", "
	end if
	
	currYear = currYear & "['" & diasemana(datepart("ww", rs("wd")), yy_act) & "', " & rs("articulos") & "]"
	
	rs.movenext
loop

rs.close 

%>
<%
fi = cdate("01/01/" & yy)
ff = cdate("31/12/" & yy)
fi = dateadd("d", 7+1-datepart("w", fi, 2), fi)
ff = dateadd("d", 7-datepart("w", ff, 2), ff)

'ant_y
sql = "SELECT DATEADD(d, 1 - DATEPART(dw, fecha), fecha) AS wd, COUNT(id) AS articulos "
sql = sql & "FROM reg_articulos "
sql = sql & "WHERE (fecha>='" & fi & "' AND fecha<='" & ff & "' AND id_cliente=" & uid & ") " 
sql = sql & "GROUP BY DATEADD(d, 1 - DATEPART(dw, fecha), fecha) "
sql = sql & "ORDER BY DATEADD(d, 1 - DATEPART(dw, fecha), fecha)"
'if request.Cookies("dev")("sql")<>"" then
	%><p class="peq"><%= sql %></p><%
'end if
'response.End()
rs.Open sql, session("connPWAcesos")

do while not rs.eof 
	valores_ant(datepart("ww", rs("wd"))) = rs("articulos")
	if datepart("ww", rs("wd"))>ww_max then ww_max=datepart("ww", rs("wd"))
	'if rs("ww")<ww_min then ww_min=rs("ww")
	if prevYear<>"" then
		prevYear = prevYear & ", "
	end if
	
	prevYear = prevYear & "['" & diasemana(datepart("ww", rs("wd")), yy) & "', " & rs("articulos") & "]"
	
	rs.movenext
loop

rs.close 
%>
<%
set rs=nothing
%>

<% if 1=2 then %>
<table border="1" cellspacing="0" cellpadding="2">
<tr>
    <td>semana</td>
    <% for jj=0 to ww_max %>
    <td><%= jj %></td>
    <% next %>
</tr>
<tr>
    <td>diasemana</td>
    <% for jj=0 to ww_max %>
    <td><%= diasemana(jj, yy_act) %></td>
    <% next %>
</tr>
<tr>
    <td>articulos <%= yy_act %></td>
    <% for jj=0 to ww_max 
		'if valores_act(jj)="" then valores_act(jj)=0
	%>
    <td><%= valores_act(jj) %></td>
    <% next %>
</tr>

<tr>
    <td>diasemana</td>
    <% for jj=0 to ww_max %>
    <td><%= diasemana(jj, yy) %></td>
    <% next %>
</tr>
<tr>
    <td>articulos <%= yy %></td>
    <% for jj=0 to ww_max 
		'if valores_ant(jj)="" then ant(jj)=0
	%>
    <td><%= valores_ant(jj) %></td>
    <% next %>
</tr>
</table>
<% end if %>
<hr />
<%= currYear %>
<hr />
<%= prevYear %>
<hr />
<% function diasemana(ww, yy) 
	dim fi
	fi = cdate("01/01/" & yy)
	fi = dateadd("d", 7+1-datepart("w", fi, 2), fi)
	
	f_tmp = dateadd("d", 7*(ww-2), fi)
	
	'yyyy-mm-dd
	if day(f_tmp)<10 then
		d_tmp = "0" & cstr(day(f_tmp))
	else
		d_tmp = cstr(day(f_tmp))
	end if
	
	if month(f_tmp)<10 then
		m_tmp = "0" & cstr(month(f_tmp))
	else
		m_tmp = cstr(month(f_tmp))
	end if
	
	diasemana = year(f_tmp) & "-" & m_tmp & "-" & d_tmp
end function %>
