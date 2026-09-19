local coreGui=game:GetService("CoreGui")
local tweenService=game:GetService("TweenService")
local userInputService=game:GetService("UserInputService")
local players=game:GetService("Players")
local localPlayer=players.LocalPlayer
local runService=game:GetService("RunService")
local replicatedStorage=game:GetService("ReplicatedStorage")
local remotesFolder=replicatedStorage:WaitForChild("RemotesFolder")
local currentRooms=workspace:WaitForChild("CurrentRooms")
local lighting=game:GetService("Lighting")
local proximityPromptService=game:GetService("ProximityPromptService")
if coreGui:FindFirstChild("thisismenu") then coreGui.thisismenu:Destroy() end
if coreGui:FindFirstChild("thisismenu_esp") then coreGui.thisismenu_esp:Destroy() end
local espGui=Instance.new("ScreenGui")
espGui.Name="thisismenu_esp"
espGui.IgnoreGuiInset=true
espGui.Parent=coreGui
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
local green=Color3.fromRGB(0,255,0)
local orange=Color3.fromRGB(255,120,0)
local red=Color3.fromRGB(255,0,0)
local gray=Color3.fromRGB(100,100,100)
local lightYellow=Color3.fromRGB(200,200,0)
local lightBlue=Color3.fromRGB(0,200,255)
local darkBackground=Color3.fromRGB(35,35,40)
local white=Color3.new(1,1,1)
local lightGray=Color3.fromRGB(200,200,200)
local mediumGray=Color3.fromRGB(180,180,180)
local panelBackground=Color3.fromRGB(45,45,53)
local tweenFast=TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
local tweenSlow=TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
local sourceSansFont=Enum.Font.SourceSans
local toggleOffPosition=UDim2.new(0,0,0.5,-8)
local toggleOnPosition=UDim2.new(1,-16,0.5,-8)
local mainGui=Instance.new("ScreenGui")
mainGui.Name="thisismenu"
mainGui.Parent=coreGui
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
titleLabel.TextColor3=white
titleLabel.TextXAlignment=Enum.TextXAlignment.Left
titleLabel.Text="  thisismenu"
for instance,wasFlyEnabled in ipairs({92,62}) do
local labelOrFrame=createInstance("Frame",sidebar)
labelOrFrame.Size=UDim2.new(0,wasFlyEnabled,0,4)
labelOrFrame.Position=UDim2.new(0,10,0,50+9*(instance-1))
labelOrFrame.BackgroundColor3=green
local gradientOrGlobals=Instance.new("UIGradient")
gradientOrGlobals.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(0.7,0),NumberSequenceKeypoint.new(1,1)})
gradientOrGlobals.Parent=labelOrFrame
local temporaryValue=createInstance("Frame",labelOrFrame)
temporaryValue.Size=UDim2.new(0,8,0,8)
temporaryValue.Position=UDim2.new(1,-4,0.5,-4)
temporaryValue.Rotation=45
temporaryValue.BackgroundColor3=green
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
isOldGeneration.BackgroundColor3=white
addCorner(isOldGeneration,8)
local localValue,cameraOrCorner=false,false
local function setValue(localObject)
localValue=localObject
tweenService:Create(isOldGeneration,tweenFast,{Position=localValue and toggleOnPosition or toggleOffPosition,BackgroundColor3=localValue and green or white}):Play()
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
local character=localPlayer.Character
if not character then return end
if localValue then
for _,partOrPlayer in ipairs(character:GetDescendants()) do
if partOrPlayer:IsA("BasePart") then
savedPhysicalProperties[partOrPlayer]=partOrPlayer.CustomPhysicalProperties
local localObject=partOrPlayer.CustomPhysicalProperties
partOrPlayer.CustomPhysicalProperties=PhysicalProperties.new(100,localObject and localObject.Friction or 0.5,localObject and localObject.Elasticity or 0.5,localObject and localObject.FrictionWeight or 1,localObject and localObject.ElasticityWeight or 1)
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
local character=localPlayer.Character
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
local uiObject=localPlayer.PlayerGui:FindFirstChild("MainUI")
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
local character=localPlayer.Character
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
local character=localPlayer.Character
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
highlightOrHumanoid.FillColor=green
highlightOrHumanoid.OutlineColor=green
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
labelOrFrame.TextColor3=green
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
local currentRoom=tonumber(localPlayer:GetAttribute("CurrentRoom"))
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
local objectiveNames={KeyObtain="Key",LeverForGate="Lever",ElectricalKeyObtain="Electrical Key",LiveHintBook="Book",LiveBreakerPolePickup="Breaker",LibraryHintPaper="Paper"}
local function clearObjectiveEsp()
for localObject,localValue in pairs(objectiveEspEntries) do
pcall(function() localValue.l:Destroy() end)
pcall(function() localValue.h:Destroy() end)
end
table.clear(objectiveEspEntries)
end
local function createObjectiveEsp(localObject,labelText)
if objectiveEspEntries[localObject] then return end
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
local currentRoom=tonumber(localPlayer:GetAttribute("CurrentRoom"))
local room=currentRoom and currentRooms:FindFirstChild(tostring(currentRoom))
local nextObjects={}
if room then
for _,localObject in ipairs(room:GetDescendants()) do
local labelText=objectiveNames[localObject.Name]
if labelText then nextObjects[localObject]=true if not objectiveEspEntries[localObject] then pcall(createObjectiveEsp,localObject,labelText) end end
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
if not trackedObjects[localObject] or not localValue.a:IsDescendantOf(workspace) then localValue.l.Visible=false return end
updateScreenPosition(localValue.l,localValue.a.Position)
end)
end
end)
end
local entityEspEntries={}
local entityNames={RushMoving="Rush",AmbushMoving="Ambush",Eyes="Eyes",SallyMoving="Sally",Snare="Snare",FigureRig="Figure",SeekRig="Seek",GlitchCube="Glitch Fragment"}
local alwaysShowEntities={RushMoving=true,AmbushMoving=true}
local proxyEntities={RushMoving=true,AmbushMoving=true,Eyes=true}
local function clearEntityEsp()
for instance,localValue in pairs(entityEspEntries) do
pcall(function() localValue.l:Destroy() end)
pcall(function() localValue.h:Destroy() end)
pcall(function() localValue.m:Destroy() end)
end
table.clear(entityEspEntries)
end
local function createEntityEsp(it,labelText)
if entityEspEntries[it] then return end
if it.Name=="Snare" then
local parent=it.Parent
if parent and parent.Name=="Snare" then return end
end
local anchorPart=nil
local localModel=nil
local adornee=it
if it.Name=="Snare" then
anchorPart=it:FindFirstChild("Hitbox")
elseif it.Name=="GlitchCube" then
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
if localState<=0 then localState=1 end
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
runService.Heartbeat:Connect(function()
if isOldGeneration() then return end
if not mainFrame.get() then
if next(entityEspEntries) then clearEntityEsp() end
return
end
local currentRoom=tonumber(localPlayer:GetAttribute("CurrentRoom"))
local room=currentRoom and currentRooms:FindFirstChild(tostring(currentRoom))
local trackedObjects={}
for _,localObject in ipairs(workspace:GetDescendants()) do
local labelText=entityNames[localObject.Name]
if labelText and not trackedObjects[localObject] then
if not (localObject.Name=="Snare" and localObject.Parent and localObject.Parent.Name=="Snare") then
if alwaysShowEntities[localObject.Name] or (room and localObject:IsDescendantOf(room)) or (not localObject:IsDescendantOf(currentRooms)) then trackedObjects[localObject]=true pcall(createEntityEsp,localObject,labelText) end
end
end
end
for it,localValue in pairs(entityEspEntries) do
if not trackedObjects[it] or not it:IsDescendantOf(workspace) then
pcall(function() localValue.l:Destroy() end)
pcall(function() localValue.h:Destroy() end)
pcall(function() localValue.m:Destroy() end)
entityEspEntries[it]=nil
else
pcall(function()
if not localValue.a:IsDescendantOf(workspace) then localValue.l.Visible=false return end
updateScreenPosition(localValue.l,localValue.a.Position+Vector3.new(0,localValue.y,0))
end)
end
end
end)
end
local closetEspEntries={}
local closetNames={Wardrobe=true,Bed=true}
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
local currentRoom=tonumber(localPlayer:GetAttribute("CurrentRoom"))
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
updateScreenPosition(localValue.l,localValue.a.Position)
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
for _,partOrPlayer in ipairs(players:GetPlayers()) do
if partOrPlayer~=localPlayer then
local character=partOrPlayer.Character
local head=character and character:FindFirstChild("Head")
if head then
trackedObjects[partOrPlayer]=true
local localValue=playerEspEntries[partOrPlayer]
if not localValue then
local highlightOrHumanoid=Instance.new("Highlight")
highlightOrHumanoid.FillColor=white
highlightOrHumanoid.OutlineColor=white
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
labelOrFrame.TextColor3=white
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
highlightOrHumanoid.FillColor=white
highlightOrHumanoid.OutlineColor=white
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
local lootNames={GoldPile=true,ChestBox=true,ChestBoxLocked=true}
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
local currentRoom=tonumber(localPlayer:GetAttribute("CurrentRoom"))
local room=currentRoom and currentRooms:FindFirstChild(tostring(currentRoom))
local nextObjects={}
if room then
for _,localObject in ipairs(room:GetDescendants()) do
if lootNames[localObject.Name] then
nextObjects[localObject]=true
if not lootEspEntries[localObject] then
local labelText=localObject.Name=="GoldPile" and ("Gold "..tostring(localObject:GetAttribute("GoldValue"))) or (localObject.Name=="ChestBoxLocked" and "Chest [Locked]" or "Chest")
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
local itemNames={Lighter="Lighter",Flashlight="Flashlight",Lockpick="Lockpick",SkeletonKey="Skeleton Key",Candle="Candle",Shears="Shears",AlarmClock="Alarm Clock",Smoothie="Smoothie",RiftCandle="Moonlight Candle",TipJar="Tip Jar",Donut="Donut",RiftSmoothie="Moonlight Float",RiftJar="Rift Jar",Vitamins="Vitamins",Crucifix="Crucifix",Battery="Battery",Bandage="Bandage",Green_Herb="Green Herb",GweenSoda="Gween Soda",Bread="Bread",Cheese="Cheese",StarVial="Starlight Vial",StarBottle="Starlight Bottle"}
local function clearItemEsp()
for localObject,localValue in pairs(itemEspEntries) do
pcall(function() localValue.l:Destroy() end)
pcall(function() localValue.h:Destroy() end)
end
table.clear(itemEspEntries)
end
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
local highlightOrHumanoid=Instance.new("Highlight")
highlightOrHumanoid.FillColor=lightBlue
highlightOrHumanoid.OutlineColor=lightBlue
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
labelOrFrame.TextColor3=lightBlue
labelOrFrame.TextStrokeColor3=Color3.new(0,0,0)
labelOrFrame.TextStrokeTransparency=0
labelOrFrame.TextScaled=false
labelOrFrame.TextSize=14
labelOrFrame.Visible=false
labelOrFrame.Parent=espGui
itemEspEntries[localObject]={l=labelOrFrame,h=highlightOrHumanoid,a=anchorPart}
end
local function updateItemEsp(mainFrame)
local trackedObjects={}
local function scanObjects()
local currentRoom=tonumber(localPlayer:GetAttribute("CurrentRoom"))
local room=currentRoom and currentRooms:FindFirstChild(tostring(currentRoom))
local dropsFolder=workspace:FindFirstChild("Drops")
local character=localPlayer.Character
local rootPosition=character and character:FindFirstChild("HumanoidRootPart") and character.HumanoidRootPart.Position
local nextObjects={}
local function scanRoot(rt,md)
for _,localObject in ipairs(rt:GetDescendants()) do
local labelText=itemNames[localObject.Name]
if labelText then
local invalid=false
-- TIPJAR v JeffShopu (JeffShop_Hotel/Jeff/TipJar) nikdy ESP neukazovat, vlastni prineseny TipJar normalne funguje
if localObject.Name=="TipJar" then
local partOrPlayer=localObject.Parent
while partOrPlayer do
if partOrPlayer.Name=="JeffShop_Hotel" then invalid=true break end
partOrPlayer=partOrPlayer.Parent
end
end
-- Lighter v Bookcase_Fake neukazovat (stejne jako u Bookcase)
if not invalid and localObject.Name=="Lighter" then
local partOrPlayer=localObject.Parent
while partOrPlayer and partOrPlayer~=rt do
if partOrPlayer.Name=="Bookcase_Fake" then invalid=true break end
partOrPlayer=partOrPlayer.Parent
end
end
local partOrPlayer=localObject.Parent
while partOrPlayer and partOrPlayer~=rt do
if partOrPlayer.Name=="Bookcase" or partOrPlayer.Name=="BookcaseFake" then invalid=true break end
partOrPlayer=partOrPlayer.Parent
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
local character=localPlayer.Character
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
localPlayer.CharacterAdded:Connect(function(character)
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
local character=localPlayer.Character
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
local function setupFakeDoorBypass(mainFrame)
task.spawn(function()
while true do
task.wait(0.5)
if isOldGeneration() then break end
if mainFrame.get() then
for _,localObject in ipairs(currentRooms:GetDescendants()) do
if localObject.Name=="DoorFake" then
local highlightOrHumanoid=localObject:FindFirstChild("Hidden")
if highlightOrHumanoid then highlightOrHumanoid.CanTouch=false end
local labelOrFrame=localObject:FindFirstChild("Lock")
local uiObject=labelOrFrame and labelOrFrame:FindFirstChild("UnlockPrompt")
if uiObject then uiObject.Enabled=false end
end
end
end
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
local function setupSeekBypass(mainFrame)
task.spawn(function()
while true do
task.wait(0.5)
if isOldGeneration() then break end
if mainFrame.get() then
for _,localObject in ipairs(currentRooms:GetDescendants()) do
if localObject.Name=="Seek_Arm" or localObject.Name=="ChandelierObstruction" then
for _,partOrPlayer in ipairs(localObject:GetDescendants()) do
if partOrPlayer:IsA("BasePart") then partOrPlayer.CanTouch=false end
end
elseif localObject.Name=="SeekFloodline" then
localObject.CanTouch=false
localObject.CanCollide=true
end
end
end
end
end)
end
local function setupSnareBypass(mainFrame)
task.spawn(function()
while true do
task.wait(0.5)
if isOldGeneration() then break end
if mainFrame.get() then
for _,room in ipairs(currentRooms:GetChildren()) do
local assets=room:FindFirstChild("Assets")
if assets then
for _,trackedObjects in ipairs(assets:GetChildren()) do
if trackedObjects.Name=="Snare" then
for _,localObject in ipairs(trackedObjects:GetDescendants()) do
if localObject.Name=="Hitbox" then
for _,ti in ipairs(localObject:GetChildren()) do
if ti.Name=="TouchInterest" then ti:Destroy() end
end
end
end
end
end
end
end
end
end
end)
end
local function setupFullbright(mainFrame)
local buttonOrVelocity,localState,wasFlyEnabled=nil,nil,false
task.spawn(function()
while true do
task.wait(0.5)
if isOldGeneration() then break end
if mainFrame.get() then
if not wasFlyEnabled then buttonOrVelocity,localState=lighting.Brightness,lighting.GlobalShadows end
lighting.Brightness=0.301
lighting.GlobalShadows=false
elseif wasFlyEnabled then
lighting.Brightness=buttonOrVelocity
lighting.GlobalShadows=localState
end
wasFlyEnabled=mainFrame.get()
end
end)
end
local function setupAmbient(mainFrame)
local whiteAmbient=Color3.fromRGB(255,255,255)
local lastTween=nil
local function applyAmbient(color)
pcall(function()
if lastTween then lastTween:Cancel() end
lastTween=tweenService:Create(lighting,TweenInfo.new(0.2,Enum.EasingStyle.Exponential),{Ambient=color})
lastTween:Play()
end)
end
local function getRoomAmbient()
local currentRoom=tonumber(localPlayer:GetAttribute("CurrentRoom"))
local room=currentRoom and currentRooms:FindFirstChild(tostring(currentRoom))
local roomAmbient=room and room:GetAttribute("Ambient")
if typeof(roomAmbient)=="Color3" then return roomAmbient end
return lighting.Ambient
end
local wasEnabled=false
runService.Heartbeat:Connect(function()
if isOldGeneration() then return end
local enabled=mainFrame.get()
if enabled then
if lighting.Ambient~=whiteAmbient then applyAmbient(whiteAmbient) end
elseif wasEnabled then
applyAmbient(getRoomAmbient())
end
wasEnabled=enabled
end)
end
local function setupAutoBreaker(mainFrame)
-- docasne vypnuto, nahrazeno EBF FireServer click buttonem (viz setupEBFClick)
end
local function setupEBFClick(rootOrRow,titleLabel)
local edgeMargin=-10
titleLabel.Size=UDim2.new(1,-70,0,50)
local clickButton=createInstance("TextButton",rootOrRow)
clickButton.Size=UDim2.new(0,25,0,25)
clickButton.Position=UDim2.new(1,edgeMargin-25,0,12)
clickButton.BackgroundColor3=darkBackground
clickButton.AutoButtonColor=false
clickButton.Font=sourceSansFont
clickButton.TextSize=20
clickButton.TextColor3=white
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
clickButton.MouseButton1Click:Connect(function()
local ebf=remotesFolder:FindFirstChild("EBF")
if ebf then ebf:FireServer() end
task.spawn(function()
clickButton.BackgroundColor3=gray
task.wait(0.15)
clickButton.BackgroundColor3=darkBackground
end)
end)
end
local autoInteractBlacklist={HidePrompt=true,RiftPrompt=true,StarRiftPrompt=true,InteractPrompt=true,ClimbPrompt=true,DonatePrompt=true,DialoguePrompt=true,RevivePrompt=true,EnterPrompt=true,AnimatePrompt=true,ToolEventPrompt=true,Prompt=true,PropPrompt=true}
local promptCooldown={}
local function firePrompt(prompt)
if not prompt or not prompt:IsA("ProximityPrompt") or promptCooldown[prompt] then return end
local cameraOrCorner=workspace.CurrentCamera
if not cameraOrCorner then return end
promptCooldown[prompt]=true
task.spawn(function()
local tempPart=nil
pcall(function()
local oldDist=prompt.MaxActivationDistance
local oldEnable=prompt.Enabled
local oldParent=prompt.Parent
local oldHold=prompt.HoldDuration
local oldLOS=prompt.RequiresLineOfSight
pcall(function()
prompt.MaxActivationDistance=99999
prompt.Enabled=true
prompt.HoldDuration=0
prompt.RequiresLineOfSight=false
end)
tempPart=Instance.new("Part")
tempPart.CanCollide=false
tempPart.CanQuery=false
tempPart.CanTouch=false
tempPart.Anchored=true
tempPart.Transparency=1
tempPart.Size=Vector3.new(0.001,0.001,0.001)
tempPart.Position=cameraOrCorner.CFrame:ToWorldSpace(CFrame.new(0,0,-0.1)).Position
tempPart.Parent=workspace
if prompt.Parent and oldParent then
pcall(function() prompt.Parent=tempPart end)
local shown,fired=false,false
local shownConn=proximityPromptService.PromptShown:Connect(function(p) if p==prompt then shown=true end end)
local firedConn=prompt.Triggered:Connect(function() fired=true end)
local t1=0
while not shown and t1<2 do t1=t1+1 task.wait() end
local t2=0
while not fired and t2<3 do prompt:InputHoldBegin() prompt:InputHoldEnd() t2=t2+1 task.wait() end
pcall(function()
prompt.MaxActivationDistance=oldDist
prompt.Enabled=oldEnable
prompt.HoldDuration=oldHold
prompt.RequiresLineOfSight=oldLOS
end)
pcall(function() prompt.Parent=oldParent end)
task.wait()
pcall(function() shownConn:Disconnect() end)
pcall(function() firedConn:Disconnect() end)
end
pcall(function() tempPart:Destroy() end)
promptCooldown[prompt]=nil
end)
end)
end
local function triggerPrompt(prompt,autoToggles)
if not prompt or not prompt.Parent then return end
if autoInteractBlacklist[prompt.Name] then return end
if prompt:GetAttribute("AutoInteractIgnore") then return end
local parent=prompt.Parent
if parent.Parent and parent.Parent.Name=="DoorFake" then return end
if prompt.Name=="ActivateEventPrompt" and prompt.ActionText=="Close" then return end
local j=prompt.Parent
while j do
if j.Name=="JeffShop_Hotel" then return end
j=j.Parent
end
local category=nil
local a=prompt.Parent
while a do
if objectiveNames[a.Name] then category="objectives" break
elseif itemNames[a.Name] then category="items" break
elseif lootNames[a.Name] then category="loot" break end
a=a.Parent
end
if not category then
local p=prompt.Parent
while p do
if p.Name=="DrawerContainer" or p.Name=="RolltopContainer" then category="drawers" break end
p=p.Parent
end
end
if not category then
local q=prompt.Parent
while q do
if q.Name=="Lock" and q.Parent and q.Parent.Name=="Door" then category="doors" break end
q=q.Parent
end
end
if not category then return end
if category~="drawers" then
local toggle=autoToggles and autoToggles[category]
if toggle and not toggle.get() then return end
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
local currentRoom=tonumber(localPlayer:GetAttribute("CurrentRoom"))
local room=currentRoom and currentRooms:FindFirstChild(tostring(currentRoom))
local nextList={}
if room then
for _,obj in ipairs(room:GetDescendants()) do
if obj:IsA("ProximityPrompt") then nextList[#nextList+1]=obj end
end
end
local dropsFolder=workspace:FindFirstChild("Drops")
if dropsFolder then
for _,obj in ipairs(dropsFolder:GetDescendants()) do
if obj:IsA("ProximityPrompt") then nextList[#nextList+1]=obj end
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
if prompt.Parent and (prompt.Parent:IsA("BasePart") or prompt.Parent:IsA("Model")) then
local dist
if prompt.Parent:IsA("BasePart") then dist=localPlayer:DistanceFromCharacter(prompt.Parent.Position)
else dist=localPlayer:DistanceFromCharacter(prompt.Parent:GetPivot().Position) end
if (dist<=prompt.MaxActivationDistance and prompt.Enabled) or (dist<=prompt.MaxActivationDistance and (prompt.Name=="LongPushPrompt" or prompt.Name=="BigPropPrompt")) then
task.spawn(function() triggerPrompt(prompt,autoToggles) end)
end
end
end)
end
lastAutoInteractFire=tick()
end)
end
local function getLibraryCode()
local character=localPlayer.Character
local paperOrPosition=character and character:FindFirstChild("LibraryHintPaper") or localPlayer.Backpack:FindFirstChild("LibraryHintPaper")
local permUi=localPlayer.PlayerGui:FindFirstChild("PermUI")
local hints=permUi and permUi:FindFirstChild("Hints")
if not (paperOrPosition and paperOrPosition:FindFirstChild("UI") and hints) then return nil end
local cooldown={"_","_","_","_","_"}
for _,highlightOrHumanoid in ipairs(hints:GetChildren()) do
for _,uiObject in ipairs(paperOrPosition.UI:GetChildren()) do
if highlightOrHumanoid:IsA("ImageLabel") and uiObject:IsA("ImageLabel") and highlightOrHumanoid.ImageRectOffset==uiObject.ImageRectOffset then
local numberValue=tonumber(uiObject.Name)
if numberValue and cooldown[numberValue] then cooldown[numberValue]=highlightOrHumanoid.TextLabel.Text end
end
end
end
return table.concat(cooldown)
end
local function setupAutoLibraryLock(mainFrame,sl)
runService.Heartbeat:Connect(function()
if isOldGeneration() then return end
if not mainFrame.get() then return end
local character=localPlayer.Character
local rootOrRow=character and character:FindFirstChild("HumanoidRootPart")
local padding=currentRooms:FindFirstChild("Padlock",true)
if not rootOrRow or not padding then return end
local paperOrPosition=padding:GetPivot().Position
if (rootOrRow.Position-paperOrPosition).Magnitude<sl.get() then
local cooldown=getLibraryCode()
if cooldown and tonumber(cooldown) then remotesFolder.PL:FireServer(cooldown) end
end
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
local character=localPlayer.Character
local rootOrRow=character and character:FindFirstChild("HumanoidRootPart")
if rootOrRow then buttonOrVelocity.Parent=rootOrRow buttonOrVelocity.Velocity=rootOrRow.CFrame.LookVector*2.25 else buttonOrVelocity.Parent=nil end
else
buttonOrVelocity.Parent=nil
end
end)
end
local function setupCamera(fa,speedToggle,ca)
local mainGame=require(localPlayer.PlayerGui.MainUI.Initiator.Main_Game)
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
fill.BackgroundColor3=green
addCorner(fill,3)
local knob=createInstance("Frame",track)
knob.Size=UDim2.new(0,14,0,14)
knob.BackgroundColor3=white
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
userInputService.InputChanged:Connect(function(ip)
if dragging and ip.UserInputType==Enum.UserInputType.MouseMovement then updateSlider(ip.Position.X) end
end)
userInputService.InputEnded:Connect(function(ip)
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
keybindButton.TextColor3=white
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
userInputService.InputBegan:Connect(function(ip)
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
userInputService.InputEnded:Connect(function(ip)
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
buttonOrVelocity.ZIndex=52
local uiObject=createInstance("Frame",buttonOrVelocity)
uiObject.Size=UDim2.new(1,0,0,2)
uiObject.Position=UDim2.new(0,0,1,-2)
uiObject.BackgroundColor3=green
uiObject.Visible=mm==md
uiObject.ZIndex=52
addGradient(uiObject)
modeLines[mm]=uiObject
mb[mm]=buttonOrVelocity
buttonOrVelocity.MouseButton1Click:Connect(function()
md=mm
for nm,ln in pairs(modeLines) do
ln.Visible=(nm==mm)
mb[nm].TextColor3=nm==mm and white or lightGray
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
local mainFeatures={"speed","fly","noclip","door reach","bypass","ebf fireserver","auto library lock","auto interact","anticheat manipulation"}
local rowHeight=50
local expandedHeights={[1]=140,[2]=95,[5]=295,[7]=95,[8]=175}
local bypassFeatures={"dupe","eyes","snare","seek fire&hands","screech","halt","dread","timothy"}
local autoInteractFeatures={"doors","objectives","items","loot"}
local espFeatures={"door esp","objective esp","item esp","loot esp","closet esp","players esp","entities esp"}
local visualFeatures={"camera","ambient","fullbright","esp","thirdperson"}
local visualExpandedHeights={[1]=155,[4]=265}
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
tweenService:Create(rootOrRow,tweenFast,{Position=UDim2.new(0,0,0,yOffset)}):Play()
yOffset=yOffset+rz[j]+5
end
tweenService:Create(contentScroller,tweenFast,{CanvasSize=UDim2.new(0,0,0,yOffset-5)}):Play()
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
tweenService:Create(gradientOrGlobals,tweenFast,{Rotation=expanded and 180 or 0,ImageColor3=expanded and green or white}):Play()
rz[instance]=expanded and eh[instance] or rowHeight
tweenService:Create(rootOrRow,tweenFast,{Size=UDim2.new(1,-20,0,rz[instance])}):Play()
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
if not isBypass and name~="ebf fireserver" then featureToggle=temporaryValue(rootOrRow,expandedHeights[instance] and UDim2.new(1,-77,0,19) or UDim2.new(1,-44,0,19)) end
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
elseif name=="bypass" then
for kk,it in ipairs(bypassFeatures) do bypassToggles[it]=localObject(rootOrRow,55+(kk-1)*30,it,30) end
setupFakeDoorBypass(bypassToggles.dupe)
setupEyesBypass(bypassToggles.eyes)
setupSnareBypass(bypassToggles.snare)
setupSeekBypass(bypassToggles["seek fire&hands"])
task.spawn(function()
while true do
task.wait(0.25)
if isOldGeneration() then break end
if bypassToggles.screech.get() then
local localState=remotesFolder:FindFirstChild("Screech")
if localState then localState:Destroy() end
end
if bypassToggles.halt.get() then
local localState=remotesFolder:FindFirstChild("ShadeResult")
if localState then localState:Destroy() end
end
if bypassToggles.dread.get() then
local localState=remotesFolder:FindFirstChild("Dread")
if localState then localState:Destroy() end
end
if bypassToggles.timothy.get() then
local localState=remotesFolder:FindFirstChild("SpiderJumpscare")
if localState then localState:Destroy() end
end
end
end)
elseif name=="ebf fireserver" then
setupEBFClick(rootOrRow,titleLabel)
elseif name=="auto library lock" then
setupAutoLibraryLock(featureToggle,localState(rootOrRow,55,11,1,50))
elseif name=="auto interact" then
setupKeybind(rootOrRow,titleLabel,"R",-77,featureToggle,"hold")
local autoToggles={}
for kk,it in ipairs(autoInteractFeatures) do autoToggles[it]=localObject(rootOrRow,55+(kk-1)*30,it,30) end
setupAutoInteract(featureToggle,autoToggles)
end
end
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
local sidebar,objectiveToggle,e1,q1,g1,u1,t1
for kk,it in ipairs(espFeatures) do
local espToggle=localObject(rootOrRow,55+(kk-1)*30,it,30)
if it=="door esp" then sidebar=espToggle elseif it=="objective esp" then objectiveToggle=espToggle elseif it=="entities esp" then e1=espToggle elseif it=="closet esp" then q1=espToggle elseif it=="players esp" then g1=espToggle elseif it=="loot esp" then u1=espToggle elseif it=="item esp" then t1=espToggle end
end
updateDoorEsp(sidebar)
updateObjectiveEsp(objectiveToggle)
updateEntityEsp(e1)
updateClosetEsp(q1)
updatePlayerEsp(g1)
updateLootEsp(u1)
updateItemEsp(t1)
elseif name=="thirdperson" then
setupKeybind(rootOrRow,titleLabel,"T",-44,visualToggle,"toggle")
setupThirdPerson(visualToggle)
elseif name=="fullbright" then
setupFullbright(visualToggle)
elseif name=="ambient" then
setupAmbient(visualToggle)
end
end
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
buttonOrVelocity.TextColor3=white
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
uiObject.BackgroundColor3=green
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
tweenService:Create(ln,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size=UDim2.new(1,-20,0,3),Position=UDim2.new(0,10,1,-5)}):Play()
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
d3.Text="  place: thehotel"
local objectiveToggle,o2=mainFrame.Size,mainFrame.Position
local o3Value,o4=UDim2.new(0,40,0,40),UDim2.new(0.5,-20,0.5,-20)
local o5Value,o6=true,false
userInputService.InputBegan:Connect(function(ip,gp)
if gp or ip.KeyCode~=Enum.KeyCode.RightShift or o6 then return end
o6=true
if o5Value then
local temporaryValue=tweenService:Create(mainFrame,tweenSlow,{Size=o3Value,Position=o4})
temporaryValue:Play()
temporaryValue.Completed:Wait()
mainFrame.Visible=false
o5Value=false
else
mainFrame.Visible=true
mainFrame.Size=o3Value
mainFrame.Position=o4
local temporaryValue=tweenService:Create(mainFrame,tweenSlow,{Size=objectiveToggle,Position=o2})
temporaryValue:Play()
temporaryValue.Completed:Wait()
o5Value=true
end
o6=false
end)
