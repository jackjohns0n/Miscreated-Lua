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