SELECT SQL_CALC_FOUND_ROWS item.item_id, item.item_code AS 'Item Code',
  item.biblio_id AS 'Title', ct.coll_type_name AS 'Collection Type',
  loc.location_name AS 'Location', biblio.classification AS 'Classification',
  item.last_update AS 'Last Updated'
FROM item
  LEFT JOIN biblio ON item.biblio_id=biblio.biblio_id
  LEFT JOIN mst_location AS loc ON item.location_id=loc.location_id
  LEFT JOIN mst_coll_type AS ct ON item.coll_type_id=ct.coll_type_id
WHERE (
  biblio.biblio_id IN(
    SELECT DISTINCT biblio_id
    FROM biblio
    WHERE MATCH (title, series_title) AGAINST ('+2015-0755' IN BOOLEAN MODE)
  )
  OR biblio.biblio_id IN(
    SELECT ba.biblio_id
    FROM biblio_author AS ba
      LEFT JOIN mst_author AS a ON ba.author_id=a.author_id
    WHERE author_name LIKE '%2015-0755%'
  )
  OR biblio.biblio_id IN(
    SELECT bt.biblio_id
    FROM biblio_topic AS bt
      LEFT JOIN mst_topic AS t ON bt.topic_id=t.topic_id
    WHERE topic LIKE '%2015-0755%'
  )
  OR item.item_code LIKE '2015-0755%'
)
ORDER BY item.last_update DESC
LIMIT 20 OFFSET 0