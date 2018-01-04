void generation(int x, int y,int **Dungeon) {
	bool placebig = true, placed = false; int xx, yy, forc = 3, i, j, roomcount, roomcountz, plac = 0, breakpoint = 0;
	int whichroom = 0;
	if (x > y) roomcount = x; else roomcount = y;
	roomcount /= 5;
	roomcount += 5;
	roomcountz = roomcount;
	for (int b = 0; b < roomcount;) {
		xx = 1 + rand() % (x - 4);
		yy = 1 + rand() % (y - 4);
		Dungeon[xx][yy] = 2;
		b++;
	}
	while (placed == false) {
		for (i = 1; i < x - 1; i++) {
			for (j = 1; j < y - 1; j++) {
				if (Dungeon[i][j] == 2) {
					plac++;
					if (plac == roomcount) placed = true;
					if (whichroom == 0) {
						place = 1; whichroom++; roomcountz--;
					}
					else if (whichroom == 1) {
						place = 2 + rand() % forc;
						if (placebig == true && place == 4) {
							placebig = false;
							forc = 2;
						}
						roomcountz--;
						if (roomcountz == 1) {
							whichroom++;
						}
					}
					else if (whichroom == 2) {
							place = 5;
					}
					if (place == 1 || place == 2 || place == 5) volume = 3;
					else if (place == 3) volume = 7;
					else if (place == 4) volume = 14;
					for (int q = 0; q < volume; q++) {
						if (breakpoint == 1) {breakpoint = 0;  break;}
						for (int d = 0; d < volume; d++) {
							Out(x, y, Dungeon);
							if (((i + q) == x) || ((j + q) == y)) { breakpoint++; break; }
							if (place == 1 && Dungeon[i + q][j + d] != 1 && Dungeon[i + q][j + d] != 2 && Dungeon[i + q][j + d] != 3 && Dungeon[i + q][j + d] != 5 && Dungeon[i + q][j + d] != 6) Dungeon[i + q][j + d] = StartR[q][d];
							if (place == 2 && Dungeon[i + q][j + d] != 1 && Dungeon[i + q][j + d] != 2 && Dungeon[i + q][j + d] != 3 && Dungeon[i + q][j + d] != 5 && Dungeon[i + q][j + d] != 6) Dungeon[i + q][j + d] = SmallR[q][d];
							if (place == 3 && Dungeon[i + q][j + d] != 1 && Dungeon[i + q][j + d] != 2 && Dungeon[i + q][j + d] != 3 && Dungeon[i + q][j + d] != 5 && Dungeon[i + q][j + d] != 6) Dungeon[i + q][j + d] = MidR[q][d];
							if (place == 4 && Dungeon[i + q][j + d] != 1 && Dungeon[i + q][j + d] != 2 && Dungeon[i + q][j + d] != 3 && Dungeon[i + q][j + d] != 5 && Dungeon[i + q][j + d] != 6) Dungeon[i + q][j + d] = BigR[q][d];
							if (place == 5 && Dungeon[i + q][j + d] != 1 && Dungeon[i + q][j + d] != 2 && Dungeon[i + q][j + d] != 3 && Dungeon[i + q][j + d] != 5 && Dungeon[i + q][j + d] != 6) { if (ExitR[q][d] == 6) { coordx = (i + q); coordy = (j + d); } Dungeon[i + q][j + d] = ExitR[q][d]; }
						}
					}
				}
			}
		}
	}
	for (i = 1; i < x - 1; i++)
		for (j = 1; j < y - 1; j++) {
			if (Dungeon[i][j] == 2) Dungeon[i][j] = 4;
			if (Dungeon[i][j] != 4 && Dungeon[i][j] != 3 && Dungeon[i][j] != 5 && Dungeon[i][j] != 6)
				Dungeon[i][j] = 9;
		}
}