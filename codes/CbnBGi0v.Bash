#! /bin/bash
# scp tppcal.cgi webcore@tpp2-dev:/var/www/tppcal
# requires kbashlib

. kbashlib
year="${FORM_year:-$(date +%Y)}"
month="${FORM_month:-$(date +%m)}"
if [ -n "$FORM_day" ]; then day="$FORM_day"
elif [ -n "$FORM_month" ]; then day=01
else day=$(date +%d)
fi
startday="${FORM_startday:-0}"     # View starts on day of week (0..6); 0=Sun
colweeks="${FORM_weeks:-5}"        # number of weeks to display

day_param=$(date +%w -d "$year-$month-$day")
day_start_offset=$((startday - day_param))
let 'day_start_offset > 0' && let 'day_start_offset -= 7'

day_start=$(date +%s -d "$year-$month-$day $day_start_offset days")
nweek_start=$(date +%V -d @$day_start)

nl=$'\n'
echo "Content-type:text/html$nl"

echo "<body><head><title>TPPcal for $year-$month-$day, $colweeks weeks</title><style type='text/css'>table.tppcal tr.daysrow td.label {text-align: left} table.tppcal {border:solid; border-width:1px} table.tppcal tr td {border:solid; border-width:1px; border-color: #888888; text-align: center} table.tppcal tr.daysrow td.dw6,td.dw0 {background-color:#aaa}</style></head><body>" #DEBUG

################################# Months row
html_months_row="<tr class=monthsrow>"

################################# Days row
monthlabel () {
    [ $colspan == 0 ] && return
    local monthformat
    let 'colspan > 2' && monthformat="%B %Y" || monthformat="%b"
    local monthlabel=$(date -d @$((sday - 86400)) +"$monthformat")
    html_months_row="$html_months_row<td colspan=$colspan>$monthlabel"
}

html_days_row="<tr class=daysrow><td class=label>Employee"
w=0; colspan=1
while let 'w < colweeks'; do
    d=0
    while let 'd < 7'; do
	sday=$(( (w * 7 + d) * 86400 + $day_start))
	nday=$(date -d @$sday +%-d)
	html_days_row="$html_days_row<td class=dw$(( (d + startday) %7))>$nday"
	if [ $nday == 1 ] && [ x$d$w != x00 ] ; then # month change!
	    monthlabel
	    colspan=0
	fi
	let d++; let colspan++
    done
    let w++
done
let 'sday += 86400'
monthlabel

################################# Weeks row
html_weeks_row="<tr class=weeksrow><td class=label>"
w=0
while let 'w < colweeks'; do
    nweek=$((nweek_start + w))
    html_weeks_row="$html_weeks_row<td colspan=7>Week $nweek"
    let w++
done

################################# Header
echo "<!DOCTYPE html>$nl<table class=tppcal>
$html_months_row$nl$html_weeks_row$nl$html_days_row"

################################# Contents

################################# Footer
echo "</table>"