#!/bin/bash
for i in 1 2 3 4 5
do
  php /var/www/u0060959/data/www/komexpress24.ru/bitrix/modules/primepix.merlion/service/cli.php >> /var/www/u0060959/data/www/komexpress24.ru/bitrix/modules/primepix.merlion/service/proc.log
  if [ "$SECONDS" -gt 90 ]
  then
     exit
  fi

  sleep 10
done