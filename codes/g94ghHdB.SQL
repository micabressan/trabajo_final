SaveRepair(i)
{
	format( QUERY, sizeof(QUERY), "UPDATE `"TABLE_REPAIR"` SET \
	`rRepairName`= '%s', `rOwnerName`= '%s', `rBank`= '%i', \
	`rLandTax`= '%i', `rProds`= '%i', `rPriceProds`= '%i', \
	`rClubOwned`= '%i', `rClubAttack`= '%i', `rPayDay`= '%i', \
	`rDeputy_1`= '%s', `rDeputy_2`= '%s', `rDeputy_3`= '%s', \
	`rMechanic_1`= '%s', `rMechanic_2`= '%s', `rMechanic_3`= '%s', `rMechanic_4`= '%s', `rMechanic_5`= '%s', \
	`rAuction_0`= '%i', `rAuction_1`= '%i', `rAuction_2`= '%i', `rAuction_3`= '%i', `rAuction_4`= '%i', `rAuction_5`= '%i', `rAuctionName`= '%s' \
	WHERE `rID` = '%i'",

	RepairInfo[i][rRepairName], RepairInfo[i][rOwnerName], RepairInfo[i][rBank],
	RepairInfo[i][rLandTax], RepairInfo[i][rProds], RepairInfo[i][rPriceProds],
	RepairInfo[i][rClubOwned], RepairInfo[i][rClubAttack], RepairInfo[i][rPayDay],
	RepairInfo[i][rDeputy_1], RepairInfo[i][rDeputy_2], RepairInfo[i][rDeputy_3],
	RepairInfo[i][rMechanic_1], RepairInfo[i][rMechanic_2], RepairInfo[i][rMechanic_3], RepairInfo[i][rMechanic_4], RepairInfo[i][rMechanic_5],
	RepairInfo[i][rAuction][0], RepairInfo[i][rAuction][1], RepairInfo[i][rAuction][2], RepairInfo[i][rAuction][3], RepairInfo[i][rAuction][4], RepairInfo[i][rAuctionName],
	RepairInfo[i][rID]);
	mysql_tquery(ServerInfo[EMySQL], QUERY, "", "");
}