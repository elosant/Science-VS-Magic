-- Services
local replicatedStorage = game:GetService("ReplicatedStorage")
local playersService = game:GetService("Players")

local player = playersService.LocalPlayer

local shared = replicatedStorage.shared

local sharedLib = shared.lib
local signalLib = require(sharedLib.signalLib)

signalLib.subscribeAsync("movementInputChange", function(movementType)
	print(movementType)
end)

return nil