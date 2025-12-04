(function (Drupal, once) {
  'use strict';

  Drupal.behaviors.servicesPage = {
    attach: function (context, settings) {
      // Search functionality
      const searchInput = once('services-search', '#servicesSearchInput', context);
      if (searchInput.length) {
        const serviceItems = context.querySelectorAll('.services-service-item');

        searchInput[0].addEventListener('input', function(e) {
          const searchTerm = e.target.value.toLowerCase();
          
          serviceItems.forEach(item => {
            const title = item.querySelector('h3').textContent.toLowerCase();
            const description = item.querySelector('p').textContent.toLowerCase();
            
            if (title.includes(searchTerm) || description.includes(searchTerm)) {
              item.style.display = 'block';
            } else {
              item.style.display = 'none';
            }
          });
        });
      }

      // Filter functionality
      const filterButtons = once('services-filter', '.services-filter-btn', context);
      if (filterButtons.length) {
        const serviceItems = context.querySelectorAll('.services-service-item');
        
        filterButtons.forEach(button => {
          button.addEventListener('click', function() {
            // Remove active class from all buttons
            context.querySelectorAll('.services-filter-btn').forEach(btn => btn.classList.remove('active'));
            // Add active class to clicked button
            this.classList.add('active');
            
            const category = this.getAttribute('data-category');
            
            if (category === 'all') {
              serviceItems.forEach(item => item.style.display = 'block');
            } else if (category === 'populaires') {
              serviceItems.forEach(item => {
                const hasPopularBadge = item.querySelector('.services-service-badge') && 
                                       item.querySelector('.services-service-badge').textContent === 'Populaire';
                item.style.display = hasPopularBadge ? 'block' : 'none';
              });
            } else if (category === 'nouveaux') {
              serviceItems.forEach(item => {
                const hasNewBadge = item.querySelector('.services-service-badge') && 
                                   item.querySelector('.services-service-badge').textContent === 'Nouveau';
                item.style.display = hasNewBadge ? 'block' : 'none';
              });
            }
          });
        });
      }
    }
  };

})(Drupal, once);
