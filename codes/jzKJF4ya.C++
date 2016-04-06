	if (ruut[1] == ruut[2] && ruut[2] == ruut[3])
		return 1;
	else if (ruut[4] == ruut[5] && ruut[5] == ruut[6])
		return 1;
	else if (ruut[7] == ruut[8] && ruut[8] == ruut[9])
		return 1;
	else if (ruut[1] == ruut[4] && ruut[4] == ruut[7])
		return 1;
	else if (ruut[2] == ruut[5] && ruut[5] == ruut[8])
		return 1;
	else if (ruut[3] == ruut[6] && ruut[6] == ruut[9])
		return 1;
	else if (ruut[1] == ruut[5] && ruut[5] == ruut[9])
		return 1;
	else if (ruut[3] == ruut[5] && ruut[5] == ruut[7])
		return 1;
	else if (ruut[1] != '1' && ruut[2] != '2' && ruut[3] != '3' && ruut[4] != '4' && ruut[5] != '5' && ruut[6] != '6' && ruut[7] != '7' && ruut[8] != '8' && ruut[9] != '9')
		return 0;
	else
		return -1;