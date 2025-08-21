task.wait(10)

if not game.Workspace:FindFirstChild("CurrentRooms") then
    warn("Not in a Doors game, returning")
    return
end

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
        }
    },
    ["but bad"] = {Texture = 11027732448, Color = nil},
    ["Screaming"] = {Texture = 11709617815, Color = nil},
    ["Minecraft"] = {Texture = 10896793201, Color = nil},
    ["Plushie"] = {Texture = 12978732658, Color = nil},
    ["Tuff"] = {Texture = 87088896638971, Color = nil},
    ["Stage 2"] = {Texture = 11232581784, Color = nil},
}

local function applyRushSkin(model)
    local currentSkin = GetCurrentSkin("Rush")
    if not currentSkin or not rushSkins[currentSkin] then return end
    local skinData = rushSkins[currentSkin]
    local attachment = model:FindFirstChild("RushNew") and model.RushNew:FindFirstChild("Attachment")
    if attachment then
        for _, particle in ipairs(attachment:GetChildren()) do
            if particle:IsA("ParticleEmitter") then
                particle.Texture = "rbxassetid://" .. skinData.Texture
                if skinData.Color then
                    if typeof(skinData.Color) == "ColorSequence" then
                        particle.Color = skinData.Color
                    else
                        particle.Color = ColorSequence.new(skinData.Color)
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






