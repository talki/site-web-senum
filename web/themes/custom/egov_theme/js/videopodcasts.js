// Jouer la vidéo directement dans la carte (inline)
function playVideoInline(element, videoId) {
    const thumbnail = element.closest('.video-thumbnail') || element.closest('.featured-thumbnail');
    if (!thumbnail) return;
    
    // Remplacer la vignette par le player YouTube
    thumbnail.innerHTML = `
        <iframe 
            width="100%" 
            height="100%" 
            style="position: absolute; top: 0; left: 0; border-radius: 12px;"
            src="https://www.youtube.com/embed/${videoId}?autoplay=1" 
            frameborder="0" 
            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
            allowfullscreen>
        </iframe>
    `;
}

// Ouvrir le modal avec la vidéo en plein écran
function openVideoModal(videoId) {
    const modal = document.getElementById('videoModal');
    const playerContainer = document.getElementById('videoPlayerContainer');
    
    if (!modal || !playerContainer) {
        console.error('Modal elements not found');
        return;
    }
    
    playerContainer.innerHTML = `
        <iframe 
            width="100%" 
            height="600" 
            src="https://www.youtube.com/embed/${videoId}?autoplay=1" 
            frameborder="0" 
            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
            allowfullscreen>
        </iframe>
    `;
    
    modal.style.display = 'flex';
    document.body.style.overflow = 'hidden'; // Bloquer le scroll
}

// Fermer le modal
function closeVideoModal() {
    const modal = document.getElementById('videoModal');
    const playerContainer = document.getElementById('videoPlayerContainer');
    
    if (modal) modal.style.display = 'none';
    if (playerContainer) playerContainer.innerHTML = '';
    document.body.style.overflow = 'auto'; // Réactiver le scroll
}

// Fermer avec la touche Escape
document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
        closeVideoModal();
    }
});

// Gérer les filtres de catégories
document.addEventListener('DOMContentLoaded', function() {
    const filterButtons = document.querySelectorAll('.filter-btn');
    const videoCards = document.querySelectorAll('.video-card');
    
    filterButtons.forEach(button => {
        button.addEventListener('click', function() {
            const filter = this.getAttribute('data-filter');
            
            // Mettre à jour les boutons actifs
            filterButtons.forEach(btn => btn.classList.remove('active'));
            this.classList.add('active');
            
            // Filtrer les vidéos
            videoCards.forEach(card => {
                if (filter === 'all' || card.getAttribute('data-category') === filter) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        });
    });
});