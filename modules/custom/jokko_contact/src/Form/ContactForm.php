<?php

namespace Drupal\jokko_contact\Form;

use Drupal\Core\Form\FormBase;
use Drupal\Core\Form\FormStateInterface;

class ContactForm extends FormBase {

  public function getFormId() {
    return 'jokko_contact_form';
  }

  public function buildForm(array $form, FormStateInterface $form_state) {

    $form['prenom'] = [
      '#type' => 'textfield',
      '#title' => 'Prénom',
      '#required' => TRUE,
    ];

    $form['nom'] = [
      '#type' => 'textfield',
      '#title' => 'Nom',
      '#required' => TRUE,
    ];

    $form['email'] = [
      '#type' => 'email',
      '#title' => 'Email',
      '#required' => TRUE,
    ];

    $form['telephone'] = [
      '#type' => 'textfield',
      '#title' => 'Téléphone',
    ];

    $form['organisation'] = [
      '#type' => 'textfield',
      '#title' => 'Organisation',
    ];

    $form['sujet'] = [
      '#type' => 'textfield',
      '#title' => 'Sujet',
      '#required' => TRUE,
    ];

    $form['message'] = [
      '#type' => 'textarea',
      '#title' => 'Message',
      '#required' => TRUE,
    ];

    $form['submit'] = [
      '#type' => 'submit',
      '#value' => 'Envoyer le message',
      '#button_type' => 'primary',
    ];

    return $form;
  }

  public function submitForm(array &$form, FormStateInterface $form_state) {

    $mailManager = \Drupal::service('plugin.manager.mail');
    $module = 'jokko_contact';
    $key = 'contact_message';
    $to = 'contact@jokko.sn';    // Destinataire final
    $langcode = 'fr';

    $params = [
      'prenom' => $form_state->getValue('prenom'),
      'nom' => $form_state->getValue('nom'),
      'email' => $form_state->getValue('email'),
      'telephone' => $form_state->getValue('telephone'),
      'organisation' => $form_state->getValue('organisation'),
      'sujet' => $form_state->getValue('sujet'),
      'message' => $form_state->getValue('message'),
    ];

    $mailManager->mail($module, $key, $to, $langcode, $params);

    \Drupal::messenger()->addStatus("Votre message a bien été envoyé. Merci de nous avoir contactés !");
  }
}
