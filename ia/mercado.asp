<!--#include virtual="/activa-v2/ia/api_call.asp"-->
<%
' /ia/mercado.asp
' Agente 7: MarketAnalyzer
' Genera análisis semanal del mercado inmobiliario con datos reales agregados.

Response.ContentType = "application/json"
Response.Charset = "utf-8"
On Error Resume Next

Dim token_seguridad
token_seguridad = Request.QueryString("key")

If token_seguridad <> "SECRET_CRON_V2" Then
    Response.Write "{""error"": true, ""msg"": ""No autorizado para MarketAnalyzer""}"
    Response.End
End If

' 1. Verificar si ya hay reporte semanal de esta semana
Dim rsBriefing
Set rsBriefing = Server.CreateObject("ADODB.Recordset")
rsBriefing.Open "SELECT TOP 1 contenido_es FROM AI_BRIEFINGS " & _
               "WHERE tipo = 'semanal' AND fecha >= DATEADD(day, -7, GETDATE()) " & _
               "ORDER BY fecha DESC", session("connPW")
If Not rsBriefing.EOF Then
    Response.Write rsBriefing("contenido_es") & ""
    rsBriefing.Close : Set rsBriefing = Nothing
    Response.End
End If
rsBriefing.Close : Set rsBriefing = Nothing

' 2. Recopilar datos reales de la semana
Dim datos_agregados : datos_agregados = ""

' Contar operaciones por tipo/segmento
Dim rsOpeCount
Set rsOpeCount = Server.CreateObject("ADODB.Recordset")
rsOpeCount.Open "SELECT seccion, COUNT(*) AS total FROM w_OPERACIONES " & _
                "WHERE FECHA_ACTUALIZACION >= DATEADD(day, -7, GETDATE()) " & _
                "GROUP BY seccion", session("connPW")
datos_agregados = datos_agregados & "OPERACIONES DE LA SEMANA:" & vbCrLf
Do While Not rsOpeCount.EOF
    datos_agregados = datos_agregados & "- " & rsOpeCount("seccion") & ": " & rsOpeCount("total") & " operaciones" & vbCrLf
    rsOpeCount.MoveNext
Loop
rsOpeCount.Close : Set rsOpeCount = Nothing

' Contar noticias por tipo
Dim rsNotCount
Set rsNotCount = Server.CreateObject("ADODB.Recordset")
rsNotCount.Open "SELECT TIPO_NOTICIA, COUNT(*) AS total FROM C_NOTICIAS_INMOBILIARIAS " & _
                "WHERE FECHA_ACTUALIZACION >= DATEADD(day, -7, GETDATE()) " & _
                "GROUP BY TIPO_NOTICIA", session("connPW")
datos_agregados = datos_agregados & vbCrLf & "NOTICIAS DE LA SEMANA:" & vbCrLf
Dim sTipoNom
Do While Not rsNotCount.EOF
    Select Case rsNotCount("TIPO_NOTICIA") & ""
        Case "N": sTipoNom = "Noticias"
        Case "W": sTipoNom = "Rumores"
        Case "E": sTipoNom = "Estudios"
        Case "B": sTipoNom = "Demandas"
        Case Else: sTipoNom = "Otros"
    End Select
    datos_agregados = datos_agregados & "- " & sTipoNom & ": " & rsNotCount("total") & vbCrLf
    rsNotCount.MoveNext
Loop
rsNotCount.Close : Set rsNotCount = Nothing

' Titulares destacados de la semana
Dim rsTitulares
Set rsTitulares = Server.CreateObject("ADODB.Recordset")
rsTitulares.Open "SELECT TOP 10 TITULO FROM C_NOTICIAS_INMOBILIARIAS " & _
                 "WHERE FECHA_ACTUALIZACION >= DATEADD(day, -7, GETDATE()) " & _
                 "ORDER BY FECHA_ACTUALIZACION DESC", session("connPW")
datos_agregados = datos_agregados & vbCrLf & "TITULARES DESTACADOS:" & vbCrLf
Do While Not rsTitulares.EOF
    datos_agregados = datos_agregados & "- " & rsTitulares("TITULO") & vbCrLf
    rsTitulares.MoveNext
Loop
rsTitulares.Close : Set rsTitulares = Nothing

If datos_agregados = "" Then
    datos_agregados = "Sin datos suficientes esta semana."
End If

' 3. Prompt Semanal Experto
Dim systemPrompt, userPrompt
systemPrompt = "Eres un analista senior del mercado inmobiliario español (MarketAnalyzer de Activa). Genera el boletín semanal profesional. " & _
"Responde EXCLUSIVAMENTE en JSON con clave 'analisis_html'."

userPrompt = "Análisis Semanal: " & DateAdd("d", -7, Date()) & " a " & Date() & vbCrLf & vbCrLf & _
             "DATOS:" & vbCrLf & datos_agregados & vbCrLf & _
             "Formato (300 palabras max HTML): 1. Panorama 2. Tendencias segmento 3. Operaciones top 4. Perspectiva. JSON!"

' 4. LLamada
Dim finalJSON
finalJSON = CallIA_CompleteJSON(systemPrompt, userPrompt, "mercado", 0)

If finalJSON = "" Or Left(finalJSON, 4) = "ERR:" Then
    Response.Write "{""error"": true, ""msg"": ""Fallo en LLM para Analizador de Mercado""}"
    Response.End
End If

' 5. Guardar como Reporte Semanal
Dim connDB
Set connDB = Server.CreateObject("ADODB.Connection")
connDB.Open session("connPW")
connDB.Execute "INSERT INTO AI_BRIEFINGS (fecha, tipo, contenido_es, provider, fecha_creacion) " & _
               "VALUES (CONVERT(DATE, GETDATE()), 'semanal', N'" & Replace(finalJSON, "'", "''") & "', 'groq', GETDATE())"
connDB.Close
Set connDB = Nothing

Response.Write finalJSON
%>
