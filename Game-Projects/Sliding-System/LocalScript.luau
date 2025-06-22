-- Services
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")

-- Local player
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:FindFirstChildOfClass("Humanoid")

-- Animations
local animation = script:FindFirstChildOfClass("Animation")
local animationTrack = humanoid:LoadAnimation(animation)

-- Slide configuration
local SLIDE_CONFIG = {
	Cooldown = 0.1,
	BaseSpeed = 55,
	HipHeight = { Normal = 0, Slide = -2 },
	MaxMultiplier = 2,
	SpeedChangeRate = { Forward = 1, Upward = 2, Downward = 1 },
	PushOnCancel = true,
	PushVelocity = { Forward = 50, Up = 50 }
}

-- Variables
local isSliding = false
local canSlide = true
local currentMultiplier = 1
local alignGyro = nil
local slideVelocity = nil
local slideConnection = nil

-- Raycast parameters
local rayParams = RaycastParams.new()
rayParams.FilterDescendantsInstances = { character }
rayParams.FilterType = Enum.RaycastFilterType.Exclude


local function stopSlide()
	if not isSliding then return end
	isSliding = false
	
	if slideConnection then
		slideConnection:Disconnect()
		slideConnection = nil
	end
	if slideVelocity then
		slideVelocity:Destroy()
		slideVelocity = nil
	end
	if alignGyro then
		alignGyro:Destroy()
		alignGyro = nil
	end

	animationTrack:Stop(0.15)
	humanoid.HipHeight = SLIDE_CONFIG.HipHeight.Normal
	
	task.delay(SLIDE_CONFIG.Cooldown, function()
		canSlide = true
	end)
end

local function applyPushVelocity(multiplier)
	if SLIDE_CONFIG.PushOnCancel then
		local push = Instance.new("BodyVelocity")
		push.MaxForce = Vector3.new(40000, 40000, 40000)
		push.Velocity =
			(humanoidRootPart.CFrame.LookVector * (SLIDE_CONFIG.PushVelocity.Forward * multiplier)) +
			(humanoidRootPart.CFrame.UpVector * SLIDE_CONFIG.PushVelocity.Up)
		push.Parent = humanoidRootPart
		Debris:AddItem(push, 0.1)
	end
end

local function startSlide()
	if isSliding or not canSlide then return end
	
	local groundRay = workspace:Raycast(
		humanoidRootPart.Position,
		-humanoidRootPart.CFrame.UpVector * 5,
		rayParams
	)
	
	if not groundRay then return end

	isSliding = true
	canSlide = false
	currentMultiplier = 1

	animationTrack:Play(0.15)
	humanoid.HipHeight = SLIDE_CONFIG.HipHeight.Slide

	slideVelocity = Instance.new("BodyVelocity")
	slideVelocity.MaxForce = Vector3.new(40000, 0, 40000)
	slideVelocity.Velocity = humanoidRootPart.CFrame.LookVector * SLIDE_CONFIG.BaseSpeed
	slideVelocity.Parent = humanoidRootPart

	alignGyro = Instance.new("BodyGyro")
	alignGyro.MaxTorque = Vector3.new(3e5, 3e5, 3e5)
	alignGyro.P = 10000
	alignGyro.Parent = humanoidRootPart

	-- Slide Loop
	local previousY = humanoidRootPart.Position.Y
	slideConnection = RunService.RenderStepped:Connect(function(dt)
		local currentY = humanoidRootPart.Position.Y
		local verticalChange = currentY - previousY
		previousY = currentY

		local ray = workspace:Raycast(
			humanoidRootPart.Position,
			-humanoidRootPart.CFrame.UpVector * 10,
			rayParams
		)
		
		if ray then
			local right = humanoidRootPart.CFrame.RightVector
			local up = ray.Normal
			local look = right:Cross(up)
			alignGyro.CFrame = CFrame.fromMatrix(humanoidRootPart.Position, right, up, look)
		end

		-- Speed multiplier logic based on movement
		if math.abs(verticalChange) < 0.1 then
			currentMultiplier = math.clamp(
				currentMultiplier - SLIDE_CONFIG.SpeedChangeRate.Forward * dt,
				0,
				SLIDE_CONFIG.MaxMultiplier
			)
		elseif verticalChange > 0 then
			currentMultiplier = math.clamp(
				currentMultiplier - SLIDE_CONFIG.SpeedChangeRate.Upward * dt,
				0,
				SLIDE_CONFIG.MaxMultiplier
			)
		else
			currentMultiplier = math.clamp(
				currentMultiplier + SLIDE_CONFIG.SpeedChangeRate.Downward * dt,
				0,
				SLIDE_CONFIG.MaxMultiplier
			)
		end

		-- Update velocity
		slideVelocity.Velocity =
			humanoidRootPart.CFrame.LookVector *
			SLIDE_CONFIG.BaseSpeed *
			currentMultiplier

		-- End slide if stopped or not on ground
		if currentMultiplier < 0.1 or not ray then
			stopSlide()
		end
	end)
end

-- Input Handling
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.C then
		startSlide()
	elseif input.KeyCode == Enum.KeyCode.Space then
		local prevMultiplier = currentMultiplier
		stopSlide()
		applyPushVelocity(prevMultiplier)
	end
end)

