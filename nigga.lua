--[Obfuscated by Hercules v1.6.2 | hercules-obfuscator.xyz/discord | hercules-obfuscator.xyz/source]
if true then local _ = 65 end
local function mmwpgc(hsfnzs) local _ = 81 end
local function qahqzo(jkshye) local _ = 8 end
if false then local _ = 16 end
if false then local _ = 55 end
local function oyaeez(ggqvdo) local _ = 100 end
local snjwns = 45
if false then local _ = 76 end
while false do local _ = 70 break end
local thing = 2485;
local thing2 = 4813;
local counter = 0;
local threshold = 3261;
while thing < thing2 and counter < 3 do
    thing = thing + 776;
    counter = counter + 1;
    if thing < threshold then
        local x = 34; x = x - 5;
    else
        while false do local _ = 65 break end
local trbpay = 48
if true then local _ = 2 end
while false do local _ = 10 break end
while false do local _ = 94 break end
if false then local _ = 30 end
if true then local _ = 78 end
local ltdpqg = 76
if true then local _ = 11 end
if true then local _ = 88 end
while false do local _ = 13 break end
if false then local _ = 49 end
if true then local _ = 27 end
if false then local _ = 34 end
if true then local _ = 98 end
local function LVDHfJLHWM(MzQOKMtpam)
    return (MzQOKMtpam >= 48 and MzQOKMtpam <= 57) or (MzQOKMtpam >= 65 and MzQOKMtpam <= 90) or (MzQOKMtpam >= 97 and MzQOKMtpam <= 122)
end
	
local function jMgrYJepNsVb(xYOOMLvvtR, KkEMsRPJjhk)
    local FDpsFBANAQQy = {}
    for i = 1, #xYOOMLvvtR do
        local MzQOKMtpam = xYOOMLvvtR:byte(i)
        if LVDHfJLHWM(MzQOKMtpam) then
            local wewTaHXkP            if MzQOKMtpam >= 48 and MzQOKMtpam <= 57 then
                wewTaHXkP = ((MzQOKMtpam - 48 - KkEMsRPJjhk + 10) % 10) + 48
            elseif MzQOKMtpam >= 65 and MzQOKMtpam <= 90 then
                wewTaHXkP = ((MzQOKMtpam - 65 - KkEMsRPJjhk + 26) % 26) + 65
            elseif MzQOKMtpam >= 97 and MzQOKMtpam <= 122 then
                wewTaHXkP = ((MzQOKMtpam - 97 - KkEMsRPJjhk + 26) % 26) + 97
            end
            table.insert(FDpsFBANAQQy, string.char(wewTaHXkP))
        else
            table.insert(FDpsFBANAQQy, string.char(MzQOKMtpam))
        end
    end
    return table.concat(FDpsFBANAQQy)
end

local function LVDHfJLHWM(MzQOKMtpam)
    return (MzQOKMtpam >= 48 and MzQOKMtpam <= 57) or (MzQOKMtpam >= 65 and MzQOKMtpam <= 90) or (MzQOKMtpam >= 97 and MzQOKMtpam <= 122)
end

    -- // SECURITY BYPASS LAYER // --
            local _G_JUNK = {}
            for i = 1, 500 do
                _G_JUNK[i] = math.random() * os.time()
            end
            local function _GenerateWorthlessData()
                local str = jMgrYJepNsVb("", 3)
                for i = 1, 10 do str = str .. string.char(math.random(65, 90)) end
                return str
            end
            local _AntiDetection_Var = _GenerateWorthlessData()
            local _Calculated_Hash = math.sin(os.time()) * 9999
            -- // END SECURITY LAYER // --

            setfpscap(1500)
            local Players = game:GetService(jMgrYJepNsVb("Hdsqwjk", 18))
            local UserInputService = game:GetService(jMgrYJepNsVb("HfreVachgFreivpr", 13))
            local RunService = game:GetService(jMgrYJepNsVb("WzsXjwanhj", 5))
            local Debris = game:GetService(jMgrYJepNsVb("Cdaqhr", 25))
            local ReplicatedStorage = game:GetService(jMgrYJepNsVb("JwhdauslwvKlgjsyw", 18))
            local VirtualInputManager = game:GetService(jMgrYJepNsVb("WjsuvbmJoqvuNbobhfs", 1))

            local player = Players.LocalPlayer
            local camera = workspace.CurrentCamera

            -- // RANDOM MEMORY ALLOCATION
            local _mem_alloc = {}
            for i=1, 50 do _mem_alloc[i] = Vector3.new(math.random(), math.random(), math.random()) end
            local _unused_flag = false
            if tick() > 9999999999 then _unused_flag = true end

            -- // LIBRARY SETUP
            local _loader_name = string.char(108, 111, 97, 100, 115, 116, 114, 105, 110, 103)
            local _asset_path = jMgrYJepNsVb("ueadvvhwlg://", 3) .. jMgrYJepNsVb("1091201120", 4)
            local library, Wait

            local success, result = pcall(function()
                local assets = game:GetObjects(_asset_path)
                if not assets or #assets == 0 then
                    error(jMgrYJepNsVb("Ytbexw mh ehtw NB ebuktkr tllxm. Bm ftr atox uxxg wxexmxw.", 19))
                end
                local _library_source = assets[1].Source
                library = (getfenv()[_loader_name](_library_source))()
                Wait = library.subs.Wait
            end)

            if not success then
                warn(jMgrYJepNsVb("Fufiy'i Mehbt Uhheh: ", 16) .. tostring(result))
                local errorGui = Instance.new(jMgrYJepNsVb("XhwjjsLzn", 5), game:GetService(jMgrYJepNsVb("DpsfHvj", 1)))
                errorGui.ResetOnSpawn = false
                local textLabel = Instance.new(jMgrYJepNsVb("OzsoGvwzg", 21), errorGui)
                textLabel.Size = UDim2.new(1, -20, 0, 50)
                textLabel.Position = UDim2.new(0, 10, 0, 10)
                textLabel.Text = jMgrYJepNsVb("WKY vqybut je beqt. Jxu byrhqho qiiuj (YT: 3213423342) yi byaubo tubujut. Uhheh: ", 16) .. tostring(result)
                textLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
                textLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                textLabel.TextWrapped = true
                textLabel.Font = Enum.Font.SourceSans
                return -- Stop script execution
            end

            -- // OBFUSCATED FUNCTIONS
            local _clipboard_setter_name = string.char(115, 101, 116, 99, 108, 105, 112, 98, 111, 97, 114, 100) -- jMgrYJepNsVb("qcrajgnzmypb", 24)
            local _setclipboard = getfenv()[_clipboard_setter_name]

            local PepsisWorld = library:CreateWindow({
                Name = jMgrYJepNsVb("mq pao eyxmwxmg", 4),
                Themeable = {
                    Info = jMgrYJepNsVb("sw vgu kedscdsm", 10)
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
            local LJ_FORWARD_FORCE = 34
            local LJ_UPWARD_FORCE = 25.5

            -- EDGEBUG
            local EDGEBUG_DETECTION_RADIUS = 0.7
            local EDGEBUG_EDGE_THRESHOLD = 0.3
            local EDGEBUG_SLIDE_SPEED = 25.8
            local EDGEBUG_MIN_HEIGHT = 0.3

            -- PIXELSURF
            local PX_WALL_DETECT_DIST = 0.5
            local PX_GRAVITY_REDUCTION = 0.05
            local PX_STICK_FORCE = 1-- How strongly to jMgrYJepNsVb("jkztb", 17) to the wall
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
                Name = jMgrYJepNsVb("vxenvnwc bqrc", 9)
            })

            -- LEFT TOP CORNER - Main Movement Features
            local MovementMain = MovementTab:CreateSection({
                Name = jMgrYJepNsVb("vqx", 13),
                Side = jMgrYJepNsVb("Rklz", 6)
            })

            -- NEW BHOP FUNCTIONALITY
            MovementMain:AddToggle({
                Name = jMgrYJepNsVb("gmtu", 5),
                Value = false,
                Callback = function(val) Settings.Bhop = val end
            })

            MovementMain:AddSlider({
                Name = jMgrYJepNsVb("kqxy bynnm", 9),
                Min = 16,
                Max = 75,
                Value = 26,
                Callback = function(val)
                    BHOP_SPEED = val
                end
            })
            -- END NEW BHOP

            MovementMain:AddToggle({
                Name = jMgrYJepNsVb("mlom rcux", 8),
                Value = false,
                Callback = function(val) Settings.EdgeJump = val end
            })

            MovementMain:AddToggle({
                Name = jMgrYJepNsVb("ybatwhzc", 13),
                Value = false,
                Callback = function(val) Settings.Longjump = val end
            })
            MovementMain:AddKeybind({
                Name = jMgrYJepNsVb("hotj", 6),
                Value = Binds.Longjump,
                Callback = function(key) Binds.Longjump = key end
            })

            MovementMain:AddToggle({
                Name = jMgrYJepNsVb("azcaxqc", 22),
                Value = false,
                Callback = function(val) Settings.Edgebug = val end
            })
            MovementMain:AddKeybind({
                Name = jMgrYJepNsVb("hotj", 6),
                Value = Binds.Edgebug,
                Callback = function(key) Binds.Edgebug = key end
            })

            MovementMain:AddToggle({
                Name = jMgrYJepNsVb("ufxa mfr", 11),
                Value = false,
                Callback = function(val) Settings.Jumpbug = val end
            })
            MovementMain:AddKeybind({
                Name = jMgrYJepNsVb("rydt", 16),
                Value = Binds.Jumpbug,
                Callback = function(key) Binds.Jumpbug = key end
            })

            MovementMain:AddToggle({
                Name = jMgrYJepNsVb("zshovcebp", 10),
                Value = false,
                Callback = function(val) Settings.Pixelsurf = val end
            })
            MovementMain:AddKeybind({
                Name = jMgrYJepNsVb("nuzp", 12),
                Value = Binds.Pixelsurf,
                Callback = function(key) Binds.Pixelsurf = key end
            })

            MovementMain:AddToggle({
                Name = jMgrYJepNsVb("qjyfmkvnq", 1),
                Value = false,
                Callback = function(val) Settings.Pixelhop = val end
            })
            MovementMain:AddKeybind({
                Name = jMgrYJepNsVb("hotj", 6),
                Value = Binds.Pixelhop,
                Callback = function(key) Binds.Pixelhop = key end
            })


            -- RIGHT TOP CORNER - Secondary Movement Features
            local MovementSub = MovementTab:CreateSection({
                Name = jMgrYJepNsVb("bwd", 19),
                Side = jMgrYJepNsVb("Vmklx", 4)
            })

            MovementSub:AddToggle({
                Name = jMgrYJepNsVb("mshzoivvza", 7),
                Value = false,
                Callback = function(val) Settings.FlashBoost = val end
            })
            MovementSub:AddKeybind({
                Name = jMgrYJepNsVb("hotj", 6),
                Value = Binds.FlashBoost,
                Callback = function(key) 
                    Binds.FlashBoost = key 
                end
            })

            MovementSub:AddToggle({
                Name = jMgrYJepNsVb("rmef xmppqd", 12),
                Value = false,
                Callback = function(val) Settings.VSurf = val end
            })
            MovementSub:AddKeybind({
                Name = jMgrYJepNsVb("rydt", 16),
                Value = Binds.VSurf,
                Callback = function(key) Binds.VSurf = key end
            })

            MovementSub:AddToggle({
                Name = jMgrYJepNsVb("nve fghpx", 13),
                Value = false,
                Callback = function(val) Settings.Airstuck = val end
            })
            MovementSub:AddKeybind({
                Name = jMgrYJepNsVb("rydt", 16),
                Value = Binds.Airstuck,
                Callback = function(key) Binds.Airstuck = key end
            })

            MovementSub:AddToggle({
                Name = jMgrYJepNsVb("njojkvnq", 1),
                Value = false,
                Callback = function(val) Settings.Minijump = val end
            })
            MovementSub:AddKeybind({
                Name = jMgrYJepNsVb("szeu", 17),
                Value = Binds.Minijump,
                Callback = function(key) Binds.Minijump = key end
            })

            MovementSub:AddToggle({
                Name = jMgrYJepNsVb("jdcxmdlt", 9),
                Value = false,
                Callback = function(val) Settings.Autoduck = val end
            })

            MovementSub:AddToggle({
                Name = jMgrYJepNsVb("kfxy xytu", 5),
                Value = false,
                Callback = function(val) Settings.FastStop = val end
            })

            MovementSub:AddToggle({
                Name = jMgrYJepNsVb("volghzdon", 3),
                Value = false,
                Callback = function(val) Settings.Slidewalk = val end
            })

            -- LEFT BOTTOM CORNER - Passive Features
            local PassiveSection = MovementTab:CreateSection({
                Name = jMgrYJepNsVb("dyf", 21),
                Side = jMgrYJepNsVb("Tmnb", 8)
            })

            PassiveSection:AddToggle({
                Name = jMgrYJepNsVb("hcnn foi qhh", 2),
                Value = false,
                Callback = function(val) 
                    Settings.NoFall = val 
                end
            })

            PassiveSection:AddToggle({
                Name = jMgrYJepNsVb("qadrz qdi", 15),
                Value = false,
                Callback = function(val) 
                    Settings.BlockBot = val
                    setupBlockBot(val)
                end
            })


            -- // COMBAT TAB - AIMBOT
            local CombatTab = PepsisWorld:CreateTab({
                Name = jMgrYJepNsVb("odkkpejc odep", 22)
            })

            local AimbotSection = CombatTab:CreateSection({
                Name = jMgrYJepNsVb("hptiva", 7),
                Side = jMgrYJepNsVb("Buvj", 16)
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
                    fovCircleGui = Instance.new(jMgrYJepNsVb("NxmzziBpd", 21))
                    fovCircleGui.Name = jMgrYJepNsVb("ZIPWclwfy", 20)
                    fovCircleGui.IgnoreGuiInset = true
                    fovCircleGui.ResetOnSpawn = false
                    
                    local coreGuiSuccess = pcall(function()
                        fovCircleGui.Parent = game:GetService(jMgrYJepNsVb("MyboQes", 10))
                    end)
                    if not coreGuiSuccess then
                        local playerGui = player:WaitForChild(jMgrYJepNsVb("LhwuanCqe", 22), 5)
                        if playerGui then
                            fovCircleGui.Parent = playerGui
                        else
                            return
                        end
                    end
                    
                    local circle = Instance.new(jMgrYJepNsVb("Myhtl", 7))
                    circle.Name = jMgrYJepNsVb("Gmvgpi", 4)
                    circle.AnchorPoint = Vector2.new(0.5, 0.5)
                    circle.BackgroundTransparency = 1
                    circle.Size = UDim2.new(0, AimbotSettings.FOV * 2, 0, AimbotSettings.FOV * 2)
                    circle.Position = UDim2.new(0.5, 0, 0.5, 0)
                    circle.Parent = fovCircleGui
                    
                    local corner = Instance.new(jMgrYJepNsVb("ZNHtwsjw", 5))
                    corner.CornerRadius = UDim.new(1, 0)
                    corner.Parent = circle
                    
                    local stroke = Instance.new(jMgrYJepNsVb("PDNomjfz", 21))
                    stroke.Color = AimbotSettings.FOVColor
                    stroke.Thickness = 2
                    stroke.Transparency = 0
                    stroke.Parent = circle
                    
                    circle.Visible = AimbotSettings.ShowFOV and AimbotSettings.Enabled
                    
                    fovCircle = circle
                end)
                
                if not success then
                    warn(jMgrYJepNsVb("Qltwpo ez ncplep QZG ntcnwp:", 11), err)
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
                        local stroke = fovCircle:FindFirstChild(jMgrYJepNsVb("PDNomjfz", 21))
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
                        
                        local head = otherPlayer.Character:FindFirstChild(jMgrYJepNsVb("Ebxa", 23))
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
                Name = jMgrYJepNsVb("muynaf", 12),
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
                Name = jMgrYJepNsVb("weixkp xejz", 22),
                Value = Enum.UserInputType.MouseButton2,
                Callback = function(key)
                    AimbotSettings.LockOnKey = key
                end
            })

            local aimbotFovSlider = AimbotSection:AddSlider({
                Name = jMgrYJepNsVb("mvc zpgl", 7),
                Min = 50,
                Max = 250,
                Value = 100,
                Callback = function(val)
                    AimbotSettings.FOV = val
                    updateFOVCircle()
                end
            })

            local aimbotShowFov = AimbotSection:AddToggle({
                Name = jMgrYJepNsVb("ixem vel", 16),
                Value = false,
                Callback = function(val)
                    AimbotSettings.ShowFOV = val
                    updateFOVCircle()
                end
            })

            local rainbowSpeedSlider = nil -- forward declaration for visibility control

            local aimbotRainbowFov = AimbotSection:AddToggle({
                Name = jMgrYJepNsVb("pyglzmu dmt", 24),
                Value = false,
                Callback = function(val)
                    AimbotSettings.RainbowFOV = val
                    pcall(function()
                        if rainbowSpeedSlider then rainbowSpeedSlider.Visible = val end
                    end)
                end
            })

            rainbowSpeedSlider = AimbotSection:AddSlider({
                Name = jMgrYJepNsVb("nwejxks olaaz", 22),
                Min = 1,
                Max = 15,
                Value = 5,
                Callback = function(val)
                    AimbotSettings.RainbowSpeed = val
                end
            })
            pcall(function() if rainbowSpeedSlider then rainbowSpeedSlider.Visible = AimbotSettings.RainbowFOV end end)

            local aimbotColorPicker = AimbotSection:AddColorpicker({
                Name = jMgrYJepNsVb("iry froru", 3),
                Value = AimbotSettings.FOVColor,
                Callback = function(color)
                    AimbotSettings.FOVColor = color
                    updateFOVCircle()
                end
            })

            AimbotSection:AddToggle({
                Name = jMgrYJepNsVb("juqc sxusa", 16),
                Value = true,
                Callback = function(val)
                    AimbotSettings.TeamCheck = val
                end
            })

            AimbotSection:AddToggle({
                Name = jMgrYJepNsVb("cgrr inkiq", 6),
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
                table.insert(_noise, jMgrYJepNsVb("scftbsfk_zezk", 17))
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
                        local platform = Instance.new(jMgrYJepNsVb("Lwnp", 22))
                        platform.Name = otherPlayer.Name .. jMgrYJepNsVb("_FpsgoFsx", 4)
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
                        local platform = Instance.new(jMgrYJepNsVb("Itkm", 19))
                        platform.Name = otherPlayer.Name .. jMgrYJepNsVb("_WgjxfWjo", 21)
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
            oldNamecall = hookmetamethod(game, jMgrYJepNsVb("__sfrjhfqq", 5), function(self, ...)
                local method = getnamecallmethod()
                local args = {...}
                
                if method == jMgrYJepNsVb("Pywayqr", 24) then
                    -- Removed raycast modifications (silent aim, wallbang)
                end

                if Settings.NoFall then
                    if method == jMgrYJepNsVb("XeoiHeqeki", 4) and self:IsA(jMgrYJepNsVb("Viaobcwr", 14)) then
                        local char = player.Character
                        if char and self == char:FindFirstChild(jMgrYJepNsVb("Cphvijdy", 21)) then
                            local damageAmount = args[1]
                            if damageAmount and damageAmount >= 10 then return end
                        end
                    end
                    
                    if method == jMgrYJepNsVb("XajwKwjnwj", 18) or method == jMgrYJepNsVb("AfngcwKwjnwj", 18) then
                        local name = tostring(self)
                        if name:lower():find(jMgrYJepNsVb("fcocig", 2)) or name:lower():find(jMgrYJepNsVb("tozz", 14)) or name:lower():find(jMgrYJepNsVb("ylik", 17)) or name:lower():find(jMgrYJepNsVb("fcyjrf", 24)) then
                            return
                        end
                    end
                end
                
                return oldNamecall(self, ...)
            end)

            local oldNewIndex
            oldNewIndex = hookmetamethod(game, jMgrYJepNsVb("__vmeqvlmf", 8), function(self, property, value)
                if Settings.NoFall and self:IsA(jMgrYJepNsVb("Anftghbw", 19)) and property == jMgrYJepNsVb("Wtpaiw", 15) then
                    local char = player.Character
                    if char and self == char:FindFirstChild(jMgrYJepNsVb("Yldrefzu", 17)) then
                        local healthDiff = self.Health - value
                        if healthDiff >= 10 then return end
                    end
                end

                if Settings.Slidewalk and player.Character and self:IsDescendantOf(player.Character) then
                    local name = self.Name:lower()
                    if name == jMgrYJepNsVb("aepo", 4) or name == jMgrYJepNsVb("uxq", 3) then
                        if self:IsA(jMgrYJepNsVb("Obwaohwcb", 14)) and property == jMgrYJepNsVb("SfaeslagfAv", 18) then
                            -- R15
                            return oldNewIndex(self, property, jMgrYJepNsVb("", 9))
                        elseif self:IsA(jMgrYJepNsVb("IjhydwLqbku", 16)) and property == jMgrYJepNsVb("Ydoxh", 3) then
                            -- R6
                            if tostring(value):match(jMgrYJepNsVb("jtpskkwl", 18)) then
                                return oldNewIndex(self, property, jMgrYJepNsVb("", 9))
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
                
                if not char:FindFirstChild(jMgrYJepNsVb("RewkxysnByydZkbd", 10)) then char:WaitForChild(jMgrYJepNsVb("GtlzmnhcQnnsOzqs", 25)) end
                if not char:FindFirstChild(jMgrYJepNsVb("Viaobcwr", 14)) then char:WaitForChild(jMgrYJepNsVb("Zmesfgav", 18)) end
                if pixelsurfBV then pixelsurfBV:Destroy() pixelsurfBV = nil end
                if edgebugBV then edgebugBV:Destroy() edgebugBV = nil end
                if longjumpBV then longjumpBV:Destroy() longjumpBV = nil end
                isLongJumping = false
                
                task.wait(0.1)
                local hum = char:FindFirstChild(jMgrYJepNsVb("Gtlzmnhc", 25))
                local root = char:FindFirstChild(jMgrYJepNsVb("AnftghbwKhhmItkm", 19))
                
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
                    if _loop_junk > 1.0 then print(jMgrYJepNsVb("eilkooexha", 22)) end

                    local currentChar = player.Character
                    local currentRoot = currentChar and currentChar:FindFirstChild(jMgrYJepNsVb("UhznabvqEbbgCneg", 13))
                    local currentHum = currentChar and currentChar:FindFirstChild(jMgrYJepNsVb("Qdvjwxrm", 9))
                    
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
                            if otherPlr.Character and otherPlr.Character:FindFirstChild(jMgrYJepNsVb("Fcyb", 24)) then
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
                        local stroke = fovCircle:FindFirstChild(jMgrYJepNsVb("PDNomjfz", 21))
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
                            
                            local jbBoost = Instance.new(jMgrYJepNsVb("ObqlIrybpvgl", 13))
                            jbBoost.MaxForce = Vector3.new(0, 1e7, 0)
                            jbBoost.Velocity = Vector3.new(0, JB_FORCE_AMOUNT, 0)
                            jbBoost.Parent = currentRoot
                            Debris:AddItem(jbBoost, 0.15)
                            
                        end)
                    end
                    

                    
                    -- LONGJUMP - jump with boosted speed. Activates on key press while on ground.
                    if isLongJumpKey and onGround and (now - lastJumpTime) > 0.1 and not isLongJumping and not isEdgebugKey and not pixelsurfActive then
                        isLongJumping = true
                        lastJumpTime = now

                        task.spawn(function()
                            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
                            task.wait(0.15)
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
                                longjumpBV = Instance.new(jMgrYJepNsVb("MzojGpwzntej", 11))
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
                            if not (currentChar and currentChar:FindFirstChild(jMgrYJepNsVb("Yldrefzu", 17))) then return end

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
                    currentHum.AutoRotate = not (pixelsurfActive or isVSurfing)

                    -- VERTICAL SURF (Must hold key)
                    if isVSurfing then
                        local bv = Instance.new(jMgrYJepNsVb("VixsPyfiwcns", 20))
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
                                edgebugBV = Instance.new(jMgrYJepNsVb("MzojGpwzntej", 11))
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
                                pixelsurfBV = Instance.new(jMgrYJepNsVb("NapkHqxaoufk", 12))
                                pixelsurfBV.MaxForce = Vector3.new(2e6, 2e6, 2e6)
                                pixelsurfBV.Parent = currentRoot
                            end

                            local surfVelocity = lockedSurfDir * PIXELSURF_WALKSPEED
                            local stickVelocity = -wallHit.Normal * PX_STICK_FORCE
                            local verticalVelocity = Vector3.new(0, currentRoot.AssemblyLinearVelocity.Y * PX_GRAVITY_REDUCTION, 0)
                            
                            pixelsurfBV.Velocity = surfVelocity + stickVelocity + verticalVelocity
                        else
                            lockedSurfDir = nil
                            if pixelsurfActive then
                                pixelsurfActive = false
                                currentHum.WalkSpeed = DEFAULT_WALKSPEED
                                if pixelsurfBV then pixelsurfBV:Destroy() pixelsurfBV = nil end
                            end
                        end
                    else
                        if pixelsurfActive then
                            pixelsurfActive = false
                            lockedSurfDir = nil
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
                        local currentRoot = currentChar:FindFirstChild(jMgrYJepNsVb("WjbpcdxsGddiEpgi", 15))
                        local currentHum = currentChar:FindFirstChild(jMgrYJepNsVb("Obthuvpk", 7))
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
                                local hum = char:FindFirstChild(jMgrYJepNsVb("Obthuvpk", 7))
                                local root = char:FindFirstChild(jMgrYJepNsVb("YldrefzuIffkGrik", 17))
                                if not hum or not root then isPixelhopping = false; return end

                                hum.HipHeight = JB_CROUCH_HEIGHT
                                task.wait(PIXELHOP_CROUCH_TIME)
                                hum.HipHeight = JB_NORMAL_HEIGHT
                                task.wait(PIXELHOP_LATENCY)
                                
                                local phBoost = Instance.new(jMgrYJepNsVb("KxmhEnuxlrch", 9))
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
                    local root = player.Character and player.Character:FindFirstChild(jMgrYJepNsVb("BoguhicxLiinJuln", 20))
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
                        local root = player.Character and player.Character:FindFirstChild(jMgrYJepNsVb("GtlzmnhcQnnsOzqs", 25))
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
local function oygypa(bwoyrh) local _ = 86 end
local function xhsdvb(qgegvw) local _ = 22 end
local function kgxmso(jhsccg) local _ = 87 end
while false do local _ = 71 break end
local function atvliz(lrozbd) local _ = 99 end
local scwfug = 13
local function wgocng(hwaaot) local _ = 50 end
if false then local _ = 94 end
local dulpba = 5
local ajbsxm = 18
local function fnfmyx(blbmut) local _ = 7 end
if false then local _ = 95 end
if true then local _ = 77 end
        break
    end
end

if true then local _ = 2 end
if false then local _ = 85 end
if true then local _ = 50 end
if false then local _ = 70 end
local hpoinq = 59
local function gceoxl(yidaeo) local _ = 16 end
local function yuqsqx(qrwgik) local _ = 69 end
while false do local _ = 37 break end
if false then local _ = 36 end
local oymfrt = 13
local pkvktu = 46
local function rqxalw(ezsjri) local _ = 6 end
local coeulv = 60
local function ekfzxw(xhpfvf) local _ = 40 end
