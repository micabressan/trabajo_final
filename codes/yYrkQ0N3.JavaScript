numFormat = function (Num,fix) {
    if (fix==undefined) {
	fix = 2
    };
    var fractional = (Num - parseInt(Num)).toFixed(fix).toString();
    var nList = parseInt(Num).toString().split("").reverse();
    retStr = [nList[0]];
    for (i=1;i<nList.length;i++) {
	if (i%3==0) {
	    retStr.push( ",");
	}
	retStr.push(nList[i]);
    }
    return retStr.reverse().join("")+fractional.slice(1);
};