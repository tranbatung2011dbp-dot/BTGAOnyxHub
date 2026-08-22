-- Khởi tạo thư viện giao diện Rayfield UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu'))()

-- Đặt mã xác thực bắt buộc theo yêu cầu
local MA_XAC_THUC = "BTGAOnyx11"

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
   KeySystem = false 
})

-- TAB KHÓA (Hiện đầu tiên khi chưa nhập mã)
local LockTab = Window:CreateTab("Xác Thực", 4483362458)

-- Khai báo trước các Tab tính năng
local MainTab, PlayerTab, AutoTab

LockTab:CreateInput({
   Name = "Nhập mã để mở khóa menu:",
   PlaceholderText = "Mã là gì nhỉ? Nhập tại đây...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
       if Text == MA_XAC_THUC then
           Rayfield:Notify({Title = "Thành Công", Content = "Mã chính xác! Đang mở khóa menu...", Duration = 3})
           
           -- TẠO CÁC TAB TÍNH NĂNG KHI NHẬP ĐÚNG MÃ BTGAOnyx11
           MainTab = Window:CreateTab("Chính", 4483362458)
           PlayerTab = Window:CreateTab("Người Chơi", 4483362458)
           AutoTab = Window:CreateTab("Tự Động / Khác", 4483362458)

           -- CÀI ĐẶT TAB CHÍNH
           MainTab:CreateButton({
              Name = "🚀 Kích Hoạt Script Gốc BTGAOnyx",
              Callback = function()
                  Rayfield:Notify({Title = "BTGAOnyx", Content = "Đang chạy script gốc...", Duration = 3})
                  pcall(function()
                      -- Đường dẫn chạy link script gốc của bạn
                      loadstring(game:HttpGet("https://githubusercontent.com"))()
                  end)
              end,
           })

           -- CÀI ĐẶT TAB NGƯỜI CHƠI
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

           -- CÀI ĐẶT TAB TỰ ĐỘNG
           local AutoFarmToggle = false
           AutoTab:CreateToggle({
              Name = "Bật Tự Động Nhặt Đồ / Farm (Mẫu)",
              CurrentValue = false,
              Flag = "AutoFarm",
              Callback = function(Value)
                  AutoFarmToggle = Value
                  while AutoFarmToggle do
                      task.wait(1)
                      print("BTGAOnyx đang chạy vòng lặp Farm mẫu...")
                  end
              end,
           })

           AutoTab:CreateButton({
              Name = "Xóa Sương Mù (Clear Fog/Chống Lag)",
              Callback = function()
                  game:GetService("Lighting").FogEnd = 999999
                  game:GetService("Lighting").GlobalShadows = false
                  Rayfield:Notify({Title = "BTGAOnyx", Content = "Đã tối ưu hóa đồ họa!", Duration = 2})
              end,
           })

       else
           Rayfield:Notify({Title = "Thất Bại", Content = "Mã sai rồi! Vui lòng kiểm tra lại.", Duration = 3})
       end
   end,
})

-- Thông báo khi khởi động menu
Rayfield:Notify({
   Name = "BTGAOnyx Hub",
   Content = "Vui lòng nhập đúng mã BTGAOnyx11 để tiếp tục!",
   Duration = 5,
   Image = 4483362458,
})
