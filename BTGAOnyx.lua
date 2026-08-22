-- Khởi tạo thư viện giao diện Kavo UI (Siêu ổn định, chống lỗi nil value)
local KavoUi = loadstring(game:HttpGet("https://githubusercontent.com"))()

-- KHỞI TẠO MENU BTGAONYX
local Window = KavoUi.CreateLib("🌟 BTGAOnyx Hub | Menu Đa Năng", "DarkTheme")

-- ====================================================================
-- CÁC TAB TÍNH NĂNG CHÍNH
-- ====================================================================

-- TAB 1: NGƯỜI CHƠI
local PlayerTab = Window:NewTab("Người Chơi")
local PlayerSection = PlayerTab:NewSection("Tính Năng Người Chơi")

PlayerSection:NewSlider("Tốc Độ Chạy (WalkSpeed)", "Thay đổi tốc độ chạy của bạn", 500, 16, function(Value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
end)

PlayerSection:NewSlider("Sức Nhảy (JumpPower)", "Thay đổi sức nhảy của bạn", 500, 50, function(Value)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
end)

PlayerSection:NewToggle("Nhảy Vô Hạn", "Bật để nhảy liên tục trên không", function(Value)
    _G.InfJump = Value
    game:GetService("UserInputService").JumpRequest:Connect(function()
        if _G.InfJump then
            game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
        end
    end)
end)

-- CHỨC NĂNG ĐI XUYÊN TƯỜNG (NOCLIP)
local NoclipConnection
PlayerSection:NewToggle("Đi Xuyên Tường (Noclip)", "Bật để đi xuyên qua mọi vật thể", function(Value)
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
end)

-- TAB 2: TỰ ĐỘNG / FARM
local AutoTab = Window:NewTab("Tự Động")
local AutoSection = AutoTab:NewSection("Tự Động / Khác")

local AutoFarmToggle = false
AutoSection:NewToggle("Bật Auto Farm (Mẫu)", "Vòng lặp tự động nhặt đồ hoặc farm", function(Value)
    AutoFarmToggle = Value
    while AutoFarmToggle do
        task.wait(1)
        print("BTGAOnyx đang chạy vòng lặp Farm tự động...")
    end
end)

AutoSection:NewButton("Tối Ưu Đồ Họa (Chống Lag)", "Xóa sương mù và giảm bóng đổ", function()
    game:GetService("Lighting").FogEnd = 999999
    game:GetService("Lighting").GlobalShadows = false
end)
