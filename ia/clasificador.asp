<!--#include virtual="/activa-v2/ia/api_call.asp"-->
<%
' /ia/clasificador.asp
' Agente 3: ArticleClassifier
' Sugiere categoría, prioridad y keywords leyendo Titulo y Contenido reales de BD.

Response.ContentType = "application/json"
Response.Charset = "utf-8"
On Error Resume Next

Dim article_id
article_id = Request.QueryString("id")

If article_id = "" Then
    Response.Write "{""error"": true, ""msg"": ""Falta parametro de articulo""}"
    Response.End
End If

' 1. Verificar caché existente
Dim rsCache
Set rsCache = Server.CreateObject("ADODB.Recordset")
rsCache.Open "SELECT TOP 1 categoria_sugerida, prioridad_sugerida, keywords_sugeridos, empresas_detectadas, ubicaciones_detectadas, tipo_operacion, segmento " & _
             "FROM AI_CLASIFICACIONES WHERE id_articulo = " & CLng(article_id) & " AND aprobado = 0", session("connPW")
If Not rsCache.EOF Then
    ' Devolver la clasificación pendiente de aprobar
    Dim jsonCache
    jsonCache = "{""categoria"":""" & rsCache("categoria_sugerida") & """,""prioridad"":""" & rsCache("prioridad_sugerida") & """"
    jsonCache = jsonCache & ",""keywords"":[""" & Replace(rsCache("keywords_sugeridos") & "", ",", """,""") & """]"
    jsonCache = jsonCache & ",""empresas_mencionadas"":[""" & Replace(rsCache("empresas_detectadas") & "", ",", """,""") & """]"
    jsonCache = jsonCache & ",""ubicaciones"":[""" & Replace(rsCache("ubicaciones_detectadas") & "", ",", """,""") & """]"
    jsonCache = jsonCache & ",""tipo_operacion"":""" & rsCache("tipo_operacion") & """,""segmento"":""" & rsCache("segmento") & """,""cached"":true}"
    rsCache.Close : Set rsCache = Nothing
    Response.Write jsonCache
    Response.End
End If
rsCache.Close : Set rsCache = Nothing

' 2. Obtener datos reales del artículo
Dim rsArt, sTitulo, sContenido
Set rsArt = Server.CreateObject("ADODB.Recordset")
rsArt.Open "SELECT TITULO, TEXTO FROM C_NOTICIAS_INMOBILIARIAS WHERE ID = " & CLng(article_id), session("connPW")
If rsArt.EOF Then
    rsArt.Close : Set rsArt = Nothing
    Response.Write "{""error"": true, ""msg"": ""Articulo no encontrado""}"
    Response.End
End If
sTitulo = rsArt("TITULO") & ""
sContenido = Left(rsArt("TEXTO") & "", 1500)
rsArt.Close : Set rsArt = Nothing

' 3. Prompting
Dim systemPrompt, userPrompt
systemPrompt = "Eres un asistente AI integrador de CMS inmobiliario. Analiza título y contenido para sugerir Metadata. Responde SOLO con JSON:" & _
"{""categoria"": ""not|rum|est|ope|ven|sub|dem|dis|t4a|ofe"", ""prioridad"": ""alta|media|baja"", ""keywords"": [""key1""], ""empresas_mencionadas"": [""emp1""], ""ubicaciones"": [""ub1""], ""tipo_operacion"": ""alquiler|venta|inversion|null"", ""segmento"": ""oficinas|locales|naves|hoteles|null""}"

userPrompt = "Clasifica este artículo inmobiliario:" & vbCrLf & "Titulo: " & sTitulo & vbCrLf & "Contenido: " & sContenido & vbCrLf & "JSON:"

' 4. LLamada
Dim finalJSON
finalJSON = CallIA_CompleteJSON(systemPrompt, userPrompt, "clasificacion", CLng(article_id))

If finalJSON = "" Or Left(finalJSON, 4) = "ERR:" Then
    Response.Write "{""error"": true, ""msg"": ""Fallo la extracción en el clasificador.""}"
    Response.End
End If

' 5. Guardar en AI_CLASIFICACIONES
Dim connDB
Set connDB = Server.CreateObject("ADODB.Connection")
connDB.Open session("connPW")
connDB.Execute "INSERT INTO AI_CLASIFICACIONES (id_articulo, categoria_sugerida, prioridad_sugerida, keywords_sugeridos, fecha_creacion) " & _
               "VALUES (" & CLng(article_id) & ", '', '', N'" & Replace(finalJSON, "'", "''") & "', GETDATE())"
connDB.Close
Set connDB = Nothing

Response.Write finalJSON
%>
