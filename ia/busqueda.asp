<!--#include virtual="/activa-v2/ia/api_call.asp"-->
<%
' /ia/busqueda.asp
' Agente 5: SmartSearch
' Interpreta lenguaje natural para el buscador del Header V2

Response.ContentType = "application/json"
Response.Charset = "utf-8"
On Error Resume Next

Dim sQuery
sQuery = Request.QueryString("q")

If Trim(sQuery) = "" Then
    Response.Write "{""error"": true, ""msg"": ""Mandar query vacia no está permitido""}"
    Response.End
End If

' 1. Prompting
Dim systemPrompt, userPrompt
systemPrompt = "Eres el Agente Inteligente de Busqueda para el portal Activa. Recibiras una busqueda humana. Tu deber es extraer entidades. " & _
"Responde EXCLUSIVAMENTE en formato JSON plano sin etiquetas markdown. Estructura requerida: " & _
"{""keywords_busqueda"": [""keyword1""], ""filtros_sugeridos"": {""tipo"": ""not|ope|dis|null"", ""segmento"": ""oficinas|locales|naves|hoteles|null"", ""ubicacion"": ""madrid|barcelona|...""}, ""sugerencias_alternativas"": [""sug1""]}"

userPrompt = "El usuario busca en un portal inmobiliario de noticias español. Consulta: """ & sQuery & """"

' 2. LLamada a la API 
' Usamos costo CERO para esta prueba, pero se guardaria como 'busqueda'
Dim finalJSON
finalJSON = CallIA_CompleteJSON(systemPrompt, userPrompt, "busqueda", 0)

If finalJSON = "" Or Left(finalJSON, 4) = "ERR:" Then
    ' Fallback, si la IA falla devolvemos lo esencial y dejamos el buscador legacy trabajar sin interrupciones.
    Response.Write "{""error"":true, ""keywords_busqueda"":[""" & Replace(sQuery, """", "\""") & """], ""sugerencias_alternativas"":[]}"
    Response.End
End If

' 3. Devolver JSON al frontend
' En producción aquí también podríamos hacer la query de BD con las keywords identificadas, 
' pero ahora la daremos al JS para que autocompleta con un lindo UI.
Response.Write finalJSON
%>
