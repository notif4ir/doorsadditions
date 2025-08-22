repeat wait() until game:IsLoaded()
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

repeat wait() until playerGui:FindFirstChild("TopbarUI")

spawn(function()
	
	local topbar = playerGui:WaitForChild("TopbarUI"):WaitForChild("Topbar")

	local dataFile = "dskin_data.json"

	local HttpService = game:GetService("HttpService")
	local Players = game:GetService("Players")
	local player = Players.LocalPlayer
	local playerGui = player:WaitForChild("PlayerGui")
	local topbar = playerGui:WaitForChild("TopbarUI"):WaitForChild("Topbar")

	local dataFile = "dskin_data.json"

	local function getCurrency()
		if not isfile(dataFile) then return 0 end
		local data = HttpService:JSONDecode(readfile(dataFile))
		return data.currency or 0
	end

	local original = topbar:WaitForChild("Stardust")
	local riftshards = original:Clone()
	riftshards.Name = "Riftshards"
	riftshards.Parent = topbar
	
	riftshards.Visible = true
	riftshards.Icon.Image = "rbxassetid://14400901694"
	riftshards.Boosted.Image = "rbxassetid://14400901694"
	riftshards.Icon.ImageColor3 = Color3.fromRGB(108,79,255)
	riftshards.Boosted.ImageColor3 = Color3.fromRGB(108,79,255)

	local textLabel = riftshards

	local function updateUI()
		local currency = getCurrency()
		textLabel.Text = tostring(currency)
		local digitCount = #tostring(currency)
		local extraWidth = (digitCount * 10)
		riftshards.Size = UDim2.new(original.Size.X.Scale, original.Size.X.Offset + extraWidth, original.Size.Y.Scale, original.Size.Y.Offset)
	end

	updateUI()

	task.spawn(function()
		while true do
			updateUI()
			task.wait(0.5)
		end
	end)

end) 

if game.PlaceId == 6516141723 then else warn("not in doors lobby, returning lol v2 and only showing currency") return end

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local mainUI = playerGui:WaitForChild("MainUI")
local lobbyFrame = mainUI:WaitForChild("LobbyFrame")
local bottomButtons = lobbyFrame:WaitForChild("BottomButtons")
local lobbyMainButtons = lobbyFrame:WaitForChild("LobbyMainButtons")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local templateButton = bottomButtons:WaitForChild("ButtonInventory")
lobbyMainButtons.Visible = true
bottomButtons.Visible = true

local oldButton = bottomButtons:FindFirstChild("ButtonSkins")
if oldButton then oldButton:Destroy() end
local oldFrame = mainUI:FindFirstChild("SkinsFrame")
if oldFrame then oldFrame:Destroy() end

local buttonClone = templateButton:Clone()
buttonClone.Name = "ButtonSkins"
buttonClone.Parent = bottomButtons
buttonClone.ImageLabel.Image = "rbxassetid://4521136666"

local uiStroke = buttonClone:FindFirstChildWhichIsA("UIStroke")
local originalStrokeColor = uiStroke and uiStroke.Color or Color3.new(1,1,1)
local originalBackground = buttonClone.BackgroundColor3
local originalImageColor = buttonClone.ImageLabel.ImageColor3

local uiScale = buttonClone:FindFirstChildWhichIsA("UIScale")
if not uiScale then
	uiScale = Instance.new("UIScale")
	uiScale.Parent = buttonClone
end
uiScale.Scale = 1

local hoverScale = 1.13
local tweenTime = 0.1
local cornerScaleFactor = 1/16

local function tweenProperties(targetScale, targetBg, targetStroke, targetImageColor)
	local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	TweenService:Create(uiScale, tweenInfo, {Scale = targetScale}):Play()
	TweenService:Create(buttonClone, tweenInfo, {BackgroundColor3 = targetBg}):Play()
	if uiStroke then
		TweenService:Create(uiStroke, tweenInfo, {Color = targetStroke}):Play()
	end
	TweenService:Create(buttonClone.ImageLabel, tweenInfo, {ImageColor3 = targetImageColor}):Play()
end

buttonClone.MouseEnter:Connect(function()
	tweenProperties(hoverScale, originalStrokeColor, originalBackground, originalBackground)
end)

buttonClone.MouseLeave:Connect(function()
	tweenProperties(1, originalBackground, originalStrokeColor, originalStrokeColor)
end)

local mainFrame = Instance.new("Frame")
mainFrame.Name = "SkinsFrame"
mainFrame.AnchorPoint = Vector2.new(0.5,0.5)
mainFrame.Position = UDim2.new(0.5,0,0.5,0)
mainFrame.Size = UDim2.new(0, 1000, 0, 700)
mainFrame.BackgroundColor3 = originalBackground
mainFrame.BackgroundTransparency = 0.25
mainFrame.BorderColor3 = originalStrokeColor
mainFrame.Visible = false
mainFrame.Parent = mainUI

local frameStroke = uiStroke and uiStroke:Clone()
if frameStroke then frameStroke.Parent = mainFrame end

local buttonCorner = buttonClone:FindFirstChildWhichIsA("UICorner")
if buttonCorner then
	local frameCorner = buttonCorner:Clone()
	frameCorner.CornerRadius = UDim.new(buttonCorner.CornerRadius.Scale * cornerScaleFactor, buttonCorner.CornerRadius.Offset * cornerScaleFactor)
	frameCorner.Parent = mainFrame
end

local closeButton = Instance.new("ImageButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 40, 0, 40)
closeButton.Position = UDim2.new(1, -45, 0, 5)
closeButton.AnchorPoint = Vector2.new(0,0)
closeButton.BackgroundTransparency = 1
closeButton.BorderSizePixel = 0
closeButton.Image = "rbxassetid://2195446979"
closeButton.ImageColor3 = originalImageColor
closeButton.Parent = mainFrame

if buttonCorner then
	local closeCorner = buttonCorner:Clone()
	closeCorner.CornerRadius = UDim.new(buttonCorner.CornerRadius.Scale * cornerScaleFactor, buttonCorner.CornerRadius.Offset * cornerScaleFactor)
	closeCorner.Parent = closeButton
end

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "SKINS"
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.TextSize = 36
titleLabel.TextColor3 = originalImageColor
titleLabel.TextScaled = false
titleLabel.Parent = mainFrame

closeButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
	lobbyMainButtons.Visible = true
	bottomButtons.Visible = true
end)

buttonClone.MouseButton1Click:Connect(function()
	mainFrame.Visible = true
	lobbyMainButtons.Visible = false
	bottomButtons.Visible = false
end)

local characters = {"Rush","Ambush","Eyes","Screech","Seek","Figure"}
local skins = {
	Rush = {
		{Name="Old", Image="rbxassetid://11845899956", Cost=50},
		{Name="but bad", Image="rbxassetid://11027732448", Cost=25},
		{Name="Screaming", Image="rbxassetid://11709617815", Cost=100},
		{Name="Minecraft", Image="rbxassetid://10896793201", Cost=25},
		{Name="Plushie", Image="rbxassetid://12978732658", Cost=100},
		{Name="Tuff", Image="rbxassetid://87088896638971", Cost=100},
		{Name="Stage 2", Image="rbxassetid://96123320328002", Cost=100},
		{Name="Blitz", Image="rbxassetid://126371141966093", Cost=75},
		{Name="veri sad", Image="rbxassetid://14229414086", Cost=50}
	},
	Ambush = {
		{Name="Old", Image="rbxassetid://11387541299", Cost=50},
		{Name="Ambus", Image="rbxassetid://13705966898", Cost=50},
		{Name="Stage 2", Image="rbxassetid://106229929047970", Cost=100},
		{Name="Glitched", Image="rbxassetid://86673868926469", Cost=75},
		{Name="Stage 3", Image="rbxassetid://133716056050083", Cost=200},
		{Name="Neko", Image="rbxassetid://11208622587", Cost=75},
		{Name="Trolololo", Image="rbxassetid://11879070081", Cost=75},
		{Name="veri sad", Image="rbxassetid://73075323354438", Cost=50},
		{Name="but bad", Image="rbxassetid://11035107437", Cost=25},
	},
	Eyes = {
		{Name="Old", Image="rbxassetid://10183789367", Cost=100},
		{Name="Lookman", Image="rbxassetid://101244281293434", Cost=75},
	},
	Screech = {
		{Name="Bald", Image="rbxassetid://11143896610", Cost=100},
	},
	Seek = {
		{Name="Old", Image="rbxassetid://126017924797876", Cost=100},
	},
	Figure = {
		{Name="Noob", Image="rbxassetid://13143745036", Cost=75},
	}
}

local dataFile = "dskin_data.json"

local dskinData

local function saveData()
	writefile(dataFile, HttpService:JSONEncode(dskinData))
end

if not isfile(dataFile) then
	dskinData = {currency=0, bought={}, equipped={}}
	for _, char in ipairs(characters) do
		dskinData.bought[char] = {}
		dskinData.equipped[char] = "None"
	end
	writefile(dataFile, HttpService:JSONEncode(dskinData))
else
	dskinData = HttpService:JSONDecode(readfile(dataFile))
	for _, char in ipairs(characters) do
		if not dskinData.bought[char] then
			dskinData.bought[char] = {}
		end
		if not dskinData.equipped[char] then
			dskinData.equipped[char] = "None"
		end
	end
	saveData()
end

local tabBar = Instance.new("ScrollingFrame")
tabBar.Name = "TabBar"
tabBar.Size = UDim2.new(1, -20, 0, 50)
tabBar.Position = UDim2.new(0,10,0,60)
tabBar.BackgroundTransparency = 1
tabBar.ScrollBarThickness = 6
tabBar.CanvasSize = UDim2.new(0, 0, 0, 0)
tabBar.HorizontalScrollBarInset = Enum.ScrollBarInset.ScrollBar
tabBar.Parent = mainFrame

local uiList = Instance.new("UIListLayout")
uiList.FillDirection = Enum.FillDirection.Horizontal
uiList.SortOrder = Enum.SortOrder.LayoutOrder
uiList.Padding = UDim.new(0,10)
uiList.Parent = tabBar

local tabFrames = {}

for i, char in ipairs(characters) do
	local tabButton = Instance.new("TextButton")
	tabButton.Name = char.."Tab"
	tabButton.Text = char
	tabButton.Size = UDim2.new(0, 120, 1, 0)
	tabButton.BackgroundColor3 = originalBackground
	tabButton.TextColor3 = originalImageColor
	tabButton.Font = Enum.Font.GothamBold
	tabButton.TextSize = 20
	tabButton.Parent = tabBar

	local tabFrame = Instance.new("ScrollingFrame")
	tabFrame.Name = char.."Frame"
	tabFrame.Size = UDim2.new(1, -20, 1, -120)
	tabFrame.Position = UDim2.new(0,10,0,110)
	tabFrame.BackgroundColor3 = originalBackground
	tabFrame.BackgroundTransparency = 0.25
	tabFrame.BorderColor3 = originalStrokeColor
	tabFrame.Visible = false
	tabFrame.ScrollBarThickness = 6
	tabFrame.Parent = mainFrame

	local frameCorner = buttonCorner:Clone()
	frameCorner.CornerRadius = UDim.new(buttonCorner.CornerRadius.Scale * cornerScaleFactor, buttonCorner.CornerRadius.Offset * cornerScaleFactor)
	frameCorner.Parent = tabFrame

	tabFrames[tabButton] = tabFrame

	local function updateTab()
		for _, child in ipairs(tabFrame:GetChildren()) do
			if child:IsA("ImageButton") then
				child:Destroy()
			end
		end

		local skinList = { {Name="None", Image="rbxassetid://2195446979", Cost=0} }
		for _, s in ipairs(skins[char] or {}) do table.insert(skinList, s) end

		local xOffset = 0
		for _, skin in ipairs(skinList) do
			local skinButton = Instance.new("ImageButton")
			skinButton.Size = UDim2.new(0, 150, 0, 150)
			skinButton.Position = UDim2.new(0, xOffset, 0, 0)
			skinButton.Image = skin.Image
			skinButton.BackgroundColor3 = originalBackground
			skinButton.BorderColor3 = originalStrokeColor
			skinButton.Parent = tabFrame

			local skinCorner = buttonCorner:Clone()
			skinCorner.Parent = skinButton

			local nameLabel = Instance.new("TextLabel")
			nameLabel.Size = UDim2.new(1,0,0,30)
			nameLabel.Position = UDim2.new(0,0,1,0)
			nameLabel.BackgroundTransparency = 1
			nameLabel.TextColor3 = Color3.new(1,1,1)
			nameLabel.Font = Enum.Font.GothamBold
			nameLabel.TextSize = 18
			nameLabel.Text = skin.Name
			nameLabel.Parent = skinButton

			local costLabel = Instance.new("TextLabel")
			costLabel.Size = UDim2.new(1,0,0,20)
			costLabel.Position = UDim2.new(0,0,1,30)
			costLabel.BackgroundTransparency = 1
			costLabel.TextColor3 = Color3.new(1,1,1)
			costLabel.Font = Enum.Font.Gotham
			costLabel.TextSize = 16
			costLabel.Text = (dskinData.equipped[char]==skin.Name and "Equipped") or (table.find(dskinData.bought[char], skin.Name) and "Owned") or tostring(skin.Cost)
			costLabel.Parent = skinButton

			skinButton.MouseButton1Click:Connect(function()
				local freshData = HttpService:JSONDecode(readfile(dataFile))
				dskinData = freshData
				if skin.Name ~= "None" and not table.find(dskinData.bought[char], skin.Name) then
					if dskinData.currency >= skin.Cost then
						dskinData.currency = dskinData.currency - skin.Cost
						table.insert(dskinData.bought[char], skin.Name)
					else
						costLabel.Text = "Not enough currency!"
						task.delay(1, updateTab)
						return
					end
				end
				dskinData.equipped[char] = skin.Name
				saveData()
				updateTab()
			end)

			xOffset = xOffset + 160
		end
		tabFrame.CanvasSize = UDim2.new(0, xOffset, 0, 0)
	end

	tabButton.MouseButton1Click:Connect(function()
		for _, f in pairs(tabFrames) do f.Visible = false end
		tabFrame.Visible = true
		updateTab()
	end)
end
