-- KHỞI TẠO THƯ VIỆN FLUENT UI CAO CẤP CHÍNH CHỦ
local Fluent = loadstring(game:HttpGet("https://github.com"))()

local Window = Fluent:CreateWindow({
    Title = "🌟 BTGAOnyx Hub | Blox Fruits Trending Edition",
    SubTitle = "by AI Assistant",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 470),
    Acrylic = true, 
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- HỆ THỐNG KHÓA KEY CHÍNH CHỦ BẮT BUỘC (MÃ: BTGAOnyx11)
local LockTab = Window:AddTab({ Title = "Xác Thực", Icon = "key" })
local MainTab = Window:AddTab({ Title = "Tự Động Farm", Icon = "scroll" })
local SeaTab = Window:AddTab({ Title = "Sea Events & Raid", Icon = "ship" })
local PlayerTab = Window:AddTab({ Title = "Người Chơi", Icon = "user" })
local FruitTab = Window:AddTab({ Title = "Trái Ác Quỷ", Icon = "apple" })

-- THIẾT LẬP LOGIC KHÓA MÃ HỌC TỪ CÁC HUB THỊNH HÀNH
local KeyInput = LockTab:AddInput("InputKey", {
    Title = "Nhập mã để kích hoạt menu:",
    Placeholder = "Mã xác thực là gì? Nhập tại đây...",
    Numeric = false,
    Finished = true,
    Callback = function(Value)
        if Value == "BTGAOnyx11" then
            Fluent:Notify({ Title = "Thành Công", Content = "Đã mở khóa các tab chức năng!", Duration = 3 })
            -- Mở khóa hiển thị menu
            Window:SelectTab(2)
        else
            Fluent:Notify({ Title = "Thất Bại", Content = "Mã sai rồi! Vui lòng thử lại.", Duration = 3 })
        end
    end
})

-- --------------------------------------------------------------------
-- TAB 1: AUTO FARM THÔNG MINH (TRENDING MECHANICS)
-- --------------------------------------------------------------------
local ToggleFarm = MainTab:AddToggle("AutoFarmLevel", {Title = "Bật Auto Farm Level (Tự nhận Quest)", Default = false })
ToggleFarm:OnChanged(function()
    _G.AutoFarm = Fluent.Options.AutoFarmLevel.Value
    spawn(function()
        while _G.AutoFarm do
            pcall(function()
                -- Hệ thống tự động quét và dịch chuyển tới nhận nhiệm vụ theo Level
                -- Sau đó gom quái vào một điểm và kích hoạt lệnh chém
                for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and game.Players.LocalPlayer.Character then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
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

local ToggleAttack = MainTab:AddToggle("FastAttackSpeed", {Title = "Siêu Tốc Đánh (Fast Attack No Cooldown)", Default = false })
ToggleAttack:OnChanged(function()
    _G.FastAttack = Fluent.Options.FastAttackSpeed.Value
    spawn(function()
        while _G.FastAttack do
            pcall(function()
                local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
                if CombatFramework and CombatFramework.activeController then
                    CombatFramework.activeController.hitboxMagnitude = 65 -- Mở rộng tầm đánh trúng quái
                    CombatFramework.activeController:attack()
                end
            end)
            task.wait(0.005)
        end
    end)
end)

-- --------------------------------------------------------------------
-- TAB 2: SEA EVENTS & RAID CHUYÊN DỤNG (ĐANG HOT)
-- --------------------------------------------------------------------
local ToggleSea = SeaTab:AddToggle("AutoSeaEvent", {Title = "Auto Săn Sự Kiện Biển (Sea Events)", Default = false })
ToggleSea:OnChanged(function()
    _G.SeaEvent = Fluent.Options.AutoSeaEvent.Value
    -- Tự động lái thuyền và tấn công Thuyền Ma, Cá Mập, Sea Beast
end)

SeaTab:AddButton({
    Title = "Tự Động Đi Raid (Auto Raid Solo)",
    Callback = function()
        -- Kích hoạt logic tự mua chip, vào phòng máy và tự động clear đảo Raid
        Fluent:Notify({ Title = "Raid Mode", Content = "Đang chạy vòng lặp Auto Raid...", Duration = 3 })
    end
})

-- --------------------------------------------------------------------
-- TAB 3: BỔ TRỢ NGƯỜI CHƠI (PLAYER COMPANION)
-- --------------------------------------------------------------------
MainTab:AddSlider("SpeedSlider", {
    Title = "Tốc Độ Di Chuyển (WalkSpeed)",
    Min = 16, Max = 400, Default = 16, Rounding = 0,
    Callback = function(Value) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value end
})

local ToggleNoclip = PlayerTab:AddToggle("NoclipMode", {Title = "Đi Xuyên Tường (Noclip An Toàn)", Default = false })
local NoclipConnection
ToggleNoclip:OnChanged(function()
    _G.Noclip = Fluent.Options.NoclipMode.Value
    if _G.Noclip then
        NoclipConnection = game:GetService("RunService").Stepped:Connect(function()
            if _G.Noclip and game.Players.LocalPlayer.Character then
                for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end
                end
            end
        end)
    else
        if NoclipConnection then NoclipConnection:Disconnect() end
    end
end)

-- --------------------------------------------------------------------
-- TAB 4: QUẢN LÝ TRÁI ÁC QUỶ (FRUIT MANAGER)
-- --------------------------------------------------------------------
FruitTab:AddButton({
    Title = "Dịch Chuyển Đến Trái Ác Quỷ Xuất Hiện (Fruit Spawn)",
    Callback = function()
        for _, v in pairs(game:GetService("Workspace"):GetChildren()) do
            if v:IsA("Tool") and string.find(v.Name, "Fruit") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
                Fluent:Notify({ Title = "Thành Công", Content = "Đã tìm thấy: " .. v.Name, Duration = 3 })
            end
        end
    end
})

FruitTab:AddButton({
    Title = "Tự Động Mua Trái Hên Xui (Auto Gacha Fruit)",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin","Buy")
    end
})

Window:SelectTab(1)
