
// Filter functionality
const filterButtons = document.querySelectorAll('.filter-btn');
const articles = document.querySelectorAll('.article-card');

filterButtons.forEach(button => {
    button.addEventListener('click', function () {
        // Remove active class from all buttons
        filterButtons.forEach(btn => btn.classList.remove('active'));
        // Add active class to clicked button
        this.classList.add('active');

        const filter = this.getAttribute('data-filter');

        articles.forEach(article => {
            if (filter === 'all') {
                article.style.display = 'flex';
                setTimeout(() => {
                    article.style.opacity = '1';
                    article.style.transform = 'translateY(0)';
                }, 10);
            } else {
                const category = article.getAttribute('data-category');
                if (category === filter) {
                    article.style.display = 'flex';
                    setTimeout(() => {
                        article.style.opacity = '1';
                        article.style.transform = 'translateY(0)';
                    }, 10);
                } else {
                    article.style.opacity = '0';
                    article.style.transform = 'translateY(20px)';
                    setTimeout(() => {
                        article.style.display = 'none';
                    }, 300);
                }
            }
        });
    });
});

// Smooth scroll animations
const observerOptions = {
    threshold: 0.1,
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

articles.forEach(article => {
    article.style.opacity = '0';
    article.style.transform = 'translateY(30px)';
    article.style.transition = 'all 0.6s ease';
    observer.observe(article);
});
