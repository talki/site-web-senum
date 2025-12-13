<?php

namespace Drupal\monitoring_proxy\Controller;

use Drupal\Core\Controller\ControllerBase;
use Symfony\Component\HttpFoundation\JsonResponse;

class MonitoringProxyController extends ControllerBase {
  
  public function getData() {
    $api_url = 'http://102.164.134.109/operational_data';
    
    try {
      $ch = curl_init();
      curl_setopt($ch, CURLOPT_URL, $api_url);
      curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
      curl_setopt($ch, CURLOPT_TIMEOUT, 30);
      
      $response = curl_exec($ch);
      $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
      
      if (curl_errno($ch)) {
        curl_close($ch);
        return new JsonResponse([
          'error' => 'Erreur cURL: ' . curl_error($ch)
        ], 500);
      }
      
      curl_close($ch);
      
      if ($http_code !== 200) {
        return new JsonResponse([
          'error' => 'Erreur HTTP: ' . $http_code
        ], $http_code);
      }
      
      $data = json_decode($response, true);
      
      if (json_last_error() !== JSON_ERROR_NONE) {
        return new JsonResponse([
          'error' => 'Erreur JSON: ' . json_last_error_msg()
        ], 500);
      }
      
      return new JsonResponse($data);
      
    } catch (\Exception $e) {
      return new JsonResponse([
        'error' => 'Exception: ' . $e->getMessage()
      ], 500);
    }
  }
}
