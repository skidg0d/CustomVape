--need to do  configure fly and speed  test the config  also make Custom Window  press Ctrl and F at the same time and type -- to find all the custom modules easierly
shared.VapeIndependent = true
shared.CustomSaveVape = "301549746"
local GuiLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true))()

local Eternium = GuiLibrary.CreateWindow({
    Name = "Cat",
    Icon = "vape/assets/WorldIcon.png",
    IconSize = 16
})

--onlyheadshot
runFunction(function()
	local OnlyHeadShot = {Enabled = true}
local Combat = GuiLibrary.ObjectsThatCanBeSaved.CombatWindow.Api
local OnlyHeadShot = Combat.CreateOptionsButton({
    Name = "OnlyHeadShot",
    Function = function(callback)
        if callback then
            local CurrentCamera = workspace.CurrentCamera
local Players = game.Players
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
function ClosestPlayer()
    local MaxDist, Closest = math.huge
    for I,V in pairs(Players.GetPlayers(Players)) do
        if V == LocalPlayer then continue end
        if V.Team == LocalPlayer then continue end
        if not V.Character then continue end
        local Head = V.Character.FindFirstChild(V.Character, "Head")
        if not Head then continue end
        local Pos, Vis = CurrentCamera.WorldToScreenPoint(CurrentCamera, Head.Position)
        if not Vis then continue end
        local MousePos, TheirPos = Vector2.new(Mouse.X, Mouse.Y), Vector2.new(Pos.X, Pos.Y)
        local Dist = (TheirPos - MousePos).Magnitude
        if Dist < MaxDist then
            MaxDist = Dist
            Closest = V
        end
    end
    return Closest
end
local MT = getrawmetatable(game)
local OldNC = MT.__namecall
local OldIDX = MT.__index
setreadonly(MT, false)
MT.__namecall = newcclosure(function(self, ...)
    local Args, Method = {...}, getnamecallmethod()
    if Method == "FindPartOnRayWithIgnoreList" and not checkcaller() then
        local CP = ClosestPlayer()
        if CP and CP.Character and CP.Character.FindFirstChild(CP.Character, "Head") then
            Args[1] = Ray.new(CurrentCamera.CFrame.Position, (CP.Character.Head.Position - CurrentCamera.CFrame.Position).Unit * 1000)
            return OldNC(self, unpack(Args))
        end
    end
    return OldNC(self, ...)
end)
MT.__index = newcclosure(function(self, K)
    if K == "Clips" then
        return workspace.Map
    end
    return OldIDX(self, K)
end)
setreadonly(MT, true),
    HoverText = "Shoots people in the head",
    Default = true, 
    ExtraText = function() return "" end 
})

--infinitecash
local Utility = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api
local InfiniteCash = Utility.CreateOptionsButton({
    Name = "InfiniteCash",
    Function = function(callback)
        wait()
        LocalPlayer.Cash.Value = 16000
    end
else
    if loadingCFG then
        return
    end;
    for L_1479_forvar0 = 1, 5 do
        wait()
        LocalPlayer.Cash.Value = oldcash
    end
    HoverText = "Gives you infinite cash ",
    Default = true, 
})

local Utility = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api
local AntiVoteKick = Utility.CreateOptionsButton({
    Name = "AntiVoteKick",
    Function = function(callback)
        if callback then
            local L_1452_ = {}
            for L_1453_forvar0, L_1454_forvar1 in next, L_30_:GetPlayers() do
                if L_1454_forvar1 ~= L_32_ and not L_52_[L_1454_forvar1.Name].novotekick then
                    table.insert(L_1452_, L_1454_forvar1)
                end
            end;
            if # L_1452_ > 1 then
                local L_1455_ = L_1452_[math.random(1, # L_1452_)]
                if L_1455_ then
                    L_41_:FireServer(L_1455_.Name)
                end
            end
        end
    end
    HoverText = "Prevents people from kicking you",
    Default = true,
})


--norecoil
runFunction(function()
	local NoRecoil = {Enabled = true}
local Combat = GuiLibrary.ObjectsThatCanBeSaved.CombatWindow.Api
local NoRecoil = Combat.CreateOptionsButton({
    Name = "NoRecoil",
    Function = function(callback)
        if callback then
            client.RecoilX = 0
            client.RecoilY = 0
            client.resetaccuracy()
        end
    HoverText = "Removes the recoil",
    Default = true,
})

--tracers
runFunction(function()
	local TracersColor = {Value = 0.44}
	local TracersTransparency = {Value = 1}
	local TracersStartPosition = {Value = "Middle"}
	local TracersEndPosition = {Value = "Head"}
	local TracersTeammates = {Enabled = true}
	local tracersfolderdrawing = {}
	local methodused

	local tracersfuncs1 = {
		Drawing = function(plr)
			if TracersTeammates.Enabled and (not plr.Targetable) and (not plr.Friend) then return end
			local newobj = Drawing.new("Line")
			newobj.Thickness = 1
			newobj.Transparency = 1 - (TracersTransparency.Value / 100)
			newobj.Color = getPlayerColor(plr.Player) or Color3.fromHSV(TracersColor.Hue, TracersColor.Sat, TracersColor.Value)
			tracersfolderdrawing[plr.Player] = {entity = plr, Main = newobj}
		end,
		DrawingV3 = function(plr)
			if TracersTeammates.Enabled and (not plr.Targetable) and (not plr.Friend) then return end
			local toppoint = PointInstance.new(plr[TracersEndPosition.Value == "Torso" and "RootPart" or "Head"])
			local bottompoint = TracersStartPosition.Value == "Mouse" and PointMouse.new() or Point2D.new(UDim2.new(0.5, 0, TracersStartPosition.Value == "Middle" and 0.5 or 1, 0))
			local newobj = LineDynamic.new(toppoint, bottompoint)
			newobj.Opacity = 1 - (TracersTransparency.Value / 100)
			newobj.Color = getPlayerColor(plr.Player) or Color3.fromHSV(TracersColor.Hue, TracersColor.Sat, TracersColor.Value)
			tracersfolderdrawing[plr.Player] = {entity = plr, Main = newobj}
		end,
	}
	local tracersfuncs2 = {
		Drawing = function(ent)
			local v = tracersfolderdrawing[ent]
			tracersfolderdrawing[ent] = nil
			if v then 
				pcall(function() v.Main.Visible = false v.Main:Remove() end)
			end
		end,
	}
	local tracerscolorfuncs = {
		Drawing = function(hue, sat, value)
			local color = Color3.fromHSV(hue, sat, value)
			for i,v in pairs(tracersfolderdrawing) do 
				v.Main.Color = getPlayerColor(v.entity.Player) or color
			end
		end
	}
	tracerscolorfuncs.DrawingV3 = tracerscolorfuncs.Drawing
	tracersfuncs2.DrawingV3 = tracersfuncs2.Drawing
	local tracersloop = {
		Drawing = function()
			for i,v in pairs(tracersfolderdrawing) do 
				local rootPart = v.entity[TracersEndPosition.Value == "Torso" and "RootPart" or "Head"].Position
				local rootPos, rootVis = worldtoviewportpoint(rootPart)
				local screensize = gameCamera.ViewportSize
				local startVector = TracersStartPosition.Value == "Mouse" and inputService:GetMouseLocation() or Vector2.new(screensize.X / 2, (TracersStartPosition.Value == "Middle" and screensize.Y / 2 or screensize.Y))
				local endVector = Vector2.new(rootPos.X, rootPos.Y)
				v.Main.Visible = rootVis
				v.Main.From = startVector
				v.Main.To = endVector
			end
		end,
	}

	local Tracers = {Enabled = false}
	Tracers = GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api.CreateOptionsButton({
		Name = "Tracers", 
		Function = function(callback) 
			if callback then
				methodused = "Drawing"..synapsev3
				if tracersfuncs2[methodused] then
					table.insert(Tracers.Connections, entityLibrary.entityRemovedEvent:Connect(tracersfuncs2[methodused]))
				end
				if tracersfuncs1[methodused] then
					local addfunc = tracersfuncs1[methodused]
					for i,v in pairs(entityLibrary.entityList) do 
						if tracersfolderdrawing[v.Player] then tracersfuncs2[methodused](v.Player) end
						addfunc(v)
					end
					table.insert(Tracers.Connections, entityLibrary.entityAddedEvent:Connect(function(ent)
						if tracersfolderdrawing[ent.Player] then tracersfuncs2[methodused](ent.Player) end
						addfunc(ent)
					end))
				end
				if tracerscolorfuncs[methodused] then 
					table.insert(Tracers.Connections, GuiLibrary.ObjectsThatCanBeSaved.FriendsListTextCircleList.Api.FriendColorRefresh.Event:Connect(function()
						tracerscolorfuncs[methodused](TracersColor.Hue, TracersColor.Sat, TracersColor.Value)
					end))
				end
				if tracersloop[methodused] then 
					RunLoops:BindToRenderStep("Tracers", tracersloop[methodused])
				end
			else
				RunLoops:UnbindFromRenderStep("Tracers")
				for i,v in pairs(tracersfolderdrawing) do 
					if tracersfuncs2[methodused] then
						tracersfuncs2[methodused](i)
					end
				end
			end
		end,
		HoverText = "Extra Sensory Perception\nRenders an Tracers on players."
	})
	TracersStartPosition = Tracers.CreateDropdown({
		Name = "Start Position",
		List = {"Middle", "Bottom", "Mouse"},
		Function = function() if Tracers.Enabled then Tracers.ToggleButton(true) Tracers.ToggleButton(true) end end
	})
	TracersEndPosition = Tracers.CreateDropdown({
		Name = "End Position",
		List = {"Head", "Torso"},
		Function = function() if Tracers.Enabled then Tracers.ToggleButton(true) Tracers.ToggleButton(true) end end
	})
	TracersColor = Tracers.CreateColorSlider({
		Name = "Player Color", 
		Function = function(hue, sat, val) 
			if Tracers.Enabled and tracerscolorfuncs[methodused] then 
				tracerscolorfuncs[methodused](hue, sat, val)
			end
		end
	})
	TracersTransparency = Tracers.CreateSlider({
		Name = "Transparency", 
		Min = 1,
		Max = 100, 
		Function = function(val) 
			for i,v in pairs(tracersfolderdrawing) do 
				if v.Main then 
					v.Main[methodused == "DrawingV3" and "Opacity" or "Transparency"] = 1 - (val / 100)
				end
			end
		end,
		Default = 0
	})
	TracersTeammates = Tracers.CreateToggle({
		Name = "Priority Only",
		Function = function() if Tracers.Enabled then Tracers.ToggleButton(true) Tracers.ToggleButton(true) end end,
		Default = true
	})
end)

--chatspammer
runFunction(function()
	local ChatSpammer = {Enabled = false}
	local ChatSpammerDelay = {Value = 10}
	local ChatSpammerHideWait = {Enabled = true}
	local ChatSpammerMessages = {ObjectList = {}}
	local chatspammerfirstexecute = true
	local chatspammerhook = false
	local oldchanneltab
	local oldchannelfunc
	local oldchanneltabs = {}
	local waitnum = 0
	ChatSpammer = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
		Name = "ChatSpammer",
		Function = function(callback)
			if callback then
				if textChatService.ChatVersion == Enum.ChatVersion.TextChatService then 
					task.spawn(function()
						repeat
							if ChatSpammer.Enabled then
								pcall(function()
									textChatService.ChatInputBarConfiguration.TargetTextChannel:SendAsync((#ChatSpammerMessages.ObjectList > 0 and ChatSpammerMessages.ObjectList[math.random(1, #ChatSpammerMessages.ObjectList)] or "vxpe on top"))
								end)
							end
							if waitnum ~= 0 then
								task.wait(waitnum)
								waitnum = 0
							else
								task.wait(ChatSpammerDelay.Value / 10)
							end
						until not ChatSpammer.Enabled
					end)
				else
					task.spawn(function()
						if chatspammerfirstexecute then
							lplr.PlayerGui:WaitForChild("Chat", 10)
							chatspammerfirstexecute = false
						end
						if lplr.PlayerGui:FindFirstChild("Chat") and lplr.PlayerGui.Chat:FindFirstChild("Frame") and lplr.PlayerGui.Chat.Frame:FindFirstChild("ChatChannelParentFrame") and replicatedStorageService:FindFirstChild("DefaultChatSystemChatEvents") then
							if not chatspammerhook then
								task.spawn(function()
									chatspammerhook = true
									for i,v in pairs(getconnections(replicatedStorageService.DefaultChatSystemChatEvents.OnNewMessage.OnClientEvent)) do
										if v.Function and #debug.getupvalues(v.Function) > 0 and type(debug.getupvalues(v.Function)[1]) == "table" and getmetatable(debug.getupvalues(v.Function)[1]) and getmetatable(debug.getupvalues(v.Function)[1]).GetChannel then
											oldchanneltab = getmetatable(debug.getupvalues(v.Function)[1])
											oldchannelfunc = getmetatable(debug.getupvalues(v.Function)[1]).GetChannel
											getmetatable(debug.getupvalues(v.Function)[1]).GetChannel = function(Self, Name)
												local tab = oldchannelfunc(Self, Name)
												if tab and tab.AddMessageToChannel then
													local addmessage = tab.AddMessageToChannel
													if oldchanneltabs[tab] == nil then
														oldchanneltabs[tab] = tab.AddMessageToChannel
													end
													tab.AddMessageToChannel = function(Self2, MessageData)
														if MessageData.MessageType == "System" then
															if MessageData.Message:find("You must wait") and ChatSpammer.Enabled then
																return nil
															end
														end
														return addmessage(Self2, MessageData)
													end
												end
												return tab
											end
										end
									end
								end)
							end
							task.spawn(function()
								repeat
									pcall(function()
										replicatedStorageService.DefaultChatSystemChatEvents.SayMessageRequest:FireServer((#ChatSpammerMessages.ObjectList > 0 and ChatSpammerMessages.ObjectList[math.random(1, #ChatSpammerMessages.ObjectList)] or "vxpe on top"), "All")
									end)
									if waitnum ~= 0 then
										task.wait(waitnum)
										waitnum = 0
									else
										task.wait(ChatSpammerDelay.Value / 10)
									end
								until not ChatSpammer.Enabled
							end)				
						else
							warningNotification("ChatSpammer", "Default chat not found.", 3)
							if ChatSpammer.Enabled then ChatSpammer.ToggleButton(false) end
						end
					end)
				end
			else
				waitnum = 0
			end
		end,
		HoverText = "Spams chat with text of your choice (Default Chat Only)"
	})
	ChatSpammerDelay = ChatSpammer.CreateSlider({
		Name = "Delay",
		Min = 1,
		Max = 50,
		Default = 10,
		Function = function() end
	})
	ChatSpammerHideWait = ChatSpammer.CreateToggle({
		Name = "Hide Wait Message",
		Function = function() end,
		Default = true
	})
	ChatSpammerMessages = ChatSpammer.CreateTextList({
		Name = "Message",
		TempText = "message to spam",
		Function = function() end
	})
end)

--autoreport
runFunction(function()
	local AutoReport = {Enabled = false}
	local AutoReportList = {ObjectList = {}}
	local AutoReportNotify = {Enabled = false}
	local alreadyreported = {}

	local function removerepeat(str)
		local newstr = ""
		local lastlet = ""
		for i,v in pairs(str:split("")) do 
			if v ~= lastlet then
				newstr = newstr..v 
				lastlet = v
			end
		end
		return newstr
	end

	local reporttable = {
		gay = "Bullying",
		gae = "Bullying",
		gey = "Bullying",
		hack = "Scamming",
		exploit = "Scamming",
		cheat = "Scamming",
		hecker = "Scamming",
		haxker = "Scamming",
		hacer = "Scamming",
		report = "Bullying",
		fat = "Bullying",
		black = "Bullying",
		getalife = "Bullying",
		fatherless = "Bullying",
		report = "Bullying",
		fatherless = "Bullying",
		disco = "Offsite Links",
		yt = "Offsite Links",
		dizcourde = "Offsite Links",
		retard = "Swearing",
		bad = "Bullying",
		trash = "Bullying",
		nolife = "Bullying",
		nolife = "Bullying",
		loser = "Bullying",
		killyour = "Bullying",
		kys = "Bullying",
		hacktowin = "Bullying",
		bozo = "Bullying",
		kid = "Bullying",
		adopted = "Bullying",
		linlife = "Bullying",
		commitnotalive = "Bullying",
		vape = "Offsite Links",
		futureclient = "Offsite Links",
		download = "Offsite Links",
		youtube = "Offsite Links",
		die = "Bullying",
		lobby = "Bullying",
		ban = "Bullying",
		wizard = "Bullying",
		wisard = "Bullying",
		witch = "Bullying",
		magic = "Bullying",
	}
	local reporttableexact = {
		L = "Bullying",
	}
	

	local function findreport(msg)
		local checkstr = removerepeat(msg:gsub("%W+", ""):lower())
		for i,v in pairs(reporttable) do 
			if checkstr:find(i) then 
				return v, i
			end
		end
		for i,v in pairs(reporttableexact) do 
			if checkstr == i then 
				return v, i
			end
		end
		for i,v in pairs(AutoReportList.ObjectList) do 
			if checkstr:find(v) then 
				return "Bullying", v
			end
		end
		return nil
	end

	AutoReport = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
		Name = "AutoReport",
		Function = function(callback) 
			if callback then 
				if textChatService.ChatVersion == Enum.ChatVersion.TextChatService then 
					table.insert(AutoReport.Connections, textChatService.MessageReceived:Connect(function(tab)
						if tab.TextSource then
							local plr = playersService:GetPlayerByUserId(tab.TextSource.UserId)
							local args = tab.Text:split(" ")
							if plr and plr ~= lplr and WhitelistFunctions:GetWhitelist(plr) == 0 then
								local reportreason, reportedmatch = findreport(tab.Text)
								if reportreason then 
									if alreadyreported[plr] then return end
									task.spawn(function()
										if syn == nil or reportplayer then
											if reportplayer then
												reportplayer(plr, reportreason, "he said a bad word")
											else
												playersService:ReportAbuse(plr, reportreason, "he said a bad word")
											end
										end
									end)
									if AutoReportNotify.Enabled then 
										warningNotification("AutoReport", "Reported "..plr.Name.." for "..reportreason..' ('..reportedmatch..')', 15)
									end
									alreadyreported[plr] = true
								end
							end
						end
					end))
				else 
					if replicatedStorageService:FindFirstChild("DefaultChatSystemChatEvents") then
						table.insert(AutoReport.Connections, replicatedStorageService.DefaultChatSystemChatEvents.OnMessageDoneFiltering.OnClientEvent:Connect(function(tab, channel)
							local plr = playersService:FindFirstChild(tab.FromSpeaker)
							local args = tab.Message:split(" ")
							if plr and plr ~= lplr and WhitelistFunctions:GetWhitelist(plr) == 0 then
								local reportreason, reportedmatch = findreport(tab.Message)
								if reportreason then 
									if alreadyreported[plr] then return end
									task.spawn(function()
										if syn == nil or reportplayer then
											if reportplayer then
												reportplayer(plr, reportreason, "he said a bad word")
											else
												playersService:ReportAbuse(plr, reportreason, "he said a bad word")
											end
										end
									end)
									if AutoReportNotify.Enabled then 
										warningNotification("AutoReport", "Reported "..plr.Name.." for "..reportreason..' ('..reportedmatch..')', 15)
									end
									alreadyreported[plr] = true
								end
							end
						end))
					else
						warningNotification("AutoReport", "Default chat not found.", 5)
						AutoReport.ToggleButton(false)
					end
				end
			end
		end
	})
	AutoReportNotify = AutoReport.CreateToggle({
		Name = "Notify",
		Function = function() end
	})
	AutoReportList = AutoReport.CreateTextList({
		Name = "Report Words",
		TempText = "phrase (to report)"
	})
end)

--keystrokes
runFunction(function()
	local Keystrokes = {}
	local keys = {}
	local keystrokesframe
	local keyconnection1
	local keyconnection2

	local function createKeystroke(keybutton, pos, pos2)
		local key = Instance.new("Frame")
		key.Size = keybutton == Enum.KeyCode.Space and UDim2.new(0, 110, 0, 24) or UDim2.new(0, 34, 0, 36)
		key.BackgroundColor3 = Color3.new()
		key.BackgroundTransparency = 0.5
		key.Position = pos
		key.Name = keybutton.Name
		key.Parent = keystrokesframe
		local keytext = Instance.new("TextLabel")
		keytext.BackgroundTransparency = 1
		keytext.Size = UDim2.new(1, 0, 1, 0)
		keytext.Font = Enum.Font.Gotham
		keytext.Text = keybutton == Enum.KeyCode.Space and "______" or keybutton.Name
		keytext.TextXAlignment = Enum.TextXAlignment.Left
		keytext.TextYAlignment = Enum.TextYAlignment.Top
		keytext.Position = pos2
		keytext.TextSize = keybutton == Enum.KeyCode.Space and 18 or 15
		keytext.TextColor3 = Color3.new(1, 1, 1)
		keytext.Parent = key
		local keycorner = Instance.new("UICorner")
		keycorner.CornerRadius = UDim.new(0, 4)
		keycorner.Parent = key
		keys[keybutton] = {Key = key}
	end

	Keystrokes = GuiLibrary.CreateLegitModule({
		Name = "Keystrokes",
		Function = function(callback)
			if callback then 
				keyconnection1 = inputService.InputBegan:Connect(function(inputType)
					local key = keys[inputType.KeyCode]
					if key then 
						if key.Tween then key.Tween:Cancel() end
						if key.Tween2 then key.Tween2:Cancel() end
						key.Tween = tweenService:Create(key.Key, TweenInfo.new(0.1), {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0})
						key.Tween:Play()
						key.Tween2 = tweenService:Create(key.Key.TextLabel, TweenInfo.new(0.1), {TextColor3 = Color3.new()})
						key.Tween2:Play()
					end
				end)
				keyconnection2 = inputService.InputEnded:Connect(function(inputType)
					local key = keys[inputType.KeyCode]
					if key then 
						if key.Tween then key.Tween:Cancel() end
						if key.Tween2 then key.Tween2:Cancel() end
						key.Tween = tweenService:Create(key.Key, TweenInfo.new(0.1), {BackgroundColor3 = Color3.new(), BackgroundTransparency = 0.5})
						key.Tween:Play()
						key.Tween2 = tweenService:Create(key.Key.TextLabel, TweenInfo.new(0.1), {TextColor3 = Color3.new(1, 1, 1)})
						key.Tween2:Play()
					end
				end)
			else
				if keyconnection1 then keyconnection1:Disconnect() end
				if keyconnection2 then keyconnection2:Disconnect() end
			end
		end
	})
	keystrokesframe = Instance.new("Frame")
	keystrokesframe.Size = UDim2.new(0, 110, 0, 176)
	keystrokesframe.BackgroundTransparency = 1
	keystrokesframe.Parent = Keystrokes.GetCustomChildren()
	createKeystroke(Enum.KeyCode.W, UDim2.new(0, 38, 0, 0), UDim2.new(0, 6, 0, 5))
	createKeystroke(Enum.KeyCode.S, UDim2.new(0, 38, 0, 42), UDim2.new(0, 8, 0, 5))
	createKeystroke(Enum.KeyCode.A, UDim2.new(0, 0, 0, 42), UDim2.new(0, 7, 0, 5))
	createKeystroke(Enum.KeyCode.D, UDim2.new(0, 76, 0, 42), UDim2.new(0, 8, 0, 5))
	createKeystroke(Enum.KeyCode.Space, UDim2.new(0, 0, 0, 83), UDim2.new(0, 25, 0, -10))
end)

--esp
runFunction(function()
	local ESPColor = {Value = 0.44}
	local ESPHealthBar = {Enabled = false}
	local ESPBoundingBox = {Enabled = true}
	local ESPName = {Enabled = true}
	local ESPMethod = {Value = "2D"}
	local ESPTeammates = {Enabled = true}
	local espfolderdrawing = {}
	local espconnections = {}
	local methodused

	local function floorESPPosition(pos)
		return Vector2.new(math.floor(pos.X), math.floor(pos.Y))
	end

	local function ESPWorldToViewport(pos)
		local newpos = worldtoviewportpoint(gameCamera.CFrame:pointToWorldSpace(gameCamera.CFrame:pointToObjectSpace(pos)))
		return Vector2.new(newpos.X, newpos.Y)
	end

	local espfuncs1 = {
		Drawing2D = function(plr)
			if ESPTeammates.Enabled and (not plr.Targetable) and (not plr.Friend) then return end
			local thing = {}
			thing.Quad1 = Drawing.new("Square")
			thing.Quad1.Transparency = ESPBoundingBox.Enabled and 1 or 0
			thing.Quad1.ZIndex = 2
			thing.Quad1.Filled = false
			thing.Quad1.Thickness = 1
			thing.Quad1.Color = getPlayerColor(plr.Player) or Color3.fromHSV(ESPColor.Hue, ESPColor.Sat, ESPColor.Value)
			thing.QuadLine2 = Drawing.new("Square")
			thing.QuadLine2.Transparency = ESPBoundingBox.Enabled and 0.5 or 0
			thing.QuadLine2.ZIndex = 1
			thing.QuadLine2.Thickness = 1
			thing.QuadLine2.Filled = false
			thing.QuadLine2.Color = Color3.new()
			thing.QuadLine3 = Drawing.new("Square")
			thing.QuadLine3.Transparency = ESPBoundingBox.Enabled and 0.5 or 0
			thing.QuadLine3.ZIndex = 1
			thing.QuadLine3.Thickness = 1
			thing.QuadLine3.Filled = false
			thing.QuadLine3.Color = Color3.new()
			if ESPHealthBar.Enabled then 
				thing.Quad3 = Drawing.new("Line")
				thing.Quad3.Thickness = 1
				thing.Quad3.ZIndex = 2
				thing.Quad3.Color = Color3.new(0, 1, 0)
				thing.Quad4 = Drawing.new("Line")
				thing.Quad4.Thickness = 3
				thing.Quad4.Transparency = 0.5
				thing.Quad4.ZIndex = 1
				thing.Quad4.Color = Color3.new()
			end
			if ESPName.Enabled then 
				thing.Drop = Drawing.new("Text")
				thing.Drop.Color = Color3.new()
				thing.Drop.Text = WhitelistFunctions:GetTag(plr.Player)..(plr.Player.DisplayName or plr.Player.Name)
				thing.Drop.ZIndex = 1
				thing.Drop.Center = true
				thing.Drop.Size = 20
				thing.Text = Drawing.new("Text")
				thing.Text.Text = thing.Drop.Text
				thing.Text.ZIndex = 2
				thing.Text.Color = thing.Quad1.Color
				thing.Text.Center = true
				thing.Text.Size = 20
			end
			espfolderdrawing[plr.Player] = {entity = plr, Main = thing}
		end,
		Drawing2DV3 = function(plr)
			if ESPTeammates.Enabled and (not plr.Targetable) and (not plr.Friend) then return end
			local toppoint = PointInstance.new(plr.RootPart, CFrame.new(2, 3, 0))
			local bottompoint = PointInstance.new(plr.RootPart, CFrame.new(-2, -3.5, 0))
			local newobj = RectDynamic.new(toppoint)
			newobj.BottomRight = bottompoint
			newobj.Outlined = ESPBoundingBox.Enabled
			newobj.Opacity = ESPBoundingBox.Enabled and 1 or 0
			newobj.OutlineOpacity = 0.5
			newobj.Color = getPlayerColor(plr.Player) or Color3.fromHSV(ESPColor.Hue, ESPColor.Sat, ESPColor.Value)
			local newobj2 = {}
			local newobj3 = {}
			if ESPHealthBar.Enabled then 
				local topoffset = PointOffset.new(PointInstance.new(plr.RootPart, CFrame.new(-2, 3, 0)), Vector2.new(-5, -1))
				local bottomoffset = PointOffset.new(PointInstance.new(plr.RootPart, CFrame.new(-2, -3.5, 0)), Vector2.new(-3, 1))
				local healthoffset = PointOffset.new(bottomoffset, Vector2.new(0, -1))
				local healthoffset2 = PointOffset.new(bottomoffset, Vector2.new(-1, -((bottomoffset.ScreenPos.Y - topoffset.ScreenPos.Y) - 1)))
				newobj2.Bkg = RectDynamic.new(topoffset)
				newobj2.Bkg.Filled = true
				newobj2.Bkg.Opacity = 0.5
				newobj2.Bkg.BottomRight = bottomoffset
				newobj2.Line = RectDynamic.new(healthoffset)
				newobj2.Line.Filled = true
				newobj2.Line.YAlignment = YAlignment.Bottom
				newobj2.Line.BottomRight = healthoffset2
				newobj2.Line.Color = Color3.fromHSV(math.clamp(plr.Humanoid.Health / plr.Humanoid.MaxHealth, 0, 1) / 2.5, 0.89, 1)
				newobj2.Offset = healthoffset2
				newobj2.TopOffset = topoffset
				newobj2.BottomOffset = bottomoffset
			end
			if ESPName.Enabled then 
				local nameoffset1 = PointOffset.new(PointInstance.new(plr.RootPart, CFrame.new(0, 3, 0)), Vector2.new(0, -15))
				local nameoffset2 = PointOffset.new(nameoffset1, Vector2.new(1, 1))
				newobj3.Text = TextDynamic.new(nameoffset1)
				newobj3.Text.Text = WhitelistFunctions:GetTag(plr.Player)..(plr.Player.DisplayName or plr.Player.Name)
				newobj3.Text.Color = newobj.Color
				newobj3.Text.ZIndex = 2
				newobj3.Text.Size = 20
				newobj3.Drop = TextDynamic.new(nameoffset2)
				newobj3.Drop.Text = newobj3.Text.Text
				newobj3.Drop.Color = Color3.new()
				newobj3.Drop.ZIndex = 1
				newobj3.Drop.Size = 20
			end
			espfolderdrawing[plr.Player] = {entity = plr, Main = newobj, HealthBar = newobj2, Name = newobj3}
		end,
		DrawingSkeleton = function(plr)
			if ESPTeammates.Enabled and (not plr.Targetable) and (not plr.Friend) then return end
			local thing = {}
			thing.Head = Drawing.new("Line")
			thing.Head2 = Drawing.new("Line")
			thing.Torso = Drawing.new("Line")
			thing.Torso2 = Drawing.new("Line")
			thing.Torso3 = Drawing.new("Line")
			thing.LeftArm = Drawing.new("Line")
			thing.RightArm = Drawing.new("Line")
			thing.LeftLeg = Drawing.new("Line")
			thing.RightLeg = Drawing.new("Line")
			local color = getPlayerColor(plr.Player) or Color3.fromHSV(ESPColor.Hue, ESPColor.Sat, ESPColor.Value)
			for i,v in pairs(thing) do v.Thickness = 2 v.Color = color end
			espfolderdrawing[plr.Player] = {entity = plr, Main = thing}
		end,
		DrawingSkeletonV3 = function(plr)
			if ESPTeammates.Enabled and (not plr.Targetable) and (not plr.Friend) then return end
			local thing = {Main = {}, entity = plr}
			local rigcheck = plr.Humanoid.RigType == Enum.HumanoidRigType.R6
			local head = PointInstance.new(plr.Head)
			head.RotationType = CFrameRotationType.TargetRelative
			local headfront = PointInstance.new(plr.Head, CFrame.new(0, 0, -0.5))
			headfront.RotationType = CFrameRotationType.TargetRelative
			local toplefttorso = PointInstance.new(plr.Character[(rigcheck and "Torso" or "UpperTorso")], CFrame.new(-1.5, 0.8, 0))
			toplefttorso.RotationType = CFrameRotationType.TargetRelative
			local toprighttorso = PointInstance.new(plr.Character[(rigcheck and "Torso" or "UpperTorso")], CFrame.new(1.5, 0.8, 0))
			toprighttorso.RotationType = CFrameRotationType.TargetRelative
			local toptorso = PointInstance.new(plr.Character[(rigcheck and "Torso" or "UpperTorso")], CFrame.new(0, 0.8, 0))
			toptorso.RotationType = CFrameRotationType.TargetRelative
			local bottomtorso = PointInstance.new(plr.Character[(rigcheck and "Torso" or "UpperTorso")], CFrame.new(0, -0.8, 0))
			bottomtorso.RotationType = CFrameRotationType.TargetRelative
			local bottomlefttorso = PointInstance.new(plr.Character[(rigcheck and "Torso" or "UpperTorso")], CFrame.new(-0.5, -0.8, 0))
			bottomlefttorso.RotationType = CFrameRotationType.TargetRelative
			local bottomrighttorso = PointInstance.new(plr.Character[(rigcheck and "Torso" or "UpperTorso")], CFrame.new(0.5, -0.8, 0))
			bottomrighttorso.RotationType = CFrameRotationType.TargetRelative
			local leftarm = PointInstance.new(plr.Character[(rigcheck and "Left Arm" or "LeftHand")], CFrame.new(0, -0.8, 0))
			leftarm.RotationType = CFrameRotationType.TargetRelative
			local rightarm = PointInstance.new(plr.Character[(rigcheck and "Right Arm" or "RightHand")], CFrame.new(0, -0.8, 0))
			rightarm.RotationType = CFrameRotationType.TargetRelative
			local leftleg = PointInstance.new(plr.Character[(rigcheck and "Left Leg" or "LeftFoot")], CFrame.new(0, -0.8, 0))
			leftleg.RotationType = CFrameRotationType.TargetRelative
			local rightleg = PointInstance.new(plr.Character[(rigcheck and "Right Leg" or "RightFoot")], CFrame.new(0, -0.8, 0))
			rightleg.RotationType = CFrameRotationType.TargetRelative
			thing.Main.Head = LineDynamic.new(toptorso, head)
			thing.Main.Head2 = LineDynamic.new(head, headfront)
			thing.Main.Torso = LineDynamic.new(toplefttorso, toprighttorso)
			thing.Main.Torso2 = LineDynamic.new(toptorso, bottomtorso)
			thing.Main.Torso3 = LineDynamic.new(bottomlefttorso, bottomrighttorso)
			thing.Main.LeftArm = LineDynamic.new(toplefttorso, leftarm)
			thing.Main.RightArm = LineDynamic.new(toprighttorso, rightarm)
			thing.Main.LeftLeg = LineDynamic.new(bottomlefttorso, leftleg)
			thing.Main.RightLeg = LineDynamic.new(bottomrighttorso, rightleg)
			local color = getPlayerColor(plr.Player) or Color3.fromHSV(ESPColor.Hue, ESPColor.Sat, ESPColor.Value)
			for i,v in pairs(thing.Main) do v.Thickness = 2 v.Color = color end
			espfolderdrawing[plr.Player] = thing
		end,
		Drawing3D = function(plr)
			if ESPTeammates.Enabled and (not plr.Targetable) and (not plr.Friend) then return end
			local thing = {}
			thing.Line1 = Drawing.new("Line")
			thing.Line2 = Drawing.new("Line")
			thing.Line3 = Drawing.new("Line")
			thing.Line4 = Drawing.new("Line")
			thing.Line5 = Drawing.new("Line")
			thing.Line6 = Drawing.new("Line")
			thing.Line7 = Drawing.new("Line")
			thing.Line8 = Drawing.new("Line")
			thing.Line9 = Drawing.new("Line")
			thing.Line10 = Drawing.new("Line")
			thing.Line11 = Drawing.new("Line")
			thing.Line12 = Drawing.new("Line")
			local color = getPlayerColor(plr.Player) or Color3.fromHSV(ESPColor.Hue, ESPColor.Sat, ESPColor.Value)
			for i,v in pairs(thing) do v.Thickness = 1 v.Color = color end
			espfolderdrawing[plr.Player] = {entity = plr, Main = thing}
		end,
		Drawing3DV3 = function(plr)
			if ESPTeammates.Enabled and (not plr.Targetable) and (not plr.Friend) then return end
			local thing = {}
			local point1 = PointInstance.new(plr.RootPart, CFrame.new(1.5, 3, 1.5))
			point1.RotationType = CFrameRotationType.Ignore
			local point2 = PointInstance.new(plr.RootPart, CFrame.new(1.5, -3, 1.5))
			point2.RotationType = CFrameRotationType.Ignore
			local point3 = PointInstance.new(plr.RootPart, CFrame.new(-1.5, 3, 1.5))
			point3.RotationType = CFrameRotationType.Ignore
			local point4 = PointInstance.new(plr.RootPart, CFrame.new(-1.5, -3, 1.5))
			point4.RotationType = CFrameRotationType.Ignore
			local point5 = PointInstance.new(plr.RootPart, CFrame.new(1.5, 3, -1.5))
			point5.RotationType = CFrameRotationType.Ignore
			local point6 = PointInstance.new(plr.RootPart, CFrame.new(1.5, -3, -1.5))
			point6.RotationType = CFrameRotationType.Ignore
			local point7 = PointInstance.new(plr.RootPart, CFrame.new(-1.5, 3, -1.5))
			point7.RotationType = CFrameRotationType.Ignore
			local point8 = PointInstance.new(plr.RootPart, CFrame.new(-1.5, -3, -1.5))
			point8.RotationType = CFrameRotationType.Ignore
			thing.Line1 = LineDynamic.new(point1, point2)
			thing.Line2 = LineDynamic.new(point3, point4)
			thing.Line3 = LineDynamic.new(point5, point6)
			thing.Line4 = LineDynamic.new(point7, point8)
			thing.Line5 = LineDynamic.new(point1, point3)
			thing.Line6 = LineDynamic.new(point1, point5)
			thing.Line7 = LineDynamic.new(point5, point7)
			thing.Line8 = LineDynamic.new(point7, point3)
			thing.Line9 = LineDynamic.new(point2, point4)
			thing.Line10 = LineDynamic.new(point2, point6)
			thing.Line11 = LineDynamic.new(point6, point8)
			thing.Line12 = LineDynamic.new(point8, point4)
			local color = getPlayerColor(plr.Player) or Color3.fromHSV(ESPColor.Hue, ESPColor.Sat, ESPColor.Value)
			for i,v in pairs(thing) do v.Thickness = 1 v.Color = color end
			espfolderdrawing[plr.Player] = {entity = plr, Main = thing}
		end
	}
	local espfuncs2 = {
		Drawing2D = function(ent)
			local v = espfolderdrawing[ent]
			espfolderdrawing[ent] = nil
			if v then 
				for i2,v2 in pairs(v.Main) do
					pcall(function() v2.Visible = false v2:Remove() end)
				end
			end
		end,
		Drawing2DV3 = function(ent)
			local v = espfolderdrawing[ent]
			espfolderdrawing[ent] = nil
			if v then
				v.Main.Visible = false
				for i2,v2 in pairs(v.HealthBar) do
					if typeof(v2):find("Point") == nil then 
						v2.Visible = false
					end
				end
				for i2,v2 in pairs(v.Name) do
					if typeof(v2):find("Point") == nil then 
						v2.Visible = false
					end
				end
			end
		end,
		Drawing3D = function(ent)
			local v = espfolderdrawing[ent]
			espfolderdrawing[ent] = nil
			if v then 
				for i2,v2 in pairs(v.Main) do
					pcall(function() v2.Visible = false v2:Remove() end)
				end
			end
		end,
		Drawing3DV3 = function(ent)
			local v = espfolderdrawing[ent]
			espfolderdrawing[ent] = nil
			if v then
				for i2,v2 in pairs(v.Main) do
					if typeof(v2):find("Dynamic") then 
						v2.Visible = false
					end
				end
			end
		end,
		DrawingSkeleton = function(ent)
			local v = espfolderdrawing[ent]
			espfolderdrawing[ent] = nil
			if v then 
				for i2,v2 in pairs(v.Main) do
					pcall(function() v2.Visible = false v2:Remove() end)
				end
			end
		end,
		DrawingSkeletonV3 = function(ent)
			local v = espfolderdrawing[ent]
			espfolderdrawing[ent] = nil
			if v then 
				for i2,v2 in pairs(v.Main) do
					if typeof(v2):find("Dynamic") then 
						v2.Visible = false
					end
				end
			end
		end
	}
	local espupdatefuncs = {
		Drawing2D = function(ent)
			local v = espfolderdrawing[ent.Player]
			if v and v.Main.Quad3 then 
				local color = Color3.fromHSV(math.clamp(ent.Humanoid.Health / ent.Humanoid.MaxHealth, 0, 1) / 2.5, 0.89, 1)
				v.Main.Quad3.Color = color
			end
			if v and v.Text then 
				v.Text.Text = WhitelistFunctions:GetTag(ent.Player)..(ent.Player.DisplayName or ent.Player.Name)
				v.Drop.Text = v.Text.Text
			end
		end,
		Drawing2DV3 = function(ent)
			local v = espfolderdrawing[ent.Player]
			if v and v.HealthBar.Line then 
				local health = ent.Humanoid.Health / ent.Humanoid.MaxHealth
				local color = Color3.fromHSV(math.clamp(health, 0, 1) / 2.5, 0.89, 1)
				v.HealthBar.Line.Color = color
			end
			if v and v.Name and v.Name.Text then 
				v.Name.Text.Text = WhitelistFunctions:GetTag(ent.Player)..(ent.Player.DisplayName or ent.Player.Name)
				v.Name.Drop.Text = v.Name.Text.Text
			end
		end
	}
	local espcolorfuncs = {
		Drawing2D = function(hue, sat, value)
			local color = Color3.fromHSV(hue, sat, value)
			for i,v in pairs(espfolderdrawing) do 
				v.Main.Quad1.Color = getPlayerColor(v.entity.Player) or color
				if v.Main.Text then 
					v.Main.Text.Color = v.Main.Quad1.Color
				end
			end
		end,
		Drawing2DV3 = function(hue, sat, value)
			local color = Color3.fromHSV(hue, sat, value)
			for i,v in pairs(espfolderdrawing) do 
				v.Main.Color = getPlayerColor(v.entity.Player) or color
				if v.Name.Text then 
					v.Name.Text.Color = v.Main.Color
				end
			end
		end,
		Drawing3D = function(hue, sat, value)
			local color = Color3.fromHSV(hue, sat, value)
			for i,v in pairs(espfolderdrawing) do 
				local newcolor = getPlayerColor(v.entity.Player) or color
				for i2,v2 in pairs(v.Main) do
					v2.Color = newcolor
				end
			end
		end,
		Drawing3DV3 = function(hue, sat, value)
			local color = Color3.fromHSV(hue, sat, value)
			for i,v in pairs(espfolderdrawing) do 
				local newcolor = getPlayerColor(v.entity.Player) or color
				for i2,v2 in pairs(v.Main) do
					if typeof(v2):find("Dynamic") then 
						v2.Color = newcolor
					end
				end
			end
		end,
		DrawingSkeleton = function(hue, sat, value)
			local color = Color3.fromHSV(hue, sat, value)
			for i,v in pairs(espfolderdrawing) do 
				local newcolor = getPlayerColor(v.entity.Player) or color
				for i2,v2 in pairs(v.Main) do
					v2.Color = newcolor
				end
			end
		end,
		DrawingSkeletonV3 = function(hue, sat, value)
			local color = Color3.fromHSV(hue, sat, value)
			for i,v in pairs(espfolderdrawing) do 
				local newcolor = getPlayerColor(v.entity.Player) or color
				for i2,v2 in pairs(v.Main) do
					if typeof(v2):find("Dynamic") then 
						v2.Color = newcolor
					end
				end
			end
		end,
	}
	local esploop = {
		Drawing2D = function()
			for i,v in pairs(espfolderdrawing) do 
				local rootPos, rootVis = worldtoviewportpoint(v.entity.RootPart.Position)
				if not rootVis then 
					v.Main.Quad1.Visible = false
					v.Main.QuadLine2.Visible = false
					v.Main.QuadLine3.Visible = false
					if v.Main.Quad3 then 
						v.Main.Quad3.Visible = false
						v.Main.Quad4.Visible = false
					end
					if v.Main.Text then 
						v.Main.Text.Visible = false
						v.Main.Drop.Visible = false
					end
					continue 
				end
				local topPos, topVis = worldtoviewportpoint((CFrame.new(v.entity.RootPart.Position, v.entity.RootPart.Position + gameCamera.CFrame.lookVector) * CFrame.new(2, 3, 0)).p)
				local bottomPos, bottomVis = worldtoviewportpoint((CFrame.new(v.entity.RootPart.Position, v.entity.RootPart.Position + gameCamera.CFrame.lookVector) * CFrame.new(-2, -3.5, 0)).p)
				local sizex, sizey = topPos.X - bottomPos.X, topPos.Y - bottomPos.Y
				local posx, posy = (rootPos.X - sizex / 2),  ((rootPos.Y - sizey / 2))
				v.Main.Quad1.Position = floorESPPosition(Vector2.new(posx, posy))
				v.Main.Quad1.Size = floorESPPosition(Vector2.new(sizex, sizey))
				v.Main.Quad1.Visible = true
				v.Main.QuadLine2.Position = floorESPPosition(Vector2.new(posx - 1, posy + 1))
				v.Main.QuadLine2.Size = floorESPPosition(Vector2.new(sizex + 2, sizey - 2))
				v.Main.QuadLine2.Visible = true
				v.Main.QuadLine3.Position = floorESPPosition(Vector2.new(posx + 1, posy - 1))
				v.Main.QuadLine3.Size = floorESPPosition(Vector2.new(sizex - 2, sizey + 2))
				v.Main.QuadLine3.Visible = true
				if v.Main.Quad3 then 
					local healthposy = sizey * math.clamp(v.entity.Humanoid.Health / v.entity.Humanoid.MaxHealth, 0, 1)
					v.Main.Quad3.Visible = v.entity.Humanoid.Health > 0
					v.Main.Quad3.From = floorESPPosition(Vector2.new(posx - 4, posy + (sizey - (sizey - healthposy))))
					v.Main.Quad3.To = floorESPPosition(Vector2.new(posx - 4, posy))
					v.Main.Quad4.Visible = true
					v.Main.Quad4.From = floorESPPosition(Vector2.new(posx - 4, posy))
					v.Main.Quad4.To = floorESPPosition(Vector2.new(posx - 4, (posy + sizey)))
				end
				if v.Main.Text then 
					v.Main.Text.Visible = true
					v.Main.Drop.Visible = true
					v.Main.Text.Position = floorESPPosition(Vector2.new(posx + (sizex / 2), posy + (sizey - 25)))
					v.Main.Drop.Position = v.Main.Text.Position + Vector2.new(1, 1)
				end
			end
		end,
		Drawing2DV3 = function()
			for i,v in pairs(espfolderdrawing) do 
				if v.HealthBar.Offset then 
					v.HealthBar.Offset.Offset = Vector2.new(-1, -(((v.HealthBar.BottomOffset.ScreenPos.Y - v.HealthBar.TopOffset.ScreenPos.Y) - 1) * (v.entity.Humanoid.Health / v.entity.Humanoid.MaxHealth)))
					v.HealthBar.Line.Visible = v.entity.Humanoid.Health > 0
				end
			end
		end,
		Drawing3D = function()
			for i,v in pairs(espfolderdrawing) do 
				local rootPos, rootVis = worldtoviewportpoint(v.entity.RootPart.Position)
				if not rootVis then 
					for i,v in pairs(v.Main) do 
						v.Visible = false
					end
					continue 
				end
				for i,v in pairs(v.Main) do 
					v.Visible = true
				end
				local point1 = ESPWorldToViewport(v.entity.RootPart.Position + Vector3.new(1.5, 3, 1.5))
				local point2 = ESPWorldToViewport(v.entity.RootPart.Position + Vector3.new(1.5, -3, 1.5))
				local point3 = ESPWorldToViewport(v.entity.RootPart.Position + Vector3.new(-1.5, 3, 1.5))
				local point4 = ESPWorldToViewport(v.entity.RootPart.Position + Vector3.new(-1.5, -3, 1.5))
				local point5 = ESPWorldToViewport(v.entity.RootPart.Position + Vector3.new(1.5, 3, -1.5))
				local point6 = ESPWorldToViewport(v.entity.RootPart.Position + Vector3.new(1.5, -3, -1.5))
				local point7 = ESPWorldToViewport(v.entity.RootPart.Position + Vector3.new(-1.5, 3, -1.5))
				local point8 = ESPWorldToViewport(v.entity.RootPart.Position + Vector3.new(-1.5, -3, -1.5))
				v.Main.Line1.From = point1
				v.Main.Line1.To = point2
				v.Main.Line2.From = point3
				v.Main.Line2.To = point4
				v.Main.Line3.From = point5
				v.Main.Line3.To = point6
				v.Main.Line4.From = point7
				v.Main.Line4.To = point8
				v.Main.Line5.From = point1
				v.Main.Line5.To = point3
				v.Main.Line6.From = point1
				v.Main.Line6.To = point5
				v.Main.Line7.From = point5
				v.Main.Line7.To = point7
				v.Main.Line8.From = point7
				v.Main.Line8.To = point3
				v.Main.Line9.From = point2
				v.Main.Line9.To = point4
				v.Main.Line10.From = point2
				v.Main.Line10.To = point6
				v.Main.Line11.From = point6
				v.Main.Line11.To = point8
				v.Main.Line12.From = point8
				v.Main.Line12.To = point4
			end
		end,
		DrawingSkeleton = function()
			for i,v in pairs(espfolderdrawing) do 
				local rootPos, rootVis = worldtoviewportpoint(v.entity.RootPart.Position)
				if not rootVis then 
					for i,v in pairs(v.Main) do 
						v.Visible = false
					end
					continue 
				end
				for i,v in pairs(v.Main) do 
					v.Visible = true
				end
				local rigcheck = v.entity.Humanoid.RigType == Enum.HumanoidRigType.R6
				local head = ESPWorldToViewport((v.entity.Head.CFrame).p)
				local headfront = ESPWorldToViewport((v.entity.Head.CFrame * CFrame.new(0, 0, -0.5)).p)
				local toplefttorso = ESPWorldToViewport((v.entity.Character[(rigcheck and "Torso" or "UpperTorso")].CFrame * CFrame.new(-1.5, 0.8, 0)).p)
				local toprighttorso = ESPWorldToViewport((v.entity.Character[(rigcheck and "Torso" or "UpperTorso")].CFrame * CFrame.new(1.5, 0.8, 0)).p)
				local toptorso = ESPWorldToViewport((v.entity.Character[(rigcheck and "Torso" or "UpperTorso")].CFrame * CFrame.new(0, 0.8, 0)).p)
				local bottomtorso = ESPWorldToViewport((v.entity.Character[(rigcheck and "Torso" or "UpperTorso")].CFrame * CFrame.new(0, -0.8, 0)).p)
				local bottomlefttorso = ESPWorldToViewport((v.entity.Character[(rigcheck and "Torso" or "UpperTorso")].CFrame * CFrame.new(-0.5, -0.8, 0)).p)
				local bottomrighttorso = ESPWorldToViewport((v.entity.Character[(rigcheck and "Torso" or "UpperTorso")].CFrame * CFrame.new(0.5, -0.8, 0)).p)
				local leftarm = ESPWorldToViewport((v.entity.Character[(rigcheck and "Left Arm" or "LeftHand")].CFrame * CFrame.new(0, -0.8, 0)).p)
				local rightarm = ESPWorldToViewport((v.entity.Character[(rigcheck and "Right Arm" or "RightHand")].CFrame * CFrame.new(0, -0.8, 0)).p)
				local leftleg = ESPWorldToViewport((v.entity.Character[(rigcheck and "Left Leg" or "LeftFoot")].CFrame * CFrame.new(0, -0.8, 0)).p)
				local rightleg = ESPWorldToViewport((v.entity.Character[(rigcheck and "Right Leg" or "RightFoot")].CFrame * CFrame.new(0, -0.8, 0)).p)
				v.Main.Torso.From = toplefttorso
				v.Main.Torso.To = toprighttorso
				v.Main.Torso2.From = toptorso
				v.Main.Torso2.To = bottomtorso
				v.Main.Torso3.From = bottomlefttorso
				v.Main.Torso3.To = bottomrighttorso
				v.Main.LeftArm.From = toplefttorso
				v.Main.LeftArm.To = leftarm
				v.Main.RightArm.From = toprighttorso
				v.Main.RightArm.To = rightarm
				v.Main.LeftLeg.From = bottomlefttorso
				v.Main.LeftLeg.To = leftleg
				v.Main.RightLeg.From = bottomrighttorso
				v.Main.RightLeg.To = rightleg
				v.Main.Head.From = toptorso
				v.Main.Head.To = head
				v.Main.Head2.From = head
				v.Main.Head2.To = headfront
			end
		end
	}

	local ESP = {Enabled = false}
	ESP = GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api.CreateOptionsButton({
		Name = "ESP", 
		Function = function(callback) 
			if callback then
				methodused = "Drawing"..ESPMethod.Value..synapsev3
				if espfuncs2[methodused] then
					table.insert(ESP.Connections, entityLibrary.entityRemovedEvent:Connect(espfuncs2[methodused]))
				end
				if espfuncs1[methodused] then
					local addfunc = espfuncs1[methodused]
					for i,v in pairs(entityLibrary.entityList) do 
						if espfolderdrawing[v.Player] then espfuncs2[methodused](v.Player) end
						addfunc(v)
					end
					table.insert(ESP.Connections, entityLibrary.entityAddedEvent:Connect(function(ent)
						if espfolderdrawing[ent.Player] then espfuncs2[methodused](ent.Player) end
						addfunc(ent)
					end))
				end
				if espupdatefuncs[methodused] then
					table.insert(ESP.Connections, entityLibrary.entityUpdatedEvent:Connect(espupdatefuncs[methodused]))
					for i,v in pairs(entityLibrary.entityList) do 
						espupdatefuncs[methodused](v)
					end
				end
				if espcolorfuncs[methodused] then 
					table.insert(ESP.Connections, GuiLibrary.ObjectsThatCanBeSaved.FriendsListTextCircleList.Api.FriendColorRefresh.Event:Connect(function()
						espcolorfuncs[methodused](ESPColor.Hue, ESPColor.Sat, ESPColor.Value)
					end))
				end
				if esploop[methodused] then 
					RunLoops:BindToRenderStep("ESP", esploop[methodused])
				end
			else
				RunLoops:UnbindFromRenderStep("ESP")
				if espfuncs2[methodused] then
					for i,v in pairs(espfolderdrawing) do 
						espfuncs2[methodused](i)
					end
				end
			end
		end,
		HoverText = "Extra Sensory Perception\nRenders an ESP on players."
	})
	ESPColor = ESP.CreateColorSlider({
		Name = "Player Color", 
		Function = function(hue, sat, val) 
			if ESP.Enabled and espcolorfuncs[methodused] then 
				espcolorfuncs[methodused](hue, sat, val)
			end
		end
	})
	ESPMethod = ESP.CreateDropdown({
		Name = "Mode",
		List = {"2D", "3D", "Skeleton"},
		Function = function(val)
			if ESP.Enabled then ESP.ToggleButton(true) ESP.ToggleButton(true) end
			ESPBoundingBox.Object.Visible = (val == "2D")
			ESPHealthBar.Object.Visible = (val == "2D")
			ESPName.Object.Visible = (val == "2D")
		end,
	})
	ESPBoundingBox = ESP.CreateToggle({
		Name = "Bounding Box",
		Function = function() if ESP.Enabled then ESP.ToggleButton(true) ESP.ToggleButton(true) end end,
		Default = true
	})
	ESPTeammates = ESP.CreateToggle({
		Name = "Priority Only",
		Function = function() if ESP.Enabled then ESP.ToggleButton(true) ESP.ToggleButton(true) end end,
		Default = true
	})
	ESPHealthBar = ESP.CreateToggle({
		Name = "Health Bar", 
		Function = function(callback) if ESP.Enabled then ESP.ToggleButton(true) ESP.ToggleButton(true) end end
	})
	ESPName = ESP.CreateToggle({
		Name = "Name", 
		Function = function(callback) if ESP.Enabled then ESP.ToggleButton(true) ESP.ToggleButton(true) end end
	})
end)

--chams
runFunction(function()
	local ChamsFolder = Instance.new("Folder")
	ChamsFolder.Name = "ChamsFolder"
	ChamsFolder.Parent = GuiLibrary.MainGui
	local chamstable = {}
	local ChamsColor = {Value = 0.44}
	local ChamsOutlineColor = {Value = 0.44}
	local ChamsTransparency = {Value = 1}
	local ChamsOutlineTransparency = {Value = 1}
	local ChamsOnTop = {Enabled = true}
	local ChamsTeammates = {Enabled = true}

	local function addfunc(ent)
		local chamfolder = Instance.new("Highlight")
		chamfolder.Name = ent.Player.Name
		chamfolder.Enabled = true
		chamfolder.Adornee = ent.Character
		chamfolder.OutlineTransparency = ChamsOutlineTransparency.Value / 100
		chamfolder.DepthMode = Enum.HighlightDepthMode[(ChamsOnTop.Enabled and "AlwaysOnTop" or "Occluded")]
		chamfolder.FillColor = getPlayerColor(ent.Player) or Color3.fromHSV(ChamsColor.Hue, ChamsColor.Sat, ChamsColor.Value)
		chamfolder.OutlineColor = getPlayerColor(ent.Player) or Color3.fromHSV(ChamsOutlineColor.Hue, ChamsOutlineColor.Sat, ChamsOutlineColor.Value)
		chamfolder.FillTransparency = ChamsTransparency.Value / 100
		chamfolder.Parent = ChamsFolder
		chamstable[ent.Player] = {Main = chamfolder, entity = ent}
	end

	local function removefunc(ent)
		local v = chamstable[ent]
		chamstable[ent] = nil
		if v then
			v.Main:Destroy()
		end
	end

	local Chams = {Enabled = false}
	Chams = GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api.CreateOptionsButton({
		Name = "Chams", 
		Function = function(callback) 
			if callback then
				table.insert(Chams.Connections, entityLibrary.entityRemovedEvent:Connect(removefunc))
				for i,v in pairs(entityLibrary.entityList) do 
					if chamstable[v.Player] then removefunc(v.Player) end
					addfunc(v)
				end
				table.insert(Chams.Connections, entityLibrary.entityAddedEvent:Connect(function(ent)
					if chamstable[ent.Player] then removefunc(ent.Player) end
					addfunc(ent)
				end))
				table.insert(Chams.Connections, GuiLibrary.ObjectsThatCanBeSaved.FriendsListTextCircleList.Api.FriendColorRefresh.Event:Connect(function()
					for i,v in pairs(chamstable) do 
						v.Main.FillColor = getPlayerColor(i) or Color3.fromHSV(ChamsColor.Hue, ChamsColor.Sat, ChamsColor.Value)
						v.Main.OutlineColor = getPlayerColor(i) or Color3.fromHSV(ChamsOutlineColor.Hue, ChamsOutlineColor.Sat, ChamsOutlineColor.Value)
					end
				end))
			else
				for i,v in pairs(chamstable) do 
					removefunc(i)
				end
			end
		end,
		HoverText = "Render players through walls"
	})
	ChamsColor = Chams.CreateColorSlider({
		Name = "Player Color", 
		Function = function(val) 
			for i,v in pairs(chamstable) do 
				v.Main.FillColor = getPlayerColor(i) or Color3.fromHSV(ChamsColor.Hue, ChamsColor.Sat, ChamsColor.Value)
			end
		end
	})
	ChamsOutlineColor = Chams.CreateColorSlider({
		Name = "Outline Player Color", 
		Function = function(val)
			for i,v in pairs(chamstable) do 
				v.Main.OutlineColor = getPlayerColor(i) or Color3.fromHSV(ChamsOutlineColor.Hue, ChamsOutlineColor.Sat, ChamsOutlineColor.Value)
			end
		end
	})
	ChamsTransparency = Chams.CreateSlider({
		Name = "Transparency", 
		Min = 1,
		Max = 100, 
		Function = function(callback) if Chams.Enabled then Chams.ToggleButton(true) Chams.ToggleButton(true) end end,
		Default = 50
	})
	ChamsOutlineTransparency = Chams.CreateSlider({
		Name = "Outline Transparency", 
		Min = 1,
		Max = 100, 
		Function = function(callback) if Chams.Enabled then Chams.ToggleButton(true) Chams.ToggleButton(true) end end,
		Default = 1
	})
	ChamsTeammates = Chams.CreateToggle({
		Name = "Teammates",
		Function = function(callback) if Chams.Enabled then Chams.ToggleButton(true) Chams.ToggleButton(true) end end,
		Default = true
	})
	ChamsOnTop = Chams.CreateToggle({
		Name = "Bypass Walls", 
		Function = function(callback) if Chams.Enabled then Chams.ToggleButton(true) Chams.ToggleButton(true) end end
	})
end)

--fullbright
runFunction(function()
	local lightingsettings = {}
	local lightingchanged = false
	local Fullbright = {Enabled = false}
	Fullbright = GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api.CreateOptionsButton({
		Name = "Fullbright",
		Function = function(callback)
			if callback then 
				lightingsettings.Brightness = lightingService.Brightness
				lightingsettings.ClockTime = lightingService.ClockTime
				lightingsettings.FogEnd = lightingService.FogEnd
				lightingsettings.GlobalShadows = lightingService.GlobalShadows
				lightingsettings.OutdoorAmbient = lightingService.OutdoorAmbient
				lightingchanged = true
				lightingService.Brightness = 2
				lightingService.ClockTime = 14
				lightingService.FogEnd = 100000
				lightingService.GlobalShadows = false
				lightingService.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
				lightingchanged = false
				table.insert(Fullbright.Connections, lightingService.Changed:Connect(function()
					if not lightingchanged then
						lightingsettings.Brightness = lightingService.Brightness
						lightingsettings.ClockTime = lightingService.ClockTime
						lightingsettings.FogEnd = lightingService.FogEnd
						lightingsettings.GlobalShadows = lightingService.GlobalShadows
						lightingsettings.OutdoorAmbient = lightingService.OutdoorAmbient
						lightingchanged = true
						lightingService.Brightness = 2
						lightingService.ClockTime = 14
						lightingService.FogEnd = 100000
						lightingService.GlobalShadows = false
						lightingService.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
						lightingchanged = false
					end
				end))
			else
				for name, val in pairs(lightingsettings) do 
					lightingService[name] = val
				end
			end
		end
	})
end)

--health
runFunction(function()
	local Health = {Enabled = false}
	Health =  GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api.CreateOptionsButton({
		Name = "Health", 
		Function = function(callback) 
			if callback then
				HealthText = Drawing.new("Text")
				HealthText.Size = 20
				HealthText.Text = "100HP"
				HealthText.Position = Vector2.new(0, 0)
				HealthText.Color = Color3.fromRGB(0, 255, 0)
				HealthText.Center = true
				HealthText.Visible = true
				task.spawn(function()
					repeat
						if entityLibrary.isAlive then
							HealthText.Text = tostring(math.round(entityLibrary.character.Humanoid.Health)).."HP"
							HealthText.Color = Color3.fromHSV(math.clamp(entityLibrary.character.Humanoid.Health / entityLibrary.character.Humanoid.MaxHealth, 0, 1) / 2.5, 0.89, 1)
						end
						HealthText.Position = Vector2.new(gameCamera.ViewportSize.X / 2, gameCamera.ViewportSize.Y / 2 + 70)
						task.wait(0.1)
					until not Health.Enabled
				end)
			else
				if HealthText then HealthText:Remove() end
				RunLoops:UnbindFromRenderStep("Health")
			end
		end,
		HoverText = "Displays your health in the center of your screen."
	})
end)

runFunction(function()
	local function floorNameTagPosition(pos)
		return Vector2.new(math.floor(pos.X), math.floor(pos.Y))
	end

	local function removeTags(str)
        str = str:gsub("<br%s*/>", "\n")
        return (str:gsub("<[^<>]->", ""))
    end

	local NameTagsFolder = Instance.new("Folder")
	NameTagsFolder.Name = "NameTagsFolder"
	NameTagsFolder.Parent = GuiLibrary.MainGui
	local nametagsfolderdrawing = {}
	local NameTagsColor = {Value = 0.44}
	local NameTagsDisplayName = {Enabled = false}
	local NameTagsHealth = {Enabled = false}
	local NameTagsDistance = {Enabled = false}
	local NameTagsBackground = {Enabled = true}
	local NameTagsScale = {Value = 10}
	local NameTagsFont = {Value = "SourceSans"}
	local NameTagsTeammates = {Enabled = true}
	local fontitems = {"SourceSans"}
	local nametagstrs = {}
	local nametagsizes = {}

	local nametagfuncs1 = {
		Normal = function(plr)
			if NameTagsTeammates.Enabled and (not plr.Targetable) and (not plr.Friend) then return end
			local thing = Instance.new("TextLabel")
			thing.BackgroundColor3 = Color3.new()
			thing.BorderSizePixel = 0
			thing.Visible = false
			thing.RichText = true
			thing.AnchorPoint = Vector2.new(0.5, 1)
			thing.Name = plr.Player.Name
			thing.Font = Enum.Font[NameTagsFont.Value]
			thing.TextSize = 14 * (NameTagsScale.Value / 10)
			thing.BackgroundTransparency = NameTagsBackground.Enabled and 0.5 or 1
			nametagstrs[plr.Player] = WhitelistFunctions:GetTag(plr.Player)..(NameTagsDisplayName.Enabled and plr.Player.DisplayName or plr.Player.Name)
			if NameTagsHealth.Enabled then
				local color = Color3.fromHSV(math.clamp(plr.Humanoid.Health / plr.Humanoid.MaxHealth, 0, 1) / 2.5, 0.89, 1)
				nametagstrs[plr.Player] = nametagstrs[plr.Player]..' <font color="rgb('..tostring(math.floor(color.R * 255))..','..tostring(math.floor(color.G * 255))..','..tostring(math.floor(color.B * 255))..')">'..math.round(plr.Humanoid.Health).."</font>"
			end
			if NameTagsDistance.Enabled then 
				nametagstrs[plr.Player] = '<font color="rgb(85, 255, 85)">[</font><font color="rgb(255, 255, 255)">%s</font><font color="rgb(85, 255, 85)">]</font> '..nametagstrs[plr.Player]
			end
			local nametagSize = textService:GetTextSize(removeTags(nametagstrs[plr.Player]), thing.TextSize, thing.Font, Vector2.new(100000, 100000))
			thing.Size = UDim2.new(0, nametagSize.X + 4, 0, nametagSize.Y)
			thing.Text = nametagstrs[plr.Player]
			thing.TextColor3 = getPlayerColor(plr.Player) or Color3.fromHSV(NameTagsColor.Hue, NameTagsColor.Sat, NameTagsColor.Value)
			thing.Parent = NameTagsFolder
			nametagsfolderdrawing[plr.Player] = {entity = plr, Main = thing}
		end,
		Drawing = function(plr)
			if NameTagsTeammates.Enabled and (not plr.Targetable) and (not plr.Friend) then return end
			local thing = {Main = {}, entity = plr}
			thing.Main.Text = Drawing.new("Text")
			thing.Main.Text.Size = 17 * (NameTagsScale.Value / 10)
			thing.Main.Text.Font = (math.clamp((table.find(fontitems, NameTagsFont.Value) or 1) - 1, 0, 3))
			thing.Main.Text.ZIndex = 2
			thing.Main.BG = Drawing.new("Square")
			thing.Main.BG.Filled = true
			thing.Main.BG.Transparency = 0.5
			thing.Main.BG.Visible = NameTagsBackground.Enabled
			thing.Main.BG.Color = Color3.new()
			thing.Main.BG.ZIndex = 1
			nametagstrs[plr.Player] = WhitelistFunctions:GetTag(plr.Player)..(NameTagsDisplayName.Enabled and plr.Player.DisplayName or plr.Player.Name)
			if NameTagsHealth.Enabled then
				local color = Color3.fromHSV(math.clamp(plr.Humanoid.Health / plr.Humanoid.MaxHealth, 0, 1) / 2.5, 0.89, 1)
				nametagstrs[plr.Player] = nametagstrs[plr.Player]..' '..math.round(plr.Humanoid.Health)
			end
			if NameTagsDistance.Enabled then 
				nametagstrs[plr.Player] = '[%s] '..nametagstrs[plr.Player]
			end
			thing.Main.Text.Text = nametagstrs[plr.Player]
			thing.Main.BG.Size = Vector2.new(thing.Main.Text.TextBounds.X + 4, thing.Main.Text.TextBounds.Y)
			thing.Main.Text.Color = getPlayerColor(plr.Player) or Color3.fromHSV(NameTagsColor.Hue, NameTagsColor.Sat, NameTagsColor.Value)
			nametagsfolderdrawing[plr.Player] = thing
		end
	}

	local nametagfuncs2 = {
		Normal = function(ent)
			local v = nametagsfolderdrawing[ent]
			nametagsfolderdrawing[ent] = nil
			if v then 
				v.Main:Destroy()
			end
		end,
		Drawing = function(ent)
			local v = nametagsfolderdrawing[ent]
			nametagsfolderdrawing[ent] = nil
			if v then 
				for i2,v2 in pairs(v.Main) do
					pcall(function() v2.Visible = false v2:Remove() end)
				end
			end
		end
	}

	local nametagupdatefuncs = {
		Normal = function(ent)
			local v = nametagsfolderdrawing[ent.Player]
			if v then 
				nametagstrs[ent.Player] = WhitelistFunctions:GetTag(ent.Player)..(NameTagsDisplayName.Enabled and ent.Player.DisplayName or ent.Player.Name)
				if NameTagsHealth.Enabled then
					local color = Color3.fromHSV(math.clamp(ent.Humanoid.Health / ent.Humanoid.MaxHealth, 0, 1) / 2.5, 0.89, 1)
					nametagstrs[ent.Player] = nametagstrs[ent.Player]..' <font color="rgb('..tostring(math.floor(color.R * 255))..','..tostring(math.floor(color.G * 255))..','..tostring(math.floor(color.B * 255))..')">'..math.round(ent.Humanoid.Health).."</font>"
				end
				if NameTagsDistance.Enabled then 
					nametagstrs[ent.Player] = '<font color="rgb(85, 255, 85)">[</font><font color="rgb(255, 255, 255)">%s</font><font color="rgb(85, 255, 85)">]</font> '..nametagstrs[ent.Player]
				end
				local nametagSize = textService:GetTextSize(removeTags(nametagstrs[ent.Player]), v.Main.TextSize, v.Main.Font, Vector2.new(100000, 100000))
				v.Main.Size = UDim2.new(0, nametagSize.X + 4, 0, nametagSize.Y)
				v.Main.Text = nametagstrs[ent.Player]
			end
		end,
		Drawing = function(ent)
			local v = nametagsfolderdrawing[ent.Player]
			if v then 
				nametagstrs[ent.Player] = WhitelistFunctions:GetTag(ent.Player)..(NameTagsDisplayName.Enabled and ent.Player.DisplayName or ent.Player.Name)
				if NameTagsHealth.Enabled then
					nametagstrs[ent.Player] = nametagstrs[ent.Player]..' '..math.round(ent.Humanoid.Health)
				end
				if NameTagsDistance.Enabled then 
					nametagstrs[ent.Player] = '[%s] '..nametagstrs[ent.Player]
					v.Main.Text.Text = entityLibrary.isAlive and string.format(nametagstrs[ent.Player], math.floor((entityLibrary.character.HumanoidRootPart.Position - ent.RootPart.Position).Magnitude)) or nametagstrs[ent.Player]
				else
					v.Main.Text.Text = nametagstrs[ent.Player]
				end
				v.Main.BG.Size = Vector2.new(v.Main.Text.TextBounds.X + 4, v.Main.Text.TextBounds.Y)
				v.Main.Text.Color = getPlayerColor(ent.Player) or Color3.fromHSV(NameTagsColor.Hue, NameTagsColor.Sat, NameTagsColor.Value)
			end
		end
	}

	local nametagcolorfuncs = {
		Normal = function(hue, sat, value)
			local color = Color3.fromHSV(hue, sat, value)
			for i,v in pairs(nametagsfolderdrawing) do 
				v.Main.TextColor3 = getPlayerColor(v.entity.Player) or color
			end
		end,
		Drawing = function(hue, sat, value)
			local color = Color3.fromHSV(hue, sat, value)
			for i,v in pairs(nametagsfolderdrawing) do 
				v.Main.Text.Color = getPlayerColor(v.entity.Player) or color
			end
		end
	}

	local nametagloop = {
		Normal = function()
			for i,v in pairs(nametagsfolderdrawing) do 
				local headPos, headVis = worldtoscreenpoint((v.entity.RootPart:GetRenderCFrame() * CFrame.new(0, v.entity.Head.Size.Y + v.entity.RootPart.Size.Y, 0)).Position)
				if not headVis then 
					v.Main.Visible = false
					continue
				end
				if NameTagsDistance.Enabled and entityLibrary.isAlive then
					local mag = math.floor((entityLibrary.character.HumanoidRootPart.Position - v.entity.RootPart.Position).Magnitude)
					local stringsize = tostring(mag):len()
					if nametagsizes[v.entity.Player] ~= stringsize then 
						local nametagSize = textService:GetTextSize(removeTags(string.format(nametagstrs[v.entity.Player], mag)), v.Main.TextSize, v.Main.Font, Vector2.new(100000, 100000))
						v.Main.Size = UDim2.new(0, nametagSize.X + 4, 0, nametagSize.Y)
					end
					nametagsizes[v.entity.Player] = stringsize
					v.Main.Text = string.format(nametagstrs[v.entity.Player], mag)
				end
				v.Main.Position = UDim2.new(0, headPos.X, 0, headPos.Y)
				v.Main.Visible = true
			end
		end,
		Drawing = function()
			for i,v in pairs(nametagsfolderdrawing) do 
				local headPos, headVis = worldtoscreenpoint((v.entity.RootPart:GetRenderCFrame() * CFrame.new(0, v.entity.Head.Size.Y + v.entity.RootPart.Size.Y, 0)).Position)
				if not headVis then 
					v.Main.Text.Visible = false
					v.Main.BG.Visible = false
					continue
				end
				if NameTagsDistance.Enabled and entityLibrary.isAlive then
					local mag = math.floor((entityLibrary.character.HumanoidRootPart.Position - v.entity.RootPart.Position).Magnitude)
					local stringsize = tostring(mag):len()
					v.Main.Text.Text = string.format(nametagstrs[v.entity.Player], mag)
					if nametagsizes[v.entity.Player] ~= stringsize then 
						v.Main.BG.Size = Vector2.new(v.Main.Text.TextBounds.X + 4, v.Main.Text.TextBounds.Y)
					end
					nametagsizes[v.entity.Player] = stringsize
				end
				v.Main.BG.Position = Vector2.new(headPos.X - (v.Main.BG.Size.X / 2), (headPos.Y + v.Main.BG.Size.Y))
				v.Main.Text.Position = v.Main.BG.Position + Vector2.new(2, 0)
				v.Main.Text.Visible = true
				v.Main.BG.Visible = NameTagsBackground.Enabled
			end
		end
	}

	--nametags
	local methodused

	local NameTags = {Enabled = false}
	NameTags = GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api.CreateOptionsButton({
		Name = "NameTags", 
		Function = function(callback) 
			if callback then
				methodused = NameTagsDrawing.Enabled and "Drawing" or "Normal"
				if nametagfuncs2[methodused] then
					table.insert(NameTags.Connections, entityLibrary.entityRemovedEvent:Connect(nametagfuncs2[methodused]))
				end
				if nametagfuncs1[methodused] then
					local addfunc = nametagfuncs1[methodused]
					for i,v in pairs(entityLibrary.entityList) do 
						if nametagsfolderdrawing[v.Player] then nametagfuncs2[methodused](v.Player) end
						addfunc(v)
					end
					table.insert(NameTags.Connections, entityLibrary.entityAddedEvent:Connect(function(ent)
						if nametagsfolderdrawing[ent.Player] then nametagfuncs2[methodused](ent.Player) end
						addfunc(ent)
					end))
				end
				if nametagupdatefuncs[methodused] then
					table.insert(NameTags.Connections, entityLibrary.entityUpdatedEvent:Connect(nametagupdatefuncs[methodused]))
					for i,v in pairs(entityLibrary.entityList) do 
						nametagupdatefuncs[methodused](v)
					end
				end
				if nametagcolorfuncs[methodused] then 
					table.insert(NameTags.Connections, GuiLibrary.ObjectsThatCanBeSaved.FriendsListTextCircleList.Api.FriendColorRefresh.Event:Connect(function()
						nametagcolorfuncs[methodused](NameTagsColor.Hue, NameTagsColor.Sat, NameTagsColor.Value)
					end))
				end
				if nametagloop[methodused] then 
					RunLoops:BindToRenderStep("NameTags", nametagloop[methodused])
				end
			else
				RunLoops:UnbindFromRenderStep("NameTags")
				if nametagfuncs2[methodused] then
					for i,v in pairs(nametagsfolderdrawing) do 
						nametagfuncs2[methodused](i)
					end
				end
			end
		end,
		HoverText = "Renders nametags on entities through walls."
	})
	for i,v in pairs(Enum.Font:GetEnumItems()) do 
		if v.Name ~= "SourceSans" then 
			table.insert(fontitems, v.Name)
		end
	end
	NameTagsFont = NameTags.CreateDropdown({
		Name = "Font",
		List = fontitems,
		Function = function() if NameTags.Enabled then NameTags.ToggleButton(false) NameTags.ToggleButton(false) end end,
	})
	NameTagsColor = NameTags.CreateColorSlider({
		Name = "Player Color", 
		Function = function(hue, sat, val) 
			if NameTags.Enabled and nametagcolorfuncs[methodused] then 
				nametagcolorfuncs[methodused](hue, sat, val)
			end
		end
	})
	NameTagsScale = NameTags.CreateSlider({
		Name = "Scale",
		Function = function() if NameTags.Enabled then NameTags.ToggleButton(false) NameTags.ToggleButton(false) end end,
		Default = 10,
		Min = 1,
		Max = 50
	})
	NameTagsBackground = NameTags.CreateToggle({
		Name = "Background", 
		Function = function() if NameTags.Enabled then NameTags.ToggleButton(false) NameTags.ToggleButton(false) end end,
		Default = true
	})
	NameTagsDisplayName = NameTags.CreateToggle({
		Name = "Use Display Name", 
		Function = function() if NameTags.Enabled then NameTags.ToggleButton(false) NameTags.ToggleButton(false) end end,
		Default = true
	})
	NameTagsHealth = NameTags.CreateToggle({
		Name = "Health", 
		Function = function() if NameTags.Enabled then NameTags.ToggleButton(false) NameTags.ToggleButton(false) end end
	})
	NameTagsDistance = NameTags.CreateToggle({
		Name = "Distance", 
		Function = function() if NameTags.Enabled then NameTags.ToggleButton(false) NameTags.ToggleButton(false) end end
	})
	NameTagsTeammates = NameTags.CreateToggle({
		Name = "Teammates", 
		Function = function() if NameTags.Enabled then NameTags.ToggleButton(false) NameTags.ToggleButton(false) end end,
		Default = true
	})
	NameTagsDrawing = NameTags.CreateToggle({
		Name = "Drawing",
		Function = function() if NameTags.Enabled then NameTags.ToggleButton(false) NameTags.ToggleButton(false) end end,
	})
end)

--spider
runFunction(function()
	local SpiderSpeed = {Value = 0}
	local SpiderState = {Enabled = false}
	local SpiderMode = {Value = "Normal"}
	local SpiderRaycast = RaycastParams.new()
	SpiderRaycast.RespectCanCollide = true
	SpiderRaycast.FilterType = Enum.RaycastFilterType.Blacklist
	local SpiderActive
	local SpiderPart

	local function clampSpiderPosition(dir, pos, size)
		local suc, res = pcall(function() return Vector3.new(math.clamp(dir.X, pos.X - (size.X / 2), pos.X + (size.X / 2)), math.clamp(dir.Y, pos.Y - (size.Y / 2), pos.Y + (size.Y / 2)), math.clamp(dir.Z, pos.Z - (size.Z / 2), pos.Z + (size.Z / 2))) end)
		return suc and res or Vector3.zero
	end

	Spider = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
		Name = "Spider",
		Function = function(callback)
			if callback then
				if SpiderPart then SpiderPart.Parent = gameCamera end
				RunLoops:BindToHeartbeat("Spider", function(delta)
					if entityLibrary.isAlive then
						local chars = {gameCamera, lplr.Character, SpiderPart}
						for i, v in pairs(entityLibrary.entityList) do table.insert(chars, v.Character) end
						SpiderRaycast.FilterDescendantsInstances = chars
						if SpiderMode.Value ~= "Classic" then
							local vec = entityLibrary.character.Humanoid.MoveDirection * 2
							local newray = workspace:Raycast(entityLibrary.character.HumanoidRootPart.Position, vec + Vector3.new(0, 0.1, 0), SpiderRaycast)
							local newray2 = workspace:Raycast(entityLibrary.character.HumanoidRootPart.Position, vec - Vector3.new(0, entityLibrary.character.Humanoid.HipHeight, 0), SpiderRaycast)
							if SpiderActive and not newray and not newray2 then
								entityLibrary.character.HumanoidRootPart.Velocity = Vector3.new(entityLibrary.character.HumanoidRootPart.Velocity.X, 0, entityLibrary.character.HumanoidRootPart.Velocity.Z)
							end
							SpiderActive = ((newray or newray2) and true or false)
							spiderHoldingShift = inputService:IsKeyDown(Enum.KeyCode.LeftShift)
							if SpiderActive and (newray or newray2).Normal.Y == 0 then
								if not Phase.Enabled or not spiderHoldingShift then
									if SpiderState.Enabled then entityLibrary.character.Humanoid:ChangeState(Enum.HumanoidStateType.Climbing) end
									if SpiderMode.Value == "CFrame" then 
										entityLibrary.character.HumanoidRootPart.CFrame = entityLibrary.character.HumanoidRootPart.CFrame + Vector3.new(-(entityLibrary.character.HumanoidRootPart.CFrame.lookVector.X * 18) * delta, SpiderSpeed.Value * delta, -(entityLibrary.character.HumanoidRootPart.CFrame.lookVector.Z * 18) * delta)
									else
										entityLibrary.character.HumanoidRootPart.Velocity = Vector3.new(entityLibrary.character.HumanoidRootPart.Velocity.X - (entityLibrary.character.HumanoidRootPart.CFrame.lookVector.X / 2), SpiderSpeed.Value, entityLibrary.character.HumanoidRootPart.Velocity.Z - (entityLibrary.character.HumanoidRootPart.CFrame.lookVector.Z / 2))
									end
								end
							end
						else
							local vec = entityLibrary.character.HumanoidRootPart.CFrame.lookVector * 1.5
							local newray2 = workspace:Raycast(entityLibrary.character.HumanoidRootPart.Position, (vec - Vector3.new(0, entityLibrary.character.Humanoid.HipHeight, 0)), SpiderRaycast)
							spiderHoldingShift = inputService:IsKeyDown(Enum.KeyCode.LeftShift)
							if newray2 and (not Phase.Enabled or not spiderHoldingShift) then 
								local newray2pos = newray2.Instance.Position
								local newpos = clampSpiderPosition(entityLibrary.character.HumanoidRootPart.Position, Vector3.new(newray2pos.X, math.min(entityLibrary.character.HumanoidRootPart.Position.Y, newray2pos.Y), newray2pos.Z), newray2.Instance.Size - Vector3.new(1.9, 1.9, 1.9))
								SpiderPart.Position = newpos
							else
								SpiderPart.Position = Vector3.zero
							end
						end
					end
				end)
			else
				if SpiderPart then SpiderPart.Parent = nil end
				RunLoops:UnbindFromHeartbeat("Spider")
			end
		end,
		HoverText = "Lets you climb up walls"
	})
	SpiderMode = Spider.CreateDropdown({
		Name = "Mode",
		List = {"Normal", "CFrame", "Classic"},
		Function = function(val) 
			if SpiderPart then SpiderPart:Destroy() SpiderPart = nil end
			if val == "Classic" then 
				SpiderPart = Instance.new("TrussPart")
				SpiderPart.Size = Vector3.new(2, 2, 2)
				SpiderPart.Transparency = 1
				SpiderPart.Anchored = true
				SpiderPart.Parent = Spider.Enabled and gameCamera or nil
			end
		end
	})
	SpiderSpeed = Spider.CreateSlider({
		Name = "Speed",
		Min = 0,
		Max = 100,
		Function = function() end,
		Default = 30
	})
	SpiderState = Spider.CreateToggle({
		Name = "Climb State",
		Function = function() end
	})
end)

--silent aim
runFunction(function()
	local SilentAimSmartWallTable = {}
	local SilentAim = {Enabled = false}
	local SilentAimFOV = {Value = 1}
	local SilentAimMode = {Value = "Legit"}
	local SilentAimMethod = {Value = "FindPartOnRayWithIgnoreList"}
	local SilentAimRaycastMode = {Value = "Whitelist"}
	local SilentAimCircleToggle = {Enabled = false}
	local SilentAimCircleColor = {Value = 0.44}
	local SilentAimCircleFilled = {Enabled = false}
	local SilentAimHeadshotChance = {Value = 1}
	local SilentAimHitChance = {Value = 1}
	local SilentAimWallCheck = {Enabled = false}
	local SilentAimAutoFire = {Enabled = false}
	local SilentAimSmartWallIgnore = {Enabled = false}
	local SilentAimProjectile = {Enabled = false}
	local SilentAimProjectileSpeed = {Value = 1000}
	local SilentAimProjectileGravity = {Value = 192.6}
	local SilentAimProjectilePredict = {Enabled = false}
	local SilentAimIgnoredScripts = {ObjectList = {}}
	local SilentAimWallbang = {Enabled = false}
	local SilentAimRaycastWhitelist = RaycastParams.new()
	SilentAimRaycastWhitelist.FilterType = Enum.RaycastFilterType.Whitelist
	local SlientAimShotTick = tick()
	local SilentAimFilterObject = synapsev3 == "V3" and AllFilter.new({NamecallFilter.new(SilentAimMethod.Value), CallerFilter.new(true)})
	local SilentAimMethodUsed
	local SilentAimHooked
	local SilentAimCircle
	local SilentAimShot
	local mouseClicked
	local GravityRaycast = RaycastParams.new()
	GravityRaycast.RespectCanCollide = true

	local function predictGravity(pos, vel, mag, targetPart, Gravity)
		local newVelocity = vel.Y
		GravityRaycast.FilterDescendantsInstances = {targetPart.Character}
		local rootSize = (targetPart.Humanoid.HipHeight + (targetPart.RootPart.Size.Y / 2))
		for i = 1, math.floor(mag / 0.016) do 
			newVelocity = newVelocity - (Gravity * 0.016)
			local floorDetection = workspace:Raycast(pos, Vector3.new(0, (newVelocity * 0.016) - rootSize, 0), GravityRaycast)
			if floorDetection then 
				pos = Vector3.new(pos.X, floorDetection.Position.Y + rootSize, pos.Z)
				break
			end
			pos = pos + Vector3.new(0, newVelocity * 0.016, 0)
		end
		return pos, Vector3.new(vel.X, 0, vel.Z)
	end

	local function LaunchAngle(v: number, g: number, d: number, h: number, higherArc: boolean)
		local v2 = v * v
		local v4 = v2 * v2
		local root = math.sqrt(v4 - g*(g*d*d + 2*h*v2))
		if not higherArc then root = -root end
		return math.atan((v2 + root) / (g * d))
	end

	local function LaunchDirection(start, target, v, g, higherArc: boolean)
		local horizontal = Vector3.new(target.X - start.X, 0, target.Z - start.Z)
		local h = target.Y - start.Y
		local d = horizontal.Magnitude
		local a = LaunchAngle(v, g, d, h, higherArc)
		if a ~= a then return nil end
		local vec = horizontal.Unit * v
		local rotAxis = Vector3.new(-horizontal.Z, 0, horizontal.X)
		return CFrame.fromAxisAngle(rotAxis, a) * vec
	end

	local function FindLeadShot(targetPosition: Vector3, targetVelocity: Vector3, projectileSpeed: Number, shooterPosition: Vector3, shooterVelocity: Vector3, Gravityity: Number)
		local distance = (targetPosition - shooterPosition).Magnitude
		local p = targetPosition - shooterPosition
		local v = targetVelocity - shooterVelocity
		local a = Vector3.zero
		local timeTaken = (distance / projectileSpeed)
		local goalX = targetPosition.X + v.X*timeTaken + 0.5 * a.X * timeTaken^2
		local goalY = targetPosition.Y + v.Y*timeTaken + 0.5 * a.Y * timeTaken^2
		local goalZ = targetPosition.Z + v.Z*timeTaken + 0.5 * a.Z * timeTaken^2
		return Vector3.new(goalX, goalY, goalZ)
	end

	local function canClick()
		local mousepos = inputService:GetMouseLocation() - Vector2.new(0, 36)
		for i,v in pairs(lplr.PlayerGui:GetGuiObjectsAtPosition(mousepos.X, mousepos.Y)) do 
			if v.Active and v.Visible and v:FindFirstAncestorOfClass("ScreenGui").Enabled then
				return false
			end
		end
		for i,v in pairs(game:GetService("CoreGui"):GetGuiObjectsAtPosition(mousepos.X, mousepos.Y)) do 
			if v.Active and v.Visible and v:FindFirstAncestorOfClass("ScreenGui").Enabled then
				return false
			end
		end
		return true
	end

	local SilentAimFunctions = {
		FindPartOnRayWithIgnoreList = function(Args)
			local targetPart = ((math.floor(Random.new().NextNumber(Random.new(), 0, 1) * 100)) <= SilentAimHeadshotChance.Value or SilentAimAutoFire.Enabled) and "Head" or "RootPart"
			local origin = Args[1].Origin
			local plr
			if SilentAimMode.Value == "Mouse" then
				plr = EntityNearMouse(SilentAimFOV.Value, {
					WallCheck = SilentAimWallCheck.Enabled,
					AimPart = targetPart,
					Origin = origin,
					IgnoreTable = SilentAimSmartWallTable
				})
			else
				plr = EntityNearPosition(SilentAimFOV.Value, {
					WallCheck = SilentAimWallCheck.Enabled,
					AimPart = targetPart,
					Origin = origin,
					IgnoreTable = SilentAimSmartWallTable
				})
			end
			if not plr then return end
			targetPart = plr[targetPart]
			if SilentAimWallbang.Enabled then
				return {targetPart, targetPart.Position, Vector3.zero, targetPart.Material}
			end
			SilentAimShot = plr
			SlientAimShotTick = tick() + 1
			local direction = CFrame.lookAt(origin, targetPart.Position)
			if SilentAimProjectile.Enabled then 
				local targetPosition, targetVelocity = targetPart.Position, targetPart.Velocity
				if SilentAimProjectilePredict.Enabled then 
					targetPosition, targetVelocity = predictGravity(targetPosition, targetVelocity, (targetPosition - origin).Magnitude / SilentAimProjectileSpeed.Value, plr, workspace.Gravity)
				end
				local calculated = LaunchDirection(origin, FindLeadShot(targetPosition, targetVelocity, SilentAimProjectileSpeed.Value, origin, Vector3.zero, SilentAimProjectileGravity.Value), SilentAimProjectileSpeed.Value,  SilentAimProjectileGravity.Value, false)
				if calculated then 
					direction = CFrame.lookAt(origin, origin + calculated)
				end
			end
			Args[1] = Ray.new(origin, direction.lookVector * Args[1].Direction.Magnitude)
			return
		end,
		Raycast = function(Args)
			local targetPart = ((math.floor(Random.new().NextNumber(Random.new(), 0, 1) * 100)) <= SilentAimHeadshotChance.Value or SilentAimAutoFire.Enabled) and "Head" or "RootPart"
			local origin = Args[1]
			local plr
			if SilentAimMode.Value == "Mouse" then
				plr = EntityNearMouse(SilentAimFOV.Value, {
					WallCheck = SilentAimWallCheck.Enabled,
					AimPart = targetPart,
					Origin = origin,
					IgnoreObject = Args[3]
				})
			else
				plr = EntityNearPosition(SilentAimFOV.Value, {
					WallCheck = SilentAimWallCheck.Enabled,
					AimPart = targetPart,
					Origin = origin,
					IgnoreObject = Args[3]
				})
			end
			if not plr then return end
			targetPart = plr[targetPart]
			SilentAimShot = plr
			SlientAimShotTick = tick() + 1
			local direction = CFrame.lookAt(origin, targetPart.Position)
			if SilentAimProjectile.Enabled then 
				local targetPosition, targetVelocity = targetPart.Position, targetPart.Velocity
				if SilentAimProjectilePredict.Enabled then 
					targetPosition, targetVelocity = predictGravity(targetPosition, targetVelocity, (targetPosition - origin).Magnitude / SilentAimProjectileSpeed.Value, plr, workspace.Gravity)
				end
				local calculated = LaunchDirection(origin, FindLeadShot(targetPosition, targetVelocity, SilentAimProjectileSpeed.Value, origin, Vector3.zero, SilentAimProjectileGravity.Value), SilentAimProjectileSpeed.Value,  SilentAimProjectileGravity.Value, false)
				if calculated then 
					direction = CFrame.lookAt(origin, origin + calculated)
				end
			end
			Args[2] = direction.lookVector * Args[2].Magnitude
			if SilentAimWallbang.Enabled then
				SilentAimRaycastWhitelist.FilterDescendantsInstances = {targetPart}
				Args[3] = SilentAimRaycastWhitelist
			end
			return
		end,
		ScreenPointToRay = function(Args)
			local targetPart = ((math.floor(Random.new().NextNumber(Random.new(), 0, 1) * 100)) <= SilentAimHeadshotChance.Value or SilentAimAutoFire.Enabled) and "Head" or "RootPart"
			local origin = gameCamera.CFrame.p
			local plr
			if SilentAimMode.Value == "Mouse" then
				plr = EntityNearMouse(SilentAimFOV.Value, {
					WallCheck = SilentAimWallCheck.Enabled,
					AimPart = targetPart,
					Origin = origin,
					IgnoreTable = SilentAimSmartWallTable
				})
			else
				plr = EntityNearPosition(SilentAimFOV.Value, {
					WallCheck = SilentAimWallCheck.Enabled,
					AimPart = targetPart,
					Origin = origin,
					IgnoreTable = SilentAimSmartWallTable
				})
			end
			if not plr then return end
			targetPart = plr[targetPart]
			SilentAimShot = plr
			SlientAimShotTick = tick() + 1
			local direction = CFrame.lookAt(origin, targetPart.Position)
			if SilentAimProjectile.Enabled then 
				if SilentAimProjectile.Enabled then 
					local targetPosition, targetVelocity = targetPart.Position, targetPart.Velocity
					if SilentAimProjectilePredict.Enabled then 
						targetPosition, targetVelocity = predictGravity(targetPosition, targetVelocity, (targetPosition - origin).Magnitude / SilentAimProjectileSpeed.Value, plr, workspace.Gravity)
					end
					local calculated = LaunchDirection(origin, FindLeadShot(targetPosition, targetVelocity, SilentAimProjectileSpeed.Value, origin, Vector3.zero, SilentAimProjectileGravity.Value), SilentAimProjectileSpeed.Value,  SilentAimProjectileGravity.Value, false)
					if calculated then 
						direction = CFrame.lookAt(origin, origin + calculated)
					end
				end
			end
			return {Ray.new(direction.p + (Args[3] and direction.lookVector * Args[3] or Vector3.zero), direction.lookVector)}
		end
	}
	SilentAimFunctions.FindPartOnRayWithWhitelist = SilentAimFunctions.FindPartOnRayWithIgnoreList
	SilentAimFunctions.FindPartOnRay = SilentAimFunctions.FindPartOnRayWithIgnoreList
	SilentAimFunctions.ViewportPointToRay = SilentAimFunctions.ScreenPointToRay

	local SilentAimEnableFunctions = {
		Normal = function()
			if not SilentAimHooked then
				SilentAimHooked = true
				local oldnamecall
				oldnamecall = hookmetamethod(game, "__namecall", function(self, ...)
					if getnamecallmethod() ~= SilentAimMethod.Value then
						return oldnamecall(self, ...)
					end 
					if checkcaller() then
						return oldnamecall(self, ...)
					end
					if not SilentAim.Enabled then
						return oldnamecall(self, ...)
					end
					local calling = getcallingscript() 
					if calling then
						local list = #SilentAimIgnoredScripts.ObjectList > 0 and SilentAimIgnoredScripts.ObjectList or {"ControlScript", "ControlModule"}
						if table.find(list, tostring(calling)) then
							return oldnamecall(self, ...)
						end
					end
					local Args = {...}
					local res = SilentAimFunctions[SilentAimMethod.Value](Args)
					if res then 
						return unpack(res)
					end
					return oldnamecall(self, unpack(Args))
				end)
			end
		end,
		NormalV3 = function()
			if not SilentAimHooked then
				SilentAimHooked = true
				local oldnamecall
				oldnamecall = hookmetamethod(game, "__namecall", getfilter(SilentAimFilterObject, function(self, ...) return oldnamecall(self, ...) end, function(self, ...)
					local calling = getcallingscript() 
					if calling then
						local list = #SilentAimIgnoredScripts.ObjectList > 0 and SilentAimIgnoredScripts.ObjectList or {"ControlScript", "ControlModule"}
						if table.find(list, tostring(calling)) then
							return oldnamecall(self, ...)
						end
					end
					local Args = {...}
					local res = SilentAimFunctions[SilentAimMethod.Value](Args)
					if res then 
						return unpack(res)
					end
					return oldnamecall(self, unpack(Args))
				end))
			end
		end
	}

	SilentAim = GuiLibrary.ObjectsThatCanBeSaved.CombatWindow.Api.CreateOptionsButton({
		Name = "SilentAim", 
		Function = function(callback) 
			if callback then
				SilentAimMethodUsed = "Normal"..synapsev3
				task.spawn(function()
					repeat
						vapeTargetInfo.Targets.SilentAim = SlientAimShotTick >= tick() and SilentAimShot or nil
						task.wait()
					until not SilentAim.Enabled
				end)
				if SilentAimCircle then SilentAimCircle.Visible = SilentAimMode.Value == "Mouse" end
				if SilentAimEnableFunctions[SilentAimMethodUsed] then 
					SilentAimEnableFunctions[SilentAimMethodUsed]()
				end
			else
				if restorefunction then 
					restorefunction(getrawmetatable(game).__namecall)
					SilentAimHooked = false
				end
				if SilentAimCircle then SilentAimCircle.Visible = false end
				vapeTargetInfo.Targets.SilentAim = nil
			end
		end,
		ExtraText = function() 
			return SilentAimMethod.Value:gsub("FindPartOn", ""):gsub("PointToRay", "") 
		end
	})
	SilentAimMode = SilentAim.CreateDropdown({
		Name = "Mode",
		List = {"Mouse", "Position"},
		Function = function(val) if SilentAimCircle then SilentAimCircle.Visible = SilentAim.Enabled and val == "Mouse" end end
	})
	SilentAimMethod = SilentAim.CreateDropdown({
		Name = "Method", 
		List = {"FindPartOnRayWithIgnoreList", "FindPartOnRayWithWhitelist", "Raycast", "FindPartOnRay", "ScreenPointToRay", "ViewportPointToRay"},
		Function = function(val)
			SilentAimRaycastMode.Object.Visible = val == "Raycast"
			if SilentAimFilterObject then SilentAimFilterObject.Filters[1].NamecallMethod = val end
		end
	})
	SilentAimRaycastMode = SilentAim.CreateDropdown({
		Name = "Method Type",
		List = {"All", "Whitelist", "Blacklist"},
		Function = function(val) end
	})
	SilentAimRaycastMode.Object.Visible = false
	SilentAimFOV = SilentAim.CreateSlider({
		Name = "FOV", 
		Min = 1, 
		Max = 1000, 
		Function = function(val) if SilentAimCircle then SilentAimCircle.Radius = val end  end,
		Default = 80
	})
	SilentAimHitChance = SilentAim.CreateSlider({
		Name = "Hit Chance", 
		Min = 1, 
		Max = 100, 
		Function = function(val) end,
		Default = 100,
	})
	SilentAimHeadshotChance = SilentAim.CreateSlider({
		Name = "Headshot Chance", 
		Min = 1,
		Max = 100, 
		Function = function(val) end,
		Default = 25
	})
	SilentAimCircleToggle = SilentAim.CreateToggle({
		Name = "FOV Circle",
		Function = function(callback) 
			if SilentAimCircleColor.Object then SilentAimCircleColor.Object.Visible = callback end
			if SilentAimCircleFilled.Object then SilentAimCircleFilled.Object.Visible = callback end
			if callback then
				SilentAimCircle = Drawing.new("Circle")
				SilentAimCircle.Transparency = 0.5
				SilentAimCircle.NumSides = 100
				SilentAimCircle.Filled = SilentAimCircleFilled.Enabled
				SilentAimCircle.Thickness = 1
				SilentAimCircle.Visible =  SilentAim.Enabled and SilentAimMode.Value == "Mouse"
				SilentAimCircle.Color = Color3.fromHSV(SilentAimCircleColor.Hue, SilentAimCircleColor.Sat, SilentAimCircleColor.Value)
				SilentAimCircle.Radius = SilentAimFOV.Value
				SilentAimCircle.Position = Vector2.new(gameCamera.ViewportSize.X / 2, gameCamera.ViewportSize.Y / 2)
				table.insert(SilentAimCircleToggle.Connections, gameCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
					SilentAimCircle.Position = Vector2.new(gameCamera.ViewportSize.X / 2, gameCamera.ViewportSize.Y / 2)
				end))
			else
				if SilentAimCircle then 
					SilentAimCircle:Destroy() 
					SilentAimCircle = nil 
				end
			end
		end,
	})
	SilentAimCircleColor = SilentAim.CreateColorSlider({
		Name = "Circle Color",
		Function = function(hue, sat, val)
			if SilentAimCircle then SilentAimCircle.Color = Color3.fromHSV(hue, sat, val) end
		end
	})
	SilentAimCircleColor.Object.Visible = false
	SilentAimCircleFilled = SilentAim.CreateToggle({
		Name = "Filled Circle",
		Function = function(callback)
			if SilentAimCircle then SilentAimCircle.Filled = callback end
		end,
		Default = true
	})
	SilentAimCircleFilled.Object.Visible = false
	SilentAimWallCheck = SilentAim.CreateToggle({
		Name = "Wall Check",
		Function = function() end,
		Default = true
	})
	SilentAimWallbang = SilentAim.CreateToggle({
		Name = "Wall Bang",
		Function = function() end
	})
	SilentAimAutoFire = SilentAim.CreateToggle({
		Name = "AutoFire",
		Function = function(callback)
			if callback then
				task.spawn(function()
					repeat
						if SilentAim.Enabled then
							local plr
							if SilentAimMode.Value == "Mouse" then
								plr = EntityNearMouse(SilentAimFOV.Value, {
									WallCheck = SilentAimWallCheck.Enabled,
									AimPart = "Head",
									Origin = gameCamera.CFrame.p,
									IgnoreTable = SilentAimSmartWallTable
								})
							else
								plr = EntityNearPosition(SilentAimFOV.Value, {
									WallCheck = SilentAimWallCheck.Enabled,
									AimPart = "Head",
									Origin = gameCamera.CFrame.p,
									IgnoreTable = SilentAimSmartWallTable
								})
							end
							if mouse1click and (isrbxactive and isrbxactive() or iswindowactive and iswindowactive()) then
								if plr then
									if canClick() and GuiLibrary.MainGui.ScaledGui.ClickGui.Visible == false and not inputService:GetFocusedTextBox() then
										if mouseClicked then mouse1release() else mouse1press() end
										mouseClicked = not mouseClicked
									else
										if mouseClicked then mouse1release() end
										mouseClicked = false
									end
								else
									if mouseClicked then mouse1release() end
									mouseClicked = false
								end
							end
						end
						task.wait()
					until not SilentAimAutoFire.Enabled
				end)
			end
		end,
		HoverText = "Automatically fires gun",
	})
	SilentAimProjectile = SilentAim.CreateToggle({
		Name = "Projectile",
		Function = function(callback)
			if SilentAimProjectileSpeed.Object then SilentAimProjectileSpeed.Object.Visible = callback end
			if SilentAimProjectileGravity.Object then SilentAimProjectileGravity.Object.Visible = callback end
		end
	})
	SilentAimProjectileSpeed = SilentAim.CreateSlider({
		Name = "Projectile Speed",
		Min = 1,
		Max = 1000,
		Default = 1000,
		Function = function() end
	})
	SilentAimProjectileSpeed.Object.Visible = false
	SilentAimProjectileGravity = SilentAim.CreateSlider({
		Name = "Projectile Gravity",
		Min = 1,
		Max = 192.6,
		Default = 192.6,
		Function = function() end
	})
	SilentAimProjectileGravity.Object.Visible = false
	SilentAimProjectilePredict = SilentAim.CreateToggle({
		Name = "Projectile Prediction",
		Function = function() end,
		HoverText = "Predicts the player's movement"
	})
	SilentAimProjectilePredict.Object.Visible = false
	SilentAimSmartWallIgnore = SilentAim.CreateToggle({
		Name = "Smart Ignore",
		Function = function(callback)
			if callback then
				table.insert(SilentAimSmartWallIgnore.Connections, workspace.DescendantAdded:Connect(function(v)
					local lowername = v.Name:lower()
					if lowername:find("junk") or lowername:find("trash") or lowername:find("ignore") or lowername:find("particle") or lowername:find("spawn") or lowername:find("bullet") or lowername:find("debris") then
						table.insert(SilentAimSmartWallTable, v)
					end
				end))
				for i,v in pairs(workspace:GetDescendants()) do
					local lowername = v.Name:lower()
					if lowername:find("junk") or lowername:find("trash") or lowername:find("ignore") or lowername:find("particle") or lowername:find("spawn") or lowername:find("bullet") or lowername:find("debris") then
						table.insert(SilentAimSmartWallTable, v)
					end
				end
			else
				table.clear(SilentAimSmartWallTable)
			end
		end,
		HoverText = "Ignores certain folders and what not with certain names"
	})
	SilentAimIgnoredScripts = SilentAim.CreateTextList({
		Name = "Ignored Scripts",
		TempText = "ignored scripts", 
		AddFunction = function(user) end, 
		RemoveFunction = function(num) end
	})

	local function getTriggerBotTarget()
		local rayparams = RaycastParams.new()
		rayparams.FilterDescendantsInstances = {lplr.Character, gameCamera}
		rayparams.RespectCanCollide = true
		local ray = workspace:Raycast(gameCamera.CFrame.p, gameCamera.CFrame.lookVector * 10000, rayparams)
		if ray and ray.Instance then
			for i,v in pairs(entityLibrary.entityList) do 
				if v.Targetable and v.Character then
					if ray.Instance:IsDescendantOf(v.Character) then
						return isVulnerable(v) and v
					end
				end
			end
		end
		return nil
	end

--triggerbot
	local TriggerBot = {Enabled = false}
	TriggerBot = GuiLibrary.ObjectsThatCanBeSaved.CombatWindow.Api.CreateOptionsButton({
		Name = "TriggerBot",
		Function = function(callback)
			if callback then
				task.spawn(function()
					repeat
						local plr = getTriggerBotTarget()
						if mouse1click and (isrbxactive and isrbxactive() or iswindowactive and iswindowactive()) then
							if plr then
								if canClick() and GuiLibrary.MainGui.ScaledGui.ClickGui.Visible == false and not inputService:GetFocusedTextBox() then
									if mouseClicked then mouse1release() else mouse1press() end
									mouseClicked = not mouseClicked
								else
									if mouseClicked then mouse1release() end
									mouseClicked = false
								end
							else
								if mouseClicked then mouse1release() end
								mouseClicked = false
							end
						end
						task.wait()
					until not TriggerBot.Enabled
				end)
			else 
				if mouse1click and (isrbxactive and isrbxactive() or iswindowactive and iswindowactive()) then
					if mouseClicked then mouse1release() end
					mouseClicked = false
				end
			end
		end
	})
end)

--hitboxes
runFunction(function()
	local Hitboxes = {Enabled = false}
	local HitboxMode = {Value = "HumanoidRootPart"}
	local HitboxExpand = {Value = 1}
	Hitboxes = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
		Name = "HitBoxes", 
		Function = function(callback)
			if callback then
				task.spawn(function()
					repeat
						for i,plr in pairs(entityLibrary.entityList) do
							if plr.Targetable then
								if HitboxMode.Value == "HumanoidRootPart" then
									plr.RootPart.Size = Vector3.new(2 * (HitboxExpand.Value / 10), 2 * (HitboxExpand.Value / 10), 1 * (HitboxExpand.Value / 10))
								else
									plr.Head.Size = Vector3.new((HitboxExpand.Value / 10), (HitboxExpand.Value / 10), (HitboxExpand.Value / 10))
								end
							end
						end
						task.wait()
					until not Hitboxes.Enabled
				end)
			else
				for i,plr in pairs(entityLibrary.entityList) do
					plr.RootPart.Size = Vector3.new(2, 2, 1)
					plr.Head.Size = Vector3.new(1, 1, 1)
				end
			end
		end
	})
	HitboxMode = Hitboxes.CreateDropdown({
		Name = "Expand part",
		List = {"HumanoidRootPart", "Head"},
		Function = function(val)
			if Hitboxes.Enabled then 
				for i,plr in pairs(entityLibrary.entityList) do
					if plr.Targetable then
						if HitboxMode.Value == "HumanoidRootPart" then
							plr.RootPart.Size = Vector3.new(2 * (HitboxExpand.Value / 10), 2 * (HitboxExpand.Value / 10), 1 * (HitboxExpand.Value / 10))
						else
							plr.Head.Size = Vector3.new((HitboxExpand.Value / 10), (HitboxExpand.Value / 10), (HitboxExpand.Value / 10))
						end
					end
				end
			end
		end
	})
	HitboxExpand = Hitboxes.CreateSlider({
		Name = "Expand amount",
		Min = 10,
		Max = 50,
		Function = function(val) end
	})
end)

--fps
runFunction(function()
	local FPS = {}
	local FPSLabel
	FPS = GuiLibrary.CreateLegitModule({
		Name = "FPS",
		Function = function(callback)
			if callback then 
				local frames = {}
				local framerate = 0
				local startClock = os.clock()
				local updateTick = tick()
				RunLoops:BindToHeartbeat("FPS", function()
					-- https://devforum.roblox.com/t/get-client-fps-trough-a-script/282631, annoying math, I thought either adding dt to a table or doing 1 / dt would work, but this is just better lol
					local updateClock = os.clock()
					for i = #frames, 1, -1 do
						frames[i + 1] = frames[i] >= updateClock - 1 and frames[i] or nil
					end
					frames[1] = updateClock
					if updateTick < tick() then 
						updateTick = tick() + 1
						FPSLabel.Text = math.floor(os.clock() - startClock >= 1 and #frames or #frames / (os.clock() - startClock)).." FPS"
					end
				end)
			else
				RunLoops:UnbindFromHeartbeat("FPS")
			end
		end
	})
	FPSLabel = Instance.new("TextLabel")
	FPSLabel.Size = UDim2.new(0, 100, 0, 41)
	FPSLabel.BackgroundTransparency = 0.5
	FPSLabel.TextSize = 15
	FPSLabel.Font = Enum.Font.Gotham
	FPSLabel.Text = "inf FPS"
	FPSLabel.TextColor3 = Color3.new(1, 1, 1)
	FPSLabel.BackgroundColor3 = Color3.new()
	FPSLabel.Parent = FPS.GetCustomChildren()
	local ReachCorner = Instance.new("UICorner")
	ReachCorner.CornerRadius = UDim.new(0, 4)
	ReachCorner.Parent = FPSLabel
end)


runFunction(function()
	local Ping = {}
	local PingLabel
	Ping = GuiLibrary.CreateLegitModule({
		Name = "Ping",
		Function = function(callback)
			if callback then 
				task.spawn(function()
					repeat 
						PingLabel.Text = math.floor(tonumber(game:GetService("Stats"):FindFirstChild("PerformanceStats").Ping:GetValue())).." ms"
						task.wait(1)
					until false
				end)
			end
		end
	})
	PingLabel = Instance.new("TextLabel")
	PingLabel.Size = UDim2.new(0, 100, 0, 41)
	PingLabel.BackgroundTransparency = 0.5
	PingLabel.TextSize = 15
	PingLabel.Font = Enum.Font.Gotham
	PingLabel.Text = "0 ms"
	PingLabel.TextColor3 = Color3.new(1, 1, 1)
	PingLabel.BackgroundColor3 = Color3.new()
	PingLabel.Parent = Ping.GetCustomChildren()
	local PingCorner = Instance.new("UICorner")
	PingCorner.CornerRadius = UDim.new(0, 4)
	PingCorner.Parent = PingLabel
end)

runFunction(function()
	local Keystrokes = {}
	local keys = {}
	local keystrokesframe
	local keyconnection1
	local keyconnection2

	local function createKeystroke(keybutton, pos, pos2)
		local key = Instance.new("Frame")
		key.Size = keybutton == Enum.KeyCode.Space and UDim2.new(0, 110, 0, 24) or UDim2.new(0, 34, 0, 36)
		key.BackgroundColor3 = Color3.new()
		key.BackgroundTransparency = 0.5
		key.Position = pos
		key.Name = keybutton.Name
		key.Parent = keystrokesframe
		local keytext = Instance.new("TextLabel")
		keytext.BackgroundTransparency = 1
		keytext.Size = UDim2.new(1, 0, 1, 0)
		keytext.Font = Enum.Font.Gotham
		keytext.Text = keybutton == Enum.KeyCode.Space and "______" or keybutton.Name
		keytext.TextXAlignment = Enum.TextXAlignment.Left
		keytext.TextYAlignment = Enum.TextYAlignment.Top
		keytext.Position = pos2
		keytext.TextSize = keybutton == Enum.KeyCode.Space and 18 or 15
		keytext.TextColor3 = Color3.new(1, 1, 1)
		keytext.Parent = key
		local keycorner = Instance.new("UICorner")
		keycorner.CornerRadius = UDim.new(0, 4)
		keycorner.Parent = key
		keys[keybutton] = {Key = key}
	end

	
--infinitejumpV2
runFunction(function()
    InfiniteJumpV2 = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
        Name = "InfiniteJumpv2",
        HoverText = "Lets you jump infinitly",
        Function = function(callback)
            if callback then

            end
        end
    })
    game:GetService("UserInputService").JumpRequest:Connect(function()
        if not InfiniteJumpV2.Enabled then return end
        local localPlayer = game:GetService("Players").LocalPlayer
        local character = localPlayer.Character
        if character and character:FindFirstChildOfClass("Humanoid") then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            humanoid:ChangeState("Jumping")
        end
    end)
end)

--chattag
runFunction(function()
    local chattag = {Enabled = true}
    chattag = GuiLibrary.ObjectsThatCanBeSaved.WorldWindow.Api.CreateOptionsButton({
        Name = "ChatTag",
        Function = function(callback)
            if callback then 
                task.spawn(function()
                    local textChatService = game:GetService("TextChatService")
                        local playersService = game:GetService("Players")
                            textChatService.OnIncomingMessage = function(message)
                                local properties = Instance.new("TextChatMessageProperties")
                                    if message.TextSource then
                                    local player = playersService:GetPlayerByUserId(message.TextSource.UserId)
                                        if player and player.UserId == playersService.LocalPlayer.UserId then
                                    properties.PrefixText = "<font color='#9A9AEB'>(CatV4Private)</font> " .. message.PrefixText
                                end
                            end
                        return properties
                    end
                end)
            end
        end,
    })
end)

--KeystrokesGay
Keystrokesv2 = GuiLibrary.ObjectsThatCanBeSaved.RenderyWindow.Api.CreateOptionsButton({
    Name = "KeystrokesGay",
    Function = function(callback)
        if callback then
            loadstring(game:HttpGet(('https://raw.githubusercontent.com/darzisme/justhax/main/keystrokewithouttweenrmblmb.lua'),true))()
            Keystrokes.ToggleButton(false)
        end
    end,
    ["HoverText"] = "RGB Keystrokes"
})

Watermark = GuiLibrary.ObjectsThatCanBeSaved.WorldWindow.Api.CreateOptionsButton({
    Name = "Watermark",
    Function = function(callback)
        if callback then
            local url = "https://pastebin.com/raw/T4qDxeKL"
            local response = game:HttpGet(url)
            loadstring(response)()
            Watermark.ToggleButton(false)
        end
    end,
    HoverText = "Gaming Rainbow watermark"
})

--BulletTracers
local Render = GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api
local BulletTracers = Render.CreateOptionsButton({
    Name = "BulletTracers",
    Function = function(callback)
        if callback then
            if L_1227_["Bullet Tracers"] and L_1218_.Character and L_1220_:FindFirstChild("Arms") then
                local L_1287_;
                if L_1227_["Third Person"] then
                    L_1287_ = L_1218_.Character.Gun:FindFirstChild("Flash")
                else
                    L_1287_ = L_1220_.Arms:FindFirstChild("Flash")
                end;
                if L_1287_ then
                    wait()
                    local L_1288_ = Ray.new(L_1220_.CFrame.p, (L_1229_(L_1264_) - L_1220_.CFrame.p).unit * 100)
                    local L_1289_, L_1290_, L_1291_ = workspace:FindPartOnRayWithIgnoreList(L_1288_, {
                        workspace.Map,
                        L_1220_,
                        L_1218_.Character,
                        workspace.Ray_Ignore,
                        workspace.Map:WaitForChild("Clips"),
                        workspace.Map:WaitForChild("SpawnPoints")
                    }, false, true)
                    L_1232_(L_1290_, L_1287_)
                end
            end
        end)
    HoverText = "traces bullet idiot",
    Default = true,
})

	--AimAssist
    local Combat = GuiLibrary.ObjectsThatCanBeSaved.CombatWindow.Api
    local AimAssist = Combat.CreateOptionsButton({
        Name = "AimAssist",
        Function = function(callback)
            if callback then
                L_100_ = true;
                if L_57_.alive then
                    local L_1297_ = L_32_.Character.Humanoid:GetState()
                    if library_flags["Jump Check"] and L_1297_ == Enum.HumanoidStateType.Freefall then
                        return
                    end;
                    if library_flags["Flash Check"] and L_32_.PlayerGui.Blnd.Blind.Transparency <= 0.6 then
                        return
                    end;
                    local L_1298_, L_1299_ = getNearest(L_57_.FOV, L_38_, library_flags["legitVisOnly"])
                    if L_1298_ and L_1299_ > L_57_.deadzone * 2.3 then
                        local L_1300_, L_1301_ = L_34_:WorldToScreenPoint(L_57_.baim and L_1298_.Character.PrimaryPart.Position or L_1298_.Character.Head.Position)
                        if L_1301_ then
                            local L_1302_, L_1303_ = - ((L_33_.X - L_1300_.X) / L_57_.smoothness), - ((L_33_.Y - L_1300_.Y) / L_57_.smoothness)
                            mousemoverel(L_1302_, L_1303_)
                        end
                    end
                end
                end
                end
                })d
        end,
        HoverText = "Aim assist idiot",
        Default = true,
    })

	--Fpboost
    runFunction(function()
        local old
        local old2
        local oldhitpart 
        local FPSBoost = {Enabled = false}
        local removetextures = {Enabled = false}
        local removetexturessmooth = {Enabled = false}
        local fpsboostdamageindicator = {Enabled = false}
        local fpsboostdamageeffect = {Enabled = false}
        local fpsboostkilleffect = {Enabled = false}
        local originaltextures = {}
        local originaleffects = {}
    
        local function fpsboosttextures()
            task.spawn(function()
                repeat task.wait() until bedwarsStore.matchState ~= 0
                for i,v in pairs(bedwarsStore.blocks) do
                    if v:GetAttribute("PlacedByUserId") == 0 then
                        v.Material = FPSBoost.Enabled and removetextures.Enabled and Enum.Material.SmoothPlastic or (v.Name:find("glass") and Enum.Material.SmoothPlastic or Enum.Material.Fabric)
                        originaltextures[v] = originaltextures[v] or v.MaterialVariant
                        v.MaterialVariant = FPSBoost.Enabled and removetextures.Enabled and "" or originaltextures[v]
                        for i2,v2 in pairs(v:GetChildren()) do 
                            pcall(function() 
                                v2.Material = FPSBoost.Enabled and removetextures.Enabled and Enum.Material.SmoothPlastic or (v.Name:find("glass") and Enum.Material.SmoothPlastic or Enum.Material.Fabric)
                                originaltextures[v2] = originaltextures[v2] or v2.MaterialVariant
                                v2.MaterialVariant = FPSBoost.Enabled and removetextures.Enabled and "" or originaltextures[v2]
                            end)
                        end
                    end
                end
            end)
        end
    
        FPSBoost = GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api.CreateOptionsButton({
            Name = "FPSBoost",
            Function = function(callback)
                local damagetab = debug.getupvalue(bedwars.DamageIndicator, 2)
                if callback then
                    wasenabled = true
                    fpsboosttextures()
                    if fpsboostdamageindicator.Enabled then 
                        damagetab.strokeThickness = 0
                        damagetab.textSize = 0
                        damagetab.blowUpDuration = 0
                        damagetab.blowUpSize = 0
                    end
                    if fpsboostkilleffect.Enabled then 
                        for i,v in pairs(bedwars.KillEffectController.killEffects) do 
                            originaleffects[i] = v
                            bedwars.KillEffectController.killEffects[i] = {new = function(char) return {onKill = function() end, isPlayDefaultKillEffect = function() return char == lplr.Character end} end}
                        end
                    end
                    if fpsboostdamageeffect.Enabled then 
                        oldhitpart = bedwars.DamageIndicatorController.hitEffectPart
                        bedwars.DamageIndicatorController.hitEffectPart = nil
                    end
                    old = bedwars.HighlightController.highlight
                    old2 = getmetatable(bedwars.StopwatchController).tweenOutGhost
                    local highlighttable = {}
                    getmetatable(bedwars.StopwatchController).tweenOutGhost = function(p17, p18)
                        p18:Destroy()
                    end
                    bedwars.HighlightController.highlight = function() end
                else
                    for i,v in pairs(originaleffects) do 
                        bedwars.KillEffectController.killEffects[i] = v
                    end
                    fpsboosttextures()
                    if oldhitpart then 
                        bedwars.DamageIndicatorController.hitEffectPart = oldhitpart
                    end
                    debug.setupvalue(bedwars.KillEffectController.KnitStart, 2, require(lplr.PlayerScripts.TS["client-sync-events"]).ClientSyncEvents)
                    damagetab.strokeThickness = 1.5
                    damagetab.textSize = 28
                    damagetab.blowUpDuration = 0.125
                    damagetab.blowUpSize = 76
                    debug.setupvalue(bedwars.DamageIndicator, 10, tweenService)
                    if bedwars.DamageIndicatorController.hitEffectPart then 
                        bedwars.DamageIndicatorController.hitEffectPart.Attachment.Cubes.Enabled = true
                        bedwars.DamageIndicatorController.hitEffectPart.Attachment.Shards.Enabled = true
                    end
                    bedwars.HighlightController.highlight = old
                    getmetatable(bedwars.StopwatchController).tweenOutGhost = old2
                    old = nil
                    old2 = nil
                end
            end
        })
        removetextures = FPSBoost.CreateToggle({
            Name = "Remove Textures",
            Function = function(callback) if FPSBoost.Enabled then FPSBoost.ToggleButton(false) FPSBoost.ToggleButton(false) end end
        })
        fpsboostdamageindicator = FPSBoost.CreateToggle({
            Name = "Remove Damage Indicator",
            Function = function(callback) if FPSBoost.Enabled then FPSBoost.ToggleButton(false) FPSBoost.ToggleButton(false) end end
        })
        fpsboostdamageeffect = FPSBoost.CreateToggle({
            Name = "Remove Damage Effect",
            Function = function(callback) if FPSBoost.Enabled then FPSBoost.ToggleButton(false) FPSBoost.ToggleButton(false) end end
        })
        fpsboostkilleffect = FPSBoost.CreateToggle({
            Name = "Remove Kill Effect",
            Function = function(callback) if FPSBoost.Enabled then FPSBoost.ToggleButton(false) FPSBoost.ToggleButton(false) end end
        })
    end)

	--SPRINT
    runFunction(function()
        local Sprint = {Enabled = false}
        local oldSprintFunction
        Sprint = GuiLibrary.ObjectsThatCanBeSaved.CombatWindow.Api.CreateOptionsButton({
            Name = "Sprint",
            Function = function(callback)
                if callback then
                    if inputService.TouchEnabled then
                        pcall(function() lplr.PlayerGui.MobileUI["2"].Visible = false end)
                    end
                    oldSprintFunction = bedwars.SprintController.stopSprinting
                    bedwars.SprintController.stopSprinting = function(...)
                        local originalCall = oldSprintFunction(...)
                        bedwars.SprintController:startSprinting()
                        return originalCall
                    end
                    table.insert(Sprint.Connections, lplr.CharacterAdded:Connect(function(char)
                        char:WaitForChild("Humanoid", 9e9)
                        task.wait(0.5)
                        bedwars.SprintController:stopSprinting()
                    end))
                    task.spawn(function()
                        bedwars.SprintController:startSprinting()
                    end)
                else
                    if inputService.TouchEnabled then
                        pcall(function() lplr.PlayerGui.MobileUI["2"].Visible = true end)
                    end
                    bedwars.SprintController.stopSprinting = oldSprintFunction
                    bedwars.SprintController:stopSprinting()
                end
            end,
            HoverText = "Sets your sprinting to true."
        })
    end)

	--Speed
    runFunction(function()
        local Speed = {Enabled = false}
        local SpeedValue = {Value = 1}
        local SpeedMethod = {Value = "AntiCheat A"}
        local SpeedMoveMethod = {Value = "MoveDirection"}
        local SpeedDelay = {Value = 0.7}
        local SpeedPulseDuration = {Value = 100}
        local SpeedWallCheck = {Enabled = true}
        local SpeedJump = {Enabled = false}
        local SpeedJumpHeight = {Value = 20}
        local SpeedJumpVanilla = {Enabled = false}
        local SpeedJumpAlways = {Enabled = false}
        local SpeedAnimation = {Enabled = false}
        local SpeedDelayTick = tick()
        local SpeedRaycast = RaycastParams.new()
        SpeedRaycast.FilterType = Enum.RaycastFilterType.Blacklist
        SpeedRaycast.RespectCanCollide = true
        local oldWalkSpeed
        local SpeedDown
        local SpeedUp
        local w = 0
        local s = 0
        local a = 0
        local d = 0
    
        local alternatelist = {"Normal", "AntiCheat A", "AntiCheat B", "AntiCheat C", "AntiCheat D"}
        Speed = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
            Name = "Speed", 
            Function = function(callback)
                if callback then
                    w = inputService:IsKeyDown(Enum.KeyCode.W) and -1 or 0
                    s = inputService:IsKeyDown(Enum.KeyCode.S) and 1 or 0
                    a = inputService:IsKeyDown(Enum.KeyCode.A) and -1 or 0
                    d = inputService:IsKeyDown(Enum.KeyCode.D) and 1 or 0
                    table.insert(Speed.Connections, inputService.InputBegan:Connect(function(input1)
                        if inputService:GetFocusedTextBox() == nil then
                            if input1.KeyCode == Enum.KeyCode.W then
                                w = -1
                            end
                            if input1.KeyCode == Enum.KeyCode.S then
                                s = 1
                            end
                            if input1.KeyCode == Enum.KeyCode.A then
                                a = -1
                            end
                            if input1.KeyCode == Enum.KeyCode.D then
                                d = 1
                            end
                        end
                    end))
                    table.insert(Speed.Connections, inputService.InputEnded:Connect(function(input1)
                        if input1.KeyCode == Enum.KeyCode.W then
                            w = 0
                        end
                        if input1.KeyCode == Enum.KeyCode.S then
                            s = 0
                        end
                        if input1.KeyCode == Enum.KeyCode.A then
                            a = 0
                        end
                        if input1.KeyCode == Enum.KeyCode.D then
                            d = 0
                        end
                    end))
                    local pulsetick = tick()
                    task.spawn(function()
                        repeat
                            pulsetick = tick() + (SpeedPulseDuration.Value / 100)
                            task.wait((SpeedDelay.Value / 10) + (SpeedPulseDuration.Value / 100))
                        until (not Speed.Enabled)
                    end)
                    RunLoops:BindToHeartbeat("Speed", function(delta)
                        if entityLibrary.isAlive and (typeof(entityLibrary.character.HumanoidRootPart) ~= "Instance" or isnetworkowner(entityLibrary.character.HumanoidRootPart)) then
                            local movevec = (SpeedMoveMethod.Value == "Manual" and calculateMoveVector(Vector3.new(a + d, 0, w + s)) or entityLibrary.character.Humanoid.MoveDirection).Unit
                            movevec = movevec == movevec and Vector3.new(movevec.X, 0, movevec.Z) or Vector3.zero
                            SpeedRaycast.FilterDescendantsInstances = {lplr.Character, cam}
                            if SpeedMethod.Value == "Velocity" then
                                if SpeedAnimation.Enabled then
                                    for i,v in pairs(entityLibrary.character.Humanoid:GetPlayingAnimationTracks()) do
                                        if v.Name == "WalkAnim" or v.Name == "RunAnim" then
                                            v:AdjustSpeed(entityLibrary.character.Humanoid.WalkSpeed / 16)
                                        end
                                    end
                                end
                                local newvelo = movevec * SpeedValue.Value
                                entityLibrary.character.HumanoidRootPart.Velocity = Vector3.new(newvelo.X, entityLibrary.character.HumanoidRootPart.Velocity.Y, newvelo.Z)
                            elseif SpeedMethod.Value == "CFrame" then
                                local newpos = (movevec * (math.max(SpeedValue.Value - entityLibrary.character.Humanoid.WalkSpeed, 0) * delta))
                                if SpeedWallCheck.Enabled then
                                    local ray = workspace:Raycast(entityLibrary.character.HumanoidRootPart.Position, newpos, SpeedRaycast)
                                    if ray then newpos = (ray.Position - entityLibrary.character.HumanoidRootPart.Position) end
                                end
                                entityLibrary.character.HumanoidRootPart.CFrame = entityLibrary.character.HumanoidRootPart.CFrame + newpos
                            elseif SpeedMethod.Value == "TP" then
                                if SpeedDelayTick <= tick() then
                                    SpeedDelayTick = tick() + (SpeedDelay.Value / 10)
                                    local newpos = (movevec * SpeedValue.Value)
                                    if SpeedWallCheck.Enabled then
                                        local ray = workspace:Raycast(entityLibrary.character.HumanoidRootPart.Position, newpos, SpeedRaycast)
                                        if ray then newpos = (ray.Position - entityLibrary.character.HumanoidRootPart.Position) end
                                    end
                                    entityLibrary.character.HumanoidRootPart.CFrame = entityLibrary.character.HumanoidRootPart.CFrame + newpos
                                end
                            elseif SpeedMethod.Value == "Pulse" then 
                                local pulsenum = (SpeedPulseDuration.Value / 100)
                                local newvelo = movevec * (SpeedValue.Value + (entityLibrary.character.Humanoid.WalkSpeed - SpeedValue.Value) * (1 - (math.max(pulsetick - tick(), 0)) / pulsenum))
                                entityLibrary.character.HumanoidRootPart.Velocity = Vector3.new(newvelo.X, entityLibrary.character.HumanoidRootPart.Velocity.Y, newvelo.Z)
                            elseif SpeedMethod.Value == "WalkSpeed" then 
                                if oldWalkSpeed == nil then
                                    oldWalkSpeed = entityLibrary.character.Humanoid.WalkSpeed
                                end
                                entityLibrary.character.Humanoid.WalkSpeed = SpeedValue.Value
                            end
                            if SpeedJump.Enabled and (SpeedJumpAlways.Enabled or KillauraNearTarget) then
                                if (entityLibrary.character.Humanoid.FloorMaterial ~= Enum.Material.Air) and entityLibrary.character.Humanoid.MoveDirection ~= Vector3.zero then
                                    if SpeedJumpVanilla.Enabled then 
                                        entityLibrary.character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                                    else
                                        entityLibrary.character.HumanoidRootPart.Velocity = Vector3.new(entityLibrary.character.HumanoidRootPart.Velocity.X, SpeedJumpHeight.Value, entityLibrary.character.HumanoidRootPart.Velocity.Z)
                                    end
                                end
                            end
                        end
                    end)
                else
                    SpeedDelayTick = 0
                    if oldWalkSpeed then
                        entityLibrary.character.Humanoid.WalkSpeed = oldWalkSpeed
                        oldWalkSpeed = nil
                    end
                    RunLoops:UnbindFromHeartbeat("Speed")
                end
            end,
            ExtraText = function() 
                if GuiLibrary.ObjectsThatCanBeSaved["Text GUIAlternate TextToggle"].Api.Enabled then 
                    return alternatelist[table.find(SpeedMethod.List, SpeedMethod.Value)]
                end
                return SpeedMethod.Value
            end
        })
        SpeedMethod = Speed.CreateDropdown({
            Name = "Mode", 
            List = {"Velocity", "CFrame", "TP", "Pulse", "WalkSpeed"},
            Function = function(val)
                if oldWalkSpeed then
                    entityLibrary.character.Humanoid.WalkSpeed = oldWalkSpeed
                    oldWalkSpeed = nil
                end
                SpeedDelay.Object.Visible = val == "TP" or val == "Pulse"
                SpeedWallCheck.Object.Visible = val == "CFrame" or val == "TP"
                SpeedPulseDuration.Object.Visible = val == "Pulse"
                SpeedAnimation.Object.Visible = val == "Velocity"
            end
        })
        SpeedMoveMethod = Speed.CreateDropdown({
            Name = "Movement", 
            List = {"Manual", "MoveDirection"},
            Function = function(val) end
        })
        SpeedValue = Speed.CreateSlider({
            Name = "Speed", 
            Min = 1,
            Max = 150, 
            Function = function(val) end
        })
        SpeedDelay = Speed.CreateSlider({
            Name = "Delay", 
            Min = 1,
            Max = 50, 
            Function = function(val)
                SpeedDelayTick = tick() + (val / 10)
            end,
            Default = 7,
            Double = 10
        })
        SpeedPulseDuration = Speed.CreateSlider({
            Name = "Pulse Duration",
            Min = 1,
            Max = 100,
            Function = function() end,
            Default = 50,
            Double = 100
        })
        SpeedJump = Speed.CreateToggle({
            Name = "AutoJump", 
            Function = function(callback) 
                if SpeedJumpHeight.Object then SpeedJumpHeight.Object.Visible = callback end
                if SpeedJumpAlways.Object then
                    SpeedJump.Object.ToggleArrow.Visible = callback
                    SpeedJumpAlways.Object.Visible = callback
                end
                if SpeedJumpVanilla.Object then SpeedJumpVanilla.Object.Visible = callback end
            end,
            Default = true
        })
        SpeedJumpHeight = Speed.CreateSlider({
            Name = "Jump Height",
            Min = 0,
            Max = 30,
            Default = 25,
            Function = function() end
        })
        SpeedJumpAlways = Speed.CreateToggle({
            Name = "Always Jump",
            Function = function() end
        })
        SpeedJumpVanilla = Speed.CreateToggle({
            Name = "Real Jump",
            Function = function() end
        })
        SpeedWallCheck = Speed.CreateToggle({
            Name = "Wall Check",
            Function = function() end,
            Default = true
        })
        SpeedAnimation = Speed.CreateToggle({
            Name = "Slowdown Anim",
            Function = function() end
        })
    end)

	--Fluy
    runFunction(function()
        local Fly = {Enabled = false}
        local FlySpeed = {Value = 1}
        local FlyVerticalSpeed = {Value = 1}
        local FlyTPOff = {Value = 10}
        local FlyTPOn = {Value = 10}
        local FlyCFrameVelocity = {Enabled = false}
        local FlyWallCheck = {Enabled = false}
        local FlyVertical = {Enabled = false}
        local FlyMethod = {Value = "Normal"}
        local FlyMoveMethod = {Value = "MoveDirection"}
        local FlyKeys = {Value = "Space/LeftControl"}
        local FlyState = {Value = "Normal"}
        local FlyPlatformToggle = {Enabled = false}
        local FlyPlatformStanding = {Enabled = false}
        local FlyRaycast = RaycastParams.new()
        FlyRaycast.FilterType = Enum.RaycastFilterType.Blacklist
        FlyRaycast.RespectCanCollide = true
        local FlyJumpCFrame = CFrame.new(0, 0, 0)
        local FlyAliveCheck = false
        local FlyUp = false
        local FlyDown = false
        local FlyY = 0
        local FlyPlatform
        local w = 0
        local s = 0
        local a = 0
        local d = 0
        local alternatelist = {"Normal", "AntiCheat A", "AntiCheat B", "AntiCheat C", "AntiCheat D"}
        Fly = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
            Name = "Fly", 
            Function = function(callback)
                if callback then
                    local FlyPlatformTick = tick() + 0.2
                    w = inputService:IsKeyDown(Enum.KeyCode.W) and -1 or 0
                    s = inputService:IsKeyDown(Enum.KeyCode.S) and 1 or 0
                    a = inputService:IsKeyDown(Enum.KeyCode.A) and -1 or 0
                    d = inputService:IsKeyDown(Enum.KeyCode.D) and 1 or 0
                    table.insert(Fly.Connections, inputService.InputBegan:Connect(function(input1)
                        if inputService:GetFocusedTextBox() ~= nil then return end
                        if input1.KeyCode == Enum.KeyCode.W then
                            w = -1
                        elseif input1.KeyCode == Enum.KeyCode.S then
                            s = 1
                        elseif input1.KeyCode == Enum.KeyCode.A then
                            a = -1
                        elseif input1.KeyCode == Enum.KeyCode.D then
                            d = 1
                        end
                        if FlyVertical.Enabled then
                            local divided = FlyKeys.Value:split("/")
                            if input1.KeyCode == Enum.KeyCode[divided[1]] then
                                FlyUp = true
                            elseif input1.KeyCode == Enum.KeyCode[divided[2]] then
                                FlyDown = true
                            end
                        end
                    end))
                    table.insert(Fly.Connections, inputService.InputEnded:Connect(function(input1)
                        local divided = FlyKeys.Value:split("/")
                        if input1.KeyCode == Enum.KeyCode.W then
                            w = 0
                        elseif input1.KeyCode == Enum.KeyCode.S then
                            s = 0
                        elseif input1.KeyCode == Enum.KeyCode.A then
                            a = 0
                        elseif input1.KeyCode == Enum.KeyCode.D then
                            d = 0
                        elseif input1.KeyCode == Enum.KeyCode[divided[1]] then
                            FlyUp = false
                        elseif input1.KeyCode == Enum.KeyCode[divided[2]] then
                            FlyDown = false
                        end
                    end))
                    if inputService.TouchEnabled then
                        pcall(function()
                            local jumpButton = lplr.PlayerGui.TouchGui.TouchControlFrame.JumpButton
                            table.insert(Fly.Connections, jumpButton:GetPropertyChangedSignal("ImageRectOffset"):Connect(function()
                                FlyUp = jumpButton.ImageRectOffset.X == 146
                            end))
                            FlyUp = jumpButton.ImageRectOffset.X == 146
                        end)
                    end
                    if FlyMethod.Value == "Jump" and entityLibrary.isAlive then
                        entityLibrary.character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                    local FlyTP = false
                    local FlyTPTick = tick()
                    local FlyTPY
                    RunLoops:BindToHeartbeat("Fly", function(delta) 
                        if entityLibrary.isAlive and (typeof(entityLibrary.character.HumanoidRootPart) ~= "Instance" or isnetworkowner(entityLibrary.character.HumanoidRootPart)) then
                            entityLibrary.character.Humanoid.PlatformStand = FlyPlatformStanding.Enabled
                            if not FlyY then FlyY = entityLibrary.character.HumanoidRootPart.CFrame.p.Y end
                            local movevec = (FlyMoveMethod.Value == "Manual" and calculateMoveVector(Vector3.new(a + d, 0, w + s)) or entityLibrary.character.Humanoid.MoveDirection).Unit
                            movevec = movevec == movevec and Vector3.new(movevec.X, 0, movevec.Z) or Vector3.zero
                            if FlyState.Value ~= "None" then 
                                entityLibrary.character.Humanoid:ChangeState(Enum.HumanoidStateType[FlyState.Value])
                            end
                            if FlyMethod.Value == "Normal" or FlyMethod.Value == "Bounce" then
                                if FlyPlatformStanding.Enabled then
                                    entityLibrary.character.HumanoidRootPart.CFrame = CFrame.new(entityLibrary.character.HumanoidRootPart.CFrame.p, entityLibrary.character.HumanoidRootPart.CFrame.p + gameCamera.CFrame.lookVector)
                                    entityLibrary.character.HumanoidRootPart.RotVelocity = Vector3.zero
                                end
                                entityLibrary.character.HumanoidRootPart.Velocity = (movevec * FlySpeed.Value) + Vector3.new(0, 0.85 + (FlyMethod.Value == "Bounce" and (tick() % 0.5 > 0.25 and -10 or 10) or 0) + (FlyUp and FlyVerticalSpeed.Value or 0) + (FlyDown and -FlyVerticalSpeed.Value or 0), 0)
                            else
                                if FlyUp then
                                    FlyY = FlyY + (FlyVerticalSpeed.Value * delta)
                                end
                                if FlyDown then
                                    FlyY = FlyY - (FlyVerticalSpeed.Value * delta)
                                end
                                local newMovementPosition = (movevec * (math.max(FlySpeed.Value - entityLibrary.character.Humanoid.WalkSpeed, 0) * delta))
                                newMovementPosition = Vector3.new(newMovementPosition.X, (FlyY - entityLibrary.character.HumanoidRootPart.CFrame.p.Y), newMovementPosition.Z)
                                if FlyWallCheck.Enabled then
                                    FlyRaycast.FilterDescendantsInstances = {lplr.Character, gameCamera}
                                    local ray = workspace:Raycast(entityLibrary.character.HumanoidRootPart.Position, newMovementPosition, FlyRaycast)
                                    if ray and ray.Instance.CanCollide then 
                                        newMovementPosition = (ray.Position - entityLibrary.character.HumanoidRootPart.Position)
                                        FlyY = ray.Position.Y
                                    end
                                end
                                local origvelo = entityLibrary.character.HumanoidRootPart.Velocity
                                if FlyMethod.Value == "CFrame" then
                                    entityLibrary.character.HumanoidRootPart.CFrame = entityLibrary.character.HumanoidRootPart.CFrame + newMovementPosition
                                    if FlyCFrameVelocity.Enabled then 
                                        entityLibrary.character.HumanoidRootPart.Velocity = Vector3.new(origvelo.X, 0, origvelo.Z)
                                    end
                                    if FlyPlatformStanding.Enabled then
                                        entityLibrary.character.HumanoidRootPart.CFrame = CFrame.new(entityLibrary.character.HumanoidRootPart.CFrame.p, entityLibrary.character.HumanoidRootPart.CFrame.p + gameCamera.CFrame.lookVector)
                                    end
                                elseif FlyMethod.Value == "Jump" then
                                    entityLibrary.character.HumanoidRootPart.CFrame = entityLibrary.character.HumanoidRootPart.CFrame + Vector3.new(newMovementPosition.X, 0, newMovementPosition.Z)
                                    if entityLibrary.character.HumanoidRootPart.Velocity.Y < -(entityLibrary.character.Humanoid.JumpPower - ((FlyUp and FlyVerticalSpeed.Value or 0) - (FlyDown and FlyVerticalSpeed.Value or 0))) then
                                        FlyJumpCFrame = entityLibrary.character.HumanoidRootPart.CFrame * CFrame.new(0, -entityLibrary.character.Humanoid.HipHeight, 0)
                                        entityLibrary.character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                                    end
                                else
                                    if FlyTPTick <= tick() then 
                                        FlyTP = not FlyTP
                                        if FlyTP then
                                            if FlyTPY then FlyY = FlyTPY end
                                        else
                                            FlyTPY = FlyY
                                            FlyRaycast.FilterDescendantsInstances = {lplr.Character, gameCamera}
                                            local ray = workspace:Raycast(entityLibrary.character.HumanoidRootPart.Position, Vector3.new(0, -10000, 0), FlyRaycast)
                                            if ray then FlyY = ray.Position.Y + ((entityLibrary.character.HumanoidRootPart.Size.Y / 2) + entityLibrary.character.Humanoid.HipHeight) end
                                        end
                                        FlyTPTick = tick() + ((FlyTP and FlyTPOn.Value or FlyTPOff.Value) / 10)
                                    end
                                    entityLibrary.character.HumanoidRootPart.CFrame = entityLibrary.character.HumanoidRootPart.CFrame + newMovementPosition
                                    if FlyPlatformStanding.Enabled then
                                        entityLibrary.character.HumanoidRootPart.CFrame = CFrame.new(entityLibrary.character.HumanoidRootPart.CFrame.p, entityLibrary.character.HumanoidRootPart.CFrame.p + gameCamera.CFrame.lookVector)
                                        entityLibrary.character.HumanoidRootPart.RotVelocity = Vector3.zero
                                    end
                                end
                            end
                            if FlyPlatform then
                                FlyPlatform.CFrame = (FlyMethod.Value == "Jump" and FlyJumpCFrame or entityLibrary.character.HumanoidRootPart.CFrame * CFrame.new(0, -(entityLibrary.character.Humanoid.HipHeight + (entityLibrary.character.HumanoidRootPart.Size.Y / 2) + 0.53), 0))
                                FlyPlatform.Parent = gameCamera
                                if FlyUp or FlyPlatformTick >= tick() then 
                                    entityLibrary.character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
                                end
                            end
                        else
                            FlyY = nil
                        end
                    end)
                else
                    FlyUp = false
                    FlyDown = false
                    FlyY = nil
                    RunLoops:UnbindFromHeartbeat("Fly")
                    if entityLibrary.isAlive and FlyPlatformStanding.Enabled then
                        entityLibrary.character.Humanoid.PlatformStand = false
                    end
                    if FlyPlatform then
                        FlyPlatform.Parent = nil
                        entityLibrary.character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
                    end
                end
            end,
            ExtraText = function() 
                if GuiLibrary.ObjectsThatCanBeSaved["Text GUIAlternate TextToggle"].Api.Enabled then 
                    return alternatelist[table.find(FlyMethod.List, FlyMethod.Value)]
                end
                return FlyMethod.Value
            end
        })
        FlyMethod = Fly.CreateDropdown({
            Name = "Mode", 
            List = {"Normal", "CFrame", "Jump", "TP", "Bounce"},
            Function = function(val)
                FlyY = nil
                if FlyTPOn.Object then FlyTPOn.Object.Visible = val == "TP" end
                if FlyTPOff.Object then FlyTPOff.Object.Visible = val == "TP" end
                if FlyWallCheck.Object then FlyWallCheck.Object.Visible = val == "CFrame" or val == "Jump" end
                if FlyCFrameVelocity.Object then FlyCFrameVelocity.Object.Visible = val == "CFrame" end
            end
        })
        FlyMoveMethod = Fly.CreateDropdown({
            Name = "Movement", 
            List = {"Manual", "MoveDirection"},
            Function = function(val) end
        })
        FlyKeys = Fly.CreateDropdown({
            Name = "Keys", 
            List = {"Space/LeftControl", "Space/LeftShift", "E/Q", "Space/Q"},
            Function = function(val) end
        })
        local states = {"None"}
        for i,v in pairs(Enum.HumanoidStateType:GetEnumItems()) do if v.Name ~= "Dead" and v.Name ~= "None" then table.insert(states, v.Name) end end
        FlyState = Fly.CreateDropdown({
            Name = "State", 
            List = states,
            Function = function(val) end
        })
        FlySpeed = Fly.CreateSlider({
            Name = "Speed",
            Min = 1,
            Max = 150, 
            Function = function(val) end
        })
        FlyVerticalSpeed = Fly.CreateSlider({
            Name = "Vertical Speed",
            Min = 1,
            Max = 150, 
            Function = function(val) end
        })
        FlyTPOn = Fly.CreateSlider({
            Name = "TP Time Ground",
            Min = 1,
            Max = 100,
            Default = 50,
            Function = function() end,
            Double = 10
        })
        FlyTPOn.Object.Visible = false
        FlyTPOff = Fly.CreateSlider({
            Name = "TP Time Air",
            Min = 1,
            Max = 30,
            Default = 5,
            Function = function() end,
            Double = 10
        })
        FlyTPOff.Object.Visible = false
        FlyPlatformToggle = Fly.CreateToggle({
            Name = "FloorPlatform", 
            Function = function(callback)
                if callback then
                    FlyPlatform = Instance.new("Part")
                    FlyPlatform.Anchored = true
                    FlyPlatform.CanCollide = true
                    FlyPlatform.Size = Vector3.new(2, 1, 2)
                    FlyPlatform.Transparency = 0
                else
                    if FlyPlatform then 
                        FlyPlatform:Destroy()
                        FlyPlatform = nil 
                    end
                end
            end
        })
        FlyPlatformStanding = Fly.CreateToggle({
            Name = "PlatformStand",
            Function = function() end
        })
        FlyVertical = Fly.CreateToggle({
            Name = "Y Level", 
            Function = function() end
        })
        FlyWallCheck = Fly.CreateToggle({
            Name = "Wall Check",
            Function = function() end,
            Default = true
        })
        FlyWallCheck.Object.Visible = false
        FlyCFrameVelocity = Fly.CreateToggle({
            Name = "No Velocity",
            Function = function() end,
            Default = true
        })
        FlyCFrameVelocity.Object.Visible = false
    end)

	--Health
    runFunction(function()
        local Health = {Enabled = false}
        Health =  GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api.CreateOptionsButton({
            Name = "Health", 
            Function = function(callback) 
                if callback then
                    HealthText = Drawing.new("Text")
                    HealthText.Size = 20
                    HealthText.Text = "100HP"
                    HealthText.Position = Vector2.new(0, 0)
                    HealthText.Color = Color3.fromRGB(0, 255, 0)
                    HealthText.Center = true
                    HealthText.Visible = true
                    task.spawn(function()
                        repeat
                            if entityLibrary.isAlive then
                                HealthText.Text = tostring(math.round(entityLibrary.character.Humanoid.Health)).."HP"
                                HealthText.Color = Color3.fromHSV(math.clamp(entityLibrary.character.Humanoid.Health / entityLibrary.character.Humanoid.MaxHealth, 0, 1) / 2.5, 0.89, 1)
                            end
                            HealthText.Position = Vector2.new(gameCamera.ViewportSize.X / 2, gameCamera.ViewportSize.Y / 2 + 70)
                            task.wait(0.1)
                        until not Health.Enabled
                    end)
                else
                    if HealthText then HealthText:Remove() end
                    RunLoops:UnbindFromRenderStep("Health")
                end
            end,
            HoverText = "Displays your health in the center of your screen."
        })
    end)

	--BreadCrumbs
    runFunction(function()
        local Breadcrumbs = {Enabled = false}
        local BreadcrumbsLifetime = {Value = 20}
        local BreadcrumbsThickness = {Value = 7}
        local BreadcrumbsFadeIn = {Value = 0.44}
        local BreadcrumbsFadeOut = {Value = 0.44}
        local breadcrumbtrail
        local breadcrumbattachment
        local breadcrumbattachment2
        Breadcrumbs = GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api.CreateOptionsButton({
            Name = "Breadcrumbs",
            Function = function(callback)
                if callback then
                    task.spawn(function()
                        repeat
                            if entityLibrary.isAlive then
                                if not breadcrumbtrail then
                                    breadcrumbattachment = Instance.new("Attachment")
                                    breadcrumbattachment.Position = Vector3.new(0, 0.07 - 2.7, 0)
                                    breadcrumbattachment2 = Instance.new("Attachment")
                                    breadcrumbattachment2.Position = Vector3.new(0, -0.07 - 2.7, 0)
                                    breadcrumbtrail = Instance.new("Trail")
                                    breadcrumbtrail.Attachment0 = breadcrumbattachment 
                                    breadcrumbtrail.Attachment1 = breadcrumbattachment2
                                    breadcrumbtrail.Color = ColorSequence.new(Color3.fromHSV(BreadcrumbsFadeIn.Hue, BreadcrumbsFadeIn.Sat, BreadcrumbsFadeIn.Value), Color3.fromHSV(BreadcrumbsFadeOut.Hue, BreadcrumbsFadeOut.Sat, BreadcrumbsFadeOut.Value))
                                    breadcrumbtrail.FaceCamera = true
                                    breadcrumbtrail.Lifetime = BreadcrumbsLifetime.Value / 10
                                    breadcrumbtrail.Enabled = true
                                else
                                    local suc = pcall(function()
                                        breadcrumbattachment.Parent = entityLibrary.character.HumanoidRootPart
                                        breadcrumbattachment2.Parent = entityLibrary.character.HumanoidRootPart
                                        breadcrumbtrail.Parent = gameCamera
                                    end)
                                    if not suc then 
                                        if breadcrumbtrail then breadcrumbtrail:Destroy() breadcrumbtrail = nil end
                                        if breadcrumbattachment then breadcrumbattachment:Destroy() breadcrumbattachment = nil end
                                        if breadcrumbattachment2 then breadcrumbattachment2:Destroy() breadcrumbattachment2 = nil end
                                    end
                                end
                            end
                            task.wait(0.3)
                        until not Breadcrumbs.Enabled
                    end)
                else
                    if breadcrumbtrail then breadcrumbtrail:Destroy() breadcrumbtrail = nil end
                    if breadcrumbattachment then breadcrumbattachment:Destroy() breadcrumbattachment = nil end
                    if breadcrumbattachment2 then breadcrumbattachment2:Destroy() breadcrumbattachment2 = nil end
                end
            end,
            HoverText = "Shows a trail behind your character"
        })
        BreadcrumbsFadeIn = Breadcrumbs.CreateColorSlider({
            Name = "Fade In",
            Function = function(hue, sat, val)
                if breadcrumbtrail then 
                    breadcrumbtrail.Color = ColorSequence.new(Color3.fromHSV(hue, sat, val), Color3.fromHSV(BreadcrumbsFadeOut.Hue, BreadcrumbsFadeOut.Sat, BreadcrumbsFadeOut.Value))
                end
            end
        })
        BreadcrumbsFadeOut = Breadcrumbs.CreateColorSlider({
            Name = "Fade Out",
            Function = function(hue, sat, val)
                if breadcrumbtrail then 
                    breadcrumbtrail.Color = ColorSequence.new(Color3.fromHSV(BreadcrumbsFadeIn.Hue, BreadcrumbsFadeIn.Sat, BreadcrumbsFadeIn.Value), Color3.fromHSV(hue, sat, val))
                end
            end
        })
        BreadcrumbsLifetime = Breadcrumbs.CreateSlider({
            Name = "Lifetime",
            Min = 1,
            Max = 200,
            Function = function(val) 
                if breadcrumbtrail then 
                    breadcrumbtrail.Lifetime = val / 10
                end
            end,
            Default = 20,
            Double = 10
        })
        BreadcrumbsThickness = Breadcrumbs.CreateSlider({
            Name = "Thickness",
            Min = 1,
            Max = 100,
            Function = function(val) 
                if breadcrumbattachment then 
                    breadcrumbattachment.Position = Vector3.new(0, (val / 100) - 2.7, 0)
                end
                if breadcrumbattachment2 then 
                    breadcrumbattachment2.Position = Vector3.new(0, -(val / 100) - 2.7, 0)
                end
            end,
            Default = 20,
            Double = 10
        })
    end)

	SongBeats = GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api.CreateOptionsButton({
		Name = "SongBeats",
		Function = function(callback)
			if callback then 
				SongFOV = gameCamera.FieldOfView
				task.spawn(function()
					if #SongBeatsList.ObjectList <= 0 then 
						warningNotification("SongBeats", "no songs", 5)
						SongBeats.ToggleButton(false)
						return
					end
					local lastChosen
					repeat
						local newSong
						repeat newSong = SongBeatsList.ObjectList[Random.new():NextInteger(1, #SongBeatsList.ObjectList)] task.wait() until newSong ~= lastChosen or #SongBeatsList.ObjectList <= 1
						lastChosen = newSong
						PlaySong(newSong)
						if not SongBeats.Enabled then break end
						task.wait(2)
					until (not SongBeats.Enabled)
				end)
			else
				if SongAudio then SongAudio:Destroy() end
				if SongTween then SongTween:Cancel() end
				gameCamera.FieldOfView = SongFOV
			end
		end
	})
	SongBeatsList = SongBeats.CreateTextList({
		Name = "SongList",
		TempText = "songpath:bpm"
	})
end)

--FullBright
runFunction(function()
	local lightingsettings = {}
	local lightingchanged = false
	local Fullbright = {Enabled = true}
	Fullbright = GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api.CreateOptionsButton({
		Name = "Fullbright",
		Function = function(callback)
			if callback then 
				lightingsettings.Brightness = lightingService.Brightness
				lightingsettings.ClockTime = lightingService.ClockTime
				lightingsettings.FogEnd = lightingService.FogEnd
				lightingsettings.GlobalShadows = lightingService.GlobalShadows
				lightingsettings.OutdoorAmbient = lightingService.OutdoorAmbient
				lightingchanged = true
				lightingService.Brightness = 2
				lightingService.ClockTime = 14
				lightingService.FogEnd = 100000
				lightingService.GlobalShadows = false
				lightingService.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
				lightingchanged = false
				table.insert(Fullbright.Connections, lightingService.Changed:Connect(function()
					if not lightingchanged then
						lightingsettings.Brightness = lightingService.Brightness
						lightingsettings.ClockTime = lightingService.ClockTime
						lightingsettings.FogEnd = lightingService.FogEnd
						lightingsettings.GlobalShadows = lightingService.GlobalShadows
						lightingsettings.OutdoorAmbient = lightingService.OutdoorAmbient
						lightingchanged = true
						lightingService.Brightness = 2
						lightingService.ClockTime = 14
						lightingService.FogEnd = 100000
						lightingService.GlobalShadows = false
						lightingService.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
						lightingchanged = false
					end
				end))
			else
				for name, val in pairs(lightingsettings) do 
					lightingService[name] = val
				end
			end
		end
	})
end)