<%
'@LANGUAGE="VBSCRIPT"
'on error resume next

'Caché		
'al poner registro accesos
response.expires=0
response.buffer=true

'antes de poner registro accesos
'Response.Expires = 60
Response.Expiresabsolute = Now() - 1
Response.AddHeader "pragma","no-cache"
Response.AddHeader "cache-control","private"
Response.CacheControl = "no-cache"

session("mostrado_form_login")=false

'if session("pag_anterior")<>session("pag_actual") then 	
'	session("pag_anterior")=session("pag_actual")
'end if
%>
<link rel="icon" href="/favicon.png" type="image/png" />
<link rel="shortcut icon" href="/favicon.png" type="image/png" />
<script language="javascript">AC_FL_RunContent = 0;</script>
<script src="/inc/AC_RunActiveContent.js" language="javascript"></script>
<% call insertar_log_pag(session("pag_activa")) %>
<% 
public sub insertar_log_pag(pagActual) 
	sql = "INSERT INTO log_pags (session_id, date, usr_id, "
	sql = sql & "modo, lang, "
	sql = sql & "url, querystring, form, http_referer, pag_activa"
	sql = sql & ") VALUES ("
	sql = sql & "'" & session.SessionID & "', GETDATE(), "
	
	if session("usr_auth") then 
		sql = sql & "'" & session("usr_id") & "', "
	else
		sql = sql & "NULL, "
	end if
	sql = sql & "'" & session("modo") & "', "
	sql = sql & "'" & session("lang") & "', "
	
	cTxt = lcase(request.ServerVariables("PATH_INFO"))
	cTxt = replace(cTxt, "default.asp", "")
	sql = sql & "'" & cTxt & "', "
	
	if request.QueryString="" then 
		sql = sql & "NULL, "
	else
		sql = sql & "'" & ConvierteTexto(request.QueryString) & "', "
	end if
	if request.Form="" then 
		sql = sql & "NULL, "
	else
		sql = sql & "'" & ConvierteTexto(request.Form) & "', "
	end if
	if request.ServerVariables("HTTP_REFERER")="" then 
		sql = sql & "NULL, "
	else
		sql = sql & "'" & request.ServerVariables("HTTP_REFERER") & "', "
	end if

	sql = sql & "'" & pagActual & "'"
	sql = sql & ")"
	
	session("cnx_easy").execute sql
	
end sub 



public sub z_insertar_log_pag(pagActual, pagAnterior) 
'	response.Write("<hr>")	
'	response.Write("<li><b>pagActual: " & pagActual & "</b></li>")
'	response.Write("<li><b>pagAnterior: " & pagAnterior & "</b></li>")
	
'	response.Write("<li><b>pag_actual: " & session("pag_actual") & "</b></li>")
'	response.Write("<li><b>pag_anterior: " & session("pag_anterior") & "</b></li>")
	'if pag_actual=pag_anterior then exit sub
	sql = "INSERT INTO log_pags (session_id, date, usr_id, "
	sql = sql & "modo, lang, "
	sql = sql & "url, querystring, form, http_referer, pag_actual, pag_anterior"
	sql = sql & ") VALUES ("
	sql = sql & "'" & session.SessionID & "', GETDATE(), "
	
	if session("usr_auth") then 
		sql = sql & "'" & session("usr_id") & "', "
	else
		sql = sql & "NULL, "
	end if
	sql = sql & "'" & session("modo") & "', "
	sql = sql & "'" & session("lang") & "', "
	
	cTxt = lcase(request.ServerVariables("PATH_INFO"))
	cTxt = replace(cTxt, "default.asp", "")
	sql = sql & "'" & cTxt & "', "
	
	if request.QueryString="" then 
		sql = sql & "NULL, "
	else
		sql = sql & "'" & ConvierteTexto(request.QueryString) & "', "
	end if
	if request.Form="" then 
		sql = sql & "NULL, "
	else
		sql = sql & "'" & ConvierteTexto(request.Form) & "', "
	end if
	if request.ServerVariables("HTTP_REFERER")="" then 
		sql = sql & "NULL, "
	else
		sql = sql & "'" & request.ServerVariables("HTTP_REFERER") & "', "
	end if

	sql = sql & "'" & pagActual & "', "
	sql = sql & "'" & pagAnterior & "'"
	sql = sql & ")"
	
	'response.Write(sql)
	'response.Write("<hr>")

'	response.Write("<hr>")	
'	response.Write("<li><b>pag_actual: " & session("pag_actual") & "</b></li>")
'	response.Write("<li><b>pag_anterior: " & session("pag_anterior") & "</b></li>")
	
	session("cnx_easy").execute sql
	'session("pag_anterior")=session("pag_actual")
	session("pag_anterior")=pagAnterior
	session("pag_actual")=pagActual
'	
'	response.Write("<hr>")	
'	response.Write("<li><b>pag_actual: " & session("pag_actual") & "</b></li>")
'	response.Write("<li><b>pag_anterior: " & session("pag_anterior") & "</b></li>")
'	response.Write("<li><b>pag_actual: " & session("pag_actual") & "</b></li>")
'	response.Write("<li><b>pag_anterior: " & session("pag_anterior") & "</b></li>")
end sub 
public sub z_insertar_log_pags() 
	sql = "INSERT INTO log_pags (session_id, date, usr_id, usr_email, "
	sql = sql & "session_modo, session_lang, "
	sql = sql & "url, querystring, form, http_referer, pag_activa, pag_actual, pag_anterior"
	sql = sql & ") VALUES ("
	sql = sql & "'" & session.SessionID & "', GETDATE(), "
	
	if session("usr_auth") then 
		sql = sql & "'" & session("usr_id") & "', "
		sql = sql & "'" & session("usr_email") & "', "
	else
		sql = sql & "NULL, NULL, "
	end if
	sql = sql & "'" & session("modo") & "', "
	sql = sql & "'" & session("lang") & "', "
	
	cTxt = lcase(request.ServerVariables("PATH_INFO"))
	cTxt = replace(cTxt, "default.asp", "")
	sql = sql & "'" & cTxt & "', "
	
	if request.QueryString="" then 
		sql = sql & "NULL, "
	else
		sql = sql & "'" & ConvierteTexto(request.QueryString) & "', "
	end if
	if request.Form="" then 
		sql = sql & "NULL, "
	else
		sql = sql & "'" & ConvierteTexto(request.Form) & "', "
	end if
	if request.ServerVariables("HTTP_REFERER")="" then 
		sql = sql & "NULL, "
	else
		sql = sql & "'" & request.ServerVariables("HTTP_REFERER") & "', "
	end if

	sql = sql & "'" & session("pag_actual") & "', "
	sql = sql & "'" & session("pag_activa") & "', "
	sql = sql & "'" & session("pag_anterior") & "'"
	sql = sql & ")"
	
	'response.Write(sql)
	'response.Write("<hr>")
	
	session("cnx_easy").execute sql
end sub 
%>
