<!--#include virtual="/activa-v2/ia/config.asp"-->
<!--#include virtual="/activa-v2/ia/costes_check.asp"-->
<%
' /ia/api_call.asp
' Wrapper REST Unificado con adaptadores para la API de OpenAI, Claude y Gemini.
' Protegido con Timouts agresivos de 10-15s para no bloquear IIS.

Function CallIA_CompleteJSON(systemPrompt, userPrompt, tipoOperacion, idReferencia)
    Dim dictFailedProviders
    Set dictFailedProviders = Server.CreateObject("Scripting.Dictionary")
    
    Dim resultJSON
    resultJSON = "{""error"": true, ""msg"": ""No hay proveedores disponibles o todos fallaron""}"
    
    Dim continueTrying, providerToUse
    continueTrying = True
    
    Do While continueTrying
        providerToUse = GetActiveProvider(dictFailedProviders)
        
        If providerToUse = "" Then
            ' Se acabaron los proveedores
            continueTrying = False
            Exit Do
        End If
        
        ' Verificar Costes en Base de Datos de este proveedor especifico
        If Not CheckIABudget(providerToUse) Then
            ' Proveedor agotado en presupuesto, intentar el siguiente
            dictFailedProviders.Add providerToUse, "budget_exhausted"
        Else
            ' Hay presupuesto, realizar la llamada real dependiendo del adaptador.
            Dim apiResponse
            apiResponse = ExecuteRESTCall(providerToUse, systemPrompt, userPrompt)
            
            If Left(apiResponse, 6) = "ERROR:" Then
                ' Fallo de Red o Timeout. Add al Diccionario y probar el siguiente fallback
                dictFailedProviders.Add providerToUse, apiResponse
            Else
                ' Llamada Exitosa. (Idealmente aqui se logea el Coste real leyendo los Usage tokens de la respuesta).
                Call LogIACost(providerToUse, "default", 150, 100, tipoOperacion, idReferencia)
                
                resultJSON = CleanJSONResponse(apiResponse)
                continueTrying = False
            End If
        End If
    Loop
    
    CallIA_CompleteJSON = resultJSON
End Function

' Privada: Llama y adapta la peticion
Function ExecuteRESTCall(provider, sys, usr)
    On Error Resume Next
    Dim xmlhttp, url, payload, authHeader
    Set xmlhttp = Server.CreateObject("MSXML2.ServerXMLHTTP.6.0")
    
    ' TIMEOUTS AGRESIVOS: Resolve (5s), Connect (5s), Send (15s), Receive (15s)
    ' Regla #1 extraida de la validacion arquitectonica para evitar colapsar IIS.
    xmlhttp.setTimeouts 5000, 5000, 15000, 15000 
    
    If provider = "openai" Or provider = "groq" Then
        url = IA_PROVIDERS(provider)("endpoint_chat")
        authHeader = "Bearer " & IA_PROVIDERS(provider)("api_key")
        ' OpenAI Format Payload (Escapar comillas es critico en ASP)
        payload = "{""model"": """ & IA_PROVIDERS(provider)("model_default") & """, ""messages"": [{""role"": ""system"", ""content"": """ & Replace(sys, """", "\""") & """}, {""role"": ""user"", ""content"": """ & Replace(usr, """", "\""") & """}], ""temperature"": 0.2, ""response_format"": {""type"": ""json_object""}}"
        
        xmlhttp.Open "POST", url, False
        xmlhttp.setRequestHeader "Content-Type", "application/json"
        xmlhttp.setRequestHeader "Authorization", authHeader
        
    ElseIf provider = "claude" Then
        url = IA_PROVIDERS("claude")("endpoint_chat")
        authHeader = IA_PROVIDERS("claude")("api_key")
        ' Claude Format Payload
        payload = "{""model"": """ & IA_PROVIDERS("claude")("model_default") & """, ""max_tokens"": 1024, ""system"": """ & Replace(sys, """", "\""") & """, ""messages"": [{""role"": ""user"", ""content"": """ & Replace(usr, """", "\""") & """}]}"
        
        xmlhttp.Open "POST", url, False
        xmlhttp.setRequestHeader "Content-Type", "application/json"
        xmlhttp.setRequestHeader "x-api-key", authHeader
        xmlhttp.setRequestHeader "anthropic-version", IA_PROVIDERS("claude")("version_header")
        
    ElseIf provider = "gemini" Then
        ' Gemini Format Payload
        url = IA_PROVIDERS("gemini")("endpoint_base") & IA_PROVIDERS("gemini")("model_default") & ":generateContent?key=" & IA_PROVIDERS("gemini")("api_key")
        payload = "{""contents"":[{""parts"":[{""text"": """ & Replace(sys & " | " & usr, """", "\""") & """}]}]}"
        
        xmlhttp.Open "POST", url, False
        xmlhttp.setRequestHeader "Content-Type", "application/json"
    End If
    
    xmlhttp.Send payload
    
    If Err.Number <> 0 Then
        ExecuteRESTCall = "ERROR: " & Err.Description
        Err.Clear
        Exit Function
    End If
    
    If xmlhttp.Status >= 400 Then
        ExecuteRESTCall = "ERROR: HTTP " & xmlhttp.Status & " - " & xmlhttp.responseText
    Else
        ' Devolver la respuesta en String. Luego el controlador la procesara.
        ExecuteRESTCall = xmlhttp.responseText
    End If
    
    Set xmlhttp = Nothing
End Function

' Privada: Limpia la respuesta por si el LLM la envuelve en Markdown.
' Regla #4 extraida de documentacion futura (Parser VBScript crashea facil)
Function CleanJSONResponse(rawText)
    Dim cleanText
    cleanText = rawText
    
    ' Busqueda simple de las llaves principales sin librerias regexp complicadas
    Dim startPos, endPos
    startPos = InStr(cleanText, "{")
    endPos = InStrRev(cleanText, "}")
    
    If startPos > 0 And endPos > startPos Then
        cleanText = Mid(cleanText, startPos, (endPos - startPos) + 1)
    Else
        ' Fallback Array inicial si es lista de relacionados/alertas
        startPos = InStr(cleanText, "[")
        endPos = InStrRev(cleanText, "]")
        If startPos > 0 And endPos > startPos Then
            cleanText = Mid(cleanText, startPos, (endPos - startPos) + 1)
        End If
    End If
    
    CleanJSONResponse = cleanText
End Function
%>
