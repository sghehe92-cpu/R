local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local player = Players:WaitForChild("LocalPlayer") or Players.LocalPlayer

if not player then
    print("Error: Could not find LocalPlayer")
    return
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input.KeyCode == Enum.KeyCode.F then
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:TakeDamage(humanoid.MaxHealth)
            end
        end
    end
end)
