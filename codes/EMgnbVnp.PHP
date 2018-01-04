function estoque() {
global $product;
if ( $product->stock ) {
if ( number_format($product->stock,0,'','') < 6 ) { 
echo '<div class="restante">Somente ' . number_format($product->stock,0,'','') . ' em estoque!</div>';
} 
}
}
 
add_action('woocommerce_after_shop_loop_item','estoque', 10);