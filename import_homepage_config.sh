#!/bin/bash

# Script de génération automatique de la configuration Homepage
# Exécuter depuis /var/www/html/drupal/

echo "🚀 Génération automatique de la configuration Homepage..."

# Couleurs
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Créer le dossier de configuration
CONFIG_DIR="modules/custom/egov_homepage/config/install"
mkdir -p "$CONFIG_DIR"

echo -e "${BLUE}📁 Création des fichiers de configuration dans $CONFIG_DIR${NC}"

# 1. CONTENT TYPE HOMEPAGE
echo -e "${BLUE}📝 Content type Homepage...${NC}"
cat > "$CONFIG_DIR/node.type.homepage.yml" << 'EOF'
langcode: fr
status: true
dependencies: 
  module:
    - node
third_party_settings: {  }
name: 'Page d''accueil'
type: homepage
description: 'Type de contenu pour la page d''accueil du site. Une seule page de ce type doit exister.'
help: 'Utilisez ce type de contenu pour gérer le contenu de la page d''accueil. Vous pouvez modifier les différentes sections : Hero, Services, Actualités, etc.'
new_revision: true
preview_mode: 1
display_submitted: false
EOF

# 2. PARAGRAPHS TYPES
echo -e "${BLUE}📝 Types de Paragraphs...${NC}"

cat > "$CONFIG_DIR/paragraphs.paragraphs_type.stat_card.yml" << 'EOF'
langcode: fr
status: true
dependencies: {}
id: stat_card
label: 'Carte Statistique'
icon_uuid: null
icon_default: null
description: 'Carte pour afficher une statistique (nombre + libellé)'
behavior_plugins: []
EOF

cat > "$CONFIG_DIR/paragraphs.paragraphs_type.service_card.yml" << 'EOF'
langcode: fr
status: true
dependencies: {}
id: service_card
label: 'Carte Service'
icon_uuid: null
icon_default: null
description: 'Carte pour afficher un service (icône + titre + description)'
behavior_plugins: []
EOF

cat > "$CONFIG_DIR/paragraphs.paragraphs_type.news_item.yml" << 'EOF'
langcode: fr
status: true
dependencies: {}
id: news_item
label: 'Article Actualité'
icon_uuid: null
icon_default: null
description: 'Article pour le fil d''actualités'
behavior_plugins: []
EOF

# 3. FIELD STORAGES (définitions des types de champs)
echo -e "${BLUE}📝 Field storages...${NC}"

cat > "$CONFIG_DIR/field.storage.node.field_hero_title.yml" << 'EOF'
langcode: fr
status: true
dependencies:
  module:
    - node
id: node.field_hero_title
field_name: field_hero_title
entity_type: node
type: string
settings:
  max_length: 255
  is_ascii: false
  case_sensitive: false
module: core
locked: false
cardinality: 1
translatable: true
indexes: {}
persist_with_no_fields: false
custom_storage: false
EOF

cat > "$CONFIG_DIR/field.storage.node.field_hero_subtitle.yml" << 'EOF'
langcode: fr
status: true
dependencies:
  module:
    - node
id: node.field_hero_subtitle
field_name: field_hero_subtitle
entity_type: node
type: string
settings:
  max_length: 255
  is_ascii: false
  case_sensitive: false
module: core
locked: false
cardinality: 1
translatable: true
indexes: {}
persist_with_no_fields: false
custom_storage: false
EOF

cat > "$CONFIG_DIR/field.storage.node.field_hero_description.yml" << 'EOF'
langcode: fr
status: true
dependencies:
  module:
    - node
    - text
id: node.field_hero_description
field_name: field_hero_description
entity_type: node
type: text_long
settings: {}
module: text
locked: false
cardinality: 1
translatable: true
indexes: {}
persist_with_no_fields: false
custom_storage: false
EOF

cat > "$CONFIG_DIR/field.storage.node.field_hero_stats.yml" << 'EOF'
langcode: fr
status: true
dependencies:
  module:
    - entity_reference_revisions
    - node
id: node.field_hero_stats
field_name: field_hero_stats
entity_type: node
type: entity_reference_revisions
settings:
  target_type: paragraph
module: entity_reference_revisions
locked: false
cardinality: -1
translatable: true
indexes: {}
persist_with_no_fields: false
custom_storage: false
EOF

cat > "$CONFIG_DIR/field.storage.node.field_services_title.yml" << 'EOF'
langcode: fr
status: true
dependencies:
  module:
    - node
id: node.field_services_title
field_name: field_services_title
entity_type: node
type: string
settings:
  max_length: 255
  is_ascii: false
  case_sensitive: false
module: core
locked: false
cardinality: 1
translatable: true
indexes: {}
persist_with_no_fields: false
custom_storage: false
EOF

cat > "$CONFIG_DIR/field.storage.paragraph.field_stat_number.yml" << 'EOF'
langcode: fr
status: true
dependencies:
  module:
    - paragraphs
id: paragraph.field_stat_number
field_name: field_stat_number
entity_type: paragraph
type: string
settings:
  max_length: 50
  is_ascii: false
  case_sensitive: false
module: core
locked: false
cardinality: 1
translatable: true
indexes: {}
persist_with_no_fields: false
custom_storage: false
EOF

cat > "$CONFIG_DIR/field.storage.paragraph.field_stat_label.yml" << 'EOF'
langcode: fr
status: true
dependencies:
  module:
    - paragraphs
id: paragraph.field_stat_label
field_name: field_stat_label
entity_type: paragraph
type: string
settings:
  max_length: 255
  is_ascii: false
  case_sensitive: false
module: core
locked: false
cardinality: 1
translatable: true
indexes: {}
persist_with_no_fields: false
custom_storage: false
EOF

# 4. FIELD INSTANCES (attachement des champs aux content types)
echo -e "${BLUE}📝 Field instances...${NC}"

cat > "$CONFIG_DIR/field.field.node.homepage.field_hero_title.yml" << 'EOF'
langcode: fr
status: true
dependencies:
  config:
    - field.storage.node.field_hero_title
    - node.type.homepage
id: node.homepage.field_hero_title
field_name: field_hero_title
entity_type: node
bundle: homepage
label: 'Titre Hero'
description: 'Titre principal de la section hero (ex: "Bienvenue sur la Plateforme")'
required: true
translatable: true
default_value: []
default_value_callback: ''
settings: {}
field_type: string
EOF

cat > "$CONFIG_DIR/field.field.node.homepage.field_hero_subtitle.yml" << 'EOF'
langcode: fr
status: true
dependencies:
  config:
    - field.storage.node.field_hero_subtitle
    - node.type.homepage
id: node.homepage.field_hero_subtitle
field_name: field_hero_subtitle
entity_type: node
bundle: homepage
label: 'Sous-titre Hero'
description: 'Sous-titre mis en évidence (ex: "d''Interopérabilité du Sénégal")'
required: true
translatable: true
default_value: []
default_value_callback: ''
settings: {}
field_type: string
EOF

cat > "$CONFIG_DIR/field.field.node.homepage.field_hero_description.yml" << 'EOF'
langcode: fr
status: true
dependencies:
  config:
    - field.storage.node.field_hero_description
    - node.type.homepage
  module:
    - text
id: node.homepage.field_hero_description
field_name: field_hero_description
entity_type: node
bundle: homepage
label: 'Description Hero'
description: 'Description complète affichée dans la section hero'
required: false
translatable: true
default_value: []
default_value_callback: ''
settings: {}
field_type: text_long
EOF

cat > "$CONFIG_DIR/field.field.node.homepage.field_hero_stats.yml" << 'EOF'
langcode: fr
status: true
dependencies:
  config:
    - field.storage.node.field_hero_stats
    - node.type.homepage
    - paragraphs.paragraphs_type.stat_card
  module:
    - entity_reference_revisions
id: node.homepage.field_hero_stats
field_name: field_hero_stats
entity_type: node
bundle: homepage
label: 'Statistiques Hero'
description: 'Cartes de statistiques affichées dans la section hero (ex: "45+ Administrations")'
required: false
translatable: true
default_value: []
default_value_callback: ''
settings:
  handler: 'default:paragraph'
  handler_settings:
    negate: 0
    target_bundles:
      stat_card: stat_card
    target_bundles_drag_drop:
      stat_card:
        enabled: true
        weight: 2
field_type: entity_reference_revisions
EOF

cat > "$CONFIG_DIR/field.field.node.homepage.field_services_title.yml" << 'EOF'
langcode: fr
status: true
dependencies:
  config:
    - field.storage.node.field_services_title
    - node.type.homepage
id: node.homepage.field_services_title
field_name: field_services_title
entity_type: node
bundle: homepage
label: 'Titre Services'
description: 'Titre de la section services'
required: false
translatable: true
default_value:
  - value: 'Services'
default_value_callback: ''
settings: {}
field_type: string
EOF

cat > "$CONFIG_DIR/field.field.paragraph.stat_card.field_stat_number.yml" << 'EOF'
langcode: fr
status: true
dependencies:
  config:
    - field.storage.paragraph.field_stat_number
    - paragraphs.paragraphs_type.stat_card
id: paragraph.stat_card.field_stat_number
field_name: field_stat_number
entity_type: paragraph
bundle: stat_card
label: 'Nombre'
description: 'Le chiffre à afficher (ex: "45+", "127", "2.3M")'
required: true
translatable: true
default_value: []
default_value_callback: ''
settings: {}
field_type: string
EOF

cat > "$CONFIG_DIR/field.field.paragraph.stat_card.field_stat_label.yml" << 'EOF'
langcode: fr
status: true
dependencies:
  config:
    - field.storage.paragraph.field_stat_label
    - paragraphs.paragraphs_type.stat_card
id: paragraph.stat_card.field_stat_label
field_name: field_stat_label
entity_type: paragraph
bundle: stat_card
label: 'Libellé'
description: 'Le libellé de la statistique (ex: "Administrations", "API Actives")'
required: true
translatable: true
default_value: []
default_value_callback: ''
settings: {}
field_type: string
EOF

# 5. RÉSUMÉ
echo -e "\n${GREEN}✅ Tous les fichiers de configuration générés !${NC}"
echo "======================================================"

echo -e "${BLUE}📁 Fichiers créés dans $CONFIG_DIR :${NC}"
ls -la "$CONFIG_DIR"

echo -e "\n${GREEN}🚀 Configuration prête pour l'import !${NC}"
echo -e "${YELLOW}📝 Prochaine étape : Lancer l'import automatique${NC}"
echo ""
echo "Commande : ./import_homepage_config.sh"

# 6. CRÉER LE FICHIER .INFO.YML DU MODULE
cat > "modules/custom/egov_homepage/egov_homepage.info.yml" << 'EOF'
name: 'eGov Homepage'
description: 'Module pour gérer la page d''accueil administrable'
type: module
core_version_requirement: ^9 || ^10
package: 'eGov Senegal'
dependencies:
  - drupal:node
  - paragraphs:paragraphs
  - drupal:field
  - drupal:text
  - entity_reference_revisions:entity_reference_revisions
EOF

echo -e "${GREEN}📦 Module eGov Homepage configuré${NC}"
echo -e "${BLUE}✅ Prêt pour l'installation !${NC}"

