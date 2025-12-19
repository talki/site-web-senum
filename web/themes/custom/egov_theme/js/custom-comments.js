(function ($, Drupal) {
  'use strict';

  Drupal.behaviors.customComments = {
    attach: function (context, settings) {
      
      $('#custom-comment-form', context).once('custom-comment-form').on('submit', function(e) {
        e.preventDefault();
        
        const form = $(this);
        const nodeId = form.data('node-id');
        const authorName = $('#comment-author-name').val().trim();
        const commentBody = $('#comment-body').val().trim();
        const submitBtn = form.find('.btn-submit');
        const messageDiv = $('#comment-message');
        
        if (!authorName || !commentBody) {
          messageDiv.html('<p style="color: red;">❌ Veuillez remplir tous les champs.</p>');
          return;
        }
        
        submitBtn.prop('disabled', true).text('Envoi en cours...');
        messageDiv.html('<p style="color: blue;">⏳ Envoi du commentaire...</p>');
        
        $.ajax({
          url: '/egov-api/add-comment',
          method: 'POST',
          contentType: 'application/json',
          data: JSON.stringify({
            node_id: nodeId,
            author_name: authorName,
            comment_body: commentBody
          }),
          success: function(response) {
            messageDiv.html('<p style="color: green;">✅ ' + response.message + '</p>');
            $('#comment-author-name').val('');
            $('#comment-body').val('');
            setTimeout(function() {
              location.reload();
            }, 2000);
          },
          error: function(xhr) {
            let errorMsg = '❌ Erreur lors de l\'envoi.';
            if (xhr.responseJSON && xhr.responseJSON.message) {
              errorMsg += ' ' + xhr.responseJSON.message;
            }
            messageDiv.html('<p style="color: red;">' + errorMsg + '</p>');
            submitBtn.prop('disabled', false).text('Publier');
          }
        });
      });
      
      $('.btn-cancel', context).once('comment-cancel').on('click', function() {
        $('#comment-author-name').val('');
        $('#comment-body').val('');
        $('#comment-message').html('');
      });
      
    }
  };

})(jQuery, Drupal);
