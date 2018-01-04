function get_single_product()
{
	$products = get_field('product');
	if (!empty($products) && is_array($products))
		return $products[0];

	return false;
}

function check_product_access($product=false) {
	if($product===false) $product = get_single_product();

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

function showProduct($product) {
	if (empty($product)) return '';
	echo '<div>' . do_shortcode('[add_to_cart id="' . $product->ID . '" style=""]') . '</div>'; 
}

if (check_product_access()==false) {
	showProduct(get_single_product());
}