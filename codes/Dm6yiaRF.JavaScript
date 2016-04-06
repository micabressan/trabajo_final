/**
Renvoie le rectangle des cells
@return array
*/
function getRectangleOfCells(cell1,cell2,border){
	var operationBegin = getOperations();

	var cellX1;	var cellY1;
	var cellX2;	var cellY2;

	// les limites
		cellX1	= getCellX(cell1);	cellY1	= getCellY(cell1);
		cellX2	= getCellX(cell2);	cellY2	= getCellY(cell2);
			var minX = function() { var c = [cellX1,cellX2];	c = arrayMin(c);	return c[0]; };
			var maxX = function() { var c = [cellX1,cellX2];	c = arrayMax(c);	return c[0]; };
			var minY = function() { var c = [cellY1,cellY2];	c = arrayMin(c);	return c[0]; };
			var maxY = function() { var c = [cellY1,cellY2];	c = arrayMax(c);	return c[0]; };
		debug(minX+" "+maxX+" "+minY+" "+maxY);
		for(var XX =minX; XX<maxX; XX++){
			for(var YY = minY; YY<maxY; YY++){
				var case = getCellFromXY(XX,YY);
				if(case){
					mark(case);
				}
			}
		}
		
	if(_debugSensorCell){	op("getRectangleOfCells", operationBegin);}

}