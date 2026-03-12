<%
' /ia/config.asp
' Archivo maestro de configuraciones de Inteligencia Artificial para Activa V2.
' Incluye credenciales (harcodeadas a nivel de entorno/prueba, ideal BD real) y configuraciones base.

Dim IA_PROVIDERS
Set IA_PROVIDERS = Server.CreateObject("Scripting.Dictionary")

' -------------------------------------------------------------------
' 1. OpenAI (GPT-4)
' -------------------------------------------------------------------
Dim aiOpenAI
Set aiOpenAI = Server.CreateObject("Scripting.Dictionary")
aiOpenAI.Add "provider", "openai"
aiOpenAI.Add "endpoint_chat", "https://api.openai.com/v1/chat/completions"
' Idealmente esta key se saca de AI_CONFIG con encriptacion, la hardcodeamos para desarrollo de la v2.
aiOpenAI.Add "api_key", "" 
aiOpenAI.Add "model_default", "gpt-4o-mini"
aiOpenAI.Add "model_advanced", "gpt-4o"
aiOpenAI.Add "active", True
aiOpenAI.Add "fallback_order", 2
IA_PROVIDERS.Add "openai", aiOpenAI

' -------------------------------------------------------------------
' 2. Anthropic (Claude)
' -------------------------------------------------------------------
Dim aiClaude
Set aiClaude = Server.CreateObject("Scripting.Dictionary")
aiClaude.Add "provider", "claude"
aiClaude.Add "endpoint_chat", "https://api.anthropic.com/v1/messages"
aiClaude.Add "api_key", ""
aiClaude.Add "model_default", "claude-3-5-haiku-20241022"
aiClaude.Add "model_advanced", "claude-3-5-sonnet-20241022"
aiClaude.Add "version_header", "2023-06-01"
aiClaude.Add "active", True
aiClaude.Add "fallback_order", 1
IA_PROVIDERS.Add "claude", aiClaude

' -------------------------------------------------------------------
' 3. Google (Gemini)
' -------------------------------------------------------------------
Dim aiGemini
Set aiGemini = Server.CreateObject("Scripting.Dictionary")
aiGemini.Add "provider", "gemini"
' La URL de Gemini suele requerir el modelo en la querystring:
aiGemini.Add "endpoint_base", "https://generativelanguage.googleapis.com/v1beta/models/"
aiGemini.Add "api_key", ""
aiGemini.Add "model_default", "gemini-1.5-flash"
aiGemini.Add "model_advanced", "gemini-1.5-pro"
aiGemini.Add "active", True
aiGemini.Add "fallback_order", 4
IA_PROVIDERS.Add "gemini", aiGemini

' -------------------------------------------------------------------
' 4. Groq (Llama 3 / Mixtral)
' -------------------------------------------------------------------
Dim aiGroq
Set aiGroq = Server.CreateObject("Scripting.Dictionary")
aiGroq.Add "provider", "groq"
aiGroq.Add "endpoint_chat", "https://api.groq.com/openai/v1/chat/completions"
aiGroq.Add "api_key", "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"
aiGroq.Add "model_default", "llama-3.3-70b-versatile"
aiGroq.Add "model_advanced", "llama-3.3-70b-versatile"
aiGroq.Add "active", True
aiGroq.Add "fallback_order", 0 ' Prioridad MAXIMA inicial para pruebas
IA_PROVIDERS.Add "groq", aiGroq


' Funcion global para obtener el proveedor activo segun el fallback order
Function GetActiveProvider(currentFailedProvidersDict)
    ' currentFailedProvidersDict sera un diccionario con los nombres de los proveedores que ya han fallado en una iteracion
    Dim p, bestOrder, selectedProvider
    bestOrder = 999
    selectedProvider = ""
    
    For Each p In IA_PROVIDERS.Keys
        If IA_PROVIDERS(p)("active") Then
            If Not currentFailedProvidersDict.Exists(p) Then
                If CInt(IA_PROVIDERS(p)("fallback_order")) < bestOrder Then
                    bestOrder = CInt(IA_PROVIDERS(p)("fallback_order"))
                    selectedProvider = p
                End If
            End If
        End If
    Next
    
    GetActiveProvider = selectedProvider
End Function
%>
