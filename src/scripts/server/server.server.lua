-- Services
local serverStorage = game:GetService("ServerStorage")
local runService = game:GetService("RunService")

-- Systems
local systems = {}

-- Handler require.
for _, handlerModule in pairs(serverStorage.server.handlers:GetChildren()) do
	pcall(function()
		spawn(function()
			require(handlerModule)
		end)
	end)
end

-- System require.
for _, systemModule in pairs(serverStorage.server.systems:GetChildren()) do
	pcall(function()
		systems[systemModule.Name] = require(systemModule)
	end)
end

runService:BindToRenderStep("systemStep", Enum.RenderPriority.First.Value, function(deltaTime)
	for systemName, system in pairs(systems) do
		spawn(system.update(deltaTime))
	end
end)
