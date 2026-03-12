<%@ Language=VBScript CodePage=65001 %>
<%
' /ia/mercado_cron.asp
' Wrapper CRON para el MarketAnalyzer Semanal

Response.ContentType = "text/plain"
Response.Charset = "utf-8"

Dim token_seguridad
token_seguridad = Request.QueryString("key")

If token_seguridad <> "SECRET_CRON_V2" Then
    Response.Write "ERROR: Invalid Token"
    Response.End
End If

' Ejecutar el reporte semanal
Dim http, url, res
Set http = Server.CreateObject("MSXML2.ServerXMLHTTP.6.0")
' IMPORTANTE: Aumentar Timeouts masivamente ya que el reporte semanal gastará varios miles de tokens. (Resolve, Connect, Send, Receive)
http.setTimeouts 5000, 5000, 10000, 45000 

url = "http://" & Request.ServerVariables("HTTP_HOST") & "/activa-v2/ia/mercado.asp?key=" & token_seguridad

http.Open "GET", url, False
http.Send

If http.Status = 200 Then
    res = http.responseText
    If InStr(res, """error"": true") > 0 Then
        Response.Write "CRON_MARKET_FAILED: " & res
    Else
        Response.Write "CRON_MARKET_SUCCESS: Terminado a las " & Now()
    End If
Else
    Response.Write "CRON_MARKET_HTTP_ERROR: " & http.Status
End If

Set http = Nothing
%>
