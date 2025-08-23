local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local RiftLeverGlass = Instance.new("Tool")
RiftLeverGlass.Grip = CFrame.new(0, 0, 0.5, 1, 0, 0, 0, -0, 1, 0, -1, -0)
RiftLeverGlass.GripForward = Vector3.new(0, -1, 0)
RiftLeverGlass.GripPos = Vector3.new(0, 0, 0.5)
RiftLeverGlass.GripUp = Vector3.new(0, -0, -1)
RiftLeverGlass.WorldPivot = CFrame.new(122.8, 0.25, -89.4, 1, 0, 0, 0, 1, 0, 0, 0, 1)
RiftLeverGlass.Name = "RiftLeverGlass"

local Handle = Instance.new("Part")
Handle.BottomSurface = Enum.SurfaceType.Smooth
Handle.BrickColor = BrickColor.new("Persimmon")
Handle.CFrame = CFrame.new(122.8, 0.25, -89.4, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Handle.Color = Color3.fromRGB(255, 58, 58)
Handle.Material = Enum.Material.Neon
Handle.Position = Vector3.new(122.8, 0.25, -89.4)
Handle.Size = Vector3.new(0.6, 0.5, 2)
Handle.TopSurface = Enum.SurfaceType.Smooth
Handle.Name = "Handle"

local Mesh = Instance.new("SpecialMesh")
Mesh.MeshType = Enum.MeshType.FileMesh
Mesh.MeshId = "rbxassetid://8741860150"

local ParticlesIn = Instance.new("Attachment")
ParticlesIn.Name = "ParticlesIn"

local ZoomParticle = Instance.new("ParticleEmitter")
ZoomParticle.Brightness = 1.28
ZoomParticle.Color = ColorSequence.new(Color3.fromRGB(255,0,0))
ZoomParticle.Lifetime = NumberRange.new(.3)
ZoomParticle.LightEmission = 1
ZoomParticle.LockedToPart = true
ZoomParticle.Rate = 14
ZoomParticle.Speed = NumberRange.new(0.01)
ZoomParticle.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 2.69, 1), NumberSequenceKeypoint.new(1, 0.96, 0)})
ZoomParticle.Squash = NumberSequence.new({NumberSequenceKeypoint.new(0, 0, 0.43), NumberSequenceKeypoint.new(1, 0, 0.4)})
ZoomParticle.Texture = "rbxassetid://11868709765"
ZoomParticle.TimeScale = 0.1
ZoomParticle.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.18, 0), NumberSequenceKeypoint.new(0.91, 0), NumberSequenceKeypoint.new(1, 1)})
ZoomParticle.ZOffset = 1
ZoomParticle.Name = "ZoomParticle"

local Triangles = Instance.new("ParticleEmitter")
Triangles.Brightness = 1.28
Triangles.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255,0,0)), ColorSequenceKeypoint.new(0.38, Color3.fromRGB(255,155,155)), ColorSequenceKeypoint.new(0.62, Color3.fromRGB(255,92,92)), ColorSequenceKeypoint.new(1, Color3.fromRGB(91,36,36))})
Triangles.Lifetime = NumberRange.new(.3)
Triangles.LightEmission = 1
Triangles.LockedToPart = true
Triangles.Speed = NumberRange.new(0.01)
Triangles.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.5, 1.5), NumberSequenceKeypoint.new(1, 0.13, 0)})
Triangles.SpreadAngle = Vector2.new(360,360)
Triangles.Squash = NumberSequence.new({NumberSequenceKeypoint.new(0, -0.07, 0.27), NumberSequenceKeypoint.new(1, 0, 0.05)})
Triangles.Texture = "rbxassetid://11869189963"
Triangles.TimeScale = 0.1
Triangles.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.9, 0), NumberSequenceKeypoint.new(1, 1)})
Triangles.VelocitySpread = 360
Triangles.ZOffset = -1
Triangles.Name = "Triangles"

local RainbowShards = Instance.new("ParticleEmitter")
RainbowShards.Brightness = 1.28
RainbowShards.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255,155,155)), ColorSequenceKeypoint.new(0.46, Color3.fromRGB(230,104,106)), ColorSequenceKeypoint.new(1, Color3.fromRGB(36,12,12))})
RainbowShards.Lifetime = NumberRange.new(.5,0.55)
RainbowShards.LightEmission = 1
RainbowShards.LockedToPart = true
RainbowShards.Rate = 2
RainbowShards.Speed = NumberRange.new(0.01)
RainbowShards.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.94, 1.94), NumberSequenceKeypoint.new(1, 0.81, 0)})
RainbowShards.SpreadAngle = Vector2.new(360,360)
RainbowShards.Squash = NumberSequence.new({NumberSequenceKeypoint.new(0, 0, 0.43), NumberSequenceKeypoint.new(1, 0, 0.4)})
RainbowShards.Texture = "rbxassetid://11868718459"
RainbowShards.TimeScale = 0.1
RainbowShards.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.18, 0), NumberSequenceKeypoint.new(0.84, 0), NumberSequenceKeypoint.new(1, 1)})
RainbowShards.VelocitySpread = 360
RainbowShards.ZOffset = -3
RainbowShards.Name = "RainbowShards"

RiftLeverGlass.Parent = player:WaitForChild("Backpack")
Handle.Parent = RiftLeverGlass
Mesh.Parent = Handle
ParticlesIn.Parent = Handle
ZoomParticle.Parent = ParticlesIn
Triangles.Parent = ParticlesIn
RainbowShards.Parent = ParticlesIn

local cooldown = false
local cooldownTime = 60
local showTime = 10

local function createHighlight(target, color)
	local highlight = Instance.new("Highlight")
	highlight.Adornee = target
	highlight.FillColor = color
	highlight.OutlineColor = color
	highlight.FillTransparency = 1
	highlight.OutlineTransparency = 1
	highlight.Parent = target
	return highlight
end

local function tweenHighlight(highlight, fillTransparency, outlineTransparency, time)
	local tween = TweenService:Create(highlight, TweenInfo.new(time, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
		FillTransparency = fillTransparency,
		OutlineTransparency = outlineTransparency
	})
	tween:Play()
	return tween
end

local function getPreLastRoom()
	local rooms = {}
	for _, room in pairs(workspace:WaitForChild("CurrentRooms"):GetChildren()) do
		local num = tonumber(room.Name)
		if num then
			table.insert(rooms, room)
		end
	end
	table.sort(rooms, function(a, b)
		return tonumber(a.Name) < tonumber(b.Name)
	end)
	if #rooms >= 2 then
		return rooms[#rooms - 1]
	end
	return nil
end

local function activateRiftLeverGlass()
	if cooldown then return end
	cooldown = true

	local highlights = {}

	local targetRoom = getPreLastRoom()
	if targetRoom then
		for _, obj in pairs(targetRoom:GetDescendants()) do
			if obj:IsA("Model") or obj:IsA("Part") then
				if obj.Name == "Door" then
					local h = createHighlight(obj, Color3.fromRGB(255,170,0))
					table.insert(highlights, h)
					tweenHighlight(h, 0.5, 0, 1)
				elseif obj.Name == "LeverForGate" then
					local h = createHighlight(obj, Color3.fromRGB(255,255,0))
					table.insert(highlights, h)
					tweenHighlight(h, 0.5, 0, 1)
				end
			end
		end
	end

	local bookshelfs = workspace.CurrentRooms:FindFirstChild("50") and workspace.CurrentRooms["50"]:FindFirstChild("Assets") and workspace.CurrentRooms["50"].Assets:FindFirstChild("Bookshelves1")
	if bookshelfs then
		for _, bookshelf in pairs(bookshelfs:GetChildren()) do
			local book = bookshelf:FindFirstChild("LiveHintBook")
			if book then
				local h = createHighlight(book, Color3.fromRGB(0,255,255))
				table.insert(highlights, h)
				tweenHighlight(h, 0.5, 0, 1)
			end
		end
	end

	task.delay(showTime, function()
		for _, h in ipairs(highlights) do
			if h and h.Parent then
				tweenHighlight(h, 1, 1, 1).Completed:Connect(function()
					h:Destroy()
				end)
			end
		end
	end)

	task.delay(cooldownTime, function()
		cooldown = false
	end)
end

RiftLeverGlass.Activated:Connect(activateRiftLeverGlass)
