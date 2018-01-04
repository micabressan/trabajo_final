with
base as (
select 
	from_unixtime(unix_timestamp(v_time_check, 'dd.MM.yyyy HH:mm:ss'),'yyyy-MM-dd') as day
	, v_regno
	, concat(codd_kafka.v_gps_y, '_', codd_kafka.v_gps_x) as camera_id
	, v_time_check,
  	  IF(from_unixtime(unix_timestamp(v_time_check,'dd.MM.yyyy HH:mm:ss'),'u') in (6,7), 1, 0) as is_holiday

	
from codd_kafka
--where v_regno = 'Р486ХТ190'
)


,pre as
(select 	
	day
 	, is_holiday
 	, v_regno
 	, camera_id
 	, v_time_check
 	, lead(v_time_check, 1) over (partition by v_regno order by v_time_check) as r_previous_overall
	from base ),
	
get_target as (
	select 
	day,
  	is_holiday,
    v_regno

from pre WHERE  abs(round((unix_timestamp(v_time_check) - unix_timestamp(r_previous_overall))/3600, 0)) > 5 
  								and camera_id in ('55.760433_37.600353' , 
												  '55.75632_37.614136', 
												  '55.75919_37.62158',
												  '55.77345_37.591034',
												  '55.772774_37.59014')
),

group_target as (
  SELECT 
  		day,
 		 v_regno,
  		is_holiday 
  FROM get_target
		GROUP BY day, v_regno, is_holiday),
		
target_overall as (
  SELECT 
  		COUNT(v_regno) as cnt,
  		v_regno 
		FROM group_target GROUP BY v_regno  HAVING cnt >= 6),
		
target_holiday as (
  SELECT 
  		COUNT(v_regno) as cnt,
  		is_holiday,
  		v_regno 
		FROM group_target GROUP BY v_regno, is_holiday HAVING cnt >= 3 and is_holiday=1),
		
get_interspection as (
  SELECT t1.v_regno as v_regno 
  FROM target_overall as t1 INNER JOIN target_holiday as t2 ON t1.v_regno=t2.v_regno)

  
SELECT v_regno FROM get_interspection