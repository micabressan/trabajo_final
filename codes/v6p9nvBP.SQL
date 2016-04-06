WITH ranks AS (
  SELECT 
    season, row_number() over(partition by season order by season desc) "ses_row"
    , discipline, row_number() over(partition by season, discipline order by season, discipline desc) "dis_row"
    , gender, row_number() over(partition by season, discipline, gender order by season, discipline, gender desc) "gen_row"
    , name, points, rank() over(partition by season, discipline, gender order by points desc) ranking
  FROM ranking
  WHERE discipline IS NOT NULL
)
SELECT 
  CASE WHEN "ses_row" = 1 THEN TO_CHAR(season) ELSE ' ' END "season", 
  CASE WHEN "dis_row" = 1 THEN TO_CHAR(discipline) ELSE ' ' END "discipline", 
  CASE WHEN "gen_row" = 1 THEN TO_CHAR(gender) ELSE ' ' END "gender", 
  points 
  , CASE WHEN ranking IN (1, 2, 3) THEN name ELSE ' ' END "top-3"
  , CASE WHEN ranking IN (1, 2, 3, 4, 5, 6, 7) THEN name ELSE ' ' END "top-7"
  , CASE WHEN ranking IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10) THEN name ELSE ' ' END "top-10"
FROM ranks
WHERE ranking IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
ORDER BY season, discipline, gender, 4 DESC;