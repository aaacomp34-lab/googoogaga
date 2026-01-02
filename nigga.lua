--[[
    WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]


local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local v3_new = Vector3.new


-- NoSpread Settings
local NoSpreadEnabled = true
local WeaponsFolder = ReplicatedStorage:FindFirstChild("Weapons")


-- // TUNING & SETTINGS
local LOCKED_SLIDE_SPEED = 18
local SMOOTH_FAC = 0.15 -- Increased for smoother edgebug
local MAX_PX_SPEED = 22
local JUMP_COOLDOWN = 0.12 
local SCROLL_SPEED = 2.0
local EXPONENT, INTENSITY = 0.6, 18 


local BHOP_LOCK_SPEED = 18      
local DEFAULT_WALKSPEED = 18    -- Updated to match your request
local DECAY_RATE = 0.85         
local FAST_FALL_SPEED, FALL_LERP = -45, 0.08


local binds = {
    eb = Enum.KeyCode.C, jb = Enum.KeyCode.Q, px = Enum.KeyCode.LeftShift,
    as = Enum.KeyCode.V, lj = Enum.KeyCode.E, bhop = Enum.KeyCode.B,
    ns = Enum.KeyCode.H, 
    toggleGui = Enum.KeyCode.Insert
}


local guiVisible = true
local slideActive, jumpbugActive, pixelsurfActive, airstuckActive, longjumpActive, bhopActive, noSpreadActive = false, false, false, false, false, false, true
local keysPressed = {W = false, A = false, S = false, D = false}
local lastJumpTime, lastSpeed, lastUpdate = 0, 0, 0
local lockedY, airstuckPos, slideBodyVelocity, slideCurrentVel = nil, nil, nil, Vector3.new(0,0,0)
local segments = {}


-- NoSpread Function
local function noSpread(weapon)
    if NoSpreadEnabled and noSpreadActive then
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


-- Initialize NoSpread on existing weapons
if WeaponsFolder then
    for _, weapon in ipairs(WeaponsFolder:GetChildren()) do
        noSpread(weapon)
    end
end


-- Watch for new weapons
if WeaponsFolder then
    WeaponsFolder.ChildAdded:Connect(function(weapon)
        noSpread(weapon)
    end)
end


-- // HUD CONSTRUCTION
local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
sg.Name = "randomshi38456"
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
    ns = createIndicator("NS"), ws = createIndicator("WS") -- Added WS indicator
}


local graphContainer = Instance.new("Frame", sg)
graphContainer.Size, graphContainer.Position = UDim2.new(0, 550, 0, 150), UDim2.new(0.45, -275, 0.62, 0)
graphContainer.BackgroundTransparency, graphContainer.ClipsDescendants = 1, true


-- // MAIN MENU
local main = Instance.new("Frame", sg)
main.Size, main.Position = UDim2.new(0, 300, 0, 310), UDim2.new(0.05, 0, 0.1, 0)
main.BackgroundColor3, main.BorderSizePixel = Color3.fromRGB(255, 105, 180), 0


local top = Instance.new("Frame", main)
top.Size, top.BackgroundColor3 = UDim2.new(1, 0, 0, 25), Color3.new(1, 1, 1)


local title = Instance.new("TextLabel", top)
title.Size, title.Position = UDim2.new(1, -10, 1, 0), UDim2.new(0, 10, 0, 0)
title.Text, title.TextColor3 = "randomshi38456 / internal", Color3.new(0,0,0)
title.Font, title.TextSize, title.BackgroundTransparency = Enum.Font.SourceSansBold, 16, 1
title.TextXAlignment = Enum.TextXAlignment.Left


local scroll = Instance.new("ScrollingFrame", main)
scroll.Size, scroll.Position = UDim2.new(1, -20, 1, -45), UDim2.new(0, 10, 0, 35)
scroll.BackgroundColor3, scroll.ScrollBarThickness = Color3.new(1, 1, 1), 6
scroll.ScrollBarImageColor3 = Color3.fromRGB(255, 105, 180)
Instance.new("UIListLayout", scroll).Padding = UDim.new(0, 8)


local resizeBtn = Instance.new("TextButton", main)
resizeBtn.Size = UDim2.new(0, 15, 0, 15)
resizeBtn.Position = UDim2.new(1, -15, 1, -15)
resizeBtn.Text, resizeBtn.BackgroundTransparency = "", 0.5
resizeBtn.BackgroundColor3 = Color3.new(1,1,1)


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
createBindRow("ns", "NOSPREAD")


-- // DRAG & RESIZE LOGIC
local dragging, draggingRes, dragStart, startPos, startSize = false, false, nil, nil, nil
top.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true dragStart = i.Position startPos = main.Position end end)
resizeBtn.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then draggingRes = true dragStart = i.Position startSize = main.Size end end)
UserInputService.InputChanged:Connect(function(i)
    if i.UserInputType == Enum.MouseMovement then
        if dragging then
            local delta = i.Position - dragStart
            main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        elseif draggingRes then
            local delta = i.Position - dragStart
            main.Size = UDim2.new(0, math.max(150, startSize.X.Offset + delta.X), 0, math.max(100, startSize.Y.Offset + delta.Y))
        end
    end
end)
UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging, draggingRes = false, false end end)


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


-- // INPUTS
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    local k = input.KeyCode
    if k == binds.toggleGui then
        guiVisible = not guiVisible
        main.Visible, graphContainer.Visible, indContainer.Visible, velText.Visible = guiVisible, guiVisible, guiVisible, guiVisible
    elseif k == binds.eb then slideActive = true
    elseif k == binds.jb then jumpbugActive = true
    elseif k == binds.px then pixelsurfActive = true
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then lockedY = player.Character.HumanoidRootPart.Position.Y end
    elseif k == binds.as then
        airstuckActive = not airstuckActive
        if airstuckActive and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then airstuckPos = player.Character.HumanoidRootPart.CFrame else airstuckPos = nil end
    elseif k == binds.lj then longjumpActive = true
    elseif k == binds.bhop then bhopActive = not bhopActive
    elseif k == binds.ns then
        noSpreadActive = not noSpreadActive
        if WeaponsFolder then for _, weapon in ipairs(WeaponsFolder:GetChildren()) do noSpread(weapon) end end
    elseif k == Enum.KeyCode.W then keysPressed.W = true
    elseif k == Enum.KeyCode.A then keysPressed.A = true
    elseif k == Enum.KeyCode.S then keysPressed.S = true
    elseif k == Enum.KeyCode.D then keysPressed.D = true end
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
    elseif k == Enum.KeyCode.D then keysPressed.D = false end
end)


-- // ENGINE
RunService.Heartbeat:Connect(function(dt)
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")
    if not root or not hum then return end


    if hum.WalkSpeed ~= 20 then
        hum.WalkSpeed = 20
    end


    local hVel = Vector3.new(root.Velocity.X, 0, root.Velocity.Z)
    local hSpeed = hVel.Magnitude


    lastUpdate = lastUpdate + dt
    if lastUpdate >= 0.033 then
        lastUpdate = 0
        if guiVisible then
            velText.Text = string.format("%.2f", hSpeed)
            updateGraph(hSpeed)
            local states = {eb = slideActive, jb = jumpbugActive, px = pixelsurfActive, lj = longjumpActive, as = airstuckActive, bh = bhopActive, ns = noSpreadActive, ws = true}
            for id, active in pairs(states) do
                if inds[id] then
                    inds[id].Label.TextTransparency = active and 0 or 1
                    inds[id].Stroke.Transparency = active and 0 or 1
                end
            end
        end
    end


    if airstuckActive and airstuckPos then 
        root.CFrame, root.Velocity = airstuckPos, Vector3.zero return 
    end


    local onGround = (hum.FloorMaterial ~= Enum.Material.Air)
    local now = tick()


    if bhopActive then
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
        elseif onGround and hSpeed > 18 then -- Updated decay floor
            local newS = math.max(18, hSpeed * DECAY_RATE)
            root.Velocity = Vector3.new(hVel.Unit.X * newS, root.Velocity.Y, hVel.Unit.Z * newS)
        end
    end


    if onGround and (now - lastJumpTime) > JUMP_COOLDOWN then
    if longjumpActive then 
        lastJumpTime = now
        root.Velocity = root.CFrame.LookVector * 49 + Vector3.new(0,26,0)
        return
        elseif jumpbugActive then 
            lastJumpTime = now
            root.Velocity = Vector3.new(root.Velocity.X, 33, root.Velocity.Z) 
        end
    end


    if slideActive and root.Velocity.Y < -5 then
        root.Velocity = root.Velocity:Lerp(Vector3.new(root.Velocity.X, FAST_FALL_SPEED, root.Velocity.Z), FALL_LERP)
    end


    -- // SMOOTH EDGEBUG (SLIDE) SYSTEM
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
else  -- FIXED: Changed from elseif slideBodyVelocity to else, and preserve speed
    local currentSpeed = slideCurrentVel.Magnitude
    if slideBodyVelocity then
        slideBodyVelocity:Destroy()
        slideBodyVelocity = nil
    end
    if currentSpeed > 1 then  -- Preserve momentum with short boost
        local preserveBV = Instance.new("BodyVelocity", root)
        preserveBV.MaxForce = Vector3.new(4e4, 0, 4e4)
        preserveBV.Velocity = Vector3.new(slideCurrentVel.X, 0, slideCurrentVel.Z)
        Debris:AddItem(preserveBV, 0.1)  -- Short duration to kickstart physics
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
print("googoogaga giga niga") 
