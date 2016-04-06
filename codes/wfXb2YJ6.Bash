# echo −n “39” > /sys/class/gpio/unexport /* Flushing values*/

# echo −n “39” > /sys/class/gpio/export /* Starting the gpio39 */

# echo −n “out” > /sys/class/gpio/gpio39/direction /* Here we set Digital 13 as an OUTPUT */

# echo −n “strong” > /sys/class/gpio/gpio39/drive

# echo −n “1” > /sys/class/gpio/gpio39/value /* Boolean logic: 1 for HIGH and 0 for LOW*/

# cat /sys/class/gpio/gpio39/value /* Reading the raw value on gpio39 */