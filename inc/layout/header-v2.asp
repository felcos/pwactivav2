<!-- activa-v2/inc/layout/header-v2.asp -->
<header class="av2-header av2-wrapper">
    <!-- Logotipo: PROPERTY (Gris/Blanco dependiendo del tema) WEB (Naranja base activo) -->
    <a href="/default.asp" class="av2-logo" style="text-decoration: none;">
        <span style="font-size: 1.6rem; font-weight: 900; letter-spacing: -0.8px;">
            <span style="color: var(--text-primary);">PROPERTY</span><span style="color: var(--accent);">WEB</span>
        </span>
    </a>

    <!-- Barra de búsqueda global inteligente -->
    <div class="av2-search-container" style="flex: 1; max-width: 500px; margin: 0 20px; position: relative;">
        <i class="fa-solid fa-magnifying-glass" style="position: absolute; left: 14px; top: 12px; color: var(--text-muted);"></i>
        <input type="text" id="av2-global-search" placeholder="Busca operaciones, oficinas, demandas (IA)..." autocomplete="off"
               style="width: 100%; padding: 10px 15px 10px 40px; border-radius: 20px; border: 1px solid var(--border-color); background: var(--bg-main); color: var(--text-primary); outline: none; transition: box-shadow 0.2s;" 
               onfocus="this.style.boxShadow='var(--shadow-glow)';" 
               onblur="this.style.boxShadow='none';" />
        
        <i id="av2-search-spinner" class="fa-solid fa-circle-notch fa-spin" style="position: absolute; right: 14px; top: 12px; color: var(--accent); display: none;"></i>

        <!-- Panel de Sugerencias AI (SmartSearch) -->
        <div id="av2-ai-search-results" style="display: none; position: absolute; top: 100%; left: 0; right: 0; margin-top: 10px; background: var(--bg-surface); border: 1px solid var(--border-color); border-radius: var(--radius); padding: 15px; box-shadow: var(--shadow); z-index: var(--z-dropdown);">
            <div style="font-size: 11px; text-transform: uppercase; color: var(--accent); font-weight: 700; margin-bottom: 10px; display: flex; align-items: center; gap: 6px;">
                <i class="fa-solid fa-wand-magic-sparkles"></i> Activa SmartSearch
            </div>
            
            <div id="av2-ai-search-chips" style="display: flex; flex-wrap: wrap; gap: 8px; margin-bottom: 12px;">
                <!-- Los chips se inyectarán aquí -->
            </div>
            
            <div id="av2-ai-search-alternatives" style="font-size: 12px; color: var(--text-secondary);">
                <!-- Las sugerencias se inyectarán aquí -->
            </div>
        </div>
    </div>

    <!-- Navegación de Acciones Rápidas -->
    <nav class="av2-nav" style="display: flex; align-items: center; gap: 20px;">
        
        <!-- Info Dropdown (Propietario, C.Comercial, Industrial...) -->
        <div class="av2-dropdown" style="position: relative; cursor: pointer; display: flex; align-items: center; gap: 5px;">
            <span style="font-weight: 600; color: var(--text-secondary); transition: color 0.2s;" onmouseover="this.style.color='var(--accent)'" onmouseout="this.style.color='var(--text-secondary)'"> Info <i class="fa-solid fa-chevron-down" style="font-size: 10px;"></i></span>
        </div>

        <!-- Selector de Temas Rápidos -->
        <div class="av2-theme-picker" style="cursor: pointer; display: flex; align-items: center;" title="Cambiar Tema" onclick="AV2_toggleTheme()">
            <i class="fa-solid fa-palette av2-text-muted" style="transition: color 0.2s;" onmouseover="this.style.color='var(--accent)'" onmouseout="this.style.color='var(--text-muted)'"></i>
        </div>

        <!-- Alertas Bell / Notificaciones V2 -->
        <div class="av2-bell" style="position: relative; cursor: pointer;" title="Notificaciones IA">
            <i class="fa-solid fa-bell av2-text-muted" style="font-size: 18px; transition: color 0.2s;" onmouseover="this.style.color='var(--accent)'" onmouseout="this.style.color='var(--text-muted)'"></i>
            <!-- Indicador IA -->
            <span class="av2-badge av2-badge-sub" style="position: absolute; top: -6px; right: -8px; padding: 2px 5px; font-size: 9px; border-radius: 50%; background-color: var(--accent); color: white;">3</span>
        </div>

        <!-- User & Quotas -->
        <div class="av2-user-menu" style="display: flex; align-items: center; gap: 12px; border-left: 1px solid var(--border-color); padding-left: 20px; cursor: pointer;">
            <div style="text-align: right; line-height: 1.2;">
                <div style="font-size: 13px; font-weight: 600; color: var(--text-primary);">Mi Panel</div>
                <div style="font-size: 11px; color: var(--accent); font-weight: 600;">98 Cuotas</div>
            </div>
            <!-- Avatar Iniciales -->
            <div style="width: 38px; height: 38px; border-radius: 50%; background: var(--bg-surface-hover); border: 2px solid var(--accent); color: var(--accent); display: flex; align-items: center; justify-content: center; font-weight: bold; font-size: 14px;">
                AV
            </div>
        </div>
    </nav>
</header>

<script>
    // JS Básico integrado para cambio rápido de tema. Idealmente se pasa a activa-v2.js
    function AV2_toggleTheme() {
        const doc = document.documentElement;
        let currentTheme = doc.getAttribute('data-theme') || 'light';
        const themes = ['light', 'dark', 'matrix', 'ocean'];
        
        let nextIndex = (themes.indexOf(currentTheme) + 1) % themes.length;
        let newTheme = themes[nextIndex];
        
        doc.setAttribute('data-theme', newTheme);
        localStorage.setItem('av2-theme', newTheme);
    }

    /* =========================================
       AGENTE 5: SmartSearch (AI Debounced Search)
       ========================================= */
    const searchInput = document.getElementById('av2-global-search');
    const searchSpinner = document.getElementById('av2-search-spinner');
    const searchResults = document.getElementById('av2-ai-search-results');
    const searchChips = document.getElementById('av2-ai-search-chips');
    const searchAlts = document.getElementById('av2-ai-search-alternatives');
    let searchTimeout = null;

    if(searchInput) {
        searchInput.addEventListener('input', function() {
            clearTimeout(searchTimeout);
            const query = this.value.trim();
            
            if (query.length < 5) {
                searchResults.style.display = 'none';
                searchSpinner.style.display = 'none';
                return;
            }

            searchSpinner.style.display = 'block';

            // Debounce de 600ms para no saturar la API
            searchTimeout = setTimeout(() => {
                fetch('/activa-v2/ia/busqueda.asp?q=' + encodeURIComponent(query))
                .then(res => res.json())
                .then(data => {
                    searchSpinner.style.display = 'none';
                    if (data.error) return;

                    searchChips.innerHTML = '';
                    searchAlts.innerHTML = '';
                    
                    // Render Chips
                    let items = [];
                    if(data.keywords_busqueda) {
                        data.keywords_busqueda.forEach(k => {
                            if(k.toLowerCase() !== "null") items.push(`<span class="av2-badge" style="background:var(--bg-main); border:1px solid var(--accent-light); color:var(--text-primary);"><i class="fa-solid fa-key" style="color:var(--accent);"></i> ${k}</span>`);
                        });
                    }
                    if(data.filtros_sugeridos) {
                        if(data.filtros_sugeridos.tipo && data.filtros_sugeridos.tipo !== "null") {
                            items.push(`<span class="av2-badge" style="background:rgba(49, 130, 206, 0.1); color:var(--info);"><i class="fa-solid fa-filter"></i> ${data.filtros_sugeridos.tipo}</span>`);
                        }
                        if(data.filtros_sugeridos.segmento && data.filtros_sugeridos.segmento !== "null") {
                            items.push(`<span class="av2-badge" style="background:rgba(229, 62, 62, 0.1); color:var(--error);"><i class="fa-regular fa-building"></i> ${data.filtros_sugeridos.segmento}</span>`);
                        }
                        if(data.filtros_sugeridos.ubicacion && data.filtros_sugeridos.ubicacion !== "null") {
                            items.push(`<span class="av2-badge" style="background:rgba(56, 161, 105, 0.1); color:var(--success);"><i class="fa-solid fa-location-dot"></i> ${data.filtros_sugeridos.ubicacion}</span>`);
                        }
                    }

                    searchChips.innerHTML = items.join('');

                    if(data.sugerencias_alternativas && data.sugerencias_alternativas.length > 0) {
                        searchAlts.innerHTML = "<strong>Relacionado:</strong> " + data.sugerencias_alternativas.map(s => `<a href="#" onclick="document.getElementById('av2-global-search').value='${s}'; document.getElementById('av2-global-search').dispatchEvent(new Event('input')); return false;" style="margin-right:8px; text-decoration:underline dashed; cursor:pointer; color:var(--accent);">${s}</a>`).join('');
                    } else {
                        searchAlts.innerHTML = "<span style='opacity:0.6;'>Pulsa Enter para buscar coincidencia exacta...</span>";
                    }

                    searchResults.style.display = 'block';
                })
                .catch(err => {
                    searchSpinner.style.display = 'none';
                    console.error("SmartSearch falló:", err);
                });

            }, 700);
        });

        document.addEventListener('click', function(e) {
            if (!searchInput.contains(e.target) && !searchResults.contains(e.target)) {
                searchResults.style.display = 'none';
            }
        });
        
        searchInput.addEventListener('focus', function() {
            if (this.value.trim().length >= 5 && searchChips.innerHTML !== '') {
                searchResults.style.display = 'block';
            }
        });
    }
</script>
