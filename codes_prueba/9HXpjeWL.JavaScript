function getRectangleOfCells(cell1,cell2,border){
	var operationBegin = getOperations();
	var retour = [];
	var cellX1;	var cellY1;
	var cellX2;	var cellY2;

	// les limites
		cellX1	= getCellX(cell1);	cellY1	= getCellY(cell1);
		cellX2	= getCellX(cell2);	cellY2	= getCellY(cell2);

			var minX = arraySort([cellX1,cellX2], _sortByAsc);
			var maxX = arraySort([cellX1,cellX2], _sortByDesc);
			var minY = arraySort([cellY1,cellY2], _sortByAsc);
			var maxY = arraySort([cellY1,cellY2], _sortByDesc);
			
		for(var XX =minX[0]-border; XX<=maxX[0]+border; XX++){
			for(var YY = minY[0]-border; YY<=maxY[0]+border; YY++){
				var case = getCellFromXY(XX,YY);
				if(case){
					mark(case);
					push(retour, case);
				}
			}
		}
		
	op("getRectangleOfCells", operationBegin);
	return retour;
}

function _sortByAsc(a, b) {
	if (a < b){     return -1;}
	if (a > b){     return 1;}
	return 0;
}
function _sortByDesc(a, b) {
	if (a > b){     return -1;}
	if (a < b){     return 1;}
	return 0;
}

function op(token, debut){
		debugW	(
				"[OP "+token+"] "+
				round(((getOperations()-debut) / OPERATIONS_LIMIT)*100)+"% des opérations utilisées ( "+
				(getOperations()-debut) +"op )"
				);
}