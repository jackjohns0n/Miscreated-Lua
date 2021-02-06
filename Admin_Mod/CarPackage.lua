-- !weather
-- Starts any of the weather pattern on the server (by number or name)
ChatCommands["!carpackage"] = function(playerId, command)
	Log(">> !carpackage")

	local player = System.GetEntity(playerId)
  
  -- Only allow the following SteamId to invoke the command 
  local steamid = player.player:GetSteam64Id()
  local allowCommand = steamid == "76561197992974688" -- change this to some valid admin's Steam64 id
  
  -- or through faction restrictions
  -- allowCommand = allowCommand or nil ~= string.match(System.GetCVar("g_gameRules_faction4_steamids"), steamid)
  
  -- or through actual current faction
  -- allowCommand = allowCommand or 4 == player.actor:GetFaction() -- faction 0 to 7 (same numbering as cvars)
  
	if allowCommand then
		local vForwardOffset = {x=0,y=0,z=0}
		FastScaleVector(vForwardOffset, player:GetDirectionVector(), 2.0)

		local vSpawnPos = {x=0,y=0,z=0}
		FastSumVectors(vSpawnPos, vForwardOffset, player:GetWorldPos())

		ISM.SpawnItem(Oil, vSpawnPos)
    ISM.SpawnItem(Oil, vSpawnPos)
    ISM.SpawnItem(Oil, vSpawnPos)
    ISM.SpawnItem(Oil, vSpawnPos)
    ISM.SpawnItem(Oil, vSpawnPos)
    ISM.SpawnItem(Oil, vSpawnPos)
    ISM.SpawnItem(Oil, vSpawnPos)
    ISM.SpawnItem(Oil, vSpawnPos)
    ISM.SpawnItem(Oil, vSpawnPos)
    ISM.SpawnItem(Oil, vSpawnPos)
    ISM.SpawnItem(JerryCanDiesel, vSpawnPos)
    ISM.SpawnItem(JerryCanDiesel, vSpawnPos)
    ISM.SpawnItem(JerryCanDiesel, vSpawnPos)
    ISM.SpawnItem(JerryCanDiesel, vSpawnPos)
    ISM.SpawnItem(JerryCanDiesel, vSpawnPos)
    ISM.SpawnItem(JerryCanDiesel, vSpawnPos)
    ISM.SpawnItem(JerryCanDiesel, vSpawnPos)
    ISM.SpawnItem(JerryCanDiesel, vSpawnPos)
    ISM.SpawnItem(JerryCanDiesel, vSpawnPos)
    ISM.SpawnItem(JerryCanDiesel, vSpawnPos)
    ISM.SpawnItem(Wheel, vSpawnPos)
    ISM.SpawnItem(Wheel, vSpawnPos)
    ISM.SpawnItem(Wheel, vSpawnPos)
    ISM.SpawnItem(Wheel, vSpawnPos)
    ISM.SpawnItem(Wheel, vSpawnPos)
    ISM.SpawnItem(Wheel, vSpawnPos)
    ISM.SpawnItem(CarBattery, vSpawnPos)
    ISM.SpawnItem(SparkPlugs, vSpawnPos)
    ISM.SpawnItem(DriveBelt, vSpawnPos)
	end
end

-- For debugging
--dump(ChatCommands)