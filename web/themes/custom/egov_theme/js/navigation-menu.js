/**
 * @file
 * Navigation complète - Desktop et Mobile
 */
(function() {
    'use strict';
    
    document.addEventListener('DOMContentLoaded', function() {
        console.log('Script navigation chargé');
        
        // ============================================
        // PARTIE 1 : SOUS-MENUS DESKTOP
        // ============================================
        
        const menuItemsExpanded = document.querySelectorAll('.nav-menu-desktop li.menu-item--expanded');
        console.log('Items avec sous-menus trouvés:', menuItemsExpanded.length);
        
        menuItemsExpanded.forEach(function(item, index) {
            const submenu = item.querySelector('ul.submenu');
            
            if (submenu) {
                console.log('Sous-menu #' + index + ' trouvé:', submenu);
                
                // Desktop : affichage au hover
                item.addEventListener('mouseenter', function() {
                    if (window.innerWidth > 968) {
                        console.log('Hover sur item #' + index);
                        submenu.style.display = 'block';
                        submenu.style.opacity = '1';
                        submenu.style.visibility = 'visible';
                        submenu.style.transform = 'translateY(0)';
                    }
                });
                
                item.addEventListener('mouseleave', function() {
                    if (window.innerWidth > 968) {
                        console.log('Sortie de item #' + index);
                        submenu.style.opacity = '0';
                        submenu.style.visibility = 'hidden';
                        submenu.style.transform = 'translateY(-10px)';
                        
                        setTimeout(function() {
                            if (submenu.style.opacity === '0') {
                                submenu.style.display = 'none';
                            }
                        }, 300);
                    }
                });
                
                // Mobile : ouverture au clic
                const link = item.querySelector('a');
                if (link) {
                    link.addEventListener('click', function(e) {
                        if (window.innerWidth <= 968) {
                            e.preventDefault();
                            console.log('Sous-menu cliqué (mobile)');
                            item.classList.toggle('submenu-open');
                        }
                    });
                }
            } else {
                console.warn('Pas de sous-menu trouvé pour item #' + index);
            }
        });
        
        // ============================================
        // PARTIE 2 : MENU HAMBURGER MOBILE
        // ============================================
        
        const hamburgerBtn = document.getElementById('hamburgerBtn');
        const navMenuDesktop = document.querySelector('.nav-menu-desktop');
        
        console.log('Hamburger trouvé:', hamburgerBtn);
        console.log('Menu trouvé:', navMenuDesktop);
        
        if (!hamburgerBtn || !navMenuDesktop) {
            console.error('Éléments hamburger/menu manquants !');
            return;
        }
        
        // Toggle du menu au clic sur hamburger
        hamburgerBtn.addEventListener('click', function(e) {
            e.preventDefault();
            e.stopPropagation();
            
            console.log('Hamburger cliqué !');
            
            this.classList.toggle('active');
            navMenuDesktop.classList.toggle('open');
            
            console.log('Menu ouvert:', navMenuDesktop.classList.contains('open'));
        });
        
        // Fermer le menu si on clique en dehors
        document.addEventListener('click', function(e) {
            if (!navMenuDesktop.contains(e.target) && !hamburgerBtn.contains(e.target)) {
                hamburgerBtn.classList.remove('active');
                navMenuDesktop.classList.remove('open');
            }
        });
        
        // Réinitialiser au redimensionnement
        window.addEventListener('resize', function() {
            if (window.innerWidth > 968) {
                navMenuDesktop.classList.remove('open');
                hamburgerBtn.classList.remove('active');
            }
        });
    });
})();