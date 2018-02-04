select all_recs.session_id, all_recs.hotel_id, all_recs.position, all_recs.confidence, all_recs.oww_page, all_recs.rec_ts,
clicks.oneg_hotel_id, concat(clicks.dt, ' ', clicks.click_time), all_recs.click_ts from (
    select session_id, rec_ts, min(unix_timestamp(rec_ts) - unix_timestamp(click_ts)) as diff
    from(
        select c.session_id, c.oneg_hotel_id, concat(c.dt, ' ', c.click_time) as click_ts, recs.rec_ts, recs.hotel_id  
        from efx_hotel_clicks c join (
            select session_id, concat(dt, ' ', click_time) as rec_ts, hotel_id from efx_hotel_recommendation
        ) recs
        on (recs.session_id = c.session_id)
        where c.dt >= '2011-04-21' and c.dt <= '2011-05-26'
    ) min_click
    where (unix_timestamp(rec_ts) - unix_timestamp(click_ts)) >= 0
    group by session_id, rec_ts
) cr_min
join  (
    select r.session_id, r.hotel_id, r.position, r.confidence, r.oww_page, concat(r.dt, ' ', r.click_time) as rec_ts, rec_click.click_ts
    from efx_hotel_recommendation r left outer join (
        select r.session_id, r.hotel_id, concat(r.dt, ' ', r.click_time) as rec_ts, concat(c.dt, ' ', c.click_time) as click_ts
            from efx_hotel_recommendation r join efx_hotel_clicks c on  
            (r.session_id = c.session_id and r.hotel_id = c.oneg_hotel_id) 
            where c.pagetype = 'DHD' and c.dt >= '2011-04-21' and c.dt <= '2011-05-26' and 
            concat(c.dt, ' ', c.click_time) > concat(r.dt, ' ', r.click_time)
    ) rec_click
    on (r.session_id = rec_click.session_id and concat(r.dt, ' ', r.click_time) = rec_click.rec_ts and 
    r.hotel_id = rec_click.hotel_id)
    where r.dt >= '2011-04-21' and r.dt <= '2011-05-26'
) all_recs 

on all_recs.session_id = cr_min.session_id and all_recs.rec_ts = cr_min.rec_ts
join efx_hotel_clicks clicks on
  clicks.session_id = cr_min.session_id and 
  concat(clicks.dt, ' ', clicks.click_time) = from_unixtime(unix_timestamp(cr_min.rec_ts)-cr_min.diff)
    where clicks.dt >= '2011-04-21' and clicks.dt <= '2011-05-26' and clicks.pagetype = 'DHD'
;