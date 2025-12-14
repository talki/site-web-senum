<?php

namespace Drupal\monitoring_proxy\Controller;

use Drupal\Core\Controller\ControllerBase;
use Symfony\Component\HttpFoundation\JsonResponse;

class MonitoringProxyController extends ControllerBase {
  
  public function getData() {
    try {
      $all_data = [];
      
      // 1. Récupérer les données PROD (existant)
      $prod_url = 'http://102.164.134.109/operational_data';
      $ch = curl_init();
      curl_setopt($ch, CURLOPT_URL, $prod_url);
      curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
      curl_setopt($ch, CURLOPT_TIMEOUT, 30);
      
      $response = curl_exec($ch);
      $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
      
      if (!curl_errno($ch) && $http_code === 200) {
        $prod_data = json_decode($response, true);
        if (is_array($prod_data)) {
          // Ajouter le tag environnement
          foreach ($prod_data as &$item) {
            $item['environment'] = 'PROD';
          }
          $all_data = array_merge($all_data, $prod_data);
        }
      }
      
      curl_close($ch);
      
      // 2. NOUVEAU : Récupérer les données INTEGRATION (fichier local)
      $integration_file = '/var/monitoring/integration_data.json';
      if (file_exists($integration_file)) {
        $integration_content = file_get_contents($integration_file);
        $integration_data = json_decode($integration_content, true);
        
        if (is_array($integration_data)) {
          // Ajouter le tag environnement
          foreach ($integration_data as &$item) {
            $item['environment'] = 'INTEGRATION';
          }
          $all_data = array_merge($all_data, $integration_data);
        }
      }
      
      // Trier par timestamp décroissant
      usort($all_data, function($a, $b) {
        $ts_a = isset($a['request_in_ts']) ? $a['request_in_ts'] : 0;
        $ts_b = isset($b['request_in_ts']) ? $b['request_in_ts'] : 0;
        return $ts_b - $ts_a;
      });
      
      return new JsonResponse($all_data);
      
    } catch (\Exception $e) {
      return new JsonResponse([
        'error' => 'Exception: ' . $e->getMessage()
      ], 500);
    }
  }
}