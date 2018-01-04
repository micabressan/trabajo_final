This is a fix for the "Please match the requested format error" for WooCommerce while using WooCommerce Measurement Price Calculator. The bug was found using the Enfold theme, but could be there for any other themes as well.

Just create a js file and add this code, or append it to your theme js file:

jQuery(document).ready( function() {
	if (jQuery('.qty').attr("pattern") == ''){
		jQuery('.qty').removeAttr("pattern");
	}
});

For enqueue a js file use:
function wpbv_adding_scripts() {
 
	wp_register_script('js_fixes', get_stylesheet_directory_uri() . '/assets/js/fixqty.js', array('jquery'),'1.1', true);
 
	wp_enqueue_script('js_fixes');
}
  
add_action( 'wp_enqueue_scripts', 'wpbv_adding_scripts' ); 

Being assets/js/fixqty.js the route of the js file you have created.