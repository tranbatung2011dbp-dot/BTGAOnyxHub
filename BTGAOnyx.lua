-- TỰ TẠO GIAO DIỆN THUẦN (KHÔNG DÙNG LINK NGOÀI - CHỐNG LỖI NIL VALUE 100%)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local SpeedBtn = Instance.new("TextButton")
local JumpBtn = Instance.new("TextButton")
local NoclipBtn = Instance.new("TextButton")
local CloseBtn = Instance.new("TextButton")

-- Cài đặt vị trí và giao diện Menu (Tông màu tối đen đỏ ngầu)
ScreenGui.Parent = game.CoreGui
MainFrame.Name = "BTGAOnyxMenu"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 250, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true -- Có thể giữ chuột để di chuyển menu trên màn hình

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.Text = "🌟 BTGAOnyx Hub 🌟"
Title.TextColor3 = Color3.fromRGB(255, 0, 0)
Title.TextSize = 18
Title.Font = Enum.Font.SourceSansBold

-- NÚT BẬT TỐC ĐỘ (WalkSpeed)
SpeedBtn.Parent = MainFrame
SpeedBtn.Position = UDim2.new(0.1, 0, 0.2, 0)
SpeedBtn.Size = UDim2.new(0.8, 0, 0, 40)
SpeedBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpeedBtn.Text = "⚡ Tăng Tốc Chạy (Bật/Tắt)"
SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBtn.TextSize = 14

local speedActive = false
SpeedBtn.MouseButton1Click:Connect(function()
    speedActive = not speedActive
    if speedActive then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
        SpeedBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    else
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        SpeedBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end
end)

-- NÚT BẬT NHẢY CAO (JumpPower)
JumpBtn.Parent = MainFrame
JumpBtn.Position = UDim2.new(0.1, 0, 0.4, 0)
JumpBtn.Size = UDim2.new(0.8, 0, 0, 40)
JumpBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
JumpBtn.Text = "🦘 Nhảy Cao (Bật/Tắt)"
JumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpBtn.TextSize = 14

local jumpActive = false
JumpBtn.MouseButton1Click:Connect(function()
    jumpActive = not jumpActive
    if jumpActive then
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 150
        JumpBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    else
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
        JumpBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end
end)

-- NÚT ĐI XUYÊN TƯỜNG (Noclip)
NoclipBtn.Parent = MainFrame
NoclipBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
NoclipBtn.Size = UDim2.new(0.8, 0, 0, 40)
NoclipBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
NoclipBtn.Text = "🧱 Xuyên Tường (Bật/Tắt)"
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

-- NÚT ĐÓNG MENU
CloseBtn.Parent = MainFrame
CloseBtn.Position = UDim2.new(0.1, 0, 0.8, 0)
CloseBtn.Size = UDim2.new(0.8, 0, 0, 35)
CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseBtn.Text = "❌ Tắt Menu"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
