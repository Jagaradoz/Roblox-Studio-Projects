local TweenService = game:GetService("TweenService")

local random = Random.new()
local BUILDING_ANIMATION_PART_DELAY = 0.03
local model = script.Parent

-- Finding all base parts and stores in table.
local function getBasePartDescendants(ancestor)
	local result = {}
	
	for _, instance in pairs(ancestor:GetDescendants()) do
		if instance:IsA("BasePart") then table.insert(result, instance) end
	end
	
	return result
end

-- Create original specified properties in dictionary.
local function getOriginalProperties(instances, properties)
	local dictionary = {}
	
	for _, inst in ipairs(instances) do
		dictionary[inst] = {}
		for _, prop in ipairs(properties) do
			dictionary[inst][prop] = inst[prop]
		end
	end
	
	return dictionary
end

-- Animate the fancy fade in animation.
local function animateBuildingIn(buildingModel, tweenInfo)
	local parts = getBasePartDescendants(buildingModel)
	local originals = getOriginalProperties(parts, {"Transparency", "CFrame", "Color", "Size"})
	
    -- Set all parts in random properties.
	for _, part in ipairs(parts) do
		part.Transparency = 1
		part.Color = Color3.fromRGB(255,255,255)
		part.Size = Vector3.new()
		part.CFrame *= CFrame.new(
			random:NextNumber(-1,1),
			random:NextNumber(-0.25,1.75),
			random:NextNumber(-1,1)
		) * CFrame.Angles(
			random:NextNumber(-math.pi,math.pi),
			random:NextNumber(-math.pi,math.pi),
			random:NextNumber(-math.pi,math.pi)
		)
	end
	
    -- Play the animation to reach original properties.
	for _, part in ipairs(parts) do
		local tween = TweenService:Create(part, tweenInfo, originals[part])
		
		tween.Completed:Connect(function()
			for prop, value in pairs(originals[part]) do part[prop] = value end
		end)
		
		tween:Play()
		task.wait(BUILDING_ANIMATION_PART_DELAY)
	end
end

-- Apply the animation.
while task.wait(2) do
	animateBuildingIn(model, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out))
end

