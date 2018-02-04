select
	inputdata.group_chanid,
	vhh.stamp,
	0 as tariffid,
	sum(vhh.val * inputdata.sign) as val,
	max(
		(case reliable when 11 then 0 else 1 end)
	) as reliable
from (
	select
		inputdata.idg,
		inputdata.idcm,
		inputdata.idsub,
		inputdata.group_chanid,
		inputdata.dcid,
		inputdata.objid,
		inputdata.devid,
		inputdata.joinid,
		channels.chanid,
		inputdata.sign
	from (
		select
			inputdata.idg,
			inputdata.idcm,
			inputdata.idsub,
			inputdata.dcid,
			cons.objid,
			cons.devid,
			cons.joinid,
			inputdata.direction,
			inputdata.AR,
			inputdata.group_chanid,
			cons.sign
		from (
			select
				cast(:groupid as int) as idg,
				cast(:consumid as int) as idcm,
				cast(:subid as int) as idsub,
				cast(:dcid as int) as dcid,
				group_chanid,
				direction,
				AR
			from (
				select
					0 as group_chanid,
					1 as direction,
					0 as AR
				from dual
				union all select 1, -1, 0 from dual
				union all select 2, 1, 1 from dual
				union all select 3, -1, 1 from dual
			)
			where
				group_chanid in (
					select
						cast(regexp_substr(:chanids,'[^,]+', 1, level) as int) column_value
					from dual
					connect by
						regexp_substr(:chanids, '[^,]+', 1, level) is not null
				)
		) inputdata
		left join cons on
			cons.idg = inputdata.idg and
			cons.idcm = inputdata.idcm and
			cons.idsub = inputdata.idsub and
			cons.dcid = inputdata.dcid
	) inputdata
	left join channels on
		channels.dcid = inputdata.dcid and
		channels.objid = inputdata.objid and
		channels.devid = inputdata.devid and
		channels.joinid = inputdata.joinid and
		channels.direction = inputdata.direction and
		channels.ar = inputdata.ar
	where
		channels.enabled = 1
) inputdata
left join vhh on
	vhh.dcid = inputdata.dcid and
	vhh.objid = inputdata.objid and
	vhh.devid = inputdata.devid and
	vhh.joinid = inputdata.joinid and
	vhh.chanid = inputdata.chanid and
	vhh.stamp between
		to_date(:day_begin, 'YYYY.MM.DD HH24:MI:SS') + 1/48 and
		to_date(:day_end, 'YYYY.MM.DD HH24:MI:SS')
where val is not null
group by
	vhh.stamp,
	inputdata.idsub,
	inputdata.dcid,
	inputdata.group_chanid
order by
	vhh.stamp,
	inputdata.idsub,
	inputdata.dcid,
	inputdata.group_chanid