<!--#include virtual="/activa-v2/ia/api_call.asp"-->
<%
' /ia/resumidor.asp
' Agente 1: Article Summarizer.
' Produce resumenes de articulos on-demand desde el UI de vista previa de articulo.
Response.ContentType = "application/json"
Response.Charset = "utf-8"

On Error Resume Next

Dim artId, lang
artId = Request.QueryString("id")
lang = Request.QueryString("lang")

If artId = "" Then
    Response.Write "{""error"": true, ""msg"": ""ID no proporcionado""}"
    Response.End
End If

If lang = "" Then lang = "es"

' 1. Verificar Cache en BD (Tabla AI_RESUMENES)
Dim bCacheExists : bCacheExists = False 
Dim cachedSummary : cachedSummary = ""
Dim rsCache
Set rsCache = Server.CreateObject("ADODB.Recordset")
rsCache.Open "SELECT resumen FROM AI_RESUMENES WHERE id_articulo = " & CLng(artId) & " AND idioma = '" & Left(lang,2) & "'", session("connPW")
If Not rsCache.EOF Then
    bCacheExists = True
    cachedSummary = rsCache("resumen") & ""
End If
rsCache.Close
Set rsCache = Nothing

If bCacheExists And cachedSummary <> "" Then
    Response.Write "{""error"": false, ""resumen"": """ & Replace(Replace(cachedSummary, "\", "\\"), """", "\""") & """, ""cached"": true}"
    Response.End
End If

' 2. Obtener texto del articulo original de la BD
Dim rsArt, arrTextoBody
Set rsArt = Server.CreateObject("ADODB.Recordset")
rsArt.Open "SELECT TITULO, TEXTO FROM C_NOTICIAS_INMOBILIARIAS WHERE ID = " & CLng(artId), session("connPW")
If rsArt.EOF Then
    Response.Write "{""error"": true, ""msg"": ""Articulo no encontrado en BD""}"
    rsArt.Close : Set rsArt = Nothing
    Response.End
End If
arrTextoBody = rsArt("TITULO") & ". " & Left(rsArt("TEXTO") & "", 2000)
rsArt.Close
Set rsArt = Nothing

' 3. Construir los Prompts
Dim systemPrompt, userPrompt
systemPrompt = "Eres un asistente experto analista de mercados inmobiliarios españoles. Tu objetivo es resumir estrictamente el articulo entregado en 2-3 frases muy concisas. Destaca los actores (empresas), cifras clave (dinero/metros) y ubicacion si las hay. Responde en JSON estricto con una clave 'resumen'."

' Indicar el idioma de salida
If LCase(lang) = "en" Then
    userPrompt = "Please summarize this real estate article in English. Respond ONLY in valid JSON format: {\""resumen\"": \""Your summary here\""}. Article: " & arrTextoBody
Else
    userPrompt = "Por favor, resume este artículo inmobiliario en Español. Responde SOLO en formato JSON válido: {\""resumen\"": \""Tu resumen aqui\""}. Articulo: " & arrTextoBody
End If

' 4. Realizar conexion al Gateway Unificado
Dim finalJSON
finalJSON = CallIA_CompleteJSON(systemPrompt, userPrompt, "resumen", artId)

If finalJSON = "" Or Left(finalJSON, 4) = "ERR:" Then
    Response.Write "{""error"": true, ""msg"": ""Fallo en LLM""}"
    Response.End
End If

' 5. Guardar en Cache
Dim connDB
Set connDB = Server.CreateObject("ADODB.Connection")
connDB.Open session("connPW")
connDB.Execute "INSERT INTO AI_RESUMENES (id_articulo, idioma, resumen, provider, fecha_creacion) " & _
               "VALUES (" & CLng(artId) & ", '" & Left(lang,2) & "', N'" & Replace(finalJSON, "'", "''") & "', 'groq', GETDATE())"
connDB.Close
Set connDB = Nothing

' Vuelca la respuesta unificada al HTTP
Response.Write finalJSON
%>
