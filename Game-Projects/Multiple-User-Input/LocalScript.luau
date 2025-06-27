local UserInputService = game:GetService("UserInputService")

local binds = {}

local MultipleUserInputModule = {}

function MultipleUserInputModule:BindKeyPresses(name, callback, ...)
	local keys = table.pack(...)
	keys.n = nil
	
	binds[name] = UserInputService.InputBegan:Connect(function(input)
		if input.KeyCode and input.KeyCode == keys[#keys] then
			for i, key in pairs(keys) do
				if not UserInputService:IsKeyDown(key) then
					return
				end
			end
			
			callback()
		end
	end)
end

function MultipleUserInputModule:UnbindKeyPresses(name)
	if binds[name] then
		binds[name]:Disconnect()
	end
end

return MultipleUserInputModule
