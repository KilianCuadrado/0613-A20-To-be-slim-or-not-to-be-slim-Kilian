<?php
    include __DIR__ . '/includes/head.html';
    include __DIR__ . '/includes/navbar.html';
?>
<script src="/js/albumDetall.js" defer></script>

<main class="container py-4">
    <a id="back-to-group" href="/" class="btn btn-link ps-0 mb-3">&larr; Volver al grupo</a>

    <section id="album-error" class="mb-4"></section>

    <section id="album-video" class="mb-4"></section>

    <section id="album-header" class="mb-4">
        <div class="alert alert-info mb-0">Cargando album...</div>
    </section>

    <section>
        <h2 class="h4 mb-3">Canciones del album</h2>
        <div id="album-songs" class="list-group"></div>
    </section>
</main>

<?php
    include __DIR__ . '/includes/footer.html';
?>
