-- Send the player's position back to them via chat
ChatCommands["!mypos"] = function(playerId, command)
	Log(">> !mypos - %s", command);

	local player = System.GetEntity(playerId)
	local pos = player:GetWorldPos()

	g_gameRules.game:SendTextMessage(4, playerId, string.format("Your position is: %.1f %.1f %.1f", pos.x, pos.y, pos.z));
end

-- For debugging
--dump(ChatCommands)