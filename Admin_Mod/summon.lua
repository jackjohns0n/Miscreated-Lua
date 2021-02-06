-- Summon a player by SteamId to your position
ChatCommands["!summon"] = function(playerId, command)
	Log(">> !summon - %s", command);

	local player = System.GetEntity(playerId)
  
    -- Only allow the following SteamId to invoke the command 
  local steamid = player.player:GetSteam64Id()
  local allowCommand = steamid == "76561197992974688" -- change this to some valid admin's Steam64 id
  
  -- or through faction restrictions
  -- allowCommand = allowCommand or nil ~= string.match(System.GetCVar("g_gameRules_faction4_steamids"), steamid)
  
  -- or through actual current faction
  -- allowCommand = allowCommand or 4 == player.actor:GetFaction() -- faction 0 to 7 (same numbering as cvars)
  
	if allowCommand then
    

	-- Performing a generic entity search is very expensive - use sparingly
	local players = System.GetEntitiesByClass("Player")

	for i,p in pairs(players) do 
		if p.player:GetSteam64Id() == command then
			p.player:TeleportTo(playerId)
			return;
		end
	end

	g_gameRules.game:SendTextMessage(4, playerId, "A player with the SteamId does not exist on the server.");
  end
end

-- For debugging
--dump(ChatCommands)