i#!/bin/bash

# Script d'installation des modules pour eGov Homepage
# À exécuter depuis /var/www/html/drupal/

echo "📦 Installation des modules Drupal pour eGov Homepage..."

# Couleurs
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Vérifier la position (doit être à la racine du projet Composer)
if [ ! -f "composer.json" ] || [ ! -d "web" ]; then
    echo -e "${RED}❌ ERREUR: Exécutez depuis la racine du projet${NC}"
    echo -e "${YELLOW}📍 Position attendue : /var/www/html/drupal/${NC}"
    echo "cd /var/www/html/drupal/"
    exit 1
fi

echo -e "${GREEN}✅ Position correcte (racine Composer)${NC}"

# 1. MISE À JOUR DES DÉPENDANCES
echo -e "${BLUE}🔄 Mise à jour de Composer...${NC}"
composer update --no-dev --optimize-autoloader

# 2. INSTALLATION DES MODULES REQUIS
echo -e "${BLUE}📦 Installation des modules via Composer...${NC}"

# Modules essentiels
echo -e "${BLUE}📥 Paragraphs (composants flexibles)...${NC}"
composer require drupal/paragraphs

echo -e "${BLUE}📥 Field Group (organisation formulaires)...${NC}"
composer require drupal/field_group

echo -e "${BLUE}📥 Admin Toolbar (UX admin améliorée)...${NC}"
composer require drupal/admin_toolbar

# Modules optionnels mais recommandés
echo -e "${BLUE}📥 Pathauto (URLs automatiques)...${NC}"
composer require drupal/pathauto

echo -e "${BLUE}📥 Token (support pour pathauto)...${NC}"
composer require drupal/token

echo -e "${BLUE}📥 Entity Reference Revisions (pour paragraphs)...${NC}"
composer require drupal/entity_reference_revisions

# 3. ACTIVATION DES MODULES
echo -e "${BLUE}🔌 Activation des modules via Drush...${NC}"

# Vérifier que Drush fonctionne
if ! command -v ../drush &> /dev/null && ! command -v drush &> /dev/null; then
    echo -e "${YELLOW}⚠️  Drush non trouvé, utilisation de Drupal console...${NC}"
    DRUSH_CMD="php web/core/scripts/drupal"
else
    if [ -f "../drush" ]; then
        DRUSH_CMD="../drush"
    else
        DRUSH_CMD="drush"
    fi
fi

echo "Utilisation de : $DRUSH_CMD"

# Activation séquentielle pour éviter les dépendances
echo -e "${BLUE}🔌 Token...${NC}"
$DRUSH_CMD en token -y

echo -e "${BLUE}🔌 Entity Reference Revisions...${NC}"
$DRUSH_CMD en entity_reference_revisions -y

echo -e "${BLUE}🔌 Paragraphs...${NC}"
$DRUSH_CMD en paragraphs -y

echo -e "${BLUE}🔌 Field Group...${NC}"
$DRUSH_CMD en field_group -y

echo -e "${BLUE}🔌 Admin Toolbar...${NC}"
$DRUSH_CMD en admin_toolbar admin_toolbar_tools -y

echo -e "${BLUE}🔌 Pathauto...${NC}"
$DRUSH_CMD en pathauto -y

# 4. VIDER LES CACHES
echo -e "${BLUE}🧹 Nettoyage des caches...${NC}"
$DRUSH_CMD cr

# 5. VÉRIFICATION DES MODULES
echo -e "${BLUE}🔍 Vérification de l'installation...${NC}"

MODULES_CHECK=("paragraphs" "field_group" "admin_toolbar" "pathauto" "token" "entity_reference_revisions")
INSTALLED=0
TOTAL=${#MODULES_CHECK[@]}

for module in "${MODULES_CHECK[@]}"; do
    if $DRUSH_CMD pm:list --type=module --status=enabled | grep -q "$module"; then
        echo -e "${GREEN}✅ $module${NC}"
        INSTALLED=$((INSTALLED + 1))
    else
        echo -e "${RED}❌ $module${NC}"
    fi
done

# 6. RÉSUMÉ
echo -e "\n${BLUE}📊 RÉSULTAT INSTALLATION :${NC}"
echo "================================="

PERCENTAGE=$((INSTALLED * 100 / TOTAL))

if [ $PERCENTAGE -eq 100 ]; then
    echo -e "${GREEN} PARFAIT ! Tous les modules installés ($INSTALLED/$TOTAL)${NC}"
    echo -e "${GREEN} Prêt pour l'étape 3 : Configuration${NC}"
elif [ $PERCENTAGE -ge 80 ]; then
    echo -e "${YELLOW} PRESQUE PARFAIT ! $INSTALLED/$TOTAL modules ($PERCENTAGE%)${NC}"
    echo -e "${YELLOW} Quelques modules peuvent être installés manuellement${NC}"
else
    echo -e "${RED}❌ PROBLÈME : Seulement $INSTALLED/$TOTAL installés ($PERCENTAGE%)${NC}"
    echo -e "${RED}🔧 Vérifiez les erreurs ci-dessus${NC}"
fi

# 7. SAUVEGARDE DU STATUS
{
    echo "# eGov Homepage - Installation Modules"
    echo "Date: $(date)"
    echo "Modules installés: $INSTALLED/$TOTAL ($PERCENTAGE%)"
    echo "Status: $([ $PERCENTAGE -ge 80 ] && echo "✅ Prêt" || echo "❌ Problèmes")"
    echo ""
    echo "Modules vérifiés:"
    for module in "${MODULES_CHECK[@]}"; do
        if $DRUSH_CMD pm:list --type=module --status=enabled | grep -q "$module"; then
            echo "- $module: ✅"
        else
            echo "- $module: ❌"
        fi
    done
    echo ""
    echo "Prochaine étape: $([ $PERCENTAGE -ge 80 ] && echo "Création du content type" || echo "Corriger l'installation")"
} > modules_installation_status.txt

echo -e "\n📄 Rapport sauvé: modules_installation_status.txt"

# 8. INSTRUCTIONS SUIVANTES
if [ $PERCENTAGE -ge 80 ]; then
    echo -e "\n${GREEN} ÉTAPES SUIVANTES :${NC}"
    echo "1. Modules installés"
    echo "2.  Prochaine étape : Création du content type Homepage"
    echo "3. Puis configuration des templates"
    echo ""
    echo -e "${BLUE}💡 Interface admin améliorée maintenant disponible à :${NC}"
    echo "https://votre-site.com/admin/structure/types"
else
    echo -e "\n${YELLOW}🔧 ACTIONS CORRECTIVES :${NC}"
    echo "1. Vérifiez les messages d'erreur ci-dessus"
    echo "2. Installez manuellement les modules manquants :"
    echo "   drush en paragraphs field_group admin_toolbar -y"
    echo "3. Relancez ce script"
fi

echo -e "\n${BLUE} COMMANDES UTILES :${NC}"
echo "Voir modules installés : $DRUSH_CMD pm:list --type=module --status=enabled"
echo "Vider caches : $DRUSH_CMD cr"
echo "Status site : $DRUSH_CMD status"

