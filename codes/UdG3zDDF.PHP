get_header(); ?>
    <main class="uk-section-muted uk-container uk-container-center uk-margin-top uk-margin-large-bottom">
        <div class="uk-grid" data-uk-grid-margin>
		<?php
		while ( have_posts() ) : the_post();
			get_template_part( 'template-parts/content', 'page' );
			// If comments are open or we have at least one comment, load up the comment template.
			if ( comments_open() || get_comments_number() ) :
				comments_template();
			endif;
		endwhile;
		get_sidebar();
		?>
    </div>
    </main>
<?php
get_footer();