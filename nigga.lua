--[[
    WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
    Combined Script: Movement + Combat
    UPDATE: Bhop is suppressed while holding Longjump (E) and returns immediately when E is released.
]]

-- // SERVICES
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local v3_new = Vector3.new

-- // SCRIPT 1: MOVEMENT (START)
local WeaponsFolder = ReplicatedStorage:FindFirstChild("Weapons")


-- // TUNING & SETTINGS (MOVEMENT)
local LOCKED_SLIDE_SPEED = 18
local SMOOTH_FAC = 0.35 
local MAX_PX_SPEED = 22
local JUMP_COOLDOWN = 0.12 
local SCROLL_SPEED = 2.0
local EXPONENT, INTENSITY = 0.6, 18 


local BHOP_LOCK_SPEED = 18      
local DEFAULT_WALKSPEED = 18    
local DECAY_RATE = 0.85         
local FAST_FALL_SPEED, FALL_LERP = -50, 0.15

-- LONGJUMP TUNING
local LJ_FORWARD_VELOCITY = 65.0 
local LJ_UPWARD_VELOCITY = 30.0 

local binds = {
    eb = Enum.KeyCode.C, jb = Enum.KeyCode.Q, px = Enum.KeyCode.LeftShift,
    as = Enum.KeyCode.V, lj = Enum.KeyCode.E, bhop = Enum.KeyCode.B,
    toggleGui = Enum.KeyCode.Insert
}


local guiVisible = true
local slideActive, jumpbugActive, pixelsurfActive, airstuckActive, longjumpActive, bhopActive = false, false, false, false, false, false
local isLongjumping = false -- Used for indicator and cooldown tracking

local keysPressed = {W = false, A = false, S = false, D = false}
local lastJumpTime, lastSpeed, lastUpdate = 0, 0, 0
local lockedY, airstuckPos, slideBodyVelocity, slideCurrentVel = nil, nil, nil, Vector3.new(0,0,0)
local segments = {}


-- // HUD & GUI CONSTRUCTION (MOVEMENT SECTION)
local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
sg.Name = "randomshi / internal" 
sg.ResetOnSpawn = false


local velText = Instance.new("TextLabel", sg)
velText.Size, velText.Position = UDim2.new(0, 115, 0, 25), UDim2.new(0.5, -65, 0.55, 0)
velText.BackgroundTransparency, velText.TextColor3 = 1, Color3.fromRGB(255, 105, 180)
velText.Font, velText.TextSize = Enum.Font.SourceSansBold, 24
velText.Text = "0.00"
local vOut = Instance.new("UIStroke", velText)
vOut.Thickness, vOut.Color = 1.5, Color3.new(0,0,0)


local indContainer = Instance.new("Frame", sg)
indContainer.Size, indContainer.Position = UDim2.new(0, 250, 0, 20), UDim2.new(0.5, -125, 0.58, 0)
indContainer.BackgroundTransparency = 1
local layout = Instance.new("UIListLayout", indContainer)
layout.FillDirection, layout.HorizontalAlignment, layout.Padding = Enum.FillDirection.Horizontal, Enum.HorizontalAlignment.Center, UDim.new(0, 5)


local function createIndicator(name)
    local l = Instance.new("TextLabel", indContainer)
    l.Text, l.Size = name, UDim2.new(0, 28, 1, 0)
    l.Font, l.TextSize, l.TextColor3 = Enum.Font.SourceSansBold, 15, Color3.fromRGB(255, 105, 180)
    l.BackgroundTransparency = 1
    local out = Instance.new("UIStroke", l)
    out.Thickness, out.Color = 1.2, Color3.new(0,0,0)
    l.TextTransparency, out.Transparency = 1, 1
    return {Label = l, Stroke = out}
end


local inds = {
    eb = createIndicator("EB"), jb = createIndicator("JB"),
    px = createIndicator("PX"), lj = createIndicator("LJ"),
    as = createIndicator("AS"), bh = createIndicator("BH"), 
    ws = createIndicator("WS"), ns = createIndicator("NS") 
}


local graphContainer = Instance.new("Frame", sg)
graphContainer.Size, graphContainer.Position = UDim2.new(0, 550, 0, 150), UDim2.new(0.45, -275, 0.62, 0)
graphContainer.BackgroundTransparency, graphContainer.ClipsDescendants = 1, true


-- // MAIN MENU (WRAPPER)
local main = Instance.new("Frame", sg)
main.Size, main.Position = UDim2.new(0, 300, 0, 310), UDim2.new(0.05, 0, 0.1, 0)
main.BackgroundColor3, main.BorderSizePixel = Color3.fromRGB(255, 105, 180), 0
main.Name = "MovementFrame"
main.Active = true

local top = Instance.new("Frame", main)
top.Size, top.BackgroundColor3 = UDim2.new(1, 0, 0, 25), Color3.new(1, 1, 1)
top.ZIndex = 2

local title = Instance.new("TextLabel", top)
title.Size, title.Position = UDim2.new(1, -10, 1, 0), UDim2.new(0, 10, 0, 0)
title.Text = "randomshi / internal"
title.TextColor3 = Color3.new(0,0,0)
title.Font, title.TextSize, title.BackgroundTransparency = Enum.Font.SourceSansBold, 16, 1
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 2
title.Active = true

-- TAB BUTTONS (Added to Top)
local tabBtnMove = Instance.new("TextButton", top)
tabBtnMove.Size, tabBtnMove.Position, tabBtnMove.BackgroundColor3 = UDim2.new(0, 70, 0, 20), UDim2.new(1, -140, 0, 2), Color3.fromRGB(200, 200, 200)
tabBtnMove.Text = "Movement"
tabBtnMove.TextSize = 14
tabBtnMove.Font = Enum.Font.SourceSansBold
tabBtnMove.TextColor3 = Color3.new(0,0,0)
tabBtnMove.ZIndex = 2
tabBtnMove.Active = true

local tabBtnCombat = Instance.new("TextButton", top)
tabBtnCombat.Size, tabBtnCombat.Position, tabBtnCombat.BackgroundColor3 = UDim2.new(0, 60, 0, 20), UDim2.new(1, -65, 0, 2), Color3.fromRGB(255, 105, 180)
tabBtnCombat.Text, tabBtnCombat.TextSize = "Combat", 14
tabBtnCombat.Font = Enum.Font.SourceSansBold
tabBtnCombat.TextColor3 = Color3.new(1,1,1)
tabBtnCombat.ZIndex = 2
tabBtnCombat.Active = true

local scroll = Instance.new("ScrollingFrame", main)
scroll.Size, scroll.Position = UDim2.new(1, -20, 1, -45), UDim2.new(0, 10, 0, 35)
scroll.BackgroundColor3, scroll.ScrollBarThickness = Color3.new(1, 1, 1), 6
scroll.ScrollBarImageColor3 = Color3.fromRGB(255, 105, 180)
Instance.new("UIListLayout", scroll).Padding = UDim.new(0, 8)


local function createBindRow(id, labelName)
    local row = Instance.new("Frame", scroll)
    row.Size, row.BackgroundColor3 = UDim2.new(1, -5, 0, 40), Color3.new(1, 1, 1)
    local txt = Instance.new("TextLabel", row)
    txt.Size, txt.Position = UDim2.new(0.6, 0, 1, 0), UDim2.new(0, 10, 0, 0)
    txt.Text, txt.TextColor3, txt.Font, txt.TextSize = labelName, Color3.new(0, 0, 0), Enum.Font.SourceSansBold, 18
    txt.BackgroundTransparency, txt.TextXAlignment = 1, Enum.TextXAlignment.Left
    local btn = Instance.new("TextButton", row)
    btn.Size, btn.Position = UDim2.new(0, 80, 0, 28), UDim2.new(1, -90, 0.15, 0)
    btn.BackgroundColor3, btn.Text, btn.TextColor3 = Color3.fromRGB(255, 105, 180), binds[id].Name, Color3.new(1, 1, 1)
    btn.Font, btn.TextSize = Enum.Font.SourceSansBold, 16
    btn.MouseButton1Click:Connect(function()
        btn.Text = "..."
        local conn; conn = UserInputService.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Keyboard then
                binds[id] = input.KeyCode 
                btn.Text = input.KeyCode.Name 
                conn:Disconnect()
            end
        end)
    end)
end


createBindRow("eb", "SLIDE/EB"); createBindRow("jb", "JUMPBUG"); createBindRow("px", "PIXELSURF")
createBindRow("as", "AIRSTUCK"); createBindRow("lj", "LONGJUMP"); createBindRow("bhop", "BHOP")


-- // SCRIPT 2: AIMBOT & SKELETON ESP (START)
local aimbotEnabled = false
local aimPartOption = "Head"      
local circleRadius = 120 
local smoothness = 0.15 
local aimbotMode = "Hold"        
local activationKey = Enum.UserInputType.MouseButton2 
local skeletonEspEnabled = false
local noSpreadEnabled = true
local fovVisible = true
local waitingForActKey = false

local holdingKey = false
local target = nil               
local toggleActive = false       
local skeletons = {} 
local aimCandidates = {"Head", "Torso"} 

local circle = Drawing.new("Circle")
circle.Thickness = 1.5
circle.NumSides = 64
circle.Radius = circleRadius
circle.Color = Color3.fromRGB(255, 105, 180) 
circle.Filled = false
circle.Visible = fovVisible
circle.Transparency = 0.8

-- // NOSPREAD LOGIC (Active Function)
local function noSpread(weapon)
    if noSpreadEnabled then
        local spread = weapon:FindFirstChild("Spread")
        if spread then
            for _, v in ipairs(spread:GetDescendants()) do
                if v:IsA("NumberValue") then
                    v.Value = 0
                end
            end
        end
    end
end

if WeaponsFolder then
    for _, weapon in ipairs(WeaponsFolder:GetChildren()) do
        noSpread(weapon)
    end
    WeaponsFolder.ChildAdded:Connect(function(weapon)
        noSpread(weapon)
    end)
end


-- // COMBAT FRAME (Second Section)
local combatFrame = Instance.new("Frame", sg)
combatFrame.Name = "CombatFrame"
combatFrame.Size = main.Size
combatFrame.Position = main.Position
combatFrame.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
combatFrame.BorderSizePixel = 0
combatFrame.Visible = false
combatFrame.Active = true

local cTop = Instance.new("Frame", combatFrame)
cTop.Size, cTop.BackgroundColor3 = UDim2.new(1, 0, 0, 25), Color3.new(1, 1, 1)
cTop.ZIndex = 2

local cTitle = Instance.new("TextLabel", cTop)
cTitle.Size, cTitle.Position = UDim2.new(1, -10, 1, 0), UDim2.new(0, 10, 0, 0)
cTitle.Text = "randomshi / internal"
cTitle.TextColor3 = Color3.new(0,0,0)
cTitle.Font, cTitle.TextSize, cTitle.BackgroundTransparency = Enum.Font.SourceSansBold, 16, 1
cTitle.TextXAlignment = Enum.TextXAlignment.Left
cTitle.ZIndex = 2
cTitle.Active = true

local cTabBtnMove = Instance.new("TextButton", cTop)
cTabBtnMove.Size, cTabBtnMove.Position, cTabBtnMove.BackgroundColor3 = UDim2.new(0, 70, 0, 20), UDim2.new(1, -140, 0, 2), Color3.fromRGB(255, 105, 180)
cTabBtnMove.Text = "Movement"
cTabBtnMove.TextSize = 14
cTabBtnMove.Font = Enum.Font.SourceSansBold
cTabBtnMove.TextColor3 = Color3.new(1,1,1)
cTabBtnMove.ZIndex = 2
cTabBtnMove.Active = true

local cTabBtnCombat = Instance.new("TextButton", cTop)
cTabBtnCombat.Size, cTabBtnCombat.Position, cTabBtnCombat.BackgroundColor3 = UDim2.new(0, 60, 0, 20), UDim2.new(1, -65, 0, 2), Color3.fromRGB(200, 200, 200)
cTabBtnCombat.Text, cTabBtnCombat.TextSize = "Combat", 14
cTabBtnCombat.Font = Enum.Font.SourceSansBold
cTabBtnCombat.TextColor3 = Color3.new(0,0,0)
cTabBtnCombat.ZIndex = 2
cTabBtnCombat.Active = true

local cScroll = Instance.new("ScrollingFrame", combatFrame)
cScroll.Size, cScroll.Position = UDim2.new(1, -20, 1, -45), UDim2.new(0, 10, 0, 35)
cScroll.BackgroundColor3, cScroll.ScrollBarThickness = Color3.new(1, 1, 1), 6
cScroll.ScrollBarImageColor3 = Color3.fromRGB(255, 105, 180)
Instance.new("UIListLayout", cScroll).Padding = UDim.new(0, 5)

local function createCombatBtn(name, posY, text, color, txtColor)
    local btn = Instance.new("TextButton", cScroll)
    btn.Size, btn.Position = UDim2.new(0.9, 0, 0, 30), UDim2.new(0.05, 0, UDim.new(0, posY))
    btn.Text, btn.BackgroundColor3, btn.TextColor3 = text, color, txtColor or Color3.new(1, 1, 1)
    btn.Font, btn.TextSize = Enum.Font.SourceSansBold, 16
    return btn
end

-- Combat UI Elements
local toggleButton = createCombatBtn("AimbotToggle", 0, "Aimbot: OFF", Color3.new(1,1,1), Color3.new(0,0,0))
toggleButton.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    if aimbotEnabled then
        toggleButton.Text = "Aimbot: ON"
        toggleButton.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
        toggleButton.TextColor3 = Color3.new(1,1,1)
    else
        toggleButton.Text = "Aimbot: OFF"
        toggleButton.BackgroundColor3 = Color3.new(1,1,1)
        toggleButton.TextColor3 = Color3.new(0,0,0)
        toggleActive = false
        target = nil
    end
end)

local modeButton = createCombatBtn("Mode", 35, "Mode: Hold", Color3.fromRGB(70, 70, 70), Color3.new(1,1,1))
modeButton.MouseButton1Click:Connect(function()
    aimbotMode = (aimbotMode == "Hold" and "Toggle" or "Hold")
    modeButton.Text = "Mode: " .. aimbotMode
    toggleActive = false
    target = nil
end)

local keyButton = createCombatBtn("ActKey", 70, "Activation: Right Click", Color3.fromRGB(70, 70, 70), Color3.new(1,1,1))
keyButton.MouseButton1Click:Connect(function()
    waitingForActKey = true
    keyButton.Text = "Press any key..."
end)

local aimPartButton = createCombatBtn("AimPart", 105, "Aim Part: Head", Color3.fromRGB(70, 70, 70), Color3.new(1,1,1))
aimPartButton.MouseButton1Click:Connect(function()
    if aimPartOption == "Head" then aimPartOption = "Torso"
    else aimPartOption = "Head" end
    aimPartButton.Text = "Aim Part: " .. aimPartOption
end)

-- SENSITIVITY SLIDER CREATION (0.00 - 1.00)
local sliderContainer = Instance.new("Frame", cScroll)
sliderContainer.Size = UDim2.new(0.9, 0, 0, 30)
sliderContainer.Position = UDim2.new(0.05, 0, UDim.new(0, 140))
sliderContainer.BackgroundTransparency = 1

local sliderLabel = Instance.new("TextLabel", sliderContainer)
sliderLabel.Size = UDim2.new(0.4, 0, 1, 0)
sliderLabel.Text = "Sens: 0.15"
sliderLabel.TextColor3 = Color3.new(0,0,0)
sliderLabel.BackgroundTransparency = 1
sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
sliderLabel.Font = Enum.Font.SourceSansBold
sliderLabel.TextSize = 16

local sliderBar = Instance.new("TextButton", sliderContainer)
sliderBar.Size = UDim2.new(0.55, 0, 0, 10)
sliderBar.Position = UDim2.new(0.45, 0, 0.5, -5)
sliderBar.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
sliderBar.AutoButtonColor = false
sliderBar.Text = ""

local sliderFill = Instance.new("Frame", sliderBar)
sliderFill.Size = UDim2.new(smoothness, 0, 1, 0)
sliderFill.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
sliderFill.BorderSizePixel = 0

-- Slider Logic
local sliding = false
sliderBar.MouseButton1Down:Connect(function()
    sliding = true
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        sliding = false
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if sliding and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mousePos = UserInputService:GetMouseLocation()
        local barPos = sliderBar.AbsolutePosition
        local barSize = sliderBar.AbsoluteSize
        local percent = math.clamp((mousePos.X - barPos.X) / barSize.X, 0, 1)
        
        smoothness = math.floor(percent * 100) / 100
        sliderLabel.Text = "Sens: " .. string.format("%.2f", smoothness)
        sliderFill.Size = UDim2.new(percent, 0, 1, 0)
    end
end)

local skeletonButton = createCombatBtn("Skeleton", 175, "Skeleton ESP: OFF", Color3.fromRGB(70, 70, 70), Color3.new(1,1,1))
skeletonButton.MouseButton1Click:Connect(function()
    skeletonEspEnabled = not skeletonEspEnabled
    if skeletonEspEnabled then
        skeletonButton.Text = "Skeleton ESP: ON"
        skeletonButton.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
    else
        skeletonButton.Text = "Skeleton ESP: OFF"
        skeletonButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        for pl, lines in pairs(skeletons) do
            for _, line in pairs(lines) do line:Remove() end
            skeletons[pl] = nil
        end
    end
end)

-- FOV TOGGLE BUTTON
local fovButton = createCombatBtn("FovToggle", 210, "FOV: Visible", Color3.fromRGB(70, 70, 70), Color3.new(1,1,1))
fovButton.MouseButton1Click:Connect(function()
    fovVisible = not fovVisible
    circle.Visible = fovVisible
    fovButton.Text = "FOV: " .. (fovVisible and "Visible" or "Hidden")
end)

-- FOV SLIDER (0 - 500)
local fovSliderContainer = Instance.new("Frame", cScroll)
fovSliderContainer.Size = UDim2.new(0.9, 0, 0, 30)
fovSliderContainer.Position = UDim2.new(0.05, 0, UDim.new(0, 245))
fovSliderContainer.BackgroundTransparency = 1

local fovSliderLabel = Instance.new("TextLabel", fovSliderContainer)
fovSliderLabel.Size = UDim2.new(0.4, 0, 1, 0)
fovSliderLabel.Text = "Size: 120"
fovSliderLabel.TextColor3 = Color3.new(0,0,0)
fovSliderLabel.BackgroundTransparency = 1
fovSliderLabel.TextXAlignment = Enum.TextXAlignment.Left
fovSliderLabel.Font = Enum.Font.SourceSansBold
fovSliderLabel.TextSize = 16

local fovSliderBar = Instance.new("TextButton", fovSliderContainer)
fovSliderBar.Size = UDim2.new(0.55, 0, 0, 10)
fovSliderBar.Position = UDim2.new(0.45, 0, 0.5, -5)
fovSliderBar.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
fovSliderBar.AutoButtonColor = false
fovSliderBar.Text = ""

local fovSliderFill = Instance.new("Frame", fovSliderBar)
fovSliderFill.Size = UDim2.new(circleRadius / 500, 0, 1, 0)
fovSliderFill.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
fovSliderFill.BorderSizePixel = 0

-- FOV Slider Logic
local fovSliding = false
fovSliderBar.MouseButton1Down:Connect(function()
    fovSliding = true
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        fovSliding = false
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if fovSliding and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mousePos = UserInputService:GetMouseLocation()
        local barPos = fovSliderBar.AbsolutePosition
        local barSize = fovSliderBar.AbsoluteSize
        local percent = math.clamp((mousePos.X - barPos.X) / barSize.X, 0, 1)
        
        local newVal = math.floor(percent * 500)
        circleRadius = newVal
        circle.Radius = newVal
        
        fovSliderLabel.Text = "Size: " .. newVal
        fovSliderFill.Size = UDim2.new(percent, 0, 1, 0)
    end
end)


-- // TAB SWITCHING LOGIC
local function switchTab(tab)
    if tab == "Move" then
        main.Visible = true
        combatFrame.Visible = false
        tabBtnMove.BackgroundColor3 = Color3.fromRGB(255, 105, 180) tabBtnMove.TextColor3 = Color3.new(1,1,1)
        tabBtnCombat.BackgroundColor3 = Color3.fromRGB(200, 200, 200) tabBtnCombat.TextColor3 = Color3.new(0,0,0)
        cTabBtnMove.BackgroundColor3 = Color3.fromRGB(255, 105, 180) cTabBtnMove.TextColor3 = Color3.new(1,1,1)
        cTabBtnCombat.BackgroundColor3 = Color3.fromRGB(200, 200, 200) cTabBtnCombat.TextColor3 = Color3.new(0,0,0)
    else
        main.Visible = false
        combatFrame.Visible = true
        tabBtnMove.BackgroundColor3 = Color3.fromRGB(200, 200, 200) tabBtnMove.TextColor3 = Color3.new(0,0,0)
        tabBtnCombat.BackgroundColor3 = Color3.fromRGB(255, 105, 180) tabBtnCombat.TextColor3 = Color3.new(1,1,1)
        cTabBtnMove.BackgroundColor3 = Color3.fromRGB(200, 200, 200) cTabBtnMove.TextColor3 = Color3.new(0,0,0)
        cTabBtnCombat.BackgroundColor3 = Color3.fromRGB(255, 105, 180) cTabBtnCombat.TextColor3 = Color3.new(1,1,1)
    end
end

tabBtnMove.MouseButton1Click:Connect(function() switchTab("Move") end)
tabBtnCombat.MouseButton1Click:Connect(function() switchTab("Combat") end)
cTabBtnMove.MouseButton1Click:Connect(function() switchTab("Move") end)
cTabBtnCombat.MouseButton1Click:Connect(function() switchTab("Combat") end)

-- // DRAGGING & RESIZING LOGIC
local dragToggle = nil
local dragStart = nil
local startPos = nil

local resizing = false
local resizeDir = ""
local resizeStart = nil
local resizeStartPos = nil
local resizeStartSize = nil
local MIN_W, MIN_H = 150, 100

-- Dragging Logic
local function updateDrag(input)
    local delta = input.Position - dragStart
    local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    main.Position = position
    combatFrame.Position = position
end

local function makeDraggable(frame)
    frame.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1) then
            dragToggle = true
            dragStart = input.Position
            startPos = main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragToggle = false
                end
            end)
        end
    end)
end

makeDraggable(top)
makeDraggable(title)
makeDraggable(tabBtnMove)
makeDraggable(tabBtnCombat)
makeDraggable(cTop)
makeDraggable(cTitle)
makeDraggable(cTabBtnMove)
makeDraggable(cTabBtnCombat)

-- Resizing Logic (8-Way)
local function createResizeHandles(frame)
    local s = 10 
    local dirs = {
        {Name="TL", Pos=UDim2.new(0, -s/2, 0, -s/2), Size=UDim2.new(0, s, 0, s)},
        {Name="T",  Pos=UDim2.new(0.5, -s/2, 0, -s/2), Size=UDim2.new(1, s, 0, s)},
        {Name="TR", Pos=UDim2.new(1, -s/2, 0, -s/2), Size=UDim2.new(0, s, 0, s)},
        {Name="L",  Pos=UDim2.new(0, -s/2, 0.5, -s/2), Size=UDim2.new(0, s, 1, s)},
        {Name="R",  Pos=UDim2.new(1, -s/2, 0.5, -s/2), Size=UDim2.new(0, s, 1, s)},
        {Name="BL", Pos=UDim2.new(0, -s/2, 1, -s/2), Size=UDim2.new(0, s, 0, s)},
        {Name="B",  Pos=UDim2.new(0.5, -s/2, 1, -s/2), Size=UDim2.new(1, s, 0, s)},
        {Name="BR", Pos=UDim2.new(1, -s/2, 1, -s/2), Size=UDim2.new(0, s, 0, s)},
    }

    for _, data in ipairs(dirs) do
        local h = Instance.new("TextButton", frame)
        h.Name = data.Name
        h.Size = data.Size
        h.Position = data.Pos
        h.BackgroundTransparency = 1
        h.Text = ""
        h.ZIndex = 20
        h.Active = true
        h.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 then
                resizing = true
                resizeDir = data.Name
                resizeStart = i.Position
                resizeStartPos = Vector2.new(frame.Position.X.Offset, frame.Position.Y.Offset)
                resizeStartSize = Vector2.new(frame.Size.X.Offset, frame.Size.Y.Offset)
            end
        end)
    end
end

createResizeHandles(main)
createResizeHandles(combatFrame)

UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        resizing = false
        resizeDir = ""
    end
end)

RunService.RenderStepped:Connect(function()
    local input = UserInputService:GetMouseLocation() 
    
    if resizing then
        local delta = input - resizeStart
        local newX, newY, newW, newH = resizeStartPos.X, resizeStartPos.Y, resizeStartSize.X, resizeStartSize.Y
        
        if resizeDir:find("R") then
            newW = math.max(MIN_W, resizeStartSize.X + delta.X)
        end
        if resizeDir:find("L") then
            local dX = -delta.X
            if (resizeStartSize.X + dX) >= MIN_W then
                newX = resizeStartPos.X + delta.X
                newW = resizeStartSize.X + dX
            end
        end
        if resizeDir:find("B") then
            newH = math.max(MIN_H, resizeStartSize.Y + delta.Y)
        end
        if resizeDir:find("T") then
            local dY = -delta.Y
            if (resizeStartSize.Y + dY) >= MIN_H then
                newY = resizeStartPos.Y + delta.Y
                newH = resizeStartSize.Y + dY
            end
        end
        
        local finalPos = UDim2.new(0, newX, 0, newY)
        local finalSize = UDim2.new(0, newW, 0, newH)
        main.Position = finalPos
        main.Size = finalSize
        combatFrame.Position = finalPos
        combatFrame.Size = finalSize
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        if dragToggle then
            updateDrag(input)
        end
    end
end)


-- // GRAPH LOGIC
local function updateGraph(s)
    local maxHeight = 150
    local targetY = maxHeight - math.clamp(s^EXPONENT * INTENSITY, 5, maxHeight - 5)
    local prevY = maxHeight - math.clamp(lastSpeed^EXPONENT * INTENSITY, 5, maxHeight - 5)
    local line = Instance.new("Frame", graphContainer)
    line.BorderSizePixel, line.BackgroundColor3 = 0, Color3.fromRGB(255, 105, 180)
    local diff = targetY - prevY
    line.Size = UDim2.new(0, SCROLL_SPEED + 0.5, 0, math.abs(diff) + 1.5)
    line.Position = UDim2.new(0, 548, 0, math.min(targetY, prevY))
    table.insert(segments, line)
    if #segments > 180 then segments[1]:Destroy() table.remove(segments, 1) end
    for i = 1, #segments do segments[i].Position = segments[i].Position - UDim2.new(0, SCROLL_SPEED, 0, 0) end
    lastSpeed = s
end


-- // INPUTS (MERGED)
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    local k = input.KeyCode
    
    -- Movement Binds
    if k == binds.toggleGui then
        guiVisible = not guiVisible
        main.Visible, graphContainer.Visible, indContainer.Visible, velText.Visible, combatFrame.Visible = guiVisible, guiVisible, guiVisible, guiVisible, guiVisible and not main.Visible
        if not guiVisible then combatFrame.Visible = false end
    elseif k == binds.eb then slideActive = true
    elseif k == binds.jb then jumpbugActive = true
    elseif k == binds.px then pixelsurfActive = true
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then lockedY = player.Character.HumanoidRootPart.Position.Y end
    elseif k == binds.as then
        airstuckActive = not airstuckActive
        if airstuckActive and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then airstuckPos = player.Character.HumanoidRootPart.CFrame else airstuckPos = nil end
    elseif k == binds.lj then longjumpActive = true
    elseif k == binds.bhop then bhopActive = not bhopActive
    elseif k == Enum.KeyCode.W then keysPressed.W = true
    elseif k == Enum.KeyCode.A then keysPressed.A = true
    elseif k == Enum.KeyCode.S then keysPressed.S = true
    elseif k == Enum.KeyCode.D then keysPressed.D = true 
    
    -- Combat Inputs (Key Binding)
    elseif waitingForActKey then
        waitingForActKey = false
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            activationKey = Enum.UserInputType.MouseButton1
            keyButton.Text = "Key: Left Click"
        elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
            activationKey = Enum.UserInputType.MouseButton2
            keyButton.Text = "Key: Right Click"
        elseif input.UserInputType == Enum.UserInputType.MouseButton3 then
            activationKey = Enum.UserInputType.MouseButton3
            keyButton.Text = "Key: Middle Click"
        elseif input.UserInputType == Enum.UserInputType.Keyboard then
            activationKey = input.KeyCode
            keyButton.Text = "Key: " .. activationKey.Name
        else
            keyButton.Text = "Key: Right Click"
            activationKey = Enum.UserInputType.MouseButton2
        end
        
    elseif input.UserInputType == activationKey or input.KeyCode == activationKey then
        if aimbotMode == "Hold" then
            holdingKey = true
        else
            toggleActive = not toggleActive
            if toggleActive then acquireTarget() else clearTarget() end
        end
    end
end)


UserInputService.InputEnded:Connect(function(input)
    local k = input.KeyCode
    if k == binds.eb then slideActive = false
    elseif k == binds.jb then jumpbugActive = false
    elseif k == binds.px then pixelsurfActive = false lockedY = nil
    elseif k == binds.lj then longjumpActive = false
    elseif k == Enum.KeyCode.W then keysPressed.W = false
    elseif k == Enum.KeyCode.A then keysPressed.A = false
    elseif k == Enum.KeyCode.S then keysPressed.S = false
    elseif k == Enum.KeyCode.D then keysPressed.D = false
    elseif input.UserInputType == activationKey or input.KeyCode == activationKey then
        if aimbotMode == "Hold" then holdingKey = false end
    end
end)


-- // ENGINE: MOVEMENT
RunService.Heartbeat:Connect(function(dt)
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")
    if not root or not hum then return end

    if hum.WalkSpeed ~= 20 then hum.WalkSpeed = 20 end

    local hVel = Vector3.new(root.Velocity.X, 0, root.Velocity.Z)
    local hSpeed = hVel.Magnitude

    lastUpdate = lastUpdate + dt
    if lastUpdate >= 0.033 then
        lastUpdate = 0
        if guiVisible then
            velText.Text = string.format("%.2f", hSpeed)
            updateGraph(hSpeed)
            
            -- Calculate Effective Bhop: Bhop is ON if toggle is ON and E is NOT held
            local effectiveBhop = bhopActive and not longjumpActive
            
            local states = {
                eb = slideActive, jb = jumpbugActive, px = pixelsurfActive, 
                lj = longjumpActive or isLongjumping, as = airstuckActive, 
                bh = bhopActive, ws = true, ns = noSpreadEnabled
            }
            for id, active in pairs(states) do
                if inds[id] then
                    inds[id].Label.TextTransparency = active and 0 or 1
                    inds[id].Stroke.Transparency = active and 0 or 1
                end
            end
        end
    end

    if airstuckActive and airstuckPos then root.CFrame, root.Velocity = airstuckPos, Vector3.zero return end

    local onGround = (hum.FloorMaterial ~= Enum.Material.Air)
    local now = tick()

    -- Reset physics longjump state on ground
    if onGround then
        isLongjumping = false
    end

    -- CALCULATE EFFECTIVE BHOP STATE
    -- If user holds E (longjumpActive), Bhop logic is paused to allow high speed
    -- If user releases E (not longjumpActive), Bhop logic returns immediately
    local effectiveBhop = bhopActive and not longjumpActive

    -- BHOP Logic (Only runs if effectiveBhop is true)
    if effectiveBhop then
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) and onGround then
            hum.Jump = true
            if keysPressed.W then
                local look = root.CFrame.LookVector
                root.Velocity = Vector3.new(look.X * BHOP_LOCK_SPEED, root.Velocity.Y, look.Z * BHOP_LOCK_SPEED)
            end
        elseif not onGround then
            if hSpeed > BHOP_LOCK_SPEED then
                local capped = hVel.Unit * BHOP_LOCK_SPEED
                root.Velocity = Vector3.new(capped.X, root.Velocity.Y, capped.Z)
            end
        elseif onGround and hSpeed > 18 then 
            local newS = math.max(18, hSpeed * DECAY_RATE)
            root.Velocity = Vector3.new(hVel.Unit.X * newS, root.Velocity.Y, hVel.Unit.Z * newS)
        end
    end

    -- LONGJUMP Logic
    if onGround and (now - lastJumpTime) > JUMP_COOLDOWN then
        if longjumpActive then 
            lastJumpTime = now
            isLongjumping = true -- Set physics flag
            
            hum.Jump = true
            
            local lookDir = root.CFrame.LookVector
            -- Apply high velocity vector
            root.Velocity = Vector3.new(lookDir.X * LJ_FORWARD_VELOCITY, LJ_UPWARD_VELOCITY, lookDir.Z * LJ_FORWARD_VELOCITY)
            return
        elseif jumpbugActive then 
            lastJumpTime = now
            root.Velocity = Vector3.new(root.Velocity.X, 33, root.Velocity.Z) 
        end
    end

    if slideActive and root.Velocity.Y < -5 then
        root.Velocity = root.Velocity:Lerp(Vector3.new(root.Velocity.X, FAST_FALL_SPEED, root.Velocity.Z), FALL_LERP)
    end

    if slideActive then
        if not slideBodyVelocity then 
            slideBodyVelocity = Instance.new("BodyVelocity", root)
            slideBodyVelocity.MaxForce = Vector3.new(1e7, 0, 1e7)
        end
        local camCF = camera.CFrame
        local moveDir = (Vector3.new(camCF.LookVector.X, 0, camCF.LookVector.Z).Unit * (keysPressed.W and 1 or (keysPressed.S and -1 or 0))) + 
                        (Vector3.new(camCF.RightVector.X, 0, camCF.RightVector.Z).Unit * (keysPressed.D and 1 or (keysPressed.A and -1 or 0)))
        local targetVel = (moveDir.Magnitude > 0 and moveDir.Unit or Vector3.new(camCF.LookVector.X, 0, camCF.LookVector.Z).Unit) * LOCKED_SLIDE_SPEED
        slideCurrentVel = slideCurrentVel:Lerp(targetVel, SMOOTH_FAC)
        slideBodyVelocity.Velocity = Vector3.new(slideCurrentVel.X, 0, slideCurrentVel.Z)
        
        if root.Velocity.Y < -5 then
            root.Velocity = root.Velocity:Lerp(Vector3.new(root.Velocity.X, FAST_FALL_SPEED, root.Velocity.Z), FALL_LERP)
        end
    else
        local currentSpeed = slideCurrentVel.Magnitude
        if slideBodyVelocity then
            slideBodyVelocity:Destroy()
            slideBodyVelocity = nil
        end
        if currentSpeed > 1 then
            local preserveBV = Instance.new("BodyVelocity", root)
            preserveBV.MaxForce = Vector3.new(4e4, 0, 4e4)
            preserveBV.Velocity = Vector3.new(slideCurrentVel.X, 0, slideCurrentVel.Z)
            Debris:AddItem(preserveBV, 0.1)
        end
        slideCurrentVel = Vector3.new(0, 0, 0)
    end

    if pixelsurfActive and lockedY then
        local bp = Instance.new("BodyPosition", root)
        bp.MaxForce, bp.Position = Vector3.new(0, 40000, 0), Vector3.new(root.Position.X, lockedY, root.Position.Z)
        Debris:AddItem(bp, 0.03)
        local bv = Instance.new("BodyVelocity", root)
        bv.MaxForce, bv.Velocity = Vector3.new(10000, 0, 10000), root.CFrame.LookVector * MAX_PX_SPEED
        Debris:AddItem(bv, 0.03)
    end
end)

-- // ENGINE: AIMBOT & SKELETON ESP
local function findAimPartInCharacter(character, wantPartName)
    if not character then return nil end
    if wantPartName == "Head" then return character:FindFirstChild("Head")
    elseif wantPartName == "Torso" then return character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso") or character:FindFirstChild("LowerTorso")
    else
        local choice = aimCandidates[math.random(1, #aimCandidates)]
        return findAimPartInCharacter(character, choice)
    end
end

local function isPartValid(p)
    if not p then return false end
    if not p:IsDescendantOf(workspace) then return false end
    local model = p:FindFirstAncestorOfClass("Model")
    if not model then return false end
    local humanoid = model:FindFirstChildOfClass("Humanoid")
    if not humanoid then return false end
    if humanoid.Health <= 0 then return false end
    return true
end

local function getClosestToMouse()
    local closest, dist = nil, circleRadius
    local mousePos = UserInputService:GetMouseLocation()
    for _, otherPlayer in ipairs(Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Team ~= player.Team and otherPlayer.Character then 
            local part = findAimPartInCharacter(otherPlayer.Character, aimPartOption)
            if part then
                local screenPoint, onScreen = camera:WorldToViewportPoint(part.Position)
                if onScreen then
                    local mag = (Vector2.new(screenPoint.X, screenPoint.Y) - mousePos).Magnitude
                    if mag < dist then dist = mag closest = part end
                end
            end
        end
    end
    return closest
end

local function acquireTarget()
    local p = getClosestToMouse()
    if isPartValid(p) then target = p return true end
    target = nil return false
end

local function clearTarget() target = nil end

local function updateSkeleton(playerObj)
    if not skeletonEspEnabled then return end
    local char = playerObj.Character
    if not char then return end

    local color = Color3.fromRGB(255, 105, 180)

    local joints = {}
    local isR15 = char:FindFirstChild("UpperTorso") ~= nil

    if isR15 then
        joints = {
            {"Head", "UpperTorso"},
            {"UpperTorso", "LowerTorso"},
            {"UpperTorso", "LeftUpperArm"},
            {"LeftUpperArm", "LeftLowerArm"},
            {"LeftLowerArm", "LeftHand"},
            {"UpperTorso", "RightUpperArm"},
            {"RightUpperArm", "RightLowerArm"},
            {"RightLowerArm", "RightHand"},
            {"LowerTorso", "LeftUpperLeg"},
            {"LeftUpperLeg", "LeftLowerLeg"},
            {"LeftLowerLeg", "LeftFoot"},
            {"LowerTorso", "RightUpperLeg"},
            {"RightUpperLeg", "RightLowerLeg"},
            {"RightLowerLeg", "RightFoot"},
        }
    else 
        joints = {
            {"Head", "Torso"},
            {"Torso", "Left Arm"},
            {"Left Arm", "Left Leg"}, 
            {"Torso", "Right Arm"},
            {"Right Arm", "Right Leg"},
            {"Torso", "Left Leg"},
            {"Torso", "Right Leg"},
        }
    end

    if not skeletons[playerObj] then skeletons[playerObj] = {} end
    local lineTable = skeletons[playerObj]

    while #lineTable < #joints do
        local line = Drawing.new("Line")
        line.Thickness = 1.5
        line.Color = color
        table.insert(lineTable, line)
    end

    for i, jointPair in ipairs(joints) do
        local p1 = char:FindFirstChild(jointPair[1])
        local p2 = char:FindFirstChild(jointPair[2])

        local line = lineTable[i]
        if p1 and p2 then
            local s1, onScreen1 = camera:WorldToViewportPoint(p1.Position)
            local s2, onScreen2 = camera:WorldToViewportPoint(p2.Position)

            if onScreen1 and onScreen2 then
                line.From = Vector2.new(s1.X, s1.Y)
                line.To = Vector2.new(s2.X, s2.Y)
                line.Visible = true
                line.Color = color
            else
                line.Visible = false
            end
        else
            line.Visible = false
        end
    end
end

local function refreshAllESP()
    if not skeletonEspEnabled then return end
    for _, pl in ipairs(Players:GetPlayers()) do
        if pl ~= player and pl.Team ~= player.Team and pl.Character then
            if not skeletons[pl] then updateSkeleton(pl) end
        else
            if skeletons[pl] then
                for _, line in pairs(skeletons[pl]) do line:Remove() end
                skeletons[pl] = nil
            end
        end
    end
end

Players.PlayerAdded:Connect(function(pl)
    pl.CharacterAdded:Connect(function()
        if skeletonEspEnabled then wait(0.05) updateSkeleton(pl) end
    end)
end)

Players.PlayerRemoving:Connect(function(pl)
    if skeletons[pl] then
        for _, line in pairs(skeletons[pl]) do line:Remove() end
        skeletons[pl] = nil
    end
end)

for _, pl in ipairs(Players:GetPlayers()) do
    pl.CharacterAdded:Connect(function()
        if skeletonEspEnabled then wait(0.05) updateSkeleton(pl) end
    end)
end

RunService.RenderStepped:Connect(function()
    local mousePos = UserInputService:GetMouseLocation()
    circle.Position = Vector2.new(mousePos.X, mousePos.Y)

    if skeletonEspEnabled then
        refreshAllESP()
        for pl, _ in pairs(skeletons) do updateSkeleton(pl) end
    end

    if not aimbotEnabled then return end

    if aimbotMode == "Hold" then
        if holdingKey then
            local targetPart = getClosestToMouse()
            if targetPart then
                local targetPos = targetPart.Position
                local newCFrame = CFrame.new(camera.CFrame.Position, targetPos)
                camera.CFrame = camera.CFrame:Lerp(newCFrame, smoothness)
            end
        end
    else
        if toggleActive then
            if isPartValid(target) then
                local targetPos = target.Position
                local newCFrame = CFrame.new(camera.CFrame.Position, targetPos)
                camera.CFrame = camera.CFrame:Lerp(newCFrame, smoothness)
            else
                if not acquireTarget() then end
            end
        end
    end
end)

Players.PlayerRemoving:Connect(function(p)
    if target and target:FindFirstAncestorOfClass("Model") == p.Character then clearTarget() end
end)

player.CharacterRemoving:Connect(function()
    clearTarget()
    toggleActive = false
end)

print("googoogaga giga niga")
