-- Khởi tạo thư viện giao diện Venyx UI (Giao diện nhiều Tab chuyên nghiệp, mượt và không lỗi)
local Venyx = loadstring(game:HttpGet("https://githubusercontent.com"))()
local UI = Venyx.CreateLib("🌟 BTGAOnyx Hub | Blox Fruits", "Default")

-- ====================================================================
-- TAB 1: TRANG CHỦ & THÔNG TIN
-- ====================================================================
local HomeTab = UI:NewTab("Trang Chủ")
local HomeSection = HomeTab:NewSection("Thông Tin Menu")

HomeSection:AddLabel("👋 Chào mừng bạn đến với BTGAOnyx Hub!")
HomeSection:AddLabel("🔥 Menu độc lập - An toàn - Chống Kick 100%")

-- ====================================================================
-- TAB 2: TỰ ĐỘNG CÀY (AUTO FARM)
-- ====================================================================
local FarmTab = UI:NewTab("Auto Farm")
local FarmSection = FarmTab:NewSection("Cày Cấp & Quái")

FarmSection:NewToggle("Tự Động Farm Level", false, function(Value)
    _G.AutoFarm = Value
    spawn(function()
        while _G.AutoFarm do
            pcall(function()
                for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and game.Players.LocalPlayer.Character then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                        local VirtualUser = game:GetService('VirtualUser')
                        VirtualUser:CaptureController()
                        VirtualUser:ClickButton1(Vector2.new(850, 520))
                    end
                end
            end)
            task.wait(0.1)
        end
    end)
end)

FarmSection:NewToggle("Siêu Tốc Đánh (Fast Attack)", false, function(Value)
    _G.FastAttack = Value
    spawn(function()
        while _G.FastAttack do
            pcall(function()
                local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
                if CombatFramework and CombatFramework.activeController then
                    CombatFramework.activeController.hitboxMagnitude = 55
                    CombatFramework.activeController:attack()
                end
            end)
            task.wait(0.01)
        end
    end)
end)

-- ====================================================================
-- TAB 3: NGƯỜI CHƠI (PLAYER)
-- ====================================================================
local PlayerTab = UI:NewTab("Người Chơi")
local PlayerSection = PlayerTab:NewSection("Bổ Trợ Di Chuyển")

PlayerSection:NewSlider("Tốc Độ Chạy (WalkSpeed)", 16, 16, 500, function(Value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
end)

PlayerSection:NewSlider("Sức Nhảy (JumpPower)", 50, 50, 500, function(Value)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
end)

PlayerSection:NewToggle("Đi Xuyên Tường (Noclip)", false, function(Value)
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
        if NoclipConnection then NoclipConnection:Disconnect() end
    end
end)

PlayerSection:NewToggle("Nhảy Vô Hạn", false, function(Value)
    _G.InfJump = Value
    game:GetService("UserInputService").JumpRequest:Connect(function()
        if _G.InfJump then
            game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
        end
    end)
end)

-- ====================================================================
-- TAB 4: DỊCH CHUYỂN (TELEPORT)
-- ====================================================================
local TeleportTab = UI:NewTab("Dịch Chuyển")
local TeleportSection = TeleportTab:NewSection("Chọn Biển (Sea)")

TeleportSection:NewButton("Dịch Chuyển Đến Biển 1", "Nhấn để qua Sea 1", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain")
end)

TeleportSection:NewButton("Dịch Chuyển Đến Biển 2", "Nhấn để qua Sea 2", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
end)

TeleportSection:NewButton("Dịch Chuyển Đến Biển 3", "Nhấn để qua Sea 3", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
end)

-- ====================================================================
-- TAB 5: TRÁI ÁC QUỶ (FRUIT)
-- ====================================================================
local FruitTab = UI:NewTab("Trái Ác Quỷ")
local FruitSection = FruitTab:NewSection("Tính Năng Trái Cây")

FruitSection:NewButton("Tự Động Nhặt Trái Ác Quỷ", "Tìm trái trên bản đồ", function()
    for _, v in pairs(game:GetService("Workspace"):GetChildren()) do
        if v:IsA("Tool") and string.find(v.Name, "Fruit") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
        end
    end
end)

FruitSection:NewButton("Tự Động Mua Trái Hên Xui (Random Fruit)", "Mua từ gacha", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin","Buy")
end)

-- Mặc định chọn mở Tab đầu tiên khi chạy menu
UI:SelectTab(HomeTab)
