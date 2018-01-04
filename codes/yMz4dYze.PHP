function has_access($product) {
	if (!empty($product)) {
		$current_user = wp_get_current_user();
		
		if ( is_user_logged_in() && (wc_customer_bought_product( $current_user->user_email, $current_user->ID, $product->ID ))) {	 
			return true; 
		} else {				
			return false;
		}
	}

    return false;
}