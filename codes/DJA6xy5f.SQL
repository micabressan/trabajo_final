;with
base as (
select 
	from_unixtime(unix_timestamp(v_time_check, 'dd.MM.yyyy HH:mm:ss'),'yyyy-MM-dd') as dt
	, codd.v_regno
	, concat(codd.v_gps_y, '_', codd.v_gps_x) as camera_id
    , codd.v_gps_y as camera_x
    , codd.v_gps_x as camera_y
	, codd.v_time_check
    , codd.day
from codd_data.codd codd where day >= '2017-07-10'
)
,pre as
(select
	dt
 	, v_regno
 	, camera_id
    , camera_x
    , camera_y
 	, v_time_check
	, row_number() over (partition by day, v_regno order by v_time_check) as camera_cum
	, lag(v_time_check, 1) over (partition by day, v_regno order by v_time_check) as l_previous_in_day
 	, lead(v_time_check, 1) over (partition by day, v_regno order by v_time_check) as r_previous_in_day
 	, lag(v_time_check, 1) over (partition by v_regno order by v_time_check) as l_previous_overall
 	, lead(v_time_check, 1) over (partition by v_regno order by v_time_check) as r_previous_overall
from base )
, f as (
select 
	dt
 	, v_regno
 	, camera_id
    , camera_x
    , camera_y
 	, v_time_check 
	, camera_cum
	, abs(round((unix_timestamp(v_time_check) - unix_timestamp(l_previous_in_day))/60, 0)) as t_diff_day_prev
	, abs(round((unix_timestamp(v_time_check) - unix_timestamp(r_previous_in_day))/60, 0)) as t_diff_day_next
	, abs(round((unix_timestamp(v_time_check) - unix_timestamp(l_previous_overall))/60, 0)) as t_diff_prev
	, abs(round((unix_timestamp(v_time_check) - unix_timestamp(r_previous_overall))/60, 0)) as t_diff_next
from pre
where camera_id in 
('55.789635_37.548138', '55.788334_37.54572', '55.77837_37.557087', '55.77862_37.55678', '55.77687_37.555447',
'55.774197_37.5512', '55.77351_37.54544', '55.77408_37.54278', '55.774826_37.53855', '55.77711_37.53234', '55.777546_37.52722')
   or (camera_x >= 55.77408 and camera_x <= 55.788334 and camera_y >= 37.52722 and camera_y <= 37.557087)
)
, par as
(
select phoneno, carno from 
(
select 
	phoneno
	,  carno
	, max(from_unixtime(unix_timestamp(parkingstart, 'dd.MM.yyyy HH:mm:ss'),'yyyy-MM-dd')) as max_date
	, count(*) as qty
	, row_number() over (partition by carno order by count(*) desc) as rn
from parking_data.parking
where phoneno != 'NULL'
and from_unixtime(unix_timestamp(parkingstart, 'dd.MM.yyyy HH:mm:ss'),'yyyy-MM-dd') >= '2017-01-01'
group by 
  phoneno
  ,  carno
) xx
where rn = 1
), extra as (
select 
	f.v_regno as v_regno, 
	sec.regno_hash as regno_hash,
    sec.regno as regno
from f
join secret.regno as sec on f.v_regno = sec.regno_hash
where (t_diff_prev >= 300 or t_diff_next >= 300)
group by 
v_regno, regno_hash, regno
)
select 
	extra.regno, 
	par.phoneno
from extra
join par on extra.regno = par.carno
where par.carno is not null
group by 
extra.regno,
par.phoneno