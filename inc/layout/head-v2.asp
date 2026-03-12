<!-- activa-v2/inc/layout/head-v2.asp -->
<!-- IMPORTANTE: Este archivo se incluye en lugar de /inc/head.asp en paginas modernizadas -->
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0" />
<title>Activa v2 - Inteligencia Inmobiliaria</title>

<!-- Tipografía moderna (Inter / Segoe UI drop-in) -->
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet" />

<!-- FontAwesome 6 Free -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

<!-- Bootstrap 3 Core (solo Layouts) - El sitio usa BS3 intensivamente -->
<!-- <link rel="stylesheet" href="/lib/bootstrap/css/bootstrap.min.css" /> -->

<!-- Sistema de variables y estilizaciones maestras V2 -->
<link rel="stylesheet" href="/activa-v2/css/activa-v2.css" />
<link rel="stylesheet" href="/activa-v2/css/themes/dark.css" />
<link rel="stylesheet" href="/activa-v2/css/themes/matrix.css" />
<link rel="stylesheet" href="/activa-v2/css/themes/ocean.css" />

<!-- Iniciar tema guardado por el usuario en localStorage antes del render para evitar flickering -->
<script>
    (function() {
        var savedTheme = localStorage.getItem('av2-theme') || 'light';
        document.documentElement.setAttribute('data-theme', savedTheme);
    })();
</script>
