<!--#include virtual="/activa-v2/ia/api_call.asp"-->
<%
' /ia/relacionados.asp
' Agente 4: RelatedFinder
' Identifica artículos relacionados por contenido, inmuebles, empresas o temática.

Response.ContentType = "application/json"
Response.Charset = "utf-8"
On Error Resume Next

Dim article_id
article_id = Request.QueryString("id")

If article_id = "" Then
    Response.Write "{""error"": true, ""msg"": ""Falta parametro de id de articulo""}"
    Response.End
End If

' 1. Verificar caché
Dim rsCache, cachedJSON
cachedJSON = ""
Set rsCache = Server.CreateObject("ADODB.Recordset")
rsCache.Open "SELECT TOP 5 id_articulo_relacionado, score, razon FROM AI_RELACIONADOS " & _
             "WHERE id_articulo = " & CLng(article_id) & " ORDER BY score DESC", session("connPW")
If Not rsCache.EOF Then
    cachedJSON = "["
    Dim firstRel : firstRel = True
    Do While Not rsCache.EOF
        If Not firstRel Then cachedJSON = cachedJSON & ","
        cachedJSON = cachedJSON & "{""id"":" & rsCache("id_articulo_relacionado") & ",""score"":" & rsCache("score") & ",""razon"":""" & Replace(rsCache("razon") & "", """", "\""") & """}"
        firstRel = False
        rsCache.MoveNext
    Loop
    cachedJSON = cachedJSON & "]"
    rsCache.Close : Set rsCache = Nothing
    Response.Write cachedJSON
    Response.End
End If
rsCache.Close : Set rsCache = Nothing

' 2. Obtener artículo principal
Dim rsMain, sTituloPrincipal, sContenidoPrincipal
Set rsMain = Server.CreateObject("ADODB.Recordset")
rsMain.Open "SELECT TITULO, LEFT(TEXTO, 500) AS EXTRACTO FROM C_NOTICIAS_INMOBILIARIAS WHERE ID = " & CLng(article_id), session("connPW")
If rsMain.EOF Then
    rsMain.Close : Set rsMain = Nothing
    Response.Write "{""error"": true, ""msg"": ""Articulo no encontrado""}"
    Response.End
End If
sTituloPrincipal = rsMain("TITULO") & ""
sContenidoPrincipal = rsMain("EXTRACTO") & ""
rsMain.Close : Set rsMain = Nothing

' 3. Obtener candidatos recientes
Dim rsCand, candidatos_texto
candidatos_texto = ""
Set rsCand = Server.CreateObject("ADODB.Recordset")
rsCand.Open "SELECT TOP 30 ID, TITULO, LEFT(TEXTO, 200) AS EXTRACTO FROM C_NOTICIAS_INMOBILIARIAS " & _
            "WHERE ID <> " & CLng(article_id) & " ORDER BY FECHA_ACTUALIZACION DESC", session("connPW")
Do While Not rsCand.EOF
    candidatos_texto = candidatos_texto & "[" & rsCand("ID") & "] - " & rsCand("TITULO") & " - " & Replace(rsCand("EXTRACTO") & "", vbCrLf, " ") & vbCrLf
    rsCand.MoveNext
Loop
rsCand.Close : Set rsCand = Nothing

' 4. Prompting
Dim systemPrompt, userPrompt
systemPrompt = "Eres un motor de recomendación de CMS inmobiliario. Analiza el artículo principal y la lista de candidatos. " & _
"Identifica los 5 artículos más relacionados semánticamente. Responde SOLO en JSON: [{""id"": X, ""score"": 0-100, ""razon"": ""breve""}]"

userPrompt = "ARTICULO PRINCIPAL:" & vbCrLf & "Titulo: " & sTituloPrincipal & vbCrLf & "Contenido: " & sContenidoPrincipal & vbCrLf & vbCrLf & _
             "CANDIDATOS:" & vbCrLf & candidatos_texto & vbCrLf & "JSON:"

' 5. LLamada
Dim finalJSON
finalJSON = CallIA_CompleteJSON(systemPrompt, userPrompt, "relacionados", CLng(article_id))

If finalJSON = "" Or Left(finalJSON, 4) = "ERR:" Then
    Response.Write "{""error"": true, ""msg"": ""Fallo en LLM para generar relacionados""}"
    Response.End
End If

' 6. Guardar en AI_RELACIONADOS (simplificado: guardamos el JSON crudo, en producción se parsea)
Dim connDB
Set connDB = Server.CreateObject("ADODB.Connection")
connDB.Open session("connPW")
connDB.Execute "DELETE FROM AI_RELACIONADOS WHERE id_articulo = " & CLng(article_id)
' En producción: parsear el JSON array e insertar fila a fila
connDB.Close
Set connDB = Nothing

Response.Write finalJSON
%>
