local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
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
	c.Parent = parent
end
local function centerFade(parent)
	local fg = Instance.new("UIGradient")
	fg.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.25, 0), NumberSequenceKeypoint.new(0.75, 0), NumberSequenceKeypoint.new(1, 1)})
	fg.Parent = parent
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
	return {set = set, get = function() return on end}
end
local function makeSubRow(parent, y, name, h)
	local sr = mk("Frame", parent)
	sr.Size = UDim2.new(1, 0, 0, h)
	sr.Position = UDim2.new(0, 0, 0, y)
	sr.BackgroundTransparency = 1
	local st = mk("TextLabel", sr)
	st.Size = UDim2.new(1, -60, 1, 0)
	st.BackgroundTransparency = 1
	st.Font = FONT
	st.TextSize = 20
	st.TextColor3 = GRAY
	st.TextXAlignment = Enum.TextXAlignment.Left
	st.Text = "    " .. name
	makeToggle(sr, UDim2.new(1, -44, 0.5, -6))
end
local function makeSlider(parent, y, initial, mn, mx)
	local c = mk("Frame", parent)
	c.Size = UDim2.new(1, 0, 0, 40)
	c.Position = UDim2.new(0, 0, 0, y)
	c.BackgroundTransparency = 1
	local track = mk("Frame", c)
	track.Size = UDim2.new(1, -80, 0, 6)
	track.Position = UDim2.new(0, 10, 0.5, -3)
	track.BackgroundColor3 = Color3.fromRGB(80, 80, 88)
	track.Active = true
	corner(track, 3)
	local fill = mk("Frame", track)
	fill.BackgroundColor3 = GREEN
	corner(fill, 3)
	local knob = mk("Frame", track)
	knob.Size = UDim2.new(0, 14, 0, 14)
	knob.BackgroundColor3 = WHITE
	knob.Active = true
	corner(knob, 7)
	local val = mk("TextLabel", c)
	val.Size = UDim2.new(0, 50, 1, 0)
	val.Position = UDim2.new(1, -60, 0, 0)
	val.BackgroundTransparency = 1
	val.Font = FONT
	val.TextSize = 20
	val.TextColor3 = GRAY
	val.TextXAlignment = Enum.TextXAlignment.Right
	local function set(v)
		v = math.clamp(math.floor(v + 0.5), mn, mx)
		local sc = (v - mn) / (mx - mn)
		fill.Size = UDim2.new(sc, 0, 1, 0)
		knob.Position = UDim2.new(sc, -7, 0.5, -7)
		val.Text = tostring(v)
	end
	set(initial)
	local dragging = false
	local function update(x)
		local ax = track.AbsolutePosition.X
		local aw = track.AbsoluteSize.X
		set(mn + math.clamp((x - ax) / aw, 0, 1) * (mx - mn))
	end
	local function beginDrag(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			update(input.Position.X)
		end
	end
	track.InputBegan:Connect(beginDrag)
	knob.InputBegan:Connect(beginDrag)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			update(input.Position.X)
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)
end
local function makeKeybind(r, tl, defaultKey, switchX, swApi)
	local kbRight = switchX - 6
	tl.Size = UDim2.new(1, kbRight - 35, 0, 50)
	local kb = mk("TextButton", r)
	kb.Size = UDim2.new(0, 25, 0, 25)
	kb.Position = UDim2.new(1, kbRight - 25, 0, 12)
	kb.BackgroundColor3 = SIDEBAR
	kb.AutoButtonColor = false
	kb.Font = FONT
	kb.TextSize = 18
	kb.TextColor3 = WHITE
	kb.Text = defaultKey
	kb.AutomaticSize = Enum.AutomaticSize.X
	corner(kb, 6)
	local pad = Instance.new("UIPadding")
	pad.PaddingLeft = UDim.new(0, 6)
	pad.PaddingRight = UDim.new(0, 6)
	pad.Parent = kb
	local listening = false
	local function anchorRight()
		kb.Position = UDim2.new(1, kbRight - kb.AbsoluteSize.X, 0, 12)
	end
	kb:GetPropertyChangedSignal("AbsoluteSize"):Connect(anchorRight)
	anchorRight()
	kb.MouseButton1Click:Connect(function()
		listening = true
		kb.Text = "..."
	end)
	local keyMode = "toggle"
	UserInputService.InputBegan:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
		if listening then
			listening = false
			kb.Text = input.KeyCode == Enum.KeyCode.Escape and "nothing" or input.KeyCode.Name
			return
		end
		local b = kb.Text
		if b == "nothing" or b == "..." then return end
		if input.KeyCode.Name ~= b then return end
		if keyMode == "toggle" then
			swApi.set(not swApi.get())
		else
			swApi.set(true)
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if keyMode ~= "hold" then return end
		if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
		local b = kb.Text
		if b == "nothing" or b == "..." then return end
		if input.KeyCode.Name == b then
			swApi.set(false)
		end
	end)
	local popup = mk("Frame", main)
	popup.Size = UDim2.new(0, 100, 0, 62)
	popup.BackgroundColor3 = SIDEBAR
	popup.Visible = false
	corner(popup, 6)
	popup.ZIndex = 51
	local veil = mk("TextButton", main)
	veil.Size = UDim2.new(1, 0, 1, 0)
	veil.BackgroundTransparency = 1
	veil.Text = ""
	veil.AutoButtonColor = false
	veil.Visible = false
	veil.ZIndex = 50
	veil.MouseButton1Click:Connect(function()
		veil.Visible = false
		popup.Visible = false
	end)
	local modeLines, modeBtns = {}, {}
	for k, m in ipairs({"hold", "toggle"}) do
		local b = mk("TextButton", popup)
		b.Size = UDim2.new(1, -12, 0, 24)
		b.Position = UDim2.new(0, 6, 0, 5 + (k - 1) * 28)
		b.BackgroundTransparency = 1
		b.AutoButtonColor = false
		b.Font = FONT
		b.TextSize = 18
		b.TextColor3 = m == "toggle" and WHITE or GRAY
		b.TextXAlignment = Enum.TextXAlignment.Left
		b.Text = "  " .. m
		b.ZIndex = 52
		local u = mk("Frame", b)
		u.Size = UDim2.new(1, 0, 0, 2)
		u.Position = UDim2.new(0, 0, 1, -2)
		u.BackgroundColor3 = GREEN
		u.Visible = m == "toggle"
		u.ZIndex = 52
		centerFade(u)
		modeLines[m] = u
		modeBtns[m] = b
		b.MouseButton1Click:Connect(function()
			keyMode = m
			for name, line in pairs(modeLines) do
				line.Visible = (name == m)
				modeBtns[name].TextColor3 = name == m and WHITE or GRAY
			end
			veil.Visible = false
			popup.Visible = false
		end)
	end
	kb.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton2 then
			local mp = main.AbsolutePosition
			local kp = kb.AbsolutePosition
			popup.Position = UDim2.new(0, kp.X - mp.X - 6 - 100, 0, kp.Y - mp.Y - 18.5)
			popup.Visible = not popup.Visible
			veil.Visible = popup.Visible
		end
	end)
end
local generalButtons = {"speed", "fly", "noclip", "door reach", "fix closet delay", "bypass", "auto breaker", "auto library lock"}
local ROW_H = 50
local expandedH = {[1] = 140, [2] = 95, [6] = 235, [8] = 95}
local bypassItems = {"dupe", "eyes", "snare", "seek fire&hands", "screech", "halt"}
local rows = {}
local rowH = {ROW_H, ROW_H, ROW_H, ROW_H, ROW_H, ROW_H, ROW_H, ROW_H}
local content = mk("ScrollingFrame", main)
content.Position = UDim2.new(0, 209, 0, 10)
content.Size = UDim2.new(1, -219, 1, -20)
content.BackgroundTransparency = 1
content.ScrollingDirection = Enum.ScrollingDirection.Y
content.ScrollBarThickness = 8
content.ScrollBarImageColor3 = SIDEBAR
local function totalH()
	local t = 0
	for _, h in ipairs(rowH) do
		t = t + h + 5
	end
	return t - 5
end
local function layout()
	local y = 0
	for j, r in ipairs(rows) do
		TweenService:Create(r, TWEEN_FAST, {Position = UDim2.new(0, 0, 0, y)}):Play()
		y = y + rowH[j] + 5
	end
	TweenService:Create(content, TWEEN_FAST, {CanvasSize = UDim2.new(0, 0, 0, y - 5)}):Play()
end
for i, name in ipairs(generalButtons) do
	local expandable = expandedH[i] ~= nil
	local isBypass = name == "bypass"
	local r = mk("Frame", content)
	r.Size = UDim2.new(1, -20, 0, ROW_H)
	r.Position = UDim2.new(0, 0, 0, (i - 1) * 55)
	r.BackgroundColor3 = ROW_BG
	r.ClipsDescendants = true
	corner(r, 6)
	local tl = mk("TextLabel", r)
	tl.Size = (expandable and not isBypass) and UDim2.new(1, -110, 0, 50) or UDim2.new(1, -60, 0, 50)
	tl.BackgroundTransparency = 1
	tl.Font = FONT
	tl.TextSize = 20
	tl.TextColor3 = GRAY
	tl.TextXAlignment = Enum.TextXAlignment.Left
	tl.Text = "    " .. name
	local swApi = isBypass and nil or makeToggle(r, expandable and UDim2.new(1, -77, 0, 19) or UDim2.new(1, -44, 0, 19))
	rows[i] = r
	if expandable then
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
	if name == "speed" then
		makeSubRow(r, 100, "no acceleration", 40)
		makeSlider(r, 55, 22, 10, 90)
	elseif name == "fly" then
		makeSlider(r, 55, 22, 10, 90)
		makeKeybind(r, tl, "F", -77, swApi)
	elseif name == "noclip" then
		makeKeybind(r, tl, "N", -44, swApi)
	elseif name == "bypass" then
		for k, item in ipairs(bypassItems) do
			makeSubRow(r, 55 + (k - 1) * 30, item, 30)
		end
	elseif name == "auto library lock" then
		makeSlider(r, 55, 11, 1, 50)
	end
end
content.CanvasSize = UDim2.new(0, 0, 0, totalH())
local icons = {"102026220307992", "97670340728331"}
local underlines = {}
local selected = 1
for i, name in ipairs({"general", "visual"}) do
	local b = mk("TextButton", side)
	b.Size = UDim2.new(1, 0, 0, 46)
	b.Position = UDim2.new(0, 0, 0, 68 + 52 * (i - 1))
	b.BackgroundColor3 = SIDEBAR
	b.AutoButtonColor = false
	b.Font = FONT
	b.TextSize = 23
	b.TextColor3 = WHITE
	b.TextXAlignment = Enum.TextXAlignment.Left
	b.Text = string.rep(" ", name == "general" and 11 or 12) .. name
	local im = mk("ImageLabel", b)
	im.Size = UDim2.new(0, 30, 0, 30)
	im.Position = UDim2.new(0, name == "general" and 6 or 10, 0.5, -11)
	im.BackgroundTransparency = 1
	im.Image = "rbxassetid://" .. icons[i]
	local u = mk("Frame", b)
	u.Size = UDim2.new(1, -20, 0, 3)
	u.Position = UDim2.new(0, 10, 1, -5)
	u.BackgroundColor3 = GREEN
	u.Visible = i == 1
	centerFade(u)
	underlines[i] = u
	b.MouseButton1Click:Connect(function()
		if i == selected then return end
		selected = i
		for _, l in ipairs(underlines) do
			l.Visible = false
		end
		for _, r in ipairs(rows) do
			r.Visible = (i == 1)
		end
		content.CanvasSize = UDim2.new(0, 0, 0, i == 1 and totalH() or 0)
		local line = underlines[i]
		line.Visible = true
		line.Size = UDim2.new(0, 0, 0, 3)
		line.Position = UDim2.new(0.5, 0, 1, -5)
		TweenService:Create(line, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(1, -20, 0, 3), Position = UDim2.new(0, 10, 1, -5)}):Play()
	end)
end
local pl = mk("TextLabel", side)
pl.Size = UDim2.new(1, 0, 0, 17)
pl.Position = UDim2.new(0, 0, 1, -20)
pl.BackgroundTransparency = 1
pl.Font = FONT
pl.TextSize = 13
pl.TextColor3 = Color3.fromRGB(130, 130, 135)
pl.TextXAlignment = Enum.TextXAlignment.Left
pl.Text = "  place: thehotel"
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
