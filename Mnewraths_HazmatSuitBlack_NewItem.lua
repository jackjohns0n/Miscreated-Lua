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
-- Now we are removing the RandomMilitaryItems category from the ItemSpawnManager's itemCategories Table
RemoveItemFromTable(ItemSpawnerManager.itemCategories, "category", "RandomMilitaryItems")
-- Here is the new RandomMilitaryItems category we are creating
local newItem = {
                    category = "RandomMilitaryItems",
					classes =
					{
						{ category = "RandomAccessory", percent = 3 },
						{ category = "RandomCraftingGuide", percent = 1 },
						{ category = "RandomGhillieSuit", percent = 1 },
						{ category = "RandomHazmatSuit", percent = 2 }, -- Here is the RandomHazmatSuit category
						{ category = "RandomMilitaryClothing", percent = 31 },
						{ category = "RandomMilitaryGrenade", percent = 15 },
						{ category = "RandomMilitaryWeaponWithMagazines", percent = 12 },
						{ class = "HazmatSuitBlack", percent = 3 }, -- I also added the HazmatSuitBlack on it's own just because
						{ class = "Binoculars", percent = 2 },
						{ class = "C4Bricks", percent = 0.1 },
						{ class = "Cb_radio", percent = 5 },
						{ class = "GasMask", percent = 1 },
						{ class = "GridMap", percent = 3 },
						{ class = "Maglite", percent = 3 },
						{ class = "MagliteSmall", percent = 2 },
						{ class = "MilitaryCanteenPlastic", percent = 4 },
						{ class = "MilitaryCanteenMetal", percent = 2 },
						{ class = "MRE", percent = 3 },
						{ class = "SurvivalKnife", percent = 2.9 },
						{ class = "hesco_barrier", percent = 4 },
					},
                }
-- Now we are adding the new RandomMilitaryItems category to the table
table.insert(ItemSpawnerManager.itemCategories, newItem)
-- Now we are removeing the original RandomHospitalClothes category so we can add our own to the table.
RemoveItemFromTable(ItemSpawnerManager.itemCategories, "category", "RandomHospitalClothes")
-- Here is our new RandomHospitalClothes category
local newItem = {
					category = "RandomHospitalClothes",
					classes =
					{
						{ category = "RandomHospitalClothesSmall", percent = 25 },
						{ category = "RandomClothes", percent = 10 },
						{ class = "HazmatSuitWhite", percent = 10 },
						{ class = "HazmatSuitBlack", percent = 10 }, -- Added my HazmatSuitBlack
						{ class = "GasCanisterPack", percent = 10 }, -- and adjusted all the percentages
						{ class = "RainJacketOrangeBlue", percent = 5}, -- to equal 100%
						{ class = "RainJacketYellow", percent = 5},
						{ class = "RainJacketRed", percent = 5},
						{ class = "ButtonUpShirtBlue", percent = 5},
						{ class = "ButtonUpShirtGrey", percent = 5},
						{ class = "CottonShirtBlue", percent = 5 },
						{ class = "CottonShirtTan", percent = 5 },
					},
				}
-- Finally, adding the new RandomHospitalClothes category
table.insert(ItemSpawnerManager.itemCategories, newItem)