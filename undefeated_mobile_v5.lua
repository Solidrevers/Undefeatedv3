-- Un Defeated Mobile v5 | S2 Hub Style | Steal a Brainrot
-- Loadstring: loadstring(game:HttpGet"https://pastebin.com/YOUR_PASTEBIN_ID")()
-- Host this file on a paste service (Pastebin, GitHub raw, etc.) and use the loadstring above.

--// Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")

--// Utility
local function Notify(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 3
        })
    end)
end

--// Color Configuration (customizable)
local Theme = {
    Primary = Color3.fromRGB(88, 101, 242),
    Secondary = Color3.fromRGB(136, 153, 255),
    Background = Color3.fromRGB(30, 30, 46),
    Card = Color3.fromRGB(45, 45, 65),
    Text = Color3.fromRGB(225, 225, 225),
    Accent = Color3.fromRGB(255, 107, 107),
    Success = Color3.fromRGB(107, 255, 144),
    Warning = Color3.fromRGB(255, 200, 80),
}

--// State
local State = {
    SpeedActive = false,
    SpeedValue = 58,
    AutoSteal = false,
    StealRadius = 60,
    AutoCollect = false,
    AutoSell = false,
    DuelMode = false,
    ESP = false,
    BatAimbot = false,
    BatAimFOV = 90,
    InfiniteJump = false,
    FastFall = false,
    DropBrains = false,
    LaserAimbot = false,
    LaserFOV = 120,
    Visibility = true,
}

--// GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UndefeatedHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game:GetService("CoreGui")

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "Main"
MainFrame.Size = UDim2.new(0, 320, 0, 480)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -240)
MainFrame.BackgroundColor3 = Theme.Background
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Theme.Primary
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Theme.Primary
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 1, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Un Defeated Hub v5"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 16
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Parent = TitleBar

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Theme.Accent
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

-- Side Navigation
local SideNav = Instance.new("Frame")
SideNav.Size = UDim2.new(0, 50, 1, -40)
SideNav.Position = UDim2.new(0, 0, 0, 40)
SideNav.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
SideNav.BorderSizePixel = 0
SideNav.Parent = MainFrame

local SideNavLayout = Instance.new("UIListLayout")
SideNavLayout.SortOrder = Enum.SortOrder.LayoutOrder
SideNavLayout.Padding = UDim.new(0, 4)
SideNavLayout.Parent = SideNav

local SidePadding = Instance.new("UIPadding")
SidePadding.PaddingTop = UDim.new(0, 8)
SidePadding.PaddingBottom = UDim.new(0, 8)
SidePadding.Parent = SideNav

-- Tab Buttons
local TabNames = {"Move", "Combat", "Steal", "Misc", "Settings"}
local TabButtons = {}
local TabPages = {}
local CurrentTab = "Move"

for i, name in ipairs(TabNames) do
    local Btn = Instance.new("TextButton")
    Btn.Name = name
    Btn.Size = UDim2.new(1, -10, 0, 36)
    Btn.BackgroundColor3 = Theme.Card
    Btn.Text = name
    Btn.TextColor3 = Theme.Text
    Btn.TextSize = 11
    Btn.Font = Enum.Font.GothamSemibold
    Btn.BorderSizePixel = 0
    Btn.LayoutOrder = i
    Btn.Parent = SideNav

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = Btn

    TabButtons[name] = Btn

    Btn.MouseButton1Click:Connect(function()
        for k, v in pairs(TabButtons) do
            v.BackgroundColor3 = Theme.Card
        end
        Btn.BackgroundColor3 = Theme.Primary
        CurrentTab = name
        for k, page in pairs(TabPages) do
            page.Visible = (k == name)
        end
    end)
end

-- Content Area
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -50, 1, -40)
ContentArea.Position = UDim2.new(0, 50, 0, 40)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

-- Helper to create a toggle
local function CreateToggle(parent, name, defaultValue, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -10, 0, 36)
    ToggleFrame.BackgroundColor3 = Theme.Card
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = parent

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 8)
    toggleCorner.Parent = ToggleFrame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.6, 0, 1, 0)
    Label.Position = UDim2.new(0, 8, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Theme.Text
    Label.TextSize = 12
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame

    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 44, 0, 22)
    ToggleBtn.Position = UDim2.new(1, -52, 0, 7)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
    ToggleBtn.Text = ""
    ToggleBtn.BorderSizePixel = 0
    ToggleBtn.Parent = ToggleFrame

    local toggleCorner2 = Instance.new("UICorner")
    toggleCorner2.CornerRadius = UDim.new(0, 11)
    toggleCorner2.Parent = ToggleBtn

    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 18, 0, 18)
    Knob.Position = UDim2.new(0, 2, 0, 2)
    Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Knob.BorderSizePixel = 0
    Knob.Parent = ToggleBtn

    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(0, 9)
    knobCorner.Parent = Knob

    local enabled = defaultValue
    if enabled then
        ToggleBtn.BackgroundColor3 = Theme.Success
        Knob.Position = UDim2.new(1, -20, 0, 2)
    end

    ToggleBtn.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            ToggleBtn.BackgroundColor3 = Theme.Success
            Knob.Position = UDim2.new(1, -20, 0, 2)
        else
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
            Knob.Position = UDim2.new(0, 2, 0, 2)
        end
        callback(enabled)
    end)

    return ToggleFrame
end

-- Helper to create a slider
local function CreateSlider(parent, name, min, max, default, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, -10, 0, 50)
    SliderFrame.BackgroundColor3 = Theme.Card
    SliderFrame.BorderSizePixel = 0
    SliderFrame.Parent = parent

    local sCorner = Instance.new("UICorner")
    sCorner.CornerRadius = UDim.new(0, 8)
    sCorner.Parent = SliderFrame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -16, 0, 20)
    Label.Position = UDim2.new(0, 8, 0, 2)
    Label.BackgroundTransparency = 1
    Label.Text = name .. ": " .. tostring(default)
    Label.TextColor3 = Theme.Text
    Label.TextSize = 11
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = SliderFrame

    local SliderBg = Instance.new("Frame")
    SliderBg.Size = UDim2.new(1, -16, 0, 8)
    SliderBg.Position = UDim2.new(0, 8, 0, 26)
    SliderBg.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    SliderBg.BorderSizePixel = 0
    SliderBg.Parent = SliderFrame

    local SliderFill = Instance.new("Frame")
    SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    SliderFill.BackgroundColor3 = Theme.Primary
    SliderFill.BorderSizePixel = 0
    SliderFill.Parent = SliderBg

    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 4)
    fillCorner.Parent = SliderFill

    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 14, 0, 14)
    Knob.Position = UDim2.new((default - min) / (max - min), -7, 0, -3)
    Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Knob.BorderSizePixel = 0
    Knob.ZIndex = 2
    Knob.Parent = SliderBg

    local kCorner = Instance.new("UICorner")
    kCorner.CornerRadius = UDim.new(0, 7)
    kCorner.Parent = Knob

    local dragging = false
    SliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)
    SliderBg.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local pos = math.clamp((input.Position.X - SliderBg.AbsolutePosition.X) / SliderBg.AbsoluteSize.X, 0, 1)
            local value = math.floor(min + pos * (max - min))
            SliderFill.Size = UDim2.new(pos, 0, 1, 0)
            Knob.Position = UDim2.new(pos, -7, 0, -3)
            Label.Text = name .. ": " .. tostring(value)
            callback(value)
        end
    end)

    return SliderFrame
end

-- Helper to create a section header
local function CreateSection(parent, text)
    local Section = Instance.new("TextLabel")
    Section.Size = UDim2.new(1, -10, 0, 24)
    Section.BackgroundTransparency = 1
    Section.Text = text
    Section.TextColor3 = Theme.Secondary
    Section.TextSize = 12
    Section.Font = Enum.Font.GothamBold
    Section.TextXAlignment = Enum.TextXAlignment.Left
    Section.Parent = parent
    return Section
end

-- Tab Pages
for _, name in ipairs(TabNames) do
    local Page = Instance.new("ScrollingFrame")
    Page.Name = name
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.ScrollBarThickness = 4
    Page.ScrollBarImageColor3 = Theme.Primary
    Page.Visible = (name == "Move")
    Page.Parent = ContentArea

    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 4)
    layout.Parent = Page

    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 4)
    padding.PaddingBottom = UDim.new(0, 4)
    padding.PaddingLeft = UDim.new(0, 6)
    padding.PaddingRight = UDim.new(0, 6)
    padding.Parent = Page

    TabPages[name] = Page
end

--// TAB: Movement
do
    local page = TabPages["Move"]
    CreateSection(page, "Movement")

    CreateToggle(page, "Speed Boost", State.SpeedActive, function(v)
        State.SpeedActive = v
        if v then
            Notify("Un Defeated", "Speed Boost ON (" .. State.SpeedValue .. "x)", 2)
        else
            Notify("Un Defeated", "Speed Boost OFF", 2)
        end
    end)

    CreateSlider(page, "Speed Multiplier", 10, 100, State.SpeedValue, function(v)
        State.SpeedValue = v
    end)

    CreateToggle(page, "Infinite Jump", State.InfiniteJump, function(v)
        State.InfiniteJump = v
        if v then
            Notify("Un Defeated", "Infinite Jump ON", 2)
        else
            Notify("Un Defeated", "Infinite Jump OFF", 2)
        end
    end)

    CreateToggle(page, "Fast Fall", State.FastFall, function(v)
        State.FastFall = v
        if v then
            Notify("Un Defeated", "Fast Fall ON", 2)
        else
            Notify("Un Defeated", "Fast Fall OFF", 2)
        end
    end)

    CreateToggle(page, "Drop Brainrots", State.DropBrains, function(v)
        State.DropBrains = v
        if v then
            Notify("Un Defeated", "Drop Brainrots ON — launch + drop", 2)
        else
            Notify("Un Defeated", "Drop Brainrots OFF", 2)
        end
    end)
end

--// TAB: Combat
do
    local page = TabPages["Combat"]
    CreateSection(page, "Combat")

    CreateToggle(page, "Bat Aimbot", State.BatAimbot, function(v)
        State.BatAimbot = v
        if v then
            Notify("Un Defeated", "Bat Aimbot ON (FOV: " .. State.BatAimFOV .. ")", 2)
        else
            Notify("Un Defeated", "Bat Aimbot OFF", 2)
        end
    end)

    CreateSlider(page, "Bat Aimbot FOV", 30, 180, State.BatAimFOV, function(v)
        State.BatAimFOV = v
    end)

    CreateToggle(page, "Laser Cap Aimbot (PvP)", State.LaserAimbot, function(v)
        State.LaserAimbot = v
        if v then
            Notify("Un Defeated", "Laser Aimbot ON — shoots players (FOV: " .. State.LaserFOV .. ")", 2)
        else
            Notify("Un Defeated", "Laser Aimbot OFF", 2)
        end
    end)

    CreateSlider(page, "Laser Aimbot FOV", 30, 360, State.LaserFOV, function(v)
        State.LaserFOV = v
    end)

    CreateToggle(page, "ESP (Brains)", State.ESP, function(v)
        State.ESP = v
        if v then
            Notify("Un Defeated", "ESP ON", 2)
        else
            Notify("Un Defeated", "ESP OFF", 2)
        end
    end)
end

--// TAB: Steal
do
    local page = TabPages["Steal"]
    CreateSection(page, "Steal Tools")

    CreateToggle(page, "Auto Steal", State.AutoSteal, function(v)
        State.AutoSteal = v
        if v then
            Notify("Un Defeated", "Auto Steal ON (radius: " .. State.StealRadius .. ")", 2)
        else
            Notify("Un Defeated", "Auto Steal OFF", 2)
        end
    end)

    CreateSlider(page, "Steal Radius", 10, 200, State.StealRadius, function(v)
        State.StealRadius = v
    end)

    CreateToggle(page, "Auto Collect", State.AutoCollect, function(v)
        State.AutoCollect = v
        if v then
            Notify("Un Defeated", "Auto Collect ON", 2)
        else
            Notify("Un Defeated", "Auto Collect OFF", 2)
        end
    end)

    CreateToggle(page, "Auto Sell", State.AutoSell, function(v)
        State.AutoSell = v
        if v then
            Notify("Un Defeated", "Auto Sell ON", 2)
        else
            Notify("Un Defeated", "Auto Sell OFF", 2)
        end
    end)

    CreateToggle(page, "Duel Mode", State.DuelMode, function(v)
        State.DuelMode = v
        if v then
            Notify("Un Defeated", "Duel Mode ON", 2)
        else
            Notify("Un Defeated", "Duel Mode OFF", 2)
        end
    end)
end

--// TAB: Misc
do
    local page = TabPages["Misc"]
    CreateSection(page, "Miscellaneous")

    CreateToggle(page, "GUI Visible", State.Visibility, function(v)
        State.Visibility = v
        MainFrame.Visible = v
    end)

    CreateToggle(page, "Hide HUD", false, function(v)
        pcall(function()
            StarterGui:SetCore("ShowHUD", not v)
        end)
    end)
end

--// TAB: Settings
do
    local page = TabPages["Settings"]
    CreateSection(page, "Appearance")

    CreateSlider(page, "Gui Scale", 50, 150, 100, function(v)
        local scale = v / 100
        MainFrame.Size = UDim2.new(0, 320 * scale, 0, 480 * scale)
    end)

    CreateSection(page, "Theme Colors")

    local function CreateColorButton(parent, label, color, callback)
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, -10, 0, 30)
        Frame.BackgroundColor3 = Theme.Card
        Frame.BorderSizePixel = 0
        Frame.Parent = parent

        local fCorner = Instance.new("UICorner")
        fCorner.CornerRadius = UDim.new(0, 6)
        fCorner.Parent = Frame

        local Lbl = Instance.new("TextLabel")
        Lbl.Size = UDim2.new(0.5, 0, 1, 0)
        Lbl.Position = UDim2.new(0, 8, 0, 0)
        Lbl.BackgroundTransparency = 1
        Lbl.Text = label
        Lbl.TextColor3 = Theme.Text
        Lbl.TextSize = 11
        Lbl.Font = Enum.Font.Gotham
        Lbl.TextXAlignment = Enum.TextXAlignment.Left
        Lbl.Parent = Frame

        local ColorBtn = Instance.new("TextButton")
        ColorBtn.Size = UDim2.new(0, 36, 0, 20)
        ColorBtn.Position = UDim2.new(1, -44, 0, 5)
        ColorBtn.BackgroundColor3 = color
        ColorBtn.Text = ""
        ColorBtn.BorderSizePixel = 0
        ColorBtn.Parent = Frame

        local cCorner = Instance.new("UICorner")
        cCorner.CornerRadius = UDim.new(0, 4)
        cCorner.Parent = ColorBtn

        ColorBtn.MouseButton1Click:Connect(function()
            pcall(function()
                local newColor = Color3.fromRGB(
                    math.random(0, 255),
                    math.random(0, 255),
                    math.random(0, 255)
                )
                ColorBtn.BackgroundColor3 = newColor
                callback(newColor)
                Notify("Un Defeated", "Color updated", 2)
            end)
        end)
    end

    CreateColorButton(page, "Primary", Theme.Primary, function(c) Theme.Primary = c MainStroke.Color = c end)
    CreateColorButton(page, "Background", Theme.Background, function(c) Theme.Background = c MainFrame.BackgroundColor3 = c end)
    CreateColorButton(page, "Accent", Theme.Accent, function(c) Theme.Accent = c end)

    CreateSection(page, "Info")
    local InfoLabel = Instance.new("TextLabel")
    InfoLabel.Size = UDim2.new(1, -10, 0, 50)
    InfoLabel.BackgroundTransparency = 1
    InfoLabel.Text = "Un Defeated v5\nClient-side only. No cookies logged.\nHost on Pastebin or GitHub raw for loadstring."
    InfoLabel.TextColor3 = Color3.fromRGB(150, 150, 170)
    InfoLabel.TextSize = 10
    InfoLabel.Font = Enum.Font.Gotham
    InfoLabel.TextWrapped = true
    InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
    InfoLabel.Parent = page
end

--// Close button
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

--// Dragging
local dragging = false
local dragStart, startPos

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

--// Game Logic Connections
RunService.Heartbeat:Connect(function()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = LocalPlayer.Character.HumanoidRootPart
    local hum = LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
    if not hum then return end

    -- Speed Boost
    if State.SpeedActive then
        hum.WalkSpeed = State.SpeedValue * 16
        hum.JumpHeight = State.SpeedValue * 7.2
    end

    -- Infinite Jump
    if State.InfiniteJump then
        hum.UseJumpPower = true
        hum.JumpPower = 50
    end

    -- Fast Fall
    if State.FastFall then
        hum.PlatformStand = true
    end

    -- Drop Brainrots: launch player upward and force-drop held brainrot
    if State.DropBrains then
        pcall(function()
            -- Launch player upward
            hrp.Velocity = Vector3.new(hrp.Velocity.X, 120, hrp.Velocity.Z)

            -- Find and drop the brainrot the player is currently holding
            local backpack = LocalPlayer:FindFirstChild("Backpack")
            local char = LocalPlayer.Character
            if not backpack or not char then return end

            -- Check if player is holding a tool with a brainrot
            for _, tool in ipairs(char:GetChildren()) do
                if tool:IsA("Tool") then
                    -- Look for brainrot-related children inside the tool
                    for _, child in ipairs(tool:GetDescendants()) do
                        if child.Name == "Brainrot" or child.Name == "Brain" then
                            -- Clone the brainrot part and drop it at player's feet
                            local dropClone = child:Clone()
                            if dropClone then
                                dropClone.Parent = Workspace
                                dropClone.Position = hrp.Position + Vector3.new(0, -3, 0)
                                dropClone.Anchored = false
                                dropClone.Velocity = Vector3.new(
                                    math.random(-20, 20),
                                    math.random(10, 30),
                                    math.random(-20, 20)
                                )
                            end
                            -- Also destroy the original inside the tool to force-drop
                            child:Destroy()
                        end
                    end
                end
            end
        end)
    end
end)

--// Auto Steal Loop
task.spawn(function()
    while task.wait(0.2) do
        if State.AutoSteal then
            pcall(function()
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj.Name == "Brainrot" or obj.Name == "Brain" or obj:FindFirstChild("Value") then
                        local dist = (obj.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                        if dist <= State.StealRadius then
                            pcall(function()
                                local touch = Instance.new("TouchTransmit")
                                touch.Parent = obj
                            end)
                        end
                    end
                end
            end)
        end
    end
end)

--// ESP Loop
task.spawn(function()
    while task.wait(0.5) do
        if State.ESP then
            pcall(function()
                for _, part in ipairs(workspace:GetDescendants()) do
                    if part.Name == "Brainrot" or part.Name == "Brain" then
                        if not part:FindFirstChild("ESP_Highlight") then
                            local hl = Instance.new("Highlight")
                            hl.Name = "ESP_Highlight"
                            hl.FillColor = Theme.Accent
                            hl.FillTransparency = 0.5
                            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                            hl.OutlineTransparency = 0
                            hl.Adornee = part
                            hl.Parent = part
                        end
                    end
                end
            end)
        else
            pcall(function()
                for _, part in ipairs(workspace:GetDescendants()) do
                    if part.Name == "ESP_Highlight" then
                        part:Destroy()
                    end
                end
            end)
        end
    end
end)

--// Bat Aimbot (brainrots)
RunService.RenderStepped:Connect(function()
    if not State.BatAimbot then return end
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = LocalPlayer.Character.HumanoidRootPart

    pcall(function()
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj.Name == "Brainrot" or obj.Name == "Brain" then
                if obj:IsA("BasePart") then
                    local dist = (obj.Position - hrp.Position).Magnitude
                    if dist <= State.BatAimFOV * 5 then
                        hrp.CFrame = CFrame.lookAt(hrp.Position, obj.Position)
                    end
                end
            end
        end
    end)
end)

--// Laser Cap Aimbot (PvP — aims all equipped gears at nearest player)
RunService.RenderStepped:Connect(function()
    if not State.LaserAimbot then return end
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = LocalPlayer.Character.HumanoidRootPart

    pcall(function()
        -- Find nearest player target within FOV range
        local nearestTarget = nil
        local nearestDist = math.huge

        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local targetHrp = player.Character.HumanoidRootPart
                local dist = (targetHrp.Position - hrp.Position).Magnitude
                local maxRange = State.LaserFOV * 5
                if dist <= maxRange and dist < nearestDist then
                    nearestTarget = targetHrp
                    nearestDist = dist
                end
            end
        end

        if not nearestTarget then return end

        -- Aim all equipped gears (tools) at the nearest player
        for _, tool in ipairs(LocalPlayer.Character:GetChildren()) do
            if tool:IsA("Tool") or tool:IsA("HopperBin") then
                -- Aim the tool's handle at the target
                local handle = tool:FindFirstChild("Handle")
                if handle and handle:IsA("BasePart") then
                    local targetPos = nearestTarget.Position
                    local aimCFrame = CFrame.lookAt(handle.Position, Vector3.new(targetPos.X, handle.Position.Y, targetPos.Z))
                    handle.CFrame = aimCFrame
                end

                -- Also aim any basepart in the tool at the target
                local gun = tool:FindFirstChildWhichIsA("BasePart")
                if gun then
                    local targetPos = nearestTarget.Position
                    local newCF = CFrame.lookAt(gun.Position, Vector3.new(targetPos.X, gun.Position.Y, targetPos.Z))
                    gun.CFrame = newCF
                end
            end
        end
    end)
end)

--// Notify on load
Notify("Un Defeated", "Hub v5 loaded successfully", 3)

print("[Un Defeated v5] Loaded successfully. v5 updates: Drop Brainrots (launch + force drop), Laser Cap Aimbot now targets players (PvP).")