with
base as (
select 
	from_unixtime(unix_timestamp(v_time_check, 'dd.MM.yyyy HH:mm:ss'),'yyyy-MM-dd') as day
	, v_regno
	, concat(codd_kafka.v_gps_y, '_', codd_kafka.v_gps_x) as camera_id
	, v_time_check
	
from codd_kafka WHERE v_time_check > unix_timestamp('2017-10-23 00:00:00.0','dd.MM.yyyy HH:mm:ss')
--where v_regno = 'Р486ХТ190'
)

,pre as
(select 	
	day,
 	IF(day in ('2017-10-28', '2017-10-29', '2017-11-04', '2017-11-05', 
	   		  '2017-11-11', '2017-11-12', '2017-11-18', '2017-11-19',
	  		  '2017-11-25', '2017-11-26', '2017-12-02', '2017-12-03',
	  		  '2017-12-09', '2017-12-10', '2017-12-16', '2017-12-17',
	  		  '2017-12-23') , 1,0)  as is_holiday
 	, v_regno
 	, camera_id
 	, v_time_check
	, row_number() over (partition by day, v_regno  order by v_time_check) as camera_cum
 	--, lag(v_time_check, 1) over (partition by v_regno order by v_time_check) as l_previous_overall
 	, lead(v_time_check, 1) over (partition by v_regno order by v_time_check) as r_previous_overall
	from base ),
	
get_target as (
	select 
	day
  	is_holiday,
 	, v_regno
 	, camera_id
 	, v_time_check 
	, camera_cum
	--, abs(round((unix_timestamp(v_time_check) - unix_timestamp(l_previous_overall))/3600, 0)) as t_diff_prev
	--, abs(round((unix_timestamp(v_time_check) - unix_timestamp(r_previous_overall))/3600, 0)) as t_diff_next
from pre WHERE  abs(round((unix_timestamp(v_time_check) - unix_timestamp(r_previous_overall))/3600, 0)) > 5 
  								and camera_id in ('55.760433_37.600353' , 
												  '55.75632_37.614136', 
												  '55.75919_37.62158',
												  '55.77345_37.591034',
												  '55.772774_37.59014')
)

group_target as (
  SELECT day,
 		 v_regno,
  		is_holiday
		GROUP BY day, v_regno, is_holiday),
		
target_overall as (
  SELECT 
  		COUNT(v_regno) as cnt,
  		v_regno 
		FROM group_target GROUP BY v_regno HAVING cnt > 15)
		
target_holiday as (
  SELECT 
  		COUNT(v_regno) as cnt,
  		is_holiday,
  		v_regno 
		FROM group_target GROUP BY v_regno, is_holiday HAVING cnt > 6 and is_holiday=1)