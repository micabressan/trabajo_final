var isPlayerInRangeOfPoint = function(player, range, x, y ,z){

    x -= player.position.x;
    y -= player.position.y;
    z -= player.position.z;

    return ((x * x) + (y * y) + (z * z) < (range * range));
};