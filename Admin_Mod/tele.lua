-- Teleport to a position
ChatCommands["!teleport"] = function(playerId, command)
    Log(">> !teleport - %s", command);

    local player = System.GetEntity(playerId);
    local allowCommand = steamid == "76561197992974688";

    if allowCommand then
        local steamid = player.player:GetSteam64Id();

        if command == "base" then
            local bases = BaseBuildingSystem.GetPlotSigns();

            for i,b in pairs(bases) do 
                if b.plotsign:GetOwnerSteam64Id() == steamId then
                    player.player:TeleportTo(b:GetWorldPos());
                    return;
                end
            end
            g_gameRules.game:SendTextMessage(4, playerId, "You do not have a base on this server.");
        else
            player.player:TeleportTo(command);
        end
    end
end