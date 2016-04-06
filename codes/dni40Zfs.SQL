WITH ranks AS (
  SELECT 
    season, row_number() over(partition by season order by season desc) "ses_row"
    , discipline, row_number() over(partition by season, discipline order by season, discipline desc) "dis_row"
    , name, points, gender, rank() over(partition by season, discipline order by points desc) ranking
  FROM ranking
  WHERE discipline IS NOT NULL
),
top3 AS (
  SELECT 
    season, discipline, gender, name, row_number() over(partition by season, discipline order by points desc) rownr,
    CASE WHEN ranking IN (1, 2, 3) THEN name ELSE ' ' END "top-3"
  FROM ranks
  WHERE ranking IN (1, 2, 3)
),
top7 AS (
  SELECT 
    season, discipline, gender, name, row_number() over(partition by season, discipline order by points desc) rownr,
    CASE WHEN ranking IN (4, 5, 6, 7, 8, 9, 10) THEN name ELSE ' ' END "top-7"
  FROM ranks
  WHERE ranking IN (4, 5, 6, 7, 8, 9, 10)
),
top10 AS (
  SELECT 
    "ses_row", "dis_row", season, discipline, gender, row_number() over(partition by season, discipline order by points desc) rownr,
    CASE WHEN ranking IN (11, 12, 13, 14, 15, 16, 17, 18, 19, 20) THEN name ELSE ' ' END "top-10"
  FROM ranks
  WHERE ranking IN (11, 12, 13, 14, 15, 16, 17, 18, 19, 20)
)
SELECT 
  -- 11 Since we start from 11 (top10)
  CASE WHEN t."ses_row" = 11 THEN TO_CHAR(t.season) ELSE ' ' END "season"
  ,CASE WHEN t."dis_row" = 11 THEN TO_CHAR(t.discipline) ELSE ' ' END "discipline"
  ,(SELECT t3.name FROM top3 t3 WHERE t.season = t3.season AND t.discipline = t3.discipline AND t.rownr = t3.rownr) "top-3"
  ,(SELECT t2.name FROM top7 t2 WHERE t.season = t2.season AND t.discipline = t2.discipline AND t.rownr = t2.rownr) "top-7"
  , t."top-10" "top-10"
FROM top10 t
ORDER BY season, discipline;