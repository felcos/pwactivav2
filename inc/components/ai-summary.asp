<!-- activa-v2/inc/components/ai-summary.asp -->
<%
    ' El articulo ID y texto deberian venir de la pagina superior.
    ' Se requiere: strArticuloId, strArticuloTitulo
%>
<div id="av2-ai-summary-container" class="av2-card" style="margin-bottom: 24px; position: relative; overflow: hidden; border-left: 4px solid var(--accent); display: none;">
    <!-- Decoración de fondo -->
    <i class="fa-solid fa-robot" style="position: absolute; right: -20px; top: -10px; font-size: 120px; color: var(--accent); opacity: 0.05; transform: rotate(-15deg);"></i>
    
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; position: relative; z-index: 2;">
        <div style="display: flex; align-items: center; gap: 10px;">
            <div style="width: 32px; height: 32px; border-radius: 8px; background: var(--accent-light); color: var(--accent); display: flex; align-items: center; justify-content: center;">
                <i class="fa-solid fa-bolt" style="font-size: 14px;"></i>
            </div>
            <div>
                <h4 style="margin: 0; font-size: 15px; font-weight: 700; color: var(--text-primary); letter-spacing: -0.3px;">Resumen Ejecutivo IA</h4>
                <div style="font-size: 11px; color: var(--text-muted);">Generado automáticamente</div>
            </div>
        </div>
        
        <div style="display: flex; gap: 8px;">
            <button onclick="AV2_LoadAISummary('es')" id="btn-ai-es" class="av2-btn av2-btn-outline" style="padding: 4px 10px; font-size: 11px;">ES</button>
            <button onclick="AV2_LoadAISummary('en')" id="btn-ai-en" class="av2-btn av2-btn-outline" style="padding: 4px 10px; font-size: 11px; color: var(--text-muted); border-color: var(--border-color);">EN</button>
        </div>
    </div>
    
    <div id="av2-ai-summary-content" style="position: relative; z-index: 2; font-size: 14px; line-height: 1.6; color: var(--text-secondary);">
        <!-- Estado de Carga -->
        <div style="display: flex; align-items: center; gap: 10px; padding: 10px 0;">
            <i class="fa-solid fa-circle-notch fa-spin" style="color: var(--accent);"></i>
            <span>Analizando los puntos clave del artículo...</span>
        </div>
    </div>
</div>

<script>
    // Invocado al cargar la pagina del articulo.
    // Documentacion Frontend R19: Si la IA falla, la pagina debe seguir funcionando sin bloquearse.
    
    const AV2_AI_CONFIG = {
        articleId: '<%=strArticuloId%>',
        title: '<%=Replace(strArticuloTitulo, "'", "\'")%>'
    };

    document.addEventListener("DOMContentLoaded", function() {
        if(AV2_AI_CONFIG.articleId && AV2_AI_CONFIG.articleId !== "") {
            document.getElementById('av2-ai-summary-container').style.display = 'block';
            AV2_LoadAISummary('es');
        }
    });

    function AV2_LoadAISummary(lang) {
        let contentDiv = document.getElementById('av2-ai-summary-content');
        
        // Estilos de botones
        document.getElementById('btn-ai-es').style.color = lang === 'es' ? 'var(--accent)' : 'var(--text-muted)';
        document.getElementById('btn-ai-es').style.borderColor = lang === 'es' ? 'var(--accent)' : 'var(--border-color)';
        document.getElementById('btn-ai-en').style.color = lang === 'en' ? 'var(--accent)' : 'var(--text-muted)';
        document.getElementById('btn-ai-en').style.borderColor = lang === 'en' ? 'var(--accent)' : 'var(--border-color)';

        contentDiv.innerHTML = '<div style="display:flex;align-items:center;gap:10px;padding:10px 0;"><i class="fa-solid fa-circle-notch fa-spin" style="color:var(--accent);"></i><span>Generando resumen en ' + (lang==='es'?'Español':'Inglés') + '...</span></div>';

        // Peticion AJAX al backend IIS en Background
        fetch('/activa-v2/ia/resumidor.asp?id=' + AV2_AI_CONFIG.articleId + '&lang=' + lang, {
            method: 'GET',
            headers: { 'Content-Type': 'application/json' }
        })
        .then(response => response.json())
        .then(data => {
            if (data.error) {
                contentDiv.innerHTML = '<span style="color: var(--error);"><i class="fa-solid fa-triangle-exclamation"></i> Resumen no disponible temporalmente.</span>';
            } else {
                contentDiv.innerHTML = '<div style="font-weight: 500;">' + data.resumen + '</div>';
            }
        })
        .catch(err => {
            // Falla de red silenciosa. Racional R19: Degradacion elegante.
            document.getElementById('av2-ai-summary-container').style.display = 'none';
        });
    }
</script>
