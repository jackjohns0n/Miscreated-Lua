-- Goto an alias player's position
ChatCommands["!goto"] = function(playerId, command)
	Log(">> !goto - %s", command);

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

	g_gameRules.game:SendTextMessage(4, playerId, "The alias was not found");
  end