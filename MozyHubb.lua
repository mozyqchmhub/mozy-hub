-- MOZY HUB v2.0 | DARK EDITION
-- Mobile UI | Navigation Hub

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local old = PlayerGui:FindFirstChild("MOZY_HUB")
if old then old:Destroy() end

local C = {
    bg = Color3.fromRGB(20, 13, 13),
    panel = Color3.fromRGB(39, 30, 30),
    panel2 = Color3.fromRGB(52, 42, 42),
    text = Color3.fromRGB(245, 242, 242),
    muted = Color3.fromRGB(172, 163, 163),
    accent = Color3.fromRGB(48, 164, 255),
    green = Color3.fromRGB(20, 235, 40),
}

local gui = Instance.new("ScreenGui")
gui.Name = "MOZY_HUB"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = PlayerGui

local function corner(obj, radius)
    local u = Instance.new("UICorner")
    u.CornerRadius = UDim.new(0, radius or 14)
    u.Parent = obj
    return u
end

local function stroke(obj, color, thickness, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color or C.panel2
    s.Thickness = thickness or 1
    s.Transparency = transparency or 0
    s.Parent = obj
    return s
end

local function make(class, props, parent)
    local obj = Instance.new(class)
    for k, v in pairs(props or {}) do obj[k] = v end
    obj.Parent = parent
    return obj
end

local function label(parent, text, size, pos, dims, color, bold)
    return make("TextLabel", {
        BackgroundTransparency = 1, Text = text, TextSize = size or 14,
        Position = pos or UDim2.new(), Size = dims or UDim2.new(1,0,0,24),
        Font = bold and Enum.Font.GothamBold or Enum.Font.Gotham,
        TextColor3 = color or C.text, TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
    }, parent)
end

local function button(parent, text, pos, dims)
    local b = make("TextButton", {
        Text = text, TextSize = 14, Font = Enum.Font.GothamMedium,
        TextColor3 = C.text, BackgroundColor3 = C.panel2,
        BackgroundTransparency = 0.08, Position = pos, Size = dims,
        AutoButtonColor = true,
    }, parent)
    corner(b, 12)
    return b
end

local shell = make("Frame", {
    Name = "Window", AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.51, 0), Size = UDim2.new(0.88, 0, 0.57, 0),
    BackgroundColor3 = C.bg, BackgroundTransparency = 0.12,
    BorderSizePixel = 0, ClipsDescendants = true,
}, gui)
corner(shell, 24)
stroke(shell, Color3.fromRGB(90, 70, 70), 1, 0.25)
make("UISizeConstraint", {MinSize = Vector2.new(310, 350), MaxSize = Vector2.new(760, 650)}, shell)

local top = make("Frame", {
    Size = UDim2.new(1,0,0,56), BackgroundTransparency = 1,
}, shell)

local brand = label(top, "◆  MOZY HUB", 17, UDim2.new(0,16,0,4), UDim2.new(0.42,0,0,25), C.text, true)
label(top, "Universal UI  •  Mobile", 10, UDim2.new(0,18,0,29), UDim2.new(0.45,0,0,18), C.muted, false)

local status = make("TextLabel", {
    Text = "READY", TextSize = 11, Font = Enum.Font.GothamBold,
    TextColor3 = Color3.new(0,0,0), BackgroundColor3 = C.green,
    Position = UDim2.new(0.55,0,0,14), Size = UDim2.new(0,62,0,27),
}, top)
corner(status, 15)

local minBtn = button(top, "—", UDim2.new(1,-82,0,11), UDim2.new(0,30,0,32))
local closeBtn = button(top, "×", UDim2.new(1,-43,0,11), UDim2.new(0,30,0,32))
minBtn.TextSize = 20
closeBtn.TextSize = 22

local body = make("Frame", {
    Position = UDim2.new(0,10,0,58), Size = UDim2.new(1,-20,1,-68),
    BackgroundTransparency = 1,
}, shell)

local side = make("Frame", {
    Size = UDim2.new(0.34,0,1,0), BackgroundColor3 = Color3.fromRGB(27,20,20),
    BackgroundTransparency = 0.15, BorderSizePixel = 0,
}, body)
corner(side, 17)

local search = make("TextBox", {
    PlaceholderText = "⌕  Search", Text = "", ClearTextOnFocus = false,
    Font = Enum.Font.Gotham, TextSize = 14, TextColor3 = C.text,
    PlaceholderColor3 = C.muted, BackgroundColor3 = C.panel2,
    BackgroundTransparency = 0.05, Position = UDim2.new(0,8,0,8),
    Size = UDim2.new(1,-16,0,40), TextXAlignment = Enum.TextXAlignment.Left,
}, side)
corner(search, 12)
make("UIPadding", {PaddingLeft = UDim.new(0,12)}, search)

local navScroll = make("ScrollingFrame", {
    Position = UDim2.new(0,6,0,57), Size = UDim2.new(1,-12,1,-108),
    BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 2,
    CanvasSize = UDim2.new(0,0,0,0), AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, side)
make("UIListLayout", {Padding = UDim.new(0,5), SortOrder = Enum.SortOrder.LayoutOrder}, navScroll)
make("UIPadding", {PaddingBottom = UDim.new(0,6)}, navScroll)

local profile = make("Frame", {
    AnchorPoint = Vector2.new(0,1), Position = UDim2.new(0,7,1,-7),
    Size = UDim2.new(1,-14,0,43), BackgroundTransparency = 1,
}, side)
label(profile, string.sub(LocalPlayer.Name,1,18), 13, UDim2.new(0,5,0,1), UDim2.new(1,-8,0,18), C.text, true)
label(profile, "@" .. LocalPlayer.DisplayName, 11, UDim2.new(0,5,0,20), UDim2.new(1,-8,0,18), C.muted, false)

local content = make("ScrollingFrame", {
    Position = UDim2.new(0.34,8,0,0), Size = UDim2.new(0.66,-8,1,0),
    BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 3,
    CanvasSize = UDim2.new(0,0,0,0), AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, body)
make("UIListLayout", {Padding = UDim.new(0,9), SortOrder = Enum.SortOrder.LayoutOrder}, content)
make("UIPadding", {PaddingTop = UDim.new(0,4), PaddingBottom = UDim.new(0,10), PaddingLeft = UDim.new(0,3), PaddingRight = UDim.new(0,3)}, content)

local pages = {}
local navButtons = {}
local currentPage = "Info"

local function clearContent()
    for _, child in ipairs(content:GetChildren()) do
        if not child:IsA("UIListLayout") and not child:IsA("UIPadding") then child:Destroy() end
    end
end

local function card(title, subtitle)
    local f = make("Frame", {
        Size = UDim2.new(1,0,0,78), BackgroundColor3 = C.panel,
        BackgroundTransparency = 0.08, BorderSizePixel = 0,
    }, content)
    corner(f, 16)
    label(f, title, 15, UDim2.new(0,14,0,10), UDim2.new(1,-28,0,23), C.text, true)
    if subtitle then label(f, subtitle, 12, UDim2.new(0,14,0,36), UDim2.new(1,-28,0,34), C.muted, false) end
    return f
end

local function actionCard(title, desc, actionText, callback)
    local f = card(title, desc)
    local b = button(f, actionText or "Run", UDim2.new(1,-84,0,22), UDim2.new(0,70,0,34))
    b.TextSize = 12
    b.MouseButton1Click:Connect(callback or function() end)
    return f
end

local function showPage(name)
    currentPage = name
    clearContent()
    for n, b in pairs(navButtons) do
        b.BackgroundColor3 = n == name and Color3.fromRGB(68,54,54) or C.panel
    end

    if name == "Info" then
        card("MOZY HUB | Welcome", "Mobile-friendly interface • UI build")
        card("Local Status", "Hub loaded successfully. Controls below affect this UI or local demo only.")
        actionCard("Refresh Status", "Update the status label.", "Refresh", function()
            status.Text = "READY"
            status.BackgroundColor3 = C.green
        end)
        actionCard("Copy Player Name", "Show your current username in the UI.", "Show", function()
            status.Text = string.sub(LocalPlayer.Name,1,8)
        end)
        card("Developer Information", "MOZY HUB • Community UI")
    elseif name == "User Info" then
        card("Player Information", "Details for your local player.")
        card("Username", LocalPlayer.Name)
        card("Display Name", LocalPlayer.DisplayName)
        card("User ID", tostring(LocalPlayer.UserId))
        card("Account Age", tostring(LocalPlayer.AccountAge) .. " days")
    elseif name == "Main" then
        card("Main Features", "Safe local interface controls.")
        actionCard("Toggle Hub Accent", "Change the hub highlight color.", "Toggle", function()
            C.accent = C.accent == Color3.fromRGB(48,164,255) and Color3.fromRGB(180,90,255) or Color3.fromRGB(48,164,255)
            for _, b in pairs(navButtons) do
                if b.Text == currentPage then b.BackgroundColor3 = C.accent end
            end
            status.BackgroundColor3 = C.accent
        end)
        actionCard("Reset UI", "Restore the status indicator.", "Reset", function()
            status.Text = "READY"; status.BackgroundColor3 = C.green
        end)
        actionCard("Fake Donate (Preview)", "Local visual demo only; no Robux or real donation is sent.", "Preview", function()
            status.Text = "DEMO ONLY"
            status.BackgroundColor3 = Color3.fromRGB(255,190,55)
        end)
    elseif name == "Player" then
        card("Player", "Local character information and safe settings.")
        actionCard("Refresh Character", "Check whether your character is loaded.", "Check", function()
            status.Text = LocalPlayer.Character and "CHAR OK" or "NO CHAR"
        end)
        actionCard("Respawn Info", "Refreshes the displayed character status only.", "Refresh", function()
            status.Text = LocalPlayer.Character and "CHAR OK" or "NO CHAR"
        end)
        card("Note", "Movement or avatar changes should be implemented in your own Roblox experience.")
    elseif name == "Custom Jump" then
        card("Custom Jump", "Demo settings panel; no exploit or server bypass.")
        local valueLabel = label(content, "Jump setting: 50 (preview only)", 13, UDim2.new(), UDim2.new(1,0,0,25), C.text, true)
        local row = make("Frame", {Size = UDim2.new(1,0,0,44), BackgroundTransparency = 1}, content)
        local minus = button(row, "−", UDim2.new(0,0,0,2), UDim2.new(0.3,-4,0,38))
        local plus = button(row, "+", UDim2.new(0.34,0,0,2), UDim2.new(0.3,-4,0,38))
        local reset = button(row, "Reset", UDim2.new(0.68,0,0,2), UDim2.new(0.32,0,0,38))
        local val = 50
        local function update() valueLabel.Text = "Jump setting: " .. val .. " (preview only)" end
        minus.MouseButton1Click:Connect(function() val = math.max(0,val-5); update() end)
        plus.MouseButton1Click:Connect(function() val = math.min(200,val+5); update() end)
        reset.MouseButton1Click:Connect(function() val = 50; update() end)
    elseif name == "Fake Donate" then
        card("Fake Donate", "Local-only preview. This does not create a real donation.")
        actionCard("Preview Donation Banner", "Display a demo status indicator.", "Preview", function()
            status.Text = "DEMO ONLY"
            status.BackgroundColor3 = Color3.fromRGB(255,190,55)
        end)
    elseif name == "Copy Avatar" then
        card("Copy Avatar", "Avatar copying from other players is not enabled here.")
        actionCard("View My Avatar Info", "Display your own avatar username.", "View", function()
            status.Text = string.sub(LocalPlayer.DisplayName,1,8)
        end)
    elseif name == "Cosmetics" then
        card("Cosmetics", "Accessory UI placeholder for your own Roblox experience.")
        actionCard("Accessory Menu", "Connect this to approved avatar assets in your own game.", "Open", function()
            status.Text = "COSMETIC"
        end)
    elseif name == "Settings" then
        card("Settings", "Customize this interface.")
        actionCard("Toggle Transparency", "Switch the panel transparency.", "Toggle", function()
            shell.BackgroundTransparency = shell.BackgroundTransparency > 0.1 and 0.02 or 0.12
        end)
        actionCard("Reset Window", "Restore the default size.", "Reset", function()
            shell.Size = UDim2.new(0.88,0,0.57,0)
        end)
    end
end

local navNames = {"Info", "User Info", "Main", "Player", "Custom Jump", "Fake Donate", "Copy Avatar", "Cosmetics", "Settings"}
for i, name in ipairs(navNames) do
    local b = button(navScroll, "  " .. name, UDim2.new(), UDim2.new(1,0,0,39))
    b.LayoutOrder = i
    b.TextXAlignment = Enum.TextXAlignment.Left
    b.BackgroundColor3 = C.panel
    navButtons[name] = b
    b.MouseButton1Click:Connect(function() showPage(name) end)
end

search:GetPropertyChangedSignal("Text"):Connect(function()
    local q = string.lower(search.Text)
    for name, b in pairs(navButtons) do
        b.Visible = q == "" or string.find(string.lower(name), q, 1, true) ~= nil
    end
end)

local minimized = false
minBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    body.Visible = not minimized
    shell.Size = minimized and UDim2.new(0.88,0,0,56) or UDim2.new(0.88,0,0.57,0)
    minBtn.Text = minimized and "+" or "—"
end)
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

-- Drag window using the top bar (mouse or touch).
local dragging, dragStart, startPos
top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = shell.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        shell.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Reopen button after minimizing/closing is intentionally not persisted.
showPage("Info")
