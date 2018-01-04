wp_enqueue_script( 'my-script', get_bloginfo('template_directory') . '/js/custom_script.js' );
$params = array(
    0 => array(
        'lat' => '35',
        'long' => '45'
    ),
    1 => array(
        'lat' => '40',
        'long' => '50'
    )
);
$reshuffled_data = array('l10n_print_after' => 'my_localized_data = '.json_encode($params).';');
wp_localize_script( 'my-script', 'location', $reshuffled_data );