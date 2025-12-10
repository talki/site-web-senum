<?php

namespace Drupal\management\Controller;

use Drupal\Core\Controller\ControllerBase;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpFoundation\Response;

/**
 * Contrôleur pour gérer la soumission du formulaire de contact.
 */
class ContactController extends ControllerBase {

    /**
     * Traite la soumission du formulaire de contact.
     *
     * @param \Symfony\Component\HttpFoundation\Request $request
     *   L'objet de requête HTTP.
     *
     * @return \Symfony\Component\HttpFoundation\JsonResponse|\Symfony\Component\HttpFoundation\RedirectResponse
     *   Une réponse JSON ou une redirection.
     */
    public function submitForm(Request $request) {

        // Récupération des données POST
        $nom = $request->request->get('nom');
        $email = $request->request->get('email');
        $messageTexte = $request->request->get('message');

        // Envoi d'un email simple via Drupal
        $mailManager = \Drupal::service('plugin.manager.mail');

        $module = 'management';   // Le nom de TON module actuel
        $key = 'contact_form';    // La clé de l'email
        $to = 'nkital@gmail.com'; // Destinataire (modifiables plus tard)
        $langcode = \Drupal::languageManager()->getCurrentLanguage()->getId();

        $params = [
            'nom' => $nom,
            'email' => $email,
            'message' => $messageTexte,
        ];

        $mailManager->mail($module, $key, $to, $langcode, $params);

        // Message utilisateur
        \Drupal::messenger()->addMessage(
                "Nous vous remercions pour votre message. Nous reviendrons vers vous dans les meilleurs délais."
        );

        $html = '
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Message envoyé</title>
<meta http-equiv="refresh" content="3;url=/">
<style>
    body {
        font-family: Arial, sans-serif;
        background: #f5f7fa;
        margin: 0;
        padding: 0;
        display: flex;
        height: 100vh;
        justify-content: center;
        align-items: center;
        color: #333;
    }
    .box {
        background: white;
        padding: 30px 40px;
        border-radius: 12px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        text-align: center;
        max-width: 420px;
    }
    .title {
        font-size: 22px;
        margin-bottom: 15px;
        font-weight: bold;
        color: #00853f;
    }
    .subtitle {
        font-size: 15px;
        margin-bottom: 20px;
    }
    .loader {
        border: 4px solid #e5e7eb;
        border-top: 4px solid #00853f;
        border-radius: 50%;
        width: 35px;
        height: 35px;
        margin: 0 auto 15px auto;
        animation: spin 0.9s linear infinite;
    }
    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }
</style>
</head>
<body>

<div class="box">
    <div class="loader"></div>
    <div class="title">Message envoyé avec succès</div>
    <div class="subtitle">
        Nous vous remercions pour votre message.<br>
        Vous allez être redirigé automatiquement…
    </div>
</div>

</body>
</html>
';

        return new Response($html);

        // Redirection vers la page contact
        // return new RedirectResponse('/contact?success=1');
    }
}
