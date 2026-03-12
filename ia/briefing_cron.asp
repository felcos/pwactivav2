<%@ Language=VBScript CodePage=65001 %>
<%
' /ia/briefing_cron.asp
' Wrapper CRON para invocar el Briefing sin output visual al scheduler
' Ejecutable vía wget o curl con Task Scheduler
Response.ContentType = "text/plain"
Response.Charset = "utf-8"

Dim token_seguridad
token_seguridad = Request.QueryString("key")

If token_seguridad <> "SECRET_CRON_V2" Then
    Response.Write "ERROR: Invalid Token"
    Response.End
End If

' Usamos ServerXMLHTTP para auto-llamarnos así no bloqueamos el cron si hay que hacer más cosas directas.
Dim http, url, res
Set http = Server.CreateObject("MSXML2.ServerXMLHTTP.6.0")

' La URL real dependerá del entorno. Usamos el request actual para armarla.
url = "http://" & Request.ServerVariables("HTTP_HOST") & "/activa-v2/ia/briefing.asp?key=" & token_seguridad

http.Open "GET", url, False
http.Send

If http.Status = 200 Then
    res = http.responseText
    If InStr(res, """error"": true") > 0 Then
        Response.Write "CRON_FAILED: " & res
    Else
        Response.Write "CRON_SUCCESS: Generado Briefing a las " & Now()
    End If
Else
    Response.Write "CRON_HTTP_ERROR: " & http.Status
End If

Set http = Nothing
%>
