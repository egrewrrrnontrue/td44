-- OVERLORD UTILITY ENGINE v7.0: ULTRA-COMPACT FIXED
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
MainFrame.Size = UDim2.new(0, 320, 0, 400)
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
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
Container.CanvasSize = UDim2.new(0, 0, 0, 550)
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

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer and LocalPlayer:GetMouse()

local Settings = {
    WalkSpeed = 16, JumpPower = 50, InfJump = false, Noclip = false,
    HitboxExt = false, HitboxSize = 25, Aimbot = false, AimFOV = 150,
    Fly = false, FlySpeed = 50, LagSwitch = false, ChatSpam = false
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

-- Buttons and Toggles
CreateMenuButton("Set Speed: 150", function()
    Settings.WalkSpeed = 150
    local hum = getHum()
    if hum then hum.WalkSpeed = 150 end
end)

CreateMenuButton("Set Jump Power: 200", function()
    Settings.JumpPower = 200
    local hum = getHum()
    if hum then
        if hum.UseJumpPower ~= nil then hum.UseJumpPower = true end
        hum.JumpPower = 200
    end
end)

CreateMenuButton("Reset Stats to Default", function()
    Settings.WalkSpeed = 16
    Settings.JumpPower = 50
    local hum = getHum()
    if hum then
        hum.WalkSpeed = 16
        hum.JumpPower = 50
    end
end)

CreateMenuToggle("Infinite Jump Engine", false, function(v)
    Settings.InfJump = v
end)

CreateMenuToggle("Phase Mode (Noclip)", false, function(v)
    Settings.Noclip = v
end)

CreateMenuToggle("Flight Mechanics (W,A,S,D)", false, function(v)
    Settings.Fly = v
    if not v and getRoot() then
        local root = getRoot()
        if root:FindFirstChild("EngineFlyVel") then root.EngineFlyVel:Destroy() end
        if root:FindFirstChild("EngineFlyGyro") then root.EngineFlyGyro:Destroy() end
    end
end)

CreateMenuToggle("Expand Enemy Hitboxes", false, function(v)
    Settings.HitboxExt = v
end)

CreateMenuToggle("Aim Lock Tracking Assist", false, function(v)
    Settings.Aimbot = v
end)

CreateMenuButton("Teleport: CTRL + Left Click", function()
    if not Mouse then return end
    local connection
    connection = Mouse.Button1Down:Connect(function()
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) and Mouse.Target then
            local root = getRoot()
            if root and Mouse.Hit then
                root.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 3, 0))
            end
        end
    end)
    -- optional: disconnect after a while or keep it persistent (kept persistent here)
end)

CreateMenuToggle("Network Lag Switch", false, function(v)
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

-- Simulate Fake Error 277 Kick
CreateMenuButton("Simulate Fake Error 277 Kick", function()
    pcall(function()
        game:GetService("GuiService"):SetErrorMessage("An unexpected error occurred and you have been disconnected. (Error Code: 277)")
    end)
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
