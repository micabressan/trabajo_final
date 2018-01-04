global tour=0;
var i;
global dit=0;
var enemy = getNearestEnemy();
var name=getName(enemy);
var arme=getWeapon(enemy);
if(arme==1) arme="ton pistolet";
if(arme==2) arme="ta mitrailleuse";
if(arme==3) arme="ton double gun";
if(arme==4) arme="ton shotgun";
if(arme==5) arme="ton magnum";
if(arme==6) arme="ton laser";

if(getCellDistance(enemy, getCell()) <= ((getMP(getLeek()) + getMP(enemy))*3))    useChip(CHIP_HELMET, getLeek());


if(tour==0)    setWeapon(WEAPON_PISTOL);
if(tour==1 && dit==0 || getWeapon(enemy)!=-1 && tour==0){
    say(name +", "+arme+" ne me fais pas peur : je vais te tayer en julienne !!!");
    dit=1;
}

var portee_enemy=getWeaponMaxRange(getWeapon(enemy));
enemy = getNearestEnemy();

if(portee_enemy>=getWeaponMaxRange(getWeapon())) moveToward(enemy);
else    for (i = 1; i < 4; i++) if (getCellDistance(getCell(),getCell(enemy)) > 7) moveToward(enemy,1);

useWeapon(enemy);
useWeapon(enemy);
if(getLife()<getLife(enemy) && getLife()<getTotalLife())    useChip(CHIP_BANDAGE, getLeek());
useChip(CHIP_SPARK, enemy);


if(getTP()>0){
enemy = getNearestEnemy();
portee_enemy=getWeaponMaxRange(getWeapon(enemy));

if(portee_enemy>=getWeaponMaxRange(getWeapon())) moveToward(enemy);
else    for (i = 1; i < 4; i++) if (getCellDistance(getCell(),getCell(enemy)) > 7) moveToward(enemy,1);

useWeapon(enemy);
useWeapon(enemy);
if(getLife()<getLife(enemy) && getLife()<getTotalLife())    useChip(CHIP_BANDAGE, getLeek());
useChip(CHIP_SPARK, enemy);
}

useChip(CHIP_SHOCK, enemy);
useChip(CHIP_SHOCK, enemy);

if(portee_enemy<getWeaponMaxRange(getWeapon()))    moveAwayFrom(enemy);

if(getLife()<getTotalLife() && getLife(enemy)>0)    useChip(CHIP_BANDAGE, getLeek());

name=getName(enemy);

if(isDead(enemy))    debug("Kill "+name+"=Done !!!");

if(getTP()!=0 && tour==0)say("Vous ne perdez rien pour attendre bande de noobs !");
if(getTP()!=0 && tour==1)say("Attention j'arrive !");
if(getTP()!=0 && tour==2)say("Préparez le grand POT-AU-FEU !!!");
if(getTP()!=0 && tour==3)say("Inclinez vous devant votre DIEU : poiraxx le grand !!!");

tour++;