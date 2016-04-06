// before
$query = "SELECT Places.id
FROM Places
LEFT JOIN Clients ON (Clients.id = Places.client_id)
LEFT JOIN ClientSubGroups ON (ClientSubGroups.id = Clients.group_id)
WHERE Clients.balancing_group_id = '" . $id . "' ".$andWhere."
";

//after
$query = "SELECT Places.id
FROM Places
LEFT JOIN Clients ON (Clients.id = Places.client_id)
LEFT JOIN ClientSubGroups ON (ClientSubGroups.id = Clients.group_id)
WHERE (Clients.balancing_group_id = '" . $id . "' or ClientSubGroups.balancing_group_id = '" . $id . "') ".$andWhere."
";