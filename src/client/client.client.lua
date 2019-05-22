-- Services
local playersService = game:GetService("Players")
local runService = game:GetService("RunService")

-- Player
local player = PlayersService.LocalPlayer
local starterPlayer = player:WaitForChild("StarterPlayer")

-- Systems
local systems = {}

-- Handler require.
for _, handlerModule in pairs(starterPlayer.Client.handlers) do
	require(handlerModule)
end

-- System require.
for _, systemModule in pairs(starterPlayer.Client.systems:GetChildren()) do
	systems[systemModule.Name] = require(systemModule)
end

runService:BindToRenderStep("systemStep", Enum.RenderPriority.First, function(deltaTime)
	debug.profilebegin("systemStep")

	for systemName, system in pairs(systems) do
		system.Update(deltaTime)
	end

	debug.profileend("systemStep")
end)