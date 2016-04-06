select
c1.city1 ||'_'||c2.city2 as img,
c1.email,c1.city1,c2.city2,c1.datecreated,c1.num,c2.num
--,io.icon
from
(
	select *
	from
	(
			select *
			,ROW_NUMBER() OVER(PARTITION BY email ORDER BY datecreated,city_need) as num
			from 
			(
				select t.email, tt.city as city1, t.datecreated,
			    case when tt.city is not null then 1 else 0 end city_need
			    from
					(
						select distinct (substr (o.route,5,3)) uniq_city,
					lower(trim(email)) as email, o.datecreated
					from bi.fct_orders o
					where true
					and trunc(o.datecreated) BETWEEN sysdate()-250 and sysdate()-180
					and not exists
						(
							select
							lower(trim(o2.email))
							from bi.fct_orders o2
							where o2.email = lower(trim(o.email))
							and trunc(o2.datecreated)BETWEEN sysdate()-180 and sysdate()-1
							--and o.status = 'Issued'
						)
					) t
					left join tmp.ebarkov_cities tt on t.uniq_city = tt.CITY
					where true
					and (case when tt.city is not null then 1 else 0 end) = 1
					--and email = '0002444@mail.ru'
			) tt1
			where true
			and city_need = 1
	) tt2
where true and num = '1'
)c1
left join 
( select *
			from
			(
				 select *,
				 ROW_NUMBER() OVER(PARTITION BY email ORDER BY datecreated,city_need) as num
				 from 
					(
						select t.email, tt.city as city2, t.datecreated,
					    case when tt.city is not null then 1 else 0 end city_need
					    from
							(
									select distinct (substr (o.route,5,3)) uniq_city,
					lower(trim(email)) as email, o.datecreated
					from bi.fct_orders o
					where true
					and trunc(o.datecreated) BETWEEN sysdate()-250 and sysdate()-180
					and not exists
						(
							select
							lower(trim(o2.email))
							from bi.fct_orders o2
							where o2.email = lower(trim(o.email))
							and trunc(o2.datecreated)BETWEEN sysdate()-180 and sysdate()-1
							--and o.status = 'Issued'
						)
							) t
							left join tmp.ebarkov_cities tt on t.uniq_city = tt.CITY
							where true
							and (case when tt.city is not null then 1 else 0 end) = 1
							--and email = '0002444@mail.ru'
					) tt1
			where true
			and city_need = 1
			) tt2
		where true and num = '2'
) c2 ON c2.email = c1.email
left join tmp.vbaydikov_p_home_data home ON lower(trim(home.email)) = c1.email
left join bi.dim_city dim ON dim.code = home.city
--left join tmp.ebarkov_forecast_io io ON io.city_code = home.city
where true
and c2.city2 is not null
--and io.icon = 'rain'
limit 100;