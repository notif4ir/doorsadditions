-- LocalScript inside StarterPlayerScripts

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local tool = Instance.new("Tool")
tool.Name = "DFling"
tool.RequiresHandle = false
tool.CanBeDropped = false
tool.Parent = player.Backpack

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DFlingUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(0.3,0,0.05,0)
textLabel.Position = UDim2.new(0.35,0,0.05,0)
textLabel.BackgroundTransparency = 1
textLabel.TextScaled = true
textLabel.Font = Enum.Font.SourceSansBold
textLabel.TextColor3 = Color3.fromRGB(0,255,0)
textLabel.Text = "Fling Force: 0"
textLabel.Visible = false
textLabel.Parent = screenGui

local charging = false
local force = 0
local forceIncrement = 10
local chargeInterval = 0.025

tool.Equipped:Connect(function()
	textLabel.Visible = true
end)

tool.Unequipped:Connect(function()
	textLabel.Visible = false
	charging = false
	force = 0
	textLabel.Text = "Fling Force: 0"
end)

UIS.InputBegan:Connect(function(input, gp)
	if gp then return end
	if tool.Parent == player.Character then
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			charging = true
			force = 0
			while charging do
				force += forceIncrement
				textLabel.Text = "Fling Force: " .. force
				task.wait(chargeInterval)
			end
		end
	end
end)

UIS.InputEnded:Connect(function(input, gp)
	if gp then return end
	if tool.Parent == player.Character then
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			charging = false
			local char = player.Character
			if char and char:FindFirstChild("HumanoidRootPart") then
				local hrp = char.HumanoidRootPart
				local direction = camera.CFrame.LookVector.Unit
				hrp.Velocity = direction * force
			end
			force = 0
			textLabel.Text = "Fling Force: 0"
		end
	end
end)
