<?php

namespace Drupal\egov_api\Controller;

use Drupal\Core\Controller\ControllerBase;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Drupal\comment\Entity\Comment;
use Drupal\node\Entity\Node;

/**
 * Controller pour gérer les commentaires.
 */
class CommentController extends ControllerBase {

  /**
   * Ajouter un commentaire.
   */
  public function addComment(Request $request) {
    
    $data = json_decode($request->getContent(), TRUE);
    
    if (empty($data['node_id']) || empty($data['author_name']) || empty($data['comment_body'])) {
      return new JsonResponse([
        'status' => 'error',
        'message' => 'Données manquantes',
      ], 400);
    }
    
    $node_id = (int) $data['node_id'];
    $author_name = trim($data['author_name']);
    $comment_body = trim($data['comment_body']);
    
    $node = Node::load($node_id);
    if (!$node) {
      return new JsonResponse([
        'status' => 'error',
        'message' => 'Node introuvable',
      ], 404);
    }
    
    try {
      $comment = Comment::create([
        'entity_type' => 'node',
        'entity_id' => $node_id,
        'field_name' => 'comment',
        'uid' => 0,
        'comment_type' => 'comment',
        'subject' => substr($comment_body, 0, 50),
        'comment_body' => [
          'value' => $comment_body,
          'format' => 'basic_html',
        ],
        'name' => $author_name,
        'status' => 1,
      ]);
      
      $comment->save();
      
      \Drupal::service('cache_tags.invalidator')->invalidateTags(['node:' . $node_id]);
      
      return new JsonResponse([
        'status' => 'success',
        'message' => 'Commentaire publié avec succès',
        'comment_id' => $comment->id(),
      ]);
      
    } catch (\Exception $e) {
      return new JsonResponse([
        'status' => 'error',
        'message' => 'Erreur: ' . $e->getMessage(),
      ], 500);
    }
  }

}