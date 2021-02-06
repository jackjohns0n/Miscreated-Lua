--[[ChatCommands["!bases_dump"] = function(playerId, command)
	Log(">> !bases_dump - %s", command);

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

-- For debugging
dump(ChatCommands)
]]--