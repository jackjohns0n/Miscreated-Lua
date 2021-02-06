--[[
--These are the game settings, game will not start until 10 people are on the server, kills=score and score limit is 20.
--First to 20 kills wins.  
--For testing purposes, time limit is set to 600 seconds (10 minutes) and only headshots will register damage.  [This is no longer the case, but I am leaving here for posterity]
g_minplayerlimit=10
g_minPlayersForRankedGame=10
g_scoreLimit=10
g_mpHeadshotsOnly = 1
g_timelimit = 600
]]--
function Miscreated.Server:OnInit()
	Log(">> StartGame")
  Log(">> Huzzah It Works!")

		System.ExecuteCommand("g_minplayerlimit 10")
    System.ExecuteCommand("g_scoreLimit 20")
    System.ExecuteCommand("g_timelimit 2700")
end