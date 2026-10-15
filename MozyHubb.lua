-- MOZY HUB v2.0 | DARK EDITION
-- Mobile UI | Navigation Hub

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local ACCESSORY_IDS = {74891470, 10159610478, 10159600649, 141742418}
local enabled = false
local addedAccessories = {}

local function removeAddedAccessories()
    for _, accessory in ipairs(addedAccessories) do
        if accessory and accessory.Parent then accessory:Destroy() end
    end
    table.clear(addedAccessories)
end

local function equipAccessory(assetId)
    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    local ok, asset = pcall(function()
        return game:GetObjects("rbxassetid://" .. tostring(assetId))[1]
    end)
    if not ok or not asset then
        warn("MOZY HUB: couldn't load accessory asset", assetId)
        return
    end

    local accessory = asset:IsA("Accessory") and asset or asset:FindFirstChildWhichIsA("Accessory", true)
    if not accessory then
        asset:Destroy()
        warn("MOZY HUB: asset is not an Accessory", assetId)
        return
    end
    if accessory ~= asset then
        accessory.Parent = nil
        asset:Destroy()
    end

    local added = pcall(function() humanoid:AddAccessory(accessory) end)
    if added and accessory.Parent then
        table.insert(addedAccessories, accessory)
    else
        accessory:Destroy()
        warn("MOZY HUB: couldn't attach accessory", assetId)
    end
end

local function setEnabled(on)
    if enabled == on then return end
    enabled = on
    if on then
        for _, id in ipairs(ACCESSORY_IDS) do equipAccessory(id) end
    else
        removeAddedAccessories()
    end
end

local gui = Instance.new("ScreenGui")
gui.Name = "MOZY_AccessoriesToggle"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local panel = Instance.new("Frame")
panel.Size = UDim2.fromOffset(260, 116)
panel.Position = UDim2.new(0.5, -130, 0.72, -58)
panel.BackgroundColor3 = Color3.fromRGB(28, 22, 22)
panel.BackgroundTransparency = 0.08
panel.BorderSizePixel = 0
panel.Parent = gui
Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 16)

local outline = Instance.new("UIStroke")
outline.Color = Color3.fromRGB(92, 72, 72)
outline.Transparency = 0.15
outline.Parent = panel

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(14, 9)
title.Size = UDim2.new(1, -28, 0, 24)
title.Font = Enum.Font.GothamBold
title.Text = "MOZY HUB • ACCESSORIES"
title.TextColor3 = Color3.fromRGB(245, 240, 240)
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = panel

local toggle = Instance.new("TextButton")
toggle.Position = UDim2.fromOffset(14, 42)
toggle.Size = UDim2.new(1, -28, 0, 42)
toggle.BackgroundColor3 = Color3.fromRGB(135, 55, 55)
toggle.BorderSizePixel = 0
toggle.Font = Enum.Font.GothamBold
toggle.Text = "ACCESSORIES: OFF"
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.TextSize = 14
toggle.Parent = panel
Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 12)

local function refreshButton()
    toggle.Text = enabled and "ACCESSORIES: ON" or "ACCESSORIES: OFF"
    toggle.BackgroundColor3 = enabled
        and Color3.fromRGB(28, 150, 70)
        or Color3.fromRGB(135, 55, 55)
end

toggle.Activated:Connect(function()
    setEnabled(not enabled)
    refreshButton()
end)

player.CharacterAdded:Connect(function()
    table.clear(addedAccessories)
    task.wait(1)
    if enabled then
        enabled = false
        setEnabled(true)
        refreshButton()
    end
end)

refreshButton()
