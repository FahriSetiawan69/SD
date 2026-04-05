-- [[ FahriRoundopHUB - SD (Sniper Duels) Official Home UI ]] --
local CoreGui = game:GetService("CoreGui")
local BaseURL = "https://raw.githubusercontent.com/FahriSetiawan69/SD/main/"

-- 1. ANTI-DUPLICATE (Pembersihan agar tidak double menu)
if CoreGui:FindFirstChild("FR_SD_MobileToggle") then CoreGui.FR_SD_MobileToggle:Destroy() end
if CoreGui:FindFirstChild("Fluent") then CoreGui.Fluent:Destroy() end

-- Menggunakan Global variable agar bisa diakses oleh module di folder Features
_G.Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- 2. WINDOW SETUP
local Window = _G.Fluent:CreateWindow({
    Title = "FahriRoundopHUB",
    SubTitle = "Sniper Duels - Edition",
    TabWidth = 160, 
    Size = UDim2.fromOffset(450, 320),
    Acrylic = true, 
    Theme = "Dark", 
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- 3. MOBILE TOGGLE SYNC
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "FR_SD_MobileToggle"
ScreenGui.Enabled = false
local ToggleButton = Instance.new("ImageButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 48, 0, 48)
ToggleButton.Position = UDim2.new(0.02, 0, 0.45, 0)
ToggleButton.Image = "rbxassetid://4483345998" -- Icon hiasan
ToggleButton.Draggable = true
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0, 12)

local OriginalMinimize = Window.Minimize
Window.Minimize = function(self)
    OriginalMinimize(self)
    ScreenGui.Enabled = Window.Minimized 
end
ToggleButton.MouseButton1Click:Connect(function() Window:Minimize() end)

-- 4. TABS SETUP
local Tabs = {
    Main = Window:AddTab({ Title = "Combat & Visual", Icon = "crosshair" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

-- 5. FEATURES IMPLEMENTATION (Empty Logic)

-- --- TOGGLE: ESP ---
Tabs.Main:AddToggle("SD_ESP", {
    Title = "Player ESP", 
    Default = false,
    Description = "Melihat posisi musuh menembus dinding."
}):OnChanged(function(v)
    _G.ESP_Enabled = v
    -- Logika ESP akan diletakkan di sini
end)

-- --- TOGGLE: AIM BOT ---
Tabs.Main:AddToggle("SD_AimBot", {
    Title = "Silent Aim / Aim Bot", 
    Default = false,
    Description = "Otomatis mengarahkan tembakan ke kepala musuh."
}):OnChanged(function(v)
    _G.Aimbot_Enabled = v
    -- Logika Aim Bot akan diletakkan di sini
end)

-- --- TOGGLE: AUTO RELOAD ---
Tabs.Main:AddToggle("SD_AutoReload", {
    Title = "Auto Reload", 
    Default = false,
    Description = "Otomatis mengisi peluru saat habis."
}):OnChanged(function(v)
    _G.AutoReload_Enabled = v
    -- Logika Auto Reload akan diletakkan di sini
end)

-- --- TOGGLE: AUTO RUN ---
Tabs.Main:AddToggle("SD_AutoRun", {
    Title = "Auto Run / Speed", 
    Default = false,
    Description = "Lari lebih cepat secara otomatis."
}):OnChanged(function(v)
    _G.AutoRun_Enabled = v
    -- Logika Auto Run akan diletakkan di sini
end)

-- 6. CLEANUP (Saat GUI di-close)
CoreGui.ChildRemoved:Connect(function(child)
    if child.Name == "Fluent" then
        ScreenGui:Destroy()
        _G.ESP_Enabled = nil
        _G.Aimbot_Enabled = nil
        _G.AutoReload_Enabled = nil
        _G.AutoRun_Enabled = nil
        _G.Fluent = nil
    end
end)

-- Notifikasi Awal
_G.Fluent:Notify({
    Title = "SD Hub Loaded!",
    Content = "Sniper Duels Edition siap digunakan.",
    Duration = 5
})

Window:SelectTab(1)

