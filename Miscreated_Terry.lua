-- Alias management
Aliases = { }

-- Add/update a player alias
-- This allows a player to create an alias for themselves
-- Other players who know the alias can then goto the aliased player's location
ChatCommands["!alias"] = function(playerId, command)
	Log(">> !alias - %s", command);

	local player = System.GetEntity(playerId);

	if player.player:GetSteam64Id() == "76561197992974688" then
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
	end
	--dump(Aliases)
end

-- Goto an alias player's position
ChatCommands["!goto"] = function(playerId, command)
	Log(">> !goto - %s", command);

	local playerSource = System.GetEntity(playerId);

	if playerSource.player:GetSteam64Id() == "76561197992974688" then
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

		g_gameRules.game:SendTextMessage(4, playerId, "The alias was not found");
	end
end

-- Teleport to a position
ChatCommands["!teleport"] = function(playerId, command)
	Log(">> !teleport - %s", command);

	local player = System.GetEntity(playerId)

	if player.player:GetSteam64Id() == "76561197992974688" then
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

	local player = System.GetEntity(playerId)

	if player.player:GetSteam64Id() == "76561197992974688" then
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

	local player = System.GetEntity(playerId)

	if player.player:GetSteam64Id() == "76561197992974688" then
		PushP[playerId] = player:GetWorldPos()
	end
end

-- Pop current position
ChatCommands["!popp"] = function(playerId, command)
	Log(">> !popp - %s", command);

	local player = System.GetEntity(playerId)

	if player.player:GetSteam64Id() == "76561197992974688" then
		if PushP[playerId] then
			player.player:TeleportTo(PushP[playerId])
		end
	end
end

ChatCommands["!bases_dump"] = function(playerId, command)
	Log(">> !bases_dump - %s", command);

	local player = System.GetEntity(playerId)

	if player.player:GetSteam64Id() == "76561197992974688" then
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

	if player.player:GetSteam64Id() == "76561197992974688" then
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

	if player.player:GetSteam64Id() == "76561197992974688" then
		local plotSignId = player.player:GetActivePlotSignId()
		
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

ChatCommands["!give"] = function(playerId, command)
	Log(">> !give - %s", command)

	local player = System.GetEntity(playerId);

	if player.player:GetSteam64Id() == "76561197992974688" then
		local item = ISM.GiveItem(playerId, command, false)

		if item then
			if item.item:IsStackable() or item.item:IsMagazine() then
				item.item:SetStackCount(item.item:GetMaxStackSize())
			end
			if item.item:IsDestroyable() then
				item.item:SetHealth(item.item:GetMaxHealth())
			end
		end
	end
end

ChatCommands["!spawn"] = function(playerId, command)
	Log(">> !spawn - %s", command)

	local player = System.GetEntity(playerId)

	if player.player:GetSteam64Id() == "76561197992974688" then
		local vForwardOffset = {x=0,y=0,z=0}
		FastScaleVector(vForwardOffset, player:GetDirectionVector(), 2.0)

		local vSpawnPos = {x=0,y=0,z=0}
		FastSumVectors(vSpawnPos, vForwardOffset, player:GetWorldPos())

		local item = ISM.SpawnItem(command, vSpawnPos)

		if item then
			if item.item:IsStackable() or item.item:IsMagazine() then
				item.item:SetStackCount(item.item:GetMaxStackSize())
			end
			if item.item:IsDestroyable() then
				item.item:SetHealth(item.item:GetMaxHealth())
			end
		end
	end
end

ChatCommands["!rcon"] = function(playerId, command)
	Log(">> !rcon - %s", command)

	local player = System.GetEntity(playerId)

	if player.player:GetSteam64Id() == "76561197992974688" then
		System.ExecuteCommand(command)
	end
end

ChatCommands["!weather"] = function(playerId, command)
	Log(">> !weather - %s", command)

	local player = System.GetEntity(playerId)
    
	if player.player:GetSteam64Id() == "76561197992974688" then
		System.ExecuteCommand("wm_startPattern " .. command)
	end
end

ChatCommands["!hide"] = function(playerId, command)
	Log(">> !hide - %s", command)

	local player = System.GetEntity(playerId)
    
	if player.player:GetSteam64Id() == "76561197992974688" then
		player:Hide(tonumber(command))
	end
end

ChatCommands["!airdrop"] = function(playerId, command)
	Log(">> !airdrop - %s", command)

	local player = System.GetEntity(playerId)

	if player.player:GetSteam64Id() == "76561197992974688" then

		local spawnParams = {}
		spawnParams.class = "AirDropPlane"
		spawnParams.name = spawnParams.class

		local spawnedEntity = System.SpawnEntity(spawnParams)
	end
end

ChatCommands["!aircrash"] = function(playerId, command)
	Log(">> !aircrash - %s", command)

	local player = System.GetEntity(playerId)

	if player.player:GetSteam64Id() == "76561197992974688" then

		local spawnParams = {}
		spawnParams.class = "AirPlaneCrash"
		spawnParams.name = spawnParams.class

		local spawnedEntity = System.SpawnEntity(spawnParams)
	end
end

ChatCommands["!horde"] = function(playerId, command)
	Log(">> !horde - %s", command)

	local player = System.GetEntity(playerId)

	if player.player:GetSteam64Id() == "76561197992974688" then

		AISM.SpawnCategory(player:GetWorldPos(), "test_group", true, 4.0, 10.0, 1.0)
		AISM.SpawnCategory(player:GetWorldPos(), "test_group", true, 4.0, 10.0, 1.0)
		AISM.SpawnCategory(player:GetWorldPos(), "test_group", true, 4.0, 10.0, 1.0)

	end
end


ChatCommands["!invasion"] = function(playerId, command)
	Log(">> !invasion - %s", command)

	local player = System.GetEntity(playerId)

	if player.player:GetSteam64Id() == "76561197992974688" then

		-- vSpawnPos of ZERO means the AI system will choose where to spawn the AI in at
		-- that makes the most sent to get to the target destination
		local vSpawnPos = {x=0,y=0,z=0}

		-- Uncomment following if you want to specify the starting spawn location
		--local vForwardOffset = {x=0,y=0,z=0}
		--FastScaleVector(vForwardOffset, player:GetDirectionVector(), 300.0)
		--FastSumVectors(vSpawnPos, vForwardOffset, player:GetWorldPos())

		AISM.SpawnInvasion(vSpawnPos, player:GetWorldPos(), "test_invasion", true)

	end
end

function AirDropCrate:OnDropped()
	--g_gameRules.game:SendTextMessage(0, 0, "Incoming air drop. Difficulty increased.")
end

function AirDropCrate:OnLanded()
	--AISM.SpawnCategory(self:GetWorldPos(), "test_group", true, 2.0, 5.0, 1.0)
end