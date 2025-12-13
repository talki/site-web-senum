// Toggle autoplay
const toggleSwitch = document.querySelector('.toggle-switch');
toggleSwitch.addEventListener('click', function () {
    this.classList.toggle('active');
});

// Toggle subscribe button
const subscribeBtn = document.querySelector('.subscribe-btn');
subscribeBtn.addEventListener('click', function () {
    this.classList.toggle('subscribed');
    if (this.classList.contains('subscribed')) {
        this.textContent = 'Abonné ✓';
    } else {
        this.textContent = 'S\'abonner';
    }
});

// Like button
const likeBtn = document.querySelector('.action-button:first-child');
likeBtn.addEventListener('click', function () {
    this.classList.toggle('liked');
});

// Show more description
const showMoreBtn = document.querySelector('.show-more-btn');
showMoreBtn.addEventListener('click', function () {
    const allParagraphs = document.querySelectorAll('.description-text');
    allParagraphs.forEach(p => p.style.display = 'block');
    this.textContent = this.textContent === 'Afficher plus' ? 'Afficher moins' : 'Afficher plus';
});

// Progress bar click
const progressBar = document.querySelector('.progress-bar');
progressBar.addEventListener('click', function (e) {
    const rect = this.getBoundingClientRect();
    const percent = (e.clientX - rect.left) / rect.width * 100;
    document.querySelector('.progress-fill').style.width = percent + '%';
});

// Play overlay
const playOverlay = document.querySelector('.play-overlay');
playOverlay.addEventListener('click', function () {
    alert('Lecture de la vidéo...');
});

// Comment actions
const commentInput = document.querySelector('.comment-input');
const commentActions = document.querySelector('.add-comment .comment-actions');

commentInput.addEventListener('focus', function () {
    commentActions.style.display = 'flex';
});

document.querySelector('.btn-cancel').addEventListener('click', function () {
    commentInput.value = '';
    commentActions.style.display = 'none';
    commentInput.blur();
});

document.querySelector('.btn-submit').addEventListener('click', function () {
    if (commentInput.value.trim()) {
        alert('Commentaire publié : ' + commentInput.value);
        commentInput.value = '';
        commentActions.style.display = 'none';
    }
});

// Hide comment actions initially
commentActions.style.display = 'none';
