-- Script pour activer/désactiver le Noclip et le vol dans Roblox

-- Obtenir le joueur local et son personnage
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- État initial du Noclip et du vol
local noclip = false
local flying = false

-- Fonction pour gérer les collisions en fonction de l'état du Noclip
game:GetService("RunService").Stepped:Connect(function()
    if noclip then
        -- Si Noclip est activé, désactiver la collision pour toutes les parties du personnage
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    else
        -- Si Noclip est désactivé, réactiver la collision pour toutes les parties du personnage
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end)

-- Fonction pour gérer le vol
local flySpeed = 50 -- Vitesse de vol
local movement = Vector3.new(0, 0, 0)
game:GetService("RunService").RenderStepped:Connect(function()
    if flying then
        -- Utilisation de la caméra pour déterminer la direction du vol
        local cam = game.Workspace.CurrentCamera
        local direction = cam.CFrame.LookVector * movement.Z + cam.CFrame.RightVector * movement.X + Vector3.new(0, movement.Y, 0)
        
        -- Déplacer le personnage dans la direction voulue
        character:MoveTo(character.HumanoidRootPart.Position + direction * (flySpeed * game:GetService("RunService").RenderStepped:Wait()))
    end
end)

-- Gestion des entrées pour le vol et le Noclip
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.N then
            noclip = not noclip -- Inverser l'état de Noclip
            flying = noclip -- Assumer que le vol est actif uniquement si le Noclip l'est
            if noclip then
                print("Noclip et Vol activés. Appuyez sur N pour désactiver.")
            else
                print("Noclip et Vol désactivés. Appuyez sur N pour activer.")
            end
        elseif flying then
            if input.KeyCode == Enum.KeyCode.W then
                movement = movement + Vector3.new(0, 0, 1)
            elseif input.KeyCode == Enum.KeyCode.S then
                movement = movement + Vector3.new(0, 0, -1)
            elseif input.KeyCode == Enum.KeyCode.A then
                movement = movement + Vector3.new(-1, 0, 0)
            elseif input.KeyCode == Enum.KeyCode.D then
                movement = movement + Vector3.new(1, 0, 0)
            elseif input.KeyCode == Enum.KeyCode.Space then
                movement = movement + Vector3.new(0, 1, 0)
            elseif input.KeyCode == Enum.KeyCode.LeftControl then
                movement = movement + Vector3.new(0, -1, 0)
            end
        end
    end
end)

-- Arrêter le mouvement quand les touches sont relâchées
game:GetService("UserInputService").InputEnded:Connect(function(input, gameProcessed)
    if not gameProcessed and flying then
        if input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.S then
            movement = Vector3.new(movement.X, movement.Y, 0)
        elseif input.KeyCode == Enum.KeyCode.A or input.KeyCode == Enum.KeyCode.D then
            movement = Vector3.new(0, movement.Y, movement.Z)
        elseif input.KeyCode == Enum.KeyCode.Space or input.KeyCode == Enum.KeyCode.LeftControl then
            movement = Vector3.new(movement.X, 0, movement.Z)
        end
    end
end)

-- Note : 
-- Ce script doit être utilisé avec précaution car l'utilisation de Noclip et de vol peut être considérée comme une triche dans certains serveurs de jeu. 
-- Assurez-vous que vous avez la permission d'utiliser ce type de script sur le serveur où vous jouez.
-- Ce script doit être placé dans un script LocalScript attaché à un objet dans le StarterPlayerScripts.
