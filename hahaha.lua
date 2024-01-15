-- Farewell Infortality.
-- Version: 2.82
-- Instances:
local SaveToolGUI = Instance.new("ScreenGui")
local maintoolgui = Instance.new("Frame")
local sidebar = Instance.new("Frame")
local savetoolrainbow = Instance.new("Frame")
local fsadfasdf = Instance.new("TextLabel")
local savetool = Instance.new("TextButton")
local loadtools = Instance.new("TextButton")
local closetoolgui = Instance.new("TextButton")
local openguitool = Instance.new("Frame")
local opengui = Instance.new("TextButton")
--Properties:
SaveToolGUI.Name = "SaveToolGUI"
SaveToolGUI.Parent = game.CoreGui

maintoolgui.Name = "maintoolgui"
maintoolgui.Parent = SaveToolGUI
maintoolgui.BackgroundColor3 = Color3.new(0.290196, 0.290196, 0.290196)
maintoolgui.BorderSizePixel = 0
maintoolgui.Position = UDim2.new(0.412636995, 0, 0.380214572, 0)
maintoolgui.Size = UDim2.new(0, 271, 0, 201)
maintoolgui.Visible = false

sidebar.Name = "sidebar"
sidebar.Parent = maintoolgui
sidebar.BackgroundColor3 = Color3.new(0.380392, 0.380392, 0.380392)
sidebar.BorderSizePixel = 0
sidebar.Position = UDim2.new(-0.0295202956, 0, 0, 0)
sidebar.Size = UDim2.new(0, 286, 0, 37)

savetoolrainbow.Name = "savetoolrainbow"
savetoolrainbow.Parent = maintoolgui
savetoolrainbow.BackgroundColor3 = Color3.new(1, 1, 1)
savetoolrainbow.BorderSizePixel = 0
savetoolrainbow.Position = UDim2.new(-0.0295202956, 0, 0.184079602, 0)
savetoolrainbow.Size = UDim2.new(0, 286, 0, 7)

fsadfasdf.Name = "fsadfasdf"
fsadfasdf.Parent = maintoolgui
fsadfasdf.BackgroundColor3 = Color3.new(0.317647, 0.317647, 0.317647)
fsadfasdf.BorderSizePixel = 0
fsadfasdf.Position = UDim2.new(0.129151285, 0, -0.0646766201, 0)
fsadfasdf.Size = UDim2.new(0, 200, 0, 50)
fsadfasdf.Font = Enum.Font.Fantasy
fsadfasdf.Text = "Save/Load Tools GUI"
fsadfasdf.TextColor3 = Color3.new(1, 1, 1)
fsadfasdf.TextScaled = true
fsadfasdf.TextSize = 14
fsadfasdf.TextWrapped = true

savetool.Name = "savetool"
savetool.Parent = maintoolgui
savetool.BackgroundColor3 = Color3.new(0.380392, 0.380392, 0.380392)
savetool.BorderSizePixel = 3
savetool.Position = UDim2.new(0.129151285, 0, 0.313432842, 0)
savetool.Size = UDim2.new(0, 200, 0, 43)
savetool.AutoButtonColor = false
savetool.Text = "Save Tools"
savetool.TextColor3 = Color3.new(0, 0, 0)
savetool.TextScaled = true
savetool.TextSize = 14
savetool.TextWrapped = true
savetool.MouseButton1Click:connect(function()
		for _,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
if (v:IsA("Tool")) then
v.Parent = game.Players.LocalPlayer
end
		end
		
						        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Saved Tools";
            Text = "Save/Load Tools GUI";
        })
		
end)

loadtools.Name = "loadtools"
loadtools.Parent = maintoolgui
loadtools.BackgroundColor3 = Color3.new(0.380392, 0.380392, 0.380392)
loadtools.BorderSizePixel = 3
loadtools.Position = UDim2.new(0.129151285, 0, 0.631840825, 0)
loadtools.Size = UDim2.new(0, 200, 0, 43)
loadtools.AutoButtonColor = false
loadtools.Text = "Load Tools"
loadtools.TextColor3 = Color3.new(0, 0, 0)
loadtools.TextScaled = true
loadtools.TextSize = 14
loadtools.TextWrapped = true
loadtools.MouseButton1Click:connect(function()
	for _,v in pairs(game.Players.LocalPlayer:GetChildren()) do
if (v:IsA("Tool")) then
v.Parent = game.Players.LocalPlayer.Backpack
end
	end
	
	
				        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Loaded Tools";
            Text = "Save/Load Tools GUI";
        })
	
	
end)

closetoolgui.Name = "closetoolgui"
closetoolgui.Parent = maintoolgui
closetoolgui.BackgroundColor3 = Color3.new(0.380392, 0.380392, 0.380392)
closetoolgui.BackgroundTransparency = 1
closetoolgui.BorderSizePixel = 3
closetoolgui.Position = UDim2.new(0.867158651, 0, 0.00497512426, 0)
closetoolgui.Size = UDim2.new(0, 43, 0, 36)
closetoolgui.AutoButtonColor = false
closetoolgui.Font = Enum.Font.Highway
closetoolgui.Text = "X"
closetoolgui.TextColor3 = Color3.new(1, 1, 1)
closetoolgui.TextScaled = true
closetoolgui.TextSize = 14
closetoolgui.TextWrapped = true
closetoolgui.MouseButton1Click:connect(function()
	maintoolgui.Visible = false
	openguitool.Visible = true
end)

openguitool.Name = "openguitool"
openguitool.Parent = SaveToolGUI
openguitool.BackgroundColor3 = Color3.new(0.552941, 0.552941, 0.552941)
openguitool.BorderSizePixel = 0
openguitool.Position = UDim2.new(0, 0, 0.703218162, 0)
openguitool.Size = UDim2.new(0, 129, 0, 35)

opengui.Name = "opengui"
opengui.Parent = openguitool
opengui.BackgroundColor3 = Color3.new(0.372549, 0.372549, 0.372549)
opengui.BorderSizePixel = 0
opengui.Position = UDim2.new(0.372093022, 0, -8.71930808e-07, 0)
opengui.Size = UDim2.new(0, 81, 0, 35)
opengui.Font = Enum.Font.Fantasy
opengui.Text = "Open"
opengui.TextColor3 = Color3.new(1, 1, 1)
opengui.TextScaled = true
opengui.TextSize = 14
opengui.TextWrapped = true
opengui.MouseButton1Click:connect(function()
	openguitool.Visible = false
	maintoolgui.Visible = true
end)
-- Scripts:
openguitool.Active = true
openguitool.Draggable = true
maintoolgui.Active = true
maintoolgui.Draggable = true

			        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Loaded";
            Text = "Save/Load Tools GUI";
        })

function zigzag(X) return math.acos(math.cos(X*math.pi))/math.pi end

counter = 0

while wait(0.1)do
	savetoolrainbow.BackgroundColor3 = Color3.fromHSV(zigzag(counter),1,1)
	savetool.TextColor3 = Color3.fromHSV(zigzag(counter),1,1)
	savetool.BorderColor3 = Color3.fromHSV(zigzag(counter),1,1)
	loadtools.TextColor3 = Color3.fromHSV(zigzag(counter),1,1)
	loadtools.BorderColor3 = Color3.fromHSV(zigzag(counter),1,1)

	
	counter = counter + 0.01
end
