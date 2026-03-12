<%@ Language="VBScript" %>
<!--#include virtual="/activa-v2/inc/layout/head-v2.asp"-->
<%
' Datos mockeados del articulo 
Dim strArticuloId : strArticuloId = "9999"
Dim strArticuloTitulo : strArticuloTitulo = "Prueba V2: MERLIN Properties adquiere gran centro logístico"
%>
<style>
/* Estilos extra de la vista de articulo mockeada (simulado del viejo framework) */
.av2-article-content p {
    font-size: 1.1rem;
    line-height: 1.8;
    color: var(--text-primary);
    margin-bottom: 20px;
}
</style>
</head>
<body class="av2-body" data-av2="true">

<!--#include virtual="/activa-v2/inc/layout/header-v2.asp"-->

<main class="av2-wrapper" style="max-width: 900px; margin: 40px auto; padding: 0 20px;">
    
    <!-- Migas de pan / Etiquetas V2 -->
    <div style="margin-bottom: 20px;">
        <span class="av2-badge av2-badge-ope" style="margin-right: 10px;">OPERACIÓN (ope)</span>
        <span style="color: var(--text-muted); font-size: 0.9rem;">12 de Marzo de 2026</span>
    </div>

    <!-- Título Principal -->
    <h1 style="font-size: 2.5rem; font-weight: 800; margin-bottom: 30px; line-height: 1.2; color: var(--text-primary);"><%=strArticuloTitulo%></h1>
    
    <!-- INYECCIÓN: Componente IA Article Summarizer -->
    <!--#include virtual="/activa-v2/inc/components/ai-summary.asp"-->

    <!-- Contenido Ficticio del Articulo -->
    <article class="av2-article-content">
        <p><strong>Madrid, España.</strong> En un movimiento estratégico que consolida su posición en el mercado industrial ibérico, la socimi MERLIN Properties ha cerrado hoy la compra de una de las mayores plataformas logísticas de la zona centro, por un importe que ronda los 50 millones de euros.</p>
        
        <p>La operación, asesorada por grandes consultoras del sector, subraya el apetito constante por activos prime en nudos de comunicaciones clave. El activo cuenta con más de 60.000 metros cuadrados de SBA (Superficie Bruta Alquilable) y certificaciones de sostenibilidad de grado BREEAM Excelente, un requisito ya indispensable para los fondos institucionales.</p>
        
        <p>Expertos del mercado señalan que la absorción (Take-up) en logística mantiene ritmos de crucero, impulsada en buena medida por las necesidades de operadores de comercio electrónico y cadenas de distribución que buscan acortar los tiempos de última milla. Se espera que durante el próximo trimestre se oficialicen más movimientos similares en los ejes de la A-2 y la A-4.</p>
    </article>

</main>

<!--#include virtual="/activa-v2/inc/layout/footer-v2.asp"-->

</body>
</html>
