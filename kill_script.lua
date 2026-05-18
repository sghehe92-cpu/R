local Players = game:GetService("Players")
local player = Players.LocalPlayer

while not player.Character do
    wait(0.1)
end

local humanoid = player.Character:WaitForChild("Humanoid")
humanoid.Health = 0
print("Player killed!")
