<?php
include("connection.php");

class Maps {
	protected $conn;
	protected $data = array();
	function __construct() {
 
		$db = new dbObj();
		$connString =  $db->getConnstring();
		$this->conn = $connString;
	}
	
	public function getMaps() {
		$sql = "SELECT * FROM Maps";
		$queryRecords = pg_query($this->conn, $sql) or die("error to fetch maps data");
		$data = pg_fetch_all($queryRecords);
		return $data;
	}
}
?>