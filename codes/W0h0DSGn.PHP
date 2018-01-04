function check_product_access($product) {
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
 
function has_single_product_access()
{
    $products = get_field('product');
    if (!empty($products)) {
        foreach($products as $product) {
            if (check_product_access($product)) return $product;
        }
    }
 
    return false;
}




if ($product = has_single_product_access()) {

	echo '<div>' . do_shortcode('[add_to_cart id="' . $product->ID . '" style=""]') . '</div>'; 
	 
	 
 }