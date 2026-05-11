<?php
    include __DIR__ . '/includes/head.html';
    include __DIR__ . '/includes/navbar.html';
?>
<script src="/js/grupDetall.js" defer></script>

<main class="container py-4">
    <a href="/" class="btn btn-link ps-0 mb-3">&larr; Volver al home</a>

    <section id="grup-header" class="mb-4">
        <div class="alert alert-info mb-0">Cargando grupo...</div>
    </section>

    <section class="mb-4">
        <h2 class="h4 mb-3">Integrantes oficiales estables</h2>
        <div id="integrants-list" class="list-group"></div>
    </section>

    <section>
        <h2 class="h4 mb-3">Albumes oficiales</h2>
        <div id="albumes-list" class="row g-3"></div>
    </section>
</main>

<?php
    include __DIR__ . '/includes/footer.html';
?>
