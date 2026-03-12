<!--#include virtual="/activa-v2/inc/layout/head-v2.asp"-->
<!--#include virtual="/activa-v2/inc/layout/header-v2.asp"-->
<main class="av2-wrapper" style="padding: 40px 0;">
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px;">
        <h1 style="font-size: 2rem; font-weight: 800; color: var(--text-primary);">Monitor de <span style="color: var(--accent);">Costes IA</span></h1>
        <div class="av2-badge" style="background: var(--bg-surface); border: 1px solid var(--border-color); padding: 8px 15px;">
            <i class="fa-solid fa-calendar-day" style="color: var(--accent); margin-right: 8px;"></i> <%= Date() %>
        </div>
    </div>

    <%
    ' Obtener resumen de costes de la base de datos
    Dim rsCostes, gastoHoy, gastoMes, limDiario, limMensual
    gastoHoy = 0 : gastoMes = 0 : limDiario = 0 : limMensual = 0
    
    On Error Resume Next
    Set rsCostes = Server.CreateObject("ADODB.Recordset")
    rsCostes.Open "SELECT " & _
                  "(SELECT SUM(coste_estimado) FROM AI_COSTES WHERE CAST(fecha AS DATE) = CAST(GETDATE() AS DATE)) as hoy, " & _
                  "(SELECT SUM(coste_estimado) FROM AI_COSTES WHERE MONTH(fecha) = MONTH(GETDATE()) AND YEAR(fecha) = YEAR(GETDATE())) as mes, " & _
                  "(SELECT SUM(presupuesto_diario) FROM AI_CONFIG WHERE activo = 1) as limD, " & _
                  "(SELECT SUM(presupuesto_mensual) FROM AI_CONFIG WHERE activo = 1) as limM", session("connPW")
                  
    If Not rsCostes.EOF Then
        gastoHoy = CDbl(NullToZero(rsCostes("hoy")))
        gastoMes = CDbl(NullToZero(rsCostes("mes")))
        limDiario = CDbl(NullToZero(rsCostes("limD")))
        limMensual = CDbl(NullToZero(rsCostes("limM")))
    End If
    rsCostes.Close : Set rsCostes = Nothing

    Function NullToZero(val)
        If IsNull(val) Or val = "" Then NullToZero = 0 Else NullToZero = val
    End Function

    Function Perc(val, max)
        If max = 0 Then Perc = 0 Else Perc = Round((val / max) * 100, 1)
    End Function
    %>

    <div class="av2-grid" style="--grid-cols: 2; gap: 25px; margin-bottom: 40px;">
        <!-- Card Gasto Diario -->
        <div class="av2-card" style="padding: 25px;">
            <div style="font-size: 0.9rem; font-weight: 700; color: var(--text-secondary); text-transform: uppercase; margin-bottom: 15px;">Gasto Hoy</div>
            <div style="font-size: 2.5rem; font-weight: 900; color: var(--text-primary); margin-bottom: 10px;">
                <%= FormatNumber(gastoHoy, 4) %>€ <small style="font-size: 1rem; color: var(--text-muted);">/ <%= limDiario %>€</small>
            </div>
            <div style="height: 10px; background: var(--bg-main); border-radius: 5px; overflow: hidden; margin-top: 20px;">
                <div style="width: <%= Perc(gastoHoy, limDiario) %>%; height: 100%; background: var(--accent); transition: width 1s ease;"></div>
            </div>
            <div style="text-align: right; font-size: 0.8rem; margin-top: 8px; color: var(--text-muted);">Consumido: <%= Perc(gastoHoy, limDiario) %>%</div>
        </div>

        <!-- Card Gasto Mensual -->
        <div class="av2-card" style="padding: 25px;">
            <div style="font-size: 0.9rem; font-weight: 700; color: var(--text-secondary); text-transform: uppercase; margin-bottom: 15px;">Gasto Mes Actual</div>
            <div style="font-size: 2.5rem; font-weight: 900; color: var(--text-primary); margin-bottom: 10px;">
                <%= FormatNumber(gastoMes, 2) %>€ <small style="font-size: 1rem; color: var(--text-muted);">/ <%= limMensual %>€</small>
            </div>
            <div style="height: 10px; background: var(--bg-main); border-radius: 5px; overflow: hidden; margin-top: 20px;">
                <div style="width: <%= Perc(gastoMes, limMensual) %>%; height: 100%; background: #3182ce; transition: width 1s ease;"></div>
            </div>
            <div style="text-align: right; font-size: 0.8rem; margin-top: 8px; color: var(--text-muted);">Consumido: <%= Perc(gastoMes, limMensual) %>%</div>
        </div>
    </div>

    <!-- Desglose por Agente -->
    <div class="av2-card" style="padding: 25px;">
        <h3 style="margin-bottom: 20px;">Desglose por Agente</h3>
        <table style="width: 100%; border-collapse: collapse; font-size: 0.95rem;">
            <thead>
                <tr style="text-align: left; border-bottom: 2px solid var(--border-color);">
                    <th style="padding: 12px;">Operación / Agente</th>
                    <th style="padding: 12px;">Llamadas</th>
                    <th style="padding: 12px;">Ingreso Tokens</th>
                    <th style="padding: 12px;">Salida Tokens</th>
                    <th style="padding: 12px; text-align: right;">Coste Estimado</th>
                </tr>
            </thead>
            <tbody>
                <%
                Dim rsList
                Set rsList = Server.CreateObject("ADODB.Recordset")
                rsList.Open "SELECT tipo_operacion, COUNT(*) as c, SUM(tokens_entrada) as tin, SUM(tokens_salida) as tout, SUM(coste_estimado) as cost " & _
                            "FROM AI_COSTES WHERE MONTH(fecha) = MONTH(GETDATE()) GROUP BY tipo_operacion ORDER BY cost DESC", session("connPW")
                Do While Not rsList.EOF
                %>
                <tr style="border-bottom: 1px solid var(--border-color);">
                    <td style="padding: 12px; font-weight: 600;"><%= rsList("tipo_operacion") %></td>
                    <td style="padding: 12px;"><%= rsList("c") %></td>
                    <td style="padding: 12px;"><%= FormatNumber(rsList("tin"), 0) %></td>
                    <td style="padding: 12px;"><%= FormatNumber(rsList("tout"), 0) %></td>
                    <td style="padding: 12px; text-align: right; font-weight: 700; color: var(--accent);"><%= FormatNumber(rsList("cost"), 5) %>€</td>
                </tr>
                <%
                    rsList.MoveNext
                Loop
                rsList.Close : Set rsList = Nothing
                %>
            </tbody>
        </table>
    </div>
</main>
<!--#include virtual="/activa-v2/inc/layout/footer-v2.asp"-->
