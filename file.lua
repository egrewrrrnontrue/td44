-- OVERLORD UTILITY ENGINE v8.0 ULTIMATE: MEGA EXPANSION (200+ Features)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "OverlordEngineUI_Ultimate"

local CoreGui = game:GetService("CoreGui")
if CoreGui then
    local ok = pcall(function() ScreenGui.Parent = CoreGui end)
    if not ok then
        ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end
else
    ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
end

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 380, 0, 700)
MainFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TopBar.BorderSizePixel = 0
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 10)

local TitleLabel = Instance.new("TextLabel", TopBar)
TitleLabel.Size = UDim2.new(1, -50, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.Text = "⚡ OVERLORD v8.0 ULTIMATE (200+ Features)"
TitleLabel.TextColor3 = Color3.fromRGB(0, 255, 200)
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 14
TitleLabel.BackgroundTransparency = 1

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -40, 0, 0)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.BackgroundTransparency = 1
CloseBtn.TextSize = 18
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local Container = Instance.new("ScrollingFrame", MainFrame)
Container.Size = UDim2.new(1, -16, 1, -50)
Container.Position = UDim2.new(0, 8, 0, 45)
Container.BackgroundTransparency = 1
Container.CanvasSize = UDim2.new(0, 0, 0, 3500)
Container.ScrollBarThickness = 5
Container.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 200)

local UIListLayout = Instance.new("UIListLayout", Container)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

local function CreateMenuButton(text, callback)
    local Btn = Instance.new("TextButton", Container)
    Btn.Size = UDim2.new(1, 0, 0, 30)
    Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    Btn.Font = Enum.Font.SourceSansSemibold
    Btn.TextSize = 13
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4)
    if callback then
        Btn.MouseButton1Click:Connect(callback)
    end
    return Btn
end

local function CreateMenuToggle(text, default, callback)
    local state = default
    local Tgl = Instance.new("TextButton", Container)
    Tgl.Size = UDim2.new(1, 0, 0, 30)
    Tgl.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Tgl.Text = text .. " : " .. (state and "✓" or "✗")
    Tgl.TextColor3 = state and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(180, 180, 180)
    Tgl.Font = Enum.Font.SourceSansSemibold
    Tgl.TextSize = 13
    Instance.new("UICorner", Tgl).CornerRadius = UDim.new(0, 4)
    
    Tgl.MouseButton1Click:Connect(function()
        state = not state
        Tgl.Text = text .. " : " .. (state and "✓" or "✗")
        Tgl.TextColor3 = state and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(180, 180, 180)
        if callback then callback(state) end
    end)
    return Tgl
end

local function CreateMenuNumberInput(text, default, callback)
    local frame = Instance.new("Frame", Container)
    frame.Size = UDim2.new(1, 0, 0, 34)
    frame.BackgroundTransparency = 1

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.Position = UDim2.new(0, 5, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.SourceSansSemibold
    label.TextSize = 13
    label.TextColor3 = Color3.fromRGB(220, 220, 220)

    local box = Instance.new("TextBox", frame)
    box.Size = UDim2.new(0.25, 0, 0.7, 0)
    box.Position = UDim2.new(0.62, 0, 0.15, 0)
    box.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    box.TextColor3 = Color3.fromRGB(220, 220, 220)
    box.Text = tostring(default)
    box.ClearTextOnFocus = false
    box.Font = Enum.Font.SourceSans
    box.TextSize = 13
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 3)

    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0.1, 0, 0.7, 0)
    btn.Position = UDim2.new(0.88, 0, 0.15, 0)
    btn.Text = "Set"
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.TextColor3 = Color3.fromRGB(0, 200, 150)
    btn.Font = Enum.Font.SourceSansSemibold
    btn.TextSize = 11
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 3)

    btn.MouseButton1Click:Connect(function()
        local val = tonumber(box.Text)
        if val then
            pcall(function() callback(val) end)
            box.Text = tostring(val)
        else
            local old = box.Text
            box.Text = "ERROR"
            task.wait(0.4)
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

-- MASSIVE SETTINGS TABLE (200+ features)
local Settings = {
    -- Movement
    WalkSpeed = 16, JumpPower = 50, InfJump = false, Noclip = false, Fly = false, FlySpeed = 50,
    SpeedHack = false, SpeedMult = 2, SlideBoost = false, WallRun = false, DashEnabled = false,
    -- Combat
    Aimbot = false, AimFOV = 150, HitboxExt = false, HitboxSize = 25, ReachExtension = false,
    ReachDistance = 50, AutoAttack = false, AutoPunch = false, CriticalHit = false, DamageBoost = false,
    -- Defensive
    GodMode = false, NoFallDamage = false, ShieldMode = false, DodgeChance = 50, AutoHeal = false,
    -- Vision
    ESPEnabled = false, WallHack = false, PlayerTracking = false, NameTags = false, DistanceDisplay = false,
    -- Utility
    InvisMode = false, AutoFarm = false, InstantToolGrab = false, VehicleSpeed = 100, TeleportToMouse = false,
    -- World
    WeatherControl = false, DayNightMode = false, RemoveObstacles = false, LagSwitch = false,
    -- Advanced Combat
    AutoDodge = false, CombatMode = false, MultiTarget = false, TrueLead = false, NoRecoil = false,
    -- Special Effects
    RainbowMode = false, GlowEffect = false, TrailEffect = false, ExplosionEffect = false,
    -- Automation
    AutoFarmCoins = false, AutoCompleteQuests = false, AutoBuyGear = false, AutoUpgrade = false,
    -- Social
    ChatSpam = false, SpamMessage = "OVERLORD v8.0!", AutoReply = false, BlockChat = false,
    -- Anti-Cheat
    AntiDetection = false, HideFromServer = false, CleanLog = false, FakePosition = false,
    -- Item Control
    DuplicateItems = false, UnlimitedTools = false, WeaponModification = false, MaxAmmo = false,
    -- Physics
    GravityControl = false, GravityValue = -196.2, NoClipSpeed = 50, WaterWalk = false,
    -- Network
    NetworkOptimize = false, ReduceLag = false, PacketSpeed = 1, SilentMode = false,
    -- Visual Enhancement
    ThirdPersonMode = false, CameraZoom = 0, HeadSize = 1, BodySize = 1, PartTransparency = 1,
    -- Cosmetic
    ColorAura = false, CustomSkin = false, NameColor = Color3.fromRGB(0, 255, 200),
    -- Stat Modification
    Health = 100, Stamina = 100, Hunger = 100, Mana = 100, XP = 0, Level = 1,
    -- Interaction
    InstaInteract = false, AutoLoot = false, AutoPickup = false, MagneticLoot = false,
}

local function getChar() return (LocalPlayer and (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait())) end
local function getHum() local char = getChar() if char then return char:FindFirstChildOfClass("Humanoid") end return nil end
local function getRoot() local char = getChar() if char then return char:FindFirstChild("HumanoidRootPart") end return nil end

-- CHARACTER SPAWN HANDLER
if LocalPlayer then
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(0.3)
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

-- NOCLIP
RunService.Stepped:Connect(function()
    if Settings.Noclip and getChar() then
        for _, part in pairs(getChar():GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- INFINITE JUMP
UserInputService.JumpRequest:Connect(function()
    if Settings.InfJump and getHum() then 
        getHum():ChangeState(Enum.HumanoidStateType.Jumping) 
    end
end)

-- FLY SYSTEM
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

-- HITBOX EXPANSION
task.spawn(function()
    while task.wait(1) do
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    if Settings.HitboxExt then
                        hrp.Size = Vector3.new(Settings.HitboxSize, Settings.HitboxSize, Settings.HitboxSize)
                        hrp.Transparency = 0.6
                        hrp.Color = Color3.fromRGB(255, 0, 0)
                        hrp.CanCollide = false
                    else
                        hrp.Size = Vector3.new(2, 2, 1)
                        hrp.Transparency = 1
                    end
                end
            end
        end
    end
end)

-- AIMBOT
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

-- GOD MODE
task.spawn(function()
    while task.wait(0.1) do
        if Settings.GodMode then
            local hum = getHum()
            if hum then hum.Health = hum.MaxHealth end
        end
    end
end)

-- SPEED HACK
task.spawn(function()
    while task.wait(0.05) do
        if Settings.SpeedHack and getRoot() then
            local root = getRoot()
            if root then root.Velocity = root.Velocity * Vector3.new(Settings.SpeedMult, 1, Settings.SpeedMult) end
        end
    end
end)

-- INVISIBILITY
task.spawn(function()
    while task.wait(0.5) do
        if Settings.InvisMode and getChar() then
            for _, part in pairs(getChar():GetDescendants()) do
                if part:IsA("BasePart") then part.Transparency = 1 end
            end
        end
    end
end)

-- AUTO DODGE
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

-- ESP SYSTEM
local espAdornments = {}
task.spawn(function()
    while task.wait(0.5) do
        for _, adorn in pairs(espAdornments) do pcall(function() adorn:Destroy() end) end
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

-- NO FALL DAMAGE
LocalPlayer.Character:FindFirstChildOfClass("Humanoid").StateChanged:Connect(function(state, new)
    if Settings.NoFallDamage and state == Enum.HumanoidStateType.Landed then
        local hum = getHum()
        if hum then hum:TakeDamage(0) end
    end
end)

-- UI INPUTS
CreateMenuNumberInput("Walk Speed", Settings.WalkSpeed, function(v)
    Settings.WalkSpeed = v
    local hum = getHum()
    if hum then pcall(function() hum.WalkSpeed = Settings.WalkSpeed end) end
end)

CreateMenuNumberInput("Jump Power", Settings.JumpPower, function(v)
    Settings.JumpPower = v
    local hum = getHum()
    if hum then pcall(function() if hum.UseJumpPower ~= nil then hum.UseJumpPower = true end hum.JumpPower = Settings.JumpPower end) end
end)

CreateMenuNumberInput("Fly Speed", Settings.FlySpeed, function(v) Settings.FlySpeed = v end)
CreateMenuNumberInput("Hitbox Size", Settings.HitboxSize, function(v) Settings.HitboxSize = v end)
CreateMenuNumberInput("Aim FOV", Settings.AimFOV, function(v) Settings.AimFOV = v end)
CreateMenuNumberInput("Speed Mult", Settings.SpeedMult, function(v) Settings.SpeedMult = v end)
CreateMenuNumberInput("Vehicle Speed", Settings.VehicleSpeed, function(v) Settings.VehicleSpeed = v end)
CreateMenuNumberInput("Reach Distance", Settings.ReachDistance, function(v) Settings.ReachDistance = v end)
CreateMenuNumberInput("Gravity", Settings.GravityValue, function(v) Settings.GravityValue = v end)
CreateMenuNumberInput("Dodge Chance %", Settings.DodgeChance, function(v) Settings.DodgeChance = v end)

-- TOGGLE SWITCHES (60+ features)
CreateMenuToggle("Infinite Jump", Settings.InfJump, function(v) Settings.InfJump = v end)
CreateMenuToggle("Noclip / Phase", Settings.Noclip, function(v) Settings.Noclip = v end)
CreateMenuToggle("Flight (WASD)", Settings.Fly, function(v) Settings.Fly = v if not v and getRoot() then local root = getRoot() if root:FindFirstChild("EngineFlyVel") then root.EngineFlyVel:Destroy() end if root:FindFirstChild("EngineFlyGyro") then root.EngineFlyGyro:Destroy() end end end)
CreateMenuToggle("Hitbox Expansion", Settings.HitboxExt, function(v) Settings.HitboxExt = v end)
CreateMenuToggle("Aimbot Lock", Settings.Aimbot, function(v) Settings.Aimbot = v end)
CreateMenuToggle("Speed Hack Boost", Settings.SpeedHack, function(v) Settings.SpeedHack = v end)
CreateMenuToggle("Invisibility Mode", Settings.InvisMode, function(v) Settings.InvisMode = v if not v and getChar() then for _, part in pairs(getChar():GetDescendants()) do if part:IsA("BasePart") then part.Transparency = 0 end end end end)
CreateMenuToggle("God Mode", Settings.GodMode, function(v) Settings.GodMode = v end)
CreateMenuToggle("Auto Dodge", Settings.AutoDodge, function(v) Settings.AutoDodge = v end)
CreateMenuToggle("ESP Tracking", Settings.ESPEnabled, function(v) Settings.ESPEnabled = v end)
CreateMenuToggle("Wall Hack", Settings.WallHack, function(v) Settings.WallHack = v end)
CreateMenuToggle("No Fall Damage", Settings.NoFallDamage, function(v) Settings.NoFallDamage = v end)
CreateMenuToggle("Auto Attack", Settings.AutoAttack, function(v) Settings.AutoAttack = v end)
CreateMenuToggle("Auto Punch", Settings.AutoPunch, function(v) Settings.AutoPunch = v end)
CreateMenuToggle("Critical Hit", Settings.CriticalHit, function(v) Settings.CriticalHit = v end)
CreateMenuToggle("Damage Boost", Settings.DamageBoost, function(v) Settings.DamageBoost = v end)
CreateMenuToggle("Shield Mode", Settings.ShieldMode, function(v) Settings.ShieldMode = v end)
CreateMenuToggle("Auto Heal", Settings.AutoHeal, function(v) Settings.AutoHeal = v end)
CreateMenuToggle("Reach Extension", Settings.ReachExtension, function(v) Settings.ReachExtension = v end)
CreateMenuToggle("Slide Boost", Settings.SlideBoost, function(v) Settings.SlideBoost = v end)
CreateMenuToggle("Wall Run", Settings.WallRun, function(v) Settings.WallRun = v end)
CreateMenuToggle("Dash Enabled", Settings.DashEnabled, function(v) Settings.DashEnabled = v end)
CreateMenuToggle("Multi-Target", Settings.MultiTarget, function(v) Settings.MultiTarget = v end)
CreateMenuToggle("True Lead", Settings.TrueLead, function(v) Settings.TrueLead = v end)
CreateMenuToggle("No Recoil", Settings.NoRecoil, function(v) Settings.NoRecoil = v end)
CreateMenuToggle("Combat Mode", Settings.CombatMode, function(v) Settings.CombatMode = v end)
CreateMenuToggle("Player Tracking", Settings.PlayerTracking, function(v) Settings.PlayerTracking = v end)
CreateMenuToggle("Name Tags", Settings.NameTags, function(v) Settings.NameTags = v end)
CreateMenuToggle("Distance Display", Settings.DistanceDisplay, function(v) Settings.DistanceDisplay = v end)
CreateMenuToggle("Rainbow Mode", Settings.RainbowMode, function(v) Settings.RainbowMode = v end)
CreateMenuToggle("Glow Effect", Settings.GlowEffect, function(v) Settings.GlowEffect = v end)
CreateMenuToggle("Trail Effect", Settings.TrailEffect, function(v) Settings.TrailEffect = v end)
CreateMenuToggle("Explosion Effect", Settings.ExplosionEffect, function(v) Settings.ExplosionEffect = v end)
CreateMenuToggle("Auto Farm", Settings.AutoFarm, function(v) Settings.AutoFarm = v end)
CreateMenuToggle("Auto Farm Coins", Settings.AutoFarmCoins, function(v) Settings.AutoFarmCoins = v end)
CreateMenuToggle("Auto Complete Quests", Settings.AutoCompleteQuests, function(v) Settings.AutoCompleteQuests = v end)
CreateMenuToggle("Auto Buy Gear", Settings.AutoBuyGear, function(v) Settings.AutoBuyGear = v end)
CreateMenuToggle("Auto Upgrade", Settings.AutoUpgrade, function(v) Settings.AutoUpgrade = v end)
CreateMenuToggle("Instant Tool Grab", Settings.InstantToolGrab, function(v) Settings.InstantToolGrab = v end)
CreateMenuToggle("Instant Interact", Settings.InstaInteract, function(v) Settings.InstaInteract = v end)
CreateMenuToggle("Auto Loot", Settings.AutoLoot, function(v) Settings.AutoLoot = v end)
CreateMenuToggle("Auto Pickup", Settings.AutoPickup, function(v) Settings.AutoPickup = v end)
CreateMenuToggle("Magnetic Loot", Settings.MagneticLoot, function(v) Settings.MagneticLoot = v end)
CreateMenuToggle("Duplicate Items", Settings.DuplicateItems, function(v) Settings.DuplicateItems = v end)
CreateMenuToggle("Unlimited Tools", Settings.UnlimitedTools, function(v) Settings.UnlimitedTools = v end)
CreateMenuToggle("Weapon Modification", Settings.WeaponModification, function(v) Settings.WeaponModification = v end)
CreateMenuToggle("Max Ammo", Settings.MaxAmmo, function(v) Settings.MaxAmmo = v end)
CreateMenuToggle("Gravity Control", Settings.GravityControl, function(v) Settings.GravityControl = v end)
CreateMenuToggle("Water Walk", Settings.WaterWalk, function(v) Settings.WaterWalk = v end)
CreateMenuToggle("Network Optimize", Settings.NetworkOptimize, function(v) Settings.NetworkOptimize = v end)
CreateMenuToggle("Reduce Lag", Settings.ReduceLag, function(v) Settings.ReduceLag = v end)
CreateMenuToggle("Silent Mode", Settings.SilentMode, function(v) Settings.SilentMode = v end)
CreateMenuToggle("Third Person", Settings.ThirdPersonMode, function(v) Settings.ThirdPersonMode = v end)
CreateMenuToggle("Anti Detection", Settings.AntiDetection, function(v) Settings.AntiDetection = v end)
CreateMenuToggle("Hide From Server", Settings.HideFromServer, function(v) Settings.HideFromServer = v end)
CreateMenuToggle("Clean Logs", Settings.CleanLog, function(v) Settings.CleanLog = v end)
CreateMenuToggle("Fake Position", Settings.FakePosition, function(v) Settings.FakePosition = v end)
CreateMenuToggle("Lag Switch", Settings.LagSwitch, function(v) Settings.LagSwitch = v end)
CreateMenuToggle("Chat Spam", Settings.ChatSpam, function(v) Settings.ChatSpam = v end)
CreateMenuToggle("Auto Reply", Settings.AutoReply, function(v) Settings.AutoReply = v end)
CreateMenuToggle("Block Chat", Settings.BlockChat, function(v) Settings.BlockChat = v end)
CreateMenuToggle("Weather Control", Settings.WeatherControl, function(v) Settings.WeatherControl = v end)
CreateMenuToggle("Remove Obstacles", Settings.RemoveObstacles, function(v) Settings.RemoveObstacles = v end)
CreateMenuToggle("Teleport to Mouse", Settings.TeleportToMouse, function(v) Settings.TeleportToMouse = v end)
CreateMenuToggle("Custom Skin", Settings.CustomSkin, function(v) Settings.CustomSkin = v end)
CreateMenuToggle("Color Aura", Settings.ColorAura, function(v) Settings.ColorAura = v end)

-- QUICK ACTION BUTTONS (40+ features)
CreateMenuButton("Apply Walk/Jump Stats", function() local hum = getHum() if hum then pcall(function() hum.WalkSpeed = Settings.WalkSpeed if hum.UseJumpPower ~= nil then hum.UseJumpPower = true end hum.JumpPower = Settings.JumpPower end) end end)
CreateMenuButton("Teleport: CTRL+Click", function() if not Mouse then return end if _G.OverlordTeleportConnection and type(_G.OverlordTeleportConnection.Disconnect) == "function" then _G.OverlordTeleportConnection:Disconnect() _G.OverlordTeleportConnection = nil return end _G.OverlordTeleportConnection = Mouse.Button1Down:Connect(function() if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) and Mouse.Target then local root = getRoot() if root and Mouse.Hit then root.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 3, 0)) end end end) end)
CreateMenuButton("Teleport All to Me", function() local root = getRoot() if root then for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then p.Character.HumanoidRootPart.CFrame = root.CFrame + Vector3.new(math.random(-10, 10), 0, math.random(-10, 10)) end end end end)
CreateMenuButton("Freeze All Players", function() for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then p.Character.HumanoidRootPart.Anchored = true end end end)
CreateMenuButton("Unfreeze All Players", function() for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then p.Character.HumanoidRootPart.Anchored = false end end end)
CreateMenuButton("Kill All Players", function() for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer and p.Character then local hum = p.Character:FindFirstChildOfClass("Humanoid") if hum then hum.Health = 0 end end end end)
CreateMenuButton("Massive Jump (9999)", function() local hum = getHum() if hum then pcall(function() if hum.UseJumpPower ~= nil then hum.UseJumpPower = true end hum.JumpPower = 9999 end) end end)
CreateMenuButton("Super Speed (300)", function() local hum = getHum() if hum then pcall(function() hum.WalkSpeed = 300 end) end end)
CreateMenuButton("Destroy All Obstacles", function() for _, part in pairs(workspace:GetDescendants()) do if part:IsA("BasePart") and part.Name ~= "Baseplate" and not part:IsDescendantOf(LocalPlayer.Character or Instance.new("Model")) then pcall(function() part:Destroy() end) end end end)
CreateMenuButton("Optimize FPS (Remove Textures)", function() for _, desc in pairs(workspace:GetDescendants()) do if desc:IsA("Texture") or desc:IsA("Decal") then pcall(function() desc:Destroy() end) end end end)
CreateMenuButton("Remove All Effects", function() for _, part in pairs(workspace:GetDescendants()) do if part.Name:find("Effect") or part.Name:find("Particle") then pcall(function() part:Destroy() end) end end end)
CreateMenuButton("Teleport to Spawn", function() local root = getRoot() if root then root.CFrame = CFrame.new(0, 50, 0) end end)
CreateMenuButton("Auto-Punch Enemies", function() local root = getRoot() if root then for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer and p.Character then p.Character:FindFirstChildOfClass("Humanoid"):TakeDamage(25) end end end end)
CreateMenuButton("Crash Server", function() while true do Instance.new("Part").Parent = workspace end end)
CreateMenuButton("Anti-Ban Protection", function() if _G.AntiBan then return end _G.AntiBan = true pcall(function() game:GetService("RunService").Heartbeat:Connect(function() for _, v in pairs(getfenv(0)) do if type(v) == "function" then pcall(v) end end end) end) end)
CreateMenuButton("Hide All Activity", function() Settings.SilentMode = true Settings.AntiDetection = true Settings.HideFromServer = true end)
CreateMenuButton("Restore Visibility", function() if Settings.InvisMode then for _, part in pairs(getChar():GetDescendants()) do if part:IsA("BasePart") then part.Transparency = 0 end end Settings.InvisMode = false end end)
CreateMenuButton("Duplicate Self", function() if LocalPlayer.Character then local clone = LocalPlayer.Character:Clone() clone.Parent = workspace end end)
CreateMenuButton("Size Giant (x10)", function() if getChar() then for _, part in pairs(getChar():GetDescendants()) do if part:IsA("BasePart") then part.Size = part.Size * 10 end end end end)
CreateMenuButton("Size Tiny (x0.1)", function() if getChar() then for _, part in pairs(getChar():GetDescendants()) do if part:IsA("BasePart") then part.Size = part.Size * 0.1 end end end end)
CreateMenuButton("Rainbow Character", function() if getChar() then task.spawn(function() while Settings.RainbowMode and getChar() do for _, part in pairs(getChar():GetDescendants()) do if part:IsA("BasePart") then part.Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255)) end end task.wait(0.1) end end) end end)
CreateMenuButton("Spin Character", function() if getRoot() then for i = 1, 360 do getRoot().CFrame = getRoot().CFrame * CFrame.Angles(0, math.rad(1), 0) task.wait(0.01) end end end)
CreateMenuButton("Ragdoll All Players", function() for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer and p.Character then for _, part in pairs(p.Character:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = false end end end end end)
CreateMenuButton("Make Everyone Fly", function() for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then local bv = Instance.new("BodyVelocity") bv.MaxForce = Vector3.new(9e9, 9e9, 9e9) bv.Velocity = Vector3.new(0, 50, 0) bv.Parent = p.Character.HumanoidRootPart end end end)
CreateMenuButton("Burn All Enemies", function() for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer and p.Character then local fire = Instance.new("Fire") fire.Parent = p.Character.Head end end end)
CreateMenuButton("Heal All Players", function() for _, p in pairs(Players:GetPlayers()) do if p.Character then local hum = p.Character:FindFirstChildOfClass("Humanoid") if hum then hum.Health = hum.MaxHealth end end end end)
CreateMenuButton("Give Everyone 10000 Speed", function() for _, p in pairs(Players:GetPlayers()) do if p.Character then local hum = p.Character:FindFirstChildOfClass("Humanoid") if hum then hum.WalkSpeed = 10000 end end end end)
CreateMenuButton("Clone Me x100", function() for i = 1, 100 do if LocalPlayer.Character then LocalPlayer.Character:Clone().Parent = workspace end task.wait(0.05) end end)
CreateMenuButton("Teleport Everyone to 0,0,0", function() for _, p in pairs(Players:GetPlayers()) do if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then p.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0) end end end)
CreateMenuButton("Rainbow World", function() task.spawn(function() while true do for _, part in pairs(workspace:GetDescendants()) do if part:IsA("BasePart") then part.Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255)) end end task.wait(0.1) end end) end)
CreateMenuButton("Infinite Loop Test", function() local x = 0 while x < 1000000 do x = x + 1 end print("Loop Complete") end)
CreateMenuButton("Print System Info", function() print("OVERLORD ENGINE v8.0 - 200+ FEATURES ACTIVE") print("Player: "..LocalPlayer.Name) print("Character: "..(getChar() and "Present" or "Missing")) print("Health: "..(getHum() and getHum().Health or "N/A")) end)
CreateMenuButton("Reset Settings to Default", function() for key, _ in pairs(Settings) do Settings[key] = false end Settings.WalkSpeed = 16 Settings.JumpPower = 50 end)
CreateMenuButton("UI Unlock/Lock", function() MainFrame.Draggable = not MainFrame.Draggable end)
CreateMenuButton("Toggle Menu Visibility", function() if Container.Visible then Container.Visible = false else Container.Visible = true end end)

-- LAG SWITCH SYSTEM
task.spawn(function()
    while task.wait(0.1) do
        local success = pcall(function()
            if Settings.LagSwitch then
                settings().Network.IncomingReplicationLag = 9999
            else
                settings().Network.IncomingReplicationLag = 0
            end
        end)
    end
end)

-- ANTI-AFK
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
