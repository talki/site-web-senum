/**
 * Menu Mobile
 */
(function() {
    'use strict';
    
    if (window.mobileMenuDone) return;
    window.mobileMenuDone = true;
    
    document.addEventListener('DOMContentLoaded', function() {
        
        var hamburger = document.getElementById('hamburgerBtn');
        var menu = document.getElementById('mainMenu') || document.querySelector('.nav-menu-desktop');
        var overlay = document.getElementById('menuOverlay');
        var accueilItem = document.getElementById('accueilItem') || document.querySelector('li.has-submenu');
        
        if (!hamburger || !menu) {
            console.log('Menu: éléments manquants');
            return;
        }
        
        // Créer overlay si absent
        if (!overlay) {
            overlay = document.createElement('div');
            overlay.className = 'menu-overlay';
            overlay.id = 'menuOverlay';
            document.body.appendChild(overlay);
        }
        
        console.log('✅ Menu mobile initialisé');
        
        // Hamburger
        hamburger.addEventListener('click', function(e) {
            e.preventDefault();
            e.stopPropagation();
            
            var isOpen = menu.classList.contains('open');
            console.log('Hamburger cliqué, menu ouvert:', !isOpen);
            
            if (isOpen) {
                fermerMenu();
            } else {
                ouvrirMenu();
            }
        });
        
        // Overlay
        overlay.addEventListener('click', fermerMenu);
        
        // Lien Accueil (sous-menu)
        if (accueilItem) {
            var accueilLink = accueilItem.querySelector('a');
            if (accueilLink) {
                accueilLink.addEventListener('click', function(e) {
                    if (window.innerWidth <= 968) {
                        e.preventDefault();
                        e.stopPropagation();
                        accueilItem.classList.toggle('submenu-open');
                        console.log('Sous-menu toggled:', accueilItem.classList.contains('submenu-open'));
                    }
                });
            }
        }
        
        function ouvrirMenu() {
            menu.classList.add('open');
            hamburger.classList.add('active');
            overlay.classList.add('active');
            document.body.classList.add('menu-open');
        }
        
        function fermerMenu() {
            menu.classList.remove('open');
            hamburger.classList.remove('active');
            overlay.classList.remove('active');
            document.body.classList.remove('menu-open');
            if (accueilItem) {
                accueilItem.classList.remove('submenu-open');
            }
        }
        
        // Escape
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') fermerMenu();
        });
    });
})();