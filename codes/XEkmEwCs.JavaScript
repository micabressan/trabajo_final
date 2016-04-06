// JavaScript rounding functions
function round(x) { return x>0 ? x+0.5|0 : x-0.5|0 }
function roundN(x) { return x-0.5|0 }
function roundP(x) { return x+0.5|0 }

function floor(x) { return x>0 ? x|0 : x-1|0 }
function floorN(x) { return x-1|0 }
function floorP(x) { return x|0 }

function ceil(x) { return x>0 ? x+1|0 : x|0 }
function ceilN(x) { return x|0 }
function ceilP(x) { return x+1|0 }