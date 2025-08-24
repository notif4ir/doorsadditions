repeat wait() until game:IsLoaded()
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
repeat wait() until playerGui:WaitForChild("TopbarUI"):WaitForChild("Topbar"):WaitForChild("Stardust")

spawn(function()
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
mainFrame.Size = UDim2.new(0.9, 0, 0.85, 0)
mainFrame.BackgroundColor3 = originalBackground
mainFrame.BackgroundTransparency = 0.15
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
titleLabel.Size = UDim2.new(1, -60, 0, 50)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "SKINS"
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.TextSize = 36
titleLabel.TextColor3 = originalImageColor
titleLabel.TextScaled = true
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

local characters = {"Map","Rush","Ambush","Eyes","Screech","Seek","Figure"}
local skins = {
	Map = {
		{Name="Retro", Image="rbxassetid://14663229942", Cost=100},
		{Name="Pixel", Image="rbxassetid://13569233822", Cost=75},
		{Name="Rusty", Image="rbxassetid://17847838254", Cost=75},
		{Name="Inverted", Image="rbxassetid://96498567035505", Cost=50},
	},
	Rush = {
		{Name="Old", Image="rbxassetid://11845899956", Cost=50},
		{Name="but bad", Image="rbxassetid://11027732448", Cost=25},
		{Name="Screaming", Image="rbxassetid://11709617815", Cost=100},
		{Name="Minecraft", Image="rbxassetid://10896793201", Cost=25},
		{Name="Plushie", Image="rbxassetid://12978732658", Cost=100},
		{Name="Tuff", Image="rbxassetid://87088896638971", Cost=100},
		{Name="Stage 2", Image="rbxassetid://96123320328002", Cost=100},
		{Name="Blitz", Image="rbxassetid://16755073604", Cost=100},
		{Name="veri sad", Image="rbxassetid://14229414086", Cost=50},
		{Name="pewpew", Image="rbxassetid://11004381332", Cost=50},
		{Name="Golden", Image="rbxassetid://10859906277", Cost=75},
		{Name="Nightmare", Image="rbxassetid://12426378358", Cost=50},
		{Name="Stage 3", Image="rbxassetid://71095814517056", Cost=200},
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
		{Name="Double Lighted", Image="rbxassetid://117626246301713", Cost=100},
		{Name="Neon", Image="rbxassetid://110494047315151", Cost=50},
	},
	Eyes = {
		{Name="Old", Image="rbxassetid://10183789367", Cost=100},
		{Name="Lookman", Image="rbxassetid://101244281293434", Cost=75},
		{Name="Seeys", Image="rbxassetid://16458340255", Cost=75},
		{Name="Seek Eye", Image="rbxassetid://11244133614", Cost=50},
		{Name="but bad", Image="rbxassetid://11697351921", Cost=25},
		{Name="Kawaii", Image="rbxassetid://12568774779", Cost=75},
		{Name="Halt eyes", Image="rbxassetid://112372068839719", Cost=50},
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
	dskinData = {currency=0, bought={}, equipped={}, customSkins={}}
	for _, char in ipairs(characters) do
		dskinData.bought[char] = {}
		dskinData.equipped[char] = "None"
		dskinData.customSkins[char] = {}
	end
	writefile(dataFile, HttpService:JSONEncode(dskinData))
else
	dskinData = HttpService:JSONDecode(readfile(dataFile))
	for _, char in ipairs(characters) do
		if not dskinData.bought[char] then dskinData.bought[char] = {} end
		if not dskinData.equipped[char] then dskinData.equipped[char] = "None" end
		if not dskinData.customSkins then dskinData.customSkins = {} end
		if not dskinData.customSkins[char] then dskinData.customSkins[char] = {} end
	end
	saveData()
end

local function reload()
	dskinData = HttpService:JSONDecode(readfile(dataFile))
end

local function getNextCustomId(char)
	local maxId = 0
	for _, s in ipairs(dskinData.customSkins[char]) do
		if typeof(s.Id) == "number" and s.Id > maxId then maxId = s.Id end
	end
	return maxId + 1
end

local modalShade = Instance.new("Frame")
modalShade.Name = "ModalShade"
modalShade.BackgroundColor3 = Color3.new(0,0,0)
modalShade.BackgroundTransparency = 0.4
modalShade.Visible = false
modalShade.Size = UDim2.new(1,0,1,0)
modalShade.Parent = mainFrame
local function showShade(v) modalShade.Visible = v end

local function openCustomEditor(charName, slotId, refreshTab)
	if mainFrame:FindFirstChild("CustomEditor") then mainFrame.CustomEditor:Destroy() end
	showShade(true)
	local editor = Instance.new("Frame")
	editor.Name = "CustomEditor"
	editor.Size = UDim2.new(0.6, 0, 0.6, 0)
	editor.Position = UDim2.new(0.5, 0, 0.5, 0)
	editor.AnchorPoint = Vector2.new(0.5, 0.5)
	editor.BackgroundColor3 = Color3.fromRGB(20,20,20)
	editor.BorderColor3 = originalStrokeColor
	editor.Parent = mainFrame
	local corner = Instance.new("UICorner", editor)
	corner.CornerRadius = UDim.new(0, 16)
	local pad = Instance.new("UIPadding", editor)
	pad.PaddingTop = UDim.new(0,16)
	pad.PaddingBottom = UDim.new(0,16)
	pad.PaddingLeft = UDim.new(0,16)
	pad.PaddingRight = UDim.new(0,16)
	local grid = Instance.new("UIGridLayout", editor)
	grid.CellPadding = UDim2.new(0,10,0,10)
	grid.FillDirectionMaxCells = 2
	grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
	grid.SortOrder = Enum.SortOrder.LayoutOrder
	grid.VerticalAlignment = Enum.VerticalAlignment.Top
	local function resizeGrid()
		local w = editor.AbsoluteSize.X
		local columns = w > 900 and 2 or 1
		grid.FillDirectionMaxCells = columns
		grid.CellSize = UDim2.new(1/columns, -12, 0, 56)
	end
	editor:GetPropertyChangedSignal("AbsoluteSize"):Connect(resizeGrid)
	task.defer(resizeGrid)
	local function field(lbl)
		local row = Instance.new("Frame")
		row.BackgroundTransparency = 1
		row.Size = UDim2.new(1,0,0,56)
		local l = Instance.new("TextLabel", row)
		l.Size = UDim2.new(0.35,0,1,0)
		l.BackgroundTransparency = 1
		l.Text = lbl
		l.Font = Enum.Font.GothamBold
		l.TextScaled = true
		l.TextColor3 = Color3.new(1,1,1)
		local b = Instance.new("TextBox", row)
		b.Size = UDim2.new(0.65,0,1,0)
		b.BackgroundColor3 = Color3.fromRGB(40,40,40)
		b.TextColor3 = Color3.new(1,1,1)
		b.Font = Enum.Font.Gotham
		b.TextScaled = true
		b.ClearTextOnFocus = false
		local r = Instance.new("UICorner", b)
		r.CornerRadius = UDim.new(0,10)
		return row, b
	end
	local row1, nameBox = field("Name")
	local row2, imageBox = field("Main Texture ID")
	local row3, ptexBox = field("Particle Texture ID")
	local row4, rBox = field("Red (0-255)")
	local row5, gBox = field("Green (0-255)")
	local row6, bBox = field("Blue (0-255)")
	row1.Parent = editor
	row2.Parent = editor
	row3.Parent = editor
	row4.Parent = editor
	row5.Parent = editor
	row6.Parent = editor
	local preview = Instance.new("ImageLabel")
	preview.Size = UDim2.new(1,0,0,160)
	preview.BackgroundColor3 = Color3.fromRGB(32,32,32)
	preview.BorderColor3 = originalStrokeColor
	preview.ScaleType = Enum.ScaleType.Fit
	preview.Parent = editor
	local btnBar = Instance.new("Frame")
	btnBar.BackgroundTransparency = 1
	btnBar.Size = UDim2.new(1,0,0,56)
	btnBar.Parent = editor
	local btnLayout = Instance.new("UIListLayout", btnBar)
	btnLayout.FillDirection = Enum.FillDirection.Horizontal
	btnLayout.Padding = UDim.new(0,10)
	btnLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	btnLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	local function mkBtn(text,color)
		local b = Instance.new("TextButton")
		b.Size = UDim2.new(0,140,1,0)
		b.Text = text
		b.TextScaled = true
		b.TextColor3 = Color3.new(1,1,1)
		b.BackgroundColor3 = color
		local r = Instance.new("UICorner", b)
		r.CornerRadius = UDim.new(0,10)
		b.Parent = btnBar
		return b
	end
	local equipBtn = mkBtn("Equip", Color3.fromRGB(70,120,255))
	local saveBtn = mkBtn("Save", Color3.fromRGB(0,150,0))
	local closeBtn = mkBtn("Close", Color3.fromRGB(120,120,120))
	local slot
	for _, s in ipairs(dskinData.customSkins[charName]) do
		if s.Id == slotId then slot = s break end
	end
	if not slot then editor:Destroy() showShade(false) return end
	nameBox.Text = slot.Name or ("Custom "..slotId)
	imageBox.Text = slot.Image or ""
	ptexBox.Text = slot.ParticleTexture or ""
	rBox.Text = tostring((slot.ParticleColor and slot.ParticleColor[1]) or 255)
	gBox.Text = tostring((slot.ParticleColor and slot.ParticleColor[2]) or 255)
	bBox.Text = tostring((slot.ParticleColor and slot.ParticleColor[3]) or 255)
	preview.Image = slot.Image or ""
	local function commit(saveOnly)
		slot.Name = nameBox.Text ~= "" and nameBox.Text or ("Custom "..slotId)
		slot.Image = imageBox.Text ~= "" and imageBox.Text or slot.Image
		slot.ParticleTexture = ptexBox.Text or ""
		slot.ParticleColor = {math.clamp(tonumber(rBox.Text) or 255,0,255), math.clamp(tonumber(gBox.Text) or 255,0,255), math.clamp(tonumber(bBox.Text) or 255,0,255)}
		saveData()
		if refreshTab then refreshTab() end
		if not saveOnly then
			dskinData.equipped[charName] = "custom_"..tostring(slotId)
			saveData()
			if refreshTab then refreshTab() end
		end
		preview.Image = slot.Image or ""
	end
	imageBox:GetPropertyChangedSignal("Text"):Connect(function() preview.Image = imageBox.Text end)
	equipBtn.MouseButton1Click:Connect(function() commit(false) end)
	saveBtn.MouseButton1Click:Connect(function() commit(true) end)
	closeBtn.MouseButton1Click:Connect(function() editor:Destroy() showShade(false) end)
end

local headerBar = Instance.new("Frame")
headerBar.Size = UDim2.new(1, -20, 0, 60)
headerBar.Position = UDim2.new(0,10,0,60)
headerBar.BackgroundTransparency = 1
headerBar.Parent = mainFrame
local tabBar = Instance.new("ScrollingFrame")
tabBar.Name = "TabBar"
tabBar.Size = UDim2.new(1, 0, 1, 0)
tabBar.CanvasSize = UDim2.new(0, 0, 0, 0)
tabBar.ScrollBarThickness = 4
tabBar.BackgroundTransparency = 1
tabBar.Parent = headerBar
local uiList = Instance.new("UIListLayout")
uiList.FillDirection = Enum.FillDirection.Horizontal
uiList.SortOrder = Enum.SortOrder.LayoutOrder
uiList.Padding = UDim.new(0,10)
uiList.Parent = tabBar

local contentScroller = Instance.new("ScrollingFrame")
contentScroller.Name = "ContentScroller"
contentScroller.Size = UDim2.new(1, -20, 1, -140)
contentScroller.Position = UDim2.new(0,10,0,120)
contentScroller.BackgroundTransparency = 1
contentScroller.ScrollBarThickness = 6
contentScroller.Parent = mainFrame

local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, 0, 1, 0)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = contentScroller

local tabFrames = {}

local function buildGrid(scroller)
	for _, c in ipairs(scroller:GetChildren()) do if c:IsA("UIGridLayout") then c:Destroy() end end
	local grid = Instance.new("UIGridLayout", scroller)
	grid.CellPadding = UDim2.new(0,10,0,10)
	grid.SortOrder = Enum.SortOrder.LayoutOrder
	local function resize()
		local w = scroller.AbsoluteSize.X
		local columns = 2
		if w >= 1200 then columns = 5 elseif w >= 900 then columns = 4 elseif w >= 650 then columns = 3 else columns = 2 end
		local cellW = (w - (columns-1)*10) / columns
		local cellH = math.floor(cellW*0.8)+60
		grid.CellSize = UDim2.new(0, math.floor(cellW), 0, math.floor(cellH))
	end
	scroller:GetPropertyChangedSignal("AbsoluteSize"):Connect(resize)
	task.defer(resize)
	return grid
end

local function makeTile(parent, imageId, title, sub, onClick, extraBtnText, extraBtnCallback)
	local tile = Instance.new("Frame")
	tile.BackgroundColor3 = originalBackground
	tile.BorderColor3 = originalStrokeColor
	tile.Parent = parent
	local corner = buttonCorner:Clone()
	corner.Parent = tile
	local img = Instance.new("ImageButton")
	img.Name = "Image"
	img.Size = UDim2.new(1,0,0.75,0)
	img.BackgroundColor3 = Color3.fromRGB(30,30,30)
	img.Image = imageId or ""
	img.ScaleType = Enum.ScaleType.Fit
	img.Parent = tile
	local nameLabel = Instance.new("TextLabel")
	nameLabel.Size = UDim2.new(1, -10, 0, 22)
	nameLabel.Position = UDim2.new(0,5,0.75,4)
	nameLabel.BackgroundTransparency = 1
	nameLabel.TextColor3 = Color3.new(1,1,1)
	nameLabel.Font = Enum.Font.GothamBold
	nameLabel.TextScaled = true
	nameLabel.Text = title
	nameLabel.Parent = tile
	local subLabel = Instance.new("TextLabel")
	subLabel.Size = UDim2.new(0.5, -10, 0, 20)
	subLabel.Position = UDim2.new(0,5,1,-24)
	subLabel.BackgroundTransparency = 1
	subLabel.TextColor3 = Color3.new(1,1,1)
	subLabel.Font = Enum.Font.Gotham
	subLabel.TextScaled = true
	subLabel.Text = sub
	subLabel.Parent = tile
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.5, -10, 0, 26)
	btn.Position = UDim2.new(0.5,5,1,-28)
	btn.Text = "Select"
	btn.TextScaled = true
	btn.TextColor3 = Color3.new(1,1,1)
	btn.BackgroundColor3 = Color3.fromRGB(60,120,255)
	local bc = Instance.new("UICorner", btn)
	bc.CornerRadius = UDim.new(0,10)
	btn.Parent = tile
	if extraBtnText and extraBtnCallback then
		local ebtn = Instance.new("TextButton")
		ebtn.Size = UDim2.new(0.5, -10, 0, 26)
		ebtn.Position = UDim2.new(0,5,1,-28)
		ebtn.Text = extraBtnText
		ebtn.TextScaled = true
		ebtn.TextColor3 = Color3.new(1,1,1)
		ebtn.BackgroundColor3 = Color3.fromRGB(90,90,130)
		local ec = Instance.new("UICorner", ebtn)
		ec.CornerRadius = UDim.new(0,10)
		ebtn.Parent = tile
		ebtn.MouseButton1Click:Connect(extraBtnCallback)
	end
	img.MouseButton1Click:Connect(onClick)
	btn.MouseButton1Click:Connect(onClick)
	return tile, subLabel, btn
end

for _, char in ipairs(characters) do
	local tabButton = Instance.new("TextButton")
	tabButton.Name = char.."Tab"
	tabButton.Text = char
	tabButton.Size = UDim2.new(0, 140, 1, 0)
	tabButton.BackgroundColor3 = originalBackground
	tabButton.TextColor3 = originalImageColor
	tabButton.Font = Enum.Font.GothamBold
	tabButton.TextScaled = true
	local corner = Instance.new("UICorner", tabButton)
	corner.CornerRadius = UDim.new(0,12)
	tabButton.Parent = tabBar

	local tabFrame = Instance.new("ScrollingFrame")
	tabFrame.Name = char.."Frame"
	tabFrame.Size = UDim2.new(1, 0, 1, 0)
	tabFrame.BackgroundTransparency = 1
	tabFrame.ScrollBarThickness = 6
	tabFrame.Visible = false
	tabFrame.Parent = contentFrame
	buildGrid(tabFrame)

	tabFrames[tabButton] = tabFrame

	local function updateTab()
		for _, child in ipairs(tabFrame:GetChildren()) do
			if child:IsA("Frame") then child:Destroy() end
		end
		reload()
		local skinList = { {Name="None", Image="rbxassetid://2195446979", Cost=0, Kind="builtin"} }
		for _, s in ipairs(skins[char] or {}) do table.insert(skinList, {Name=s.Name, Image=s.Image, Cost=s.Cost, Kind="builtin"}) end
		for _, c in ipairs(dskinData.customSkins[char] or {}) do
			table.insert(skinList, {Name=c.Name, Image=c.Image or "rbxassetid://0", Cost=0, Kind="custom", Id=c.Id, ParticleColor=c.ParticleColor, ParticleTexture=c.ParticleTexture})
		end
		for _, skin in ipairs(skinList) do
			local equippedNow = dskinData.equipped[char]
			local isEquipped = skin.Kind=="custom" and equippedNow=="custom_"..tostring(skin.Id) or equippedNow==skin.Name
			local owned = skin.Kind=="custom" or skin.Name=="None" or table.find(dskinData.bought[char], skin.Name) ~= nil
			local subText = isEquipped and "Equipped" or (owned and "Owned" or tostring(skin.Cost))
			local tile, subLabel, btn = makeTile(tabFrame, skin.Image, skin.Kind=="custom" and (skin.Name.." (custom_"..skin.Id..")") or skin.Name, subText, function()
				reload()
				if skin.Kind=="builtin" then
					if skin.Name ~= "None" and not table.find(dskinData.bought[char], skin.Name) then
						if dskinData.currency >= skin.Cost then
							dskinData.currency = dskinData.currency - skin.Cost
							table.insert(dskinData.bought[char], skin.Name)
							saveData()
						else
							subLabel.Text = "Need "..skin.Cost
							return
						end
					end
					dskinData.equipped[char] = skin.Name
					saveData()
					subLabel.Text = "Equipped"
				else
					dskinData.equipped[char] = "custom_"..tostring(skin.Id)
					saveData()
					subLabel.Text = "Equipped"
				end
			end, skin.Kind=="custom" and "Edit" or nil, skin.Kind=="custom" and function()
				openCustomEditor(char, skin.Id, updateTab)
			end or nil)
			if isEquipped then
				for _, v in ipairs(tile:GetChildren()) do
					if v:IsA("TextButton") and v.Text=="Select" then v.Text = "Equipped" v.BackgroundColor3 = Color3.fromRGB(0,160,70) end
				end
			elseif owned then
				for _, v in ipairs(tile:GetChildren()) do
					if v:IsA("TextButton") and v.Text=="Select" then v.Text = "Equip" v.BackgroundColor3 = Color3.fromRGB(60,120,255) end
				end
			else
				for _, v in ipairs(tile:GetChildren()) do
					if v:IsA("TextButton") and v.Text=="Select" then v.Text = "Buy" v.BackgroundColor3 = Color3.fromRGB(200,150,0) end
				end
			end
		end
		if char == "Rush" or char == "Ambush" then
			local addTile = Instance.new("Frame")
			addTile.BackgroundColor3 = Color3.fromRGB(40,80,40)
			addTile.BorderColor3 = originalStrokeColor
			local c = Instance.new("UICorner", addTile) c.CornerRadius = UDim.new(0,12)
			addTile.Parent = tabFrame
			local t = Instance.new("TextButton", addTile)
			t.Size = UDim2.new(1,-10,1,-10)
			t.Position = UDim2.new(0,5,0,5)
			t.Text = "+ New Custom (250)"
			t.TextScaled = true
			t.TextColor3 = Color3.new(1,1,1)
			t.BackgroundTransparency = 1
			t.MouseButton1Click:Connect(function()
				reload()
				if dskinData.currency < 250 then
					t.Text = "Need 250"
					task.delay(1,function() if t then t.Text = "+ New Custom (250)" end end)
					return
				end
				dskinData.currency = dskinData.currency - 250
				local id = getNextCustomId(char)
				local defaultImage = char=="Rush" and "rbxassetid://10859906277" or "rbxassetid://11387541299"
				local slot = {Id=id, Name="Custom "..id, Image=defaultImage, ParticleColor={255,255,255}, ParticleTexture=""}
				table.insert(dskinData.customSkins[char], slot)
				saveData()
				updateTab()
				openCustomEditor(char, id, updateTab)
			end)
		end
		tabFrame.CanvasSize = UDim2.new(0,0,0,0)
	end

	tabButton.MouseButton1Click:Connect(function()
		for _, f in pairs(tabFrames) do f.Visible = false end
		for b, f in pairs(tabFrames) do b.BackgroundColor3 = originalBackground end
		tabFrame.Visible = true
		tabButton.BackgroundColor3 = Color3.fromRGB(60,60,60)
		updateTab()
	end)
end

do
	local first = tabBar:FindFirstChild(characters[1].."Tab")
	if first and first:IsA("TextButton") then first:Activate() end
end

_G.DSkin = _G.DSkin or {}

_G.DSkin.GetEquipped = function(char)
	reload()
	return dskinData.equipped[char]
end

_G.DSkin.GetCustomById = function(char, id)
	reload()
	for _, s in ipairs(dskinData.customSkins[char] or {}) do
		if s.Id == id then return s end
	end
	return nil
end

spawn(function()
	local Players = game:GetService("Players")
	local HttpService = game:GetService("HttpService")
	local LocalPlayer = Players.LocalPlayer
	local CodeInput = LocalPlayer.PlayerGui.GlobalUI.Shop.ScrollingShop.Code.CodeInput
	local dataFile = "DSKINS_PLAYERDATA"
	local codeFile = "DSKINS_RDCDS"

	if not pcall(function() readfile(codeFile) end) then
		writefile(codeFile, "")
	end

	local redeemedCodes = {}
	local savedData = readfile(codeFile)
	for code in string.gmatch(savedData, "[^\n]+") do
		redeemedCodes[code] = true
	end

	local validCodes = {
		["F4IR"] = 25,
		["CUSTOMSKINS"] = 25,
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

	local function AddCurrency(amount)
		local data = ensureData()
		data.currency = data.currency + amount
		writeData(data)
	end

	local function redeemCode(code)
		code = code:upper()
		if redeemedCodes[code] then
			warn("Code already redeemed!")
			return
		end
		local reward = validCodes[code]
		if reward then
			redeemedCodes[code] = true
			local newData = ""
			for c,_ in pairs(redeemedCodes) do
				newData = newData .. c .. "\n"
			end
			writefile(codeFile, newData)
			AddCurrency(reward)
			print("Code redeemed: " .. code .. " | Currency added: " .. reward)
		else
			warn("Invalid code!")
		end
	end

	CodeInput.FocusLost:Connect(function(enterPressed)
		if enterPressed then
			local code = CodeInput.Text
			redeemCode(code)
			CodeInput.Text = ""
		end
	end)
end)
