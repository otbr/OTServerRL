local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
--setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_EARTH)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, 0, -50, 0, -75)

function onUseWeapon(cid, var)
	local healthAfter
	local target = variantToNumber(var)
	local maxHealth = getCreatureHealth(target)
	local ret = doCombat(cid, combat, var)
	print("You've hit a : " .. getCreatureName(target) .. " -- "..getCreatureName(cid))
	if(ret == false) then
		return false
	end

	if (variantToNumber(var) == 0) then
		healthAfter = maxHealth
	else
		healthAfter = getCreatureHealth(target)	
	end
	
	--Apply Life Steal or Mana Leech
	applyLSorML(cid, healthAfter, maxHealth, target)
	return true
end
