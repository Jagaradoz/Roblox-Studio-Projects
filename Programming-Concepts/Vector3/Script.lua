-- Declarations:
local v1 = Vector3.new(1, 2, 3)
local v2 = Vector3.new(4, 5, 6)

-- Operations:
local add = v1 + v2            -- Vector addition: (5,7,9)
local sub = v1 - v2            -- Vector subtraction: (-3,-3,-3)
local mul = v1 * 2             -- Scalar multiplication: (2,4,6)
local div = v2 / 2             -- Scalar division: (2,2.5,3)

-- Methods:
local length = (v2-v1).Magnitude    -- Length (distance from v2 to v1 in magnitude)
local unit = v1.Unit                -- Normalized to a unit vector
local dot = v1:Dot(v2)              -- Dot product (scalar)
local cross = v1:Cross(v2)          -- Cross product (vector perpendicular to both)

-- Application:
part.Position = v1
part.Size = v1
part.Orientation = v1