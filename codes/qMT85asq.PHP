<?php
function getTeam(){
    $qry = mysql_query("SELECT  clantrax_members.nickname as membernick,
                                clantrax_teams.name as teamname
                        FROM clantrax_members
                        INNER JOIN clantrax_teams
                        ON clantrax_teams.name ='squad 1'
                        WHERE clantrax_teams.name = 'squad 1' ORDER BY clantrax_teams.name ASC, clantrax_members.nickname ASC");
    	$tmp_array = array();
	while($result = mysql_fetch_assoc($qry)) {
        echo "<tr>";
	if(!in_array($result[teamname], $tmp_array)) {
            echo "<td>" . $result[teamname] . "</td>";
	    $tmp_array[] = $result[teamname];
	}
            
        echo "<td> <!-- ALLE NICKS UNTEREINANDER HIER --> </td>";
                
        echo "</tr>";
    }
}
?>