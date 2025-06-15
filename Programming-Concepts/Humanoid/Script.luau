-- Humanoid States (Enum.HumanoidStateType):
    -- Enum.HumanoidStateType.Freefall                  : In air, falling
    -- Enum.HumanoidStateType.FallingDown               : After impact, ragdoll-like moment
    -- Enum.HumanoidStateType.GettingUp                 : Transition from falling to standing
    -- Enum.HumanoidStateType.Jumping                   : When jump is triggered
    -- Enum.HumanoidStateType.Landed                    : When landing after Freefall
    -- Enum.HumanoidStateType.Running                   : Moving horizontally
    -- Enum.HumanoidStateType.RunningNoPhysics          : Like Running but no floor contact
    -- Enum.HumanoidStateType.Climbing                  : While on climbable surface
    -- Enum.HumanoidStateType.Seated                    : Sitting (e.g., in vehicle seat)
    -- Enum.HumanoidStateType.Swimming                  : In water
    -- Enum.HumanoidStateType.Dead                      : After Health <= 0
    -- Enum.HumanoidStateType.Physics                   : Generic physics-controlled state
    -- Enum.HumanoidStateType.StrafingNoPhysics         : Used for strafing animations
humanoid:GetState()
humanoid:ChangeState(Enum.HumanoidStateType.Jumping)

-- Humanoid Events:
    -- .Running(speed)                   : Fires when character is moving (speed > 0)
    -- .Jumping(active)                  : Fires when jumping starts
    -- .FallingDown()                    : When character enters FallingDown state
    -- .StateChanged(old, new)           : Fires when state changes
    -- .Died()                           : Fires on death
    -- .Seated(active, seat)             : Fires when sitting or standing from seat
    -- .Climbing(speed)                  : Fires while climbing
    -- .Swimming(speed)                  : Fires while swimming
    -- .MoveDirection                    : Property, but updates movement direction
humanoid.Running:Connect(function(speed) ... end)
humanoid.Jumping:Connect(function() ... end)
humanoid.Seated:Connect(function(active, seat) ... end)

-- Humanoid Key Properties:
    -- Health (number)                       : Current health (0 = dead)
    -- MaxHealth (number)                    : Maximum health value
    -- WalkSpeed (number)                    : Movement speed (default 16)
    -- JumpPower (number)                    : Jump height (default 50), or use JumpHeight
    -- AutoRotate (bool)                     : Whether character auto-faces MoveDirection
    -- PlatformStand (bool)                  : Disables animation/movement when true
    -- Sit (bool)                            : Puts character into seated state
    -- Jump (bool)                           : Triggers jump when set true
    -- MoveDirection (Vector3)               : Current direction based on input (unit vector)
    -- FloorMaterial (Enum.Material)         : Material beneath feet (nil if in air)
print("HP:", humanoid.Health)
print("Is seated:", humanoid.Sit)
print("Move direction:", humanoid.MoveDirection)
if humanoid.FloorMaterial == Enum.Material.Air then print("Player is airborne") end

-- Humanoid Methods:
    -- :Move(direction: Vector3, relativeToCamera: bool)        : Controls character movement manually
    -- :TakeDamage(amount: number)                              : Reduces health by amount (triggers .Died if <= 0)
    -- :ApplyDescription(desc: HumanoidDescription)             : Applies appearance data from a HumanoidDescription
    -- :GetAppliedDescription()                                 : Returns current applied HumanoidDescription
    -- :AddAccessory(accessory: Accessory)                      : Adds an accessory to the character
    -- :Sit()                                                   : Forces the humanoid to enter the seated state
humanoid:Move(Vector3.new(1, 0, 0), true)                
humanoid:TakeDamage(10)                                 
local desc = humanoid:GetAppliedDescription()           
humanoid:ApplyDescription(desc)                         
character:WaitForChild("Hat"):Clone().Parent = character
humanoid:Sit()                                          

-- Examples:
humanoid.Health = 0                                         -- Kill player
humanoid.Health = humanoid.MaxHealth                        -- Heal player to full
humanoid.StateChanged:Connect(function(old, new) ... end)   -- Detect state change
humanoid.WalkSpeed = 24                                     -- Change WalkSpeed 
humanoid.JumpPower = 70                                     -- Change JumpPower
humanoid.Died:Connect(function() ... end)                   -- Detect when character dies