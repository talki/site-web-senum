# Module Management - Drupal

## Installation

1. Copiez le dossier `management` dans `/modules/custom/` de votre site Drupal
2. Activez le module via l'interface d'administration ou en ligne de commande:
   ```
   drush en management
   ```
3. Videz le cache:
   ```
   drush cr
   ```

## Utilisation

### Dans votre page Contact

Modifiez votre formulaire HTML pour qu'il pointe vers la route du module:

```html
<form action="/management/contact/submit" method="POST">
  <!-- Vos champs de formulaire -->
</form>
```

### Structure du module

```
management/
├── management.info.yml          # Informations du module
├── management.routing.yml       # Définition des routes
├── src/
│   └── Controller/
│       └── ContactController.php # Contrôleur principal
├── EXEMPLE_FORMULAIRE.html      # Exemple de formulaire
└── README.md                    # Ce fichier
```

### Route disponible

- **POST** `/management/contact/submit` - Traite la soumission du formulaire

### Personnalisation

Modifiez le fichier `src/Controller/ContactController.php` pour:
- Ajouter la validation des données
- Envoyer des emails
- Enregistrer en base de données
- Rediriger vers une page spécifique
- Retourner une réponse JSON pour AJAX

### Sécurité (Recommandé)

Pour ajouter une protection CSRF, modifiez le routing pour exiger un token:
1. Ajoutez le token dans votre formulaire
2. Validez-le dans le contrôleur

## Logs

Les soumissions sont enregistrées dans les logs Drupal (admin/reports/dblog)
