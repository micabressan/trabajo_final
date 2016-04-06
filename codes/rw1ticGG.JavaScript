
/**
Renvoie le rectangle des cells
@op ~TROP
@return array
*/
function getCouloirOfCells(cell1,cell2,width){
	var operationBegin = getOperations();
	var ligne 		= [];
	var cellX1;	var cellY1;
	var cellX2;	var cellY2;
	var dist;
	var dx;
	var dy;
	var degrees	=0;
	// le vecteur
		if (cell1 == cell2){	return [];	}

			push(ligne, cell1);		push(ligne, cell2);
			
			cellX1	= getCellX(cell1);	cellY1	= getCellY(cell1);
			cellX2	= getCellX(cell2);	cellY2	= getCellY(cell2);
			var difX 		= cellX2 - cellX1;
			var difY 		= cellY2 - cellY1;
				dist 	= round(getDistance(cell1, cell2));
				dx 		= difX / dist;
				dy 		= difY / dist;
				
			var vecteurCouloirX = cellX2 - cellX1;
			var vecteurCouloirY = cellY2 - cellY1;
			var vecteurPerpendiculaireX = 0 - vecteurCouloirY +0.000001;
			var vecteurPerpendiculaireY = vecteurCouloirX;
			//degrees = getAngle(cell1,cell2);
			//debug(degrees);
		for (var i = 1; i <= dist; i++) {
			// la ligne de base
				var cellLineX = round(getCellX(cell1) + dx * i);
				var cellLineY = round(getCellY(cell1) + dy * i);
				var cell = getCellFromXY(cellLineX, cellLineY);
				push(ligne, cell);
				mark(cell, COLOR_BLUE);
			// les cases perpendiculaires
				// on va chercher la cell correspondant
					if(width >0){
					var cellWidthX;
					var cellWidthY;
					var cellWidth;
						var ratioVecteur = vecteurPerpendiculaireY/vecteurPerpendiculaireX;
						for(var x=0;x<=width;x=x+0.15){
								cellWidthX = floor(cellLineX + x);
								cellWidthY = floor(cellLineY + ratioVecteur*x);
								cellWidth = getCellFromXY(cellWidthX, cellWidthY);
								if(cellWidth and !inArray(ligne, cellWidth)){push(ligne, cellWidth);}
mark(cellWidth, COLOR_RED);
								cellWidthX = floor(cellLineX - x);
								cellWidthY = floor(cellLineY - ratioVecteur*x);
								cellWidth = getCellFromXY(cellWidthX, cellWidthY);
								if(cellWidth and !inArray(ligne, cellWidth)){push(ligne, cellWidth);}
mark(cellWidth, COLOR_GREEN);
						}
					}
					mark(cell);
pause();
			
		}
		
	if(_debugSensorCell){	op("getCouloirOfCells", operationBegin);}
	return ligne;
}