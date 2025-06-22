-- Properties
local cf1 = CFrame.new(10, 5, -3)                                                   -- Creates a CFrame at position (10,5,-3) with no rotation
local cf2 = CFrame.new(Vector3.new(1, 2, 3))                                        -- Creates a CFrame at the given Vector3 position
local rotation = CFrame.Angles(0, math.rad(90), 0)                                  -- Creates rotation-only CFrame from radians around X, Y, Z axes
local lookAtCf = CFrame.lookAt(Vector3.new(0, 5, 0), Vector3.new(10, 5, 10))        -- Creates a CFrame looking at target point
local lookAlongCf = CFrame.lookAlong(Vector3.new(0, 0, -1))                         -- Creates a CFrame facing along a direction vector
local axisAngleCf = CFrame.fromAxisAngle(Vector3.new(1, 0, 0), math.rad(90))        -- Creates a CFrame rotated around an axis by an angle
local fromMatrixCf = CFrame.fromMatrix(                                             -- Creates a CFrame at (0,0,0) with custom rotation axes (here, the identity/orientation is unchanged)
    Vector3.new(0, 0, 0),                           -- Position
    Vector3.new(1, 0, 0),                           -- Right (X axis)
    Vector3.new(0, 1, 0),                           -- Up (Y axis)
    Vector3.new(0, 0, 1)                            -- Back (Z axis)
)                                                                                   

-- Methods:
local exampleCF = cf1 * CFrame.new(0, 0, 0, 1, 0, 0, 0, 1.2, 0, 0, 0, 1)            -- Example of skewed rotation matrix
local correctedCf = exampleCF:Orthonormalize()                                      -- Corrects and normalizes rotation axes
local worldCf = cf1:ToWorldSpace(CFrame.new(1, 0, 0))                               -- Converts local-space CFrame to world-space
local backToLocal = cf1:ToObjectSpace(worldCf)                                      -- Converts world-space CFrame to local space
local inverseCf = cf1:Inverse()                                                     -- Returns inverse transformation of this CFrame
local halfway = CFrame.new(0, 0, 0):Lerp(CFrame.new(10, 0, 0), 0.5)                 -- Interpolates between two CFrames

-- Conversions
local cfToPos = cf1.Position                                                        -- Extracts position vector from CFrame
local posToCf = CFrame.new(Vector3.new(5, 10, 15))                                  -- Creates CFrame from a Vector3 position

-- Unit Vectors
local right = cf1.RightVector                                                       -- Right direction unit vector
local up = cf1.UpVector                                                             -- Up direction unit vector
local look = cf1.LookVector                                                         -- Forward (look) direction unit vector
