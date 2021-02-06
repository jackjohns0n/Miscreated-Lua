-- Alias management
Aliases = { }

-- Add/update a player alias
-- This allows a player to create an alias for themselves
-- Other players who know the alias can then goto the aliased player's location
ChatCommands["!alias"] = function(playerId, command)
	Log(">> !alias - %s", command);

	if not command or command == "" then
		local alias = Aliases[playerId]

		if alias then
			g_gameRules.game:SendTextMessage(4, playerId, "Your alias is: "..alias);
		else
			g_gameRules.game:SendTextMessage(4, playerId, "You do not have a current alias");
		end

		return
	end

	Aliases[playerId] = command;
	g_gameRules.game:SendTextMessage(4, playerId, "Your alias is now: "..command);

	--dump(Aliases)
end

-- Goto an alias player's position
ChatCommands["!goto"] = function(playerId, command)
	Log(">> !goto - %s", command);

  local steamid = player.player:GetSteam64Id()
  local allowCommand = steamid == "76561197992974688" -- change this to some valid admin's Steam64 id

  -- or through faction restrictions
  -- allowCommand = allowCommand or nil ~= string.match(System.GetCVar("g_gameRules_faction4_steamids"), steamid)

  -- or through actual current faction
  -- allowCommand = allowCommand or 4 == player.actor:GetFaction() -- faction 0 to 7 (same numbering as cvars)

	if allowCommand then
  local playerSource = System.GetEntity(playerId);

	-- Goto a player
    for id, alias in pairs(Aliases) do
      if command == alias then
        g_gameRules.game:SendTextMessage(4, playerId, "Teleporting to alias: "..alias);

        local playerTarget = System.GetEntity(id);

        if not playerTarget then
          Log(">> !goto - player entity could not be found")
          return
        end

        playerSource.player:TeleportTo(id)

        return
      end
    end
  end

	g_gameRules.game:SendTextMessage(4, playerId, "The alias was not found");
end

-- Teleport to a position
ChatCommands["!teleport"] = function(playerId, command)
	Log(">> !teleport - %s", command);

	local player = System.GetEntity(playerId)

  local steamid = player.player:GetSteam64Id()
  local allowCommand = steamid == "76561197992974688" -- change this to some valid admin's Steam64 id

  -- or through faction restrictions
  -- allowCommand = allowCommand or nil ~= string.match(System.GetCVar("g_gameRules_faction4_steamids"), steamid)

  -- or through actual current faction
  -- allowCommand = allowCommand or 4 == player.actor:GetFaction() -- faction 0 to 7 (same numbering as cvars)

	if allowCommand then

	-- Special case just for fun
	if command == "base" then

		local steamId = player.player:GetSteam64Id();

		local bases = BaseBuildingSystem.GetPlotSigns()

		for i,b in pairs(bases) do 
			if b.plotsign:GetOwnerSteam64Id() == steamId then
				player.player:TeleportTo(b:GetWorldPos())
				return;
			end
		end

		g_gameRules.game:SendTextMessage(4, playerId, "You do not have a base on this server.");
		return
	end

  player.player:TeleportTo(command)
  end
end

-- Summon a player by SteamId to your position
ChatCommands["!summon"] = function(playerId, command)
	Log(">> !summon - %s", command);

  local steamid = player.player:GetSteam64Id()
  local allowCommand = steamid == "76561197992974688" -- change this to some valid admin's Steam64 id

  -- or through faction restrictions
  -- allowCommand = allowCommand or nil ~= string.match(System.GetCVar("g_gameRules_faction4_steamids"), steamid)

  -- or through actual current faction
  -- allowCommand = allowCommand or 4 == player.actor:GetFaction() -- faction 0 to 7 (same numbering as cvars)

	if allowCommand then
    local player = System.GetEntity(playerId)

    -- Performing a generic entity search is very expensive - use sparingly
    local players = System.GetEntitiesByClass("Player")

    for i,p in pairs(players) do 
      if p.player:GetSteam64Id() == command then
        p.player:TeleportTo(playerId)
        return;
      end
    end
  end

	g_gameRules.game:SendTextMessage(4, playerId, "A player with the SteamId does not exist on the server.");
end

-- Send the player's position back to them via chat
ChatCommands["!mypos"] = function(playerId, command)
	Log(">> !mypos - %s", command);

	local player = System.GetEntity(playerId)
	local pos = player:GetWorldPos()

	g_gameRules.game:SendTextMessage(4, playerId, string.format("Your position is: %.1f %.1f %.1f", pos.x, pos.y, pos.z));
end

PushP = { }

-- Push current position
ChatCommands["!pushp"] = function(playerId, command)
	Log(">> !pushp - %s", command);

  local steamid = player.player:GetSteam64Id()
  local allowCommand = steamid == "76561197992974688" -- change this to some valid admin's Steam64 id

  -- or through faction restrictions
  -- allowCommand = allowCommand or nil ~= string.match(System.GetCVar("g_gameRules_faction4_steamids"), steamid)

  -- or through actual current faction
  -- allowCommand = allowCommand or 4 == player.actor:GetFaction() -- faction 0 to 7 (same numbering as cvars)

	if allowCommand then
    local player = System.GetEntity(playerId)
    PushP[playerId] = player:GetWorldPos()
  end
end

-- Pop current position
ChatCommands["!popp"] = function(playerId, command)
	Log(">> !popp - %s", command);

  local steamid = player.player:GetSteam64Id()
  local allowCommand = steamid == "76561197992974688" -- change this to some valid admin's Steam64 id

  -- or through faction restrictions
  -- allowCommand = allowCommand or nil ~= string.match(System.GetCVar("g_gameRules_faction4_steamids"), steamid)

  -- or through actual current faction
  -- allowCommand = allowCommand or 4 == player.actor:GetFaction() -- faction 0 to 7 (same numbering as cvars)

	if allowCommand then
    if PushP[playerId] then
      local player = System.GetEntity(playerId)
      player.player:TeleportTo(PushP[playerId])
    end
  end
end

ChatCommands["!bases_dump"] = function(playerId, command)
	Log(">> !bases_dump - %s", command);

  local steamid = player.player:GetSteam64Id()
  local allowCommand = steamid == "76561197992974688" -- change this to some valid admin's Steam64 id

  -- or through faction restrictions
  -- allowCommand = allowCommand or nil ~= string.match(System.GetCVar("g_gameRules_faction4_steamids"), steamid)

  -- or through actual current faction
  -- allowCommand = allowCommand or 4 == player.actor:GetFaction() -- faction 0 to 7 (same numbering as cvars)

	if allowCommand then

    local bases = BaseBuildingSystem.GetPlotSigns()

    for i,b in pairs(bases) do 

      local numParts = b.plotsign:GetPartCount()
      Log("Base - index: %d, numParts: %d", i, numParts)

      if numParts > 0 then
        for p = 0, numParts - 1 do
          local partId = b.plotsign:GetPartId(p)

          local canPackUp = 1
          if (not b.plotsign:CanPackUp(partId)) then
            canPackUp = 0;
          end

          Log("Id: %d, TypeId: %d, ClassName: %s, CanPackUp: %d, MaxHealth: %f, Damage: %f", partId, b.plotsign:GetPartTypeId(partId), b.plotsign:GetPartClassName(partId), canPackUp, b.plotsign:GetMaxHealth(partId), b.plotsign:GetDamage(partId))
        end
      end
    end
  end
end

ChatCommands["!base_dump"] = function(playerId, command)
	Log(">> !base_dump - %s", command);

	local player = System.GetEntity(playerId);

  local steamid = player.player:GetSteam64Id()
  local allowCommand = steamid == "76561197992974688" -- change this to some valid admin's Steam64 id

  -- or through faction restrictions
  -- allowCommand = allowCommand or nil ~= string.match(System.GetCVar("g_gameRules_faction4_steamids"), steamid)

  -- or through actual current faction
  -- allowCommand = allowCommand or 4 == player.actor:GetFaction() -- faction 0 to 7 (same numbering as cvars)

	if allowCommand then

	local plotSignId = player.player:GetActivePlotSignId()

    if plotSignId then
      local b = BaseBuildingSystem.GetPlotSign(plotSignId)

      if b then
        local numParts = b.plotsign:GetPartCount()
        Log("Base: numParts: %d", numParts)

        if numParts > 0 then
          for p = 0, numParts - 1 do
            local partId = b.plotsign:GetPartId(p)

            local canPackUp = 1
            if (not b.plotsign:CanPackUp(partId)) then
              canPackUp = 0;
            end

            Log("Id: %d, TypeId: %d, ClassName: %s, CanPackUp: %d, MaxHealth: %f, Damage: %f", partId, b.plotsign:GetPartTypeId(partId), b.plotsign:GetPartClassName(partId), canPackUp, b.plotsign:GetMaxHealth(partId), b.plotsign:GetDamage(partId))
          end
        end
      end
    end
  end
end

ChatCommands["!base_delete"] = function(playerId, command)
	Log(">> !base_delete - %s", command);

	local player = System.GetEntity(playerId);

	local plotSignId = player.player:GetActivePlotSignId()

  local steamid = player.player:GetSteam64Id()
  local allowCommand = steamid == "76561197992974688" -- change this to some valid admin's Steam64 id

  -- or through faction restrictions
  -- allowCommand = allowCommand or nil ~= string.match(System.GetCVar("g_gameRules_faction4_steamids"), steamid)

  -- or through actual current faction
  -- allowCommand = allowCommand or 4 == player.actor:GetFaction() -- faction 0 to 7 (same numbering as cvars)

	if allowCommand then
		if plotSignId then
      local b = BaseBuildingSystem.GetPlotSign(plotSignId)

      if b then
        -- Iterate through all the parts and delete them
        while b.plotsign:GetPartCount() > 0 do
          local partId = b.plotsign:GetPartId(0)
          b.plotsign:DeletePart(partId)
        end

        -- Delete the actual plot sign
        b.plotsign:DeletePart(-1)
      end
    end
  end
end

ChatCommands["!spawn"] = function(playerId, command)
	Log(">> !spawn - %s", command)

	local player = System.GetEntity(playerId)

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

    ISM.SpawnItem(command, vSpawnPos)
  end
end