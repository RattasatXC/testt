
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Wait for Character and PlayerGui
while not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") or not LocalPlayer.PlayerGui do
    task.wait(0.1)
end

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "sp"
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false
local success, result = pcall(function()
    ScreenGui.Parent = LocalPlayer.PlayerGui
end)
if not success then
    ScreenGui.Parent = game:GetService("CoreGui")
    print("Failed to set ScreenGui to PlayerGui, using CoreGui: " .. result)
end

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 420)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
MainFrame.ClipsDescendants = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Make GUI Draggable
local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- GUI Elements
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Title.Text = "BlockSpin Aimbot & ESP"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame
local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = Title

-- Aimbot (Head) Toggle
local AimbotHeadButton = Instance.new("TextButton")
AimbotHeadButton.Size = UDim2.new(0.9, 0, 0, 50)
AimbotHeadButton.Position = UDim2.new(0.05, 0, 0, 50)
AimbotHeadButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
AimbotHeadButton.Text = "fix"
AimbotHeadButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AimbotHeadButton.TextSize = 18
AimbotHeadButton.Font = Enum.Font.SourceSans
AimbotHeadButton.Parent = MainFrame
local AimbotHeadButtonCorner = Instance.new("UICorner")
AimbotHeadButtonCorner.CornerRadius = UDim.new(0, 5)
AimbotHeadButtonCorner.Parent = fix

-- Aimbot (Medium) Toggle
local AimbotMediumButton = Instance.new("TextButton")
AimbotMediumButton.Size = UDim2.new(0.9, 0, 0, 50)
AimbotMediumButton.Position = UDim2.new(0.05, 0, 0, 110)
AimbotMediumButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
AimbotMediumButton.Text = "fix"
AimbotMediumButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AimbotMediumButton.TextSize = 18
AimbotMediumButton.Font = Enum.Font.SourceSans
AimbotMediumButton.Parent = MainFrame
local AimbotMediumButtonCorner = Instance.new("UICorner")
AimbotMediumButtonCorner.CornerRadius = UDim.new(0, 5)
AimbotMediumButtonCorner.Parent = fix

-- ESP Toggle
local EspButton = Instance.new("TextButton")
EspButton.Size = UDim2.new(0.9, 0, 0, 50)
EspButton.Position = UDim2.new(0.05, 0, 0, 170)
EspButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
EspButton.Text = "ESP: OFF"
EspButton.TextColor3 = Color3.fromRGB(255, 255, 255)
EspButton.TextSize = 18
EspButton.Font = Enum.Font.SourceSans
EspButton.Parent = MainFrame
local EspButtonCorner = Instance.new("UICorner")
EspButtonCorner.CornerRadius = UDim.new(0, 5)
EspButtonCorner.Parent = EspButton

-- Hitbox Toggle
local HitboxButton = Instance.new("TextButton")
HitboxButton.Size = UDim2.new(0.9, 0, 0, 50)
HitboxButton.Position = UDim2.new(0.05, 0, 0, 230)
HitboxButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
HitboxButton.Text = "Hitbox: OFF"
HitboxButton.TextColor3 = Color3.fromRGB(255, 255, 255)
HitboxButton.TextSize = 18
HitboxButton.Font = Enum.Font.SourceSans
HitboxButton.Parent = MainFrame
local HitboxButtonCorner = Instance.new("UICorner")
HitboxButtonCorner.CornerRadius = UDim.new(0, 5)
HitboxButtonCorner.Parent = HitboxButton

-- Auto-Punch Toggle
local AutoPunchButton = Instance.new("TextButton")
AutoPunchButton.Size = UDim2.new(0.9, 0, 0, 50)
AutoPunchButton.Position = UDim2.new(0.05, 0, 0, 290)
AutoPunchButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
AutoPunchButton.Text = "Auto-Punch: OFF"
AutoPunchButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoPunchButton.TextSize = 18
AutoPunchButton.Font = Enum.Font.SourceSans
AutoPunchButton.Parent = MainFrame
local AutoPunchButtonCorner = Instance.new("UICorner")
AutoPunchButtonCorner.CornerRadius = UDim.new(0, 5)
AutoPunchButtonCorner.Parent = AutoPunchButton

-- FOV Slider
local FovLabel = Instance.new("TextLabel")
FovLabel.Size = UDim2.new(0.9, 0, 0, 30)
FovLabel.Position = UDim2.new(0.05, 0, 0, 350)
FovLabel.BackgroundTransparency = 1
FovLabel.Text = "FOV: 30"
FovLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
FovLabel.TextSize = 18
FovLabel.Font = Enum.Font.SourceSans
FovLabel.Parent = MainFrame

local FovSlider = Instance.new("TextButton")
FovSlider.Size = UDim2.new(0.9, 0, 0, 20)
FovSlider.Position = UDim2.new(0.05, 0, 0, 380)
FovSlider.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
FovSlider.Text = ""
FovSlider.Parent = MainFrame
local FovSliderCorner = Instance.new("UICorner")
FovSliderCorner.CornerRadius = UDim.new(0, 5)
FovSliderCorner.Parent = FovSlider

local SliderKnob = Instance.new("Frame")
SliderKnob.Size = UDim2.new(0, 10, 1, 0)
SliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SliderKnob.Parent = FovSlider
local KnobCorner = Instance.new("UICorner")
KnobCorner.CornerRadius = UDim.new(0, 5)
KnobCorner.Parent = SliderKnob

-- FOV Circle
local FovCircle = Instance.new("Frame")
FovCircle.Size = UDim2.new(0, 100, 0, 100)
FovCircle.Position = UDim2.new(0.5, 0, 0.5, 0)
FovCircle.AnchorPoint = Vector2.new(0.5, 0.5)
FovCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
FovCircle.BackgroundTransparency = 0.7
FovCircle.BorderSizePixel = 2
FovCircle.BorderColor3 = Color3.fromRGB(200, 200, 200)
FovCircle.Visible = false
FovCircle.Parent = ScreenGui
local FovCircleCorner = Instance.new("UICorner")
FovCircleCorner.CornerRadius = UDim.new(1, 0)
FovCircleCorner.Parent = FovCircle
local FovCircleStroke = Instance.new("UIStroke")
FovCircleStroke.Color = Color3.fromRGB(255, 255, 255)
FovCircleStroke.Thickness = 2
FovCircleStroke.Transparency = 0.2
FovCircleStroke.Parent = FovCircle

-- Variables
local isRunning = true
local aimbotHeadEnabled = false
local aimbotMediumEnabled = false
local espEnabled = false
local hitboxEnabled = false
local autoPunchEnabled = false
local fov = 30
local punchRange = 5
local hitboxSize = Vector3.new(6, 6, 6)
local hitboxTransparency = 0.9
local aimPartsHead = {"Head", "HeadPart"}
local aimPartsMedium = {"HumanoidRootPart", "UpperTorso", "Torso", "RootPart"}
local espBillboards = {}
local espHighlights = {}
local hitboxParts = {}
local currentTarget = nil
local smoothingFactor = 0.1
local lastDistances = {}
local lastVelocity = {}
local targetSwitchCooldown = 0
local targetSwitchDelay = 0.3

-- FOV Slider Logic
local function updateFovSlider(input)
    local success, result = pcall(function()
        local sliderWidth = FovSlider.AbsoluteSize.X
        local knobPos = math.clamp((input.Position.X - FovSlider.AbsolutePosition.X) / sliderWidth, 0, 1)
        SliderKnob.Position = UDim2.new(knobPos, -5, 0, 0)
        local newFov = 10 + (knobPos * 80)
        TweenService:Create(FovCircle, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {Size = UDim2.new(0, newFov * 12, 0, newFov * 12)}):Play()
        fov = newFov
        FovLabel.Text = "FOV: " .. math.floor(fov)
    end)
    if not success then
        print("FOV slider error: " .. result)
    end
end

FovSlider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        updateFovSlider(input)
    end
end)
FovSlider.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
        updateFovSlider(input)
    end
end)

-- ESP Logic
local function createEsp(player)
    if player ~= LocalPlayer and player.Character then
        local humanoidRootPart = nil
        for _, partName in ipairs(aimPartsMedium) do
            humanoidRootPart = player.Character:FindFirstChild(partName)
            if humanoidRootPart then break end
        end
        if humanoidRootPart and not espBillboards[player] then
            local success, result = pcall(function()
                -- BillboardGui
                local billboard = Instance.new("BillboardGui")
                billboard.Adornee = humanoidRootPart
                billboard.Size = UDim2.new(0, 120, 0, 60)
                billboard.StudsOffset = Vector3.new(0, 3, 0)
                billboard.AlwaysOnTop = true
                billboard.MaxDistance = 0 -- No distance limit
                billboard.Parent = ScreenGui

                local nameLabel = Instance.new("TextLabel")
                nameLabel.Size = UDim2.new(1, 0, 1, 0)
                nameLabel.BackgroundTransparency = 1
                nameLabel.Text = player.Name .. " | Calculating..."
                nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                nameLabel.TextSize = 16
                nameLabel.TextScaled = true
                nameLabel.TextStrokeTransparency = 0.3
                nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                nameLabel.Font = Enum.Font.SourceSansBold
                nameLabel.Parent = billboard

                -- Highlight
                local highlight = Instance.new("Highlight")
                highlight.Adornee = player.Character
                highlight.FillTransparency = 0.3
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.OutlineTransparency = 0
                highlight.FillColor = (player.Team and player.Team == LocalPlayer.Team) and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
                highlight.Parent = player.Character

                espBillboards[player] = {billboard = billboard, nameLabel = nameLabel}
                espHighlights[player] = highlight
                lastDistances[player] = 0
            end)
            if not success then
                print("ESP creation failed for " .. player.Name .. ": " .. result)
            end
        end
    end
end

local function updateEsp()
    if not LocalPlayer.Character then return end
    local localPos = LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart.Position
    if not localPos then return end

    for player, data in pairs(espBillboards) do
        local success, result = pcall(function()
            local humanoidRootPart = nil
            if player.Character then
                for _, partName in ipairs(aimPartsMedium) do
                    humanoidRootPart = player.Character:FindFirstChild(partName)
                    if humanoidRootPart then break end
                end
            end
            if player.Character and humanoidRootPart and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                local distance = (humanoidRootPart.Position - localPos).Magnitude
                if math.abs(distance - lastDistances[player]) > 5 then
                    data.nameLabel.Text = player.Name .. " | " .. math.floor(distance) .. " studs"
                    lastDistances[player] = distance
                end
                data.billboard.Enabled = true
                local scale = math.clamp(200 / (distance + 1), 0.8, 1.5)
                data.billboard.Size = UDim2.new(0, 120 * scale, 0, 60 * scale)
                if espHighlights[player] then
                    espHighlights[player].Enabled = true
                    espHighlights[player].FillColor = (player.Team and player.Team == LocalPlayer.Team) and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
                end
            else
                data.billboard:Destroy()
                if espHighlights[player] then
                    espHighlights[player]:Destroy()
                end
                espBillboards[player] = nil
                espHighlights[player] = nil
                lastDistances[player] = nil
            end
        end)
        if not success then
            print("ESP update failed for " .. player.Name .. ": " .. result)
        end
    end

    -- Ensure ESP for all players
    if espEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and not espBillboards[player] then
                createEsp(player)
            end
        end
    end
end

-- Hitbox Logic
local function expandHitbox(player)
    if player ~= LocalPlayer and player.Character then
        local success, result = pcall(function()
            local character = player.Character
            local humanoidRootPart = nil
            for _, partName in ipairs(aimPartsMedium) do
                humanoidRootPart = character:FindFirstChild(partName)
                if humanoidRootPart then break end
            end
            if humanoidRootPart and not hitboxParts[player] then
                humanoidRootPart.Size = hitboxSize
                humanoidRootPart.Transparency = hitboxTransparency
                humanoidRootPart.CanCollide = false

                local head = character:FindFirstChild("Head") or character:FindFirstChild("HeadPart")
                if head then
                    head.Size = hitboxSize * 0.5
                    head.Transparency = hitboxTransparency
                    head.CanCollide = false
                end

                hitboxParts[player] = {humanoidRootPart = humanoidRootPart, head = head}
            end
        end)
        if not success then
            print("Hitbox expansion failed for " .. player.Name .. ": " .. result)
        end
    end
end

local function resetHitbox(player)
    local success, result = pcall(function()
        if hitboxParts[player] then
            local humanoidRootPart = hitboxParts[player].humanoidRootPart
            local head = hitboxParts[player].head
            if humanoidRootPart then
                humanoidRootPart.Size = Vector3.new(2, 2, 1)
                humanoidRootPart.Transparency = 0
                humanoidRootPart.CanCollide = true
            end
            if head then
                head.Size = Vector3.new(1, 1, 1)
                head.Transparency = 0
                head.CanCollide = true
            end
            hitboxParts[player] = nil
        end
    end)
    if not success then
        print("Hitbox reset failed for " .. player.Name .. ": " .. result)
    end
end

local function updateHitbox()
    for player, _ in pairs(hitboxParts) do
        local success, result = pcall(function()
            if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") or not player.Character:FindFirstChild("Humanoid") or player.Character.Humanoid.Health <= 0 then
                resetHitbox(player)
            end
        end)
        if not success then
            print("Hitbox update failed for " .. player.Name .. ": " .. result)
        end
    end
end

-- Aimbot Logic
local function getClosestPlayer(aimParts)
    local closestPlayer = nil
    local minDistance = math.huge
    local centerScreen = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            if not player.Team or player.Team ~= LocalPlayer.Team then
                local targetPart = nil
                for _, partName in ipairs(aimParts) do
                    targetPart = player.Character:FindFirstChild(partName)
                    if targetPart then break end
                end
                targetPart = targetPart or player.Character:FindFirstChild("HumanoidRootPart")
                if targetPart then
                    local screenPoint, onScreen = Camera:WorldToScreenPoint(targetPart.Position)
                    if onScreen then
                        local distance = (centerScreen - Vector2.new(screenPoint.X, screenPoint.Y)).Magnitude
                        if distance < minDistance and distance < fov * 12 then
                            minDistance = distance
                            closestPlayer = player
                        end
                    end
                end
            end
        end
    end
    return closestPlayer
end

local function lockAimbot(aimParts)
    local success, result = pcall(function()
        -- Update target switch cooldown
        targetSwitchCooldown = math.max(targetSwitchCooldown - RunService.RenderStepped:Wait(), 0)

        -- Check if current target is still valid
        if currentTarget and currentTarget.Character and currentTarget.Character:FindFirstChild("Humanoid") and currentTarget.Character.Humanoid.Health > 0 then
            local targetPart = nil
            for _, partName in ipairs(aimParts) do
                targetPart = currentTarget.Character:FindFirstChild(partName)
                if targetPart then break end
            end
            targetPart = targetPart or currentTarget.Character:FindFirstChild("HumanoidRootPart")
            if targetPart then
                local screenPoint, onScreen = Camera:WorldToScreenPoint(targetPart.Position)
                local centerScreen = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                local distance = (centerScreen - Vector2.new(screenPoint.X, screenPoint.Y)).Magnitude
                if not onScreen or distance > fov * 12 or (not aimbotHeadEnabled and not aimbotMediumEnabled) then
                    currentTarget = nil
                    lastVelocity[currentTarget] = nil
                end
            else
                currentTarget = nil
                lastVelocity[currentTarget] = nil
            end
        else
            currentTarget = nil
            lastVelocity[currentTarget] = nil
        end

        -- Find new target if none and cooldown is over
        if not currentTarget and targetSwitchCooldown <= 0 then
            currentTarget = getClosestPlayer(aimParts)
            if currentTarget then
                targetSwitchCooldown = targetSwitchDelay
            end
        end

        -- Lock onto target
        if currentTarget and currentTarget.Character then
            local targetPart = nil
            for _, partName in ipairs(aimParts) do
                targetPart = currentTarget.Character:FindFirstChild(partName)
                if targetPart then break end
            end
            targetPart = targetPart or currentTarget.Character:FindFirstChild("HumanoidRootPart")
            if targetPart then
                -- Smooth velocity
                local velocity = targetPart.Velocity
                lastVelocity[currentTarget] = lastVelocity[currentTarget] or velocity
                lastVelocity[currentTarget] = lastVelocity[currentTarget]:Lerp(velocity, 0.5)
                local predictedPos = targetPart.Position + lastVelocity[currentTarget] * 0.05

                -- Smoothly interpolate
                local currentCFrame = Camera.CFrame
                local targetCFrame = CFrame.new(currentCFrame.Position, predictedPos)
                local smoothedCFrame = currentCFrame:Lerp(targetCFrame, smoothingFactor)
                TweenService:Create(Camera, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {CFrame = smoothedCFrame}):Play()
            end
        end
    end)
    if not success then
        print("Aimbot error: " .. result)
        currentTarget = nil
        lastVelocity[currentTarget] = nil
    end
end

local function lockAimbotHead()
    if not aimbotHeadEnabled then return end
    lockAimbot(aimPartsHead)
end

local function lockAimbotMedium()
    if not aimbotMediumEnabled then return end
    lockAimbot(aimPartsMedium)
end

-- Auto-Punch Logic
local function simulatePunch(target)
    if not target or not target.Character then return end
    local success, result = pcall(function()
        local head = target.Character:FindFirstChild("Head") or target.Character:FindFirstChild("HeadPart")
        if head then
            local effect = Instance.new("Part")
            effect.Size = Vector3.new(0.5, 0.5, 0.5)
            effect.Position = head.Position + Vector3.new(0, 0.5, 0)
            effect.BrickColor = BrickColor.new("Really yellow")
            effect.Anchored = true
            effect.CanCollide = false
            effect.Parent = workspace
            Debris:AddItem(effect, 0.3)

            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://9119726640"
            sound.Volume = 0.5
            sound.Parent = effect
            sound:Play()
            Debris:AddItem(sound, 1)
        end
    end)
    if not success then
        print("Punch simulation failed: " .. result)
    end
end

local function autoPunch()
    if not autoPunchEnabled then return end
    local success, result = pcall(function()
        local localPos = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart.Position
        if not localPos then return end

        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                local distance = (player.Character.HumanoidRootPart.Position - localPos).Magnitude
                if distance <= punchRange then
                    simulatePunch(player)
                end
            end
        end
    end)
    if not success then
        print("Auto-Punch error: " .. result)
    end
end

local function guaranteedPunch()
    local success, result = pcall(function()
        local localPos = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart.Position
        if not localPos then return end

        local closestPlayer = nil
        local minDistance = punchRange

        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                local distance = (player.Character.HumanoidRootPart.Position - localPos).Magnitude
                if distance <= minDistance then
                    minDistance = distance
                    closestPlayer = player
                end
            end
        end

        if closestPlayer then
            simulatePunch(closestPlayer)
        end
    end)
    if not success then
        print("Guaranteed Punch error: " .. result)
    end
end

-- Toggle Aimbot (Head)
AimbotHeadButton.MouseButton1Click:Connect(function()
    aimbotHeadEnabled = not aimbotHeadEnabled
    if aimbotHeadEnabled then aimbotMediumEnabled = false end
    AimbotHeadButton.Text = "Aimbot (Head): " .. (aimbotHeadEnabled and "ON" or "OFF")
    AimbotMediumButton.Text = "Aimbot (Medium): " .. (aimbotMediumEnabled and "ON" or "OFF")
    FovCircle.Visible = aimbotHeadEnabled or aimbotMediumEnabled
    if not aimbotHeadEnabled and not aimbotMediumEnabled then
        currentTarget = nil
        lastVelocity = {}
    end
end)

-- Toggle Aimbot (Medium)
AimbotMediumButton.MouseButton1Click:Connect(function()
    aimbotMediumEnabled = not aimbotMediumEnabled
    if aimbotMediumEnabled then aimbotHeadEnabled = false end
    AimbotMediumButton.Text = "Aimbot (Medium): " .. (aimbotMediumEnabled and "ON" or "OFF")
    AimbotHeadButton.Text = "Aimbot (Head): " .. (aimbotHeadEnabled and "ON" or "OFF")
    FovCircle.Visible = aimbotHeadEnabled or aimbotMediumEnabled
    if not aimbotHeadEnabled and not aimbotMediumEnabled then
        currentTarget = nil
        lastVelocity = {}
    end
end)

-- Toggle ESP
EspButton.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    EspButton.Text = "ESP: " .. (espEnabled and "ON" or "OFF")
    if espEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            createEsp(player)
        end
    else
        for _, data in pairs(espBillboards) do
            data.billboard:Destroy()
        end
        for _, highlight in pairs(espHighlights) do
            highlight:Destroy()
        end
        espBillboards = {}
        espHighlights = {}
        lastDistances = {}
    end
end)

-- Toggle Hitbox
HitboxButton.MouseButton1Click:Connect(function()
    hitboxEnabled = not hitboxEnabled
    HitboxButton.Text = "Hitbox: " .. (hitboxEnabled and "ON" or "OFF")
    if hitboxEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            expandHitbox(player)
        end
    else
        for player, _ in pairs(hitboxParts) do
            resetHitbox(player)
        end
        hitboxParts = {}
    end
end)

-- Toggle Auto-Punch
AutoPunchButton.MouseButton1Click:Connect(function()
    autoPunchEnabled = not autoPunchEnabled
    AutoPunchButton.Text = "Auto-Punch: " .. (autoPunchEnabled and "ON" or "OFF")
end)

-- Player Added
Players.PlayerAdded:Connect(function(player)
    if espEnabled then
        createEsp(player)
    end
    if hitboxEnabled then
        expandHitbox(player)
    end
end)

-- Player Removing
Players.PlayerRemoving:Connect(function(player)
    if espBillboards[player] then
        espBillboards[player].billboard:Destroy()
        espBillboards[player] = nil
    end
    if espHighlights[player] then
        espHighlights[player]:Destroy()
        espHighlights[player] = nil
    end
    if hitboxParts[player] then
        resetHitbox(player)
    end
    if player == currentTarget then
        currentTarget = nil
        lastVelocity[player] = nil
    end
    lastDistances[player] = nil
end)

-- Guaranteed Punch on Click
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.UserInputType == Enum.UserInputType.MouseButton1 and autoPunchEnabled then
        guaranteedPunch()
    end
end)

-- Main Loops
RunService.RenderStepped:Connect(function()
    if not isRunning then return end
    local success, result = pcall(function()
        if aimbotHeadEnabled then
            lockAimbotHead()
        elseif aimbotMediumEnabled then
            lockAimbotMedium()
        end
    end)
    if not success then
        print("Aimbot loop error: " .. result)
        isRunning = false
    end
end)

RunService.Heartbeat:Connect(function()
    if not isRunning then return end
    local success, result = pcall(function()
        if espEnabled then
            updateEsp()
        end
        if hitboxEnabled then
            updateHitbox()
        end
        if autoPunchEnabled then
            autoPunch()
        end
        if aimbotHeadEnabled or aimbotMediumEnabled then
            FovCircle.Position = UDim2.new(0.5, 0, 0.5, 0)
        end
    end)
    if not success then
        print("ESP/Hitbox/Auto-Punch loop error: " .. result)
        isRunning = false
    end
end)

-- Initial Setup
print("sr")



local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local mouse = player:GetMouse()
local camera = workspace.CurrentCamera
local gui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local titleBar = Instance.new("TextLabel")
local toggleButton = Instance.new("TextButton")
local aimbotEnabled = false
local espEnabled = false
local fovRadius = 200 -- ระยะ FOV (หน่วย Roblox studs)
local hitboxSize = Vector3.new(10, 10, 10) -- ขนาด Hitbox

-- ตั้งค่า GUI
gui.Name = "AimbotESPControl"
gui.Parent = player:WaitForChild("PlayerGui")

frame.Size = UDim2.new(0, 250, 0, 200)
frame.Position = UDim2.new(0.5, -125, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.Parent = gui

titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
titleBar.Text = "Aimbot & ESP Control"
titleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
titleBar.Font = Enum.Font.SourceSansBold
titleBar.TextSize = 18
titleBar.Parent = frame

toggleButton.Size = UDim2.new(0.8, 0, 0, 40)
toggleButton.Position = UDim2.new(0.1, 0, 0.3, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
toggleButton.Text = "Enable Aimbot"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.SourceSans
toggleButton.TextSize = 16
toggleButton.Parent = frame

local espToggleButton = Instance.new("TextButton")
espToggleButton.Size = UDim2.new(0.8, 0, 0, 40)
espToggleButton.Position = UDim2.new(0.1, 0, 0.5, 10)
espToggleButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
espToggleButton.Text = "Enable ESP"
espToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
espToggleButton.Font = Enum.Font.SourceSans
espToggleButton.TextSize = 16
espToggleButton.Parent = frame

-- ทำให้ GUI ขยับได้
local dragging = false
local dragStart = nil
local startPos = nil

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)

titleBar.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

titleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- ฟังก์ชัน ESP
local espCache = {} -- เก็บ Highlight และ BillboardGui สำหรับแต่ละผู้เล่น

local function createESP(character)
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    local rootPart = character.HumanoidRootPart
    
    -- เพิ่ม Highlight (เรืองแสง)
    local highlight = Instance.new("Highlight")
    highlight.FillColor = Color3.fromRGB(255, 0, 0) -- สีแดง
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255) -- ขอบขาว
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Adornee = character
    highlight.Parent = character
    
    -- เพิ่ม BillboardGui แสดงระยะ
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESPBillboard"
    billboard.Size = UDim2.new(0, 100, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = rootPart
    
    local distanceLabel = Instance.new("TextLabel")
    distanceLabel.Size = UDim2.new(1, 0, 1, 0)
    distanceLabel.BackgroundTransparency = 1
    distanceLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    distanceLabel.Font = Enum.Font.SourceSansBold
    distanceLabel.TextSize = 14
    distanceLabel.TextStrokeTransparency = 0
    distanceLabel.Parent = billboard
    
    -- เพิ่ม Hitbox
    local hitbox = Instance.new("Part")
    hitbox.Name = "Hitbox"
    hitbox.Size = hitboxSize
    hitbox.Transparency = 1
    hitbox.CanCollide = false
    hitbox.Anchored = true
    hitbox.Parent = character
    
    espCache[character] = {highlight = highlight, billboard = billboard, hitbox = hitbox}
end

local function updateESP()
    for character, esp in pairs(espCache) do
        if character.Parent and character:FindFirstChild("HumanoidRootPart") and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude
            if distance <= fovRadius then
                esp.billboard.Enabled = true
                esp.highlight.Enabled = true
                esp.billboard.DistanceLabel.Text = string.format("%.1f meters", distance / 3) -- 1 stud ≈ 0.333 เมตร
                esp.hitbox.Position = character.HumanoidRootPart.Position
            else
                esp.billboard.Enabled = false
                esp.highlight.Enabled = false
            end
        else
            esp.highlight:Destroy()
            esp.billboard:Destroy()
            esp.hitbox:Destroy()
            espCache[character] = nil
        end
    end
end

local function setupESP()
    for _, target in pairs(Players:GetPlayers()) do
        if target ~= player and target.Character then
            createESP(target.Character)
        end
        target.CharacterAdded:Connect(function(character)
            wait(0.1) -- รอให้ Character โหลด
            createESP(character)
        end)
    end
    Players.PlayerAdded:Connect(function(newPlayer)
        newPlayer.CharacterAdded:Connect(function(character)
            wait(0.1)
            createESP(character)
        end)
    end)
end

-- ฟังก์ชัน Aimbot
local function getNearestEnemy()
    local nearestEnemy = nil
    local shortestDistance = math.huge
    
    for _, target in pairs(Players:GetPlayers()) do
        if target ~= player and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - target.Character.HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance and distance <= fovRadius then
                local screenPoint, onScreen = camera:WorldToScreenPoint(target.Character.HumanoidRootPart.Position)
                if onScreen then
                    shortestDistance = distance
                    nearestEnemy = target.Character:FindFirstChild("Hitbox") or target.Character.HumanoidRootPart
                end
            end
        end
    end
    
    return nearestEnemy
end

-- การควบคุม GUI
toggleButton.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    toggleButton.Text = aimbotEnabled and "Disable Aimbot" or "Enable Aimbot"
    toggleButton.BackgroundColor3 = aimbotEnabled and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(80, 80, 80)
end)

espToggleButton.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    espToggleButton.Text = espEnabled and "Disable ESP" or "Enable ESP"
    espToggleButton.BackgroundColor3 = espEnabled and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(80, 80, 80)
    if espEnabled then
        setupESP()
    else
        for _, esp in pairs(espCache) do
            esp.highlight:Destroy()
            esp.billboard:Destroy()
            esp.hitbox:Destroy()
        end
        espCache = {}
    end
end)

-- ลูปหลัก
RunService.RenderStepped:Connect(function()
    if aimbotEnabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local target = getNearestEnemy()
        if target then
            local targetPos = target.Position
            local cameraPos = camera.CFrame.Position
            local newCFrame = CFrame.new(cameraPos, targetPos)
            camera.CFrame = camera.CFrame:Lerp(newCFrame, 0.2) -- การเล็งที่นุ่มนวล
        end
    end
    if espEnabled then
        updateESP()
    end
end)