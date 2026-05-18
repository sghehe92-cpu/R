local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
if not player then return end

local character = player.Character
if not character then
    character = player.CharacterAdded:Wait()
end

local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local auraActive = true
local attackSpeed = 0.25
local lastAttackTime = 0
local auraSize = 50
local damage = 25

print("Aura Kill Script Started!")

local connection
connection = RunService.Heartbeat:Connect(function()
    if not character or not humanoidRootPart or not humanoidRootPart.Parent then
        connection:Disconnect()
        return
    end
    
    if not auraActive then return end
    
    local currentTime = tick()
    if currentTime - lastAttackTime < attackSpeed then return end
    lastAttackTime = currentTime
    
    for _, targetPlayer in pairs(Players:GetPlayers()) do
        if targetPlayer ~= player and targetPlayer.Character then
            local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
            local targetHumanoid = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
            
            if targetRoot and targetHumanoid and targetHumanoid.Health > 0 then
                local dist = (humanoidRootPart.Position - targetRoot.Position).Magnitude
                if dist <= auraSize then
                    targetHumanoid:TakeDamage(damage)
                end
            end
        end
    end
end)
