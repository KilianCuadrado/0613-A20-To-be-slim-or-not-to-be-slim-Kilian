fetch("/api/grups")
    .then((response) => response.json())
    .then((data) => {
        const grupsList = document.getElementById("grups-list");

        data.forEach((grup) => {
            const imageUrl = grup.img || "https://via.placeholder.com/640x360?text=Sin+imagen";
            const detailUrl = `/grup/${grup.id}`;
            const card = document.createElement("article");
            card.className = "col-12 col-sm-6 col-lg-4";
            card.innerHTML = `
                <a href="${detailUrl}" class="grup-link-hover text-decoration-none text-reset d-block h-100">
                    <div class="grup-card-hover card h-100 shadow-sm">
                        <img src="${imageUrl}" class="card-img-top" alt="Imagen de ${grup.nombre}" style="height: 220px; object-fit: cover;">
                        <div class="card-body">
                            <h2 class="card-title h5">${grup.nombre}</h2>
                            <p class="card-text small text-muted mb-0">${grup.descripcion ?? ""}</p>
                        </div>
                    </div>
                </a>
            `;
            grupsList.appendChild(card);
        });
    })
    .catch((error) => console.error("Error fetching grups:", error));
