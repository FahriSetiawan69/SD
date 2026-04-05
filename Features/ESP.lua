-- [[ FahriRoundopHUB - SD ESP Module ]] --
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local ESP_Folder = Instance.new("Folder", game.CoreGui)
ESP_Folder.Name = "SD_ESP_Storage"

-- Fungsi untuk membuat/update Highlight
local function ApplyESP(player)
    if player == LocalPlayer then return end

    local function CreateHighlight(character)
        -- Hapus highlight lama jika ada
        if character:FindFirstChild("SD_Highlight") then
            character.SD_Highlight:Destroy()
        end

        local Highlight = Instance.new("Highlight")
        Highlight.Name = "SD_Highlight"
        Highlight.Parent = character
        
        -- Pengaturan Visual agar tidak mengganggu (Subtle Outline)
        Highlight.FillTransparency = 0.75 -- Sangat transparan di bagian dalam
        Highlight.OutlineTransparency = 0.1 -- Outline jelas tapi halus
        Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop -- Tembus tembok

        -- Logika Warna: Musuh Merah, Teman Hijau
        if player.Team == LocalPlayer.Team then
            Highlight.FillColor = Color3.fromRGB(0, 255, 0)    -- Hijau
            Highlight.OutlineColor = Color3.fromRGB(0, 255, 0) -- Hijau
        else
            Highlight.FillColor = Color3.fromRGB(255, 0, 0)    -- Merah
            Highlight.OutlineColor = Color3.fromRGB(255, 0, 0) -- Merah
        end

        -- Update warna jika pindah team
        player:GetPropertyChangedSignal("Team"):Connect(function()
            if player.Team == LocalPlayer.Team then
                Highlight.FillColor = Color3.fromRGB(0, 255, 0)
                Highlight.OutlineColor = Color3.fromRGB(0, 255, 0)
            else
                Highlight.FillColor = Color3.fromRGB(255, 0, 0)
                Highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
            end
        end)
    end

    -- Jalankan saat karakter muncul
    if player.Character then CreateHighlight(player.Character) end
    player.CharacterAdded:Connect(CreateHighlight)
end

-- Main Loop
RunService.RenderStepped:Connect(function()
    if _G.ESP_Enabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                if not player.Character:FindFirstChild("SD_Highlight") then
                    ApplyESP(player)
                else
                    -- Pastikan tetap terlihat saat ON
                    player.Character.SD_Highlight.Enabled = true
                end
            end
        end
    else
        -- Sembunyikan semua jika OFF
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("SD_Highlight") then
                player.Character.SD_Highlight.Enabled = false
            end
        end
    end
end)

