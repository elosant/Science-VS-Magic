-- Services
local serverStorage = game:GetService("ServerStorage")
local runService = game:GetService("RunService")

-- Systems
local systems = {}

-- Handler require.
for _, handlerModule in pairs(serverStorage.Server.handlers) do
	require(handlerModule)
end

-- System require.
for _, systemModule in pairs(serverStorage.Server.systems:GetChildren()) do
	systems[systemModule.Name] = require(systemModule)
end

runService:BindToRenderStep("systemStep", Enum.RenderPriority.First, function(deltaTime)
	for systemName, system in pairs(systems) do
		system.Update(deltaTime)
	end
end)
