fighter = {}

function fighter.getBaseHP(cardType)
	return cardType.baseHP
end

function fighter.getBaseATK(cardType)
	return cardType.baseATK
end

function fighter.getBaseStat(cardType)
	return fighter.getBaseHP(cardType), fighter.getBaseATK(cardType)
end


function fighter.attack(selfCardID, selfCardType, enemyCardID, enemyCardType, atk)
	if selfCardType.isModified["attack"] then
		selfCardType.attack(selfCardID, selfCardType, enemyCardID, enemyCardType, atk)
	else
		fighter.onHit(enemyCardID, enemyCardType, selfCardID, selfCardType, atk)
		selfCardID["flags"].canAttack = false
	end
end

function fighter.onHit(selfCardID, selfCardType, enemyCardID, enemyCardType, atk)
	if selfCardType.isModified["onHit"] then
		return selfCardType.onHit(selfCardID, selfCardType, enemyCardID, enemyCardType, atk)
	else
		selfCardID.HP = selfCardID.HP - atk
		if selfCardID.HP < 1 then
			return fighter.onDeath(selfCardID, selfCardType, enemyCardID, enemyCardType, atk)
		end
	end
end

function fighter.onDeath(selfCardID, selfCardType, enemyCardID, enemyCardType, atk)
	if selfCardType.isModified["onDeath"] then
		selfCardType.onDeath(selfCardID, selfCardType, enemyCardID, enemyCardType, atk)
	else
		for i, v in ipairs(playerField) do
			if v == selfCardID then
				table.remove(playerField, i)
				return true
			end
		end
		for i, v in ipairs(enemyField) do
			if v == selfCardID then
				table.remove(enemyField, i)
				return true
			end
		end
	end
end

function fighter.onSpawn(selfCardID, selfCardType)
	if selfCardType.isModified["onSpawn"] then
		selfCardType.onSpawn(selfCardID, selfCardType)
	end
end

function fighter.onEndSelfTurn(selfCardID, selfCardType)
	if selfCardType.isModified["onEndSelfTurn"] then
		selfCardType.onEndSelfTurn(selfCardID, selfCardType)
	else
		selfCardID["flags"].canAttack = true
	end
end

function fighter.onEndEnemyTurn(selfCardID, selfCardType)
	if selfCardType.isModified["onEndEnemyTurn"] then
		selfCardType.onEndEnemyTurn(selfCardID, selfCardType)
	end
end