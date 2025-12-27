<?php

/**
 * Script pour créer les pages légales - Plateforme Jokkoo
 */

use Drupal\node\Entity\Node;
use Drupal\path_alias\Entity\PathAlias;

// Contenu des pages
$pages = [
    [
        'title' => 'Mentions Légales',
        'path' => '/mentions-legales',
        'body' => '<h2>Éditeur du Site</h2>
<p>La Plateforme Nationale d\'Interopérabilité <strong>Jokkoo</strong> est éditée par :</p>
<ul>
    <li><strong>Ministère de la Communication, des Télécommunications et du Numérique (MCTN)</strong></li>
    <li>Secrétariat d\'État au Numérique (SENUM)</li>
    <li>Adresse : Building administratif, Boulevard de la République, Dakar, Sénégal</li>
    <li>Téléphone : +221 33 XXX XX XX</li>
    <li>Email : contact@egov.sn</li>
</ul>
<h2>Directeur de la Publication</h2>
<p>Le Directeur de la publication est le Secrétaire d\'État au Numérique de la République du Sénégal.</p>
<h2>Hébergement</h2>
<p>Le site est hébergé par :</p>
<ul>
    <li><strong>ADIE</strong> - Agence De l\'Informatique de l\'État</li>
    <li>Adresse : Sicap Amitié 3, Villa n°4071, Dakar, Sénégal</li>
    <li>Téléphone : +221 33 869 03 69</li>
</ul>
<h2>Propriété Intellectuelle</h2>
<p>L\'ensemble du contenu de ce site est la propriété exclusive de l\'État du Sénégal. Toute reproduction est interdite sans autorisation.</p>
<h2>Droit Applicable</h2>
<p>Les présentes mentions légales sont régies par le droit sénégalais. En cas de litige, les tribunaux de Dakar seront compétents.</p>
<h2>Contact</h2>
<p>Email : <a href="mailto:legal@egov.sn">legal@egov.sn</a></p>',
    ],
    [
        'title' => 'Politique de Confidentialité',
        'path' => '/politique-confidentialite',
        'body' => '<h2>Introduction</h2>
<p>La plateforme <strong>Jokkoo</strong> s\'engage à protéger la vie privée des utilisateurs conformément à la <strong>Loi n°2008-12 du 25 janvier 2008</strong> sur la protection des données personnelles au Sénégal.</p>
<h2>Données Collectées</h2>
<ul>
    <li><strong>Données d\'identification</strong> : nom, prénom, email, téléphone</li>
    <li><strong>Données de connexion</strong> : adresse IP, logs, navigateur</li>
    <li><strong>Données d\'utilisation</strong> : historique des services consultés</li>
</ul>
<h2>Vos Droits</h2>
<ul>
    <li><strong>Droit d\'accès</strong> : obtenir une copie de vos données</li>
    <li><strong>Droit de rectification</strong> : corriger des données inexactes</li>
    <li><strong>Droit à l\'effacement</strong> : demander la suppression</li>
</ul>
<p>Contact : <a href="mailto:dpo@egov.sn">dpo@egov.sn</a></p>
<h2>Réclamation</h2>
<p>Commission des Données Personnelles (CDP) du Sénégal : <a href="mailto:contact@cdp.sn">contact@cdp.sn</a></p>
<p><em>Dernière mise à jour : Décembre 2025</em></p>',
    ],
    [
        'title' => 'Conditions d\'Utilisation',
        'path' => '/conditions-utilisation',
        'body' => '<h2>Objet</h2>
<p>Les présentes CGU régissent l\'accès à la plateforme <strong>Jokkoo</strong>. En accédant à la plateforme, vous acceptez ces conditions.</p>
<h2>Accès à la Plateforme</h2>
<p>La plateforme est accessible gratuitement. L\'État peut suspendre l\'accès pour maintenance ou sécurité.</p>
<h2>Utilisation des Services</h2>
<p>L\'utilisateur s\'engage à ne pas :</p>
<ul>
    <li>Accéder de manière non autorisée aux systèmes</li>
    <li>Utiliser les services à des fins illicites</li>
    <li>Transmettre des virus ou codes malveillants</li>
</ul>
<h2>Propriété Intellectuelle</h2>
<p>Tous les éléments de la plateforme sont protégés. Toute reproduction est interdite sans autorisation.</p>
<h2>Droit Applicable</h2>
<p>Ces CGU sont régies par le droit sénégalais. Tribunaux compétents : Dakar.</p>
<p>Contact : <a href="mailto:legal@egov.sn">legal@egov.sn</a></p>
<p><em>Dernière mise à jour : Décembre 2025</em></p>',
    ],
    [
        'title' => 'Accessibilité',
        'path' => '/accessibilite',
        'body' => '<h2>Notre Engagement</h2>
<p>La plateforme <strong>Jokkoo</strong> s\'engage à rendre ses services accessibles à tous, y compris les personnes en situation de handicap.</p>
<h2>Niveau d\'Accessibilité Visé</h2>
<ul>
    <li><strong>WCAG 2.1</strong> - Niveau AA</li>
    <li><strong>RGAA</strong></li>
</ul>
<h2>Mesures d\'Accessibilité</h2>
<ul>
    <li>Navigation au clavier</li>
    <li>Textes alternatifs pour les images</li>
    <li>Contrastes de couleurs suffisants</li>
    <li>Structure de titres cohérente</li>
    <li>Compatibilité avec les lecteurs d\'écran</li>
</ul>
<h2>Signaler un Problème</h2>
<p>Email : <a href="mailto:accessibilite@egov.sn">accessibilite@egov.sn</a></p>
<p><em>Décembre 2025</em></p>',
    ],
    [
        'title' => 'Plan du Site',
        'path' => '/plan-du-site',
        'body' => '<h2>Navigation Principale</h2>
<ul>
    <li><a href="/">Accueil</a></li>
    <li><a href="/presentation-du-projet">À propos</a></li>
    <li><a href="/services">Services</a></li>
    <li><a href="/cadre-et-standard">Cadres et Standards</a></li>
    <li><a href="/tableau-de-bord">Tableau de Bord</a></li>
    <li><a href="/contact">Contact</a></li>
</ul>
<h2>Ressources</h2>
<ul>
    <li><a href="/publications">Publications</a></li>
    <li><a href="/actualites">Actualités</a></li>
    <li><a href="/videos-podcast">Vidéos & Podcast</a></li>
</ul>
<h2>Informations Légales</h2>
<ul>
    <li><a href="/mentions-legales">Mentions légales</a></li>
    <li><a href="/politique-confidentialite">Politique de confidentialité</a></li>
    <li><a href="/conditions-utilisation">Conditions d\'utilisation</a></li>
    <li><a href="/accessibilite">Accessibilité</a></li>
    <li><a href="/plan-du-site">Plan du site</a></li>
</ul>
<h2>Contact</h2>
<p>Email : <a href="mailto:contact@egov.sn">contact@egov.sn</a><br>
Téléphone : +221 33 869 03 69</p>',
    ],
];

echo "=== Création des pages légales ===\n\n";

foreach ($pages as $page_data) {
    // Vérifier si la page existe
    $existing = \Drupal::entityTypeManager()
        ->getStorage('node')
        ->loadByProperties(['title' => $page_data['title'], 'type' => 'page']);
    
    if (!empty($existing)) {
        echo "⚠️  '{$page_data['title']}' existe déjà\n";
        continue;
    }
    
    // Créer la page
    $node = Node::create([
        'type' => 'page',
        'title' => $page_data['title'],
        'body' => [
            'value' => $page_data['body'],
            'format' => 'full_html',
        ],
        'status' => 1,
        'langcode' => 'fr',
        'uid' => 1,
    ]);
    $node->save();
    
    // Créer l'alias URL
    $alias = PathAlias::create([
        'path' => '/node/' . $node->id(),
        'alias' => $page_data['path'],
        'langcode' => 'fr',
    ]);
    $alias->save();
    
    echo "✅ {$page_data['title']} → {$page_data['path']} (node/{$node->id()})\n";
}

echo "\n=== Terminé ! ===\n";
