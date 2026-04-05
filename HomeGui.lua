-- [[ FahriRoundopHUB - SD (Sniper Duels) Official Home UI ]] --
local CoreGui = game:GetService("CoreGui")
local BaseURL = "https://raw.githubusercontent.com/FahriSetiawan69/SD/main/"

-- 1. ANTI-DUPLICATE
if CoreGui:FindFirstChild("FR_SD_MobileToggle") then CoreGui.FR_SD_MobileToggle:Destroy() end
if CoreGui:FindFirstChild("Fluent") then CoreGui.Fluent:Destroy() end

-- Load UI Library (Fluent)
_G.Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- 2. WINDOW SETUP
local Window = _G.Fluent:CreateWindow({
    Title = "FahriRoundopHUB",
    SubTitle = "Sniper Duels Edition",
    TabWidth = 160, 
    Size = UDim2.fromOffset(450, 360), -- Ukuran sedikit lebih tinggi untuk Slider
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

-- --- SECTION: VISUAL ---
Tabs.Main:AddParagraph({
    Title = "Visuals",
    Content = "Enemy: Merah | Team: Hijau"
})

Tabs.Main:AddToggle("SD_ESP", {
    Title = "Player ESP", 
    Default = false,
    Description = "Melihat musuh menembus dinding."
}):OnChanged(function(v)
    _G.ESP_Enabled = v
    if v and not _G.ESP_Loaded then
        pcall(function()
            loadstring(game:HttpGet(BaseURL .. "Features/ESP.lua"))()
            _G.ESP_Loaded = true
        end)
    end
end)

-- --- SECTION: COMBAT ---
Tabs.Main:AddParagraph({
    Title = "Combat",
    Content = "Fitur otomatis untuk memenangkan duel."
})

Tabs.Main:AddToggle("SD_AimBot", {
    Title = "Auto-Lock Aimbot", 
    Default = false,
    Description = "Otomatis lock target (Tanpa Scope)."
}):OnChanged(function(v)
    _G.Aimbot_Enabled = v
    if v and not _G.Aimbot_Loaded then
        pcall(function()
            loadstring(game:HttpGet(BaseURL .. "Features/Aimbot.lua"))()
            _G.Aimbot_Loaded = true
        end)
    end
end)

-- --- SLIDER: ADJUST FOV ---
Tabs.Main:AddSlider("SD_FOV_Slider", {
    Title = "Aimbot FOV Size",
    Description = "Atur lebar lingkaran target Aimbot.",
    Default = 150,
    Min = 50,
    Max = 800,
    Rounding = 0,
    Callback = function(Value)
        _G.Aimbot_FOV = Value
    end
})

Tabs.Main:AddToggle("SD_AutoReload", {
    Title = "Auto Reload", 
    Default = false,
    Description = "Otomatis isi peluru."
}):OnChanged(function(v)
    _G.AutoReload_Enabled = v
    if v and not _G.AutoReload_Loaded then
        pcall(function()
            loadstring(game:HttpGet(BaseURL .. "Features/AutoReload.lua"))()
            _G.AutoReload_Loaded = true
        end)
    end
end)

Tabs.Main:AddToggle("SD_AutoRun", {
    Title = "Auto Run / Speed", 
    Default = false,
    Description = "Lari lebih cepat secara otomatis."
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
        -- Reset all states
        _G.ESP_Enabled = false
        _G.Aimbot_Enabled = false
        _G.AutoReload_Enabled = false
        _G.AutoRun_Enabled = false
        _G.Fluent = nil
    end
end)

_G.Fluent:Notify({
    Title = "FahriRoundopHUB",
    Content = "Sniper Duels Edition Loaded!",
    Duration = 5
})

Window:SelectTab(1)
