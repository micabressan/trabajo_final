// Build render array

function make_array() {
  $items = port_view_get_block();
  $array['container']['#prefix'] = '<div id = "container">';
  $array['container']['#suffix'] = '</div>';
  $array['container']['#markup'] = 'This is inside the container div';
  $array['container']['slider']['#prefix'] = '<div id = "slider">';
  $array['container']['slider']['#suffix'] = '</div>';
  $array['container']['slider']['#markup'] = 'This is inside the slider div';
  return $array;
}