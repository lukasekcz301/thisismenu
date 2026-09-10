local c = game:GetService("CoreGui")
if c:FindFirstChild("thisismenu") then c.thisismenu:Destroy() end
local function mk(t,p)
local i = Instance.new(t)
i.BorderSizePixel = 0
i.Parent = p
return i
end
local g = Instance.new("ScreenGui")
g.Name = "thisismenu"
g.Parent = c
local gn,sd = Color3.fromRGB(0,255,0),Color3.fromRGB(35,35,40)
local t3 = TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
local f = mk("Frame",g)
f.Size = UDim2.new(0,845,0,520)
f.Position = UDim2.new(0.5,-422,0.5,-260)
f.BackgroundColor3 = Color3.fromRGB(48,48,55)
f.ClipsDescendants = true
local s = mk("Frame",f)
s.Size = UDim2.new(0,199,1,0)
s.BackgroundColor3 = sd
for _,p in ipairs({f,s}) do
local cn = Instance.new("UICorner")
cn.CornerRadius = UDim.new(0,10)
cn.Parent = p
end
local tt = mk("TextLabel",s)
tt.Size = UDim2.new(1,0,0,65)
tt.BackgroundTransparency = 1
tt.Font = Enum.Font.SourceSansBold
tt.TextSize = 29
tt.TextColor3 = Color3.new(1,1,1)
tt.TextXAlignment = Enum.TextXAlignment.Left
tt.Text = "  thisismenu"
for i,w in ipairs({92,62}) do
local ln = mk("Frame",s)
ln.Size = UDim2.new(0,w,0,4)
ln.Position = UDim2.new(0,10,0,50+9*(i-1))
ln.BackgroundColor3 = gn
local gr = Instance.new("UIGradient")
gr.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(0.7,0),NumberSequenceKeypoint.new(1,1)}
gr.Parent = ln
local tip = mk("Frame",ln)
tip.Size = UDim2.new(0,8,0,8)
tip.Position = UDim2.new(1,-4,0.5,-4)
tip.Rotation = 45
tip.BackgroundColor3 = gn
end
local lines = {}
local tw = game:GetService("TweenService")
local uis = game:GetService("UserInputService")
local sel = 1
local icons = {"102026220307992","97670340728331"}
local generalbuttons = {"speed","fly","noclip"}
local gicon = "130739566847600"
local grows = {}
local gh = {50,50,50}
local eh = {140,95,75}
local function mksl(p,y,init)
local c = mk("Frame",p)
c.Size = UDim2.new(1,0,0,40)
c.Position = UDim2.new(0,0,0,y)
c.BackgroundTransparency = 1
local tr = mk("Frame",c)
tr.Size = UDim2.new(1,-80,0,6)
tr.Position = UDim2.new(0,10,0.5,-3)
tr.BackgroundColor3 = Color3.fromRGB(80,80,88)
tr.Active = true
local tc = Instance.new("UICorner")
tc.CornerRadius = UDim.new(0,3)
tc.Parent = tr
local fl = mk("Frame",tr)
fl.BackgroundColor3 = gn
local fc = Instance.new("UICorner")
fc.CornerRadius = UDim.new(0,3)
fc.Parent = fl
local kn2 = mk("Frame",tr)
kn2.Size = UDim2.new(0,14,0,14)
kn2.BackgroundColor3 = Color3.new(1,1,1)
kn2.Active = true
local kc3 = Instance.new("UICorner")
kc3.CornerRadius = UDim.new(0,7)
kc3.Parent = kn2
local vl = mk("TextLabel",c)
vl.Size = UDim2.new(0,50,1,0)
vl.Position = UDim2.new(1,-60,0,0)
vl.BackgroundTransparency = 1
vl.Font = Enum.Font.SourceSans
vl.TextSize = 20
vl.TextColor3 = Color3.fromRGB(200,200,200)
vl.TextXAlignment = Enum.TextXAlignment.Right
local mn,mx = 10,90
local function set(v)
v = math.clamp(math.floor(v+0.5),mn,mx)
local sc = (v-mn)/(mx-mn)
fl.Size = UDim2.new(sc,0,1,0)
kn2.Position = UDim2.new(sc,-7,0.5,-7)
vl.Text = tostring(v)
end
set(init)
local dg = false
local function upd(x)
local ax = tr.AbsolutePosition.X
local aw = math.max(tr.AbsoluteSize.X,1)
set(mn+math.clamp((x-ax)/aw,0,1)*(mx-mn))
end
tr.InputBegan:Connect(function(a)
if a.UserInputType == Enum.UserInputType.MouseButton1 then
dg = true
upd(a.Position.X)
end
end)
kn2.InputBegan:Connect(function(a)
if a.UserInputType == Enum.UserInputType.MouseButton1 then
dg = true
upd(a.Position.X)
end
end)
uis.InputChanged:Connect(function(a)
if dg and a.UserInputType == Enum.UserInputType.MouseMovement then
upd(a.Position.X)
end
end)
uis.InputEnded:Connect(function(a)
if a.UserInputType == Enum.UserInputType.MouseButton1 then
dg = false
end
end)
end
local function layout()
local yy = 10
for jj,rr in ipairs(grows) do
tw:Create(rr,TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=UDim2.new(0,209,0,yy)}):Play()
yy = yy + gh[jj] + 5
end
end
for i,n in ipairs(generalbuttons) do
local ix = i
local r = mk("Frame",f)
r.Size = UDim2.new(1,-219,0,50)
r.Position = UDim2.new(0,209,0,10+55*(i-1))
r.BackgroundColor3 = Color3.fromRGB(45,45,53)
r.ClipsDescendants = true
local rc2 = Instance.new("UICorner")
rc2.CornerRadius = UDim.new(0,6)
rc2.Parent = r
local tl = mk("TextLabel",r)
tl.Size = UDim2.new(1,-110,0,50)
tl.BackgroundTransparency = 1
tl.Font = Enum.Font.SourceSans
tl.TextSize = 20
tl.TextColor3 = Color3.fromRGB(200,200,200)
tl.TextXAlignment = Enum.TextXAlignment.Left
tl.Text = "    "..n
local sw = mk("TextButton",r)
sw.Size = UDim2.new(0,34,0,12)
sw.Position = UDim2.new(1,-77,0,19)
sw.BackgroundColor3 = Color3.fromRGB(180,180,180)
sw.Text = ""
sw.AutoButtonColor = false
local sc2 = Instance.new("UICorner")
sc2.CornerRadius = UDim.new(0,6)
sc2.Parent = sw
local kb = mk("Frame",sw)
kb.Size = UDim2.new(0,16,0,16)
kb.Position = UDim2.new(0,0,0.5,-8)
kb.BackgroundColor3 = Color3.new(1,1,1)
local kc = Instance.new("UICorner")
kc.CornerRadius = UDim.new(0,8)
kc.Parent = kb
local on,cd = false,false
sw.MouseButton1Click:Connect(function()
if cd then return end
cd = true
on = not on
tw:Create(kb,TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=on and UDim2.new(1,-16,0.5,-8) or UDim2.new(0,0,0.5,-8),BackgroundColor3=on and gn or Color3.new(1,1,1)}):Play()
task.wait(0.2)
cd = false
end)
local gi = mk("ImageButton",r)
gi.Size = UDim2.new(0,25,0,25)
gi.Position = UDim2.new(1,-35,0,12)
gi.BackgroundTransparency = 1
gi.AutoButtonColor = false
gi.Image = "rbxassetid://"..gicon
grows[ix] = r
if n == "speed" then
local sr = mk("Frame",r)
sr.Size = UDim2.new(1,0,0,40)
sr.Position = UDim2.new(0,0,0,100)
sr.BackgroundTransparency = 1
local st = mk("TextLabel",sr)
st.Size = UDim2.new(1,-60,1,0)
st.BackgroundTransparency = 1
st.Font = Enum.Font.SourceSans
st.TextSize = 20
st.TextColor3 = Color3.fromRGB(200,200,200)
st.TextXAlignment = Enum.TextXAlignment.Left
st.Text = "    no acceleration"
local ss = mk("TextButton",sr)
ss.Size = UDim2.new(0,34,0,12)
ss.Position = UDim2.new(1,-44,0.5,-6)
ss.BackgroundColor3 = Color3.fromRGB(180,180,180)
ss.Text = ""
ss.AutoButtonColor = false
local sc4 = Instance.new("UICorner")
sc4.CornerRadius = UDim.new(0,6)
sc4.Parent = ss
local sk = mk("Frame",ss)
sk.Size = UDim2.new(0,16,0,16)
sk.Position = UDim2.new(0,0,0.5,-8)
sk.BackgroundColor3 = Color3.new(1,1,1)
local kc2 = Instance.new("UICorner")
kc2.CornerRadius = UDim.new(0,8)
kc2.Parent = sk
local son,scd = false,false
ss.MouseButton1Click:Connect(function()
if scd then return end
scd = true
son = not son
tw:Create(sk,TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=son and UDim2.new(1,-16,0.5,-8) or UDim2.new(0,0,0.5,-8),BackgroundColor3=son and gn or Color3.new(1,1,1)}):Play()
task.wait(0.2)
scd = false
end)
mksl(r,55,22)
end
if n == "fly" then
mksl(r,55,22)
end
local exp,ecd = false,false
gi.MouseButton1Click:Connect(function()
if ecd then return end
ecd = true
exp = not exp
tw:Create(gi,TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Rotation=exp and 180 or 0,ImageColor3=exp and gn or Color3.new(1,1,1)}):Play()
gh[ix] = exp and eh[ix] or 50
tw:Create(r,TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size=UDim2.new(1,-219,0,gh[ix])}):Play()
layout()
task.wait(0.2)
ecd = false
end)
end
for i,n in ipairs({"general","visual"}) do
local b = mk("TextButton",s)
b.Size = UDim2.new(1,0,0,46)
b.Position = UDim2.new(0,0,0,68+52*(i-1))
b.BackgroundColor3 = sd
b.AutoButtonColor = false
b.Font = Enum.Font.SourceSans
b.TextSize = 23
b.TextColor3 = Color3.new(1,1,1)
b.TextXAlignment = Enum.TextXAlignment.Left
b.Text = string.rep(" ",n == "general" and 11 or 12)..n
local im = mk("ImageLabel",b)
im.Size = UDim2.new(0,30,0,30)
im.Position = UDim2.new(0,n == "general" and 6 or 10,0.5,-11)
im.BackgroundTransparency = 1
im.Image = "rbxassetid://"..icons[i]
local u = mk("Frame",b)
u.Size = UDim2.new(1,-20,0,3)
u.Position = UDim2.new(0,10,1,-5)
u.BackgroundColor3 = gn
u.Visible = i==1
local fg = Instance.new("UIGradient")
fg.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.25,0),NumberSequenceKeypoint.new(0.75,0),NumberSequenceKeypoint.new(1,1)}
fg.Parent = u
lines[i] = u
local idx = i
b.MouseButton1Click:Connect(function()
if idx == sel then return end
sel = idx
for _,l in ipairs(lines) do l.Visible = false end
for _,r in ipairs(grows) do r.Visible = (idx == 1) end
local u2 = lines[idx]
u2.Visible = true
u2.Size = UDim2.new(0,0,0,3)
u2.Position = UDim2.new(0.5,0,1,-5)
tw:Create(u2,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size=UDim2.new(1,-20,0,3),Position=UDim2.new(0,10,1,-5)}):Play()
end)
end
local places = {lobby=6516141723}
local pname = "???"
for n,id in pairs(places) do if id == game.PlaceId then pname = n end end
local pl = mk("TextLabel",s)
pl.Size = UDim2.new(1,0,0,17)
pl.Position = UDim2.new(0,0,1,-20)
pl.BackgroundTransparency = 1
pl.Font = Enum.Font.SourceSans
pl.TextSize = 13
pl.TextColor3 = Color3.fromRGB(130,130,135)
pl.TextXAlignment = Enum.TextXAlignment.Left
pl.Text = "  place: "..pname
local os,op = f.Size,f.Position
local cs,cp = UDim2.new(0,40,0,40),UDim2.new(0.5,-20,0.5,-20)
local open,busy = true,false
uis.InputBegan:Connect(function(i,gp)
if gp or i.KeyCode ~= Enum.KeyCode.RightShift or busy then return end
busy = true
if open then
local t = tw:Create(f,t3,{Size=cs,Position=cp})
t:Play()
t.Completed:Wait()
f.Visible = false
open = false
else
f.Visible = true
f.Size = cs
f.Position = cp
local t = tw:Create(f,t3,{Size=os,Position=op})
t:Play()
t.Completed:Wait()
open = true
end
busy = false
end)
