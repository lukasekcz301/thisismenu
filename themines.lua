local CoreGui=game:GetService("CoreGui")
local TweenService=game:GetService("TweenService")
local UserInputService=game:GetService("UserInputService")
local Players=game:GetService("Players")
local LocalPlayer=Players.LocalPlayer
local runService=game:GetService("RunService")
local ReplicatedStorage=game:GetService("ReplicatedStorage")
local remotesFolder=ReplicatedStorage:WaitForChild("RemotesFolder")
local currentRooms=workspace:WaitForChild("CurrentRooms")
local lighting=game:GetService("Lighting")
if CoreGui:FindFirstChild("thisismenu") then CoreGui.thisismenu:Destroy() end
if CoreGui:FindFirstChild("thisismenu_esp") then CoreGui.thisismenu_esp:Destroy() end
local espGui=Instance.new("ScreenGui")
espGui.Name="thisismenu_esp"
espGui.IgnoreGuiInset=true
espGui.Parent=CoreGui
local function createInstance(cameraOrCorner,partOrPlayer)
local instance=Instance.new(cameraOrCorner)
instance.BorderSizePixel=0
instance.Parent=partOrPlayer
return instance
end
local function addCorner(partOrPlayer,rootOrRow)
local cameraOrCorner=Instance.new("UICorner")
cameraOrCorner.CornerRadius=UDim.new(0,rootOrRow)
cameraOrCorner.Parent=partOrPlayer
end
local function addGradient(partOrPlayer)
local gradientOrGlobals=Instance.new("UIGradient")
gradientOrGlobals.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.25,0),NumberSequenceKeypoint.new(0.75,0),NumberSequenceKeypoint.new(1,1)})
gradientOrGlobals.Parent=partOrPlayer
end
local GREEN=Color3.fromRGB(0,255,0)
local orange=Color3.fromRGB(255,120,0)
local red=Color3.fromRGB(255,0,0)
local gray=Color3.fromRGB(100,100,100)
local lightYellow=Color3.fromRGB(200,200,0)
local lightBlue=Color3.fromRGB(0,200,255)
local darkBackground=Color3.fromRGB(35,35,40)
local WHITE=Color3.new(1,1,1)
local lightGray=Color3.fromRGB(200,200,200)
local mediumGray=Color3.fromRGB(180,180,180)
local panelBackground=Color3.fromRGB(45,45,53)
local TWEEN_FAST=TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
local tweenSlow=TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
local sourceSansFont=Enum.Font.SourceSans
local toggleOffPosition=UDim2.new(0,0,0.5,-8)
local toggleOnPosition=UDim2.new(1,-16,0.5,-8)
local mainGui=Instance.new("ScreenGui")
mainGui.Name="thisismenu"
mainGui.Parent=CoreGui
local mainFrame=createInstance("Frame",mainGui)
mainFrame.Size=UDim2.new(0,845,0,520)
mainFrame.Position=UDim2.new(0.5,-422,0.5,-260)
mainFrame.BackgroundColor3=Color3.fromRGB(48,48,55)
mainFrame.ClipsDescendants=true
local sidebar=createInstance("Frame",mainFrame)
sidebar.Size=UDim2.new(0,199,1,0)
sidebar.BackgroundColor3=darkBackground
addCorner(mainFrame,10)
addCorner(sidebar,10)
local titleLabel=createInstance("TextLabel",sidebar)
titleLabel.Size=UDim2.new(1,0,0,65)
titleLabel.BackgroundTransparency=1
titleLabel.Font=Enum.Font.SourceSansBold
titleLabel.TextSize=29
titleLabel.TextColor3=WHITE
titleLabel.TextXAlignment=Enum.TextXAlignment.Left
titleLabel.Text="  thisismenu"
for instance,wasFlyEnabled in ipairs({92,62}) do
local labelOrFrame=createInstance("Frame",sidebar)
labelOrFrame.Size=UDim2.new(0,wasFlyEnabled,0,4)
labelOrFrame.Position=UDim2.new(0,10,0,50+9*(instance-1))
labelOrFrame.BackgroundColor3=GREEN
local gradientOrGlobals=Instance.new("UIGradient")
gradientOrGlobals.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(0.7,0),NumberSequenceKeypoint.new(1,1)})
gradientOrGlobals.Parent=labelOrFrame
local temporaryValue=createInstance("Frame",labelOrFrame)
temporaryValue.Size=UDim2.new(0,8,0,8)
temporaryValue.Position=UDim2.new(1,-4,0.5,-4)
temporaryValue.Rotation=45
temporaryValue.BackgroundColor3=GREEN
end
local function temporaryValue(partOrPlayer,pos)
local localState=createInstance("TextButton",partOrPlayer)
localState.Size=UDim2.new(0,34,0,12)
localState.Position=pos
localState.BackgroundColor3=mediumGray
localState.Text=""
localState.AutoButtonColor=false
addCorner(localState,6)
local isOldGeneration=createInstance("Frame",localState)
isOldGeneration.Size=UDim2.new(0,16,0,16)
isOldGeneration.Position=toggleOffPosition
isOldGeneration.BackgroundColor3=WHITE
addCorner(isOldGeneration,8)
local localValue,cameraOrCorner=false,false
local function setValue(localObject)
localValue=localObject
TweenService:Create(isOldGeneration,TWEEN_FAST,{Position=localValue and toggleOnPosition or toggleOffPosition,BackgroundColor3=localValue and GREEN or WHITE}):Play()
end
localState.MouseButton1Click:Connect(function()
if cameraOrCorner then return end
cameraOrCorner=true
setValue(not localValue)
task.wait(0.2)
cameraOrCorner=false
end)
return {set=setValue,get=function() return localValue end,btn=localState}
end
local function localObject(partOrPlayer,setupKeybind,name,highlightOrHumanoid)
local rootOrRow=createInstance("Frame",partOrPlayer)
rootOrRow.Size=UDim2.new(1,0,0,highlightOrHumanoid)
rootOrRow.Position=UDim2.new(0,0,0,setupKeybind)
rootOrRow.BackgroundTransparency=1
local localState=createInstance("TextLabel",rootOrRow)
localState.Size=UDim2.new(1,-60,1,0)
localState.BackgroundTransparency=1
localState.Font=sourceSansFont
localState.TextSize=20
localState.TextColor3=lightGray
localState.TextXAlignment=Enum.TextXAlignment.Left
localState.Text="    "..name
return temporaryValue(rootOrRow,UDim2.new(1,-44,0.5,-6)),rootOrRow
end
local globalEnvironment=getgenv()
globalEnvironment.tm=(globalEnvironment.tm or 0)+1
local generationId=globalEnvironment.tm
local function isOldGeneration() return generationId~=globalEnvironment.tm end
local savedPhysicalProperties={}
local function setNoAcceleration(localValue)
local character=LocalPlayer.Character
if not character then return end
if localValue then
for _,partOrPlayer in ipairs(character:GetDescendants()) do
if partOrPlayer:IsA("BasePart") then
savedPhysicalProperties[partOrPlayer]=partOrPlayer.CustomPhysicalProperties
local localObject=partOrPlayer.CurrentPhysicalProperties
partOrPlayer.CustomPhysicalProperties=PhysicalProperties.new(100,localObject.Friction,localObject.Elasticity,localObject.FrictionWeight,localObject.ElasticityWeight)
end
end
else
for partOrPlayer,localObject in pairs(savedPhysicalProperties) do
if partOrPlayer.Parent then partOrPlayer.CustomPhysicalProperties=localObject end
end
table.clear(savedPhysicalProperties)
end
end
local function updateScreenPosition(labelOrFrame,wp)
local cameraOrCorner=workspace.CurrentCamera
if not cameraOrCorner then labelOrFrame.Visible=false return end
local localState,localValue=cameraOrCorner:WorldToViewportPoint(wp)
if localValue then labelOrFrame.Visible=true labelOrFrame.Position=UDim2.fromOffset(localState.X,localState.Y) else labelOrFrame.Visible=false end
end
local function setupSpeed(speedToggle,sl,no)
local originalWalkSpeed,wasSpeedEnabled,j3=16,false,false
runService.Heartbeat:Connect(function()
if isOldGeneration() then return end
local character=LocalPlayer.Character
local highlightOrHumanoid=character and character:FindFirstChildOfClass("Humanoid")
local localValue=speedToggle.get()
if highlightOrHumanoid then
if localValue then
if not wasSpeedEnabled then originalWalkSpeed=highlightOrHumanoid.WalkSpeed end
highlightOrHumanoid.WalkSpeed=sl.get()
remotesFolder.Crouch:FireServer(true,true)
elseif wasSpeedEnabled then
highlightOrHumanoid.WalkSpeed=originalWalkSpeed
remotesFolder.Crouch:FireServer(false,true)
end
end
wasSpeedEnabled=localValue
local localObject=no.get()
if localObject~=j3 then j3=localObject setNoAcceleration(localObject) end
end)
end
local function setCrouchIconVisible(localValue)
local uiObject=LocalPlayer.PlayerGui:FindFirstChild("MainUI")
local localModel=uiObject and uiObject:FindFirstChild("MainFrame")
local highlightOrHumanoid=localModel and localModel:FindFirstChild("Healthbar")
local effects=highlightOrHumanoid and highlightOrHumanoid:FindFirstChild("Effects")
local crouchingIcon=effects and effects:FindFirstChild("Crouching")
if crouchingIcon then crouchingIcon.Visible=localValue end
end
local function setupFly(fa,fill,speedToggle)
local buttonOrVelocity=Instance.new("BodyVelocity")
buttonOrVelocity.MaxForce=Vector3.new(9e9,9e9,9e9)
local wasFlyEnabled=false
runService.Heartbeat:Connect(function()
if isOldGeneration() then return end
local character=LocalPlayer.Character
local highlightOrHumanoid=character and character:FindFirstChildOfClass("Humanoid")
local rootOrRow=highlightOrHumanoid and character:FindFirstChild("HumanoidRootPart")
local localValue=fa.get()
if localValue and highlightOrHumanoid and rootOrRow then
local cameraOrCorner=workspace.CurrentCamera
local localObject=highlightOrHumanoid.MoveDirection
local flyDirection=Vector3.zero
if localObject~=Vector3.zero then
local lookVector=cameraOrCorner.CFrame.LookVector
local flatCameraFrame=CFrame.new(cameraOrCorner.CFrame.Position,cameraOrCorner.CFrame.Position+Vector3.new(lookVector.X,0,lookVector.Z))
flyDirection=(cameraOrCorner.CFrame*CFrame.new(flatCameraFrame:VectorToObjectSpace(localObject))).Position-cameraOrCorner.CFrame.Position
if flyDirection~=Vector3.zero then flyDirection=flyDirection.Unit end
end
buttonOrVelocity.Parent=rootOrRow
buttonOrVelocity.Velocity=flyDirection*fill.get()
remotesFolder.Crouch:FireServer(true,true)
setCrouchIconVisible(false)
else
buttonOrVelocity.Parent=nil
if wasFlyEnabled and not localValue then
remotesFolder.Crouch:FireServer(false,true)
if speedToggle.get() then setCrouchIconVisible(true) end
end
end
wasFlyEnabled=localValue
end)
end
local function setNoCollision(localState,localValue)
local character=LocalPlayer.Character
if localValue and character then
for _,partOrPlayer in ipairs(character:GetDescendants()) do
if partOrPlayer:IsA("BasePart") then
if localState[partOrPlayer]==nil then localState[partOrPlayer]=partOrPlayer.CanCollide end
partOrPlayer.CanCollide=false
end
end
elseif not localValue then
for partOrPlayer,localObject in pairs(localState) do
if partOrPlayer.Parent then partOrPlayer.CanCollide=localObject end
end
table.clear(localState)
end
end
local function setupNoclip(mainFrame)
local localState={}
runService.Heartbeat:Connect(function()
if isOldGeneration() then return end
setNoCollision(localState,mainFrame.get())
end)
end
local doorEspEntries={}
local function c1Value()
for localObject,localValue in pairs(doorEspEntries) do
pcall(function() localValue.l:Destroy() end)
pcall(function() localValue.h:Destroy() end)
pcall(function() localValue.m:Destroy() end)
end
table.clear(doorEspEntries)
end
local function createDoorEsp(room,ix)
local localObject=room:FindFirstChild("Door")
local bypassFeatures=localObject and localObject:FindFirstChild("Door",true)
if not bypassFeatures or not bypassFeatures:IsA("BasePart") or doorEspEntries[localObject] then return end
local doorModel=Instance.new("Model")
doorModel.Parent=localObject
local humanoid=Instance.new("Humanoid")
humanoid.Parent=doorModel
for _,lastFireTime in ipairs(localObject:GetChildren()) do
if lastFireTime.Name=="Door" and lastFireTime:IsA("BasePart") then
local partOrPlayer=Instance.new("Part")
partOrPlayer.Transparency=0.999
partOrPlayer.Size=lastFireTime.Size
partOrPlayer.CFrame=lastFireTime.CFrame
partOrPlayer.CanCollide=false
partOrPlayer.CanTouch=false
partOrPlayer.CanQuery=false
partOrPlayer.Parent=doorModel
local weld=Instance.new("WeldConstraint")
weld.Part0=partOrPlayer
weld.Part1=lastFireTime
weld.Parent=partOrPlayer
end
end
local highlightOrHumanoid=Instance.new("Highlight")
highlightOrHumanoid.FillColor=GREEN
highlightOrHumanoid.OutlineColor=GREEN
highlightOrHumanoid.FillTransparency=0.75
highlightOrHumanoid.OutlineTransparency=0
highlightOrHumanoid.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
highlightOrHumanoid.Adornee=doorModel
highlightOrHumanoid.Parent=mainGui
local labelOrFrame=Instance.new("TextLabel")
labelOrFrame.BackgroundTransparency=1
labelOrFrame.Size=UDim2.fromOffset(130,26)
labelOrFrame.AnchorPoint=Vector2.new(0.5,1)
labelOrFrame.Font=Enum.Font.BuilderSansExtraBold
labelOrFrame.Text="Door "..tostring(ix)
labelOrFrame.TextXAlignment=Enum.TextXAlignment.Center
labelOrFrame.TextYAlignment=Enum.TextYAlignment.Center
labelOrFrame.TextColor3=GREEN
labelOrFrame.TextStrokeColor3=Color3.new(0,0,0)
labelOrFrame.TextStrokeTransparency=0
labelOrFrame.TextScaled=false
labelOrFrame.TextSize=18
labelOrFrame.Visible=false
labelOrFrame.Parent=espGui
doorEspEntries[localObject]={l=labelOrFrame,h=highlightOrHumanoid,m=doorModel}
end
local function updateDoorEsp(mainFrame)
runService.Heartbeat:Connect(function()
if isOldGeneration() then return end
if not mainFrame.get() then
if next(doorEspEntries) then c1Value() end
return
end
local currentRoom=tonumber(LocalPlayer:GetAttribute("CurrentRoom"))
local trackedObjects={}
for _,room in ipairs(currentRooms:GetChildren()) do
local numberValue=tonumber(room.Name)
if numberValue and currentRoom and (numberValue==currentRoom or numberValue==currentRoom+1) then
local localObject=room:FindFirstChild("Door")
if localObject and localObject:FindFirstChild("Door",true) then
trackedObjects[localObject]=true
pcall(createDoorEsp,room,numberValue+1)
end
end
end
for localObject,localValue in pairs(doorEspEntries) do
if not trackedObjects[localObject] then
pcall(function() localValue.l:Destroy() end)
pcall(function() localValue.h:Destroy() end)
pcall(function() localValue.m:Destroy() end)
doorEspEntries[localObject]=nil
else
pcall(function()
local centerX,cz,cn,labelText=0,0,0,nil
for _,lastFireTime in ipairs(localObject:GetChildren()) do
if lastFireTime.Name=="Door" and lastFireTime:IsA("BasePart") and lastFireTime:IsDescendantOf(workspace) then
centerX=centerX+lastFireTime.Position.X
cz=cz+lastFireTime.Position.Z
cn=cn+1
local transparencyParts=lastFireTime.Position.Y+lastFireTime.Size.Y*0.5
if not labelText or transparencyParts>labelText then labelText=transparencyParts end
end
end
if not cn or cn==0 or not labelText then localValue.l.Visible=false return end
updateScreenPosition(localValue.l,Vector3.new(centerX/cn,labelText+0.5,cz/cn))
end)
end
end
end)
end
local objectiveEspEntries={}
local objectiveNames={FuseObtain="Fuse",Wheel="Wheel"}
local function getObjectiveLabel(instance)
if instance.Name=="Wheel" and (not instance.Parent or instance.Parent.Name~="WaterPump") then return nil end
return objectiveNames[instance.Name]
end
local function isObjectiveAvailable(localObject)
return localObject:IsDescendantOf(currentRooms) and not localObject:GetAttribute("ItemPicked") and not localObject:GetAttribute("PlayerUsed"..LocalPlayer.Name)
end
local function clearObjectiveEsp()
for localObject,localValue in pairs(objectiveEspEntries) do
pcall(function() localValue.l:Destroy() end)
pcall(function() localValue.h:Destroy() end)
end
table.clear(objectiveEspEntries)
end
local function createObjectiveEsp(localObject,labelText)
if objectiveEspEntries[localObject] or not isObjectiveAvailable(localObject) then return end
local anchorPart=nil
if localObject:IsA("BasePart") then
anchorPart=localObject
else
local transparencyParts=-math.huge
for _,localObject in ipairs(localObject:GetDescendants()) do
if localObject:IsA("BasePart") and localObject.Position.Y>transparencyParts then transparencyParts=localObject.Position.Y anchorPart=localObject end
end
end
if not anchorPart then return end
local highlightOrHumanoid=Instance.new("Highlight")
highlightOrHumanoid.FillColor=orange
highlightOrHumanoid.OutlineColor=orange
highlightOrHumanoid.FillTransparency=0.5
highlightOrHumanoid.OutlineTransparency=0
highlightOrHumanoid.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
highlightOrHumanoid.Adornee=localObject
highlightOrHumanoid.Parent=espGui
local labelOrFrame=Instance.new("TextLabel")
labelOrFrame.BackgroundTransparency=1
labelOrFrame.Size=UDim2.fromOffset(100,20)
labelOrFrame.AnchorPoint=Vector2.new(0.5,0.5)
labelOrFrame.Font=Enum.Font.BuilderSansExtraBold
labelOrFrame.Text=labelText
labelOrFrame.TextXAlignment=Enum.TextXAlignment.Center
labelOrFrame.TextYAlignment=Enum.TextYAlignment.Center
labelOrFrame.TextColor3=orange
labelOrFrame.TextStrokeColor3=Color3.new(0,0,0)
labelOrFrame.TextStrokeTransparency=0
labelOrFrame.TextScaled=false
labelOrFrame.TextSize=14
labelOrFrame.Visible=false
labelOrFrame.Parent=espGui
objectiveEspEntries[localObject]={l=labelOrFrame,h=highlightOrHumanoid,a=anchorPart}
end
local function updateObjectiveEsp(mainFrame)
local trackedObjects={}
local function scanObjects()
local currentRoom=tonumber(LocalPlayer:GetAttribute("CurrentRoom"))
local room=currentRoom and currentRooms:FindFirstChild(tostring(currentRoom))
local nextObjects={}
if room then
for _,localObject in ipairs(room:GetDescendants()) do
local labelText=getObjectiveLabel(localObject)
if labelText and isObjectiveAvailable(localObject) then nextObjects[localObject]=true if not objectiveEspEntries[localObject] then pcall(createObjectiveEsp,localObject,labelText) end end
end
end
for localObject,localValue in pairs(objectiveEspEntries) do
if not nextObjects[localObject] then
pcall(function() localValue.l:Destroy() end)
pcall(function() localValue.h:Destroy() end)
objectiveEspEntries[localObject]=nil
end
end
trackedObjects=nextObjects
end
task.spawn(function()
while true do
task.wait(0.5)
if isOldGeneration() then break end
if mainFrame.get() then
scanObjects()
elseif next(objectiveEspEntries) then
clearObjectiveEsp()
trackedObjects={}
end
end
end)
runService.Heartbeat:Connect(function()
if isOldGeneration() then return end
if not mainFrame.get() then return end
for localObject,localValue in pairs(objectiveEspEntries) do
pcall(function()
if not trackedObjects[localObject] or not isObjectiveAvailable(localObject) or not localValue.a:IsDescendantOf(workspace) then
localValue.l:Destroy()
localValue.h:Destroy()
objectiveEspEntries[localObject]=nil
trackedObjects[localObject]=nil
return
end
updateScreenPosition(localValue.l,localValue.a.Position)
end)
end
end)
end
local function setupAnchorEsp(anchorToggle)
local entries={}
local lastScan=0
local lastRoom=nil
local heartbeatConnection,destroyingConnection
local function clearEntries()
for anchor,entry in pairs(entries) do
entry.l:Destroy()
entry.h:Destroy()
entries[anchor]=nil
end
end
local function cleanup()
clearEntries()
if heartbeatConnection then heartbeatConnection:Disconnect() end
if destroyingConnection then destroyingConnection:Disconnect() end
end
destroyingConnection=mainGui.Destroying:Connect(cleanup)
heartbeatConnection=runService.Heartbeat:Connect(function()
if isOldGeneration() then cleanup() return end
if not anchorToggle.get() then clearEntries() lastRoom=nil lastScan=0 return end
local room=currentRooms:FindFirstChild(tostring(LocalPlayer:GetAttribute("CurrentRoom")))
if not room then clearEntries() lastRoom=nil return end
local now=os.clock()
if room~=lastRoom or now-lastScan>=0.5 then
lastScan=now
lastRoom=room
local tracked={}
for _,anchor in ipairs(room:QueryDescendants("#MinesAnchor")) do
local sign=anchor:FindFirstChild("Sign")
local letter=sign and sign:FindFirstChild("TextLabel")
if letter then
tracked[anchor]=true
if not entries[anchor] then
local highlight=Instance.new("Highlight")
highlight.FillColor=WHITE
highlight.OutlineColor=WHITE
highlight.FillTransparency=0.5
highlight.OutlineTransparency=0
highlight.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
highlight.Adornee=anchor
highlight.Parent=espGui
local label=Instance.new("TextLabel")
label.BackgroundTransparency=1
label.Size=UDim2.fromOffset(150,20)
label.AnchorPoint=Vector2.new(0.5,0.5)
label.Font=Enum.Font.BuilderSansExtraBold
label.Text="Anchor "..letter.ContentText
label.TextXAlignment=Enum.TextXAlignment.Center
label.TextYAlignment=Enum.TextYAlignment.Center
label.TextColor3=WHITE
label.TextStrokeColor3=Color3.new(0,0,0)
label.TextStrokeTransparency=0
label.TextSize=14
label.Visible=false
label.Parent=espGui
entries[anchor]={l=label,h=highlight,t=letter}
end
end
end
for anchor,entry in pairs(entries) do
if not tracked[anchor] then
entry.l:Destroy()
entry.h:Destroy()
entries[anchor]=nil
end
end
end
for anchor,entry in pairs(entries) do
if not anchor:IsDescendantOf(room) or not entry.t:IsDescendantOf(anchor) then
entry.l:Destroy()
entry.h:Destroy()
entries[anchor]=nil
else
entry.l.Text="Anchor "..entry.t.ContentText
local center=anchor:GetBoundingBox()
updateScreenPosition(entry.l,center.Position)
end
end
end)
end
local entityEspEntries={}
local entityNames={RushMoving="Rush",FigureRig="Figure",GiggleCeiling="Giggle",SeekRig="Seek",Eyes="Eyes",AmbushMoving="Ambush",GrumbleRig="Grumble",GlitchCube="Glitch Fragment"}
local alwaysShowEntities={RushMoving=true,AmbushMoving=true}
local proxyEntities={RushMoving=true,Eyes=true,AmbushMoving=true}
local eyesEspBlacklist={_QueenGrumbleNest=true,GrumbleRig=true,QueenGrumbe=true,QueenGrumbleChase=true,_QueenGrumble=true,TrueSeek=true,_QueenGrumbleDam=true}
local function isEntityEspBlocked(instance)
if instance.Name~="Eyes" then return false end
local parent=instance.Parent
while parent do
if eyesEspBlacklist[parent.Name] then return true end
parent=parent.Parent
end
return false
end
local function clearEntityEsp()
for instance,localValue in pairs(entityEspEntries) do
pcall(function() localValue.l:Destroy() end)
pcall(function() localValue.h:Destroy() end)
pcall(function() localValue.m:Destroy() end)
end
table.clear(entityEspEntries)
end
local function createEntityEsp(it,labelText)
if entityEspEntries[it] or isEntityEspBlocked(it) then return end
local anchorPart=nil
local localModel=nil
local adornee=it
if it.Name=="GlitchCube" then
local proxyParts={}
for _,nm in ipairs({"OuterPart","MainPart"}) do
local sourceSansFont=it:FindFirstChild(nm)
if sourceSansFont and sourceSansFont:IsA("BasePart") then proxyParts[#proxyParts+1]=sourceSansFont end
end
if #proxyParts==0 then return end
anchorPart=proxyParts[1]
for _,sourceSansFont in ipairs(proxyParts) do
if sourceSansFont.Position.Y>anchorPart.Position.Y then anchorPart=sourceSansFont end
end
localModel=Instance.new("Model")
localModel.Name="ESPProxy"
local humanoid=Instance.new("Humanoid")
humanoid.Parent=localModel
localModel.Parent=it
for _,lastFireTime in ipairs(proxyParts) do
local partOrPlayer=Instance.new("Part")
partOrPlayer.Transparency=0.999
partOrPlayer.Size=lastFireTime.Size
partOrPlayer.CFrame=lastFireTime.CFrame
partOrPlayer.CanCollide=false
partOrPlayer.CanTouch=false
partOrPlayer.CanQuery=false
partOrPlayer.Parent=localModel
local weld=Instance.new("WeldConstraint")
weld.Part0=partOrPlayer
weld.Part1=lastFireTime
weld.Parent=partOrPlayer
end
adornee=localModel
else
local transparencyParts=-math.huge
for _,localObject in ipairs(it:GetDescendants()) do
if localObject:IsA("BasePart") and localObject.Position.Y>transparencyParts then transparencyParts=localObject.Position.Y anchorPart=localObject end
end
end
if not anchorPart then return end
local yOffset=anchorPart.Size.Y*0.5+0.5
if it.Name=="GlitchCube" then yOffset=0.5 end
if proxyEntities[it.Name] then
localModel=Instance.new("Model")
localModel.Name="ESPProxy"
local humanoid=Instance.new("Humanoid")
humanoid.Parent=localModel
localModel.Parent=it
local numberValue=0
for _,lastFireTime in ipairs(it:GetDescendants()) do
if lastFireTime:IsA("BasePart") then
numberValue=numberValue+1
if numberValue>12 then break end
local partOrPlayer=Instance.new("Part")
partOrPlayer.Shape=Enum.PartType.Ball
local localState=math.max(lastFireTime.Size.X,lastFireTime.Size.Y,lastFireTime.Size.Z)
partOrPlayer.Size=Vector3.new(localState,localState,localState)
partOrPlayer.CFrame=lastFireTime.CFrame
partOrPlayer.Transparency=0.999
partOrPlayer.CanCollide=false
partOrPlayer.CanTouch=false
partOrPlayer.CanQuery=false
partOrPlayer.Anchored=false
partOrPlayer.Parent=localModel
local weld=Instance.new("WeldConstraint")
weld.Part0=partOrPlayer
weld.Part1=lastFireTime
weld.Parent=partOrPlayer
end
end
if numberValue==0 then localModel:Destroy() return end
adornee=localModel
end
local highlightOrHumanoid=Instance.new("Highlight")
highlightOrHumanoid.FillColor=red
highlightOrHumanoid.OutlineColor=red
highlightOrHumanoid.FillTransparency=0.75
highlightOrHumanoid.OutlineTransparency=0
highlightOrHumanoid.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
highlightOrHumanoid.Adornee=adornee
highlightOrHumanoid.Parent=espGui
local labelOrFrame=Instance.new("TextLabel")
labelOrFrame.BackgroundTransparency=1
labelOrFrame.Size=UDim2.fromOffset(100,20)
labelOrFrame.AnchorPoint=Vector2.new(0.5,1)
labelOrFrame.Font=Enum.Font.BuilderSansExtraBold
labelOrFrame.Text=labelText
labelOrFrame.TextXAlignment=Enum.TextXAlignment.Center
labelOrFrame.TextYAlignment=Enum.TextYAlignment.Center
labelOrFrame.TextColor3=red
labelOrFrame.TextStrokeColor3=Color3.new(0,0,0)
labelOrFrame.TextStrokeTransparency=0
labelOrFrame.TextScaled=false
labelOrFrame.TextSize=14
labelOrFrame.Visible=false
labelOrFrame.Parent=espGui
entityEspEntries[it]={l=labelOrFrame,h=highlightOrHumanoid,m=localModel,a=anchorPart,y=yOffset}
end
local function updateEntityEsp(mainFrame)
local trackedObjects={}
local lastScan=0
runService.Heartbeat:Connect(function()
if isOldGeneration() then return end
if not mainFrame.get() then
if next(entityEspEntries) then clearEntityEsp() end
return
end
local now=os.clock()
if now-lastScan>=0.5 then
lastScan=now
local currentRoom=tonumber(LocalPlayer:GetAttribute("CurrentRoom"))
local room=currentRoom and currentRooms:FindFirstChild(tostring(currentRoom))
local nextTrackedObjects={}
for _,localObject in ipairs(workspace:GetDescendants()) do
local labelText=entityNames[localObject.Name]
if labelText and not nextTrackedObjects[localObject] and not isEntityEspBlocked(localObject) then
if alwaysShowEntities[localObject.Name] or (room and localObject:IsDescendantOf(room)) or (not localObject:IsDescendantOf(currentRooms)) then nextTrackedObjects[localObject]=true pcall(createEntityEsp,localObject,labelText) end
end
end
trackedObjects=nextTrackedObjects
for it,localValue in pairs(entityEspEntries) do
if not trackedObjects[it] or not it:IsDescendantOf(workspace) then
pcall(function() localValue.l:Destroy() end)
pcall(function() localValue.h:Destroy() end)
pcall(function() localValue.m:Destroy() end)
entityEspEntries[it]=nil
end
end
end
for it,localValue in pairs(entityEspEntries) do
pcall(function()
if isEntityEspBlocked(it) then
localValue.l:Destroy()
localValue.h:Destroy()
if localValue.m then localValue.m:Destroy() end
entityEspEntries[it]=nil
trackedObjects[it]=nil
return
end
if not localValue.a:IsDescendantOf(workspace) then localValue.l.Visible=false return end
local labelPosition=localValue.a.Position+Vector3.new(0,localValue.y,0)
if it.Name=="GiggleCeiling" and it:IsA("Model") then
local center=it:GetBoundingBox()
labelPosition=Vector3.new(center.Position.X,labelPosition.Y,center.Position.Z)
end
updateScreenPosition(localValue.l,labelPosition)
end)
end
end)
end
local closetEspEntries={}
local closetNames={Locker_Large=true,Toolshed=true}
local function clearClosetEsp()
for localObject,localValue in pairs(closetEspEntries) do
pcall(function() localValue.l:Destroy() end)
pcall(function() localValue.h:Destroy() end)
end
table.clear(closetEspEntries)
end
local function createClosetEsp(localObject)
if closetEspEntries[localObject] then return end
local anchorPart=nil
if localObject:IsA("BasePart") then
anchorPart=localObject
else
local transparencyParts=-math.huge
for _,localObject in ipairs(localObject:GetDescendants()) do
if localObject:IsA("BasePart") and localObject.Position.Y>transparencyParts then transparencyParts=localObject.Position.Y anchorPart=localObject end
end
end
if not anchorPart then return end
local highlightOrHumanoid=Instance.new("Highlight")
highlightOrHumanoid.FillColor=gray
highlightOrHumanoid.OutlineColor=gray
highlightOrHumanoid.FillTransparency=0.5
highlightOrHumanoid.OutlineTransparency=0
highlightOrHumanoid.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
highlightOrHumanoid.Adornee=localObject
highlightOrHumanoid.Parent=espGui
local labelOrFrame=Instance.new("TextLabel")
labelOrFrame.BackgroundTransparency=1
labelOrFrame.Size=UDim2.fromOffset(100,20)
labelOrFrame.AnchorPoint=Vector2.new(0.5,0.5)
labelOrFrame.Font=Enum.Font.BuilderSansExtraBold
labelOrFrame.Text="Closet"
labelOrFrame.TextXAlignment=Enum.TextXAlignment.Center
labelOrFrame.TextYAlignment=Enum.TextYAlignment.Center
labelOrFrame.TextColor3=gray
labelOrFrame.TextStrokeColor3=Color3.new(0,0,0)
labelOrFrame.TextStrokeTransparency=0
labelOrFrame.TextScaled=false
labelOrFrame.TextSize=14
labelOrFrame.Visible=false
labelOrFrame.Parent=espGui
closetEspEntries[localObject]={l=labelOrFrame,h=highlightOrHumanoid,a=anchorPart}
end
local function updateClosetEsp(mainFrame)
local trackedObjects={}
local function scanObjects()
local currentRoom=tonumber(LocalPlayer:GetAttribute("CurrentRoom"))
local room=currentRoom and currentRooms:FindFirstChild(tostring(currentRoom))
local nextObjects={}
if room then
for _,localObject in ipairs(room:GetDescendants()) do
if closetNames[localObject.Name] then nextObjects[localObject]=true if not closetEspEntries[localObject] then pcall(createClosetEsp,localObject) end end
end
end
for localObject,localValue in pairs(closetEspEntries) do
if not nextObjects[localObject] then
pcall(function() localValue.l:Destroy() end)
pcall(function() localValue.h:Destroy() end)
closetEspEntries[localObject]=nil
end
end
trackedObjects=nextObjects
end
task.spawn(function()
while true do
task.wait(0.5)
if isOldGeneration() then break end
if mainFrame.get() then scanObjects()
elseif next(closetEspEntries) then clearClosetEsp() trackedObjects={} end
end
end)
runService.Heartbeat:Connect(function()
if isOldGeneration() then return end
if not mainFrame.get() then return end
for localObject,localValue in pairs(closetEspEntries) do
pcall(function()
if not trackedObjects[localObject] or not localValue.a:IsDescendantOf(workspace) then localValue.l.Visible=false return end
local labelPosition=localValue.a.Position
if localObject:IsA("Model") then
local center=localObject:GetBoundingBox()
local labelY=localObject.Name=="Toolshed" and center.Position.Y or labelPosition.Y
labelPosition=Vector3.new(center.Position.X,labelY,center.Position.Z)
end
updateScreenPosition(localValue.l,labelPosition)
end)
end
end)
end
local playerEspEntries={}
local function clearPlayerEsp()
for partOrPlayer,localValue in pairs(playerEspEntries) do
pcall(function() localValue.l:Destroy() end)
pcall(function() localValue.h:Destroy() end)
end
table.clear(playerEspEntries)
end
local function updatePlayerEsp(mainFrame)
runService.Heartbeat:Connect(function()
if isOldGeneration() then return end
if not mainFrame.get() then
if next(playerEspEntries) then clearPlayerEsp() end
return
end
local trackedObjects={}
for _,partOrPlayer in ipairs(Players:GetPlayers()) do
if partOrPlayer~=LocalPlayer then
local character=partOrPlayer.Character
local head=character and character:FindFirstChild("Head")
if head then
trackedObjects[partOrPlayer]=true
local localValue=playerEspEntries[partOrPlayer]
if not localValue then
local highlightOrHumanoid=Instance.new("Highlight")
highlightOrHumanoid.FillColor=WHITE
highlightOrHumanoid.OutlineColor=WHITE
highlightOrHumanoid.FillTransparency=0.75
highlightOrHumanoid.OutlineTransparency=0
highlightOrHumanoid.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
highlightOrHumanoid.Adornee=character
highlightOrHumanoid.Parent=espGui
local labelOrFrame=Instance.new("TextLabel")
labelOrFrame.BackgroundTransparency=1
labelOrFrame.Size=UDim2.fromOffset(130,20)
labelOrFrame.AnchorPoint=Vector2.new(0.5,1)
labelOrFrame.Font=Enum.Font.BuilderSansExtraBold
labelOrFrame.Text=partOrPlayer.DisplayName
labelOrFrame.TextXAlignment=Enum.TextXAlignment.Center
labelOrFrame.TextYAlignment=Enum.TextYAlignment.Center
labelOrFrame.TextColor3=WHITE
labelOrFrame.TextStrokeColor3=Color3.new(0,0,0)
labelOrFrame.TextStrokeTransparency=0
labelOrFrame.TextScaled=false
labelOrFrame.TextSize=14
labelOrFrame.Visible=false
labelOrFrame.Parent=espGui
localValue={l=labelOrFrame,h=highlightOrHumanoid,c=character}
playerEspEntries[partOrPlayer]=localValue
else
if localValue.c~=character then
pcall(function() localValue.h:Destroy() end)
local highlightOrHumanoid=Instance.new("Highlight")
highlightOrHumanoid.FillColor=WHITE
highlightOrHumanoid.OutlineColor=WHITE
highlightOrHumanoid.FillTransparency=0.75
highlightOrHumanoid.OutlineTransparency=0
highlightOrHumanoid.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
highlightOrHumanoid.Adornee=character
highlightOrHumanoid.Parent=espGui
localValue.h=highlightOrHumanoid
localValue.c=character
end
localValue.l.Text=partOrPlayer.DisplayName
end
pcall(function()
updateScreenPosition(localValue.l,head.Position+Vector3.new(0,head.Size.Y*0.5+0.5,0))
end)
end
end
end
for partOrPlayer,localValue in pairs(playerEspEntries) do
if not trackedObjects[partOrPlayer] then
pcall(function() localValue.l:Destroy() end)
pcall(function() localValue.h:Destroy() end)
playerEspEntries[partOrPlayer]=nil
end
end
end)
end
local lootEspEntries={}
local lootNames={GoldPile="Gold",Toolbox="Toolbox",Toolbox_Locked="Toolbox [Locked]"}
local function clearLootEsp()
for localObject,localValue in pairs(lootEspEntries) do
pcall(function() localValue.l:Destroy() end)
pcall(function() localValue.h:Destroy() end)
end
table.clear(lootEspEntries)
end
local function createLootEsp(localObject,labelText)
if lootEspEntries[localObject] then return end
local anchorPart=nil
if localObject:IsA("BasePart") then
anchorPart=localObject
else
local transparencyParts=-math.huge
for _,localObject in ipairs(localObject:GetDescendants()) do
if localObject:IsA("BasePart") and localObject.Position.Y>transparencyParts then transparencyParts=localObject.Position.Y anchorPart=localObject end
end
end
if not anchorPart then return end
local highlightOrHumanoid=Instance.new("Highlight")
highlightOrHumanoid.FillColor=lightYellow
highlightOrHumanoid.OutlineColor=lightYellow
highlightOrHumanoid.FillTransparency=0.5
highlightOrHumanoid.OutlineTransparency=0
highlightOrHumanoid.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
highlightOrHumanoid.Adornee=localObject
highlightOrHumanoid.Parent=espGui
local labelOrFrame=Instance.new("TextLabel")
labelOrFrame.BackgroundTransparency=1
labelOrFrame.Size=UDim2.fromOffset(100,20)
labelOrFrame.AnchorPoint=Vector2.new(0.5,0.5)
labelOrFrame.Font=Enum.Font.BuilderSansExtraBold
labelOrFrame.Text=labelText
labelOrFrame.TextXAlignment=Enum.TextXAlignment.Center
labelOrFrame.TextYAlignment=Enum.TextYAlignment.Center
labelOrFrame.TextColor3=lightYellow
labelOrFrame.TextStrokeColor3=Color3.new(0,0,0)
labelOrFrame.TextStrokeTransparency=0
labelOrFrame.TextScaled=false
labelOrFrame.TextSize=14
labelOrFrame.Visible=false
labelOrFrame.Parent=espGui
lootEspEntries[localObject]={l=labelOrFrame,h=highlightOrHumanoid,a=anchorPart}
end
local function updateLootEsp(mainFrame)
local trackedObjects={}
local function scanObjects()
local currentRoom=tonumber(LocalPlayer:GetAttribute("CurrentRoom"))
local room=currentRoom and currentRooms:FindFirstChild(tostring(currentRoom))
local nextObjects={}
if room then
for _,localObject in ipairs(room:GetDescendants()) do
if lootNames[localObject.Name] then
nextObjects[localObject]=true
if not lootEspEntries[localObject] then
local labelText=lootNames[localObject.Name]
if localObject.Name=="GoldPile" then labelText=labelText.." "..tostring(localObject:GetAttribute("GoldValue")) end
pcall(createLootEsp,localObject,labelText)
end
end
end
end
for localObject,localValue in pairs(lootEspEntries) do
if not nextObjects[localObject] then
pcall(function() localValue.l:Destroy() end)
pcall(function() localValue.h:Destroy() end)
lootEspEntries[localObject]=nil
end
end
trackedObjects=nextObjects
end
task.spawn(function()
while true do
task.wait(0.5)
if isOldGeneration() then break end
if mainFrame.get() then scanObjects()
elseif next(lootEspEntries) then clearLootEsp() trackedObjects={} end
end
end)
runService.Heartbeat:Connect(function()
if isOldGeneration() then return end
if not mainFrame.get() then return end
for localObject,localValue in pairs(lootEspEntries) do
pcall(function()
if not trackedObjects[localObject] or not localValue.a:IsDescendantOf(workspace) then localValue.l.Visible=false return end
updateScreenPosition(localValue.l,localValue.a.Position)
end)
end
end)
end
local itemEspEntries={}
local itemNames={Lighter="Lighter",Flashlight="Flashlight",Lockpick="Lockpick",SkeletonKey="Skeleton Key",Candle="Candle",Shears="Shears",AlarmClock="Alarm Clock",Smoothie="Smoothie",RiftCandle="Moonlight Candle",TipJar="Tip Jar",Donut="Donut",RiftSmoothie="Moonlight Float",RiftJar="Rift Jar",Vitamins="Vitamins",Crucifix="Crucifix",Battery="Battery",Bandage="Bandage",Green_Herb="Green Herb",GweenSoda="Gween Soda",Bread="Bread",Cheese="Cheese",StarVial="Starlight Vial",StarBottle="Starlight Bottle",Glowsticks="Glowstick",BandagePack="Bandage Pack",Bulklight="Bulklight",LaserPointer="Laser Pointer",BatteryPack="Battery Pack",StardustPickup="Stardust",Straplight="Straplight"}
local jeffShopSlots={PurchasableItem1=true,PurchasableItem2=true,PurchasableItem3=true,PurchasableItem4=true,PurchasableItem5=true}
local function getJeffShopRestrictedObject(instance)
local restricted=nil
local parent=instance
while parent do
if jeffShopSlots[parent.Name] or parent.Name=="TipJar" then restricted=parent end
if parent.Name=="JeffShop_Mines" then return restricted end
parent=parent.Parent
end
return nil
end
local function clearItemEsp()
for localObject,localValue in pairs(itemEspEntries) do
pcall(function() localValue.l:Destroy() end)
pcall(function() localValue.h:Destroy() end)
if localValue.m then localValue.m:Destroy() end
end
table.clear(itemEspEntries)
end
mainGui.Destroying:Connect(clearItemEsp)
local function createItemEsp(localObject,labelText)
if itemEspEntries[localObject] then return end
local anchorPart=nil
if localObject:IsA("BasePart") then
anchorPart=localObject
else
local transparencyParts=-math.huge
for _,localObject in ipairs(localObject:GetDescendants()) do
if localObject:IsA("BasePart") and localObject.Position.Y>transparencyParts then transparencyParts=localObject.Position.Y anchorPart=localObject end
end
end
if not anchorPart then return end
local adornee=localObject
local proxy=nil
if localObject.Name=="TipJar" and getJeffShopRestrictedObject(localObject)==localObject then
local sourceParts=localObject:QueryDescendants("BasePart")
proxy=Instance.new("Model")
proxy.Name="ESPProxy"
proxy.Parent=localObject
local humanoid=Instance.new("Humanoid")
humanoid.DisplayDistanceType=Enum.HumanoidDisplayDistanceType.None
humanoid.Parent=proxy
for _,source in ipairs(sourceParts) do
local part=source:Clone()
part:ClearAllChildren()
part.Transparency=0.999
part.CanCollide=false
part.CanTouch=false
part.CanQuery=false
part.Anchored=false
part.Massless=true
part.Parent=proxy
local weld=Instance.new("WeldConstraint")
weld.Part0=part
weld.Part1=source
weld.Parent=part
end
adornee=proxy
end
local highlightOrHumanoid=Instance.new("Highlight")
highlightOrHumanoid.FillColor=lightBlue
highlightOrHumanoid.OutlineColor=lightBlue
highlightOrHumanoid.FillTransparency=0.5
highlightOrHumanoid.OutlineTransparency=0
highlightOrHumanoid.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
highlightOrHumanoid.Adornee=adornee
highlightOrHumanoid.Parent=espGui
local labelOrFrame=Instance.new("TextLabel")
labelOrFrame.BackgroundTransparency=1
labelOrFrame.Size=UDim2.fromOffset(100,20)
labelOrFrame.AnchorPoint=Vector2.new(0.5,0.5)
labelOrFrame.Font=Enum.Font.BuilderSansExtraBold
labelOrFrame.Text=labelText
labelOrFrame.TextXAlignment=Enum.TextXAlignment.Center
labelOrFrame.TextYAlignment=Enum.TextYAlignment.Center
labelOrFrame.TextColor3=lightBlue
labelOrFrame.TextStrokeColor3=Color3.new(0,0,0)
labelOrFrame.TextStrokeTransparency=0
labelOrFrame.TextScaled=false
labelOrFrame.TextSize=14
labelOrFrame.Visible=false
labelOrFrame.Parent=espGui
itemEspEntries[localObject]={l=labelOrFrame,h=highlightOrHumanoid,a=anchorPart,m=proxy}
end
local function updateItemEsp(mainFrame)
local trackedObjects={}
local function scanObjects()
local currentRoom=tonumber(LocalPlayer:GetAttribute("CurrentRoom"))
local room=currentRoom and currentRooms:FindFirstChild(tostring(currentRoom))
local dropsFolder=workspace:FindFirstChild("Drops")
local character=LocalPlayer.Character
local rootPosition=character and character:FindFirstChild("HumanoidRootPart") and character.HumanoidRootPart.Position
local nextObjects={}
local function scanRoot(rt,md)
for _,localObject in ipairs(rt:GetDescendants()) do
local labelText=itemNames[localObject.Name]
if labelText then
local invalid=false
if localObject.Name=="Lighter" then
local parent=localObject.Parent
while parent do
if parent.Name=="Bookcase" then invalid=true break end
parent=parent.Parent
end
elseif localObject.Name=="Battery" then
local parent=localObject.Parent
while parent do
if parent.Name=="BatteryPack" then invalid=true break end
parent=parent.Parent
end
end
if not invalid and md then
if not rootPosition then invalid=true
else
local autoInteractFeatures=nil
if localObject:IsA("BasePart") then autoInteractFeatures=localObject.Position
else
local transparencyParts=-math.huge
for _,localObject in ipairs(localObject:GetDescendants()) do
if localObject:IsA("BasePart") and localObject.Position.Y>transparencyParts then transparencyParts=localObject.Position.Y autoInteractFeatures=localObject.Position end
end
end
if not autoInteractFeatures or (autoInteractFeatures-rootPosition).Magnitude>md then invalid=true end
end
end
if not invalid then nextObjects[localObject]=true if not itemEspEntries[localObject] then pcall(createItemEsp,localObject,labelText) end end
end
end
end
if room then scanRoot(room) end
if dropsFolder then scanRoot(dropsFolder,50) end
for localObject,localValue in pairs(itemEspEntries) do
if not nextObjects[localObject] then
pcall(function() localValue.l:Destroy() end)
pcall(function() localValue.h:Destroy() end)
if localValue.m then localValue.m:Destroy() end
itemEspEntries[localObject]=nil
end
end
trackedObjects=nextObjects
end
task.spawn(function()
while true do
task.wait(0.5)
if isOldGeneration() then break end
if mainFrame.get() then scanObjects()
elseif next(itemEspEntries) then clearItemEsp() trackedObjects={} end
end
end)
runService.Heartbeat:Connect(function()
if isOldGeneration() then return end
if not mainFrame.get() then return end
for localObject,localValue in pairs(itemEspEntries) do
pcall(function()
if not trackedObjects[localObject] or not localValue.a:IsDescendantOf(workspace) then localValue.l.Visible=false return end
updateScreenPosition(localValue.l,localValue.a.Position)
end)
end
end)
end
local function setupThirdPerson(mainFrame)
local transparencyParts={}
local function cacheCharacterTransparency()
local character=LocalPlayer.Character
table.clear(transparencyParts)
if not character then return end
for _,localObject in ipairs(character:GetDescendants()) do
if localObject:IsA("Accessory") then
local highlightOrHumanoid=localObject:FindFirstChild("Handle")
if highlightOrHumanoid then transparencyParts[#transparencyParts+1]={partOrPlayer=highlightOrHumanoid,temporaryValue=highlightOrHumanoid.Transparency} end
end
end
local head=character:FindFirstChild("Head")
if head then transparencyParts[#transparencyParts+1]={partOrPlayer=head,temporaryValue=head.Transparency} end
end
LocalPlayer.CharacterAdded:Connect(function(character)
task.spawn(function()
character:WaitForChild("Head",10)
if not isOldGeneration() then cacheCharacterTransparency() end
end)
end)
cacheCharacterTransparency()
runService.RenderStepped:Connect(function()
if isOldGeneration() then return end
local localValue=mainFrame.get()
local cameraOrCorner=workspace.CurrentCamera
if cameraOrCorner and localValue then cameraOrCorner.CFrame=cameraOrCorner.CFrame*CFrame.new(0,1,10) end
for _,addCorner in ipairs(transparencyParts) do
pcall(function()
addCorner.partOrPlayer.Transparency=localValue and 0 or addCorner.temporaryValue
addCorner.partOrPlayer.LocalTransparencyModifier=localValue and 0 or 1
end)
end
end)
end
local function setupDoorReach(mainFrame)
local lastFireTime=0
runService.Heartbeat:Connect(function()
if isOldGeneration() then return end
if not mainFrame.get() then return end
if tick()-lastFireTime<0.1 then return end
local character=LocalPlayer.Character
local rootOrRow=character and character:FindFirstChild("HumanoidRootPart")
if not rootOrRow then return end
for _,room in ipairs(currentRooms:GetChildren()) do
local localObject=room:FindFirstChild("Door")
local part=localObject and localObject:FindFirstChild("Door")
local openRemote=localObject and localObject:FindFirstChild("ClientOpen")
if part and openRemote and (rootOrRow.Position-part.Position).Magnitude<75 then openRemote:FireServer() lastFireTime=tick() end
end
end)
end
local function setupEyesBypass(mainFrame)
runService.Heartbeat:Connect(function()
if isOldGeneration() then return end
if mainFrame.get() then
if workspace:FindFirstChild("Eyes") then remotesFolder.MotorReplication:FireServer(-650) end
end
end)
end
local function setupRemoteBypass(mainFrame,remoteName)
task.spawn(function()
while true do
task.wait(0.25)
if isOldGeneration() then break end
if mainFrame.get() then
local remote=remotesFolder:FindFirstChild(remoteName)
if remote then remote:Destroy() end
end
end
end)
end
local function setupTouchBypass(mainFrame,modelName,hitboxName)
local function removeTouchInterest(instance)
if isOldGeneration() or not mainFrame.get() then return end
local hitbox=instance.Parent
local hazard=hitbox and hitbox.Parent
if instance.Name=="TouchInterest" and hitbox and hitbox.Name==hitboxName and hazard and hazard.Name==modelName then
instance:Destroy()
end
end
local addedConnection=currentRooms.DescendantAdded:Connect(function(instance)
if instance.Name=="TouchInterest" then task.defer(removeTouchInterest,instance) end
end)
task.spawn(function()
while true do
task.wait(0.5)
if isOldGeneration() then addedConnection:Disconnect() break end
if mainFrame.get() then
for _,instance in ipairs(currentRooms:QueryDescendants("#"..modelName.." > #"..hitboxName.." > #TouchInterest")) do
removeTouchInterest(instance)
end
end
end
end)
end
local function setupAnticheatBypass(anticheatToggle)
local anticheatDisabled=false
local stopped=false
local wasEnabled=false
local attemptId=0
local attemptPending=false
local character=nil
local climbingConnection=nil
local connections={}
local remoteConnections={}
local ladderEspEntries={}
local haltSeenRooms={}
local haltPending=false
local lastScan=0
local ladderColor=Color3.fromRGB(10,0,170)
local function clearLadderEsp()
for ladder,entry in pairs(ladderEspEntries) do
entry.l:Destroy()
entry.h:Destroy()
ladderEspEntries[ladder]=nil
end
end
local function refreshLadderEsp()
if stopped or isOldGeneration() or not anticheatToggle.get() or anticheatDisabled then clearLadderEsp() return end
local tracked={}
for _,ladder in ipairs(currentRooms:QueryDescendants("#Ladder")) do
if ladder:IsA("BasePart") or (ladder:IsA("Model") and ladder:FindFirstChildWhichIsA("BasePart",true)) then
tracked[ladder]=true
if not ladderEspEntries[ladder] then
local highlight=Instance.new("Highlight")
highlight.FillColor=ladderColor
highlight.OutlineColor=ladderColor
highlight.FillTransparency=0.5
highlight.OutlineTransparency=0
highlight.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
highlight.Adornee=ladder
highlight.Parent=espGui
local label=Instance.new("TextLabel")
label.BackgroundTransparency=1
label.Size=UDim2.fromOffset(100,20)
label.AnchorPoint=Vector2.new(0.5,0.5)
label.Font=Enum.Font.BuilderSansExtraBold
label.Text="Ladder"
label.TextXAlignment=Enum.TextXAlignment.Center
label.TextYAlignment=Enum.TextYAlignment.Center
label.TextColor3=ladderColor
label.TextStrokeColor3=Color3.new(0,0,0)
label.TextStrokeTransparency=0
label.TextSize=14
label.Visible=false
label.Parent=espGui
ladderEspEntries[ladder]={l=label,h=highlight}
end
end
end
for ladder,entry in pairs(ladderEspEntries) do
if not tracked[ladder] then
entry.l:Destroy()
entry.h:Destroy()
ladderEspEntries[ladder]=nil
end
end
end
local function resetBypass()
attemptId=attemptId+1
attemptPending=false
anticheatDisabled=false
refreshLadderEsp()
end
local function tryBypass()
if stopped or isOldGeneration() or not anticheatToggle.get() or anticheatDisabled or attemptPending or not character or character:GetAttribute("Climbing")~=true then return end
attemptPending=true
attemptId=attemptId+1
local thisAttempt=attemptId
local climbingCharacter=character
task.delay(0.25,function()
if stopped or isOldGeneration() or thisAttempt~=attemptId then return end
attemptPending=false
if not anticheatToggle.get() or anticheatDisabled or climbingCharacter~=LocalPlayer.Character or climbingCharacter:GetAttribute("Climbing")~=true then return end
climbingCharacter:SetAttribute("Climbing",false)
if climbingCharacter:GetAttribute("Climbing")==false then
anticheatDisabled=true
clearLadderEsp()
end
end)
end
local function bindCharacter(newCharacter)
if character==newCharacter then return end
if climbingConnection then climbingConnection:Disconnect() climbingConnection=nil end
character=newCharacter
resetBypass()
if character then
climbingConnection=character:GetAttributeChangedSignal("Climbing"):Connect(tryBypass)
tryBypass()
end
end
local function watchRemote(remote)
if remoteConnections[remote] then return end
if remote.Name=="Cutscene" then
remoteConnections[remote]=remote.OnClientEvent:Connect(function(cutsceneName)
if stopped or isOldGeneration() then return end
if not cutsceneName:find("SewerSeek") then resetBypass() end
end)
elseif remote.Name=="UseEnemyModule" then
remoteConnections[remote]=remote.OnClientEvent:Connect(function(moduleName)
if stopped or isOldGeneration() then return end
if moduleName=="Void" or moduleName=="Glitch" then resetBypass() end
end)
end
end
local function scanHaltRooms()
for _,room in ipairs(currentRooms:GetChildren()) do
if not haltSeenRooms[room] then
local rawName=room:GetAttribute("RawName")
if (rawName and rawName:find("Halt")) or room:GetAttribute("Shade")==true then
haltSeenRooms[room]=true
haltPending=true
end
end
end
for room in pairs(haltSeenRooms) do
if room.Parent~=currentRooms then haltSeenRooms[room]=nil end
end
end
local function cleanup()
if stopped then return end
stopped=true
attemptId=attemptId+1
if anticheatDisabled then remotesFolder.ClimbLadder:FireServer() end
anticheatDisabled=false
clearLadderEsp()
if climbingConnection then climbingConnection:Disconnect() end
for _,connection in ipairs(connections) do connection:Disconnect() end
for _,connection in pairs(remoteConnections) do connection:Disconnect() end
end
bindCharacter(LocalPlayer.Character)
for _,remote in ipairs(remotesFolder:GetChildren()) do watchRemote(remote) end
scanHaltRooms()
connections[#connections+1]=remotesFolder.ChildAdded:Connect(watchRemote)
connections[#connections+1]=LocalPlayer.CharacterAdded:Connect(bindCharacter)
connections[#connections+1]=game:GetService("LogService").MessageOut:Connect(function(message)
if stopped or isOldGeneration() then return end
if message=="client teleporting" and haltPending then haltPending=false resetBypass() end
end)
connections[#connections+1]=mainGui.Destroying:Connect(cleanup)
connections[#connections+1]=runService.Heartbeat:Connect(function()
if stopped then return end
if isOldGeneration() then cleanup() return end
if character~=LocalPlayer.Character then bindCharacter(LocalPlayer.Character) end
local enabled=anticheatToggle.get()
if enabled~=wasEnabled then
wasEnabled=enabled
if not enabled and anticheatDisabled then remotesFolder.ClimbLadder:FireServer() end
resetBypass()
if enabled then tryBypass() end
end
local now=os.clock()
if now-lastScan>=0.25 then
lastScan=now
scanHaltRooms()
refreshLadderEsp()
end
if not enabled or anticheatDisabled then return end
for ladder,entry in pairs(ladderEspEntries) do
if not ladder:IsDescendantOf(currentRooms) then
entry.l:Destroy()
entry.h:Destroy()
ladderEspEntries[ladder]=nil
else
local position
if ladder:IsA("Model") then local center=ladder:GetBoundingBox() position=center.Position else position=ladder.Position end
updateScreenPosition(entry.l,position)
end
end
end)
end
local function setupAmbient(ambientToggle,fullbrightToggle)
local whiteAmbient=Color3.fromRGB(255,255,255)
local dimAmbient=Color3.fromRGB(100,100,100)
local lastTween=nil
local function applyAmbient(color)
pcall(function()
if lastTween then lastTween:Cancel() end
lastTween=TweenService:Create(lighting,TweenInfo.new(0.2,Enum.EasingStyle.Exponential),{Ambient=color})
lastTween:Play()
end)
end
local function getRoomAmbient()
return currentRooms:FindFirstChild(tostring(LocalPlayer:GetAttribute("CurrentRoom"))):GetAttribute("Ambient")
end
local wasEnabled=false
local lastAmbientEnabled,lastFullbrightEnabled=false,false
runService.Heartbeat:Connect(function()
if isOldGeneration() then return end
local ambientEnabled=ambientToggle.get()
local fullbrightEnabled=fullbrightToggle.get()
if fullbrightEnabled and not lastFullbrightEnabled then
ambientToggle.set(false)
ambientEnabled=false
elseif ambientEnabled and not lastAmbientEnabled then
fullbrightToggle.set(false)
fullbrightEnabled=false
end
local enabled=ambientEnabled or fullbrightEnabled
if enabled then
local color=ambientEnabled and whiteAmbient or dimAmbient
if lighting.Ambient~=color then applyAmbient(color) end
elseif wasEnabled then
applyAmbient(getRoomAmbient())
end
wasEnabled=enabled
lastAmbientEnabled=ambientEnabled
lastFullbrightEnabled=fullbrightEnabled
end)
end
local autoInteractBlacklist={InteractPrompt=true,RevivePrompt=true,Prompt=true}
local drawerNames={DrawerContainer=true,Locker_Small=true,Toolshed_Small=true}
local promptCooldown={}
local function firePrompt(prompt)
if not prompt or not prompt:IsA("ProximityPrompt") or promptCooldown[prompt] then return end
promptCooldown[prompt]=true
task.spawn(function()
fireproximityprompt(prompt,0)
task.wait()
promptCooldown[prompt]=nil
end)
end
local function triggerPrompt(prompt,autoToggles)
if not prompt or not prompt.Parent then return end
if getJeffShopRestrictedObject(prompt) then return end
if autoInteractBlacklist[prompt.Name] then return end
if prompt.Name=="ActivateEventPrompt" and prompt.ActionText=="Close" then return end
local category=nil
local a=prompt.Parent
while a do
if getObjectiveLabel(a) then category="objectives" break
elseif itemNames[a.Name] then category="items" break
elseif lootNames[a.Name] then category="loot" break end
a=a.Parent
end
if not category then
local p=prompt.Parent
while p do
if drawerNames[p.Name] then category="drawers" break end
p=p.Parent
end
end
if not category then return end
if category~="drawers" then
if not autoToggles[category].get() then return end
end
firePrompt(prompt)
end
local lastAutoInteractFire=0
local function setupAutoInteract(mainToggle,autoToggles)
local promptList={}
task.spawn(function()
while true do
task.wait(0.1)
if isOldGeneration() then break end
if mainToggle.get() then
local nextList={}
for _,obj in ipairs(currentRooms:QueryDescendants("ProximityPrompt")) do
nextList[#nextList+1]=obj
end
local dropsFolder=workspace:FindFirstChild("Drops")
if dropsFolder then
for _,obj in ipairs(dropsFolder:QueryDescendants("ProximityPrompt")) do
nextList[#nextList+1]=obj
end
end
promptList=nextList
else
promptList={}
end
end
end)
runService.Heartbeat:Connect(function()
if isOldGeneration() then return end
if not mainToggle.get() then return end
if tick()-lastAutoInteractFire<1/60 then return end
for _,prompt in ipairs(promptList) do
pcall(function()
local parent=prompt.Parent
if parent then
local position
if parent:IsA("Attachment") then position=parent.WorldPosition
elseif parent:IsA("BasePart") then position=parent.Position
elseif parent:IsA("Model") then position=parent:GetPivot().Position end
if not position then return end
local dist=LocalPlayer:DistanceFromCharacter(position)
if (dist<=prompt.MaxActivationDistance and prompt.Enabled) or (dist<=prompt.MaxActivationDistance and (prompt.Name=="LongPushPrompt" or prompt.Name=="BigPropPrompt")) then
task.spawn(function() triggerPrompt(prompt,autoToggles) end)
end
end
end)
end
lastAutoInteractFire=tick()
end)
end
local function setupAnticheatManipulation(mainFrame)
local buttonOrVelocity=Instance.new("BodyVelocity")
buttonOrVelocity.MaxForce=Vector3.new(9e9,9e9,9e9)
local localState={}
runService.Heartbeat:Connect(function()
if isOldGeneration() then return end
local localValue=mainFrame.get()
setNoCollision(localState,localValue)
if localValue then
local character=LocalPlayer.Character
local rootOrRow=character and character:FindFirstChild("HumanoidRootPart")
if rootOrRow then buttonOrVelocity.Parent=rootOrRow buttonOrVelocity.Velocity=rootOrRow.CFrame.LookVector*2.25 else buttonOrVelocity.Parent=nil end
else
buttonOrVelocity.Parent=nil
end
end)
end
local function setupAutoAnchor(mainToggle)
local lastAttempt=0
local busy=false
runService.Heartbeat:Connect(function()
if isOldGeneration() or not mainToggle.get() or busy then return end
local hint=LocalPlayer.PlayerGui.MainUI:FindFirstChild("AnchorHintFrame")
if not hint or tick()-lastAttempt<=0.1 then return end
lastAttempt=tick()
for _,anchor in ipairs(currentRooms:QueryDescendants("#MinesAnchor")) do
if anchor:FindFirstChild("Sign") and anchor.Sign.TextLabel.Text==hint.AnchorCode.Text then
if not anchor:GetAttribute("Activated") and LocalPlayer:DistanceFromCharacter(anchor.PrimaryPart.Position)<anchor.ActivateEventPrompt.MaxActivationDistance then
busy=true
anchor:WaitForChild("AnchorRemote"):InvokeServer(hint.Code.Text)
busy=false
end
break
end
end
end)
end
local function setupAutoCompleteClick(rootOrRow,titleLabel)
local edgeMargin=-10
titleLabel.Size=UDim2.new(1,-70,0,50)
local clickButton=createInstance("TextButton",rootOrRow)
clickButton.Size=UDim2.new(0,25,0,25)
clickButton.Position=UDim2.new(1,edgeMargin-25,0,12)
clickButton.BackgroundColor3=darkBackground
clickButton.AutoButtonColor=false
clickButton.Font=sourceSansFont
clickButton.TextSize=20
clickButton.TextColor3=WHITE
clickButton.Text="click"
clickButton.AutomaticSize=Enum.AutomaticSize.X
addCorner(clickButton,6)
local padding=Instance.new("UIPadding")
padding.PaddingLeft=UDim.new(0,6)
padding.PaddingRight=UDim.new(0,6)
padding.Parent=clickButton
local function alignButton()
clickButton.Position=UDim2.new(1,edgeMargin-clickButton.AbsoluteSize.X,0,12)
end
clickButton:GetPropertyChangedSignal("AbsoluteSize"):Connect(alignButton)
alignButton()
local running,stopped=false,false
local runRoom,activeCharacter,activeWheel,activePrompt=nil,nil,nil,nil
local elapsed,lastFrame,lastScan=0,0,0
local wheels={}
local visited,completed={},{}
local completionConnections={}
local connection
local function finish()
running=false
runRoom=nil
activeCharacter=nil
activeWheel=nil
activePrompt=nil
elapsed=0
end
local function scanWheels()
local room=currentRooms:FindFirstChild("100")
wheels={}
if room then wheels=room:QueryDescendants("#WaterPump > #Wheel") end
local tracked={}
for _,wheel in ipairs(wheels) do
tracked[wheel]=true
local sound=wheel:FindFirstChild("Sound")
if sound and not completionConnections[wheel] then
completionConnections[wheel]=sound.Played:Connect(function() completed[wheel]=true end)
if sound.IsPlaying then completed[wheel]=true end
end
end
for wheel,listener in pairs(completionConnections) do
if not tracked[wheel] then listener:Disconnect() completionConnections[wheel]=nil completed[wheel]=nil end
end
end
local function cleanup()
stopped=true
finish()
if connection then connection:Disconnect() end
for wheel,listener in pairs(completionConnections) do listener:Disconnect() completionConnections[wheel]=nil end
end
local function nextWheel()
local selected,prompt=nil,nil
local height=-math.huge
local allDone=#wheels>0
for _,wheel in ipairs(wheels) do
if wheel:IsDescendantOf(runRoom) and not visited[wheel] and not completed[wheel] then
allDone=false
local valve=wheel:FindFirstChild("ValvePrompt")
if valve and valve.Enabled and wheel.Position.Y>height then selected=wheel prompt=valve height=wheel.Position.Y end
end
end
return selected,prompt,allDone
end
local function advance()
if stopped or not running then return end
if isOldGeneration() then cleanup() return end
local character=LocalPlayer.Character
local root=character and character:FindFirstChild("HumanoidRootPart")
if character~=activeCharacter or not root or runRoom.Parent~=currentRooms then finish() return end
local now=os.clock()
local delta=now-lastFrame
lastFrame=now
if LocalPlayer:GetAttribute("InCutscene")==true then return end
if activeWheel then
if not activeWheel:IsDescendantOf(runRoom) or not activePrompt:IsDescendantOf(activeWheel) then
activeWheel=nil
activePrompt=nil
elapsed=0
else
elapsed=elapsed+delta
if elapsed>=2 then
visited[activeWheel]=true
activeWheel=nil
activePrompt=nil
elapsed=0
end
end
end
if not activeWheel then
local wheel,prompt,allDone=nextWheel()
if not wheel then if allDone then finish() end return end
activeWheel=wheel
activePrompt=prompt
elapsed=0
root.CFrame=wheel.Parent:GetPivot()
end
if activePrompt.Enabled and LocalPlayer:DistanceFromCharacter(activeWheel.Position)<=activePrompt.MaxActivationDistance then firePrompt(activePrompt) end
end
scanWheels()
connection=runService.Heartbeat:Connect(function()
if isOldGeneration() then cleanup() return end
local now=os.clock()
if now-lastScan>=0.25 then lastScan=now scanWheels() end
advance()
end)
mainGui.Destroying:Connect(cleanup)
clickButton.MouseButton1Click:Connect(function()
if stopped or isOldGeneration() or running then return end
local character=LocalPlayer.Character
local room=currentRooms:FindFirstChild("100")
if not character or not character:FindFirstChild("HumanoidRootPart") or not room then return end
scanWheels()
table.clear(visited)
running=true
runRoom=room
activeCharacter=character
activeWheel=nil
activePrompt=nil
elapsed=0
lastFrame=os.clock()
advance()
task.spawn(function()
clickButton.BackgroundColor3=gray
task.wait(0.15)
if not stopped then clickButton.BackgroundColor3=darkBackground end
end)
end)
end
local function setupCamera(fa,speedToggle,ca)
local mainGame=require(LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game)
local savedFov,featureToggle,sx=70,false,false
runService.RenderStepped:Connect(function()
if isOldGeneration() then return end
local localValue=fa.get()
local cameraOrCorner=workspace.CurrentCamera
if cameraOrCorner then
if localValue then
if not featureToggle then savedFov=cameraOrCorner.FieldOfView end
cameraOrCorner.FieldOfView=120
elseif featureToggle then
cameraOrCorner.FieldOfView=savedFov
end
end
featureToggle=localValue
if speedToggle.get() then mainGame.csgo=CFrame.new() end
local localObject=ca.get()
if localObject and not sx then
local localState=remotesFolder:FindFirstChild("Cutscene")
if localState then localState:Destroy() end
end
sx=localObject
end)
end
local function localState(partOrPlayer,setupKeybind,ini,mn,mx)
local cameraOrCorner=createInstance("Frame",partOrPlayer)
cameraOrCorner.Size=UDim2.new(1,0,0,40)
cameraOrCorner.Position=UDim2.new(0,0,0,setupKeybind)
cameraOrCorner.BackgroundTransparency=1
local track=createInstance("Frame",cameraOrCorner)
track.Size=UDim2.new(1,-80,0,6)
track.Position=UDim2.new(0,10,0.5,-3)
track.BackgroundColor3=Color3.fromRGB(80,80,88)
track.Active=true
addCorner(track,3)
local fill=createInstance("Frame",track)
fill.BackgroundColor3=GREEN
addCorner(fill,3)
local knob=createInstance("Frame",track)
knob.Size=UDim2.new(0,14,0,14)
knob.BackgroundColor3=WHITE
knob.Active=true
addCorner(knob,7)
local valueLabel=createInstance("TextLabel",cameraOrCorner)
valueLabel.Size=UDim2.new(0,50,1,0)
valueLabel.Position=UDim2.new(1,-60,0,0)
valueLabel.BackgroundTransparency=1
valueLabel.Font=sourceSansFont
valueLabel.TextSize=20
valueLabel.TextColor3=lightGray
valueLabel.TextXAlignment=Enum.TextXAlignment.Right
local currentRoom=ini
local function setValue(localValue)
localValue=math.clamp(math.floor(localValue+0.5),mn,mx)
currentRoom=localValue
local scale=(localValue-mn)/(mx-mn)
fill.Size=UDim2.new(scale,0,1,0)
knob.Position=UDim2.new(scale,-7,0.5,-7)
valueLabel.Text=tostring(localValue)
end
setValue(ini)
local dragging=false
local function updateSlider(dx)
local trackX=track.AbsolutePosition.X
local trackWidth=track.AbsoluteSize.X
setValue(mn+math.clamp((dx-trackX)/trackWidth,0,1)*(mx-mn))
end
local function beginDrag(ip)
if ip.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true updateSlider(ip.Position.X) end
end
track.InputBegan:Connect(beginDrag)
knob.InputBegan:Connect(beginDrag)
UserInputService.InputChanged:Connect(function(ip)
if dragging and ip.UserInputType==Enum.UserInputType.MouseMovement then updateSlider(ip.Position.X) end
end)
UserInputService.InputEnded:Connect(function(ip)
if ip.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end
end)
return {get=function() return currentRoom end,frame=cameraOrCorner}
end
local function setupKeybind(rootOrRow,titleLabel,dk,sx,speedToggle,md)
local keybindRightOffset=sx-6
titleLabel.Size=UDim2.new(1,keybindRightOffset-35,0,50)
local keybindButton=createInstance("TextButton",rootOrRow)
keybindButton.Size=UDim2.new(0,25,0,25)
keybindButton.Position=UDim2.new(1,keybindRightOffset-25,0,12)
keybindButton.BackgroundColor3=darkBackground
keybindButton.AutoButtonColor=false
keybindButton.Font=sourceSansFont
keybindButton.TextSize=20
keybindButton.TextColor3=WHITE
keybindButton.Text=dk
keybindButton.AutomaticSize=Enum.AutomaticSize.X
addCorner(keybindButton,6)
local padding=Instance.new("UIPadding")
padding.PaddingLeft=UDim.new(0,6)
padding.PaddingRight=UDim.new(0,6)
padding.Parent=keybindButton
local listening=false
local function alignKeybind()
keybindButton.Position=UDim2.new(1,keybindRightOffset-keybindButton.AbsoluteSize.X,0,12)
end
keybindButton:GetPropertyChangedSignal("AbsoluteSize"):Connect(alignKeybind)
alignKeybind()
keybindButton.MouseButton1Click:Connect(function() listening=true keybindButton.Text="..." end)
UserInputService.InputBegan:Connect(function(ip)
if ip.UserInputType~=Enum.UserInputType.Keyboard then return end
if listening then
listening=false
keybindButton.Text=ip.KeyCode==Enum.KeyCode.Escape and "nothing" or ip.KeyCode.Name
return
end
local buttonOrVelocity=keybindButton.Text
if buttonOrVelocity=="nothing" or buttonOrVelocity=="..." then return end
if ip.KeyCode.Name~=buttonOrVelocity then return end
if md=="toggle" then speedToggle.set(not speedToggle.get()) else speedToggle.set(true) end
end)
UserInputService.InputEnded:Connect(function(ip)
if md~="hold" then return end
if ip.UserInputType~=Enum.UserInputType.Keyboard then return end
local buttonOrVelocity=keybindButton.Text
if buttonOrVelocity=="nothing" or buttonOrVelocity=="..." then return end
if ip.KeyCode.Name==buttonOrVelocity then speedToggle.set(false) end
end)
local paperOrPosition=createInstance("Frame",mainFrame)
paperOrPosition.Size=UDim2.new(0,100,0,62)
paperOrPosition.BackgroundColor3=darkBackground
paperOrPosition.Visible=false
addCorner(paperOrPosition,6)
paperOrPosition.ZIndex=51
local valueLabel=createInstance("TextButton",mainFrame)
valueLabel.Size=UDim2.new(1,0,1,0)
valueLabel.BackgroundTransparency=1
valueLabel.Text=""
valueLabel.AutoButtonColor=false
valueLabel.Visible=false
valueLabel.ZIndex=50
valueLabel.MouseButton1Click:Connect(function() valueLabel.Visible=false paperOrPosition.Visible=false end)
local modeLines,mb={},{}
for kk,mm in ipairs({"hold","toggle"}) do
local buttonOrVelocity=createInstance("TextButton",paperOrPosition)
buttonOrVelocity.Size=UDim2.new(1,-12,0,24)
buttonOrVelocity.Position=UDim2.new(0,6,0,5+(kk-1)*28)
buttonOrVelocity.BackgroundTransparency=1
buttonOrVelocity.AutoButtonColor=false
buttonOrVelocity.Font=sourceSansFont
buttonOrVelocity.TextSize=20
buttonOrVelocity.TextXAlignment=Enum.TextXAlignment.Left
buttonOrVelocity.Text="  "..mm
buttonOrVelocity.TextColor3=mm==md and WHITE or lightGray
buttonOrVelocity.ZIndex=52
local uiObject=createInstance("Frame",buttonOrVelocity)
uiObject.Size=UDim2.new(1,0,0,2)
uiObject.Position=UDim2.new(0,0,1,-2)
uiObject.BackgroundColor3=GREEN
uiObject.Visible=mm==md
uiObject.ZIndex=52
addGradient(uiObject)
modeLines[mm]=uiObject
mb[mm]=buttonOrVelocity
buttonOrVelocity.MouseButton1Click:Connect(function()
md=mm
for nm,ln in pairs(modeLines) do
ln.Visible=(nm==mm)
mb[nm].TextColor3=nm==mm and WHITE or lightGray
end
valueLabel.Visible=false
paperOrPosition.Visible=false
end)
end
keybindButton.InputBegan:Connect(function(ip)
if ip.UserInputType==Enum.UserInputType.MouseButton2 then
local mainPosition=mainFrame.AbsolutePosition
local keybindPosition=keybindButton.AbsolutePosition
paperOrPosition.Position=UDim2.new(0,keybindPosition.X-mainPosition.X-6-100,0,keybindPosition.Y-mainPosition.Y-18.5)
paperOrPosition.Visible=not paperOrPosition.Visible
valueLabel.Visible=paperOrPosition.Visible
end
end)
end
local mainFeatures={"speed","fly","noclip","door reach","bypass","auto interact","anticheat manipulation","auto anchor","auto complete"}
local rowHeight=50
local expandedHeights={[1]=140,[2]=95,[5]=325,[6]=145}
local bypassFeatures={"anticheat","screech","giggle","halt","dupe","timothy","gloombat eggs","dread","eyes"}
local autoInteractFeatures={"objectives","items","loot"}
local espFeatures={"door esp","objective esp","item esp","loot esp","closet esp","players esp","entities esp","anchor esp"}
local visualFeatures={"camera","ambient","fullbright","esp","thirdperson"}
local visualExpandedHeights={[1]=155,[4]=295}
local visualRows={}
local visualRowHeights={rowHeight,rowHeight,rowHeight,rowHeight,rowHeight}
local mainRows={}
local mainRowHeights={rowHeight,rowHeight,rowHeight,rowHeight,rowHeight,rowHeight,rowHeight,rowHeight,rowHeight}
local bypassToggles={}
local contentScroller=createInstance("ScrollingFrame",mainFrame)
contentScroller.Position=UDim2.new(0,209,0,10)
contentScroller.Size=UDim2.new(1,-219,1,-20)
contentScroller.BackgroundTransparency=1
contentScroller.ScrollingDirection=Enum.ScrollingDirection.Y
contentScroller.ScrollBarThickness=8
contentScroller.ScrollBarImageColor3=darkBackground
local function getTotalHeight(rz)
local temporaryValue=0
for _,highlightOrHumanoid in ipairs(rz) do temporaryValue=temporaryValue+highlightOrHumanoid+5 end
return temporaryValue-5
end
local function layoutRows(rs,rz)
local yOffset=0
for j,rootOrRow in ipairs(rs) do
TweenService:Create(rootOrRow,TWEEN_FAST,{Position=UDim2.new(0,0,0,yOffset)}):Play()
yOffset=yOffset+rz[j]+5
end
TweenService:Create(contentScroller,TWEEN_FAST,{CanvasSize=UDim2.new(0,0,0,yOffset-5)}):Play()
end
local function setupExpandButton(rootOrRow,instance,eh,rz,rs)
local gradientOrGlobals=createInstance("ImageButton",rootOrRow)
gradientOrGlobals.Size=UDim2.new(0,25,0,25)
gradientOrGlobals.Position=UDim2.new(1,-35,0,12)
gradientOrGlobals.BackgroundTransparency=1
gradientOrGlobals.AutoButtonColor=false
gradientOrGlobals.Image="rbxassetid://130739566847600"
local expanded,cooldown=false,false
gradientOrGlobals.MouseButton1Click:Connect(function()
if cooldown then return end
cooldown=true
expanded=not expanded
TweenService:Create(gradientOrGlobals,TWEEN_FAST,{Rotation=expanded and 180 or 0,ImageColor3=expanded and GREEN or WHITE}):Play()
rz[instance]=expanded and eh[instance] or rowHeight
TweenService:Create(rootOrRow,TWEEN_FAST,{Size=UDim2.new(1,-20,0,rz[instance])}):Play()
layoutRows(rs,rz)
task.wait(0.2)
cooldown=false
end)
end
local speedToggle=nil
for instance,name in ipairs(mainFeatures) do
local isBypass=name=="bypass"
local rootOrRow=createInstance("Frame",contentScroller)
rootOrRow.Size=UDim2.new(1,-20,0,rowHeight)
rootOrRow.Position=UDim2.new(0,0,0,(instance-1)*55)
rootOrRow.BackgroundColor3=panelBackground
rootOrRow.ClipsDescendants=true
addCorner(rootOrRow,6)
local titleLabel=createInstance("TextLabel",rootOrRow)
titleLabel.Size=(expandedHeights[instance] and not isBypass) and UDim2.new(1,-110,0,50) or UDim2.new(1,-60,0,50)
titleLabel.BackgroundTransparency=1
titleLabel.Font=sourceSansFont
titleLabel.TextSize=20
titleLabel.TextColor3=lightGray
titleLabel.TextXAlignment=Enum.TextXAlignment.Left
titleLabel.Text="    "..name
local featureToggle=nil
if not isBypass and name~="auto complete" then featureToggle=temporaryValue(rootOrRow,expandedHeights[instance] and UDim2.new(1,-77,0,19) or UDim2.new(1,-44,0,19)) end
mainRows[instance]=rootOrRow
if expandedHeights[instance] then setupExpandButton(rootOrRow,instance,expandedHeights,mainRowHeights,mainRows) end
if name=="speed" then
speedToggle=featureToggle
setupSpeed(featureToggle,localState(rootOrRow,55,22,10,90),localObject(rootOrRow,100,"no acceleration",40))
elseif name=="fly" then
setupFly(featureToggle,localState(rootOrRow,55,22,10,90),speedToggle)
setupKeybind(rootOrRow,titleLabel,"F",-77,featureToggle,"toggle")
elseif name=="noclip" then
setupNoclip(featureToggle)
setupKeybind(rootOrRow,titleLabel,"N",-44,featureToggle,"toggle")
elseif name=="door reach" then
setupDoorReach(featureToggle)
elseif name=="anticheat manipulation" then
setupAnticheatManipulation(featureToggle)
setupKeybind(rootOrRow,titleLabel,"Z",-44,featureToggle,"hold")
elseif name=="auto anchor" then
setupAutoAnchor(featureToggle)
elseif name=="auto complete" then
setupAutoCompleteClick(rootOrRow,titleLabel)
elseif name=="bypass" then
for kk,it in ipairs(bypassFeatures) do bypassToggles[it]=localObject(rootOrRow,55+(kk-1)*30,it,30) end
setupRemoteBypass(bypassToggles.screech,"Screech")
setupTouchBypass(bypassToggles.giggle,"GiggleCeiling","Hitbox")
setupRemoteBypass(bypassToggles.halt,"ShadeResult")
setupTouchBypass(bypassToggles.dupe,"DoorFake","Hidden")
setupRemoteBypass(bypassToggles.timothy,"SpiderJumpscare")
setupRemoteBypass(bypassToggles.dread,"Dread")
setupTouchBypass(bypassToggles["gloombat eggs"],"GloomEgg","Egg")
setupAnticheatBypass(bypassToggles.anticheat)
setupEyesBypass(bypassToggles.eyes)
elseif name=="auto interact" then
setupKeybind(rootOrRow,titleLabel,"R",-77,featureToggle,"hold")
local autoToggles={}
for kk,it in ipairs(autoInteractFeatures) do autoToggles[it]=localObject(rootOrRow,55+(kk-1)*30,it,30) end
setupAutoInteract(featureToggle,autoToggles)
end
end
local ambientToggle,fullbrightToggle
for instance,name in ipairs(visualFeatures) do
local rootOrRow=createInstance("Frame",contentScroller)
rootOrRow.Size=UDim2.new(1,-20,0,rowHeight)
rootOrRow.Position=UDim2.new(0,0,0,(instance-1)*55)
rootOrRow.BackgroundColor3=panelBackground
rootOrRow.ClipsDescendants=true
rootOrRow.Visible=false
addCorner(rootOrRow,6)
local titleLabel=createInstance("TextLabel",rootOrRow)
titleLabel.Size=UDim2.new(1,-60,0,50)
titleLabel.BackgroundTransparency=1
titleLabel.Font=sourceSansFont
titleLabel.TextSize=20
titleLabel.TextColor3=lightGray
titleLabel.TextXAlignment=Enum.TextXAlignment.Left
titleLabel.Text="    "..name
local visualToggle=nil
if name=="thirdperson" or name=="fullbright" or name=="ambient" then visualToggle=temporaryValue(rootOrRow,UDim2.new(1,-44,0,19)) end
if name=="camera" then setupExpandButton(rootOrRow,1,visualExpandedHeights,visualRowHeights,visualRows) elseif name=="esp" then setupExpandButton(rootOrRow,4,visualExpandedHeights,visualRowHeights,visualRows) end
visualRows[instance]=rootOrRow
if name=="camera" then
local fovFeature=localObject(rootOrRow,55,"fov",30)
local c1Value=localObject(rootOrRow,90,"no cutscenes",30)
local noCameraShakeFeature=localObject(rootOrRow,125,"no camera shake",30)
setupCamera(fovFeature,noCameraShakeFeature,c1Value)
elseif name=="esp" then
local sidebar,objectiveToggle,e1,q1,g1,u1,t1,anchorToggle
for kk,it in ipairs(espFeatures) do
local espToggle=localObject(rootOrRow,55+(kk-1)*30,it,30)
if it=="door esp" then sidebar=espToggle elseif it=="objective esp" then objectiveToggle=espToggle elseif it=="entities esp" then e1=espToggle elseif it=="closet esp" then q1=espToggle elseif it=="players esp" then g1=espToggle elseif it=="loot esp" then u1=espToggle elseif it=="item esp" then t1=espToggle elseif it=="anchor esp" then anchorToggle=espToggle end
end
updateDoorEsp(sidebar)
updateObjectiveEsp(objectiveToggle)
updateEntityEsp(e1)
updateClosetEsp(q1)
updatePlayerEsp(g1)
updateLootEsp(u1)
updateItemEsp(t1)
setupAnchorEsp(anchorToggle)
elseif name=="thirdperson" then
setupKeybind(rootOrRow,titleLabel,"T",-44,visualToggle,"toggle")
setupThirdPerson(visualToggle)
elseif name=="fullbright" then
fullbrightToggle=visualToggle
elseif name=="ambient" then
ambientToggle=visualToggle
end
end
setupAmbient(ambientToggle,fullbrightToggle)
contentScroller.CanvasSize=UDim2.new(0,0,0,getTotalHeight(mainRowHeights))
local sidebarIcons={"102026220307992","97670340728331"}
local i2={}
local i3=1
for instance,name in ipairs({"general","visual"}) do
local buttonOrVelocity=createInstance("TextButton",sidebar)
buttonOrVelocity.Size=UDim2.new(1,0,0,46)
buttonOrVelocity.Position=UDim2.new(0,0,0,68+52*(instance-1))
buttonOrVelocity.BackgroundColor3=darkBackground
buttonOrVelocity.AutoButtonColor=false
buttonOrVelocity.Font=sourceSansFont
buttonOrVelocity.TextSize=23
buttonOrVelocity.TextColor3=WHITE
buttonOrVelocity.TextXAlignment=Enum.TextXAlignment.Left
buttonOrVelocity.Text=string.rep(" ",name=="general" and 11 or 12)..name
local im=createInstance("ImageLabel",buttonOrVelocity)
im.Size=UDim2.new(0,30,0,30)
im.Position=UDim2.new(0,name=="general" and 6 or 10,0.5,-11)
im.BackgroundTransparency=1
im.Image="rbxassetid://"..sidebarIcons[instance]
local uiObject=createInstance("Frame",buttonOrVelocity)
uiObject.Size=UDim2.new(1,-20,0,3)
uiObject.Position=UDim2.new(0,10,1,-5)
uiObject.BackgroundColor3=GREEN
uiObject.Visible=instance==1
addGradient(uiObject)
i2[instance]=uiObject
buttonOrVelocity.MouseButton1Click:Connect(function()
if instance==i3 then return end
i3=instance
for _,labelOrFrame in ipairs(i2) do labelOrFrame.Visible=false end
for _,rootOrRow in ipairs(mainRows) do rootOrRow.Visible=(instance==1) end
for _,rootOrRow in ipairs(visualRows) do rootOrRow.Visible=(instance==2) end
contentScroller.CanvasSize=UDim2.new(0,0,0,instance==1 and getTotalHeight(mainRowHeights) or getTotalHeight(visualRowHeights))
local ln=i2[instance]
ln.Visible=true
ln.Size=UDim2.new(0,0,0,3)
ln.Position=UDim2.new(0.5,0,1,-5)
TweenService:Create(ln,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size=UDim2.new(1,-20,0,3),Position=UDim2.new(0,10,1,-5)}):Play()
end)
end
local d3=createInstance("TextLabel",sidebar)
d3.Size=UDim2.new(1,0,0,17)
d3.Position=UDim2.new(0,0,1,-20)
d3.BackgroundTransparency=1
d3.Font=sourceSansFont
d3.TextSize=13
d3.TextColor3=Color3.fromRGB(130,130,135)
d3.TextXAlignment=Enum.TextXAlignment.Left
d3.Text="  place: themines"
local objectiveToggle,o2=mainFrame.Size,mainFrame.Position
local o3Value,o4=UDim2.new(0,40,0,40),UDim2.new(0.5,-20,0.5,-20)
local o5Value,o6=true,false
UserInputService.InputBegan:Connect(function(ip,gp)
if gp or ip.KeyCode~=Enum.KeyCode.RightShift or o6 then return end
o6=true
if o5Value then
local temporaryValue=TweenService:Create(mainFrame,tweenSlow,{Size=o3Value,Position=o4})
temporaryValue:Play()
temporaryValue.Completed:Wait()
mainFrame.Visible=false
o5Value=false
else
mainFrame.Visible=true
mainFrame.Size=o3Value
mainFrame.Position=o4
local temporaryValue=TweenService:Create(mainFrame,tweenSlow,{Size=objectiveToggle,Position=o2})
temporaryValue:Play()
temporaryValue.Completed:Wait()
o5Value=true
end
o6=false
end)
