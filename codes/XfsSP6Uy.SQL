WITH raw AS (
	SELECT app.label, app.uid, ifnull(scoreWindow, 0) as scoreWindow, ifnull(dowQuery.scoreDOW,0) as scoreDOW, ifnull(scoreAll,0) as scoreAll, (ifnull(scoreWindow, 0)*3 + ifnull(scoreDOW,0)*2 + ifnull(scoreAll,0))/5 as score, sd.date
	FROM
		app,
		sampling_dates as sd
		LEFT JOIN (
			SELECT appId, CAST(COUNT(*) as float) / (
				SELECT COUNT(*) as nb FROM event where time(event.date/1000, 'unixepoch') >= time(sd.date,'-30 minutes') and time(event.date/1000, 'unixepoch') <= time(sd.date,'+30 minutes')
			) as scoreWindow, sd.date FROM event, sampling_dates as sd where time(event.date/1000, 'unixepoch') >= time(sd.date,'-30 minutes') and time(event.date/1000, 'unixepoch') <= time(sd.date,'+30 minutes')
			group by sd.date, appId
		) as windowQuery on windowQuery.appId = app.uid and windowQuery.date = sd.date
		LEFT JOIN (
			SELECT appId, CAST(COUNT(*) as float) / (
				SELECT COUNT(*) FROM event where strftime('%w', event.date/1000) = strftime('%w',sd.date)
			) as scoreDOW, sd.date as date FROM event, sampling_dates as sd where strftime('%w', event.date/1000) = strftime('%w',sd.date)
			group by sd.date, appId
		) as dowQuery on dowQuery.appId = app.uid and dowQuery.date = sd.date
		LEFT JOIN (
			SELECT appId, CAST(COUNT(*) as float) / (
				SELECT COUNT(*) FROM event
			) as scoreAll, sd.date as date FROM event, sampling_dates as sd
			group by sd.date, appId
		) as allQuery on allQuery.appId = app.uid and allQuery.date = sd.date
)
SELECT * FROM raw
WHERE raw.uid in (
	SELECT uid FROM raw
	group BY uid
	order by avg(score) desc
	LIMIT 10
)
order by uid, date ASC