-- MENU CẤU HÌNH TÍNH NĂNG (Bật = true, Tắt = false)
local Config = {
    AutoFarm = false,       -- Tự động đánh quái theo cấp độ
    BringMob = true,        -- Gom tất cả quái lại 1 điểm để đánh nhanh hơn
    AutoHaki = true,        -- Tự động bật Haki vũ trang khi hồi chiêu
    AutoChest = false,      -- Tự động bay đi nhặt rương kiếm Beli
    FullBright = true,      -- Hack sáng toàn bản đồ, xóa bóng tối
    InfiniteZoom = true,    -- Mở rộng khoảng cách góc nhìn Camera (Zoom cực xa)
    AutoStats = {
        Enabled = false,    -- Tự động cộng điểm nâng chỉ số
        Target = "Melee"    -- Lựa chọn: "Melee", "Defense", "Sword", "Gun", "Blox Fruit"
    }
}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")

-- 1. TÍNH NĂNG: HACK SÁNG (FULLBRIGHT)
if Config.FullBright then
    Lighting.Brightness = 2
    Lighting.ClockTime = 14
    Lighting.GlobalShadows = false
end

-- 2. TÍNH NĂNG: MỞ RỘNG TẦM NHÌN CAMERA (INFINITE ZOOM)
if Config.InfiniteZoom then
    LocalPlayer.CameraMaxZoomDistance = 100000
end

-- 3. TÍNH NĂNG: TỰ ĐỘNG BẬT HAKI
task.spawn(function()
    while task.wait(1) do
        if Config.AutoHaki and LocalPlayer.Character then
            if not LocalPlayer.Character:FindFirstChild("HasBuso") then
                pcall(function()
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
                end)
            end
        end
    end
end)

-- 4. TÍNH NĂNG: TỰ ĐỘNG CỘNG ĐIỂM (AUTO STATS)
task.spawn(function()
    while task.wait(0.5) do
        if Config.AutoStats.Enabled then
            pcall(function()
                ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", Config.AutoStats.Target, 1)
            end)
        end
    end
end)

-- 5. TÍNH NĂNG: GOM QUÁI (BRING MOB) & AUTO FARM (MẪU ĐỊNH HƯỚNG)
task.spawn(function()
    while task.wait(0.1) do
        if Config.BringMob then
            pcall(function()
                -- Hệ thống quét và gom quái lại gần vị trí người chơi trong bán kính 300m
                for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                    if enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
                        local myPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if myPart and (enemy.HumanoidRootPart.Position - myPart.Position).Magnitude < 300 then
                            enemy.HumanoidRootPart.CFrame = myPart.CFrame * CFrame.new(0, 0, -5)
                            enemy.HumanoidRootPart.CanCollide = false
                        end
                    end
                end
            end)
        end
    end
end)

-- 6. TÍNH NĂNG: TỰ ĐỘNG NHẶT RƯƠNG (AUTO CHEST)
task.spawn(function()
    while task.wait(0.1) do
        if Config.AutoChest then
            pcall(function()
                -- Tìm và dịch chuyển trực tiếp đến rương gần nhất
                for _, chest in pairs(workspace:GetChildren()) do
                    if string.find(chest.name, "Chest") and chest:IsA("Part") then
                        local myPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if myPart then
                            myPart.CFrame = chest.CFrame
                            task.wait(0.2)
                        end
                    end
                end
            end)
        end
    end
end)
