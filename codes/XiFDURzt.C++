void APathfinding::FindPath(FVector Start, FVector End)
{
	Node* StartNode = GridInstance->GetNodeFromLocation(Start);
	Node* EndNode = GridInstance->GetNodeFromLocation(End);

	TArray<Node*> OpenSet;
	TArray<Node*> ClosedSet;
	
	UKismetSystemLibrary::DrawDebugLine(this, Start, GridInstance->GetNodeFromLocation(End)->Location, FLinearColor::Yellow);
	
	OpenSet.Add(StartNode);
	
	while (OpenSet.Num())
	{
		
		
		Node* CurrentNode = OpenSet[0]; // Start at current cycle node

		for (int i = 0; i < OpenSet.Num(); i++)
		{
			if (OpenSet[i]->FCost() <= CurrentNode->FCost() && OpenSet[i]->HCost < CurrentNode->HCost) // Get the closest node in open set
			{
				//GEngine->AddOnScreenDebugMessage(-1, 5.f, FColor::Red, TEXT("DRAW"));
				CurrentNode = OpenSet[i];
			}
		}
		UKismetSystemLibrary::DrawDebugBox(this, CurrentNode->Location, FVector::OneVector*GridInstance->NodeSize / 2.3f, FLinearColor::White, FRotator::ZeroRotator, 0);


		OpenSet.Remove(CurrentNode);	// Remove best node from the openset
		ClosedSet.Add(CurrentNode);		// Add best node to the closedset

		if (CurrentNode == EndNode) // Triggers is our current node is the end node
		{
			
			RetracePath(StartNode, EndNode);
			break;
		}

		TArray<Node*> Neighbours = GridInstance->GetNeighbourNodes(CurrentNode); // Get the Nodes around the best node

		for (int i = 0; i < Neighbours.Num(); i++)
		{

			if (Neighbours[i]->Blocked || ClosedSet.Contains(Neighbours[i])) // If node is blocked or already in the closed set then ignore and continue
			{
				continue;
			}

			int NewMovementCostToNeighbour = CurrentNode->GCost + GetDistance(CurrentNode, Neighbours[i]);

			if (NewMovementCostToNeighbour < Neighbours[i]->GCost || !OpenSet.Contains(Neighbours[i]))
			{
				Neighbours[i]->GCost = NewMovementCostToNeighbour;
				Neighbours[i]->HCost = GetDistance(Neighbours[i], EndNode);
				Neighbours[i]->ParentNode = CurrentNode;
				
				if (!OpenSet.Contains(Neighbours[i]))
				{
					OpenSet.Add(Neighbours[i]);
				}
			}
		}
		
		
	}

}