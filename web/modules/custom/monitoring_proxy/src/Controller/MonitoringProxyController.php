<?php
namespace Drupal\monitoring_proxy\Controller;

use Drupal\Core\Controller\ControllerBase;
use Symfony\Component\HttpFoundation\JsonResponse;

class MonitoringProxyController extends ControllerBase {
  
  public function getData() {
    try {
      $all_data = [];
      
      // 1. Charger UAT (fichier local)
      $uat_file = '/var/monitoring/uat_data.json';
      if (file_exists($uat_file)) {
        $uat_content = file_get_contents($uat_file);
        $uat_data = json_decode($uat_content, true);
        
        if (is_array($uat_data)) {
          foreach ($uat_data as &$item) {
            $item['environment'] = 'UAT';
          }
          $all_data = array_merge($all_data, $uat_data);
        }
      }
      
      // 2. Charger INT (fichier local - si tu fais pareil pour INT)
      $int_file = '/var/monitoring/int_data.json';
      if (file_exists($int_file)) {
        $int_content = file_get_contents($int_file);
        $int_data = json_decode($int_content, true);
        
        if (is_array($int_data)) {
          foreach ($int_data as &$item) {
            $item['environment'] = 'INT';
          }
          $all_data = array_merge($all_data, $int_data);
        }
      }
      
      // Trier par timestamp décroissant
      usort($all_data, function($a, $b) {
        $ts_a = isset($a['monitoring_data_ts']) ? $a['monitoring_data_ts'] : 0;
        $ts_b = isset($b['monitoring_data_ts']) ? $b['monitoring_data_ts'] : 0;
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