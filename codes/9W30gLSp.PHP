$view = views_get_view('swimming_suites');
$view->set_display('swimming_suites_pane');
$view->init_handlers();
$view->init_style();
$view->set_exposed_input(array('field_brand' => $brand_tid));
$view->pre_execute();
$view->execute();
$view->preview();