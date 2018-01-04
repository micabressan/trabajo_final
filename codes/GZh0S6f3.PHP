<?php

/**
 * @file
 * Stargater Reclamos module file.
*/

use Drupal\node\Entity\Node;
use Drupal\Core\Access\AccessResult;
use Drupal\Core\Session\AccountInterface;
use Drupal\node\NodeInterface;
use Drupal\Core\Form\FormStateInterface;

use Drupal\datetime\Plugin\Field\FieldType\DateTimeFieldItemList;

const RECLAMO_NO_FACTURABLE = 'No facturable';
const RECLAMO_BLOQUEADO_FACTURACION = 'Bloqueado para facturación';
const RECLAMO_FACTURADO = 'Facturado';

/**
 * Implements hook_theme().
 */
function stargate_reclamos_theme($existing, $type, $theme, $path) {
  return [
    'node__reclamo' => [
      'template' => 'node--reclamo',
      'base hook' => 'node',
    ],
    'stargate_risk_report' => [
      'template' => 'stargate_risk_report',
      'variables' => ['report' => [], 'content' => [], 'node' => []],
    ],
  ];
}

function stargate_reclamos_preprocess_node(&$vars) {
  //Add vars
  $node = $vars['node'];

  // Risk reort
  $risk_report  = json_decode($node->field_risk_report->value);

  // Legal report
  $legal_report = ['Juicios' => []];
  if ($node->field_has_trial_history->value) {
      libxml_use_internal_errors(TRUE);
      $xml = simplexml_load_string(trim($node->field_trial_history->value));
      if ($xml === FALSE) {
        $message = "Falló el parseo del XML de Juicios para el nodo [" . $node->ID() . "]\n";
        foreach(libxml_get_errors() as $error) {
          $message .= "\n" . $error->message;
        }
        \Drupal::logger('stargate_reclamos')->error($message);
      }

      $legal_report = json_decode(json_encode($xml));

      if (!is_array($legal_report->Juicio)) {
        $legal_report->Juicio = array($legal_report->Juicio);
      }
  }

  // Clean up
  $index = 0;;
  foreach($legal_report->Juicio as $trial) {
    foreach(array_keys((array) $trial) as $key) {
      if (is_object($trial->{$key})) {
        if (count((array) $trial->{$key}) == 0) {
          $legal_report->Juicio[$index]->{$key} = '';
        }
      }
    }
    $index++;
  }

  // Accident report
  $accident_report = ['#theme' => 'markup', '#markup' => $node->field_has_srt->value ? $node->field_srt->value : ''];

  // Render risk report
  $report_render_array = [
    '#theme' => 'stargate_risk_report',
    '#report' => [
      'risk'  => $risk_report,
      'legal' => $legal_report,
      'accident' => $accident_report
    ],
    '#content' => $vars['content'],
    '#node' => $vars['node']
  ];

  $vars['risk_report'] = Drupal::service('renderer')->render($report_render_array);

  // decide which homepage the user must go back to
  $vars['frontpage_url'] = _stargate_reclamos_get_frontpage_url();
}


/**
 * Implements hook_cron().
 */
function stargate_reclamos_cron() {
  $interval = \Drupal::state()->get('stargate_reclamos_cron_interval') ? : 30; // 30 seg

  $next_execution = \Drupal::state()->get('stargate_reclamos.next_execution');
  $next_execution = !empty($next_execution) ? $next_execution : 0;
  if (REQUEST_TIME >= $next_execution) {
    $nodes = _stargate_reclamos_get_nodes();
    \Drupal::logger('stargate_reclamos')->notice('Procesando reclamos ...');
    foreach ($nodes as $key => $id) {
      _stargate_reclamos_populate_fields($id);
    }
    \Drupal::state()->set('stargate_reclamos.next_execution', REQUEST_TIME + $interval);
  }
  else {
    \Drupal::logger('stargate_reclamos')->notice('Salteando reclamos.');
  }



/*
  $query = \Drupal::entityQuery('node');
  $query->condition('status', 1);
  $query->condition('type', 'reclamo');
  $nids = $query->execute();
  $nodes = entity_load_multiple('node', array_keys($nids));


  foreach ($nodes as $reclamo) {
    $reclamo->set('field_estado_facturacion', '2');
  }*/

  $ids = \Drupal::entityQuery('node')->condition('type','reclamo')->execute();
  $reclamos = Node::loadMultiple($ids);

  foreach ($reclamos as $reclamo) {
     $reclamo->set('field_estado_facturacion', '2');
  }

}

function _stargate_reclamos_get_nodes() {
  $range = \Drupal::state()->get('stargate_reclamos_query_range') ? : 50;
  $query = \Drupal::entityQuery('node');
  $query->condition('status', 1);
  $query->condition('type', 'reclamo');
  $query->condition('field_state', 'new');
  $group = $query->orConditionGroup()
    ->condition('field_has_trial_history', FALSE)
    ->condition('field_has_risk_report', FALSE);
  $query->condition($group);
  $query->range(0, $range);
  $entity_ids = $query->execute();
  return $entity_ids;
}

function _stargate_reclamos_populate_fields($id) {

  $node = Node::load($id);
  $cuil = $node->get('field_cuil')->value;

  $message = "Haciendo llamadas a los WS para cuil: $cuil (nid: $id)";
  \Drupal::logger('stargate_reclamos')->notice($message);

  if (empty($cuil)) {
    $message = "El reclamo con nid: $id no tiene seteado CUIL!";
    \Drupal::logger('stargate_reclamos')->warning($message);
    return;
  }

  $success = TRUE;

  //trial_history
  $user = \Drupal::state()->get('reclamo_ws_user') ?: 'abiuso@experta.com.ar';
  $pass = \Drupal::state()->get('reclamo_ws_pass') ?: 'ga12345678';

  $default_url = 'http://186.182.220.51/ws/wsjuicios.asmx/ObtenerJuiciosPorEmpleado?usuario=%s&constraseña=%s&cuil=%s';
  $url = \Drupal::state()->get('reclamo_ws_url') ?: $default_url;
  //@TODO: how solve encoding : Windows-1252
  $request_url = sprintf($url, $user, $pass, $cuil);
  $request_url = str_replace('ñ', '%F1', $request_url);
  $param = ['Accept' => 'application/xml'];
  $output = _stargate_reclamos_call_ws('GET', $request_url, $param);
  if ($output != '') {
    // https://stackoverflow.com/questions/8830599/php-convert-xml-to-json
    $xml = simplexml_load_string($output);
    $json = json_encode($xml);

    $node->set('field_trial_history', $output);
    $node->set('field_has_trial_history', TRUE);
  }
  else {
    \Drupal::logger('stargate_reclamos')->error('Fallo llamada a WS de Juicios!');
    $success = FALSE;
  }

  //risk_report
  $default_url_ws_risk = 'http://api.fidelitas.com.ar/v1/ic/json';
  $url = \Drupal::state()->get('reclamo_risk_ws_url') ?: $default_url_ws_risk;
  $apikey = \Drupal::state()->get('reclamo_apikey') ?: '928BFC592F76DB92';
  $param = [
    'form_params' => [
        'apikey' => $apikey,
        'cuit' => $cuil,
      ]
  ];
  $output = _stargate_reclamos_call_ws('POST', $url, $param);
  if ($output != '') {
    $node->set('field_risk_report', $output);
    $node->set('field_has_risk_report', TRUE);
  }
  else {
    \Drupal::logger('stargate_reclamos')->error('Fallo llamada a WS de Riesgos!');
    $success = FALSE;
  }

  if ($success) {
    $node->set('field_state', 'progress');
  }

  $node->save();

}

function _stargate_reclamos_call_ws($method, $url, $param) {
  $output = '';
  $client = \Drupal::httpClient();
  try {
    $response = $client->request($method, $url, $param);
    $code = $response->getStatusCode();
    if ($code == 200) { //OK
      $output = $response->getBody();
    }
  }
  catch (GuzzleHttp\Exception\ClientException $e) {
    \Drupal::logger('stargate_reclamos')->error($e->getMessage());
  }
  return $output;
}


/**
 *  implements hook_node_presave(\Drupal\Core\Entity\EntityInterface $node)
 */
function stargate_reclamos_node_presave(\Drupal\Core\Entity\EntityInterface $node) {

  if ( isset($node->field_srt->value) && !empty($node->field_srt->value) ) {
    $node->field_has_srt = true;
  } else {
    $node->field_has_srt = false;
  }

  if ( isset($node->field_social_network_analysis->value) && !empty($node->field_social_network_analysis->value) ) {
    $node->field_has_social_network = true;
  } else {
    $node->field_has_social_network = false;
  }

  // Antes de guardar o actualizar un nodo reclamo, bloquear fechas.
  if ($node->bundle() == 'reclamo') {
    _actualizar_fechas_reclamo($node);
  }
}


function _stargate_reclamos_get_frontpage_url() {
  $rol = _get_current_rol();

    $url = '/reclamos';

    if ($rol == 'contador') {
      $url = '/admin/content/facturacion';
    }
    elseif ($rol == 'administrator' or $rol == 'analista') {
      $url = '/admin/content/reclamos';
    }

  return $url;
}


/**
 * Implements hook_node_access().
 */
function stargate_reclamos_node_access(NodeInterface $node, $op, AccountInterface $account) {
  $c_type = $node->bundle();
  $rol = _get_current_rol();
  $f_value = $node->field_estado_facturacion->value;

  switch ($op) {
    case 'update':
      if ($c_type == 'reclamo') {
        !($f_value == '2' || $f_value == '3') ? $node->set('field_estado_facturacion', '1') : $f_value = $f_value;
        if ($rol =='contador' || $rol == 'usuario_art' || ($rol == 'analista'
          && $f_value != '1')) {
          // Permisos denegados para editar nodos reclamo
          return AccessResult::forbidden()->cachePerPermissions();
        }
        else {
          return AccessResult::allowed();
        }
      }
    default:
      // No opinion.
      return AccessResult::neutral();
  }
}


/**
 * Get current rol.
 */
function _get_current_rol() {
  $user = \Drupal\user\Entity\User::load(\Drupal::currentUser()->id());
  $roles = $user->getRoles(TRUE);
  return $roles[0];
}

// Obtener nombre del estado de facturacion
function _estado_facturacion($reclamo_facturado) {
  $estado_facturacion = [
    '1' => RECLAMO_NO_FACTURABLE,
    '2' => RECLAMO_BLOQUEADO_FACTURACION,
    '3' => RECLAMO_FACTURADO,
  ];
  return $estado_facturacion[$reclamo_facturado];
}

// Setear fechas reclamo
function _actualizar_fechas_reclamo($node) {
 // Estado del Reclamo
 $reclamo_terminado = $node->field_state->value;
 $fecha_terminado = $node->field_date_finished->value;

 // Estado de Facturacion
 $reclamo_facturado = $node->field_estado_facturacion->value;
 $fecha_facturado = $node->field_date_billed->value;
 $reclamo_facturado_name = _estado_facturacion($reclamo_facturado);


 $current_user = \Drupal::currentUser();

 //************* Setear Fecha Estado Reclamo

 // Si hay una fecha definida sin estar marcado como Terminado el reclamo
 if (isset($fecha_terminado) && $reclamo_terminado != 'finished') {
      // Si el campo fecha esta bloqueado
      // Significa que esta en estado Terminado, y se quiere volver a reiniciar/cambiar.
      if (!$node->field_fecha_estado_activo->value) {
        // Si el campo fecha esta desactivado/bloqueado
        // Significa que anteriormente se puso a estado Terminado
        // y se quiere volver a cambiar de estado.
        $node->field_fecha_estado_activo = TRUE; // Volver a poner activo.
        $node->set('field_date_finished', NULL); // Reiniciar la fecha a ninguna.

        \Drupal::logger('Stargate Reclamo')->notice("Cambio de estado a " . $reclamo_terminado . " en el nodo de id " . $node->id(). '. Reseteo del campo fecha TERMINADO');
      }
      // Si el reclamo esta marcado como Terminado y tiene fecha
  } elseif ($reclamo_terminado == 'finished' && isset($fecha_terminado)){
      // Bool para indicar desabilitar/bloquear el campo fecha
      $node->field_fecha_estado_activo = FALSE;

      \Drupal::logger('Stargate Reclamo')->notice("Cambio de estado a " . $reclamo_terminado . " en el nodo de id " . $node->id(). '. Bloqueo del campo fecha TERMINADO');
  } else {
    \Drupal::logger('Stargate Reclamo')->notice("Cambio de estado a " . $reclamo_terminado . " en el nodo de id " . $node->id());
  }

 //************* Setear Fecha Estado Facturacion

  // Si hay una fecha definida sin estar marcado como Facturado el reclamo
 if (isset($fecha_facturado) && $reclamo_facturado != '3') {
      // Si el campo fecha esta bloqueado
      // Significa que esta en estado Facturado, y se quiere volver a reiniciar/cambiar.
      if (!$node->field_fecha_facturado_activo->value) {
        // Si el campo fecha esta desactivado/bloqueado
        // Significa que anteriormente se puso a estado Facturado
        // y se quiere volver a cambiar de estado.
        $node->field_fecha_facturado_activo = TRUE; // Volver a poner activo.
        $node->set('field_date_billed', NULL); // Reiniciar la fecha a ninguna.

        \Drupal::logger('Stargate Reclamo')->notice("Cambio de estado de facturacion a " . $reclamo_facturado_name . " en el nodo de id " . $node->id(). '. Reseteo del campo fecha FACTURADO');
      }
      // Si el reclamo esta marcado como Facturado y tiene fecha
  } elseif ($reclamo_facturado == '3' && isset($fecha_facturado)){
      // Bool para indicar desabilitar/bloquear el campo fecha
      $node->field_fecha_facturado_activo = FALSE;

      \Drupal::logger('Stargate Reclamo')->notice("Cambio de estado de facturacion a " . $reclamo_facturado_name . " en el nodo de id " . $node->id(). '. Bloqueo del campo fecha FACTURADO');
  } else {
    \Drupal::logger('Stargate Reclamo')->notice("Cambio de estado de facturacion a " . $reclamo_facturado_name . " en el nodo de id " . $node->id());
  }

  $node->setNewRevision(TRUE);
  $node->revision_log = 'Nueva revisión para el nodo ' . $node->id() . '. Nuevo estado a: ' . $reclamo_terminado. ' y '.$reclamo_facturado_name;
  $node->setRevisionCreationTime(REQUEST_TIME);
  $node->setRevisionUserId($current_user->id());
}


/**
 * Implements hook_form_alter().
 */
function stargate_reclamos_form_alter(&$form, FormStateInterface $form_state, $form_id) {
  switch ($form_id) {
    case 'node_reclamo_edit_form':

      $rol = _get_current_rol();

      $form['#validate'][] = 'stargate_reclamos_node_form_validate';

      $node = $form_state->getFormObject()->getEntity();
      // Si es FALSE significa que el reclamo esta en estado Terminado.
      if (!$node->field_fecha_estado_activo->value && $rol != 'administrator') {
        // Bloquer campo fecha
        $form['field_date_finished']['#disabled'] = TRUE;
      }
      // Si es FALSE significa que el reclamo esta en estado Facturado.
      if (!$node->field_fecha_facturado_activo->value && $rol != 'administrator') {
        // Bloquer campo fecha
        $form['field_date_billed']['#disabled'] = TRUE;
        break;
      }
  }
}

// Validar campos fechas de estados, antes de guardar un reclamo
function stargate_reclamos_node_form_validate($form, &$form_state) {
  // Obtener datos de campos
  $node = $form_state->getFormObject()->getEntity();
  $values = $form_state->getValues();

  // Estado del Reclamo
  $reclamo_terminado = $values['field_state'][0]['value'];
  $fecha_terminado = $values['field_date_finished'][0]['value'];

  // Estado de Facturacion
  $reclamo_facturado = $values['field_estado_facturacion'][0]['value'];
  $fecha_facturado = $values['field_date_billed'][0]['value'];


  //************* Validar Estado Reclamo

  // Si el reclamo se marca como Terminado, pero no tiene fecha definida
  if ($reclamo_terminado == 'finished' && !isset($fecha_terminado)) {
    $form_state->setErrorByName('field_date_finished', t('Si el reclamo pasa a estado Terminado, debe definir la fecha.'));

    // Si hay una fecha definida sin estar marcado como Terminado el reclamo
  } elseif (isset($fecha_terminado) && $reclamo_terminado != 'finished') {

      // Si el campo fecha esta habilitado/activo
      // Significa que no se ha pasado a estado Terminado aun
      if ($node->field_fecha_estado_activo->value) {
        $form_state->setErrorByName('field_date_finished', t('Si el reclamo no esta en estado Terminado, no se puede definir fecha.'));
      }
    }

  //************* Validar Estado Facturacion

     // Si el reclamo se marca como Facturado, pero no tiene fecha definida
  if ($reclamo_facturado == '3' && !isset($fecha_facturado)) {
    $form_state->setErrorByName('field_date_billed', t('Si el reclamo pasa a estado Facturado, debe definir la fecha.'));

    // Si hay una fecha definida sin estar marcado como Facturado el reclamo
  } elseif (isset($fecha_facturado) && $reclamo_facturado != '3') {

      // Si el campo fecha esta habilitado/activo
      // Significa que no se ha pasado a estado Facturado aun
      if ($node->field_fecha_facturado_activo->value) {
        $form_state->setErrorByName('field_date_billed', t('Si el reclamo no esta en estado Facturado, no se puede definir fecha.'));
      }
    }
}