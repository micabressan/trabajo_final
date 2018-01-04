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

function has_access_to_any_old_fucking_thing()
{
	$products = get_field('product');
	if (!empty($products)) {
		foreach($products as $product) {
			if (has_access($product)) return true;
		}
	}

	return false;
}