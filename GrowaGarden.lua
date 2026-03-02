--[[
    ╔══════════════════════════════════════════╗
    ║      MOON HUB | SPECIAL GAG             ║
    ║       Grow A Garden  •  v1.0            ║
    ║     Loadstring 2 — KEY NEEDED           ║
    ╚══════════════════════════════════════════╝
]]

local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")
local LocalPlayer      = Players.LocalPlayer
local Character        = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid         = Character:WaitForChild("Humanoid")
local HRP              = Character:WaitForChild("HumanoidRootPart")

-- ═══════════════════════════════════════
--           COLOR PALETTE
-- ═══════════════════════════════════════
local C = {
    BG_Main    = Color3.fromRGB(8,  12, 28),
    BG_Side    = Color3.fromRGB(12, 18, 40),
    BG_Content = Color3.fromRGB(15, 22, 50),
    BG_Card    = Color3.fromRGB(20, 30, 65),
    Accent     = Color3.fromRGB(50, 120, 255),
    AccentDim  = Color3.fromRGB(30, 70,  160),
    AccentGlow = Color3.fromRGB(80, 150, 255),
    ON         = Color3.fromRGB(50, 200, 120),
    OFF        = Color3.fromRGB(50, 55,  85),
    TextMain   = Color3.fromRGB(220, 235, 255),
    TextSub    = Color3.fromRGB(130, 155, 200),
    TextDim    = Color3.fromRGB(70,  90,  140),
    Border     = Color3.fromRGB(35,  55,  110),
    Red        = Color3.fromRGB(220, 60,  60),
    Moon       = Color3.fromRGB(180, 210, 255),
    Gold       = Color3.fromRGB(255, 200, 50),
    Purple     = Color3.fromRGB(168, 85,  247),
    Green      = Color3.fromRGB(50,  200, 120),
}

-- ═══════════════════════════════════════
--               STATE
-- ═══════════════════════════════════════
local State = {
    Minimized = false,
    ActiveTab = "Farm",
    Toggles = {
        AutoFarmAdv    = false,
        AutoSellPrem   = false,
        ItemESP        = false,
        SeedTeleport   = false,
        SpeedHack      = false,
        InfiniteSprink = false,
    },
    Connections = {},
    OriginalSpeed = 16,
}

-- ═══════════════════════════════════════
--           UTILITY
-- ═══════════════════════════════════════
local function Corner(p, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 8)
    c.Parent = p
    return c
end

local function Stroke(p, col, th)
    local s = Instance.new("UIStroke")
    s.Color = col or C.Border
    s.Thickness = th or 1
    s.Parent = p
    return s
end

local function Tween(obj, props, t, style)
    TweenService:Create(obj,
        TweenInfo.new(t or 0.25, style or Enum.EasingStyle.Quart),
        props):Play()
end

local function Lbl(parent, props)
    local l = Instance.new("TextLabel")
    l.BackgroundTransparency = 1
    l.Font = Enum.Font.Gotham
    l.TextColor3 = C.TextMain
    l.TextSize = 12
    for k, v in pairs(props) do l[k] = v end
    l.Parent = parent
    return l
end

local function Section(parent, txt, col)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 22)
    f.BackgroundTransparency = 1
    f.Parent = parent
    Lbl(f, {
        Size = UDim2.new(1, 0, 1, 0),
        Text = "  ▸  " .. txt,
        TextColor3 = col or C.Accent,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextSize = 10,
        Font = Enum.Font.GothamBold,
    })
    return f
end

-- ═══════════════════════════════════════
--         LOADING SCREEN
-- ═══════════════════════════════════════
local LoadGui = Instance.new("ScreenGui")
LoadGui.Name = "MoonSpecial_Load"
LoadGui.ResetOnSpawn = false
LoadGui.DisplayOrder = 999
LoadGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LoadGui.Parent = game.CoreGui

local LF = Instance.new("Frame")
LF.Size = UDim2.new(1, 0, 1, 0)
LF.BackgroundColor3 = C.BG_Main
LF.BorderSizePixel = 0
LF.Parent = LoadGui

-- Stars
for i = 1, 50 do
    local s = Instance.new("Frame")
    s.Size = UDim2.new(0, math.random(1,3), 0, math.random(1,3))
    s.Position = UDim2.new(math.random(), 0, math.random(), 0)
    s.BackgroundColor3 = C.Moon
    s.BackgroundTransparency = math.random(4,9)/10
    s.BorderSizePixel = 0
    s.Parent = LF
    Corner(s, 9)
end

Lbl(LF, {Size=UDim2.new(0,90,0,90), Position=UDim2.new(0.5,-45,0.2,0),
    Text="⚡", TextSize=64, Font=Enum.Font.GothamBold})

Lbl(LF, {Size=UDim2.new(0,420,0,44), Position=UDim2.new(0.5,-210,0.38,0),
    Text="MOON HUB", TextColor3=C.Moon, TextSize=34, Font=Enum.Font.GothamBold})

Lbl(LF, {Size=UDim2.new(0,420,0,26), Position=UDim2.new(0.5,-210,0.48,0),
    Text="SPECIAL GAG  •  Grow A Garden", TextColor3=C.TextSub, TextSize=13})

local BBG = Instance.new("Frame")
BBG.Size = UDim2.new(0,360,0,10)
BBG.Position = UDim2.new(0.5,-180,0.61,0)
BBG.BackgroundColor3 = C.BG_Card
BBG.BorderSizePixel = 0
BBG.Parent = LF
Corner(BBG, 9)

local BFill = Instance.new("Frame")
BFill.Size = UDim2.new(0,0,1,0)
BFill.BackgroundColor3 = C.Purple
BFill.BorderSizePixel = 0
BFill.Parent = BBG
Corner(BFill, 9)

local BPct = Lbl(LF, {Size=UDim2.new(0,360,0,22),
    Position=UDim2.new(0.5,-180,0.64,0),
    Text="0%", TextColor3=C.Purple, TextSize=12, Font=Enum.Font.GothamBold})

local BStatus = Lbl(LF, {Size=UDim2.new(0,360,0,22),
    Position=UDim2.new(0.5,-180,0.69,0),
    Text="Initializing...", TextColor3=C.TextSub, TextSize=11})

local function LoadStep(txt, pct, w)
    BStatus.Text = txt
    Tween(BFill, {Size=UDim2.new(pct,0,1,0)}, 0.55)
    local target = math.floor(pct*100)
    local current = tonumber(BPct.Text:match("%d+")) or 0
    for i = current, target, 2 do
        BPct.Text = i.."%"
        task.wait(0.01)
    end
    BPct.Text = target.."%"
    task.wait(w or 0.6)
end

-- ═══════════════════════════════════════
--         TOGGLE LOGIC
-- ═══════════════════════════════════════
local function StopAll()
    for _, c in pairs(State.Connections) do
        if c then pcall(function() c:Disconnect() end) end
    end
    State.Connections = {}
end

local function RunFeature(key, val)
    if key == "AutoFarmAdv" and val then
        State.Connections.AutoFarmAdv = RunService.Heartbeat:Connect(function()
            -- Auto Farm Advanced logic
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and (obj.Name:lower():find("crop") or obj.Name:lower():find("plant") or obj.Name:lower():find("harvest")) then
                    local dist = (HRP.Position - obj.Position).Magnitude
                    if dist < 20 then
                        pcall(function()
                            local args = {[1]=obj}
                            game:GetService("ReplicatedStorage").RemoteEvent:FireServer(table.unpack(args))
                        end)
                    end
                end
            end
        end)
    end

    if key == "AutoSellPrem" and val then
        State.Connections.AutoSellPrem = RunService.Heartbeat:Connect(function()
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Name:lower():find("sell") then
                    local dist = (HRP.Position - obj.Position).Magnitude
                    if dist < 15 then
                        pcall(function()
                            game:GetService("ReplicatedStorage").RemoteEvent:FireServer("sell")
                        end)
                    end
                end
            end
        end)
    end

    if key == "ItemESP" and val then
        State.Connections.ItemESP = RunService.Heartbeat:Connect(function()
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and not obj:FindFirstChild("ESPBox") then
                    if obj.Name:lower():find("egg") or obj.Name:lower():find("seed") or obj.Name:lower():find("item") then
                        local bb = Instance.new("BillboardGui")
                        bb.Name = "ESPBox"
                        bb.Size = UDim2.new(0,60,0,20)
                        bb.StudsOffset = Vector3.new(0,2,0)
                        bb.AlwaysOnTop = true
                        bb.Parent = obj
                        local lbl = Instance.new("TextLabel")
                        lbl.Size = UDim2.new(1,0,1,0)
                        lbl.BackgroundTransparency = 1
                        lbl.Text = obj.Name
                        lbl.TextColor3 = C.Gold
                        lbl.TextSize = 11
                        lbl.Font = Enum.Font.GothamBold
                        lbl.Parent = bb
                    end
                end
            end
        end)
    else
        if not val and key == "ItemESP" then
            for _, obj in ipairs(workspace:GetDescendants()) do
                local bb = obj:FindFirstChild("ESPBox")
                if bb then bb:Destroy() end
            end
        end
    end

    if key == "SpeedHack" then
        if val then
            State.OriginalSpeed = Humanoid.WalkSpeed
            Tween(Humanoid, {WalkSpeed = 50}, 0.3)
        else
            Tween(Humanoid, {WalkSpeed = State.OriginalSpeed}, 0.3)
        end
    end

    if key == "InfiniteSprink" and val then
        State.Connections.InfiniteSprink = RunService.Heartbeat:Connect(function()
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Name:lower():find("sprinkler") then
                    pcall(function()
                        game:GetService("ReplicatedStorage").RemoteEvent:FireServer("sprinkler", obj)
                    end)
                end
            end
        end)
    end
end

-- ═══════════════════════════════════════
--           MAIN GUI
-- ═══════════════════════════════════════
local function BuildSpecialGUI()

    local SG = Instance.new("ScreenGui")
    SG.Name = "MoonHub_SpecialGaG"
    SG.ResetOnSpawn = false
    SG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    SG.DisplayOrder = 100
    SG.Parent = game.CoreGui

    -- Window
    local Win = Instance.new("Frame")
    Win.Size = UDim2.new(0, 580, 0, 420)
    Win.Position = UDim2.new(0.5, -290, 0.5, -210)
    Win.BackgroundColor3 = C.BG_Main
    Win.BorderSizePixel = 0
    Win.Active = true
    Win.Parent = SG
    Corner(Win, 12)
    Stroke(Win, C.Purple, 1.5)

    -- Drag
    local drag, dStart, dPos = false, nil, nil
    Win.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            drag = true; dStart = i.Position; dPos = Win.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if drag and i.UserInputType == Enum.UserInputType.MouseMovement then
            local d = i.Position - dStart
            Win.Position = UDim2.new(dPos.X.Scale, dPos.X.Offset+d.X,
                                     dPos.Y.Scale, dPos.Y.Offset+d.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end
    end)

    -- TopBar
    local Top = Instance.new("Frame")
    Top.Size = UDim2.new(1, 0, 0, 42)
    Top.BackgroundColor3 = C.BG_Side
    Top.BorderSizePixel = 0
    Top.ZIndex = 5
    Top.Parent = Win
    Corner(Top, 12)
    local TFix = Instance.new("Frame")
    TFix.Size = UDim2.new(1,0,0.5,0)
    TFix.Position = UDim2.new(0,0,0.5,0)
    TFix.BackgroundColor3 = C.BG_Side
    TFix.BorderSizePixel = 0
    TFix.ZIndex = 4
    TFix.Parent = Top

    Lbl(Top, {Size=UDim2.new(0,34,1,0), Position=UDim2.new(0,8,0,0),
        Text="⚡", TextSize=22, ZIndex=6})
    Lbl(Top, {Size=UDim2.new(0,300,1,0), Position=UDim2.new(0,44,0,0),
        Text="Moon Hub  |  Special GaG",
        TextColor3=C.Moon, TextXAlignment=Enum.TextXAlignment.Left,
        TextSize=14, Font=Enum.Font.GothamBold, ZIndex=6})

    -- Special badge
    local badge = Instance.new("Frame")
    badge.Size = UDim2.new(0,70,0,20)
    badge.Position = UDim2.new(0,348,0.5,-10)
    badge.BackgroundColor3 = Color3.fromRGB(40,15,70)
    badge.BorderSizePixel = 0
    badge.ZIndex = 6
    badge.Parent = Top
    Corner(badge, 5)
    Stroke(badge, C.Purple, 1)
    Lbl(badge, {Size=UDim2.new(1,0,1,0), Text="⚡ SPECIAL",
        TextColor3=C.Purple, TextSize=9,
        Font=Enum.Font.GothamBold, ZIndex=7})

    -- Minimize & Close
    local function TopBtn(xOff, bgCol, txt)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0,28,0,22)
        b.Position = UDim2.new(1,xOff,0.5,-11)
        b.BackgroundColor3 = bgCol
        b.Text = txt
        b.TextColor3 = C.TextMain
        b.TextSize = 13
        b.Font = Enum.Font.GothamBold
        b.BorderSizePixel = 0
        b.ZIndex = 6
        b.Parent = Top
        Corner(b, 5)
        return b
    end

    local MinBtn   = TopBtn(-66, C.BG_Card, "─")
    local CloseBtn = TopBtn(-32, C.Red,     "✕")

    -- Content Holder
    local CH = Instance.new("Frame")
    CH.Size = UDim2.new(1,0,1,-42)
    CH.Position = UDim2.new(0,0,0,42)
    CH.BackgroundTransparency = 1
    CH.ClipsDescendants = true
    CH.Parent = Win

    -- Sidebar
    local Side = Instance.new("Frame")
    Side.Size = UDim2.new(0,135,1,0)
    Side.BackgroundColor3 = C.BG_Side
    Side.BorderSizePixel = 0
    Side.Parent = CH
    Stroke(Side, C.Border, 1)

    local SideList = Instance.new("UIListLayout")
    SideList.Padding = UDim.new(0,4)
    SideList.Parent = Side
    local SP = Instance.new("UIPadding")
    SP.PaddingTop = UDim.new(0,10)
    SP.PaddingLeft = UDim.new(0,6)
    SP.PaddingRight = UDim.new(0,6)
    SP.Parent = Side

    -- Content Area
    local CA = Instance.new("Frame")
    CA.Size = UDim2.new(1,-135,1,0)
    CA.Position = UDim2.new(0,135,0,0)
    CA.BackgroundColor3 = C.BG_Content
    CA.BorderSizePixel = 0
    CA.ClipsDescendants = true
    CA.Parent = CH
    local CAP = Instance.new("UIPadding")
    CAP.PaddingAll = UDim.new(0,10)
    CAP.Parent = CA

    -- Pages & Tabs
    local Pages, TabBtns = {}, {}

    local function MakePage(name)
        local pg = Instance.new("ScrollingFrame")
        pg.Name = name
        pg.Size = UDim2.new(1,0,1,0)
        pg.BackgroundTransparency = 1
        pg.BorderSizePixel = 0
        pg.ScrollBarThickness = 3
        pg.ScrollBarImageColor3 = C.Purple
        pg.Visible = false
        pg.CanvasSize = UDim2.new(0,0,0,0)
        pg.Parent = CA
        local ll = Instance.new("UIListLayout")
        ll.Padding = UDim.new(0,6)
        ll.Parent = pg
        ll:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            pg.CanvasSize = UDim2.new(0,0,0,ll.AbsoluteContentSize.Y+16)
        end)
        Pages[name] = pg
        return pg
    end

    local function SetTab(name)
        State.ActiveTab = name
        for n, pg in pairs(Pages) do pg.Visible = (n==name) end
        for n, btn in pairs(TabBtns) do
            if n == name then
                Tween(btn, {BackgroundColor3=C.AccentDim}, 0.2)
                btn.TextColor3 = C.Moon
            else
                btn.BackgroundTransparency = 1
                btn.TextColor3 = C.TextSub
            end
        end
    end

    local Tabs = {
        {"Farm",     "🌱"},
        {"ESP",      "👁"},
        {"Speed",    "⚡"},
        {"Sprinkler","💧"},
        {"Settings", "⚙"},
    }

    for _, t in ipairs(Tabs) do
        MakePage(t[1])
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1,0,0,34)
        btn.BackgroundColor3 = Color3.fromRGB(0,0,0)
        btn.BackgroundTransparency = 1
        btn.Text = t[2].."  "..t[1]
        btn.TextColor3 = C.TextSub
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.TextSize = 12
        btn.Font = Enum.Font.GothamBold
        btn.BorderSizePixel = 0
        btn.Parent = Side
        Corner(btn, 7)
        local bp = Instance.new("UIPadding")
        bp.PaddingLeft = UDim.new(0,8)
        bp.Parent = btn
        TabBtns[t[1]] = btn
        btn.MouseButton1Click:Connect(function() SetTab(t[1]) end)
    end

    -- Toggle Builder
    local function Toggle(parent, label, key, desc, accentCol)
        local card = Instance.new("Frame")
        card.Size = UDim2.new(1,0,0, desc and 54 or 42)
        card.BackgroundColor3 = C.BG_Card
        card.BorderSizePixel = 0
        card.Parent = parent
        Corner(card, 8); Stroke(card, C.Border, 1)

        Lbl(card, {Size=UDim2.new(1,-70,0,22), Position=UDim2.new(0,10,0,6),
            Text=label, TextXAlignment=Enum.TextXAlignment.Left,
            TextSize=12, Font=Enum.Font.GothamBold})

        if desc then
            Lbl(card, {Size=UDim2.new(1,-70,0,18), Position=UDim2.new(0,10,0,28),
                Text=desc, TextColor3=C.TextDim,
                TextXAlignment=Enum.TextXAlignment.Left, TextSize=10})
        end

        local tb = Instance.new("TextButton")
        tb.Size = UDim2.new(0,48,0,24)
        tb.Position = UDim2.new(1,-58,0.5,-12)
        tb.BackgroundColor3 = C.OFF
        tb.Text = ""; tb.BorderSizePixel = 0
        tb.Parent = card; Corner(tb, 12)

        local circ = Instance.new("Frame")
        circ.Size = UDim2.new(0,18,0,18)
        circ.Position = UDim2.new(0,3,0.5,-9)
        circ.BackgroundColor3 = Color3.fromRGB(255,255,255)
        circ.BorderSizePixel = 0
        circ.Parent = tb; Corner(circ, 9)

        local onCol = accentCol or C.ON

        local function Refresh(v)
            Tween(tb, {BackgroundColor3 = v and onCol or C.OFF}, 0.2)
            Tween(circ, {Position = v and UDim2.new(0,27,0.5,-9) or UDim2.new(0,3,0.5,-9)}, 0.2)
        end

        tb.MouseButton1Click:Connect(function()
            if key then
                State.Toggles[key] = not State.Toggles[key]
                Refresh(State.Toggles[key])
                -- Stop old connection for this key
                if State.Connections[key] then
                    pcall(function() State.Connections[key]:Disconnect() end)
                    State.Connections[key] = nil
                end
                RunFeature(key, State.Toggles[key])
            end
        end)
        return card
    end

    -- ══════════════════════
    --   🌱 FARM PAGE
    -- ══════════════════════
    local FP = Pages["Farm"]
    Section(FP, "AUTO FARMING ADVANCED", C.Purple)

    Toggle(FP, "Auto Farm Advanced", "AutoFarmAdv",
        "Harvest otomatis + radius luas", C.Purple)

    Toggle(FP, "Auto Sell Premium", "AutoSellPrem",
        "Jual otomatis semua hasil panen", C.Green)

    Section(FP, "TELEPORT", C.Accent)
    Toggle(FP, "Seed Teleport", "SeedTeleport",
        "Teleport ke seed terdekat", C.Accent)

    -- Teleport button manual
    local tpCard = Instance.new("Frame")
    tpCard.Size = UDim2.new(1,0,0,42)
    tpCard.BackgroundColor3 = C.BG_Card
    tpCard.BorderSizePixel = 0
    tpCard.Parent = FP
    Corner(tpCard, 8); Stroke(tpCard, C.Border, 1)

    Lbl(tpCard, {Size=UDim2.new(1,-80,1,0), Position=UDim2.new(0,10,0,0),
        Text="🌾 Teleport ke Farm", TextXAlignment=Enum.TextXAlignment.Left,
        TextSize=12, Font=Enum.Font.GothamBold})

    local tpBtn = Instance.new("TextButton")
    tpBtn.Size = UDim2.new(0,62,0,26)
    tpBtn.Position = UDim2.new(1,-72,0.5,-13)
    tpBtn.BackgroundColor3 = C.Accent
    tpBtn.Text = "Teleport"
    tpBtn.TextColor3 = Color3.fromRGB(255,255,255)
    tpBtn.TextSize = 11
    tpBtn.Font = Enum.Font.GothamBold
    tpBtn.BorderSizePixel = 0
    tpBtn.Parent = tpCard
    Corner(tpBtn, 6)

    tpBtn.MouseButton1Click:Connect(function()
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Name:lower():find("farm") then
                HRP.CFrame = CFrame.new(obj.Position + Vector3.new(0,5,0))
                tpBtn.Text = "✓ Done"
                tpBtn.BackgroundColor3 = C.ON
                task.wait(1.5)
                tpBtn.Text = "Teleport"
                tpBtn.BackgroundColor3 = C.Accent
                break
            end
        end
    end)

    -- ══════════════════════
    --   👁 ESP PAGE
    -- ══════════════════════
    local EP = Pages["ESP"]
    Section(EP, "ITEM ESP", C.Gold)
    Toggle(EP, "Item ESP", "ItemESP",
        "Tampilkan label item & egg di map", C.Gold)

    local espInfo = Instance.new("Frame")
    espInfo.Size = UDim2.new(1,0,0,52)
    espInfo.BackgroundColor3 = C.BG_Card
    espInfo.BorderSizePixel = 0
    espInfo.Parent = EP
    Corner(espInfo, 8); Stroke(espInfo, C.Border, 1)
    Lbl(espInfo, {Size=UDim2.new(1,-16,1,0), Position=UDim2.new(0,8,0,0),
        Text="ℹ️  Item ESP menampilkan nama item\n(Egg, Seed, dll) di atas objek di map.",
        TextColor3=C.TextSub, TextXAlignment=Enum.TextXAlignment.Left,
        TextSize=11, TextWrapped=true})

    -- ══════════════════════
    --   ⚡ SPEED PAGE
    -- ══════════════════════
    local SPDP = Pages["Speed"]
    Section(SPDP, "SPEED HACK", C.Gold)
    Toggle(SPDP, "Speed Hack", "SpeedHack",
        "Tingkatkan kecepatan karakter (50)", C.Gold)

    -- Speed value display
    local spdCard = Instance.new("Frame")
    spdCard.Size = UDim2.new(1,0,0,52)
    spdCard.BackgroundColor3 = C.BG_Card
    spdCard.BorderSizePixel = 0
    spdCard.Parent = SPDP
    Corner(spdCard, 8); Stroke(spdCard, C.Border, 1)

    Lbl(spdCard, {Size=UDim2.new(0.5,0,1,0), Position=UDim2.new(0,10,0,0),
        Text="⚡ Walk Speed",
        TextXAlignment=Enum.TextXAlignment.Left,
        TextSize=12, Font=Enum.Font.GothamBold})

    local spdVal = Lbl(spdCard, {Size=UDim2.new(0.5,-10,1,0),
        Position=UDim2.new(0.5,0,0,0),
        Text="16 → 50",
        TextColor3=C.Gold,
        TextXAlignment=Enum.TextXAlignment.Right,
        TextSize=12, Font=Enum.Font.GothamBold})

    -- ══════════════════════
    --   💧 SPRINKLER PAGE
    -- ══════════════════════
    local SPRP = Pages["Sprinkler"]
    Section(SPRP, "INFINITE SPRINKLER", C.Accent)
    Toggle(SPRP, "Infinite Sprinkler", "InfiniteSprink",
        "Aktifkan semua sprinkler terus-menerus", C.Accent)

    local sprInfo = Instance.new("Frame")
    sprInfo.Size = UDim2.new(1,0,0,52)
    sprInfo.BackgroundColor3 = C.BG_Card
    sprInfo.BorderSizePixel = 0
    sprInfo.Parent = SPRP
    Corner(sprInfo, 8); Stroke(sprInfo, C.Border, 1)
    Lbl(sprInfo, {Size=UDim2.new(1,-16,1,0), Position=UDim2.new(0,8,0,0),
        Text="💧 Infinite Sprinkler otomatis mengaktifkan\nsemua sprinkler di farm tanpa henti.",
        TextColor3=C.TextSub, TextXAlignment=Enum.TextXAlignment.Left,
        TextSize=11, TextWrapped=true})

    -- ══════════════════════
    --   ⚙ SETTINGS PAGE
    -- ══════════════════════
    local SETP = Pages["Settings"]
    Section(SETP, "ABOUT", C.Purple)

    local about = Instance.new("Frame")
    about.Size = UDim2.new(1,0,0,95)
    about.BackgroundColor3 = C.BG_Card
    about.BorderSizePixel = 0
    about.Parent = SETP
    Corner(about, 8); Stroke(about, C.Purple, 1.5)

    Lbl(about, {Size=UDim2.new(1,-16,1,0), Position=UDim2.new(0,8,0,0),
        Text="⚡  Moon Hub | Special GaG\n"..
             "Versi  :  1.0\n"..
             "Game   :  Grow A Garden\n"..
             "Status :  Loadstring 2 — Key Needed 🔑\n"..
             "By     :  @Stick-figure-tdl",
        TextColor3=C.TextSub, TextXAlignment=Enum.TextXAlignment.Left,
        TextSize=11, TextWrapped=true})

    -- Stop All button
    local stopCard = Instance.new("Frame")
    stopCard.Size = UDim2.new(1,0,0,42)
    stopCard.BackgroundColor3 = C.BG_Card
    stopCard.BorderSizePixel = 0
    stopCard.Parent = SETP
    Corner(stopCard, 8); Stroke(stopCard, C.Red, 1)

    local stopBtn = Instance.new("TextButton")
    stopBtn.Size = UDim2.new(1,-20,0,28)
    stopBtn.Position = UDim2.new(0,10,0.5,-14)
    stopBtn.BackgroundColor3 = C.Red
    stopBtn.Text = "⛔  Stop Semua Fitur"
    stopBtn.TextColor3 = Color3.fromRGB(255,255,255)
    stopBtn.TextSize = 12
    stopBtn.Font = Enum.Font.GothamBold
    stopBtn.BorderSizePixel = 0
    stopBtn.Parent = stopCard
    Corner(stopBtn, 7)

    stopBtn.MouseButton1Click:Connect(function()
        StopAll()
        for k in pairs(State.Toggles) do State.Toggles[k] = false end
        stopBtn.Text = "✅ Semua Fitur Dihentikan"
        task.wait(2)
        stopBtn.Text = "⛔  Stop Semua Fitur"
    end)

    -- Minimize & Close
    MinBtn.MouseButton1Click:Connect(function()
        State.Minimized = not State.Minimized
        if State.Minimized then
            Tween(Win, {Size=UDim2.new(0,580,0,42)}, 0.3)
            MinBtn.Text = "□"
        else
            Tween(Win, {Size=UDim2.new(0,580,0,420)}, 0.3)
            MinBtn.Text = "─"
        end
    end)

    CloseBtn.MouseButton1Click:Connect(function()
        StopAll()
        Tween(Win, {Size=UDim2.new(0,580,0,0), BackgroundTransparency=1}, 0.3)
        task.wait(0.35)
        SG:Destroy()
    end)

    SetTab("Farm")
end

-- ═══════════════════════════════════════
--        RUN LOADING → BUILD GUI
-- ═══════════════════════════════════════
task.spawn(function()
    LoadStep("⚡ Initializing Special GaG...",  0.10, 0.5)
    LoadStep("🔗 Verifying key...",             0.30, 0.5)
    LoadStep("📦 Loading special modules...",   0.55, 0.5)
    LoadStep("🌾 Setting up features...",       0.78, 0.45)
    LoadStep("✅  Special GaG Ready!",          1.00, 0.35)

    for _, obj in ipairs(LF:GetDescendants()) do
        pcall(function()
            if obj:IsA("TextLabel") then Tween(obj,{TextTransparency=1},0.4) end
            if obj:IsA("Frame") then Tween(obj,{BackgroundTransparency=1},0.4) end
        end)
    end
    Tween(LF, {BackgroundTransparency=1}, 0.4)
    task.wait(0.5)
    LoadGui:Destroy()

    BuildSpecialGUI()
end)
