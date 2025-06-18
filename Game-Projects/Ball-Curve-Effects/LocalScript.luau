-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

-- Player & Character
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Objects
local part = ReplicatedStorage:WaitForChild("Part")
local start = workspace:WaitForChild("Start")

-- Configuration
local spacing = 2              				-- Distance between each clone
local height = 10              				-- Peak height of the arc
local travelTime = 1           				-- Time for each clone to reach the target
local amount = 5               				-- Number of clones per effect burst

-- Curved path calculation
local function curvePath(startPosition: Vector3, endPosition: Vector3, time: number)
	local base = startPosition:Lerp(endPosition, time)                              
	local arcHeight = math.sin(time * math.pi) * height                       
	return Vector3.new(base.X, base.Y + arcHeight, base.Z)
end

-- Effects
local function createEffects()
	local clones = {}
	local startPosition = start.Position
	local targetPosition = character.PrimaryPart.Position

	-- Generation
	for i = 1, amount do
		local clone = part:Clone()
		clone.Parent = workspace

		local offset = (i - (amount + 1) / 2) * spacing                           
		clone.Position = startPosition + Vector3.new(offset, 0, 0)

		table.insert(clones, clone)
	end

	-- Animation
	for i, clone in clones do
		local thisStartPosition = clone.Position
		local startTime = tick()

		local runServiceEvent = RunService.RenderStepped:Connect(function()
			local time = (tick() - startTime) / travelTime
			if time > 1 then return end

			clone.Position = curvePath(thisStartPosition, character.PrimaryPart.Position, time)
		end)

		task.spawn(function()
			task.wait(travelTime)
			clone.Trail.Enabled = false
			clone.Transparency = 1

			task.wait(1)

			clone:Destroy()
			print("DESTROYED")
			runServiceEvent = nil
		end)
	end
end

-- Repeating Effects
while task.wait(3) do
	createEffects()
end
