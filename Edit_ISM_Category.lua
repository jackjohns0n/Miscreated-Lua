-- I use this function to remove an entire category from a table based on the category name.
function RemoveItemFromTable(tbl, keyname, keyvalue)
	for i,v in ipairs(tbl) do
	    if (v[keyname] == keyvalue) then
			-- If the current table category name is the one we are looking for then
			-- remove the category from the table.
	        table.remove(tbl, i);
	        break;
	   end
	end
end
-- Calls the function RemoveItemFromTable and tells it to look in the ItemSpawnerManager
-- table's itemCategories Table for a category called RandomHazmatSuit
RemoveItemFromTable(ItemSpawnerManager.itemCategories, "category", "RandomHazmatSuit")
-- Here we created the new RandomHazmatSuit category that will replace the one we removed
local newItem = {
                    category = "RandomHazmatSuit",
					classes = 
					{
						{class = "HazmatSuitBlack", percent = 7 }, -- My new item added to the list
						{class = "HazmatSuitBlue", percent = 8 }, -- all percentages adjusted to
						{class = "HazmatSuitGreen", percent = 8 }, -- total 100%
						{class = "HazmatSuitPink", percent = 11 },
						{class = "HazmatSuitOrange", percent = 8 },
						{class = "HazmatSuitWhite", percent = 8 },
						{class = "HazmatSuitYellow", percent = 8 },
						{class = "HazmatMask", percent = 21 },
						{class = "GasCanisterPack", percent = 21 },
					}	
                }
-- Here we are adding the new RandomHazmatSuit category we created to the ItemSpawnManager's itemCategories Table
table.insert(ItemSpawnerManager.itemCategories, newItem)