-- OVERLORD UTILITY ENGINE v7.0: ULTRA-COMPACT FIXED (Updated: numeric inputs)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "OverlordEngineUI_Native"

local CoreGui = game:GetService("CoreGui")
-- Attempt to parent to CoreGui; if that fails (due to permission) parent to PlayerGui
if CoreGui then
    local ok = pcall(function() ScreenGui.Parent = CoreGui end)
    if not ok then
        ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end
else
    ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
end

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 320, 0, 600)
MainFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TopBar.BorderSizePixel = 0
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 8)

local TitleLabel = Instance.new("TextLabel", TopBar)
TitleLabel.Size = UDim2.new(1, -40, 1, 0)
TitleLabel.Position = UDim2.new(0, 12, 0, 0)
TitleLabel.Text = "⚡ OVERLORD ENGINE v7.0"
TitleLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 16
TitleLabel.BackgroundTransparency = 1

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -35, 0, 0)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.BackgroundTransparency = 1
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local Container = Instance.new("ScrollingFrame", MainFrame)
Container.Size = UDim2.new(1, -16, 1, -45)
Container.Position = UDim2.new(0, 8, 0, 40)
Container.BackgroundTransparency = 1
Container.CanvasSize = UDim2.new(0, 0, 0, 1200)
Container.ScrollBarThickness = 4
Container.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 150)

local UIListLayout = Instance.new("UIListLayout", Container)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 6)

local function CreateMenuButton(text, callback)
    local Btn = Instance.new("TextButton", Container)
    Btn.Size = UDim2.new(1, 0, 0, 32)
    Btn.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(240, 240, 240)
    Btn.Font = Enum.Font.SourceSansSemibold
    Btn.TextSize = 14
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4)
    if callback then
        Btn.MouseButton1Click:Connect(callback)
    end
    return Btn
end

local function CreateMenuToggle(text, default, callback)
    local state = default
    local Tgl = Instance.new("TextButton", Container)
    Tgl.Size = UDim2.new(1, 0, 0, 32)
    Tgl.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    Tgl.Text = text .. " : " .. (state and "ON" or "OFF")
    Tgl.TextColor3 = state and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(200, 200, 200)
    Tgl.Font = Enum.Font.SourceSansSemibold
    Tgl.TextSize = 14
    Instance.new("UICorner", Tgl).CornerRadius = UDim.new(0, 4)
    
    Tgl.MouseButton1Click:Connect(function()
        state = not state
        Tgl.Text = text .. " : " .. (state and "ON" or "OFF")
        Tgl.TextColor3 = state and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(200, 200, 200)
        if callback then callback(state) end
    end)
    return Tgl
end

-- Create a numeric input row: label, textbox, set button
local function CreateMenuNumberInput(text, default, callback)
    local frame = Instance.new("Frame", Container)
    frame.Size = UDim2.new(1, 0, 0, 36)
    frame.BackgroundTransparency = 1

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0.55, 0, 1, 0)
    label.Position = UDim2.new(0, 6, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.SourceSansSemibold
    label.TextSize = 14
    label.TextColor3 = Color3.fromRGB(240,240,240)

    local box = Instance.new("TextBox", frame)
    box.Size = UDim2.new(0.25, 0, 0.72, 0)
    box.Position = UDim2.new(0.6, 0, 0.14, 0)
    box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    box.TextColor3 = Color3.fromRGB(240,240,240)
    box.Text = tostring(default)
    box.ClearTextOnFocus = false
    box.Font = Enum.Font.SourceSans
    box.TextSize = 14
    local corner = Instance.new("UICorner", box)
    corner.CornerRadius = UDim.new(0, 4)

    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0.12, 0, 0.72, 0)
    btn.Position = UDim2.new(0.86, 0, 0.14, 0)
    btn.Text = "Set"
    btn.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    btn.TextColor3 = Color3.fromRGB(240,240,240)
    btn.Font = Enum.Font.SourceSansSemibold
    btn.TextSize = 14
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)

    btn.MouseButton1Click:Connect(function()
        local val = tonumber(box.Text)
        if val then
            pcall(function() callback(val) end)
            box.Text = tostring(val)
        else
            -- invalid input: flash
            local old = box.Text
            box.Text = "NaN"
            task.wait(0.6)
            box.Text = old
        end
    end)

    return frame, box, btn
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer and LocalPlayer:GetMouse()

local Settings = {
    WalkSpeed = 16,
    JumpPower = 50,
    InfJump = false,
    Noclip = false,
    HitboxExt = false,
    HitboxSize = 25,
    Aimbot = false,
    AimFOV = 150,
    Fly = false,
    FlySpeed = 50,
    LagSwitch = false,
    ChatSpam = false,
    GodMode = false,
    SpeedHack = false,
    SpeedMult = 2,
    InvisMode = false,
    AutoFarm = false,
    ESPEnabled = false,
    WallHack = false,
    InstantToolGrab = false,
    VehicleSpeed = 100,
    InfiniteStamina = false,
    AutoDodge = false
}

local function getChar() return (LocalPlayer and (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait())) end
local function getHum()
    local char = getChar()
    if char then return char:FindFirstChildOfClass("Humanoid") end
    return nil
end
local function getRoot()
    local char = getChar()
    if char then return char:FindFirstChild("HumanoidRootPart") end
    return nil
end

-- Keep WalkSpeed and JumpPower applied when character spawns
if LocalPlayer then
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(0.5)
        local hum = getHum()
        if hum then
            pcall(function()
                hum.WalkSpeed = Settings.WalkSpeed
                if hum.UseJumpPower ~= nil then hum.UseJumpPower = true end
                hum.JumpPower = Settings.JumpPower
            end)
        end
    end)
end

RunService.Stepped:Connect(function()
    if Settings.Noclip and getChar() then
        for _, part in pairs(getChar():GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

UserInputService.JumpRequest:Connect(function()
    if Settings.InfJump and getHum() then 
        getHum():ChangeState(Enum.HumanoidStateType.Jumping) 
    end
end)

-- Flight implementation
task.spawn(function()
    while task.wait(0.1) do
        if Settings.Fly and getRoot() then
            local root = getRoot()
            if root and not root:FindFirstChild("EngineFlyVel") then
                local bv = Instance.new("BodyVelocity")
                bv.Name = "EngineFlyVel"
                bv.MaxForce = Vector3.new(1,1,1) * 9e9
                bv.Velocity = Vector3.new(0,0,0)
                bv.Parent = root

                local bg = Instance.new("BodyGyro")
                bg.Name = "EngineFlyGyro"
                bg.MaxTorque = Vector3.new(1,1,1) * 9e9
                bg.CFrame = root.CFrame
                bg.Parent = root

                task.spawn(function()
                    while root and root:FindFirstChild("EngineFlyVel") and Settings.Fly do
                        RunService.RenderStepped:Wait()
                        local moveVector = Vector3.new(0,0,0)
                        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveVector = moveVector + Camera.CFrame.LookVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveVector = moveVector - Camera.CFrame.LookVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveVector = moveVector - Camera.CFrame.RightVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveVector = moveVector + Camera.CFrame.RightVector end
                        if bv then bv.Velocity = moveVector * Settings.FlySpeed end
                        if bg then bg.CFrame = Camera.CFrame end
                    end
                    if root then
                        if root:FindFirstChild("EngineFlyVel") then root.EngineFlyVel:Destroy() end
                        if root:FindFirstChild("EngineFlyGyro") then root.EngineFlyGyro:Destroy() end
                    end
                end)
            end
        end
    end
end)

-- Hitbox expansion
task.spawn(function()
    while task.wait(1) do
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                if hrp and hum then
                    if Settings.HitboxExt then
                        hrp.Size = Vector3.new(Settings.HitboxSize, Settings.HitboxSize, Settings.HitboxSize)
                        hrp.Transparency = 0.6
                        hrp.Color = Color3.fromRGB(255, 0, 0)
                        hrp.CanCollide = false
                    else
                        -- default/preset size and invisibility
                        hrp.Size = Vector3.new(2, 2, 1)
                        hrp.Transparency = 1
                    end
                end
            end
        end
    end
end)

-- Aimbot
RunService.RenderStepped:Connect(function()
    if Settings.Aimbot then
        local target = nil
        local shortestDist = Settings.AimFOV
        local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 then
                    local pos, onScreen = Camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
                    if onScreen then
                        local dist = (Vector2.new(pos.X, pos.Y) - screenCenter).Magnitude
                        if dist < shortestDist then
                            shortestDist = dist
                            target = p.Character.HumanoidRootPart
                        end
                    end
                end
            end
        end
        if target then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position)
        end
    end
end)

-- God Mode: prevent damage
task.spawn(function()
    while task.wait(0.1) do
        if Settings.GodMode then
            local hum = getHum()
            if hum then
                hum.Health = hum.MaxHealth
            end
        end
    end
end)

-- Speed Hack: multiply movement
task.spawn(function()
    while task.wait(0.05) do
        if Settings.SpeedHack and getRoot() then
            local root = getRoot()
            if root then
                root.Velocity = root.Velocity * Vector3.new(Settings.SpeedMult, 1, Settings.SpeedMult)
            end
        end
    end
end)

-- Invisibility Mode
task.spawn(function()
    while task.wait(0.5) do
        if Settings.InvisMode and getChar() then
            for _, part in pairs(getChar():GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 1
                end
            end
        end
    end
end)

-- Auto Dodge - jump away from nearby enemies
task.spawn(function()
    while task.wait(0.2) do
        if Settings.AutoDodge and getRoot() then
            local root = getRoot()
            local hum = getHum()
            if root and hum then
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        local enemyRoot = p.Character.HumanoidRootPart
                        if (enemyRoot.Position - root.Position).Magnitude < 20 then
                            hum:ChangeState(Enum.HumanoidStateType.Jumping)
                            root.Velocity = root.Velocity + (root.Position - enemyRoot.Position).Unit * 50
                        end
                    end
                end
            end
        end
    end
end)

-- ESP: Draw lines to enemies
local espAdornments = {}
task.spawn(function()
    while task.wait(0.5) do
        -- Clear old ESP
        for _, adorn in pairs(espAdornments) do
            pcall(function() adorn:Destroy() end)
        end
        espAdornments = {}
        
        if Settings.ESPEnabled and getRoot() then
            local root = getRoot()
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local enemyRoot = p.Character.HumanoidRootPart
                    local line = Instance.new("Part")
                    line.Name = "ESPLine"
                    line.Shape = Enum.PartType.Cylinder
                    line.CanCollide = false
                    line.CFrame = CFrame.new((root.Position + enemyRoot.Position) / 2, root.Position)
                    line.Size = Vector3.new(0.2, (root.Position - enemyRoot.Position).Magnitude, 0.2)
                    line.Color = Color3.fromRGB(0, 255, 0)
                    line.Transparency = 0.5
                    line.Parent = workspace
                    table.insert(espAdornments, line)
                end
            end
        end
    end
end)

-- UI Controls: inputs for numeric customization
local speedFrame = CreateMenuNumberInput("Walk Speed", Settings.WalkSpeed, function(v)
    Settings.WalkSpeed = v
    local hum = getHum()
    if hum then
        pcall(function() hum.WalkSpeed = Settings.WalkSpeed end)
    end
end)

local jumpFrame = CreateMenuNumberInput("Jump Power", Settings.JumpPower, function(v)
    Settings.JumpPower = v
    local hum = getHum()
    if hum then
        pcall(function() if hum.UseJumpPower ~= nil then hum.UseJumpPower = true end hum.JumpPower = Settings.JumpPower end)
    end
end)

local flyFrame = CreateMenuNumberInput("Fly Speed", Settings.FlySpeed, function(v)
    Settings.FlySpeed = v
end)

local hitboxFrame = CreateMenuNumberInput("Hitbox Size", Settings.HitboxSize, function(v)
    Settings.HitboxSize = v
end)

local aimFrame = CreateMenuNumberInput("Aim FOV (px)", Settings.AimFOV, function(v)
    Settings.AimFOV = v
end)

local speedMultFrame = CreateMenuNumberInput("Speed Multiplier", Settings.SpeedMult, function(v)
    Settings.SpeedMult = v
end)

local vehicleSpeedFrame = CreateMenuNumberInput("Vehicle Speed", Settings.VehicleSpeed, function(v)
    Settings.VehicleSpeed = v
end)

-- Convenience buttons to apply current settings immediately
CreateMenuButton("Apply WalkSpeed/Jumppower to Character", function()
    local hum = getHum()
    if hum then
        pcall(function()
            hum.WalkSpeed = Settings.WalkSpeed
            if hum.UseJumpPower ~= nil then hum.UseJumpPower = true end
            hum.JumpPower = Settings.JumpPower
        end)
    end
end)

CreateMenuToggle("Infinite Jump Engine", Settings.InfJump, function(v)
    Settings.InfJump = v
end)

CreateMenuToggle("Phase Mode (Noclip)", Settings.Noclip, function(v)
    Settings.Noclip = v
end)

CreateMenuToggle("Flight Mechanics (W,A,S,D)", Settings.Fly, function(v)
    Settings.Fly = v
    if not v and getRoot() then
        local root = getRoot()
        if root:FindFirstChild("EngineFlyVel") then root.EngineFlyVel:Destroy() end
        if root:FindFirstChild("EngineFlyGyro") then root.EngineFlyGyro:Destroy() end
    end
end)

CreateMenuToggle("Expand Enemy Hitboxes", Settings.HitboxExt, function(v)
    Settings.HitboxExt = v
end)

CreateMenuToggle("Aim Lock Tracking Assist", Settings.Aimbot, function(v)
    Settings.Aimbot = v
end)

CreateMenuToggle("God Mode (Invincible)", Settings.GodMode, function(v)
    Settings.GodMode = v
end)

CreateMenuToggle("Speed Hack (Movement Boost)", Settings.SpeedHack, function(v)
    Settings.SpeedHack = v
end)

CreateMenuToggle("Invisibility Mode", Settings.InvisMode, function(v)
    Settings.InvisMode = v
    if not v and getChar() then
        for _, part in pairs(getChar():GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 0
            end
        end
    end
end)

CreateMenuToggle("Auto Dodge (Combat)", Settings.AutoDodge, function(v)
    Settings.AutoDodge = v
end)

CreateMenuToggle("ESP (Enemy Tracking)", Settings.ESPEnabled, function(v)
    Settings.ESPEnabled = v
end)

CreateMenuButton("Teleport: CTRL + Left Click (toggle listener)", function()
    if not Mouse then return end
    -- toggle listener: if active, disconnect; if not, connect
    if _G.OverlordTeleportConnection and type(_G.OverlordTeleportConnection.Disconnect) == "function" then
        _G.OverlordTeleportConnection:Disconnect()
        _G.OverlordTeleportConnection = nil
        -- feedback: change title of last created button? We'll just return
        return
    end
    _G.OverlordTeleportConnection = Mouse.Button1Down:Connect(function()
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) and Mouse.Target then
            local root = getRoot()
            if root and Mouse.Hit then
                root.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 3, 0))
            end
        end
    end)
end)

CreateMenuToggle("Network Lag Switch", Settings.LagSwitch, function(v)
    Settings.LagSwitch = v
end)

task.spawn(function()
    while task.wait(0.1) do
        local success, err = pcall(function()
            if Settings.LagSwitch then
                settings().Network.IncomingReplicationLag = 9999
            else
                settings().Network.IncomingReplicationLag = 0
            end
        end)
        if not success then
            -- ignore errors (settings may be unavailable)
        end
    end
end)

-- VISUAL AND AUTOMATION ENGINE MODULE

-- Optimize Client Frames (FPS Boost)
CreateMenuButton("Optimize Client Frames (FPS Boost)", function()
    for _, desc in pairs(workspace:GetDescendants()) do
        if desc:IsA("Texture") or desc:IsA("Decal") then 
            pcall(function() desc:Destroy() end)
        end
    end
end)

-- Remove All Obstacles
CreateMenuButton("Remove All Obstacles", function()
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "Baseplate" and not part:IsDescendantOf(LocalPlayer.Character or Instance.new("Model")) then
            pcall(function() part:Destroy() end)
        end
    end
end)

-- Simulate Fake Error 277 Kick
CreateMenuButton("Simulate Fake Error 277 Kick", function()
    pcall(function()
        game:GetService("GuiService"):SetErrorMessage("An unexpected error occurred and you have been disconnected. (Error Code: 277)")
    end)
end)

-- Teleport All Players to Me
CreateMenuButton("Teleport All Players to Me", function()
    local root = getRoot()
    if root then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                p.Character.HumanoidRootPart.CFrame = root.CFrame + Vector3.new(math.random(-10, 10), 0, math.random(-10, 10))
            end
        end
    end
end)

-- Freeze All Players
CreateMenuButton("Freeze All Players", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            p.Character.HumanoidRootPart.Anchored = true
        end
    end
end)

-- Unfreeze All Players
CreateMenuButton("Unfreeze All Players", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            p.Character.HumanoidRootPart.Anchored = false
        end
    end
end)

-- Kill All Players
CreateMenuButton("Kill All Players", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.Health = 0
            end
        end
    end
end)

-- Massive Jump Power
CreateMenuButton("Massive Jump (9999)", function()
    local hum = getHum()
    if hum then
        pcall(function()
            if hum.UseJumpPower ~= nil then hum.UseJumpPower = true end
            hum.JumpPower = 9999
        end)
    end
end)

-- Super Speed Walk
CreateMenuButton("Super Speed Walk (300)", function()
    local hum = getHum()
    if hum then
        pcall(function() hum.WalkSpeed = 300 end)
    end
end)

-- Permanent Anti-AFK Routine
do
    local VirtualUser = game:GetService("VirtualUser")
    if LocalPlayer then
        LocalPlayer.Idled:Connect(function()
            pcall(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new(0, 0))
            end)
        end)
    end
end
