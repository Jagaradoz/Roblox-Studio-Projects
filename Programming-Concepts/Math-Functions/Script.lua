local angleDeg = 45
local angleRad = math.rad(angleDeg)        -- Convert degrees to radians

-- Trigonometric functions (input in radians)
local sinVal = math.sin(angleRad)          -- Opposite / Hypotenuse
local cosVal = math.cos(angleRad)          -- Adjacent / Hypotenuse
local tanVal = math.tan(angleRad)          -- sin / cos

-- Inverse trig (output in radians)
local asinVal = math.asin(sinVal)          -- Returns angle for given sin
local acosVal = math.acos(cosVal)          -- Returns angle for given cos
local atanVal = math.atan(tanVal)          -- Returns angle for tan
local atan2Val = math.atan2(1, 1)          -- atan2(y, x), handles quadrants

-- Conversions
local backToDeg = math.deg(angleRad)       -- Radians to degrees

-- General math
local x = -3.7
local absVal = math.abs(x)                 -- Absolute value (3.7)
local signVal = math.sign(x)               -- Sign (-1)

local floorVal = math.floor(x)             -- Round down (-4)
local ceilVal = math.ceil(x)               -- Round up (-3)
local roundVal = math.round(x)             -- Nearest integer (-4)

-- Exponent & log
local expVal = math.exp(2)                 -- e^2
local logVal = math.log(100)               -- Natural log (ln)
local log10Val = math.log10(100)           -- Base-10 log

-- Power, sqrt
local powVal = math.pow(2, 3)              -- 2^3 = 8
local sqrtVal = math.sqrt(16)              -- √16 = 4

-- Clamp, min, max
local clamped = math.clamp(15, 0, 10)      -- Result = 10
local minimum = math.min(3, 7, 2)          -- Result = 2
local maximum = math.max(3, 7, 2)          -- Result = 7
