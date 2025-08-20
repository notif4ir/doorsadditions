local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRoot = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

local Bloxy_Cola = Instance.new("Tool")
Bloxy_Cola.Grip = CFrame.new(0.03, 0, 0, 0.22, 0, 0.98, 0, 1, 0, -0.98, 0, 0.22)
Bloxy_Cola.GripForward = Vector3.new(-0.98, 0, -0.22)
Bloxy_Cola.GripPos = Vector3.new(0.03, 0, 0)
Bloxy_Cola.GripRight = Vector3.new(0.22, 0, -0.98)
Bloxy_Cola.TextureId = "http://www.roblox.com/asset/?id=10472127"
Bloxy_Cola.Name = "Bloxy Cola"

local Handle = Instance.new("Part")
Handle.BottomSurface = Enum.SurfaceType.Smooth
Handle.BrickColor = BrickColor.new("Mid gray")
Handle.Color = Color3.fromRGB(205, 205, 205)
Handle.Size = Vector3.new(1, 1.2, 1)
Handle.TopSurface = Enum.SurfaceType.Smooth
Handle.Name = "Handle"

local Mesh = Instance.new("SpecialMesh")
Mesh.MeshType = Enum.MeshType.FileMesh
Mesh.MeshId = "http://www.roblox.com/asset/?id=10470609"
Mesh.TextureId = "http://www.roblox.com/asset/?id=10470600"
Mesh.Scale = Vector3.new(1.2, 1.2, 1.2)
Mesh.Parent = Handle

local OpenSound = Instance.new("Sound")
OpenSound.SoundId = "http://www.roblox.com/asset/?id=10721950"
OpenSound.Name = "OpenSound"
OpenSound.Parent = Handle

local DrinkSound = Instance.new("Sound")
DrinkSound.SoundId = "http://www.roblox.com/asset/?id=10722059"
DrinkSound.Name = "DrinkSound"
DrinkSound.Parent = Handle

Handle.Parent = Bloxy_Cola
Bloxy_Cola.Parent = player.Backpack

local used = false
local colaActive = false
local jumpVelocity = Vector3.new(0, 35, 0)

Bloxy_Cola.Activated:Connect(function()
	if used then return end
	used = true
	colaActive = true
	OpenSound:Play()
	task.wait(0.5)
	DrinkSound:Play()
	Handle.Transparency = 1
	task.delay(9999, function()
		colaActive = false
	end)
end)

UserInputService.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.Space and colaActive then
		if humanoid.FloorMaterial ~= Enum.Material.Air then
			humanoidRoot.Velocity = humanoidRoot.Velocity + jumpVelocity
		end
	end
end)
