<?php

namespace Drupal\management\Controller;

use Drupal\Core\Controller\ControllerBase;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

class EnrolementController extends ControllerBase {

    public function submitForm(Request $request) {
        $nom_structure = $request->request->get('nom_structure');
        $adresse_structure = $request->request->get('adresse_structure');
        $description_structure = $request->request->get('description_structure');
        $secteur_activite = $request->request->get('secteur_activite');
        $objet_adhesion = $request->request->get('objet_adhesion');
        $type_donnees = $request->request->get('type_donnees');
        
        $civilite = $request->request->get('civilite');
        $prenom = $request->request->get('prenom');
        $nom = $request->request->get('nom');
        $telephone = $request->request->get('telephone');
        $email = $request->request->get('email');
        $fonction = $request->request->get('fonction');
        $message = $request->request->get('message');

        $mailManager = \Drupal::service('plugin.manager.mail');
        $module = 'management';
        $key = 'enrolement_form';
        $to = 'nkital@gmail.com';
        $langcode = \Drupal::languageManager()->getCurrentLanguage()->getId();
        
        $params = [
            'nom_structure' => $nom_structure,
            'adresse_structure' => $adresse_structure,
            'description_structure' => $description_structure,
            'secteur_activite' => $secteur_activite,
            'objet_adhesion' => $objet_adhesion,
            'type_donnees' => $type_donnees,
            'civilite' => $civilite,
            'prenom' => $prenom,
            'nom' => $nom,
            'telephone' => $telephone,
            'email' => $email,
            'fonction' => $fonction,
            'message' => $message,
        ];
        
        $mailManager->mail($module, $key, $to, $langcode, $params);

        $html = '<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Demande envoyee</title>
<meta http-equiv="refresh" content="4;url=/demande-enrolement">
<style>
body{font-family:Arial,sans-serif;background:linear-gradient(135deg,#f5f7fa 0%,#e4e8ec 100%);margin:0;padding:0;display:flex;height:100vh;justify-content:center;align-items:center;color:#333}
.box{background:white;padding:40px 50px;border-radius:16px;box-shadow:0 10px 40px rgba(0,0,0,0.12);text-align:center;max-width:480px}
.icon{font-size:60px;margin-bottom:20px}
.title{font-size:24px;margin-bottom:15px;font-weight:bold;color:#00853f}
.subtitle{font-size:16px;margin-bottom:25px;color:#64748b;line-height:1.6}
.loader{border:4px solid #e5e7eb;border-top:4px solid #00853f;border-radius:50%;width:40px;height:40px;margin:0 auto 20px auto;animation:spin 0.9s linear infinite}
@keyframes spin{0%{transform:rotate(0deg)}100%{transform:rotate(360deg)}}
.info{background:#f0fdf4;padding:15px;border-radius:10px;font-size:14px;color:#166534}
</style>
</head>
<body>
<div class="box">
<div class="icon">&#10004;</div>
<div class="title">Demande envoyee avec succes</div>
<div class="subtitle">Votre demande a bien ete recue.<br>Notre equipe vous contactera prochainement.</div>
<div class="loader"></div>
<div class="info">Un email de confirmation sera envoye.</div>
</div>
</body>
</html>';

        return new Response($html);
    }
}