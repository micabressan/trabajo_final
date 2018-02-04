delete x,y,z
from wp_posts x
left join wp_term_relationships y on (x.id = y.object_id)
left join wp_postmeta z on (x.id = z.post_id)
where x.post_type = 'revision'