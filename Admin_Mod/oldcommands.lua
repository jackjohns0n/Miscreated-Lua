function Miscreated:ChatCommand(playerId, command)  
      -- Sends a message to the entire server via chat box
	if (string.sub(command, 1, 6) == "!wmsg ") then
    Log(player.player:GetSteam64Id())
		if (player.player:GetSteam64Id() == "76561197992974688") then
			g_gameRules.game:SendTextMessage(4, 0, string.sub(command, 7));
		end
    
    -- Sends a message to the entire server on screen
	elseif (string.sub(command, 1, 6) == "!wann ") then
    Log(player.player:GetSteam64Id())
		if (player.player:GetSteam64Id() == "76561197992974688") then
			g_gameRules.game:SendTextMessage(0, 0, string.sub(command, 7));
		end
    
    -- This is for Strict RP servers, gives the ability to ask other players questions "Out Of Character"
  elseif (string.sub(command, 1, 5) == "!OOC ") then
    Log(player.player:GetSteam64Id())
		if (player and player.player) then
			g_gameRules.game:SendTextMessage(4, 0, string.sub(command, 6));
		end
    
  elseif (string.sub(command, 1, 5) == "!help") then
    Log(player.player:GetSteam64Id())
		if (player and player.player) then
			g_gameRules.game:SendTextMessage(4, 0, "Welcome to the server, here are a list of available chat commands that currently work.  !song - this will display some song lyrics, !Woodhaven !Sultan !Pinecrest !Brightmoor !Cape Bay !Orca Dam !Clyde Hill !Hayward Valley !Orca Hostpital - these will announce to the server that you are looking for PVP Action in that area, !Free Shoes - this will spawn you a random pair of shoes, !Free Pants - this will spawn you a random pair of pants, !Free Shirt - this will spawn you a random shirt, !OCC - If this is a role playing server and you have a question about the game or something not having to do with Role Playing you can use this command to talk 'Out Of Character'.  These are currently the only commands I have working at the moment.  These commands were made by JackJohns0n, thank you for using my GameRules mod.");
		end
    
    --This was my "Hello World" Test
  elseif (string.sub(command, 1, 5) == "!song") then
    Log(player.player:GetSteam64Id())
    if (player and player.player) then
    g_gameRules.game:SendTextMessage(0, 0, "This is the song that never ends");
    end
    
  elseif (string.sub(command, 1, 10) == "!Woodhaven") then
    Log(player.player:GetSteam64Id())
    if (player and player.player) then
    g_gameRules.game:SendTextMessage(0, 0, "Come to Woohaven for some action!");
    end
    
  elseif (string.sub(command, 1, 7) == "!Sultan") then
    Log(player.player:GetSteam64Id())
    if (player and player.player) then
    g_gameRules.game:SendTextMessage(0, 0, "Come to Sultan for some action!");
    end
    
  elseif (string.sub(command, 1, 9) == "!Pinecrest") then
    Log(player.player:GetSteam64Id())
    if (player and player.player) then
    g_gameRules.game:SendTextMessage(0, 0, "Come to Pinecrest for some action!");
    end
    
  elseif (string.sub(command, 1, 11) == "!Brightmoor") then
    Log(player.player:GetSteam64Id())
    if (player and player.player) then
    g_gameRules.game:SendTextMessage(0, 0, "Come to Brightmoor for some action!");
    end
    
  elseif (string.sub(command, 1, 8) == "!Cape Bay") then
    Log(player.player:GetSteam64Id())
    if (player and player.player) then
    g_gameRules.game:SendTextMessage(0, 0, "Come to Cape Bay for some action!");
    end
    
  elseif (string.sub(command, 1, 9) == "!Orca Dam") then
    Log(player.player:GetSteam64Id())
    if (player and player.player) then
    g_gameRules.game:SendTextMessage(0, 0, "Come to Orca Dam for some action!");
    end
    
  elseif (string.sub(command, 1, 11) == "!Clyde Hill") then
    Log(player.player:GetSteam64Id())
    if (player and player.player) then
    g_gameRules.game:SendTextMessage(0, 0, "Come to Clyde Hill for some action!");
    end
    
  elseif (string.sub(command, 1, 15) == "!Hayward Valley") then
    Log(player.player:GetSteam64Id())
    if (player and player.player) then
    g_gameRules.game:SendTextMessage(0, 0, "Come to Woohaven for some action!");
    end
    
  elseif (string.sub(command, 1, 14) == "!Orca Hospital") then
    Log(player.player:GetSteam64Id())
    if (player and player.player) then
    g_gameRules.game:SendTextMessage(0, 0, "Come to Ocra Hospital for some action!");
    end
    
	elseif (string.sub(command, 1, 11) == "!Free Shoes") then	
    Log(player.player:GetSteam64Id())
		if (player and player.player) then
      local rnd = random(1, 3);
        if (rnd == 1) then
			ISM.GiveItem(playerId, "TennisShoes");
        elseif (rnd == 2) then
			ISM.GiveItem(playerId, "Sneakers");
        else
			ISM.GiveItem(playerId, "CanvasShoes");
      end
    end 
   		rnd = random(1, 4);
	
  elseif (string.sub(command, 1, 11) == "!Free Pants") then
  Log(player.player:GetSteam64Id())
		if (player and player.player) then
      local rnd = random(1, 4);
        if (rnd == 1) then
			ISM.GiveItem(playerId, "BlueJeans");
        elseif (rnd == 2) then
			ISM.GiveItem(playerId, "BlueJeans2");
        elseif (rnd == 3) then
			ISM.GiveItem(playerId, "BlueJeans2Brown");
        else
			ISM.GiveItem(playerId, "BlueJeans2Green");
      end
    end 
  
  elseif (string.sub(command, 1, 11) == "!Free Shirt") then	
  Log(player.player:GetSteam64Id())
    if (player and player.player) then
      local	rnd = random(1, 6);
        if (rnd == 1) then
			ISM.GiveItem(playerId, "TshirtNoImageBlack");
        elseif (rnd == 2) then
			ISM.GiveItem(playerId, "TshirtNoImageBlue");
        elseif (rnd == 3) then
			ISM.GiveItem(playerId, "TshirtNoImageGreen");
        elseif (rnd == 4) then
			ISM.GiveItem(playerId, "TshirtNoImageGrey");
        elseif (rnd == 5) then
			ISM.GiveItem(playerId, "TshirtNoImagePink");
        else
			ISM.GiveItem(playerId, "TshirtNoImageRed");
      end
    end
  end
end