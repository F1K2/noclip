-- Assure-toi d'avoir les bonnes permissions pour utiliser ce script dans Roblox.

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Variable pour activer/désactiver le noclip
local noclip = false

-- Fonction pour gérer le noclip
game:GetService("RunService").Stepped:Connect(function()
    if noclip then
        for i, v in pairs(character:GetChildren()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    else
        for i, v in pairs(character:GetChildren()) do
            if v:IsA("BasePart") then
                v.CanCollide = true
            end
        end
    end
end)

-- Touche pour basculer le noclip (ici, c'est la touche 'N')
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.N then
            noclip = not noclip
            if noclip then
                print("Noclip activé")
            else
                print("Noclip désactivé")
            end
        end
    end
end)
