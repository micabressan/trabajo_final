--Posts by Month 

SELECT
  MONTH(created_date) AS created_month,
  SUM(total_posts) AS monthly_posts
FROM (
  SELECT
    FORMAT_UTC_USEC(SEC_TO_TIMESTAMP(created_utc)) AS created_date,
    COUNT(created_utc) AS total_posts
  FROM
    TABLE_QUERY([fh-bigquery:reddit_posts], "LEFT(table_id, 5) = '2017_'")
  GROUP BY
    created_date)
GROUP BY
  created_month
ORDER BY
  created_month ASC
  
--Posts by Month Using #StandardSQL

#standardSQL
SELECT
  _TABLE_SUFFIX AS month,
  COUNT(1) AS records
FROM
  `fh-bigquery.reddit_posts.2017_*`
GROUP BY
  month
ORDER BY
  month

--Comments by Month 
  
  SELECT
  MONTH(created_date) AS created_month,
  SUM(total_posts) AS monthly_comments
FROM (
  SELECT
    FORMAT_UTC_USEC(SEC_TO_TIMESTAMP(created_utc)) AS created_date,
    COUNT(created_utc) AS total_posts
  FROM
    TABLE_QUERY([fh-bigquery:reddit_comments], "LEFT(table_id, 5) = '2017_'")
  GROUP BY
    created_date)
GROUP BY
  created_month
ORDER BY
  created_month ASC
  
--Posts by Day

SELECT
  DAY(created_date) AS created_day,
  SUM(total_posts) AS daily_posts
FROM (
  SELECT
    FORMAT_UTC_USEC(SEC_TO_TIMESTAMP(created_utc)) AS created_date,
    COUNT(created_utc) AS total_posts
  FROM
    [fh-bigquery:reddit_posts.2017_06]
  GROUP BY
    created_date)
GROUP BY
  created_day
ORDER BY
  created_day ASC
  
--Comments by Day

SELECT
  DAY(created_date) AS created_day,
  SUM(total_comments) AS daily_comments
FROM (
  SELECT
    FORMAT_UTC_USEC(SEC_TO_TIMESTAMP(created_utc)) AS created_date,
    COUNT(created_utc) AS total_comments
  FROM
    [fh-bigquery:reddit_comments.2017_06]
  GROUP BY
    created_date)
GROUP BY
  created_day
ORDER BY
  created_day ASC