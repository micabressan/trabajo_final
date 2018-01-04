const getMeterValue = async (coil, size) => {
	// console.log("Coil: " + coil);
	// console.log("Size: " + size);

    try {	
    // read 2 16bit-registers to get one 32bit number
    	let val = await meter.readHoldingRegisters(coil, size);

        //Expected value equals ~1610.00 +- 20
        return Buffer.from(val.buffer).readUInt32BE(size);

    } catch(e){
        // if error return -1
        console.log("Error "+e);
        return -1
    } 
}