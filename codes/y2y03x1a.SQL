WITH base 
     AS (SELECT hash_msisdn, 
                fdt, 
                tdt, 
                startstid, 
                stopstid, 
                day, 
                CASE 
                  WHEN ( Unix_timestamp(fdt) - Unix_timestamp(Lag(tdt, 1) 
                                               OVER( 
                                                 partition BY hash_msisdn 
                                                 ORDER BY fdt)) ) / 60 <= 25 
                THEN 0 
                  ELSE 1 
                END AS t 
         FROM   metro 
         WHERE  metro.day IN ( '2017-11-15', '2017-11-16', '2017-11-17', 
                               '2017-11-18' 
                               , 
                               '2017-11-19', '2017-11-20', '2017-11-21', 
                               '2017-11-22' 
                               , 
                               '2017-11-23', '2017-11-24', '2017-11-25', 
                               '2017-11-26' 
                               , 
                               '2017-11-27', '2017-11-28', '2017-11-29', 
                               '2017-11-30' 
                               , 
                               '2017-12-01', '2017-12-02', '2017-12-03', 
                               '2017-12-04' 
                               , 
                               '2017-12-05', '2017-12-06', '2017-12-07', 
                               '2017-12-08' 
                               , 
                               '2017-12-09', '2017-12-10', '2017-12-11', 
                               '2017-12-12' 
                               , 
                               '2017-12-13', '2017-12-14', '2017-12-15', 
                               '2017-12-16' 
                             )), 
     b 
     AS (SELECT *, 
                Sum(t) 
                  OVER ( 
                    partition BY hash_msisdn 
                    ORDER BY fdt) AS cumsum 
         FROM   base), 
     pre 
     AS (SELECT hash_msisdn, 
                First_value(startstid) 
                  OVER ( 
                    partition BY hash_msisdn, cumsum 
                    ORDER BY fdt)      AS first_st, 
                First_value(fdt) 
                  OVER ( 
                    partition BY hash_msisdn, cumsum 
                    ORDER BY fdt)      AS first_FDT, 
                First_value(stopstid) 
                  OVER ( 
                    partition BY hash_msisdn, cumsum 
                    ORDER BY fdt DESC) AS last_st, 
                First_value(tdt) 
                  OVER ( 
                    partition BY hash_msisdn, cumsum 
                    ORDER BY fdt DESC) AS last_TDT, 
                day 
         FROM   b), 
     fin 
     AS (SELECT hash_msisdn, 
                first_st, 
                last_st, 
                first_fdt, 
                last_tdt, 
                From_unixtime(Unix_timestamp(first_fdt, 'yyyy-MM-dd'), 'u') AS 
                day_n, 
                Hour(first_fdt)                                             AS 
                f_hr, 
                CASE 
                  WHEN Hour(first_fdt) <= 12 THEN 'am' 
                  ELSE 'pm' 
                END                                                         AS 
                day_part, 
                day 
         FROM   pre 
         GROUP  BY hash_msisdn, 
                   first_st, 
                   last_st, 
                   first_fdt, 
                   last_tdt, 
                   From_unixtime(Unix_timestamp(first_fdt, 'yyyy-MM-dd'), 'u'), 
                   Hour(first_fdt), 
                   CASE 
                     WHEN Hour(first_fdt) <= 12 THEN 'am' 
                     ELSE 'pm' 
                   END, 
                   day), 
     f2 
     AS (SELECT hash_msisdn, 
                first_st, 
                day_part, 
                Count(*) AS cnt 
         FROM   fin 
         GROUP  BY hash_msisdn, 
                   first_st, 
                   day_part), 
     f3 
     AS (SELECT *, 
                Row_number() 
                  OVER ( 
                    partition BY hash_msisdn, day_part 
                    ORDER BY cnt DESC) AS rn 
         FROM   f2) 

CREATE TABLE sandbox.tmp_work_home AS
SELECT 			hash_msisdn, 
                first_st, 
                day_part, 
				cnt,
				rn
FROM   f3 
WHERE  rn = 1 and cnt > 5