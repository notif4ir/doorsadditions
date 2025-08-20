local player = game.Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")

local dostuff = true
local cd = 0

local tool = Instance.new("Tool")
tool.Name = "Subspace Tripmine"
tool.RequiresHandle = true
tool.CanBeDropped = true
tool.TextureId = "rbxassetid://9289962773"

local handle = Instance.new("Part")
handle.Name = "Handle"
handle.Size = Vector3.new(2,2,2)
handle.Anchored = false
handle.CanCollide = false
handle.Parent = tool

local mesh = Instance.new("SpecialMesh")
mesh.MeshType = Enum.MeshType.FileMesh
mesh.MeshId = "rbxassetid://11954776"
mesh.TextureId = "rbxassetid://11954766"
mesh.Parent = handle

tool.Grip = CFrame.new(-0.5,0,0) * CFrame.Angles(0,math.rad(-90),0)
tool.Parent = backpack

local debounce = false

local function explodeTripmine(tripmine)
    tripmine.Anchored = true
    tripmine.Transparency = 1

    local explosionSound = Instance.new("Sound")
    explosionSound.SoundId = "rbxassetid://17707206608"
    explosionSound.Volume = 1
    explosionSound.PlaybackSpeed = 1
    explosionSound.RollOffMode = Enum.RollOffMode.Linear
    explosionSound.MaxDistance = 100
    explosionSound.Parent = tripmine
    explosionSound:Play()

    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and part ~= tripmine then
            if (part.Position - tripmine.Position).Magnitude <= 35 then
                part.Anchored = false
                local bodyVel = Instance.new("BodyVelocity")
                local randomDir = Vector3.new(math.random()-0.5, math.random()-0.5, math.random()-0.5).Unit
                bodyVel.Velocity = randomDir * (150 + math.random() * 100)
                bodyVel.MaxForce = Vector3.new(1e5,1e5,1e5)
                bodyVel.Parent = part
                part.AssemblyLinearVelocity = bodyVel.Velocity

                if dostuff then
                    part.Color = Color3.fromRGB(255,105,180)
                    part.Material = Enum.Material.Neon
                    if part:IsA("MeshPart") then
                        part.TextureID = ""
                    end    
                    local sparkles = Instance.new("Sparkles", part)
                    sparkles.Color = Color3.fromRGB(255,105,180)
                end
                game.Debris:AddItem(bodyVel, 0.3)
            end
        end
    end

    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = plr.Character.HumanoidRootPart
            if (hrp.Position - tripmine.Position).Magnitude <= 35 then
                local humanoid = plr.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.Health = 0
                end
                local bodyVel = Instance.new("BodyVelocity")
                local randomDir = Vector3.new(math.random()-0.5, math.random()-0.5, math.random()-0.5).Unit
                bodyVel.Velocity = randomDir * (150 + math.random() * 100)
                bodyVel.MaxForce = Vector3.new(1e5,1e5,1e5)
                bodyVel.Parent = hrp
                hrp.AssemblyLinearVelocity = bodyVel.Velocity
                game.Debris:AddItem(bodyVel, 0.3)
            end
        end
    end

    delay(10, function()
        tripmine:Destroy()
    end)
end

tool.Activated:Connect(function()
    if debounce then return end
    debounce = true

    handle.Transparency = 1
    tool.Enabled = false

    local folder = workspace:FindFirstChild("f4temp")
    if not folder then
        folder = Instance.new("Folder")
        folder.Name = "f4temp"
        folder.Parent = workspace
    end

    local tripmineClone = handle:Clone()
    tripmineClone.Transparency = 0
    tripmineClone.Anchored = false
    tripmineClone.CanCollide = true
    tripmineClone.Position = handle.Position
    tripmineClone.Parent = folder

    local light = Instance.new("PointLight")
    light.Color = Color3.fromRGB(255,0,255)
    light.Brightness = 2
    light.Range = 35
    light.Parent = tripmineClone

    local loopSound = Instance.new("Sound")
    loopSound.SoundId = "rbxassetid://108345344203629"
    loopSound.Looped = true
    loopSound.Volume = 1
    loopSound.RollOffMode = Enum.RollOffMode.Linear
    loopSound.MaxDistance = 100
    loopSound.Parent = tripmineClone
    loopSound:Play()

    local flicker = true
    spawn(function()
        local brightness = 2
        while flicker do
            light.Brightness = brightness + math.random()*3
            wait(0.05)
            brightness = math.min(brightness + 0.5, 20)
        end
    end)

    delay(5, function()
        flicker = false
        loopSound:Stop()
        explodeTripmine(tripmineClone)
    end)

    wait(cd)
    tool.Enabled = true
    handle.Transparency = 0
    debounce = false
end)
