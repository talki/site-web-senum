#!/bin/bash

# Configuration
BACKUP_DIR="/home/backups"
SITE_NAME="egov"
DATE=$(date +%Y%m%d-%H%M%S)
BACKUP_PATH="$BACKUP_DIR/${SITE_NAME}-${DATE}"
DRUPAL_ROOT="/var/www/html/drupal"

# Couleurs
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}🚀 Début du backup complet du site...${NC}"
echo -e "${BLUE}📍 Dossier de backup : $BACKUP_PATH${NC}"

# Créer le dossier de backup
echo -e "${GREEN}📁 Création du dossier de backup...${NC}"
mkdir -p "$BACKUP_PATH"

# Se placer dans la racine Drupal
cd "$DRUPAL_ROOT"

# 1. Backup de la base de données
echo -e "${GREEN}📦 1/4 - Backup de la base de données...${NC}"
vendor/bin/drush sql:dump --gzip --result-file="$BACKUP_PATH/database.sql" 2>&1
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Base de données sauvegardée${NC}"
else
    echo -e "${RED}❌ Erreur lors du backup de la base de données${NC}"
fi

# 2. Backup des fichiers uploadés
echo -e "${GREEN}📁 2/4 - Backup des fichiers uploadés...${NC}"
if [ -d "sites/default/files" ]; then
    tar -czf "$BACKUP_PATH/files.tar.gz" sites/default/files/ 2>&1
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Fichiers sauvegardés${NC}"
    else
        echo -e "${RED}❌ Erreur lors du backup des fichiers${NC}"
    fi
else
    echo -e "${RED}⚠️  Dossier sites/default/files introuvable${NC}"
fi

# 3. Backup de la configuration
echo -e "${GREEN}⚙️  3/4 - Backup de la configuration Drupal...${NC}"
mkdir -p "$BACKUP_PATH/config"
vendor/bin/drush config:export --destination="$BACKUP_PATH/config" 2>&1
if [ $? -eq 0 ]; then
    tar -czf "$BACKUP_PATH/config.tar.gz" -C "$BACKUP_PATH" config/ 2>&1
    rm -rf "$BACKUP_PATH/config"
    echo -e "${GREEN}✅ Configuration sauvegardée${NC}"
else
    echo -e "${RED}❌ Erreur lors du backup de la configuration${NC}"
fi

# 4. Backup du code source
echo -e "${GREEN}💻 4/4 - Backup du code source...${NC}"
tar -czf "$BACKUP_PATH/code.tar.gz" \
  --exclude='sites/default/files' \
  --exclude='vendor' \
  --exclude='node_modules' \
  --exclude='.git' \
  --exclude='*.log' \
  . 2>&1
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Code source sauvegardé${NC}"
else
    echo -e "${RED}❌ Erreur lors du backup du code source${NC}"
fi

# Résumé
echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}✅ Backup terminé avec succès !${NC}"
echo -e "${BLUE}📍 Emplacement : $BACKUP_PATH${NC}"
echo ""
echo "Fichiers créés :"
ls -lh "$BACKUP_PATH"
echo ""
BACKUP_SIZE=$(du -sh "$BACKUP_PATH" | cut -f1)
echo -e "${BLUE}💾 Taille totale : $BACKUP_SIZE${NC}"
echo -e "${GREEN}========================================${NC}"

# Optionnel : Garder seulement les 5 derniers backups
echo ""
echo "🧹 Nettoyage des anciens backups (garde les 5 derniers)..."
cd "$BACKUP_DIR"
ls -t | grep "^${SITE_NAME}-" | tail -n +6 | xargs -r rm -rf
echo "✅ Nettoyage terminé"
