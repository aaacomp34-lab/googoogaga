    -- // SECURITY BYPASS LAYER // --
            local _G_JUNK = {}
            for i = 1, 500 do
                _G_JUNK[i] = math.random() * os.time()
            end
            local function _GenerateWorthlessData()
                local str = ""
                for i = 1, 10 do str = str .. string.char(math.random(65, 90)) end
                return str
            end
            local _AntiDetection_Var = _GenerateWorthlessData()
            local _Calculated_Hash = math.sin(os.time()) * 9999
            -- // END SECURITY LAYER // --

            setfpscap(1500)
            local Players = game:GetService("Players")
            local UserInputService = game:GetService("UserInputService")
            local RunService = game:GetService("RunService")
            local Debris = game:GetService("Debris")
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local VirtualInputManager = game:GetService("VirtualInputManager")

            local player = Players.LocalPlayer
            local camera = workspace.CurrentCamera

            -- // RANDOM MEMORY ALLOCATION
            local _mem_alloc = {}
            for i=1, 50 do _mem_alloc[i] = Vector3.new(math.random(), math.random(), math.random()) end
            local _unused_flag = false
            if tick() > 9999999999 then _unused_flag = true end

            -- // LIBRARY SETUP
            local _loader_name = string.char(108, 111, 97, 100, 115, 116, 114, 105, 110, 103)
            local _asset_path = "rbxassetid://" .. "7657867786"
            local _library_source = game:GetObjects(_asset_path)[1].Source
            local library = (getfenv()[_loader_name](_library_source))()
            local Wait = library.subs.Wait

            -- // OBFUSCATED FUNCTIONS
            local _clipboard_setter_name = string.char(115, 101, 116, 99, 108, 105, 112, 98, 111, 97, 114, 100) -- "setclipboard"
            local _setclipboard = getfenv()[_clipboard_setter_name]

            local PepsisWorld = library:CreateWindow({
                Name = "im lwk autistic",
                Themeable = {
                    Info = "im lwk autistic"
                }
            })

            -- // TUNING VARIABLES
            local DEFAULT_WALKSPEED = 16
            local PIXELSURF_WALKSPEED = 24
            local BHOP_SPEED = 26 -- Default value
            local BHOP_JUMP_HEIGHT = 0.73

            -- JUMPBUG
            local JB_FORCE_AMOUNT = 13.2
            local JB_LATENCY = 0.0052
            local JUMP_COOLDOWN = 0.45
            local JB_CROUCH_HEIGHT = 0.5
            local JB_NORMAL_HEIGHT = 2.0
            local JB_AUTO_CROUCH_TIME = 0.025 

            -- MINIJUMP
            local MINIJUMP_JUMP_HEIGHT = 0.63
            local MINIJUMP_CROUCH_TIME = 0.25
            local MINIJUMP_COOLDOWN = 0.5

            -- FLASH BOOST / LONGJUMP
            local FB_FORWARD_FORCE = 110
            local FB_UPWARD_FORCE = 43.2
            local LJ_FORWARD_FORCE = 36
            local LJ_UPWARD_FORCE = 25.5

            -- EDGEBUG
            local EDGEBUG_DETECTION_RADIUS = 0.7
            local EDGEBUG_EDGE_THRESHOLD = 0.3
            local EDGEBUG_SLIDE_SPEED = 25.8
            local EDGEBUG_MIN_HEIGHT = 0.3

            -- PIXELSURF
            local PX_WALL_DETECT_DIST = 1.5
            local PX_GRAVITY_REDUCTION = 0.05
            local V_SURF_SPEED = 30
            local V_SURF_FORCE = 2e7
            local V_DETECT_DIST = 2.5

            -- PIXELHOP
            local PIXELHOP_FORCE = 15
            local PIXELHOP_LATENCY = 0.0052 
            local PIXELHOP_COOLDOWN = 0.3
            local PIXELHOP_CROUCH_TIME = 0.025 
            local PIXELHOP_WALL_DETECT_DIST = 1.2

            -- EDGEJUMP
            local EDGEJUMP_DETECTION_HEIGHT = 3
            local EDGEJUMP_MIN_DISTANCE = 2
            local EDGEJUMP_COOLDOWN = 0.3
            -- BLOCK BOT
            local BLOCKBOT_PLATFORM_SIZE = Vector3.new(1, 0.2, 1)

            -- JUMP HEIGHTS
            local DEFAULT_JUMP_HEIGHT = 2.5

            -- // STATE SETTINGS (Controlled by GUI Toggles)
            local Settings = {
                Jumpbug = false,
                Edgebug = false,
                Pixelsurf = false,
                Longjump = false,
                Pixelhop = false,
                Airstuck = false,
                Minijump = false,
                Autoduck = false,
                FastStop = false,
                Slidewalk = false,
                VSurf = false,
                FlashBoost = false,
                NoFall = false,
                BlockBot = false,
                EdgeJump = false,
                Bhop = false,
            }

            -- // KEYBINDS (Default, can be changed in GUI)
            local Binds = {
                Jumpbug = Enum.KeyCode.Q,
                Edgebug = Enum.KeyCode.C,
                Pixelsurf = Enum.KeyCode.LeftShift,
                Longjump = Enum.KeyCode.E,
                Pixelhop = Enum.KeyCode.Y,
                Airstuck = Enum.KeyCode.V,
                Minijump = Enum.KeyCode.F,
                VSurf = Enum.KeyCode.T,
                FlashBoost = Enum.KeyCode.G,
            }

            -- // INTERNAL VARIABLES
            local keysPressed = {W = false, A = false, S = false, D = false}
            local lastJumpTime = 0
            local lockedSurfDir = nil
            local airstuckPos = nil
            local isJumpingBug = false
            local lastMinijumpTime = 0
            local lastPixelhopTime = 0
            local isPixelhopping = false
            local isLongJumping = false
            local longjumpBV = nil
            local lastFlashBoostTime = 0
            local isFlashBoosting = false
            local edgebugBV = nil
            local canJumpbug = false
            local jumpbugKeyHeld = false

            -- EDGEBUG SPECIFIC
            local edgebugOnEdge = false
            local lastEdgeObject = nil
            local edgeSlideDirection = nil
            local autoCrouchActive = false

            -- EDGEJUMP SPECIFIC
            local wasOnGround = true
            local edgeJumpCooldown = false
            local lastEdgeJumpTime = 0

            -- BLOCK BOT SPECIFIC
            local blockbotParts = {}
            local blockbotActive = false
            local blockbotConnections = {}

            local connections = {}
            local mainLoopConnection = nil

            -- // OBFUSCATION JUNK
            local function _useless_math(a, b)
                return (a * b) / (math.random(1, 5))
            end

            -- // GUI - MOVEMENT TAB
            local MovementTab = PepsisWorld:CreateTab({
                Name = "movement shit"
            })

            -- LEFT TOP CORNER - Main Movement Features
            local MovementMain = MovementTab:CreateSection({
                Name = "idk",
                Side = "Left"
            })

            -- NEW BHOP FUNCTIONALITY
            MovementMain:AddToggle({
                Name = "bhop",
                Value = false,
                Callback = function(val) Settings.Bhop = val end
            })

            MovementMain:AddSlider({
                Name = "bhop speed",
                Min = 16,
                Max = 75,
                Value = 26,
                Callback = function(val)
                    BHOP_SPEED = val
                end
            })
            -- END NEW BHOP

            MovementMain:AddToggle({
                Name = "edge jump",
                Value = false,
                Callback = function(val) Settings.EdgeJump = val end
            })

            MovementMain:AddToggle({
                Name = "longjump",
                Value = false,
                Callback = function(val) Settings.Longjump = val end
            })
            MovementMain:AddKeybind({
                Name = "bind",
                Value = Binds.Longjump,
                Callback = function(key) Binds.Longjump = key end
            })

            MovementMain:AddToggle({
                Name = "edgebug",
                Value = false,
                Callback = function(val) Settings.Edgebug = val end
            })
            MovementMain:AddKeybind({
                Name = "bind",
                Value = Binds.Edgebug,
                Callback = function(key) Binds.Edgebug = key end
            })

            MovementMain:AddToggle({
                Name = "jump bug",
                Value = false,
                Callback = function(val) Settings.Jumpbug = val end
            })
            MovementMain:AddKeybind({
                Name = "bind",
                Value = Binds.Jumpbug,
                Callback = function(key) Binds.Jumpbug = key end
            })

            MovementMain:AddToggle({
                Name = "pixelsurf",
                Value = false,
                Callback = function(val) Settings.Pixelsurf = val end
            })
            MovementMain:AddKeybind({
                Name = "bind",
                Value = Binds.Pixelsurf,
                Callback = function(key) Binds.Pixelsurf = key end
            })

            MovementMain:AddToggle({
                Name = "pixeljump",
                Value = false,
                Callback = function(val) Settings.Pixelhop = val end
            })
            MovementMain:AddKeybind({
                Name = "bind",
                Value = Binds.Pixelhop,
                Callback = function(key) Binds.Pixelhop = key end
            })


            -- RIGHT TOP CORNER - Secondary Movement Features
            local MovementSub = MovementTab:CreateSection({
                Name = "idk",
                Side = "Right"
            })

            MovementSub:AddToggle({
                Name = "flashboost",
                Value = false,
                Callback = function(val) Settings.FlashBoost = val end
            })
            MovementSub:AddKeybind({
                Name = "bind",
                Value = Binds.FlashBoost,
                Callback = function(key) 
                    Binds.FlashBoost = key 
                end
            })

            MovementSub:AddToggle({
                Name = "fast ladder",
                Value = false,
                Callback = function(val) Settings.VSurf = val end
            })
            MovementSub:AddKeybind({
                Name = "bind",
                Value = Binds.VSurf,
                Callback = function(key) Binds.VSurf = key end
            })

            MovementSub:AddToggle({
                Name = "air stuck",
                Value = false,
                Callback = function(val) Settings.Airstuck = val end
            })
            MovementSub:AddKeybind({
                Name = "bind",
                Value = Binds.Airstuck,
                Callback = function(key) Binds.Airstuck = key end
            })

            MovementSub:AddToggle({
                Name = "minijump",
                Value = false,
                Callback = function(val) Settings.Minijump = val end
            })
            MovementSub:AddKeybind({
                Name = "bind",
                Value = Binds.Minijump,
                Callback = function(key) Binds.Minijump = key end
            })

            MovementSub:AddToggle({
                Name = "autoduck",
                Value = false,
                Callback = function(val) Settings.Autoduck = val end
            })

            MovementSub:AddToggle({
                Name = "fast stop",
                Value = false,
                Callback = function(val) Settings.FastStop = val end
            })

            MovementSub:AddToggle({
                Name = "slidewalk",
                Value = false,
                Callback = function(val) Settings.Slidewalk = val end
            })

            -- LEFT BOTTOM CORNER - Passive Features
            local PassiveSection = MovementTab:CreateSection({
                Name = "idk",
                Side = "Left"
            })

            PassiveSection:AddToggle({
                Name = "fall dmg off",
                Value = false,
                Callback = function(val) 
                    Settings.NoFall = val 
                end
            })

            PassiveSection:AddToggle({
                Name = "block bot",
                Value = false,
                Callback = function(val) 
                    Settings.BlockBot = val
                    setupBlockBot(val)
                end
            })


            -- // COMBAT TAB - AIMBOT
            local CombatTab = PepsisWorld:CreateTab({
                Name = "shooting shit"
            })

            local AimbotSection = CombatTab:CreateSection({
                Name = "aimbot",
                Side = "Left"
            })

            -- Aimbot Settings
            local AimbotSettings = {
                Enabled = false,
                FOV = 200,
                ShowFOV = false,
                LockOnKey = Enum.UserInputType.MouseButton2,
                TeamCheck = false,
                WallCheck = false,
                FOVColor = Color3.fromRGB(255, 255, 255),
                RainbowFOV = false,
                RainbowSpeed = 10
            }

            -- Aimbot Variables
            local lockOnActive = false
            local currentTarget = nil
            local fovCircle = nil
            local fovCircleGui = nil

            -- Create FOV Circle using GUI (more compatible than Drawing library)
            local function createFOVCircle()
                local _temp = math.random()
                if _temp > 2 then return end

                pcall(function()
                    if fovCircleGui and fovCircleGui.Parent then 
                        fovCircleGui:Destroy() 
                    end
                end)
                
                fovCircleGui = nil
                fovCircle = nil
                
                local success, err = pcall(function()
                    fovCircleGui = Instance.new("ScreenGui")
                    fovCircleGui.Name = "FOVCircle"
                    fovCircleGui.IgnoreGuiInset = true
                    fovCircleGui.ResetOnSpawn = false
                    
                    local coreGuiSuccess = pcall(function()
                        fovCircleGui.Parent = game:GetService("CoreGui")
                    end)
                    if not coreGuiSuccess then
                        local playerGui = player:WaitForChild("PlayerGui", 5)
                        if playerGui then
                            fovCircleGui.Parent = playerGui
                        else
                            return
                        end
                    end
                    
                    local circle = Instance.new("Frame")
                    circle.Name = "Circle"
                    circle.AnchorPoint = Vector2.new(0.5, 0.5)
                    circle.BackgroundTransparency = 1
                    circle.Size = UDim2.new(0, AimbotSettings.FOV * 2, 0, AimbotSettings.FOV * 2)
                    circle.Position = UDim2.new(0.5, 0, 0.5, 0)
                    circle.Parent = fovCircleGui
                    
                    local corner = Instance.new("UICorner")
                    corner.CornerRadius = UDim.new(1, 0)
                    corner.Parent = circle
                    
                    local stroke = Instance.new("UIStroke")
                    stroke.Color = AimbotSettings.FOVColor
                    stroke.Thickness = 2
                    stroke.Transparency = 0
                    stroke.Parent = circle
                    
                    circle.Visible = AimbotSettings.ShowFOV and AimbotSettings.Enabled
                    
                    fovCircle = circle
                end)
                
                if not success then
                    warn("Failed to create FOV circle:", err)
                end
            end

            -- Update FOV Circle
            local function updateFOVCircle()
                if not fovCircle or not fovCircleGui or not fovCircleGui.Parent then 
                    if AimbotSettings.Enabled and AimbotSettings.ShowFOV then
                        pcall(createFOVCircle)
                    end
                    return
                end
                
                pcall(function()
                    fovCircle.Size = UDim2.new(0, AimbotSettings.FOV * 2, 0, AimbotSettings.FOV * 2)
                    fovCircle.Visible = AimbotSettings.ShowFOV and AimbotSettings.Enabled
                    if fovCircle and not AimbotSettings.RainbowFOV then
                        local stroke = fovCircle:FindFirstChild("UIStroke")
                        if stroke then
                            stroke.Color = AimbotSettings.FOVColor
                        end
                    end
                end)
            end

            -- Function to find the nearest player head within FOV
            local function getNearestPlayerHeadInFOV()
                local closestHead = nil
                local shortestDistance = math.huge
                local screenCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
                
                for _, otherPlayer in pairs(Players:GetPlayers()) do
                    if otherPlayer ~= player and otherPlayer.Character then
                        if AimbotSettings.TeamCheck then
                            if player.Team and otherPlayer.Team and player.Team == otherPlayer.Team then
                                continue
                            end
                        end
                        
                        local head = otherPlayer.Character:FindFirstChild("Head")
                        if head then
                            local screenPos, onScreen = camera:WorldToViewportPoint(head.Position)
                            
                            if onScreen then
                                local screenDistance = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                                
                                if screenDistance <= AimbotSettings.FOV and screenDistance < shortestDistance then
                                    if AimbotSettings.WallCheck then
                                        local rayParams = RaycastParams.new()
                                        rayParams.FilterDescendantsInstances = {player.Character}
                                        rayParams.FilterType = Enum.RaycastFilterType.Exclude
                                        
                                        local rayDirection = (head.Position - camera.CFrame.Position)
                                        local ray = workspace:Raycast(camera.CFrame.Position, rayDirection, rayParams)
                                        
                                        if ray and ray.Instance then
                                            if ray.Instance:IsDescendantOf(otherPlayer.Character) then
                                                shortestDistance = screenDistance
                                                closestHead = head
                                            end
                                        end
                                    else
                                        shortestDistance = screenDistance
                                        closestHead = head
                                    end
                                end
                            end
                        end
                    end
                end
                
                return closestHead
            end

            -- Forward declarations for UI elements
            local updateAimbotUI = nil

            -- Aimbot GUI Controls
            local aimbotToggle = AimbotSection:AddToggle({
                Name = "aimbot",
                Value = false,
                Callback = function(val)
                    AimbotSettings.Enabled = val
                    if not val then
                        lockOnActive = false
                        currentTarget = nil
                    end
                    updateFOVCircle()
                    if updateAimbotUI then updateAimbotUI() end
                end
            })

            local aimbotBind = AimbotSection:AddKeybind({
                Name = "aimbot bind",
                Value = Enum.UserInputType.MouseButton2,
                Callback = function(key)
                    AimbotSettings.LockOnKey = key
                end
            })

            local aimbotFovSlider = AimbotSection:AddSlider({
                Name = "fov size",
                Min = 50,
                Max = 250,
                Value = 100,
                Callback = function(val)
                    AimbotSettings.FOV = val
                    updateFOVCircle()
                end
            })

            local aimbotShowFov = AimbotSection:AddToggle({
                Name = "show fov",
                Value = false,
                Callback = function(val)
                    AimbotSettings.ShowFOV = val
                    updateFOVCircle()
                end
            })

            local rainbowSpeedSlider = nil -- forward declaration for visibility control

            local aimbotRainbowFov = AimbotSection:AddToggle({
                Name = "rainbow fov",
                Value = false,
                Callback = function(val)
                    AimbotSettings.RainbowFOV = val
                    pcall(function()
                        if rainbowSpeedSlider then rainbowSpeedSlider.Visible = val end
                    end)
                end
            })

            rainbowSpeedSlider = AimbotSection:AddSlider({
                Name = "rainbow speed",
                Min = 1,
                Max = 15,
                Value = 5,
                Callback = function(val)
                    AimbotSettings.RainbowSpeed = val
                end
            })
            pcall(function() if rainbowSpeedSlider then rainbowSpeedSlider.Visible = AimbotSettings.RainbowFOV end end)

            local aimbotColorPicker = AimbotSection:AddColorpicker({
                Name = "fov color",
                Value = AimbotSettings.FOVColor,
                Callback = function(color)
                    AimbotSettings.FOVColor = color
                    updateFOVCircle()
                end
            })

            AimbotSection:AddToggle({
                Name = "team check",
                Value = true,
                Callback = function(val)
                    AimbotSettings.TeamCheck = val
                end
            })

            AimbotSection:AddToggle({
                Name = "wall check",
                Value = false,
                Callback = function(val)
                    AimbotSettings.WallCheck = val
                end
            })

            -- UI Update Function
            updateAimbotUI = function()
                local enabled = AimbotSettings.Enabled
                
                if aimbotBind then aimbotBind.Visible = enabled end
                if aimbotFovSlider then aimbotFovSlider.Visible = enabled end
                if aimbotShowFov then aimbotShowFov.Visible = enabled end
                if aimbotRainbowFov then aimbotRainbowFov.Visible = enabled end
                if rainbowSpeedSlider then rainbowSpeedSlider.Visible = enabled and AimbotSettings.RainbowFOV end
                if aimbotColorPicker then aimbotColorPicker.Visible = enabled end
            end

            -- Initialize UI State
            updateAimbotUI()

            -- Initialize FOV Circle
            createFOVCircle()


            -- // LOGIC IMPLEMENTATION

            local function disconnectAll()
                for _, conn in pairs(connections) do
                    if conn and conn.Connected then
                        conn:Disconnect()
                    end
                end
                connections = {}
                if mainLoopConnection and mainLoopConnection.Connected then
                    mainLoopConnection:Disconnect()
                    mainLoopConnection = nil
                end
                
                if fovCircleGui and fovCircleGui.Parent then
                    fovCircleGui:Destroy()
                    fovCircleGui = nil
                    fovCircle = nil
                end
            end

            -- BLOCK BOT: Create platforms on other players' heads
            function setupBlockBot(enabled)
                local _noise = {}
                table.insert(_noise, "blockbot_init")
                local _ = #_noise

                for _, part in pairs(blockbotParts) do
                    if part and part.Parent then
                        part:Destroy()
                    end
                end
                blockbotParts = {}
                
                for _, conn in pairs(blockbotConnections) do
                    if conn and conn.Connected then
                        conn:Disconnect()
                    end
                end
                blockbotConnections = {}
                
                if not enabled then 
                    blockbotActive = false
                    return 
                end
                
                blockbotActive = true
                
                for _, otherPlayer in ipairs(Players:GetPlayers()) do
                    if otherPlayer ~= player then
                        local platform = Instance.new("Part")
                        platform.Name = otherPlayer.Name .. "_BlockBot"
                        platform.Size = BLOCKBOT_PLATFORM_SIZE
                        platform.Transparency = 1
                        platform.CanCollide = true
                        platform.Anchored = true
                        platform.Parent = workspace.CurrentCamera
                        blockbotParts[otherPlayer] = platform
                    end
                end
                
                local playerAddedConn = Players.PlayerAdded:Connect(function(otherPlayer)
                    if blockbotActive then
                        local platform = Instance.new("Part")
                        platform.Name = otherPlayer.Name .. "_BlockBot"
                        platform.Size = BLOCKBOT_PLATFORM_SIZE
                        platform.Transparency = 1
                        platform.CanCollide = true
                        platform.Anchored = true
                        platform.Parent = workspace.CurrentCamera
                        blockbotParts[otherPlayer] = platform
                    end
                end)
                table.insert(blockbotConnections, playerAddedConn)
                
                local playerRemovingConn = Players.PlayerRemoving:Connect(function(otherPlayer)
                    if blockbotParts[otherPlayer] then
                        blockbotParts[otherPlayer]:Destroy()
                        blockbotParts[otherPlayer] = nil
                    end
                end)
                table.insert(blockbotConnections, playerRemovingConn)
            end

            -- Edge Detection Function
            local function detectEdge(root, char)
                local _junkVal = math.pi * 2
                local _junkRes = math.cos(_junkVal)

                local rayParams = RaycastParams.new()
                rayParams.FilterDescendantsInstances = {char}
                rayParams.FilterType = Enum.RaycastFilterType.Exclude
                
                local downRay = workspace:Raycast(root.Position, Vector3.new(0, -EDGEBUG_DETECTION_RADIUS, 0), rayParams)
                
                if not downRay then return false, nil, nil end
                if downRay.Distance < EDGEBUG_MIN_HEIGHT then return false, nil, nil end
                
                local directions = {
                    Vector3.new(1, 0, 0), Vector3.new(-1, 0, 0),
                    Vector3.new(0, 0, 1), Vector3.new(0, 0, -1),
                    Vector3.new(0.707, 0, 0.707), Vector3.new(-0.707, 0, 0.707),
                    Vector3.new(0.707, 0, -0.707), Vector3.new(-0.707, 0, -0.707)
                }
                
                local edgeDetected = false
                local edgeDirection = nil
                local closestEdgeDistance = math.huge
                
                for _, dir in ipairs(directions) do
                    local checkPos = root.Position + (dir * EDGEBUG_EDGE_THRESHOLD)
                    local edgeRay = workspace:Raycast(checkPos, Vector3.new(0, -EDGEBUG_DETECTION_RADIUS, 0), rayParams)
                    
                    if not edgeRay or edgeRay.Instance ~= downRay.Instance then
                        edgeDetected = true
                        local distanceToEdge = (checkPos - root.Position).Magnitude
                        if distanceToEdge < closestEdgeDistance then
                            closestEdgeDistance = distanceToEdge
                            edgeDirection = -dir
                        end
                    end
                end
                
                return edgeDetected, downRay.Instance, edgeDirection
            end

            local function setupToolConnections(char)
                if not char then return end
                char.ChildAdded:Connect(function(child)
                    -- nospread works via raycast hook
                end)
            end
            if player.Character then setupToolConnections(player.Character) end
            player.CharacterAdded:Connect(setupToolConnections)

            local oldNamecall
            oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                local method = getnamecallmethod()
                local args = {...}
                
                if method == "Raycast" then
                    -- Removed raycast modifications (silent aim, wallbang)
                end

                if Settings.NoFall then
                    if method == "TakeDamage" and self:IsA("Humanoid") then
                        local char = player.Character
                        if char and self == char:FindFirstChild("Humanoid") then
                            local damageAmount = args[1]
                            if damageAmount and damageAmount >= 10 then return end
                        end
                    end
                    
                    if method == "FireServer" or method == "InvokeServer" then
                        local name = tostring(self)
                        if name:lower():find("damage") or name:lower():find("fall") or name:lower():find("hurt") or name:lower():find("health") then
                            return
                        end
                    end
                end
                
                return oldNamecall(self, ...)
            end)

            local oldNewIndex
            oldNewIndex = hookmetamethod(game, "__newindex", function(self, property, value)
                if Settings.NoFall and self:IsA("Humanoid") and property == "Health" then
                    local char = player.Character
                    if char and self == char:FindFirstChild("Humanoid") then
                        local healthDiff = self.Health - value
                        if healthDiff >= 10 then return end
                    end
                end

                if Settings.Slidewalk and player.Character and self:IsDescendantOf(player.Character) then
                    local name = self.Name:lower()
                    if name == "walk" or name == "run" then
                        if self:IsA("Animation") and property == "AnimationId" then
                            -- R15
                            return oldNewIndex(self, property, "")
                        elseif self:IsA("StringValue") and property == "Value" then
                            -- R6
                            if tostring(value):match("rbxasset") then
                                return oldNewIndex(self, property, "")
                            end
                        end
                    end
                end

                return oldNewIndex(self, property, value)
            end)

            -- [FIX] Pixelsurf: track active surf state to cleanly exit
            local pixelsurfActive = false
            local pixelsurfBV = nil

            -- Main Character Setup
            local function setupCharacter(char)
                local _setupTime = tick()
                local _randomOffset = math.random(1, 100) / 100
                if _setupTime < 0 then return end

                disconnectAll()
                
                if not char:FindFirstChild("HumanoidRootPart") then char:WaitForChild("HumanoidRootPart") end
                if not char:FindFirstChild("Humanoid") then char:WaitForChild("Humanoid") end
                if pixelsurfBV then pixelsurfBV:Destroy() pixelsurfBV = nil end
                if edgebugBV then edgebugBV:Destroy() edgebugBV = nil end
                if longjumpBV then longjumpBV:Destroy() longjumpBV = nil end
                isLongJumping = false
                
                task.wait(0.1)
                local hum = char:FindFirstChild("Humanoid")
                local root = char:FindFirstChild("HumanoidRootPart")
                
                if not hum or not root then return end
                
                local maxHealth = hum.MaxHealth
                
                if AimbotSettings.Enabled then
                    createFOVCircle()
                end
                
                lockOnActive = false
                currentTarget = nil
                
                if Settings.BlockBot then
                    setupBlockBot(true)
                end
                
                table.insert(connections, char.AncestryChanged:Connect(function(_, parent)
                    if not parent then
                        disconnectAll()
                    end
                end))
                
                -- MAIN PHYSICS LOOP
                mainLoopConnection = RunService.RenderStepped:Connect(function(dt)
                    local _loop_junk = math.random()
                    if _loop_junk > 1.0 then print("impossible") end

                    local currentChar = player.Character
                    local currentRoot = currentChar and currentChar:FindFirstChild("HumanoidRootPart")
                    local currentHum = currentChar and currentChar:FindFirstChild("Humanoid")
                    
                    if not currentRoot or not currentHum then return end
                    
                    local onGround = (currentHum.FloorMaterial ~= Enum.Material.Air)
                    local now = tick()

                    -- Reset jumpbug state on landing to allow for immediate re-jumpbug
                    if onGround and isJumpingBug then
                        isJumpingBug = false
                    end

                    -- Update canJumpbug based on key held and ground status
                    if Settings.Jumpbug and jumpbugKeyHeld and onGround then
                        canJumpbug = true
                    else
                        canJumpbug = false
                    end

                    -- Reset boost states on landing
                    if onGround then
                        if isLongJumping and (now - lastJumpTime) > 0.2 then
                            isLongJumping = false
                            currentHum.WalkSpeed = DEFAULT_WALKSPEED
                            if longjumpBV then longjumpBV:Destroy() longjumpBV = nil end
                            task.spawn(function()
                                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
                                task.wait(0.4)
                                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
                            end)
                        end
                        if isFlashBoosting and (now - lastFlashBoostTime) > 0.2 then isFlashBoosting = false end
                    end
                    
                    -- BLOCK BOT UPDATE LOOP
                    if Settings.BlockBot and blockbotActive then
                        for otherPlr, platform in pairs(blockbotParts) do
                            if otherPlr.Character and otherPlr.Character:FindFirstChild("Head") then
                                platform.CFrame = otherPlr.Character.Head.CFrame * CFrame.new(0, 1.1, 0)
                            else
                                platform.CFrame = CFrame.new(0, 999999, 0)
                            end
                        end
                    end
                    
                    local isJumpbugKey = Settings.Jumpbug and canJumpbug
                    local isEdgebugKey = Settings.Edgebug and UserInputService:IsKeyDown(Binds.Edgebug)
                    local isPixelSurfKey = Settings.Pixelsurf and UserInputService:IsKeyDown(Binds.Pixelsurf)
                    local isLongJumpKey = Settings.Longjump and UserInputService:IsKeyDown(Binds.Longjump)
                    local isMinijumpKey = Settings.Minijump and UserInputService:IsKeyDown(Binds.Minijump)
                    local isVSurfKey = Settings.VSurf and UserInputService:IsKeyDown(Binds.VSurf)

                    -- Centralized Auto-Crouch Management
                    local isVSurfing = isVSurfKey and currentHum:GetState() == Enum.HumanoidStateType.Climbing

                    local shouldEdgebugCrouch = isEdgebugKey and not isVSurfing and not pixelsurfActive
                    local shouldAutoduckCrouch = Settings.Autoduck and not onGround and not UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)
                        and not isJumpingBug and not pixelsurfActive and not isPixelhopping and not (airstuckPos and Settings.Airstuck) 
                        and (now - lastMinijumpTime > MINIJUMP_COOLDOWN) and not isLongJumping and not isFlashBoosting

                    local shouldCrouchNow = shouldEdgebugCrouch or shouldAutoduckCrouch
                    
                    if shouldCrouchNow and not autoCrouchActive then
                        autoCrouchActive = true
                        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
                    elseif not shouldCrouchNow and autoCrouchActive then
                        autoCrouchActive = false
                        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
                    end
                    
                    -- AIMBOT
                    updateFOVCircle()
                    
                    -- Handle rainbow FOV color
                    if AimbotSettings.Enabled and AimbotSettings.ShowFOV and AimbotSettings.RainbowFOV and fovCircle then
                        local stroke = fovCircle:FindFirstChild("UIStroke")
                        if stroke then
                            stroke.Color = Color3.fromHSV((tick() * (AimbotSettings.RainbowSpeed / 5)) % 1, 1, 1)
                        end
                    end
                    
                    if AimbotSettings.Enabled and lockOnActive then
                        local newTarget = getNearestPlayerHeadInFOV()
                        
                        if newTarget then
                            currentTarget = newTarget
                            
                            pcall(function()
                                camera.CFrame = CFrame.lookAt(camera.CFrame.Position, currentTarget.Position)
                            end)
                        else
                            currentTarget = nil
                        end
                    end

                    -- AIRSTUCK
                    if airstuckPos and Settings.Airstuck then
                        currentRoot.CFrame = airstuckPos
                        currentRoot.AssemblyLinearVelocity = Vector3.zero
                        return
                    end

                    -- // BHOP LOGIC
                    if Settings.Bhop and not isEdgebugKey and not isLongJumping and not isFlashBoosting then 
                        if UserInputService:IsKeyDown(Enum.KeyCode.Space) and currentHum.FloorMaterial ~= Enum.Material.Air and not pixelsurfActive then
                            currentHum.UseJumpPower = false
                            currentHum.JumpHeight = BHOP_JUMP_HEIGHT
                            currentHum.Jump = true
                        end

                        if currentHum.FloorMaterial == Enum.Material.Air or UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                            local moveDir = currentHum.MoveDirection
                            if moveDir.Magnitude > 0 then
                                currentRoot.AssemblyLinearVelocity = Vector3.new(
                                    moveDir.X * BHOP_SPEED, 
                                    currentRoot.AssemblyLinearVelocity.Y, 
                                    moveDir.Z * BHOP_SPEED
                                )
                            end
                        end
                    end
                    -- // END BHOP LOGIC

                    -- FAST STOP
                    if Settings.FastStop and not (keysPressed.W or keysPressed.A or keysPressed.S or keysPressed.D) then
                        -- Only apply on ground and when not using other movement skills that control velocity
                        if onGround and not isLongJumping and not edgebugOnEdge and not pixelsurfActive and not (airstuckPos and Settings.Airstuck) and not isEdgebugKey then
                            local currentVel = currentRoot.AssemblyLinearVelocity
                            local horizontalVel = Vector3.new(currentVel.X, 0, currentVel.Z)

                            if horizontalVel.Magnitude > 1 then
                                -- This creates a strong braking effect by rapidly reducing horizontal velocity.
                                -- It feels like a counter-strafe or quick stop rather than a jarring instant halt.
                                currentRoot.AssemblyLinearVelocity = Vector3.new(currentVel.X * 0.943, currentVel.Y, currentVel.Z * 0.943)
                            end
                        end
                    end

                    -- JUMPBUG (Must hold key)
                    if isJumpbugKey and onGround and not isJumpingBug and UserInputService:IsKeyDown(Enum.KeyCode.Space) and not isEdgebugKey and Settings.Bhop and not pixelsurfActive then
                        isJumpingBug = true
                        task.spawn(function()
                            currentHum.HipHeight = JB_CROUCH_HEIGHT
                            task.wait(JB_AUTO_CROUCH_TIME)
                            currentHum.HipHeight = JB_NORMAL_HEIGHT
                            task.wait(JB_LATENCY)
                            
                            local currentVel = currentRoot.AssemblyLinearVelocity
                            currentRoot.AssemblyLinearVelocity = Vector3.new(currentVel.X, JB_FORCE_AMOUNT * 2, currentVel.Z)
                            
                            local jbBoost = Instance.new("BodyVelocity")
                            jbBoost.MaxForce = Vector3.new(0, 1e7, 0)
                            jbBoost.Velocity = Vector3.new(0, JB_FORCE_AMOUNT, 0)
                            jbBoost.Parent = currentRoot
                            Debris:AddItem(jbBoost, 0.15)
                            
                        end)
                    end
                    

                    
                    -- LONGJUMP - jump with boosted speed, direction follows camera+WASD freely like a normal jump
                    if isLongJumpKey and onGround and (now - lastJumpTime) > 0.1 and not isLongJumping and UserInputService:IsKeyDown(Enum.KeyCode.Space) and not isEdgebugKey and not pixelsurfActive then
                        isLongJumping = true
                        lastJumpTime = now

                        task.spawn(function()
                            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
                            task.wait(0.2)
                            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
                        end)

                        currentHum:ChangeState(Enum.HumanoidStateType.Jumping)
                        currentRoot.AssemblyLinearVelocity = Vector3.new(
                            currentHum.MoveDirection.X * LJ_FORWARD_FORCE,
                            LJ_UPWARD_FORCE,
                            currentHum.MoveDirection.Z * LJ_FORWARD_FORCE
                        )
                    end

                    -- While LJ is airborne: keep boosted speed in whatever direction player steers
                    if isLongJumping and not onGround then
                        local moveDir = currentHum.MoveDirection
                        if moveDir.Magnitude > 0 then
                            if longjumpBV and longjumpBV.Parent then
                                longjumpBV.Velocity = Vector3.new(
                                    moveDir.X * LJ_FORWARD_FORCE,
                                    0,
                                    moveDir.Z * LJ_FORWARD_FORCE
                                )
                            else
                                if longjumpBV then longjumpBV:Destroy() end
                                longjumpBV = Instance.new("BodyVelocity")
                                longjumpBV.MaxForce = Vector3.new(1e7, 0, 1e7)
                                longjumpBV.Velocity = Vector3.new(moveDir.X * LJ_FORWARD_FORCE, 0, moveDir.Z * LJ_FORWARD_FORCE)
                                longjumpBV.Parent = currentRoot
                            end
                        else
                            -- No input: let momentum carry naturally, remove BV so no force applied
                            if longjumpBV then longjumpBV:Destroy() longjumpBV = nil end
                        end
                    end

                    -- MINIJUMP (Must hold key + space)
                    if isMinijumpKey and UserInputService:IsKeyDown(Enum.KeyCode.Space) and onGround and (now - lastMinijumpTime) > MINIJUMP_COOLDOWN and not isEdgebugKey and not pixelsurfActive and not isLongJumping then
                        lastMinijumpTime = now

                        -- Jump immediately
                        currentHum.UseJumpPower = false
                        currentHum.JumpHeight = MINIJUMP_JUMP_HEIGHT
                        currentHum.Jump = true

                        task.spawn(function()
                            -- Re-fetch character and humanoid in case of respawn
                            local currentChar = player.Character
                            if not (currentChar and currentChar:FindFirstChild("Humanoid")) then return end

                            task.wait() -- Wait for player to be in air

                            -- Always crouch during minijump regardless of Autoduck setting
                            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
                            task.wait(MINIJUMP_CROUCH_TIME)
                            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
                        end)
                    end

                    -- EDGEJUMP
                    if Settings.EdgeJump and not edgeJumpCooldown and not isEdgebugKey and not isLongJumping and (now - lastMinijumpTime > 1) then
                        -- Check if the player is falling (Y velocity <= 0) rather than jumping (Y velocity > 0)
                        -- This prevents EdgeJump from activating on a normal/bhop jump.
                        if wasOnGround and not onGround and currentRoot.AssemblyLinearVelocity.Y <= 0 and not pixelsurfActive then
                            local rayParams = RaycastParams.new()
                            rayParams.FilterDescendantsInstances = {currentChar}
                            rayParams.FilterType = Enum.RaycastFilterType.Exclude
                            
                            local edgeDetected = false
                            local checkRadius = 1.5
                            
                            local downRay = workspace:Raycast(currentRoot.Position, Vector3.new(0, -EDGEJUMP_DETECTION_HEIGHT, 0), rayParams)
                            
                            if not downRay or downRay.Distance > EDGEJUMP_MIN_DISTANCE then
                                edgeDetected = true
                            else
                                for i = 0, 360, 10 do
                                    local rad = math.rad(i)
                                    local offset = Vector3.new(math.cos(rad), 0, math.sin(rad)) * checkRadius
                                    local ray = workspace:Raycast(currentRoot.Position + offset, Vector3.new(0, -EDGEJUMP_DETECTION_HEIGHT, 0), rayParams)
                                    if not ray or ray.Distance > EDGEJUMP_MIN_DISTANCE then
                                        edgeDetected = true
                                        break
                                    end
                                end
                            end
                            
                            if edgeDetected then
                                local currentTime = tick()
                                
                                if currentTime - lastEdgeJumpTime > EDGEJUMP_COOLDOWN then
                                    lastEdgeJumpTime = currentTime
                                    
                                    if isLongJumpKey then
                                        isLongJumping = true
                                        lastJumpTime = currentTime

                                        task.spawn(function()
                                            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
                                            task.wait(0.2)
                                            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
                                        end)

                                        currentHum:ChangeState(Enum.HumanoidStateType.Jumping)
                                        currentRoot.AssemblyLinearVelocity = Vector3.new(
                                            currentHum.MoveDirection.X * LJ_FORWARD_FORCE,
                                            LJ_UPWARD_FORCE,
                                            currentHum.MoveDirection.Z * LJ_FORWARD_FORCE
                                        )
                                    else
                                        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                                            currentHum:ChangeState(Enum.HumanoidStateType.Jumping)
                                        else
                                            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
                                            task.wait(0.05)
                                            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
                                        end
                                    end
                                    
                                    edgeJumpCooldown = true
                                    task.spawn(function()
                                        task.wait(EDGEJUMP_COOLDOWN)
                                        edgeJumpCooldown = false
                                    end)
                                end
                            end
                        end
                    end
                    
                    wasOnGround = onGround
                    
                    -- Set default movement properties
                    currentHum.UseJumpPower = false
                    if not Settings.Bhop then
                        currentHum.JumpHeight = DEFAULT_JUMP_HEIGHT
                    end
                    if not pixelsurfActive and not isEdgebugKey and not (isLongJumping and not onGround) then
                        currentHum.WalkSpeed = DEFAULT_WALKSPEED
                    end
                    -- VERTICAL SURF (Must hold key)
                    if isVSurfKey and currentHum:GetState() == Enum.HumanoidStateType.Climbing then
                        local bv = Instance.new("BodyVelocity")
                        bv.MaxForce = Vector3.new(0, V_SURF_FORCE, 0)
                        bv.Parent = currentRoot
                        bv.Velocity = Vector3.new(0, V_SURF_SPEED, 0)
                        Debris:AddItem(bv, dt)
                    end
                    
                    -- EDGEBUG / SLIDE (Must hold key)
                    if isEdgebugKey then
                        currentHum.Jump = false
                        currentHum.WalkSpeed = EDGEBUG_SLIDE_SPEED
                        local onEdge, edgeObject, edgeDir = detectEdge(currentRoot, currentChar)
                        if onEdge and edgeObject then
                            lastEdgeObject = edgeObject
                            edgebugOnEdge = true
                            
                            local moveInput = Vector3.zero
                            if keysPressed.W then moveInput = moveInput + currentRoot.CFrame.LookVector end
                            if keysPressed.S then moveInput = moveInput - currentRoot.CFrame.LookVector end
                            if keysPressed.A then moveInput = moveInput - currentRoot.CFrame.RightVector end
                            if keysPressed.D then moveInput = moveInput + currentRoot.CFrame.RightVector end
                            
                            edgeSlideDirection = moveInput.Magnitude > 0 and moveInput.Unit or (edgeDir or currentRoot.CFrame.LookVector)
                        elseif lastEdgeObject then
                            edgebugOnEdge = true
                        else
                            edgebugOnEdge = false
                        end
                        
                        if edgebugOnEdge and edgeSlideDirection then
                            if not edgebugBV then
                                edgebugBV = Instance.new("BodyVelocity")
                                edgebugBV.MaxForce = Vector3.new(1e7, 1e7, 1e7)
                                edgebugBV.Parent = currentRoot
                            end
                            
                            local currentVel = currentRoot.AssemblyLinearVelocity
                            local hVel = Vector3.new(currentVel.X, 0, currentVel.Z)
                            local targetSpeed = math.max(hVel.Magnitude, EDGEBUG_SLIDE_SPEED)

                            edgebugBV.Velocity = Vector3.new(
                                edgeSlideDirection.X * targetSpeed,
                                0,
                                edgeSlideDirection.Z * targetSpeed
                            )
                        else
                            if edgebugBV then edgebugBV:Destroy() edgebugBV = nil end
                        end
                    else
                        if edgebugBV then edgebugBV:Destroy() edgebugBV = nil end
                        edgebugOnEdge = false
                        lastEdgeObject = nil
                        edgeSlideDirection = nil
                    end
                    
                    -- PIXELSURF (Must hold key)
                    if isPixelSurfKey then
                        local rayParams = RaycastParams.new()
                        rayParams.FilterDescendantsInstances = {currentChar}
                        rayParams.FilterType = Enum.RaycastFilterType.Exclude
                        
                        local directions = {currentRoot.CFrame.RightVector, -currentRoot.CFrame.RightVector, currentRoot.CFrame.LookVector, -currentRoot.CFrame.LookVector}
                        local wallHit, wallDistance = nil, math.huge
                        for _, dir in ipairs(directions) do
                            local ray = workspace:Raycast(currentRoot.Position, dir * (PX_WALL_DETECT_DIST + 1.5), rayParams)
                            if ray and ray.Distance < wallDistance then wallHit = ray; wallDistance = ray.Distance end
                        end
                        
                        if wallHit then
                            pixelsurfActive = true
                            currentHum.WalkSpeed = PIXELSURF_WALKSPEED
                            currentHum.AutoRotate = false
                            
                            local currentVel = currentRoot.AssemblyLinearVelocity
                            local travelDir = currentVel.Magnitude > 1 and currentVel.Unit or currentRoot.CFrame.LookVector
                            local rawTangent = Vector3.new(-wallHit.Normal.Z, 0, wallHit.Normal.X)
                            
                            if rawTangent.Magnitude < 0.001 then
                                rawTangent = currentRoot.CFrame.LookVector
                            end
                            local tangent = rawTangent.Unit
                            if tangent:Dot(travelDir) < (-tangent):Dot(travelDir) then tangent = -tangent end
                            lockedSurfDir = tangent
                            
                            local lookCf = CFrame.lookAt(currentRoot.Position, currentRoot.Position + lockedSurfDir)
                            local _, yRot, _ = lookCf:ToOrientation()
                            currentRoot.CFrame = CFrame.new(currentRoot.Position) * CFrame.fromOrientation(0, yRot, 0)
                            
                            if not pixelsurfBV or pixelsurfBV.Parent ~= currentRoot then
                                pixelsurfBV = Instance.new("BodyVelocity")
                                pixelsurfBV.MaxForce = Vector3.new(2e6, 2e6, 2e6)
                                pixelsurfBV.Parent = currentRoot
                            end
                            pixelsurfBV.Velocity = (lockedSurfDir * PIXELSURF_WALKSPEED) + Vector3.new(0, currentRoot.AssemblyLinearVelocity.Y * PX_GRAVITY_REDUCTION, 0)
                        else
                            lockedSurfDir = nil
                            if pixelsurfActive then
                                pixelsurfActive = false
                                currentHum.AutoRotate = true
                                currentHum.WalkSpeed = DEFAULT_WALKSPEED
                                if pixelsurfBV then pixelsurfBV:Destroy() pixelsurfBV = nil end
                            end
                        end
                    else
                        if pixelsurfActive then
                            pixelsurfActive = false
                            lockedSurfDir = nil
                            currentHum.AutoRotate = true
                            currentHum.WalkSpeed = DEFAULT_WALKSPEED
                            if pixelsurfBV then pixelsurfBV:Destroy() pixelsurfBV = nil end
                        end
                        lockedSurfDir = nil
                    end
                end)
            end

            if player.Character then
                setupCharacter(player.Character)
            end
            player.CharacterAdded:Connect(setupCharacter)

            -- // INPUT HANDLING
            UserInputService.InputBegan:Connect(function(input, gpe)
                local _input_check = input.UserInputType
                local _ = tostring(_input_check)

                if gpe then return end
                
                local k = input.KeyCode
                
                if k == Enum.KeyCode.W then keysPressed.W = true end
                if k == Enum.KeyCode.A then keysPressed.A = true end
                if k == Enum.KeyCode.S then keysPressed.S = true end
                if k == Enum.KeyCode.D then keysPressed.D = true end
                
                if k == Binds.Jumpbug then jumpbugKeyHeld = true end

                -- PIXELHOP (Press key to activate)
                if Settings.Pixelhop and k == Binds.Pixelhop then
                    local now = tick()
                    local isEdgebugKey = Settings.Edgebug and UserInputService:IsKeyDown(Binds.Edgebug)

                    if not isPixelhopping and (now - lastPixelhopTime) > PIXELHOP_COOLDOWN and not isEdgebugKey then
                        local currentChar = player.Character
                        if not currentChar then return end
                        local currentRoot = currentChar:FindFirstChild("HumanoidRootPart")
                        local currentHum = currentChar:FindFirstChild("Humanoid")
                        if not currentRoot or not currentHum then return end

                        local rayParams = RaycastParams.new()
                        rayParams.FilterDescendantsInstances = {currentChar}
                        rayParams.FilterType = Enum.RaycastFilterType.Exclude
                        
                        local rootCF = currentRoot.CFrame
                        local directions = {rootCF.RightVector, -rootCF.RightVector, rootCF.LookVector, -rootCF.LookVector}
                        local wallHit = nil
                        for _, dir in ipairs(directions) do
                            local ray = workspace:Raycast(currentRoot.Position, dir * PIXELHOP_WALL_DETECT_DIST, rayParams)
                            if ray then wallHit = ray; break end
                        end
                        
                        if wallHit then
                            isPixelhopping = true
                            lastPixelhopTime = now
                            task.spawn(function()
                                local char = player.Character
                                if not char then isPixelhopping = false; return end
                                local hum = char:FindFirstChild("Humanoid")
                                local root = char:FindFirstChild("HumanoidRootPart")
                                if not hum or not root then isPixelhopping = false; return end

                                hum.HipHeight = JB_CROUCH_HEIGHT
                                task.wait(PIXELHOP_CROUCH_TIME)
                                hum.HipHeight = JB_NORMAL_HEIGHT
                                task.wait(PIXELHOP_LATENCY)
                                
                                local phBoost = Instance.new("BodyVelocity")
                                phBoost.MaxForce = Vector3.new(0, 1e7, 0)
                                phBoost.Velocity = Vector3.new(0, PIXELHOP_FORCE, 0)
                                phBoost.Parent = root
                                Debris:AddItem(phBoost, 0.12)
                                
                                task.wait(PIXELHOP_COOLDOWN)
                                isPixelhopping = false
                            end)
                        end
                    end
                end

                if Settings.FlashBoost and k == Binds.FlashBoost then
                    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                    if root then
                        isFlashBoosting = true
                        lastFlashBoostTime = tick()
                        root.AssemblyLinearVelocity = (root.CFrame.LookVector * FB_FORWARD_FORCE) + Vector3.new(0, FB_UPWARD_FORCE, 0)
                    end
                end
                
                if Settings.Airstuck and k == Binds.Airstuck then
                    if airstuckPos then
                        airstuckPos = nil
                    else
                        local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                        if root then airstuckPos = root.CFrame end
                    end
                end
                
                if AimbotSettings.Enabled then
                    local keyMatch = false
                    if input.UserInputType == AimbotSettings.LockOnKey then keyMatch = true end
                    if input.KeyCode == AimbotSettings.LockOnKey then keyMatch = true end
                    if keyMatch then
                        lockOnActive = true
                        currentTarget = getNearestPlayerHeadInFOV()
                    end
                end
            end)


            UserInputService.InputEnded:Connect(function(input)
                local k = input.KeyCode
                if k == Enum.KeyCode.W then keysPressed.W = false end
                if k == Enum.KeyCode.A then keysPressed.A = false end
                if k == Enum.KeyCode.S then keysPressed.S = false end
                if k == Enum.KeyCode.D then keysPressed.D = false end
                
                if k == Binds.Jumpbug then
                    canJumpbug = false
                    jumpbugKeyHeld = false
                end
                if AimbotSettings.Enabled then
                    local keyMatch = false
                    if input.UserInputType == AimbotSettings.LockOnKey then keyMatch = true end
                    if input.KeyCode == AimbotSettings.LockOnKey then keyMatch = true end
                    if keyMatch then
                        lockOnActive = false
                        currentTarget = nil
                    end
                end
            end)
