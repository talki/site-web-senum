// ========== MENU MOBILE AVEC OVERLAY ==========
document.addEventListener('DOMContentLoaded', function() {
    console.log('🍔 Menu mobile - Initialisation');
    
    const hamburger = document.getElementById('hamburgerBtn');
    const menu = document.querySelector('.nav-menu-desktop');
    
    if (!hamburger || !menu) {
        console.error('❌ Éléments menu non trouvés !');
        return;
    }
    
    // Fonction pour ouvrir/fermer le menu
    function toggleMenu() {
        const isOpen = menu.classList.contains('open');
        
        if (isOpen) {
            // Fermer
            hamburger.classList.remove('active');
            menu.classList.remove('open');
            document.body.classList.remove('menu-open');
        } else {
            // Ouvrir
            hamburger.classList.add('active');
            menu.classList.add('open');
            document.body.classList.add('menu-open');
        }
        
        console.log('Menu état:', isOpen ? 'fermé' : 'ouvert');
    }
    
    // Clic sur le hamburger
    hamburger.addEventListener('click', function(e) {
        e.preventDefault();
        e.stopPropagation();
        toggleMenu();
    });
    
    // Fermer en cliquant sur l'overlay (body::after)
    document.body.addEventListener('click', function(e) {
        if (document.body.classList.contains('menu-open') && 
            !menu.contains(e.target) && 
            !hamburger.contains(e.target)) {
            toggleMenu();
        }
    });
    
    // Sous-menus
    const expandedItems = document.querySelectorAll('.nav-menu-desktop li.menu-item--expanded > a');
    expandedItems.forEach(function(link) {
        link.addEventListener('click', function(e) {
            if (window.innerWidth <= 968) {
                e.preventDefault();
                this.parentElement.classList.toggle('submenu-open');
                console.log('📂 Sous-menu toggled');
            }
        });
    });
    
    // Fermer le menu quand on clique sur un lien (sauf expanded)
    const menuLinks = document.querySelectorAll('.nav-menu-desktop a:not(.menu-item--expanded > a)');
    menuLinks.forEach(function(link) {
        link.addEventListener('click', function() {
            if (window.innerWidth <= 968) {
                toggleMenu();
            }
        });
    });
    
    console.log('✅ Menu mobile initialisé');
});


