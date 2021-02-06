PushP = { }

-- Push current position - Saves current position
ChatCommands["!pushp"] = function(playerId, command)
	Log(">> !pushp - %s", command);

	local player = System.GetEntity(playerId)
  
    -- Only allow the following SteamId to invoke the command 
  local steamid = player.player:GetSteam64Id()
  local allowCommand = steamid == "76561197992974688" -- change this to some valid admin's Steam64 id
  
  -- or through faction restrictions
  -- allowCommand = allowCommand or nil ~= string.match(System.GetCVar("g_gameRules_faction4_steamids"), steamid)
  
  -- or through actual current faction
  -- allowCommand = allowCommand or 4 == player.actor:GetFaction() -- faction 0 to 7 (same numbering as cvars)
  
	if allowCommand then
    
    PushP[playerId] = player:GetWorldPos()
    
  end
end

-- For debugging
--dump(ChatCommands)