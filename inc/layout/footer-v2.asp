<!-- activa-v2/inc/layout/footer-v2.asp -->
<!-- IMPORTANTE: Este archivo domina las nuevas paginas en el punto de cierre inferior -->
<footer class="av2-footer av2-wrapper" style="background: var(--bg-surface); border-top: 1px solid var(--border-color); padding: 40px 20px 20px; margin-top: 60px; transition: background 0.3s, border-color 0.3s;">
    <div style="max-width: 1400px; margin: 0 auto; display: flex; flex-wrap: wrap; gap: 40px; justify-content: space-between;">
        
        <!-- Branding y Descripción -->
        <div style="flex: 1; min-width: 250px;">
            <a href="/default.asp" class="av2-logo" style="text-decoration: none; display: inline-block; margin-bottom: 15px;">
                <span style="font-size: 1.4rem; font-weight: 900; letter-spacing: -0.5px;">
                    <span style="color: var(--text-primary);">PROPERTY</span><span style="color: var(--accent);">WEB</span>
                </span>
            </a>
            <p style="color: var(--text-muted); font-size: 13px; line-height: 1.6; max-width: 320px;">
                El portal privado líder en España de información del mercado inmobiliario. Combinando extensa experiencia humana con la nueva generación de Inteligencia Artificial Inmobiliaria.
            </p>
            <div style="display: flex; gap: 15px; margin-top: 20px;">
                <a href="#" style="color: var(--text-muted); font-size: 18px; transition: color 0.2s;" onmouseover="this.style.color='var(--accent)'" onmouseout="this.style.color='var(--text-muted)'"><i class="fa-brands fa-linkedin"></i></a>
                <a href="#" style="color: var(--text-muted); font-size: 18px; transition: color 0.2s;" onmouseover="this.style.color='var(--accent)'" onmouseout="this.style.color='var(--text-muted)'"><i class="fa-brands fa-twitter"></i></a>
            </div>
        </div>

        <!-- Enlaces Rápidos -->
        <div style="flex: 1; min-width: 150px;">
            <h4 style="color: var(--text-primary); font-size: 13px; margin-bottom: 15px; font-weight: 700; text-transform: uppercase; letter-spacing: 1px;">Áreas Base</h4>
            <ul style="list-style: none; padding: 0; margin: 0; display: flex; flex-direction: column; gap: 10px;">
                <li><a href="/default.asp" style="color: var(--text-secondary); font-size: 13px;"><i class="fa-solid fa-angle-right" style="font-size: 10px; margin-right:5px; color: var(--accent);"></i> Inicio / Briefing</a></li>
                <li><a href="/actualidad/default.asp" style="color: var(--text-secondary); font-size: 13px;"><i class="fa-solid fa-angle-right" style="font-size: 10px; margin-right:5px; color: var(--accent);"></i> Actualidad M.I.</a></li>
                <li><a href="/info/default.asp" style="color: var(--text-secondary); font-size: 13px;"><i class="fa-solid fa-angle-right" style="font-size: 10px; margin-right:5px; color: var(--accent);"></i> Portafolios Físicos</a></li>
                <li><a href="/dealanalysis/default.asp" style="color: var(--text-secondary); font-size: 13px;"><i class="fa-solid fa-angle-right" style="font-size: 10px; margin-right:5px; color: var(--accent);"></i> Deal Analysis</a></li>
            </ul>
        </div>

        <!-- Selector de Tema -->
        <div style="flex: 1; min-width: 200px;">
            <h4 style="color: var(--text-primary); font-size: 13px; margin-bottom: 15px; font-weight: 700; text-transform: uppercase; letter-spacing: 1px;">Personalización</h4>
            <div style="display: flex; flex-direction: column; gap: 8px;">
                <label style="color: var(--text-muted); font-size: 12px; margin-bottom: 5px;">Elige tu experiencia visual:</label>
                <div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 10px;">
                    <button class="av2-theme-btn" data-theme-id="light" onclick="setAV2Theme('light')" style="background: #fff; color: #333; border: 1px solid #ddd; padding: 10px; border-radius: 8px; font-size: 11px; cursor: pointer; font-weight: 700; transition: all 0.2s;">CLARO</button>
                    <button class="av2-theme-btn" data-theme-id="dark" onclick="setAV2Theme('dark')" style="background: #1e293b; color: #fff; border: 1px solid #334155; padding: 10px; border-radius: 8px; font-size: 11px; cursor: pointer; font-weight: 700; transition: all 0.2s;">OSCURO</button>
                    <button class="av2-theme-btn" data-theme-id="matrix" onclick="setAV2Theme('matrix')" style="background: #000; color: #00ff41; border: 1px solid #003300; padding: 10px; border-radius: 8px; font-size: 11px; cursor: pointer; font-weight: 700; transition: all 0.2s;">MATRIX</button>
                    <button class="av2-theme-btn" data-theme-id="ocean" onclick="setAV2Theme('ocean')" style="background: #001d36; color: #7dd3fc; border: 1px solid #003b6d; padding: 10px; border-radius: 8px; font-size: 11px; cursor: pointer; font-weight: 700; transition: all 0.2s;">OCEAN</button>
                </div>
            </div>
        </div>
    </div>
    
    <div style="max-width: 1400px; margin: 30px auto 0; padding-top: 20px; border-top: 1px solid var(--border-color); display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 15px;">
        <div style="color: var(--text-muted); font-size: 12px;">
            &copy; 1999-<%=Year(Date())%> PROPERTY WEB. Todos los derechos reservados.
        </div>
        <div style="color: var(--text-muted); font-size: 12px; display: flex; align-items: center; gap: 8px;" title="Capa V2 Activa con Agentes Backend">
            <span style="display:inline-block; width:8px; height:8px; background:var(--success); border-radius:50%; box-shadow: 0 0 8px var(--success);"></span>
            Sistemas IA Conectados
        </div>
    </div>
</footer>

<script>
    function setAV2Theme(theme) {
        document.documentElement.setAttribute('data-theme', theme);
        localStorage.setItem('av2-theme', theme);
        
        // Actualizar visual de botones
        document.querySelectorAll('.av2-theme-btn').forEach(btn => {
            if (btn.getAttribute('data-theme-id') === theme) {
                btn.style.borderColor = 'var(--accent)';
                btn.style.boxShadow = '0 0 10px var(--accent-light)';
            } else {
                btn.style.borderColor = '#ddd';
                btn.style.boxShadow = 'none';
            }
        });
    }

    // Inicializar visual de botones al cargar
    window.addEventListener('DOMContentLoaded', (event) => {
        const currentTheme = localStorage.getItem('av2-theme') || 'light';
        setAV2Theme(currentTheme);
    });
</script>
