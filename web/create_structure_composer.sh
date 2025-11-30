#!/bin/bash

# Script eGov Homepage adapté pour structure Composer + root user
# À exécuter depuis /var/www/html/drupal/web/

echo "🚀 Création de la structure eGov Homepage (version Composer)..."

# Couleurs
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Vérifier qu'on est dans le bon répertoire
if [ ! -f "index.php" ] || [ ! -d "core" ] || [ ! -d "modules" ]; then
    echo -e "${RED}❌ ERREUR: Vous n'êtes pas dans la racine Drupal${NC}"
    echo -e "${YELLOW}📍 Positionnez-vous dans le dossier 'web/' d'abord :${NC}"
    echo "cd /var/www/html/drupal/web/"
    echo "puis relancez ce script"
    exit 1
fi

echo -e "${GREEN}✅ Position correcte détectée (dossier web/)${NC}"

# 1. MODULE CUSTOM
echo -e "${BLUE}📁 Création du module custom...${NC}"

mkdir -p modules/custom/egov_homepage/config/install
mkdir -p modules/custom/egov_homepage/config/schema
mkdir -p modules/custom/egov_homepage/src/Form
mkdir -p modules/custom/egov_homepage/src/Controller
mkdir -p modules/custom/egov_homepage/templates/content
mkdir -p modules/custom/egov_homepage/templates/paragraphs
mkdir -p modules/custom/egov_homepage/css
mkdir -p modules/custom/egov_homepage/js

echo -e "${GREEN}✅ Structure du module créée${NC}"

# 2. THÈME CUSTOM
echo -e "${BLUE}🎨 Configuration du thème...${NC}"

# Vérifier si egov_theme existe déjà
if [ -d "themes/custom/egov_theme" ]; then
    THEME_PATH="themes/custom/egov_theme"
    echo -e "${GREEN}✅ Thème egov_theme trouvé${NC}"
elif [ -d "../egov_theme" ]; then
    echo -e "${YELLOW}⚠️  Thème trouvé hors structure Drupal${NC}"
    echo -e "${YELLOW}📁 Création de la structure dans themes/custom/${NC}"
    THEME_PATH="themes/custom/egov_theme"
    mkdir -p "$THEME_PATH"
else
    echo -e "${BLUE}📁 Création du thème egov_theme${NC}"
    THEME_PATH="themes/custom/egov_theme"
    mkdir -p "$THEME_PATH"
fi

# Structure du thème
mkdir -p "$THEME_PATH/templates/content"
mkdir -p "$THEME_PATH/templates/paragraphs"
mkdir -p "$THEME_PATH/templates/blocks"
mkdir -p "$THEME_PATH/css"
mkdir -p "$THEME_PATH/js"
mkdir -p "$THEME_PATH/images/icons"

echo -e "${GREEN}✅ Structure du thème créée : $THEME_PATH${NC}"

# 3. CONFIGURATION
echo -e "${BLUE}⚙️ Configuration Drupal...${NC}"

# Config dans le projet Drupal
mkdir -p ../config/sync
mkdir -p ../config/install

echo -e "${GREEN}✅ Dossiers de configuration créés${NC}"

# 4. MÉDIA
echo -e "${BLUE}📁 Dossiers média...${NC}"

mkdir -p sites/default/files/icons
mkdir -p sites/default/files/images/homepage

echo -e "${GREEN}✅ Dossiers média créés${NC}"

# 5. PERMISSIONS (adaptation pour root)
echo -e "${BLUE}🔐 Configuration des permissions...${NC}"

# Permissions pour www-data (utilisateur web)
chown -R www-data:www-data modules/custom/egov_homepage
chown -R www-data:www-data "$THEME_PATH"
chown -R www-data:www-data sites/default/files/
chown -R www-data:www-data ../config/

# Permissions d'écriture
chmod -R 755 modules/custom/egov_homepage
chmod -R 755 "$THEME_PATH"
chmod -R 775 sites/default/files/
chmod -R 755 ../config/

echo -e "${GREEN}✅ Permissions configurées pour www-data${NC}"

# 6. RÉSUMÉ
echo -e "\n${BLUE}📋 Structure créée avec succès :${NC}"
echo "
📦 /var/www/html/drupal/
├── web/                              ← (position actuelle)
│   ├── modules/custom/egov_homepage/ ← Module custom
│   ├── themes/custom/egov_theme/     ← Templates
│   └── sites/default/files/          ← Média
└── config/                           ← Configuration
    ├── sync/
    └── install/
"

# 7. FICHIER DE STATUT
cat > egov_homepage_status.txt << EOF
# eGov Homepage - Status (Structure Composer)
Date : $(date)
Position : $(pwd)
Structure : ✅ Créée
Module : modules/custom/egov_homepage/
Thème : $THEME_PATH
Permissions : ✅ www-data

Prochaines étapes :
1. Installer modules : drush en paragraphs field_group -y
2. Créer fichiers de configuration  
3. Créer templates
4. Tester interface admin
EOF

echo -e "${GREEN}📄 Status sauvé : egov_homepage_status.txt${NC}"

# 8. VÉRIFICATION RAPIDE
echo -e "\n${BLUE}🔍 Vérification rapide :${NC}"

ERRORS=0

if [ ! -d "modules/custom/egov_homepage" ]; then
    echo -e "${RED}❌ Module non créé${NC}"
    ERRORS=$((ERRORS + 1))
else
    echo -e "${GREEN}✅ Module créé${NC}"
fi

if [ ! -d "$THEME_PATH/templates" ]; then
    echo -e "${RED}❌ Templates thème non créés${NC}" 
    ERRORS=$((ERRORS + 1))
else
    echo -e "${GREEN}✅ Templates thème créés${NC}"
fi

if [ ! -d "../config/sync" ]; then
    echo -e "${RED}❌ Config sync non créé${NC}"
    ERRORS=$((ERRORS + 1))
else
    echo -e "${GREEN}✅ Config sync créé${NC}"
fi

if [ $ERRORS -eq 0 ]; then
    echo -e "\n${GREEN}🎉 SUCCÈS TOTAL ! Structure prête pour la suite${NC}"
    echo -e "${BLUE}📝 Prochaine étape : Installation des modules Drupal${NC}"
else
    echo -e "\n${YELLOW}⚠️  $ERRORS erreur(s) détectée(s) - vérifiez les permissions${NC}"
fi

echo -e "\n${BLUE}💡 Pour vérifier en détail, lancez :${NC}"
echo "./verify_structure_composer.sh"
