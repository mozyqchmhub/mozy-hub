-- MOZY HUB v1.1 | GALAXY EDITION
-- GUI INTERAKTIF

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("MozyHub")
if old then old:Destroy() end

local purple = Color3.fromRGB(175, 70, 255)
local blue = Color3.fromRGB(50, 125, 255)
local dark = Color3.fromRGB(14, 10, 30)
local white = Color3.fromRGB(245, 240, 255)

local gui = Instance.new("ScreenGui")
gui.Name = "MozyHub"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999
gui.Parent = playerGui

local function make(class, props, parent)
    local obj = Instance.new(class)
    for k, v in pairs(props) do
        obj[k] = v
    end
    obj.Parent = parent
    return obj
end

local function corner(obj, radius)
    make("UICorner", {
        CornerRadius = UDim.new(0, radius)
    }, obj)
end

local function stroke(obj, color, thickness)
    make("UIStroke", {
        Color = color,
        Thickness = thickness,
        Transparency = 0.15
    }, obj)
end

local function tween(obj, props)
    TweenService:Create(
        obj,
        TweenInfo.new(0.22, Enum.EasingStyle.Quad),
        props
    ):Play()
end

-- Launcher
local launcher = make("TextButton", {
    Name = "Launcher",
    Size = UDim2.fromOffset(58, 58),
    Position = UDim2.new(0, 14, 0.5, -29),
    BackgroundColor3 = dark,
    Text = "M",
    TextColor3 = white,
    TextSize = 29,
    Font = Enum.Font.GothamBlack,
    AutoButtonColor = true
}, gui)

corner(launcher, 50)
stroke(launcher, purple, 2)

-- Main panel
local panel = make("Frame", {
    Name = "MainPanel",
    Size = UDim2.new(0.88, 0, 0.72, 0),
    Position = UDim2.new(0.06, 0, 0.14, 0),
    BackgroundColor3 = dark,
    BorderSizePixel = 0,
    ClipsDescendants = true
}, gui)

make("UISizeConstraint", {
    MinSize = Vector2.new(270, 300),
    MaxSize = Vector2.new(520, 650)
}, panel)

corner(panel, 18)
stroke(panel, purple, 2)

make("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 10, 55)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 20, 48))
    }),
    Rotation = 35
}, panel)

-- Header
local header = make("TextLabel", {
    Size = UDim2.new(1, -100, 0, 48),
    Position = UDim2.fromOffset(14, 8),
    BackgroundTransparency = 1,
    Text = "MOZY HUB",
    TextColor3 = white,
    TextSize = 25,
    Font = Enum.Font.GothamBlack,
    TextXAlignment = Enum.TextXAlignment.Left
}, panel)

local subtitle = make("TextLabel", {
    Size = UDim2.new(1, -28, 0, 22),
    Position = UDim2.fromOffset(14, 49),
    BackgroundTransparency = 1,
    Text = "✦ GALAXY EDITION ✦",
    TextColor3 = purple,
    TextSize = 12,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left
}, panel)

local minimize = make("TextButton", {
    Size = UDim2.fromOffset(32, 32),
    Position = UDim2.new(1, -76, 0, 12),
    BackgroundColor3 = Color3.fromRGB(42, 24, 68),
    Text = "−",
    TextColor3 = white,
    TextSize = 23,
    Font = Enum.Font.GothamBold
}, panel)
corner(minimize, 9)

local close = make("TextButton", {
    Size = UDim2.fromOffset(32, 32),
    Position = UDim2.new(1, -38, 0, 12),
    BackgroundColor3 = Color3.fromRGB(55, 22, 65),
    Text = "×",
    TextColor3 = white,
    TextSize = 22,
    Font = Enum.Font.GothamBold
}, panel)
corner(close, 9)

make("Frame", {
    Size = UDim2.new(1, -28, 0, 2),
    Position = UDim2.fromOffset(14, 77),
    BackgroundColor3 = purple,
    BorderSizePixel = 0
}, panel)

-- Status
local status = make("TextLabel", {
    Size = UDim2.new(1, -28, 0, 40),
    Position = UDim2.fromOffset(14, 89),
    BackgroundColor3 = Color3.fromRGB(28, 20, 52),
    Text = "  ●  MOZY HUB READY",
    TextColor3 = Color3.fromRGB(100, 255, 170),
    TextSize = 12,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left
}, panel)
corner(status, 10)

-- Button container
local list = make("ScrollingFrame", {
    Size = UDim2.new(1, -28, 1, -185),
    Position = UDim2.fromOffset(14, 140),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = purple,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y
}, panel)

make("UIListLayout", {
    Padding = UDim.new(0, 9),
    SortOrder = Enum.SortOrder.LayoutOrder
}, list)

local function setStatus(text, color)
    status.Text = "  ●  " .. text
    status.TextColor3 = color or white
end

local function addButton(title, description, color, callback)
    local button = make("TextButton", {
        Size = UDim2.new(1, -4, 0, 58),
        BackgroundColor3 = Color3.fromRGB(24, 18, 48),
        Text = "",
        AutoButtonColor = false
    }, list)

    corner(button, 12)
    stroke(button, color, 1.5)

    make("TextLabel", {
        Size = UDim2.new(1, -24, 0, 27),
        Position = UDim2.fromOffset(12, 5),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = white,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left
    }, button)

    make("TextLabel", {
        Size = UDim2.new(1, -24, 0, 20),
        Position = UDim2.fromOffset(12, 31),
        BackgroundTransparency = 1,
        Text = description,
        TextColor3 = Color3.fromRGB(180, 165, 205),
        TextSize = 10,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left
    }, button)

    button.Activated:Connect(callback)

    button.MouseEnter:Connect(function()
        tween(button, {
            BackgroundColor3 = Color3.fromRGB(42, 26, 72)
        })
    end)

    button.MouseLeave:Connect(function()
        tween(button, {
            BackgroundColor3 = Color3.fromRGB(24, 18, 48)
        })
    end)

    return button
end

addButton("✦  COSMETICS", "Cosmetic menu", purple, function()
    setStatus("COSMETICS MENU SELECTED", purple)
end)

addButton("⟳  REAPPLY", "Refresh menu status", blue, function()
    setStatus("GUI REFRESHED", Color3.fromRGB(100, 255, 170))
end)

addButton("★  EXTRAS", "Additional options", purple, function()
    setStatus("EXTRAS COMING SOON", purple)
end)

addButton("⚙  SETTINGS", "Hub information", blue, function()
    setStatus("MOZY HUB VERSION 1.1", blue)
end)

addButton("✕  RESET STATUS", "Return to ready status", purple, function()
    setStatus("MOZY HUB READY", Color3.fromRGB(100, 255, 170))
end)

-- Footer
local footer = make("TextLabel", {
    Size = UDim2.new(1, -28, 0, 22),
    Position = UDim2.new(0, 14, 1, -27),
    BackgroundTransparency = 1,
    Text = "MOZY HUB  •  GALAXY EDITION  •  v1.1",
    TextColor3 = Color3.fromRGB(175, 145, 220),
    TextSize = 9,
    Font = Enum.Font.GothamMedium
}, panel)

-- Minimize / restore
local minimized = false
local previousSize = panel.Size

minimize.Activated:Connect(function()
    minimized = not minimized

    if minimized then
        previousSize = panel.Size
        list.Visible = false
        subtitle.Visible = false
        status.Visible = false
        footer.Visible = false
        panel.Size = UDim2.new(0.88, 0, 0, 58)
        minimize.Text = "+"
    else
        panel.Size = previousSize
        list.Visible = true
        subtitle.Visible = true
        status.Visible = true
        footer.Visible = true
        minimize.Text = "−"
    end
end)

-- Close / open
close.Activated:Connect(function()
    panel.Visible = false
    launcher.Visible = true
end)

launcher.Activated:Connect(function()
    panel.Visible = true
    launcher.Visible = false
end)

-- Drag panel with touch or mouse
local dragging = false
local dragStart
local startPos

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = panel.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseMovement
    ) then
        local delta = input.Position - dragStart

        panel.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

launcher.Visible = false
setStatus("MOZY HUB READY", Color3.fromRGB(100, 255, 170))
