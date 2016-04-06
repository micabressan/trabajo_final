#!/bin/bash

#addresse, get aktuell
location_addr="www.zamg.ac.at/cms/de/wetter/wetter-oesterreich/wien/"

#get heute nachmittag
hnachm_addr="$(echo $location_addr)"heute_nachmittag/
wget -O $HOME/.config/conkyweather/hnachm_raw "$hnachm_addr"

#get morgen nachmittag
mnachm_addr="$(echo $location_addr)"morgen_nachmittag/
wget -O $HOME/.config/conkyweather/mnachm_raw "$mnachm_addr"

#get uebermorgen
uemorgen_addr="$(echo $location_addr)"uebermorgen/
wget -O $HOME/.config/conkyweather/uemorgen_raw "$uemorgen_addr"

#get trend1
trend1_addr="$(echo $location_addr)"trend1/
wget -O $HOME/.config/conkyweather/trend1_raw "$trend1_addr"

#get trend2
trend2_addr="$(echo $location_addr)"trend2/
wget -O $HOME/.config/conkyweather/trend2_raw "$trend2_addr"

rm -f $HOME/.config/conkyweather/*_img.png

if [[ -s $HOME/.config/conkyweather/hnachm_raw ]]; then

  sed -i '/olimg/,/symbL/!d' $HOME/.config/conkyweather/hnachm_raw
  sed -i -e '1s/.*src="//' -e '1s/" title.*//' -e '2s/.*title="Wien, //' -e '2s/"><a.*//' $HOME/.config/conkyweather/hnachm_raw
  sed -i '1s/" wi.*Wien: /\
/' $HOME/.config/conkyweather/hnachm_raw
  sed -i 's/&deg;/°C/g' $HOME/.config/conkyweather/hnachm_raw
  date +%A >> $HOME/.config/conkyweather/hnachm_raw
  hnachm_img=$(sed -n 1p $HOME/.config/conkyweather/hnachm_raw)
  wget -O $HOME/.config/conkyweather/hnachm_img.png $hnachm_img
fi

if [[ -s $HOME/.config/conkyweather/mnachm_raw ]]; then

  sed -i '/olimg/,/symbL/!d' $HOME/.config/conkyweather/mnachm_raw
  sed -i -e '1s/.*src="//' -e '1s/" title.*//' -e '2s/.*title="Wien, //' -e '2s/"><a.*//' $HOME/.config/conkyweather/mnachm_raw
  sed -i '1s/" wi.*Wien: /\
/' $HOME/.config/conkyweather/mnachm_raw
  sed -i 's/&deg;/°C/g' $HOME/.config/conkyweather/mnachm_raw
  date --d="+1 Day" +%A >> $HOME/.config/conkyweather/mnachm_raw
  mnachm_img=$(sed -n 1p $HOME/.config/conkyweather/mnachm_raw)
  wget -O $HOME/.config/conkyweather/mnachm_img.png $mnachm_img
fi

if [[ -s $HOME/.config/conkyweather/uemorgen_raw ]]; then

  sed -i '/olimg/,/symbL/!d' $HOME/.config/conkyweather/uemorgen_raw
  sed -i -e '1s/.*src="//' -e '1s/" title.*//' -e '2s/.*title="Wien, //' -e '2s/"><a.*//' $HOME/.config/conkyweather/uemorgen_raw
  sed -i '1s/" wi.*Wien: /\
/' $HOME/.config/conkyweather/uemorgen_raw
  sed -i 's/&deg;/°C/g' $HOME/.config/conkyweather/uemorgen_raw
  date --d="+2 Days" +%A >> $HOME/.config/conkyweather/uemorgen_raw
  uemorgen_img=$(sed -n 1p $HOME/.config/conkyweather/uemorgen_raw)
  wget -O $HOME/.config/conkyweather/uemorgen_img.png $uemorgen_img
fi

if [[ -s $HOME/.config/conkyweather/trend1_raw ]]; then

  sed -i '/olimg/,/symbL/!d' $HOME/.config/conkyweather/trend1_raw
  sed -i -e '1s/.*src="//' -e '1s/" title.*//' -e '2s/.*title="Wien, //' -e '2s/"><a.*//' $HOME/.config/conkyweather/trend1_raw
  sed -i '1s/" wi.*Wien: /\
/' $HOME/.config/conkyweather/trend1_raw
  sed -i 's/&deg;/°C/g' $HOME/.config/conkyweather/trend1_raw
  date --d="+3 Days" +%A >> $HOME/.config/conkyweather/trend1_raw
  trend1_img=$(sed -n 1p $HOME/.config/conkyweather/trend1_raw)
  wget -O $HOME/.config/conkyweather/trend1_img.png $trend1_img
fi

if [[ -s $HOME/.config/conkyweather/trend2_raw ]]; then

  sed -i '/olimg/,/symbL/!d' $HOME/.config/conkyweather/trend2_raw
  sed -i -e '1s/.*src="//' -e '1s/" title.*//' -e '2s/.*title="Wien, //' -e '2s/"><a.*//' $HOME/.config/conkyweather/trend2_raw
  sed -i '1s/" wi.*Wien: /\
/' $HOME/.config/conkyweather/trend2_raw
  sed -i 's/&deg;/°C/g' $HOME/.config/conkyweather/trend2_raw
  date --d="+4 Days" +%A >> $HOME/.config/conkyweather/trend2_raw
  trend2_img=$(sed -n 1p $HOME/.config/conkyweather/trend2_raw)
  wget -O $HOME/.config/conkyweather/trend2_img.png $trend2_img
fi