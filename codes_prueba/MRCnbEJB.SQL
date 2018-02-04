SELECT Avg(metrics.`dom ready time (ms)`), 
       Count(metrics.`dom ready time (ms)`) 
FROM   browser_records 
WHERE  pagename REGEXP "www.gobear.com/.*/insurance/travel/quote-online.*" 
       AND metrics.`dom ready time (ms)` > 1 
       AND metrics.`dom ready time (ms)` < 45000 
       AND device LIKE "mobile & tablets"