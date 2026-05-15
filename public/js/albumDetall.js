const albumHeader = document.getElementById("album-header");
const albumVideo = document.getElementById("album-video");
const albumSongs = document.getElementById("album-songs");
const albumError = document.getElementById("album-error");
const backToGroup = document.getElementById("back-to-group");

const ALBUM_ACCESS_MAX_AGE_MS = 10 * 60 * 1000;

const extractAlbumId = () => {
    const pathParts = window.location.pathname.split("/").filter(Boolean);
    return pathParts.length >= 2 ? pathParts[1] : null;
};

const normalizeText = (value) => (value || "")
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .toLowerCase()
    .trim();

const escapeHtml = (value) => String(value)
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&#39;");

const showAlbumError = (message) => {
    albumError.innerHTML = `<div class="alert alert-danger mb-0">${escapeHtml(message)}</div>`;
    albumHeader.innerHTML = "";
    albumVideo.innerHTML = "";
    albumSongs.innerHTML = "";
};

const isNavigationAllowed = (albumId) => {
    const accessAlbumId = sessionStorage.getItem("albumAccessId");
    const accessTimestampRaw = sessionStorage.getItem("albumAccessAt");
    if (!accessAlbumId || !accessTimestampRaw) {
        return false;
    }

    const accessTimestamp = Number.parseInt(accessTimestampRaw, 10);
    if (!Number.isFinite(accessTimestamp)) {
        return false;
    }

    const age = Date.now() - accessTimestamp;
    return accessAlbumId === albumId && age >= 0 && age <= ALBUM_ACCESS_MAX_AGE_MS;
};

const fetchJson = async (url) => {
    const response = await fetch(url);
    const data = await response.json().catch(() => null);

    if (!response.ok) {
        const errorMessage = data && data.error ? data.error : "No se pudo cargar la informacion";
        throw new Error(errorMessage);
    }

    return data;
};

const renderAlbumHeader = (album) => {
    albumHeader.innerHTML = `
        <article class="card shadow-sm">
            <div class="card-body">
                <h1 class="card-title h3 mb-2">${escapeHtml(album.nombreAlbum || "Album sin nombre")}</h1>
                <p class="card-text small text-muted mb-1"><strong>Grupo:</strong> ${escapeHtml(album.grupo || "Dato sin confirmar")}</p>
                <p class="card-text small text-muted mb-1"><strong>Lanzamiento:</strong> ${escapeHtml(album.fechaLanzamiento || "Dato sin confirmar")}</p>
                <p class="card-text small text-muted mb-1"><strong>Cancion mas popular:</strong> ${escapeHtml(album.cancionMasPopular || "Dato sin confirmar")}</p>
                <p class="card-text small text-muted mb-0"><strong>Generos:</strong> ${escapeHtml(album.generos || "Dato sin confirmar")}</p>
            </div>
        </article>
    `;
};

const renderAlbumVideo = (album) => {
    if (!album.youtubeEmbedUrl) {
        albumVideo.innerHTML = "";
        return;
    }

    const videoUrl = escapeHtml(album.youtubeEmbedUrl);
    const popularSong = escapeHtml(album.cancionMasPopular || "Dato sin confirmar");

    albumVideo.innerHTML = `
        <article class="card shadow-sm">
            <div class="card-body">
                <h2 class="h5 mb-3">Video de la cancion mas popular: ${popularSong}</h2>
                <div class="ratio ratio-16x9">
                    <iframe src="${videoUrl}" title="Video de YouTube de la cancion mas popular" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
                </div>
            </div>
        </article>
    `;
};

const renderAlbumSongs = (songTitles) => {
    if (!Array.isArray(songTitles) || songTitles.length === 0) {
        albumSongs.innerHTML = '<p class="text-muted mb-0">No se han encontrado canciones para este album.</p>';
        return;
    }

    albumSongs.innerHTML = "";
    songTitles.forEach((songTitle, index) => {
        const item = document.createElement("article");
        item.className = "list-group-item";
        item.innerHTML = `
            <h3 class="h6 mb-0">${index + 1}. ${escapeHtml(songTitle)}</h3>
        `;
        albumSongs.appendChild(item);
    });
};

const fetchAlbumSongs = async (album) => {
    const params = new URLSearchParams({
        term: `${album.nombreAlbum} ${album.grupo}`,
        entity: "song",
        limit: "200"
    });

    const response = await fetch(`https://itunes.apple.com/search?${params.toString()}`);
    if (!response.ok) {
        throw new Error("No se pudieron consultar las canciones del album");
    }

    const payload = await response.json();
    const results = Array.isArray(payload.results) ? payload.results : [];
    const normalizedAlbumName = normalizeText(album.nombreAlbum);
    const normalizedGroupName = normalizeText(album.grupo);

    const uniqueByTrack = new Map();
    results.forEach((track) => {
        const trackName = typeof track.trackName === "string" ? track.trackName.trim() : "";
        const collectionName = typeof track.collectionName === "string" ? normalizeText(track.collectionName) : "";
        const artistName = typeof track.artistName === "string" ? normalizeText(track.artistName) : "";
        if (!trackName || !collectionName || !artistName) {
            return;
        }

        const albumMatch = collectionName.includes(normalizedAlbumName) || normalizedAlbumName.includes(collectionName);
        const artistMatch = artistName.includes(normalizedGroupName) || normalizedGroupName.includes(artistName);
        if (!albumMatch || !artistMatch) {
            return;
        }

        const trackKey = normalizeText(trackName);
        const trackNumber = Number.isFinite(track.trackNumber) ? track.trackNumber : Number.MAX_SAFE_INTEGER;
        if (!uniqueByTrack.has(trackKey) || uniqueByTrack.get(trackKey).trackNumber > trackNumber) {
            uniqueByTrack.set(trackKey, { trackName, trackNumber });
        }
    });

    const sortedTracks = [...uniqueByTrack.values()]
        .sort((a, b) => a.trackNumber - b.trackNumber || a.trackName.localeCompare(b.trackName))
        .map((track) => track.trackName);

    if (sortedTracks.length > 0) {
        return sortedTracks;
    }

    if (album.cancionMasPopular && album.cancionMasPopular !== "Dato sin confirmar") {
        return [album.cancionMasPopular];
    }

    return [];
};

const loadAlbumDetail = async () => {
    const albumId = extractAlbumId();
    if (!albumId || !/^\d+$/.test(albumId)) {
        showAlbumError("Identificador de album invalido");
        return;
    }

    if (!isNavigationAllowed(albumId)) {
        showAlbumError("Solo se puede acceder desde la tarjeta del album en el detalle del grupo.");
        return;
    }

    try {
        const album = await fetchJson(`/api/albumes/${albumId}`);
        const grupId = sessionStorage.getItem("albumAccessGrupId");
        if (grupId && /^\d+$/.test(grupId)) {
            backToGroup.setAttribute("href", `/grup/${grupId}`);
        }

        renderAlbumHeader(album);
        renderAlbumVideo(album);

        const songs = await fetchAlbumSongs(album);
        renderAlbumSongs(songs);
    } catch (error) {
        showAlbumError(error.message || "Error cargando el detalle del album");
    }
};

loadAlbumDetail();
