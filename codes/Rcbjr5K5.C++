Vector2D closest = Vector2D(100.0f,100.0f); 
	int count=0; 
	float Distance;
	float CurDistance = 100; 
	
	

	vector <KinematicUnit*>::iterator unitItorator; 

	for(unitItorator = listOfUnits->theUnits.begin(); unitItorator!=  listOfUnits->theUnits.end(); unitItorator++)
	{
		KinematicUnit* iterUnit = *unitItorator;
		const Vector2D& iterPos = iterUnit->getPosition();
		const Vector2D betweenVector = mpMover->getPosition() - iterPos;
		if (betweenVector.getLengthSquared() < LOCAL_RADIOUS_SQUARED)
		//if(((*unitItorator)->getPosition().getX() - mpMover->getPosition().getX())<LOCAL_RADIOUS)
		{	
			
			
			if ((*unitItorator) == mpMover){}
			else
			{
				Distance = sqrt ((pow((mpMover->getPosition().getY() - (*unitItorator)->getPosition().getY()),2) + pow(mpMover->getPosition().getX() - (*unitItorator)->getPosition().getX(),2))); 

				if(Distance<CurDistance)
				{
					closest=(*unitItorator)->getPosition(); 
					CurDistance = Distance; 
				}
			}
		}
	}