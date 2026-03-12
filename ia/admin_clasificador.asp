<!--#include virtual="/activa-v2/inc/layout/head-v2.asp"-->
<!--#include virtual="/activa-v2/inc/layout/header-v2.asp"-->
<main class="av2-wrapper" style="padding: 40px 0;">
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px;">
        <h1 style="font-size: 2rem; font-weight: 800; color: var(--text-primary);">Clasificador <span style="color: var(--accent);">IA Pendiente</span></h1>
        <div class="av2-badge" style="background: var(--bg-surface); border: 1px solid var(--border-color); padding: 8px 15px;">
            <i class="fa-solid fa-robot" style="color: var(--accent); margin-right: 8px;"></i> Agente 3
        </div>
    </div>

    <div class="av2-card" style="padding: 25px;">
        <table style="width: 100%; border-collapse: collapse;">
            <thead>
                <tr style="text-align: left; border-bottom: 2px solid var(--border-color);">
                    <th style="padding: 12px;">Artículo</th>
                    <th style="padding: 12px;">Sugerencias IA</th>
                    <th style="padding: 12px; text-align: right;">Acciones</th>
                </tr>
            </thead>
            <tbody>
                <%
                Dim rs
                Set rs = Server.CreateObject("ADODB.Recordset")
                ' Unimos con C_NOTICIAS para ver el titulo
                rs.Open "SELECT a.id_articulo, n.TITULO, a.categoria_sugerida, a.prioridad_sugerida, a.keywords_sugeridos, a.segmento " & _
                        "FROM AI_CLASIFICACIONES a INNER JOIN C_NOTICIAS_INMOBILIARIAS n ON a.id_articulo = n.ID " & _
                        "WHERE a.aprobado = 0 ORDER BY a.fecha_creacion DESC", session("connPW")
                
                Do While Not rs.EOF
                %>
                <tr style="border-bottom: 1px solid var(--border-color);">
                    <td style="padding: 15px; vertical-align: top;">
                        <div style="font-weight: 700; color: var(--text-primary); margin-bottom: 5px;"><%= rs("TITULO") %></div>
                        <div style="font-size: 0.8rem; color: var(--text-muted);">ID: <%= rs("id_articulo") %></div>
                    </td>
                    <td style="padding: 15px; vertical-align: top;">
                        <div style="display: flex; flex-wrap: wrap; gap: 5px; margin-bottom: 10px;">
                            <span class="av2-badge" style="background: var(--bg-main); color: var(--accent); border: 1px solid var(--accent);"><%= rs("categoria_sugerida") %></span>
                            <span class="av2-badge" style="background: var(--bg-main); color: var(--info); border: 1px solid var(--info);"><%= rs("prioridad_sugerida") %></span>
                            <span class="av2-badge" style="background: var(--bg-main); color: var(--success); border: 1px solid var(--success);"><%= rs("segmento") %></span>
                        </div>
                        <div style="font-size: 0.85rem; color: var(--text-secondary);">
                            <strong>Keywords:</strong> <%= rs("keywords_sugeridos") %>
                        </div>
                    </td>
                    <td style="padding: 15px; text-align: right; vertical-align: middle;">
                        <button class="av2-button" style="padding: 8px 15px; font-size: 0.85rem;" onclick="alert('Funcionalidad de aprobación en desarrollo para Backend Final')">
                            Aprobar
                        </button>
                        <button class="av2-button" style="background: transparent; color: var(--text-muted); border: 1px solid var(--border-color); padding: 8px 15px; font-size: 0.85rem; margin-top: 5px;">
                            Editar
                        </button>
                    </td>
                </tr>
                <%
                    rs.MoveNext
                Loop
                rs.Close : Set rs = Nothing
                %>
            </tbody>
        </table>
    </div>
</main>
<!--#include virtual="/activa-v2/inc/layout/footer-v2.asp"-->
