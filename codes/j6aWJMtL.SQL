SELECT p1.ID as car_1, p2.ID as car_2 FROM `compares`
                LEFT JOIN wp_term_relationships t1 ON t1.object_id = compares.car_id_1
                LEFT JOIN wp_term_relationships t2 ON t2.object_id = compares.car_id_2
                LEFT JOIN wp_posts p1 ON t1.object_id = p1.ID
                LEFT JOIN wp_posts p2 ON t2.object_id = p2.ID
                LEFT JOIN wp_postmeta m1 ON m1.post_id = p1.ID
                LEFT JOIN wp_postmeta m2 ON m2.post_id = p2.ID
                WHERE 
                t1.object_id = compares.car_id_1 AND
                t2.object_id = compares.car_id_2 AND
                t1.term_taxonomy_id = %d AND
                t2.term_taxonomy_id = %d AND
                m1.meta_key = 'поколение' AND
                m1.meta_value = 1 AND
                m2.meta_key = 'поколение' AND
                m2.meta_value = 1
                
                ORDER BY compares.count DESC 
                LIMIT 4