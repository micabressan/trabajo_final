var Pattern = function (enemy, type, nProjectiles, scope, cadency, vel) {
  this.enemy = enemy;
  this.nProjectiles = nProjectiles;
  this.scope = scope;
  this.cadency = cadency;
  this.type = type;
  this.vel = vel;
  this.patterns = [];
  this.patterns.push({"Wave" :function() {
    let initialAngle = (Math.PI - scope) /2;
    let finalAngle = initialAngle + scope;
    let incr = scope/this.nProjectiles;
    for (var i = initialAngle; i < finalAngle; i+= incr) {
      var vx = Math.cos(i);
      var vy = Math.sin(i);
      enemy.createBullet(vx*this.vel, vy*this.vel);
    }
  }});
  this.patterns.push({ "Spring" : function () {
    this.initialAngle = (Math.PI - scope)/2;
    this.finalAngle = initialAngle + scope;
    this.incr = scope/this.nProjectiles;
    this.theta > this.finalAngle ? this.theta -= this.incr : this.theta += this.incr;
    let vx = Math.cos(this.theta);
    let vy = Math.sin(this.theta);

    enemy.createBullet(vx*this.vel, vy*this.vel);

  }});
  this.changePatternTo = function (newType) {
    /*TODO: this function has to:
      - Set last pattern attributes to null
      - Initialize the new pattern attributes
     */
     /* set last pattern attrs to null
     switch (this.type) {
       case expression:

         break;   
       default:

     }
     */
     /*Initialize new attrs.
     switch (newType) {
       case Wave:

         break;
       default:

     }
     */
  }
  this.tick = function(type){
    if (type !== this.type)
      this.changePatternTo(type);
    this.patterns.find(type).value();
  };
};

function inRadians(degrees) {
  return (degrees*Math.PI/180);
}

module.exports = Pattern;