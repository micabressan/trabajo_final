add_action('init', 'photos_rewrite');

function photos_rewrite() {
    add_rewrite_rule('^music/?$', 'index.php?taxonomy=product_cat&term=music', 'top' );
}