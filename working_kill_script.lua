local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local auraActive = false

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.F then
        auraActive = not auraActive
        print("Aura " .. (auraActive and "ON" or "OFF"))
    end
end)

RunService.Heartbeat:Connect(function()
    if not auraActive or not player.Character then return end
    
    local myHumanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
    if not myHumanoidRootPart then return end
    
    for _, targetPlayer in pairs(Players:GetPlayers()) do
        if targetPlayer ~= player and targetPlayer.Character then
            local targetHumanoidRootPart = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
            local targetHumanoid = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
            
            if targetHumanoidRootPart and targetHumanoid then
                local distance = (myHumanoidRootPart.Position - targetHumanoidRootPart.Position).Magnitude
                
                if distance <= 60 then
                    targetHumanoid:TakeDamage(100)
                end
            end
        end
    end
end)

print("Aura Kill Script Loaded!")
print("Press F to toggle aura")
print("Radius: 60 | Damage: 100 per sec")
