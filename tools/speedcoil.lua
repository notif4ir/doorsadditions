local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")
local camera = workspace.CurrentCamera

local SpeedCoil = Instance.new("Tool")
SpeedCoil.CanBeDropped = false
SpeedCoil.Grip = CFrame.new(0, 0, -1, -0.71, -0.71, 0, 0.71, -0.71, 0, 0, 0, 1)
SpeedCoil.GripPos = Vector3.new(0, 0, -1)
SpeedCoil.GripRight = Vector3.new(-0.71, 0.71, 0)
SpeedCoil.GripUp = Vector3.new(-0.71, -0.71, 0)
SpeedCoil.ToolTip = "Speed Up!"
SpeedCoil.TextureId = "http://www.roblox.com/asset/?id=99170415"
SpeedCoil.Name = "SpeedCoil"

local Handle = Instance.new("Part")
Handle.CanCollide = false
Handle.CanTouch = false
Handle.Color = Color3.fromRGB(196, 40, 28)
Handle.Massless = true
Handle.Size = Vector3.new(1.3, 1.3, 2.4)
Handle.Name = "Handle"
Handle.Parent = SpeedCoil

local CoilSound = Instance.new("Sound")
CoilSound.SoundId = "http://www.roblox.com/asset/?id=99173388"
CoilSound.Volume = 1
CoilSound.Name = "CoilSound"
CoilSound.Parent = Handle

local Mesh = Instance.new("SpecialMesh")
Mesh.MeshType = Enum.MeshType.FileMesh
Mesh.MeshId = "http://www.roblox.com/asset/?id=16606212"
Mesh.TextureId = "http://www.roblox.com/asset/?id=99170547"
Mesh.Scale = Vector3.new(0.7, 0.7, 0.7)
Mesh.Parent = Handle

SpeedCoil.Parent = backpack

local humanoid
local defaultSpeed
local boostedSpeed
local defaultFOV = camera.FieldOfView
local boostedFOV = defaultFOV + 20
local equipped = false
local currentFOV = defaultFOV

RunService.RenderStepped:Connect(function(dt)
	if equipped then
		if humanoid then
			humanoid.WalkSpeed = boostedSpeed
		end
		currentFOV = currentFOV + (boostedFOV - currentFOV) * math.min(10 * dt, 1)
		camera.FieldOfView = boostedFOV
		camera.FieldOfView = currentFOV
	else
		if humanoid then
			humanoid.WalkSpeed = defaultSpeed
		end
		currentFOV = currentFOV + (defaultFOV - currentFOV) * math.min(10 * dt, 1)
		camera.FieldOfView = defaultFOV
		camera.FieldOfView = currentFOV
	end
end)

SpeedCoil.Equipped:Connect(function()
	if not humanoid then
		local char = player.Character or player.CharacterAdded:Wait()
		humanoid = char:WaitForChild("Humanoid")
		defaultSpeed = humanoid.WalkSpeed
		boostedSpeed = defaultSpeed * 1.33
	end
	CoilSound:Play()
	equipped = true
end)

SpeedCoil.Unequipped:Connect(function()
	equipped = false
end)
