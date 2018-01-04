SELECT "time", id, subject, message
  FROM public.notifications
  WHERE "time" BETWEEN
(select to_timestamp(1512803882) at time zone 'UTC')
  AND
(select to_timestamp(1512805185) at time zone 'UTC'  + 1 * INTERVAL '1 second' - 1*INTERVAL '1 microsecond')
   order by "time" desc;