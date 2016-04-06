-------------------------------------- moja wersja --------------------------------------

/*
       p = players
       pa = player availability
       rp = ranking position
       r = reservation
       c = court
       g = games
*/  

SELECT p.Id, p.Name, rp.Position, pa.Date, pa.Hour
  FROM [VersusEntities].[dbo].[Players] p
  LEFT JOIN [VersusEntities].[dbo].[RankingPositions] rp ON p.Id = rp.PlayerId 
  LEFT JOIN [VersusEntities].[dbo].[PlayerAvailabilities] pa ON p.Id = pa.PlayerId 
  WHERE rp.Position BETWEEN 25-10 AND 25+10 
       AND rp.Position != 25 
       AND p.ClubId = 1
       AND pa.Hour IN (SELECT pa2.Hour
                                  FROM [VersusEntities].[dbo].[PlayerAvailabilities] pa2
                                  WHERE pa.Date = pa2.Date AND pa2.PlayerId = 25)

       AND pa.Hour IN (SELECT DATEPART(HOUR, r.Time)
                                  FROM [VersusEntities].[dbo].[Courts] c
                                  LEFT JOIN [VersusEntities].[dbo].[Reservations] r on r.CourtId = c.Id
                                  WHERE c.ClubId = 1
                                  GROUP BY DATEPART(HOUR, r.Time), r.Time
                                  HAVING COUNT(c.Id) < 7
                                  )

       AND pa.Hour NOT IN (SELECT DATEPART(HOUR, r2.time)
                                  FROM [VersusEntities].[dbo].[Reservations] r2
                                  LEFT JOIN [VersusEntities].[dbo].[Games] g on r2.GameId = g.Id
                                  WHERE g.PlayerAId = 25 OR g.PlayerBId = p.Id OR g.PlayerBId = 25 OR g.PlayerAId = p.Id
                                  AND r2.Time = pa.Date)


------------------------ jego wersja ---------------------------------



SELECT distinct p.Id, p.Name, p.id, rp.Position, pa1.Date, pa1.Hour
  FROM [VersusEntities].[dbo].[Players] p
  LEFT JOIN [VersusEntities].[dbo].[RankingPositions] rp ON p.Id = rp.PlayerId 
  LEFT JOIN [VersusEntities].[dbo].[PlayerAvailabilities] pa1 ON pa1.PlayerId = (select PlayerId from RankingPositions pos
                                                                                                                     join Players pla on pos.PlayerId = pla.Id
                                                                                                                     where Position = 25 and ClubId = 1) -- do przekazania w tym miejscu id gracza
  left JOIN [VersusEntities].[dbo].[PlayerAvailabilities] pa2 ON p.Id = pa2.PlayerId 
  WHERE rp.Position BETWEEN 25-10 AND 25+10 
       AND rp.Position != 25 
       AND p.ClubId = 1
       AND (pa1.Date = pa2.Date AND pa1.Hour = pa2.Hour)

       AND (SELECT count(1) FROM [VersusEntities].[dbo].[Reservations] r 
                                  JOIN [VersusEntities].[dbo].[Courts] c on r.CourtId = c.Id
                                  WHERE c.ClubId = 1
                                  and r.State = 1
                                  and DATEPART(HOUR, r.Time) = r.Time) < (select count(1) from [VersusEntities].[dbo].[Courts] c where c.ClubId = 1)

       AND not EXISTS (SELECT top(1) * 
                                  FROM [VersusEntities].[dbo].[Games] g 
                                  WHERE (g.PlayerAId = 25 OR g.PlayerBId = p.Id OR g.PlayerBId = 25 OR g.PlayerAId = p.Id)
                                  AND g.Time = pa2.Date and datepart(hour,g.Time) = pa2.Hour)