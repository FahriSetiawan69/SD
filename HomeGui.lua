-- [[ FahriRoundopHUB - SD (Sniper Duels) Official Home UI ]] --
local CoreGui = game:GetService("CoreGui")
local BaseURL = "https://raw.githubusercontent.com/FahriSetiawan69/SD/main/"

-- 1. ANTI-DUPLICATE
if CoreGui:FindFirstChild("FR_SD_MobileToggle") then CoreGui.FR_SD_MobileToggle:Destroy() end
if CoreGui:FindFirstChild("Fluent") then CoreGui.Fluent:Destroy() end

-- Load UI Library
_G.Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- 2. WINDOW SETUP
local Window = _G.Fluent:CreateWindow({
    Title = "FahriRoundopHUB",
    SubTitle = "Sniper Duels Edition",
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
ToggleButton.Image = "rbxassetid://4483345998"
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

-- 5. FEATURES IMPLEMENTATION (Modular)

-- --- TOGGLE: ESP ---
Tabs.Main:AddToggle("SD_ESP", {
    Title = "Player ESP", 
    Default = false,
    Description = "Enemy: Merah | Team: Hijau (Subtle Outline)"
}):OnChanged(function(v)
    _G.ESP_Enabled = v
    if v and not _G.ESP_Loaded then
        local success, err = pcall(function()
            loadstring(game:HttpGet(BaseURL .. "Features/ESP.lua"))()
        end)
        if success then _G.ESP_Loaded = true else warn("ESP Error: " .. err) end
    end
end)

-- --- TOGGLE: AIM BOT ---
Tabs.Main:AddToggle("SD_AimBot", {
    Title = "Silent Aim / Aim Bot", 
    Default = false,
    Description = "Otomatis Lock Target ke musuh terdekat."
}):OnChanged(function(v)
    _G.Aimbot_Enabled = v
    if v and not _G.Aimbot_Loaded then
        pcall(function()
            loadstring(game:HttpGet(BaseURL .. "Features/Aimbot.lua"))()
            _G.Aimbot_Loaded = true
        end)
    end
end)

-- --- TOGGLE: AUTO RELOAD ---
Tabs.Main:AddToggle("SD_AutoReload", {
    Title = "Auto Reload", 
    Default = false,
    Description = "Isi peluru otomatis tanpa delay manual."
}):OnChanged(function(v)
    _G.AutoReload_Enabled = v
    if v and not _G.AutoReload_Loaded then
        pcall(function()
            loadstring(game:HttpGet(BaseURL .. "Features/AutoReload.lua"))()
            _G.AutoReload_Loaded = true
        end)
    end
end)

-- --- TOGGLE: AUTO RUN ---
Tabs.Main:AddToggle("SD_AutoRun", {
    Title = "Auto Run / Speed", 
    Default = false,
    Description = "Lari lebih cepat secara konstan."
}):OnChanged(function(v)
    _G.AutoRun_Enabled = v
    if v and not _G.AutoRun_Loaded then
        pcall(function()
            loadstring(game:HttpGet(BaseURL .. "Features/AutoRun.lua"))()
            _G.AutoRun_Loaded = true
        end)
    end
end)

-- 6. CLEANUP & NOTIFICATION
CoreGui.ChildRemoved:Connect(function(child)
    if child.Name == "Fluent" then
        ScreenGui:Destroy()
        _G.ESP_Enabled = false
        _G.Aimbot_Enabled = false
        _G.AutoReload_Enabled = false
        _G.AutoRun_Enabled = false
    end
end)

_G.Fluent:Notify({
    Title = "FahriRoundopHUB",
    Content = "Sniper Duels Hub Ready!",
    Duration = 5
})

Window:SelectTab(1)
