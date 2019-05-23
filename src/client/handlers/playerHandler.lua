-- Services
local replicatedStorage = game:GetService("ReplicatedStorage")
local playersService = game:GetService("Players")

-- Player
local player = playersService.LocalPlayer
local playerScripts = player:WaitForChild("PlayerScripts")

local client = playerScripts.client
local shared = replicatedStorage.shared

local entityPool = require(shared.entityPool)

return nil