local RANGE = 10
local ROWS = 100
local COLS = 100

local OFFSET_X = math.random(-100, 100)
local OFFSET_Y = math.random(-100, 100)

local function createPart(x, y, alpha)
	local part = Instance.new("Part")
	part.Size = Vector3.new(1, 1, 1)
	part.Anchored = true
	part.Position = Vector3.new(x, alpha * RANGE, y)
	part.Parent = workspace
end

for y = 1, COLS do
	for x = 1, ROWS do
		local noise = math.noise(x/ROWS + OFFSET_X, y/COLS + OFFSET_Y, 0)
		createPart(x, y, noise)
	end
end
