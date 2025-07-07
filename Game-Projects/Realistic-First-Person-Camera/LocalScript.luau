local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

local character = player.Character or player.CharacterAdded:Wait()
local humanoid = player.Character:WaitForChild("Humanoid")
local camera = workspace.CurrentCamera

camera.CameraType = Enum.CameraType.Scriptable

local bobSpeed = .2
local bobDistance = .2
local bobWalkMulti = 55
local walkVeloThreshold = 9

local defaultFOV = 60
local targetFOV = 60
local fovChange = 8
local maxFOVvelocity = 10
local FOVsmooth = 3

local sensitivity =  .4 
local maxVerticalAngle = math.rad(80) 
local turnLeanAmt = 320
local turnLeanSmoothing = .9
local turnLeanMax = .2 

local camSmooth = 16

local targetCFrame = CFrame.new()
local targetRot = CFrame.Angles(0, 0, 0)
local verticalAngle = 0
local horizontalAngle = 0
local zAngle = 0

-- Lock the mouse.
local function lockMouse(iconEnabled)
	UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
	UserInputService.MouseIconEnabled = iconEnabled
end

-- Rotate camera smoothly.
local function updateCameraRotation(change)
	local c = change * sensitivity
	horizontalAngle += math.rad(c.x)
	zAngle = math.clamp(zAngle + (c.x / turnLeanAmt), -turnLeanMax, turnLeanMax) 
	verticalAngle = math.clamp(verticalAngle + math.rad(c.y), -maxVerticalAngle, maxVerticalAngle)

	targetRot = CFrame.Angles(0, horizontalAngle, 0) * CFrame.Angles(verticalAngle, 0, 0)
end

-- Make Bobbing Effect and position for the camera.
local function updateCameraPosition()
	if character and character.PrimaryPart then
		local bobPos = math.sin(tick() * bobSpeed) * bobDistance 

		if character.PrimaryPart.AssemblyLinearVelocity.Magnitude >= walkVeloThreshold then
			bobPos = math.sin(tick() * (bobSpeed * bobWalkMulti)) * bobDistance
		end

		local offset = Vector3.new(0, bobPos, 0)
		local targetPosition = character.PrimaryPart.Position + offset

		targetCFrame = CFrame.new(targetPosition) * targetRot
	end
end

-- Smoothly rotate in z-axis.
local function smoothCameraZAxis(deltaTime)
	local amt = deltaTime / turnLeanSmoothing

	if zAngle > 0 then
		zAngle = math.max(zAngle - amt, 0)
	elseif zAngle < 0 then
		zAngle = math.min(zAngle + amt, 0)
	end

	local zRotation = CFrame.Angles(0, 0, zAngle)
	targetRot = CFrame.Angles(0, horizontalAngle, 0) * CFrame.Angles(verticalAngle, 0, 0) * zRotation
end

-- FOV for the smooth.
local function updateFOV(deltaTime)
	if not player.Character or not player.Character.PrimaryPart then
		return
	end

	local velocity = player.Character.PrimaryPart.AssemblyLinearVelocity.Magnitude
	local normalizedVelocity = math.clamp(velocity / maxFOVvelocity, 0, 1)
	targetFOV = defaultFOV + (normalizedVelocity * fovChange)

	camera.FieldOfView = camera.FieldOfView + (targetFOV - camera.FieldOfView) * deltaTime * FOVsmooth
end

local function onInputChanged(input, gameProcessed)
	if gameProcessed then return end 

	if input.UserInputType == Enum.UserInputType.MouseMovement then
		updateCameraRotation(-Vector3.new(input.Delta.X, input.Delta.Y, 0))
	end
end

local function onTouchMoved(touch, gameProcessed)
	if gameProcessed then return end

	updateCameraRotation(-Vector3.new(touch.Delta.X, touch.Delta.Y, 0))
end

local function onRenderStepped(deltaTime)
	updateCameraPosition()
	smoothCameraZAxis(deltaTime)
	updateFOV(deltaTime)

	camera.CFrame = camera.CFrame:Lerp(targetCFrame, deltaTime * camSmooth)

	if character and character.PrimaryPart then
		local _, camY, _ = camera.CFrame:ToOrientation()
		character:SetPrimaryPartCFrame(CFrame.new(character.PrimaryPart.Position) * CFrame.Angles(0, camY, 0))
	end
end

UserInputService.WindowFocused:Connect(function() lockMouse(false) end)
UserInputService.InputChanged:Connect(onInputChanged)
UserInputService.TouchMoved:Connect(onTouchMoved)
RunService.RenderStepped:Connect(onRenderStepped)

local function makeCharacterTransparent(character)
	for _, descendant in ipairs(character:GetDescendants()) do
		if descendant:IsA("BasePart") or descendant:IsA("Decal") then
			descendant.Transparency = 1
		end
	end

	for _, accessory in ipairs(character:GetChildren()) do
		if accessory:IsA("Accessory") and accessory:FindFirstChild("Handle") then
			accessory.Handle.Transparency = 1
		end
	end
end

player.CharacterAdded:Connect(makeCharacterTransparent)

task.wait(2)

if player.Character then
	makeCharacterTransparent(player.Character)
end