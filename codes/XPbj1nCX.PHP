	while($row = mysql_fetch_assoc($result))
	{		
		$chart->values .= 'data.setValue(' . $count . ', 0, \'' . $row['year'] . '-' . $row['month'] . '\');';
		$chart->values .= 'data.setValue(' . $count . ', 1, ' . $row['registered'] . ');';
		$chart->values .= 'data.setValue(' . $count . ', 2, ' . $row['deregistered'] . ');';
		
		$row['month'] = month_no($row['month']);
		$stats[$count] = $row;	
		
		$count++;			
	}