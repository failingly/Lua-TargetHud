-- Target HUD Script (LocalScript)
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local playerGui = player:WaitForChild("PlayerGui")

-- Create a ScreenGui to hold the HUD
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui

-- Create the outer box (dark background)
local outerBox = Instance.new("Frame")
outerBox.Size = UDim2.new(0, 200, 0, 120)  -- Height remains unchanged
outerBox.Position = UDim2.new(0.5, -100, 0.8, -140)  -- Set Y to 0.8 to keep it on screen but below center (adjust YOffset as needed)
outerBox.BackgroundColor3 = Color3.fromRGB(22, 22, 31)  -- Dark color: #16161f
outerBox.BackgroundTransparency = 0.5
outerBox.Parent = screenGui
outerBox.Visible = false

-- Create the inner box (lighter background)
local innerBox = Instance.new("Frame")
innerBox.Size = UDim2.new(1, 0, 1, -20)  -- Slightly smaller than outerBox
innerBox.Position = UDim2.new(0, 0, 0, 20)  -- Positioned inside the outer box
innerBox.BackgroundColor3 = Color3.fromRGB(25, 25, 37)  -- Lighter color: #191925
innerBox.BackgroundTransparency = 0.5
innerBox.Parent = outerBox

-- Create the top line (colored #6759b3)
local topLine = Instance.new("Frame")
topLine.Size = UDim2.new(1, 0, 0, 5)
topLine.Position = UDim2.new(0, 0, 0, 0)
topLine.BackgroundColor3 = Color3.fromRGB(103, 89, 179)  -- Color: #6759b3
topLine.Parent = outerBox

-- Create player's display name label
local displayNameLabel = Instance.new("TextLabel")
displayNameLabel.Size = UDim2.new(1, 0, 0, 20)
displayNameLabel.Position = UDim2.new(0, 0, 0, 10)
displayNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White font color
displayNameLabel.BackgroundTransparency = 1
displayNameLabel.Font = Enum.Font.SourceSans
displayNameLabel.TextSize = 14
displayNameLabel.Text = ""
displayNameLabel.Parent = innerBox

-- Create the player's equipped item label
local equippedItemLabel = Instance.new("TextLabel")
equippedItemLabel.Size = UDim2.new(1, 0, 0, 20)
equippedItemLabel.Position = UDim2.new(0, 0, 0, 30)  -- Positioned below the display name
equippedItemLabel.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White font color
equippedItemLabel.BackgroundTransparency = 1
equippedItemLabel.Font = Enum.Font.SourceSans
equippedItemLabel.TextSize = 12
equippedItemLabel.Text = "None"  -- Default text
equippedItemLabel.Parent = innerBox

-- Create health bar background
local healthBarBackground = Instance.new("Frame")
healthBarBackground.Size = UDim2.new(0.9, 0, 0, 10)
healthBarBackground.Position = UDim2.new(0.05, 0, 0, 60)  -- Moved down to avoid overlap with avatar
healthBarBackground.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
healthBarBackground.Parent = innerBox

-- Create health bar (colored #800080)
local healthBar = Instance.new("Frame")
healthBar.Size = UDim2.new(0, 100, 0, 10)
healthBar.Position = UDim2.new(0, 0, 0, 0)
healthBar.BackgroundColor3 = Color3.fromRGB(128, 0, 128)  -- Health bar color: #800080
healthBar.Parent = healthBarBackground

-- Create the avatar image
local avatarImage = Instance.new("ImageLabel")
avatarImage.Size = UDim2.new(0, 40, 0, 40)
avatarImage.Position = UDim2.new(0, 10, 0, 10)
avatarImage.BackgroundTransparency = 1
avatarImage.Parent = innerBox

-- Update the HUD when hovering over a player
local function updateTargetHUD()
    local targetPlayer = nil
    local targetCharacter = nil
    local targetHumanoid = nil
    local targetHead = nil

    -- Check if the mouse is hovering over a player
    for _, otherPlayer in pairs(game.Players:GetPlayers()) do
        if otherPlayer.Character and otherPlayer.Character:FindFirstChild("Head") then
            local head = otherPlayer.Character.Head
            local distance = (mouse.Hit.p - head.Position).magnitude
            
            -- Adjust the distance for when the HUD shows up (set a smaller range, e.g. 5 studs)
            if distance < 5 then  -- Reduced the distance threshold
                targetPlayer = otherPlayer
                targetCharacter = otherPlayer.Character
                targetHumanoid = targetCharacter:FindFirstChild("Humanoid")
                targetHead = head
                break
            end
        end
    end

    -- If the mouse is hovering over a player
    if targetPlayer and targetHumanoid then
        -- Show the HUD and update the player's display name
        outerBox.Visible = true
        displayNameLabel.Text = targetPlayer.DisplayName

        -- Update the equipped item label
        local equippedTool = targetPlayer.Character:FindFirstChildOfClass("Tool")
        if equippedTool then
            equippedItemLabel.Text = equippedTool.Name
        else
            equippedItemLabel.Text = "None"
        end

        -- Update the health bar based on the Humanoid's health
        local healthPercentage = targetHumanoid.Health / targetHumanoid.MaxHealth
        healthBar.Size = UDim2.new(healthPercentage, 0, 1, 0)

        -- Update the avatar picture
        local avatarId = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. targetPlayer.UserId .. "&width=420&height=420&format=png"
        avatarImage.Image = avatarId
    else
        -- Hide the HUD if no player is being hovered over
        outerBox.Visible = false
    end
end

-- Connect the update function to a RenderStepped event for continuous updates
game:GetService("RunService").RenderStepped:Connect(updateTargetHUD)
