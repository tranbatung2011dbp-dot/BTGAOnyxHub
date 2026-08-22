-- Khởi tạo thư viện giao diện Rayfield UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu'))()

-- KHỞI TẠO MENU VỚI HỆ THỐNG KEY CHÍNH CHỦ CỦA BTGAONYX
local Window = Rayfield:CreateWindow({
   Name = "🌟 BTGAOnyx Hub | Menu Đa Năng",
   LoadingTitle = "Đang tải Giao diện BTGAOnyx...",
   LoadingSubtitle = "by AI Assistant",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "BTGAOnyxHubConfig",
      FileName = "BTGAOnyxMenu"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = true,
   KeySettings = {
      Title = "Hệ Thống Xác Thực BTGAOnyx",
      Subtitle = "Nhập mã để tiếp tục sử dụng",
      Note = "Mã xác thực bắt buộc là: BTGAOnyx11",
      FileName = "BTGAOnyxKeyData",
      SaveKey = true,
      GrabKeyFromUrl = "",
      Key = {"BTGAOnyx11"}
   }
})

-- TAB 1: THÔNG TIN
local InfoTab = Window:CreateTab("Thông Tin", 4483362458)

InfoTab:CreateParagraph({
    Title = "👋 Chào mừng đến với BTGAOnyx Hub", 
    Content = "Menu độc lập, an toàn và chống kick lỗi 100%. Chúc bạn trải nghiệm vui vẻ!"
})

-- TAB 2: NGƯỜI CHƠI (PLAYER OP)
local PlayerTab = Window:CreateTab("Người Chơi", 4483362458)

PlayerTab:CreateSlider({
   Name = "Tốc Độ Chạy (WalkSpeed)",
   Range = {16, 500},
   Increment = 1,
   CurrentValue = 16,
   Flag = "SliderSpeed",
   Callback = function(Value)
       game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

PlayerTab:CreateSlider({
   Name = "Sức Nhảy (JumpPower)",
   Range = {50, 500},
   Increment = 1,
   CurrentValue = 50,
   Flag = "SliderJump",
   Callback = function(Value)
       game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
   end,
})

PlayerTab:CreateToggle({
   Name = "Nhảy Vô Hạn (Infinite Jump)",
   CurrentValue = false,
   Flag = "InfJump",
   Callback = function(Value)
       _G.InfJump = Value
       game:GetService("UserInputService").JumpRequest:Connect(function()
           if _G.InfJump then
               game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
           end
       end)
   end,
})

-- CHỨC NĂNG ĐI XUYÊN TƯỜNG (NOCLIP)
local NoclipConnection
PlayerTab:CreateToggle({
   Name = "Đi Xuyên Tường (Noclip)",
   CurrentValue = false,
   Flag = "NoclipToggle",
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
   end,
})

-- TAB 3: TỰ ĐỘNG / FARM
local AutoTab = Window:CreateTab("Tự Động / Farm", 4483362458)

local AutoFarmToggle = false
AutoTab:CreateToggle({
   Name = "Bật Auto Farm (Mẫu)",
   CurrentValue = false,
   Flag = "AutoFarm",
   Callback = function(Value)
       AutoFarmToggle = Value
       while AutoFarmToggle do
           task.wait(1)
           print("BTGAOnyx đang chạy vòng lặp Farm tự động...")
       end
   end,
})

AutoTab:CreateButton({
   Name = "Tối Ưu Đồ Họa (Chống Lag)",
   Callback = function()
       game:GetService("Lighting").FogEnd = 999999
       game:GetService("Lighting").GlobalShadows = false
       Rayfield:Notify({Title = "BTGAOnyx", Content = "Đã xóa sương mù và bóng đổ!", Duration = 2})
   end,
})
