setfpscap(1500)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- // TUNING
local DEFAULT_WALKSPEED = 17.5
local BHOP_AIR_SPEED = 24.3
local PIXELSURF_WALKSPEED = 23.2

-- HARD FLOOR (NEVER FALL BELOW THIS)
local MIN_Y_LEVEL = 2.8

-- JUMPBUG (0.2s CTRL HOLD -> AIR LAUNCH)
local JB_FORCE_AMOUNT = 17
local JB_LATENCY = 0.0052
local JUMP_COOLDOWN = 0.2
local JB_CROUCH_HEIGHT = 0.5
local JB_NORMAL_HEIGHT = 2.0
local JB_AUTO_CROUCH_TIME = 0.04

-- FLASH BOOST / LONGJUMP
local FB_FORWARD_FORCE = 120
local FB_UPWARD_FORCE = 50

-- EDGEBUG / SLIDE
local LOCKED_SLIDE_SPEED = 18
local SMOOTH_FAC = 0.4

-- PIXELSURF / LADDER
local PX_WALL_DETECT_DIST = 1.4
local PX_GRAVITY_REDUCTION = 0.05
local V_SURF_SPEED = 32
local V_SURF_FORCE = 2e7
local V_DETECT_DIST = 2.0

-- NO RECOIL SETTINGS
local noSpreadEnabled = true

local binds = {
    eb = Enum.KeyCode.C,
    jb = Enum.KeyCode.Q,
    px = Enum.KeyCode.LeftShift,
    as = Enum.KeyCode.V,
    lj = Enum.KeyCode.E,
    v_surf = Enum.KeyCode.T,
    bhop = Enum.KeyCode.B,
    fb = Enum.KeyCode.G
}

local slideActive, jumpbugActive, pixelsurfActive, airstuckActive, longjumpActive, vSurfActive, bhopActive = false, false, false, false, false, false, false
local keysPressed = {W = false, A = false, S = false, D = false}
local lastJumpTime = 0
local slideCurrentVel = Vector3.zero
local lockedSurfDir = nil
local airstuckPos = nil
local isJumpingBug = false

-- Connection cleanup table
local connections = {}

local function disconnectAll()
    for _, conn in pairs(connections) do
        if conn and conn.Connected then
            conn:Disconnect()
        end
    end
    connections = {}
end

-- // NO RECOIL / NO SPREAD LOGIC
local function applyNoSpread(weapon)
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

-- Apply no spread to all weapons
local WeaponsFolder = ReplicatedStorage:FindFirstChild("Weapons")
if WeaponsFolder then
    for _, weapon in ipairs(WeaponsFolder:GetChildren()) do
        applyNoSpread(weapon)
    end
    
    WeaponsFolder.ChildAdded:Connect(function(weapon)
        applyNoSpread(weapon)
    end)
end

-- // ULTRA AGGRESSIVE FALL DAMAGE PREVENTION
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    -- Block ALL TakeDamage calls completely
    if method == "TakeDamage" and self:IsA("Humanoid") then
        local char = player.Character
        if char and self == char:FindFirstChild("Humanoid") then
            -- Check if damage is fall-related (typically 10+ damage)
            local damageAmount = args[1]
            if damageAmount and damageAmount >= 10 then
                return -- Block all fall damage
            end
        end
    end
    
    -- Block FireServer/InvokeServer for damage events
    if method == "FireServer" or method == "InvokeServer" then
        local name = tostring(self)
        if name:lower():find("damage") or name:lower():find("fall") or name:lower():find("hurt") or name:lower():find("health") then
            -- Don't block all damage events, just suspicious ones
            return
        end
    end
    
    return oldNamecall(self, ...)
end)

-- Hook __newindex to prevent health decreases from falls
local oldNewIndex
oldNewIndex = hookmetamethod(game, "__newindex", function(self, property, value)
    if self:IsA("Humanoid") and property == "Health" then
        local char = player.Character
        if char and self == char:FindFirstChild("Humanoid") then
            -- Block large health decreases (fall damage is usually 10+)
            local healthDiff = self.Health - value
            if healthDiff >= 10 then
                return -- Prevent fall damage health reduction
            end
        end
    end
    
    return oldNewIndex(self, property, value)
end)

local function setupCharacter(char)
    disconnectAll()
    
    local hum = char:WaitForChild("Humanoid")
    local root = char:WaitForChild("HumanoidRootPart")
    
    -- Remove any fall damage scripts
    for _, child in ipairs(hum:GetChildren()) do
        if child.Name:lower():find("fall") or child.Name:lower():find("damage") then
            child:Destroy()
        end
    end
    
    local maxHealth = hum.MaxHealth
    
    -- Monitor for fall damage and instantly restore health
    table.insert(connections, hum:GetPropertyChangedSignal("Health"):Connect(function()
        local healthLoss = maxHealth - hum.Health
        -- If significant health loss (likely fall damage)
        if healthLoss >= 10 and hum.Health > 0 then
            task.spawn(function()
                -- Immediate restoration
                hum.Health = maxHealth
                -- Multiple attempts to ensure it sticks
                for i = 1, 5 do
                    task.wait(0.01)
                    if hum and hum.Parent and hum.Health < maxHealth then
                        hum.Health = maxHealth
                    end
                end
            end)
        end
        
        -- Update max health if it changed
        if hum.Health > maxHealth then
            maxHealth = hum.Health
        end
    end))
    
    -- Monitor MaxHealth changes
    table.insert(connections, hum:GetPropertyChangedSignal("MaxHealth"):Connect(function()
        maxHealth = hum.MaxHealth
    end))
    
    -- Prevent damage scripts from being added
    table.insert(connections, hum.ChildAdded:Connect(function(child)
        if child.Name:lower():find("damage") or child.Name:lower():find("fall") then
            child:Destroy()
        end
    end))
    
    -- State monitoring for additional protection
    table.insert(connections, hum.StateChanged:Connect(function(oldState, newState)
        if newState == Enum.HumanoidStateType.Landed then
            -- Force health check on landing
            task.spawn(function()
                task.wait(0.05)
                if hum and hum.Parent and hum.Health < maxHealth then
                    hum.Health = maxHealth
                end
            end)
        end
    end))
    
    -- Cleanup when character is removed
    table.insert(connections, char.AncestryChanged:Connect(function(_, parent)
        if not parent then
            disconnectAll()
        end
    end))
end

if player.Character then
    setupCharacter(player.Character)
end
player.CharacterAdded:Connect(setupCharacter)

-- // INPUT HANDLING
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    
    local k = input.KeyCode
    
    if k == binds.jb then
        jumpbugActive = true
    elseif k == binds.eb then
        slideActive = true
    elseif k == binds.px then
        pixelsurfActive = true
    elseif k == binds.as then
        airstuckActive = not airstuckActive
        local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if airstuckActive and root then
            airstuckPos = root.CFrame
        else
            airstuckPos = nil
        end
    elseif k == binds.lj then
        longjumpActive = true
    elseif k == binds.v_surf then
        vSurfActive = true
    elseif k == binds.bhop then
        bhopActive = not bhopActive
    elseif k == binds.fb then
        local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if root then
            root.AssemblyLinearVelocity = (root.CFrame.LookVector * FB_FORWARD_FORCE) + Vector3.new(0, FB_UPWARD_FORCE, 0)
        end
    elseif k == Enum.KeyCode.W then
        keysPressed.W = true
    elseif k == Enum.KeyCode.A then
        keysPressed.A = true
    elseif k == Enum.KeyCode.S then
        keysPressed.S = true
    elseif k == Enum.KeyCode.D then
        keysPressed.D = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    local k = input.KeyCode
    
    if k == binds.jb then
        jumpbugActive = false
    elseif k == binds.px then
        pixelsurfActive = false
        lockedSurfDir = nil
    elseif k == binds.eb then
        slideActive = false
    elseif k == binds.lj then
        longjumpActive = false
    elseif k == binds.v_surf then
        vSurfActive = false
    elseif k == Enum.KeyCode.W then
        keysPressed.W = false
    elseif k == Enum.KeyCode.A then
        keysPressed.A = false
    elseif k == Enum.KeyCode.S then
        keysPressed.S = false
    elseif k == Enum.KeyCode.D then
        keysPressed.D = false
    end
end)

-- // MAIN ENGINE
RunService.RenderStepped:Connect(function(dt)
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")
    
    if not root or not hum then return end
    
    local onGround = (hum.FloorMaterial ~= Enum.Material.Air)
    
    -- --- AIRSTUCK (highest priority - returns early) ---
    if airstuckActive and airstuckPos then
        root.CFrame = airstuckPos
        root.AssemblyLinearVelocity = Vector3.zero
        return
    end
    
    local now = tick()
    
    -- --- HARD FLOOR (only apply if not using movement abilities) ---
    if root.Position.Y < MIN_Y_LEVEL and not (slideActive or pixelsurfActive or vSurfActive) then
        local currentVel = root.AssemblyLinearVelocity
        root.AssemblyLinearVelocity = Vector3.new(currentVel.X, math.max(0, currentVel.Y), currentVel.Z)
        root.CFrame = CFrame.new(root.Position.X, MIN_Y_LEVEL, root.Position.Z) * root.CFrame.Rotation
        if hum:GetState() ~= Enum.HumanoidStateType.Running then
            hum:ChangeState(Enum.HumanoidStateType.Running)
        end
    end
    
    -- --- JUMPBUG (SPACEBAR REQUIRED) ---
    if jumpbugActive and onGround and not isJumpingBug and UserInputService:IsKeyDown(Enum.KeyCode.Space) then
        isJumpingBug = true
        task.spawn(function()
            hum.HipHeight = JB_CROUCH_HEIGHT
            task.wait(JB_AUTO_CROUCH_TIME)
            
            hum.HipHeight = JB_NORMAL_HEIGHT
            task.wait(JB_LATENCY)
            
            local currentVel = root.AssemblyLinearVelocity
            root.AssemblyLinearVelocity = Vector3.new(currentVel.X, JB_FORCE_AMOUNT * 2, currentVel.Z)
            
            local jbBoost = Instance.new("BodyVelocity")
            jbBoost.MaxForce = Vector3.new(0, 1e7, 0)
            jbBoost.Velocity = Vector3.new(0, JB_FORCE_AMOUNT, 0)
            jbBoost.Parent = root
            Debris:AddItem(jbBoost, 0.15)
            
            task.wait(JUMP_COOLDOWN)
            isJumpingBug = false
        end)
    end
    
    -- --- BHOP ---
    if bhopActive then
        hum.UseJumpPower = false
        hum.JumpHeight = 0.85
        if slideActive and (keysPressed.W or keysPressed.S) then
            hum.WalkSpeed = LOCKED_SLIDE_SPEED
        else
            hum.WalkSpeed = (not onGround) and BHOP_AIR_SPEED or DEFAULT_WALKSPEED
        end
        
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) and onGround then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    else
        hum.UseJumpPower = true
        if slideActive and (keysPressed.W or keysPressed.S) then
            hum.WalkSpeed = LOCKED_SLIDE_SPEED
        elseif not pixelsurfActive then
            hum.WalkSpeed = DEFAULT_WALKSPEED
        end
    end
    
    -- --- VERTICAL LADDER SURF ---
    if vSurfActive then
        local rayParams = RaycastParams.new()
        rayParams.FilterDescendantsInstances = {char}
        rayParams.FilterType = Enum.RaycastFilterType.Exclude
        
        local hit = workspace:Raycast(root.Position, root.CFrame.LookVector * V_DETECT_DIST, rayParams)
        if hit then
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(0, V_SURF_FORCE, 0)
            bv.Velocity = Vector3.new(0, V_SURF_SPEED, 0)
            bv.Parent = root
            Debris:AddItem(bv, dt)
        end
    end
    
    -- --- LONGJUMP ---
    if longjumpActive and onGround and (now - lastJumpTime) > JUMP_COOLDOWN then
        lastJumpTime = now
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
        
        local lookDir = root.CFrame.LookVector
        root.AssemblyLinearVelocity = Vector3.new(lookDir.X * 63, 26.6, lookDir.Z * 60)
    end
    
    -- --- EDGEBUG SLIDE ---
    if slideActive then
        if keysPressed.W or keysPressed.S then
            local camCF = camera.CFrame
            local forward = Vector3.new(camCF.LookVector.X, 0, camCF.LookVector.Z).Unit
            local moveDir
            
            if keysPressed.W then 
                moveDir = forward
            else
                moveDir = -forward
            end
            
            slideCurrentVel = slideCurrentVel:Lerp(moveDir * LOCKED_SLIDE_SPEED, SMOOTH_FAC)
            
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(1e6, 0, 1e6)
            bv.Velocity = Vector3.new(slideCurrentVel.X, 0, slideCurrentVel.Z)
            bv.Parent = root
            Debris:AddItem(bv, 0.03)
            
            if onGround and root and root.Parent then
                local currentVel = root.AssemblyLinearVelocity
                local newVelY = currentVel.Y > 0 and 0 or currentVel.Y
                root.AssemblyLinearVelocity = Vector3.new(
                    slideCurrentVel.X,
                    newVelY,
                    slideCurrentVel.Z
                )
            end
        else
            slideCurrentVel = Vector3.zero
        end
    else
        slideCurrentVel = Vector3.zero
    end
    
    -- --- PIXELSURF (CAMERA-DEPENDENT WITH MANUAL CONTROL) ---
    if pixelsurfActive then
        local rayParams = RaycastParams.new()
        rayParams.FilterDescendantsInstances = {char}
        rayParams.FilterType = Enum.RaycastFilterType.Exclude
        
        -- Get camera look direction (horizontal only)
        local camLookFlat = Vector3.new(camera.CFrame.LookVector.X, 0, camera.CFrame.LookVector.Z).Unit
        
        local directions = {
            root.CFrame.RightVector,
            -root.CFrame.RightVector,
            root.CFrame.LookVector,
            -root.CFrame.LookVector
        }
        
        local wallHit = nil
        for _, dir in ipairs(directions) do
            local ray = workspace:Raycast(root.Position, dir * PX_WALL_DETECT_DIST, rayParams)
            if ray then
                wallHit = ray
                break
            end
        end
        
        if wallHit then
            -- Calculate surf direction
            if not lockedSurfDir then
                local currentVel = root.AssemblyLinearVelocity
                local travelDir = currentVel.Magnitude > 1 and currentVel.Unit or camLookFlat
                local tangent = Vector3.new(-wallHit.Normal.Z, 0, wallHit.Normal.X).Unit
                
                if tangent:Dot(travelDir) < (-tangent):Dot(travelDir) then
                    tangent = -tangent
                end
                
                lockedSurfDir = tangent
            end
            
            -- Check if camera is looking in the same direction as surf direction
            local dotProduct = camLookFlat:Dot(lockedSurfDir)
            
            -- Dot product > 0.766 means angle < 40° (cos(40°) ≈ 0.766)
            -- This creates an 80° cone (40° left + 40° right) where pixelsurf works
            if dotProduct > 0.766 then
                -- Check if W or S is pressed for manual control
                local moveMultiplier = 0
                if keysPressed.W then
                    moveMultiplier = 1 -- Move forward along wall
                elseif keysPressed.S then
                    moveMultiplier = -1 -- Move backward along wall
                end
                
                -- Only apply velocity if W or S is pressed
                if moveMultiplier ~= 0 then
                    hum.WalkSpeed = PIXELSURF_WALKSPEED
                    hum.AutoRotate = false
                    
                    local bv = Instance.new("BodyVelocity")
                    bv.MaxForce = Vector3.new(2e6, 2e6, 2e6)
                    bv.Velocity = (lockedSurfDir * PIXELSURF_WALKSPEED * moveMultiplier) + Vector3.new(0, root.AssemblyLinearVelocity.Y * PX_GRAVITY_REDUCTION, 0)
                    bv.Parent = root
                    Debris:AddItem(bv, 0.03)
                else
                    -- No input, stop movement but keep on wall
                    hum.AutoRotate = false
                end
            else
                -- Player looking at wrong angle, stop pixelsurf
                lockedSurfDir = nil
                hum.AutoRotate = true
            end
        else
            lockedSurfDir = nil
            hum.AutoRotate = true
        end
    else
        if hum then
            hum.AutoRotate = true
        end
        lockedSurfDir = nil
    end
end)
