background yes
font zekton:size=8
xftfont zekton:size=8
use_xft yes
xftalpha 0.1
update_interval 1.0
total_run_times 0
own_window yes
own_window_type normal
own_window_transparent yes
own_window_hints undecorated,below,sticky,skip_taskbar,skip_pager
double_buffer yes
draw_shades no
draw_outline no
draw_borders no
draw_graph_borders no
minimum_size 220 5
maximum_width 220
default_color white
default_shade_color black
default_outline_color black
alignment top_right
gap_x 1
gap_y 5
no_buffers yes
cpu_avg_samples 2
override_utf8_locale yes
uppercase no # set to yes if you want all text to be in uppercase
use_spacer no
 
TEXT
SYSTEM ${hr 1 }
Hostname: $alignr$nodename
Kernel: $alignr$kernel
Uptime: $alignr$uptime
Load: ${alignr}$loadavg

CPU ${hr 1 }
Core1: ${cpu cpu0}% ${cpubar cpu0}%
Core2: ${cpu cpu1}% ${cpubar cpu1}%
Core3: ${cpu cpu2}% ${cpubar cpu2}%

RAM ${hr 1 } 
Used: ${alignr}$mem / $memmax ($memperc%)
${membar 4}
Swap: ${alignr}$swap / $swapmax ($swapperc%)
${swapbar 4}
 
Top ${hr 1 }
${top name 1}$alignr${top cpu 1}${top mem 1}
${top name 2}$alignr${top cpu 2}${top mem 2}
${top name 3}$alignr${top cpu 3}${top mem 3}
${top_mem name 1}$alignr${top_mem cpu 1}${top_mem mem 1}
${top_mem name 2}$alignr${top_mem cpu 2}${top_mem mem 2}
${top_mem name 3}$alignr${top_mem cpu 3}${top_mem mem 3}
 
FILESYSTEM ${hr 1}${color}
HDD: $alignr ${fs_used /} / ${fs_size /} ($alignr${fs_used_perc /}%)
${fs_bar 4 /}
 
NETWORK ${hr 1}${color}
D: ${downspeed eth0} ${alignr}U: ${upspeed eth0}
${downspeedgraph eth0 25,107} ${alignr}${upspeedgraph eth0 25,107}
RX: ${totaldown eth0} ${alignr}TX: ${totalup eth0}