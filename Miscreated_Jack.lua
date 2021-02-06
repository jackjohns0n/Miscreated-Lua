-- Alias management
Aliases = { }

--This checks to see if the function we are Registering a callback to exists and
--if it doesnt then we log that it doesnt and then create it, or else
--we will just log that it already exists
if not (Miscreated.RevivePlayer) then
  Miscreated.RevivePlayer = function(self,playerId)
    Log(">> Miscreated:RevivePlayer didn't exist so I am creating it.");
  end
else Log(">> Miscreated:RevivePlayer already existed.");
end

--food(500.0) = 33%, (1000) = 66%, (1400) = 93%
--water(750.0) = 42%, (1500) = 85%, (1600) = 91%
-- Player Stats
-- Use this to set players stats like Food, Water, Health.
-- Any change to the player's position and rotation would have to be done here
function PlayerStats(playerId)
  Log(">> Miscreated:RevivePlayer");

  local player = System.GetEntity(playerId);
  local playerName = player:GetName()
  local steamid = player.player:GetSteam64Id()

  if (player and player.actor and player.player) then
    Log(">> Miscreated:RevivePlayer - Name: %s", playerName);
    Log(">> Miscreated:RevivePlayer - Steam64ID: %s", tostring(steamid));

    --player.actor:SetHealth(50.0);
    --player.player:SetFood(750.0);
    --player.player:SetWater(875.0);
    Aliases[playerName] = playerId;
    --other examples of stats that can be added, just uncomment and add a value
    --player.player:SetOxygen()
    --player.player:SetBleedingLevel()
    --player.player:SetUnconcious()
    --player.player:SetTorpidity()
    --player.player:SetRadiation()
    --player.player:SetTemperature()
  end
end

ChatCommands["!summon"] = function(playerId, command)
  Log(">> !summon - %s", command);

  local player = System.GetEntity(playerId)
  local steamid = player.player:GetSteam64Id()

  if player.player:GetSteam64Id() == "76561198068552213" or player.player:GetSteam64Id() == "76561198258982583" then

    if (Aliases[command] ~= nil) then
      local playerToSummonId = Aliases[command];
      local playerToSummon = System.GetEntity(playerToSummonId)

      playerToSummon.player:TeleportTo(playerId);
    else
      g_gameRules.game:SendTextMessage(4, playerId, command.." was not found");
    end
  end
end

-- Goto an alias player's position
ChatCommands["!goto"] = function(playerId, command)
  Log(">> !goto - %s", command);

  local player = System.GetEntity(playerId)
  local playerName = player:GetName()
  local steamid = player.player:GetSteam64Id()

  if player.player:GetSteam64Id() == "76561198068552213" or player.player:GetSteam64Id() == "76561198258982583" then

    if (Aliases[command] ~= nil) then
      g_gameRules.game:SendTextMessage(4, playerId, "Teleporting to: "..command);
      Log(">> Sending "..playerName.." to "..command);

      local playerToGotoId = Aliases[command];

      player.player:TeleportTo(playerToGotoId)
    else
      g_gameRules.game:SendTextMessage(4, playerId, command.." was not found");
      Log(">> Could not send "..playerName.. " to "..command);
    end
  end
end

ChatCommands["!spawncat"] = function(playerId, command)
  Log(">> !spawncat - %s", command)

  local player = System.GetEntity(playerId)

  if player.player:GetSteam64Id() == "76561198068552213" or player.player:GetSteam64Id() == "76561198258982583" then

    local vForwardOffset = {x=0,y=0,z=0}
    FastScaleVector(vForwardOffset, player:GetDirectionVector(), 2.0)

    local vSpawnPos = {x=0,y=0,z=0}
    FastSumVectors(vSpawnPos, vForwardOffset, player:GetWorldPos())

    ISM.SpawnCategory(command, vSpawnPos)
  end
end


-- Teleport to a position
ChatCommands["!teleport"] = function(playerId, command)
  Log(">> !teleport - %s", command);

  local player = System.GetEntity(playerId)

  if player.player:GetSteam64Id() == "76561198068552213" or player.player:GetSteam64Id() == "76561198258982583" then
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

  if player.player:GetSteam64Id() == "76561198068552213" or player.player:GetSteam64Id() == "76561198258982583" then
    PushP[playerId] = player:GetWorldPos()
  end
end
-- Pop current position
ChatCommands["!popp"] = function(playerId, command)
  Log(">> !popp - %s", command);

  local player = System.GetEntity(playerId)

  if player.player:GetSteam64Id() == "76561198068552213" or player.player:GetSteam64Id() == "76561198258982583" then
    if PushP[playerId] then
      player.player:TeleportTo(PushP[playerId])
    end
  end
end
ChatCommands["!bases_dump"] = function(playerId, command)
  Log(">> !bases_dump - %s", command);

  local player = System.GetEntity(playerId)

  if player.player:GetSteam64Id() == "76561198068552213" or player.player:GetSteam64Id() == "76561198258982583" then
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

  if player.player:GetSteam64Id() == "76561198068552213" or player.player:GetSteam64Id() == "76561198258982583" then
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

  if player.player:GetSteam64Id() == "76561198068552213" or player.player:GetSteam64Id() == "76561198258982583" then
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

  if player.player:GetSteam64Id() == "76561198068552213" or player.player:GetSteam64Id() == "76561198258982583" then
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

  if player.player:GetSteam64Id() == "76561198068552213" or player.player:GetSteam64Id() == "76561198258982583" then
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

  if player.player:GetSteam64Id() == "76561198068552213" or player.player:GetSteam64Id() == "76561198258982583" then
    System.ExecuteCommand(command)
  end
end
ChatCommands["!weather"] = function(playerId, command)
  Log(">> !weather - %s", command)

  local player = System.GetEntity(playerId)

  if player.player:GetSteam64Id() == "76561198068552213" or player.player:GetSteam64Id() == "76561198258982583" then
    System.ExecuteCommand("wm_startPattern " .. command)
  end
end
ChatCommands["!hide"] = function(playerId, command)
  Log(">> !hide - %s", command)

  local player = System.GetEntity(playerId)

  if player.player:GetSteam64Id() == "76561198068552213" or player.player:GetSteam64Id() == "76561198258982583" then
    player:Hide(tonumber(command))
  end
end
ChatCommands["!airdrop"] = function(playerId, command)
  Log(">> !airdrop - %s", command)

  local player = System.GetEntity(playerId)

  if player.player:GetSteam64Id() == "76561198068552213" or player.player:GetSteam64Id() == "76561198258982583" then

    local spawnParams = {}
    spawnParams.class = "AirDropPlane"
    spawnParams.name = spawnParams.class

    local spawnedEntity = System.SpawnEntity(spawnParams)
  end
end
ChatCommands["!aircrash"] = function(playerId, command)
  Log(">> !aircrash - %s", command)

  local player = System.GetEntity(playerId)

  if player.player:GetSteam64Id() == "76561198068552213" or player.player:GetSteam64Id() == "76561198258982583" then

    local spawnParams = {}
    spawnParams.class = "AirPlaneCrash"
    spawnParams.name = spawnParams.class

    local spawnedEntity = System.SpawnEntity(spawnParams)
  end
end
ChatCommands["!horde"] = function(playerId, command)
  Log(">> !horde - %s", command)

  local player = System.GetEntity(playerId)

  if player.player:GetSteam64Id() == "76561198068552213" or player.player:GetSteam64Id() == "76561198258982583" then

    AISM.SpawnCategory(player:GetWorldPos(), "test_group", true, 4.0, 10.0, 1.0)
    AISM.SpawnCategory(player:GetWorldPos(), "test_group", true, 4.0, 10.0, 1.0)
    AISM.SpawnCategory(player:GetWorldPos(), "test_group", true, 4.0, 10.0, 1.0)

  end
end
ChatCommands["!invasion"] = function(playerId, command)
  Log(">> !invasion - %s", command)

  local player = System.GetEntity(playerId)

  if player.player:GetSteam64Id() == "76561198068552213" or player.player:GetSteam64Id() == "76561198258982583" then

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
ChatCommands["!santa"] = function(playerId, command)
  Log(">> !santa - %s", command)

  local player = System.GetEntity(playerId)

  if player.player:GetSteam64Id() == "76561198068552213" or player.player:GetSteam64Id() == "76561198258982583" then

    local spawnParams = {}
    spawnParams.class = "AirDropChristmas"
    spawnParams.name = spawnParams.class

    local spawnedEntity = System.SpawnEntity(spawnParams)
  end
end
-- !time
-- Changes Time of Day/Night on the server (by number)
ChatCommands["!time"] = function(playerId, command)
  Log(">> !time - %s", command)

  local player = System.GetEntity(playerId)
  local playerName = player:GetName()
  local steamid = player.player:GetSteam64Id()

  if player.player:GetSteam64Id() == "76561198068552213" or player.player:GetSteam64Id() == "76561198258982583" then

    System.ExecuteCommand("wm_forceTime " .. command)
  end
end
-- !heal 
-- Heals the player to full health
ChatCommands["!heal"] = function(playerId, command)
  Log(">> !heal - %s", command)

  local player = System.GetEntity(playerId)
  local playerName = player:GetName()
  local steamid = player.player:GetSteam64Id()

  if player.player:GetSteam64Id() == "76561198068552213" or player.player:GetSteam64Id() == "76561198258982583" then

    player.actor:SetHealth(100.0);
  end
end
function AirDropCrate:OnDropped()
  --g_gameRules.game:SendTextMessage(0, 0, "Incoming air drop. Difficulty increased.")
end

function AirDropCrate:OnLanded()
  --AISM.SpawnCategory(self:GetWorldPos(), "test_group", true, 2.0, 5.0, 1.0)
end

RegisterCallbackReturnAware(
  Miscreated,
  "RevivePlayer",
  nil,
  function(self, ret, playerId)
    PlayerStats(playerId)
    return ret
  end
)