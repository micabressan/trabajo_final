		sf::Vector2f v = a->mVelocity - b->mVelocity;

	if (v.y > 0.f)
	{
		lineIntersection(aCenter, aCenter + v,
			sf::Vector2f(minkowsky.left, minkowsky.top),
			sf::Vector2f(minkowsky.left + minkowsky.width, minkowsky.top),
			&tfirst.y);
	}

	else if (v.y < 0.f)
	{
		lineIntersection(aCenter, aCenter + v,
			sf::Vector2f(minkowsky.left, minkowsky.top + minkowsky.height),
			sf::Vector2f(minkowsky.left + minkowsky.width, minkowsky.top + minkowsky.height),
			&tfirst.y);
	}


	if (v.x > 0.f)
	{
		lineIntersection(aCenter, aCenter + v,
			sf::Vector2f(minkowsky.left, minkowsky.top),
			sf::Vector2f(minkowsky.left, minkowsky.top + minkowsky.height),
			&tfirst.x);
	}

	else if (v.x < 0.f)
	{
		lineIntersection(aCenter, aCenter + v,
			sf::Vector2f(minkowsky.left + minkowsky.width, minkowsky.top),
			sf::Vector2f(minkowsky.left + minkowsky.width, minkowsky.top + minkowsky.height),
			&tfirst.x);
	}