/**
 * @file
 * JavaScript pour le thème E-Gov Sénégal
 */

(function (Drupal, once) {
  'use strict';

  Drupal.behaviors.egovTheme = {
    attach: function (context, settings) {
      
      // Smooth scroll pour les ancres
      once('smooth-scroll', 'a[href^="#"]', context).forEach(function(anchor) {
        anchor.addEventListener('click', function (e) {
          const target = document.querySelector(this.getAttribute('href'));
          if (target) {
            e.preventDefault();
            target.scrollIntoView({ behavior: 'smooth', block: 'start' });
          }
        });
      });

      // Observer pour les animations au scroll
      const observerOptions = {
        threshold: 0.2,
        rootMargin: '0px 0px -50px 0px'
      };

      const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
          if (entry.isIntersecting) {
            entry.target.style.opacity = '1';
            entry.target.style.transform = 'translateY(0)';
          }
        });
      }, observerOptions);

      // Observer les cartes pour animation
      once('animate-cards', '.stat-card, .service-card, .use-case-card, .benefit-card', context).forEach(function(el) {
        el.style.opacity = '0';
        el.style.transform = 'translateY(30px)';
        el.style.transition = 'all 0.6s ease-out';
        observer.observe(el);
      });

      // Animation des compteurs pour les stats
      function animateCounter(element, target) {
        const duration = 2000;
        const start = 0;
        const increment = target / (duration / 16);
        let current = start;

        const timer = setInterval(() => {
          current += increment;
          if (current >= target) {
            element.textContent = target;
            clearInterval(timer);
          } else {
            element.textContent = Math.floor(current);
          }
        }, 16);
      }

      // Observer pour les statistiques
      const statsObserver = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
          if (entry.isIntersecting) {
            const numbers = entry.target.querySelectorAll('.stat-number');
            numbers.forEach(num => {
              const text = num.textContent;
              const value = parseFloat(text.replace(/[^0-9.]/g, ''));
              if (!isNaN(value) && text.indexOf('%') === -1 && text.indexOf('M') === -1 && text.indexOf('K') === -1) {
                animateCounter(num, value);
              }
            });
            statsObserver.unobserve(entry.target);
          }
        });
      }, { threshold: 0.5 });

      // Observer la section des stats
      once('stats-animation', '.stats-section, .stats-section-fullwidth', context).forEach(function(section) {
        statsObserver.observe(section);
      });

    }
  };

})(Drupal, once);
