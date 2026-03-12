<!--#include virtual="/activa-v2/inc/layout/head-v2.asp"-->
<!--#include virtual="/activa-v2/inc/layout/header-v2.asp"-->
<main class="av2-wrapper" style="padding: 40px 0;">
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px;">
        <h1 style="font-size: 2rem; font-weight: 800; color: var(--text-primary);">Análisis de <span style="color: var(--accent);">Mercado</span></h1>
        <div class="av2-badge" style="background: var(--bg-surface); border: 1px solid var(--border-color); padding: 8px 15px;">
            <i class="fa-solid fa-chart-line" style="color: var(--accent); margin-right: 8px;"></i> Histórico Semanal
        </div>
    </div>

    <div class="av2-grid" style="--grid-cols: 1; gap: 30px;">
        <%
        Dim rs
        Set rs = Server.CreateObject("ADODB.Recordset")
        rs.Open "SELECT fecha, contenido_es FROM AI_BRIEFINGS WHERE tipo = 'semanal' ORDER BY fecha DESC", session("connPW")
        
        If rs.EOF Then
            Response.Write "<div class='av2-card' style='padding:40px; text-align:center;'>No se han generado análisis semanales todavía.</div>"
        End If

        Do While Not rs.EOF
        %>
        <div class="av2-card" style="padding: 30px;">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; border-bottom: 1px solid var(--border-color); padding-bottom: 15px;">
                <h3 style="margin: 0;">Análisis del <%= rs("fecha") %></h3>
                <span class="av2-badge" style="background: var(--accent); color: white;">Semanal</span>
            </div>
            <div class="av2-content" style="line-height: 1.6; color: var(--text-secondary);">
                <%= rs("contenido_es") %>
            </div>
        </div>
        <%
            rs.MoveNext
        Loop
        rs.Close : Set rs = Nothing
        %>
    </div>
</main>
<!--#include virtual="/activa-v2/inc/layout/footer-v2.asp"-->
