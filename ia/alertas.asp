<!--#include virtual="/activa-v2/ia/api_call.asp"-->
<%
' /ia/alertas.asp
' Agente 6: AlertDetector
' Analiza noticias recientes en busca de eventos de alto impacto.

Response.ContentType = "application/json"
Response.Charset = "utf-8"
On Error Resume Next

Dim token_seguridad
token_seguridad = Request.QueryString("key")

If token_seguridad <> "SECRET_CRON_V2" Then
    Response.Write "{""error"": true, ""msg"": ""No autorizado""}"
    Response.End
End If

' 1. Obtener artículos de las últimas 2 horas no procesados
Dim rsNoticias, titulos_extractos
titulos_extractos = ""
Set rsNoticias = Server.CreateObject("ADODB.Recordset")
rsNoticias.Open "SELECT TOP 15 ID, TITULO, LEFT(TEXTO, 300) AS EXTRACTO FROM C_NOTICIAS_INMOBILIARIAS " & _
                "WHERE FECHA_ACTUALIZACION >= DATEADD(hour, -2, GETDATE()) " & _
                "AND ID NOT IN (SELECT ISNULL(id_articulo, 0) FROM V2_NOTIFICACIONES WHERE tipo = 'alerta_ia') " & _
                "ORDER BY FECHA_ACTUALIZACION DESC", session("connPW")
Do While Not rsNoticias.EOF
    titulos_extractos = titulos_extractos & "[" & rsNoticias("ID") & "] - " & rsNoticias("TITULO") & " - " & Replace(rsNoticias("EXTRACTO") & "", vbCrLf, " ") & vbCrLf
    rsNoticias.MoveNext
Loop
rsNoticias.Close : Set rsNoticias = Nothing

' Añadir operaciones recientes
Dim rsOpe
Set rsOpe = Server.CreateObject("ADODB.Recordset")
rsOpe.Open "SELECT TOP 10 ID, TITULO, LEFT(TITULO, 200) AS EXTRACTO FROM w_OPERACIONES " & _
           "WHERE FECHA_ACTUALIZACION >= DATEADD(hour, -2, GETDATE()) " & _
           "ORDER BY FECHA_ACTUALIZACION DESC", session("connPW")
Do While Not rsOpe.EOF
    titulos_extractos = titulos_extractos & "[OPE-" & rsOpe("ID") & "] - " & rsOpe("TITULO") & vbCrLf
    rsOpe.MoveNext
Loop
rsOpe.Close : Set rsOpe = Nothing

If titulos_extractos = "" Then
    Response.Write "{""alertas"":[], ""msg"": ""Sin noticias nuevas para analizar""}"
    Response.End
End If

' 2. Prompting
Dim systemPrompt, userPrompt
systemPrompt = "Eres el Analista de Riesgos (AlertDetector) del CMS inmobiliario Activa. Busca eventos críticos " & _
"(operaciones >50M, quiebras, cambios de ley, mega-fusiones). Responde SOLO JSON: [{""id"": X, ""impacto"": ""alto|medio"", ""razon"": ""justificacion""}]"

userPrompt = "Analiza noticias recientes y devuelve SOLO las de ALTO IMPACTO:" & vbCrLf & vbCrLf & _
             "NOTICIAS:" & vbCrLf & titulos_extractos & vbCrLf & "JSON:"

' 3. LLamada
Dim finalJSON
finalJSON = CallIA_CompleteJSON(systemPrompt, userPrompt, "alerta", 0)

If finalJSON = "" Or Left(finalJSON, 4) = "ERR:" Then
    Response.Write "{""error"": true, ""msg"": ""Fallo en LLM para generar alertas""}"
    Response.End
End If

' 4. Guardar notificaciones en V2_NOTIFICACIONES
' En producción: parsear el JSON array y crear una notificación por cada alerta detectada
Dim connDB
Set connDB = Server.CreateObject("ADODB.Connection")
connDB.Open session("connPW")
connDB.Execute "INSERT INTO AI_COSTES (provider, tipo_operacion, fecha) VALUES ('groq', 'alerta', GETDATE())"
connDB.Close
Set connDB = Nothing

Response.Write finalJSON
%>
