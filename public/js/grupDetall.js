const grupHeader = document.getElementById("grup-header");
const albumesList = document.getElementById("albumes-list");
const integrantsList = document.getElementById("integrants-list");

const extractGrupId = () => {
    const pathParts = window.location.pathname.split("/").filter(Boolean);
    return pathParts.length >= 2 ? pathParts[1] : null;
};

const showLoadError = (message) => {
    grupHeader.innerHTML = `<div class="alert alert-danger mb-0">${message}</div>`;
    albumesList.innerHTML = "";
    integrantsList.innerHTML = "";
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

const renderGroupHeader = (grup) => {
    const imageUrl = grup.img || "https://via.placeholder.com/960x360?text=Sin+imagen";
    const generos = grup.generos || "Dato sin confirmar";
    const fechaCreacion = grup.fechaCreacion || "Dato sin confirmar";

    grupHeader.innerHTML = `
        <article class="card shadow-sm overflow-hidden">
            <img src="${imageUrl}" class="card-img-top" alt="Imagen de ${grup.nombre}" style="max-height: 360px; object-fit: cover;">
            <div class="card-body">
                <h1 class="card-title h3 mb-2">${grup.nombre}</h1>
                <p class="card-text mb-2">${grup.descripcion || ""}</p>
                <p class="card-text small text-muted mb-1"><strong>Generos:</strong> ${generos}</p>
                <p class="card-text small text-muted mb-0"><strong>Fecha de creacion:</strong> ${fechaCreacion}</p>
            </div>
        </article>
    `;
};

const renderAlbumes = (albumes) => {
    if (!Array.isArray(albumes) || albumes.length === 0) {
        albumesList.innerHTML = '<p class="text-muted mb-0">No hay albumes para este grupo.</p>';
        return;
    }

    albumesList.innerHTML = "";
    albumes.forEach((album) => {
        const item = document.createElement("article");
        item.className = "col-12 col-md-6";
        const albumUrl = `/album/${album.id}`;
        item.innerHTML = `
            <a href="${albumUrl}" data-album-id="${album.id}" class="text-decoration-none text-reset d-block h-100">
                <div class="card h-100 shadow-sm">
                    <div class="card-body">
                        <h3 class="h6 mb-2">${album.nombreAlbum || "Album sin nombre"}</h3>
                        <p class="small text-muted mb-1"><strong>Lanzamiento:</strong> ${album.fechaLanzamiento || "Dato sin confirmar"}</p>
                        <p class="small text-muted mb-1"><strong>Cancion popular:</strong> ${album.cancionMasPopular || "Dato sin confirmar"}</p>
                    </div>
                </div>
            </a>
        `;
        albumesList.appendChild(item);
    });
};

const renderIntegrants = (integrants) => {
    if (!Array.isArray(integrants) || integrants.length === 0) {
        integrantsList.innerHTML = '<p class="text-muted mb-0">No hay integrantes oficiales estables para este grupo.</p>';
        return;
    }

    integrantsList.innerHTML = "";
    integrants.forEach((integrant) => {
        const exTag = integrant.estadoMiembro === "exintegrante"
            ? '<span class="badge text-bg-secondary ms-2">Exintegrante</span>'
            : "";
        const item = document.createElement("article");
        item.className = "list-group-item";
        item.innerHTML = `
            <h3 class="h6 mb-1">${integrant.nombre || "Integrante sin nombre"}${exTag}</h3>
            <p class="small text-muted mb-1"><strong>Instrumento:</strong> ${integrant.instrumento || "Dato sin confirmar"}</p>
            <p class="small text-muted mb-1"><strong>Edad:</strong> ${integrant.edad ?? "Dato sin confirmar"}</p>
            <p class="small text-muted mb-0"><strong>Fecha de nacimiento:</strong> ${integrant.fechaNacimiento || "Dato sin confirmar"}</p>
        `;
        integrantsList.appendChild(item);
    });
};

const loadGrupDetail = async () => {
    const grupId = extractGrupId();

    if (!grupId || !/^\d+$/.test(grupId)) {
        showLoadError("Identificador de grupo invalido");
        return;
    }

    try {
        const [grup, integrants, albumes] = await Promise.all([
            fetchJson(`/api/grups/${grupId}`),
            fetchJson(`/api/grups/${grupId}/integrants`),
            fetchJson(`/api/grups/${grupId}/albumes`)
        ]);

        renderGroupHeader(grup);
        renderIntegrants(integrants);
        renderAlbumes(albumes);
    } catch (error) {
        showLoadError(error.message || "Error cargando el detalle del grupo");
    }
};

loadGrupDetail();

albumesList.addEventListener("click", (event) => {
    const target = event.target;
    if (!(target instanceof Element)) {
        return;
    }

    const albumLink = target.closest("a[data-album-id]");
    if (!albumLink) {
        return;
    }

    const albumId = albumLink.getAttribute("data-album-id");
    if (!albumId) {
        return;
    }

    const grupId = extractGrupId();
    if (!grupId) {
        return;
    }

    sessionStorage.setItem("albumAccessId", albumId);
    sessionStorage.setItem("albumAccessGrupId", grupId);
    sessionStorage.setItem("albumAccessAt", Date.now().toString());
});
