$original_file = openFileEOL("/usr/home/mt2/chs/ch$channel_id/CONFIG",":");
            foreach ($original_file as $key => &$value) {
                switch($key)
                {
                    case "HOSTNAME":
                    {
                        $value = " ".$hostname;
                    }
                    break;
                    case "CHANNEL":
                    {
                        $value = " ".$channel;
                    }
                    break;
                    case "PORT":
                    {
                        $value = " ".$port;
                    }
                    break;
                    case "P2P_PORT":
                    {
                        $value = " ".$p2p_port;
                    }
                    break;
                    case "DB_PORT":
                    {
                        $value = " ".$db_port;
                    }
                    break;
                    case "MAP_ALLOW":
                    {
                        $value = " ".$map_allow;
                    }
                    break;
                    case "MALL_URL":
                    {
                        $value = " ".$mall_url;
                    }
                    break;
                    case "VIEW_RANGE":
                    {
                        $value = " ".$view_range;
                    }
                    break;
                    case "CHECK_MULTIHACK":
                    {
                        $value = " ".$check_multihack;
                    }
                    break;
                    case "MAX_LEVEL":
                    {
                        $value = " ".$max_level;
                    }
                    break;
                    case "TEST_SERVER":
                    {
                        $value = " ".$test_server;
                    }
                    break;
                }
            }
            date_default_timezone_set("Europe/Warsaw");
            $date = Date("Y-m-d(H-i-s)");
            $rename = copy("/usr/home/mt2/chs/ch$channel_id/CONFIG","/usr/home/mt2/chs/ch$channel_id/OLD_CONFIGS/CONFIG_$date");
            if ($rename) {
                $result2='';
                echo "<pre>";
                print_r($original_file);
                echo "</pre>";
                foreach ($original_file as $key => $value) {
                    if(!empty($key))
                        $result2 .= $key.':'.$value.PHP_EOL;
                        echo $key.": ".$value."<br>";
                }
                echo "<pre>";
                print_r($original_file);
                echo "</pre>";
                echo "<pre>";
                print_r($result2);
                echo "</pre>";
                exit(0);
                $write_file = file_put_contents("/usr/home/mt2/chs/ch$channel_id/CONFIG",$result2);
                if (!$write_file) {
                    $errors['WRITE_FILE'] = "Nie udało się zmienić ustawień kanału";
                }
                else {
                    $errors['WRITE_FILE'] = "Zmieniono ustawienia kanału";
                }
            }