-- Services
local serverStorage = game:GetService("ServerStorage")
local playersService = game:GetService("Players")

local server = serverStorage.server

-- Lib
local playerDataLib = require(server.lib.playerDataLib)

-- Shared Lib
local networkLib = require(server.lib.networkLib)
local signalLib = require(server.lib.signalLib)

playersService.PlayerAdded:Connect(function(player)
	playerDataLib.initPlayerData()

	signalLib.dispatchAsync("playerDataLoaded", player)
	networkLib.fireToClient(player, "playerDataLoaded")
end)

playersService.PlayerRemoving:Connect(function(player)
	playerDataLib.save(player)
	playerDataLib.destroy(player)
end)

game:BindToClose(function()
	for _, player in pairs(playersService:GetChildren()) do
		playerDataLib.save(player)
		playerDataLib.destroy(player)
	end
end)