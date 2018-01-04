
function _ejecutar_cron_get_nodes() {
  $ids = \Drupal::entityQuery('node')->condition('type','reclamo')->execute();
  $reclamos = Node::loadMultiple($ids);
  //$fecha_hoy = \Drupal::time()->getCurrentTime();

  foreach ($reclamos as $reclamo) {
    $estado = $reclamo->field_state->value;
    //$fecha_terminado = $reclamo->field_date_finished->value;

    if ($estado == 'finished' /* && $fecha_terminado < $fecha_hoy */) {
      if ($reclamo->field_estado_facturacion->value == '1') {
          $reclamo->set('field_estado_facturacion', '2');
      }
    }
  }
}