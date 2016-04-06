max_depth=`find . -type d -printf '%d\n'|sort -u|tail -n 1`

if [ $max_depth -eq 0 ]; then
  max_depth=1
fi

echo $max_depth