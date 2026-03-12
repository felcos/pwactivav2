<!--#include virtual="/ia/config.asp"-->
<!--#include virtual="/ia/api_call.asp"-->
<!--#include virtual="/activa-v2/inc/layout/head-v2.asp"-->
<main class="av2-wrapper" style="padding: 40px 0;">
    <h1 style="margin-bottom: 30px; font-weight: 800;">Sistema de <span style="color: var(--accent);">Autodiagnóstico</span> Activa V2</h1>

    <div class="av2-grid" style="--grid-cols: 1; gap: 20px;">
        
        <!-- TEST 1: Conexión BD -->
        <div class="av2-card">
            <h3 style="margin-top:0;"><i class="fa-solid fa-database"></i> 1. Conexión a Base de Datos</h3>
            <div style="margin-top: 15px;">
                <%
                On Error Resume Next
                Dim connTest, sqlTest, rsTest
                Set connTest = Server.CreateObject("ADODB.Connection")
                connTest.Open session("connPW")
                
                If Err.Number <> 0 Then
                    Response.Write "<div class='av2-badge' style='background:var(--error); color:white;'>ERROR</div>"
                    Response.Write "<p style='color:var(--error); margin-top:10px;'>Fallo al abrir session(""connPW""): " & Err.Description & "</p>"
                    Response.Write "<p>Tip: Asegúrate de que el usuario de BD tiene permisos y la cadena es correcta.</p>"
                    Err.Clear
                Else
                    Response.Write "<div class='av2-badge' style='background:var(--success); color:white;'>OK</div>"
                    Response.Write "<p style='color:var(--success); margin-top:10px;'>Conexión establecida con éxito.</p>"
                    
                    ' Verificar tablas clave
                    Dim tables, t, found
                    tables = Array("AI_CONFIG", "AI_COSTES", "AI_RESUMENES", "AI_BRIEFINGS", "C_NOTICIAS_INMOBILIARIAS")
                    Response.Write "<ul style='font-size:0.85rem; padding-left:20px;'>"
                    For Each t In tables
                        Set rsTest = connTest.Execute("SELECT TOP 1 * FROM sysobjects WHERE name = '" & t & "' AND xtype = 'U'")
                        If Not rsTest.EOF Then
                            Response.Write "<li><i class='fa-solid fa-check' style='color:var(--success)'></i> Tabla " & t & " encontrada.</li>"
                        Else
                            Response.Write "<li><i class='fa-solid fa-xmark' style='color:var(--error)'></i> Tabla " & t & " NO encontrada.</li>"
                        End If
                        rsTest.Close
                    Next
                    Response.Write "</ul>"
                End If
                connTest.Close : Set connTest = Nothing
                %>
            </div>
        </div>

        <!-- TEST 2: Llamada API IA -->
        <div class="av2-card">
            <h3 style="margin-top:0;"><i class="fa-solid fa-robot"></i> 2. Conectividad Inteligencia Artificial</h3>
            <div style="margin-top: 15px;">
                <%
                ' Testeamos Groq (prioritario)
                Dim testResponse, jsonTest
                Response.Write "<p style='font-size:0.9rem;'>Probando llamada mínima a Groq Llama 3...</p>"
                
                testResponse = CallIA_CompleteJSON("Responde exactamente con este JSON: {""status"":""IA_OK""}", "Groq")
                
                If InStr(testResponse, "IA_OK") > 0 Then
                    Response.Write "<div class='av2-badge' style='background:var(--success); color:white;'>OK</div>"
                    Response.Write "<pre style='background:var(--bg-main); padding:10px; border-radius:5px; margin-top:10px; font-size:0.8rem;'>" & Server.HTMLEncode(testResponse) & "</pre>"
                Else
                    Response.Write "<div class='av2-badge' style='background:var(--error); color:white;'>ERROR</div>"
                    Response.Write "<p style='color:var(--error); margin-top:10px;'>Fallo en la llamada API. Revisa la API Key en config.asp y la salida del error en logs.</p>"
                    Response.Write "<pre style='background:var(--bg-main); padding:10px; border-radius:5px; margin-top:10px; font-size:0.8rem;'>" & Server.HTMLEncode(testResponse) & "</pre>"
                End If
                %>
            </div>
        </div>

        <!-- TEST 3: Integridad de Archivos -->
        <div class="av2-card">
            <h3 style="margin-top:0;"><i class="fa-solid fa-file-code"></i> 3. Integridad de Agentes (FileSystem)</h3>
            <div style="margin-top: 15px;">
                <ul style="font-size:0.9rem; list-style:none; padding:0;">
                <%
                Dim fso, agents, aPath
                Set fso = Server.CreateObject("Scripting.FileSystemObject")
                agents = Array("/ia/resumidor.asp", "/ia/briefing.asp", "/ia/busqueda.asp", "/ia/clasificador.asp", "/ia/relacionados.asp", "/ia/alertas.asp", "/ia/mercado.asp", "/ia/costes.asp", "/ia/admin_clasificador.asp")
                
                For Each aPath In agents
                    If fso.FileExists(Server.MapPath(aPath)) Then
                        Response.Write "<li style='margin-bottom:5px;'><i class='fa-solid fa-check-circle' style='color:var(--success)'></i> " & aPath & " ... OK</li>"
                    Else
                        Response.Write "<li style='margin-bottom:5px;'><i class='fa-solid fa-times-circle' style='color:var(--error)'></i> " & aPath & " ... NO ENCONTRADO</li>"
                    End If
                Next
                Set fso = Nothing
                %>
                </ul>
            </div>
        </div>

    </div>

    <div style="margin-top:40px; text-align:center;">
        <button class="av2-btn av2-btn-primary" onclick="location.reload()">REPETIR PRUEBAS</button>
        <a href="/activa-v2/default.asp" class="av2-btn av2-btn-outline" style="margin-left:10px;">IR A HOMEPAGE V2</a>
    </div>
</main>
<!--#include virtual="/activa-v2/inc/layout/footer-v2.asp"-->
