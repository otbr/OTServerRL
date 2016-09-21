local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)		NpcSystem.parseParameters(npcHandler)
local talkState = {}
function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)		end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)		end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()					npcHandler:onThink()			end	
local shopModule = ShopModule:new()					npcHandler:addModule(shopModule)

shopModule:addBuyableItem({'wand of voodoo', 'voodoo'},		8922, 22000,	'wand of voodoo')
shopModule:addBuyableItem({'wand of inferno', 'inferno'},		2187, 15000,	'wand of inferno')
shopModule:addBuyableItem({'wand of decay', 'decay'},			2188, 5000,	'wand of decay')
shopModule:addBuyableItem({'wand of draconia', 'plague'},		8921, 7500,	'wand of draconia')
shopModule:addBuyableItem({'wand of starstorm', 'starstorm'},		8920, 18000,	'wand of starstorm')
shopModule:addBuyableItem({'wand of cosmic energy', 'cosmic'},		2189, 10000,	'wand of cosmic energy')
shopModule:addBuyableItem({'wand of vortex', 'vortex'},			2190, 500,	'wand of vortex')
shopModule:addBuyableItem({'wand of dragonbreath', 'dragon'},		2191, 1000,	'wand of dragonbreath')
shopModule:addBuyableItem({'northwind rod', 'northwind'},		8911, 7500,	'northwind rod')
shopModule:addBuyableItem({'underworld rod', 'underworld'},		8910, 22000,	'underworld rod')
shopModule:addBuyableItem({'hailstorm rod', 'hailstorm rod'},		2183, 15000,	'hailstorm rod')
shopModule:addBuyableItem({'terra rod', 'terra'},			2181, 10000,	'terra rod')
shopModule:addBuyableItem({'snakebite rod', 'snakebite'},		2182, 500,	'snakebite rod')
shopModule:addBuyableItem({'necrotic rod', 'necrotic'},			2185, 5000,	'necrotic rod')
shopModule:addBuyableItem({'moonlight rod', 'moonlight'},		2186, 1000,	'moonlight rod')
shopModule:addBuyableItem({'springsprout rod', 'springsprout'},		8912, 18000,	'springsprout rod')
shopModule:addBuyableItem({'ultimate health potion', 'uhp'},		8473, 310,	'ultimate health potion')
shopModule:addBuyableItem({'great health potion', 'ghp'},		7591, 190,	'great health potion')
shopModule:addBuyableItem({'strong health potion', 'shp'},		7588, 100,	'strong health potion')
shopModule:addBuyableItem({'health potion', 'hp'},			7618, 45,	'health potion')
shopModule:addBuyableItem({'great spirit potion', 'gsp'},			8472, 190,	'great spirit potion')
shopModule:addBuyableItem({'great mana potion', 'gmp'},		7590, 120,	'great mana potion')
shopModule:addBuyableItem({'strong mana potion', 'smp'},		7589, 80,	'strong mana potion')
shopModule:addBuyableItem({'mana potion', 'mp'},			7620, 50,	'mana potion')
shopModule:addBuyableItem({'light wand', 'lightwand'},			2163, 500,	'magic light wand')
shopModule:addBuyableItem({'heavy magic missile', 'hmm'},		2311, 300, 50,	'heavy magic missile rune')
shopModule:addBuyableItem({'great fireball', 'gfb'},			2304, 500, 50,	'great fireball rune')
shopModule:addBuyableItem({'explo', 'xpl'},				2313, 800, 50,	'explosion rune')
shopModule:addBuyableItem({'ultimate healing', 'uh'},			2273, 700, 50,	'ultimate healing rune')
shopModule:addBuyableItem({'sudden death', 'sd'},			2268, 1000, 50,	'sudden death rune')
shopModule:addBuyableItem({'blank', 'rune'},				2260, 10,	'blank rune')
shopModule:addBuyableItem({'spellbook'}, 				2175, 150,	'spellbook')

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end

	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid

	local items = {[1] = 2190, [2] = 2182, [5] = 2190, [6] = 2182}
	if(msgcontains(msg, 'first rod') or msgcontains(msg, 'first wand')) then
		if(isSorcerer(cid) or isDruid(cid)) then
			if(getPlayerStorageValue(cid, 30002) == -1) then
				selfSay('So you ask me for a {' .. getItemNameById(items[getPlayerVocation(cid)]) .. '} to begin your advanture?', cid)
				talkState[talkUser] = 1
			else
				selfSay('What? I have already gave you one {' .. getItemNameById(items[getPlayerVocation(cid)]) .. '}!', cid)
			end
		else
			selfSay('Sorry, you aren\'t a druid either a sorcerer.', cid)
		end
	elseif(msgcontains(msg, 'yes')) then
		if(talkState[talkUser] == 1) then
			doPlayerAddItem(cid, items[getPlayerVocation(cid)], 1)
			selfSay('Here you are young adept, take care yourself.', cid)
			setPlayerStorageValue(cid, 30002, 1)
		end
		talkState[talkUser] = 0
	elseif(msgcontains(msg, 'no') and isInArray({1}, talkState[talkUser]) == TRUE) then
		selfSay('Ok then.', cid)
		talkState[talkUser] = 0
	end

	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
