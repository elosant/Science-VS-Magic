-- Services
local playersService = game:GetService("Players")
local runService = game:GetService("RunService")

-- Player
local player = playersService.LocalPlayer
local playerScripts = player:WaitForChild("PlayerScripts")

local client = playerScripts.client

-- Systems
local systems = {}

-- System require.
for _, systemModule in pairs(playerScripts.client.systems:GetChildren()) do
	pcall(function()
		spawn(function()
			systems[systemModule.Name] = require(systemModule)
		end)
	end)
end

runService:BindToRenderStep("systemStep", Enum.RenderPriority.First.Value, function(deltaTime)
	debug.profilebegin("systemStep")

	for systemName, system in pairs(systems) do
		spawn(system.update(deltaTime))
	end

	debug.profileend("systemStep")
end)

-- Controller require.
for _, controller in pairs(client.controllers:GetChildren()) do
	pcall(function()
		spawn(function()
			require(controller)
		end)
	end)
end

-- Handler require, is done after system require, some handlers have a dependency on a system to register an entity.
for _, handlerModule in pairs(playerScripts.client.handlers:GetChildren()) do
	pcall(function()
		spawn(function()
			require(handlerModule)
		end)
	end)
end