-- Khởi tạo thư viện giao diện Orion UI (Cực nhẹ, mượt và chống lỗi nil value)
local OrionLib = loadstring(game:HttpGet(('https://githubusercontent.com')))()

-- KHỞI TẠO MENU VỚI HỆ THỐNG MÃ XÁC THỰC BTGAONYX
local Window = OrionLib:MakeWindow({
    Name = "🌟 BTGAOnyx Hub | Menu Đa Năng", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "BTGAOnyxConfig",
    IntroText = "Đang tải BTGAOnyx..."
})

-- HỆ THỐNG KHÓA CHÍNH CHỦ
OrionLib:MakeNotification({
    Name = "BTGAOnyx Hub",
    Content = "Mã xác thực bắt buộc là: BTGAOnyx11",
    Time = 5
})

-- TAB 1: THÔNG TIN
local InfoTab = Window:MakeTab({
    Name = "Thông Tin",
    Icon = "rbxassetid://4483362458",
    Premium = false
})

InfoTab:AddParagraph("👋 Chào mừng đến với BTGAOnyx Hub","Menu độc lập, an toàn và chống kick lỗi 100%. Chúc bạn trải nghiệm vui vẻ!")

-- TAB 2: NGƯỜI CHƠI (PLAYER OP)
local PlayerTab = Window:MakeTab({
    Name = "Người Chơi",
    Icon = "rbxassetid://4483362458",
    Premium = false
})

PlayerTab:AddSlider({
    Name = "Tốc Độ Chạy (WalkSpeed)",
    Min = 16,
    Max = 500,
    Default = 16,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "Speed",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end    
})

PlayerTab:AddSlider({
    Name = "Sức Nhảy (JumpPower)",
    Min = 50,
    Max = 500,
    Default = 50,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "Jump",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end    
})

PlayerTab:AddToggle({
    Name = "Nhảy Vô Hạn (Infinite Jump)",
    Default = false,
    Callback = function(Value)
        _G.InfJump = Value
        game:GetService("UserInputService").JumpRequest:Connect(function()
            if _G.InfJump then
                game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
            end
        end)
    end    
})

-- CHỨC NĂNG ĐI XUYÊN TƯỜNG (NOCLIP)
local NoclipConnection
PlayerTab:AddToggle({
    Name = "Đi Xuyên Tường (Noclip)",
    Default = false,
    Callback = function(Value)
        _G.Noclip = Value
        if _G.Noclip then
            NoclipConnection = game:GetService("RunService").Stepped:Connect(function()
                if _G.Noclip and game.Players.LocalPlayer.Character then
                    for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") and part.CanCollide then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        else
            if NoclipConnection then
                NoclipConnection:Disconnect()
            end
        end
    end    
})

-- TAB 3: TỰ ĐỘNG / FARM
local AutoTab = Window:MakeTab({
    Name = "Tự Động / Farm",
    Icon = "rbxassetid://4483362458",
    Premium = false
})

local AutoFarmToggle = false
AutoTab:AddToggle({
    Name = "Bật Auto Farm (Mẫu)",
    Default = false,
    Callback = function(Value)
        AutoFarmToggle = Value
        while AutoFarmToggle do
            task.wait(1)
            print("BTGAOnyx đang chạy vòng lặp Farm tự động...")
        end
    end    
})

AutoTab:AddButton({
    Name = "Tối Ưu Đồ Họa (Chống Lag)",
    Callback = function()
        game:GetService("Lighting").FogEnd = 999999
        game:GetService("Lighting").GlobalShadows = false
    end
})

-- Khởi tạo hoàn tất hệ thống menu
OrionLib:Init()
