<!-- activa-v2/inc/components/ai-briefing.asp -->
<%
    ' Componente Visual para leer o cargar dinámicamente el Briefing Diario
%>
<div id="av2-ai-briefing-container" class="av2-card" style="margin: 20px 0; position: relative; overflow: hidden; border-top: 5px solid var(--accent); background: linear-gradient(135deg, var(--bg-surface) 0%, var(--bg-main) 100%);">
    
    <!-- Decoración de fondo -->
    <i class="fa-solid fa-chart-line" style="position: absolute; right: -20px; top: -10px; font-size: 140px; color: var(--accent); opacity: 0.03; transform: rotate(-5deg);"></i>
    
    <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 20px; position: relative; z-index: 2;">
        <div style="display: flex; align-items: center; gap: 15px;">
            <div style="width: 48px; height: 48px; border-radius: 12px; background: var(--accent); color: var(--text-inverse); display: flex; align-items: center; justify-content: center; box-shadow: var(--shadow-glow);">
                <i class="fa-solid fa-robot" style="font-size: 24px;"></i>
            </div>
            <div>
                <h3 style="margin: 0; font-size: 20px; font-weight: 800; color: var(--text-primary); letter-spacing: -0.5px;">Executive Briefing</h3>
                <div style="font-size: 13px; color: var(--text-muted); font-weight: 500;">
                    <i class="fa-regular fa-calendar-days"></i> Análisis Automático de Hoy
                </div>
            </div>
        </div>
        
        <!-- Botón solo visible para Admin para forzar regeneración manual -->
        <button onclick="AV2_GenerateBriefing()" id="btn-ai-regenerate" class="av2-btn av2-btn-outline" style="font-size: 11px; display: flex; align-items: center; gap: 6px;">
            <i class="fa-solid fa-rotate-right"></i> Generar
        </button>
    </div>
    
    <div id="av2-ai-briefing-content" style="position: relative; z-index: 2; font-size: 15px; line-height: 1.7; color: var(--text-secondary);">
        <!-- Estado de Carga -->
        <div style="display: flex; align-items: center; gap: 12px; padding: 20px 0;">
            <i class="fa-solid fa-circle-notch fa-spin fa-lg" style="color: var(--accent);"></i>
            <span>Consultando el último resumen de mercado...</span>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        // En un entorno de producción, aquí se haría un AJAX GET hacia una base de datos 
        // para traer el informe YA generado por el cron. 
        // Para esta demo lo llamamos manualmente en el Load para mostrar el efecto del AI trabajando.
        AV2_LoadLatestBriefing();
    });

    function AV2_LoadLatestBriefing() {
        // En V2 Final esto debe golpear un endpoint simple que lee el último récord de AI_BRIEFINGS sin gastar Tokens
        let contentDiv = document.getElementById('av2-ai-briefing-content');
        contentDiv.innerHTML = '<span style="color: var(--text-muted);"><i class="fa-solid fa-info-circle"></i> Esperando generación interactiva del reporte...</span>';
    }

    function AV2_GenerateBriefing() {
        let contentDiv = document.getElementById('av2-ai-briefing-content');
        let btnRegenerate = document.getElementById('btn-ai-regenerate');
        
        btnRegenerate.disabled = true;
        btnRegenerate.innerHTML = '<i class="fa-solid fa-circle-notch fa-spin"></i> Generando...';
        
        contentDiv.innerHTML = '<div style="display:flex;align-items:center;gap:15px;padding:20px 0;border-radius:8px;background:var(--bg-main);"><i class="fa-solid fa-microchip fa-spin fa-lg" style="color:var(--accent); margin-left:15px;"></i><span style="font-weight:500;">Analizando decenas de noticias y operaciones para redactar el briefing... (Tomará unos segundos)</span></div>';

        // Peticion AJAX al Backend IA - Agent 2: Briefing
        fetch('/activa-v2/ia/briefing.asp?key=SECRET_CRON_V2', {
            method: 'GET',
            headers: { 'Content-Type': 'application/json' }
        })
        .then(response => response.json())
        .then(data => {
            btnRegenerate.disabled = false;
            btnRegenerate.innerHTML = '<i class="fa-solid fa-check"></i> Actualizado';
            
            if (data.error) {
                contentDiv.innerHTML = '<div style="padding: 15px; background: rgba(229, 62, 62, 0.1); border-left: 4px solid var(--error); border-radius: 4px; color: var(--text-primary);"><i class="fa-solid fa-triangle-exclamation" style="color: var(--error);"></i> Fallo de Generación: ' + data.msg + '</div>';
            } else {
                // Inyectamos el HTML parseado por el LLM
                contentDiv.innerHTML = '<div class="av2-briefing-text" style="padding-top: 10px;">' + (data.breifing_html || data.briefing_html || data.briefing || data.html || "Informe generado sin formato HTML legible.") + '</div>';
            }
        })
        .catch(err => {
            btnRegenerate.disabled = false;
            btnRegenerate.innerHTML = '<i class="fa-solid fa-rotate-right"></i> Reintentar';
            contentDiv.innerHTML = '<span style="color: var(--error);"><i class="fa-solid fa-plug-circle-xmark"></i> Fallo de conexión de red con el Agente de Briefing.</span>';
        });
    }
</script>
