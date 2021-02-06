--This checks to see if the function we are Registering a callback to exists and
--if it doesnt then we log that it doesnt and then create it, or else
--we will just log that it already exists
if not (Miscreated.RevivePlayer) then
  Miscreated.RevivePlayer = function(self,playerId)
    Log(">> Miscreated:RevivePlayer didn't exist so I am creating it.");
  end
else Log(">> Miscreated:RevivePlayer already existed.");
end

--This was originially written with Server Admin in mind.  The function is to have the admin
--automatically join the admin faction when joining the server.  Put all Server Admin SteamId's
--in the quotes on the "local allowCommand" line and define your Admin Faction number on the "local factionNumber" line
function AutoJoinFaction(playerId)
  --Log(">> Miscreated:RevivePlayer");

  local player = System.GetEntity(playerId);
  local playerName = player:GetName()
  local steamid = player.player:GetSteam64Id()
  local allowCommand = steamid == "76561197992974688" -- change this to some valid admin's Steam64 id
  local faction = player.actor:GetFaction()
  local factionNumber = 6

  if (player and player.actor) then
    --Log(">> Miscreated:RevivePlayer - Name: %s", playerName);
    --Log(">> Miscreated:RevivePlayer - Steam64ID: %s", tostring(steamid));
    Log(">> Miscreated:RevivePlayer - Players Current Faction: %s", tostring(faction));
    Log(">> Miscreated:RevivePlayer - Did I log my faction?");
    Log(">> Miscreated:RevivePlayer - allowCommand is: %s", tostring(allowCommand));

    if (allowCommand and faction == 0) then
      player.actor:SetFaction(factionNumber, true)
      local faction2 = player.actor:GetFaction()
      Log(">> Miscreated:RevivePlayer - Faction: %s", tostring(faction2));
    else
      Log(">> Miscreated:RevivePlayer - You are already apart of the faction")
    end
  end
end

RegisterCallback(Miscreated, 'RevivePlayer', nil, function (self, playerId) AutoJoinFaction(playerId) end);
--This function has depreceated and is no longer used, it is kept here for an example only.
--Do not uncomment to try and use this section!
--[[function Miscreated:InitPlayer(playerId)
  Log(">> Miscreated:InitPlayer");

    local player = System.GetEntity(playerId);
    local steamid = player.player:GetSteam64Id()
    local allowCommand = steamid == "76561197992974688" -- change this to some valid admin's Steam64 id
    local factionNumber = 6

  if (player and player.player) then
		Log(">> Miscreated:InitPlayer - Name: %s", player:GetName());
    Log(">> Miscreated:InitPlayer - Steam64ID: %s", player.player:GetSteam64Id());

    if allowCommand then
      player.actor:SetFaction( factionNumber, true )
      Log(">> Miscreated:InitPlayer - Faction: %s", player.actor:GetFaction());
  end

  end
end]]--

ChatCommands["!nodamage"] = function(playerId)

  local player = System.GetEntity(playerId);
  local steamid = player.player:GetSteam64Id()
  local allowCommand = steamid == "76561197992974688" -- change this to some valid admin's Steam64 id
  local command = "g_gameRules_faction0_dmg_f6 0"

  if allowCommand then
    System.ExecuteCommand(command)
  end
end