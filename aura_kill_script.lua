local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local auraActive = false
local attackSpeed = 0.25 -- 4x faster (1 attack per 0.25 sec = 4 attacks per sec)
local lastAttackTime = 0
local auraSize = 50 -- Aura radius

-- Mobile touch input for aura toggle
UserInputService.TouchTap:Connect(function(tap, gameProcessed)
    if gameProcessed then return end
    auraActive = not auraActive
    print("Aura " .. (auraActive and "ACTIVATED" or "DEACTIVATED"))
end)

-- Keyboard input (F key) for aura toggle
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F then
        auraActive = not auraActive
        print("Aura " .. (auraActive and "ACTIVATED" or "DEACTIVATED"))
    end
end)

-- Main aura attack loop
RunService.RenderStepped:Connect(function()
    if not auraActive or not character or not humanoidRootPart then return end
    
    local currentTime = tick()
    if currentTime - lastAttackTime < attackSpeed then return end
    lastAttackTime = currentTime
    
    -- Find all players in aura range
    for _, targetPlayer in pairs(Players:GetPlayers()) do
        if targetPlayer ~= player and targetPlayer.Character then
            local targetHumanoidRootPart = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
            local targetHumanoid = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
            
            if targetHumanoidRootPart and targetHumanoid and targetHumanoid.Health > 0 then
                local distance = (humanoidRootPart.Position - targetHumanoidRootPart.Position).Magnitude
                
                if distance <= auraSize then
                    -- Deal damage to target
                    targetHumanoid:TakeDamage(25) -- Damage per attack
                    print("Hit " .. targetPlayer.Name .. "! Health: " .. targetHumanoid.Health)
                end
            end
        end
    end
end)

print("Aura Kill Attack Script Loaded!")
print("Press F or tap screen to toggle aura")
print("Attack Speed: 4x faster (4 attacks per second)")
