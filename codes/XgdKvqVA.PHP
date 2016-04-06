function mmda_swipper_admin_settings($form, &$form_state) {
  $form = array();

  $radio_options = array('1' => t('Sim'), '0' => t('Não'));

  $form['slider'] = array(
    '#type' => 'fieldset',
    '#title' => t('Name'),
    '#collapsible' => FALSE,
    '#collapsed' => FALSE,
  );

  $form['slider']['class'] = array(
    '#type' => 'textfield',
    '#title' => t('Nome da Classe'),
    '#default_value' => variable_get('mmda_swipper_slider_class', null),
    '#required' => TRUE,
  );

  $form['slider']['pagination'] = array(
    '#type' => 'radios',
    '#title' => t('Paginação'),
    '#options' => $radio_options,
    '#description' => t('Botões de paginação abaixo do slider.'),
    '#default_value' => variable_get('mmda_swipper_slider_navigation', null),
    '#required' => TRUE,
  );

  $form['slider']['navigation'] = array(
    '#type' => 'radios',
    '#title' => t('Navegação'),
    '#options' => $radio_options,
    '#description' => t('Setas de navegação no slide.'),
    '#default_value' => variable_get('mmda_swipper_slider_navigation', null),
    '#required' => TRUE,
  );

  $form['slider']['lines'] = array(
    '#type' => 'textfield',
    '#title' => t('Quantidade de linhas para exibir'),
    '#default_value' => variable_get('mmda_swipper_slider_lines', '1'),
    '#required' => TRUE,
    '#size' => 2,
  );

  return system_settings_form($form);
}