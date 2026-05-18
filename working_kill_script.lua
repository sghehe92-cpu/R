local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local auraActive = false
local attacksPerSecond = 12000
local attackCooldown = 1 / attacksPerSecond
local lastAttackTime = 0
local attackRange = 60
local attackDamage = 100

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
    
    local currentTime = tick()
    if currentTime - lastAttackTime < attackCooldown then return end
    lastAttackTime = currentTime
    
    for _, targetPlayer in pairs(Players:GetPlayers()) do
        if targetPlayer ~= player and targetPlayer.Character then
            local targetHumanoidRootPart = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
            local targetHumanoid = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
            
            if targetHumanoidRootPart and targetHumanoid then
                local distance = (myHumanoidRootPart.Position - targetHumanoidRootPart.Position).Magnitude
                
                if distance <= attackRange then
                    targetHumanoid:TakeDamage(attackDamage)
                end
            end
        end
    end
end)

print("Aura Kill Script Loaded!")
print("Press F to toggle aura")
print("APS: 12000 | Damage: 100 | Radius: 60")
