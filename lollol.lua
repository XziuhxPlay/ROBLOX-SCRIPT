-- Farewell Infortality.
-- Version: 2.82
-- Instances:
local CMDList = Instance.new("ScreenGui")
local commandframe = Instance.new("Frame")
local partofframe = Instance.new("Frame")
local rainbowpartcmd = Instance.new("Frame")
local adsfdsfas = Instance.new("TextLabel")
local closecmd = Instance.new("TextButton")
local TextLabel = Instance.new("TextLabel")
local TextLabel_2 = Instance.new("TextLabel")
local TextLabel_3 = Instance.new("TextLabel")
local TextLabel_4 = Instance.new("TextLabel")
local TextLabel_5 = Instance.new("TextLabel")
local TextLabel_6 = Instance.new("TextLabel")
local TextLabel_7 = Instance.new("TextLabel")
local TextLabel_8 = Instance.new("TextLabel")
local TextLabel_9 = Instance.new("TextLabel")
local TextLabel_10 = Instance.new("TextLabel")
local TextLabel_11 = Instance.new("TextLabel")
local TextLabel_12 = Instance.new("TextLabel")
local TextLabel_13 = Instance.new("TextLabel")
local TextLabel_14 = Instance.new("TextLabel")
local TextLabel_15 = Instance.new("TextLabel")
local TextLabel_16 = Instance.new("TextLabel")
local TextLabel_17 = Instance.new("TextLabel")
local TextLabel_18 = Instance.new("TextLabel")
local TextLabel_19 = Instance.new("TextLabel")
local TextLabel_20 = Instance.new("TextLabel")
local TextLabel_21 = Instance.new("TextLabel")
local TextLabel_22 = Instance.new("TextLabel")
local TextLabel_23 = Instance.new("TextLabel")
local TextLabel_24 = Instance.new("TextLabel")
local TextLabel_25 = Instance.new("TextLabel")
local TextLabel_26 = Instance.new("TextLabel")
local TextLabel_27 = Instance.new("TextLabel")
local TextLabel_28 = Instance.new("TextLabel")
local TextLabel_29 = Instance.new("TextLabel")
local TextLabel_30 = Instance.new("TextLabel")
local TextLabel_31 = Instance.new("TextLabel")
local TextLabel_32 = Instance.new("TextLabel")
local TextLabel_33 = Instance.new("TextLabel")
--Properties:
CMDList.Name = "CMDList"
CMDList.Parent = game.CoreGui

commandframe.Name = "commandframe"
commandframe.Parent = CMDList
commandframe.BackgroundColor3 = Color3.new(0.337255, 0.337255, 0.337255)
commandframe.BorderSizePixel = 2
commandframe.Position = UDim2.new(-0.2, 0,0.054, 0)
commandframe.Size = UDim2.new(0, 237, 0, 777)
commandframe.Visible = true
commandframe.Active = true
commandframe.Draggable = true

partofframe.Name = "partofframe"
partofframe.Parent = commandframe
partofframe.BackgroundColor3 = Color3.new(0.219608, 0.219608, 0.219608)
partofframe.BorderSizePixel = 0
partofframe.Position = UDim2.new(-0.0295358654, 0, 0, 0)
partofframe.Size = UDim2.new(0, 251, 0, 23)

rainbowpartcmd.Name = "rainbowpartcmd"
rainbowpartcmd.Parent = commandframe
rainbowpartcmd.BackgroundColor3 = Color3.new(1, 1, 1)
rainbowpartcmd.BorderSizePixel = 0
rainbowpartcmd.Position = UDim2.new(-0.0295358654, 0, 0.0296010301, 0)
rainbowpartcmd.Size = UDim2.new(0, 251, 0, 15)

adsfdsfas.Name = "adsfdsfas"
adsfdsfas.Parent = commandframe
adsfdsfas.BackgroundColor3 = Color3.new(0.262745, 0.262745, 0.262745)
adsfdsfas.BorderSizePixel = 0
adsfdsfas.Position = UDim2.new(0.0759493634, 0, -0.0154440152, 0)
adsfdsfas.Size = UDim2.new(0, 200, 0, 35)
adsfdsfas.Text = "Commands List"
adsfdsfas.TextColor3 = Color3.new(1, 1, 1)
adsfdsfas.TextSize = 18
adsfdsfas.TextWrapped = true

closecmd.Name = "closecmd"
closecmd.Parent = commandframe
closecmd.BackgroundColor3 = Color3.new(1, 1, 1)
closecmd.BackgroundTransparency = 1
closecmd.Position = UDim2.new(0.919831216, 0, 0, 0)
closecmd.Size = UDim2.new(0, 26, 0, 23)
closecmd.Text = "X"
closecmd.TextColor3 = Color3.new(1, 1, 1)
closecmd.TextScaled = true
closecmd.TextSize = 14
closecmd.TextWrapped = true
closecmd.MouseButton1Click:connect(function()
commandframe:TweenPosition(UDim2.new(-0.2, 0,0.054, 0), 'Out', 'Bounce', 1, true)
end)

TextLabel.Parent = commandframe
TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel.BackgroundTransparency = 1
TextLabel.Position = UDim2.new(0.0464135036, 0, 0.0617760606, 0)
TextLabel.Size = UDim2.new(0, 216, 0, 23)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = ":toolgui"
TextLabel.TextColor3 = Color3.new(1, 1, 1)
TextLabel.TextSize = 20
TextLabel.TextStrokeTransparency = 0
TextLabel.TextWrapped = true
TextLabel.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_2.Parent = commandframe
TextLabel_2.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_2.BackgroundTransparency = 1
TextLabel_2.Position = UDim2.new(0.0464135036, 0, 0.0913770944, 0)
TextLabel_2.Size = UDim2.new(0, 216, 0, 23)
TextLabel_2.Font = Enum.Font.SourceSans
TextLabel_2.Text = "loads in a tool gui where you can save and load your tools"
TextLabel_2.TextColor3 = Color3.new(1, 1, 1)
TextLabel_2.TextScaled = true
TextLabel_2.TextSize = 14
TextLabel_2.TextWrapped = true
TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_3.Parent = commandframe
TextLabel_3.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_3.BackgroundTransparency = 1
TextLabel_3.Position = UDim2.new(0.0464135036, 0, 0.120978117, 0)
TextLabel_3.Size = UDim2.new(0, 216, 0, 23)
TextLabel_3.Font = Enum.Font.SourceSans
TextLabel_3.Text = ":savetools"
TextLabel_3.TextColor3 = Color3.new(1, 1, 1)
TextLabel_3.TextSize = 20
TextLabel_3.TextStrokeTransparency = 0
TextLabel_3.TextWrapped = true
TextLabel_3.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_4.Parent = commandframe
TextLabel_4.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_4.BackgroundTransparency = 1
TextLabel_4.Position = UDim2.new(0.0464135036, 0, 0.150579154, 0)
TextLabel_4.Size = UDim2.new(0, 216, 0, 23)
TextLabel_4.Font = Enum.Font.SourceSans
TextLabel_4.Text = "lets you save your tools so if you die they wont go away"
TextLabel_4.TextColor3 = Color3.new(1, 1, 1)
TextLabel_4.TextScaled = true
TextLabel_4.TextSize = 14
TextLabel_4.TextWrapped = true
TextLabel_4.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_5.Parent = commandframe
TextLabel_5.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_5.BackgroundTransparency = 1
TextLabel_5.Position = UDim2.new(0.0464135036, 0, 0.180180177, 0)
TextLabel_5.Size = UDim2.new(0, 216, 0, 23)
TextLabel_5.Font = Enum.Font.SourceSans
TextLabel_5.Text = ":loadtools"
TextLabel_5.TextColor3 = Color3.new(1, 1, 1)
TextLabel_5.TextSize = 20
TextLabel_5.TextStrokeTransparency = 0
TextLabel_5.TextWrapped = true
TextLabel_5.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_6.Parent = commandframe
TextLabel_6.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_6.BackgroundTransparency = 1
TextLabel_6.Position = UDim2.new(0.0464135036, 0, 0.199485198, 0)
TextLabel_6.Size = UDim2.new(0, 216, 0, 23)
TextLabel_6.Font = Enum.Font.SourceSans
TextLabel_6.Text = "lets you load the tools that you have saved"
TextLabel_6.TextColor3 = Color3.new(1, 1, 1)
TextLabel_6.TextScaled = true
TextLabel_6.TextSize = 14
TextLabel_6.TextWrapped = true
TextLabel_6.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_7.Parent = commandframe
TextLabel_7.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_7.BackgroundTransparency = 1
TextLabel_7.Position = UDim2.new(0.0464135036, 0, 0.22908622, 0)
TextLabel_7.Size = UDim2.new(0, 216, 0, 23)
TextLabel_7.Font = Enum.Font.SourceSans
TextLabel_7.Text = ":antiafk"
TextLabel_7.TextColor3 = Color3.new(1, 1, 1)
TextLabel_7.TextSize = 20
TextLabel_7.TextStrokeTransparency = 0
TextLabel_7.TextWrapped = true
TextLabel_7.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_8.Parent = commandframe
TextLabel_8.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_8.BackgroundTransparency = 1
TextLabel_8.Position = UDim2.new(0.0421940945, 0, 0.258687258, 0)
TextLabel_8.Size = UDim2.new(0, 216, 0, 23)
TextLabel_8.Font = Enum.Font.SourceSans
TextLabel_8.Text = "lets you go afk with no risk of getting kicked out the game"
TextLabel_8.TextColor3 = Color3.new(1, 1, 1)
TextLabel_8.TextScaled = true
TextLabel_8.TextSize = 14
TextLabel_8.TextWrapped = true
TextLabel_8.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_9.Parent = commandframe
TextLabel_9.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_9.BackgroundTransparency = 1
TextLabel_9.Position = UDim2.new(0.0464135036, 0, 0.288288295, 0)
TextLabel_9.Size = UDim2.new(0, 216, 0, 23)
TextLabel_9.Font = Enum.Font.SourceSans
TextLabel_9.Text = ":blockhead"
TextLabel_9.TextColor3 = Color3.new(1, 1, 1)
TextLabel_9.TextSize = 20
TextLabel_9.TextStrokeTransparency = 0
TextLabel_9.TextWrapped = true
TextLabel_9.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_10.Parent = commandframe
TextLabel_10.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_10.BackgroundTransparency = 1
TextLabel_10.Position = UDim2.new(0.0464135036, 0, 0.317889333, 0)
TextLabel_10.Size = UDim2.new(0, 216, 0, 23)
TextLabel_10.Font = Enum.Font.SourceSans
TextLabel_10.Text = "removes the mesh on your head"
TextLabel_10.TextColor3 = Color3.new(1, 1, 1)
TextLabel_10.TextScaled = true
TextLabel_10.TextSize = 14
TextLabel_10.TextWrapped = true
TextLabel_10.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_11.Parent = commandframe
TextLabel_11.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_11.BackgroundTransparency = 1
TextLabel_11.Position = UDim2.new(0.0421940945, 0, 0.34749037, 0)
TextLabel_11.Size = UDim2.new(0, 216, 0, 23)
TextLabel_11.Font = Enum.Font.SourceSans
TextLabel_11.Text = ":creeper6"
TextLabel_11.TextColor3 = Color3.new(1, 1, 1)
TextLabel_11.TextSize = 20
TextLabel_11.TextStrokeTransparency = 0
TextLabel_11.TextWrapped = true
TextLabel_11.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_12.Parent = commandframe
TextLabel_12.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_12.BackgroundTransparency = 1
TextLabel_12.Position = UDim2.new(0.0464135036, 0, 0.368082374, 0)
TextLabel_12.Size = UDim2.new(0, 216, 0, 23)
TextLabel_12.Font = Enum.Font.SourceSans
TextLabel_12.Text = "use only when in R6 (turns you into a creeper)"
TextLabel_12.TextColor3 = Color3.new(1, 1, 1)
TextLabel_12.TextScaled = true
TextLabel_12.TextSize = 14
TextLabel_12.TextWrapped = true
TextLabel_12.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_13.Parent = commandframe
TextLabel_13.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_13.BackgroundTransparency = 1
TextLabel_13.Position = UDim2.new(0.0464135036, 0, 0.396396428, 0)
TextLabel_13.Size = UDim2.new(0, 216, 0, 23)
TextLabel_13.Font = Enum.Font.SourceSans
TextLabel_13.Text = ":creeper15"
TextLabel_13.TextColor3 = Color3.new(1, 1, 1)
TextLabel_13.TextSize = 20
TextLabel_13.TextStrokeTransparency = 0
TextLabel_13.TextWrapped = true
TextLabel_13.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_14.Parent = commandframe
TextLabel_14.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_14.BackgroundTransparency = 1
TextLabel_14.Position = UDim2.new(0.0464135036, 0, 0.418275416, 0)
TextLabel_14.Size = UDim2.new(0, 216, 0, 23)
TextLabel_14.Font = Enum.Font.SourceSans
TextLabel_14.Text = "use only when in R15 (turns you into a creeper)"
TextLabel_14.TextColor3 = Color3.new(1, 1, 1)
TextLabel_14.TextScaled = true
TextLabel_14.TextSize = 14
TextLabel_14.TextWrapped = true
TextLabel_14.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_15.Parent = commandframe
TextLabel_15.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_15.BackgroundTransparency = 1
TextLabel_15.Position = UDim2.new(0.0464135036, 0, 0.44658947, 0)
TextLabel_15.Size = UDim2.new(0, 216, 0, 23)
TextLabel_15.Font = Enum.Font.SourceSans
TextLabel_15.Text = ":shattervest"
TextLabel_15.TextColor3 = Color3.new(1, 1, 1)
TextLabel_15.TextSize = 20
TextLabel_15.TextStrokeTransparency = 0
TextLabel_15.TextWrapped = true
TextLabel_15.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_16.Parent = commandframe
TextLabel_16.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_16.BackgroundTransparency = 1
TextLabel_16.Position = UDim2.new(0.0421940945, 0, 0.476190478, 0)
TextLabel_16.Size = UDim2.new(0, 216, 0, 23)
TextLabel_16.Font = Enum.Font.SourceSans
TextLabel_16.Text = "powerful FE admin, very good for trolling and other stuff "
TextLabel_16.TextColor3 = Color3.new(1, 1, 1)
TextLabel_16.TextScaled = true
TextLabel_16.TextSize = 14
TextLabel_16.TextWrapped = true
TextLabel_16.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_17.Parent = commandframe
TextLabel_17.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_17.BackgroundTransparency = 1
TextLabel_17.Position = UDim2.new(0.0421940945, 0, 0.504504502, 0)
TextLabel_17.Size = UDim2.new(0, 216, 0, 23)
TextLabel_17.Font = Enum.Font.SourceSans
TextLabel_17.Text = ":animationgui"
TextLabel_17.TextColor3 = Color3.new(1, 1, 1)
TextLabel_17.TextSize = 20
TextLabel_17.TextStrokeTransparency = 0
TextLabel_17.TextWrapped = true
TextLabel_17.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_18.Parent = commandframe
TextLabel_18.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_18.BackgroundTransparency = 1
TextLabel_18.Position = UDim2.new(0.0421940945, 0, 0.534105539, 0)
TextLabel_18.Size = UDim2.new(0, 216, 0, 23)
TextLabel_18.Font = Enum.Font.SourceSans
TextLabel_18.Text = "lets you do animation and can be seen by other players"
TextLabel_18.TextColor3 = Color3.new(1, 1, 1)
TextLabel_18.TextScaled = true
TextLabel_18.TextSize = 14
TextLabel_18.TextWrapped = true
TextLabel_18.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_19.Parent = commandframe
TextLabel_19.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_19.BackgroundTransparency = 1
TextLabel_19.Position = UDim2.new(0.0464135036, 0, 0.57271558, 0)
TextLabel_19.Size = UDim2.new(0, 216, 0, 23)
TextLabel_19.Font = Enum.Font.SourceSans
TextLabel_19.Text = ":gabx"
TextLabel_19.TextColor3 = Color3.new(1, 1, 1)
TextLabel_19.TextSize = 20
TextLabel_19.TextStrokeTransparency = 0
TextLabel_19.TextWrapped = true
TextLabel_19.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_20.Parent = commandframe
TextLabel_20.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_20.BackgroundTransparency = 1
TextLabel_20.Position = UDim2.new(0.0464135036, 0, 0.593307614, 0)
TextLabel_20.Size = UDim2.new(0, 216, 0, 23)
TextLabel_20.Font = Enum.Font.SourceSans
TextLabel_20.Text = "GUI with alot of fun and very powerful scirpts"
TextLabel_20.TextColor3 = Color3.new(1, 1, 1)
TextLabel_20.TextScaled = true
TextLabel_20.TextSize = 14
TextLabel_20.TextWrapped = true
TextLabel_20.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_21.Parent = commandframe
TextLabel_21.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_21.BackgroundTransparency = 1
TextLabel_21.Position = UDim2.new(0.0421940945, 0, 0.622908652, 0)
TextLabel_21.Size = UDim2.new(0, 216, 0, 23)
TextLabel_21.Font = Enum.Font.SourceSans
TextLabel_21.Text = ":clickdel"
TextLabel_21.TextColor3 = Color3.new(1, 1, 1)
TextLabel_21.TextSize = 20
TextLabel_21.TextStrokeTransparency = 0
TextLabel_21.TextWrapped = true
TextLabel_21.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_22.Parent = commandframe
TextLabel_22.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_22.BackgroundTransparency = 1
TextLabel_22.Position = UDim2.new(0.0464135036, 0, 0.651222646, 0)
TextLabel_22.Size = UDim2.new(0, 216, 0, 23)
TextLabel_22.Font = Enum.Font.SourceSans
TextLabel_22.Text = "Press Ctrl + Del and it will remove the object your mouse is pointed on"
TextLabel_22.TextColor3 = Color3.new(1, 1, 1)
TextLabel_22.TextScaled = true
TextLabel_22.TextSize = 14
TextLabel_22.TextWrapped = true
TextLabel_22.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_23.Parent = commandframe
TextLabel_23.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_23.BackgroundTransparency = 1
TextLabel_23.Position = UDim2.new(0.0464135036, 0, 0.680823684, 0)
TextLabel_23.Size = UDim2.new(0, 216, 0, 23)
TextLabel_23.Font = Enum.Font.SourceSans
TextLabel_23.Text = ":trollinggui"
TextLabel_23.TextColor3 = Color3.new(1, 1, 1)
TextLabel_23.TextSize = 20
TextLabel_23.TextStrokeTransparency = 0
TextLabel_23.TextWrapped = true
TextLabel_23.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_24.Parent = commandframe
TextLabel_24.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_24.BackgroundTransparency = 1
TextLabel_24.Position = UDim2.new(0.0464135036, 0, 0.710424721, 0)
TextLabel_24.Size = UDim2.new(0, 216, 0, 23)
TextLabel_24.Font = Enum.Font.SourceSans
TextLabel_24.Text = "a GUI verison of this admin scirpt"
TextLabel_24.TextColor3 = Color3.new(1, 1, 1)
TextLabel_24.TextScaled = true
TextLabel_24.TextSize = 14
TextLabel_24.TextWrapped = true
TextLabel_24.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_25.Parent = commandframe
TextLabel_25.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_25.BackgroundTransparency = 1
TextLabel_25.Position = UDim2.new(0.0464135036, 0, 0.740025759, 0)
TextLabel_25.Size = UDim2.new(0, 216, 0, 23)
TextLabel_25.Font = Enum.Font.SourceSans
TextLabel_25.Text = ":infinitejump"
TextLabel_25.TextColor3 = Color3.new(1, 1, 1)
TextLabel_25.TextSize = 20
TextLabel_25.TextStrokeTransparency = 0
TextLabel_25.TextWrapped = true
TextLabel_25.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_26.Parent = commandframe
TextLabel_26.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_26.BackgroundTransparency = 1
TextLabel_26.Position = UDim2.new(0.0464135036, 0, 0.769626796, 0)
TextLabel_26.Size = UDim2.new(0, 216, 0, 23)
TextLabel_26.Font = Enum.Font.SourceSans
TextLabel_26.Text = "allows you to jump an infinite amount of times"
TextLabel_26.TextColor3 = Color3.new(1, 1, 1)
TextLabel_26.TextScaled = true
TextLabel_26.TextSize = 14
TextLabel_26.TextWrapped = true
TextLabel_26.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_27.Parent = commandframe
TextLabel_27.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_27.BackgroundTransparency = 1
TextLabel_27.Position = UDim2.new(0.0464135036, 0, 0.799227834, 0)
TextLabel_27.Size = UDim2.new(0, 216, 0, 23)
TextLabel_27.Font = Enum.Font.SourceSans
TextLabel_27.Text = ":opfianlity"
TextLabel_27.TextColor3 = Color3.new(1, 1, 1)
TextLabel_27.TextSize = 20
TextLabel_27.TextStrokeTransparency = 0
TextLabel_27.TextWrapped = true
TextLabel_27.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_28.Parent = commandframe
TextLabel_28.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_28.BackgroundTransparency = 1
TextLabel_28.Position = UDim2.new(0.0464135036, 0, 0.827541888, 0)
TextLabel_28.Size = UDim2.new(0, 216, 0, 23)
TextLabel_28.Font = Enum.Font.SourceSans
TextLabel_28.Text = "Overpowered Filtering Enabled GUI"
TextLabel_28.TextColor3 = Color3.new(1, 1, 1)
TextLabel_28.TextScaled = true
TextLabel_28.TextSize = 14
TextLabel_28.TextWrapped = true
TextLabel_28.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_29.Parent = commandframe
TextLabel_29.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_29.BackgroundTransparency = 1
TextLabel_29.Position = UDim2.new(0.0421940945, 0, 0.857142866, 0)
TextLabel_29.Size = UDim2.new(0, 216, 0, 23)
TextLabel_29.Font = Enum.Font.SourceSans
TextLabel_29.Text = ":aimbot1"
TextLabel_29.TextColor3 = Color3.new(1, 1, 1)
TextLabel_29.TextSize = 20
TextLabel_29.TextStrokeTransparency = 0
TextLabel_29.TextWrapped = true
TextLabel_29.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_30.Parent = commandframe
TextLabel_30.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_30.BackgroundTransparency = 1
TextLabel_30.Position = UDim2.new(0.0464135036, 0, 0.88545692, 0)
TextLabel_30.Size = UDim2.new(0, 216, 0, 23)
TextLabel_30.Font = Enum.Font.SourceSans
TextLabel_30.Text = "Loads an Aimbot (Ctrl) to lock onto players"
TextLabel_30.TextColor3 = Color3.new(1, 1, 1)
TextLabel_30.TextScaled = true
TextLabel_30.TextSize = 14
TextLabel_30.TextWrapped = true
TextLabel_30.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_31.Parent = commandframe
TextLabel_31.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_31.BackgroundTransparency = 1
TextLabel_31.Position = UDim2.new(0.0464135036, 0, 0.915057898, 0)
TextLabel_31.Size = UDim2.new(0, 216, 0, 23)
TextLabel_31.Font = Enum.Font.SourceSans
TextLabel_31.Text = ":aimbot2"
TextLabel_31.TextColor3 = Color3.new(1, 1, 1)
TextLabel_31.TextSize = 20
TextLabel_31.TextStrokeTransparency = 0
TextLabel_31.TextWrapped = true
TextLabel_31.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_32.Parent = commandframe
TextLabel_32.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_32.BackgroundTransparency = 1
TextLabel_32.Position = UDim2.new(0.0464135036, 0, 0.944658995, 0)
TextLabel_32.Size = UDim2.new(0, 216, 0, 23)
TextLabel_32.Font = Enum.Font.SourceSans
TextLabel_32.Text = "Loads an Aimbot (H) to lock onto players"
TextLabel_32.TextColor3 = Color3.new(1, 1, 1)
TextLabel_32.TextScaled = true
TextLabel_32.TextSize = 14
TextLabel_32.TextWrapped = true
TextLabel_32.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_33.Parent = commandframe
TextLabel_33.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_33.BackgroundTransparency = 1
TextLabel_33.Position = UDim2.new(0.0421940945, 0, 0.974259973, 0)
TextLabel_33.Size = UDim2.new(0, 216, 0, 23)
TextLabel_33.Font = Enum.Font.SourceSans
TextLabel_33.Text = ":aimbotgui"
TextLabel_33.TextColor3 = Color3.new(1, 1, 1)
TextLabel_33.TextSize = 20
TextLabel_33.TextStrokeTransparency = 0
TextLabel_33.TextWrapped = true
TextLabel_33.TextXAlignment = Enum.TextXAlignment.Left
-- Scripts:

commandframe:TweenPosition(UDim2.new(0.008, 0,0.054, 0), 'In', 'Bounce', 1, true)


function zigzag(X) return math.acos(math.cos(X*math.pi))/math.pi end

counter = 0

while wait(0.1)do
	rainbowpartcmd.BackgroundColor3 = Color3.fromHSV(zigzag(counter),1,1)

	
	counter = counter + 0.01
end
