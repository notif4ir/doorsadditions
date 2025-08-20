local Players = game.Players
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local backpack = player:FindFirstChild("Backpack") or player:WaitForChild("Backpack", 5)

local tool = Instance.new("Tool")
tool.Name = "LaserGun"
tool.TextureId = "rbxassetid://303166615"
tool.RequiresHandle = true
tool.CanBeDropped = true

local handle = Instance.new("Part")
handle.Name = "Handle"
handle.Size = Vector3.new(0.58, 1.34, 2.48)
handle.Anchored = false
handle.CanCollide = false
handle.Parent = tool

local mesh = Instance.new("SpecialMesh")
mesh.MeshType = Enum.MeshType.FileMesh
mesh.MeshId = "rbxassetid://130099641"
mesh.TextureId = "rbxassetid://130093033"
mesh.Parent = handle

tool.Grip = CFrame.new(0, -0.1, 0.75)
tool.GripForward = Vector3.new(0,0,-1)
tool.GripRight = Vector3.new(1,0,0)
tool.GripUp = Vector3.new(0,1,0)

tool.Parent = backpack

local shootingCooldown = false
local deletedPlayers = {} -- Track deleted players by name

local function destroyTarget(target)
    if not target then return end
    local parent = target
    local humanoid = target.Parent:FindFirstChild("Humanoid")
    if humanoid then
        parent = target.Parent
        local plr = Players:GetPlayerFromCharacter(parent)
        deletedPlayers[parent.Name] = true
        parent:Destroy()
        if plr then
            deletedPlayers[plr.Name] = true
            plr:Destroy()
        end
    else
        target:Destroy()
    end
end

local function createBulletEffect(hitPos, hitPart)
    local bullet = Instance.new("Part")
    bullet.Size = Vector3.new(0.2,0.2,0.2)
    bullet.Shape = Enum.PartType.Ball
    bullet.Material = Enum.Material.Neon
    bullet.BrickColor = BrickColor.new("Bright blue")
    bullet.Anchored = true
    bullet.CanCollide = false
    bullet.Position = handle.Position
    bullet.Parent = workspace

    local selectionBox
    if hitPart then
        selectionBox = Instance.new("SelectionBox")
        selectionBox.Adornee = hitPart
        selectionBox.LineThickness = 0.05
        selectionBox.SurfaceTransparency = 0.7
        selectionBox.Color3 = Color3.fromRGB(0, 170, 255)
        selectionBox.Parent = hitPart
    end

    local tweenInfo = TweenInfo.new((hitPos - handle.Position).Magnitude/200, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(bullet, tweenInfo, {Position = hitPos})
    tween:Play()
    tween.Completed:Connect(function()
        bullet:Destroy()
        if selectionBox then
            selectionBox:Destroy()
        end
        destroyTarget(hitPart)
        local destroySound = Instance.new("Sound")
        destroySound.SoundId = "rbxassetid://8561505457"
        destroySound.Parent = handle
        destroySound:Play()
    end)
end

tool.Activated:Connect(function()
    if shootingCooldown then return end
    shootingCooldown = true

    local mouse = player:GetMouse()
    local target = mouse.Target
    if target and target:IsA("BasePart") then
        createBulletEffect(target.Position, target)

        local sound1 = Instance.new("Sound")
        sound1.SoundId = "rbxassetid://8561500387"
        sound1.Parent = handle
        sound1:Play()

        delay(0.5, function()
            local sound2 = Instance.new("Sound")
            sound2.SoundId = "rbxassetid://8561502124"
            sound2.Parent = handle
            sound2:Play()
        end)
    end

    wait(1)
    shootingCooldown = false
end)

RunService.Heartbeat:Connect(function()
    for name,_ in pairs(deletedPlayers) do
        local char = workspace:FindFirstChild(name)
        if char then
            char:Destroy()
        end
        local plr = Players:FindFirstChild(name)
        if plr then
            plr:Destroy()
        end
    end
end)
