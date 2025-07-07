local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.BreakJointsOnDeath = false

        humanoid.Died:Connect(function()
            for _, descendant in ipairs(character:GetDescendants()) do
                if descendant:IsA("Motor6D") then
                    local attachment0 = Instance.new("Attachment")
                    local attachment1 = Instance.new("Attachment")
                    attachment0.CFrame = descendant.C0
                    attachment1.CFrame = descendant.C1
                    attachment0.Parent = descendant.Part0
                    attachment1.Parent = descendant.Part1

                    local ballSocket = Instance.new("BallSocketConstraint")
                    ballSocket.Attachment0 = attachment0
                    ballSocket.Attachment1 = attachment1
                    ballSocket.Parent = descendant.Part0

                    descendant:Destroy()
                end
            end

            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                rootPart.CanCollide = false
            end
        end)
    end)
end)
