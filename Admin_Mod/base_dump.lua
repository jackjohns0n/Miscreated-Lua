ChatCommands["!base_dump"] = function(playerId, command)
	Log(">> !base_dump - %s", command);

	local player = System.GetEntity(playerId);


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

-- For debugging
--dump(ChatCommands)