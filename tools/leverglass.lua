local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local LeverGlass = Instance.new("Tool")
LeverGlass.Grip = CFrame.new(0, 0, 0.5, 1, 0, 0, 0, -0, 1, 0, -1, -0)
LeverGlass.GripForward = Vector3.new(0, -1, 0)
LeverGlass.GripPos = Vector3.new(0, 0, 0.5)
LeverGlass.GripUp = Vector3.new(0, -0, -1)
LeverGlass.WorldPivot = CFrame.new(124.55, 0.5, -92.6, 1, 0, 0, 0, 1, 0, 0, 0, 1)
LeverGlass.Name = "LeverGlass"

local Handle = Instance.new("Part")
Handle.BottomSurface = Enum.SurfaceType.Smooth
Handle.BrickColor = BrickColor.new("Deep orange")
Handle.CFrame = CFrame.new(124.55, 0.5, -92.6, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Handle.Color = Color3.fromRGB(255, 98, 0)
Handle.Material = Enum.Material.Metal
Handle.Position = Vector3.new(124.55, 0.5, -92.6)
Handle.Size = Vector3.new(0.6, 0.5, 2)
Handle.TopSurface = Enum.SurfaceType.Smooth
Handle.Name = "Handle"

local Mesh = Instance.new("SpecialMesh")
Mesh.MeshType = Enum.MeshType.FileMesh
Mesh.MeshId = "rbxassetid://8741860150"
Mesh.Parent = Handle
Handle.Parent = LeverGlass

LeverGlass.Parent = player:WaitForChild("Backpack")

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

local function activateLeverGlass()
	if cooldown then return end
	cooldown = true

	local highlights = {}
	local targetRoom = getPreLastRoom()
	if targetRoom then
		for _, obj in pairs(targetRoom:GetDescendants()) do
			if obj:IsA("Model") or obj:IsA("Part") then
				if obj.Name == "Door" then
					local h = createHighlight(obj, Color3.fromRGB(255, 170, 0))
					table.insert(highlights, h)
					tweenHighlight(h, 0.5, 0, 1)
				elseif obj.Name == "LeverForGate" then
					local h = createHighlight(obj, Color3.fromRGB(255, 255, 0))
					table.insert(highlights, h)
					tweenHighlight(h, 0.5, 0, 1)
				end
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

LeverGlass.Activated:Connect(activateLeverGlass)
