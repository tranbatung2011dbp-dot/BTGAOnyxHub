
--========================================================
-- BLOX FRUITS ADVANCED FRAMEWORK - DARK PRO
-- VERSION: 3.2.0
-- PLATFORM: ROBLOX STUDIO
-- FOCUS: STABILITY / QUEST / COMBAT / GUI
--========================================================

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--========================================================
-- CONFIGURATION
--========================================================

local Config = {
    AutoQuestTracker = true,
    SafeCombat = true,
    MobScanner = true,
    FullBright = false,
    InfiniteZoom = false,

    MaxZoom = 10000,
    Brightness = 2,
    ClockTime = 14,

    MobDistance = 300,
    UpdateInterval = 1,
    MobScanInterval = 2,
    MaxLogs = 50,

    Stats = {
        Target = "Melee",
        Enabled = false
    }
}

--========================================================
-- STATE
--========================================================

local State = {
    Running = true,
    Character = nil,
    Humanoid = nil,
    Root = nil,

    Level = 1,
    Health = 0,
    MaxHealth = 0,

    CurrentQuest = nil,
    NearbyMobs = 0,
    CombatStatus = "INITIALIZING",

    Connections = {},
    Logs = {}
}

--========================================================
-- ORIGINAL SETTINGS
--========================================================

local OriginalLighting = {
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime,
    GlobalShadows = Lighting.GlobalShadows
}

local OriginalZoom = Player.CameraMaxZoomDistance

--========================================================
-- LOGGER
--========================================================

local function Log(message, category)
    category = category or "INFO"

    local entry = {
        Time = os.date("%H:%M:%S"),
        Category = category,
        Message = tostring(message)
    }

    table.insert(State.Logs, entry)

    if #State.Logs > Config.MaxLogs then
        table.remove(State.Logs, 1)
    end

    print("[DARK PRO][" .. category .. "] " .. tostring(message))
end

local function SafeCall(name, callback)
    local success, result = pcall(callback)

    if not success then
        Log(name .. ": " .. tostring(result), "ERROR")
        return false
    end

    return true, result
end

local function AddConnection(connection)
    table.insert(State.Connections, connection)
    return connection
end

--========================================================
-- CHARACTER MANAGER
--========================================================

local CharacterManager = {}

function CharacterManager.Update(character)
    character = character or Player.Character

    if not character then
        return false
    end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local root = character:FindFirstChild("HumanoidRootPart")

    if not humanoid or not root or humanoid.Health <= 0 then
        return false
    end

    State.Character = character
    State.Humanoid = humanoid
    State.Root = root

    return true
end

AddConnection(Player.CharacterAdded:Connect(function(character)
    task.spawn(function()
        local humanoid = character:WaitForChild("Humanoid", 10)
        local root = character:WaitForChild("HumanoidRootPart", 10)

        if State.Running and humanoid and root then
            CharacterManager.Update(character)
            Log("Character initialized")
        end
    end)
end))

AddConnection(Player.CharacterRemoving:Connect(function()
    State.Character = nil
    State.Humanoid = nil
    State.Root = nil
    State.Health = 0
    State.MaxHealth = 0
    State.CombatStatus = "RESPAWNING"
end))

CharacterManager.Update()

--========================================================
--
