static bool HandleDebugLoadCellsCommand(ChatHandler* handler, char const* args)
{
	Player* player = handler->GetSession()->GetPlayer();
	if (!player)
		return false;

	for (uint32 cellX = 0; cellX < TOTAL_NUMBER_OF_CELLS_PER_MAP; cellX++)
		for (uint32 cellY = 0 ; cellY < TOTAL_NUMBER_OF_CELLS_PER_MAP; cellY++)
			player->SummonCreature(VISUAL_WAYPOINT, (cellX + 0.5f) * SIZE_OF_GRID_CELL, (cellY + 0.5f) * SIZE_OF_GRID_CELL, 0.f, 0.f, TEMPSUMMON_TIMED_DESPAWN, 9000);
	return true;
}