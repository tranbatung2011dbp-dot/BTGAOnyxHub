-- TỰ TẠO GIAO DIỆN THUẦN CHỨA TÍNH NĂNG FARM GIỐNG QUANTUMONYX
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local SpeedBtn = Instance.new("TextButton")
local NoclipBtn = Instance.new("TextButton")
local FarmBtn = Instance.new("TextButton")
local AttackBtn = Instance.new("TextButton")
local CloseBtn = Instance.new("TextButton")

-- Cấu hình khung Menu chính
ScreenGui.Parent = game.CoreGui
MainFrame.Name = "BTGAOnyxMenu"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 260, 0, 350)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Title.Text = "🌟 BTGAOnyx Hub (Blox Fruits) 🌟"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold

-- 1. TÍNH NĂNG AUTO FARM LEVEL (GIỐNG QUANTUMONYX)
FarmBtn.Parent = MainFrame
FarmBtn.Position = UDim2.new(0.1, 0, 0.18, 0)
FarmBtn.Size = UDim2.new(0.8, 0, 0, 40)
FarmBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
FarmBtn.Text = "🚜 Tự Động Farm Level (Bật/Tắt)"
FarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmBtn.TextSize = 14

_G.AutoFarm = false
FarmBtn.MouseButton1Click:Connect(function()
    _G.AutoFarm = not _G.AutoFarm
    if _G.AutoFarm then
        FarmBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        -- Vòng lặp gom quái và tự động đánh quái farm cấp nhanh
        spawn(function()
            while _G.AutoFarm do
                pcall(function()
                    for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and game.Players.LocalPlayer.Character then
                            -- Dịch chuyển đến vị trí quái để farm
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                            -- Kích hoạt công cụ/vũ khí đang cầm để chém quái
                            local VirtualUser = game:GetService('VirtualUser')
                            VirtualUser:CaptureController()
                            VirtualUser:ClickButton1(Vector2.new(850, 520))
                        end
                    end
                end)
                task.wait(0.1)
            end
        end)
    else
        FarmBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end
end)

-- 2. TÍNH NĂNG SIÊU TỐC ĐÁNH FAST ATTACK (GIỐNG QUANTUMONYX)
AttackBtn.Parent = MainFrame
AttackBtn.Position = UDim2.new(0.1, 0, 0.33, 0)
AttackBtn.Size = UDim2.new(0.8, 0, 0, 40)
AttackBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
AttackBtn.Text = "⚔️ Siêu Tốc Đánh (Fast Attack)"
AttackBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AttackBtn.TextSize = 14

_G.FastAttack = false
AttackBtn.MouseButton1Click:Connect(function()
    _G.FastAttack = not _G.FastAttack
    if _G.FastAttack then
        AttackBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        spawn(function()
            while _G.FastAttack do
                pcall(function()
                    -- Đoạn mã loại bỏ thời gian chờ (cooldown) của đòn đánh thường
                    local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
                    local CurrentCamera = game:GetService("Workspace").CurrentCamera
                    if CombatFramework and CombatFramework.activeController then
                        CombatFramework.activeController.hitboxMagnitude = 55
                        CombatFramework.activeController:attack()
                    end
                end)
                task.wait(0.01) -- Đánh siêu nhanh không độ trễ
            end
        end)
    else
        AttackBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end
end)

-- 3. TÍNH NĂNG ĐI XUYÊN TƯỜNG (NOCLIP)
NoclipBtn.Parent = MainFrame
NoclipBtn.Position = UDim2.new(0.1, 0, 0.48, 0)
NoclipBtn.Size = UDim2.new(0.8, 0, 0, 40)
NoclipBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
NoclipBtn.Text = "🧱 Xuyên Tường (Noclip)"
NoclipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
NoclipBtn.TextSize = 14

local noclipActive = false
local NoclipConnection
NoclipBtn.MouseButton1Click:Connect(function()
    noclipActive = not noclipActive
    if noclipActive then
        NoclipBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        NoclipConnection = game:GetService("RunService").Stepped:Connect(function()
            if noclipActive and game.Players.LocalPlayer.Character then
                for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        NoclipBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        if NoclipConnection then NoclipConnection:Disconnect() end
    end
end)

-- 4. TÍNH NĂNG TĂNG TỐC CHẠY (WALKSPEED)
SpeedBtn.Parent = MainFrame
SpeedBtn.Position = UDim2.new(0.1, 0, 0.63, 0)
SpeedBtn.Size = UDim2.new(0.8, 0, 0, 40)
SpeedBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpeedBtn.Text = "⚡ Tốc Độ Chạy Cao"
SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBtn.TextSize = 14

local speedActive = false
SpeedBtn.MouseButton1Click:Connect(function()
    speedActive = not speedActive
    if speedActive then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 80
        SpeedBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    else
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        SpeedBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end
end)

-- 5. NÚT ĐÓNG MENU
CloseBtn.Parent = MainFrame
CloseBtn.Position = UDim2.new(0.1, 0, 0.82, 0)
CloseBtn.Size = UDim2.new(0.8, 0, 0, 35)
CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseBtn.Text = "❌ Tắt Menu"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
