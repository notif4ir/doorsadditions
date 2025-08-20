local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

local wallHeight = 4
local brickSpeed = 0.04
local wallWidth = 12

local ClassicTrowel = Instance.new("Tool")
ClassicTrowel.Grip = CFrame.new(0, -1.3, 0)
ClassicTrowel.GripPos = Vector3.new(0, -1.3, 0)
ClassicTrowel.TextureId = "rbxasset://Textures/Wall.png"
ClassicTrowel.WorldPivot = CFrame.new(-13.81, 0.5, -11.12)
ClassicTrowel.Name = "ClassicTrowel"

local Handle = Instance.new("Part")
Handle.FormFactor = Enum.FormFactor.Plate
Handle.BrickColor = BrickColor.new("Brick yellow")
Handle.CFrame = CFrame.new(-13.81, 0.5, -11.12)
Handle.Color = Color3.fromRGB(215, 197, 154)
Handle.Size = Vector3.new(1, 4.4, 1)
Handle.Name = "Handle"

local Mesh = Instance.new("SpecialMesh")
Mesh.MeshType = Enum.MeshType.FileMesh
Mesh.MeshId = "rbxasset://fonts/trowel.mesh"
Mesh.TextureId = "rbxasset://textures/TrowelTexture.png"

local BuildSound = Instance.new("Sound")
BuildSound.SoundId = "rbxasset://sounds//bass.wav"
BuildSound.Volume = 1
BuildSound.Name = "BuildSound"

local MouseLoc = Instance.new("RemoteFunction")
MouseLoc.Name = "MouseLoc"

Handle.Parent = ClassicTrowel
Mesh.Parent = Handle
BuildSound.Parent = Handle
MouseLoc.Parent = ClassicTrowel

ClassicTrowel.Parent = player.Backpack

local Tool = ClassicTrowel
Tool.Enabled = true

local function placeBrick(cf, pos, color)
	local brick = Instance.new("Part")
	brick.Size = Vector3.new(4, 1, 2)
	brick.BrickColor = color
	brick.CFrame = cf * CFrame.new(pos + brick.Size / 2)
	brick.Anchored = false
	brick.Parent = workspace
	return brick, pos + brick.Size
end

local function buildWall(cf)
	local color = BrickColor.Random()
	local bricks = {}
	local y = 0
	while y < wallHeight do
		local p
		local x = -wallWidth/2
		while x < wallWidth/2 do
			local brick
			brick, p = placeBrick(cf, Vector3.new(x, y, 0), color)
			x = p.x
			table.insert(bricks, brick)
			wait(brickSpeed)
		end
		y = p.y
	end
	return bricks
end

local function snap(v)
	if math.abs(v.x) > math.abs(v.z) then
		return v.x > 0 and Vector3.new(1,0,0) or Vector3.new(-1,0,0)
	else
		return v.z > 0 and Vector3.new(0,0,1) or Vector3.new(0,0,-1)
	end
end

Tool.Activated:Connect(function()
	if not Tool.Enabled then return end
	Tool.Enabled = false

	local character = Tool.Parent
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then Tool.Enabled = true return end

	local mousePos = mouse.Hit.Position
	local lookAt = snap((mousePos - character.Head.Position).unit)
	local cf = CFrame.new(mousePos, mousePos + lookAt)

	Tool.Handle.BuildSound:Play()
	spawn(function()
	buildWall(cf)
	end)

	wait(0)
	Tool.Enabled = true
end)
