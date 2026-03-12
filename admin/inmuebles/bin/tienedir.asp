<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<!--#include virtual="/lib/aspjson/JSON_2.0.4.asp" -->
<%
id = request.QueryString("id")
tiene_dir = request.QueryString("tiene_dir")

if id="" then response.End()

sql = "UPDATE inmuebles SET "
sql = sql & "tiene_dir=" & tiene_dir
sql = sql & " WHERE id=" & id

session("connPW").execute sql

insert_reg_sql(sql)
sql_ex = sql

'devolver resultado
set rsTmp = Server.CreateObject("ADODB.Recordset")
sql = "SELECT * FROM inmuebles WHERE id=" & request.QueryString("id")
rsTmp.open sql, session("connPW")

Dim res
Set res = jsObject()

res("id") = rsTmp("id")
res("place_id") = rsTmp("place_id")
res("lat") = rsTmp("lat")
res("lng") = rsTmp("lng")

res("tiene_dir") = rsTmp("tiene_dir")

res("tiene_coords") = rsTmp("tiene_coords")

if ("" & rsTmp("lat") & rsTmp("lng"))="" then
	res("tiene_latlng")=false
else
	res("tiene_latlng") = true
end if

res("sql") = sql_ex

req = ""
for each elto in request.QueryString
	if req<>"" then req = req & ", "
	req = req & elto & ": " & request.QueryString(elto)
next
res("request") = req

res.Flush

rsTmp.close
set rsTmp=nothing
%>