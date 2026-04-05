-- [[ FahriRoundopHUB - SD Aimbot Module (Adjustable & Auto-Aim) ]] --
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Default Value jika slider belum digeser
_G.Aimbot_FOV = _G.Aimbot_FOV or 150
local AimPart = "Head"

-- Visual FOV Circle
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1
FOVCircle.NumSides = 60
FOVCircle.Filled = false
FOVCircle.Transparency = 0.5
FOVCircle.Color = Color3.fromRGB(255, 255, 255)

local function GetClosestPlayer()
    local ClosestPlayer = nil
    local ShortestDistance = math.huge
    local MousePos = UserInputService:GetMouseLocation()

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Team ~= LocalPlayer.Team and player.Character and player.Character:FindFirstChild(AimPart) then
            local Pos, OnScreen = Camera:WorldToViewportPoint(player.Character[AimPart].Position)
            
            if OnScreen then
                local Distance = (Vector2.new(Pos.X, Pos.Y) - MousePos).Magnitude
                
                -- Menggunakan _G.Aimbot_FOV yang dinamis dari Slider
                if Distance < ShortestDistance and Distance < _G.Aimbot_FOV then
                    ClosestPlayer = player
                    ShortestDistance = Distance
                end
            end
        end
    end
    return ClosestPlayer
end

RunService.RenderStepped:Connect(function()
    -- Update Lingkaran FOV (Posisi & Ukuran)
    FOVCircle.Visible = _G.Aimbot_Enabled
    FOVCircle.Position = UserInputService:GetMouseLocation()
    FOVCircle.Radius = _G.Aimbot_FOV

    if _G.Aimbot_Enabled then
        -- SEKARANG AKTIF TANPA PERLU KLIK KANAN (Langsung Lock)
        local Target = GetClosestPlayer()
        if Target and Target.Character and Target.Character:FindFirstChild(AimPart) then
            local TargetPos = Target.Character[AimPart].Position
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, TargetPos)
        end
    end
end)
