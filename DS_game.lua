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
		if room0:FindFirstChild("RiftSpawn") then
			rifttemplate:PivotTo(room0.RiftSpawn.PrimaryPart.CFrame + Vector3.new(-3, 0, -10))
		elseif game.PlaceId == 6839171747 then
			local riftpos = Instance.new("Part", game.Workspace)
			local path = workspace.CurrentRooms["0"].Assets.GateSetup.GardenGate.Collision
			riftpos.Anchored = true
			riftpos.Position = path.Position+path.CFrame.RightVector*10+path.CFrame.LookVector*8
			riftpos.Transparency=1
			rifttemplate:PivotTo(riftpos.CFrame)
			riftpos:Destroy()
		end	
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
	"https://raw.githubusercontent.com/notif4ir/doorsadditions/refs/heads/main/tools/bloxycola.lua",
	"https://raw.githubusercontent.com/notif4ir/doorsadditions/refs/heads/main/tools/leverglass.lua",
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

local function createLuckyBlock(position)
	local luckyblock = Instance.new("Part")
	luckyblock.Anchored = false
	luckyblock.BottomSurface = Enum.SurfaceType.Smooth
	luckyblock.TopSurface = Enum.SurfaceType.Smooth
	luckyblock.CFrame = CFrame.new(position)
	luckyblock.Size = LuckyBlockConfig.Size
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
		local decal = Instance.new("Decal")
		decal.Texture = LuckyBlockConfig.Texture
		decal.Face = face
		decal.Parent = luckyblock
	end

	local touchedDebounce = false

	luckyblock.Touched:Connect(function(hit)
		if touchedDebounce then return end
		if hit.Parent ~= LocalPlayer.Character then return end

		touchedDebounce = true
		local chosen = LuckyLinks[math.random(1,#LuckyLinks)]
		luckyblock:Destroy()
		loadstring(game:HttpGet(chosen))()

		local db = false
		local t = os.time()
		local conn
		conn = LocalPlayer.Backpack.ChildAdded:Connect(function(tool)
			if os.time() - t >= 3 then
				conn:Disconnect()
				return
			end

			if tool:IsA("Tool") and not db then
				tool:SetAttribute("sourceLink", chosen)
				db = true
				conn:Disconnect()
			end
		end)
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
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

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
		if data and data.texture then
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
		if data and data.texture then
			label.Image = data.texture
		else
			label.Image = ""
		end
	else
		label.Image = ""
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
	end

	data.sourceLink = tool:GetAttribute("sourceLink") or "unknown"
	if tool.TextureId and tool.TextureId ~= "" then
		data.texture = tool.TextureId
	else
		data.texture = "rbxassetid://10653365009"
	end	
	writefile(redriftFile, HttpService:JSONEncode(data))
end

local function handleRedRiftDeposit(redrift)
	local prompt = redrift:WaitForChild("StarCenter"):WaitForChild("ProximityPrompt")
	prompt.Triggered:Connect(function(player)
		if not LocalPlayer.Character then return end
		local char = LocalPlayer.Character
		local humanoid = char:FindFirstChildOfClass("Humanoid")
		if not humanoid then return end

		if isfile(redriftFile) then
			local data = HttpService:JSONDecode(readfile(redriftFile))
			if data and data.sourceLink then
				local conn
				local t = os.time()
				conn = LocalPlayer.Backpack.ChildAdded:Connect(function(tool)
					if os.time() - t >= 3 then
						conn:Disconnect()
						return
					end
					if tool:IsA("Tool") then
						tool:SetAttribute("sourceLink", data.sourceLink)
						delfile(redriftFile)
						updateRedRiftGuiROOM50(redrift)
						conn:Disconnect()
					end
				end)
				pcall(function()
					loadstring(game:HttpGet(data.sourceLink))()
				end)
				return
			end
		end

		local tool = char:FindFirstChildOfClass("Tool")
		if tool then
			saveRedRiftItem(tool)
			tool:Destroy()
			updateRedRiftGuiROOM50(redrift)
		end
	end)
end

local function handleRedRiftWithdraw(redrift)
	local prompt = redrift:WaitForChild("StarCenter"):WaitForChild("ProximityPrompt")
	prompt.Triggered:Connect(function(player)
		if not isfile(redriftFile) then
			updateRedRiftGui(redrift)
			return
		end
		local data = HttpService:JSONDecode(readfile(redriftFile))
		if not data or not data.sourceLink then
			updateRedRiftGui(redrift)
			return
		end
		
		if data.sourceLink == "https://raw.githubusercontent.com/notif4ir/doorsadditions/refs/heads/main/tools/leverglass.lua" then
			data.sourceLink = "https://raw.githubusercontent.com/notif4ir/doorsadditions/refs/heads/main/tools/other/riftleverglass.lua"
		end

		local db = false
		local t = os.time()
		local conn
		conn = LocalPlayer.Backpack.ChildAdded:Connect(function(tool)
			if os.time() - t >= 3 then
				conn:Disconnect()
				return
			end

			if tool:IsA("Tool") and not db then
				tool:SetAttribute("sourceLink", data.sourceLink)
				db = true
				conn:Disconnect()

				delfile(redriftFile)
				updateRedRiftGui(redrift)
			end
		end)

		pcall(function()
			loadstring(game:HttpGet(data.sourceLink))()
		end)
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

local function rushSkin(entity)
	task.wait(0.1)
	local skin = GetCurrentSkin("Rush")
	if not skin then return end
	local container = entity:FindFirstChild("RushNew")
	if not container then return end

	if skin == "Old" then
		for _, descendant in ipairs(container:GetDescendants()) do
			if descendant:IsA("ParticleEmitter") and descendant.Parent.Name == "Attachment" then
				if descendant.Name == "ParticleEmitter" then
					descendant.Texture = "rbxassetid://11845899956"
				else
					descendant.Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 10, 80)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 50))
					}
				end
			end
		end
	elseif skin == "but bad" then
		for _, descendant in ipairs(container:GetDescendants()) do
			if descendant:IsA("ParticleEmitter") and descendant.Name == "ParticleEmitter" then
				descendant.Texture = "rbxassetid://11027732448"
			end
		end
	elseif skin == "Screaming" then
		for _, descendant in ipairs(container:GetDescendants()) do
			if descendant:IsA("ParticleEmitter") and descendant.Name == "ParticleEmitter" then
				descendant.Texture = "rbxassetid://11709617815"
			end
		end
	elseif skin == "Minecraft" then
		for _, descendant in ipairs(container:GetDescendants()) do
			if descendant:IsA("ParticleEmitter") and descendant.Name == "ParticleEmitter" then
				descendant.Texture = "rbxassetid://10896793201"
			end
		end
	elseif skin == "Plushie" then
		for _, descendant in ipairs(container:GetDescendants()) do
			if descendant:IsA("ParticleEmitter") and descendant.Name == "ParticleEmitter" then
				descendant.Texture = "rbxassetid://12978732658"
			end
		end
	elseif skin == "Tuff" then
		for _, descendant in ipairs(container:GetDescendants()) do
			if descendant:IsA("ParticleEmitter") then
				if descendant.Name == "ParticleEmitter" then
					descendant.Texture = "rbxassetid://87088896638971"
				end
				if descendant.Name == "BlackTrail" then
					descendant.Texture = "rbxassetid://124421145883538"
					descendant.Rate = 100
					descendant.Lifetime = NumberRange.new(1)
					descendant.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
				end
			end
			if descendant:IsA("Sound") then
				descendant.SoundId = "rbxassetid://125495161781334"
				descendant.PlaybackSpeed*=4
			end
		end
	elseif skin == "Stage 2" then
		for _, descendant in ipairs(container:GetDescendants()) do
			if descendant:IsA("ParticleEmitter") and descendant.Parent.Name == "Attachment" then
				if descendant.Name == "ParticleEmitter" then
					descendant.Texture = "rbxassetid://96123320328002"
				else
					descendant.Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(128, 128, 128))
					}
				end
			end
		end
	elseif skin == "Blitz" then
		for _, descendant in ipairs(container:GetDescendants()) do
			if descendant:IsA("ParticleEmitter") and descendant.Parent.Name == "Attachment" then
				if descendant.Name == "ParticleEmitter" then
					descendant.Texture = "rbxassetid://126371141966093"
				else
					descendant.Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 107, 47)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 100, 0))
					}
				end
			end
		end
	elseif skin == "veri sad" then
		for _, descendant in ipairs(container:GetDescendants()) do
			if descendant:IsA("ParticleEmitter") and descendant.Name == "ParticleEmitter" then
				descendant.Texture = "rbxassetid://14229414086"
			end
		end
	end
end

local function ambushSkin(entity)
	task.wait(0.1)
	local skin = GetCurrentSkin("Ambush")
	if not skin then return end
	local container = entity:FindFirstChild("RushNew")
	if not container then return end

	if skin == "Old" then
		for _, descendant in ipairs(container:GetDescendants()) do
			if descendant:IsA("ParticleEmitter") and descendant.Parent.Name == "Attachment" then
				if descendant.Name == "ParticleEmitter" then
					descendant.Texture = "rbxassetid://11387541299"
				end
			end
			if descendant:IsA("PointLight") then
				descendant.Brightness = 25555556
				descendant.Range = 15
				descendant.Color = Color3.fromRGB(255, 0, 4)
			end	
		end
	elseif skin == "Ambus" then
		for _, descendant in ipairs(container:GetDescendants()) do
			if descendant:IsA("ParticleEmitter") and descendant.Parent.Name == "Attachment" then
				if descendant.Name == "ParticleEmitter" then
					descendant.Texture = "rbxassetid://13705966898"
				end
			end
			if descendant:IsA("PointLight") then
				descendant.Brightness = 0
				descendant.Range = 0
			end	
		end
	elseif skin == "Stage 2" then
		for _, descendant in ipairs(container:GetDescendants()) do
			if descendant:IsA("ParticleEmitter") and descendant.Parent.Name == "Attachment" then
				if descendant.Name == "ParticleEmitter" then
					descendant.Texture = "rbxassetid://106229929047970"
				end
			end
			if descendant:IsA("PointLight") then
				descendant.Range = 25
			end	
		end
	elseif skin == "Glitched" then
		for _, descendant in ipairs(container:GetDescendants()) do
			if descendant:IsA("ParticleEmitter") and descendant.Parent.Name == "Attachment" then
				if descendant.Name == "ParticleEmitter" then
					descendant.Texture = "rbxassetid://86673868926469"
				end
			end
			if descendant:IsA("PointLight") then
				descendant.Brightness = 2555555584
				descendant.Range = 20
				descendant.Color = Color3.fromRGB(255, 0, 4)
			end	
		end
	elseif skin == "Stage 3" then
		for _, descendant in ipairs(container:GetDescendants()) do
			if descendant:IsA("ParticleEmitter") and descendant.Parent.Name == "Attachment" then
				if descendant.Name == "ParticleEmitter" then
					descendant.Texture = "rbxassetid://133716056050083"
					descendant.LockedToPart = false
				end
			end
			if descendant:IsA("PointLight") then
				descendant.Brightness = 12212121
				descendant.Range = 60
				descendant.Color = Color3.fromRGB(17, 212, 115)
			end	
			if descendant:IsA("Sound") then
				descendant.PlaybackSpeed = descendant.PlaybackSpeed * 0.2
				descendant.Volume = math.clamp(descendant.Volume * 4, 0, 10)
				local reverb = Instance.new("ReverbSoundEffect")
				reverb.DecayTime = 10
				reverb.WetLevel = 0.8
				reverb.DryLevel = 0.2
				reverb.Parent = descendant
				local echo = Instance.new("EchoSoundEffect")
				echo.Delay = 0.5
				echo.WetLevel = 0.7
				echo.DryLevel = 0.3
				echo.Parent = descendant
			end
		end
	elseif skin == "Neko Ambush" then
		for _, descendant in ipairs(container:GetDescendants()) do
			if descendant:IsA("ParticleEmitter") and descendant.Parent.Name == "Attachment" then
				if descendant.Name == "ParticleEmitter" then
					descendant.Texture = "rbxassetid://11208622587"
				end
			end
			if descendant:IsA("PointLight") then
				descendant.Brightness = 15
				descendant.Range = 15
				descendant.Color = Color3.fromRGB(247, 0, 255)
			end	
		end
	elseif skin == "Trolololo" then
		for _, descendant in ipairs(container:GetDescendants()) do
			if descendant:IsA("ParticleEmitter") and descendant.Parent.Name == "Attachment" then
				if descendant.Name == "ParticleEmitter" then
					descendant.Texture = "rbxassetid://11879070081"
				end
			end
		end
	elseif skin == "veri sad" then
		for _, descendant in ipairs(container:GetDescendants()) do
			if descendant:IsA("ParticleEmitter") and descendant.Parent.Name == "Attachment" then
				if descendant.Name == "ParticleEmitter" then
					descendant.Texture = "rbxassetid://73075323354438"
				end
			end
			if descendant:IsA("PointLight") then
				descendant.Brightness = 5
				descendant.Range = 10
			end	
		end
	elseif skin == "but bad" then
		for _, descendant in ipairs(container:GetDescendants()) do
			if descendant:IsA("ParticleEmitter") and descendant.Parent.Name == "Attachment" then
				if descendant.Name == "ParticleEmitter" then
					descendant.Texture = "rbxassetid://11035107437"
				end
			end
			if descendant:IsA("PointLight") then
				descendant.Brightness = 5
				descendant.Range = 10
			end	
		end
	end
end
local function eyesSkin(entity)
	task.wait(0.1)
	local skin = GetCurrentSkin("Eyes")
	if not skin then return end
	local container = entity:FindFirstChild("Core")
	if not container then return end

	local function disableOtherParticles()
		for _, descendant in ipairs(container:GetDescendants()) do
			if descendant:IsA("ParticleEmitter") and descendant.Name ~= "Eyes" and descendant.Name ~= "Angry" then
				descendant.Enabled = false
			end
		end
	end

	if skin == "Old" then
		for _, descendant in ipairs(container:GetDescendants()) do
			if descendant:IsA("ParticleEmitter") and descendant.Parent.Name == "Attachment" then
				descendant.Enabled = false
			end
			if descendant:IsA("PointLight") then
				descendant.Brightness = 25
				descendant.Range = 15
			end	
		end
		local eyeParticles = Instance.new("Model")
		eyeParticles.Name = "eyeParticles"

		local Eyes = Instance.new("ParticleEmitter")
		Eyes.Brightness = 1.26
		Eyes.EmissionDirection = Enum.NormalId.Front
		Eyes.LockedToPart = true
		Eyes.Rate = 0.2
		Eyes.Shape = Enum.ParticleEmitterShape.Sphere
		Eyes.ShapeStyle = Enum.ParticleEmitterShapeStyle.Surface
		Eyes.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0), NumberSequenceKeypoint.new(1, 0.5, 0)})
		Eyes.Speed = NumberRange.new(0)
		Eyes.Squash = NumberSequence.new({NumberSequenceKeypoint.new(0, -1, 0), NumberSequenceKeypoint.new(0.03, -0.47, 0), NumberSequenceKeypoint.new(0.07, -0.17, 0), NumberSequenceKeypoint.new(0.43, -0.12, 0), NumberSequenceKeypoint.new(0.46, -0.39, 0), NumberSequenceKeypoint.new(0.48, -0.73, 0), NumberSequenceKeypoint.new(0.52, -0.73, 0), NumberSequenceKeypoint.new(0.55, -0.15, 0), NumberSequenceKeypoint.new(0.94, -0.17, 0), NumberSequenceKeypoint.new(0.97, -0.25, 0), NumberSequenceKeypoint.new(1, -0.68, 0)})
		Eyes.Texture = "rbxassetid://10183789367"
		Eyes.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(0.46, 0, 0), NumberSequenceKeypoint.new(0.47, 1, 0), NumberSequenceKeypoint.new(0.51, 1, 0), NumberSequenceKeypoint.new(0.53, 0, 0), NumberSequenceKeypoint.new(1, 0, 0)})
		Eyes.VelocityInheritance = 0.5
		Eyes.ZOffset = 2
		Eyes.Name = "Eyes"

		local Eyes_2 = Eyes:Clone()
		Eyes_2.Rate = 0.3
		Eyes_2.Texture = "rbxassetid://10183789209"

		local Eyes_3 = Eyes:Clone()
		Eyes_3.Rate = 0.36
		Eyes_3.Texture = "rbxassetid://10183788505"

		local Eyes_4 = Eyes:Clone()
		Eyes_4.Rate = 0.34
		Eyes_4.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.35, 0), NumberSequenceKeypoint.new(1, 0.35, 0)})
		Eyes_4.Texture = "rbxassetid://10183788915"

		local Eyes_5 = Eyes:Clone()
		Eyes_5.Rate = 0.4
		Eyes_5.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.7, 0), NumberSequenceKeypoint.new(1, 0.7, 0)})
		Eyes_5.Texture = "rbxassetid://10183789076"

		local Eyes_6 = Eyes:Clone()
		Eyes_6.Rate = 0.3
		Eyes_6.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.98, 0), NumberSequenceKeypoint.new(1, 0.98, 0)})
		Eyes_6.Texture = "rbxassetid://10183788505"

		Eyes.Parent = eyeParticles
		Eyes_2.Parent = eyeParticles
		Eyes_3.Parent = eyeParticles
		Eyes_4.Parent = eyeParticles
		Eyes_5.Parent = eyeParticles
		Eyes_6.Parent = eyeParticles

		for _, particle in ipairs(eyeParticles:GetChildren()) do
			particle.Parent = container
		end

		container.Attachment.Angry.Texture = "rbxassetid://4868646391"
		container.Attachment.Angry.Rate = 10
		container.Attachment.Angry.Rotation = NumberRange.new(-5,5)
		container.Attachment.Angry.LightEmission = 1
		container.Attachment.Angry.Size = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 6),
			NumberSequenceKeypoint.new(1, 6)
		})

		task.spawn(function()
			while entity.Parent do
				disableOtherParticles()
				task.wait(0.1)
			end
		end)
	elseif skin == "Lookman" then
		for _, descendant in ipairs(container:GetDescendants()) do
			if descendant:IsA("ParticleEmitter") and descendant.Parent.Name == "Attachment" then
				if descendant.Name == "EyesParticle" then
					descendant.Texture = "rbxassetid://101244281293434"
				else
					descendant.Enabled = false
				end
			end
			if descendant:IsA("PointLight") then
				descendant.Brightness = 0
				descendant.Range = 0
			end	
		end
	end
end

local function seekSkin(entity)
	if GetCurrentSkin("Seek") == "Old" then
		task.wait(0.5)
		if entity:FindFirstChild("Figure") then
			entity.Figure.Transparency = 0
			for _, child in pairs(entity.SeekRig:GetDescendants()) do
				if child:IsA("BasePart") then
					child.Transparency = 1
				elseif child:IsA("Decal") or child:IsA("Texture") then
					child:Destroy()
				end
			end
			for _, particle in pairs(entity.Figure:GetDescendants()) do
				if particle:IsA("ParticleEmitter") then
					particle.Enabled = true
				end
			end
		end
	end
end

local function screechSkin(entity)
	if GetCurrentSkin("Screech") == "Bald" then
		task.wait(0.25)

		local skinColor = Color3.fromRGB(198, 177, 178)
		for _, tentacle in pairs(entity:GetChildren()) do
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

-- connector
local function connectEntitySkins(entity)
	if entity.Name == "RushMoving" then
		task.spawn(function() rushSkin(entity) end)
	elseif entity.Name == "AmbushMoving" then
		task.spawn(function() ambushSkin(entity) end)
	elseif entity.Name == "SeekMovingNewClone" then
		seekSkin(entity)
	elseif entity.Name == "Screech" then
		screechSkin(entity)
	elseif entity.Name == "Eyes" then
		eyesSkin(entity)
	end
end

-- run for existing entities
for _, obj in ipairs(game.Workspace:GetChildren()) do
	connectEntitySkins(obj)
end
for _, obj in ipairs(game.Workspace.CurrentCamera:GetChildren()) do
	connectEntitySkins(obj)
end

-- connect for new ones
game.Workspace.ChildAdded:Connect(connectEntitySkins)
game.Workspace.CurrentCamera.ChildAdded:Connect(connectEntitySkins)
