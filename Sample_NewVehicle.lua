--[[ -- remove the block comment to enable

local newVehicle = {
	class = "new_vehicle_class_name", -- TODO: Add class name here
	contents = "RandomF100TruckContents"
	}

-- search category to modify... (replace dune_buggy with the spawner cone type you wish to expand)
local categoryToAdjust = FindInTable(VehicleSpawnerManager.vehicleCategories, "category", "dune_buggy")

-- insert into the table and determine the current class count
local oldCount = #categoryToAdjust.classes
table.insert(categoryToAdjust.classes, newVehicle)
local newCount = #categoryToAdjust.classes

-- add more vehicles so that the new one is being selected as well
categoryToAdjust.initialMinVehicles = categoryToAdjust.initialMinVehicles * math.ceil(newCount / oldCount)

-- can be used to output changed script to server.log
-- examine the log file if everything is correct, in doubt you can log information out using System.Log
--dump(VehicleSpawnerManager)

]]--
