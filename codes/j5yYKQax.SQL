select currTime, nextTime, Id, DATEDIFF ( second , currTime , nextTime )  AS Duration
from (
    select Id, 
           StartDate as currTime,
           lead(StartDate) over (order by Id) as nextTime
    from [sfc_v2].[dbo].[Activity]
) as t
where Id = 1;