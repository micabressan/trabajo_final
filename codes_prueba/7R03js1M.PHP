$products = get_field('product');

if (get_field('product')) {
	foreach ($products as $product) { 
		$current_user = wp_get_current_user();
	
		if ( is_user_logged_in() && (wc_customer_bought_product( $current_user->user_email, $current_user->ID, $product->ID ))) {		 
			return true; 
		} else {				
			echo '<div>' . do_shortcode('[add_to_cart id="' . $product->ID . '" style=""]') . '</div>'; 
		}
	}
}