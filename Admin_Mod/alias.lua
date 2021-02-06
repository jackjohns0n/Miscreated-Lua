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

    if (Aliases[command] == nil) then
        Aliases[command] = playerId;
        g_gameRules.game:SendTextMessage(4, playerId, "Your alias is now: "..command);
    else
        g_gameRules.game:SendTextMessage(4, playerId, "The alias: "..command.." is already taken, try another one");
    end

    dump(Aliases)
end
ChatCommands["!summon"] = function(playerId, command)
    Log(">> !summon - %s", command);

    local player = System.GetEntity(playerId)
    local steamid = player.player:GetSteam64Id()
    local allowCommand = steamid == "76561197992974688" -- change this to some valid admin's Steam64 id
    
    -- or through faction restrictions
    -- allowCommand = allowCommand or nil ~= string.match(System.GetCVar("g_gameRules_faction4_steamids"), steamid)
    
    -- or through actual current faction
    -- allowCommand = allowCommand or 4 == player.actor:GetFaction() -- faction 0 to 7 (same numbering as cvars)
  
    if allowCommand then
      if (Aliases[command] == nil) then
        local playerToSummonId = Aliases[command];
        local playerToSummon = System.GetEntity(playerToSummonId)
        
        playerToSummon.player:TeleportTo(playerId);
      end
    end

    g_gameRules.game:SendTextMessage(4, playerId, "A player with the SteamId does not exist on the server.");
end
-- Goto an alias player's position
ChatCommands["!goto"] = function(playerId, command)
	Log(">> !goto - %s", command);

	local player = System.GetEntity(playerId)
  local steamid = player.player:GetSteam64Id()
  local allowCommand = steamid == "76561197992974688" -- change this to some valid admin's Steam64 id

	-- Goto a player
    if allowCommand then
      if (Aliases[command] == nil) then
			g_gameRules.game:SendTextMessage(4, playerId, "Teleporting to alias: "..alias);
      
      local playerToGotoId = Aliases[command];
      local playerToGoto = System.GetEntity(playerToGotoId)
      
			player.player:TeleportTo(playerToGoto)
		end
	end

	g_gameRules.game:SendTextMessage(4, playerId, "The alias was not found");
end
--Dump all bases
ChatCommands["!bases_dump"] = function(playerId, command)
	Log(">> !bases_dump - %s", command);

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
--Delete a base
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
--Dump your base to log
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
    
    player.actor:SetHealth(50.0);
    player.player:SetFood(750.0);
    player.player:SetWater(875.0);
    --other examples of stats that can be added, just uncomment and add a value
    --player.player:SetOxygen()
    --player.player:SetBleedingLevel()
    --player.player:SetUnconcious()
    --player.player:SetTorpidity()
    --player.player:SetRadiation()
    --player.player:SetTemperature()
	end
end

RegisterCallback(Miscreated, 'RevivePlayer', nil, function (self, playerId) PlayerStats(playerId) end);

--This function has depreceated and is no longer used, it is kept here for an example only.
--Do not uncomment to try and use this section!
--[[function Miscreated:InitPlayer(playerId)
  Log(">> Miscreated:InitPlayer");
  
  local player = System.GetEntity(playerId);
  local playerName = player:GetName()
  local steamid = player.player:GetSteam64Id()
  local allowCommand = steamid == "76561197992974688" -- change this to some valid admin's Steam64 id
  local factionNumber = 6

  if (player and player.player) then
		Log(">> Miscreated:InitPlayer - Name: %s", playerName);
		Log(">> Miscreated:InitPlayer - Steam64ID: %s", player.player:GetSteam64Id());
    
    player.actor:SetHealth(50.0);
    player.player:SetFood(750.0);
    player.player:SetWater(875.0);
  end
end]]--

--You can use this function to set custom random spawn locations
--If you wanted you could add condtion statements and set random spawns for different factions.  Get creative.
--[[function SpawnLocation(playerId)
	--Log(">> Miscreated:InitPlayer");
  
    local player = System.GetEntity(playerId);

	if (player and player.player) then
		--Log(">> Miscreated:InitPlayer - Name: %s", player:GetName());
		--Log(">> Miscreated:InitPlayer - Steam64ID: %s", player.player:GetSteam64Id());
    --Log(">> Miscreated:InitPlayer - Moving player to a random location in Brightmoor");
    
    local rnd = random(1, 6)
    if (rnd ==1) then
		g_Vectors.temp_v1.x = 5365.9169921875;
		g_Vectors.temp_v1.y = 2122.59106445312;
		g_Vectors.temp_v1.z = 26.2360000610352;
    elseif (rnd ==2) then
    g_Vectors.temp_v1.x = 5660.51513671875;
		g_Vectors.temp_v1.y = 2111.28393554687;
		g_Vectors.temp_v1.z = 24.75;
    elseif (rnd ==3) then
    g_Vectors.temp_v1.x = 5520.77099609375;
		g_Vectors.temp_v1.y = 2313.97290039062;
		g_Vectors.temp_v1.z = 24.75;
    elseif (rnd ==4) then
    g_Vectors.temp_v1.x = 5132.4619140625;
		g_Vectors.temp_v1.y = 1948.46704101563;
		g_Vectors.temp_v1.z = 24.7119998931885;
    elseif (rnd ==5) then
    g_Vectors.temp_v1.x = 5334.14208984375;
		g_Vectors.temp_v1.y = 2565.60009765625;
		g_Vectors.temp_v1.z = 24.7000007629395;
    else
    g_Vectors.temp_v1.x = 5260.4169921875;
		g_Vectors.temp_v1.y = 2076.09594726562;
		g_Vectors.temp_v1.z = 26.5;
  end

		player:SetWorldPos(g_Vectors.temp_v1);
  end
end

RegisterCallback(Miscreated, 'InitPlayer', nil, function (self, playerId) SpawnLocation(playerId) end);]]--

--You can use this function to set random custom loadouts
--This works the same wayt as it does in the Hosting.cfg but it doesnt depend on factions.
--Always list the "Parent" item first for example list the weapon first then list the ammo
--right after so that the ammo will go into the weapon, if not the weapon will spawn without the ammo.
--If you wanted you could add condtion statements and set random spawns for different factions.  Get creative.
function PlayerLoadout(playerId)
	--Log(">> Miscreated:EquipPlayer");
  
	local player = System.GetEntity(playerId);

	if (player and player.player) then

    local rnd = random(1, 8)
    if (rnd == 1) then
      ISM.GiveItem(playerId, "AT15", true);
      ISM.GiveItem(playerId, "STANAGx30", false, rifleId, "stanag_mag00");
      ISM.GiveItem(playerId, "OpticScope");
      ISM.GiveItem(playerId, "RifleSilencer");
      ISM.GiveItem(playerId, "ForegripVertical");
      ISM.GiveItem(playerId, "LaserSight");
      ISM.GiveItem(playerId, "FlashlightRifle");
      ISM.GiveItem(playerId, "ACAW", false);
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "HuntingScope");
      ISM.GiveItem(playerId, "G18Pistol", false);
      ISM.GiveItem(playerId, "9mmx33", false, rifleId, "9mmx33_mag00");
      ISM.GiveItem(playerId, "PistolSilencer");
      ISM.GiveItem(playerId, "FlashlightPistol");
      ISM.GiveItem(playerId, "FannyPackCamo1");
      ISM.GiveItem(playerId, "AdvancedBandage");
      ISM.GiveItem(playerId, "AdvancedBandage");
      ISM.GiveItem(playerId, "AdvancedBandage");
      ISM.GiveItem(playerId, "MilitaryJacketBlack");
      ISM.GiveItem(playerId, "DuffelBagBlack");
      ISM.GiveItem(playerId, "Aviators");
      ISM.GiveItem(playerId, "MilitaryHelmetUrbanCamo1");
      ISM.GiveItem(playerId, "PoliceVestBlack");
      ISM.GiveItem(playerId, "WandererPantsBlack");
      ISM.GiveItem(playerId, "CombatBootsBlack");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
    elseif (rnd == 2) then
      ISM.GiveItem(playerId, "M16", true);
      ISM.GiveItem(playerId, "STANAGx30", false, rifleId, "stanag_mag00");
      ISM.GiveItem(playerId, "OpticScope");
      ISM.GiveItem(playerId, "RifleSilencer");
      ISM.GiveItem(playerId, "ForegripVertical");
      ISM.GiveItem(playerId, "LaserSight");
      ISM.GiveItem(playerId, "FlashlightRifle");
      ISM.GiveItem(playerId, "ACAW", false);
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "HuntingScope");
      ISM.GiveItem(playerId, "G18Pistol", false);
      ISM.GiveItem(playerId, "9mmx33", false, rifleId, "9mmx33_mag00");
      ISM.GiveItem(playerId, "PistolSilencer");
      ISM.GiveItem(playerId, "FlashlightPistol");
      ISM.GiveItem(playerId, "FannyPackCamo2");
      ISM.GiveItem(playerId, "AdvancedBandage");
      ISM.GiveItem(playerId, "AdvancedBandage");
      ISM.GiveItem(playerId, "AdvancedBandage");
      ISM.GiveItem(playerId, "MilitaryJacketGreen");
      ISM.GiveItem(playerId, "DuffelBagGreen");
      ISM.GiveItem(playerId, "Aviators");
      ISM.GiveItem(playerId, "MilitaryHelmetGreen");
      ISM.GiveItem(playerId, "PoliceVestBlack");
      ISM.GiveItem(playerId, "WandererPantsBlack");
      ISM.GiveItem(playerId, "CombatBootsBlack");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
    elseif (rnd == 3) then
      ISM.GiveItem(playerId, "Mk18", true);
      ISM.GiveItem(playerId, "STANAGx30", false, rifleId, "stanag_mag00");
      ISM.GiveItem(playerId, "OpticScope");
      ISM.GiveItem(playerId, "RifleSilencer");
      ISM.GiveItem(playerId, "ForegripVertical");
      ISM.GiveItem(playerId, "LaserSight");
      ISM.GiveItem(playerId, "FlashlightRifle");
      ISM.GiveItem(playerId, "ACAW", false);
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "HuntingScope");
      ISM.GiveItem(playerId, "G18Pistol", false);
      ISM.GiveItem(playerId, "9mmx33", false, rifleId, "9mmx33_mag00");
      ISM.GiveItem(playerId, "PistolSilencer");
      ISM.GiveItem(playerId, "FlashlightPistol");
      ISM.GiveItem(playerId, "FannyPackCamo3");
      ISM.GiveItem(playerId, "AdvancedBandage");
      ISM.GiveItem(playerId, "AdvancedBandage");
      ISM.GiveItem(playerId, "AdvancedBandage");
      ISM.GiveItem(playerId, "MilitaryJacketTan");
      ISM.GiveItem(playerId, "DuffelBagTanCamo1");
      ISM.GiveItem(playerId, "Aviators");
      ISM.GiveItem(playerId, "MilitaryHelmetTan");
      ISM.GiveItem(playerId, "PoliceVestBlack");
      ISM.GiveItem(playerId, "WandererPantsBlack");
      ISM.GiveItem(playerId, "CombatBootsBlack");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
    elseif (rnd == 4) then
      ISM.GiveItem(playerId, "Mk18Reaver", true);
      ISM.GiveItem(playerId, "STANAGx30", false, rifleId, "stanag_mag00");
      ISM.GiveItem(playerId, "OpticScope");
      ISM.GiveItem(playerId, "RifleSilencer");
      ISM.GiveItem(playerId, "ForegripVertical");
      ISM.GiveItem(playerId, "LaserSight");
      ISM.GiveItem(playerId, "FlashlightRifle");
      ISM.GiveItem(playerId, "ACAW", false);
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "HuntingScope");
      ISM.GiveItem(playerId, "G18Pistol", false);
      ISM.GiveItem(playerId, "9mmx33", false, rifleId, "9mmx33_mag00");
      ISM.GiveItem(playerId, "PistolSilencer");
      ISM.GiveItem(playerId, "FlashlightPistol");
      ISM.GiveItem(playerId, "FannyPackCamo1");
      ISM.GiveItem(playerId, "AdvancedBandage");
      ISM.GiveItem(playerId, "AdvancedBandage");
      ISM.GiveItem(playerId, "AdvancedBandage");
      ISM.GiveItem(playerId, "MilitaryJacketUrbanCamo1");
      ISM.GiveItem(playerId, "DuffelBagUrbanCamo1");
      ISM.GiveItem(playerId, "Aviators");
      ISM.GiveItem(playerId, "MilitaryHelmetUrbanCamo1");
      ISM.GiveItem(playerId, "PoliceVestBlack");
      ISM.GiveItem(playerId, "WandererPantsBlack");
      ISM.GiveItem(playerId, "CombatBootsBlack");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
    elseif (rnd == 5) then
      ISM.GiveItem(playerId, "AKM", true);
      ISM.GiveItem(playerId, "762x30", false, rifleId, "762x30_mag00");
      ISM.GiveItem(playerId, "LaserSight");
      ISM.GiveItem(playerId, "FlashlightRifle");
      ISM.GiveItem(playerId, "ACAW", false);
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "HuntingScope");
      ISM.GiveItem(playerId, "G18Pistol", false);
      ISM.GiveItem(playerId, "9mmx33", false, rifleId, "9mmx33_mag00");
      ISM.GiveItem(playerId, "PistolSilencer");
      ISM.GiveItem(playerId, "FlashlightPistol");
      ISM.GiveItem(playerId, "FannyPackCamo2");
      ISM.GiveItem(playerId, "AdvancedBandage");
      ISM.GiveItem(playerId, "AdvancedBandage");
      ISM.GiveItem(playerId, "AdvancedBandage");
      ISM.GiveItem(playerId, "MilitaryJacketBlack");
      ISM.GiveItem(playerId, "DuffelBagBlack");
      ISM.GiveItem(playerId, "Aviators");
      ISM.GiveItem(playerId, "MilitaryHelmetUrbanCamo1");
      ISM.GiveItem(playerId, "PoliceVestBlack");
      ISM.GiveItem(playerId, "WandererPantsBlack");
      ISM.GiveItem(playerId, "CombatBootsBlack");
      ISM.GiveItem(playerId, "762x30");
      ISM.GiveItem(playerId, "762x30");
      ISM.GiveItem(playerId, "762x30");
      ISM.GiveItem(playerId, "762x30");
      ISM.GiveItem(playerId, "762x30");
      ISM.GiveItem(playerId, "762x30");
      ISM.GiveItem(playerId, "762x30");
      ISM.GiveItem(playerId, "762x30");
      ISM.GiveItem(playerId, "762x30");
      ISM.GiveItem(playerId, "762x30");
      ISM.GiveItem(playerId, "762x30");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
    elseif (rnd == 6) then
      ISM.GiveItem(playerId, "AKMGold", true);
      ISM.GiveItem(playerId, "762x30", false, rifleId, "762x30_mag00");
      ISM.GiveItem(playerId, "LaserSight");
      ISM.GiveItem(playerId, "FlashlightRifle");
      ISM.GiveItem(playerId, "ACAW", false);
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "HuntingScope");
      ISM.GiveItem(playerId, "G18Pistol", false);
      ISM.GiveItem(playerId, "9mmx33", false, rifleId, "9mmx33_mag00");
      ISM.GiveItem(playerId, "PistolSilencer");
      ISM.GiveItem(playerId, "FlashlightPistol");
      ISM.GiveItem(playerId, "FannyPackCamo3");
      ISM.GiveItem(playerId, "AdvancedBandage");
      ISM.GiveItem(playerId, "AdvancedBandage");
      ISM.GiveItem(playerId, "AdvancedBandage");
      ISM.GiveItem(playerId, "MilitaryJacketGreen");
      ISM.GiveItem(playerId, "DuffelBagGreen");
      ISM.GiveItem(playerId, "Aviators");
      ISM.GiveItem(playerId, "MilitaryHelmetGreen");
      ISM.GiveItem(playerId, "PoliceVestBlack");
      ISM.GiveItem(playerId, "WandererPantsBlack");
      ISM.GiveItem(playerId, "CombatBootsBlack");
      ISM.GiveItem(playerId, "762x30");
      ISM.GiveItem(playerId, "762x30");
      ISM.GiveItem(playerId, "762x30");
      ISM.GiveItem(playerId, "762x30");
      ISM.GiveItem(playerId, "762x30");
      ISM.GiveItem(playerId, "762x30");
      ISM.GiveItem(playerId, "762x30");
      ISM.GiveItem(playerId, "762x30");
      ISM.GiveItem(playerId, "762x30");
      ISM.GiveItem(playerId, "762x30");
      ISM.GiveItem(playerId, "762x30");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
    elseif (rnd == 7) then
      ISM.GiveItem(playerId, "AK74U", true);
      ISM.GiveItem(playerId, "545x30", false, rifleId, "545x30_mag00");
      ISM.GiveItem(playerId, "ACAW", false);
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "HuntingScope");
      ISM.GiveItem(playerId, "G18Pistol", false);
      ISM.GiveItem(playerId, "9mmx33", false, rifleId, "9mmx33_mag00");
      ISM.GiveItem(playerId, "PistolSilencer");
      ISM.GiveItem(playerId, "FlashlightPistol");
      ISM.GiveItem(playerId, "FannyPackCamo1");
      ISM.GiveItem(playerId, "AdvancedBandage");
      ISM.GiveItem(playerId, "AdvancedBandage");
      ISM.GiveItem(playerId, "AdvancedBandage");
      ISM.GiveItem(playerId, "MilitaryJacketTan");
      ISM.GiveItem(playerId, "DuffelBagTanCamo1");
      ISM.GiveItem(playerId, "Aviators");
      ISM.GiveItem(playerId, "MilitaryHelmetTan");
      ISM.GiveItem(playerId, "PoliceVestBlack");
      ISM.GiveItem(playerId, "WandererPantsBlack");
      ISM.GiveItem(playerId, "CombatBootsBlack");
      ISM.GiveItem(playerId, "545x30");
      ISM.GiveItem(playerId, "545x30");
      ISM.GiveItem(playerId, "545x30");
      ISM.GiveItem(playerId, "545x30");
      ISM.GiveItem(playerId, "545x30");
      ISM.GiveItem(playerId, "545x30");
      ISM.GiveItem(playerId, "545x30");
      ISM.GiveItem(playerId, "545x30");
      ISM.GiveItem(playerId, "545x30");
      ISM.GiveItem(playerId, "545x30");
      ISM.GiveItem(playerId, "545x30");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
    else
      ISM.GiveItem(playerId, "Bulldog", true);
      ISM.GiveItem(playerId, "STANAGx30", false, rifleId, "stanag_mag00");
      ISM.GiveItem(playerId, "ACAW", false);
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "HuntingScope");
      ISM.GiveItem(playerId, "G18Pistol", false);
      ISM.GiveItem(playerId, "9mmx33", false, rifleId, "9mmx33_mag00");
      ISM.GiveItem(playerId, "PistolSilencer");
      ISM.GiveItem(playerId, "FlashlightPistol");
      ISM.GiveItem(playerId, "FannyPackCamo2");
      ISM.GiveItem(playerId, "AdvancedBandage");
      ISM.GiveItem(playerId, "AdvancedBandage");
      ISM.GiveItem(playerId, "AdvancedBandage");
      ISM.GiveItem(playerId, "MilitaryJacketUrbanCamo1");
      ISM.GiveItem(playerId, "DuffelBagUrbanCamo1");
      ISM.GiveItem(playerId, "Aviators");
      ISM.GiveItem(playerId, "MilitaryHelmetUrbanCamo1");
      ISM.GiveItem(playerId, "PoliceVestBlack");
      ISM.GiveItem(playerId, "WandererPantsBlack");
      ISM.GiveItem(playerId, "CombatBootsBlack");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "STANAGx30");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "9mmx33");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
      ISM.GiveItem(playerId, "762x5");
    end
  end
end
  
RegisterCallback(Miscreated, 'EquipPlayer', nil, function (self, playerId) PlayerLoadout(playerId) end);
-- !joinf <factionno>
-- Joins the faction if its enabled and possible (forced: without requiring server restart)
-- <factionno> 0-6 (1,2 invalid)
ChatCommands["!joinf"] = function(playerId, command)
  Log(">> !joinf - %s", command)

  local player = System.GetEntity(playerId)
  
  player.actor:SetFaction( tonumber(command), true ) -- param is factionno, forced (forced meaning, player can switch faction at any point without server restart)
end
-- The following are some example chat commands
-- If you want to use them, please copy them into their own lua file and then upload them as a mod
-- !mirror <message>
-- Sends the message <message> back to the invoking player's chat window
-- The 4 below sends to the chat message window, using 0 it will appear at the top of the player's screen
-- Replace playerId with a 0 to send to all clients
--[[ChatCommands["!mirror"] = function(playerId, command)
	Log(">> !mirror - %s", command)

	g_gameRules.game:SendTextMessage(4, playerId, command);
end]]--
-- Send the player's position back to them via chat
ChatCommands["!mypos"] = function(playerId, command)
	Log(">> !mypos - %s", command);

	local player = System.GetEntity(playerId)
	local pos = player:GetWorldPos()

	g_gameRules.game:SendTextMessage(4, playerId, string.format("Your position is: %.1f %.1f %.1f", pos.x, pos.y, pos.z));
end
-- Teleport to a position
ChatCommands["!teleport"] = function(playerId, command)
    Log(">> !teleport - %s", command);

    local player = System.GetEntity(playerId);
    local steamid = player.player:GetSteam64Id();
    local allowCommand = steamid == "76561197992974688";
    
    if allowCommand then
    
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
--PushP management
PushP = { }
-- Push current position - Saves current position
ChatCommands["!pushp"] = function(playerId, command)
	Log(">> !pushp - %s", command);

	local player = System.GetEntity(playerId)
  local steamid = player.player:GetSteam64Id()
  local allowCommand = steamid == "76561197992974688" -- change this to some valid admin's Steam64 id
  
	if allowCommand then
    
    PushP[playerId] = player:GetWorldPos()
    
  end
end
-- Pop current position - Returns the player to the last saved position
ChatCommands["!popp"] = function(playerId, command)
	Log(">> !popp - %s", command);

	if PushP[playerId] then
		local player = System.GetEntity(playerId)
    local steamid = player.player:GetSteam64Id()
    local allowCommand = steamid == "76561197992974688" -- change this to some valid admin's Steam64 id
  
  if allowCommand then

      player.player:TeleportTo(PushP[playerId])
      
    end
  end
end
-- !rcon 
-- Execute console command on server
ChatCommands["!rcon"] = function(playerId, command)
	Log(">> !rcon - %s", command)

	local player = System.GetEntity(playerId)
  local steamid = player.player:GetSteam64Id()
  local allowCommand = steamid == "76561197992974688" -- change this to some valid admin's Steam64 id
  
	if allowCommand then
		System.ExecuteCommand(command)
	end
end
-- !time
-- Sets the time of day by executing the wm_forcetime rcon command
ChatCommands["!time"] = function(playerId, command)
	Log(">> !time - %s", command)

	local player = System.GetEntity(playerId)
  
  -- Only allow the following SteamId to invoke the command 
  local steamid = player.player:GetSteam64Id()
  local allowCommand = steamid == "76561197992974688" -- change this to some valid admin's Steam64 id
  
  -- or through faction restrictions
  -- allowCommand = allowCommand or nil ~= string.match(System.GetCVar("g_gameRules_faction4_steamids"), steamid)
  
  -- or through actual current faction
  -- allowCommand = allowCommand or 4 == player.actor:GetFaction() -- faction 0 to 7 (same numbering as cvars)
  
	if allowCommand then
		System.ExecuteCommand("wm_forceTime " .. command)
	end
end
-- !weather
-- Starts any of the weather pattern on the server (by number or name)
ChatCommands["!weather"] = function(playerId, command)
	Log(">> !weather - %s", command)

	local player = System.GetEntity(playerId)
  
  -- Only allow the following SteamId to invoke the command 
  local steamid = player.player:GetSteam64Id()
  local allowCommand = steamid == "76561197992974688" -- change this to some valid admin's Steam64 id
  
  -- or through faction restrictions
  -- allowCommand = allowCommand or nil ~= string.match(System.GetCVar("g_gameRules_faction4_steamids"), steamid)
  
  -- or through actual current faction
  -- allowCommand = allowCommand or 4 == player.actor:GetFaction() -- faction 0 to 7 (same numbering as cvars)
  
	if allowCommand then
		System.ExecuteCommand("wm_startPattern " .. command)
	end
end
-- !spawn <item_name>
-- Spawns the <item_name> 2m in front of the player at their feet level
-- <item_name> can be any valid item name in the game -ex. AT15
ChatCommands["!spawn"] = function(playerId, command)
	Log(">> !spawn - %s", command)

	local player = System.GetEntity(playerId)
  
  -- Only allow the following SteamId to invoke the command 
  local steamid = player.player:GetSteam64Id()
  local allowCommand = steamid == "76561197992974688" -- change this to some valid admin's Steam64 id
  
	if allowCommand then
		local vForwardOffset = {x=0,y=0,z=0}
		FastScaleVector(vForwardOffset, player:GetDirectionVector(), 2.0)

		local vSpawnPos = {x=0,y=0,z=0}
		FastSumVectors(vSpawnPos, vForwardOffset, player:GetWorldPos())

		ISM.SpawnItem(command, vSpawnPos)
	end
end
-- !give <item_name>
-- Gives the <item_name> to the invoking player and it will appear in their inventory
-- <item_name> can be any valid item name in the game -ex. AT15
ChatCommands["!give"] = function(playerId, command)
	Log(">> !give - %s", command)

	local player = System.GetEntity(playerId)
  
  -- Only allow the following SteamId to invoke the command 
  local steamid = player.player:GetSteam64Id()
  local allowCommand = steamid == "76561197992974688" -- change this to some valid admin's Steam64 id
  
  -- or through faction restrictions
  -- allowCommand = allowCommand or nil ~= string.match(System.GetCVar("g_gameRules_faction4_steamids"), steamid)
  
  -- or through actual current faction
  -- allowCommand = allowCommand or 4 == player.actor:GetFaction() -- faction 0 to 7 (same numbering as cvars)
  
	if allowCommand then
		local weaponId = ISM.GiveItem(playerId, command, true)
	end
end