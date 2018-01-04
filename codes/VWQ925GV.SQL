SELECT * FROM
 (SELECT fielddate,
         line,
         sum(suc) AS success,
         sum(unsuc) AS unsuccess,
         sum(unsuc + suc) AS total
  FROM
   (SELECT DISTINCT [IdChain],
                    [IdTask],
                    CAST(FLOOR(CAST((cast([DateTimeStart] AS smalldatetime)) AS float) * 24)/24 AS smalldatetime) AS fielddate,
                    CASE
                        WHEN (callresult = '5'
                              OR callresult = '18') THEN 1
                        ELSE 0
                    END AS suc,
                    CASE
                        WHEN (callresult != '5'
                              AND callresult != '18') THEN 1
                        ELSE 0
                    END AS unsuc
    FROM [oktell_cc_temp].[dbo].[A_Cube_CC_EffortConnections]
    WHERE isoutput = 0
     AND [DateTimeStart] >= '2017-11-01 00:00:00'
     AND idchain IS NOT NULL)AS t1
  LEFT JOIN
   (SELECT [Id] AS [IdTask],
           [Name] AS line
    FROM [oktell_cc_temp].[dbo].[A_Cube_CC_Cat_Task])AS t2 ON t2.[IdTask] = t1.[IdTask]
  GROUP BY fielddate,
           line)t1
WHERE fielddate >= '2017-11-01 00:00:00'
ORDER BY fielddate DESC


--------
--------
OKTELL_CODE
--------
--------


declare @mnog float
declare @temp1 table ( idchain uniqueidentifier, [CallResult] int, [datetimestart] datetime )
declare @temp table ( idchain uniqueidentifier,  [suc] int, [unsuc] int, [int] datetime )

select @mnog = case @interval
	when 5 then 287.999999999999
	when 15 then 95.999999999999
	when 30 then 47.999999999999
	when 60 then 23.999999999999
	else 47.999999999999  -- 30 min
	end

if (@interval is null)
	set @interval = 30
	
insert into @temp1
select	idchain, callresult, datetimestart
from [oktell_cc_temp].[dbo].[A_Cube_CC_EffortConnections] 
where isoutput = 0 
	and Datetimestart between @dt1 and @dt2 
	and TimeStart  between @tm1 and @tm2
	and IDTask = @task
	and idchain is not null
	--and ((IdOperator is null and (callresult in (13,6, 19, 23,24,26,27,30))) or IdOperator in (select id from @operators)) 
	
--select * from @temp1

		insert into @temp
		select [Idchain], [suc], [unsuc], 
		[int]
		from (
			select	distinct [Idchain],
					[suc] = case 
					when exists (select * 
								from @temp1 tt2
								where tt2.idchain = tt1.idchain
								and ([CallResult] = 5 or [CallResult] = 18)) then 1
					else null
					end,
					[unsuc] = case 
					when not exists (select * 
								from @temp1 tt2
								where tt2.idchain = tt1.idchain
								and ([CallResult] = 5 or [CallResult] = 18)) then 1
					else null
					end,
					[int] = case 						
						when @interval = 1 then cast(floor(cast (datetimestart as float)) as datetime)	
						when @interval = 7 then cast(floor(cast (datetimestart as float) - datepart (dw, datetimestart) + 1) as datetime)		
						when @interval = 12 then cast (cast(datepart (yy, datetimestart) as nvarchar (4))+'-' + cast(datepart (mm, datetimestart) as nvarchar (2)) +'-01' as datetime)
						else 	
							cast(  
								( floor( cast(datetimestart as float)*@mnog)/@mnog - 
								floor(cast(datetimestart as float)) )
								as datetime)				
						end 
										
			from	@temp1 tt1
			) tb1

--select * from @temp

select	[int] = case @interval
			when 5  then convert(nvarchar(5),[int],108) + '—' + convert(nvarchar(5),dateadd(mi,5,[int]),108)
			when 15 then convert(nvarchar(5),[int],108) + '—' + convert(nvarchar(5),dateadd(mi,15,[int]),108)
			when 30 then convert(nvarchar(5),[int],108) + '—' + convert(nvarchar(5),dateadd(mi,30,[int]),108)
			when 60 then convert(nvarchar(5),[int],108) + '—' + convert(nvarchar(5),dateadd(hh,1,[int]),108)
			when 1 then convert(nvarchar(5),[int],4) + ' ' + cast(datepart(yy,[int]) as nvarchar(4)) -- + ' г.'
			when 7 then convert(nvarchar(5),[int] ,4) + '—' + 
      							convert(nvarchar(5), dateadd(dd, 7, [int]) ,4)
      		when 12 then case datepart(mm, [int])
      					when 1 then 'Февраль '+ cast(datepart(yy, [int])as nvarchar(4))
      					when 3 then 'Март '+ cast(datepart(yy, [int])as nvarchar(4))
      					when 4 then 'Апрель '+ cast(datepart(yy, [int])as nvarchar(4))
      					when 5 then 'Май '+ cast(datepart(yy, [int])as nvarchar(4))
      					when 6 then 'Июнь '+ cast(datepart(yy, [int])as nvarchar(4))
      					when 7 then 'Июль '+ cast(datepart(yy, [int])as nvarchar(4))
      					when 8 then 'Август '+ cast(datepart(yy, [int])as nvarchar(4))
      					when 9 then 'Сентябрь '+ cast(datepart(yy, [int])as nvarchar(4))
      					when 10 then 'Октябрь '+ cast(datepart(yy, [int])as nvarchar(4))
      					when 11 then 'Ноябрь '+ cast(datepart(yy, [int])as nvarchar(4))
      					when 12 then 'Декабрь '+ cast(datepart(yy, [int])as nvarchar(4))
      					end
			else convert(nvarchar(5),[int],108) + '—' + convert(nvarchar(5),dateadd(mi,30,[int]),108)
			end, 
		count (*) [total],
		count (suc) [served],
		count (unsuc) [lost]
from @temp
group by [int]