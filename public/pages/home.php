
<?php
    include __DIR__ . '/includes/head.html';
    include __DIR__ . '/includes/navbar.html';
?>
<script src="/js/llistarGrups.js" defer></script>
<style>
    .grup-card-hover {
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }

    .grup-link-hover:hover .grup-card-hover,
    .grup-link-hover:focus .grup-card-hover,
    .grup-link-hover:focus-visible .grup-card-hover {
        transform: translateY(-6px);
        box-shadow: 0 0.75rem 1.5rem rgba(0, 0, 0, 0.18) !important;
    }
</style>

<main class="container py-4">
    <h1 class="mb-4">Grupos de musica</h1>
    <div id="grups-list" class="row g-4"></div>
</main>

<?php
    include __DIR__ . '/includes/footer.html';
?>
