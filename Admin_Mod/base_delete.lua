ChatCommands["!bases_dump"] = function(playerId, command)
	Log(">> !bases_dump - %s", command);
	
	--Change Faction to what ever faction can use this command
	local player = System.GetEntity(playerId)
    local steamid = player.player:GetSteam64Id()

  	local allowCommand = steamid == "76561197992974688"
	
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

ChatCommands["!base_delete"] = function(playerId, command)
	Log(">> !base_delete - %s", command);

	--Change Faction to what ever faction can use this command
	local player = System.GetEntity(playerId)
    local steamid = player.player:GetSteam64Id()

  	local allowCommand = steamid == "76561197992974688"
	
	if allowCommand then
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
-- For debugging
--dump(ChatCommands)