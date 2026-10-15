-- MOZY HUB v2.0 | DARK EDITION
-- Mobile UI | Navigation Hub

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("MozyHub")
if old then old:Destroy() end

local C = {
    Background = Color3.fromRGB(17, 13, 17),
    Sidebar = Color3.fromRGB(24, 19, 23),
    Card = Color3.fromRGB(39, 31, 38),
    Hover = Color3.fromRGB(55, 39, 58),
    Purple = Color3.fromRGB(180, 70, 255),
    White = Color3.fromRGB(245, 240, 248),
    Gray = Color3.fromRGB(165, 155, 170),
    Green = Color3.fromRGB(60, 240, 100)
}

local function make(class, props, parent)
    local obj = Instance.new(class)
    for k, v in pairs(props) do
        obj[k] = v
    end
    obj.Parent = parent
    return obj
end

local function round(obj, radius)
    make("UICorner", {
        CornerRadius = UDim.new(0, radius)
    }, obj)
end

local function outline(obj, color, thickness)
    make("UIStroke", {
        Color = color,
        Thickness = thickness,
        Transparency = 0.2
    }, obj)
end

local function label(parent, text, size, position, textSize, color)
    return make("TextLabel", {
        BackgroundTransparency = 1,
        Text = text,
        Size = size,
        Position = position,
        Font = Enum.Font.GothamMedium,
        TextSize = textSize,
        TextColor3 = color or C.White,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        TextWrapped = true
    }, parent)
end

local gui = make("ScreenGui", {
    Name = "MozyHub",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    DisplayOrder = 999
}, playerGui)

-- Floating launcher
local launcher = make("TextButton", {
    Name = "Launcher",
    Size = UDim2.fromOffset(54, 54),
    Position = UDim2.new(0, 18, 0.5, -27),
    BackgroundColor3 = C.Background,
    Text = "M",
    TextSize = 27,
    Font = Enum.Font.GothamBlack,
    TextColor3 = C.Purple
}, gui)

round(launcher, 30)
outline(launcher, C.Purple, 2)

-- Main window
local panel = make("Frame", {
    Name = "Main",
    Size = UDim2.new(0.92, 0, 0.72, 0),
    Position = UDim2.new(0.04, 0, 0.14, 0),
    BackgroundColor3 = C.Background,
    BackgroundTransparency = 0.04,
    BorderSizePixel = 0,
    ClipsDescendants = true
}, gui)

round(panel, 20)
outline(panel, C.Purple, 1.5)

make("UISizeConstraint", {
    MinSize = Vector2.new(300, 330),
    MaxSize = Vector2.new(650, 680)
}, panel)

-- Top bar
local top = make("Frame", {
    Size = UDim2.new(1, 0, 0, 58),
    BackgroundColor3 = C.Sidebar,
    BackgroundTransparency = 0.08,
    BorderSizePixel = 0
}, panel)

label(top, "✦  MOZY HUB", UDim2.new(1, -120, 1, 0),
    UDim2.fromOffset(16, 0), 21, C.Purple)

local version = label(top, "v2.0", UDim2.fromOffset(45, 30),
    UDim2.new(1, -95, 0, 14), 12, C.Gray)
version.TextXAlignment = Enum.TextXAlignment.Center

local minimize = make("TextButton", {
    Size = UDim2.fromOffset(32, 32),
    Position = UDim2.new(1, -78, 0, 13),
    BackgroundColor3 = C.Hover,
    Text = "−",
    TextSize = 22,
    TextColor3 = C.White,
    Font = Enum.Font.GothamBold
}, top)
round(minimize, 9)

local close = make("TextButton", {
    Size = UDim2.fromOffset(32, 32),
    Position = UDim2.new(1, -39, 0, 13),
    BackgroundColor3 = C.Hover,
    Text = "×",
    TextSize = 22,
    TextColor3 = C.White,
    Font = Enum.Font.GothamBold
}, top)
round(close, 9)

-- Sidebar
local sidebar = make("Frame", {
    Name = "Sidebar",
    Size = UDim2.new(0, 118, 1, -58),
    Position = UDim2.fromOffset(0, 58),
    BackgroundColor3 = C.Sidebar,
    BorderSizePixel = 0
}, panel)

local profile = make("Frame", {
    Size = UDim2.new(1, -14, 0, 62),
    Position = UDim2.fromOffset(7, 8),
    BackgroundColor3 = C.Card
}, sidebar)
round(profile, 12)

label(profile, "M", UDim2.fromOffset(34, 42),
    UDim2.fromOffset(6, 9), 23, C.Purple)

label(profile, "MOZY", UDim2.new(1, -48, 0, 24),
    UDim2.fromOffset(43, 8), 12, C.White)

label(profile, "Galaxy Hub", UDim2.new(1, -48, 0, 20),
    UDim2.fromOffset(43, 31), 9, C.Gray)

local nav = make("ScrollingFrame", {
    Size = UDim2.new(1, -10, 1, -91),
    Position = UDim2.fromOffset(5, 78),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 2,
    ScrollBarImageColor3 = C.Purple,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y
}, sidebar)

make("UIListLayout", {
    Padding = UDim.new(0, 5),
    SortOrder = Enum.SortOrder.LayoutOrder
}, nav)

-- Main content area
local content = make("ScrollingFrame", {
    Name = "Content",
    Size = UDim2.new(1, -128, 1, -70),
    Position = UDim2.fromOffset(123, 64),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = C.Purple,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y
}, panel)

make("UIListLayout", {
    Padding = UDim.new(0, 10),
    SortOrder = Enum.SortOrder.LayoutOrder
}, content)

local currentPage = nil
local navButtons = {}

local function clearContent()
    for _, child in ipairs(content:GetChildren()) do
        if not child:IsA("UIListLayout") then
            child:Destroy()
        end
    end
end

local function addCard(title, description)
    local card = make("Frame", {
        Size = UDim2.new(1, -6, 0, 76),
        BackgroundColor3 = C.Card,
        BorderSizePixel = 0
    }, content)

    round(card, 13)

    label(card, title, UDim2.new(1, -22, 0, 30),
        UDim2.fromOffset(12, 8), 14, C.White)

    label(card, description, UDim2.new(1, -22, 0, 32),
        UDim2.fromOffset(12, 38), 11, C.Gray)

    return card
end

local function addAction(title, description, callback)
    local card = make("TextButton", {
        Size = UDim2.new(1, -6, 0, 76),
        BackgroundColor3 = C.Card,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false
    }, content)

    round(card, 13)
    outline(card, C.Purple, 1)

    label(card, title, UDim2.new(1, -35, 0, 30),
        UDim2.fromOffset(12, 8), 14, C.White)

    label(card, description, UDim2.new(1, -35, 0, 32),
        UDim2.fromOffset(12, 38), 11, C.Gray)

    label(card, "›", UDim2.fromOffset(20, 40),
        UDim2.new(1, -27, 0, 18), 25, C.Purple)

    card.Activated:Connect(callback)

    card.MouseEnter:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.15), {
            BackgroundColor3 = C.Hover
        }):Play()
    end)

    card.MouseLeave:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.15), {
            BackgroundColor3 = C.Card
        }):Play()
    end)

    return card
end

local function showPage(page)
    currentPage = page
    clearContent()

    for name, button in pairs(navButtons) do
        button.BackgroundColor3 =
            name == page and C.Hover or C.Sidebar
    end

    if page == "INFO" then
        addCard("MOZY HUB | Galaxy Edition",
            "Mobile-friendly interface • Version 2.0")
        addCard("Status", "GUI loaded successfully.")
        addCard("Navigation", "Pilih kategori di sidebar untuk berpindah menu.")

    elseif page == "MAIN" then
        addCard("Main Menu", "Menu utama MOZY HUB.")
        addCard("Interface", "Tampilan dan navigasi aktif.")

    elseif page == "PLAYER" then
        addCard("Player", "Menu informasi karakter.")
        addCard("Rig Support", "R6 dan R15 memiliki struktur karakter berbeda.")

    elseif page == "COSMETICS" then
        addCard("Cosmetics", "Menu kosmetik.")
        addCard("Catatan", "Fungsi penerapan kosmetik belum dihubungkan.")
        addAction("Refresh Status", "Periksa status GUI", function()
            showPage("COSMETICS")
        end)

    elseif page == "EXTRAS" then
        addCard("Extras", "Slot untuk fitur tambahan.")
        addCard("Coming Soon", "Fitur tambahan dapat ditambahkan nanti.")

    elseif page == "SETTINGS" then
        addCard("Settings", "Pengaturan antarmuka.")
        addAction("Reset UI Status", "Muat ulang halaman Info", function()
            showPage("INFO")
        end)
    end
end

local pages = {
    {"INFO", "ⓘ"},
    {"MAIN", "⌂"},
    {"PLAYER", "♙"},
    {"COSMETICS", "✦"},
    {"EXTRAS", "☆"},
    {"SETTINGS", "⚙"}
}

for _, item in ipairs(pages) do
    local name, icon = item[1], item[2]

    local button = make("TextButton", {
        Size = UDim2.new(1, 0, 0, 38),
        BackgroundColor3 = C.Sidebar,
        BorderSizePixel = 0,
        Text = icon .. " " .. name,
        TextColor3 = C.White,
        TextSize = 10,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        AutoButtonColor = false
    }, nav)

    round(button, 8)
    navButtons[name] = button

    button.Activated:Connect(function()
        showPage(name)
    end)
end

-- Minimize / restore
local minimized = false
local previousSize = panel.Size

minimize.Activated:Connect(function()
    minimized = not minimized

    if minimized then
        previousSize = panel.Size
        sidebar.Visible = false
        content.Visible = false
        panel.Size = UDim2.new(0.72, 0, 0, 58)
        minimize.Text = "+"
    else
        panel.Size = previousSize
        sidebar.Visible = true
        content.Visible = true
        minimize.Text = "−"
    end
end)

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
local startPosition

top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPosition = panel.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseMovement
    ) then
        local delta = input.Position - dragStart

        panel.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
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
showPage("INFO")

print("MOZY HUB v2.0 loaded")
