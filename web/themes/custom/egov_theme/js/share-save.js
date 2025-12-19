// Ajoutez dans custom-comments.js ou créez un nouveau fichier js/share-save.js

(function ($, Drupal) {
  'use strict';

  Drupal.behaviors.shareSaveActions = {
    attach: function (context, settings) {
      
      // ========== BOUTON PARTAGER ==========
      $('.action-btn:has(span:contains("Partager"))', context).once('share-action').on('click', function(e) {
        e.preventDefault();
        
        // Vérifier si l'API Web Share est disponible (mobile)
        if (navigator.share) {
          navigator.share({
            title: document.title,
            text: $('meta[property="og:description"]').attr('content') || 'Découvrez cet article',
            url: window.location.href
          }).catch(err => console.log('Partage annulé'));
        } else {
          // Afficher le menu de partage personnalisé
          showShareMenu($(this));
        }
      });
      
      // ========== BOUTON SAUVEGARDER ==========
      $('.action-btn:has(span:contains("Sauvegarder"))', context).once('save-action').on('click', function(e) {
        e.preventDefault();
        
        var $btn = $(this);
        var nodeId = $('article').data('history-node-id') || window.location.pathname;
        var articleData = {
          id: nodeId,
          title: document.title,
          url: window.location.href,
          date: new Date().toISOString()
        };
        
        // Récupérer les articles sauvegardés
        var saved = JSON.parse(localStorage.getItem('savedArticles') || '[]');
        var index = saved.findIndex(item => item.id === nodeId);
        
        if (index === -1) {
          // Sauvegarder
          saved.push(articleData);
          localStorage.setItem('savedArticles', JSON.stringify(saved));
          
          $btn.addClass('saved');
          $btn.find('span:last').text('✓ Sauvegardé');
          showNotification('Article sauvegardé !', 'success');
        } else {
          // Retirer
          saved.splice(index, 1);
          localStorage.setItem('savedArticles', JSON.stringify(saved));
          
          $btn.removeClass('saved');
          $btn.find('span:last').text('Sauvegarder');
          showNotification('Article retiré des favoris', 'info');
        }
      });
      
      // Vérifier au chargement si l'article est déjà sauvegardé
      checkIfSaved();
      
      // ========== FONCTIONS HELPER ==========
      
      function showShareMenu($button) {
        // Supprimer menu existant
        $('.share-menu').remove();
        
        var url = encodeURIComponent(window.location.href);
        var title = encodeURIComponent(document.title);
        
        var $menu = $('<div class="share-menu">')
          .html(`
            <div class="share-menu-header">Partager cet article</div>
            <a href="https://www.facebook.com/sharer/sharer.php?u=${url}" target="_blank" class="share-option">
              <span>📘</span> Facebook
            </a>
            <a href="https://twitter.com/intent/tweet?url=${url}&text=${title}" target="_blank" class="share-option">
              <span>🐦</span> Twitter
            </a>
            <a href="https://www.linkedin.com/sharing/share-offsite/?url=${url}" target="_blank" class="share-option">
              <span>💼</span> LinkedIn
            </a>
            <a href="mailto:?subject=${title}&body=Découvrez cet article: ${url}" class="share-option">
              <span>📧</span> Email
            </a>
            <button class="share-option copy-link" data-url="${window.location.href}">
              <span>🔗</span> Copier le lien
            </button>
          `);
        
        $('body').append($menu);
        
        // Position du menu
        var btnOffset = $button.offset();
        $menu.css({
          top: btnOffset.top + $button.outerHeight() + 10,
          left: btnOffset.left
        });
        
        setTimeout(() => $menu.addClass('show'), 10);
        
        // Copier le lien
        $('.copy-link').on('click', function() {
          var url = $(this).data('url');
          copyToClipboard(url);
          showNotification('Lien copié !', 'success');
          $menu.remove();
        });
        
        // Fermer au clic extérieur
        $(document).one('click', function(e) {
          if (!$(e.target).closest('.share-menu, .action-btn').length) {
            $menu.removeClass('show');
            setTimeout(() => $menu.remove(), 300);
          }
        });
      }
      
      function copyToClipboard(text) {
        if (navigator.clipboard) {
          navigator.clipboard.writeText(text);
        } else {
          // Fallback pour anciens navigateurs
          var $temp = $('<textarea>').val(text).appendTo('body').select();
          document.execCommand('copy');
          $temp.remove();
        }
      }
      
      function showNotification(message, type) {
        var $notification = $('<div class="custom-notification">')
          .addClass('notification-' + type)
          .html(`<span class="notification-icon">${type === 'success' ? '✓' : 'ℹ'}</span> ${message}`);
        
        $('body').append($notification);
        
        setTimeout(() => $notification.addClass('show'), 10);
        setTimeout(() => {
          $notification.removeClass('show');
          setTimeout(() => $notification.remove(), 300);
        }, 3000);
      }
      
      function checkIfSaved() {
        var nodeId = $('article').data('history-node-id') || window.location.pathname;
        var saved = JSON.parse(localStorage.getItem('savedArticles') || '[]');
        
        if (saved.some(item => item.id === nodeId)) {
          $('.action-btn:has(span:contains("Sauvegarder"))').addClass('saved').find('span:last').text('✓ Sauvegardé');
        }
      }
      
    }
  };

})(jQuery, Drupal);
