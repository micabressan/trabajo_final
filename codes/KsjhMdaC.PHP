<?php 
	date_default_timezone_set('America/Danmarkshavn');
	class StartupCJ {
		public $json_trade = "top.html";
		public $cj_page = 'i.php';
		public $cloak_page = 'c.php';
		public $tds_redirect = '';

		public $use_cloak = true;
		
		function __construct() {

			

			if ($this->use_cloak) {

				if (isset($_SERVER["HTTP_REFERER"])) {

					$url = parse_url($_SERVER["HTTP_REFERER"]);
					
					if (isset($url['host'])) {


						$db_trader = file_get_contents($this->json_trade);
						$db_trader_arr = json_decode($db_trader); 
						$db_trader_arr = array_diff($db_trader_arr, array(''));
						$main_host = str_replace("www.", "", $_SERVER['SERVER_NAME']);
						$referer = str_replace("www.", "", $url['host']);
						$count = array_search($referer, $db_trader_arr);
						if ($count>0 and $main_host!=$referer) {
							$count = null;
							$sql = null;
							$dbh = null;
							$this->startCJ();
						} else {
							$count = null;
							$sql = null;
							$dbh = null;
							$this->startCloak();	
						}

					} else {
						$this->startCloak();
					}

				} else {
					$this->startCloak();
				}

			} else {
				$this->startCJ();
			}
		}

		public function startCJ() {
			// require $this->cj_page;
			echo "main";
		}

		public function startCloak() {
			// require $this->cloak_page;
			echo "clock";
		}

		public function startTDS() {
			header('Location: '.$this->tds_redirect);
		}
	}

	new StartupCJ;
?>