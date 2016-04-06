var getTargetPlayer = function(target){
    var checkProcess;

    if (isNaN(target)) {
        checkProcess = function (t1, t2) {
            if (t1.name.indexOf(t2) === 0) return true;
                return false;
        };
    }
    else {
        target = parseInt(target);
        checkProcess = function (t1, t2) {
            if (t1.client.networkId === t2) return true;
                return false;
        };
    }
      
    for (var tempPlayer of g_players) {
        if (checkProcess(tempPlayer, target)) {
            target = tempPlayer;
            break;
        }
    }

    if (typeof target === "undefined") return -1;

    return target;
};