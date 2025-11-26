#!/bin/bash

echo "🚨 REVERT D'URGENCE - ANNULATION DES MODIFICATIONS"
echo "================================================="
echo ""

cd /var/www/html/drupal

echo "1️⃣ Restauration du format HTML full_html..."

# Restaurer le format full_html à sa configuration par défaut
./vendor/bin/drush php-eval "
\$format = \Drupal::entityTypeManager()->getStorage('filter_format')->load('full_html');
if (\$format) {
  \$filters = [
    'filter_align' => [
      'id' => 'filter_align',
      'provider' => 'filter',
      'status' => TRUE,
      'weight' => 8,
      'settings' => [],
    ],
    'filter_caption' => [
      'id' => 'filter_caption',
      'provider' => 'filter',
      'status' => TRUE,
      'weight' => 9,
      'settings' => [],
    ],
    'filter_html' => [
      'id' => 'filter_html',
      'provider' => 'filter',
      'status' => TRUE,
      'weight' => -10,
      'settings' => [
        'allowed_html' => '<a href hreflang> <em> <strong> <cite> <blockquote cite> <code> <ul type> <ol start type> <li> <dl> <dt> <dd> <h2 id> <h3 id> <h4 id> <h5 id> <h6 id> <p> <br> <span> <img src alt height width data-entity-type data-entity-uuid data-align data-caption> <drupal-media data-entity-type data-entity-uuid data-align data-caption>',
        'filter_html_help' => TRUE,
        'filter_html_nofollow' => FALSE,
      ],
    ],
    'filter_htmlcorrector' => [
      'id' => 'filter_htmlcorrector',
      'provider' => 'filter',
      'status' => TRUE,
      'weight' => 10,
      'settings' => [],
    ],
    'filter_html_image_secure' => [
      'id' => 'filter_html_image_secure',
      'provider' => 'filter',
      'status' => TRUE,
      'weight' => 9,
      'settings' => [],
    ],
    'filter_autop' => [
      'id' => 'filter_autop',
      'provider' => 'filter',
      'status' => TRUE,
      'weight' => 0,
      'settings' => [],
    ],
    'filter_url' => [
      'id' => 'filter_url',
      'provider' => 'filter',
      'status' => TRUE,
      'weight' => 0,
      'settings' => [
        'filter_url_length' => 72,
      ],
    ],
  ];
  \$format->set('filters', \$filters);
  \$format->save();
  echo '✅ Format full_html restauré à la configuration par défaut' . PHP_EOL;
} else {
  echo '❌ Format full_html non trouvé' . PHP_EOL;
}
"

echo ""
echo "2️⃣ Restauration du contenu original de la page..."

# Restaurer le contenu original simple
cat > /tmp/page_original_simple.html << 'ENDHTML'
<h1>Présentation Vidéo de la Plateforme</h1>

<p>Cette page présente la Plateforme Nationale d'Interopérabilité du Sénégal.</p>

<div style="background: #f8f9fa; padding: 20px; border-radius: 8px; margin: 20px 0;">
    <h2>🎥 Vidéo de Présentation</h2>
    <p>Pour voir la vidéo de présentation, veuillez visiter notre chaîne YouTube officielle.</p>
    
    <div style="text-align: center; margin: 20px 0;">
        <a href="https://youtube.com" target="_blank" style="display: inline-block; background: #dc3545; color: white; padding: 12px 24px; text-decoration: none; border-radius: 5px; font-weight: bold;">
            ▶️ Voir la Vidéo sur YouTube
        </a>
    </div>
</div>

<h2>📚 À propos de la Plateforme</h2>

<p>La Plateforme Nationale d'Interopérabilité du Sénégal est un projet phare du New Deal Technologique porté par le Ministère de la Communication, des Télécommunications et du Numérique (MCTN).</p>

<h3>🎯 Objectifs Principaux :</h3>
<ul>
    <li>Transformation digitale des services publics</li>
    <li>Interopérabilité entre les systèmes d'information</li>
    <li>Amélioration de l'efficacité administrative</li>
    <li>Facilitation des démarches pour les citoyens</li>
</ul>

<h3>📊 Impact Attendu :</h3>
<ul>
    <li>Réduction des délais de traitement</li>
    <li>Diminution des coûts administratifs</li>
    <li>Amélioration de la transparence</li>
    <li>Modernisation de l'État</li>
</ul>

<div style="background: #e8f5e8; padding: 15px; border-radius: 5px; margin: 20px 0;">
    <strong>📞 Contact :</strong><br>
    Pour plus d'informations, contactez le Ministère de la Communication, des Télécommunications et du Numérique.
</div>
ENDHTML

# Restaurer la page
./vendor/bin/drush php-eval "
\$html = file_get_contents('/tmp/page_original_simple.html');

// Essayer de trouver la page par ID 12
\$node = \Drupal::entityTypeManager()->getStorage('node')->load(12);
if (!\$node) {
  // Si pas trouvée par ID, chercher par titre
  \$query = \Drupal::entityQuery('node')
    ->condition('type', 'page')
    ->condition('title', 'Vidéo', 'CONTAINS')
    ->execute();
  
  if (!empty(\$query)) {
    \$nid = array_shift(\$query);
    \$node = \Drupal::entityTypeManager()->getStorage('node')->load(\$nid);
  }
}

if (\$node) {
  \$node->set('body', [
    'value' => \$html,
    'format' => 'full_html',
  ]);
  \$node->save();
  echo '✅ Page restaurée avec contenu simple (ID: ' . \$node->id() . ')' . PHP_EOL;
} else {
  echo '❌ Page non trouvée pour la restauration!' . PHP_EOL;
}
"

echo ""
echo "3️⃣ Vérification et nettoyage des configurations..."

# Vérifier que les modules de base fonctionnent
./vendor/bin/drush php-eval "
echo 'Vérification des modules essentiels...' . PHP_EOL;
\$modules = ['node', 'system', 'user', 'filter'];
foreach (\$modules as \$module) {
  if (\Drupal::moduleHandler()->moduleExists(\$module)) {
    echo '✅ ' . \$module . ' : OK' . PHP_EOL;
  } else {
    echo '❌ ' . \$module . ' : MANQUANT!' . PHP_EOL;
  }
}
"

echo ""
echo "4️⃣ Nettoyage intensif du cache..."

# Nettoyage complet
./vendor/bin/drush cr
./vendor/bin/drush cc all 2>/dev/null || true

echo ""
echo "5️⃣ Test de fonctionnement..."

# Test de base de Drupal
./vendor/bin/drush status | head -10

echo ""
echo "6️⃣ Suppression des fichiers temporaires..."

# Nettoyer les fichiers créés
rm -f /tmp/video_*.html
rm -f /tmp/page_*.html

echo ""
echo "🎉 REVERT TERMINÉ !"
echo "=================="
echo ""
echo "✅ Actions effectuées :"
echo "   • Format HTML restauré à la configuration par défaut"
echo "   • Page restaurée avec contenu simple et sûr"
echo "   • Cache nettoyé complètement"
echo "   • Fichiers temporaires supprimés"
echo ""
echo "🔍 Vérifiez maintenant :"
echo "   1. Votre site fonctionne : https://egov.pexone.com"
echo "   2. La page vidéo : https://egov.pexone.com/video-de-presentation-0"
echo "   3. L'administration : https://egov.pexone.com/admin"
echo ""
echo "⚠️  Si des problèmes persistent :"
echo "   • Vérifiez les logs : ./vendor/bin/drush ws"
echo "   • Contactez votre administrateur système"
echo ""
echo "💡 Pour la vidéo YouTube :"
echo "   • Utilisez le système Media natif de Drupal"
echo "   • Évitez les iframes directes pour la sécurité"
echo "   • Suivez les bonnes pratiques Drupal"

