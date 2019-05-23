-- Services
local replicatedStorage = game:GetService("ReplicatedStorage")

local shared = replicatedStorage.shared

local sharedLib = shared.lib
local networkLib = require(sharedLib.networkLib)
local signalLib = require(sharedLib.signalLib)

networkLib.listenToServer("dataRequestFailed", function()
end)

networkLib.listenToServer("playerDataLoaded", function()
end)

return nil