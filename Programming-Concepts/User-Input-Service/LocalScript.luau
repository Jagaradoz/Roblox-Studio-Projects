-- UserInputService Scenarios:
-- Keyboard, mouse, touch, and gamepad input events
-- Input state queries
-- Input device connections/disconnections
-- Mobile sensors
-- Focus and input capturing

local UserInputService = game:GetService("UserInputService")

-- 1. Detect keyboard key press and release
    -- InputBegan: fired when key/button pressed
    -- InputEnded: fired when key/button released
    -- InputChanged: fired when input state changes (e.g., mouse move)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end                                            -- Prevent unintendtionally fired (e.g. Chatting, Clicking Built-in Gui)

    if input.UserInputType == Enum.UserInputType.Keyboard then ... end          -- Handle any keyboard key press here
    if input.KeyCode == Enum.KeyCode.R then ... end                             -- Handle specifically R key pressed
    if input.UserInputType == Enum.UserInputType.MouseButton1 then ... end      -- Handle left mouse button pressed
    if input.UserInputType == Enum.UserInputType.MouseButton2 then ... end      -- Handle right mouse button pressed
    if input.UserInputType == Enum.UserInputType.MouseButton3 then ... end      -- Handle middle mouse button pressed
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then ... end                  -- Handle specifically W key is holding
end)
UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input.UserInputType == Enum.UserInputType.Keyboard then ... end          -- Handle any keyboard key press here
    if input.KeyCode == Enum.KeyCode.R then ... end                             -- Handle specifically R key pressed
    if input.UserInputType == Enum.UserInputType.MouseButton1 then ... end      -- Handle left mouse button pressed
    if input.UserInputType == Enum.UserInputType.MouseButton2 then ... end      -- Handle right mouse button pressed
    if input.UserInputType == Enum.UserInputType.MouseButton3 then ... end      -- Handle middle mouse button pressed
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then ... end                  -- Handle specifically W key is holding
end)
UserInputService.InputChanged:Connect(function(input, gameProcessed)
    if gameProcessed then return end                                            -- Prevent unintendtionally fired (e.g. Chatting, Clicking Built-in Gui)

    if input.UserInputType == Enum.UserInputType.MouseMovement then ... end     -- Handle mouse movement here
end)

-- 4. Detect touch input
    -- TouchTap: fired on screen tap gesture
    -- TouchSwipe: fired on swipe gesture
UserInputService.TouchTap:Connect(function(touchPositions, gameProcessed)
    if gameProcessed then return end                                            -- Prevent unintendtionally fired (e.g. Chatting, Clicking Built-in Gui)

    print("Screen tapped at positions:", touchPositions)
end)
UserInputService.TouchSwipe:Connect(function(touchPositions, gameProcessed)
    if gameProcessed then return end                                            -- Prevent unintendtionally fired (e.g. Chatting, Clicking Built-in Gui)

    print("Swipe detected")
end)

-- 5. Detect gamepad input (buttons pressed/released)
UserInputService.GamepadConnected:Connect(function(gamepad)
    print("Gamepad connected:", gamepad)
end)
UserInputService.GamepadDisconnected:Connect(function(gamepad)
    print("Gamepad disconnected:", gamepad)
end)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.Gamepad1 then
        print("Gamepad button pressed:", input.KeyCode.Name)
    end
end)

-- 6. Detect focus and keyboard input capture (e.g., typing in TextBox)
UserInputService.TextBoxFocused:Connect(function()
    print("Player started typing")
end)
UserInputService.TextBoxFocusReleased:Connect(function()
    print("Player stopped typing")
end)

-- 7. Detect accelerometer or gyroscope (mobile device tilt)
UserInputService.AccelerometerChanged:Connect(function(acceleration)
    print("Acceleration:", acceleration)
end)
UserInputService.GyroscopeChanged:Connect(function(rotation)
    print("Gyroscope rotation:", rotation)
end)

-- 8. Detect Jump Request
UserInputService.JumpRequest:Connect(function() ... end)

-- 9. Detect other platform connected
local result1 = UserInputService.TouchedEnabled
local result2 = UserInputService.GamepadEnabled
local result3 = UserInputService.VREnabled