-- Farewell Infortality.
-- Version: 2.82
-- Instances:
local UI = Instance.new("ScreenGui")
local UIFrame = Instance.new("Frame")
local loadcmd = Instance.new("TextButton")
local TextLabel = Instance.new("TextLabel")
local closeui = Instance.new("TextButton")
--Properties:
UI.Name = "UI"
UI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

UIFrame.Name = "UIFrame"
UIFrame.Parent = UI
UIFrame.BackgroundColor3 = Color3.new(0.403922, 0.403922, 0.403922)
UIFrame.BorderSizePixel = 0
UIFrame.Position = UDim2.new(0.312999994, 0, -0.15, 0)
UIFrame.Size = UDim2.new(0, 769, 0, 50)

loadcmd.Name = "loadcmd"
loadcmd.Parent = UIFrame
loadcmd.BackgroundColor3 = Color3.new(1, 1, 1)
loadcmd.BackgroundTransparency = 1
loadcmd.Position = UDim2.new(0, 0, 0.180000007, 0)
loadcmd.Size = UDim2.new(0, 171, 0, 32)
loadcmd.Font = Enum.Font.SourceSansLight
loadcmd.Text = "Load CMD (or type :cmd)"
loadcmd.TextColor3 = Color3.new(1, 1, 1)
loadcmd.TextScaled = true
loadcmd.TextSize = 14
loadcmd.TextWrapped = true
loadcmd.MouseButton1Click:connect(function()
	loadstring(game:HttpGet("https://pastebin.com/raw/M3tZZAqa",true))()
end)

TextLabel.Parent = UIFrame
TextLabel.BackgroundColor3 = Color3.new(0.478431, 0.478431, 0.478431)
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0.356306911, 0, -0.180000007, 0)
TextLabel.Size = UDim2.new(0, 221, 0, 68)
TextLabel.Font = Enum.Font.SourceSansBold
TextLabel.Text = "Ultimate Script Admin"
TextLabel.TextColor3 = Color3.new(1, 1, 1)
TextLabel.TextScaled = true
TextLabel.TextSize = 14
TextLabel.TextWrapped = true

closeui.Name = "closeui"
closeui.Parent = UIFrame
closeui.BackgroundColor3 = Color3.new(1, 1, 1)
closeui.BackgroundTransparency = 1
closeui.Position = UDim2.new(0.755526662, 0, 0.180000007, 0)
closeui.Size = UDim2.new(0, 171, 0, 32)
closeui.Font = Enum.Font.SourceSansLight
closeui.Text = "Close (can't be opened again)"
closeui.TextColor3 = Color3.new(1, 1, 1)
closeui.TextScaled = true
closeui.TextSize = 14
closeui.TextWrapped = true
closeui.MouseButton1Click:connect(function()
	UIFrame:TweenPosition(UDim2.new(0.313, 0,-0.15, 0), 'Out', 'Bounce', 1, true)
end)
-- Scripts:

UIFrame:TweenPosition(UDim2.new(0.313, 0,0.025, 0), 'In', 'Bounce', 1, true)
