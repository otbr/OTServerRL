----function by Armageddom--
function onStepIn(cid, item, frompos, item2, topos) 

playerpos = getPlayerPosition(cid) 
novapos = {x=935, y=1273, z=10} 

if item.uid == 10251 then

getThingfromPos(playerpos) 
doSendMagicEffect(playerpos,2) 
doTeleportThing(cid,novapos) 
doSendMagicEffect(novapos,10) 
end 
end