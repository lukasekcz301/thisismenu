local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
if CoreGui:FindFirstChild("thisismenu") then
	CoreGui.thisismenu:Destroy()
end
local function mk(className, parent)
	local i = Instance.new(className)
	i.BorderSizePixel = 0
	i.Parent = parent
	return i
end
local function corner(parent, radius)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, radius)
	c.Parent = parenta
end
local GREEN = Color3.fromRGB(0, 255, 0)
local SIDEBAR = Color3.fromRGB(35, 35, 40)
local WHITE = Color3.new(1, 1, 1)
local GRAY = Color3.fromRGB(200, 200, 200)
local TOGGLE_OFF = Color3.fromRGB(180, 180, 180)
local ROW_BG = Color3.fromRGB(45, 45, 53)
local TWEEN_FAST = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TWEEN_PANEL = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local FONT = Enum.Font.SourceSans
local KNOB_OFF = UDim2.new(0, 0, 0.5, -8)
local KNOB_ON = UDim2.new(1, -16, 0.5, -8)
local gui = Instance.new("ScreenGui")
gui.Name = "thisismenu"
gui.Parent = CoreGui
local main = mk("Frame", gui)
main.Size = UDim2.new(0, 845, 0, 520)
main.Position = UDim2.new(0.5, -422, 0.5, -260)
main.BackgroundColor3 = Color3.fromRGB(48, 48, 55)
main.ClipsDescendants = true
local side = mk("Frame", main)
side.Size = UDim2.new(0, 199, 1, 0)
side.BackgroundColor3 = SIDEBAR
corner(main, 10)
corner(side, 10)
local title = mk("TextLabel", side)
title.Size = UDim2.new(1, 0, 0, 65)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.TextSize = 29
title.TextColor3 = WHITE
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = "  thisismenu"
for i, w in ipairs({92, 62}) do
	local ln = mk("Frame", side)
	ln.Size = UDim2.new(0, w, 0, 4)
	ln.Position = UDim2.new(0, 10, 0, 50 + 9 * (i - 1))
	ln.BackgroundColor3 = GREEN
	local gr = Instance.new("UIGradient")
	gr.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.7, 0), NumberSequenceKeypoint.new(1, 1)})
	gr.Parent = ln
	local tip = mk("Frame", ln)
	tip.Size = UDim2.new(0, 8, 0, 8)
	tip.Position = UDim2.new(1, -4, 0.5, -4)
	tip.Rotation = 45
	tip.BackgroundColor3 = GREEN
end
local function makeToggle(parent, position)
	local sw = mk("TextButton", parent)
	sw.Size = UDim2.new(0, 34, 0, 12)
	sw.Position = position
	sw.BackgroundColor3 = TOGGLE_OFF
	sw.Text = ""
	sw.AutoButtonColor = false
	corner(sw, 6)
	local knob = mk("Frame", sw)
	knob.Size = UDim2.new(0, 16, 0, 16)
	knob.Position = KNOB_OFF
	knob.BackgroundColor3 = WHITE
	corner(knob, 8)
	local on, cooldown = false, false
	local function set(v)
		on = v
		TweenService:Create(knob, TWEEN_FAST, {Position = on and KNOB_ON or KNOB_OFF, BackgroundColor3 = on and GREEN or WHITE}):Play()
	end
	sw.MouseButton1Click:Connect(function()
		if cooldown then return end
		cooldown = true
		set(not on)
		task.wait(0.2)
		cooldown = false
	end)
	return {set = set, get = function() return on end, btn = sw}
end
local generalButtons = {"target player", "use codes"}
local ROW_H = 50
local expandedH = {[1] = 50}
local rows = {}
local rowH = {ROW_H, ROW_H}
local content = mk("ScrollingFrame", main)
content.Position = UDim2.new(0, 209, 0, 10)
content.Size = UDim2.new(1, -219, 1, -20)
content.BackgroundTransparency = 1
content.ScrollingDirection = Enum.ScrollingDirection.Y
content.ScrollBarThickness = 8
content.ScrollBarImageColor3 = SIDEBAR
local function layout()
	local y = 0
	for j, r in ipairs(rows) do
		TweenService:Create(r, TWEEN_FAST, {Position = UDim2.new(0, 0, 0, y)}):Play()
		y = y + rowH[j] + 5
	end
	TweenService:Create(content, TWEEN_FAST, {CanvasSize = UDim2.new(0, 0, 0, y - 5)}):Play()
end
local targetApi = nil
local codesApi = nil
for i, name in ipairs(generalButtons) do
	local r = mk("Frame", content)
	r.Size = UDim2.new(1, -20, 0, ROW_H)
	r.Position = UDim2.new(0, 0, 0, (i - 1) * 55)
	r.BackgroundColor3 = ROW_BG
	r.ClipsDescendants = true
	corner(r, 6)
	local tl = mk("TextLabel", r)
	tl.Size = expandedH[i] and UDim2.new(1, -110, 0, 50) or UDim2.new(1, -60, 0, 50)
	tl.BackgroundTransparency = 1
	tl.Font = FONT
	tl.TextSize = 20
	tl.TextColor3 = GRAY
	tl.TextXAlignment = Enum.TextXAlignment.Left
	tl.Text = "    " .. name
	local api = makeToggle(r, expandedH[i] and UDim2.new(1, -77, 0, 19) or UDim2.new(1, -44, 0, 19))
	if name == "target player" then targetApi = api else codesApi = api end
	rows[i] = r
	if expandedH[i] then
		local gear = mk("ImageButton", r)
		gear.Size = UDim2.new(0, 25, 0, 25)
		gear.Position = UDim2.new(1, -35, 0, 12)
		gear.BackgroundTransparency = 1
		gear.AutoButtonColor = false
		gear.Image = "rbxassetid://130739566847600"
		local expanded, gearCooldown = false, false
		gear.MouseButton1Click:Connect(function()
			if gearCooldown then return end
			gearCooldown = true
			expanded = not expanded
			TweenService:Create(gear, TWEEN_FAST, {Rotation = expanded and 180 or 0, ImageColor3 = expanded and GREEN or WHITE}):Play()
			rowH[i] = expanded and expandedH[i] or ROW_H
			TweenService:Create(r, TWEEN_FAST, {Size = UDim2.new(1, -20, 0, rowH[i])}):Play()
			layout()
			task.wait(0.2)
			gearCooldown = false
		end)
	end
end
layout()
local codes = {"JUMP OVER THE BRICK", "PATHSWAP", "RAGDOLL COMBAT", "VOCAB HAVOC", "REPRESSED", "LAZYDEVS", "3RD", "SCREECHSUCKS", "8BITRYAN", "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "BIJUU MIKE", "DANTDM", "FIND THE TROLLFACES", "ISHOWSPEED", "KREEKRACT", "KUBZ SCOUTS", "LORE", "PENGUINZ0", "RAGDOLL MAYHEM", "RAGDOLL UNIVERSE", "THINKNOODLES", "W", "XQC", "41", "54", "67", "CHEDDAR BALLS", "/E FREE", "CRUSADERS", "L"}
task.spawn(function()
	while true do
		if codesApi.get() then
			for _, code in ipairs(codes) do
				ReplicatedStorage.RemotesFolder.ShopCode:FireServer(code)
				task.wait(6)
			end
		else
			task.wait(1)
		end
	end
end)
local elevators = workspace:WaitForChild("Lobby"):WaitForChild("LobbyElevators")
local selectedPlayer = nil
local lastElevator = nil
local playerRows = {}
local targetRow = rows[1]
local filter = ""
local function isElevatorOf(name, pl)
	local a = "PlayerElevator-" .. pl.Name
	return name == a or name:sub(1, #a + 1) == a .. "-"
end
local function elevatorOf(pl)
	for _, ch in ipairs(elevators:GetChildren()) do
		if isElevatorOf(ch.Name, pl) then
			return ch
		end
	end
	return nil
end
local function tryTeleport()
	if not targetApi.get() then return end
	if not selectedPlayer then return end
	local el = elevatorOf(selectedPlayer)
	if not el or el == lastElevator then return end
	lastElevator = el
	ReplicatedStorage.RemotesFolder.ElevatorJoin:FireServer(el)
end
local function refreshPlayers()
	if selectedPlayer and not selectedPlayer.Parent then
		selectedPlayer = nil
	end
	for _, fr in pairs(playerRows) do
		fr:Destroy()
	end
	playerRows = {}
	local list = Players:GetPlayers()
	table.sort(list, function(a, b) return a.Name:lower() < b.Name:lower() end)
	local y = 90
	for _, pl in ipairs(list) do
		if filter == "" or pl.Name:lower():find(filter:lower(), 1, true) then
			local pr = mk("TextButton", targetRow)
			pr.Size = UDim2.new(1, 0, 0, 30)
			pr.Position = UDim2.new(0, 0, 0, y)
			pr.BackgroundTransparency = 1
			pr.AutoButtonColor = false
			pr.Font = FONT
			pr.TextSize = 20
			pr.TextXAlignment = Enum.TextXAlignment.Left
			pr.Text = "    " .. pl.Name
			pr.TextColor3 = pl == selectedPlayer and GREEN or GRAY
			pr.MouseButton1Click:Connect(function()
				selectedPlayer = pl
				for _, fr in pairs(playerRows) do
					fr.TextColor3 = GRAY
				end
				pr.TextColor3 = GREEN
				lastElevator = nil
				tryTeleport()
			end)
			playerRows[pl] = pr
			y = y + 30
		end
	end
	expandedH[1] = y
	if rowH[1] ~= ROW_H then
		rowH[1] = y
		TweenService:Create(targetRow, TWEEN_FAST, {Size = UDim2.new(1, -20, 0, y)}):Play()
		layout()
	end
end
local searchBox = mk("TextBox", targetRow)
searchBox.Size = UDim2.new(1, 0, 0, 30)
searchBox.Position = UDim2.new(0, 0, 0, 55)
searchBox.BackgroundColor3 = SIDEBAR
searchBox.Font = FONT
searchBox.TextSize = 18
searchBox.TextColor3 = WHITE
searchBox.PlaceholderText = "Search"
searchBox.PlaceholderColor3 = GRAY
searchBox.Text = ""
searchBox.ClearTextOnFocus = false
searchBox.TextXAlignment = Enum.TextXAlignment.Left
corner(searchBox, 6)
local searchPad = Instance.new("UIPadding")
searchPad.PaddingLeft = UDim.new(0, 10)
searchPad.Parent = searchBox
searchBox:GetPropertyChangedSignal("Text"):Connect(function()
	filter = searchBox.Text
	refreshPlayers()
end)
refreshPlayers()
Players.PlayerAdded:Connect(refreshPlayers)
Players.PlayerRemoving:Connect(refreshPlayers)
elevators.ChildAdded:Connect(function(ch)
	if selectedPlayer and isElevatorOf(ch.Name, selectedPlayer) then
		tryTeleport()
	end
end)
targetApi.btn.MouseButton1Click:Connect(function()
	if not targetApi.get() then
		lastElevator = nil
	end
	tryTeleport()
end)
local gb = mk("TextButton", side)
gb.Size = UDim2.new(1, 0, 0, 46)
gb.Position = UDim2.new(0, 0, 0, 68)
gb.BackgroundColor3 = SIDEBAR
gb.AutoButtonColor = false
gb.Font = FONT
gb.TextSize = 23
gb.TextColor3 = WHITE
gb.TextXAlignment = Enum.TextXAlignment.Left
gb.Text = string.rep(" ", 11) .. "general"
local gim = mk("ImageLabel", gb)
gim.Size = UDim2.new(0, 30, 0, 30)
gim.Position = UDim2.new(0, 6, 0.5, -11)
gim.BackgroundTransparency = 1
gim.Image = "rbxassetid://102026220307992"
local gu = mk("Frame", gb)
gu.Size = UDim2.new(1, -20, 0, 3)
gu.Position = UDim2.new(0, 10, 1, -5)
gu.BackgroundColor3 = GREEN
local guFade = Instance.new("UIGradient")
guFade.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.25, 0), NumberSequenceKeypoint.new(0.75, 0), NumberSequenceKeypoint.new(1, 1)})
guFade.Parent = gu
local placeName = game.PlaceId == 6516141723 and "lobby" or "???"
local pl = mk("TextLabel", side)
pl.Size = UDim2.new(1, 0, 0, 17)
pl.Position = UDim2.new(0, 0, 1, -20)
pl.BackgroundTransparency = 1
pl.Font = FONT
pl.TextSize = 13
pl.TextColor3 = Color3.fromRGB(130, 130, 135)
pl.TextXAlignment = Enum.TextXAlignment.Left
pl.Text = "  place: " .. placeName
local origSize, origPos = main.Size, main.Position
local closedSize, closedPos = UDim2.new(0, 40, 0, 40), UDim2.new(0.5, -20, 0.5, -20)
local isOpen, busy = true, false
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed or input.KeyCode ~= Enum.KeyCode.RightShift or busy then return end
	busy = true
	if isOpen then
		local t = TweenService:Create(main, TWEEN_PANEL, {Size = closedSize, Position = closedPos})
		t:Play()
		t.Completed:Wait()
		main.Visible = false
		isOpen = false
	else
		main.Visible = true
		main.Size = closedSize
		main.Position = closedPos
		local t = TweenService:Create(main, TWEEN_PANEL, {Size = origSize, Position = origPos})
		t:Play()
		t.Completed:Wait()
		isOpen = true
	end
	busy = false
end)
