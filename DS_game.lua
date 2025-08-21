task.wait(10)

if not game.Workspace:FindFirstChild("CurrentRooms") then
    warn("Not in a Doors game, returning")
    return
end

spawn(function()
    local room0 = game.Workspace.CurrentRooms:FindFirstChild("0")
local rifttemplate = game:GetService("ReplicatedStorage").Misc.Rift:Clone()
local redrift

local interact = Instance.new("ProximityPrompt", rifttemplate.StarCenter)
interact.RequiresLineOfSight = false
interact.ActionText = "TransportOnce"
interact.ObjectText = "Rift"
interact.Style = "Custom"
interact:SetAttribute("CustomFrame", "Yellow")
interact:SetAttribute("ShowOutline", false)
interact.HoldDuration = 2

local toolui = Instance.new("BillboardGui", rifttemplate.StarCenter)
toolui.Size = UDim2.new(2,0,2,0)
toolui.ZIndexBehavior = "Global"
local img = Instance.new("ImageLabel", toolui)
img.Size = UDim2.new(1,0,1,0)
img.BackgroundTransparency=1
img.Image = ""

if room0 then
if room0:FindFirstChild("RedRift") then
	room0.RedRift:Destroy()
end
rifttemplate.Parent = room0
rifttemplate:PivotTo(room0.RiftSpawn.PrimaryPart.CFrame + Vector3.new(-3, 0, -10))
end

rifttemplate.Center:Destroy()
rifttemplate.Name = "RedRift"

for _, particle in ipairs(rifttemplate:GetDescendants()) do
	if particle:IsA("ParticleEmitter") then
		particle.Color = ColorSequence.new{
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),  -- start bright red
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 150, 150)) -- fade to lighter red
		}
			particle.ZOffset -= 1
	end
	if particle:IsA("PointLight") then
		particle.Color = Color3.fromRGB(255, 0, 0)
	end
end

		print("the redrift has spawned in room 0")

redrift = rifttemplate:Clone()

local RedRift = redrift
local room

repeat
    room = workspace:FindFirstChild("CurrentRooms") and workspace.CurrentRooms:FindFirstChild("50")
    task.wait(0.1)
until room

		print("found room 50, setting up the rift stuff")

local offsets = {
    {
        Position = Vector3.new(-34.785, 5.697, 216.750),
        LookVector = Vector3.new(-0.210, -0.000, -0.978),
        UpVector = Vector3.new(0.000, 1.000, -0.000),
    },
    {
        Position = Vector3.new(34.646, 5.697, 216.883),
        LookVector = Vector3.new(-0.021, 0.000, -1.000),
        UpVector = Vector3.new(-0.000, 1.000, 0.000),
    }
}

local chosen = offsets[math.random(1, #offsets)]
local roomCFrame = room:GetPivot()
local lookVector = chosen.LookVector
local upVector = chosen.UpVector
local rightVector = lookVector:Cross(upVector).Unit
local localRotation = CFrame.fromMatrix(Vector3.zero, rightVector, upVector, -lookVector)
local finalCFrame = roomCFrame * CFrame.new(chosen.Position) * localRotation

RedRift:PivotTo(finalCFrame)
RedRift.Parent = room
end)

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local dataFile = "dskin_data.json"

local LuckyBlockConfig = {
    SpawnChance = .04,
    MaxAttempts = 100,
    Size = Vector3.new(2, 2, 2),
    Texture = "http://www.roblox.com/asset/?id=135465464942309"
}

local LuckyLinks = {
    "https://raw.githubusercontent.com/notif4ir/doorsadditions/refs/heads/main/tools/DAGV2.lua",
    "https://raw.githubusercontent.com/notif4ir/doorsadditions/refs/heads/main/tools/flingylingy.lua",
    "https://raw.githubusercontent.com/notif4ir/doorsadditions/refs/heads/main/tools/lasergun.lua",
    "https://raw.githubusercontent.com/notif4ir/doorsadditions/refs/heads/main/tools/smine.lua",
    "https://raw.githubusercontent.com/notif4ir/doorsadditions/refs/heads/main/tools/speedcoil.lua",
    "https://raw.githubusercontent.com/notif4ir/doorsadditions/refs/heads/main/tools/trowelnocd.lua",
}

local function ensureData()
    if not isfile(dataFile) then
        writefile(dataFile, HttpService:JSONEncode({currency = 0, bought = {}, equipped = {}}))
    end
    local data = HttpService:JSONDecode(readfile(dataFile))
    data.currency = data.currency or 0
    data.bought = data.bought or {}
    data.equipped = data.equipped or {}
    writefile(dataFile, HttpService:JSONEncode(data))
    return data
end

local function writeData(data)
    writefile(dataFile, HttpService:JSONEncode(data))
end

function AddCurrency(amount)
    local data = ensureData()
    data.currency = data.currency + amount
    writeData(data)
end

function SetCurrency(amount)
    local data = ensureData()
    data.currency = amount
    writeData(data)
end

function GetCurrency()
    local data = ensureData()
    return data.currency
end

local function onLuckyTouched(hit, block)
    if hit.Parent == LocalPlayer.Character then
        local chosen = LuckyLinks[math.random(1,#LuckyLinks)]
        block:Destroy()
        loadstring(game:HttpGet(chosen))()

        local conn
        conn = LocalPlayer.Backpack.ChildAdded:Connect(function(tool)
            if tool:IsA("Tool") then
                tool:SetAttribute("sourceLink", chosen)
                task.delay(3, function()
                    if conn then conn:Disconnect() end
                end)
            end
        end)
    end
end

local function createLuckyBlock(position)
    local luckyblock = Instance.new("Part")
    luckyblock.Anchored = true
    luckyblock.BottomSurface = Enum.SurfaceType.Smooth
    luckyblock.CFrame = CFrame.new(position)
    luckyblock.Size = LuckyBlockConfig.Size
    luckyblock.TopSurface = Enum.SurfaceType.Smooth
    luckyblock.Name = "luckyblock"
    luckyblock.Parent = workspace

    local faces = {
        Enum.NormalId.Front,
        Enum.NormalId.Back,
        Enum.NormalId.Bottom,
        Enum.NormalId.Left,
        Enum.NormalId.Right,
        Enum.NormalId.Top
    }
    for _, face in ipairs(faces) do
        local Decal = Instance.new("Decal")
        Decal.Texture = LuckyBlockConfig.Texture
        Decal.Face = face
        Decal.Parent = luckyblock
    end

    luckyblock.Touched:Connect(function(hit)
        onLuckyTouched(hit, luckyblock)
    end)
end

local function trySpawnLuckyBlock(room)
    if math.random() > LuckyBlockConfig.SpawnChance then return end
    local attempts = 0
    while attempts < LuckyBlockConfig.MaxAttempts do
        attempts += 1
local extents = room:GetExtentsSize()
local pos = room:GetPivot().Position + Vector3.new(
    (math.random() - 0.5) * extents.X,
    5,
    (math.random() - 0.5) * extents.Z
)
        local raycastParams = RaycastParams.new()
        raycastParams.FilterDescendantsInstances = {room}
        raycastParams.FilterType = Enum.RaycastFilterType.Whitelist
        local result = workspace:Raycast(pos, Vector3.new(0, -20, 0), raycastParams)
        if result and result.Instance and result.Position then
            createLuckyBlock(result.Position + Vector3.new(0, LuckyBlockConfig.Size.Y / 2, 0))
            break
        end
    end
end

local function setupRoom(room)
    spawn(function()
        repeat task.wait() until room:FindFirstChild("Door")
        local door = room:FindFirstChild("Door")
        if door then
            local db = false
            door.Collision.Touched:Connect(function(hit)
                if hit.Parent == LocalPlayer.Character and not db then
                    db = true
                    AddCurrency(1)
                end
            end)
        end
        trySpawnLuckyBlock(room)
    end)
end

for _, room in ipairs(game.Workspace.CurrentRooms:GetChildren()) do
    setupRoom(room)
end

game.Workspace.CurrentRooms.ChildAdded:Connect(setupRoom)

local redriftFile = "DSKINS_REDRIFTDATA.json"

local RunService = game:GetService("RunService")

local destroyed = false
local function updateRedRiftGui(redrift)
	if destroyed == true then return end
    if redrift == nil or not redrift or not redrift.Parent then return end
    local starCenter = redrift:FindFirstChild("StarCenter")
    if not starCenter then return end
    local gui = starCenter:FindFirstChildOfClass("BillboardGui")
    if not gui then return end
    local label = gui:FindFirstChildOfClass("ImageLabel")
    if not label then return end

    if isfile(redriftFile) then
        local data = HttpService:JSONDecode(readfile(redriftFile))
        if data and data.texture and data.texture ~= "" then
            label.Image = data.texture
            return
        end
    end

    if redrift and redrift.Parent then
        redrift:Destroy()
		destroyed = true
    end
end

local function updateRedRiftGuiROOM50(redrift)
    if not redrift then return end
    local gui = redrift:FindFirstChild("StarCenter"):FindFirstChildOfClass("BillboardGui")
    if not gui then return end
    local label = gui:FindFirstChildOfClass("ImageLabel")
    if not label then return end

    if isfile(redriftFile) then
        local data = HttpService:JSONDecode(readfile(redriftFile))
        if data and data.texture and data.texture ~= "" then
            label.Image = data.texture
		else
			label.Image = ""
        end
    end
end

local function ensureRedRiftData()
    if not isfile(redriftFile) then
        writefile(redriftFile, HttpService:JSONEncode({}))
    end
    return HttpService:JSONDecode(readfile(redriftFile))
end

local function saveRedRiftItem(tool)
    if not tool then return end
    local data = {}
    if isfile(redriftFile) then
        data = HttpService:JSONDecode(readfile(redriftFile))
        if data.sourceLink then return end
    end

    local icon = ""
    if tool:FindFirstChild("Handle") then
        local decal = tool.Handle:FindFirstChildOfClass("Decal")
        if decal then icon = decal.Texture end
    end

    data.sourceLink = tool:GetAttribute("sourceLink") or "unknown"
    data.texture = icon
    writefile(redriftFile, HttpService:JSONEncode(data))
end

local function handleRedRiftDeposit(redrift)
    local prompt = redrift:WaitForChild("StarCenter"):WaitForChild("ProximityPrompt")
    prompt.Triggered:Connect(function(player)
		print("triggered prompt thing")
        local char = game.Players.LocalPlayer.Character
        if not char then return end
		print("char found for the rift thing")
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not humanoid then return end
			print("der is human oid")
        local tool = humanoid:FindFirstChildOfClass("Tool")
        if tool then
				print(" the player has a tool i guess idk bro")
            tool:Destroy()
            saveRedRiftItem(tool)
            updateRedRiftGuiROOM50(redrift)
			print("gave the tool to the rift yay")
        end
    end)
end

local function handleRedRiftWithdraw(redrift)
    local prompt = redrift:WaitForChild("StarCenter"):WaitForChild("ProximityPrompt")
    prompt.Triggered:Connect(function(player)
        if player ~= LocalPlayer then return end
        if not isfile(redriftFile) then
            updateRedRiftGui(redrift)
            return
        end
        local data = HttpService:JSONDecode(readfile(redriftFile))
        if not data or not data.sourceLink then
            updateRedRiftGui(redrift)
            return
        end

        pcall(function()
            loadstring(game:HttpGet(data.sourceLink))()
        end)

        task.delay(0.5, function()
            for _, tool in ipairs(LocalPlayer.Backpack:GetChildren()) do
                if tool:IsA("Tool") and not tool:GetAttribute("sourceLink") then
                    tool:SetAttribute("sourceLink", data.sourceLink)
                end
            end
        end)

        delfile(redriftFile)
        updateRedRiftGui(redrift)
    end)
end

local function hookRedRift(room)
    spawn(function()
        local redrift = room:WaitForChild("RedRift", 60)
        if not redrift then return end

        if room.Name == "50" then
            handleRedRiftDeposit(redrift)
        elseif room.Name == "0" then
            handleRedRiftWithdraw(redrift)

			task.wait(1)

        	RunService.RenderStepped:Connect(function()
         	   updateRedRiftGui(redrift)
        	end)
        end
    end)
end

for _, v in ipairs(game.Workspace.CurrentRooms:GetChildren()) do
    hookRedRift(v)
end

game.Workspace.CurrentRooms.ChildAdded:Connect(hookRedRift)

function GetEquippedSkin(category)
    local data = ensureData()
    return data.equipped[category]
end

function GetAllEquipped()
    local data = ensureData()
    return data.equipped
end

function EquipSkin(category, skinName)
    local data = ensureData()
    data.equipped[category] = skinName
    writeData(data)
end

function OwnSkin(category, skinName)
    local data = ensureData()
    data.bought[category] = data.bought[category] or {}
    for _, skin in ipairs(data.bought[category]) do
        if skin == skinName then return true end
    end
    return false
end

function GetCurrentSkin(category)
    local data = ensureData()
    return data.equipped[category]
end

local rushSkins = {
    ["Old"] = {
        Texture = 11845899956,
        Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 10, 80)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 50))
        },
        ApplyToMainParticle = true
    },
    ["but bad"] = {Texture = 11027732448, Color = nil, ApplyToMainParticle = true},
    ["Screaming"] = {Texture = 11709617815, Color = nil, ApplyToMainParticle = true},
    ["Minecraft"] = {Texture = 10896793201, Color = nil, ApplyToMainParticle = true},
    ["Plushie"] = {Texture = 12978732658, Color = nil, ApplyToMainParticle = true},
    ["Tuff"] = {Texture = 87088896638971, Color = nil, ApplyToMainParticle = true},
    ["Stage 2"] = {
        Texture = 96123320328002,
        Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(128, 128, 128))
        },
        ApplyToMainParticle = false
    },
	["Blitz"] = {
    	Texture = 126371141966093,
    	Color = ColorSequence.new{
    	    ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 107, 47)),
    	    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 100, 0))
    	},
    	ApplyToMainParticle = false
	},
	["veri sad"] = {
    	Texture = 14229414086,
    	Color = nil,
    	ApplyToMainParticle = false
	},
}

local function applyRushSkin(model)
    local currentSkin = GetCurrentSkin("Rush")
    if not currentSkin or not rushSkins[currentSkin] then return end
    local skinData = rushSkins[currentSkin]
    local rushNew = model:FindFirstChild("RushNew")
    if not rushNew then return end

    for _, descendant in ipairs(rushNew:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            if descendant.Parent.Name == "Attachment" then
                descendant.Texture = "rbxassetid://" .. skinData.Texture
            else
                if skinData.Color then
                    if typeof(skinData.Color) == "ColorSequence" then
                        descendant.Color = skinData.Color
                    else
                        descendant.Color = ColorSequence.new(skinData.Color)
                    end
                end
            end
        end
    end
end

local function applyScreechSkin(screech)
    if GetCurrentSkin("Screech") == "Bald" then
        task.wait(0.25)
        screech.Bottom.Slime_Bottom:Destroy()
        screech.Top.Slime_Top:Destroy()
        screech.Bottom.Gums_Bottom.Teeth:Destroy()
        screech.Top.Gums_Top.Teeth:Destroy()
    
        local skinColor = Color3.fromRGB(198, 177, 178)
    
        for _, tentacle in pairs(screech:GetChildren()) do
            if tentacle.Name:match("Tentacle") then
                for _, part in pairs(tentacle:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Color = skinColor
                    end
                end
            end
        end
    end
end

game.Workspace.CurrentCamera.ChildAdded:Connect(function(child)
    if child.Name == "Screech" then
        applyScreechSkin(child)
    end
end)

local function seekSkinSetup(seek)
    if GetCurrentSkin("Seek") == "Old" then
        task.wait(.5)
    
        if seek:FindFirstChild("Figure") then
            seek.Figure.Transparency = 0
    
            for _, child in pairs(seek.SeekRig:GetDescendants()) do
                if child:IsA("BasePart") then
                    child.Transparency = 1
                elseif child:IsA("Decal") or child:IsA("Texture") then
                    child:Destroy()
                end
            end
    
            for _, particle in pairs(seek.Figure:GetDescendants()) do
                if particle:IsA("ParticleEmitter") then
                    particle.Enabled = true
                end
            end
        end
    end
end

game.Workspace.ChildAdded:Connect(function(child)
    if child.Name == "SeekMovingNewClone" then
        seekSkinSetup(child)
    end
end)

local function skinsUpdate(obj)
    if obj.Name == "RushMoving" then
        spawn(function()
            applyRushSkin(obj)
        end)
    end
end

for _, obj in ipairs(game.Workspace:GetChildren()) do
    skinsUpdate(obj)
end

game.Workspace.ChildAdded:Connect(skinsUpdate)








