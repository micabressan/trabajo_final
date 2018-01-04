<?php
$rrdFile1 = dirname(__FILE__) . "/outTopic1.rrd";
$rrdFile2 = dirname(__FILE__) . "/outTopic2.rrd";
$outputPngFile = dirname(__FILE__) . "/temps.png";



$graphObj = new RRDGraph($outputPngFile);
$graphObj->setOptions(
    array(
        "--start" => "-7200",
        "--end" => "now",
        "-D",
        "--slope-mode",
        "--width" => "1200",
        "--height" => "400",
        "--step" => "60",
        "--no-gridfit", 
        "--lower-limit" => "0",
        "--upper-limit" => "30", "--rigid",
		"--right-axis" => "1:0",
		"--right-axis-format" => "%.1lf",
		"--alt-y-grid",
		"--y-grid" => "0.5:2",
		"--watermark" => date, 
        "--color" => "BACK#ecf0f1",
        "DEF:mytemp1=$rrdFile1:outTopic1:AVERAGE",
        "LINE1:mytemp1#000000",
        "AREA:mytemp1#2980b950",
        "DEF:mytemp2=$rrdFile2:outTopic2:AVERAGE",
        "LINE1:mytemp2#000000",
        "AREA:mytemp2#00000050"        
    )
);
$graphObj->save();

header('Content-Type: image/png');
readfile('/var/www/html/temps.png');

?>