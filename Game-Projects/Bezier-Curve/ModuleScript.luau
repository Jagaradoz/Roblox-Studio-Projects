local function cubicBezier(t, p0, p1, p2, p3)
	return (1-t)^3 * p0 
		+ 3 * (1-t)^2 * t * p1
		+ 3 * (1-t) * t^2 * p2
		+ t^3 * p3
end

local function createLUT(numSegments, ...)
	local distSum = 0
	local sums = {}
	local step = 1/numSegments
	
	for i = 0, 1, step do
		local firstPoint = cubicBezier(i, ...)
		local secondPoint = cubicBezier(i + step, ...)
		local dist = (secondPoint - firstPoint).Magnitude
		
		table.insert(sums, distSum)
		distSum += dist
	end
	
	return sums
end

local function remap(n, oldMin, oldMax, min, max)
	return (min + ((max-min) * ((n-oldMin) / (oldMax - oldMin))))
end

local Bezier = {}

function Bezier.New(numSegments, p0, p1, p2, p3)
	local self = setmetatable({}, { __index = Bezier })
	
	self._points = {p0, p1, p2, p3}
	self._distLUT = createLUT(numSegments, p0, p1, p2, p3)
	
	return self
end

function Bezier:Calculate(t)
	local LUT = self._distLUT
	local arcLength = LUT[#LUT]
	local targetDist = arcLength * t
	
	for i, dist in pairs(LUT) do
		local nextDist = LUT[i+1]
		
		if targetDist >= dist and targetDist< nextDist then
			local adjustedT = remap(targetDist, dist, nextDist, i/#LUT, (i+1)/#LUT) 
			
			return cubicBezier(adjustedT, unpack(self._points))
		end
	end
end


return Bezier
