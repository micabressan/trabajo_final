var tla= new Float32Array(
	[
		-1,-1,-1, // triangle 1 : begin 36 vrstic = 12*3 = 36
        -1,-1, 1,
        -1, 1, 1, // triangle 1 : end
		1, 1,-1, // triangle 2 : begin
        -1,-1,-1,
        -1, 1,-1 // triangle 2 : end
	]);
	
	function constructGeometry() {
		// ustvari podatke za tla (koordinate oglišč, normale,
		// koordinate teksture)
		// uporabi constructSphere za izdelavo geometrije krogle
		// ustvari bufferje na GPU in kopiraj podatke
		bufferTrikotniki = gl.createBuffer();
		gl.bindBuffer(gl.ARRAY_BUFFER, bufferTrikotniki);
		gl.bufferData(gl.ARRAY_BUFFER, tla, gl.STATIC_DRAW);

	}

//SPODI
gl.bindBuffer(gl.ARRAY_BUFFER, bufferTrikotniki);
		gl.enableVertexAttribArray(0);
		gl.vertexAttribPointer(0, 3, gl.FLOAT, false, 6 * 3, 0);//OGLIŠČA * x,y,z
		gl.drawArrays(gl.TRIANGLES, 0, 6);//OGLIŠČA