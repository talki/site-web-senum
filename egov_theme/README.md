# E-Gov Theme - Thème Drupal pour la Plateforme d'Interopérabilité du Sénégal

## Description
Thème personnalisé pour la plateforme nationale d'interopérabilité du Sénégal. Ce thème reproduit fidèlement le design fourni avec les couleurs du drapeau sénégalais.

## Installation

### 1. Copier le thème
Copiez le dossier `egov_theme` dans le répertoire des thèmes custom de Drupal:
```bash
cp -r /home/claude/egov_theme /chemin/vers/drupal/themes/custom/
```

### 2. Définir les permissions
```bash
cd /chemin/vers/drupal/themes/custom/egov_theme
chown -R www-data:www-data .
chmod -R 755 .
```

### 3. Activer le thème
```bash
# Via Drush
drush theme:enable egov_theme
drush config-set system.theme default egov_theme -y

# Ou via l'interface Drupal
# Allez dans Apparence > Installer et définir par défaut
```

### 4. Vider le cache
```bash
drush cr
# Ou: Drupal > Configuration > Développement > Performance > Vider tous les caches
```

## Structure du thème

```
egov_theme/
├── css/
│   └── style.css          # Tous les styles CSS
├── js/
│   └── script.js          # Animations et interactions JavaScript
├── templates/
│   ├── page.html.twig     # Template de page par défaut
│   └── page--front.html.twig  # Template de la page d'accueil
├── egov_theme.info.yml    # Configuration du thème
├── egov_theme.libraries.yml  # Définition des assets CSS/JS
└── README.md              # Ce fichier
```

## Fonctionnalités

### Design
- Couleurs du drapeau sénégalais (vert, jaune, rouge)
- Design moderne et responsive
- Animations fluides au scroll
- Hero section avec call-to-action
- Statistiques animées
- Grille de services
- Cas d'usage
- Bénéfices
- Sidebar avec actualités et widgets
- Footer complet

### Responsive
- Adapté pour mobile, tablette et desktop
- Breakpoints: 640px, 968px, 1100px, 1200px, 1400px

### Animations
- Animation des cartes au scroll
- Compteurs animés pour les statistiques
- Transitions fluides
- Effets hover interactifs

## Personnalisation

### Couleurs
Les couleurs sont définies dans les variables CSS (`:root` dans style.css):
```css
--senegal-green: #00853F;
--senegal-yellow: #FCD116;
--senegal-red: #E31B23;
```

### Contenu
Pour modifier le contenu de la page d'accueil, éditez:
- `templates/page--front.html.twig`

Pour le menu et le footer sur toutes les pages:
- `templates/page.html.twig`

## Configuration Drupal

### Régions disponibles
- header
- primary_menu
- secondary_menu
- breadcrumb
- highlighted
- help
- content
- sidebar_first
- sidebar_second
- footer
- page_top
- page_bottom

### Page d'accueil
Pour que le template `page--front.html.twig` fonctionne:
1. Allez dans Configuration > Système > Informations du site
2. Vérifiez que "Page d'accueil par défaut" est configurée
3. Visitez la page d'accueil

## Support
Pour toute question ou problème:
- Email: contact@interop.sn
- Tél: +221 33 XXX XX XX

## Licence
© 2025 MCTN/SENUM - République du Sénégal

---

Développé dans le cadre du New Deal Technologique
