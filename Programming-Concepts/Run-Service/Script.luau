local RunService = game:GetService("RunService")

-- Frame Update Cycle (Fastest to Slowest):
    -- User Input: Captures player input events first, before rendering or simulation.
    -- Rendering: Fires just before the frame is rendered on screen (client-only).
    -- Wait States:
        -- task.wait(): yields execution until the next Heartbeat or RenderStepped cycle.
        -- task.spawn(): schedules a function to run asynchronously (like a lightweight thread).
        -- task.delay(): schedules a function to run after a delay, non-blocking.
    -- Garbage Collection: Runs automatically in the background to free unused memory, impacting performance but not exposed as event.
    -- Physics Simulation: Stepped event fires before the physics simulation step.
    -- Heartbeat: Heartbeat event fires after physics simulation; used for game logic updates.

-- 1. Events for game loop:
    -- Heartbeat: Fires every frame *after* physics simulation; use for game logic that depends on physics updates
    -- Stepped: Fires every frame *before* physics simulation; good for input processing or pre-physics updates
    -- RenderStepped: (Client-Only) Fires every frame *before rendering*; only runs on the client, use for smooth camera updates, GUI animations, etc.
RunService.Heartbeat:Connect(function(deltaTime) ... end)           -- deltaTime = time since last Heartbeat event
RunService.Stepped:Connect(function(time, deltaTime) ... end)       -- time = current time, deltaTime = time since last Stepped event
RunService.RenderStepped:Connect(function(deltaTime) ... end)       -- deltaTime = time since last RenderStepped event

-- 2. Temporary Connection: Connect to an event and disconnect
local connection = RunService.Heartbeat:Connect(function() ... end)
connection:Disconnect()

-- 3. Environment Checks:
    -- :IsStudio()         : Is the game running in Roblox Studio?
    -- :IsServer()         : Is the current script running on the server?
    -- :IsClient()         : Is the current script running on the client?
local isStudio = RunService:IsStudio()
local isServer = RunService:IsServer()
local isClient = RunService:IsClient()

-- 4. Other RunService Methods:
RunService:Set3dRenderingEnabled(bool)                              -- Enable or disable 3D rendering (mostly used in Studio for testing)
RunService:BindToRenderStep(name, priority, callback)               -- Binds a function to RenderStepped with a priority for precise control over render order
RunService:UnbindFromRenderStep(name)                               -- Removes a previously bound RenderStep callback
RunService:Run()                                                    -- Starts the game loop (usually not called by developers)
RunService:Pause()                                                  -- Pauses the game loop (used internally)