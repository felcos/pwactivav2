<%@ Language=VBScript CodePage=65001 %>
<%
' /ia/alertas_cron.asp
' Wrapper CRON para invocar el AlertDetector (Agente 6)
' Se ejecuta cada 30 min (o configurable) 

Response.ContentType = "text/plain"
Response.Charset = "utf-8"

Dim token_seguridad
token_seguridad = Request.QueryString("key")

If token_seguridad <> "SECRET_CRON_V2" Then
    Response.Write "ERROR: Invalid Token"
    Response.End
End If

Dim http, url, res
Set http = Server.CreateObject("MSXML2.ServerXMLHTTP.6.0")
url = "http://" & Request.ServerVariables("HTTP_HOST") & "/activa-v2/ia/alertas.asp?key=" & token_seguridad

http.Open "GET", url, False
http.Send

If http.Status = 200 Then
    res = http.responseText
    If InStr(res, """error"": true") > 0 Then
        Response.Write "CRON_ALERT_FAILED: " & res
    Else
        Response.Write "CRON_ALERT_SUCCESS: Analisis ejecutado a las " & Now() & vbCrLf & res
    End If
Else
    Response.Write "CRON_HTTP_ERROR: " & http.Status
End If

Set http = Nothing
%>
