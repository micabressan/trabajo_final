with recursive input_strings as (
	select
		cast(:idscope as varchar(1024)) as mystring
	from rdb$database
), input_data as (
	select
		position(',', mystring) + 1 as pos,
		(char_length(mystring) - position(',', reverse(mystring))) + 1 as lim,
		cast(
			substring(
				mystring from 1 for (position(',', mystring, 1) - 1)
			) as int
		) as column_value
	from input_strings
	where
		position(',', mystring) > 0
	union all
	select
		position(',', mystring, pos) + 1,
		lim,
		cast(
			substring(
				mystring from pos for (
					position(',', mystring, pos + 1) - pos
				)
			) as int
		) as column_value
	from input_data, input_strings
	where
		pos > 0 and
		pos < lim
) select
	cast(daych.num_ch as int),
	daych.dt_day,
	cast(daych.tek as int),
	daych.data_1
from
	daych
where
	daych.dt_day between
		cast(cast(:day_begin as timestamp) as date) and
		cast(cast(:day_end as timestamp) as date) and
	daych.num_obj = cast(:objid as type of num_eninteger) and
	daych.num_device = cast(:devid as type of num_eninteger) and
	daych.num_sam = cast(:samid as type of num_eninteger) and
	daych.num_ch in (
		select column_value from input_data
		union all
		select
			cast(case position(',', mystring)
				when 0 then mystring
				else substring(mystring from
					(char_length(mystring) - position(',', reverse(mystring))) + 2
				)
			end as int) as column_value
		from input_strings
	)
order by
	daych.dt_day,
	daych.num_ch