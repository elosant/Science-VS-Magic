-- Services
local playersService = game:GetService("Players")
local runService = game:GetService("RunService")

-- Player
local player = playersService.LocalPlayer
local playerScripts = player:WaitForChild("PlayerScripts")

-- Systems
local systems = {}

-- Handler require.
for _, handlerModule in pairs(playerScripts.client.handlers:GetChildren()) do
	require(handlerModule)
end

-- System require.
for _, systemModule in pairs(playerScripts.client.systems:GetChildren()) do
	systems[systemModule.Name] = require(systemModule)
end

runService:BindToRenderStep("systemStep", Enum.RenderPriority.First.Value, function(deltaTime)
	debug.profilebegin("systemStep")

	for systemName, system in pairs(systems) do
		system.Update(deltaTime)
	end

	debug.profileend("systemStep")
end)