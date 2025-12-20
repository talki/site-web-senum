/**
 * @file
 * Navigation complète - Desktop et Mobile
 */
(function() {
    'use strict';
    
    document.addEventListener('DOMContentLoaded', function() {
        console.log('🚀 Script navigation chargé');
        
        // ============================================
        // PARTIE 1 : SOUS-MENUS DESKTOP
        // ============================================
        
        const menuItemsExpanded = document.querySelectorAll('.nav-menu-desktop li.menu-item--expanded');
        console.log('📋 Items avec sous-menus trouvés:', menuItemsExpanded.length);
        
        menuItemsExpanded.forEach(function(item, index) {
            const submenu = item.querySelector('ul.submenu, .menu-level-1');
            
            if (submenu) {
                // Desktop : affichage au hover (le CSS gère déjà ça)
                // Mobile : ouverture au clic
                const link = item.querySelector('a');
                if (link) {
                    link.addEventListener('click', function(e) {
                        if (window.innerWidth <= 968) {
                            e.preventDefault();
                            console.log('📱 Sous-menu cliqué (mobile) #' + index);
                            item.classList.toggle('submenu-open');
                        }
                    });
                }
            }
        });
        
        // ============================================
        // PARTIE 2 : MENU HAMBURGER MOBILE
        // ============================================
        
        const hamburgerBtn = document.getElementById('hamburgerBtn');
        const navMenuDesktop = document.querySelector('.nav-menu-desktop');
        
        console.log('🍔 Hamburger trouvé:', hamburgerBtn ? 'OUI' : 'NON');
        console.log('📱 Menu trouvé:', navMenuDesktop ? 'OUI' : 'NON');
        
        if (!hamburgerBtn || !navMenuDesktop) {
            console.error('❌ Éléments hamburger/menu manquants !');
            return;
        }
        
        // Toggle du menu au clic sur hamburger
        hamburgerBtn.addEventListener('click', function(e) {
            e.preventDefault();
            e.stopPropagation();
            
            const isOpen = navMenuDesktop.classList.contains('open');
            
            console.log('🍔 Hamburger cliqué ! État actuel:', isOpen ? 'ouvert' : 'fermé');
            
            if (isOpen) {
                // Fermer
                navMenuDesktop.classList.remove('open');
                this.classList.remove('active');
                document.body.style.overflow = '';
                console.log('✅ Menu fermé');
            } else {
                // Ouvrir
                navMenuDesktop.classList.add('open');
                this.classList.add('active');
                document.body.style.overflow = 'hidden';
                console.log('✅ Menu ouvert');
            }
        });
        
        // Fermer le menu si on clique en dehors
        document.addEventListener('click', function(e) {
            if (navMenuDesktop.classList.contains('open') && 
                !navMenuDesktop.contains(e.target) && 
                !hamburgerBtn.contains(e.target)) {
                
                console.log('👆 Clic extérieur - Fermeture menu');
                navMenuDesktop.classList.remove('open');
                hamburgerBtn.classList.remove('active');
                document.body.style.overflow = '';
            }
        });
        
        // Empêcher la fermeture si on clique dans le menu
        navMenuDesktop.addEventListener('click', function(e) {
            e.stopPropagation();
        });
        
        // Réinitialiser au redimensionnement
        window.addEventListener('resize', function() {
            if (window.innerWidth > 968) {
                navMenuDesktop.classList.remove('open');
                hamburgerBtn.classList.remove('active');
                document.body.style.overflow = '';
                console.log('📐 Redimensionnement - Menu réinitialisé');
            }
        });
        
        console.log('✅ Navigation initialisée avec succès');
    });
})();
