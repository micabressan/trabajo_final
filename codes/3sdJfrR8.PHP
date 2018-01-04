<?php 
error_reporting(E_ALL) ;
ini_set('display_errors', 'On');

class APICall
{
	protected $ms;
	protected $count;
	
	function __construct()
	{
		$serverName = "sql.golos.cloud";
		$connectionOptions = array(
			"Database" => "DBGolos",
			"Uid" => "golos",
			"PWD" => "golos"
		);

		$this->ms = sqlsrv_connect( $serverName, $connectionOptions );
		if( $this->ms === false ) {
			die( FormatErrors( sqlsrv_errors()));
		}
	}
	
	function __destruct()
	{
		sqlsrv_close($this->ms);
	}
	
	public function query($params = array())
	{
		return '';
	}
}
?>