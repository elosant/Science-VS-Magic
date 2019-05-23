-- Services
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")

local shared = replicatedStorage.shared

local sharedLib = shared.lib
local signalLib = require(sharedLib.signalLib)

local entityPool do
	if runService:IsClient() then
		entityPool = game:GetService("Players").LocalPlayer.client.entityPool
	elseif runService:IsServer() then
		entityPool = game:GetService("ServerStorage").server.entityPool
	end
end

local baseSystem = {}
baseSystem.registeredEntityCount = 0

function baseSystem.new(componentName)
	local componentPool = {}
	entityPool.componentEntityMap[componentName] = componentPool

	local system = {}

	function system.onEntityRegistered(entityId) -- Called by entityPool's addComponent function.
		baseSystem.registeredEntityCount = baseSystem.registeredEntityCount + 1

		-- Calls inhereted class' entity registered callback if it has one.
		if system["_onEntityRegistered"] then system._onEntityRegistered(entityId); end

		return entityId
	end

	function system.onEntityDeregistered(entityId) -- Called by entityPool's removeComponent function.
		-- Guard clause not needed, the entity is checked for its existence in entityPool.
		baseSystem.registeredEntityCount = baseSystem.registeredEntityCount - 1

		-- Calls inhereted class' entity registered callback if it has one.
		if system["_onEntityDeregistered"] then system._onEntityDeregistered(entityId); end
	end

	signalLib.subscribeAsync("componentAttached", function(attachedComponentName, entityId)
		if attachedComponentName ~= componentName then return end

		system.onEntityRegistered(entityId)
	end)

	signalLib.subscribeAsync("componentDetached", function(detachedComponentName, entityId)
		if detachedComponentName ~= componentName then return end

		system.onEntityRegistered(entityId)
	end)

	return system
end

return baseSystem