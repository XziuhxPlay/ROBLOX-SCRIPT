local main = Instance.new("ScreenGui")
local top = Instance.new("Frame")
local back = Instance.new("Frame")
local ScrollingFrame = Instance.new("ScrollingFrame")
local bald = Instance.new("TextButton")
local ragdoll = Instance.new("TextButton")
local kill = Instance.new("TextButton")
local naked = Instance.new("TextButton")
local goto = Instance.new("TextButton")
local rtools = Instance.new("TextButton")
local box = Instance.new("TextButton")
local sink = Instance.new("TextButton")
local ban = Instance.new("TextButton")
local explorer = Instance.new("TextButton")
local slock = Instance.new("TextButton")
local UIGridLayout = Instance.new("UIGridLayout")
local kick = Instance.new("TextButton")
local blockhead = Instance.new("TextButton")
local stools = Instance.new("TextButton")
local noface = Instance.new("TextButton")
local punish = Instance.new("TextButton")
local pantsless = Instance.new("TextButton")
local shirtless = Instance.new("TextButton")
local tshirtless = Instance.new("TextButton")
local noregen = Instance.new("TextButton")
local stopanim = Instance.new("TextButton")
local blockchar = Instance.new("TextButton")
local nolimbs = Instance.new("TextButton")
local nola = Instance.new("TextButton")
local noll = Instance.new("TextButton")
local nora = Instance.new("TextButton")
local norl = Instance.new("TextButton")
local nowaist = Instance.new("TextButton")
local noroot = Instance.new("TextButton")
local top_2 = Instance.new("TextLabel")
local credits = Instance.new("TextLabel")
local queue = Instance.new("TextLabel")
local target = Instance.new("TextBox")
local Players = game:GetService("Players")
function splitString(str,delim)
	local broken = {}
	if delim == nil then delim = "," end
	for w in string.gmatch(str,"[^"..delim.."]+") do
		table.insert(broken,w)
	end
	return broken
end
function toTokens(str)
	local tokens = {}
	for op,name in string.gmatch(str,"([+-])([^+-]+)") do
		table.insert(tokens,{Operator = op,Name = name})
	end
	return tokens
end
function getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end
local WTS = function(Object)
	local ObjectVector = workspace.CurrentCamera:WorldToScreenPoint(Object.Position)
	return Vector2.new(ObjectVector.X, ObjectVector.Y)
end
local mouse = Players.LocalPlayer:GetMouse()
local MousePositionToVector2 = function()
	return Vector2.new(mouse.X, mouse.Y)
end
local GetClosestPlayerFromCursor = function()
	local found = nil
	local ClosestDistance = math.huge
	for i, v in pairs(Players:GetPlayers()) do
		if v ~= Players.LocalPlayer and v.Character and v.Character:FindFirstChildOfClass("Humanoid") then
			for k, x in pairs(v.Character:GetChildren()) do
				if string.find(x.Name, "Torso") then
					local Distance = (WTS(x) - MousePositionToVector2()).Magnitude
					if Distance < ClosestDistance then
						ClosestDistance = Distance
						found = v
					end
				end
			end
		end
	end
	return found
end
local SpecialPlayerCases = {
	["all"] = function(speaker) return Players:GetPlayers() end,
	["others"] = function(speaker)
		local plrs = {}
		for i,v in pairs(Players:GetPlayers()) do
			if v ~= speaker then
				table.insert(plrs,v)
			end
		end
		return plrs
	end,
	["me"] = function(speaker)return {speaker} end,
	["#(%d+)"] = function(speaker,args,currentList)
		local returns = {}
		local randAmount = tonumber(args[1])
		local players = {unpack(currentList)}
		for i = 1,randAmount do
			if #players == 0 then break end
			local randIndex = math.random(1,#players)
			table.insert(returns,players[randIndex])
			table.remove(players,randIndex)
		end
		return returns
	end,
	["random"] = function(speaker,args,currentList)
		local players = Players:GetPlayers()
		local localplayer = Players.LocalPlayer
		table.remove(players, table.find(players, localplayer))
		return {players[math.random(1,#players)]}
	end,
	["%%(.+)"] = function(speaker,args)
		local returns = {}
		local team = args[1]
		for _,plr in pairs(Players:GetPlayers()) do
			if plr.Team and string.sub(string.lower(plr.Team.Name),1,#team) == string.lower(team) then
				table.insert(returns,plr)
			end
		end
		return returns
	end,
	["allies"] = function(speaker)
		local returns = {}
		local team = speaker.Team
		for _,plr in pairs(Players:GetPlayers()) do
			if plr.Team == team then
				table.insert(returns,plr)
			end
		end
		return returns
	end,
	["enemies"] = function(speaker)
		local returns = {}
		local team = speaker.Team
		for _,plr in pairs(Players:GetPlayers()) do
			if plr.Team ~= team then
				table.insert(returns,plr)
			end
		end
		return returns
	end,
	["team"] = function(speaker)
		local returns = {}
		local team = speaker.Team
		for _,plr in pairs(Players:GetPlayers()) do
			if plr.Team == team then
				table.insert(returns,plr)
			end
		end
		return returns
	end,
	["nonteam"] = function(speaker)
		local returns = {}
		local team = speaker.Team
		for _,plr in pairs(Players:GetPlayers()) do
			if plr.Team ~= team then
				table.insert(returns,plr)
			end
		end
		return returns
	end,
	["friends"] = function(speaker,args)
		local returns = {}
		for _,plr in pairs(Players:GetPlayers()) do
			if plr:IsFriendsWith(speaker.UserId) and plr ~= speaker then
				table.insert(returns,plr)
			end
		end
		return returns
	end,
	["nonfriends"] = function(speaker,args)
		local returns = {}
		for _,plr in pairs(Players:GetPlayers()) do
			if not plr:IsFriendsWith(speaker.UserId) and plr ~= speaker then
				table.insert(returns,plr)
			end
		end
		return returns
	end,
	["guests"] = function(speaker,args)
		local returns = {}
		for _,plr in pairs(Players:GetPlayers()) do
			if plr.Guest then
				table.insert(returns,plr)
			end
		end
		return returns
	end,
	["bacons"] = function(speaker,args)
		local returns = {}
		for _,plr in pairs(Players:GetPlayers()) do
			if plr.Character:FindFirstChild('Pal Hair') or plr.Character:FindFirstChild('Kate Hair') then
				table.insert(returns,plr)
			end
		end
		return returns
	end,
	["age(%d+)"] = function(speaker,args)
		local returns = {}
		local age = tonumber(args[1])
		if not age == nil then return end
		for _,plr in pairs(Players:GetPlayers()) do
			if plr.AccountAge <= age then
				table.insert(returns,plr)
			end
		end
		return returns
	end,
	["nearest"] = function(speaker,args,currentList)
		local speakerChar = speaker.Character
		if not speakerChar or not getRoot(speakerChar) then return end
		local lowest = math.huge
		local NearestPlayer = nil
		for _,plr in pairs(currentList) do
			if plr ~= speaker and plr.Character then
				local distance = plr:DistanceFromCharacter(getRoot(speakerChar).Position)
				if distance < lowest then
					lowest = distance
					NearestPlayer = {plr}
				end
			end
		end
		return NearestPlayer
	end,
	["farthest"] = function(speaker,args,currentList)
		local speakerChar = speaker.Character
		if not speakerChar or not getRoot(speakerChar) then return end
		local highest = 0
		local Farthest = nil
		for _,plr in pairs(currentList) do
			if plr ~= speaker and plr.Character then
				local distance = plr:DistanceFromCharacter(getRoot(speakerChar).Position)
				if distance > highest then
					highest = distance
					Farthest = {plr}
				end
			end
		end
		return Farthest
	end,
	["group(%d+)"] = function(speaker,args)
		local returns = {}
		local groupID = tonumber(args[1])
		for _,plr in pairs(Players:GetPlayers()) do
			if plr:IsInGroup(groupID) then  
				table.insert(returns,plr)
			end
		end
		return returns
	end,
	["alive"] = function(speaker,args)
		local returns = {}
		for _,plr in pairs(Players:GetPlayers()) do
			if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") and plr.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
				table.insert(returns,plr)
			end
		end
		return returns
	end,
	["dead"] = function(speaker,args)
		local returns = {}
		for _,plr in pairs(Players:GetPlayers()) do
			if (not plr.Character or not plr.Character:FindFirstChildOfClass("Humanoid")) or plr.Character:FindFirstChildOfClass("Humanoid").Health <= 0 then
				table.insert(returns,plr)
			end
		end
		return returns
	end,
	["rad(%d+)"] = function(speaker,args)
		local returns = {}
		local radius = tonumber(args[1])
		local speakerChar = speaker.Character
		if not speakerChar or not getRoot(speakerChar) then return end
		for _,plr in pairs(Players:GetPlayers()) do
			if plr.Character and getRoot(plr.Character) then
				local magnitude = (getRoot(plr.Character).Position-getRoot(speakerChar).Position).magnitude
				if magnitude <= radius then table.insert(returns,plr) end
			end
		end
		return returns
	end,
	["cursor"] = function(speaker)
		local plrs = {}
		local v = GetClosestPlayerFromCursor()
		if v ~= nil then table.insert(plrs, v) end
		return plrs
	end,
}
function onlyIncludeInTable(tab,matches)
	local matchTable = {}
	local resultTable = {}
	for i,v in pairs(matches) do matchTable[v.Name] = true end
	for i,v in pairs(tab) do if matchTable[v.Name] then table.insert(resultTable,v) end end
	return resultTable
end

function removeTableMatches(tab,matches)
	local matchTable = {}
	local resultTable = {}
	for i,v in pairs(matches) do matchTable[v.Name] = true end
	for i,v in pairs(tab) do if not matchTable[v.Name] then table.insert(resultTable,v) end end
	return resultTable
end

function getPlayersByName(Name)
	local Name,Len,Found = string.lower(Name),#Name,{}
	for _,v in pairs(Players:GetPlayers()) do
		if Name:sub(0,1) == '@' then
			if string.sub(string.lower(v.Name),1,Len-1) == Name:sub(2) then
				table.insert(Found,v)
			end
		else
			if string.sub(string.lower(v.Name),1,Len) == Name or string.sub(string.lower(v.DisplayName),1,Len) == Name then
				table.insert(Found,v)
			end
		end
	end
	return Found
end
function getPlayer(list,speaker)
	if list == nil then return {speaker.Name} end
	local nameList = splitString(list,",")

	local foundList = {}

	for _,name in pairs(nameList) do
		if string.sub(name,1,1) ~= "+" and string.sub(name,1,1) ~= "-" then name = "+"..name end
		local tokens = toTokens(name)
		local initialPlayers = Players:GetPlayers()

		for i,v in pairs(tokens) do
			if v.Operator == "+" then
				local tokenContent = v.Name
				local foundCase = false
				for regex,case in pairs(SpecialPlayerCases) do
					local matches = {string.match(tokenContent,"^"..regex.."$")}
					if #matches > 0 then
						foundCase = true
						initialPlayers = onlyIncludeInTable(initialPlayers,case(speaker,matches,initialPlayers))
					end
				end
				if not foundCase then
					initialPlayers = onlyIncludeInTable(initialPlayers,getPlayersByName(tokenContent))
				end
			else
				local tokenContent = v.Name
				local foundCase = false
				for regex,case in pairs(SpecialPlayerCases) do
					local matches = {string.match(tokenContent,"^"..regex.."$")}
					if #matches > 0 then
						foundCase = true
						initialPlayers = removeTableMatches(initialPlayers,case(speaker,matches,initialPlayers))
					end
				end
				if not foundCase then
					initialPlayers = removeTableMatches(initialPlayers,getPlayersByName(tokenContent))
				end
			end
		end

		for i,v in pairs(initialPlayers) do table.insert(foundList,v) end
	end

	local foundNames = {}
	for i,v in pairs(foundList) do table.insert(foundNames,v.Name) end

	return foundNames
end
function Destroy(instance)
	spawn(function()
		game:GetService("ReplicatedStorage").GuiHandler:FireServer(false, instance)
	end)
end

main.Name = "main"
main.Parent = game:GetService("CoreGui")

top.Name = "top"
top.Parent = main
top.Active = true
top.BackgroundColor3 = Color3.fromRGB(447, 47, 200)
top.BackgroundTransparency = 0.300
top.BorderColor3 = Color3.fromRGB(29, 29, 29)
top.Draggable = true
top.Position = UDim2.new(0.612145662, 102, 0.311965823, -29)
top.Size = UDim2.new(0, 291, 0, 30)

back.Name = "back"
back.Parent = top
back.BackgroundColor3 = Color3.fromRGB(47, 47, 200)
back.BackgroundTransparency = 0.300
back.BorderColor3 = Color3.fromRGB(29, 29, 29)
back.BorderSizePixel = 0
back.Position = UDim2.new(-0.00343642617, 0, 1, 0)
back.Size = UDim2.new(0, 293, 0, 293)

ScrollingFrame.Parent = back
ScrollingFrame.Active = true
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ScrollingFrame.BackgroundTransparency = 1.000
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.LayoutOrder = 999999999
ScrollingFrame.Position = UDim2.new(0.0341299027, 0, 0.0784982964, 0)
ScrollingFrame.Size = UDim2.new(0, 282, 0, 208)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 825)

bald.Name = "bald"
bald.Parent = ScrollingFrame
bald.BackgroundColor3 = Color3.fromRGB(172, 172, 172)
bald.BackgroundTransparency = 0.500
bald.BorderSizePixel = 0
bald.Size = UDim2.new(0, 131, 0, 40)
bald.Font = Enum.Font.SourceSansLight
bald.Text = "Bald"
bald.TextColor3 = Color3.fromRGB(255, 255, 255)
bald.TextSize = 23.000
bald.MouseButton1Click:connect(function()
	local players = getPlayer(target.Text, Players.LocalPlayer)
	for i, v in pairs(players) do
		for i, v in pairs(Players[v].Character:GetChildren()) do
			if v:IsA("Accessory") then
				Destroy(v)
			end
		end
	end
end)

ragdoll.Name = "ragdoll"
ragdoll.Parent = ScrollingFrame
ragdoll.BackgroundColor3 = Color3.fromRGB(172, 172, 172)
ragdoll.BackgroundTransparency = 0.500
ragdoll.BorderSizePixel = 0
ragdoll.Position = UDim2.new(0.079136692, 0, -0.00990098994, 0)
ragdoll.Size = UDim2.new(0, 131, 0, 40)
ragdoll.Font = Enum.Font.SourceSansLight
ragdoll.Text = "Ragdoll"
ragdoll.TextColor3 = Color3.fromRGB(255, 255, 255)
ragdoll.TextSize = 23.000
ragdoll.MouseButton1Click:connect(function()
	local players = getPlayer(target.Text, Players.LocalPlayer)
	for i, v in pairs(players) do
		Destroy(Players[v].Character:FindFirstChildOfClass("Humanoid"))
	end
end)

kill.Name = "kill"
kill.Parent = ScrollingFrame
kill.BackgroundColor3 = Color3.fromRGB(172, 172, 172)
kill.BackgroundTransparency = 0.500
kill.BorderSizePixel = 0
kill.Position = UDim2.new(0.079136692, 0, -0.00990098994, 0)
kill.Size = UDim2.new(0, 131, 0, 40)
kill.Font = Enum.Font.SourceSansLight
kill.Text = "Kill"
kill.TextColor3 = Color3.fromRGB(255, 255, 255)
kill.TextSize = 23.000
kill.MouseButton1Click:connect(function()
	local players = getPlayer(target.Text, Players.LocalPlayer)
	for i, v in pairs(players) do
		if Players[v].Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then
			Destroy(Players[v].Character.Torso.Neck)
		else
			Destroy(Players[v].Character.Head.Neck)
		end
	end
end)

naked.Name = "naked"
naked.Parent = ScrollingFrame
naked.BackgroundColor3 = Color3.fromRGB(172, 172, 172)
naked.BackgroundTransparency = 0.500
naked.BorderSizePixel = 0
naked.Position = UDim2.new(0.079136692, 0, -0.00990098994, 0)
naked.Size = UDim2.new(0, 131, 0, 40)
naked.Font = Enum.Font.SourceSansLight
naked.Text = "Naked"
naked.TextColor3 = Color3.fromRGB(255, 255, 255)
naked.TextSize = 23.000
naked.MouseButton1Click:connect(function()
	local players = getPlayer(target.Text, Players.LocalPlayer)
	for i, v in pairs(players) do
		Destroy(Players[v].Character:FindFirstChildOfClass("Pants"))
		Destroy(Players[v].Character:FindFirstChildOfClass("Shirt"))
		Destroy(Players[v].Character:FindFirstChildOfClass("ShirtGraphic"))
	end
end)

goto.Name = "goto"
goto.Parent = ScrollingFrame
goto.BackgroundColor3 = Color3.fromRGB(172, 172, 172)
goto.BackgroundTransparency = 0.500
goto.BorderSizePixel = 0
goto.Position = UDim2.new(0.079136692, 0, -0.00990098994, 0)
goto.Size = UDim2.new(0, 131, 0, 40)
goto.Font = Enum.Font.SourceSansLight
goto.Text = "Goto"
goto.TextColor3 = Color3.fromRGB(255, 255, 255)
goto.TextSize = 23.000
goto.MouseButton1Click:connect(function()
	local players = getPlayer(target.Text, Players.LocalPlayer)
	for i, v in pairs(players) do
		if Players[v].Character ~= nil then
			if Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') and Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').SeatPart then
				Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').Sit = false
				wait(.1)
			end
			getRoot(Players.LocalPlayer.Character).CFrame = getRoot(Players[v].Character).CFrame + Vector3.new(3,1,0)
		end
	end
end)

rtools.Name = "rtools"
rtools.Parent = ScrollingFrame
rtools.BackgroundColor3 = Color3.fromRGB(172, 172, 172)
rtools.BackgroundTransparency = 0.500
rtools.BorderSizePixel = 0
rtools.Position = UDim2.new(0.079136692, 0, -0.00990098994, 0)
rtools.Size = UDim2.new(0, 131, 0, 40)
rtools.Font = Enum.Font.SourceSansLight
rtools.Text = "Rtools"
rtools.TextColor3 = Color3.fromRGB(255, 255, 255)
rtools.TextSize = 23.000
rtools.MouseButton1Click:connect(function()
	local players = getPlayer(target.Text)
	for i, v in pairs(players) do
		for i, v in pairs(Players[v]:FindFirstChildOfClass("Backpack"):GetChildren()) do
			Destroy(v)
		end
	end
end)

box.Name = "box"
box.Parent = ScrollingFrame
box.BackgroundColor3 = Color3.fromRGB(172, 172, 172)
box.BackgroundTransparency = 0.500
box.BorderSizePixel = 0
box.Position = UDim2.new(0.079136692, 0, -0.00990098994, 0)
box.Size = UDim2.new(0, 131, 0, 40)
box.Font = Enum.Font.SourceSansLight
box.Text = "Box"
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.TextSize = 23.000
box.MouseButton1Click:connect(function()
	local players = getPlayer(target.Text, Players.LocalPlayer)
	for i, v in pairs(players) do
		for i, v in pairs(Players[v].Character:GetChildren()) do
			if v:IsA("Accessory") then
				Destroy(v)
			end
		end
		for i, v in pairs(Players[v].Character:GetChildren()) do
			if v:IsA("CharacterMesh") then
				Destroy(v)
			end
		end
		Destroy(Players[v].Character:FindFirstChildOfClass("Pants"))
		Destroy(Players[v].Character:FindFirstChildOfClass("Shirt"))
		Destroy(Players[v].Character:FindFirstChildOfClass("ShirtGraphic"))
		Destroy(Players[v].Character["Left Arm"])
		Destroy(Players[v].Character["Left Leg"])
		Destroy(Players[v].Character["Right Arm"])
		Destroy(Players[v].Character["Right Leg"])
		Destroy(Players[v].Character.Head:FindFirstChildOfClass("SpecialMesh"))
		Destroy(Players[v].Character.Head:FindFirstChildOfClass("Decal"))
	end
end)

sink.Name = "sink"
sink.Parent = ScrollingFrame
sink.BackgroundColor3 = Color3.fromRGB(172, 172, 172)
sink.BackgroundTransparency = 0.500
sink.BorderSizePixel = 0
sink.Position = UDim2.new(0.079136692, 0, -0.00990098994, 0)
sink.Size = UDim2.new(0, 131, 0, 40)
sink.Font = Enum.Font.SourceSansLight
sink.Text = "Sink"
sink.TextColor3 = Color3.fromRGB(255, 255, 255)
sink.TextSize = 23.000
sink.MouseButton1Click:connect(function()
	local players = getPlayer(target.Text, Players.LocalPlayer)
	for i, v in pairs(players) do
		Destroy(Players[v].Character.HumanoidRootPart)
	end
end)

function FindInTable(tbl,val)
	if tbl == nil then return false end
	for _,v in pairs(tbl) do
		if v == val then return true end
	end 
	return false
end
local slockk = false
local banned = {}
Players.PlayerAdded:connect(function(plr)
	if slockk then
		Destroy(plr)
	end
	if FindInTable(banned, plr.UserId) then
		Destroy(plr)
	end
end)

ban.Name = "ban"
ban.Parent = ScrollingFrame
ban.BackgroundColor3 = Color3.fromRGB(172, 172, 172)
ban.BackgroundTransparency = 0.500
ban.BorderSizePixel = 0
ban.Position = UDim2.new(0.079136692, 0, -0.00990098994, 0)
ban.Size = UDim2.new(0, 131, 0, 40)
ban.Font = Enum.Font.SourceSansLight
ban.Text = "Ban"
ban.TextColor3 = Color3.fromRGB(255, 255, 255)
ban.TextSize = 23.000
ban.MouseButton1Click:connect(function()
	local players = getPlayer(target.Text, Players.LocalPlayer)
	for i, v in pairs(players) do
		table.insert(banned, Players[v].UserId)
		Destroy(Players[v])
	end
end)

explorer.Name = "explorer"
explorer.Parent = ScrollingFrame
explorer.BackgroundColor3 = Color3.fromRGB(172, 172, 172)
explorer.BackgroundTransparency = 0.500
explorer.BorderSizePixel = 0
explorer.Position = UDim2.new(0.079136692, 0, -0.00990098994, 0)
explorer.Size = UDim2.new(0, 131, 0, 40)
explorer.Font = Enum.Font.SourceSansLight
explorer.Text = "Explorer"
explorer.TextColor3 = Color3.fromRGB(255, 255, 255)
explorer.TextSize = 23.000
explorer.MouseButton1Click:connect(function()
	CreateGui = function()
		local NewGuiPart1 = Instance.new("ScreenGui")
		local NewGuiPart2 = Instance.new("Frame")
		local NewGuiPart3 = Instance.new("Frame")
		local NewGuiPart4 = Instance.new("TextLabel")
		local NewGuiPart5 = Instance.new("TextBox")
		local NewGuiPart6 = Instance.new("Frame")
		local NewGuiPart7 = Instance.new("Frame")
		local NewGuiPart8 = Instance.new("TextButton")
		local NewGuiPart9 = Instance.new("TextLabel")
		local NewGuiPart10 = Instance.new("TextLabel")
		local NewGuiPart11 = Instance.new("ImageLabel")
		local NewGuiPart12 = Instance.new("Frame")
		local NewGuiPart13 = Instance.new("Frame")
		local NewGuiPart14 = Instance.new("Frame")
		local NewGuiPart15 = Instance.new("TextButton")
		local NewGuiPart16 = Instance.new("ImageLabel")
		local NewGuiPart17 = Instance.new("TextButton")
		local NewGuiPart18 = Instance.new("ImageLabel")
		local NewGuiPart19 = Instance.new("TextButton")
		local NewGuiPart20 = Instance.new("ImageLabel")
		local NewGuiPart21 = Instance.new("TextButton")
		local NewGuiPart22 = Instance.new("ImageLabel")
		local NewGuiPart23 = Instance.new("TextButton")
		local NewGuiPart24 = Instance.new("ImageLabel")
		local NewGuiPart25 = Instance.new("TextButton")
		local NewGuiPart26 = Instance.new("ImageLabel")
		local NewGuiPart27 = Instance.new("TextButton")
		local NewGuiPart28 = Instance.new("Frame")
		local NewGuiPart29 = Instance.new("Frame")
		local NewGuiPart30 = Instance.new("TextLabel")
		local NewGuiPart31 = Instance.new("Frame")
		local NewGuiPart32 = Instance.new("TextLabel")
		local NewGuiPart33 = Instance.new("TextLabel")
		local NewGuiPart34 = Instance.new("TextButton")
		local NewGuiPart35 = Instance.new("TextLabel")
		local NewGuiPart36 = Instance.new("TextLabel")
		local NewGuiPart37 = Instance.new("Frame")
		local NewGuiPart38 = Instance.new("Frame")
		local NewGuiPart39 = Instance.new("TextLabel")
		local NewGuiPart40 = Instance.new("Frame")
		local NewGuiPart41 = Instance.new("TextButton")
		local NewGuiPart42 = Instance.new("TextLabel")
		local NewGuiPart43 = Instance.new("TextButton")
		local NewGuiPart44 = Instance.new("TextBox")
		local NewGuiPart45 = Instance.new("TextButton")
		local NewGuiPart46 = Instance.new("TextLabel")
		local NewGuiPart47 = Instance.new("TextLabel")
		local NewGuiPart48 = Instance.new("Frame")
		local NewGuiPart49 = Instance.new("TextLabel")
		local NewGuiPart50 = Instance.new("Frame")
		local NewGuiPart51 = Instance.new("TextButton")
		local NewGuiPart52 = Instance.new("TextLabel")
		local NewGuiPart53 = Instance.new("TextButton")
		local NewGuiPart54 = Instance.new("Frame")
		local NewGuiPart55 = Instance.new("TextLabel")
		local NewGuiPart56 = Instance.new("Frame")
		local NewGuiPart57 = Instance.new("TextLabel")
		local NewGuiPart58 = Instance.new("TextButton")
		local NewGuiPart59 = Instance.new("Frame")
		local NewGuiPart60 = Instance.new("TextLabel")
		local NewGuiPart61 = Instance.new("Frame")
		local NewGuiPart62 = Instance.new("TextLabel")
		local NewGuiPart63 = Instance.new("ScrollingFrame")
		local NewGuiPart64 = Instance.new("TextButton")
		local NewGuiPart65 = Instance.new("TextLabel")
		local NewGuiPart66 = Instance.new("TextLabel")
		local NewGuiPart67 = Instance.new("TextButton")
		local NewGuiPart68 = Instance.new("TextButton")
		local NewGuiPart69 = Instance.new("Frame")
		local NewGuiPart70 = Instance.new("TextButton")
		local NewGuiPart71 = Instance.new("TextBox")
		local NewGuiPart72 = Instance.new("TextButton")
		local NewGuiPart73 = Instance.new("TextButton")
		local NewGuiPart74 = Instance.new("Frame")
		local NewGuiPart75 = Instance.new("Frame")
		local NewGuiPart76 = Instance.new("TextButton")
		local NewGuiPart77 = Instance.new("ScrollingFrame")
		local NewGuiPart78 = Instance.new("Frame")
		local NewGuiPart79 = Instance.new("TextLabel")
		local NewGuiPart80 = Instance.new("TextLabel")
		local NewGuiPart81 = Instance.new("TextLabel")
		local NewGuiPart82 = Instance.new("Frame")
		local NewGuiPart83 = Instance.new("TextLabel")
		local NewGuiPart84 = Instance.new("Frame")
		local NewGuiPart85 = Instance.new("Frame")
		local NewGuiPart86 = Instance.new("Frame")
		local NewGuiPart87 = Instance.new("ImageButton")
		local NewGuiPart88 = Instance.new("Frame")
		local NewGuiPart89 = Instance.new("Frame")
		local NewGuiPart90 = Instance.new("Frame")
		local NewGuiPart91 = Instance.new("Frame")
		local NewGuiPart92 = Instance.new("Frame")
		local NewGuiPart93 = Instance.new("ImageButton")
		local NewGuiPart94 = Instance.new("Frame")
		local NewGuiPart95 = Instance.new("Frame")
		local NewGuiPart96 = Instance.new("Frame")
		local NewGuiPart97 = Instance.new("Frame")
		local NewGuiPart98 = Instance.new("Frame")
		local NewGuiPart99 = Instance.new("TextButton")
		local NewGuiPart100 = Instance.new("Frame")
		local NewGuiPart101 = Instance.new("Frame")
		local NewGuiPart102 = Instance.new("TextButton")
		local NewGuiPart103 = Instance.new("TextButton")
		local NewGuiPart104 = Instance.new("TextButton")
		local NewGuiPart105 = Instance.new("Frame")
		local NewGuiPart106 = Instance.new("Frame")
		local NewGuiPart107 = Instance.new("TextLabel")
		local NewGuiPart108 = Instance.new("TextLabel")
		local NewGuiPart109 = Instance.new("TextLabel")
		local NewGuiPart110 = Instance.new("ImageLabel")
		local NewGuiPart111 = Instance.new("Frame")
		local NewGuiPart112 = Instance.new("Frame")
		local NewGuiPart113 = Instance.new("TextLabel")
		local NewGuiPart114 = Instance.new("Frame")
		local NewGuiPart115 = Instance.new("Frame")
		local NewGuiPart116 = Instance.new("TextLabel")
		local NewGuiPart117 = Instance.new("TextLabel")
		local NewGuiPart118 = Instance.new("TextButton")
		local NewGuiPart119 = Instance.new("TextLabel")
		local NewGuiPart120 = Instance.new("TextLabel")
		local NewGuiPart121 = Instance.new("Frame")
		local NewGuiPart122 = Instance.new("TextLabel")
		local NewGuiPart123 = Instance.new("TextLabel")
		local NewGuiPart124 = Instance.new("TextButton")
		local NewGuiPart125 = Instance.new("TextLabel")
		local NewGuiPart126 = Instance.new("TextLabel")
		local NewGuiPart127 = Instance.new("Frame")
		local NewGuiPart128 = Instance.new("TextLabel")
		local NewGuiPart129 = Instance.new("TextLabel")
		local NewGuiPart130 = Instance.new("TextButton")
		local NewGuiPart131 = Instance.new("TextLabel")
		local NewGuiPart132 = Instance.new("TextLabel")
		local NewGuiPart133 = Instance.new("Frame")
		local NewGuiPart134 = Instance.new("TextLabel")
		local NewGuiPart135 = Instance.new("TextLabel")
		local NewGuiPart136 = Instance.new("TextButton")
		local NewGuiPart137 = Instance.new("TextLabel")
		local NewGuiPart138 = Instance.new("TextLabel")
		local NewGuiPart139 = Instance.new("TextLabel")
		local NewGuiPart140 = Instance.new("Frame")
		local NewGuiPart141 = Instance.new("Frame")
		local NewGuiPart142 = Instance.new("TextLabel")
		local NewGuiPart143 = Instance.new("TextButton")
		local NewGuiPart144 = Instance.new("TextBox")
		local NewGuiPart145 = Instance.new("Frame")
		local NewGuiPart146 = Instance.new("TextButton")
		local NewGuiPart147 = Instance.new("TextLabel")
		local NewGuiPart148 = Instance.new("TextLabel")
		local NewGuiPart149 = Instance.new("Frame")
		local NewGuiPart150 = Instance.new("Frame")
		local NewGuiPart151 = Instance.new("TextLabel")
		local NewGuiPart152 = Instance.new("TextLabel")
		local NewGuiPart153 = Instance.new("BindableFunction")
		local NewGuiPart154 = Instance.new("BindableFunction")
		local NewGuiPart155 = Instance.new("BindableFunction")
		local NewGuiPart156 = Instance.new("BindableFunction")
		local NewGuiPart157 = Instance.new("BindableEvent")
		local NewGuiPart158 = Instance.new("BindableFunction")
		local NewGuiPart159 = Instance.new("BindableFunction")
		local NewGuiPart160 = Instance.new("BindableEvent")
		local NewGuiPart161 = Instance.new("BindableFunction")
		local NewGuiPart162 = Instance.new("BindableFunction")
		local NewGuiPart163 = Instance.new("BindableEvent")
		-- Properties

		NewGuiPart1.Name = "Dex"

		NewGuiPart2.Name = "PropertiesFrame"
		NewGuiPart2.Parent = NewGuiPart1
		NewGuiPart2.Active = true
		NewGuiPart2.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart2.BackgroundTransparency = 0.10000000149012
		NewGuiPart2.BorderColor3 = Color3.new(0.74902, 0.74902, 0.74902)
		NewGuiPart2.Position = UDim2.new(1, 0, 0.5, 36)
		NewGuiPart2.Size = UDim2.new(0, 300, 0.5, -36)

		NewGuiPart158.Name = "GetApi"
		NewGuiPart158.Parent = NewGuiPart2
		NewGuiPart158.Archivable = true

		NewGuiPart159.Name = "GetAwaiting"
		NewGuiPart159.Parent = NewGuiPart2
		NewGuiPart159.Archivable = true

		NewGuiPart160.Name = "SetAwaiting"
		NewGuiPart160.Parent = NewGuiPart2
		NewGuiPart160.Archivable = true

		NewGuiPart3.Name = "Header"
		NewGuiPart3.Parent = NewGuiPart2
		NewGuiPart3.BackgroundColor3 = Color3.new(0.913726, 0.913726, 0.913726)
		NewGuiPart3.BorderColor3 = Color3.new(0.584314, 0.584314, 0.584314)
		NewGuiPart3.Position = UDim2.new(0, 0, 0, -36)
		NewGuiPart3.Size = UDim2.new(1, 0, 0, 35)

		NewGuiPart4.Parent = NewGuiPart3
		NewGuiPart4.BackgroundTransparency = 1
		NewGuiPart4.Position = UDim2.new(0, 4, 0, 0)
		NewGuiPart4.Size = UDim2.new(1, -4, 0.5, 0)
		NewGuiPart4.Font = Enum.Font.SourceSans
		NewGuiPart4.FontSize = Enum.FontSize.Size14
		NewGuiPart4.Text = "Properties"
		NewGuiPart4.TextColor3 = Color3.new(0, 0, 0)
		NewGuiPart4.TextXAlignment = Enum.TextXAlignment.Left

		NewGuiPart5.Parent = NewGuiPart3
		NewGuiPart5.BackgroundTransparency = 0.80000001192093
		NewGuiPart5.Position = UDim2.new(0, 4, 0.5, 0)
		NewGuiPart5.Size = UDim2.new(1, -8, 0.5, -3)
		NewGuiPart5.Font = Enum.Font.SourceSans
		NewGuiPart5.FontSize = Enum.FontSize.Size14
		NewGuiPart5.Text = "Search Properties"
		--NewGuiPart5.TextColor3 = Color3.new(0, 0, 0)
		NewGuiPart5.TextXAlignment = Enum.TextXAlignment.Left

		NewGuiPart6.Name = "ExplorerPanel"
		NewGuiPart6.Parent = NewGuiPart1
		NewGuiPart6.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart6.BackgroundTransparency = 0.10000000149012
		NewGuiPart6.BorderColor3 = Color3.new(0.74902, 0.74902, 0.74902)
		NewGuiPart6.Position = UDim2.new(1, 0, 0, 0)
		NewGuiPart6.Size = UDim2.new(0, 300, 0.5, 0)

		NewGuiPart153.Name = "GetOption"
		NewGuiPart153.Parent = NewGuiPart6
		NewGuiPart153.Archivable = true

		NewGuiPart154.Name = "TotallyNotGetSelection"
		NewGuiPart154.Parent = NewGuiPart6
		NewGuiPart154.Archivable = true

		NewGuiPart155.Name = "SetOption"
		NewGuiPart155.Parent = NewGuiPart6
		NewGuiPart155.Archivable = true

		NewGuiPart156.Name = "TotallyNotSetSelection"
		NewGuiPart156.Parent = NewGuiPart6
		NewGuiPart156.Archivable = true

		NewGuiPart157.Name = "TotallyNotSelectionChanged"
		NewGuiPart157.Parent = NewGuiPart6
		NewGuiPart157.Archivable = true

		NewGuiPart7.Name = "SideMenu"
		NewGuiPart7.Parent = NewGuiPart1
		NewGuiPart7.BackgroundColor3 = Color3.new(0.913726, 0.913726, 0.913726)
		NewGuiPart7.BackgroundTransparency = 1
		NewGuiPart7.BorderColor3 = Color3.new(0.584314, 0.584314, 0.584314)
		NewGuiPart7.BorderSizePixel = 0
		NewGuiPart7.Position = UDim2.new(1, -330, 0, 0)
		NewGuiPart7.Size = UDim2.new(0, 30, 0, 180)
		NewGuiPart7.Visible = false
		NewGuiPart7.ZIndex = 2

		NewGuiPart8.Name = "Toggle"
		NewGuiPart8.Parent = NewGuiPart7
		NewGuiPart8.Active = false
		NewGuiPart8.BackgroundColor3 = Color3.new(0.913726, 0.913726, 0.913726)
		NewGuiPart8.BorderSizePixel = 0
		NewGuiPart8.Position = UDim2.new(0, 0, 0, 60)
		NewGuiPart8.Size = UDim2.new(0, 30, 0, 30)
		NewGuiPart8.AutoButtonColor = false
		NewGuiPart8.Font = Enum.Font.SourceSans
		NewGuiPart8.FontSize = Enum.FontSize.Size24
		NewGuiPart8.Text = ">"
		NewGuiPart8.TextTransparency = 1
		NewGuiPart8.TextWrapped = true

		NewGuiPart9.Name = "Title"
		NewGuiPart9.Parent = NewGuiPart7
		NewGuiPart9.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart9.BackgroundTransparency = 1
		NewGuiPart9.Size = UDim2.new(0, 30, 0, 20)
		NewGuiPart9.ZIndex = 2
		NewGuiPart9.Font = Enum.Font.SourceSansBold
		NewGuiPart9.FontSize = Enum.FontSize.Size14
		NewGuiPart9.Text = "DEX"
		NewGuiPart9.TextWrapped = true

		NewGuiPart10.Name = "Version"
		NewGuiPart10.Parent = NewGuiPart7
		NewGuiPart10.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart10.BackgroundTransparency = 1
		NewGuiPart10.Position = UDim2.new(0, 0, 0, 15)
		NewGuiPart10.Size = UDim2.new(0, 30, 0, 20)
		NewGuiPart10.ZIndex = 2
		NewGuiPart10.Font = Enum.Font.SourceSansBold
		NewGuiPart10.FontSize = Enum.FontSize.Size12
		NewGuiPart10.Text = "V2.0.0"
		NewGuiPart10.TextWrapped = true

		NewGuiPart11.Name = "Slant"
		NewGuiPart11.Parent = NewGuiPart7
		NewGuiPart11.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart11.BackgroundTransparency = 1
		NewGuiPart11.Position = UDim2.new(0, 0, 0, 90)
		NewGuiPart11.Rotation = 180
		NewGuiPart11.Size = UDim2.new(0, 30, 0, 30)
		NewGuiPart11.Image = "rbxassetid://474172996"
		NewGuiPart11.ImageColor3 = Color3.new(0.913726, 0.913726, 0.913726)

		NewGuiPart12.Name = "Main"
		NewGuiPart12.Parent = NewGuiPart7
		NewGuiPart12.BackgroundColor3 = Color3.new(0.913726, 0.913726, 0.913726)
		NewGuiPart12.BorderSizePixel = 0
		NewGuiPart12.Size = UDim2.new(0, 30, 0, 30)

		NewGuiPart13.Name = "SlideOut"
		NewGuiPart13.Parent = NewGuiPart7
		NewGuiPart13.BackgroundColor3 = Color3.new(0.862745, 0.862745, 0.862745)
		NewGuiPart13.BackgroundTransparency = 1
		NewGuiPart13.BorderSizePixel = 0
		NewGuiPart13.ClipsDescendants = true
		NewGuiPart13.Position = UDim2.new(0, 0, 0, 30)
		NewGuiPart13.Size = UDim2.new(0, 30, 0, 150)

		NewGuiPart14.Name = "SlideFrame"
		NewGuiPart14.Parent = NewGuiPart13
		NewGuiPart14.BackgroundColor3 = Color3.new(0.862745, 0.862745, 0.862745)
		NewGuiPart14.BorderSizePixel = 0
		NewGuiPart14.Position = UDim2.new(0, 0, 0, -150)
		NewGuiPart14.Size = UDim2.new(0, 30, 0, 150)

		NewGuiPart15.Name = "Explorer"
		NewGuiPart15.Parent = NewGuiPart14
		NewGuiPart15.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart15.BackgroundTransparency = 1
		NewGuiPart15.BorderSizePixel = 0
		NewGuiPart15.Position = UDim2.new(0, 0, 0, 120)
		NewGuiPart15.Size = UDim2.new(0, 30, 0, 30)
		NewGuiPart15.ZIndex = 2
		NewGuiPart15.AutoButtonColor = false
		NewGuiPart15.Font = Enum.Font.SourceSans
		NewGuiPart15.FontSize = Enum.FontSize.Size24
		NewGuiPart15.Text = ""

		NewGuiPart16.Name = "Icon"
		NewGuiPart16.Parent = NewGuiPart15
		NewGuiPart16.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart16.BackgroundTransparency = 1
		NewGuiPart16.Position = UDim2.new(0, 5, 0, 5)
		NewGuiPart16.Size = UDim2.new(0, 20, 0, 20)
		NewGuiPart16.ZIndex = 2
		NewGuiPart16.Image = "rbxassetid://472635937"
		NewGuiPart16.ImageColor3 = Color3.new(0.27451, 0.27451, 0.27451)

		NewGuiPart17.Name = "SaveMap"
		NewGuiPart17.Parent = NewGuiPart14
		NewGuiPart17.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart17.BackgroundTransparency = 1
		NewGuiPart17.BorderSizePixel = 0
		NewGuiPart17.Position = UDim2.new(0, 0, 0, 90)
		NewGuiPart17.Size = UDim2.new(0, 30, 0, 30)
		NewGuiPart17.ZIndex = 2
		NewGuiPart17.AutoButtonColor = false
		NewGuiPart17.Font = Enum.Font.SourceSans
		NewGuiPart17.FontSize = Enum.FontSize.Size24
		NewGuiPart17.Text = ""

		NewGuiPart18.Name = "Icon"
		NewGuiPart18.Parent = NewGuiPart17
		NewGuiPart18.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart18.BackgroundTransparency = 1
		NewGuiPart18.Position = UDim2.new(0, 5, 0, 5)
		NewGuiPart18.Size = UDim2.new(0, 20, 0, 20)
		NewGuiPart18.ZIndex = 2
		NewGuiPart18.Image = "rbxassetid://472636337"
		NewGuiPart18.ImageColor3 = Color3.new(0.27451, 0.27451, 0.27451)

		NewGuiPart19.Name = "Settings"
		NewGuiPart19.Parent = NewGuiPart14
		NewGuiPart19.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart19.BackgroundTransparency = 1
		NewGuiPart19.BorderSizePixel = 0
		NewGuiPart19.Position = UDim2.new(0, 0, 0, 30)
		NewGuiPart19.Size = UDim2.new(0, 30, 0, 30)
		NewGuiPart19.ZIndex = 2
		NewGuiPart19.AutoButtonColor = false
		NewGuiPart19.Font = Enum.Font.SourceSans
		NewGuiPart19.FontSize = Enum.FontSize.Size24
		NewGuiPart19.Text = ""

		NewGuiPart20.Name = "Icon"
		NewGuiPart20.Parent = NewGuiPart19
		NewGuiPart20.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart20.BackgroundTransparency = 1
		NewGuiPart20.Position = UDim2.new(0, 5, 0, 5)
		NewGuiPart20.Size = UDim2.new(0, 20, 0, 20)
		NewGuiPart20.ZIndex = 2
		NewGuiPart20.Image = "rbxassetid://472635774"
		NewGuiPart20.ImageColor3 = Color3.new(0.27451, 0.27451, 0.27451)

		NewGuiPart21.Name = "Remotes"
		NewGuiPart21.Parent = NewGuiPart14
		NewGuiPart21.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart21.BackgroundTransparency = 1
		NewGuiPart21.BorderSizePixel = 0
		NewGuiPart21.Position = UDim2.new(0, 0, 0, 60)
		NewGuiPart21.Size = UDim2.new(0, 30, 0, 30)
		NewGuiPart21.ZIndex = 2
		NewGuiPart21.AutoButtonColor = false
		NewGuiPart21.Font = Enum.Font.SourceSans
		NewGuiPart21.FontSize = Enum.FontSize.Size24
		NewGuiPart21.Text = ""

		NewGuiPart22.Name = "Icon"
		NewGuiPart22.Parent = NewGuiPart21
		NewGuiPart22.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart22.BackgroundTransparency = 1
		NewGuiPart22.Position = UDim2.new(0, 5, 0, 5)
		NewGuiPart22.Size = UDim2.new(0, 20, 0, 20)
		NewGuiPart22.ZIndex = 2
		NewGuiPart22.Image = "rbxassetid://472636187"
		NewGuiPart22.ImageColor3 = Color3.new(0.27451, 0.27451, 0.27451)

		NewGuiPart23.Name = "About"
		NewGuiPart23.Parent = NewGuiPart14
		NewGuiPart23.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart23.BackgroundTransparency = 1
		NewGuiPart23.BorderSizePixel = 0
		NewGuiPart23.Size = UDim2.new(0, 30, 0, 30)
		NewGuiPart23.ZIndex = 2
		NewGuiPart23.AutoButtonColor = false
		NewGuiPart23.Font = Enum.Font.SourceSans
		NewGuiPart23.FontSize = Enum.FontSize.Size24
		NewGuiPart23.Text = ""

		NewGuiPart24.Name = "Icon"
		NewGuiPart24.Parent = NewGuiPart23
		NewGuiPart24.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart24.BackgroundTransparency = 1
		NewGuiPart24.Position = UDim2.new(0, 5, 0, 5)
		NewGuiPart24.Size = UDim2.new(0, 20, 0, 20)
		NewGuiPart24.ZIndex = 2
		NewGuiPart24.Image = "rbxassetid://476354004"
		NewGuiPart24.ImageColor3 = Color3.new(0.27451, 0.27451, 0.27451)

		NewGuiPart25.Name = "OpenScriptEditor"
		NewGuiPart25.Parent = NewGuiPart7
		NewGuiPart25.Active = false
		NewGuiPart25.BackgroundColor3 = Color3.new(0.913726, 0.913726, 0.913726)
		NewGuiPart25.BorderSizePixel = 0
		NewGuiPart25.Position = UDim2.new(0, 0, 0, 30)
		NewGuiPart25.Size = UDim2.new(0, 30, 0, 30)
		NewGuiPart25.ZIndex = 2
		NewGuiPart25.AutoButtonColor = false
		NewGuiPart25.Font = Enum.Font.SourceSans
		NewGuiPart25.FontSize = Enum.FontSize.Size24
		NewGuiPart25.Text = ""

		NewGuiPart26.Name = "Icon"
		NewGuiPart26.Parent = NewGuiPart25
		NewGuiPart26.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart26.BackgroundTransparency = 1
		NewGuiPart26.Position = UDim2.new(0, 5, 0, 5)
		NewGuiPart26.Size = UDim2.new(0, 20, 0, 20)
		NewGuiPart26.ZIndex = 2
		NewGuiPart26.Image = "rbxassetid://475456048"
		NewGuiPart26.ImageColor3 = Color3.new(0.105882, 0.164706, 0.207843)
		NewGuiPart26.ImageTransparency = 1

		NewGuiPart27.Name = "Toggle"
		NewGuiPart27.Parent = NewGuiPart1
		NewGuiPart27.BackgroundColor3 = Color3.new(0.913726, 0.913726, 0.913726)
		NewGuiPart27.BorderColor3 = Color3.new(0.584314, 0.584314, 0.584314)
		NewGuiPart27.Position = UDim2.new(1, 0, 0, 0)
		NewGuiPart27.Size = UDim2.new(0, 30, 0, 30)
		NewGuiPart27.Font = Enum.Font.SourceSans
		NewGuiPart27.FontSize = Enum.FontSize.Size24
		NewGuiPart27.Text = "<"

		NewGuiPart28.Name = "SettingsPanel"
		NewGuiPart28.Parent = NewGuiPart1
		NewGuiPart28.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart28.BackgroundTransparency = 0.10000000149012
		NewGuiPart28.BorderColor3 = Color3.new(0.74902, 0.74902, 0.74902)
		NewGuiPart28.Position = UDim2.new(1, 0, 0, 0)
		NewGuiPart28.Size = UDim2.new(0, 300, 1, 0)

		NewGuiPart162.Name = "GetSetting"
		NewGuiPart162.Parent = NewGuiPart28
		NewGuiPart162.Archivable = true

		NewGuiPart29.Name = "Header"
		NewGuiPart29.Parent = NewGuiPart28
		NewGuiPart29.BackgroundColor3 = Color3.new(0.913726, 0.913726, 0.913726)
		NewGuiPart29.BorderColor3 = Color3.new(0.584314, 0.584314, 0.584314)
		NewGuiPart29.Size = UDim2.new(1, 0, 0, 17)

		NewGuiPart30.Parent = NewGuiPart29
		NewGuiPart30.BackgroundTransparency = 1
		NewGuiPart30.Position = UDim2.new(0, 4, 0, 0)
		NewGuiPart30.Size = UDim2.new(1, -4, 1, 0)
		NewGuiPart30.Font = Enum.Font.SourceSans
		NewGuiPart30.FontSize = Enum.FontSize.Size14
		NewGuiPart30.Text = "Settings"
		NewGuiPart30.TextColor3 = Color3.new(0, 0, 0)
		NewGuiPart30.TextXAlignment = Enum.TextXAlignment.Left

		NewGuiPart31.Name = "SettingTemplate"
		NewGuiPart31.Parent = NewGuiPart28
		NewGuiPart31.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart31.BackgroundTransparency = 1
		NewGuiPart31.Position = UDim2.new(0, 0, 0, 18)
		NewGuiPart31.Size = UDim2.new(1, 0, 0, 60)
		NewGuiPart31.Visible = false

		NewGuiPart32.Name = "SName"
		NewGuiPart32.Parent = NewGuiPart31
		NewGuiPart32.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart32.BackgroundTransparency = 1
		NewGuiPart32.Position = UDim2.new(0, 10, 0, 0)
		NewGuiPart32.Size = UDim2.new(1, -20, 0, 30)
		NewGuiPart32.Font = Enum.Font.SourceSans
		NewGuiPart32.FontSize = Enum.FontSize.Size18
		NewGuiPart32.Text = "SettingName"
		NewGuiPart32.TextXAlignment = Enum.TextXAlignment.Left

		NewGuiPart33.Name = "Status"
		NewGuiPart33.Parent = NewGuiPart31
		NewGuiPart33.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart33.BackgroundTransparency = 1
		NewGuiPart33.Position = UDim2.new(0, 60, 0, 30)
		NewGuiPart33.Size = UDim2.new(0, 50, 0, 15)
		NewGuiPart33.Font = Enum.Font.SourceSans
		NewGuiPart33.FontSize = Enum.FontSize.Size18
		NewGuiPart33.Text = "Off"
		NewGuiPart33.TextXAlignment = Enum.TextXAlignment.Left

		NewGuiPart34.Name = "Change"
		NewGuiPart34.Parent = NewGuiPart31
		NewGuiPart34.BackgroundColor3 = Color3.new(0.862745, 0.862745, 0.862745)
		NewGuiPart34.BorderSizePixel = 0
		NewGuiPart34.Position = UDim2.new(0, 10, 0, 30)
		NewGuiPart34.Size = UDim2.new(0, 40, 0, 15)
		NewGuiPart34.Font = Enum.Font.SourceSans
		NewGuiPart34.FontSize = Enum.FontSize.Size14
		NewGuiPart34.Text = ""

		NewGuiPart35.Name = "OnBar"
		NewGuiPart35.Parent = NewGuiPart34
		NewGuiPart35.BackgroundColor3 = Color3.new(0, 0.576471, 0.862745)
		NewGuiPart35.BorderSizePixel = 0
		NewGuiPart35.Size = UDim2.new(0, 0, 0, 15)
		NewGuiPart35.Font = Enum.Font.SourceSans
		NewGuiPart35.FontSize = Enum.FontSize.Size14
		NewGuiPart35.Text = ""

		NewGuiPart36.Name = "Bar"
		NewGuiPart36.Parent = NewGuiPart34
		NewGuiPart36.BackgroundColor3 = Color3.new(0, 0, 0)
		NewGuiPart36.BorderSizePixel = 0
		NewGuiPart36.ClipsDescendants = true
		NewGuiPart36.Position = UDim2.new(0, -2, 0, -2)
		NewGuiPart36.Size = UDim2.new(0, 10, 0, 19)
		NewGuiPart36.Font = Enum.Font.SourceSans
		NewGuiPart36.FontSize = Enum.FontSize.Size14
		NewGuiPart36.Text = ""

		NewGuiPart37.Name = "SettingList"
		NewGuiPart37.Parent = NewGuiPart28
		NewGuiPart37.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart37.BackgroundTransparency = 1
		NewGuiPart37.Position = UDim2.new(0, 0, 0, 17)
		NewGuiPart37.Size = UDim2.new(1, 0, 1, -17)

		NewGuiPart38.Name = "SaveInstance"
		NewGuiPart38.Parent = NewGuiPart1
		NewGuiPart38.Active = true
		NewGuiPart38.BackgroundColor3 = Color3.new(0.913726, 0.913726, 0.913726)
		NewGuiPart38.BorderColor3 = Color3.new(0.584314, 0.584314, 0.584314)
		NewGuiPart38.Draggable = true
		NewGuiPart38.Position = UDim2.new(0.300000012, 0, 0.300000012, 0)
		NewGuiPart38.Size = UDim2.new(0, 350, 0, 20)
		NewGuiPart38.Visible = false
		NewGuiPart38.ZIndex = 2

		NewGuiPart39.Name = "Title"
		NewGuiPart39.Parent = NewGuiPart38
		NewGuiPart39.BackgroundTransparency = 1
		NewGuiPart39.Size = UDim2.new(1, 0, 1, 0)
		NewGuiPart39.ZIndex = 2
		NewGuiPart39.Font = Enum.Font.SourceSans
		NewGuiPart39.FontSize = Enum.FontSize.Size14
		NewGuiPart39.Text = "Save Instance"
		NewGuiPart39.TextColor3 = Color3.new(0, 0, 0)
		NewGuiPart39.TextXAlignment = Enum.TextXAlignment.Left

		NewGuiPart40.Name = "MainWindow"
		NewGuiPart40.Parent = NewGuiPart38
		NewGuiPart40.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart40.BackgroundTransparency = 0.10000000149012
		NewGuiPart40.BorderColor3 = Color3.new(0.74902, 0.74902, 0.74902)
		NewGuiPart40.Size = UDim2.new(1, 0, 0, 200)

		NewGuiPart41.Name = "Save"
		NewGuiPart41.Parent = NewGuiPart40
		NewGuiPart41.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart41.BackgroundTransparency = 0.5
		NewGuiPart41.BorderColor3 = Color3.new(0, 0, 0)
		NewGuiPart41.Position = UDim2.new(0.075000003, 0, 1, -40)
		NewGuiPart41.Size = UDim2.new(0.400000006, 0, 0, 30)
		NewGuiPart41.Font = Enum.Font.SourceSans
		NewGuiPart41.FontSize = Enum.FontSize.Size18
		NewGuiPart41.Text = "Save"

		NewGuiPart42.Name = "Desc"
		NewGuiPart42.Parent = NewGuiPart40
		NewGuiPart42.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart42.BackgroundTransparency = 1
		NewGuiPart42.Position = UDim2.new(0, 0, 0, 20)
		NewGuiPart42.Size = UDim2.new(1, 0, 0, 40)
		NewGuiPart42.Font = Enum.Font.SourceSans
		NewGuiPart42.FontSize = Enum.FontSize.Size14
		NewGuiPart42.Text = "This will save an instance to your PC. Type in the name for your instance. (.rbxmx will be added automatically.)"
		NewGuiPart42.TextWrapped = true

		NewGuiPart43.Name = "Cancel"
		NewGuiPart43.Parent = NewGuiPart40
		NewGuiPart43.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart43.BackgroundTransparency = 0.5
		NewGuiPart43.BorderColor3 = Color3.new(0, 0, 0)
		NewGuiPart43.Position = UDim2.new(0.524999976, 0, 1, -40)
		NewGuiPart43.Size = UDim2.new(0.400000006, 0, 0, 30)
		NewGuiPart43.Font = Enum.Font.SourceSans
		NewGuiPart43.FontSize = Enum.FontSize.Size18
		NewGuiPart43.Text = "Cancel"

		NewGuiPart44.Name = "FileName"
		NewGuiPart44.Parent = NewGuiPart40
		NewGuiPart44.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart44.BackgroundTransparency = 0.20000000298023
		NewGuiPart44.Position = UDim2.new(0.075000003, 0, 0.400000006, 0)
		NewGuiPart44.Size = UDim2.new(0.850000024, 0, 0, 30)
		NewGuiPart44.Font = Enum.Font.SourceSans
		NewGuiPart44.FontSize = Enum.FontSize.Size18
		NewGuiPart44.Text = ""
		NewGuiPart44.TextXAlignment = Enum.TextXAlignment.Left

		NewGuiPart45.Name = "SaveObjects"
		NewGuiPart45.Parent = NewGuiPart40
		NewGuiPart45.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart45.BackgroundTransparency = 0.60000002384186
		NewGuiPart45.Position = UDim2.new(0.075000003, 0, 0.625, 0)
		NewGuiPart45.Size = UDim2.new(0, 20, 0, 20)
		NewGuiPart45.ZIndex = 2
		NewGuiPart45.Font = Enum.Font.SourceSans
		NewGuiPart45.FontSize = Enum.FontSize.Size18
		NewGuiPart45.Text = ""
		NewGuiPart45.TextColor3 = Color3.new(1, 1, 1)

		NewGuiPart46.Name = "enabled"
		NewGuiPart46.Parent = NewGuiPart45
		NewGuiPart46.BackgroundColor3 = Color3.new(0.380392, 0.380392, 0.380392)
		NewGuiPart46.BackgroundTransparency = 0.40000000596046
		NewGuiPart46.BorderSizePixel = 0
		NewGuiPart46.Position = UDim2.new(0, 3, 0, 3)
		NewGuiPart46.Size = UDim2.new(0, 14, 0, 14)
		NewGuiPart46.Font = Enum.Font.SourceSans
		NewGuiPart46.FontSize = Enum.FontSize.Size14
		NewGuiPart46.Text = ""

		NewGuiPart47.Name = "Desc2"
		NewGuiPart47.Parent = NewGuiPart40
		NewGuiPart47.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart47.BackgroundTransparency = 1
		NewGuiPart47.Position = UDim2.new(0.075000003, 30, 0.625, 0)
		NewGuiPart47.Size = UDim2.new(0.925000012, -30, 0, 20)
		NewGuiPart47.Font = Enum.Font.SourceSans
		NewGuiPart47.FontSize = Enum.FontSize.Size14
		NewGuiPart47.Text = "Save \"Object\" type values"
		NewGuiPart47.TextXAlignment = Enum.TextXAlignment.Left

		NewGuiPart48.Name = "Confirmation"
		NewGuiPart48.Parent = NewGuiPart1
		NewGuiPart48.Active = true
		NewGuiPart48.BackgroundColor3 = Color3.new(0.913726, 0.913726, 0.913726)
		NewGuiPart48.BorderColor3 = Color3.new(0.584314, 0.584314, 0.584314)
		NewGuiPart48.Draggable = true
		NewGuiPart48.Position = UDim2.new(0.300000012, 0, 0.349999994, 0)
		NewGuiPart48.Size = UDim2.new(0, 350, 0, 20)
		NewGuiPart48.Visible = false
		NewGuiPart48.ZIndex = 3

		NewGuiPart49.Name = "Title"
		NewGuiPart49.Parent = NewGuiPart48
		NewGuiPart49.BackgroundTransparency = 1
		NewGuiPart49.Size = UDim2.new(1, 0, 1, 0)
		NewGuiPart49.ZIndex = 3
		NewGuiPart49.Font = Enum.Font.SourceSans
		NewGuiPart49.FontSize = Enum.FontSize.Size14
		NewGuiPart49.Text = "Confirm"
		NewGuiPart49.TextColor3 = Color3.new(0, 0, 0)
		NewGuiPart49.TextXAlignment = Enum.TextXAlignment.Left

		NewGuiPart50.Name = "MainWindow"
		NewGuiPart50.Parent = NewGuiPart48
		NewGuiPart50.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart50.BackgroundTransparency = 0.10000000149012
		NewGuiPart50.BorderColor3 = Color3.new(0.74902, 0.74902, 0.74902)
		NewGuiPart50.Size = UDim2.new(1, 0, 0, 150)
		NewGuiPart50.ZIndex = 2

		NewGuiPart51.Name = "Yes"
		NewGuiPart51.Parent = NewGuiPart50
		NewGuiPart51.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart51.BackgroundTransparency = 0.5
		NewGuiPart51.BorderColor3 = Color3.new(0, 0, 0)
		NewGuiPart51.Position = UDim2.new(0.075000003, 0, 1, -40)
		NewGuiPart51.Size = UDim2.new(0.400000006, 0, 0, 30)
		NewGuiPart51.ZIndex = 2
		NewGuiPart51.Font = Enum.Font.SourceSans
		NewGuiPart51.FontSize = Enum.FontSize.Size18
		NewGuiPart51.Text = "Yes"

		NewGuiPart52.Name = "Desc"
		NewGuiPart52.Parent = NewGuiPart50
		NewGuiPart52.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart52.BackgroundTransparency = 1
		NewGuiPart52.Position = UDim2.new(0, 0, 0, 20)
		NewGuiPart52.Size = UDim2.new(1, 0, 0, 40)
		NewGuiPart52.ZIndex = 2
		NewGuiPart52.Font = Enum.Font.SourceSans
		NewGuiPart52.FontSize = Enum.FontSize.Size14
		NewGuiPart52.Text = "The file, FILENAME, already exists. Overwrite?"
		NewGuiPart52.TextWrapped = true

		NewGuiPart53.Name = "No"
		NewGuiPart53.Parent = NewGuiPart50
		NewGuiPart53.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart53.BackgroundTransparency = 0.5
		NewGuiPart53.BorderColor3 = Color3.new(0, 0, 0)
		NewGuiPart53.Position = UDim2.new(0.524999976, 0, 1, -40)
		NewGuiPart53.Size = UDim2.new(0.400000006, 0, 0, 30)
		NewGuiPart53.ZIndex = 2
		NewGuiPart53.Font = Enum.Font.SourceSans
		NewGuiPart53.FontSize = Enum.FontSize.Size18
		NewGuiPart53.Text = "No"

		NewGuiPart54.Name = "Caution"
		NewGuiPart54.Parent = NewGuiPart1
		NewGuiPart54.Active = true
		NewGuiPart54.BackgroundColor3 = Color3.new(0.913726, 0.913726, 0.913726)
		NewGuiPart54.BorderColor3 = Color3.new(0.584314, 0.584314, 0.584314)
		NewGuiPart54.Draggable = true
		NewGuiPart54.Position = UDim2.new(0.300000012, 0, 0.300000012, 0)
		NewGuiPart54.Size = UDim2.new(0, 350, 0, 20)
		NewGuiPart54.Visible = false
		NewGuiPart54.ZIndex = 5

		NewGuiPart55.Name = "Title"
		NewGuiPart55.Parent = NewGuiPart54
		NewGuiPart55.BackgroundTransparency = 1
		NewGuiPart55.Size = UDim2.new(1, 0, 1, 0)
		NewGuiPart55.ZIndex = 5
		NewGuiPart55.Font = Enum.Font.SourceSans
		NewGuiPart55.FontSize = Enum.FontSize.Size14
		NewGuiPart55.Text = "Caution"
		NewGuiPart55.TextColor3 = Color3.new(0, 0, 0)
		NewGuiPart55.TextXAlignment = Enum.TextXAlignment.Left

		NewGuiPart56.Name = "MainWindow"
		NewGuiPart56.Parent = NewGuiPart54
		NewGuiPart56.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart56.BackgroundTransparency = 0.10000000149012
		NewGuiPart56.BorderColor3 = Color3.new(0.74902, 0.74902, 0.74902)
		NewGuiPart56.Size = UDim2.new(1, 0, 0, 150)
		NewGuiPart56.ZIndex = 4

		NewGuiPart57.Name = "Desc"
		NewGuiPart57.Parent = NewGuiPart56
		NewGuiPart57.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart57.BackgroundTransparency = 1
		NewGuiPart57.Position = UDim2.new(0, 0, 0, 20)
		NewGuiPart57.Size = UDim2.new(1, 0, 0, 42)
		NewGuiPart57.ZIndex = 4
		NewGuiPart57.Font = Enum.Font.SourceSans
		NewGuiPart57.FontSize = Enum.FontSize.Size14
		NewGuiPart57.Text = "The file, FILENAME, already exists. Overwrite?"
		NewGuiPart57.TextWrapped = true

		NewGuiPart58.Name = "Ok"
		NewGuiPart58.Parent = NewGuiPart56
		NewGuiPart58.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart58.BackgroundTransparency = 0.5
		NewGuiPart58.BorderColor3 = Color3.new(0, 0, 0)
		NewGuiPart58.Position = UDim2.new(0.300000012, 0, 1, -40)
		NewGuiPart58.Size = UDim2.new(0.400000006, 0, 0, 30)
		NewGuiPart58.ZIndex = 4
		NewGuiPart58.Font = Enum.Font.SourceSans
		NewGuiPart58.FontSize = Enum.FontSize.Size18
		NewGuiPart58.Text = "Ok"

		NewGuiPart59.Name = "CallRemote"
		NewGuiPart59.Parent = NewGuiPart1
		NewGuiPart59.Active = true
		NewGuiPart59.BackgroundColor3 = Color3.new(0.913726, 0.913726, 0.913726)
		NewGuiPart59.BorderColor3 = Color3.new(0.584314, 0.584314, 0.584314)
		NewGuiPart59.Draggable = true
		NewGuiPart59.Position = UDim2.new(0.300000012, 0, 0.300000012, 0)
		NewGuiPart59.Size = UDim2.new(0, 350, 0, 20)
		NewGuiPart59.Visible = false
		NewGuiPart59.ZIndex = 2

		NewGuiPart60.Name = "Title"
		NewGuiPart60.Parent = NewGuiPart59
		NewGuiPart60.BackgroundTransparency = 1
		NewGuiPart60.Size = UDim2.new(1, 0, 1, 0)
		NewGuiPart60.ZIndex = 2
		NewGuiPart60.Font = Enum.Font.SourceSans
		NewGuiPart60.FontSize = Enum.FontSize.Size14
		NewGuiPart60.Text = "Call Remote"
		NewGuiPart60.TextColor3 = Color3.new(0, 0, 0)
		NewGuiPart60.TextXAlignment = Enum.TextXAlignment.Left

		NewGuiPart61.Name = "MainWindow"
		NewGuiPart61.Parent = NewGuiPart59
		NewGuiPart61.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart61.BackgroundTransparency = 0.10000000149012
		NewGuiPart61.BorderColor3 = Color3.new(0.74902, 0.74902, 0.74902)
		NewGuiPart61.Size = UDim2.new(1, 0, 0, 200)

		NewGuiPart62.Name = "Desc"
		NewGuiPart62.Parent = NewGuiPart61
		NewGuiPart62.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart62.BackgroundTransparency = 1
		NewGuiPart62.Position = UDim2.new(0, 0, 0, 20)
		NewGuiPart62.Size = UDim2.new(1, 0, 0, 20)
		NewGuiPart62.Font = Enum.Font.SourceSans
		NewGuiPart62.FontSize = Enum.FontSize.Size14
		NewGuiPart62.Text = "Arguments"
		NewGuiPart62.TextWrapped = true

		NewGuiPart63.Name = "Arguments"
		NewGuiPart63.Parent = NewGuiPart61
		NewGuiPart63.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart63.BackgroundTransparency = 1
		NewGuiPart63.Position = UDim2.new(0, 0, 0, 40)
		NewGuiPart63.Size = UDim2.new(1, 0, 0, 80)
		NewGuiPart63.BottomImage = "rbxasset://textures/blackBkg_square.png"
		NewGuiPart63.CanvasSize = UDim2.new(0, 0, 0, 0)
		NewGuiPart63.MidImage = "rbxasset://textures/blackBkg_square.png"
		NewGuiPart63.TopImage = "rbxasset://textures/blackBkg_square.png"

		NewGuiPart64.Name = "DisplayReturned"
		NewGuiPart64.Parent = NewGuiPart61
		NewGuiPart64.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart64.BackgroundTransparency = 0.60000002384186
		NewGuiPart64.Position = UDim2.new(0.075000003, 0, 0.625, 0)
		NewGuiPart64.Size = UDim2.new(0, 20, 0, 20)
		NewGuiPart64.ZIndex = 2
		NewGuiPart64.Font = Enum.Font.SourceSans
		NewGuiPart64.FontSize = Enum.FontSize.Size18
		NewGuiPart64.Text = ""
		NewGuiPart64.TextColor3 = Color3.new(1, 1, 1)

		NewGuiPart65.Name = "enabled"
		NewGuiPart65.Parent = NewGuiPart64
		NewGuiPart65.BackgroundColor3 = Color3.new(0.380392, 0.380392, 0.380392)
		NewGuiPart65.BackgroundTransparency = 0.40000000596046
		NewGuiPart65.BorderSizePixel = 0
		NewGuiPart65.Position = UDim2.new(0, 3, 0, 3)
		NewGuiPart65.Size = UDim2.new(0, 14, 0, 14)
		NewGuiPart65.Visible = false
		NewGuiPart65.Font = Enum.Font.SourceSans
		NewGuiPart65.FontSize = Enum.FontSize.Size14
		NewGuiPart65.Text = ""

		NewGuiPart66.Name = "Desc2"
		NewGuiPart66.Parent = NewGuiPart61
		NewGuiPart66.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart66.BackgroundTransparency = 1
		NewGuiPart66.Position = UDim2.new(0.075000003, 30, 0.625, 0)
		NewGuiPart66.Size = UDim2.new(0.925000012, -30, 0, 20)
		NewGuiPart66.Font = Enum.Font.SourceSans
		NewGuiPart66.FontSize = Enum.FontSize.Size14
		NewGuiPart66.Text = "Display values returned"
		NewGuiPart66.TextXAlignment = Enum.TextXAlignment.Left

		NewGuiPart67.Name = "Add"
		NewGuiPart67.Parent = NewGuiPart61
		NewGuiPart67.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart67.BackgroundTransparency = 0.5
		NewGuiPart67.BorderColor3 = Color3.new(0, 0, 0)
		NewGuiPart67.Position = UDim2.new(0.800000012, 0, 0.625, 0)
		NewGuiPart67.Size = UDim2.new(0, 20, 0, 20)
		NewGuiPart67.Font = Enum.Font.SourceSansBold
		NewGuiPart67.FontSize = Enum.FontSize.Size24
		NewGuiPart67.Text = "+"

		NewGuiPart68.Name = "Subtract"
		NewGuiPart68.Parent = NewGuiPart61
		NewGuiPart68.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart68.BackgroundTransparency = 0.5
		NewGuiPart68.BorderColor3 = Color3.new(0, 0, 0)
		NewGuiPart68.Position = UDim2.new(0.899999976, 0, 0.625, 0)
		NewGuiPart68.Size = UDim2.new(0, 20, 0, 20)
		NewGuiPart68.Font = Enum.Font.SourceSansBold
		NewGuiPart68.FontSize = Enum.FontSize.Size24
		NewGuiPart68.Text = "-"

		NewGuiPart69.Name = "ArgumentTemplate"
		NewGuiPart69.Parent = NewGuiPart61
		NewGuiPart69.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart69.BackgroundTransparency = 0.5
		NewGuiPart69.BorderColor3 = Color3.new(0.74902, 0.74902, 0.74902)
		NewGuiPart69.Size = UDim2.new(1, 0, 0, 20)
		NewGuiPart69.Visible = false

		NewGuiPart70.Name = "Type"
		NewGuiPart70.Parent = NewGuiPart69
		NewGuiPart70.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart70.BackgroundTransparency = 0.89999997615814
		NewGuiPart70.BorderColor3 = Color3.new(0, 0, 0)
		NewGuiPart70.Size = UDim2.new(0.400000006, 0, 0, 20)
		NewGuiPart70.Font = Enum.Font.SourceSans
		NewGuiPart70.FontSize = Enum.FontSize.Size18
		NewGuiPart70.Text = "Script"

		NewGuiPart71.Name = "Value"
		NewGuiPart71.Parent = NewGuiPart69
		NewGuiPart71.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart71.BackgroundTransparency = 0.89999997615814
		NewGuiPart71.Position = UDim2.new(0.400000006, 0, 0, 0)
		NewGuiPart71.Size = UDim2.new(0.600000024, -12, 0, 20)
		NewGuiPart71.Font = Enum.Font.SourceSans
		NewGuiPart71.FontSize = Enum.FontSize.Size14
		NewGuiPart71.Text = ""
		NewGuiPart71.TextXAlignment = Enum.TextXAlignment.Left

		NewGuiPart72.Name = "Cancel"
		NewGuiPart72.Parent = NewGuiPart61
		NewGuiPart72.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart72.BackgroundTransparency = 0.5
		NewGuiPart72.BorderColor3 = Color3.new(0, 0, 0)
		NewGuiPart72.Size = UDim2.new(0.400000006, 0, 0, 30)
		NewGuiPart72.Font = Enum.Font.SourceSans
		NewGuiPart72.FontSize = Enum.FontSize.Size18
		NewGuiPart72.Text = "Cancel"

		NewGuiPart73.Name = "Ok"
		NewGuiPart73.Parent = NewGuiPart61
		NewGuiPart73.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart73.BackgroundTransparency = 0.5
		NewGuiPart73.BorderColor3 = Color3.new(0, 0, 0)
		NewGuiPart73.Position = UDim2.new(0.075000003, 0, 1, -40)
		NewGuiPart73.Size = UDim2.new(0.400000006, 0, 0, 30)
		NewGuiPart73.Font = Enum.Font.SourceSans
		NewGuiPart73.FontSize = Enum.FontSize.Size18
		NewGuiPart73.Text = "Call"

		NewGuiPart74.Name = "TableCaution"
		NewGuiPart74.Parent = NewGuiPart1
		NewGuiPart74.Active = true
		NewGuiPart74.BackgroundColor3 = Color3.new(0.913726, 0.913726, 0.913726)
		NewGuiPart74.BorderColor3 = Color3.new(0.584314, 0.584314, 0.584314)
		NewGuiPart74.Draggable = true
		NewGuiPart74.Position = UDim2.new(0.300000012, 0, 0.300000012, 0)
		NewGuiPart74.Size = UDim2.new(0, 350, 0, 20)
		NewGuiPart74.Visible = false
		NewGuiPart74.ZIndex = 2

		NewGuiPart75.Name = "MainWindow"
		NewGuiPart75.Parent = NewGuiPart74
		NewGuiPart75.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart75.BackgroundTransparency = 0.10000000149012
		NewGuiPart75.BorderColor3 = Color3.new(0.74902, 0.74902, 0.74902)
		NewGuiPart75.Size = UDim2.new(1, 0, 0, 150)

		NewGuiPart76.Name = "Ok"
		NewGuiPart76.Parent = NewGuiPart75
		NewGuiPart76.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart76.BackgroundTransparency = 0.5
		NewGuiPart76.BorderColor3 = Color3.new(0, 0, 0)
		NewGuiPart76.Position = UDim2.new(0.300000012, 0, 1, -40)
		NewGuiPart76.Size = UDim2.new(0.400000006, 0, 0, 30)
		NewGuiPart76.Font = Enum.Font.SourceSans
		NewGuiPart76.FontSize = Enum.FontSize.Size18
		NewGuiPart76.Text = "Ok"

		NewGuiPart77.Name = "TableResults"
		NewGuiPart77.Parent = NewGuiPart75
		NewGuiPart77.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart77.BackgroundTransparency = 1
		NewGuiPart77.Position = UDim2.new(0, 0, 0, 20)
		NewGuiPart77.Size = UDim2.new(1, 0, 0, 80)
		NewGuiPart77.BottomImage = "rbxasset://textures/blackBkg_square.png"
		NewGuiPart77.CanvasSize = UDim2.new(0, 0, 0, 0)
		NewGuiPart77.MidImage = "rbxasset://textures/blackBkg_square.png"
		NewGuiPart77.TopImage = "rbxasset://textures/blackBkg_square.png"

		NewGuiPart78.Name = "TableTemplate"
		NewGuiPart78.Parent = NewGuiPart75
		NewGuiPart78.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart78.BackgroundTransparency = 0.5
		NewGuiPart78.BorderColor3 = Color3.new(0.74902, 0.74902, 0.74902)
		NewGuiPart78.Size = UDim2.new(1, 0, 0, 20)
		NewGuiPart78.Visible = false

		NewGuiPart79.Name = "Type"
		NewGuiPart79.Parent = NewGuiPart78
		NewGuiPart79.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart79.BackgroundTransparency = 0.89999997615814
		NewGuiPart79.Size = UDim2.new(0.400000006, 0, 0, 20)
		NewGuiPart79.Font = Enum.Font.SourceSans
		NewGuiPart79.FontSize = Enum.FontSize.Size18
		NewGuiPart79.Text = "Script"

		NewGuiPart80.Name = "Value"
		NewGuiPart80.Parent = NewGuiPart78
		NewGuiPart80.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart80.BackgroundTransparency = 0.89999997615814
		NewGuiPart80.Position = UDim2.new(0.400000006, 0, 0, 0)
		NewGuiPart80.Size = UDim2.new(0.600000024, -12, 0, 20)
		NewGuiPart80.Font = Enum.Font.SourceSans
		NewGuiPart80.FontSize = Enum.FontSize.Size14
		NewGuiPart80.Text = "Script"

		NewGuiPart81.Name = "Title"
		NewGuiPart81.Parent = NewGuiPart74
		NewGuiPart81.BackgroundTransparency = 1
		NewGuiPart81.Size = UDim2.new(1, 0, 1, 0)
		NewGuiPart81.ZIndex = 2
		NewGuiPart81.Font = Enum.Font.SourceSans
		NewGuiPart81.FontSize = Enum.FontSize.Size14
		NewGuiPart81.Text = "Caution"
		NewGuiPart81.TextColor3 = Color3.new(0, 0, 0)
		NewGuiPart81.TextXAlignment = Enum.TextXAlignment.Left

		NewGuiPart82.Name = "ScriptEditor"
		NewGuiPart82.Parent = NewGuiPart1
		NewGuiPart82.Active = true
		NewGuiPart82.BackgroundColor3 = Color3.new(0.913726, 0.913726, 0.913726)
		NewGuiPart82.BorderColor3 = Color3.new(0.584314, 0.584314, 0.584314)
		NewGuiPart82.Draggable = true
		NewGuiPart82.Position = UDim2.new(0.300000012, 0, 0.300000012, 0)
		NewGuiPart82.Size = UDim2.new(0, 516, 0, 20)
		NewGuiPart82.Visible = false
		NewGuiPart82.ZIndex = 5

		NewGuiPart163.Name = "OpenScript"
		NewGuiPart163.Parent = NewGuiPart82
		NewGuiPart163.Archivable = true

		NewGuiPart83.Name = "Title"
		NewGuiPart83.Parent = NewGuiPart82
		NewGuiPart83.BackgroundTransparency = 1
		NewGuiPart83.Size = UDim2.new(1, 0, 1, 0)
		NewGuiPart83.ZIndex = 5
		NewGuiPart83.Font = Enum.Font.SourceSans
		NewGuiPart83.FontSize = Enum.FontSize.Size14
		NewGuiPart83.Text = "Script Viewer"
		NewGuiPart83.TextColor3 = Color3.new(0, 0, 0)
		NewGuiPart83.TextXAlignment = Enum.TextXAlignment.Left

		NewGuiPart84.Name = "Cover"
		NewGuiPart84.Parent = NewGuiPart82
		NewGuiPart84.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart84.BorderSizePixel = 0
		NewGuiPart84.Position = UDim2.new(0, 0, 3, 0)
		NewGuiPart84.Size = UDim2.new(0, 516, 0, 416)

		NewGuiPart85.Name = "EditorGrid"
		NewGuiPart85.Parent = NewGuiPart82
		NewGuiPart85.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart85.BorderSizePixel = 0
		NewGuiPart85.Position = UDim2.new(0, 0, 3, 0)
		NewGuiPart85.Size = UDim2.new(0, 500, 0, 400)

		NewGuiPart86.Name = "TopBar"
		NewGuiPart86.Parent = NewGuiPart82
		NewGuiPart86.BackgroundColor3 = Color3.new(0.941177, 0.941177, 0.941177)
		NewGuiPart86.BorderColor3 = Color3.new(0.584314, 0.584314, 0.584314)
		NewGuiPart86.Size = UDim2.new(1, 0, 3, 0)

		NewGuiPart87.Name = "ScriptBarLeft"
		NewGuiPart87.Parent = NewGuiPart86
		NewGuiPart87.Active = false
		NewGuiPart87.BackgroundColor3 = Color3.new(0.866667, 0.866667, 0.866667)
		NewGuiPart87.BorderColor3 = Color3.new(0.584314, 0.584314, 0.584314)
		NewGuiPart87.Position = UDim2.new(1, -32, 0, 40)
		NewGuiPart87.Size = UDim2.new(0, 16, 0, 20)
		NewGuiPart87.AutoButtonColor = false

		NewGuiPart88.Name = "Arrow Graphic"
		NewGuiPart88.Parent = NewGuiPart87
		NewGuiPart88.BackgroundTransparency = 1
		NewGuiPart88.BorderSizePixel = 0
		NewGuiPart88.Position = UDim2.new(0.5, -4, 0.5, -4)
		NewGuiPart88.Size = UDim2.new(0, 8, 0, 8)

		NewGuiPart89.Name = "Graphic"
		NewGuiPart89.Parent = NewGuiPart88
		NewGuiPart89.BackgroundColor3 = Color3.new(0.584314, 0.584314, 0.584314)
		NewGuiPart89.BackgroundTransparency = 0.69999998807907
		NewGuiPart89.BorderSizePixel = 0
		NewGuiPart89.Position = UDim2.new(0.25, 0, 0.375, 0)
		NewGuiPart89.Size = UDim2.new(0.125, 0, 0.25, 0)

		NewGuiPart90.Name = "Graphic"
		NewGuiPart90.Parent = NewGuiPart88
		NewGuiPart90.BackgroundColor3 = Color3.new(0.584314, 0.584314, 0.584314)
		NewGuiPart90.BackgroundTransparency = 0.69999998807907
		NewGuiPart90.BorderSizePixel = 0
		NewGuiPart90.Position = UDim2.new(0.375, 0, 0.25, 0)
		NewGuiPart90.Size = UDim2.new(0.125, 0, 0.5, 0)

		NewGuiPart91.Name = "Graphic"
		NewGuiPart91.Parent = NewGuiPart88
		NewGuiPart91.BackgroundColor3 = Color3.new(0.584314, 0.584314, 0.584314)
		NewGuiPart91.BackgroundTransparency = 0.69999998807907
		NewGuiPart91.BorderSizePixel = 0
		NewGuiPart91.Position = UDim2.new(0.5, 0, 0.125, 0)
		NewGuiPart91.Size = UDim2.new(0.125, 0, 0.75, 0)

		NewGuiPart92.Name = "Graphic"
		NewGuiPart92.Parent = NewGuiPart88
		NewGuiPart92.BackgroundColor3 = Color3.new(0.584314, 0.584314, 0.584314)
		NewGuiPart92.BackgroundTransparency = 0.69999998807907
		NewGuiPart92.BorderSizePixel = 0
		NewGuiPart92.Position = UDim2.new(0.625, 0, 0, 0)
		NewGuiPart92.Size = UDim2.new(0.125, 0, 1, 0)

		NewGuiPart93.Name = "ScriptBarRight"
		NewGuiPart93.Parent = NewGuiPart86
		NewGuiPart93.Active = false
		NewGuiPart93.BackgroundColor3 = Color3.new(0.866667, 0.866667, 0.866667)
		NewGuiPart93.BorderColor3 = Color3.new(0.584314, 0.584314, 0.584314)
		NewGuiPart93.Position = UDim2.new(1, -16, 0, 40)
		NewGuiPart93.Size = UDim2.new(0, 16, 0, 20)
		NewGuiPart93.AutoButtonColor = false

		NewGuiPart94.Name = "Arrow Graphic"
		NewGuiPart94.Parent = NewGuiPart93
		NewGuiPart94.BackgroundTransparency = 1
		NewGuiPart94.BorderSizePixel = 0
		NewGuiPart94.Position = UDim2.new(0.5, -4, 0.5, -4)
		NewGuiPart94.Size = UDim2.new(0, 8, 0, 8)

		NewGuiPart95.Name = "Graphic"
		NewGuiPart95.Parent = NewGuiPart94
		NewGuiPart95.BackgroundColor3 = Color3.new(0.584314, 0.584314, 0.584314)
		NewGuiPart95.BackgroundTransparency = 0.69999998807907
		NewGuiPart95.BorderSizePixel = 0
		NewGuiPart95.Position = UDim2.new(0.625, 0, 0.375, 0)
		NewGuiPart95.Size = UDim2.new(0.125, 0, 0.25, 0)

		NewGuiPart96.Name = "Graphic"
		NewGuiPart96.Parent = NewGuiPart94
		NewGuiPart96.BackgroundColor3 = Color3.new(0.584314, 0.584314, 0.584314)
		NewGuiPart96.BackgroundTransparency = 0.69999998807907
		NewGuiPart96.BorderSizePixel = 0
		NewGuiPart96.Position = UDim2.new(0.5, 0, 0.25, 0)
		NewGuiPart96.Size = UDim2.new(0.125, 0, 0.5, 0)

		NewGuiPart97.Name = "Graphic"
		NewGuiPart97.Parent = NewGuiPart94
		NewGuiPart97.BackgroundColor3 = Color3.new(0.584314, 0.584314, 0.584314)
		NewGuiPart97.BackgroundTransparency = 0.69999998807907
		NewGuiPart97.BorderSizePixel = 0
		NewGuiPart97.Position = UDim2.new(0.375, 0, 0.125, 0)
		NewGuiPart97.Size = UDim2.new(0.125, 0, 0.75, 0)

		NewGuiPart98.Name = "Graphic"
		NewGuiPart98.Parent = NewGuiPart94
		NewGuiPart98.BackgroundColor3 = Color3.new(0.584314, 0.584314, 0.584314)
		NewGuiPart98.BackgroundTransparency = 0.69999998807907
		NewGuiPart98.BorderSizePixel = 0
		NewGuiPart98.Position = UDim2.new(0.25, 0, 0, 0)
		NewGuiPart98.Size = UDim2.new(0.125, 0, 1, 0)

		NewGuiPart99.Name = "Clipboard"
		NewGuiPart99.Parent = NewGuiPart86
		NewGuiPart99.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart99.BackgroundTransparency = 0.5
		NewGuiPart99.BorderColor3 = Color3.new(0, 0, 0)
		NewGuiPart99.Position = UDim2.new(0, 0, 0, 20)
		NewGuiPart99.Size = UDim2.new(0, 80, 0, 20)
		NewGuiPart99.Font = Enum.Font.SourceSans
		NewGuiPart99.FontSize = Enum.FontSize.Size14
		NewGuiPart99.Text = "To Clipboard"

		NewGuiPart100.Name = "ScriptBar"
		NewGuiPart100.Parent = NewGuiPart86
		NewGuiPart100.BackgroundColor3 = Color3.new(0.823529, 0.823529, 0.823529)
		NewGuiPart100.BorderColor3 = Color3.new(0.584314, 0.584314, 0.584314)
		NewGuiPart100.ClipsDescendants = true
		NewGuiPart100.Position = UDim2.new(0, 0, 0, 40)
		NewGuiPart100.Size = UDim2.new(1, -32, 0, 20)

		NewGuiPart101.Name = "Entry"
		NewGuiPart101.Parent = NewGuiPart86
		NewGuiPart101.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart101.BackgroundTransparency = 1
		NewGuiPart101.Size = UDim2.new(0, 100, 1, 0)
		NewGuiPart101.Visible = false

		NewGuiPart102.Name = "Button"
		NewGuiPart102.Parent = NewGuiPart101
		NewGuiPart102.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart102.BackgroundTransparency = 0.60000002384186
		NewGuiPart102.BorderColor3 = Color3.new(0, 0, 0)
		NewGuiPart102.ClipsDescendants = true
		NewGuiPart102.Size = UDim2.new(1, 0, 1, 0)
		NewGuiPart102.ZIndex = 4
		NewGuiPart102.Font = Enum.Font.SourceSans
		NewGuiPart102.FontSize = Enum.FontSize.Size12
		NewGuiPart102.Text = ""
		NewGuiPart102.TextXAlignment = Enum.TextXAlignment.Left

		NewGuiPart103.Name = "Close"
		NewGuiPart103.Parent = NewGuiPart101
		NewGuiPart103.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart103.BackgroundTransparency = 1
		NewGuiPart103.BorderColor3 = Color3.new(0, 0, 0)
		NewGuiPart103.Position = UDim2.new(1, -20, 0, 0)
		NewGuiPart103.Size = UDim2.new(0, 20, 0, 20)
		NewGuiPart103.ZIndex = 4
		NewGuiPart103.Font = Enum.Font.SourceSans
		NewGuiPart103.FontSize = Enum.FontSize.Size14
		NewGuiPart103.Text = "X"

		NewGuiPart104.Name = "Close"
		NewGuiPart104.Parent = NewGuiPart82
		NewGuiPart104.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart104.BackgroundTransparency = 1
		NewGuiPart104.BorderColor3 = Color3.new(0, 0, 0)
		NewGuiPart104.Position = UDim2.new(1, -20, 0, 0)
		NewGuiPart104.Size = UDim2.new(0, 20, 0, 20)
		NewGuiPart104.ZIndex = 5
		NewGuiPart104.Font = Enum.Font.SourceSans
		NewGuiPart104.FontSize = Enum.FontSize.Size14
		NewGuiPart104.Text = "X"

		NewGuiPart105.Name = "IntroFrame"
		NewGuiPart105.Parent = NewGuiPart1
		NewGuiPart105.BackgroundColor3 = Color3.new(0.960784, 0.960784, 0.960784)
		NewGuiPart105.BorderSizePixel = 0
		NewGuiPart105.Position = UDim2.new(1, 30, 0, 0)
		NewGuiPart105.Size = UDim2.new(0, 300, 1, 0)
		NewGuiPart105.ZIndex = 2

		NewGuiPart106.Name = "Main"
		NewGuiPart106.Parent = NewGuiPart105
		NewGuiPart106.BackgroundColor3 = Color3.new(0.960784, 0.960784, 0.960784)
		NewGuiPart106.BorderSizePixel = 0
		NewGuiPart106.Position = UDim2.new(0, -30, 0, 0)
		NewGuiPart106.Size = UDim2.new(0, 30, 0, 90)
		NewGuiPart106.ZIndex = 2

		NewGuiPart107.Name = "Title"
		NewGuiPart107.Parent = NewGuiPart105
		NewGuiPart107.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart107.BackgroundTransparency = 1
		NewGuiPart107.Position = UDim2.new(0, 100, 0, 150)
		NewGuiPart107.Size = UDim2.new(0, 100, 0, 60)
		NewGuiPart107.ZIndex = 2
		NewGuiPart107.Font = Enum.Font.SourceSansBold
		NewGuiPart107.FontSize = Enum.FontSize.Size60
		NewGuiPart107.Text = "DEX"
		NewGuiPart107.TextWrapped = true

		NewGuiPart108.Name = "Version"
		NewGuiPart108.Parent = NewGuiPart105
		NewGuiPart108.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart108.BackgroundTransparency = 1
		NewGuiPart108.Position = UDim2.new(0, 100, 0, 210)
		NewGuiPart108.Size = UDim2.new(0, 100, 0, 30)
		NewGuiPart108.ZIndex = 2
		NewGuiPart108.Font = Enum.Font.SourceSansBold
		NewGuiPart108.FontSize = Enum.FontSize.Size28
		NewGuiPart108.Text = "V2.0.0"
		NewGuiPart108.TextWrapped = true

		NewGuiPart109.Name = "Creator"
		NewGuiPart109.Parent = NewGuiPart105
		NewGuiPart109.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart109.BackgroundTransparency = 1
		NewGuiPart109.Position = UDim2.new(0, 80, 0, 300)
		NewGuiPart109.Size = UDim2.new(0, 140, 0, 30)
		NewGuiPart109.ZIndex = 2
		NewGuiPart109.Font = Enum.Font.SourceSansBold
		NewGuiPart109.FontSize = Enum.FontSize.Size28
		NewGuiPart109.Text = "Raspberry Pi , Script Made By Advancedev"
		NewGuiPart109.TextWrapped = true

		NewGuiPart110.Name = "Slant"
		NewGuiPart110.Parent = NewGuiPart105
		NewGuiPart110.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart110.BackgroundTransparency = 1
		NewGuiPart110.Position = UDim2.new(0, -30, 0, 90)
		NewGuiPart110.Rotation = 180
		NewGuiPart110.Size = UDim2.new(0, 30, 0, 30)
		NewGuiPart110.ZIndex = 2
		NewGuiPart110.Image = "rbxassetid://474172996"
		NewGuiPart110.ImageColor3 = Color3.new(0.960784, 0.960784, 0.960784)

		NewGuiPart111.Name = "SaveMapWindow"
		NewGuiPart111.Parent = NewGuiPart1
		NewGuiPart111.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart111.BackgroundTransparency = 0.10000000149012
		NewGuiPart111.BorderColor3 = Color3.new(0.74902, 0.74902, 0.74902)
		NewGuiPart111.Position = UDim2.new(1, 0, 0, 0)
		NewGuiPart111.Size = UDim2.new(0, 300, 1, 0)

		NewGuiPart112.Name = "Header"
		NewGuiPart112.Parent = NewGuiPart111
		NewGuiPart112.BackgroundColor3 = Color3.new(0.913726, 0.913726, 0.913726)
		NewGuiPart112.BorderColor3 = Color3.new(0.584314, 0.584314, 0.584314)
		NewGuiPart112.Size = UDim2.new(1, 0, 0, 17)

		NewGuiPart113.Parent = NewGuiPart112
		NewGuiPart113.BackgroundTransparency = 1
		NewGuiPart113.Position = UDim2.new(0, 4, 0, 0)
		NewGuiPart113.Size = UDim2.new(1, -4, 1, 0)
		NewGuiPart113.Font = Enum.Font.SourceSans
		NewGuiPart113.FontSize = Enum.FontSize.Size14
		NewGuiPart113.Text = "Map Downloader"
		NewGuiPart113.TextColor3 = Color3.new(0, 0, 0)
		NewGuiPart113.TextXAlignment = Enum.TextXAlignment.Left

		NewGuiPart114.Name = "MapSettings"
		NewGuiPart114.Parent = NewGuiPart111
		NewGuiPart114.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart114.BackgroundTransparency = 1
		NewGuiPart114.Position = UDim2.new(0, 0, 0, 200)
		NewGuiPart114.Size = UDim2.new(1, 0, 0, 240)

		NewGuiPart115.Name = "Terrain"
		NewGuiPart115.Parent = NewGuiPart114
		NewGuiPart115.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart115.BackgroundTransparency = 1
		NewGuiPart115.Position = UDim2.new(0, 0, 0, 60)
		NewGuiPart115.Size = UDim2.new(1, 0, 0, 60)

		NewGuiPart116.Name = "SName"
		NewGuiPart116.Parent = NewGuiPart115
		NewGuiPart116.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart116.BackgroundTransparency = 1
		NewGuiPart116.Position = UDim2.new(0, 10, 0, 0)
		NewGuiPart116.Size = UDim2.new(1, -20, 0, 30)
		NewGuiPart116.Font = Enum.Font.SourceSans
		NewGuiPart116.FontSize = Enum.FontSize.Size18
		NewGuiPart116.Text = "Save Terrain"
		NewGuiPart116.TextXAlignment = Enum.TextXAlignment.Left

		NewGuiPart117.Name = "Status"
		NewGuiPart117.Parent = NewGuiPart115
		NewGuiPart117.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart117.BackgroundTransparency = 1
		NewGuiPart117.Position = UDim2.new(0, 60, 0, 30)
		NewGuiPart117.Size = UDim2.new(0, 50, 0, 15)
		NewGuiPart117.Font = Enum.Font.SourceSans
		NewGuiPart117.FontSize = Enum.FontSize.Size18
		NewGuiPart117.Text = "Off"
		NewGuiPart117.TextXAlignment = Enum.TextXAlignment.Left

		NewGuiPart118.Name = "Change"
		NewGuiPart118.Parent = NewGuiPart115
		NewGuiPart118.BackgroundColor3 = Color3.new(0.862745, 0.862745, 0.862745)
		NewGuiPart118.BorderSizePixel = 0
		NewGuiPart118.Position = UDim2.new(0, 10, 0, 30)
		NewGuiPart118.Size = UDim2.new(0, 40, 0, 15)
		NewGuiPart118.Font = Enum.Font.SourceSans
		NewGuiPart118.FontSize = Enum.FontSize.Size14
		NewGuiPart118.Text = ""

		NewGuiPart119.Name = "OnBar"
		NewGuiPart119.Parent = NewGuiPart118
		NewGuiPart119.BackgroundColor3 = Color3.new(0, 0.576471, 0.862745)
		NewGuiPart119.BorderSizePixel = 0
		NewGuiPart119.Size = UDim2.new(0, 0, 0, 15)
		NewGuiPart119.Font = Enum.Font.SourceSans
		NewGuiPart119.FontSize = Enum.FontSize.Size14
		NewGuiPart119.Text = ""

		NewGuiPart120.Name = "Bar"
		NewGuiPart120.Parent = NewGuiPart118
		NewGuiPart120.BackgroundColor3 = Color3.new(0, 0, 0)
		NewGuiPart120.BorderSizePixel = 0
		NewGuiPart120.ClipsDescendants = true
		NewGuiPart120.Position = UDim2.new(0, -2, 0, -2)
		NewGuiPart120.Size = UDim2.new(0, 10, 0, 19)
		NewGuiPart120.Font = Enum.Font.SourceSans
		NewGuiPart120.FontSize = Enum.FontSize.Size14
		NewGuiPart120.Text = ""

		NewGuiPart121.Name = "Lighting"
		NewGuiPart121.Parent = NewGuiPart114
		NewGuiPart121.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart121.BackgroundTransparency = 1
		NewGuiPart121.Position = UDim2.new(0, 0, 0, 120)
		NewGuiPart121.Size = UDim2.new(1, 0, 0, 60)

		NewGuiPart122.Name = "SName"
		NewGuiPart122.Parent = NewGuiPart121
		NewGuiPart122.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart122.BackgroundTransparency = 1
		NewGuiPart122.Position = UDim2.new(0, 10, 0, 0)
		NewGuiPart122.Size = UDim2.new(1, -20, 0, 30)
		NewGuiPart122.Font = Enum.Font.SourceSans
		NewGuiPart122.FontSize = Enum.FontSize.Size18
		NewGuiPart122.Text = "Lighting Properties"
		NewGuiPart122.TextXAlignment = Enum.TextXAlignment.Left

		NewGuiPart123.Name = "Status"
		NewGuiPart123.Parent = NewGuiPart121
		NewGuiPart123.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart123.BackgroundTransparency = 1
		NewGuiPart123.Position = UDim2.new(0, 60, 0, 30)
		NewGuiPart123.Size = UDim2.new(0, 50, 0, 15)
		NewGuiPart123.Font = Enum.Font.SourceSans
		NewGuiPart123.FontSize = Enum.FontSize.Size18
		NewGuiPart123.Text = "Off"
		NewGuiPart123.TextXAlignment = Enum.TextXAlignment.Left

		NewGuiPart124.Name = "Change"
		NewGuiPart124.Parent = NewGuiPart121
		NewGuiPart124.BackgroundColor3 = Color3.new(0.862745, 0.862745, 0.862745)
		NewGuiPart124.BorderSizePixel = 0
		NewGuiPart124.Position = UDim2.new(0, 10, 0, 30)
		NewGuiPart124.Size = UDim2.new(0, 40, 0, 15)
		NewGuiPart124.Font = Enum.Font.SourceSans
		NewGuiPart124.FontSize = Enum.FontSize.Size14
		NewGuiPart124.Text = ""

		NewGuiPart125.Name = "OnBar"
		NewGuiPart125.Parent = NewGuiPart124
		NewGuiPart125.BackgroundColor3 = Color3.new(0, 0.576471, 0.862745)
		NewGuiPart125.BorderSizePixel = 0
		NewGuiPart125.Size = UDim2.new(0, 0, 0, 15)
		NewGuiPart125.Font = Enum.Font.SourceSans
		NewGuiPart125.FontSize = Enum.FontSize.Size14
		NewGuiPart125.Text = ""

		NewGuiPart126.Name = "Bar"
		NewGuiPart126.Parent = NewGuiPart124
		NewGuiPart126.BackgroundColor3 = Color3.new(0, 0, 0)
		NewGuiPart126.BorderSizePixel = 0
		NewGuiPart126.ClipsDescendants = true
		NewGuiPart126.Position = UDim2.new(0, -2, 0, -2)
		NewGuiPart126.Size = UDim2.new(0, 10, 0, 19)
		NewGuiPart126.Font = Enum.Font.SourceSans
		NewGuiPart126.FontSize = Enum.FontSize.Size14
		NewGuiPart126.Text = ""

		NewGuiPart127.Name = "CameraInstances"
		NewGuiPart127.Parent = NewGuiPart114
		NewGuiPart127.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart127.BackgroundTransparency = 1
		NewGuiPart127.Position = UDim2.new(0, 0, 0, 180)
		NewGuiPart127.Size = UDim2.new(1, 0, 0, 60)

		NewGuiPart128.Name = "SName"
		NewGuiPart128.Parent = NewGuiPart127
		NewGuiPart128.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart128.BackgroundTransparency = 1
		NewGuiPart128.Position = UDim2.new(0, 10, 0, 0)
		NewGuiPart128.Size = UDim2.new(1, -20, 0, 30)
		NewGuiPart128.Font = Enum.Font.SourceSans
		NewGuiPart128.FontSize = Enum.FontSize.Size18
		NewGuiPart128.Text = "Camera Instances"
		NewGuiPart128.TextXAlignment = Enum.TextXAlignment.Left

		NewGuiPart129.Name = "Status"
		NewGuiPart129.Parent = NewGuiPart127
		NewGuiPart129.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart129.BackgroundTransparency = 1
		NewGuiPart129.Position = UDim2.new(0, 60, 0, 30)
		NewGuiPart129.Size = UDim2.new(0, 50, 0, 15)
		NewGuiPart129.Font = Enum.Font.SourceSans
		NewGuiPart129.FontSize = Enum.FontSize.Size18
		NewGuiPart129.Text = "Off"
		NewGuiPart129.TextXAlignment = Enum.TextXAlignment.Left

		NewGuiPart130.Name = "Change"
		NewGuiPart130.Parent = NewGuiPart127
		NewGuiPart130.BackgroundColor3 = Color3.new(0.862745, 0.862745, 0.862745)
		NewGuiPart130.BorderSizePixel = 0
		NewGuiPart130.Position = UDim2.new(0, 10, 0, 30)
		NewGuiPart130.Size = UDim2.new(0, 40, 0, 15)
		NewGuiPart130.Font = Enum.Font.SourceSans
		NewGuiPart130.FontSize = Enum.FontSize.Size14
		NewGuiPart130.Text = ""

		NewGuiPart131.Name = "OnBar"
		NewGuiPart131.Parent = NewGuiPart130
		NewGuiPart131.BackgroundColor3 = Color3.new(0, 0.576471, 0.862745)
		NewGuiPart131.BorderSizePixel = 0
		NewGuiPart131.Size = UDim2.new(0, 0, 0, 15)
		NewGuiPart131.Font = Enum.Font.SourceSans
		NewGuiPart131.FontSize = Enum.FontSize.Size14
		NewGuiPart131.Text = ""

		NewGuiPart132.Name = "Bar"
		NewGuiPart132.Parent = NewGuiPart130
		NewGuiPart132.BackgroundColor3 = Color3.new(0, 0, 0)
		NewGuiPart132.BorderSizePixel = 0
		NewGuiPart132.ClipsDescendants = true
		NewGuiPart132.Position = UDim2.new(0, -2, 0, -2)
		NewGuiPart132.Size = UDim2.new(0, 10, 0, 19)
		NewGuiPart132.Font = Enum.Font.SourceSans
		NewGuiPart132.FontSize = Enum.FontSize.Size14
		NewGuiPart132.Text = ""

		NewGuiPart133.Name = "Scripts"
		NewGuiPart133.Parent = NewGuiPart114
		NewGuiPart133.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart133.BackgroundTransparency = 1
		NewGuiPart133.Size = UDim2.new(1, 0, 0, 60)

		NewGuiPart134.Name = "SName"
		NewGuiPart134.Parent = NewGuiPart133
		NewGuiPart134.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart134.BackgroundTransparency = 1
		NewGuiPart134.Position = UDim2.new(0, 10, 0, 0)
		NewGuiPart134.Size = UDim2.new(1, -20, 0, 30)
		NewGuiPart134.Font = Enum.Font.SourceSans
		NewGuiPart134.FontSize = Enum.FontSize.Size18
		NewGuiPart134.Text = "Save Scripts"
		NewGuiPart134.TextXAlignment = Enum.TextXAlignment.Left

		NewGuiPart135.Name = "Status"
		NewGuiPart135.Parent = NewGuiPart133
		NewGuiPart135.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart135.BackgroundTransparency = 1
		NewGuiPart135.Position = UDim2.new(0, 60, 0, 30)
		NewGuiPart135.Size = UDim2.new(0, 50, 0, 15)
		NewGuiPart135.Font = Enum.Font.SourceSans
		NewGuiPart135.FontSize = Enum.FontSize.Size18
		NewGuiPart135.Text = "Off"
		NewGuiPart135.TextXAlignment = Enum.TextXAlignment.Left

		NewGuiPart136.Name = "Change"
		NewGuiPart136.Parent = NewGuiPart133
		NewGuiPart136.BackgroundColor3 = Color3.new(0.862745, 0.862745, 0.862745)
		NewGuiPart136.BorderSizePixel = 0
		NewGuiPart136.Position = UDim2.new(0, 10, 0, 30)
		NewGuiPart136.Size = UDim2.new(0, 40, 0, 15)
		NewGuiPart136.Font = Enum.Font.SourceSans
		NewGuiPart136.FontSize = Enum.FontSize.Size14
		NewGuiPart136.Text = ""

		NewGuiPart137.Name = "OnBar"
		NewGuiPart137.Parent = NewGuiPart136
		NewGuiPart137.BackgroundColor3 = Color3.new(0, 0.576471, 0.862745)
		NewGuiPart137.BorderSizePixel = 0
		NewGuiPart137.Size = UDim2.new(0, 0, 0, 15)
		NewGuiPart137.Font = Enum.Font.SourceSans
		NewGuiPart137.FontSize = Enum.FontSize.Size14
		NewGuiPart137.Text = ""

		NewGuiPart138.Name = "Bar"
		NewGuiPart138.Parent = NewGuiPart136
		NewGuiPart138.BackgroundColor3 = Color3.new(0, 0, 0)
		NewGuiPart138.BorderSizePixel = 0
		NewGuiPart138.ClipsDescendants = true
		NewGuiPart138.Position = UDim2.new(0, -2, 0, -2)
		NewGuiPart138.Size = UDim2.new(0, 10, 0, 19)
		NewGuiPart138.Font = Enum.Font.SourceSans
		NewGuiPart138.FontSize = Enum.FontSize.Size14
		NewGuiPart138.Text = ""

		NewGuiPart139.Name = "ToSave"
		NewGuiPart139.Parent = NewGuiPart111
		NewGuiPart139.BackgroundTransparency = 1
		NewGuiPart139.Position = UDim2.new(0, 0, 0, 17)
		NewGuiPart139.Size = UDim2.new(1, 0, 0, 20)
		NewGuiPart139.Font = Enum.Font.SourceSans
		NewGuiPart139.FontSize = Enum.FontSize.Size18
		NewGuiPart139.Text = "To Save"
		NewGuiPart139.TextColor3 = Color3.new(0, 0, 0)

		NewGuiPart140.Name = "CopyList"
		NewGuiPart140.Parent = NewGuiPart111
		NewGuiPart140.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart140.BackgroundTransparency = 0.80000001192093
		NewGuiPart140.Position = UDim2.new(0, 0, 0, 37)
		NewGuiPart140.Size = UDim2.new(1, 0, 0, 163)

		NewGuiPart141.Name = "Bottom"
		NewGuiPart141.Parent = NewGuiPart111
		NewGuiPart141.BackgroundColor3 = Color3.new(0.913726, 0.913726, 0.913726)
		NewGuiPart141.BorderColor3 = Color3.new(0.584314, 0.584314, 0.584314)
		NewGuiPart141.Position = UDim2.new(0, 0, 1, -50)
		NewGuiPart141.Size = UDim2.new(1, 0, 0, 50)

		NewGuiPart142.Parent = NewGuiPart141
		NewGuiPart142.BackgroundTransparency = 1
		NewGuiPart142.Position = UDim2.new(0, 4, 0, 0)
		NewGuiPart142.Size = UDim2.new(1, -4, 1, 0)
		NewGuiPart142.Font = Enum.Font.SourceSans
		NewGuiPart142.FontSize = Enum.FontSize.Size14
		NewGuiPart142.Text = "After the map saves, open a new place on studio, then right click Lighting and \"Insert from file...\", then select your file and run the unpacker script inside the folder."
		NewGuiPart142.TextColor3 = Color3.new(0, 0, 0)
		NewGuiPart142.TextWrapped = true
		NewGuiPart142.TextXAlignment = Enum.TextXAlignment.Left
		NewGuiPart142.TextYAlignment = Enum.TextYAlignment.Top

		NewGuiPart143.Name = "Save"
		NewGuiPart143.Parent = NewGuiPart111
		NewGuiPart143.BackgroundColor3 = Color3.new(0.941177, 0.941177, 0.941177)
		NewGuiPart143.BackgroundTransparency = 0.80000001192093
		NewGuiPart143.BorderColor3 = Color3.new(0, 0, 0)
		NewGuiPart143.Position = UDim2.new(0, 0, 1, -80)
		NewGuiPart143.Size = UDim2.new(1, 0, 0, 30)
		NewGuiPart143.Font = Enum.Font.SourceSans
		NewGuiPart143.FontSize = Enum.FontSize.Size18
		NewGuiPart143.Text = "Save"

		NewGuiPart144.Name = "FileName"
		NewGuiPart144.Parent = NewGuiPart111
		NewGuiPart144.BackgroundColor3 = Color3.new(0.941177, 0.941177, 0.941177)
		NewGuiPart144.BackgroundTransparency = 0.60000002384186
		NewGuiPart144.Position = UDim2.new(0, 0, 1, -105)
		NewGuiPart144.Size = UDim2.new(1, 0, 0, 25)
		NewGuiPart144.Font = Enum.Font.SourceSans
		NewGuiPart144.FontSize = Enum.FontSize.Size18
		NewGuiPart144.Text = "PlaceName"
		NewGuiPart144.TextXAlignment = Enum.TextXAlignment.Left

		NewGuiPart145.Name = "Entry"
		NewGuiPart145.Parent = NewGuiPart111
		NewGuiPart145.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart145.BackgroundTransparency = 1
		NewGuiPart145.Size = UDim2.new(1, 0, 0, 22)
		NewGuiPart145.Visible = false

		NewGuiPart146.Name = "Change"
		NewGuiPart146.Parent = NewGuiPart145
		NewGuiPart146.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart146.BackgroundTransparency = 0.60000002384186
		NewGuiPart146.Position = UDim2.new(0, 10, 0, 1)
		NewGuiPart146.Size = UDim2.new(0, 20, 0, 20)
		NewGuiPart146.ZIndex = 2
		NewGuiPart146.Font = Enum.Font.SourceSans
		NewGuiPart146.FontSize = Enum.FontSize.Size18
		NewGuiPart146.Text = ""
		NewGuiPart146.TextColor3 = Color3.new(1, 1, 1)

		NewGuiPart147.Name = "enabled"
		NewGuiPart147.Parent = NewGuiPart146
		NewGuiPart147.BackgroundColor3 = Color3.new(0.380392, 0.380392, 0.380392)
		NewGuiPart147.BackgroundTransparency = 0.40000000596046
		NewGuiPart147.BorderSizePixel = 0
		NewGuiPart147.Position = UDim2.new(0, 3, 0, 3)
		NewGuiPart147.Size = UDim2.new(0, 14, 0, 14)
		NewGuiPart147.Font = Enum.Font.SourceSans
		NewGuiPart147.FontSize = Enum.FontSize.Size14
		NewGuiPart147.Text = ""

		NewGuiPart148.Name = "Info"
		NewGuiPart148.Parent = NewGuiPart145
		NewGuiPart148.BackgroundTransparency = 1
		NewGuiPart148.Position = UDim2.new(0, 40, 0, 0)
		NewGuiPart148.Size = UDim2.new(1, -40, 0, 22)
		NewGuiPart148.Font = Enum.Font.SourceSans
		NewGuiPart148.FontSize = Enum.FontSize.Size18
		NewGuiPart148.Text = "Workspace"
		NewGuiPart148.TextColor3 = Color3.new(0, 0, 0)
		NewGuiPart148.TextXAlignment = Enum.TextXAlignment.Left

		NewGuiPart149.Name = "RemoteDebugWindow"
		NewGuiPart149.Parent = NewGuiPart1
		NewGuiPart149.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart149.BackgroundTransparency = 0.10000000149012
		NewGuiPart149.BorderColor3 = Color3.new(0.74902, 0.74902, 0.74902)
		NewGuiPart149.Position = UDim2.new(1, 0, 0, 0)
		NewGuiPart149.Size = UDim2.new(0, 300, 1, 0)

		NewGuiPart161.Name = "GetSetting"
		NewGuiPart161.Parent = NewGuiPart149
		NewGuiPart161.Archivable = true

		NewGuiPart150.Name = "Header"
		NewGuiPart150.Parent = NewGuiPart149
		NewGuiPart150.BackgroundColor3 = Color3.new(0.913726, 0.913726, 0.913726)
		NewGuiPart150.BorderColor3 = Color3.new(0.584314, 0.584314, 0.584314)
		NewGuiPart150.Size = UDim2.new(1, 0, 0, 17)

		NewGuiPart151.Parent = NewGuiPart150
		NewGuiPart151.BackgroundTransparency = 1
		NewGuiPart151.Position = UDim2.new(0, 4, 0, 0)
		NewGuiPart151.Size = UDim2.new(1, -4, 1, 0)
		NewGuiPart151.Font = Enum.Font.SourceSans
		NewGuiPart151.FontSize = Enum.FontSize.Size14
		NewGuiPart151.Text = "Remote Debugger"
		NewGuiPart151.TextColor3 = Color3.new(0, 0, 0)
		NewGuiPart151.TextXAlignment = Enum.TextXAlignment.Left

		NewGuiPart152.Name = "Desc"
		NewGuiPart152.Parent = NewGuiPart149
		NewGuiPart152.BackgroundColor3 = Color3.new(1, 1, 1)
		NewGuiPart152.BackgroundTransparency = 1
		NewGuiPart152.Position = UDim2.new(0, 0, 0, 20)
		NewGuiPart152.Size = UDim2.new(1, 0, 0, 40)
		NewGuiPart152.Font = Enum.Font.SourceSans
		NewGuiPart152.FontSize = Enum.FontSize.Size32
		NewGuiPart152.Text = "Have fun with remotes"
		NewGuiPart152.TextWrapped = true
		return NewGuiPart1
	end
	local D_E_X = CreateGui()
	D_E_X.Parent = game.Players.LocalPlayer.PlayerGui
	spawn(function()
		local Gui = D_E_X


		local IntroFrame = Gui:WaitForChild("IntroFrame")

		local SideMenu = Gui:WaitForChild("SideMenu")
		local OpenToggleButton = Gui:WaitForChild("Toggle")
		local CloseToggleButton = SideMenu:WaitForChild("Toggle")
		local OpenScriptEditorButton = SideMenu:WaitForChild("OpenScriptEditor")

		local ScriptEditor = Gui:WaitForChild("ScriptEditor")

		local SlideOut = SideMenu:WaitForChild("SlideOut")
		local SlideFrame = SlideOut:WaitForChild("SlideFrame")
		local Slant = SideMenu:WaitForChild("Slant")

		local ExplorerButton = SlideFrame:WaitForChild("Explorer")
		local SettingsButton = SlideFrame:WaitForChild("Settings")

		local SelectionBox = Instance.new("SelectionBox")
		SelectionBox.Parent = Gui

		local ExplorerPanel = Gui:WaitForChild("ExplorerPanel")
		local PropertiesFrame = Gui:WaitForChild("PropertiesFrame")
		local SaveMapWindow = Gui:WaitForChild("SaveMapWindow")
		local RemoteDebugWindow = Gui:WaitForChild("RemoteDebugWindow")

		local SettingsPanel = Gui:WaitForChild("SettingsPanel")
		local SettingsListener = SettingsPanel:WaitForChild("GetSetting")
		local SettingTemplate = SettingsPanel:WaitForChild("SettingTemplate")
		local SettingList = SettingsPanel:WaitForChild("SettingList")

		local SaveMapCopyList = SaveMapWindow:WaitForChild("CopyList")
		local SaveMapSettingFrame = SaveMapWindow:WaitForChild("MapSettings")
		local SaveMapName = SaveMapWindow:WaitForChild("FileName")
		local SaveMapButton = SaveMapWindow:WaitForChild("Save")
		local SaveMapCopyTemplate = SaveMapWindow:WaitForChild("Entry")
		local SaveMapSettings = {
			CopyWhat = {
				Workspace = true,
				Lighting = true,
				ReplicatedStorage = true,
				ReplicatedFirst = true,
				StarterPack = true,
				StarterGui = true,
				StarterPlayer = true
			},
			SaveScripts = true,
			SaveTerrain = true,
			LightingProperties = true,
			CameraInstances = true
		}

		local TotallyNotSelectionChanged = ExplorerPanel:WaitForChild("TotallyNotSelectionChanged")
		local TotallyNotGetSelection = ExplorerPanel:WaitForChild("TotallyNotGetSelection")
		local TotallyNotSetSelection = ExplorerPanel:WaitForChild("TotallyNotSetSelection")

		local Player = game:GetService("Players").LocalPlayer
		local Mouse = Player:GetMouse()

		local CurrentWindow = "Nothing c:"
		local Windows = {
			Explorer = {
				ExplorerPanel,
				PropertiesFrame
			},
			Settings = {SettingsPanel},
			SaveMap = {SaveMapWindow},
			Remotes = {RemoteDebugWindow}
		}

		function switchWindows(wName,over)
			if CurrentWindow == wName and not over then return end

			local count = 0

			for i,v in pairs(Windows) do
				count = 0
				if i ~= wName then
					for _,c in pairs(v) do c:TweenPosition(UDim2.new(1, 30, count * 0.5, count * 36), "Out", "Quad", 0.5, true) count = count + 1 end
				end
			end

			count = 0

			if Windows[wName] then
				for _,c in pairs(Windows[wName]) do c:TweenPosition(UDim2.new(1, -300, count * 0.5, count * 36), "Out", "Quad", 0.5, true) count = count + 1 end
			end

			if wName ~= "Nothing c:" then
				CurrentWindow = wName
				for i,v in pairs(SlideFrame:GetChildren()) do
					v.BackgroundTransparency = 1
					v.Icon.ImageColor3 = Color3.new(70/255, 70/255, 70/255)
				end
				if SlideFrame:FindFirstChild(wName) then
					SlideFrame[wName].BackgroundTransparency = 0.5
					SlideFrame[wName].Icon.ImageColor3 = Color3.new(0,0,0)
				end
			end
		end

		function toggleDex(on)
			if on then
				SideMenu:TweenPosition(UDim2.new(1, -330, 0, 0), "Out", "Quad", 0.5, true)
				OpenToggleButton:TweenPosition(UDim2.new(1,0,0,0), "Out", "Quad", 0.5, true)
				switchWindows(CurrentWindow,true)
			else
				SideMenu:TweenPosition(UDim2.new(1, 0, 0, 0), "Out", "Quad", 0.5, true)
				OpenToggleButton:TweenPosition(UDim2.new(1,-30,0,0), "Out", "Quad", 0.5, true)
				switchWindows("Nothing c:")
			end
		end

		local Settings = {
			ClickSelect = false,
			SelBox = false,
			ClearProps = false,
			SelectUngrouped = true,
			SaveInstanceScripts = true
		}

		function ReturnSetting(set)
			if set == "ClearProps" then
				return Settings.ClearProps
			elseif set == "SelectUngrouped" then
				return Settings.SelectUngrouped
			end
		end

		OpenToggleButton.MouseButton1Up:connect(function()
			toggleDex(true)
		end)

		OpenScriptEditorButton.MouseButton1Up:connect(function()
			if OpenScriptEditorButton.Active then
				ScriptEditor.Visible = true
			end
		end)

		CloseToggleButton.MouseButton1Up:connect(function()
			if CloseToggleButton.Active then
				toggleDex(false)
			end
		end)

		for i,v in pairs(SlideFrame:GetChildren()) do
			v.MouseButton1Click:connect(function()
				switchWindows(v.Name)
			end)

			v.MouseEnter:connect(function()v.BackgroundTransparency = 0.5 end)
			v.MouseLeave:connect(function()if CurrentWindow~=v.Name then v.BackgroundTransparency = 1 end end)
		end


		function createSetting(name,interName,defaultOn)
			local newSetting = SettingTemplate:Clone()
			newSetting.Position = UDim2.new(0,0,0,#SettingList:GetChildren() * 60)
			newSetting.SName.Text = name

			local function toggle(on)
				if on then
					newSetting.Change.Bar:TweenPosition(UDim2.new(0,32,0,-2),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,0.25,true)
					newSetting.Change.OnBar:TweenSize(UDim2.new(0,34,0,15),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,0.25,true)
					newSetting.Status.Text = "On"
					Settings[interName] = true
				else
					newSetting.Change.Bar:TweenPosition(UDim2.new(0,-2,0,-2),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,0.25,true)
					newSetting.Change.OnBar:TweenSize(UDim2.new(0,0,0,15),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,0.25,true)
					newSetting.Status.Text = "Off"
					Settings[interName] = false
				end
			end	

			newSetting.Change.MouseButton1Click:connect(function()
				toggle(not Settings[interName])
			end)

			newSetting.Visible = true
			newSetting.Parent = SettingList

			if defaultOn then
				toggle(true)
			end
		end

		createSetting("Click part to select","ClickSelect",false)
		createSetting("Selection Box","SelBox",false)
		createSetting("Clear property value on focus","ClearProps",false)
		createSetting("Select ungrouped models","SelectUngrouped",true)
		createSetting("SaveInstance decompiles scripts","SaveInstanceScripts",true)

		local function getSelection()
			local t = GetSelection:Invoke()
			if t and #t > 0 then
				return t[1]
			else
				return nil
			end
		end

		Mouse.Button1Down:connect(function()
			if CurrentWindow == "Explorer" and Settings.ClickSelect then
				local target = Mouse.Target
				if target then
					SetSelection:Invoke({target})
				end
			end
		end)

		TotallyNotSelectionChanged.Event:connect(function()
			if Settings.SelBox then
				local success,err = pcall(function()
					local selection = getSelection()
					SelectionBox.Adornee = selection
				end)
				if err then
					SelectionBox.Adornee = nil
				end
			end
		end)

		SettingsListener.OnInvoke = ReturnSetting

		-- Map Copier

		function createMapSetting(obj,interName,defaultOn)
			local function toggle(on)
				if on then
					obj.Change.Bar:TweenPosition(UDim2.new(0,32,0,-2),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,0.25,true)
					obj.Change.OnBar:TweenSize(UDim2.new(0,34,0,15),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,0.25,true)
					obj.Status.Text = "On"
					SaveMapSettings[interName] = true
				else
					obj.Change.Bar:TweenPosition(UDim2.new(0,-2,0,-2),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,0.25,true)
					obj.Change.OnBar:TweenSize(UDim2.new(0,0,0,15),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,0.25,true)
					obj.Status.Text = "Off"
					SaveMapSettings[interName] = false
				end
			end	

			obj.Change.MouseButton1Click:connect(function()
				toggle(not SaveMapSettings[interName])
			end)

			obj.Visible = true
			obj.Parent = SaveMapSettingFrame

			if defaultOn then
				toggle(true)
			end
		end

		function createCopyWhatSetting(serv)
			if SaveMapSettings.CopyWhat[serv] then
				local newSetting = SaveMapCopyTemplate:Clone()
				newSetting.Position = UDim2.new(0,0,0,#SaveMapCopyList:GetChildren() * 22 + 5)
				newSetting.Info.Text = serv

				local function toggle(on)
					if on then
						newSetting.Change.enabled.Visible = true
						SaveMapSettings.CopyWhat[serv] = true
					else
						newSetting.Change.enabled.Visible = false
						SaveMapSettings.CopyWhat[serv] = false
					end
				end	

				newSetting.Change.MouseButton1Click:connect(function()
					toggle(not SaveMapSettings.CopyWhat[serv])
				end)

				newSetting.Visible = true
				newSetting.Parent = SaveMapCopyList
			end
		end

		createMapSetting(SaveMapSettingFrame.Scripts,"SaveScripts",true)
		createMapSetting(SaveMapSettingFrame.Terrain,"SaveTerrain",true)
		createMapSetting(SaveMapSettingFrame.Lighting,"LightingProperties",true)
		createMapSetting(SaveMapSettingFrame.CameraInstances,"CameraInstances",true)

		createCopyWhatSetting("Workspace")
		createCopyWhatSetting("Lighting")
		createCopyWhatSetting("ReplicatedStorage")
		createCopyWhatSetting("ReplicatedFirst")
		createCopyWhatSetting("StarterPack")
		createCopyWhatSetting("StarterGui")
		createCopyWhatSetting("StarterPlayer")

		SaveMapName.Text = tostring(game.PlaceId).."MapCopy"

		SaveMapButton.MouseButton1Click:connect(function()
			local copyWhat = {}

			local copyGroup = Instance.new("Model",game.ReplicatedStorage)

			local copyScripts = SaveMapSettings.SaveScripts

			local copyTerrain = SaveMapSettings.SaveTerrain

			local lightingProperties = SaveMapSettings.LightingProperties

			local cameraInstances = SaveMapSettings.CameraInstances

			-----------------------------------------------------------------------------------

			for i,v in pairs(SaveMapSettings.CopyWhat) do
				if v then
					table.insert(copyWhat,i)
				end
			end

			local consoleFunc = printconsole or writeconsole

			if consoleFunc then
				consoleFunc("Raspberry Pi's place copier loaded.")
				consoleFunc("Copying map of game "..tostring(game.PlaceId)..".")
			end

			function archivable(root)
				for i,v in pairs(root:GetChildren()) do
					if not game.Players:GetPlayerFromCharacter(v) then
						v.Archivable = true
						archivable(v)
					end
				end
			end

			function decompileS(root)
				for i,v in pairs(root:GetChildren()) do
					pcall(function()
						if v:IsA("LocalScript") then
							local isDisabled = v.Disabled
							v.Disabled = true
							v.Source = decompile(v)
							v.Disabled = isDisabled

							if v.Source == "" then 
								if consoleFunc then consoleFunc("LocalScript "..v.Name.." had a problem decompiling.") end
							else
								if consoleFunc then consoleFunc("LocalScript "..v.Name.." decompiled.") end
							end
						elseif v:IsA("ModuleScript") then
							v.Source = decompile(v)

							if v.Source == "" then 
								if consoleFunc then consoleFunc("ModuleScript "..v.Name.." had a problem decompiling.") end
							else
								if consoleFunc then consoleFunc("ModuleScript "..v.Name.." decompiled.") end
							end
						end
					end)
					decompileS(v)
				end
			end

			for i,v in pairs(copyWhat) do archivable(game[v]) end

			for j,obj in pairs(copyWhat) do
				if obj ~= "StarterPlayer" then
					local newFolder = Instance.new("Folder",copyGroup)
					newFolder.Name = obj
					for i,v in pairs(game[obj]:GetChildren()) do
						if v ~= copyGroup then
							pcall(function()
								v:Clone().Parent = newFolder
							end)
						end
					end
				else
					local newFolder = Instance.new("Model",copyGroup)
					newFolder.Name = "StarterPlayer"
					for i,v in pairs(game[obj]:GetChildren()) do
						local newObj = Instance.new("Folder",newFolder)
						newObj.Name = v.Name
						for _,c in pairs(v:GetChildren()) do
							if c.Name ~= "ControlScript" and c.Name ~= "CameraScript" then
								c:Clone().Parent = newObj
							end
						end
					end
				end
			end

			if workspace.CurrentCamera and cameraInstances then
				local cameraFolder = Instance.new("Model",copyGroup)
				cameraFolder.Name = "CameraItems"
				for i,v in pairs(workspace.CurrentCamera:GetChildren()) do v:Clone().Parent = cameraFolder end
			end

			if copyTerrain then
				local myTerrain = workspace.Terrain:CopyRegion(workspace.Terrain.MaxExtents)
				myTerrain.Parent = copyGroup
			end

			function saveProp(obj,prop,par)
				local myProp = obj[prop]
				if type(myProp) == "boolean" then
					local newProp = Instance.new("BoolValue",par)
					newProp.Name = prop
					newProp.Value = myProp
				elseif type(myProp) == "number" then
					local newProp = Instance.new("IntValue",par)
					newProp.Name = prop
					newProp.Value = myProp
				elseif type(myProp) == "string" then
					local newProp = Instance.new("StringValue",par)
					newProp.Name = prop
					newProp.Value = myProp
				elseif type(myProp) == "userdata" then -- Assume Color3
					pcall(function()
						local newProp = Instance.new("Color3Value",par)
						newProp.Name = prop
						newProp.Value = myProp
					end)
				end
			end

			if lightingProperties then
				local lightingProps = Instance.new("Model",copyGroup)
				lightingProps.Name = "LightingProperties"

				saveProp(game.Lighting,"Ambient",lightingProps)
				saveProp(game.Lighting,"Brightness",lightingProps)
				saveProp(game.Lighting,"ColorShift_Bottom",lightingProps)
				saveProp(game.Lighting,"ColorShift_Top",lightingProps)
				saveProp(game.Lighting,"GlobalShadows",lightingProps)
				saveProp(game.Lighting,"OutdoorAmbient",lightingProps)
				saveProp(game.Lighting,"Outlines",lightingProps)
				saveProp(game.Lighting,"GeographicLatitude",lightingProps)
				saveProp(game.Lighting,"TimeOfDay",lightingProps)
				saveProp(game.Lighting,"FogColor",lightingProps)
				saveProp(game.Lighting,"FogEnd",lightingProps)
				saveProp(game.Lighting,"FogStart",lightingProps)
			end

			if decompile and copyScripts then
				decompileS(copyGroup)
			end

			if SaveInstance then
				SaveInstance(copyGroup,SaveMapName.Text..".rbxm")
			elseif saveinstance then
				saveinstance(getelysianpath()..SaveMapName.Text..".rbxm",copyGroup)
			end
			--print("Saved!")
			if consoleFunc then
				consoleFunc("The map has been copied.")
			end
			SaveMapButton.Text = "The map has been saved"
			wait(5)
			SaveMapButton.Text = "Save"
		end)

		-- End Copier

		wait()

		IntroFrame:TweenPosition(UDim2.new(1,-300,0,0),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,0.5,true)

		switchWindows("Explorer")

		wait(1)

		SideMenu.Visible = true

		for i = 0,1,0.1 do
			IntroFrame.BackgroundTransparency = i
			IntroFrame.Main.BackgroundTransparency = i
			IntroFrame.Slant.ImageTransparency = i
			IntroFrame.Title.TextTransparency = i
			IntroFrame.Version.TextTransparency = i
			IntroFrame.Creator.TextTransparency = i
			wait()
		end

		IntroFrame.Visible = false

		SlideFrame:TweenPosition(UDim2.new(0,0,0,0),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,0.5,true)
		OpenScriptEditorButton:TweenPosition(UDim2.new(0,0,0,180),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,0.5,true)
		CloseToggleButton:TweenPosition(UDim2.new(0,0,0,210),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,0.5,true)
		Slant:TweenPosition(UDim2.new(0,0,0,240),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,0.5,true)

		wait(0.5)

		for i = 1,0,-0.1 do
			OpenScriptEditorButton.Icon.ImageTransparency = i
			CloseToggleButton.TextTransparency = i
			wait()
		end

		CloseToggleButton.Active = true
		CloseToggleButton.AutoButtonColor = true

		OpenScriptEditorButton.Active = true
		OpenScriptEditorButton.AutoButtonColor = true
	end)
	spawn(function()
		-- initial states
		local Option = {
			-- can modify object parents in the hierarchy
			Modifiable = false;
			-- can select objects
			Selectable = true;
		}

		-- MERELY

		Option.Modifiable = true

		-- END MERELY

		-- general size of GUI objects, in pixels
		local GUI_SIZE = 16
		-- padding between items within each entry
		local ENTRY_PADDING = 1
		-- padding between each entry
		local ENTRY_MARGIN = 1

		local Input = game:GetService("UserInputService")
		local HoldingCtrl = false
		local HoldingShift = false

--[[

# Explorer Panel

A GUI panel that displays the game hierarchy.


## Selection Bindables

- `Function GetSelection ( )`

	Returns an array of objects representing the objects currently
	selected in the panel.

- `Function SetSelection ( Objects selection )`

	Sets the objects that are selected in the panel. `selection` is an array
	of objects.

- `Event SelectionChanged ( )`

	Fired after the selection changes.


## Option Bindables

- `Function GetOption ( string optionName )`

	If `optionName` is given, returns the value of that option. Otherwise,
	returns a table of options and their current values.

- `Function SetOption ( string optionName, bool value )`

	Sets `optionName` to `value`.

	Options:

	- Modifiable

		Whether objects can be modified by the panel.

		Note that modifying objects depends on being able to select them. If
		Selectable is false, then Actions will not be available. Reparenting
		is still possible, but only for the dragged object.

	- Selectable

		Whether objects can be selected.

		If Modifiable is false, then left-clicking will perform a drag
		selection.

## Updates

- 2013-09-18
	- Fixed explorer icons to match studio explorer.

- 2013-09-14
	- Added GetOption and SetOption bindables.
		- Option: Modifiable; sets whether objects can be modified by the panel.
		- Option: Selectable; sets whether objects can be selected.
	- Slight modification to left-click selection behavior.
	- Improved layout and scaling.

- 2013-09-13
	- Added drag to reparent objects.
		- Left-click to select/deselect object.
		- Left-click and drag unselected object to reparent single object.
		- Left-click and drag selected object to move reparent entire selection.
		- Right-click while dragging to cancel.

- 2013-09-11
	- Added explorer panel header with actions.
		- Added Cut action.
		- Added Copy action.
		- Added Paste action.
		- Added Delete action.
	- Added drag selection.
		- Left-click: Add to selection on drag.
		- Right-click: Add to or remove from selection on drag.
	- Ensured SelectionChanged fires only when the selection actually changes.
	- Added documentation and change log.
	- Fixed thread issue.

- 2013-09-09
	- Added basic multi-selection.
		- Left-click to set selection.
		- Right-click to add to or remove from selection.
	- Removed "Selection" ObjectValue.
		- Added GetSelection BindableFunction.
		- Added SetSelection BindableFunction.
		- Added SelectionChanged BindableEvent.
	- Changed font to SourceSans.

- 2013-08-31
	- Improved GUI sizing based off of `GUI_SIZE` constant.
	- Automatic font size detection.

- 2013-08-27
	- Initial explorer panel.


## Todo

- Sorting
	- by ExplorerOrder
	- by children
	- by name
- Drag objects to reparent

]]

		local ENTRY_SIZE = GUI_SIZE + ENTRY_PADDING*2
		local ENTRY_BOUND = ENTRY_SIZE + ENTRY_MARGIN
		local HEADER_SIZE = ENTRY_SIZE*2

		local FONT = 'SourceSans'
		local FONT_SIZE do
			local size = {8,9,10,11,12,14,18,24,36,48}
			local s
			local n = math.huge
			for i = 1,#size do
				if size[i] <= GUI_SIZE then
					FONT_SIZE = i - 1
				end
			end
		end

		local GuiColor = {
			Background      = Color3.new(233/255, 233/255, 233/255);
			Border          = Color3.new(149/255, 149/255, 149/255);
			Selected        = Color3.new( 96/255, 140/255, 211/255);
			BorderSelected  = Color3.new( 86/255, 125/255, 188/255);
			Text            = Color3.new(  0/255,   0/255,   0/255);
			TextDisabled    = Color3.new(128/255, 128/255, 128/255);
			TextSelected    = Color3.new(255/255, 255/255, 255/255);
			Button          = Color3.new(221/255, 221/255, 221/255);
			ButtonBorder    = Color3.new(149/255, 149/255, 149/255);
			ButtonSelected  = Color3.new(255/255,   0/255,   0/255);
			Field           = Color3.new(255/255, 255/255, 255/255);
			FieldBorder     = Color3.new(191/255, 191/255, 191/255);
			TitleBackground = Color3.new(178/255, 178/255, 178/255);
		}

		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------

		function Create(ty,data)
			local obj
			if type(ty) == 'string' then
				obj = Instance.new(ty)
			else
				obj = ty
			end
			for k, v in pairs(data) do
				if type(k) == 'number' then
					v.Parent = obj
				else
					obj[k] = v
				end
			end
			return obj
		end

		local barActive = false
		local activeOptions = {}

		function createDDown(dBut, callback,...)
			if barActive then
				for i,v in pairs(activeOptions) do
					v:Destroy()
				end
				activeOptions = {}
				barActive = false
				return
			else
				barActive = true
			end
			local slots = {...}
			local base = dBut
			for i,v in pairs(slots) do
				local newOption = base:Clone()
				newOption.ZIndex = 5
				newOption.Name = "Option "..tostring(i)
				newOption.Parent = base.Parent.Parent.Parent
				newOption.BackgroundTransparency = 0
				newOption.ZIndex = 2
				table.insert(activeOptions,newOption)
				newOption.Position = UDim2.new(-0.4, dBut.Position.X.Offset, dBut.Position.Y.Scale, dBut.Position.Y.Offset + (#activeOptions * dBut.Size.Y.Offset))
				newOption.Text = slots[i]
				newOption.MouseButton1Down:connect(function()
					dBut.Text = slots[i]
					callback(slots[i])
					for i,v in pairs(activeOptions) do
						v:Destroy()
					end
					activeOptions = {}
					barActive = false
				end)
			end
		end

		-- Connects a function to an event such that it fires asynchronously
		function Connect(event,func)
			return event:connect(function(...)
				local a = {...}
				spawn(function() func(unpack(a)) end)
			end)
		end

		-- returns the ascendant ScreenGui of an object
		function GetScreen(screen)
			if screen == nil then return nil end
			while not screen:IsA("ScreenGui") do
				screen = screen.Parent
				if screen == nil then return nil end
			end
			return screen
		end

		do
			local ZIndexLock = {}
			-- Sets the ZIndex of an object and its descendants. Objects are locked so
			-- that SetZIndexOnChanged doesn't spawn multiple threads that set the
			-- ZIndex of the same object.
			function SetZIndex(object,z)
				if not ZIndexLock[object] then
					ZIndexLock[object] = true
					if object:IsA'GuiObject' then
						object.ZIndex = z
					end
					local children = object:GetChildren()
					for i = 1,#children do
						SetZIndex(children[i],z)
					end
					ZIndexLock[object] = nil
				end
			end

			function SetZIndexOnChanged(object)
				return object.Changed:connect(function(p)
					if p == "ZIndex" then
						SetZIndex(object,object.ZIndex)
					end
				end)
			end
		end

		---- IconMap ----
		-- Image size: 256px x 256px
		-- Icon size: 16px x 16px
		-- Padding between each icon: 2px
		-- Padding around image edge: 1px
		-- Total icons: 14 x 14 (196)
		local Icon do
			local iconMap = 'http://www.roblox.com/asset/?id=' .. MAP_ID
			game:GetService('ContentProvider'):Preload(iconMap)
			local iconDehash do
				-- 14 x 14, 0-based input, 0-based output
				local f=math.floor
				function iconDehash(h)
					return f(h/14%14),f(h%14)
				end
			end

			function Icon(IconFrame,index)
				local row,col = iconDehash(index)
				local mapSize = Vector2.new(256,256)
				local pad,border = 2,1
				local iconSize = 16

				local class = 'Frame'
				if type(IconFrame) == 'string' then
					class = IconFrame
					IconFrame = nil
				end

				if not IconFrame then
					IconFrame = Create(class,{
						Name = "Icon";
						BackgroundTransparency = 1;
						ClipsDescendants = true;
						Create('ImageLabel',{
							Name = "IconMap";
							Active = false;
							BackgroundTransparency = 1;
							Image = iconMap;
							Size = UDim2.new(mapSize.x/iconSize,0,mapSize.y/iconSize,0);
						});
					})
				end

				IconFrame.IconMap.Position = UDim2.new(-col - (pad*(col+1) + border)/iconSize,0,-row - (pad*(row+1) + border)/iconSize,0)
				return IconFrame
			end
		end

		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		---- ScrollBar
		do
			-- AutoButtonColor doesn't always reset properly
			local function ResetButtonColor(button)
				local active = button.Active
				button.Active = not active
				button.Active = active
			end

			local function ArrowGraphic(size,dir,scaled,template)
				local Frame = Create('Frame',{
					Name = "Arrow Graphic";
					BorderSizePixel = 0;
					Size = UDim2.new(0,size,0,size);
					Transparency = 1;
				})
				if not template then
					template = Instance.new("Frame")
					template.BorderSizePixel = 0
				end

				local transform
				if dir == nil or dir == 'Up' then
					function transform(p,s) return p,s end
				elseif dir == 'Down' then
					function transform(p,s) return UDim2.new(0,p.X.Offset,0,size-p.Y.Offset-1),s end
				elseif dir == 'Left' then
					function transform(p,s) return UDim2.new(0,p.Y.Offset,0,p.X.Offset),UDim2.new(0,s.Y.Offset,0,s.X.Offset) end
				elseif dir == 'Right' then
					function transform(p,s) return UDim2.new(0,size-p.Y.Offset-1,0,p.X.Offset),UDim2.new(0,s.Y.Offset,0,s.X.Offset) end
				end

				local scale
				if scaled then
					function scale(p,s) return UDim2.new(p.X.Offset/size,0,p.Y.Offset/size,0),UDim2.new(s.X.Offset/size,0,s.Y.Offset/size,0) end
				else
					function scale(p,s) return p,s end
				end

				local o = math.floor(size/4)
				if size%2 == 0 then
					local n = size/2-1
					for i = 0,n do
						local t = template:Clone()
						local p,s = scale(transform(
							UDim2.new(0,n-i,0,o+i),
							UDim2.new(0,(i+1)*2,0,1)
							))
						t.Position = p
						t.Size = s
						t.Parent = Frame
					end
				else
					local n = (size-1)/2
					for i = 0,n do
						local t = template:Clone()
						local p,s = scale(transform(
							UDim2.new(0,n-i,0,o+i),
							UDim2.new(0,i*2+1,0,1)
							))
						t.Position = p
						t.Size = s
						t.Parent = Frame
					end
				end
				if size%4 > 1 then
					local t = template:Clone()
					local p,s = scale(transform(
						UDim2.new(0,0,0,size-o-1),
						UDim2.new(0,size,0,1)
						))
					t.Position = p
					t.Size = s
					t.Parent = Frame
				end
				return Frame
			end


			local function GripGraphic(size,dir,spacing,scaled,template)
				local Frame = Create('Frame',{
					Name = "Grip Graphic";
					BorderSizePixel = 0;
					Size = UDim2.new(0,size.x,0,size.y);
					Transparency = 1;
				})
				if not template then
					template = Instance.new("Frame")
					template.BorderSizePixel = 0
				end

				spacing = spacing or 2

				local scale
				if scaled then
					function scale(p) return UDim2.new(p.X.Offset/size.x,0,p.Y.Offset/size.y,0) end
				else
					function scale(p) return p end
				end

				if dir == 'Vertical' then
					for i=0,size.x-1,spacing do
						local t = template:Clone()
						t.Size = scale(UDim2.new(0,1,0,size.y))
						t.Position = scale(UDim2.new(0,i,0,0))
						t.Parent = Frame
					end
				elseif dir == nil or dir == 'Horizontal' then
					for i=0,size.y-1,spacing do
						local t = template:Clone()
						t.Size = scale(UDim2.new(0,size.x,0,1))
						t.Position = scale(UDim2.new(0,0,0,i))
						t.Parent = Frame
					end
				end

				return Frame
			end

			local mt = {
				__index = {
					GetScrollPercent = function(self)
						return self.ScrollIndex/(self.TotalSpace-self.VisibleSpace)
					end;
					CanScrollDown = function(self)
						return self.ScrollIndex + self.VisibleSpace < self.TotalSpace
					end;
					CanScrollUp = function(self)
						return self.ScrollIndex > 0
					end;
					ScrollDown = function(self)
						self.ScrollIndex = self.ScrollIndex + self.PageIncrement
						self:Update()
					end;
					ScrollUp = function(self)
						self.ScrollIndex = self.ScrollIndex - self.PageIncrement
						self:Update()
					end;
					ScrollTo = function(self,index)
						self.ScrollIndex = index
						self:Update()
					end;
					SetScrollPercent = function(self,percent)
						self.ScrollIndex = math.floor((self.TotalSpace - self.VisibleSpace)*percent + 0.5)
						self:Update()
					end;
				};
			}
			mt.__index.CanScrollRight = mt.__index.CanScrollDown
			mt.__index.CanScrollLeft = mt.__index.CanScrollUp
			mt.__index.ScrollLeft = mt.__index.ScrollUp
			mt.__index.ScrollRight = mt.__index.ScrollDown

			function ScrollBar(horizontal)
				-- create row scroll bar
				local ScrollFrame = Create('Frame',{
					Name = "ScrollFrame";
					Position = horizontal and UDim2.new(0,0,1,-GUI_SIZE) or UDim2.new(1,-GUI_SIZE,0,0);
					Size = horizontal and UDim2.new(1,0,0,GUI_SIZE) or UDim2.new(0,GUI_SIZE,1,0);
					BackgroundTransparency = 1;
					Create('ImageButton',{
						Name = "ScrollDown";
						Position = horizontal and UDim2.new(1,-GUI_SIZE,0,0) or UDim2.new(0,0,1,-GUI_SIZE);
						Size = UDim2.new(0, GUI_SIZE, 0, GUI_SIZE);
						BackgroundColor3 = GuiColor.Button;
						BorderColor3 = GuiColor.Border;
						--BorderSizePixel = 0;
					});
					Create('ImageButton',{
						Name = "ScrollUp";
						Size = UDim2.new(0, GUI_SIZE, 0, GUI_SIZE);
						BackgroundColor3 = GuiColor.Button;
						BorderColor3 = GuiColor.Border;
						--BorderSizePixel = 0;
					});
					Create('ImageButton',{
						Name = "ScrollBar";
						Size = horizontal and UDim2.new(1,-GUI_SIZE*2,1,0) or UDim2.new(1,0,1,-GUI_SIZE*2);
						Position = horizontal and UDim2.new(0,GUI_SIZE,0,0) or UDim2.new(0,0,0,GUI_SIZE);
						AutoButtonColor = false;
						BackgroundColor3 = Color3.new(0.94902, 0.94902, 0.94902);
						BorderColor3 = GuiColor.Border;
						--BorderSizePixel = 0;
						Create('ImageButton',{
							Name = "ScrollThumb";
							AutoButtonColor = false;
							Size = UDim2.new(0, GUI_SIZE, 0, GUI_SIZE);
							BackgroundColor3 = GuiColor.Button;
							BorderColor3 = GuiColor.Border;
							--BorderSizePixel = 0;
						});
					});
				})

				local graphicTemplate = Create('Frame',{
					Name="Graphic";
					BorderSizePixel = 0;
					BackgroundColor3 = GuiColor.Border;
				})
				local graphicSize = GUI_SIZE/2

				local ScrollDownFrame = ScrollFrame.ScrollDown
				local ScrollDownGraphic = ArrowGraphic(graphicSize,horizontal and 'Right' or 'Down',true,graphicTemplate)
				ScrollDownGraphic.Position = UDim2.new(0.5,-graphicSize/2,0.5,-graphicSize/2)
				ScrollDownGraphic.Parent = ScrollDownFrame
				local ScrollUpFrame = ScrollFrame.ScrollUp
				local ScrollUpGraphic = ArrowGraphic(graphicSize,horizontal and 'Left' or 'Up',true,graphicTemplate)
				ScrollUpGraphic.Position = UDim2.new(0.5,-graphicSize/2,0.5,-graphicSize/2)
				ScrollUpGraphic.Parent = ScrollUpFrame
				local ScrollBarFrame = ScrollFrame.ScrollBar
				local ScrollThumbFrame = ScrollBarFrame.ScrollThumb
				do
					local size = GUI_SIZE*3/8
					local Decal = GripGraphic(Vector2.new(size,size),horizontal and 'Vertical' or 'Horizontal',2,graphicTemplate)
					Decal.Position = UDim2.new(0.5,-size/2,0.5,-size/2)
					Decal.Parent = ScrollThumbFrame
				end

				local Class = setmetatable({
					GUI = ScrollFrame;
					ScrollIndex = 0;
					VisibleSpace = 0;
					TotalSpace = 0;
					PageIncrement = 1;
				},mt)

				local UpdateScrollThumb
				if horizontal then
					function UpdateScrollThumb()
						ScrollThumbFrame.Size = UDim2.new(Class.VisibleSpace/Class.TotalSpace,0,0,GUI_SIZE)
						if ScrollThumbFrame.AbsoluteSize.x < GUI_SIZE then
							ScrollThumbFrame.Size = UDim2.new(0,GUI_SIZE,0,GUI_SIZE)
						end
						local barSize = ScrollBarFrame.AbsoluteSize.x
						ScrollThumbFrame.Position = UDim2.new(Class:GetScrollPercent()*(barSize - ScrollThumbFrame.AbsoluteSize.x)/barSize,0,0,0)
					end
				else
					function UpdateScrollThumb()
						ScrollThumbFrame.Size = UDim2.new(0,GUI_SIZE,Class.VisibleSpace/Class.TotalSpace,0)
						if ScrollThumbFrame.AbsoluteSize.y < GUI_SIZE then
							ScrollThumbFrame.Size = UDim2.new(0,GUI_SIZE,0,GUI_SIZE)
						end
						local barSize = ScrollBarFrame.AbsoluteSize.y
						ScrollThumbFrame.Position = UDim2.new(0,0,Class:GetScrollPercent()*(barSize - ScrollThumbFrame.AbsoluteSize.y)/barSize,0)
					end
				end

				local lastDown
				local lastUp
				local scrollStyle = {BackgroundColor3=GuiColor.Border,BackgroundTransparency=0}
				local scrollStyle_ds = {BackgroundColor3=GuiColor.Border,BackgroundTransparency=0.7}

				local function Update()
					local t = Class.TotalSpace
					local v = Class.VisibleSpace
					local s = Class.ScrollIndex
					if v <= t then
						if s > 0 then
							if s + v > t then
								Class.ScrollIndex = t - v
							end
						else
							Class.ScrollIndex = 0
						end
					else
						Class.ScrollIndex = 0
					end

					if Class.UpdateCallback then
						if Class.UpdateCallback(Class) == false then
							return
						end
					end

					local down = Class:CanScrollDown()
					local up = Class:CanScrollUp()
					if down ~= lastDown then
						lastDown = down
						ScrollDownFrame.Active = down
						ScrollDownFrame.AutoButtonColor = down
						local children = ScrollDownGraphic:GetChildren()
						local style = down and scrollStyle or scrollStyle_ds
						for i = 1,#children do
							Create(children[i],style)
						end
					end
					if up ~= lastUp then
						lastUp = up
						ScrollUpFrame.Active = up
						ScrollUpFrame.AutoButtonColor = up
						local children = ScrollUpGraphic:GetChildren()
						local style = up and scrollStyle or scrollStyle_ds
						for i = 1,#children do
							Create(children[i],style)
						end
					end
					ScrollThumbFrame.Visible = down or up
					UpdateScrollThumb()
				end
				Class.Update = Update

				SetZIndexOnChanged(ScrollFrame)

				local MouseDrag = Create('ImageButton',{
					Name = "MouseDrag";
					Position = UDim2.new(-0.25,0,-0.25,0);
					Size = UDim2.new(1.5,0,1.5,0);
					Transparency = 1;
					AutoButtonColor = false;
					Active = true;
					ZIndex = 10;
				})

				local scrollEventID = 0
				ScrollDownFrame.MouseButton1Down:connect(function()
					scrollEventID = tick()
					local current = scrollEventID
					local up_con
					up_con = MouseDrag.MouseButton1Up:connect(function()
						scrollEventID = tick()
						MouseDrag.Parent = nil
						ResetButtonColor(ScrollDownFrame)
						up_con:disconnect(); drag = nil
					end)
					MouseDrag.Parent = GetScreen(ScrollFrame)
					Class:ScrollDown()
					wait(0.2) -- delay before auto scroll
					while scrollEventID == current do
						Class:ScrollDown()
						if not Class:CanScrollDown() then break end
						wait()
					end
				end)

				ScrollDownFrame.MouseButton1Up:connect(function()
					scrollEventID = tick()
				end)

				ScrollUpFrame.MouseButton1Down:connect(function()
					scrollEventID = tick()
					local current = scrollEventID
					local up_con
					up_con = MouseDrag.MouseButton1Up:connect(function()
						scrollEventID = tick()
						MouseDrag.Parent = nil
						ResetButtonColor(ScrollUpFrame)
						up_con:disconnect(); drag = nil
					end)
					MouseDrag.Parent = GetScreen(ScrollFrame)
					Class:ScrollUp()
					wait(0.2)
					while scrollEventID == current do
						Class:ScrollUp()
						if not Class:CanScrollUp() then break end
						wait()
					end
				end)

				ScrollUpFrame.MouseButton1Up:connect(function()
					scrollEventID = tick()
				end)

				if horizontal then
					ScrollBarFrame.MouseButton1Down:connect(function(x,y)
						scrollEventID = tick()
						local current = scrollEventID
						local up_con
						up_con = MouseDrag.MouseButton1Up:connect(function()
							scrollEventID = tick()
							MouseDrag.Parent = nil
							ResetButtonColor(ScrollUpFrame)
							up_con:disconnect(); drag = nil
						end)
						MouseDrag.Parent = GetScreen(ScrollFrame)
						if x > ScrollThumbFrame.AbsolutePosition.x then
							Class:ScrollTo(Class.ScrollIndex + Class.VisibleSpace)
							wait(0.2)
							while scrollEventID == current do
								if x < ScrollThumbFrame.AbsolutePosition.x + ScrollThumbFrame.AbsoluteSize.x then break end
								Class:ScrollTo(Class.ScrollIndex + Class.VisibleSpace)
								wait()
							end
						else
							Class:ScrollTo(Class.ScrollIndex - Class.VisibleSpace)
							wait(0.2)
							while scrollEventID == current do
								if x > ScrollThumbFrame.AbsolutePosition.x then break end
								Class:ScrollTo(Class.ScrollIndex - Class.VisibleSpace)
								wait()
							end
						end
					end)
				else
					ScrollBarFrame.MouseButton1Down:connect(function(x,y)
						scrollEventID = tick()
						local current = scrollEventID
						local up_con
						up_con = MouseDrag.MouseButton1Up:connect(function()
							scrollEventID = tick()
							MouseDrag.Parent = nil
							ResetButtonColor(ScrollUpFrame)
							up_con:disconnect(); drag = nil
						end)
						MouseDrag.Parent = GetScreen(ScrollFrame)
						if y > ScrollThumbFrame.AbsolutePosition.y then
							Class:ScrollTo(Class.ScrollIndex + Class.VisibleSpace)
							wait(0.2)
							while scrollEventID == current do
								if y < ScrollThumbFrame.AbsolutePosition.y + ScrollThumbFrame.AbsoluteSize.y then break end
								Class:ScrollTo(Class.ScrollIndex + Class.VisibleSpace)
								wait()
							end
						else
							Class:ScrollTo(Class.ScrollIndex - Class.VisibleSpace)
							wait(0.2)
							while scrollEventID == current do
								if y > ScrollThumbFrame.AbsolutePosition.y then break end
								Class:ScrollTo(Class.ScrollIndex - Class.VisibleSpace)
								wait()
							end
						end
					end)
				end

				if horizontal then
					ScrollThumbFrame.MouseButton1Down:connect(function(x,y)
						scrollEventID = tick()
						local mouse_offset = x - ScrollThumbFrame.AbsolutePosition.x
						local drag_con
						local up_con
						drag_con = MouseDrag.MouseMoved:connect(function(x,y)
							local bar_abs_pos = ScrollBarFrame.AbsolutePosition.x
							local bar_drag = ScrollBarFrame.AbsoluteSize.x - ScrollThumbFrame.AbsoluteSize.x
							local bar_abs_one = bar_abs_pos + bar_drag
							x = x - mouse_offset
							x = x < bar_abs_pos and bar_abs_pos or x > bar_abs_one and bar_abs_one or x
							x = x - bar_abs_pos
							Class:SetScrollPercent(x/(bar_drag))
						end)
						up_con = MouseDrag.MouseButton1Up:connect(function()
							scrollEventID = tick()
							MouseDrag.Parent = nil
							ResetButtonColor(ScrollThumbFrame)
							drag_con:disconnect(); drag_con = nil
							up_con:disconnect(); drag = nil
						end)
						MouseDrag.Parent = GetScreen(ScrollFrame)
					end)
				else
					ScrollThumbFrame.MouseButton1Down:connect(function(x,y)
						scrollEventID = tick()
						local mouse_offset = y - ScrollThumbFrame.AbsolutePosition.y
						local drag_con
						local up_con
						drag_con = MouseDrag.MouseMoved:connect(function(x,y)
							local bar_abs_pos = ScrollBarFrame.AbsolutePosition.y
							local bar_drag = ScrollBarFrame.AbsoluteSize.y - ScrollThumbFrame.AbsoluteSize.y
							local bar_abs_one = bar_abs_pos + bar_drag
							y = y - mouse_offset
							y = y < bar_abs_pos and bar_abs_pos or y > bar_abs_one and bar_abs_one or y
							y = y - bar_abs_pos
							Class:SetScrollPercent(y/(bar_drag))
						end)
						up_con = MouseDrag.MouseButton1Up:connect(function()
							scrollEventID = tick()
							MouseDrag.Parent = nil
							ResetButtonColor(ScrollThumbFrame)
							drag_con:disconnect(); drag_con = nil
							up_con:disconnect(); drag = nil
						end)
						MouseDrag.Parent = GetScreen(ScrollFrame)
					end)
				end

				function Class:Destroy()
					ScrollFrame:Destroy()
					MouseDrag:Destroy()
					for k in pairs(Class) do
						Class[k] = nil
					end
					setmetatable(Class,nil)
				end

				Update()

				return Class
			end
		end

		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		---- Explorer panel

		local explorerPanel = D_E_X.ExplorerPanel
		Create(explorerPanel,{
			BackgroundColor3 = GuiColor.Field;
			BorderColor3 = GuiColor.Border;
			Active = true;
		})

		local SettingsRemote = explorerPanel.Parent:WaitForChild("SettingsPanel"):WaitForChild("GetSetting")
		local GetApiRemote = explorerPanel.Parent:WaitForChild("PropertiesFrame"):WaitForChild("GetApi")
		local GetAwaitRemote = explorerPanel.Parent:WaitForChild("PropertiesFrame"):WaitForChild("GetAwaiting")
		local bindSetAwaiting = explorerPanel.Parent:WaitForChild("PropertiesFrame"):WaitForChild("SetAwaiting")

		local SaveInstanceWindow = explorerPanel.Parent:WaitForChild("SaveInstance")
		local ConfirmationWindow = explorerPanel.Parent:WaitForChild("Confirmation")
		local CautionWindow = explorerPanel.Parent:WaitForChild("Caution")
		local TableCautionWindow = explorerPanel.Parent:WaitForChild("TableCaution")

		local RemoteWindow = explorerPanel.Parent:WaitForChild("CallRemote")

		local ScriptEditor = explorerPanel.Parent:WaitForChild("ScriptEditor")
		local ScriptEditorEvent = ScriptEditor:WaitForChild("OpenScript")

		local CurrentSaveInstanceWindow
		local CurrentRemoteWindow

		local lastSelectedNode

		local DexStorage
		local DexStorageMain
		local DexStorageEnabled

		if saveinstance then DexStorageEnabled = true end

		if DexStorageEnabled then
			DexStorage = Instance.new("Folder")
			DexStorage.Name = "Dex"
			DexStorageMain = Instance.new("Folder",DexStorage)
			DexStorageMain.Name = "DexStorage"
		end

		local NilStorage
		local NilStorageMain
		local NilStorageEnabled

		if get_nil_instances and IfThisFunctionWasStableEnough then NilStorageEnabled = true end

		if NilStorageEnabled then
			NilStorage = Instance.new("Folder")
			NilStorage.Name = "Dex Internal Storage"
			NilStorageMain = Instance.new("Folder",NilStorage)
			NilStorageMain.Name = "Nil Instances"
		end

		local listFrame = Create('Frame',{
			Name = "List";
			BackgroundTransparency = 1;
			ClipsDescendants = true;
			Position = UDim2.new(0,0,0,HEADER_SIZE);
			Size = UDim2.new(1,-GUI_SIZE,1,-HEADER_SIZE);
			Parent = explorerPanel;
		})

		local scrollBar = ScrollBar(false)
		scrollBar.PageIncrement = 1
		Create(scrollBar.GUI,{
			Position = UDim2.new(1,-GUI_SIZE,0,HEADER_SIZE);
			Size = UDim2.new(0,GUI_SIZE,1,-HEADER_SIZE);
			Parent = explorerPanel;
		})

		local scrollBarH = ScrollBar(true)
		scrollBarH.PageIncrement = GUI_SIZE
		Create(scrollBarH.GUI,{
			Position = UDim2.new(0,0,1,-GUI_SIZE);
			Size = UDim2.new(1,-GUI_SIZE,0,GUI_SIZE);
			Visible = false;
			Parent = explorerPanel;
		})

		local headerFrame = Create('Frame',{
			Name = "Header";
			BackgroundColor3 = GuiColor.Background;
			BorderColor3 = GuiColor.Border;
			Position = UDim2.new(0,0,0,0);
			Size = UDim2.new(1,0,0,HEADER_SIZE);
			Parent = explorerPanel;
			Create('TextLabel',{
				Text = "Explorer";
				BackgroundTransparency = 1;
				TextColor3 = GuiColor.Text;
				TextXAlignment = 'Left';
				Font = FONT;
				FontSize = FONT_SIZE;
				Position = UDim2.new(0,4,0,0);
				Size = UDim2.new(1,-4,0.5,0);
			});
		})

		local explorerFilter = 	Create('TextBox',{
			Text = "Filter Workspace";
			BackgroundTransparency = 0.8;
			TextColor3 = GuiColor.Text;
			TextXAlignment = 'Left';
			Font = FONT;
			FontSize = FONT_SIZE;
			Position = UDim2.new(0,4,0.5,0);
			Size = UDim2.new(1,-8,0.5,-2);
		});
		explorerFilter.Parent = headerFrame

		SetZIndexOnChanged(explorerPanel)

		local function CreateColor3(r, g, b) return Color3.new(r/255,g/255,b/255) end

		local Styles = {
			Font = Enum.Font.Arial;
			Margin = 5;
			Black = CreateColor3(0,0,0);
			White = CreateColor3(255,255,255);
		}

		local DropDown = {
			Font = Styles.Font;
			FontSize = Enum.FontSize.Size14;
			TextColor = CreateColor3(0,0,0);
			TextColorOver = Styles.White;
			TextXAlignment = Enum.TextXAlignment.Left;
			Height = 20;
			BackColor = Styles.White;
			BackColorOver = CreateColor3(86,125,188);
			BorderColor = CreateColor3(216,216,216);
			BorderSizePixel = 2;
			ArrowColor = CreateColor3(160,160,160);
			ArrowColorOver = Styles.Black;
		}

		local Row = {
			Font = Styles.Font;
			FontSize = Enum.FontSize.Size14;
			TextXAlignment = Enum.TextXAlignment.Left;
			TextColor = Styles.Black;
			TextColorOver = Styles.White;
			TextLockedColor = CreateColor3(120,120,120);
			Height = 24;
			BorderColor = CreateColor3(216,216,216);
			BackgroundColor = Styles.White;
			BackgroundColorAlternate = CreateColor3(246,246,246);
			BackgroundColorMouseover = CreateColor3(211,224,244);
			TitleMarginLeft = 15;
		}

		local currentRightClickMenu
		local CurrentInsertObjectWindow
		local CurrentFunctionCallerWindow

		local RbxApi

		function ClassCanCreate(IName)
			local success,err = pcall(function() Instance.new(IName) end)
			if err then
				return false
			else
				return true
			end
		end

		function GetClasses()
			if RbxApi == nil then return {} end
			local classTable = {}
			for i,v in pairs(RbxApi.Classes) do
				if ClassCanCreate(v.Name) then
					table.insert(classTable,v.Name)
				end
			end
			return classTable
		end

		local function sortAlphabetic(t, property)
			table.sort(t, 
				function(x,y) return x[property] < y[property]
				end)
		end

		local function FunctionIsHidden(functionData)
			local tags = functionData["tags"]
			for _,name in pairs(tags) do
				if name == "deprecated"
					or name == "hidden"
					or name == "writeonly" then
					return true
				end
			end
			return false
		end

		local function GetAllFunctions(className)
			local class = RbxApi.Classes[className]
			local functions = {}

			if not class then return functions end

			while class do
				if class.Name == "Instance" then break end
				for _,nextFunction in pairs(class.Functions) do
					if not FunctionIsHidden(nextFunction) then
						table.insert(functions, nextFunction)
					end
				end
				class = RbxApi.Classes[class.Superclass]
			end

			sortAlphabetic(functions, "Name")

			return functions
		end

		function GetFunctions()
			if RbxApi == nil then return {} end
			local List = SelectionVar():Get()

			if #List == 0 then return end

			local MyObject = List[1]

			local functionTable = {}
			for i,v in pairs(GetAllFunctions(MyObject.ClassName)) do
				table.insert(functionTable,v)
			end
			return functionTable
		end

		function CreateInsertObjectMenu(choices, currentChoice, readOnly, onClick)
			local mouse = game.Players.LocalPlayer:GetMouse()
			local totalSize = explorerPanel.Parent.AbsoluteSize.y
			if #choices == 0 then return end

			table.sort(choices, function(a,b) return a < b end)

			local frame = Instance.new("Frame")	
			frame.Name = "InsertObject"
			frame.Size = UDim2.new(0, 200, 1, 0)
			frame.BackgroundTransparency = 1
			frame.Active = true

			local menu = nil
			local arrow = nil
			local expanded = false
			local margin = DropDown.BorderSizePixel;

	--[[
	local button = Instance.new("TextButton")
	button.Font = Row.Font
	button.FontSize = Row.FontSize
	button.TextXAlignment = Row.TextXAlignment
	button.BackgroundTransparency = 1
	button.TextColor3 = Row.TextColor
	if readOnly then
		button.TextColor3 = Row.TextLockedColor
	end
	button.Text = currentChoice
	button.Size = UDim2.new(1, -2 * Styles.Margin, 1, 0)
	button.Position = UDim2.new(0, Styles.Margin, 0, 0)
	button.Parent = frame
	--]]

			local function hideMenu()
				expanded = false
				--showArrow(DropDown.ArrowColor)
				if frame then 
					--frame:Destroy()
					CurrentInsertObjectWindow.Visible = false
				end
			end

			local function showMenu()
				expanded = true
				menu = Instance.new("ScrollingFrame")
				menu.Size = UDim2.new(0,200,1,0)
				menu.CanvasSize = UDim2.new(0, 200, 0, #choices * DropDown.Height)
				menu.Position = UDim2.new(0, margin, 0, 0)
				menu.BackgroundTransparency = 0
				menu.BackgroundColor3 = DropDown.BackColor
				menu.BorderColor3 = DropDown.BorderColor
				menu.BorderSizePixel = DropDown.BorderSizePixel
				menu.TopImage = "rbxasset://textures/blackBkg_square.png"
				menu.MidImage = "rbxasset://textures/blackBkg_square.png"
				menu.BottomImage = "rbxasset://textures/blackBkg_square.png"
				menu.Active = true
				menu.ZIndex = 5
				menu.Parent = frame

				--local parentFrameHeight = script.Parent.List.Size.Y.Offset
				--local rowHeight = mouse.Y
				--if (rowHeight + menu.Size.Y.Offset) > parentFrameHeight then
				--	menu.Position = UDim2.new(0, margin, 0, -1 * (#choices * DropDown.Height) - margin)
				--end

				local function choice(name)
					onClick(name)
					hideMenu()
				end

				for i,name in pairs(choices) do
					local option = CreateRightClickMenuItem(name, function()
						choice(name)
					end,1)
					option.Size = UDim2.new(1, 0, 0, 20)
					option.Position = UDim2.new(0, 0, 0, (i - 1) * DropDown.Height)
					option.ZIndex = menu.ZIndex
					option.Parent = menu
				end
			end


			showMenu()


			return frame
		end

		function CreateFunctionCallerMenu(choices, currentChoice, readOnly, onClick)
			local mouse = game.Players.LocalPlayer:GetMouse()
			local totalSize = explorerPanel.Parent.AbsoluteSize.y
			if #choices == 0 then return end

			table.sort(choices, function(a,b) return a.Name < b.Name end)

			local frame = Instance.new("Frame")	
			frame.Name = "InsertObject"
			frame.Size = UDim2.new(0, 200, 1, 0)
			frame.BackgroundTransparency = 1
			frame.Active = true

			local menu = nil
			local arrow = nil
			local expanded = false
			local margin = DropDown.BorderSizePixel;

			local function hideMenu()
				expanded = false
				--showArrow(DropDown.ArrowColor)
				if frame then 
					--frame:Destroy()
					CurrentInsertObjectWindow.Visible = false
				end
			end

			local function showMenu()
				expanded = true
				menu = Instance.new("ScrollingFrame")
				menu.Size = UDim2.new(0,300,1,0)
				menu.CanvasSize = UDim2.new(0, 300, 0, #choices * DropDown.Height)
				menu.Position = UDim2.new(0, margin, 0, 0)
				menu.BackgroundTransparency = 0
				menu.BackgroundColor3 = DropDown.BackColor
				menu.BorderColor3 = DropDown.BorderColor
				menu.BorderSizePixel = DropDown.BorderSizePixel
				menu.TopImage = "rbxasset://textures/blackBkg_square.png"
				menu.MidImage = "rbxasset://textures/blackBkg_square.png"
				menu.BottomImage = "rbxasset://textures/blackBkg_square.png"
				menu.Active = true
				menu.ZIndex = 5
				menu.Parent = frame

				--local parentFrameHeight = script.Parent.List.Size.Y.Offset
				--local rowHeight = mouse.Y
				--if (rowHeight + menu.Size.Y.Offset) > parentFrameHeight then
				--	menu.Position = UDim2.new(0, margin, 0, -1 * (#choices * DropDown.Height) - margin)
				--end

				local function GetParameters(functionData)
					local paraString = ""
					paraString = paraString.."("
					for i,v in pairs(functionData.Arguments) do
						paraString = paraString..v.Type.." "..v.Name
						if i < #functionData.Arguments then
							paraString = paraString..", "
						end
					end
					paraString = paraString..")"
					return paraString
				end

				local function choice(name)
					onClick(name)
					hideMenu()
				end

				for i,name in pairs(choices) do
					local option = CreateRightClickMenuItem(name.ReturnType.." "..name.Name..GetParameters(name), function()
						choice(name)
					end,2)
					option.Size = UDim2.new(1, 0, 0, 20)
					option.Position = UDim2.new(0, 0, 0, (i - 1) * DropDown.Height)
					option.ZIndex = menu.ZIndex
					option.Parent = menu
				end
			end


			showMenu()


			return frame
		end

		function CreateInsertObject()
			if not CurrentInsertObjectWindow then return end
			CurrentInsertObjectWindow.Visible = true
			if currentRightClickMenu and CurrentInsertObjectWindow.Visible then
				CurrentInsertObjectWindow.Position = UDim2.new(0,currentRightClickMenu.Position.X.Offset-currentRightClickMenu.Size.X.Offset-2,0,0)
			end
			if CurrentInsertObjectWindow.Visible then
				CurrentInsertObjectWindow.Parent = explorerPanel.Parent
			end
		end

		function CreateFunctionCaller()
			if CurrentFunctionCallerWindow then
				CurrentFunctionCallerWindow:Destroy()
				CurrentFunctionCallerWindow = nil
			end
			CurrentFunctionCallerWindow = CreateFunctionCallerMenu(
				GetFunctions(),
				"",
				false,
				function(option)
					CurrentFunctionCallerWindow:Destroy()
					CurrentFunctionCallerWindow = nil
					local list = SelectionVar():Get()
					for i = 1,#list do
						pcall(function() Instance.new(option,list[i]) end)
					end
					print(option.Name .. " selected to be called. Function caller being added soon, please wait!")
					--CallFunction()
					DestroyRightClick()
				end
			)
			if currentRightClickMenu and CurrentFunctionCallerWindow then
				CurrentFunctionCallerWindow.Position = UDim2.new(0,currentRightClickMenu.Position.X.Offset-currentRightClickMenu.Size.X.Offset*1.5-2,0,0)
			end
			if CurrentFunctionCallerWindow then
				CurrentFunctionCallerWindow.Parent = explorerPanel.Parent
			end
		end

		function CreateRightClickMenuItem(text, onClick, insObj)
			local button = Instance.new("TextButton")
			button.Font = DropDown.Font
			button.FontSize = DropDown.FontSize
			button.TextColor3 = DropDown.TextColor
			button.TextXAlignment = DropDown.TextXAlignment
			button.BackgroundColor3 = DropDown.BackColor
			button.AutoButtonColor = false
			button.BorderSizePixel = 0
			button.Active = true
			button.Text = text

			if insObj == 1 then
				local newIcon = Icon(nil,ExplorerIndex[text] or 0)
				newIcon.Position = UDim2.new(0,0,0,2)
				newIcon.Size = UDim2.new(0,16,0,16)
				newIcon.IconMap.ZIndex = 5
				newIcon.Parent = button
				button.Text = "\t\t"..button.Text
			elseif insObj == 2 then
				button.FontSize = Enum.FontSize.Size11
			end

			button.MouseEnter:connect(function()
				button.TextColor3 = DropDown.TextColorOver
				button.BackgroundColor3 = DropDown.BackColorOver
				if not insObj and CurrentInsertObjectWindow then
					if CurrentInsertObjectWindow.Visible == false and button.Text == "Insert Object" then
						CreateInsertObject()
					elseif CurrentInsertObjectWindow.Visible and button.Text ~= "Insert Object" then
						CurrentInsertObjectWindow.Visible = false
					end
				end
				if not insObj then
					if CurrentFunctionCallerWindow and button.Text ~= "Call Function" then
						CurrentFunctionCallerWindow:Destroy()
						CurrentFunctionCallerWindow = nil
					elseif button.Text == "Call Function" then
						CreateFunctionCaller()
					end
				end
			end)
			button.MouseLeave:connect(function()
				button.TextColor3 = DropDown.TextColor
				button.BackgroundColor3 = DropDown.BackColor
			end)
			button.MouseButton1Click:connect(function()
				button.TextColor3 = DropDown.TextColor
				button.BackgroundColor3 = DropDown.BackColor
				onClick(text)
			end)	
			return button
		end

		function CreateRightClickMenu(choices, currentChoice, readOnly, onClick)
			local mouse = game.Players.LocalPlayer:GetMouse()

			local frame = Instance.new("Frame")	
			frame.Name = "DropDown"
			frame.Size = UDim2.new(0, 200, 1, 0)
			frame.BackgroundTransparency = 1
			frame.Active = true

			local menu = nil
			local arrow = nil
			local expanded = false
			local margin = DropDown.BorderSizePixel;

	--[[
	local button = Instance.new("TextButton")
	button.Font = Row.Font
	button.FontSize = Row.FontSize
	button.TextXAlignment = Row.TextXAlignment
	button.BackgroundTransparency = 1
	button.TextColor3 = Row.TextColor
	if readOnly then
		button.TextColor3 = Row.TextLockedColor
	end
	button.Text = currentChoice
	button.Size = UDim2.new(1, -2 * Styles.Margin, 1, 0)
	button.Position = UDim2.new(0, Styles.Margin, 0, 0)
	button.Parent = frame
	--]]

			local function hideMenu()
				expanded = false
				--showArrow(DropDown.ArrowColor)
				if frame then 
					frame:Destroy()
					DestroyRightClick()
				end
			end

			local function showMenu()
				expanded = true
				menu = Instance.new("Frame")
				menu.Size = UDim2.new(0, 200, 0, #choices * DropDown.Height)
				menu.Position = UDim2.new(0, margin, 0, 5)
				menu.BackgroundTransparency = 0
				menu.BackgroundColor3 = DropDown.BackColor
				menu.BorderColor3 = DropDown.BorderColor
				menu.BorderSizePixel = DropDown.BorderSizePixel
				menu.Active = true
				menu.ZIndex = 5
				menu.Parent = frame

				--local parentFrameHeight = script.Parent.List.Size.Y.Offset
				--local rowHeight = mouse.Y
				--if (rowHeight + menu.Size.Y.Offset) > parentFrameHeight then
				--	menu.Position = UDim2.new(0, margin, 0, -1 * (#choices * DropDown.Height) - margin)
				--end

				local function choice(name)
					onClick(name)
					hideMenu()
				end

				for i,name in pairs(choices) do
					local option = CreateRightClickMenuItem(name, function()
						choice(name)
					end)
					option.Size = UDim2.new(1, 0, 0, 20)
					option.Position = UDim2.new(0, 0, 0, (i - 1) * DropDown.Height)
					option.ZIndex = menu.ZIndex
					option.Parent = menu
				end
			end


			showMenu()


			return frame
		end

		function checkMouseInGui(gui)
			if gui == nil then return false end
			local plrMouse = game.Players.LocalPlayer:GetMouse()
			local guiPosition = gui.AbsolutePosition
			local guiSize = gui.AbsoluteSize	

			if plrMouse.X >= guiPosition.x and plrMouse.X <= guiPosition.x + guiSize.x and plrMouse.Y >= guiPosition.y and plrMouse.Y <= guiPosition.y + guiSize.y then
				return true
			else
				return false
			end
		end

		local clipboard = {}
		local function delete(o)
			Destroy(o)
		end

		local getTextWidth do
			local text = Create('TextLabel',{
				Name = "TextWidth";
				TextXAlignment = 'Left';
				TextYAlignment = 'Center';
				Font = FONT;
				FontSize = FONT_SIZE;
				Text = "";
				Position = UDim2.new(0,0,0,0);
				Size = UDim2.new(1,0,1,0);
				Visible = false;
				Parent = explorerPanel;
			})
			function getTextWidth(s)
				text.Text = s
				return text.TextBounds.x
			end
		end

		local nameScanned = false
		-- Holds the game tree converted to a list.
		local TreeList = {}
		-- Matches objects to their tree node representation.
		local NodeLookup = {}

		local nodeWidth = 0

		local QuickButtons = {}

		function filteringWorkspace()
			if explorerFilter.Text ~= "" and explorerFilter.Text ~= "Filter Workspace" then
				return true
			end
			return false
		end

		function lookForAName(obj,name)
			for i,v in pairs(obj:GetChildren()) do
				if string.find(string.lower(v.Name),string.lower(name)) then nameScanned = true end
				lookForAName(v,name)
			end
		end

		function scanName(obj)
			nameScanned = false
			if string.find(string.lower(obj.Name),string.lower(explorerFilter.Text)) then
				nameScanned = true
			else
				lookForAName(obj,explorerFilter.Text)
			end
			return nameScanned
		end

		function updateActions()
			for i,v in pairs(QuickButtons) do
				if v.Cond() then
					v.Toggle(true)
				else
					v.Toggle(false)
				end
			end
		end

		local updateList,rawUpdateList,updateScroll,rawUpdateSize do
			local function r(t)
				for i = 1,#t do
					if not filteringWorkspace() or scanName(t[i].Object) then
						TreeList[#TreeList+1] = t[i]

						local w = (t[i].Depth)*(2+ENTRY_PADDING+GUI_SIZE) + 2 + ENTRY_SIZE + 4 + getTextWidth(t[i].Object.Name) + 4
						if w > nodeWidth then
							nodeWidth = w
						end
						if t[i].Expanded or filteringWorkspace() then
							r(t[i])
						end
					end
				end
			end

			function rawUpdateSize()
				scrollBarH.TotalSpace = nodeWidth
				scrollBarH.VisibleSpace = listFrame.AbsoluteSize.x
				scrollBarH:Update()
				local visible = scrollBarH:CanScrollDown() or scrollBarH:CanScrollUp()
				scrollBarH.GUI.Visible = visible

				listFrame.Size = UDim2.new(1,-GUI_SIZE,1,-GUI_SIZE*(visible and 1 or 0) - HEADER_SIZE)

				scrollBar.VisibleSpace = math.ceil(listFrame.AbsoluteSize.y/ENTRY_BOUND)
				scrollBar.GUI.Size = UDim2.new(0,GUI_SIZE,1,-GUI_SIZE*(visible and 1 or 0) - HEADER_SIZE)

				scrollBar.TotalSpace = #TreeList+1
				scrollBar:Update()
			end

			function rawUpdateList()
				-- Clear then repopulate the entire list. It appears to be fast enough.
				TreeList = {}
				nodeWidth = 0
				r(NodeLookup[workspace.Parent])
				if DexStorageEnabled then
					r(NodeLookup[DexStorage])
				end
				if NilStorageEnabled then
					r(NodeLookup[NilStorage])
				end
				rawUpdateSize()
				updateActions()
			end

			-- Adding or removing large models will cause many updates to occur. We
			-- can reduce the number of updates by creating a delay, then dropping any
			-- updates that occur during the delay.
			local updatingList = false
			function updateList()
				if updatingList then return end
				updatingList = true
				wait(0.25)
				updatingList = false
				rawUpdateList()
			end

			local updatingScroll = false
			function updateScroll()
				if updatingScroll then return end
				updatingScroll = true
				wait(0.25)
				updatingScroll = false
				scrollBar:Update()
			end
		end

		local Selection do
			local bindGetSelection = explorerPanel:FindFirstChild("TotallyNotGetSelection")
			if not bindGetSelection then
				bindGetSelection = Create('BindableFunction',{Name = "TotallyNotGetSelection"})
				bindGetSelection.Parent = explorerPanel
			end

			local bindSetSelection = explorerPanel:FindFirstChild("TotallyNotSetSelection")
			if not bindSetSelection then
				bindSetSelection = Create('BindableFunction',{Name = "TotallyNotSetSelection"})
				bindSetSelection.Parent = explorerPanel
			end

			local bindSelectionChanged = explorerPanel:FindFirstChild("TotallyNotSelectionChanged")
			if not bindSelectionChanged then
				bindSelectionChanged = Create('BindableEvent',{Name = "TotallyNotSelectionChanged"})
				bindSelectionChanged.Parent = explorerPanel
			end

			local SelectionList = {}
			local SelectionSet = {}
			local Updates = true
			Selection = {
				Selected = SelectionSet;
				List = SelectionList;
			}

			local function addObject(object)
				-- list update
				local lupdate = false
				-- scroll update
				local supdate = false

				if not SelectionSet[object] then
					local node = NodeLookup[object]
					if node then
						table.insert(SelectionList,object)
						SelectionSet[object] = true
						node.Selected = true

						-- expand all ancestors so that selected node becomes visible
						node = node.Parent
						while node do
							if not node.Expanded then
								node.Expanded = true
								lupdate = true
							end
							node = node.Parent
						end
						supdate = true
					end
				end
				return lupdate,supdate
			end

			function Selection:Set(objects)
				local lupdate = false
				local supdate = false

				if #SelectionList > 0 then
					for i = 1,#SelectionList do
						local object = SelectionList[i]
						local node = NodeLookup[object]
						if node then
							node.Selected = false
							SelectionSet[object] = nil
						end
					end

					SelectionList = {}
					Selection.List = SelectionList
					supdate = true
				end

				for i = 1,#objects do
					local l,s = addObject(objects[i])
					lupdate = l or lupdate
					supdate = s or supdate
				end

				if lupdate then
					rawUpdateList()
					supdate = true
				elseif supdate then
					scrollBar:Update()
				end

				if supdate then
					bindSelectionChanged:Fire()
					updateActions()
				end
			end

			function Selection:Add(object)
				local l,s = addObject(object)
				if l then
					rawUpdateList()
					if Updates then
						bindSelectionChanged:Fire()
						updateActions()
					end
				elseif s then
					scrollBar:Update()
					if Updates then
						bindSelectionChanged:Fire()
						updateActions()
					end
				end
			end

			function Selection:StopUpdates()
				Updates = false
			end

			function Selection:ResumeUpdates()
				Updates = true
				bindSelectionChanged:Fire()
				updateActions()
			end

			function Selection:Remove(object,noupdate)
				if SelectionSet[object] then
					local node = NodeLookup[object]
					if node then
						node.Selected = false
						SelectionSet[object] = nil
						for i = 1,#SelectionList do
							if SelectionList[i] == object then
								table.remove(SelectionList,i)
								break
							end
						end

						if not noupdate then
							scrollBar:Update()
						end
						bindSelectionChanged:Fire()
						updateActions()
					end
				end
			end

			function Selection:Get()
				local list = {}
				for i = 1,#SelectionList do
					list[i] = SelectionList[i]
				end
				return list
			end

			bindSetSelection.OnInvoke = function(...)
				Selection:Set(...)
			end

			bindGetSelection.OnInvoke = function()
				return Selection:Get()
			end
		end

		function CreateCaution(title,msg)
			local newCaution = CautionWindow:Clone()
			newCaution.Title.Text = title
			newCaution.MainWindow.Desc.Text = msg
			newCaution.Parent = explorerPanel.Parent
			newCaution.Visible = true
			newCaution.MainWindow.Ok.MouseButton1Up:connect(function()
				newCaution:Destroy()
			end)
		end

		function CreateTableCaution(title,msg)
			if type(msg) ~= "table" then return CreateCaution(title,tostring(msg)) end
			local newCaution = TableCautionWindow:Clone()
			newCaution.Title.Text = title

			local TableList = newCaution.MainWindow.TableResults
			local TableTemplate = newCaution.MainWindow.TableTemplate

			for i,v in pairs(msg) do
				local newResult = TableTemplate:Clone()
				newResult.Type.Text = type(v)
				newResult.Value.Text = tostring(v)
				newResult.Position = UDim2.new(0,0,0,#TableList:GetChildren() * 20)
				newResult.Parent = TableList
				TableList.CanvasSize = UDim2.new(0,0,0,#TableList:GetChildren() * 20)
				newResult.Visible = true
			end
			newCaution.Parent = explorerPanel.Parent
			newCaution.Visible = true
			newCaution.MainWindow.Ok.MouseButton1Up:connect(function()
				newCaution:Destroy()
			end)
		end

		local function Split(str, delimiter)
			local start = 1
			local t = {}
			while true do
				local pos = string.find (str, delimiter, start, true)
				if not pos then
					break
				end
				table.insert (t, string.sub (str, start, pos - 1))
				start = pos + string.len (delimiter)
			end
			table.insert (t, string.sub (str, start))
			return t
		end

		local function ToValue(value,type)
			if type == "Vector2" then
				local list = Split(value,",")
				if #list < 2 then return nil end
				local x = tonumber(list[1]) or 0
				local y = tonumber(list[2]) or 0
				return Vector2.new(x,y)
			elseif type == "Vector3" then
				local list = Split(value,",")
				if #list < 3 then return nil end
				local x = tonumber(list[1]) or 0
				local y = tonumber(list[2]) or 0
				local z = tonumber(list[3]) or 0
				return Vector3.new(x,y,z)
			elseif type == "Color3" then
				local list = Split(value,",")
				if #list < 3 then return nil end
				local r = tonumber(list[1]) or 0
				local g = tonumber(list[2]) or 0
				local b = tonumber(list[3]) or 0
				return Color3.new(r/255,g/255, b/255)
			elseif type == "UDim2" then
				local list = Split(string.gsub(string.gsub(value, "{", ""),"}",""),",")
				if #list < 4 then return nil end
				local xScale = tonumber(list[1]) or 0
				local xOffset = tonumber(list[2]) or 0
				local yScale = tonumber(list[3]) or 0
				local yOffset = tonumber(list[4]) or 0
				return UDim2.new(xScale, xOffset, yScale, yOffset)
			elseif type == "Number" then
				return tonumber(value)
			elseif type == "String" then
				return value
			elseif type == "NumberRange" then
				local list = Split(value,",")
				if #list == 1 then
					if tonumber(list[1]) == nil then return nil end
					local newVal = tonumber(list[1]) or 0
					return NumberRange.new(newVal)
				end
				if #list < 2 then return nil end
				local x = tonumber(list[1]) or 0
				local y = tonumber(list[2]) or 0
				return NumberRange.new(x,y)
			elseif type == "Script" then
				local success,err = ypcall(function()
					_G.D_E_X_DONOTUSETHISPLEASE = nil
					loadstring(
						"_G.D_E_X_DONOTUSETHISPLEASE = "..value
					)()
					return _G.D_E_X_DONOTUSETHISPLEASE
				end)
				if err then
					return nil
				end
			else
				return nil
			end
		end

		local function ToPropValue(value,type)
			if type == "Vector2" then
				local list = Split(value,",")
				if #list < 2 then return nil end
				local x = tonumber(list[1]) or 0
				local y = tonumber(list[2]) or 0
				return Vector2.new(x,y)
			elseif type == "Vector3" then
				local list = Split(value,",")
				if #list < 3 then return nil end
				local x = tonumber(list[1]) or 0
				local y = tonumber(list[2]) or 0
				local z = tonumber(list[3]) or 0
				return Vector3.new(x,y,z)
			elseif type == "Color3" then
				local list = Split(value,",")
				if #list < 3 then return nil end
				local r = tonumber(list[1]) or 0
				local g = tonumber(list[2]) or 0
				local b = tonumber(list[3]) or 0
				return Color3.new(r/255,g/255, b/255)
			elseif type == "UDim2" then
				local list = Split(string.gsub(string.gsub(value, "{", ""),"}",""),",")
				if #list < 4 then return nil end
				local xScale = tonumber(list[1]) or 0
				local xOffset = tonumber(list[2]) or 0
				local yScale = tonumber(list[3]) or 0
				local yOffset = tonumber(list[4]) or 0
				return UDim2.new(xScale, xOffset, yScale, yOffset)
			elseif type == "Content" then
				return value
			elseif type == "float" or type == "int" or type == "double" then
				return tonumber(value)
			elseif type == "string" then
				return value
			elseif type == "NumberRange" then
				local list = Split(value,",")
				if #list == 1 then
					if tonumber(list[1]) == nil then return nil end
					local newVal = tonumber(list[1]) or 0
					return NumberRange.new(newVal)
				end
				if #list < 2 then return nil end
				local x = tonumber(list[1]) or 0
				local y = tonumber(list[2]) or 0
				return NumberRange.new(x,y)
			elseif string.sub(value,1,4) == "Enum" then
				local getEnum = value
				while true do
					local x,y = string.find(getEnum,".")
					if y then
						getEnum = string.sub(getEnum,y+1)
					else
						break
					end
				end
				print(getEnum)
				return getEnum
			else
				return nil
			end
		end

		function PromptRemoteCaller(inst)
			if CurrentRemoteWindow then
				CurrentRemoteWindow:Destroy()
				CurrentRemoteWindow = nil
			end
			CurrentRemoteWindow = RemoteWindow:Clone()
			CurrentRemoteWindow.Parent = explorerPanel.Parent
			CurrentRemoteWindow.Visible = true

			local displayValues = false

			local ArgumentList = CurrentRemoteWindow.MainWindow.Arguments
			local ArgumentTemplate = CurrentRemoteWindow.MainWindow.ArgumentTemplate

			if inst:IsA("RemoteEvent") then
				CurrentRemoteWindow.Title.Text = "Fire Event"
				CurrentRemoteWindow.MainWindow.Ok.Text = "Fire"
				CurrentRemoteWindow.MainWindow.DisplayReturned.Visible = false
				CurrentRemoteWindow.MainWindow.Desc2.Visible = false
			end

			local newArgument = ArgumentTemplate:Clone()
			newArgument.Parent = ArgumentList
			newArgument.Visible = true
			newArgument.Type.MouseButton1Down:connect(function()
				createDDown(newArgument.Type,function(choice)
					newArgument.Type.Text = choice
				end,"Script","Number","String","Color3","Vector3","Vector2","UDim2","NumberRange")
			end)

			CurrentRemoteWindow.MainWindow.Ok.MouseButton1Up:connect(function()
				if CurrentRemoteWindow and inst.Parent ~= nil then
					local MyArguments = {}
					for i,v in pairs(ArgumentList:GetChildren()) do
						table.insert(MyArguments,ToValue(v.Value.Text,v.Type.Text))
					end
					if inst:IsA("RemoteFunction") then
						if displayValues then
							spawn(function()
								local myResults = inst:InvokeServer(unpack(MyArguments))
								if myResults then
									CreateTableCaution("Remote Caller",myResults)
								else
									CreateCaution("Remote Caller","This remote did not return anything.")
								end
							end)
						else
							spawn(function()
								inst:InvokeServer(unpack(MyArguments))
							end)
						end
					else
						inst:FireServer(unpack(MyArguments))
					end
					CurrentRemoteWindow:Destroy()
					CurrentRemoteWindow = nil
				end
			end)

			CurrentRemoteWindow.MainWindow.Add.MouseButton1Up:connect(function()
				if CurrentRemoteWindow then
					local newArgument = ArgumentTemplate:Clone()
					newArgument.Position = UDim2.new(0,0,0,#ArgumentList:GetChildren() * 20)
					newArgument.Parent = ArgumentList
					ArgumentList.CanvasSize = UDim2.new(0,0,0,#ArgumentList:GetChildren() * 20)
					newArgument.Visible = true
					newArgument.Type.MouseButton1Down:connect(function()
						createDDown(newArgument.Type,function(choice)
							newArgument.Type.Text = choice
						end,"Script","Number","String","Color3","Vector3","Vector2","UDim2","NumberRange")
					end)
				end
			end)

			CurrentRemoteWindow.MainWindow.Subtract.MouseButton1Up:connect(function()
				if CurrentRemoteWindow then
					if #ArgumentList:GetChildren() > 1 then
						ArgumentList:GetChildren()[#ArgumentList:GetChildren()]:Destroy()
						ArgumentList.CanvasSize = UDim2.new(0,0,0,#ArgumentList:GetChildren() * 20)
					end
				end
			end)

			CurrentRemoteWindow.MainWindow.Cancel.MouseButton1Up:connect(function()
				if CurrentRemoteWindow then
					CurrentRemoteWindow:Destroy()
					CurrentRemoteWindow = nil
				end
			end)

			CurrentRemoteWindow.MainWindow.DisplayReturned.MouseButton1Up:connect(function()
				if displayValues then
					displayValues = false
					CurrentRemoteWindow.MainWindow.DisplayReturned.enabled.Visible = false
				else
					displayValues = true
					CurrentRemoteWindow.MainWindow.DisplayReturned.enabled.Visible = true
				end
			end)
		end

		function PromptSaveInstance(inst)
			if not SaveInstance and not _G.SaveInstance then CreateCaution("SaveInstance Missing","You do not have the SaveInstance function installed. Please go to RaspberryPi's thread to retrieve it.") return end
			if CurrentSaveInstanceWindow then
				CurrentSaveInstanceWindow:Destroy()
				CurrentSaveInstanceWindow = nil
				if explorerPanel.Parent:FindFirstChild("SaveInstanceOverwriteCaution") then
					explorerPanel.Parent.SaveInstanceOverwriteCaution:Destroy()
				end
			end
			CurrentSaveInstanceWindow = SaveInstanceWindow:Clone()
			CurrentSaveInstanceWindow.Parent = explorerPanel.Parent
			CurrentSaveInstanceWindow.Visible = true

			local filename = CurrentSaveInstanceWindow.MainWindow.FileName
			local saveObjects = true
			local overwriteCaution = false

			CurrentSaveInstanceWindow.MainWindow.Save.MouseButton1Up:connect(function()
				if readfile and getelysianpath then
					if readfile(getelysianpath()..filename.Text..".rbxmx") then
						if not overwriteCaution then
							overwriteCaution = true
							local newCaution = ConfirmationWindow:Clone()
							newCaution.Name = "SaveInstanceOverwriteCaution"
							newCaution.MainWindow.Desc.Text = "The file, "..filename.Text..".rbxmx, already exists. Overwrite?"
							newCaution.Parent = explorerPanel.Parent
							newCaution.Visible = true
							newCaution.MainWindow.Yes.MouseButton1Up:connect(function()
								ypcall(function()
									SaveInstance(inst,filename.Text..".rbxmx",not saveObjects)
								end)
								overwriteCaution = false
								newCaution:Destroy()
								if CurrentSaveInstanceWindow then
									CurrentSaveInstanceWindow:Destroy()
									CurrentSaveInstanceWindow = nil
								end
							end)
							newCaution.MainWindow.No.MouseButton1Up:connect(function()
								overwriteCaution = false
								newCaution:Destroy()
							end)
						end
					else
						ypcall(function()
							SaveInstance(inst,filename.Text..".rbxmx",not saveObjects)
						end)
						if CurrentSaveInstanceWindow then
							CurrentSaveInstanceWindow:Destroy()
							CurrentSaveInstanceWindow = nil
							if explorerPanel.Parent:FindFirstChild("SaveInstanceOverwriteCaution") then
								explorerPanel.Parent.SaveInstanceOverwriteCaution:Destroy()
							end
						end
					end
				else
					ypcall(function()
						if SaveInstance then
							SaveInstance(inst,filename.Text..".rbxmx",not saveObjects)
						else
							_G.SaveInstance(inst,filename.Text,not saveObjects)
						end
					end)
					if CurrentSaveInstanceWindow then
						CurrentSaveInstanceWindow:Destroy()
						CurrentSaveInstanceWindow = nil
						if explorerPanel.Parent:FindFirstChild("SaveInstanceOverwriteCaution") then
							explorerPanel.Parent.SaveInstanceOverwriteCaution:Destroy()
						end
					end
				end
			end)
			CurrentSaveInstanceWindow.MainWindow.Cancel.MouseButton1Up:connect(function()
				if CurrentSaveInstanceWindow then
					CurrentSaveInstanceWindow:Destroy()
					CurrentSaveInstanceWindow = nil
					if explorerPanel.Parent:FindFirstChild("SaveInstanceOverwriteCaution") then
						explorerPanel.Parent.SaveInstanceOverwriteCaution:Destroy()
					end
				end
			end)
			CurrentSaveInstanceWindow.MainWindow.SaveObjects.MouseButton1Up:connect(function()
				if saveObjects then
					saveObjects = false
					CurrentSaveInstanceWindow.MainWindow.SaveObjects.enabled.Visible = false
				else
					saveObjects = true
					CurrentSaveInstanceWindow.MainWindow.SaveObjects.enabled.Visible = true
				end
			end)
		end

		function DestroyRightClick()
			if currentRightClickMenu then
				currentRightClickMenu:Destroy()
				currentRightClickMenu = nil
			end
			if CurrentInsertObjectWindow and CurrentInsertObjectWindow.Visible then
				CurrentInsertObjectWindow.Visible = false
			end
		end

		function rightClickMenu(sObj)
			local mouse = game.Players.LocalPlayer:GetMouse()

			currentRightClickMenu = CreateRightClickMenu(
				{"Cut","Copy","Paste Into","Duplicate","Delete","Group","Ungroup","Select Children","Teleport To","Insert Part","Insert Object","View Script","Save Instance","Call Function","Call Remote"},
				"",
				false,
				function(option)
					if option == "Cut" then
						if not Option.Modifiable then return end
						clipboard = {}
						local list = Selection.List
						local cut = {}
						for i = 1,#list do
							local obj = list[i]:Clone()
							if obj then
								table.insert(clipboard,obj)
								table.insert(cut,list[i])
							end
						end
						for i = 1,#cut do
							pcall(delete,cut[i])
						end
						updateActions()
					elseif option == "Copy" then
						if not Option.Modifiable then return end
						clipboard = {}
						local list = Selection.List
						for i = 1,#list do
							table.insert(clipboard,list[i]:Clone())
						end
						updateActions()
					elseif option == "Paste Into" then
						if not Option.Modifiable then return end
						local parent = Selection.List[1] or workspace
						for i = 1,#clipboard do
							clipboard[i]:Clone().Parent = parent
						end
					elseif option == "Duplicate" then
						if not Option.Modifiable then return end
						local list = Selection:Get()
						for i = 1,#list do
							list[i]:Clone().Parent = Selection.List[1].Parent or workspace
						end
					elseif option == "Delete" then
						if not Option.Modifiable then return end
						local list = Selection:Get()
						for i = 1,#list do
							pcall(delete,list[i])
						end
						Selection:Set({})
					elseif option == "Group" then
						if not Option.Modifiable then return end
						local newModel = Instance.new("Model")
						local list = Selection:Get()
						newModel.Parent = Selection.List[1].Parent or workspace
						for i = 1,#list do
							list[i].Parent = newModel
						end
						Selection:Set({})
					elseif option == "Ungroup" then
						if not Option.Modifiable then return end
						local ungrouped = {}
						local list = Selection:Get()
						for i = 1,#list do
							if list[i]:IsA("Model") then
								for i2,v2 in pairs(list[i]:GetChildren()) do
									v2.Parent = list[i].Parent or workspace
									table.insert(ungrouped,v2)
								end		
								pcall(delete,list[i])			
							end
						end
						Selection:Set({})
						if SettingsRemote:Invoke("SelectUngrouped") then
							for i,v in pairs(ungrouped) do
								Selection:Add(v)
							end
						end
					elseif option == "Select Children" then
						if not Option.Modifiable then return end
						local list = Selection:Get()
						Selection:Set({})
						Selection:StopUpdates()
						for i = 1,#list do
							for i2,v2 in pairs(list[i]:GetChildren()) do
								Selection:Add(v2)
							end
						end
						Selection:ResumeUpdates()
					elseif option == "Teleport To" then
						if not Option.Modifiable then return end
						local list = Selection:Get()
						for i = 1,#list do
							if list[i]:IsA("BasePart") then
								pcall(function()
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = list[i].CFrame
								end)
								break
							end
						end
					elseif option == "Insert Part" then
						if not Option.Modifiable then return end
						local insertedParts = {}
						local list = Selection:Get()
						for i = 1,#list do
							pcall(function()
								local newPart = Instance.new("Part")
								newPart.Parent = list[i]
								newPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.Head.Position) + Vector3.new(0,3,0)
								table.insert(insertedParts,newPart)
							end)
						end
					elseif option == "Save Instance" then
						if not Option.Modifiable then return end
						local list = Selection:Get()
						if #list == 1 then
							list[1].Archivable = true
							ypcall(function()PromptSaveInstance(list[1]:Clone())end)
						elseif #list > 1 then
							local newModel = Instance.new("Model")
							newModel.Name = "SavedInstances"
							for i = 1,#list do
								ypcall(function()
									list[i].Archivable = true
									list[i]:Clone().Parent = newModel
								end)
							end
							PromptSaveInstance(newModel)
						end
					elseif option == "Call Remote" then
						if not Option.Modifiable then return end
						local list = Selection:Get()
						for i = 1,#list do
							if list[i]:IsA("RemoteFunction") or list[i]:IsA("RemoteEvent") then
								PromptRemoteCaller(list[i])
								break
							end
						end
					elseif option == "View Script" then
						if not Option.Modifiable then return end
						local list = Selection:Get()
						for i = 1,#list do
							if list[i]:IsA("LocalScript") or list[i]:IsA("ModuleScript") then
								ScriptEditorEvent:Fire(list[i])
							end
						end
					end
				end)
			currentRightClickMenu.Parent = explorerPanel.Parent
			currentRightClickMenu.Position = UDim2.new(0,mouse.X,0,mouse.Y)
			if currentRightClickMenu.AbsolutePosition.X + currentRightClickMenu.AbsoluteSize.X > explorerPanel.AbsolutePosition.X + explorerPanel.AbsoluteSize.X then
				currentRightClickMenu.Position = UDim2.new(0, explorerPanel.AbsolutePosition.X + explorerPanel.AbsoluteSize.X - currentRightClickMenu.AbsoluteSize.X, 0, mouse.Y)
			end
		end

		local function cancelReparentDrag()end
		local function cancelSelectDrag()end
		do
			local listEntries = {}
			local nameConnLookup = {}

			local mouseDrag = Create('ImageButton',{
				Name = "MouseDrag";
				Position = UDim2.new(-0.25,0,-0.25,0);
				Size = UDim2.new(1.5,0,1.5,0);
				Transparency = 1;
				AutoButtonColor = false;
				Active = true;
				ZIndex = 10;
			})
			local function dragSelect(last,add,button)
				local connDrag
				local conUp

				conDrag = mouseDrag.MouseMoved:connect(function(x,y)
					local pos = Vector2.new(x,y) - listFrame.AbsolutePosition
					local size = listFrame.AbsoluteSize
					if pos.x < 0 or pos.x > size.x or pos.y < 0 or pos.y > size.y then return end

					local i = math.ceil(pos.y/ENTRY_BOUND) + scrollBar.ScrollIndex
					-- Mouse may have made a large step, so interpolate between the
					-- last index and the current.
					for n = i<last and i or last, i>last and i or last do
						local node = TreeList[n]
						if node then
							if add then
								Selection:Add(node.Object)
							else
								Selection:Remove(node.Object)
							end
						end
					end
					last = i
				end)

				function cancelSelectDrag()
					mouseDrag.Parent = nil
					conDrag:disconnect()
					conUp:disconnect()
					function cancelSelectDrag()end
				end

				conUp = mouseDrag[button]:connect(cancelSelectDrag)

				mouseDrag.Parent = GetScreen(listFrame)
			end

			local function dragReparent(object,dragGhost,clickPos,ghostOffset)
				local connDrag
				local conUp
				local conUp2

				local parentIndex = nil
				local dragged = false

				local parentHighlight = Create('Frame',{
					Transparency = 1;
					Visible = false;
					Create('Frame',{
						BorderSizePixel = 0;
						BackgroundColor3 = Color3.new(0,0,0);
						BackgroundTransparency = 0.1;
						Position = UDim2.new(0,0,0,0);
						Size = UDim2.new(1,0,0,1);
					});
					Create('Frame',{
						BorderSizePixel = 0;
						BackgroundColor3 = Color3.new(0,0,0);
						BackgroundTransparency = 0.1;
						Position = UDim2.new(1,0,0,0);
						Size = UDim2.new(0,1,1,0);
					});
					Create('Frame',{
						BorderSizePixel = 0;
						BackgroundColor3 = Color3.new(0,0,0);
						BackgroundTransparency = 0.1;
						Position = UDim2.new(0,0,1,0);
						Size = UDim2.new(1,0,0,1);
					});
					Create('Frame',{
						BorderSizePixel = 0;
						BackgroundColor3 = Color3.new(0,0,0);
						BackgroundTransparency = 0.1;
						Position = UDim2.new(0,0,0,0);
						Size = UDim2.new(0,1,1,0);
					});
				})
				SetZIndex(parentHighlight,9)

				conDrag = mouseDrag.MouseMoved:connect(function(x,y)
					local dragPos = Vector2.new(x,y)
					if dragged then
						local pos = dragPos - listFrame.AbsolutePosition
						local size = listFrame.AbsoluteSize

						parentIndex = nil
						parentHighlight.Visible = false
						if pos.x >= 0 and pos.x <= size.x and pos.y >= 0 and pos.y <= size.y + ENTRY_SIZE*2 then
							local i = math.ceil(pos.y/ENTRY_BOUND-2)
							local node = TreeList[i + scrollBar.ScrollIndex]
							if node and node.Object ~= object and not object:IsAncestorOf(node.Object) then
								parentIndex = i
								local entry = listEntries[i]
								if entry then
									parentHighlight.Visible = true
									parentHighlight.Position = UDim2.new(0,1,0,entry.AbsolutePosition.y-listFrame.AbsolutePosition.y)
									parentHighlight.Size = UDim2.new(0,size.x-4,0,entry.AbsoluteSize.y)
								end
							end
						end

						dragGhost.Position = UDim2.new(0,dragPos.x+ghostOffset.x,0,dragPos.y+ghostOffset.y)
					elseif (clickPos-dragPos).magnitude > 8 then
						dragged = true
						SetZIndex(dragGhost,9)
						dragGhost.IndentFrame.Transparency = 0.25
						dragGhost.IndentFrame.EntryText.TextColor3 = GuiColor.TextSelected
						dragGhost.Position = UDim2.new(0,dragPos.x+ghostOffset.x,0,dragPos.y+ghostOffset.y)
						dragGhost.Parent = GetScreen(listFrame)
						parentHighlight.Parent = listFrame
					end
				end)

				function cancelReparentDrag()
					mouseDrag.Parent = nil
					conDrag:disconnect()
					conUp:disconnect()
					conUp2:disconnect()
					dragGhost:Destroy()
					parentHighlight:Destroy()
					function cancelReparentDrag()end
				end

				local wasSelected = Selection.Selected[object]
				if not wasSelected and Option.Selectable then
					Selection:Set({object})
				end

				conUp = mouseDrag.MouseButton1Up:connect(function()
					cancelReparentDrag()
					if dragged then
						if parentIndex then
							local parentNode = TreeList[parentIndex + scrollBar.ScrollIndex]
							if parentNode then
								parentNode.Expanded = true

								local parentObj = parentNode.Object
								local function parent(a,b)
									a.Parent = b
								end
								if Option.Selectable then
									local list = Selection.List
									for i = 1,#list do
										pcall(parent,list[i],parentObj)
									end
								else
									pcall(parent,object,parentObj)
								end
							end
						end
					else
						-- do selection click
						if wasSelected and Option.Selectable then
							Selection:Set({})
						end
					end
				end)
				conUp2 = mouseDrag.MouseButton2Down:connect(function()
					cancelReparentDrag()
				end)

				mouseDrag.Parent = GetScreen(listFrame)
			end

			local entryTemplate = Create('ImageButton',{
				Name = "Entry";
				Transparency = 1;
				AutoButtonColor = false;
				Position = UDim2.new(0,0,0,0);
				Size = UDim2.new(1,0,0,ENTRY_SIZE);
				Create('Frame',{
					Name = "IndentFrame";
					BackgroundTransparency = 1;
					BackgroundColor3 = GuiColor.Selected;
					BorderColor3 = GuiColor.BorderSelected;
					Position = UDim2.new(0,0,0,0);
					Size = UDim2.new(1,0,1,0);
					Create(Icon('ImageButton',0),{
						Name = "Expand";
						AutoButtonColor = false;
						Position = UDim2.new(0,-GUI_SIZE,0.5,-GUI_SIZE/2);
						Size = UDim2.new(0,GUI_SIZE,0,GUI_SIZE);
					});
					Create(Icon(nil,0),{
						Name = "ExplorerIcon";
						Position = UDim2.new(0,2+ENTRY_PADDING,0.5,-GUI_SIZE/2);
						Size = UDim2.new(0,GUI_SIZE,0,GUI_SIZE);
					});
					Create('TextLabel',{
						Name = "EntryText";
						BackgroundTransparency = 1;
						TextColor3 = GuiColor.Text;
						TextXAlignment = 'Left';
						TextYAlignment = 'Center';
						Font = FONT;
						FontSize = FONT_SIZE;
						Text = "";
						Position = UDim2.new(0,2+ENTRY_SIZE+4,0,0);
						Size = UDim2.new(1,-2,1,0);
					});
				});
			})

			function scrollBar.UpdateCallback(self)
				for i = 1,self.VisibleSpace do
					local node = TreeList[i + self.ScrollIndex]
					if node then
						local entry = listEntries[i]
						if not entry then
							entry = Create(entryTemplate:Clone(),{
								Position = UDim2.new(0,2,0,ENTRY_BOUND*(i-1)+2);
								Size = UDim2.new(0,nodeWidth,0,ENTRY_SIZE);
								ZIndex = listFrame.ZIndex;
							})
							listEntries[i] = entry

							local expand = entry.IndentFrame.Expand
							expand.MouseEnter:connect(function()
								local node = TreeList[i + self.ScrollIndex]
								if #node > 0 then
									if node.Expanded then
										Icon(expand,NODE_EXPANDED_OVER)
									else
										Icon(expand,NODE_COLLAPSED_OVER)
									end
								end
							end)
							expand.MouseLeave:connect(function()
								local node = TreeList[i + self.ScrollIndex]
								if #node > 0 then
									if node.Expanded then
										Icon(expand,NODE_EXPANDED)
									else
										Icon(expand,NODE_COLLAPSED)
									end
								end
							end)
							expand.MouseButton1Down:connect(function()
								local node = TreeList[i + self.ScrollIndex]
								if #node > 0 then
									node.Expanded = not node.Expanded
									if node.Object == explorerPanel.Parent and node.Expanded then
										CreateCaution("Warning","Please be careful when editing instances inside here, this is like the System32 of Dex and modifying objects here can break Dex.")
									end
									-- use raw update so the list updates instantly
									rawUpdateList()
								end
							end)

							entry.MouseButton1Down:connect(function(x,y)
								local node = TreeList[i + self.ScrollIndex]
								DestroyRightClick()
								if GetAwaitRemote:Invoke() then
									bindSetAwaiting:Fire(node.Object)
									return
								end

								if not HoldingShift then
									lastSelectedNode = i + self.ScrollIndex
								end

								if HoldingShift and not filteringWorkspace() then
									if lastSelectedNode then
										if i + self.ScrollIndex - lastSelectedNode > 0 then
											Selection:StopUpdates()
											for i2 = 1, i + self.ScrollIndex - lastSelectedNode do
												local newNode = TreeList[lastSelectedNode + i2]
												if newNode then
													Selection:Add(newNode.Object)
												end
											end
											Selection:ResumeUpdates()
										else
											Selection:StopUpdates()
											for i2 = i + self.ScrollIndex - lastSelectedNode, 1 do
												local newNode = TreeList[lastSelectedNode + i2]
												if newNode then
													Selection:Add(newNode.Object)
												end
											end
											Selection:ResumeUpdates()
										end
									end
									return
								end

								if HoldingCtrl then
									if Selection.Selected[node.Object] then
										Selection:Remove(node.Object)
									else
										Selection:Add(node.Object)
									end
									return
								end
								if Option.Modifiable then
									local pos = Vector2.new(x,y)
									dragReparent(node.Object,entry:Clone(),pos,entry.AbsolutePosition-pos)
								elseif Option.Selectable then
									if Selection.Selected[node.Object] then
										Selection:Set({})
									else
										Selection:Set({node.Object})
									end
									dragSelect(i+self.ScrollIndex,true,'MouseButton1Up')
								end
							end)

							entry.MouseButton2Down:connect(function()
								if not Option.Selectable then return end

								DestroyRightClick()

								curSelect = entry

								local node = TreeList[i + self.ScrollIndex]

								if GetAwaitRemote:Invoke() then
									bindSetAwaiting:Fire(node.Object)
									return
								end

								if not Selection.Selected[node.Object] then
									Selection:Set({node.Object})
								end
							end)


							entry.MouseButton2Up:connect(function()
								if not Option.Selectable then return end

								local node = TreeList[i + self.ScrollIndex]

								if checkMouseInGui(curSelect) then
									rightClickMenu(node.Object)
								end
							end)

							entry.Parent = listFrame
						end

						entry.Visible = true

						local object = node.Object

						-- update expand icon
						if #node == 0 then
							entry.IndentFrame.Expand.Visible = false
						elseif node.Expanded then
							Icon(entry.IndentFrame.Expand,NODE_EXPANDED)
							entry.IndentFrame.Expand.Visible = true
						else
							Icon(entry.IndentFrame.Expand,NODE_COLLAPSED)
							entry.IndentFrame.Expand.Visible = true
						end

						-- update explorer icon
						Icon(entry.IndentFrame.ExplorerIcon,ExplorerIndex[object.ClassName] or 0)

						-- update indentation
						local w = (node.Depth)*(2+ENTRY_PADDING+GUI_SIZE)
						entry.IndentFrame.Position = UDim2.new(0,w,0,0)
						entry.IndentFrame.Size = UDim2.new(1,-w,1,0)

						-- update name change detection
						if nameConnLookup[entry] then
							nameConnLookup[entry]:disconnect()
						end
						local text = entry.IndentFrame.EntryText
						text.Text = object.Name
						nameConnLookup[entry] = node.Object.Changed:connect(function(p)
							if p == 'Name' then
								text.Text = object.Name
							end
						end)

						-- update selection
						entry.IndentFrame.Transparency = node.Selected and 0 or 1
						text.TextColor3 = GuiColor[node.Selected and 'TextSelected' or 'Text']

						entry.Size = UDim2.new(0,nodeWidth,0,ENTRY_SIZE)
					elseif listEntries[i] then
						listEntries[i].Visible = false
					end
				end
				for i = self.VisibleSpace+1,self.TotalSpace do
					local entry = listEntries[i]
					if entry then
						listEntries[i] = nil
						entry:Destroy()
					end
				end
			end

			function scrollBarH.UpdateCallback(self)
				for i = 1,scrollBar.VisibleSpace do
					local node = TreeList[i + scrollBar.ScrollIndex]
					if node then
						local entry = listEntries[i]
						if entry then
							entry.Position = UDim2.new(0,2 - scrollBarH.ScrollIndex,0,ENTRY_BOUND*(i-1)+2)
						end
					end
				end
			end

			Connect(listFrame.Changed,function(p)
				if p == 'AbsoluteSize' then
					rawUpdateSize()
				end
			end)

			local wheelAmount = 6
			explorerPanel.MouseWheelForward:connect(function()
				if scrollBar.VisibleSpace - 1 > wheelAmount then
					scrollBar:ScrollTo(scrollBar.ScrollIndex - wheelAmount)
				else
					scrollBar:ScrollTo(scrollBar.ScrollIndex - scrollBar.VisibleSpace)
				end
			end)
			explorerPanel.MouseWheelBackward:connect(function()
				if scrollBar.VisibleSpace - 1 > wheelAmount then
					scrollBar:ScrollTo(scrollBar.ScrollIndex + wheelAmount)
				else
					scrollBar:ScrollTo(scrollBar.ScrollIndex + scrollBar.VisibleSpace)
				end
			end)
		end

		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		---- Object detection

		-- Inserts `v` into `t` at `i`. Also sets `Index` field in `v`.
		local function insert(t,i,v)
			for n = #t,i,-1 do
				local v = t[n]
				v.Index = n+1
				t[n+1] = v
			end
			v.Index = i
			t[i] = v
		end

		-- Removes `i` from `t`. Also sets `Index` field in removed value.
		local function remove(t,i)
			local v = t[i]
			for n = i+1,#t do
				local v = t[n]
				v.Index = n-1
				t[n-1] = v
			end
			t[#t] = nil
			v.Index = 0
			return v
		end

		-- Returns how deep `o` is in the tree.
		local function depth(o)
			local d = -1
			while o do
				o = o.Parent
				d = d + 1
			end
			return d
		end


		local connLookup = {}

		-- Returns whether a node would be present in the tree list
		local function nodeIsVisible(node)
			local visible = true
			node = node.Parent
			while node and visible do
				visible = visible and node.Expanded
				node = node.Parent
			end
			return visible
		end

		-- Removes an object's tree node. Called when the object stops existing in the
		-- game tree.
		local function removeObject(object)
			local objectNode = NodeLookup[object]
			if not objectNode then
				return
			end

			local visible = nodeIsVisible(objectNode)

			Selection:Remove(object,true)

			local parent = objectNode.Parent
			remove(parent,objectNode.Index)
			NodeLookup[object] = nil
			connLookup[object]:disconnect()
			connLookup[object] = nil

			if visible then
				updateList()
			elseif nodeIsVisible(parent) then
				updateScroll()
			end
		end

		-- Moves a tree node to a new parent. Called when an existing object's parent
		-- changes.
		local function moveObject(object,parent)
			local objectNode = NodeLookup[object]
			if not objectNode then
				return
			end

			local parentNode = NodeLookup[parent]
			if not parentNode then
				return
			end

			local visible = nodeIsVisible(objectNode)

			remove(objectNode.Parent,objectNode.Index)
			objectNode.Parent = parentNode

			objectNode.Depth = depth(object)
			local function r(node,d)
				for i = 1,#node do
					node[i].Depth = d
					r(node[i],d+1)
				end
			end
			r(objectNode,objectNode.Depth+1)

			insert(parentNode,#parentNode+1,objectNode)

			if visible or nodeIsVisible(objectNode) then
				updateList()
			elseif nodeIsVisible(objectNode.Parent) then
				updateScroll()
			end
		end

		-- ScriptContext['/Libraries/LibraryRegistration/LibraryRegistration']
		-- This RobloxLocked object lets me index its properties for some reason

		local function check(object)
			return object.AncestryChanged
		end

		-- Creates a new tree node from an object. Called when an object starts
		-- existing in the game tree.
		local function addObject(object,noupdate)
			if script then
				-- protect against naughty RobloxLocked objects
				local s = pcall(check,object)
				if not s then
					return
				end
			end

			local parentNode = NodeLookup[object.Parent]
			if not parentNode then
				return
			end

			local objectNode = {
				Object = object;
				Parent = parentNode;
				Index = 0;
				Expanded = false;
				Selected = false;
				Depth = depth(object);
			}

			connLookup[object] = Connect(object.AncestryChanged,function(c,p)
				if c == object then
					if p == nil then
						removeObject(c)
					else
						moveObject(c,p)
					end
				end
			end)

			NodeLookup[object] = objectNode
			insert(parentNode,#parentNode+1,objectNode)

			if not noupdate then
				if nodeIsVisible(objectNode) then
					updateList()
				elseif nodeIsVisible(objectNode.Parent) then
					updateScroll()
				end
			end
		end

		local function makeObject(obj,par)
			local newObject = Instance.new(obj.ClassName)
			for i,v in pairs(obj.Properties) do
				ypcall(function()
					local newProp
					newProp = ToPropValue(v.Value,v.Type)
					newObject[v.Name] = newProp
				end)
			end
			newObject.Parent = par
		end

		local function writeObject(obj)
			local newObject = {ClassName = obj.ClassName, Properties = {}}
			for i,v in pairs(RbxApi.GetProperties(obj.className)) do
				if v["Name"] ~= "Parent" then
					print("thispassed")
					table.insert(newObject.Properties,{Name = v["Name"], Type = v["ValueType"], Value = tostring(obj[v["Name"]])})
				end
			end
			return newObject
		end

		local function buildDexStorage()
			local localDexStorage

			local success,err = ypcall(function()
				localDexStorage = game:GetObjects("rbxasset://DexStorage.rbxm")[1]
			end)

			if success and localDexStorage then
				for i,v in pairs(localDexStorage:GetChildren()) do
					ypcall(function()
						v.Parent = DexStorageMain
					end)
				end
			end

			updateDexStorageListeners()
	--[[
	local localDexStorage = readfile(getelysianpath().."DexStorage.txt")--game:GetService("CookiesService"):GetCookieValue("DexStorage")
	--local success,err = pcall(function()
		if localDexStorage then
			local objTable = game:GetService("HttpService"):JSONDecode(localDexStorage)
			for i,v in pairs(objTable) do
				makeObject(v,DexStorageMain)
			end
		end
	--end)
	--]]
		end

		local dexStorageDebounce = false
		local dexStorageListeners = {}

		local function updateDexStorage()
			if dexStorageDebounce then return end
			dexStorageDebounce = true	

			wait()

			pcall(function()
				saveinstance("content//DexStorage.rbxm",DexStorageMain)
			end)

			updateDexStorageListeners()

			dexStorageDebounce = false
	--[[
	local success,err = ypcall(function()
		local objs = {}
		for i,v in pairs(DexStorageMain:GetChildren()) do
			table.insert(objs,writeObject(v))
		end
		writefile(getelysianpath().."DexStorage.txt",game:GetService("HttpService"):JSONEncode(objs))
		--game:GetService("CookiesService"):SetCookieValue("DexStorage",game:GetService("HttpService"):JSONEncode(objs))
	end)
	if err then
		CreateCaution("DexStorage Save Fail!","DexStorage broke! If you see this message, report to Raspberry Pi!")
	end
	print("hi")
	--]]
		end

		function updateDexStorageListeners()
			for i,v in pairs(dexStorageListeners) do
				v:Disconnect()
			end
			dexStorageListeners = {}
			for i,v in pairs(DexStorageMain:GetChildren()) do
				pcall(function()
					local ev = v.Changed:connect(updateDexStorage)
					table.insert(dexStorageListeners,ev)
				end)
			end
		end

		do
			NodeLookup[workspace.Parent] = {
				Object = workspace.Parent;
				Parent = nil;
				Index = 0;
				Expanded = true;
			}

			if DexStorageEnabled then
				NodeLookup[DexStorage] = {
					Object = DexStorage;
					Parent = nil;
					Index = 0;
					Expanded = true;
				}
			end

			if NilStorageEnabled then
				NodeLookup[NilStorage] = {
					Object = NilStorage;
					Parent = nil;
					Index = 0;
					Expanded = true;
				}
			end

			Connect(game.DescendantAdded,addObject)
			Connect(game.DescendantRemoving,removeObject)

			if DexStorageEnabled then
		--[[
		if readfile(getelysianpath().."DexStorage.txt") == nil then
			writefile(getelysianpath().."DexStorage.txt","")
		end
		--]]

				buildDexStorage()

				Connect(DexStorage.DescendantAdded,addObject)
				Connect(DexStorage.DescendantRemoving,removeObject)

				Connect(DexStorage.DescendantAdded,updateDexStorage)
				Connect(DexStorage.DescendantRemoving,updateDexStorage)
			end

			if NilStorageEnabled then
				Connect(NilStorage.DescendantAdded,addObject)
				Connect(NilStorage.DescendantRemoving,removeObject)		

				local currentTable = get_nil_instances()	

				spawn(function()
					while wait() do
						if #currentTable ~= #get_nil_instances() then
							currentTable = get_nil_instances()
							--NilStorageMain:ClearAllChildren()
							for i,v in pairs(get_nil_instances()) do
								if v ~= NilStorage and v ~= DexStorage then
									pcall(function()
										v.Parent = NilStorageMain
									end)
							--[[
							local newNil = v
							newNil.Archivable = true
							newNil:Clone().Parent = NilStorageMain
							--]]
								end
							end
						end
					end
				end)
			end

			local function get(o)
				return o:GetChildren()
			end

			local function r(o)
				local s,children = pcall(get,o)
				if s then
					for i = 1,#children do
						addObject(children[i],true)
						r(children[i])
					end
				end
			end

			r(workspace.Parent)
			if DexStorageEnabled then
				r(DexStorage)
			end
			if NilStorageEnabled then
				r(NilStorage)
			end

			scrollBar.VisibleSpace = math.ceil(listFrame.AbsoluteSize.y/ENTRY_BOUND)
			updateList()
		end

		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		---- Actions

		local actionButtons do
			actionButtons = {}

			local totalActions = 1
			local currentActions = totalActions
			local function makeButton(icon,over,name,vis,cond)
				local buttonEnabled = false

				local button = Create(Icon('ImageButton',icon),{
					Name = name .. "Button";
					Visible = Option.Modifiable and Option.Selectable;
					Position = UDim2.new(1,-(GUI_SIZE+2)*currentActions+2,0.25,-GUI_SIZE/2);
					Size = UDim2.new(0,GUI_SIZE,0,GUI_SIZE);
					Parent = headerFrame;
				})

				local tipText = Create('TextLabel',{
					Name = name .. "Text";
					Text = name;
					Visible = false;
					BackgroundTransparency = 1;
					TextXAlignment = 'Right';
					Font = FONT;
					FontSize = FONT_SIZE;
					Position = UDim2.new(0,0,0,0);
					Size = UDim2.new(1,-(GUI_SIZE+2)*totalActions,1,0);
					Parent = headerFrame;
				})


				button.MouseEnter:connect(function()
					if buttonEnabled then
						button.BackgroundTransparency = 0.9
					end
					--Icon(button,over)
					--tipText.Visible = true
				end)
				button.MouseLeave:connect(function()
					button.BackgroundTransparency = 1
					--Icon(button,icon)
					--tipText.Visible = false
				end)

				currentActions = currentActions + 1
				actionButtons[#actionButtons+1] = {Obj = button,Cond = cond}
				QuickButtons[#actionButtons+1] = {Obj = button,Cond = cond, Toggle = function(on)
					if on then
						buttonEnabled = true
						Icon(button,over)
					else
						buttonEnabled = false
						Icon(button,icon)
					end
				end}
				return button
			end

			--local clipboard = {}
			local function delete(o)
				Destroy(o)
			end

			makeButton(ACTION_EDITQUICKACCESS,ACTION_EDITQUICKACCESS,"Options",true,function()return true end).MouseButton1Click:connect(function()

			end)


			-- DELETE
			makeButton(ACTION_DELETE,ACTION_DELETE_OVER,"Delete",true,function() return #Selection:Get() > 0 end).MouseButton1Click:connect(function()
				if not Option.Modifiable then return end
				local list = Selection:Get()
				for i = 1,#list do
					pcall(delete,list[i])
				end
				Selection:Set({})
			end)

			-- PASTE
			makeButton(ACTION_PASTE,ACTION_PASTE_OVER,"Paste",true,function() return #Selection:Get() > 0 and #clipboard > 0 end).MouseButton1Click:connect(function()
				if not Option.Modifiable then return end
				local parent = Selection.List[1] or workspace
				for i = 1,#clipboard do
					clipboard[i]:Clone().Parent = parent
				end
			end)

			-- COPY
			makeButton(ACTION_COPY,ACTION_COPY_OVER,"Copy",true,function() return #Selection:Get() > 0 end).MouseButton1Click:connect(function()
				if not Option.Modifiable then return end
				clipboard = {}
				local list = Selection.List
				for i = 1,#list do
					table.insert(clipboard,list[i]:Clone())
				end
				updateActions()
			end)

			-- CUT
			makeButton(ACTION_CUT,ACTION_CUT_OVER,"Cut",true,function() return #Selection:Get() > 0 end).MouseButton1Click:connect(function()
				if not Option.Modifiable then return end
				clipboard = {}
				local list = Selection.List
				local cut = {}
				for i = 1,#list do
					local obj = list[i]:Clone()
					if obj then
						table.insert(clipboard,obj)
						table.insert(cut,list[i])
					end
				end
				for i = 1,#cut do
					pcall(delete,cut[i])
				end
				updateActions()
			end)

			-- FREEZE
			makeButton(ACTION_FREEZE,ACTION_FREEZE,"Freeze",true,function() return true end)

			-- ADD/REMOVE STARRED
			makeButton(ACTION_ADDSTAR,ACTION_ADDSTAR_OVER,"Star",true,function() return #Selection:Get() > 0 end)

			-- STARRED
			makeButton(ACTION_STARRED,ACTION_STARRED,"Starred",true,function() return true end)


			-- SORT
			-- local actionSort = makeButton(ACTION_SORT,ACTION_SORT_OVER,"Sort")
		end

		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		---- Option Bindables

		do
			local optionCallback = {
				Modifiable = function(value)
					for i = 1,#actionButtons do
						actionButtons[i].Obj.Visible = value and Option.Selectable
					end
					cancelReparentDrag()
				end;
				Selectable = function(value)
					for i = 1,#actionButtons do
						actionButtons[i].Obj.Visible = value and Option.Modifiable
					end
					cancelSelectDrag()
					Selection:Set({})
				end;
			}

			local bindSetOption = explorerPanel:FindFirstChild("SetOption")
			if not bindSetOption then
				bindSetOption = Create('BindableFunction',{Name = "SetOption"})
				bindSetOption.Parent = explorerPanel
			end

			bindSetOption.OnInvoke = function(optionName,value)
				if optionCallback[optionName] then
					Option[optionName] = value
					optionCallback[optionName](value)
				end
			end

			local bindGetOption = explorerPanel:FindFirstChild("GetOption")
			if not bindGetOption then
				bindGetOption = Create('BindableFunction',{Name = "GetOption"})
				bindGetOption.Parent = explorerPanel
			end

			bindGetOption.OnInvoke = function(optionName)
				if optionName then
					return Option[optionName]
				else
					local options = {}
					for k,v in pairs(Option) do
						options[k] = v
					end
					return options
				end
			end
		end

		function SelectionVar()
			return Selection
		end

		Input.InputBegan:connect(function(key)
			if key.KeyCode == Enum.KeyCode.LeftControl then
				HoldingCtrl = true
			end
			if key.KeyCode == Enum.KeyCode.LeftShift then
				HoldingShift = true
			end
		end)

		Input.InputEnded:connect(function(key)
			if key.KeyCode == Enum.KeyCode.LeftControl then
				HoldingCtrl = false
			end
			if key.KeyCode == Enum.KeyCode.LeftShift then
				HoldingShift = false
			end
		end)

		while RbxApi == nil do
			RbxApi = GetApiRemote:Invoke()
			wait()
		end

		explorerFilter.Changed:connect(function(prop)
			if prop == "Text" then
				rawUpdateList()
			end
		end)

		CurrentInsertObjectWindow = CreateInsertObjectMenu(
			GetClasses(),
			"",
			false,
			function(option)
				CurrentInsertObjectWindow.Visible = false
				local list = SelectionVar():Get()
				for i = 1,#list do
					pcall(function() Instance.new(option,list[i]) end)
				end
				DestroyRightClick()
			end
		)
	end)
	spawn(function()
	--[[
	
Change log:

09/18
	Fixed checkbox mouseover sprite
	Encapsulated checkbox creation into separate method
	Fixed another checkbox issue

09/15
	Invalid input is ignored instead of setting to default of that data type
	Consolidated control methods and simplified them
	All input goes through ToValue method
	Fixed position of BrickColor palette
	Made DropDown appear above row if it would otherwise exceed the page height
	Cleaned up stylesheets

09/14
	Made properties window scroll when mouse wheel scrolled
	Object/Instance and Color3 data types handled properly
	Multiple BrickColor controls interfering with each other fixed
	Added support for Content data type
	
--]]

		wait(0.2)

		local print = function(s)
			print(tostring(s))
		end

		-- Services
		local Teams = game:GetService("Teams")
		local Workspace = game:GetService("Workspace")
		local Debris = game:GetService("Debris")
		local ContentProvider = game:GetService("ContentProvider")
		local Players = game:GetService("Players")
		local ReplicatedStorage = game:GetService("ReplicatedStorage")

--[[
	RbxApi.Classes
	RbxApi.Enums
	RbxApi.GetProperties(className)
	RbxApi.IsEnum(valueType)
--]]

		-- Styles

		local function CreateColor3(r, g, b) return Color3.new(r/255,g/255,b/255) end

		local Styles = {
			Font = Enum.Font.Arial;
			Margin = 5;
			Black = CreateColor3(0,0,0);
			White = CreateColor3(255,255,255);
		}

		local Row = {
			Font = Styles.Font;
			FontSize = Enum.FontSize.Size14;
			TextXAlignment = Enum.TextXAlignment.Left;
			TextColor = Styles.Black;
			TextColorOver = Styles.White;
			TextLockedColor = CreateColor3(120,120,120);
			Height = 24;
			BorderColor = CreateColor3(216,216,216);
			BackgroundColor = Styles.White;
			BackgroundColorAlternate = CreateColor3(246,246,246);
			BackgroundColorMouseover = CreateColor3(211,224,244);
			TitleMarginLeft = 15;
		}

		local DropDown = {
			Font = Styles.Font;
			FontSize = Enum.FontSize.Size14;
			TextColor = CreateColor3(0,0,0);
			TextColorOver = Styles.White;
			TextXAlignment = Enum.TextXAlignment.Left;
			Height = 16;
			BackColor = Styles.White;
			BackColorOver = CreateColor3(86,125,188);
			BorderColor = CreateColor3(216,216,216);
			BorderSizePixel = 2;
			ArrowColor = CreateColor3(160,160,160);
			ArrowColorOver = Styles.Black;
		}

		local BrickColors = {
			BoxSize = 13;
			BorderSizePixel = 1;
			BorderColor = CreateColor3(160,160,160);
			FrameColor = CreateColor3(160,160,160);
			Size = 20;
			Padding = 4;
			ColorsPerRow = 8;
			OuterBorder = 1;
			OuterBorderColor = Styles.Black;
		}

		wait(1)

		local Gui = D_E_X
		local PropertiesFrame = Gui:WaitForChild("PropertiesFrame")
		local ExplorerFrame = Gui:WaitForChild("ExplorerPanel")

		local bindGetSelection = ExplorerFrame.TotallyNotGetSelection
		local bindSelectionChanged = ExplorerFrame.TotallyNotSelectionChanged
		local bindGetApi = PropertiesFrame.GetApi
		local bindGetAwait = PropertiesFrame.GetAwaiting
		local bindSetAwait = PropertiesFrame.SetAwaiting

		local ContentUrl = ContentProvider.BaseUrl .. "asset/?id="

		local SettingsRemote = Gui:WaitForChild("SettingsPanel"):WaitForChild("GetSetting")

		local propertiesSearch = PropertiesFrame.Header.TextBox

		local AwaitingObjectValue = false
		local AwaitingObjectObj
		local AwaitingObjectProp

		function searchingProperties()
			if propertiesSearch.Text ~= "" and propertiesSearch.Text ~= "Search Properties" then
				return true
			end
			return false
		end

		local function GetSelection()
			local selection = bindGetSelection:Invoke()
			if #selection == 0 then
				return nil
			else
				return selection
			end 
		end

		-- Number

		local function Round(number, decimalPlaces)
			return tonumber(string.format("%." .. (decimalPlaces or 0) .. "f", number))
		end

		-- Strings

		local function Split(str, delimiter)
			local start = 1
			local t = {}
			while true do
				local pos = string.find (str, delimiter, start, true)
				if not pos then
					break
				end
				table.insert (t, string.sub (str, start, pos - 1))
				start = pos + string.len (delimiter)
			end
			table.insert (t, string.sub (str, start))
			return t
		end

		-- Data Type Handling

		local function ToString(value, type)
			if type == "float" then
				return tostring(Round(value,2))
			elseif type == "Content" then
				if string.find(value,"/asset") then
					local match = string.find(value, "=") + 1
					local id = string.sub(value, match)
					return id
				else
					return tostring(value)
				end
			elseif type == "Vector2" then
				local x = value.x
				local y = value.y
				return string.format("%g, %g", x,y)
			elseif type == "Vector3" then
				local x = value.x
				local y = value.y
				local z = value.z
				return string.format("%g, %g, %g", x,y,z)
			elseif type == "Color3" then
				local r = value.r
				local g = value.g
				local b = value.b
				return string.format("%d, %d, %d", r*255,g*255,b*255)
			elseif type == "UDim2" then
				local xScale = value.X.Scale
				local xOffset = value.X.Offset
				local yScale = value.Y.Scale
				local yOffset = value.Y.Offset
				return string.format("{%d, %d}, {%d, %d}", xScale, xOffset, yScale, yOffset)
			else
				return tostring(value)
			end
		end

		local function ToValue(value,type)
			if type == "Vector2" then
				local list = Split(value,",")
				if #list < 2 then return nil end
				local x = tonumber(list[1]) or 0
				local y = tonumber(list[2]) or 0
				return Vector2.new(x,y)
			elseif type == "Vector3" then
				local list = Split(value,",")
				if #list < 3 then return nil end
				local x = tonumber(list[1]) or 0
				local y = tonumber(list[2]) or 0
				local z = tonumber(list[3]) or 0
				return Vector3.new(x,y,z)
			elseif type == "Color3" then
				local list = Split(value,",")
				if #list < 3 then return nil end
				local r = tonumber(list[1]) or 0
				local g = tonumber(list[2]) or 0
				local b = tonumber(list[3]) or 0
				return Color3.new(r/255,g/255, b/255)
			elseif type == "UDim2" then
				local list = Split(string.gsub(string.gsub(value, "{", ""),"}",""),",")
				if #list < 4 then return nil end
				local xScale = tonumber(list[1]) or 0
				local xOffset = tonumber(list[2]) or 0
				local yScale = tonumber(list[3]) or 0
				local yOffset = tonumber(list[4]) or 0
				return UDim2.new(xScale, xOffset, yScale, yOffset)
			elseif type == "Content" then
				if tonumber(value) ~= nil then
					value = ContentUrl .. value
				end
				return value
			elseif type == "float" or type == "int" or type == "double" then
				return tonumber(value)
			elseif type == "string" then
				return value
			elseif type == "NumberRange" then
				local list = Split(value,",")
				if #list == 1 then
					if tonumber(list[1]) == nil then return nil end
					local newVal = tonumber(list[1]) or 0
					return NumberRange.new(newVal)
				end
				if #list < 2 then return nil end
				local x = tonumber(list[1]) or 0
				local y = tonumber(list[2]) or 0
				return NumberRange.new(x,y)
			else
				return nil
			end
		end


		-- Tables

		local function CopyTable(T)
			local t2 = {}
			for k,v in pairs(T) do
				t2[k] = v
			end
			return t2
		end

		local function SortTable(T)
			table.sort(T, 
				function(x,y) return x.Name < y.Name
				end)
		end

		-- Spritesheet
		local Sprite = {
			Width = 13;
			Height = 13;
		}

		local Spritesheet = {
			Image = "http://www.roblox.com/asset/?id=128896947";
			Height = 256;
			Width = 256;
		}

		local Images = {
			"unchecked",
			"checked",
			"unchecked_over",
			"checked_over",
			"unchecked_disabled",
			"checked_disabled"
		}

		local function SpritePosition(spriteName)
			local x = 0
			local y = 0
			for i,v in pairs(Images) do
				if (v == spriteName) then
					return {x, y}
				end
				x = x + Sprite.Height
				if (x + Sprite.Width) > Spritesheet.Width then
					x = 0
					y = y + Sprite.Height
				end
			end
		end

		local function GetCheckboxImageName(checked, readOnly, mouseover)
			if checked then
				if readOnly then
					return "checked_disabled"
				elseif mouseover then
					return "checked_over"
				else
					return "checked"
				end
			else
				if readOnly then
					return "unchecked_disabled"
				elseif mouseover then
					return "unchecked_over"
				else
					return "unchecked"
				end
			end
		end

		local MAP_ID = 418720155

		-- Gui Controls --

		---- IconMap ----
		-- Image size: 256px x 256px
		-- Icon size: 16px x 16px
		-- Padding between each icon: 2px
		-- Padding around image edge: 1px
		-- Total icons: 14 x 14 (196)
		local Icon do
			local iconMap = 'http://www.roblox.com/asset/?id=' .. MAP_ID
			game:GetService('ContentProvider'):Preload(iconMap)
			local iconDehash do
				-- 14 x 14, 0-based input, 0-based output
				local f=math.floor
				function iconDehash(h)
					return f(h/14%14),f(h%14)
				end
			end

			function Icon(IconFrame,index)
				local row,col = iconDehash(index)
				local mapSize = Vector2.new(256,256)
				local pad,border = 2,1
				local iconSize = 16

				local class = 'Frame'
				if type(IconFrame) == 'string' then
					class = IconFrame
					IconFrame = nil
				end

				if not IconFrame then
					IconFrame = Create(class,{
						Name = "Icon";
						BackgroundTransparency = 1;
						ClipsDescendants = true;
						Create('ImageLabel',{
							Name = "IconMap";
							Active = false;
							BackgroundTransparency = 1;
							Image = iconMap;
							Size = UDim2.new(mapSize.x/iconSize,0,mapSize.y/iconSize,0);
						});
					})
				end

				IconFrame.IconMap.Position = UDim2.new(-col - (pad*(col+1) + border)/iconSize,0,-row - (pad*(row+1) + border)/iconSize,0)
				return IconFrame
			end
		end

		local function CreateCell()
			local tableCell = Instance.new("Frame")
			tableCell.Size = UDim2.new(0.5, -1, 1, 0)
			tableCell.BackgroundColor3 = Row.BackgroundColor
			tableCell.BorderColor3 = Row.BorderColor
			return tableCell
		end

		local function CreateLabel(readOnly)
			local label = Instance.new("TextLabel")
			label.Font = Row.Font
			label.FontSize = Row.FontSize
			label.TextXAlignment = Row.TextXAlignment
			label.BackgroundTransparency = 1

			if readOnly then
				label.TextColor3 = Row.TextLockedColor
			else
				label.TextColor3 = Row.TextColor
			end
			return label
		end

		local function CreateTextButton(readOnly, onClick)
			local button = Instance.new("TextButton")
			button.Font = Row.Font
			button.FontSize = Row.FontSize
			button.TextXAlignment = Row.TextXAlignment
			button.BackgroundTransparency = 1
			if readOnly then
				button.TextColor3 = Row.TextLockedColor
			else
				button.TextColor3 = Row.TextColor
				button.MouseButton1Click:connect(function()
					onClick()
				end)
			end
			return button
		end

		local function CreateObject(readOnly)
			local button = Instance.new("TextButton")
			button.Font = Row.Font
			button.FontSize = Row.FontSize
			button.TextXAlignment = Row.TextXAlignment
			button.BackgroundTransparency = 1
			if readOnly then
				button.TextColor3 = Row.TextLockedColor
			else
				button.TextColor3 = Row.TextColor
			end
			local cancel = Create(Icon('ImageButton',177),{
				Name = "Cancel";
				Visible = false;
				Position = UDim2.new(1,-20,0,0);
				Size = UDim2.new(0,20,0,20);
				Parent = button;
			})
			return button
		end

		local function CreateTextBox(readOnly)
			if readOnly then
				local box = CreateLabel(readOnly)
				return box
			else
				local box = Instance.new("TextBox")
				if not SettingsRemote:Invoke("ClearProps") then
					box.ClearTextOnFocus = false
				end
				box.Font = Row.Font
				box.FontSize = Row.FontSize
				box.TextXAlignment = Row.TextXAlignment
				box.BackgroundTransparency = 1
				box.TextColor3 = Row.TextColor
				return box
			end
		end

		local function CreateDropDownItem(text, onClick)
			local button = Instance.new("TextButton")
			button.Font = DropDown.Font
			button.FontSize = DropDown.FontSize
			button.TextColor3 = DropDown.TextColor
			button.TextXAlignment = DropDown.TextXAlignment
			button.BackgroundColor3 = DropDown.BackColor
			button.AutoButtonColor = false
			button.BorderSizePixel = 0
			button.Active = true
			button.Text = text

			button.MouseEnter:connect(function()
				button.TextColor3 = DropDown.TextColorOver
				button.BackgroundColor3 = DropDown.BackColorOver
			end)
			button.MouseLeave:connect(function()
				button.TextColor3 = DropDown.TextColor
				button.BackgroundColor3 = DropDown.BackColor
			end)
			button.MouseButton1Click:connect(function()
				onClick(text)
			end)	
			return button
		end

		local function CreateDropDown(choices, currentChoice, readOnly, onClick)
			local frame = Instance.new("Frame")	
			frame.Name = "DropDown"
			frame.Size = UDim2.new(1, 0, 1, 0)
			frame.BackgroundTransparency = 1
			frame.Active = true

			local menu = nil
			local arrow = nil
			local expanded = false
			local margin = DropDown.BorderSizePixel;

			local button = Instance.new("TextButton")
			button.Font = Row.Font
			button.FontSize = Row.FontSize
			button.TextXAlignment = Row.TextXAlignment
			button.BackgroundTransparency = 1
			button.TextColor3 = Row.TextColor
			if readOnly then
				button.TextColor3 = Row.TextLockedColor
			end
			button.Text = currentChoice
			button.Size = UDim2.new(1, -2 * Styles.Margin, 1, 0)
			button.Position = UDim2.new(0, Styles.Margin, 0, 0)
			button.Parent = frame

			local function showArrow(color)
				if arrow then arrow:Destroy() end

				local graphicTemplate = Create('Frame',{
					Name="Graphic";
					BorderSizePixel = 0;
					BackgroundColor3 = color;
				})
				local graphicSize = 16/2

				arrow = ArrowGraphic(graphicSize,'Down',true,graphicTemplate)
				arrow.Position = UDim2.new(1,-graphicSize * 2,0.5,-graphicSize/2)
				arrow.Parent = frame
			end

			local function hideMenu()
				expanded = false
				showArrow(DropDown.ArrowColor)
				if menu then menu:Destroy() end
			end

			local function showMenu()
				expanded = true
				menu = Instance.new("Frame")
				menu.Size = UDim2.new(1, -2 * margin, 0, #choices * DropDown.Height)
				menu.Position = UDim2.new(0, margin, 0, Row.Height + margin)
				menu.BackgroundTransparency = 0
				menu.BackgroundColor3 = DropDown.BackColor
				menu.BorderColor3 = DropDown.BorderColor
				menu.BorderSizePixel = DropDown.BorderSizePixel
				menu.Active = true
				menu.ZIndex = 5
				menu.Parent = frame

				local parentFrameHeight = menu.Parent.Parent.Parent.Parent.Size.Y.Offset
				local rowHeight = menu.Parent.Parent.Parent.Position.Y.Offset
				if (rowHeight + menu.Size.Y.Offset) > math.max(parentFrameHeight,PropertiesFrame.AbsoluteSize.y) then
					menu.Position = UDim2.new(0, margin, 0, -1 * (#choices * DropDown.Height) - margin)
				end

				local function choice(name)
					onClick(name)
					hideMenu()
				end

				for i,name in pairs(choices) do
					local option = CreateDropDownItem(name, function()
						choice(name)
					end)
					option.Size = UDim2.new(1, 0, 0, 16)
					option.Position = UDim2.new(0, 0, 0, (i - 1) * DropDown.Height)
					option.ZIndex = menu.ZIndex
					option.Parent = menu
				end
			end

			showArrow(DropDown.ArrowColor)

			if not readOnly then

				button.MouseEnter:connect(function()
					button.TextColor3 = Row.TextColor
					showArrow(DropDown.ArrowColorOver)
				end)
				button.MouseLeave:connect(function()
					button.TextColor3 = Row.TextColor
					if not expanded then
						showArrow(DropDown.ArrowColor)
					end
				end)
				button.MouseButton1Click:connect(function()
					if expanded then
						hideMenu()
					else
						showMenu()
					end
				end)
			end

			return frame,button
		end

		local function CreateBrickColor(readOnly, onClick)
			local frame = Instance.new("Frame")
			frame.Size = UDim2.new(1,0,1,0)
			frame.BackgroundTransparency = 1

			local colorPalette = Instance.new("Frame")
			colorPalette.BackgroundTransparency = 0
			colorPalette.SizeConstraint = Enum.SizeConstraint.RelativeXX
			colorPalette.Size = UDim2.new(1, -2 * BrickColors.OuterBorder, 1, -2 * BrickColors.OuterBorder)
			colorPalette.BorderSizePixel = BrickColors.BorderSizePixel
			colorPalette.BorderColor3 = BrickColors.BorderColor
			colorPalette.Position = UDim2.new(0, BrickColors.OuterBorder, 0, BrickColors.OuterBorder + Row.Height)
			colorPalette.ZIndex = 5
			colorPalette.Visible = false
			colorPalette.BorderSizePixel = BrickColors.OuterBorder
			colorPalette.BorderColor3 = BrickColors.OuterBorderColor
			colorPalette.Parent = frame

			local function show()
				colorPalette.Visible = true
			end

			local function hide()
				colorPalette.Visible = false
			end

			local function toggle()
				colorPalette.Visible = not colorPalette.Visible
			end

			local colorBox = Instance.new("TextButton", frame)
			colorBox.Position = UDim2.new(0, Styles.Margin, 0, Styles.Margin)
			colorBox.Size = UDim2.new(0, BrickColors.BoxSize, 0, BrickColors.BoxSize)
			colorBox.Text = ""
			colorBox.MouseButton1Click:connect(function()
				if not readOnly then
					toggle()
				end
			end)

			if readOnly then
				colorBox.AutoButtonColor = false
			end

			local spacingBefore = (Styles.Margin * 2) + BrickColors.BoxSize

			local propertyLabel = CreateTextButton(readOnly, function()
				if not readOnly then
					toggle()
				end
			end)
			propertyLabel.Size = UDim2.new(1, (-1 * spacingBefore) - Styles.Margin, 1, 0)
			propertyLabel.Position = UDim2.new(0, spacingBefore, 0, 0)
			propertyLabel.Parent = frame

			local size = (1 / BrickColors.ColorsPerRow)

			for index = 0, 127 do
				local brickColor = BrickColor.palette(index)
				local color3 = brickColor.Color

				local x = size * (index % BrickColors.ColorsPerRow)
				local y = size * math.floor(index / BrickColors.ColorsPerRow)

				local brickColorBox = Instance.new("TextButton")
				brickColorBox.Text = ""
				brickColorBox.Size = UDim2.new(size,0,size,0)
				brickColorBox.BackgroundColor3 = color3
				brickColorBox.Position = UDim2.new(x, 0, y, 0)
				brickColorBox.ZIndex = colorPalette.ZIndex
				brickColorBox.Parent = colorPalette

				brickColorBox.MouseButton1Click:connect(function()
					hide()
					onClick(brickColor)
				end)
			end

			return frame,propertyLabel,colorBox
		end

		local function CreateColor3Control(readOnly, onClick)
			local frame = Instance.new("Frame")
			frame.Size = UDim2.new(1,0,1,0)
			frame.BackgroundTransparency = 1

			local colorBox = Instance.new("TextButton", frame)
			colorBox.Position = UDim2.new(0, Styles.Margin, 0, Styles.Margin)
			colorBox.Size = UDim2.new(0, BrickColors.BoxSize, 0, BrickColors.BoxSize)
			colorBox.Text = ""
			colorBox.AutoButtonColor = false

			local spacingBefore = (Styles.Margin * 2) + BrickColors.BoxSize
			local box = CreateTextBox(readOnly)
			box.Size = UDim2.new(1, (-1 * spacingBefore) - Styles.Margin, 1, 0)
			box.Position = UDim2.new(0, spacingBefore, 0, 0)
			box.Parent = frame

			return frame,box,colorBox
		end

		function CreateCheckbox(value, readOnly, onClick)
			local checked = value
			local mouseover = false

			local checkboxFrame = Instance.new("ImageButton")
			checkboxFrame.Size = UDim2.new(0, Sprite.Width, 0, Sprite.Height)
			checkboxFrame.BackgroundTransparency = 1
			checkboxFrame.ClipsDescendants = true
			--checkboxFrame.Position = UDim2.new(0, Styles.Margin, 0, Styles.Margin)

			local spritesheetImage = Instance.new("ImageLabel", checkboxFrame)
			spritesheetImage.Name = "SpritesheetImageLabel"
			spritesheetImage.Size = UDim2.new(0, Spritesheet.Width, 0, Spritesheet.Height)
			spritesheetImage.Image = Spritesheet.Image
			spritesheetImage.BackgroundTransparency = 1

			local function updateSprite()
				local spriteName = GetCheckboxImageName(checked, readOnly, mouseover)
				local spritePosition = SpritePosition(spriteName)
				spritesheetImage.Position = UDim2.new(0, -1 * spritePosition[1], 0, -1 * spritePosition[2])
			end

			local function setValue(val)
				checked = val
				updateSprite()
			end

			if not readOnly then
				checkboxFrame.MouseEnter:connect(function() mouseover = true updateSprite() end)
				checkboxFrame.MouseLeave:connect(function() mouseover = false updateSprite() end)
				checkboxFrame.MouseButton1Click:connect(function()
					onClick(checked)
				end)
			end

			updateSprite()

			return checkboxFrame, setValue
		end



		-- Code for handling controls of various data types --

		local Controls = {}

		Controls["default"] = function(object, propertyData, readOnly)
			local propertyName = propertyData["Name"]
			local propertyType = propertyData["ValueType"]

			local box = CreateTextBox(readOnly)
			box.Size = UDim2.new(1, -2 * Styles.Margin, 1, 0)
			box.Position = UDim2.new(0, Styles.Margin, 0, 0)

			local function update()
				local value = object[propertyName]
				box.Text = ToString(value, propertyType)
			end

			if not readOnly then
				box.FocusLost:connect(function(enterPressed)
					Set(object, propertyData, ToValue(box.Text,propertyType))
					update()
				end)
			end

			update()

			object.Changed:connect(function(property)
				if (property == propertyName) then
					update()
				end
			end)

			return box
		end

		Controls["bool"] = function(object, propertyData, readOnly)
			local propertyName = propertyData["Name"]
			local checked = object[propertyName]

			local checkbox, setValue = CreateCheckbox(checked, readOnly, function(value)
				Set(object, propertyData, not checked)
			end)
			checkbox.Position = UDim2.new(0, Styles.Margin, 0, Styles.Margin)

			setValue(checked)

			local function update()
				checked = object[propertyName]
				setValue(checked)
			end

			object.Changed:connect(function(property)
				if (property == propertyName) then
					update()
				end
			end)

			if object:IsA("BoolValue") then
				object.Changed:connect(function(val)
					update()
				end)
			end

			update()

			return checkbox
		end

		Controls["BrickColor"] = function(object, propertyData, readOnly)
			local propertyName = propertyData["Name"]

			local frame,label,brickColorBox = CreateBrickColor(readOnly, function(brickColor)
				Set(object, propertyData, brickColor)
			end)

			local function update()
				local value = object[propertyName]
				brickColorBox.BackgroundColor3 = value.Color
				label.Text = tostring(value)
			end

			update()

			object.Changed:connect(function(property)
				if (property == propertyName) then
					update()
				end
			end)

			return frame
		end

		Controls["Color3"] = function(object, propertyData, readOnly)
			local propertyName = propertyData["Name"]

			local frame,textBox,colorBox = CreateColor3Control(readOnly)

			textBox.FocusLost:connect(function(enterPressed)
				Set(object, propertyData, ToValue(textBox.Text,"Color3"))
				local value = object[propertyName]
				colorBox.BackgroundColor3 = value
				textBox.Text = ToString(value, "Color3")
			end)

			local function update()
				local value = object[propertyName]
				colorBox.BackgroundColor3 = value
				textBox.Text = ToString(value, "Color3")
			end

			update()

			object.Changed:connect(function(property)
				if (property == propertyName) then
					update()
				end
			end)

			return frame
		end

		Controls["Enum"] = function(object, propertyData, readOnly)
			local propertyName = propertyData["Name"]
			local propertyType = propertyData["ValueType"]

			local enumName = object[propertyName].Name

			local enumNames = {}
			for _,enum in pairs(Enum[tostring(propertyType)]:GetEnumItems()) do
				table.insert(enumNames, enum.Name)
			end

			local dropdown, propertyLabel = CreateDropDown(enumNames, enumName, readOnly, function(value)
				Set(object, propertyData, value)
			end)
			--dropdown.Parent = frame

			local function update()
				local value = object[propertyName].Name
				propertyLabel.Text = tostring(value)
			end

			update()

			object.Changed:connect(function(property)
				if (property == propertyName) then
					update()
				end
			end)

			return dropdown
		end

		Controls["Object"] = function(object, propertyData, readOnly)
			local propertyName = propertyData["Name"]
			local propertyType = propertyData["ValueType"]

			local box = CreateObject(readOnly,function()end)
			box.Size = UDim2.new(1, -2 * Styles.Margin, 1, 0)
			box.Position = UDim2.new(0, Styles.Margin, 0, 0)

			local function update()
				if AwaitingObjectObj == object then
					if AwaitingObjectValue == true then
						box.Text = "Select an Object"
						return
					end
				end
				local value = object[propertyName]
				box.Text = ToString(value, propertyType)
			end

			if not readOnly then
				box.MouseButton1Click:connect(function()
					if AwaitingObjectValue then
						AwaitingObjectValue = false
						update()
						return
					end
					AwaitingObjectValue = true
					AwaitingObjectObj = object
					AwaitingObjectProp = propertyData
					box.Text = "Select an Object"
				end)

				box.Cancel.Visible = true
				box.Cancel.MouseButton1Click:connect(function()
					object[propertyName] = nil
				end)
			end

			update()

			object.Changed:connect(function(property)
				if (property == propertyName) then
					update()
				end
			end)

			if object:IsA("ObjectValue") then
				object.Changed:connect(function(val)
					update()
				end)
			end

			return box
		end

		function GetControl(object, propertyData, readOnly)
			local propertyType = propertyData["ValueType"]
			local control = nil

			if Controls[propertyType] then
				control = Controls[propertyType](object, propertyData, readOnly)
			elseif RbxApi.IsEnum(propertyType) then
				control = Controls["Enum"](object, propertyData, readOnly)
			else
				control = Controls["default"](object, propertyData, readOnly)
			end
			return control
		end
		-- Permissions

		function CanEditObject(object)
			local player = Players.LocalPlayer
			local character = player.Character
			return Permissions.CanEdit
		end

		function CanEditProperty(object,propertyData)
			local tags = propertyData["tags"]
			for _,name in pairs(tags) do
				if name == "readonly" then
					return false
				end
			end
			return CanEditObject(object)
		end

		--RbxApi
		local function PropertyIsHidden(propertyData)
			local tags = propertyData["tags"]
			for _,name in pairs(tags) do
				if name == "deprecated"
					or name == "hidden"
					or name == "writeonly" then
					return true
				end
			end
			return false
		end

		function Set(object, propertyData, value)
			local propertyName = propertyData["Name"]
			local propertyType = propertyData["ValueType"]

			if value == nil then return end

			for i,v in pairs(GetSelection()) do
				if CanEditProperty(v,propertyData) then
					pcall(function()
						--print("Setting " .. propertyName .. " to " .. tostring(value))
						v[propertyName] = value
					end)
				end
			end
		end

		function CreateRow(object, propertyData, isAlternateRow)
			local propertyName = propertyData["Name"]
			local propertyType = propertyData["ValueType"]
			local propertyValue = object[propertyName]
			--rowValue, rowValueType, isAlternate
			local backColor = Row.BackgroundColor;
			if (isAlternateRow) then
				backColor = Row.BackgroundColorAlternate
			end

			local readOnly = not CanEditProperty(object, propertyData)
			if propertyType == "Instance" or propertyName == "Parent" then readOnly = true end

			local rowFrame = Instance.new("Frame")
			rowFrame.Size = UDim2.new(1,0,0,Row.Height)
			rowFrame.BackgroundTransparency = 1
			rowFrame.Name = 'Row'

			local propertyLabelFrame = CreateCell()
			propertyLabelFrame.Parent = rowFrame
			propertyLabelFrame.ClipsDescendants = true

			local propertyLabel = CreateLabel(readOnly)
			propertyLabel.Text = propertyName
			propertyLabel.Size = UDim2.new(1, -1 * Row.TitleMarginLeft, 1, 0)
			propertyLabel.Position = UDim2.new(0, Row.TitleMarginLeft, 0, 0)
			propertyLabel.Parent = propertyLabelFrame

			local propertyValueFrame = CreateCell()
			propertyValueFrame.Size = UDim2.new(0.5, -1, 1, 0)
			propertyValueFrame.Position = UDim2.new(0.5, 0, 0, 0)
			propertyValueFrame.Parent = rowFrame

			local control = GetControl(object, propertyData, readOnly)
			control.Parent = propertyValueFrame

			rowFrame.MouseEnter:connect(function()
				propertyLabelFrame.BackgroundColor3 = Row.BackgroundColorMouseover
				propertyValueFrame.BackgroundColor3 = Row.BackgroundColorMouseover
			end)
			rowFrame.MouseLeave:connect(function()
				propertyLabelFrame.BackgroundColor3 = backColor
				propertyValueFrame.BackgroundColor3 = backColor
			end)

			propertyLabelFrame.BackgroundColor3 = backColor
			propertyValueFrame.BackgroundColor3 = backColor

			return rowFrame
		end

		function ClearPropertiesList()
			for _,instance in pairs(ContentFrame:GetChildren()) do
				instance:Destroy()
			end
		end

		local selection = Gui:FindFirstChild("Selection", 1)
		print(selection)

		function displayProperties(props)
			for i,v in pairs(props) do
				pcall(function()
					local a = CreateRow(v.object, v.propertyData, ((numRows % 2) == 0))
					a.Position = UDim2.new(0,0,0,numRows*Row.Height)
					a.Parent = ContentFrame
					numRows = numRows + 1
				end)
			end
		end

		function checkForDupe(prop,props)
			for i,v in pairs(props) do
				if v.propertyData.Name == prop.Name and v.propertyData.ValueType == prop.ValueType then
					return true
				end
			end
			return false
		end

		function sortProps(t)
			table.sort(t, 
				function(x,y) return x.propertyData.Name < y.propertyData.Name
				end)
		end

		function showProperties(obj)
			ClearPropertiesList()
			if obj == nil then return end
			local propHolder = {}
			local foundProps = {}
			numRows = 0
			for _,nextObj in pairs(obj) do
				if not foundProps[nextObj.className] then
					foundProps[nextObj.className] = true
					for i,v in pairs(RbxApi.GetProperties(nextObj.className)) do
						local suc, err = pcall(function()
							if not (PropertyIsHidden(v)) and not checkForDupe(v,propHolder) then
								if string.find(string.lower(v.Name),string.lower(propertiesSearch.Text)) or not searchingProperties() then
									table.insert(propHolder,{propertyData = v, object = nextObj})
								end
							end
						end)
				--[[if not suc then 
					warn("Problem getting the value of property " .. v.Name .. " | " .. err)
				end	--]]
					end
				end
			end
			sortProps(propHolder)
			displayProperties(propHolder)
			ContentFrame.Size = UDim2.new(1, 0, 0, numRows * Row.Height)
			scrollBar.ScrollIndex = 0
			scrollBar.TotalSpace = numRows * Row.Height
			scrollBar.Update()
		end

		----------------------------------------------------------------
		-----------------------SCROLLBAR STUFF--------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		local ScrollBarWidth = 16

		local ScrollStyles = {
			Background      = Color3.new(233/255, 233/255, 233/255);
			Border          = Color3.new(149/255, 149/255, 149/255);
			Selected        = Color3.new( 63/255, 119/255, 189/255);
			BorderSelected  = Color3.new( 55/255, 106/255, 167/255);
			Text            = Color3.new(  0/255,   0/255,   0/255);
			TextDisabled    = Color3.new(128/255, 128/255, 128/255);
			TextSelected    = Color3.new(255/255, 255/255, 255/255);
			Button          = Color3.new(221/255, 221/255, 221/255);
			ButtonBorder    = Color3.new(149/255, 149/255, 149/255);
			ButtonSelected  = Color3.new(255/255,   0/255,   0/255);
			Field           = Color3.new(255/255, 255/255, 255/255);
			FieldBorder     = Color3.new(191/255, 191/255, 191/255);
			TitleBackground = Color3.new(178/255, 178/255, 178/255);
		}
		do
			local ZIndexLock = {}
			function SetZIndex(object,z)
				if not ZIndexLock[object] then
					ZIndexLock[object] = true
					if object:IsA'GuiObject' then
						object.ZIndex = z
					end
					local children = object:GetChildren()
					for i = 1,#children do
						SetZIndex(children[i],z)
					end
					ZIndexLock[object] = nil
				end
			end
		end
		function SetZIndexOnChanged(object)
			return object.Changed:connect(function(p)
				if p == "ZIndex" then
					SetZIndex(object,object.ZIndex)
				end
			end)
		end
		function Create(ty,data)
			local obj
			if type(ty) == 'string' then
				obj = Instance.new(ty)
			else
				obj = ty
			end
			for k, v in pairs(data) do
				if type(k) == 'number' then
					v.Parent = obj
				else
					obj[k] = v
				end
			end
			return obj
		end
		-- returns the ascendant ScreenGui of an object
		function GetScreen(screen)
			if screen == nil then return nil end
			while not screen:IsA("ScreenGui") do
				screen = screen.Parent
				if screen == nil then return nil end
			end
			return screen
		end
		-- AutoButtonColor doesn't always reset properly
		function ResetButtonColor(button)
			local active = button.Active
			button.Active = not active
			button.Active = active
		end

		function ArrowGraphic(size,dir,scaled,template)
			local Frame = Create('Frame',{
				Name = "Arrow Graphic";
				BorderSizePixel = 0;
				Size = UDim2.new(0,size,0,size);
				Transparency = 1;
			})
			if not template then
				template = Instance.new("Frame")
				template.BorderSizePixel = 0
			end

			local transform
			if dir == nil or dir == 'Up' then
				function transform(p,s) return p,s end
			elseif dir == 'Down' then
				function transform(p,s) return UDim2.new(0,p.X.Offset,0,size-p.Y.Offset-1),s end
			elseif dir == 'Left' then
				function transform(p,s) return UDim2.new(0,p.Y.Offset,0,p.X.Offset),UDim2.new(0,s.Y.Offset,0,s.X.Offset) end
			elseif dir == 'Right' then
				function transform(p,s) return UDim2.new(0,size-p.Y.Offset-1,0,p.X.Offset),UDim2.new(0,s.Y.Offset,0,s.X.Offset) end
			end

			local scale
			if scaled then
				function scale(p,s) return UDim2.new(p.X.Offset/size,0,p.Y.Offset/size,0),UDim2.new(s.X.Offset/size,0,s.Y.Offset/size,0) end
			else
				function scale(p,s) return p,s end
			end

			local o = math.floor(size/4)
			if size%2 == 0 then
				local n = size/2-1
				for i = 0,n do
					local t = template:Clone()
					local p,s = scale(transform(
						UDim2.new(0,n-i,0,o+i),
						UDim2.new(0,(i+1)*2,0,1)
						))
					t.Position = p
					t.Size = s
					t.Parent = Frame
				end
			else
				local n = (size-1)/2
				for i = 0,n do
					local t = template:Clone()
					local p,s = scale(transform(
						UDim2.new(0,n-i,0,o+i),
						UDim2.new(0,i*2+1,0,1)
						))
					t.Position = p
					t.Size = s
					t.Parent = Frame
				end
			end
			if size%4 > 1 then
				local t = template:Clone()
				local p,s = scale(transform(
					UDim2.new(0,0,0,size-o-1),
					UDim2.new(0,size,0,1)
					))
				t.Position = p
				t.Size = s
				t.Parent = Frame
			end
			return Frame
		end

		function GripGraphic(size,dir,spacing,scaled,template)
			local Frame = Create('Frame',{
				Name = "Grip Graphic";
				BorderSizePixel = 0;
				Size = UDim2.new(0,size.x,0,size.y);
				Transparency = 1;
			})
			if not template then
				template = Instance.new("Frame")
				template.BorderSizePixel = 0
			end

			spacing = spacing or 2

			local scale
			if scaled then
				function scale(p) return UDim2.new(p.X.Offset/size.x,0,p.Y.Offset/size.y,0) end
			else
				function scale(p) return p end
			end

			if dir == 'Vertical' then
				for i=0,size.x-1,spacing do
					local t = template:Clone()
					t.Size = scale(UDim2.new(0,1,0,size.y))
					t.Position = scale(UDim2.new(0,i,0,0))
					t.Parent = Frame
				end
			elseif dir == nil or dir == 'Horizontal' then
				for i=0,size.y-1,spacing do
					local t = template:Clone()
					t.Size = scale(UDim2.new(0,size.x,0,1))
					t.Position = scale(UDim2.new(0,0,0,i))
					t.Parent = Frame
				end
			end

			return Frame
		end

		do
			local mt = {
				__index = {
					GetScrollPercent = function(self)
						return self.ScrollIndex/(self.TotalSpace-self.VisibleSpace)
					end;
					CanScrollDown = function(self)
						return self.ScrollIndex + self.VisibleSpace < self.TotalSpace
					end;
					CanScrollUp = function(self)
						return self.ScrollIndex > 0
					end;
					ScrollDown = function(self)
						self.ScrollIndex = self.ScrollIndex + self.PageIncrement
						self:Update()
					end;
					ScrollUp = function(self)
						self.ScrollIndex = self.ScrollIndex - self.PageIncrement
						self:Update()
					end;
					ScrollTo = function(self,index)
						self.ScrollIndex = index
						self:Update()
					end;
					SetScrollPercent = function(self,percent)
						self.ScrollIndex = math.floor((self.TotalSpace - self.VisibleSpace)*percent + 0.5)
						self:Update()
					end;
				};
			}
			mt.__index.CanScrollRight = mt.__index.CanScrollDown
			mt.__index.CanScrollLeft = mt.__index.CanScrollUp
			mt.__index.ScrollLeft = mt.__index.ScrollUp
			mt.__index.ScrollRight = mt.__index.ScrollDown

			function ScrollBar(horizontal)
				-- create row scroll bar
				local ScrollFrame = Create('Frame',{
					Name = "ScrollFrame";
					Position = horizontal and UDim2.new(0,0,1,-ScrollBarWidth) or UDim2.new(1,-ScrollBarWidth,0,0);
					Size = horizontal and UDim2.new(1,0,0,ScrollBarWidth) or UDim2.new(0,ScrollBarWidth,1,0);
					BackgroundTransparency = 1;
					Create('ImageButton',{
						Name = "ScrollDown";
						Position = horizontal and UDim2.new(1,-ScrollBarWidth,0,0) or UDim2.new(0,0,1,-ScrollBarWidth);
						Size = UDim2.new(0, ScrollBarWidth, 0, ScrollBarWidth);
						BackgroundColor3 = ScrollStyles.Button;
						BorderColor3 = ScrollStyles.Border;
						--BorderSizePixel = 0;
					});
					Create('ImageButton',{
						Name = "ScrollUp";
						Size = UDim2.new(0, ScrollBarWidth, 0, ScrollBarWidth);
						BackgroundColor3 = ScrollStyles.Button;
						BorderColor3 = ScrollStyles.Border;
						--BorderSizePixel = 0;
					});
					Create('ImageButton',{
						Name = "ScrollBar";
						Size = horizontal and UDim2.new(1,-ScrollBarWidth*2,1,0) or UDim2.new(1,0,1,-ScrollBarWidth*2);
						Position = horizontal and UDim2.new(0,ScrollBarWidth,0,0) or UDim2.new(0,0,0,ScrollBarWidth);
						AutoButtonColor = false;
						BackgroundColor3 = Color3.new(0.94902, 0.94902, 0.94902);
						BorderColor3 = ScrollStyles.Border;
						--BorderSizePixel = 0;
						Create('ImageButton',{
							Name = "ScrollThumb";
							AutoButtonColor = false;
							Size = UDim2.new(0, ScrollBarWidth, 0, ScrollBarWidth);
							BackgroundColor3 = ScrollStyles.Button;
							BorderColor3 = ScrollStyles.Border;
							--BorderSizePixel = 0;
						});
					});
				})

				local graphicTemplate = Create('Frame',{
					Name="Graphic";
					BorderSizePixel = 0;
					BackgroundColor3 = ScrollStyles.Border;
				})
				local graphicSize = ScrollBarWidth/2

				local ScrollDownFrame = ScrollFrame.ScrollDown
				local ScrollDownGraphic = ArrowGraphic(graphicSize,horizontal and 'Right' or 'Down',true,graphicTemplate)
				ScrollDownGraphic.Position = UDim2.new(0.5,-graphicSize/2,0.5,-graphicSize/2)
				ScrollDownGraphic.Parent = ScrollDownFrame
				local ScrollUpFrame = ScrollFrame.ScrollUp
				local ScrollUpGraphic = ArrowGraphic(graphicSize,horizontal and 'Left' or 'Up',true,graphicTemplate)
				ScrollUpGraphic.Position = UDim2.new(0.5,-graphicSize/2,0.5,-graphicSize/2)
				ScrollUpGraphic.Parent = ScrollUpFrame
				local ScrollBarFrame = ScrollFrame.ScrollBar
				local ScrollThumbFrame = ScrollBarFrame.ScrollThumb
				do
					local size = ScrollBarWidth*3/8
					local Decal = GripGraphic(Vector2.new(size,size),horizontal and 'Vertical' or 'Horizontal',2,graphicTemplate)
					Decal.Position = UDim2.new(0.5,-size/2,0.5,-size/2)
					Decal.Parent = ScrollThumbFrame
				end

				local MouseDrag = Create('ImageButton',{
					Name = "MouseDrag";
					Position = UDim2.new(-0.25,0,-0.25,0);
					Size = UDim2.new(1.5,0,1.5,0);
					Transparency = 1;
					AutoButtonColor = false;
					Active = true;
					ZIndex = 10;
				})

				local Class = setmetatable({
					GUI = ScrollFrame;
					ScrollIndex = 0;
					VisibleSpace = 0;
					TotalSpace = 0;
					PageIncrement = 1;
				},mt)

				local UpdateScrollThumb
				if horizontal then
					function UpdateScrollThumb()
						ScrollThumbFrame.Size = UDim2.new(Class.VisibleSpace/Class.TotalSpace,0,0,ScrollBarWidth)
						if ScrollThumbFrame.AbsoluteSize.x < ScrollBarWidth then
							ScrollThumbFrame.Size = UDim2.new(0,ScrollBarWidth,0,ScrollBarWidth)
						end
						local barSize = ScrollBarFrame.AbsoluteSize.x
						ScrollThumbFrame.Position = UDim2.new(Class:GetScrollPercent()*(barSize - ScrollThumbFrame.AbsoluteSize.x)/barSize,0,0,0)
					end
				else
					function UpdateScrollThumb()
						ScrollThumbFrame.Size = UDim2.new(0,ScrollBarWidth,Class.VisibleSpace/Class.TotalSpace,0)
						if ScrollThumbFrame.AbsoluteSize.y < ScrollBarWidth then
							ScrollThumbFrame.Size = UDim2.new(0,ScrollBarWidth,0,ScrollBarWidth)
						end
						local barSize = ScrollBarFrame.AbsoluteSize.y
						ScrollThumbFrame.Position = UDim2.new(0,0,Class:GetScrollPercent()*(barSize - ScrollThumbFrame.AbsoluteSize.y)/barSize,0)
					end
				end

				local lastDown
				local lastUp
				local scrollStyle = {BackgroundColor3=ScrollStyles.Border,BackgroundTransparency=0}
				local scrollStyle_ds = {BackgroundColor3=ScrollStyles.Border,BackgroundTransparency=0.7}

				local function Update()
					local t = Class.TotalSpace
					local v = Class.VisibleSpace
					local s = Class.ScrollIndex
					if v <= t then
						if s > 0 then
							if s + v > t then
								Class.ScrollIndex = t - v
							end
						else
							Class.ScrollIndex = 0
						end
					else
						Class.ScrollIndex = 0
					end

					if Class.UpdateCallback then
						if Class.UpdateCallback(Class) == false then
							return
						end
					end

					local down = Class:CanScrollDown()
					local up = Class:CanScrollUp()
					if down ~= lastDown then
						lastDown = down
						ScrollDownFrame.Active = down
						ScrollDownFrame.AutoButtonColor = down
						local children = ScrollDownGraphic:GetChildren()
						local style = down and scrollStyle or scrollStyle_ds
						for i = 1,#children do
							Create(children[i],style)
						end
					end
					if up ~= lastUp then
						lastUp = up
						ScrollUpFrame.Active = up
						ScrollUpFrame.AutoButtonColor = up
						local children = ScrollUpGraphic:GetChildren()
						local style = up and scrollStyle or scrollStyle_ds
						for i = 1,#children do
							Create(children[i],style)
						end
					end
					ScrollThumbFrame.Visible = down or up
					UpdateScrollThumb()
				end
				Class.Update = Update

				SetZIndexOnChanged(ScrollFrame)

				local scrollEventID = 0
				ScrollDownFrame.MouseButton1Down:connect(function()
					scrollEventID = tick()
					local current = scrollEventID
					local up_con
					up_con = MouseDrag.MouseButton1Up:connect(function()
						scrollEventID = tick()
						MouseDrag.Parent = nil
						ResetButtonColor(ScrollDownFrame)
						up_con:disconnect(); drag = nil
					end)
					MouseDrag.Parent = GetScreen(ScrollFrame)
					Class:ScrollDown()
					wait(0.2) -- delay before auto scroll
					while scrollEventID == current do
						Class:ScrollDown()
						if not Class:CanScrollDown() then break end
						wait()
					end
				end)

				ScrollDownFrame.MouseButton1Up:connect(function()
					scrollEventID = tick()
				end)

				ScrollUpFrame.MouseButton1Down:connect(function()
					scrollEventID = tick()
					local current = scrollEventID
					local up_con
					up_con = MouseDrag.MouseButton1Up:connect(function()
						scrollEventID = tick()
						MouseDrag.Parent = nil
						ResetButtonColor(ScrollUpFrame)
						up_con:disconnect(); drag = nil
					end)
					MouseDrag.Parent = GetScreen(ScrollFrame)
					Class:ScrollUp()
					wait(0.2)
					while scrollEventID == current do
						Class:ScrollUp()
						if not Class:CanScrollUp() then break end
						wait()
					end
				end)

				ScrollUpFrame.MouseButton1Up:connect(function()
					scrollEventID = tick()
				end)

				if horizontal then
					ScrollBarFrame.MouseButton1Down:connect(function(x,y)
						scrollEventID = tick()
						local current = scrollEventID
						local up_con
						up_con = MouseDrag.MouseButton1Up:connect(function()
							scrollEventID = tick()
							MouseDrag.Parent = nil
							ResetButtonColor(ScrollUpFrame)
							up_con:disconnect(); drag = nil
						end)
						MouseDrag.Parent = GetScreen(ScrollFrame)
						if x > ScrollThumbFrame.AbsolutePosition.x then
							Class:ScrollTo(Class.ScrollIndex + Class.VisibleSpace)
							wait(0.2)
							while scrollEventID == current do
								if x < ScrollThumbFrame.AbsolutePosition.x + ScrollThumbFrame.AbsoluteSize.x then break end
								Class:ScrollTo(Class.ScrollIndex + Class.VisibleSpace)
								wait()
							end
						else
							Class:ScrollTo(Class.ScrollIndex - Class.VisibleSpace)
							wait(0.2)
							while scrollEventID == current do
								if x > ScrollThumbFrame.AbsolutePosition.x then break end
								Class:ScrollTo(Class.ScrollIndex - Class.VisibleSpace)
								wait()
							end
						end
					end)
				else
					ScrollBarFrame.MouseButton1Down:connect(function(x,y)
						scrollEventID = tick()
						local current = scrollEventID
						local up_con
						up_con = MouseDrag.MouseButton1Up:connect(function()
							scrollEventID = tick()
							MouseDrag.Parent = nil
							ResetButtonColor(ScrollUpFrame)
							up_con:disconnect(); drag = nil
						end)
						MouseDrag.Parent = GetScreen(ScrollFrame)
						if y > ScrollThumbFrame.AbsolutePosition.y then
							Class:ScrollTo(Class.ScrollIndex + Class.VisibleSpace)
							wait(0.2)
							while scrollEventID == current do
								if y < ScrollThumbFrame.AbsolutePosition.y + ScrollThumbFrame.AbsoluteSize.y then break end
								Class:ScrollTo(Class.ScrollIndex + Class.VisibleSpace)
								wait()
							end
						else
							Class:ScrollTo(Class.ScrollIndex - Class.VisibleSpace)
							wait(0.2)
							while scrollEventID == current do
								if y > ScrollThumbFrame.AbsolutePosition.y then break end
								Class:ScrollTo(Class.ScrollIndex - Class.VisibleSpace)
								wait()
							end
						end
					end)
				end

				if horizontal then
					ScrollThumbFrame.MouseButton1Down:connect(function(x,y)
						scrollEventID = tick()
						local mouse_offset = x - ScrollThumbFrame.AbsolutePosition.x
						local drag_con
						local up_con
						drag_con = MouseDrag.MouseMoved:connect(function(x,y)
							local bar_abs_pos = ScrollBarFrame.AbsolutePosition.x
							local bar_drag = ScrollBarFrame.AbsoluteSize.x - ScrollThumbFrame.AbsoluteSize.x
							local bar_abs_one = bar_abs_pos + bar_drag
							x = x - mouse_offset
							x = x < bar_abs_pos and bar_abs_pos or x > bar_abs_one and bar_abs_one or x
							x = x - bar_abs_pos
							Class:SetScrollPercent(x/(bar_drag))
						end)
						up_con = MouseDrag.MouseButton1Up:connect(function()
							scrollEventID = tick()
							MouseDrag.Parent = nil
							ResetButtonColor(ScrollThumbFrame)
							drag_con:disconnect(); drag_con = nil
							up_con:disconnect(); drag = nil
						end)
						MouseDrag.Parent = GetScreen(ScrollFrame)
					end)
				else
					ScrollThumbFrame.MouseButton1Down:connect(function(x,y)
						scrollEventID = tick()
						local mouse_offset = y - ScrollThumbFrame.AbsolutePosition.y
						local drag_con
						local up_con
						drag_con = MouseDrag.MouseMoved:connect(function(x,y)
							local bar_abs_pos = ScrollBarFrame.AbsolutePosition.y
							local bar_drag = ScrollBarFrame.AbsoluteSize.y - ScrollThumbFrame.AbsoluteSize.y
							local bar_abs_one = bar_abs_pos + bar_drag
							y = y - mouse_offset
							y = y < bar_abs_pos and bar_abs_pos or y > bar_abs_one and bar_abs_one or y
							y = y - bar_abs_pos
							Class:SetScrollPercent(y/(bar_drag))
						end)
						up_con = MouseDrag.MouseButton1Up:connect(function()
							scrollEventID = tick()
							MouseDrag.Parent = nil
							ResetButtonColor(ScrollThumbFrame)
							drag_con:disconnect(); drag_con = nil
							up_con:disconnect(); drag = nil
						end)
						MouseDrag.Parent = GetScreen(ScrollFrame)
					end)
				end

				function Class:Destroy()
					ScrollFrame:Destroy()
					MouseDrag:Destroy()
					for k in pairs(Class) do
						Class[k] = nil
					end
					setmetatable(Class,nil)
				end

				Update()

				return Class
			end
		end

		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------

		local MainFrame = Instance.new("Frame")
		MainFrame.Name = "MainFrame"
		MainFrame.Size = UDim2.new(1, -1 * ScrollBarWidth, 1, 0)
		MainFrame.Position = UDim2.new(0, 0, 0, 0)
		MainFrame.BackgroundTransparency = 1
		MainFrame.ClipsDescendants = true
		MainFrame.Parent = PropertiesFrame

		ContentFrame = Instance.new("Frame")
		ContentFrame.Name = "ContentFrame"
		ContentFrame.Size = UDim2.new(1, 0, 0, 0)
		ContentFrame.BackgroundTransparency = 1
		ContentFrame.Parent = MainFrame

		scrollBar = ScrollBar(false)
		scrollBar.PageIncrement = 1
		Create(scrollBar.GUI,{
			Position = UDim2.new(1,-ScrollBarWidth,0,0);
			Size = UDim2.new(0,ScrollBarWidth,1,0);
			Parent = PropertiesFrame;
		})

		scrollBarH = ScrollBar(true)
		scrollBarH.PageIncrement = ScrollBarWidth
		Create(scrollBarH.GUI,{
			Position = UDim2.new(0,0,1,-ScrollBarWidth);
			Size = UDim2.new(1,-ScrollBarWidth,0,ScrollBarWidth);
			Visible = false;
			Parent = PropertiesFrame;
		})

		do
			local listEntries = {}
			local nameConnLookup = {}

			function scrollBar.UpdateCallback(self)
				scrollBar.TotalSpace = ContentFrame.AbsoluteSize.Y
				scrollBar.VisibleSpace = MainFrame.AbsoluteSize.Y
				ContentFrame.Position = UDim2.new(ContentFrame.Position.X.Scale,ContentFrame.Position.X.Offset,0,-1*scrollBar.ScrollIndex)
			end

			function scrollBarH.UpdateCallback(self)

			end

			MainFrame.Changed:connect(function(p)
				if p == 'AbsoluteSize' then
					scrollBarH.VisibleSpace = math.ceil(MainFrame.AbsoluteSize.x)
					scrollBarH:Update()
					scrollBar.VisibleSpace = math.ceil(MainFrame.AbsoluteSize.y)
					scrollBar:Update()
				end
			end)

			local wheelAmount = Row.Height
			PropertiesFrame.MouseWheelForward:connect(function()
				if scrollBar.VisibleSpace - 1 > wheelAmount then
					scrollBar:ScrollTo(scrollBar.ScrollIndex - wheelAmount)
				else
					scrollBar:ScrollTo(scrollBar.ScrollIndex - scrollBar.VisibleSpace)
				end
			end)
			PropertiesFrame.MouseWheelBackward:connect(function()
				if scrollBar.VisibleSpace - 1 > wheelAmount then
					scrollBar:ScrollTo(scrollBar.ScrollIndex + wheelAmount)
				else
					scrollBar:ScrollTo(scrollBar.ScrollIndex + scrollBar.VisibleSpace)
				end
			end)
		end

		scrollBar.VisibleSpace = math.ceil(MainFrame.AbsoluteSize.y)
		scrollBar:Update()

		showProperties(GetSelection())

		bindSelectionChanged.Event:connect(function()
			showProperties(GetSelection())
		end)

		bindSetAwait.Event:connect(function(obj)
			if AwaitingObjectValue then
				AwaitingObjectValue = false
				local mySel = obj
				if mySel then
					pcall(function()
						Set(AwaitingObjectObj, AwaitingObjectProp, mySel)
					end)
				end
			end
		end)

		propertiesSearch.Changed:connect(function(prop)
			if prop == "Text" then
				showProperties(GetSelection())
			end
		end)

		bindGetApi.OnInvoke = function()
			return RbxApi
		end

		bindGetAwait.OnInvoke = function()
			return AwaitingObjectValue
		end
	end)
	spawn(function()
		local top = D_E_X.ScriptEditor

		local editorGrid = top:WaitForChild("EditorGrid")

		local currentSource = ""

		local currentEditor = {
			x = 0,
			y = 0
		}

		local userInput = game:GetService("UserInputService")
		local mouse = game.Players.LocalPlayer:GetMouse()

		local topBar = top:WaitForChild("TopBar")
		local scriptBar = topBar:WaitForChild("ScriptBar")
		local scriptBarLeft = topBar:WaitForChild("ScriptBarLeft")
		local scriptBarRight = topBar:WaitForChild("ScriptBarRight")
		local clipboardButton = topBar:WaitForChild("Clipboard")

		local entryTemplate = topBar:WaitForChild("Entry")

		local openEvent = top:WaitForChild("OpenScript")

		local closeButton = top:WaitForChild("Close")

		local memoryScripts = {}

		local editingIndex = 0

		-- Scrollbar

		local ScrollBarWidth = 16

		local ScrollStyles = {
			Background      = Color3.new(233/255, 233/255, 233/255);
			Border          = Color3.new(149/255, 149/255, 149/255);
			Selected        = Color3.new( 63/255, 119/255, 189/255);
			BorderSelected  = Color3.new( 55/255, 106/255, 167/255);
			Text            = Color3.new(  0/255,   0/255,   0/255);
			TextDisabled    = Color3.new(128/255, 128/255, 128/255);
			TextSelected    = Color3.new(255/255, 255/255, 255/255);
			Button          = Color3.new(221/255, 221/255, 221/255);
			ButtonBorder    = Color3.new(149/255, 149/255, 149/255);
			ButtonSelected  = Color3.new(255/255,   0/255,   0/255);
			Field           = Color3.new(255/255, 255/255, 255/255);
			FieldBorder     = Color3.new(191/255, 191/255, 191/255);
			TitleBackground = Color3.new(178/255, 178/255, 178/255);
		}
		do
			local ZIndexLock = {}
			function SetZIndex(object,z)
				if not ZIndexLock[object] then
					ZIndexLock[object] = true
					if object:IsA'GuiObject' then
						object.ZIndex = z
					end
					local children = object:GetChildren()
					for i = 1,#children do
						SetZIndex(children[i],z)
					end
					ZIndexLock[object] = nil
				end
			end
		end
		function SetZIndexOnChanged(object)
			return object.Changed:connect(function(p)
				if p == "ZIndex" then
					SetZIndex(object,object.ZIndex)
				end
			end)
		end
		function Create(ty,data)
			local obj
			if type(ty) == 'string' then
				obj = Instance.new(ty)
			else
				obj = ty
			end
			for k, v in pairs(data) do
				if type(k) == 'number' then
					v.Parent = obj
				else
					obj[k] = v
				end
			end
			return obj
		end
		-- returns the ascendant ScreenGui of an object
		function GetScreen(screen)
			if screen == nil then return nil end
			while not screen:IsA("ScreenGui") do
				screen = screen.Parent
				if screen == nil then return nil end
			end
			return screen
		end
		-- AutoButtonColor doesn't always reset properly
		function ResetButtonColor(button)
			local active = button.Active
			button.Active = not active
			button.Active = active
		end

		function ArrowGraphic(size,dir,scaled,template)
			local Frame = Create('Frame',{
				Name = "Arrow Graphic";
				BorderSizePixel = 0;
				Size = UDim2.new(0,size,0,size);
				Transparency = 1;
			})
			if not template then
				template = Instance.new("Frame")
				template.BorderSizePixel = 0
			end

			local transform
			if dir == nil or dir == 'Up' then
				function transform(p,s) return p,s end
			elseif dir == 'Down' then
				function transform(p,s) return UDim2.new(0,p.X.Offset,0,size-p.Y.Offset-1),s end
			elseif dir == 'Left' then
				function transform(p,s) return UDim2.new(0,p.Y.Offset,0,p.X.Offset),UDim2.new(0,s.Y.Offset,0,s.X.Offset) end
			elseif dir == 'Right' then
				function transform(p,s) return UDim2.new(0,size-p.Y.Offset-1,0,p.X.Offset),UDim2.new(0,s.Y.Offset,0,s.X.Offset) end
			end

			local scale
			if scaled then
				function scale(p,s) return UDim2.new(p.X.Offset/size,0,p.Y.Offset/size,0),UDim2.new(s.X.Offset/size,0,s.Y.Offset/size,0) end
			else
				function scale(p,s) return p,s end
			end

			local o = math.floor(size/4)
			if size%2 == 0 then
				local n = size/2-1
				for i = 0,n do
					local t = template:Clone()
					local p,s = scale(transform(
						UDim2.new(0,n-i,0,o+i),
						UDim2.new(0,(i+1)*2,0,1)
						))
					t.Position = p
					t.Size = s
					t.Parent = Frame
				end
			else
				local n = (size-1)/2
				for i = 0,n do
					local t = template:Clone()
					local p,s = scale(transform(
						UDim2.new(0,n-i,0,o+i),
						UDim2.new(0,i*2+1,0,1)
						))
					t.Position = p
					t.Size = s
					t.Parent = Frame
				end
			end
			if size%4 > 1 then
				local t = template:Clone()
				local p,s = scale(transform(
					UDim2.new(0,0,0,size-o-1),
					UDim2.new(0,size,0,1)
					))
				t.Position = p
				t.Size = s
				t.Parent = Frame
			end
			return Frame
		end

		function GripGraphic(size,dir,spacing,scaled,template)
			local Frame = Create('Frame',{
				Name = "Grip Graphic";
				BorderSizePixel = 0;
				Size = UDim2.new(0,size.x,0,size.y);
				Transparency = 1;
			})
			if not template then
				template = Instance.new("Frame")
				template.BorderSizePixel = 0
			end

			spacing = spacing or 2

			local scale
			if scaled then
				function scale(p) return UDim2.new(p.X.Offset/size.x,0,p.Y.Offset/size.y,0) end
			else
				function scale(p) return p end
			end

			if dir == 'Vertical' then
				for i=0,size.x-1,spacing do
					local t = template:Clone()
					t.Size = scale(UDim2.new(0,1,0,size.y))
					t.Position = scale(UDim2.new(0,i,0,0))
					t.Parent = Frame
				end
			elseif dir == nil or dir == 'Horizontal' then
				for i=0,size.y-1,spacing do
					local t = template:Clone()
					t.Size = scale(UDim2.new(0,size.x,0,1))
					t.Position = scale(UDim2.new(0,0,0,i))
					t.Parent = Frame
				end
			end

			return Frame
		end

		do
			local mt = {
				__index = {
					GetScrollPercent = function(self)
						return self.ScrollIndex/(self.TotalSpace-self.VisibleSpace)
					end;
					CanScrollDown = function(self)
						return self.ScrollIndex + self.VisibleSpace < self.TotalSpace
					end;
					CanScrollUp = function(self)
						return self.ScrollIndex > 0
					end;
					ScrollDown = function(self)
						self.ScrollIndex = self.ScrollIndex + self.PageIncrement
						self:Update()
					end;
					ScrollUp = function(self)
						self.ScrollIndex = self.ScrollIndex - self.PageIncrement
						self:Update()
					end;
					ScrollTo = function(self,index)
						self.ScrollIndex = index
						self:Update()
					end;
					SetScrollPercent = function(self,percent)
						self.ScrollIndex = math.floor((self.TotalSpace - self.VisibleSpace)*percent + 0.5)
						self:Update()
					end;
				};
			}
			mt.__index.CanScrollRight = mt.__index.CanScrollDown
			mt.__index.CanScrollLeft = mt.__index.CanScrollUp
			mt.__index.ScrollLeft = mt.__index.ScrollUp
			mt.__index.ScrollRight = mt.__index.ScrollDown

			function ScrollBar(horizontal)
				-- create row scroll bar
				local ScrollFrame = Create('Frame',{
					Name = "ScrollFrame";
					Position = horizontal and UDim2.new(0,0,1,-ScrollBarWidth) or UDim2.new(1,-ScrollBarWidth,0,0);
					Size = horizontal and UDim2.new(1,0,0,ScrollBarWidth) or UDim2.new(0,ScrollBarWidth,1,0);
					BackgroundTransparency = 1;
					Create('ImageButton',{
						Name = "ScrollDown";
						Position = horizontal and UDim2.new(1,-ScrollBarWidth,0,0) or UDim2.new(0,0,1,-ScrollBarWidth);
						Size = UDim2.new(0, ScrollBarWidth, 0, ScrollBarWidth);
						BackgroundColor3 = ScrollStyles.Button;
						BorderColor3 = ScrollStyles.Border;
						--BorderSizePixel = 0;
					});
					Create('ImageButton',{
						Name = "ScrollUp";
						Size = UDim2.new(0, ScrollBarWidth, 0, ScrollBarWidth);
						BackgroundColor3 = ScrollStyles.Button;
						BorderColor3 = ScrollStyles.Border;
						--BorderSizePixel = 0;
					});
					Create('ImageButton',{
						Name = "ScrollBar";
						Size = horizontal and UDim2.new(1,-ScrollBarWidth*2,1,0) or UDim2.new(1,0,1,-ScrollBarWidth*2);
						Position = horizontal and UDim2.new(0,ScrollBarWidth,0,0) or UDim2.new(0,0,0,ScrollBarWidth);
						AutoButtonColor = false;
						BackgroundColor3 = Color3.new(0.94902, 0.94902, 0.94902);
						BorderColor3 = ScrollStyles.Border;
						--BorderSizePixel = 0;
						Create('ImageButton',{
							Name = "ScrollThumb";
							AutoButtonColor = false;
							Size = UDim2.new(0, ScrollBarWidth, 0, ScrollBarWidth);
							BackgroundColor3 = ScrollStyles.Button;
							BorderColor3 = ScrollStyles.Border;
							--BorderSizePixel = 0;
						});
					});
				})

				local graphicTemplate = Create('Frame',{
					Name="Graphic";
					BorderSizePixel = 0;
					BackgroundColor3 = ScrollStyles.Border;
				})
				local graphicSize = ScrollBarWidth/2

				local ScrollDownFrame = ScrollFrame.ScrollDown
				local ScrollDownGraphic = ArrowGraphic(graphicSize,horizontal and 'Right' or 'Down',true,graphicTemplate)
				ScrollDownGraphic.Position = UDim2.new(0.5,-graphicSize/2,0.5,-graphicSize/2)
				ScrollDownGraphic.Parent = ScrollDownFrame
				local ScrollUpFrame = ScrollFrame.ScrollUp
				local ScrollUpGraphic = ArrowGraphic(graphicSize,horizontal and 'Left' or 'Up',true,graphicTemplate)
				ScrollUpGraphic.Position = UDim2.new(0.5,-graphicSize/2,0.5,-graphicSize/2)
				ScrollUpGraphic.Parent = ScrollUpFrame
				local ScrollBarFrame = ScrollFrame.ScrollBar
				local ScrollThumbFrame = ScrollBarFrame.ScrollThumb
				do
					local size = ScrollBarWidth*3/8
					local Decal = GripGraphic(Vector2.new(size,size),horizontal and 'Vertical' or 'Horizontal',2,graphicTemplate)
					Decal.Position = UDim2.new(0.5,-size/2,0.5,-size/2)
					Decal.Parent = ScrollThumbFrame
				end

				local MouseDrag = Create('ImageButton',{
					Name = "MouseDrag";
					Position = UDim2.new(-0.25,0,-0.25,0);
					Size = UDim2.new(1.5,0,1.5,0);
					Transparency = 1;
					AutoButtonColor = false;
					Active = true;
					ZIndex = 10;
				})

				local Class = setmetatable({
					GUI = ScrollFrame;
					ScrollIndex = 0;
					VisibleSpace = 0;
					TotalSpace = 0;
					PageIncrement = 1;
				},mt)

				local UpdateScrollThumb
				if horizontal then
					function UpdateScrollThumb()
						ScrollThumbFrame.Size = UDim2.new(Class.VisibleSpace/Class.TotalSpace,0,0,ScrollBarWidth)
						if ScrollThumbFrame.AbsoluteSize.x < ScrollBarWidth then
							ScrollThumbFrame.Size = UDim2.new(0,ScrollBarWidth,0,ScrollBarWidth)
						end
						local barSize = ScrollBarFrame.AbsoluteSize.x
						ScrollThumbFrame.Position = UDim2.new(Class:GetScrollPercent()*(barSize - ScrollThumbFrame.AbsoluteSize.x)/barSize,0,0,0)
					end
				else
					function UpdateScrollThumb()
						ScrollThumbFrame.Size = UDim2.new(0,ScrollBarWidth,Class.VisibleSpace/Class.TotalSpace,0)
						if ScrollThumbFrame.AbsoluteSize.y < ScrollBarWidth then
							ScrollThumbFrame.Size = UDim2.new(0,ScrollBarWidth,0,ScrollBarWidth)
						end
						local barSize = ScrollBarFrame.AbsoluteSize.y
						ScrollThumbFrame.Position = UDim2.new(0,0,Class:GetScrollPercent()*(barSize - ScrollThumbFrame.AbsoluteSize.y)/barSize,0)
					end
				end

				local lastDown
				local lastUp
				local scrollStyle = {BackgroundColor3=ScrollStyles.Border,BackgroundTransparency=0}
				local scrollStyle_ds = {BackgroundColor3=ScrollStyles.Border,BackgroundTransparency=0.7}

				local function Update()
					local t = Class.TotalSpace
					local v = Class.VisibleSpace
					local s = Class.ScrollIndex
					if v <= t then
						if s > 0 then
							if s + v > t then
								Class.ScrollIndex = t - v
							end
						else
							Class.ScrollIndex = 0
						end
					else
						Class.ScrollIndex = 0
					end

					if Class.UpdateCallback then
						if Class.UpdateCallback(Class) == false then
							return
						end
					end

					local down = Class:CanScrollDown()
					local up = Class:CanScrollUp()
					if down ~= lastDown then
						lastDown = down
						ScrollDownFrame.Active = down
						ScrollDownFrame.AutoButtonColor = down
						local children = ScrollDownGraphic:GetChildren()
						local style = down and scrollStyle or scrollStyle_ds
						for i = 1,#children do
							Create(children[i],style)
						end
					end
					if up ~= lastUp then
						lastUp = up
						ScrollUpFrame.Active = up
						ScrollUpFrame.AutoButtonColor = up
						local children = ScrollUpGraphic:GetChildren()
						local style = up and scrollStyle or scrollStyle_ds
						for i = 1,#children do
							Create(children[i],style)
						end
					end
					ScrollThumbFrame.Visible = down or up
					UpdateScrollThumb()
				end
				Class.Update = Update

				SetZIndexOnChanged(ScrollFrame)

				local scrollEventID = 0
				ScrollDownFrame.MouseButton1Down:connect(function()
					scrollEventID = tick()
					local current = scrollEventID
					local up_con
					up_con = MouseDrag.MouseButton1Up:connect(function()
						scrollEventID = tick()
						MouseDrag.Parent = nil
						ResetButtonColor(ScrollDownFrame)
						up_con:disconnect(); drag = nil
					end)
					MouseDrag.Parent = GetScreen(ScrollFrame)
					Class:ScrollDown()
					wait(0.2) -- delay before auto scroll
					while scrollEventID == current do
						Class:ScrollDown()
						if not Class:CanScrollDown() then break end
						wait()
					end
				end)

				ScrollDownFrame.MouseButton1Up:connect(function()
					scrollEventID = tick()
				end)

				ScrollUpFrame.MouseButton1Down:connect(function()
					scrollEventID = tick()
					local current = scrollEventID
					local up_con
					up_con = MouseDrag.MouseButton1Up:connect(function()
						scrollEventID = tick()
						MouseDrag.Parent = nil
						ResetButtonColor(ScrollUpFrame)
						up_con:disconnect(); drag = nil
					end)
					MouseDrag.Parent = GetScreen(ScrollFrame)
					Class:ScrollUp()
					wait(0.2)
					while scrollEventID == current do
						Class:ScrollUp()
						if not Class:CanScrollUp() then break end
						wait()
					end
				end)

				ScrollUpFrame.MouseButton1Up:connect(function()
					scrollEventID = tick()
				end)

				if horizontal then
					ScrollBarFrame.MouseButton1Down:connect(function(x,y)
						scrollEventID = tick()
						local current = scrollEventID
						local up_con
						up_con = MouseDrag.MouseButton1Up:connect(function()
							scrollEventID = tick()
							MouseDrag.Parent = nil
							ResetButtonColor(ScrollUpFrame)
							up_con:disconnect(); drag = nil
						end)
						MouseDrag.Parent = GetScreen(ScrollFrame)
						if x > ScrollThumbFrame.AbsolutePosition.x then
							Class:ScrollTo(Class.ScrollIndex + Class.VisibleSpace)
							wait(0.2)
							while scrollEventID == current do
								if x < ScrollThumbFrame.AbsolutePosition.x + ScrollThumbFrame.AbsoluteSize.x then break end
								Class:ScrollTo(Class.ScrollIndex + Class.VisibleSpace)
								wait()
							end
						else
							Class:ScrollTo(Class.ScrollIndex - Class.VisibleSpace)
							wait(0.2)
							while scrollEventID == current do
								if x > ScrollThumbFrame.AbsolutePosition.x then break end
								Class:ScrollTo(Class.ScrollIndex - Class.VisibleSpace)
								wait()
							end
						end
					end)
				else
					ScrollBarFrame.MouseButton1Down:connect(function(x,y)
						scrollEventID = tick()
						local current = scrollEventID
						local up_con
						up_con = MouseDrag.MouseButton1Up:connect(function()
							scrollEventID = tick()
							MouseDrag.Parent = nil
							ResetButtonColor(ScrollUpFrame)
							up_con:disconnect(); drag = nil
						end)
						MouseDrag.Parent = GetScreen(ScrollFrame)
						if y > ScrollThumbFrame.AbsolutePosition.y then
							Class:ScrollTo(Class.ScrollIndex + Class.VisibleSpace)
							wait(0.2)
							while scrollEventID == current do
								if y < ScrollThumbFrame.AbsolutePosition.y + ScrollThumbFrame.AbsoluteSize.y then break end
								Class:ScrollTo(Class.ScrollIndex + Class.VisibleSpace)
								wait()
							end
						else
							Class:ScrollTo(Class.ScrollIndex - Class.VisibleSpace)
							wait(0.2)
							while scrollEventID == current do
								if y > ScrollThumbFrame.AbsolutePosition.y then break end
								Class:ScrollTo(Class.ScrollIndex - Class.VisibleSpace)
								wait()
							end
						end
					end)
				end

				if horizontal then
					ScrollThumbFrame.MouseButton1Down:connect(function(x,y)
						scrollEventID = tick()
						local mouse_offset = x - ScrollThumbFrame.AbsolutePosition.x
						local drag_con
						local up_con
						drag_con = MouseDrag.MouseMoved:connect(function(x,y)
							local bar_abs_pos = ScrollBarFrame.AbsolutePosition.x
							local bar_drag = ScrollBarFrame.AbsoluteSize.x - ScrollThumbFrame.AbsoluteSize.x
							local bar_abs_one = bar_abs_pos + bar_drag
							x = x - mouse_offset
							x = x < bar_abs_pos and bar_abs_pos or x > bar_abs_one and bar_abs_one or x
							x = x - bar_abs_pos
							Class:SetScrollPercent(x/(bar_drag))
						end)
						up_con = MouseDrag.MouseButton1Up:connect(function()
							scrollEventID = tick()
							MouseDrag.Parent = nil
							ResetButtonColor(ScrollThumbFrame)
							drag_con:disconnect(); drag_con = nil
							up_con:disconnect(); drag = nil
						end)
						MouseDrag.Parent = GetScreen(ScrollFrame)
					end)
				else
					ScrollThumbFrame.MouseButton1Down:connect(function(x,y)
						scrollEventID = tick()
						local mouse_offset = y - ScrollThumbFrame.AbsolutePosition.y
						local drag_con
						local up_con
						drag_con = MouseDrag.MouseMoved:connect(function(x,y)
							local bar_abs_pos = ScrollBarFrame.AbsolutePosition.y
							local bar_drag = ScrollBarFrame.AbsoluteSize.y - ScrollThumbFrame.AbsoluteSize.y
							local bar_abs_one = bar_abs_pos + bar_drag
							y = y - mouse_offset
							y = y < bar_abs_pos and bar_abs_pos or y > bar_abs_one and bar_abs_one or y
							y = y - bar_abs_pos
							Class:SetScrollPercent(y/(bar_drag))
						end)
						up_con = MouseDrag.MouseButton1Up:connect(function()
							scrollEventID = tick()
							MouseDrag.Parent = nil
							ResetButtonColor(ScrollThumbFrame)
							drag_con:disconnect(); drag_con = nil
							up_con:disconnect(); drag = nil
						end)
						MouseDrag.Parent = GetScreen(ScrollFrame)
					end)
				end

				function Class:Destroy()
					ScrollFrame:Destroy()
					MouseDrag:Destroy()
					for k in pairs(Class) do
						Class[k] = nil
					end
					setmetatable(Class,nil)
				end

				Update()

				return Class
			end
		end

		-- End Scrollbar

		local scrollBar = ScrollBar(false)
		scrollBar.PageIncrement = 16
		Create(scrollBar.GUI,{
			Position = UDim2.new(1,0,0,0);
			Size = UDim2.new(0,ScrollBarWidth,1,0);
			Parent = editorGrid;
		})

		local scrollBarH = ScrollBar(true)
		scrollBarH.PageIncrement = 8
		Create(scrollBarH.GUI,{
			Position = UDim2.new(0,0,1,0);
			Size = UDim2.new(1,0,0,ScrollBarWidth);
			Parent = editorGrid;
		})

		local entries = {}

		local grid = {}

		local count = 1
		local xCount = 1

		local lineSpan = 0

		for i = 0,490,8 do
			local newRow = {}
			for j = 0,390,16 do
				local cellText = Instance.new("TextLabel",editorGrid)
				cellText.BackgroundTransparency = 1
				cellText.BorderSizePixel = 0
				cellText.Text = ""
				cellText.Position = UDim2.new(0,i,0,j)
				cellText.Size = UDim2.new(0,8,0,16)
				cellText.Font = Enum.Font.SourceSans
				cellText.FontSize = Enum.FontSize.Size18
				table.insert(newRow,cellText)
				xCount = xCount + 1
			end
			table.insert(grid,newRow)
			count = count + 1
			xCount = 1
		end

		local syntaxHighlightList = {
			{["Keyword"] = "for", ["Color"] = Color3.new(0, 0, 127/255), ["Independent"] = true},
			{["Keyword"] = "local", ["Color"] = Color3.new(0, 0, 127/255), ["Independent"] = true},
			{["Keyword"] = "if", ["Color"] = Color3.new(0, 0, 127/255), ["Independent"] = true},
			{["Keyword"] = "then", ["Color"] = Color3.new(0, 0, 127/255), ["Independent"] = true},
			{["Keyword"] = "do", ["Color"] = Color3.new(0, 0, 127/255), ["Independent"] = true},
			{["Keyword"] = "while", ["Color"] = Color3.new(0, 0, 127/255), ["Independent"] = true},
			{["Keyword"] = "end", ["Color"] = Color3.new(0, 0, 127/255), ["Independent"] = true},
			{["Keyword"] = "function", ["Color"] = Color3.new(0, 0, 127/255), ["Independent"] = true},
			{["Keyword"] = "string", ["Color"] = Color3.new(0, 0, 127/255), ["Independent"] = true},
			{["Keyword"] = "table", ["Color"] = Color3.new(0, 0, 127/255), ["Independent"] = true},
			{["Keyword"] = "game", ["Color"] = Color3.new(0, 0, 127/255), ["Independent"] = true},
			{["Keyword"] = "workspace", ["Color"] = Color3.new(0, 0, 127/255), ["Independent"] = true},
			{["Keyword"] = "return", ["Color"] = Color3.new(0, 0, 127/255), ["Independent"] = true},
			{["Keyword"] = "break", ["Color"] = Color3.new(0, 0, 127/255), ["Independent"] = true},
			{["Keyword"] = "elseif", ["Color"] = Color3.new(0, 0, 127/255), ["Independent"] = true},
			{["Keyword"] = "in", ["Color"] = Color3.new(0, 0, 127/255), ["Independent"] = true},
			{["Keyword"] = "pairs", ["Color"] = Color3.new(0, 0, 127/255), ["Independent"] = true},
			{["Keyword"] = "ipairs", ["Color"] = Color3.new(0, 0, 127/255), ["Independent"] = true}
		}

		function checkMouseInGui(gui)
			if gui == nil then return false end
			local plrMouse = game.Players.LocalPlayer:GetMouse()
			local guiPosition = gui.AbsolutePosition
			local guiSize = gui.AbsoluteSize	

			if plrMouse.X >= guiPosition.x and plrMouse.X <= guiPosition.x + guiSize.x and plrMouse.Y >= guiPosition.y and plrMouse.Y <= guiPosition.y + guiSize.y then
				return true
			else
				return false
			end
		end

		function AddZeros(num,reach)
			local toConvert = tostring(num)
			while #toConvert < reach do
				toConvert = " "..toConvert
			end
			return toConvert
		end

		function buildScript(source,xOff,yOff,override)
			local buildingRows = true
			local buildScr = source

			local totalLines = 0

			--print(xOff,yOff)

			if currentSource ~= source then
				currentSource = source
			end

			if override then
				currentSource = source
				entries = {}
				while buildingRows do
					local x,y = string.find(buildScr,"\n")
					if x and y then
						table.insert(entries,string.sub(buildScr,1,y))
						buildScr = string.sub(buildScr,y+1,string.len(buildScr))
					else
						buildingRows = false
						table.insert(entries,buildScr)
					end
				end
			end

			totalLines = #entries
			lineSpan = #tostring(totalLines)

			if lineSpan == 1 then lineSpan = 2 end

			local currentRow = 1
			local currentColumn = 2 + lineSpan

			local colorTime = 0
			local colorReplace = nil

			local inString = false

			local workingEntries = entries

	--[[
	for i,v in pairs(entries) do
		table.insert(workingEntries,v)
	end
	
	for i = 1,yOff do
		table.remove(workingEntries,1)
	end
	--]]

			local delayance = xOff

			for i = 1,#grid do
				for j = 1,#grid[i] do
					if i <= lineSpan then
						local newNum = AddZeros(yOff + j,lineSpan)
						local newDigit =  string.sub(newNum,i,i)
						if newDigit == " " then
							grid[i][j].Text = ""
						else
							grid[i][j].Text = newDigit
						end
						grid[i][j].BackgroundTransparency = 0
						grid[i][j].BackgroundColor3 = Color3.new(163/255, 162/255, 165/255)
						--grid[i][j].Font = Enum.Font.SourceSansBold
					elseif i == lineSpan + 1 then
						grid[i][j].Text = ""
						grid[i][j].BackgroundTransparency = 0
						grid[i][j].BackgroundColor3 = Color3.new(200/255, 200/255, 200/255)
						--grid[i][j].Font = Enum.Font.SourceSans
					else
						grid[i][j].Text = ""
						grid[i][j].BackgroundTransparency = 1
						--grid[i][j].Font = Enum.Font.SourceSans
					end
				end
			end

			while true do
				if currentRow > #workingEntries or currentRow > #grid[1] then break end
				local entry = workingEntries[currentRow+yOff]
				while string.len(entry) > 0 do
					if string.sub(entry,1,1) == "\t" then entry = "    "..string.sub(entry,2) end

					if currentColumn > #grid then break end

					if delayance == 0 then
						grid[currentColumn][currentRow].Text = string.sub(entry,1,1)
					end

					-- Coloring

					if not inString then
						for i,v in pairs(syntaxHighlightList) do
							if string.sub(entry,1,string.len(v["Keyword"])) == v["Keyword"] then
								if v["Independent"] then
									local outCheck = string.len(v["Keyword"])+1
									local outEntry = string.sub(entry,outCheck,outCheck)
									if not string.find(outEntry,"%w") then
										colorTime = string.len(v["Keyword"])
										colorReplace = v["Color"]
									end
								else
									colorTime = string.len(v["Keyword"])
									colorReplace = v["Color"]
								end
							end
						end
					end

					if string.sub(entry,1,1) == "\"" and string.match(entry,"\".+\"") then
						inString = true
						colorTime = string.len(string.match(entry,"\".+\""))
						colorReplace = Color3.new(170/255, 0, 1)
					end

					if colorTime > 0 then
						colorTime = colorTime - 1
						grid[currentColumn][currentRow].TextColor3 = colorReplace
						if colorTime == 0 then inString = false end
					else
						grid[currentColumn][currentRow].TextColor3 = Color3.new(0,0,0)
						inString = false
					end

					if delayance == 0 then
						currentColumn = currentColumn + 1
					else
						delayance = delayance - 1
					end
					entry = string.sub(entry,2,string.len(entry))
				end
				currentRow = currentRow + 1
				currentColumn = 2 + lineSpan
				colorTime = 0
				delayance = xOff
				inString = false
			end
		end

		function scrollBar.UpdateCallback(self)
			scrollBar.TotalSpace = #entries * 16
			scrollBar.VisibleSpace = editorGrid.AbsoluteSize.Y
			buildScript(currentSource,math.floor(scrollBarH.ScrollIndex/8),math.floor(scrollBar.ScrollIndex/16))
		end

		function scrollBarH.UpdateCallback(self)
			scrollBarH.TotalSpace = (getLongestEntry(entries) + 1 + lineSpan) * 8
			scrollBarH.VisibleSpace = editorGrid.AbsoluteSize.X
			buildScript(currentSource,math.floor(scrollBarH.ScrollIndex/8),math.floor(scrollBar.ScrollIndex/16))
		end

		function getLongestEntry(tab)
			local longest = 0
			for i,v in pairs(tab) do
				if string.len(v) > longest then
					longest = string.len(v)
				end
			end
			return longest
		end

		function openScript(scrObj)
			if scrObj:IsA("LocalScript") then
				scrObj.Archivable = true
				scrObj = scrObj:Clone()
				scrObj.Disabled = true
			end

			local scrName = scrObj.Name
			local scrSource = decompile(scrObj)

			table.insert(memoryScripts,{Name = scrName,Source = scrSource})

			local newTab = entryTemplate:Clone()
			newTab.Button.Text = scrName
			newTab.Position = UDim2.new(0,#scriptBar:GetChildren() * 100,0,0)
			newTab.Visible = true

			newTab.Button.MouseButton1Down:connect(function()
				for i,v in pairs(scriptBar:GetChildren()) do
					if v == newTab then
						editingIndex = i
						buildScript(memoryScripts[i].Source,0,0,true)
						scrollBar:ScrollTo(1)
						scrollBar:Update()
						scrollBarH:ScrollTo(1)
						scrollBarH:Update()
					end
				end
			end)

			newTab.Close.MouseButton1Click:connect(function()
				for i,v in pairs(scriptBar:GetChildren()) do
					if v == newTab then
						table.remove(memoryScripts,i)
						if editingIndex == i then
							editingIndex = #memoryScripts
							if editingIndex > 0 then
								buildScript(memoryScripts[#memoryScripts].Source,0,0,true)
							else
								buildScript("",0,0,true)
							end
						end

						scrollBar:ScrollTo(1)
						scrollBar:Update()
						scrollBarH:ScrollTo(1)
						scrollBarH:Update()

						for i2 = i,#scriptBar:GetChildren() do
							scriptBar:GetChildren()[i2].Position = scriptBar:GetChildren()[i2].Position + UDim2.new(0,-100,0,0)
						end
						if editingIndex > i then
							editingIndex = editingIndex - 1
						end
						newTab:Destroy()
					end
				end
			end)

			editingIndex = #memoryScripts
			buildScript(scrSource,0,0,true)

			newTab.Parent = scriptBar
		end

		function updateScriptBar()
			local entryCount = 0

			scriptBarLeft.Active = false
			scriptBarLeft.AutoButtonColor = false
			for i,v in pairs(scriptBarLeft["Arrow Graphic"]:GetChildren()) do
				v.BackgroundTransparency = 0.7
			end
			scriptBarRight.Active = false
			scriptBarRight.AutoButtonColor = false
			for i,v in pairs(scriptBarRight["Arrow Graphic"]:GetChildren()) do
				v.BackgroundTransparency = 0.7
			end
			for i,v in pairs(scriptBar:GetChildren()) do
				if v.Position.X.Offset < 0 then
					scriptBarLeft.Active = true
					scriptBarLeft.AutoButtonColor = true
					for i,v in pairs(scriptBarLeft["Arrow Graphic"]:GetChildren()) do
						v.BackgroundTransparency = 0
					end
				elseif v.Position.X.Offset >= 0 then
					entryCount = entryCount + 1
					if entryCount == 5 then
						scriptBarRight.Active = true
						scriptBarRight.AutoButtonColor = true
						for i,v in pairs(scriptBarRight["Arrow Graphic"]:GetChildren()) do
							v.BackgroundTransparency = 0
						end
					end
				end
			end
		end

		scriptBar.ChildAdded:connect(updateScriptBar)
		scriptBar.ChildRemoved:connect(updateScriptBar)

		scriptBarLeft.MouseButton1Click:connect(function()
			if scriptBarLeft.Active == false then return end
			for i,v in pairs(scriptBar:GetChildren()) do
				v.Position = v.Position + UDim2.new(0,100,0,0)
			end
			updateScriptBar()
		end)

		scriptBarRight.MouseButton1Click:connect(function()
			if scriptBarRight.Active == false then return end
			for i,v in pairs(scriptBar:GetChildren()) do
				v.Position = v.Position + UDim2.new(0,-100,0,0)
			end
			updateScriptBar()
		end)

		mouse.Button1Down:connect(function()
			if checkMouseInGui(editorGrid) then
				--print("LETS EDIT!")
			end
		end)

		openEvent.Event:connect(function(...)
			top.Visible = true
			local args = {...}
			if #args > 0 then
				openScript(args[1])
			end
		end)

		clipboardButton.MouseButton1Click:connect(function()
			if Clipboard and Clipboard.set then
				Clipboard.set(currentSource)
			elseif CopyString then
				CopyString(currentSource)
			end
		end)

		closeButton.MouseButton1Click:connect(function()
			top.Visible = false
		end)

--[[
local scr = script.Parent:WaitForChild("Scr")
local scr2 = script.Parent:WaitForChild("Scr2")
local scr3 = script.Parent:WaitForChild("Scr3")
local scr4 = script.Parent:WaitForChild("TOS")
local scr5 = script.Parent:WaitForChild("HW")
--]]

		buildScript("",0,0,true)
--[[
openScript(scr)
openScript(scr2)
openScript(scr3)
openScript(scr4)
openScript(scr5)
--]]

		scrollBar:Update()
		scrollBarH:Update()
	end)

	--moony
end)

slock.Name = "slock"
slock.Parent = ScrollingFrame
slock.BackgroundColor3 = Color3.fromRGB(172, 172, 172)
slock.BackgroundTransparency = 0.500
slock.BorderSizePixel = 0
slock.Position = UDim2.new(0.079136692, 0, -0.00990098994, 0)
slock.Size = UDim2.new(0, 131, 0, 40)
slock.Font = Enum.Font.SourceSansLight
slock.Text = "Slock"
slock.TextColor3 = Color3.fromRGB(255, 255, 255)
slock.TextSize = 23.000
slock.MouseButton1Click:connect(function()
	if slockk then 
		queue.Text = "Skidded by FindingStuff   SLOCK: false"
		slockk = false
	else
		queue.Text = "Skidded by FindingStuff   SLOCK: true"
		slockk = true
	end
end)

UIGridLayout.Parent = ScrollingFrame
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout.CellPadding = UDim2.new(0, 15, 0, 15)
UIGridLayout.CellSize = UDim2.new(0, 131, 0, 40)

kick.Name = "kick"
kick.Parent = ScrollingFrame
kick.BackgroundColor3 = Color3.fromRGB(172, 172, 172)
kick.BackgroundTransparency = 0.500
kick.BorderSizePixel = 0
kick.Position = UDim2.new(0.079136692, 0, -0.00990098994, 0)
kick.Size = UDim2.new(0, 131, 0, 40)
kick.Font = Enum.Font.SourceSansLight
kick.Text = "Kick"
kick.TextColor3 = Color3.fromRGB(255, 255, 255)
kick.TextSize = 23.000
kick.MouseButton1Click:connect(function()
	local players = getPlayer(target.Text, Players.LocalPlayer)
	for i, v in pairs(players) do
		Destroy(Players[v])
	end
end)

blockhead.Name = "blockhead"
blockhead.Parent = ScrollingFrame
blockhead.BackgroundColor3 = Color3.fromRGB(172, 172, 172)
blockhead.BackgroundTransparency = 0.500
blockhead.BorderSizePixel = 0
blockhead.Position = UDim2.new(0.079136692, 0, -0.00990098994, 0)
blockhead.Size = UDim2.new(0, 131, 0, 40)
blockhead.Font = Enum.Font.SourceSansLight
blockhead.Text = "Blockhead"
blockhead.TextColor3 = Color3.fromRGB(255, 255, 255)
blockhead.TextSize = 23.000
blockhead.MouseButton1Click:connect(function()
	local players = getPlayer(target.Text, Players.LocalPlayer)
	for i, v in pairs(players) do
		Destroy(Players[v].Character.Head:FindFirstChildOfClass("SpecialMesh"))
	end
end)

stools.Name = "stools"
stools.Parent = ScrollingFrame
stools.BackgroundColor3 = Color3.fromRGB(172, 172, 172)
stools.BackgroundTransparency = 0.500
stools.BorderSizePixel = 0
stools.Position = UDim2.new(0.079136692, 0, -0.00990098994, 0)
stools.Size = UDim2.new(0, 131, 0, 40)
stools.Font = Enum.Font.SourceSansLight
stools.Text = "Stools"
stools.TextColor3 = Color3.fromRGB(255, 255, 255)
stools.TextSize = 23.000
stools.MouseButton1Click:connect(function()
	local players = getPlayer(target.Text, Players.LocalPlayer)
	for i, v in pairs(players) do
		Destroy(Players[v].Character:FindFirstChildOfClass("Humanoid"))
		repeat wait() until Players[v].Character:FindFirstChildOfClass("Humanoid").Parent == nil
		for _, v in ipairs(Players[v].Character:GetChildren()) do
			if v:IsA("BackpackItem") and v:FindFirstChild("Handle") then
				Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):EquipTool(v)
			end
		end
	end
end)

noface.Name = "noface"
noface.Parent = ScrollingFrame
noface.BackgroundColor3 = Color3.fromRGB(172, 172, 172)
noface.BackgroundTransparency = 0.500
noface.BorderSizePixel = 0
noface.Position = UDim2.new(0.079136692, 0, -0.00990098994, 0)
noface.Size = UDim2.new(0, 131, 0, 40)
noface.Font = Enum.Font.SourceSansLight
noface.Text = "Noface"
noface.TextColor3 = Color3.fromRGB(255, 255, 255)
noface.TextSize = 23.000
noface.MouseButton1Click:connect(function()
	local players = getPlayer(target.Text, Players.LocalPlayer)
	for i, v in pairs(players) do
		Destroy(Players[v].Character.Head:FindFirstChildOfClass("Decal"))
	end
end)

punish.Name = "punish"
punish.Parent = ScrollingFrame
punish.BackgroundColor3 = Color3.fromRGB(172, 172, 172)
punish.BackgroundTransparency = 0.500
punish.BorderSizePixel = 0
punish.Position = UDim2.new(0.079136692, 0, -0.00990098994, 0)
punish.Size = UDim2.new(0, 131, 0, 40)
punish.Font = Enum.Font.SourceSansLight
punish.Text = "Punish"
punish.TextColor3 = Color3.fromRGB(255, 255, 255)
punish.TextSize = 23.000
punish.MouseButton1Click:connect(function()
	local players = getPlayer(target.Text, Players.LocalPlayer)
	for i, v in pairs(players) do
		Destroy(Players[v].Character)
	end
end)

pantsless.Name = "pantsless"
pantsless.Parent = ScrollingFrame
pantsless.BackgroundColor3 = Color3.fromRGB(172, 172, 172)
pantsless.BackgroundTransparency = 0.500
pantsless.BorderSizePixel = 0
pantsless.Position = UDim2.new(0.079136692, 0, -0.00990098994, 0)
pantsless.Size = UDim2.new(0, 131, 0, 40)
pantsless.Font = Enum.Font.SourceSansLight
pantsless.Text = "Pantsless"
pantsless.TextColor3 = Color3.fromRGB(255, 255, 255)
pantsless.TextSize = 23.000
pantsless.MouseButton1Click:connect(function()
	local players = getPlayer(target.Text, Players.LocalPlayer)
	for i, v in pairs(players) do
		Destroy(Players[v].Character:FindFirstChildOfClass("Pants"))
	end
end)

shirtless.Name = "shirtless"
shirtless.Parent = ScrollingFrame
shirtless.BackgroundColor3 = Color3.fromRGB(172, 172, 172)
shirtless.BackgroundTransparency = 0.500
shirtless.BorderSizePixel = 0
shirtless.Position = UDim2.new(0.079136692, 0, -0.00990098994, 0)
shirtless.Size = UDim2.new(0, 131, 0, 40)
shirtless.Font = Enum.Font.SourceSansLight
shirtless.Text = "Shirtless"
shirtless.TextColor3 = Color3.fromRGB(255, 255, 255)
shirtless.TextSize = 23.000
shirtless.MouseButton1Click:connect(function()
	local players = getPlayer(target.Text, Players.LocalPlayer)
	for i, v in pairs(players) do
		Destroy(Players[v].Character:FindFirstChildOfClass("Shirt"))
	end
end)

tshirtless.Name = "tshirtless"
tshirtless.Parent = ScrollingFrame
tshirtless.BackgroundColor3 = Color3.fromRGB(172, 172, 172)
tshirtless.BackgroundTransparency = 0.500
tshirtless.BorderSizePixel = 0
tshirtless.Position = UDim2.new(0.079136692, 0, -0.00990098994, 0)
tshirtless.Size = UDim2.new(0, 131, 0, 40)
tshirtless.Font = Enum.Font.SourceSansLight
tshirtless.Text = "Tshirtless"
tshirtless.TextColor3 = Color3.fromRGB(255, 255, 255)
tshirtless.TextSize = 23.000
tshirtless.MouseButton1Click:connect(function()
	local players = getPlayer(target.Text, Players.LocalPlayer)
	for i, v in pairs(players) do
		Destroy(Players[v].Character:FindFirstChildOfClass("ShirtGraphic"))
	end
end)

noregen.Name = "noregen"
noregen.Parent = ScrollingFrame
noregen.BackgroundColor3 = Color3.fromRGB(172, 172, 172)
noregen.BackgroundTransparency = 0.500
noregen.BorderSizePixel = 0
noregen.Position = UDim2.new(0.079136692, 0, -0.00990098994, 0)
noregen.Size = UDim2.new(0, 131, 0, 40)
noregen.Font = Enum.Font.SourceSansLight
noregen.Text = "Noregen"
noregen.TextColor3 = Color3.fromRGB(255, 255, 255)
noregen.TextSize = 23.000
noregen.MouseButton1Click:connect(function()
	local players = getPlayer(target.Text, Players.LocalPlayer)
	for i, v in pairs(players) do
		Destroy(Players[v].Character:FindFirstChild("Health"))
	end
end)

stopanim.Name = "stopanim"
stopanim.Parent = ScrollingFrame
stopanim.BackgroundColor3 = Color3.fromRGB(172, 172, 172)
stopanim.BackgroundTransparency = 0.500
stopanim.BorderSizePixel = 0
stopanim.Position = UDim2.new(0.079136692, 0, -0.00990098994, 0)
stopanim.Size = UDim2.new(0, 131, 0, 40)
stopanim.Font = Enum.Font.SourceSansLight
stopanim.Text = "Stopanim"
stopanim.TextColor3 = Color3.fromRGB(255, 255, 255)
stopanim.TextSize = 23.000
stopanim.MouseButton1Click:connect(function()
	local players = getPlayer(target.Text, Players.LocalPlayer)
	for i, v in pairs(players) do
		Destroy(Players[v].Character:FindFirstChildOfClass("Humanoid"):FindFirstChildOfClass("Animator"))
	end
end)

blockchar.Name = "blockchar"
blockchar.Parent = ScrollingFrame
blockchar.BackgroundColor3 = Color3.fromRGB(172, 172, 172)
blockchar.BackgroundTransparency = 0.500
blockchar.BorderSizePixel = 0
blockchar.Position = UDim2.new(0.079136692, 0, -0.00990098994, 0)
blockchar.Size = UDim2.new(0, 131, 0, 40)
blockchar.Font = Enum.Font.SourceSansLight
blockchar.Text = "Blockchar"
blockchar.TextColor3 = Color3.fromRGB(255, 255, 255)
blockchar.TextSize = 23.000
blockchar.MouseButton1Click:connect(function()
	local players = getPlayer(target.Text, Players.LocalPlayer)
	for i, v in pairs(players) do
		for i, v in pairs(Players[v].Character:GetChildren()) do
			if v:IsA("CharacterMesh") then
				Destroy(v)
			end
		end
	end
end)

nolimbs.Name = "nolimbs"
nolimbs.Parent = ScrollingFrame
nolimbs.BackgroundColor3 = Color3.fromRGB(172, 172, 172)
nolimbs.BackgroundTransparency = 0.500
nolimbs.BorderSizePixel = 0
nolimbs.Position = UDim2.new(0.079136692, 0, -0.00990098994, 0)
nolimbs.Size = UDim2.new(0, 131, 0, 40)
nolimbs.Font = Enum.Font.SourceSansLight
nolimbs.Text = "Nolimbs"
nolimbs.TextColor3 = Color3.fromRGB(255, 255, 255)
nolimbs.TextSize = 23.000
nolimbs.MouseButton1Click:connect(function()
	local players = getPlayer(target.Text, Players.LocalPlayer)
	for i, v in pairs(players) do
		if Players[v].Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then
			Destroy(Players[v].Character["Left Arm"])
			Destroy(Players[v].Character["Left Leg"])
			Destroy(Players[v].Character["Right Arm"])
			Destroy(Players[v].Character["Right Leg"])
		else
			Destroy(Players[v].Character["LeftUpperArm"])
			Destroy(Players[v].Character["LeftUpperLeg"])
			Destroy(Players[v].Character["RightUpperArm"])
			Destroy(Players[v].Character["RightUpperLeg"])
		end
	end
end)

nola.Name = "nola"
nola.Parent = ScrollingFrame
nola.BackgroundColor3 = Color3.fromRGB(172, 172, 172)
nola.BackgroundTransparency = 0.500
nola.BorderSizePixel = 0
nola.Position = UDim2.new(0.079136692, 0, -0.00990098994, 0)
nola.Size = UDim2.new(0, 131, 0, 40)
nola.Font = Enum.Font.SourceSansLight
nola.Text = "Nola"
nola.TextColor3 = Color3.fromRGB(255, 255, 255)
nola.TextSize = 23.000
nola.MouseButton1Click:connect(function()
	local players = getPlayer(target.Text, Players.LocalPlayer)
	for i, v in pairs(players) do
		if Players[v].Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then
			Destroy(Players[v].Character["Left Arm"])
		else
			Destroy(Players[v].Character["LeftUpperArm"])
		end
	end
end)

noll.Name = "noll"
noll.Parent = ScrollingFrame
noll.BackgroundColor3 = Color3.fromRGB(172, 172, 172)
noll.BackgroundTransparency = 0.500
noll.BorderSizePixel = 0
noll.Position = UDim2.new(0.079136692, 0, -0.00990098994, 0)
noll.Size = UDim2.new(0, 131, 0, 40)
noll.Font = Enum.Font.SourceSansLight
noll.Text = "Noll"
noll.TextColor3 = Color3.fromRGB(255, 255, 255)
noll.TextSize = 23.000
noll.MouseButton1Click:connect(function()
	local players = getPlayer(target.Text, Players.LocalPlayer)
	for i, v in pairs(players) do
		if Players[v].Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then
			Destroy(Players[v].Character["Left Leg"])
		else
			Destroy(Players[v].Character["LeftUpperLeg"])
		end
	end
end)

nora.Name = "nora"
nora.Parent = ScrollingFrame
nora.BackgroundColor3 = Color3.fromRGB(172, 172, 172)
nora.BackgroundTransparency = 0.500
nora.BorderSizePixel = 0
nora.Position = UDim2.new(0.079136692, 0, -0.00990098994, 0)
nora.Size = UDim2.new(0, 131, 0, 40)
nora.Font = Enum.Font.SourceSansLight
nora.Text = "Nora"
nora.TextColor3 = Color3.fromRGB(255, 255, 255)
nora.TextSize = 23.000
nora.MouseButton1Click:connect(function()
	local players = getPlayer(target.Text, Players.LocalPlayer)
	for i, v in pairs(players) do
		if Players[v].Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then
			Destroy(Players[v].Character["Right Arm"])
		else
			Destroy(Players[v].Character["RightUpperArm"])
		end
	end
end)

norl.Name = "norl"
norl.Parent = ScrollingFrame
norl.BackgroundColor3 = Color3.fromRGB(172, 172, 172)
norl.BackgroundTransparency = 0.500
norl.BorderSizePixel = 0
norl.Position = UDim2.new(0.079136692, 0, -0.00990098994, 0)
norl.Size = UDim2.new(0, 131, 0, 40)
norl.Font = Enum.Font.SourceSansLight
norl.Text = "Norl"
norl.TextColor3 = Color3.fromRGB(255, 255, 255)
norl.TextSize = 23.000
norl.MouseButton1Click:connect(function()
	local players = getPlayer(target.Text, Players.LocalPlayer)
	for i, v in pairs(players) do
		if Players[v].Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then
			Destroy(Players[v].Character["Right Leg"])
		else
			Destroy(Players[v].Character["RightUpperLeg"])
		end
	end
end)

nowaist.Name = "nowaist"
nowaist.Parent = ScrollingFrame
nowaist.BackgroundColor3 = Color3.fromRGB(172, 172, 172)
nowaist.BackgroundTransparency = 0.500
nowaist.BorderSizePixel = 0
nowaist.Position = UDim2.new(0.079136692, 0, -0.00990098994, 0)
nowaist.Size = UDim2.new(0, 131, 0, 40)
nowaist.Font = Enum.Font.SourceSansLight
nowaist.Text = "Nowaist"
nowaist.TextColor3 = Color3.fromRGB(255, 255, 255)
nowaist.TextSize = 23.000
nowaist.MouseButton1Click:connect(function()
	local players = getPlayer(target.Text, Players.LocalPlayer)
	for i, v in pairs(players) do
		if Players[v].Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R15 then
			Destroy(Players[v].Character.UpperTorso.Waist)
		end
	end
end)

noroot.Name = "noroot"
noroot.Parent = ScrollingFrame
noroot.BackgroundColor3 = Color3.fromRGB(172, 172, 172)
noroot.BackgroundTransparency = 0.500
noroot.BorderSizePixel = 0
noroot.Position = UDim2.new(0.079136692, 0, -0.00990098994, 0)
noroot.Size = UDim2.new(0, 131, 0, 40)
noroot.Font = Enum.Font.SourceSansLight
noroot.Text = "Noroot"
noroot.TextColor3 = Color3.fromRGB(255, 255, 255)
noroot.TextSize = 23.000
noroot.MouseButton1Click:connect(function()
	local players = getPlayer(target.Text, Players.LocalPlayer)
	for i, v in pairs(players) do
		if Players[v].Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R15 then
			Destroy(Players[v].Character.LowerTorso.Root)
		end
	end
end)

top_2.Name = "top"
top_2.Parent = top
top_2.BackgroundColor3 = Color3.fromRGB(47, 47, 200)
top_2.BackgroundTransparency = 1.000
top_2.Position = UDim2.new(0.154639184, 0, -0.333333343, 0)
top_2.Size = UDim2.new(0, 200, 0, 50)
top_2.Font = Enum.Font.SourceSansLight
top_2.Text = "zazasploit"
top_2.TextColor3 = Color3.fromRGB(255, 255, 255)
top_2.TextSize = 45.000

credits.Name = "credits"
credits.Parent = top
credits.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
credits.BackgroundTransparency = 1.000
credits.Position = UDim2.new(0, 0, 1, 0)
credits.Size = UDim2.new(0, 291, 0, 23)
credits.Font = Enum.Font.SourceSansLight
credits.Text = "Skidded by FindingStuff, UI by Unverified"
credits.TextColor3 = Color3.fromRGB(255, 255, 255)
credits.TextSize = 17.000
credits.TextWrapped = true

queue.Name = "queue"
queue.Parent = top
queue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
queue.BackgroundTransparency = 1.000
queue.Position = UDim2.new(0, 0, 10.0333338, 0)
queue.Size = UDim2.new(0, 292, 0, 23)
queue.Font = Enum.Font.SourceSans
queue.Text = "Skidded by FindingStuff   SLOCK: false"
queue.TextColor3 = Color3.fromRGB(255, 0, 4)
queue.TextSize = 20.000
queue.TextWrapped = true

target.Name = "target"
target.Parent = top
target.BackgroundColor3 = Color3.fromRGB(172, 172, 172)
target.BackgroundTransparency = 0.400
target.Position = UDim2.new(0.0206185561, 0, 8.86666584, 0)
target.Size = UDim2.new(0, 278, 0, 33)
target.Font = Enum.Font.SourceSans
target.Text = ""
target.TextColor3 = Color3.fromRGB(255, 255, 255)
target.TextSize = 23.000

local selectionbox = Instance.new("SelectionBox", workspace)
local equipped = false
local oldmouse = mouse.Icon
local destroytool = Instance.new("Tool", Players.LocalPlayer:FindFirstChildOfClass("Backpack"))
destroytool.RequiresHandle = false
destroytool.Name = "Delete"
destroytool.ToolTip = "from zazasploit"
destroytool.TextureId = "http://www.roblox.com/asset/?id=12223874"
destroytool.CanBeDropped = false
destroytool.Equipped:connect(function()
	equipped = true
	mouse.Icon = "rbxasset://textures\\HammerCursor.png"
	while equipped do
		selectionbox.Adornee = mouse.Target
		wait()
	end
end)
destroytool.Unequipped:connect(function()
	equipped = false
	selectionbox.Adornee = nil
	mouse.Icon = oldmouse
	print(oldmouse)
end)
destroytool.Activated:connect(function()
	local explosion = Instance.new("Explosion", workspace)
	explosion.BlastPressure = 0
	explosion.BlastRadius = 0
	explosion.DestroyJointRadiusPercent = 0
	explosion.ExplosionType = Enum.ExplosionType.NoCraters
	explosion.Position = mouse.Target.Position
	Destroy(mouse.Target)
end)
game:GetService("StarterGui"):SetCoreGuiEnabled('Backpack', true)
Players.LocalPlayer.CharacterAdded:connect(function()
	local destroytool = Instance.new("Tool", Players.LocalPlayer:FindFirstChildOfClass("Backpack"))
	destroytool.RequiresHandle = false
	destroytool.Name = "Delete"
	destroytool.ToolTip = "from zazasploit"
	destroytool.TextureId = "http://www.roblox.com/asset/?id=12223874"
	destroytool.CanBeDropped = false
	destroytool.Equipped:connect(function()
		equipped = true
		mouse.Icon = "rbxasset://textures\\HammerCursor.png"
		while equipped do
			selectionbox.Adornee = mouse.Target
			wait()
		end
	end)
	destroytool.Unequipped:connect(function()
		equipped = false
		selectionbox.Adornee = nil
		mouse.Icon = oldmouse
		print(oldmouse)
	end)
	destroytool.Activated:connect(function()
		local explosion = Instance.new("Explosion", workspace)
		explosion.BlastPressure = 0
		explosion.BlastRadius = 0
		explosion.DestroyJointRadiusPercent = 0
		explosion.ExplosionType = Enum.ExplosionType.NoCraters
		explosion.Position = mouse.Target.Position
		Destroy(mouse.Target)
	end)
	game:GetService("StarterGui"):SetCoreGuiEnabled('Backpack', true)
end)
