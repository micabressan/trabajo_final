SET
@health = 10,
@mana = 10,
@minlevel = 255,  
@maxlevel = 255,
@mindmg = 10,  
@maxdmg = 10,
@MapID = 548;

UPDATE creature_template
SET HealthModifier = HealthModifier * @health, ManaModifier = ManaModifier * @mana, minlevel = @minlevel, maxlevel =  @Maxlevel, mindmg = mindmg * @mindmg, @maxdmg = maxdmg * @maxdmg
WHERE entry IN (SELECT id FROM creatures WHERE map = @MapID);