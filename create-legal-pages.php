#!/usr/bin/env drush
<?php

/**
 * Script pour créer les pages légales - Plateforme Jokkoo
 * Exécuter avec: drush php:script create-legal-pages.php
 */

use Drupal\node\Entity\Node;
use Drupal\pathauto\PathautoState;

// ============================================
// PAGE 1: MENTIONS LÉGALES
// ============================================
$mentions_legales = <<<HTML
<h2>Éditeur du Site</h2>
<p>La Plateforme Nationale d'Interopérabilité <strong>Jokkoo</strong> est éditée par :</p>
<ul>
    <li><strong>Ministère de la Communication, des Télécommunications et du Numérique (MCTN)</strong></li>
    <li>Secrétariat d'État au Numérique (SENUM)</li>
    <li>Adresse : Building administratif, Boulevard de la République, Dakar, Sénégal</li>
    <li>Téléphone : +221 33 XXX XX XX</li>
    <li>Email : contact@egov.sn</li>
</ul>

<h2>Directeur de la Publication</h2>
<p>Le Directeur de la publication est le Secrétaire d'État au Numérique de la République du Sénégal.</p>

<h2>Hébergement</h2>
<p>Le site est hébergé par :</p>
<ul>
    <li><strong>ADIE</strong> - Agence De l'Informatique de l'État</li>
    <li>Adresse : Sicap Amitié 3, Villa n°4071, Dakar, Sénégal</li>
    <li>Téléphone : +221 33 869 03 69</li>
</ul>

<h2>Propriété Intellectuelle</h2>
<p>L'ensemble du contenu de ce site (textes, images, logos, icônes, sons, logiciels, etc.) est la propriété exclusive de l'État du Sénégal ou de ses partenaires. Toute reproduction, représentation, modification, publication ou adaptation de tout ou partie des éléments du site est interdite, sauf autorisation écrite préalable.</p>

<h2>Liens Hypertextes</h2>
<p>La plateforme Jokkoo peut contenir des liens hypertextes vers d'autres sites. L'État du Sénégal n'exerce aucun contrôle sur ces sites et décline toute responsabilité quant à leur contenu.</p>

<h2>Droit Applicable</h2>
<p>Les présentes mentions légales sont régies par le droit sénégalais. En cas de litige, les tribunaux de Dakar seront seuls compétents.</p>

<h2>Contact</h2>
<p>Pour toute question relative aux présentes mentions légales, vous pouvez nous contacter à l'adresse : <a href="mailto:legal@egov.sn">legal@egov.sn</a></p>
HTML;

// ============================================
// PAGE 2: POLITIQUE DE CONFIDENTIALITÉ
// ============================================
$politique_confidentialite = <<<HTML
<h2>Introduction</h2>
<p>La plateforme <strong>Jokkoo</strong>, Plateforme Nationale d'Interopérabilité du Sénégal, s'engage à protéger la vie privée des utilisateurs. Cette politique de confidentialité explique comment nous collectons, utilisons et protégeons vos données personnelles conformément à la <strong>Loi n°2008-12 du 25 janvier 2008</strong> sur la protection des données à caractère personnel au Sénégal.</p>

<h2>Responsable du Traitement</h2>
<p>Le responsable du traitement des données est :</p>
<ul>
    <li><strong>Ministère de la Communication, des Télécommunications et du Numérique</strong></li>
    <li>Secrétariat d'État au Numérique</li>
    <li>Email : dpo@egov.sn</li>
</ul>

<h2>Données Collectées</h2>
<p>Nous collectons les données suivantes :</p>
<ul>
    <li><strong>Données d'identification</strong> : nom, prénom, adresse email, numéro de téléphone</li>
    <li><strong>Données de connexion</strong> : adresse IP, logs de connexion, navigateur utilisé</li>
    <li><strong>Données professionnelles</strong> : organisme, fonction (pour les administrations partenaires)</li>
    <li><strong>Données d'utilisation</strong> : historique des services consultés, requêtes API</li>
</ul>

<h2>Finalités du Traitement</h2>
<p>Vos données sont collectées pour :</p>
<ul>
    <li>Fournir les services de la plateforme d'interopérabilité</li>
    <li>Gérer les comptes utilisateurs et l'authentification</li>
    <li>Assurer la sécurité et prévenir les fraudes</li>
    <li>Améliorer nos services et établir des statistiques</li>
    <li>Répondre à vos demandes de support</li>
    <li>Respecter nos obligations légales</li>
</ul>

<h2>Base Légale</h2>
<p>Le traitement de vos données repose sur :</p>
<ul>
    <li>L'exécution d'une mission d'intérêt public (services e-gouvernement)</li>
    <li>Votre consentement pour certains traitements spécifiques</li>
    <li>Le respect d'obligations légales</li>
</ul>

<h2>Durée de Conservation</h2>
<ul>
    <li><strong>Données de compte</strong> : durée de l'utilisation du compte + 3 ans</li>
    <li><strong>Logs de connexion</strong> : 12 mois</li>
    <li><strong>Données de support</strong> : 5 ans après clôture du ticket</li>
</ul>

<h2>Vos Droits</h2>
<p>Conformément à la Loi n°2008-12, vous disposez des droits suivants :</p>
<ul>
    <li><strong>Droit d'accès</strong> : obtenir une copie de vos données</li>
    <li><strong>Droit de rectification</strong> : corriger des données inexactes</li>
    <li><strong>Droit à l'effacement</strong> : demander la suppression de vos données</li>
    <li><strong>Droit d'opposition</strong> : vous opposer au traitement de vos données</li>
</ul>
<p>Pour exercer ces droits, contactez : <a href="mailto:dpo@egov.sn">dpo@egov.sn</a></p>

<h2>Sécurité</h2>
<p>Nous mettons en œuvre des mesures techniques et organisationnelles appropriées :</p>
<ul>
    <li>Chiffrement des données en transit (SSL/TLS)</li>
    <li>Authentification forte pour l'accès aux services</li>
    <li>Surveillance et journalisation des accès</li>
</ul>

<h2>Réclamation</h2>
<p>Vous pouvez adresser une réclamation à la <strong>Commission des Données Personnelles (CDP)</strong> du Sénégal : <a href="mailto:contact@cdp.sn">contact@cdp.sn</a></p>

<p><em>Dernière mise à jour : Décembre 2025</em></p>
HTML;

// ============================================
// PAGE 3: CONDITIONS D'UTILISATION
// ============================================
$conditions_utilisation = <<<HTML
<h2>Objet</h2>
<p>Les présentes Conditions Générales d'Utilisation (CGU) régissent l'accès et l'utilisation de la plateforme <strong>Jokkoo</strong>, Plateforme Nationale d'Interopérabilité du Sénégal. En accédant à la plateforme, vous acceptez sans réserve les présentes conditions.</p>

<h2>Définitions</h2>
<ul>
    <li><strong>Plateforme</strong> : désigne le site web Jokkoo et l'ensemble des services associés</li>
    <li><strong>Utilisateur</strong> : toute personne accédant à la plateforme</li>
    <li><strong>Partenaire</strong> : administration publique ou organisme connecté à la plateforme</li>
    <li><strong>API</strong> : interface de programmation permettant l'échange de données</li>
</ul>

<h2>Accès à la Plateforme</h2>
<p>La plateforme Jokkoo est accessible gratuitement à tout utilisateur disposant d'un accès Internet. Certains services nécessitent la création d'un compte.</p>
<p>L'État du Sénégal se réserve le droit de suspendre ou restreindre l'accès pour des raisons de maintenance ou de sécurité.</p>

<h2>Création de Compte</h2>
<p>Vous êtes responsable de :</p>
<ul>
    <li>La confidentialité de vos identifiants de connexion</li>
    <li>Toutes les activités effectuées depuis votre compte</li>
    <li>Signaler immédiatement toute utilisation non autorisée</li>
</ul>

<h2>Utilisation des Services</h2>
<p>L'utilisateur s'engage à ne pas :</p>
<ul>
    <li>Tenter d'accéder de manière non autorisée aux systèmes</li>
    <li>Effectuer des actions susceptibles de nuire au fonctionnement</li>
    <li>Utiliser les services à des fins illicites ou frauduleuses</li>
    <li>Transmettre des virus ou codes malveillants</li>
    <li>Surcharger les serveurs par des requêtes excessives</li>
</ul>

<h2>Propriété Intellectuelle</h2>
<p>Tous les éléments de la plateforme sont protégés par les droits de propriété intellectuelle. Sauf autorisation expresse, toute reproduction est interdite.</p>

<h2>Responsabilité</h2>
<p>L'État s'efforce d'assurer la disponibilité et la fiabilité de la plateforme mais ne garantit pas l'absence d'erreurs ou d'interruptions.</p>

<h2>Suspension et Résiliation</h2>
<p>L'État peut suspendre l'accès en cas de non-respect des CGU, utilisation frauduleuse ou atteinte à la sécurité.</p>

<h2>Droit Applicable</h2>
<p>Les présentes CGU sont régies par le droit sénégalais. Tout litige sera soumis aux tribunaux de Dakar.</p>

<h2>Contact</h2>
<p>Email : <a href="mailto:legal@egov.sn">legal@egov.sn</a></p>

<p><em>Dernière mise à jour : Décembre 2025</em></p>
HTML;

// ============================================
// PAGE 4: ACCESSIBILITÉ
// ============================================
$accessibilite = <<<HTML
<h2>Notre Engagement</h2>
<p>La plateforme <strong>Jokkoo</strong> s'engage à rendre ses services numériques accessibles à tous les citoyens sénégalais, y compris les personnes en situation de handicap. Cette démarche s'inscrit dans le cadre de la <strong>Stratégie Sénégal Numérique 2025</strong>.</p>

<h2>Niveau d'Accessibilité Visé</h2>
<ul>
    <li><strong>WCAG 2.1</strong> (Web Content Accessibility Guidelines) - Niveau AA</li>
    <li><strong>RGAA</strong> (Référentiel Général d'Amélioration de l'Accessibilité)</li>
</ul>

<h2>Mesures d'Accessibilité</h2>

<h3>Navigation</h3>
<ul>
    <li>Navigation possible entièrement au clavier</li>
    <li>Liens d'évitement pour accéder directement au contenu</li>
    <li>Structure de titres cohérente (H1, H2, H3...)</li>
    <li>Fil d'Ariane pour faciliter l'orientation</li>
</ul>

<h3>Contenu</h3>
<ul>
    <li>Textes alternatifs pour toutes les images</li>
    <li>Contrastes de couleurs suffisants</li>
    <li>Taille de police ajustable</li>
    <li>Langage clair et simple</li>
</ul>

<h3>Formulaires</h3>
<ul>
    <li>Labels associés à tous les champs</li>
    <li>Messages d'erreur explicites</li>
</ul>

<h3>Multimédia</h3>
<ul>
    <li>Sous-titres pour les vidéos</li>
    <li>Transcriptions textuelles disponibles</li>
</ul>

<h2>Technologies Compatibles</h2>
<ul>
    <li>HTML5 sémantique</li>
    <li>Compatibilité avec les lecteurs d'écran (NVDA, JAWS, VoiceOver)</li>
    <li>Chrome, Firefox, Edge, Safari (dernières versions)</li>
</ul>

<h2>Signaler un Problème</h2>
<p>Si vous rencontrez un problème d'accessibilité :</p>
<ul>
    <li><strong>Email</strong> : <a href="mailto:accessibilite@egov.sn">accessibilite@egov.sn</a></li>
    <li><strong>Formulaire</strong> : <a href="/contact">Page Contact</a></li>
</ul>

<h2>Voie de Recours</h2>
<p>En cas de réponse non satisfaisante, contactez le Ministère de la Communication, des Télécommunications et du Numérique.</p>

<p><em>Déclaration établie en Décembre 2025</em></p>
HTML;

// ============================================
// PAGE 5: PLAN DU SITE
// ============================================
$plan_site = <<<HTML
<h2>Navigation Principale</h2>

<h3>🏠 Accueil</h3>
<ul>
    <li><a href="/">Page d'accueil</a></li>
</ul>

<h3>ℹ️ À Propos</h3>
<ul>
    <li><a href="/presentation-du-projet">Présentation du projet Jokkoo</a></li>
</ul>

<h3>⚙️ Services</h3>
<ul>
    <li><a href="/services">Catalogue des services</a></li>
</ul>

<h3>📋 Cadres et Standards</h3>
<ul>
    <li><a href="/cadre-et-standard">Documentation technique</a></li>
</ul>

<h3>📊 Tableau de Bord</h3>
<ul>
    <li><a href="/tableau-de-bord">Statistiques et indicateurs</a></li>
</ul>

<h3>📞 Contact</h3>
<ul>
    <li><a href="/contact">Formulaire de contact</a></li>
</ul>

<h2>Ressources</h2>

<h3>📄 Publications</h3>
<ul>
    <li><a href="/publications">Documents et rapports</a></li>
</ul>

<h3>📰 Actualités</h3>
<ul>
    <li><a href="/actualites">Dernières nouvelles</a></li>
</ul>

<h3>🎬 Vidéos & Podcast</h3>
<ul>
    <li><a href="/videos-podcast">Contenu multimédia</a></li>
</ul>

<h2>Informations Légales</h2>
<ul>
    <li><a href="/mentions-legales">Mentions légales</a></li>
    <li><a href="/politique-confidentialite">Politique de confidentialité</a></li>
    <li><a href="/conditions-utilisation">Conditions d'utilisation</a></li>
    <li><a href="/accessibilite">Accessibilité</a></li>
    <li><a href="/plan-du-site">Plan du site</a> (cette page)</li>
</ul>

<h2>Aide</h2>
<ul>
    <li><a href="/contact">Support technique</a></li>
    <li><a href="mailto:contact@egov.sn">Email : contact@egov.sn</a></li>
    <li>Téléphone : +221 33 XXX XX XX</li>
</ul>
HTML;

// ============================================
// CRÉATION DES PAGES
// ============================================

$pages = [
    [
        'title' => 'Mentions Légales',
        'body' => $mentions_legales,
        'path' => '/mentions-legales',
    ],
    [
        'title' => 'Politique de Confidentialité',
        'body' => $politique_confidentialite,
        'path' => '/politique-confidentialite',
    ],
    [
        'title' => 'Conditions d\'Utilisation',
        'body' => $conditions_utilisation,
        'path' => '/conditions-utilisation',
    ],
    [
        'title' => 'Accessibilité',
        'body' => $accessibilite,
        'path' => '/accessibilite',
    ],
    [
        'title' => 'Plan du Site',
        'body' => $plan_site,
        'path' => '/plan-du-site',
    ],
];

echo "=== Création des pages légales ===\n\n";

foreach ($pages as $page_data) {
    // Vérifier si la page existe déjà
    $existing = \Drupal::entityTypeManager()
        ->getStorage('node')
        ->loadByProperties(['title' => $page_data['title'], 'type' => 'page']);
    
    if (!empty($existing)) {
        echo "⚠️  Page '{$page_data['title']}' existe déjà (ignorée)\n";
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
        'status' => 1, // Publié
        'langcode' => 'fr',
        'uid' => 1,
    ]);
    
    $node->save();
    
    // Définir l'alias d'URL
    \Drupal::service('path_alias.manager')->create(
        '/node/' . $node->id(),
        $page_data['path'],
        'fr'
    );
    
    echo "✅ Page créée : {$page_data['title']} → {$page_data['path']} (node/{$node->id()})\n";
}

echo "\n=== Terminé ===\n";
echo "N'oubliez pas de vider le cache : drush cr\n";
