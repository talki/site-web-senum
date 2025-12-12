#!/bin/bash

DRUPAL_ROOT="/var/www/html/drupal"
cd "$DRUPAL_ROOT"

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}🚀 Création du système Publications...${NC}"

# 1. Export config
echo -e "${GREEN}📦 1/5 - Export de la configuration...${NC}"
mkdir -p /tmp/config-export
vendor/bin/drush config:export --destination=/tmp/config-export

# 2. Créer le content type Publication
echo -e "${GREEN}📝 2/5 - Création du content type Publication...${NC}"
cd /tmp/config-export

# Copier et modifier le content type
cp node.type.actualite.yml node.type.publication.yml
sed -i "s/name: Actualité/name: Publication/g" node.type.publication.yml
sed -i "s/type: actualite/type: publication/g" node.type.publication.yml
sed -i "s/description: 'Contenu pour les actualités et annonces'/description: 'Contenu pour les publications officielles et rapports'/g" node.type.publication.yml

# 3. Copier les champs
echo -e "${GREEN}📋 3/5 - Copie des champs...${NC}"
for file in field.field.node.actualite.*; do
    if [ -f "$file" ]; then
        newfile="${file//actualite/publication}"
        cp "$file" "$newfile"
        sed -i 's/actualite/publication/g' "$newfile"
        echo "  ✓ Copié: $newfile"
    fi
done

# Copier aussi core.entity_form_display et core.entity_view_display
for file in core.entity_form_display.node.actualite.* core.entity_view_display.node.actualite.*; do
    if [ -f "$file" ]; then
        newfile="${file//actualite/publication}"
        cp "$file" "$newfile"
        sed -i 's/actualite/publication/g' "$newfile"
        echo "  ✓ Copié: $newfile"
    fi
done

# 4. Import config
echo -e "${GREEN}⬇️  4/5 - Import de la configuration...${NC}"
cd "$DRUPAL_ROOT"
vendor/bin/drush config:import --partial --source=/tmp/config-export

# 5. Dupliquer le node
echo -e "${GREEN}📄 5/5 - Duplication de la page...${NC}"
NODE_ID=$(vendor/bin/drush php-eval "
  \$node = \Drupal\node\Entity\Node::load(30);
  if (\$node) {
    \$clone = \$node->createDuplicate();
    \$clone->setTitle('Publications');
    \$clone->save();
    echo \$clone->id();
  }
")

if [ ! -z "$NODE_ID" ]; then
    echo -e "${GREEN}✅ Page Publications créée avec l'ID : $NODE_ID${NC}"
    echo -e "${BLUE}🔗 URL : /node/$NODE_ID${NC}"
    
    # Créer un alias d'URL
    vendor/bin/drush php-eval "
      \$path_alias_storage = \Drupal::entityTypeManager()->getStorage('path_alias');
      \$path_alias = \$path_alias_storage->create([
        'path' => '/node/$NODE_ID',
        'alias' => '/publications',
        'langcode' => 'fr',
      ]);
      \$path_alias->save();
      echo 'Alias créé : /publications';
    "
else
    echo -e "${YELLOW}⚠️  Erreur lors de la duplication du node${NC}"
fi

# 6. Clear cache
echo -e "${GREEN}🧹 Nettoyage du cache...${NC}"
vendor/bin/drush cr

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}✅ Système Publications créé !${NC}"
echo -e "${BLUE}📝 Content type : publication${NC}"
echo -e "${BLUE}📄 Page ID : $NODE_ID${NC}"
echo -e "${BLUE}🔗 URL : https://www.egov.pexone.com/publications${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo -e "${YELLOW}📌 Prochaines étapes :${NC}"
echo "1. Ajouter le node ID $NODE_ID dans egov_theme.theme"
echo "2. Créer le template pour les publications"
echo "3. Tester la page"
