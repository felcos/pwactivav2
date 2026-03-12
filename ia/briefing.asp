<!--#include virtual="/activa-v2/ia/api_call.asp"-->
<%
' /ia/briefing.asp
' Agente 2: Daily Briefing
' Genera un resumen ejecutivo del día analizando las noticias reales de la DB.

Response.ContentType = "application/json"
Response.Charset = "utf-8"
On Error Resume Next

Dim token_seguridad
token_seguridad = Request.QueryString("key")

If token_seguridad <> "SECRET_CRON_V2" Then
    Response.Write "{""error"": true, ""msg"": ""No autorizado""}"
    Response.End
End If

' 1. Verificar si ya hay briefing de hoy
Dim rsBriefing
Set rsBriefing = Server.CreateObject("ADODB.Recordset")
rsBriefing.Open "SELECT TOP 1 contenido_es FROM AI_BRIEFINGS WHERE fecha = CONVERT(DATE, GETDATE()) AND tipo = 'diario'", session("connPW")
If Not rsBriefing.EOF Then
    Dim cachedBriefing
    cachedBriefing = rsBriefing("contenido_es") & ""
    rsBriefing.Close : Set rsBriefing = Nothing
    Response.Write cachedBriefing
    Response.End
End If
rsBriefing.Close : Set rsBriefing = Nothing

' 2. Obtener noticias de las ultimas 24 horas de BD
Dim rsNoticias, texto_contexto
texto_contexto = ""
Set rsNoticias = Server.CreateObject("ADODB.Recordset")
rsNoticias.Open "SELECT TOP 20 TITULO, TIPO_NOTICIA FROM C_NOTICIAS_INMOBILIARIAS " & _
                "WHERE FECHA_ACTUALIZACION >= DATEADD(day, -1, GETDATE()) " & _
                "ORDER BY FECHA_ACTUALIZACION DESC", session("connPW")
Dim sCategoria
Do While Not rsNoticias.EOF
    Select Case rsNoticias("TIPO_NOTICIA") & ""
        Case "N": sCategoria = "NOTICIA"
        Case "W": sCategoria = "RUMOR"
        Case "E": sCategoria = "ESTUDIO"
        Case Else: sCategoria = "OTRO"
    End Select
    texto_contexto = texto_contexto & "- [" & sCategoria & "] " & rsNoticias("TITULO") & vbCrLf
    rsNoticias.MoveNext
Loop
rsNoticias.Close : Set rsNoticias = Nothing

' Añadir operaciones recientes
Dim rsOpe
Set rsOpe = Server.CreateObject("ADODB.Recordset")
rsOpe.Open "SELECT TOP 10 TITULO FROM w_OPERACIONES " & _
           "WHERE FECHA_ACTUALIZACION >= DATEADD(day, -1, GETDATE()) " & _
           "ORDER BY FECHA_ACTUALIZACION DESC", session("connPW")
Do While Not rsOpe.EOF
    texto_contexto = texto_contexto & "- [OPERACION] " & rsOpe("TITULO") & vbCrLf
    rsOpe.MoveNext
Loop
rsOpe.Close : Set rsOpe = Nothing

If texto_contexto = "" Then
    texto_contexto = "No hay noticias nuevas en las últimas 24 horas."
End If

' 3. Prompting
Dim systemPrompt, userPrompt
systemPrompt = "Eres el analista jefe (Daily Briefing Agent) del portal Activa. Genera un briefing estructurado del mercado inmobiliario español para inversores. Tono ejecutivo. Responde estrictamente en JSON: {""breifing_html"": ""<contenido html>""}"

userPrompt = "Genera un briefing ejecutivo del mercado inmobiliario para hoy (" & Date() & ")." & vbCrLf & vbCrLf & _
             "Noticias recientes:" & vbCrLf & texto_contexto & vbCrLf & _
             "Formato: Párrafo general (3 frases), enumera noticias clave. SOLO JSON."

' 4. LLamada 
Dim finalJSON
finalJSON = CallIA_CompleteJSON(systemPrompt, userPrompt, "briefing", 0)

If finalJSON = "" Or Left(finalJSON, 4) = "ERR:" Then
    Response.Write "{""error"": true, ""msg"": ""Fallo en LLM para generar Briefing""}"
    Response.End
End If

' 5. Guardar en AI_BRIEFINGS
Dim connDB
Set connDB = Server.CreateObject("ADODB.Connection")
connDB.Open session("connPW")
connDB.Execute "INSERT INTO AI_BRIEFINGS (fecha, tipo, contenido_es, provider, fecha_creacion) " & _
               "VALUES (CONVERT(DATE, GETDATE()), 'diario', N'" & Replace(finalJSON, "'", "''") & "', 'groq', GETDATE())"
connDB.Close
Set connDB = Nothing

Response.Write finalJSON
%>
