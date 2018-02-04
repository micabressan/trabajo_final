function calc(gyroX, gyroY, gyroZ, accelX, accelY, accelZ, time, timeOld){
	var gyro = (gyro, time, timeOld) => {
	   return gyro*((time-timeOld)/1000);
	};
	var speed = (acc, time, timeOld) => {
	   return acc*((time-timeOld)/1000);
	};
	var space= (acc, time, timeOld) => {
	   return acc*((Math.pow(time-timeOld)/1000), 2);
	};
	
	return {
			"tX" : gyro(gyroX, time, timeOld),
			"tY" : gyro(gyroY, time, timeOld),
			"tZ" : gyro(gyroZ, time, timeOld),
			
			"vX" : speed(accelX, time, timeOld),
			"vY" : speed(accelX, time, timeOld),
			"vZ" : speed(accelX, time, timeOld),
			
			"sX" : space(accelX, time, timeOld),
			"sY" : space(accelY, time, timeOld),
			"sZ" : space(accelZ, time, timeOld)
		};
}