-- [[ FahriRoundopHUB - SD (SNIPER DUELS) EDITION ]] --
-- URL di bawah ini sudah diarahkan ke repository SD (Sniper Duels) milikmu
local BaseURL = "https://raw.githubusercontent.com/FahriSetiawan69/SD/main/"
local StarterGui = game:GetService("StarterGui")

-- 1. Pop-up Notifikasi Loading
StarterGui:SetCore("SendNotification", {
    Title = "FahriRoundopHUB",
    Text = "SD Hub (Sniper Duels) Loading...",
    Icon = "rbxassetid://4483362458", -- Ikon Crosshair/Target
    Duration = 5
})

-- 2. Logika Pemanggilan HomeGui
local function StartHub()
    -- Mengambil HomeGui.lua dari repo SD
    local targetURL = BaseURL .. "HomeGui.lua"
    
    local success, content = pcall(function()
        return game:HttpGet(targetURL)
    end)

    if success and content then
        local func, err = loadstring(content)
        if func then
            print("[FR-HUB] SD HomeGui Terdeteksi! Menjalankan...")
            func()
        else
            warn("[FR-HUB] Error Compile: " .. tostring(err))
            StarterGui:SetCore("SendNotification", {
                Title = "Compile Error!",
                Text = "Ada kesalahan penulisan di HomeGui.lua",
                Duration = 5
            })
        end
    else
        -- Muncul jika file tidak ada di GitHub atau koneksi bermasalah
        warn("[FR-HUB] HTTP 404: File tidak ditemukan di " .. targetURL)
        StarterGui:SetCore("SendNotification", {
            Title = "Fetch Error!",
            Text = "Gagal memuat file SD dari GitHub.",
            Duration = 8
        })
    end
end

-- Menjalankan fungsi di thread terpisah agar tidak mengganggu proses lain
task.spawn(StartHub)

