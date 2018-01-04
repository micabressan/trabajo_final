En WP_Posts:
SELECT * FROM `wp_posts` WHERE `post_status` = "Publish" and `post_type` = "post" ORDER BY "post_date"