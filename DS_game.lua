if not game.Workspace:FindFirstChild("CurrentRooms") then
    warn("Not in a Doors game, returning")
    return
end

local HttpService = game:GetService("HttpService")
local dataFile = "dskin_data.json"

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

local function AddCurrency(amount)
    local data = ensureData()
    data.currency = data.currency + amount
    writeData(data)
end

local function SetCurrency(amount)
    local data = ensureData()
    data.currency = amount
    writeData(data)
end

local function GetCurrency()
    local data = ensureData()
    return data.currency
end

local function setupRoom(room)
    spawn(function()
        local door = room:FindFirstChild("Door")
        if door then
            local db = false
            door.Collision.Touched:Connect(function(hit)
                if hit.Parent == game.Players.LocalPlayer.Character and not db then
                    db = true
                    AddCurrency(1)
                end
            end)
        end
    end)
end

for _, room in ipairs(game.Workspace.CurrentRooms:GetChildren()) do
    setupRoom(room)
end

game.Workspace.CurrentRooms.ChildAdded:Connect(setupRoom)

-- Skin functions
local function GetEquippedSkin(category)
    local data = ensureData()
    return data.equipped[category]
end

local function GetAllEquipped()
    local data = ensureData()
    return data.equipped
end

local function EquipSkin(category, skinName)
    local data = ensureData()
    data.equipped[category] = skinName
    writeData(data)
end

local function OwnSkin(category, skinName)
    local data = ensureData()
    data.bought[category] = data.bought[category] or {}
    for _, skin in ipairs(data.bought[category]) do
        if skin == skinName then return true end
    end
    return false
end

local function GetCurrentSkin(category)
    local data = ensureData()
    return data.equipped[category]
end

local rushSkins = {
    ["Old"] = 11845899956,
    ["but bad"] = 11027732448,
    ["Screaming"] = 11709617815,
    ["Minecraft"] = 10896793201,
    ["Plushie"] = 12978732658,
    ["Tuff"] = 87088896638971,
    ["Stage 2"] = 11232581784,
}

local function applyRushSkin(model)
    local currentSkin = GetCurrentSkin("Rush")
    if not currentSkin or not rushSkins[currentSkin] then return end
    local attachment = model:FindFirstChild("RushNew") and model.RushNew:FindFirstChild("Attachment")
    if attachment and attachment:FindFirstChild("ParticleEmitter") then
        attachment.ParticleEmitter.Texture = "rbxassetid://" .. rushSkins[currentSkin]
    end
end

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