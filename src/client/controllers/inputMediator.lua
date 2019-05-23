-- This mediator relays an input invocation to a system/handler, of which is currently only the movementHandler
-- The cases are handled here instead of the handler since the hander are already at a high line count.

-- Services
local userInputService = game:GetService("UserInputService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local playersService = game:GetService("Players")

local player = playersService.LocalPlayer

local shared = replicatedStorage.shared

local sharedLib = shared.lib
local signalLib = require(sharedLib.signalLib)

local movementActionsMap = {
	dashRight = {
		Enum.KeyCode.E,
		Enum.KeyCode.DPadRight
	},

	dashLeft = {
		Enum.KeyCode.Q,
		Enum.KeyCode.DPadLeft
	}
}

player.CharacterAdded:Connect(function(character)
	character:WaitForChild("Humanoid").StateChanged:Connect(function(oldState, newState)
		if newState ~= Enum.HumanoidStateType.Running then return end

		signalLib.dispatchAsync("movementInputChange", "walking")
	end)
end)

userInputService.InputBegan:Connect(function(inputObject, gameProcessed)
	for movementType, keycodes in pairs(movementActionsMap) do
		for _, keycode in pairs(keycodes) do
			if inputObject.KeyCode == keycode then
				signalLib.dispatchAsync("movementInputChange", movementType)
				return
			end
		end
	end
end)

userInputService.JumpRequest:Connect(function()
	signalLib.dispatchAsync("movementInputChange", "jump")
end)

userInputService.InputEnded:Connect(function(inputObject, gameProcessed)
end)

userInputService.InputChanged:Connect(function(inputObject, gameProcessed)
end)


return nil