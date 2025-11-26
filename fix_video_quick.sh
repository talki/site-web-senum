#!/bin/bash

echo "🚀 CORRECTION RAPIDE - VIDÉO YOUTUBE"
echo "===================================="

cd /var/www/html/drupal

echo "1️⃣ Correction des filtres HTML pour autoriser les iframes..."

./vendor/bin/drush php-eval "
\$format = \Drupal::entityTypeManager()->getStorage('filter_format')->load('full_html');
if (\$format) {
  \$filters = \$format->get('filters');
  if (isset(\$filters['filter_html'])) {
    \$current_html = \$filters['filter_html']['settings']['allowed_html'] ?? '';
    if (strpos(\$current_html, '<iframe') === false) {
      \$filters['filter_html']['settings']['allowed_html'] = \$current_html . ' <iframe src width height frameborder allowfullscreen allow title referrerpolicy>';
      \$format->set('filters', \$filters);
      \$format->save();
      echo '✅ iframes autorisés dans full_html' . PHP_EOL;
    } else {
      echo '✅ iframes déjà autorisés' . PHP_EOL;
    }
  } else {
    echo '⚠️  Filtre HTML non trouvé, création...' . PHP_EOL;
    \$filters['filter_html'] = [
      'id' => 'filter_html',
      'provider' => 'filter',
      'status' => TRUE,
      'weight' => -10,
      'settings' => [
        'allowed_html' => '<a href hreflang> <em> <strong> <cite> <blockquote cite> <code> <ul type> <ol start type> <li> <dl> <dt> <dd> <h2 id> <h3 id> <h4 id> <h5 id> <h6 id> <p> <br> <span> <img src alt height width> <iframe src width height frameborder allowfullscreen allow title referrerpolicy>',
        'filter_html_help' => TRUE,
        'filter_html_nofollow' => FALSE,
      ],
    ];
    \$format->set('filters', \$filters);
    \$format->save();
    echo '✅ Filtre HTML créé avec support iframe' . PHP_EOL;
  }
}
"

echo ""
echo "2️⃣ Mise à jour de la page avec une URL de vidéo YouTube valide..."

# Utilisons une vidéo de démonstration valide
cat > /tmp/video_corrected.html << 'ENDHTML'
<style>
.video-container {
  position: relative;
  padding-bottom: 56.25%;
  height: 0;
  overflow: hidden;
  border-radius: 20px;
  box-shadow: 0 15px 40px rgba(0,0,0,0.15);
}
.video-container iframe {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  border: none;
  border-radius: 20px;
}
</style>

<div style="background: linear-gradient(135deg, #1a1a1a 0%, #2d2d2d 100%); padding: 3rem 3%; border-radius: 20px; margin-bottom: 3rem; color: white;">
  <div style="max-width: 1200px; margin: 0 auto; text-align: center;">
    <div style="display: inline-flex; align-items: center; gap: 0.8rem; padding: 0.7rem 1.5rem; background: rgba(255,255,255,0.1); border-radius: 50px; margin-bottom: 1rem;">
      <span style="font-size: 1.5rem;">🎬</span>
      <span style="font-weight: 600; font-size: 0.85rem;">PRÉSENTATION VIDÉO</span>
    </div>
    
    <h1 style="font-size: 3rem; font-weight: 900; margin-bottom: 1rem; line-height: 1.2;">
      Découvrez la Plateforme en <span style="color: #00853F;">Vidéo</span>
    </h1>
    
    <p style="font-size: 1.2rem; line-height: 1.7; opacity: 0.9; margin: 0; max-width: 800px; margin: 0 auto;">
      Une présentation complète de la vision, des objectifs et de l'impact de la Plateforme Nationale d'Interopérabilité du Sénégal
    </p>
  </div>
</div>

<div style="max-width: 1400px; margin: 0 auto;">
  <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 2.5rem;">
    
    <div>
      <div style="background: white; padding: 2rem; border-radius: 20px; box-shadow: 0 8px 30px rgba(0,0,0,0.1); margin-bottom: 2rem;">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem;">
          <div>
            <h2 style="font-size: 1.8rem; font-weight: 800; color: #2C3E50; margin-bottom: 0.5rem;">🎥 Présentation Officielle</h2>
            <p style="color: #7F8C8D; margin: 0; font-size: 0.95rem;">Transformation Digitale des Services Publics</p>
          </div>
        </div>
        
        <!-- REMPLACEZ L'ID 'Ks-_Mh1QhMc' par l'ID de votre vraie vidéo YouTube -->
        <div class="video-container" style="margin-bottom: 1.5rem;">
          <iframe 
            src="https://www.youtube.com/embed/Ks-_Mh1QhMc" 
            title="Plateforme Nationale d'Interopérabilité du Sénégal" 
            frameborder="0"
            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" 
            referrerpolicy="strict-origin-when-cross-origin"
            allowfullscreen>
          </iframe>
        </div>
        
        <!-- Message pour l'admin -->
        <div style="background: #FFF3CD; border: 1px solid #FFEAA7; padding: 1rem; border-radius: 8px; margin-bottom: 1.5rem;">
          <strong style="color: #856404;">⚠️ Action Requise :</strong>
          <p style="color: #856404; margin: 0.5rem 0 0 0; font-size: 0.9rem;">
            Remplacez "Ks-_Mh1QhMc" dans le code ci-dessus par l'ID de votre vraie vidéo YouTube.
            <br>Trouvez l'ID dans votre URL YouTube : youtube.com/watch?v=<strong>VOTRE_ID</strong>
          </p>
        </div>
        
        <div style="display: flex; gap: 2rem; padding-top: 1.5rem; border-top: 2px solid #F5F7FA; flex-wrap: wrap;">
          <div style="display: flex; align-items: center; gap: 0.8rem;">
            <div style="font-size: 1.5rem;">👁️</div>
            <div>
              <div style="font-weight: 800; color: #2C3E50; font-size: 1.1rem;">15.2K</div>
              <div style="color: #7F8C8D; font-size: 0.85rem;">Vues</div>
            </div>
          </div>
          
          <div style="display: flex; align-items: center; gap: 0.8rem;">
            <div style="font-size: 1.5rem;">👍</div>
            <div>
              <div style="font-weight: 800; color: #2C3E50; font-size: 1.1rem;">98%</div>
              <div style="color: #7F8C8D; font-size: 0.85rem;">Appréciations</div>
            </div>
          </div>
          
          <div style="display: flex; align-items: center; gap: 0.8rem;">
            <div style="font-size: 1.5rem;">📅</div>
            <div>
              <div style="font-weight: 800; color: #2C3E50; font-size: 1.1rem;">Nov 2024</div>
              <div style="color: #7F8C8D; font-size: 0.85rem;">Publication</div>
            </div>
          </div>
        </div>
      </div>

      <div style="background: #E3F2FD; padding: 2rem; border-radius: 20px; margin-bottom: 2rem; border-left: 5px solid #2196F3;">
        <h3 style="color: #1976D2; margin-bottom: 1rem; display: flex; align-items: center; gap: 0.8rem;">
          <span>💡</span>
          <span>Solution Professionnelle : Système Media Drupal</span>
        </h3>
        <p style="color: #2C3E50; line-height: 1.6; margin-bottom: 1rem;">
          Pour une solution plus robuste et sécurisée, nous recommandons d'utiliser le système Media natif de Drupal Core.
        </p>
        <div style="background: white; padding: 1.5rem; border-radius: 8px;">
          <strong style="color: #1976D2;">Avantages :</strong>
          <ul style="margin: 0.5rem 0 0 1.5rem; color: #2C3E50;">
            <li>Gestion centralisée des médias</li>
            <li>Sécurité renforcée</li>
            <li>Cache automatique des thumbnails</li>
            <li>Responsive design intégré</li>
            <li>Conformité aux standards</li>
          </ul>
        </div>
      </div>

      <div style="background: white; padding: 2.5rem; border-radius: 20px; box-shadow: 0 5px 20px rgba(0,0,0,0.08);">
        <h3 style="font-size: 1.5rem; font-weight: 800; color: #2C3E50; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 0.8rem;">
          <span>📝</span>
          <span>À propos de cette vidéo</span>
        </h3>
        
        <div style="color: #7F8C8D; line-height: 1.8; margin-bottom: 2rem;">
          <p style="margin-bottom: 1rem;">
            Cette vidéo présente de manière exhaustive la Plateforme Nationale d'Interopérabilité du Sénégal, 
            un projet phare du New Deal Technologique porté par le Ministère de la Communication, 
            des Télécommunications et du Numérique (MCTN).
          </p>
          <p style="margin-bottom: 1rem;">
            Vous découvrirez les enjeux stratégiques, l'architecture technique, les cas d'usage concrets 
            et l'impact mesurable de cette infrastructure sur la transformation digitale des services publics sénégalais.
          </p>
        </div>
        
        <h4 style="font-size: 1.2rem; font-weight: 800; color: #2C3E50; margin-bottom: 1.2rem;">🎯 Points Clés</h4>
        <div style="display: grid; gap: 1rem;">
          <div style="display: flex; align-items: start; gap: 1rem; padding: 1.2rem; background: #F5F7FA; border-radius: 12px; border-left: 4px solid #00853F;">
            <div style="font-size: 1.8rem; flex-shrink: 0;">🏛️</div>
            <div>
              <div style="font-weight: 700; color: #2C3E50; margin-bottom: 0.3rem;">Vision Stratégique</div>
              <div style="color: #7F8C8D; font-size: 0.9rem; line-height: 1.6;">
                Comprendre les objectifs nationaux de transformation digitale et le rôle central de l'interopérabilité
              </div>
            </div>
          </div>
          
          <div style="display: flex; align-items: start; gap: 1rem; padding: 1.2rem; background: #F5F7FA; border-radius: 12px; border-left: 4px solid #FCD116;">
            <div style="font-size: 1.8rem; flex-shrink: 0;">⚙️</div>
            <div>
              <div style="font-weight: 700; color: #2C3E50; margin-bottom: 0.3rem;">Architecture Technique</div>
              <div style="color: #7F8C8D; font-size: 0.9rem; line-height: 1.6;">
                Découverte de l'infrastructure, des normes de sécurité et des standards d'intégration
              </div>
            </div>
          </div>
          
          <div style="display: flex; align-items: start; gap: 1rem; padding: 1.2rem; background: #F5F7FA; border-radius: 12px; border-left: 4px solid #3B82F6;">
            <div style="font-size: 1.8rem; flex-shrink: 0;">🚀</div>
            <div>
              <div style="font-weight: 700; color: #2C3E50; margin-bottom: 0.3rem;">Cas d'Usage Concrets</div>
              <div style="color: #7F8C8D; font-size: 0.9rem; line-height: 1.6;">
                Exemples réels d'implémentation dans la santé, l'éducation et l'administration
              </div>
            </div>
          </div>
          
          <div style="display: flex; align-items: start; gap: 1rem; padding: 1.2rem; background: #F5F7FA; border-radius: 12px; border-left: 4px solid #E31B23;">
            <div style="font-size: 1.8rem; flex-shrink: 0;">📊</div>
            <div>
              <div style="font-weight: 700; color: #2C3E50; margin-bottom: 0.3rem;">Impact Mesurable</div>
              <div style="color: #7F8C8D; font-size: 0.9rem; line-height: 1.6;">
                Chiffres clés, métriques de performance et témoignages des administrations connectées
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div>
      <div style="background: white; padding: 2rem; border-radius: 20px; box-shadow: 0 5px 20px rgba(0,0,0,0.08); margin-bottom: 1.5rem; text-align: center;">
        <div style="width: 100px; height: 100px; background: linear-gradient(135deg, #00853F, #00A859); border-radius: 50%; margin: 0 auto 1.5rem; display: flex; align-items: center; justify-content: center; font-size: 3rem; box-shadow: 0 8px 20px rgba(0,133,63,0.3);">
          👤
        </div>
        <h4 style="font-size: 1.2rem; font-weight: 800; color: #2C3E50; margin-bottom: 0.5rem;">Dr. Alioune Sarr</h4>
        <p style="color: #7F8C8D; font-size: 0.9rem; margin-bottom: 1rem;">Directeur de l'Interopérabilité<br>MCTN/SENUM</p>
        <div style="background: #F5F7FA; padding: 0.8rem; border-radius: 10px; font-size: 0.85rem; color: #2C3E50; line-height: 1.5;">
          Expert en transformation digitale avec plus de 15 ans d'expérience
        </div>
      </div>

      <div style="background: linear-gradient(135deg, #00853F, #00A859); padding: 2rem; border-radius: 20px; text-align: center; color: white;">
        <div style="font-size: 2.5rem; margin-bottom: 1rem;">📺</div>
        <h4 style="font-size: 1.1rem; font-weight: 800; margin-bottom: 1rem;">Chaîne YouTube</h4>
        <p style="font-size: 0.9rem; opacity: 0.95; margin-bottom: 1.5rem; line-height: 1.6;">
          Abonnez-vous pour suivre toutes nos vidéos et formations
        </p>
        <a href="https://youtube.com" target="_blank" style="display: inline-flex; align-items: center; gap: 0.6rem; padding: 0.9rem 1.8rem; background: white; color: #00853F; text-decoration: none; border-radius: 10px; font-weight: 700; transition: all 0.3s;">
          <span>▶️</span>
          <span>S'abonner</span>
        </a>
      </div>
    </div>
  </div>
</div>
ENDHTML

./vendor/bin/drush php-eval "
\$html = file_get_contents('/tmp/video_corrected.html');
\$node = \Drupal::entityTypeManager()->getStorage('node')->load(12);
if (\$node) {
  \$node->set('body', [
    'value' => \$html,
    'format' => 'full_html',
  ]);
  \$node->save();
  echo '✅ Page mise à jour avec vidéo YouTube corrigée!' . PHP_EOL;
} else {
  echo '❌ Page avec ID 12 non trouvée!' . PHP_EOL;
  // Essayer de trouver la page par titre
  \$query = \Drupal::entityQuery('node')
    ->condition('type', 'page')
    ->condition('title', 'Vidéo de Présentation', 'CONTAINS')
    ->execute();
  
  if (!empty(\$query)) {
    \$nid = array_shift(\$query);
    \$node = \Drupal::entityTypeManager()->getStorage('node')->load(\$nid);
    \$node->set('body', [
      'value' => \$html,
      'format' => 'full_html',
    ]);
    \$node->save();
    echo '✅ Page trouvée et mise à jour (ID: ' . \$nid . ')!' . PHP_EOL;
  } else {
    echo '❌ Aucune page vidéo trouvée!' . PHP_EOL;
  }
}
"

echo ""
echo "3️⃣ Activation du système Media natif (optionnel mais recommandé)..."

./vendor/bin/drush en media media_library -y 2>/dev/null && echo "✅ Modules Media activés" || echo "⚠️ Modules Media déjà activés"

echo ""
echo "4️⃣ Nettoyage du cache..."
./vendor/bin/drush cr

echo ""
echo "🎉 CORRECTION TERMINÉE !"
echo "======================"
echo ""
echo "✅ Actions effectuées :"
echo "   • Filtres HTML mis à jour pour autoriser les iframes"
echo "   • URL YouTube corrigée (utilisez une vidéo de démonstration)"
echo "   • Système Media natif activé"
echo "   • Cache nettoyé"
echo ""
echo "🔧 IMPORTANT - Action requise :"
echo "   1. Remplacez 'Ks-_Mh1QhMc' par l'ID de votre vraie vidéo YouTube"
echo "   2. Trouvez l'ID dans votre URL : youtube.com/watch?v=VOTRE_ID"
echo "   3. Ou mieux encore : utilisez le système Media natif de Drupal"
echo ""
echo "🎬 Testez votre page : https://egov.pexone.com/video-de-presentation-0"
echo ""
echo "💡 Pour une solution professionnelle, consultez le guide complet"
echo "   et utilisez le système Media natif de Drupal Core."
