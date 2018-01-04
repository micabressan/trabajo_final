<?php
/**
 * Loop Name: Blog Grid
 *
 * @package siteorigin-corp
 * @license GPL 2.0 
 */     

$args = array(
	'meta_key' => 'datum_akce',
	'meta_type' => 'DATE',
	'orderby' => 'meta_value_num',
  'order'	=> 'ASC',
             	'meta_key' => 'datum_akce',
                'posts_per_page' => 30, 
                'meta_value'   => date('ymd'),
                'meta_key'     => 'datum_akce',
                'meta_compare' => '>=',
); ?>
     
<?php

    $the_query = new WP_Query( $args );
    
    
    if ( $the_query->have_posts() ) {
        while ( $the_query->have_posts() ) {
            
            $the_query->the_post(); ?>


    
<?php		get_template_part( 'template-parts/content', get_post_format() ); ?>
        

 <?php } } else { ?>

<h2>Nejsou naplánovány žádné akce</h2>    
        
<?php //endif; ?>
    <?php } ?>