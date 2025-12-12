<?php

// phpcs:ignoreFile

$databases = [];


$settings['hash_salt'] = '9kyqlPPdA-VkTJq_KRYZsLKGeGL0il6ZubSP2ZDvDdPAi32TU9RfIChRiJsbKQUEjW-nJWVIaw';

/**
 * Deployment identifier.
 *
 * Drupal's dependency injection container will be automatically invalidated and
 * rebuilt when the Drupal core version changes. When updating contributed or
 * custom code that changes the container, changing this identifier will also
 * allow the container to be invalidated as soon as code is deployed.
 */
# $settings['deployment_identifier'] = \Drupal::VERSION;

/**
 * Access control for update.php script.
 *
 * If you are updating your Drupal installation using the update.php script but
 * are not logged in using either an account with the "Administer software
 * updates" permission or the site maintenance account (the account that was
 * created during installation), you will need to modify the access check
 * statement below. Change the FALSE to a TRUE to disable the access check.
 * After finishing the upgrade, be sure to open this file again and change the
 * TRUE back to a FALSE!
 */
$settings['update_free_access'] = FALSE;

/**
 * ------------------------------------------------------------
 *  ACTIVE LE MODE DEBUG DRUPAL (LOGS + TWIG + ERREURS PHP)
 * ------------------------------------------------------------
 */

/* Charger les services de debug (development.services.yml) */
$settings['container_yamls'][] = $app_root . '/' . $site_path . '/development.services.yml';

/* Niveau d’erreurs Drupal */
$config['system.logging']['error_level'] = 'verbose';

/* Afficher TOUTES les erreurs PHP */
ini_set('display_errors', TRUE);
ini_set('display_startup_errors', TRUE);
error_reporting(E_ALL);

/* Désactiver la pré-compilation Twig */
$settings['twig_debug'] = TRUE;
$settings['twig_auto_reload'] = TRUE;
$settings['twig_cache'] = FALSE;

/**
 * IMPORTANT : ne pas utiliser cache.backend.null sur Drupal 10
 * car ce backend n’existe plus.
 *
 * On utilise plutôt cache.backend.memory (RAM).
 */
$settings['cache']['bins']['render'] = 'cache.backend.memory';
$settings['cache']['bins']['page'] = 'cache.backend.memory';
$settings['cache']['bins']['dynamic_page_cache'] = 'cache.backend.memory';



/**
 * The default list of directories that will be ignored by Drupal's file API.
 *
 * By default ignore node_modules and bower_components folders to avoid issues
 * with common frontend tools and recursive scanning of directories looking for
 * extensions.
 *
 * @see \Drupal\Core\File\FileSystemInterface::scanDirectory()
 * @see \Drupal\Core\Extension\ExtensionDiscovery::scanDirectory()
 */
$settings['file_scan_ignore_directories'] = [
  'node_modules',
  'bower_components',
];

/**
 * The default number of entities to update in a batch process.
 *
 * This is used by update and post-update functions that need to go through and
 * change all the entities on a site, so it is useful to increase this number
 * if your hosting configuration (i.e. RAM allocation, CPU speed) allows for a
 * larger number of entities to be processed in a single batch run.
 */
$settings['entity_update_batch_size'] = 50;

/**
 * Entity update backup.
 *
 * This is used to inform the entity storage handler that the backup tables as
 * well as the original entity type and field storage definitions should be
 * retained after a successful entity update process.
 */
$settings['entity_update_backup'] = TRUE;

/**
 * Node migration type.
 *
 * This is used to force the migration system to use the classic node migrations
 * instead of the default complete node migrations. The migration system will
 * use the classic node migration only if there are existing migrate_map tables
 * for the classic node migrations and they contain data. These tables may not
 * exist if you are developing custom migrations and do not want to use the
 * complete node migrations. Set this to TRUE to force the use of the classic
 * node migrations.
 */
$settings['migrate_node_migrate_type_classic'] = FALSE;

/**
 * The default settings for migration sources.
 *
 * These settings are used as the default settings on the Credential form at
 * /upgrade/credentials.
 *
 * - migrate_source_version - The version of the source database. This can be
 *   '6' or '7'. Defaults to '7'.
 * - migrate_source_connection - The key in the $databases array for the source
 *   site.
 * - migrate_file_public_path - The location of the source Drupal 6 or Drupal 7
 *   public files. This can be a local file directory containing the source
 *   Drupal 6 or Drupal 7 site (e.g /var/www/docroot), or the site address
 *   (e.g http://example.com).
 * - migrate_file_private_path - The location of the source Drupal 7 private
 *   files. This can be a local file directory containing the source Drupal 7
 *   site (e.g /var/www/docroot), or empty to use the same value as Public
 *   files directory.
 *
 * Sample configuration for a drupal 6 source site with the source files in a
 * local directory.
 *
 * @code
 * $settings['migrate_source_version'] = '6';
 * $settings['migrate_source_connection'] = 'migrate';
 * $settings['migrate_file_public_path'] = '/var/www/drupal6';
 * @endcode
 *
 * Sample configuration for a drupal 7 source site with public source files on
 * the source site and the private files in a local directory.
 *
 * @code
 * $settings['migrate_source_version'] = '7';
 * $settings['migrate_source_connection'] = 'migrate';
 * $settings['migrate_file_public_path'] = 'https://drupal7.com';
 * $settings['migrate_file_private_path'] = '/var/www/drupal7';
 * @endcode
 */
# $settings['migrate_source_connection'] = '';
# $settings['migrate_source_version'] = '';
# $settings['migrate_file_public_path'] = '';
# $settings['migrate_file_private_path'] = '';

/**
 * Load local development override configuration, if available.
 *
 * Create a settings.local.php file to override variables on secondary (staging,
 * development, etc.) installations of this site.
 *
 * Typical uses of settings.local.php include:
 * - Disabling caching.
 * - Disabling JavaScript/CSS compression.
 * - Rerouting outgoing emails.
 *
 * Keep this code block at the end of this file to take full effect.
 */
#
# if (file_exists($app_root . '/' . $site_path . '/settings.local.php')) {
#   include $app_root . '/' . $site_path . '/settings.local.php';
# }
$databases['default']['default'] = array (
  'database' => 'interoperabilite',
  'username' => 'interoperabilite',
  'password' => 'ToChangeIO2025!',
  'prefix' => '',
  'host' => 'localhost',
  'port' => '5432',
  'driver' => 'pgsql',
  'namespace' => 'Drupal\\pgsql\\Driver\\Database\\pgsql',
  'autoload' => 'core/modules/pgsql/src/Driver/Database/pgsql/',
);
$settings['config_sync_directory'] = 'sites/default/files/config_Wu4lSLvdgpJioZLciCgXRaEmIJGxRMxN-MGPBE1W9bbbMNJStfvLgpeIkvFaxjyNNCJeYuYeFw/sync';
