#!/system/bin/sh

###
#
#  /etc/init.d script
#  For Xiaomi Redmi Note 2 (tested on Redmi Note 2 Prime + Multirom Stable 7.2.1.0)
#  Copyright (C) 2013-2016 BrateloSlava, 4pda.ru + XDA
#
#  This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or (at your option) any later version. 
#  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#  You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
###

###
#
#  RN2 freq
# (1950000) /* KHz */
# (1781000) /* KHz */
# (1625000) /* KHz */
# (1469000) /* KHz */
# (1326000) /* KHz */
# (1183000) /* KHz */
# (806000) /* KHz */
# (403000) /* KHz */
#
#  RN2 Prime freq
# (2158000) /* KHz */
# (1885000) /* KHz */
# (1664000) /* KHz */
# (1482000) /* KHz */
# (1326000) /* KHz */
# (1183000) /* KHz */
# (806000) /* KHz */
# (403000) /* KHz */
#
###

file_if_exists () { if [ -r $2 ]; then echo $1 > $2; fi; }
file_if_exists_append () { if [ -r $2 ]; then echo $1 >> $2; fi; }
file_if_exists_chmod () { if [ -r $2 ]; then chmod 644 $2; echo $1 > $2; chmod 444 $2; fi; }

### detect XRN2 version (Prime or not)
if grep "2158000" /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies ; then
	isPrime=1
else
	isPrime=0
fi	

### Config

CPU_min_freq="403000"
if [ $isPrime ]
then
	## XRN2 Prime
	CPU_max_freq="2158000"
else	
	## XRN2
	CPU_max_freq="1950000"
fi	
CPU_governor="interactive"

MC_Power_Save="2"

### I/O scheduler
if [ $isPrime ]
then
	IO_SCH="deadline"
else
	IO_SCH="cfq"
fi

READ_AHEAD_KB="512"

### TCP Congestion Algorithm
TCP_Algorithm="cubic"
#TCP_Algorithm="reno"

### Tweak Entropy
## 64 default. choose from: 64, 128, 256, 512, 1024, 2048
Random_RWT="2048"
## 128 default. choose from: 128, 256,512, 1024, 2048, 4096
Random_WWT="4096"

### /Config

###############################################################################
######################            BEGIN            ############################
###############################################################################

sleep 3

while [ ""`getprop sys.boot_completed` != "1" ] ; do sleep 1; done

sleep 15

### Cache dropping
sync;
file_if_exists "3" "/proc/sys/vm/drop_caches";
sleep 1;
file_if_exists "0" "/proc/sys/vm/drop_caches";
sleep 1

### Set CPU Config
for i in /sys/devices/system/cpu/cpu?; do
	echo 1 > $i/online;
	echo $CPU_min_freq > $i/cpufreq/scaling_min_freq;
	echo $CPU_max_freq > $i/cpufreq/scaling_max_freq;
	echo $CPU_governor > $i/cpufreq/scaling_governor;
done
sleep 3

### Interactive governor-specific settings
if [ $isPrime ]
then
	## XRN2 Prime
	file_if_exists "85 1664000:90 1885000:70" "/sys/devices/system/cpu/cpufreq/interactive/target_loads"
	file_if_exists "20000 1326000:40000 1664000:20000" "/sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay"
	file_if_exists "90" "/sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load"
	file_if_exists "806000" "/sys/devices/system/cpu/cpufreq/interactive/hispeed_freq"
	file_if_exists "80000" "/sys/devices/system/cpu/cpufreq/interactive/boostpulse_duration"
	file_if_exists "30000" "/sys/devices/system/cpu/cpufreq/interactive/timer_rate"
	file_if_exists "20000" "/sys/devices/system/cpu/cpufreq/interactive/timer_slack"
	file_if_exists "40000" "/sys/devices/system/cpu/cpufreq/interactive/min_sample_time"
else
	## XRN2
	file_if_exists "85 1625000:90 1781000:70" "/sys/devices/system/cpu/cpufreq/interactive/target_loads"
	file_if_exists "20000 1326000:40000 1625000:20000" "/sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay"
	file_if_exists "90" "/sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load"
	file_if_exists "806000" "/sys/devices/system/cpu/cpufreq/interactive/hispeed_freq"
	file_if_exists "80000" "/sys/devices/system/cpu/cpufreq/interactive/boostpulse_duration"
	file_if_exists "30000" "/sys/devices/system/cpu/cpufreq/interactive/timer_rate"
	file_if_exists "20000" "/sys/devices/system/cpu/cpufreq/interactive/timer_slack"
	file_if_exists "40000" "/sys/devices/system/cpu/cpufreq/interactive/min_sample_time"
fi	

### Multi-Core Power Saving
file_if_exists_chmod $MC_Power_Save "/sys/devices/system/cpu/sched_mc_power_savings"