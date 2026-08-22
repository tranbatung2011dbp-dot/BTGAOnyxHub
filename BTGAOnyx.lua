-- KỊCH BẢN BLOX FRUITS ĐỘC LẬP 100% - KHÔNG LIÊN QUAN ĐẾN QUANTUM
local Fluent = loadstring(game:HttpGet("https://github.com"))()

local Window = Fluent:CreateWindow({
    Title = "🌟 BTGAOnyx Hub | Blox Fruits Edition",
    SubTitle = "Bản Độc Lập Không Key",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false, -- Tắt mờ kính để tối ưu hóa mượt mà cho mọi thiết bị
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Tự động phân chia các Tab chức năng thịnh hành
local Tabs = {
    Main = Window:AddTab({ Title = "Tự Động Farm", Icon = "scroll" }),
    Player = Window:AddTab({ Title = "Người Chơi", Icon = "user" }),
    Fruit = Window:AddTab({ Title = "Trái Ác Quỷ", Icon = "apple" })
}

-- --------------------------------------------------------------------
-- TAB 1: CHỨC NĂNG FARM CÀY CUỐC
-- --------------------------------------------------------------------
local ToggleFarm = Tabs.Main:AddToggle("AutoFarmLevel", {Title = "Bật Auto Farm Level", Default = false })
ToggleFarm:OnChanged(function()
    _G.AutoFarm = Fluent.Options.AutoFarmLevel.Value
    spawn(function()
        while _G.AutoFarm do
            pcall(function()
                for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and game.Players.LocalPlayer.Character then
                        -- Dịch chuyển né đòn lên đầu quái
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                        -- Lệnh tự động click tấn công
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

local ToggleAttack = Tabs.Main:AddToggle("FastAttackSpeed", {Title = "Bật Siêu Tốc Đánh (Fast Attack)", Default = false })
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
-- TAB 2: BỔ TRỢ NGƯỜI CHƠI
-- --------------------------------------------------------------------
Tabs.Player:AddSlider("WalkSpeedSlider", {
    Title = "Tốc Độ Di Chuyển",
    Min = 16, Max = 300, Default = 16, Rounding = 0,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

local ToggleNoclip = Tabs.Player:AddToggle("NoclipMode", {Title = "Đi Xuyên Tường (Noclip)", Default = false })
local NoclipConnection
ToggleNoclip:OnChanged(function()
    _G.Noclip = Fluent.Options.NoclipMode.Value
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

-- --------------------------------------------------------------------
-- TAB 3: QUẢN LÝ TRÁI ÁC QUỶ
-- --------------------------------------------------------------------
Tabs.Fruit:AddButton({
    Title = "Dịch Chuyển Nhặt Trái Ác Quỷ Rơi (Toàn Bản Đồ)",
    Callback = function()
        local found = false
        for _, v in pairs(game:GetService("Workspace"):GetChildren()) do
            if v:IsA("Tool") and string.find(v.Name, "Fruit") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
                found = true
            end
        end
        if not found then
            Fluent:Notify({ Title = "Thông Báo", Content = "Hiện không có trái ác quỷ nào rơi trên map!", Duration = 3 })
        end
    end
})

Tabs.Fruit:AddButton({
    Title = "Random Trái Ác Quỷ (Gacha Fruit)",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin","Buy")
    end
})

Window:SelectTab(1)
