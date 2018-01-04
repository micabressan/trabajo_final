TArray<Node*> AGrid::GetNeighbourNodes(Node* CurrentNode)
{
	TArray<Node*> Neighbours;
	for (int x = -1; x < 1; x++)
	{
		for (int z = -1; z < 1; z++)
		{
			for (int y = -1; y < 1; y++)
			{
				if (x == 0 && z == 0 && y == 0)
				{
					continue;
				}

				if (CurrentNode->GridX + x >= 0 && CurrentNode->GridZ + z >= 0 && CurrentNode->GridY + y >= 0)
				{
					
					
					Neighbours.Add(NodeGrid[CurrentNode->GridX + x][CurrentNode->GridZ + z][CurrentNode->GridY + y]);
				}
			}
		}
	}

	return Neighbours;
}