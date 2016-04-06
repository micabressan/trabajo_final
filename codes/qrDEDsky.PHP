<?

// чистый PHP

// это первый класс для работы с бд

class db {

    private $mysqli ;
    private $sql = "";
    private $result;

    function __construct (  ) {

        $db = array(
            'login' => '',
            'password' => '',
            'host' => '',
            'table' => ''
        );

        $this->mysqli = new mysqli (
            $db['host'],
            $db['login'],
            $db['password'],
            $db['table']
        ) or die( $this->mysqli->connect_errno );

    }

    /**
     * @return string
     */
    public function getLastSql (  ) {

        return $this->sql;

    }

    /**
     * @param $table
     * @param $start
     * @param $per_page
     * @return bool|mysqli_result
     */
    public function paginate ( $table, $start, $per_page ) {

        $this->sql = "SELECT * FROM {$table} LIMIT {$start}, {$per_page}";

        $this->result = $this->mysqli->query ( $this->sql ) or die ( mysqli_error( $this->mysqli ) );

        return $this->result;

    }

    /**
     * @param $query NULL
     * @return bool|mysqli_result
     */
    public function free_query ( $query = null ) {

        $this->sql = $query;

        $this->result = $this->mysqli->query($this->sql) or die ( mysqli_error( $this->mysqli ) );

        return $this->result;

    }

    /**
     * @param $table
     * @return bool|mysqli_result
     */
    public function selectCount ( $table ) {

        $this->sql = "SELECT count(*) FROM {$table}";

        $this->result = $this->mysqli->query ( $this->sql ) or die ( mysqli_error( $this->mysqli ) );

        return $this->result;

    }

    /**
     * @param $table
     * @return bool|mysqli_result
     */
    public function selectAll ( $table ) {

        $this->sql      = ( "SELECT * FROM `{$table}`" );
        $this->result   = $this->mysqli->query( $this->sql ) or die( mysqli_error( $this->mysqli ) );

        return $this->result;

    }


    /**
     * @param $table
     * @param $rows
     * @param $values
     * @param $id
     */
    public function update ( $table, $rows, $values, $id ) {
        $set = "";
        $i = 0;
        for ($k = 0; $k < count($rows); $k++ ) {
            if ( $k == 17 ) {
                $set .= "`" . $rows[$k] . "`='" . $values[$i] . "'";
            } else {
                $set .= "`" . $rows[$k] . "`='" . $values[$i] . "', ";
            }
            $i++;
        }

        $this->sql      = "UPDATE `{$table}` SET " . $set . " WHERE `id`=$id LIMIT 1";

        $this->result   = $this->mysqli->query( $this->sql ) or die( mysqli_error( $this->mysqli ) );

    }

    /**
     * @param $query
     * @return array|null
     */
    public function fetch ( $query ) {

        return mysqli_fetch_assoc( $query );

    }

    /**
     * @param $table
     * @param $limitSt
     * @param $limitEn
     * @param array $rows
     * @return bool|mysqli_result
     */

    public function selectParam ( $table, $limitSt, $limitEn, $rows = array() ) {

        $this->sql      = ( ( "SELECT `" . implode( '`, `', $rows ) ) .
                             " FROM `{$table}` LIMIT {$limitSt} {$limitEn}" );
        $this->result   = $this->mysqli->query( $this->sql ) or die( mysqli_error( $this->mysqli ) );

        return $this->result;
    }

    /**
     * @param $table
     * @param array $rows
     * @return bool|mysqli_result
     */
    public function select ( $table, $rows = array() ) {

        $this->sql      = ( "SELECT `" . implode( '`, `', $rows ) . "` FROM `{$table}`" );

        $this->result   = $this->mysqli->query( $this->sql );

        return $this->result;

    }

    /**
     * @param $table
     * @param array $rows
     * @param array $values
     * @return bool|mysqli_result
     */
    public function insert ( $table, $rows = array(), $values = array() ) {

        $this->sql = ( "INSERT INTO `{$table}` ( `" . implode( '`, `', $rows ) . "`)
                        VALUES ( '" . implode( "', '", $values) . "' )" );
        //pre($this->sql);
        $this->result   = $this->mysqli->query( $this->sql ) or die( mysqli_error( $this->mysqli ) );

        return $this->result;
    }

    /**
     * @param $sqlTextSS
     * @return string
     * TODO ...
     */
    private function ss ( $sqlTextSS ) {

        return $this->mysqli->real_escape_string( $sqlTextSS );

    }

    /**
     * @param null $table
     * @return int
     */
    public function maxId ( $table = null ) {
        $this->sql      = ("SELECT Max(id) FROM {$table}");
        $this->result   = $this->mysqli->query( $this->sql);
        $this->result   = $this->result->fetch_row();
        $idM            = $this->result[0];
        $idM++;
        return $idM;
    }

    /**
     * @param $table
     */
    public function dropTable ( $table ) {

        $this->sql      = "DROPTABLE `{$table}`";
        $this->result = $this->mysqli->query( $this->sql ) or die( mysqli_error( $this->mysqli ) );

    }

}

?>