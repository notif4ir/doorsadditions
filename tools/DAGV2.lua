local maxhealth = 50

local Head = Instance.new("Part")
Head.FormFactor = Enum.FormFactor.Symmetric
Head.BottomSurface = Enum.SurfaceType.Smooth
Head.BrickColor = BrickColor.new("Dark orange")
Head.CFrame = CFrame.new(-2.29, 3.1, -0.17, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Head.Color = Color3.fromRGB(160, 95, 53)
Head.Material = Enum.Material.SmoothPlastic
Head.Position = Vector3.new(-2.29, 3.1, -0.17)
Head.Size = Vector3.new(2, 1, 1)
Head.TopSurface = Enum.SurfaceType.Smooth
Head.Name = "Head"

local Puppy = Instance.new("Model")
Puppy.WorldPivot = CFrame.new(-2.29, 3.1, -0.17, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Puppy.Name = "Puppy"

local Mesh = Instance.new("SpecialMesh")
Mesh.Scale = Vector3.new(1.3, 1, 1.2)

local HairAttachment = Instance.new("Attachment")
HairAttachment.CFrame = CFrame.new(0, 0.6, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
HairAttachment.Position = Vector3.new(0, 0.6, 0)
HairAttachment.WorldAxis = Vector3.new(1, 0, 0)
HairAttachment.WorldCFrame = CFrame.new(-2.29, 3.7, -0.17, 1, 0, 0, 0, 1, 0, 0, 0, 1)
HairAttachment.WorldPosition = Vector3.new(-2.29, 3.7, -0.17)
HairAttachment.Name = "HairAttachment"

local HatAttachment = Instance.new("Attachment")
HatAttachment.CFrame = CFrame.new(0, 0.6, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
HatAttachment.Position = Vector3.new(0, 0.6, 0)
HatAttachment.WorldAxis = Vector3.new(1, 0, 0)
HatAttachment.WorldCFrame = CFrame.new(-2.29, 3.7, -0.17, 1, 0, 0, 0, 1, 0, 0, 0, 1)
HatAttachment.WorldPosition = Vector3.new(-2.29, 3.7, -0.17)
HatAttachment.Name = "HatAttachment"

local FaceFrontAttachment = Instance.new("Attachment")
FaceFrontAttachment.CFrame = CFrame.new(0, 0, -0.6, 1, 0, 0, 0, 1, 0, 0, 0, 1)
FaceFrontAttachment.Position = Vector3.new(0, 0, -0.6)
FaceFrontAttachment.WorldAxis = Vector3.new(1, 0, 0)
FaceFrontAttachment.WorldCFrame = CFrame.new(-2.29, 3.1, -0.77, 1, 0, 0, 0, 1, 0, 0, 0, 1)
FaceFrontAttachment.WorldPosition = Vector3.new(-2.29, 3.1, -0.77)
FaceFrontAttachment.Name = "FaceFrontAttachment"

local FaceCenterAttachment = Instance.new("Attachment")
FaceCenterAttachment.WorldAxis = Vector3.new(1, 0, 0)
FaceCenterAttachment.WorldCFrame = CFrame.new(-2.29, 3.1, -0.17, 1, 0, 0, 0, 1, 0, 0, 0, 1)
FaceCenterAttachment.WorldPosition = Vector3.new(-2.29, 3.1, -0.17)
FaceCenterAttachment.Name = "FaceCenterAttachment"

local GettingUp = Instance.new("Sound")
GettingUp.EmitterSize = 5
GettingUp.MaxDistance = 150
GettingUp.MinDistance = 5
GettingUp.RollOffMaxDistance = 150
GettingUp.RollOffMinDistance = 5
GettingUp.SoundId = "rbxasset://sounds/action_get_up.mp3"
GettingUp.Volume = 0.65
GettingUp.Name = "GettingUp"

local CharacterSoundEvent = Instance.new("RemoteEvent")
CharacterSoundEvent.Name = "CharacterSoundEvent"

local Died = Instance.new("Sound")
Died.EmitterSize = 5
Died.MaxDistance = 150
Died.MinDistance = 5
Died.RollOffMaxDistance = 150
Died.RollOffMinDistance = 5
Died.SoundId = "rbxasset://sounds/uuhhh.mp3"
Died.Volume = 0.65
Died.Name = "Died"

local CharacterSoundEvent_2 = Instance.new("RemoteEvent")
CharacterSoundEvent_2.Name = "CharacterSoundEvent"

local FreeFalling = Instance.new("Sound")
FreeFalling.EmitterSize = 5
FreeFalling.Looped = true
FreeFalling.MaxDistance = 150
FreeFalling.MinDistance = 5
FreeFalling.RollOffMaxDistance = 150
FreeFalling.RollOffMinDistance = 5
FreeFalling.SoundId = "rbxasset://sounds/action_falling.mp3"
FreeFalling.TimePosition = 0.19
FreeFalling.Volume = 0
FreeFalling.Name = "FreeFalling"

local CharacterSoundEvent_3 = Instance.new("RemoteEvent")
CharacterSoundEvent_3.Name = "CharacterSoundEvent"

local Jumping = Instance.new("Sound")
Jumping.EmitterSize = 5
Jumping.MaxDistance = 150
Jumping.MinDistance = 5
Jumping.RollOffMaxDistance = 150
Jumping.RollOffMinDistance = 5
Jumping.SoundId = "rbxasset://sounds/action_jump.mp3"
Jumping.Volume = 0.65
Jumping.Name = "Jumping"

local CharacterSoundEvent_4 = Instance.new("RemoteEvent")
CharacterSoundEvent_4.Name = "CharacterSoundEvent"

local Landing = Instance.new("Sound")
Landing.EmitterSize = 5
Landing.MaxDistance = 150
Landing.MinDistance = 5
Landing.RollOffMaxDistance = 150
Landing.RollOffMinDistance = 5
Landing.SoundId = "rbxasset://sounds/action_jump_land.mp3"
Landing.Volume = 0.65
Landing.Name = "Landing"

local CharacterSoundEvent_5 = Instance.new("RemoteEvent")
CharacterSoundEvent_5.Name = "CharacterSoundEvent"

local Splash = Instance.new("Sound")
Splash.EmitterSize = 5
Splash.MaxDistance = 150
Splash.MinDistance = 5
Splash.RollOffMaxDistance = 150
Splash.RollOffMinDistance = 5
Splash.SoundId = "rbxasset://sounds/impact_water.mp3"
Splash.Volume = 0.65
Splash.Name = "Splash"

local CharacterSoundEvent_6 = Instance.new("RemoteEvent")
CharacterSoundEvent_6.Name = "CharacterSoundEvent"

local Running = Instance.new("Sound")
Running.EmitterSize = 5
Running.Looped = true
Running.MaxDistance = 150
Running.MinDistance = 5
Running.Pitch = 1.85
Running.PlaybackSpeed = 1.85
Running.RollOffMaxDistance = 150
Running.RollOffMinDistance = 5
Running.SoundId = "rbxasset://sounds/action_footsteps_plastic.mp3"
Running.TimePosition = 0.33
Running.Volume = 0.65
Running.Name = "Running"

local CharacterSoundEvent_7 = Instance.new("RemoteEvent")
CharacterSoundEvent_7.Name = "CharacterSoundEvent"

local Swimming = Instance.new("Sound")
Swimming.EmitterSize = 5
Swimming.Looped = true
Swimming.MaxDistance = 150
Swimming.MinDistance = 5
Swimming.Pitch = 1.6
Swimming.PlaybackSpeed = 1.6
Swimming.RollOffMaxDistance = 150
Swimming.RollOffMinDistance = 5
Swimming.SoundId = "rbxasset://sounds/action_swim.mp3"
Swimming.Volume = 0.65
Swimming.Name = "Swimming"

local CharacterSoundEvent_8 = Instance.new("RemoteEvent")
CharacterSoundEvent_8.Name = "CharacterSoundEvent"

local Climbing = Instance.new("Sound")
Climbing.EmitterSize = 5
Climbing.Looped = true
Climbing.MaxDistance = 150
Climbing.MinDistance = 5
Climbing.RollOffMaxDistance = 150
Climbing.RollOffMinDistance = 5
Climbing.SoundId = "rbxasset://sounds/action_footsteps_plastic.mp3"
Climbing.Volume = 0.65
Climbing.Name = "Climbing"

local CharacterSoundEvent_9 = Instance.new("RemoteEvent")
CharacterSoundEvent_9.Name = "CharacterSoundEvent"

local Decal = Instance.new("Decal")
Decal.Texture = "http://www.roblox.com/asset/?id=3098297329"
--[[ Unsupported Type: Content For : TextureContent ]]

local Torso = Instance.new("Part")
Torso.FormFactor = Enum.FormFactor.Symmetric
Torso.BottomSurface = Enum.SurfaceType.Smooth
Torso.BrickColor = BrickColor.new("Dark orange")
Torso.CFrame = CFrame.new(-2.29, 4.3, 0.63, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Torso.Color = Color3.fromRGB(160, 95, 53)
Torso.LeftParamA = 0
Torso.LeftParamB = 0
Torso.Material = Enum.Material.SmoothPlastic
Torso.Position = Vector3.new(-2.29, 4.3, 0.63)
Torso.RightParamA = 0
Torso.RightParamB = 0
Torso.Size = Vector3.new(2, 2, 1)
Torso.TopSurface = Enum.SurfaceType.Smooth
Torso.Transparency = 1
Torso.Name = "Torso"

local roblox = Instance.new("Decal")
roblox.Name = "roblox"

local NeckAttachment = Instance.new("Attachment")
NeckAttachment.CFrame = CFrame.new(0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
NeckAttachment.Position = Vector3.new(0, 1, 0)
NeckAttachment.WorldAxis = Vector3.new(1, 0, 0)
NeckAttachment.WorldCFrame = CFrame.new(-2.29, 5.3, 0.63, 1, 0, 0, 0, 1, 0, 0, 0, 1)
NeckAttachment.WorldPosition = Vector3.new(-2.29, 5.3, 0.63)
NeckAttachment.Name = "NeckAttachment"

local BodyFrontAttachment = Instance.new("Attachment")
BodyFrontAttachment.CFrame = CFrame.new(0, 0, -0.5, 1, 0, 0, 0, 1, 0, 0, 0, 1)
BodyFrontAttachment.Position = Vector3.new(0, 0, -0.5)
BodyFrontAttachment.WorldAxis = Vector3.new(1, 0, 0)
BodyFrontAttachment.WorldCFrame = CFrame.new(-2.29, 4.3, 0.13, 1, 0, 0, 0, 1, 0, 0, 0, 1)
BodyFrontAttachment.WorldPosition = Vector3.new(-2.29, 4.3, 0.13)
BodyFrontAttachment.Name = "BodyFrontAttachment"

local BodyBackAttachment = Instance.new("Attachment")
BodyBackAttachment.CFrame = CFrame.new(0, 0, 0.5, 1, 0, 0, 0, 1, 0, 0, 0, 1)
BodyBackAttachment.Position = Vector3.new(0, 0, 0.5)
BodyBackAttachment.WorldAxis = Vector3.new(1, 0, 0)
BodyBackAttachment.WorldCFrame = CFrame.new(-2.29, 4.3, 1.13, 1, 0, 0, 0, 1, 0, 0, 0, 1)
BodyBackAttachment.WorldPosition = Vector3.new(-2.29, 4.3, 1.13)
BodyBackAttachment.Name = "BodyBackAttachment"

local LeftCollarAttachment = Instance.new("Attachment")
LeftCollarAttachment.CFrame = CFrame.new(-1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
LeftCollarAttachment.Position = Vector3.new(-1, 1, 0)
LeftCollarAttachment.WorldAxis = Vector3.new(1, 0, 0)
LeftCollarAttachment.WorldCFrame = CFrame.new(-3.29, 5.3, 0.63, 1, 0, 0, 0, 1, 0, 0, 0, 1)
LeftCollarAttachment.WorldPosition = Vector3.new(-3.29, 5.3, 0.63)
LeftCollarAttachment.Name = "LeftCollarAttachment"

local RightCollarAttachment = Instance.new("Attachment")
RightCollarAttachment.CFrame = CFrame.new(1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
RightCollarAttachment.Position = Vector3.new(1, 1, 0)
RightCollarAttachment.WorldAxis = Vector3.new(1, 0, 0)
RightCollarAttachment.WorldCFrame = CFrame.new(-1.29, 5.3, 0.63, 1, 0, 0, 0, 1, 0, 0, 0, 1)
RightCollarAttachment.WorldPosition = Vector3.new(-1.29, 5.3, 0.63)
RightCollarAttachment.Name = "RightCollarAttachment"

local WaistFrontAttachment = Instance.new("Attachment")
WaistFrontAttachment.CFrame = CFrame.new(0, -1, -0.5, 1, 0, 0, 0, 1, 0, 0, 0, 1)
WaistFrontAttachment.Position = Vector3.new(0, -1, -0.5)
WaistFrontAttachment.WorldAxis = Vector3.new(1, 0, 0)
WaistFrontAttachment.WorldCFrame = CFrame.new(-2.29, 3.3, 0.13, 1, 0, 0, 0, 1, 0, 0, 0, 1)
WaistFrontAttachment.WorldPosition = Vector3.new(-2.29, 3.3, 0.13)
WaistFrontAttachment.Name = "WaistFrontAttachment"

local WaistCenterAttachment = Instance.new("Attachment")
WaistCenterAttachment.CFrame = CFrame.new(0, -1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
WaistCenterAttachment.Position = Vector3.new(0, -1, 0)
WaistCenterAttachment.WorldAxis = Vector3.new(1, 0, 0)
WaistCenterAttachment.WorldCFrame = CFrame.new(-2.29, 3.3, 0.63, 1, 0, 0, 0, 1, 0, 0, 0, 1)
WaistCenterAttachment.WorldPosition = Vector3.new(-2.29, 3.3, 0.63)
WaistCenterAttachment.Name = "WaistCenterAttachment"

local WaistBackAttachment = Instance.new("Attachment")
WaistBackAttachment.CFrame = CFrame.new(0, -1, 0.5, 1, 0, 0, 0, 1, 0, 0, 0, 1)
WaistBackAttachment.Position = Vector3.new(0, -1, 0.5)
WaistBackAttachment.WorldAxis = Vector3.new(1, 0, 0)
WaistBackAttachment.WorldCFrame = CFrame.new(-2.29, 3.3, 1.13, 1, 0, 0, 0, 1, 0, 0, 0, 1)
WaistBackAttachment.WorldPosition = Vector3.new(-2.29, 3.3, 1.13)
WaistBackAttachment.Name = "WaistBackAttachment"

local Right_Arm = Instance.new("Part")
Right_Arm.FormFactor = Enum.FormFactor.Symmetric
Right_Arm.BottomSurface = Enum.SurfaceType.Smooth
Right_Arm.BrickColor = BrickColor.new("Dark orange")
Right_Arm.CFrame = CFrame.new(-1.73, 2, -0.37, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Right_Arm.CanCollide = false
Right_Arm.Color = Color3.fromRGB(160, 95, 53)
Right_Arm.Material = Enum.Material.SmoothPlastic
Right_Arm.Position = Vector3.new(-1.73, 2, -0.37)
Right_Arm.Size = Vector3.new(1, 2, 1)
Right_Arm.TopSurface = Enum.SurfaceType.Smooth
Right_Arm.Name = "Right Arm"

local Right_Shoulder = Instance.new("Motor6D")
Right_Shoulder.MaxVelocity = 0.1
Right_Shoulder.C0 = CFrame.new(0.06, -1.8, -1, 0, 0, 1, 0, 1, 0, -1, 0, 0)
Right_Shoulder.C1 = CFrame.new(-0.5, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
Right_Shoulder.Name = "Right Shoulder"

Right_Shoulder.Part0 = Torso
Right_Shoulder.Part1 = Right_Arm

local Left_Arm = Instance.new("Part")
Left_Arm.FormFactor = Enum.FormFactor.Symmetric
Left_Arm.BottomSurface = Enum.SurfaceType.Smooth
Left_Arm.BrickColor = BrickColor.new("Dark orange")
Left_Arm.CFrame = CFrame.new(-2.85, 2, -0.37, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Left_Arm.CanCollide = false
Left_Arm.Color = Color3.fromRGB(160, 95, 53)
Left_Arm.Material = Enum.Material.SmoothPlastic
Left_Arm.Position = Vector3.new(-2.85, 2, -0.37)
Left_Arm.Size = Vector3.new(1, 2, 1)
Left_Arm.TopSurface = Enum.SurfaceType.Smooth
Left_Arm.Name = "Left Arm"

local Left_Shoulder = Instance.new("Motor6D")
Left_Shoulder.MaxVelocity = 0.1
Left_Shoulder.C0 = CFrame.new(-0.06, -1.8, -1, 0, 0, -1, 0, 1, 0, 1, 0, 0)
Left_Shoulder.C1 = CFrame.new(0.5, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
Left_Shoulder.Name = "Left Shoulder"

Left_Shoulder.Part0 = Torso
Left_Shoulder.Part1 = Left_Arm

local Right_Leg = Instance.new("Part")
Right_Leg.FormFactor = Enum.FormFactor.Symmetric
Right_Leg.BottomSurface = Enum.SurfaceType.Smooth
Right_Leg.BrickColor = BrickColor.new("Dark orange")
Right_Leg.CFrame = CFrame.new(-1.89, 2.1, 1.13, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Right_Leg.CanCollide = false
Right_Leg.Color = Color3.fromRGB(160, 95, 53)
Right_Leg.Material = Enum.Material.SmoothPlastic
Right_Leg.Position = Vector3.new(-1.89, 2.1, 1.13)
Right_Leg.Size = Vector3.new(1, 2, 1)
Right_Leg.TopSurface = Enum.SurfaceType.Smooth
Right_Leg.Name = "Right Leg"

local Right_Hip = Instance.new("Motor6D")
Right_Hip.MaxVelocity = 0.1
Right_Hip.C0 = CFrame.new(0.9, -1.2, 0.5, 0, 0, 1, 0, 1, 0, -1, 0, 0)
Right_Hip.C1 = CFrame.new(0.5, 1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
Right_Hip.Name = "Right Hip"

Right_Hip.Part0 = Torso
Right_Hip.Part1 = Right_Leg

local Left_Leg = Instance.new("Part")
Left_Leg.FormFactor = Enum.FormFactor.Symmetric
Left_Leg.BottomSurface = Enum.SurfaceType.Smooth
Left_Leg.BrickColor = BrickColor.new("Dark orange")
Left_Leg.CFrame = CFrame.new(-2.69, 2.1, 1.13, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Left_Leg.CanCollide = false
Left_Leg.Color = Color3.fromRGB(160, 95, 53)
Left_Leg.Material = Enum.Material.SmoothPlastic
Left_Leg.Position = Vector3.new(-2.69, 2.1, 1.13)
Left_Leg.Size = Vector3.new(1, 2, 1)
Left_Leg.TopSurface = Enum.SurfaceType.Smooth
Left_Leg.Name = "Left Leg"

local Left_Hip = Instance.new("Motor6D")
Left_Hip.MaxVelocity = 0.1
Left_Hip.C0 = CFrame.new(-0.9, -1.2, 0.5, 0, 0, -1, 0, 1, 0, 1, 0, 0)
Left_Hip.C1 = CFrame.new(-0.5, 1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
Left_Hip.Name = "Left Hip"

Left_Hip.Part0 = Torso
Left_Hip.Part1 = Left_Leg

local Neck = Instance.new("Motor6D")
Neck.MaxVelocity = 0.1
Neck.C0 = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0)
Neck.C1 = CFrame.new(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0)
Neck.Name = "Neck"
Neck.Part0 = Torso
Neck.Part1 = Head

local FakeTorso = Instance.new("Part")
FakeTorso.BottomSurface = Enum.SurfaceType.Smooth
FakeTorso.BrickColor = BrickColor.new("Dark orange")
FakeTorso.CFrame = CFrame.new(-2.29, 2.5, 0.33, 1, 0, 0, 0, 1, 0, 0, 0, 1)
FakeTorso.Color = Color3.fromRGB(160, 95, 53)
FakeTorso.Material = Enum.Material.SmoothPlastic
FakeTorso.Position = Vector3.new(-2.29, 2.5, 0.33)
FakeTorso.Size = Vector3.new(1, 0.4, 2)
FakeTorso.TopSurface = Enum.SurfaceType.Smooth
FakeTorso.Name = "FakeTorso"

local Weld = Instance.new("Weld")
Weld.C1 = CFrame.new(0, 1.8, 0.3, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Weld.Part0 = Torso
Weld.Part1 = FakeTorso

local Weld_2 = Instance.new("Weld")
Weld_2.C1 = CFrame.new(0, 1.2, 0.8, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Weld_2.Part0 = Torso
Weld_2.Part1 = Head

local Tail = Instance.new("Part")
Tail.BottomSurface = Enum.SurfaceType.Smooth
Tail.BrickColor = BrickColor.new("Dark orange")
Tail.CFrame = CFrame.new(-2.29, 3, 1.28, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Tail.Color = Color3.fromRGB(160, 95, 53)
Tail.Material = Enum.Material.SmoothPlastic
Tail.Position = Vector3.new(-2.29, 3, 1.28)
Tail.Size = Vector3.new(0.05, 1, 0.05)
Tail.TopSurface = Enum.SurfaceType.Smooth
Tail.Name = "Tail"

local Weld_3 = Instance.new("Weld")
Weld_3.C1 = CFrame.new(0, 1.3, -0.65, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Weld_3.Part0 = Torso
Weld_3.Part1 = Tail

local Part1 = Instance.new("Part")
Part1.BottomSurface = Enum.SurfaceType.Smooth
Part1.BrickColor = BrickColor.new("Dark orange")
Part1.CFrame = CFrame.new(-2.99, 3.1, -0.17, 0, -1, 0, 0, 0, -1, 1, 0, 0)
Part1.Color = Color3.fromRGB(160, 95, 53)
Part1.Material = Enum.Material.SmoothPlastic
Part1.Orientation = Vector3.new(90, -90, 0)
Part1.Position = Vector3.new(-2.99, 3.1, -0.17)
Part1.Rotation = Vector3.new(90, 0, 90)
Part1.Size = Vector3.new(1, 1, 1)
Part1.TopSurface = Enum.SurfaceType.Smooth
Part1.Name = "Part1"

local Weld_4 = Instance.new("Weld")
Weld_4.C1 = CFrame.new(0.8, -0.7, -1.2, 0, 0, 1, -1, 0, 0, 0, -1, 0)
Weld_4.Part0 = Torso
Weld_4.Part1 = Part1

local Part1_2 = Instance.new("Part")
Part1_2.BottomSurface = Enum.SurfaceType.Smooth
Part1_2.BrickColor = BrickColor.new("Dark orange")
Part1_2.CFrame = CFrame.new(-1.59, 3.1, -0.17, 0, 1, 0, 0, 0, -1, -1, 0, 0)
Part1_2.Color = Color3.fromRGB(160, 95, 53)
Part1_2.Material = Enum.Material.SmoothPlastic
Part1_2.Orientation = Vector3.new(90, 90, 0)
Part1_2.Position = Vector3.new(-1.59, 3.1, -0.17)
Part1_2.Rotation = Vector3.new(90, 0, -90)
Part1_2.Size = Vector3.new(1, 1, 1)
Part1_2.TopSurface = Enum.SurfaceType.Smooth
Part1_2.Name = "Part1"

local Weld_5 = Instance.new("Weld")
Weld_5.C1 = CFrame.new(-0.8, -0.7, -1.2, 0, 0, -1, 1, 0, 0, 0, -1, 0)
Weld_5.Part0 = Torso
Weld_5.Part1 = Part1_2

local LeftShoulderAttachment = Instance.new("Attachment")
LeftShoulderAttachment.CFrame = CFrame.new(0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
LeftShoulderAttachment.Position = Vector3.new(0, 1, 0)
LeftShoulderAttachment.WorldAxis = Vector3.new(1, 0, 0)
LeftShoulderAttachment.WorldCFrame = CFrame.new(-2.85, 3, -0.37, 1, 0, 0, 0, 1, 0, 0, 0, 1)
LeftShoulderAttachment.WorldPosition = Vector3.new(-2.85, 3, -0.37)
LeftShoulderAttachment.Name = "LeftShoulderAttachment"

local LeftGripAttachment = Instance.new("Attachment")
LeftGripAttachment.CFrame = CFrame.new(0, -1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
LeftGripAttachment.Position = Vector3.new(0, -1, 0)
LeftGripAttachment.WorldAxis = Vector3.new(1, 0, 0)
LeftGripAttachment.WorldCFrame = CFrame.new(-2.85, 1, -0.37, 1, 0, 0, 0, 1, 0, 0, 0, 1)
LeftGripAttachment.WorldPosition = Vector3.new(-2.85, 1, -0.37)
LeftGripAttachment.Name = "LeftGripAttachment"

local Mesh_2 = Instance.new("SpecialMesh")
Mesh_2.Scale = Vector3.new(0.5, 0.5, 0.5)

local RightShoulderAttachment = Instance.new("Attachment")
RightShoulderAttachment.CFrame = CFrame.new(0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
RightShoulderAttachment.Position = Vector3.new(0, 1, 0)
RightShoulderAttachment.WorldAxis = Vector3.new(1, 0, 0)
RightShoulderAttachment.WorldCFrame = CFrame.new(-1.73, 3, -0.37, 1, 0, 0, 0, 1, 0, 0, 0, 1)
RightShoulderAttachment.WorldPosition = Vector3.new(-1.73, 3, -0.37)
RightShoulderAttachment.Name = "RightShoulderAttachment"

local RightGripAttachment = Instance.new("Attachment")
RightGripAttachment.CFrame = CFrame.new(0, -1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
RightGripAttachment.Position = Vector3.new(0, -1, 0)
RightGripAttachment.WorldAxis = Vector3.new(1, 0, 0)
RightGripAttachment.WorldCFrame = CFrame.new(-1.73, 1, -0.37, 1, 0, 0, 0, 1, 0, 0, 0, 1)
RightGripAttachment.WorldPosition = Vector3.new(-1.73, 1, -0.37)
RightGripAttachment.Name = "RightGripAttachment"

local Mesh_3 = Instance.new("SpecialMesh")
Mesh_3.Scale = Vector3.new(0.5, 0.5, 0.5)

local LeftFootAttachment = Instance.new("Attachment")
LeftFootAttachment.CFrame = CFrame.new(0, -1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
LeftFootAttachment.Position = Vector3.new(0, -1, 0)
LeftFootAttachment.WorldAxis = Vector3.new(1, 0, 0)
LeftFootAttachment.WorldCFrame = CFrame.new(-2.69, 1.1, 1.13, 1, 0, 0, 0, 1, 0, 0, 0, 1)
LeftFootAttachment.WorldPosition = Vector3.new(-2.69, 1.1, 1.13)
LeftFootAttachment.Name = "LeftFootAttachment"

local Mesh_4 = Instance.new("SpecialMesh")
Mesh_4.Scale = Vector3.new(0.5, 0.5, 0.5)

local RightFootAttachment = Instance.new("Attachment")
RightFootAttachment.CFrame = CFrame.new(0, -1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
RightFootAttachment.Position = Vector3.new(0, -1, 0)
RightFootAttachment.WorldAxis = Vector3.new(1, 0, 0)
RightFootAttachment.WorldCFrame = CFrame.new(-1.89, 1.1, 1.13, 1, 0, 0, 0, 1, 0, 0, 0, 1)
RightFootAttachment.WorldPosition = Vector3.new(-1.89, 1.1, 1.13)
RightFootAttachment.Name = "RightFootAttachment"

local Mesh_5 = Instance.new("SpecialMesh")
Mesh_5.Scale = Vector3.new(0.5, 0.5, 0.5)

local HumanoidRootPart = Instance.new("Part")
HumanoidRootPart.FormFactor = Enum.FormFactor.Symmetric
HumanoidRootPart.BottomSurface = Enum.SurfaceType.Smooth
HumanoidRootPart.BrickColor = BrickColor.new("Dark orange")
HumanoidRootPart.CFrame = CFrame.new(-2.29, 4.3, 0.63, 1, 0, 0, 0, 1, 0, 0, 0, 1)
HumanoidRootPart.Color = Color3.fromRGB(160, 95, 53)
HumanoidRootPart.LeftParamA = 0
HumanoidRootPart.LeftParamB = 0
HumanoidRootPart.Material = Enum.Material.SmoothPlastic
HumanoidRootPart.Position = Vector3.new(-2.29, 4.3, 0.63)
HumanoidRootPart.RightParamA = 0
HumanoidRootPart.RightParamB = 0
HumanoidRootPart.Size = Vector3.new(2, 2, 1)
HumanoidRootPart.TopSurface = Enum.SurfaceType.Smooth
HumanoidRootPart.Transparency = 1
HumanoidRootPart.Name = "HumanoidRootPart"

local RootAttachment = Instance.new("Attachment")
RootAttachment.WorldAxis = Vector3.new(1, 0, 0)
RootAttachment.WorldCFrame = CFrame.new(-2.29, 4.3, 0.63, 1, 0, 0, 0, 1, 0, 0, 0, 1)
RootAttachment.WorldPosition = Vector3.new(-2.29, 4.3, 0.63)
RootAttachment.Name = "RootAttachment"

local RootJoint = Instance.new("Motor6D")
RootJoint.MaxVelocity = 0.1
RootJoint.C0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0)
RootJoint.C1 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0)
RootJoint.Name = "RootJoint"
RootJoint.Part0 = HumanoidRootPart
RootJoint.Part1 = Torso

local Mesh_6 = Instance.new("SpecialMesh")
Mesh_6.MeshType = Enum.MeshType.Wedge
Mesh_6.Scale = Vector3.new(0.5, 0.5, 0.7)

local Mesh_7 = Instance.new("SpecialMesh")

local Mesh_8 = Instance.new("SpecialMesh")
Mesh_8.MeshType = Enum.MeshType.Wedge
Mesh_8.Scale = Vector3.new(0.5, 0.5, 0.7)

local Humanoid = Instance.new("Humanoid")
Humanoid.DisplayName = "dag"
Humanoid.MaxHealth = maxhealth
Humanoid.Health = maxhealth

Puppy.Parent = game:GetService("Workspace")
Head.Parent = Puppy
Mesh.Parent = Head
HairAttachment.Parent = Head
HatAttachment.Parent = Head
FaceFrontAttachment.Parent = Head
FaceCenterAttachment.Parent = Head
GettingUp.Parent = Head
CharacterSoundEvent.Parent = GettingUp
Died.Parent = Head
CharacterSoundEvent_2.Parent = Died
FreeFalling.Parent = Head
CharacterSoundEvent_3.Parent = FreeFalling
Jumping.Parent = Head
CharacterSoundEvent_4.Parent = Jumping
Landing.Parent = Head
CharacterSoundEvent_5.Parent = Landing
Splash.Parent = Head
CharacterSoundEvent_6.Parent = Splash
Running.Parent = Head
CharacterSoundEvent_7.Parent = Running
Swimming.Parent = Head
CharacterSoundEvent_8.Parent = Swimming
Climbing.Parent = Head
CharacterSoundEvent_9.Parent = Climbing
Decal.Parent = Head
Torso.Parent = Puppy
roblox.Parent = Torso
NeckAttachment.Parent = Torso
BodyFrontAttachment.Parent = Torso
BodyBackAttachment.Parent = Torso
LeftCollarAttachment.Parent = Torso
RightCollarAttachment.Parent = Torso
WaistFrontAttachment.Parent = Torso
WaistCenterAttachment.Parent = Torso
WaistBackAttachment.Parent = Torso
Right_Arm.Parent = Puppy
Right_Shoulder.Parent = Torso
Left_Arm.Parent = Puppy
Left_Shoulder.Parent = Torso
Right_Leg.Parent = Puppy
Right_Hip.Parent = Torso
Left_Leg.Parent = Puppy
Left_Hip.Parent = Torso
Neck.Parent = Torso
FakeTorso.Parent = Puppy
Weld.Parent = Torso
Weld_2.Parent = Torso
Tail.Parent = Puppy
Weld_3.Parent = Torso
Part1.Parent = Puppy
Weld_4.Parent = Torso
Part1_2.Parent = Puppy
Weld_5.Parent = Torso
LeftShoulderAttachment.Parent = Left_Arm
LeftGripAttachment.Parent = Left_Arm
Mesh_2.Parent = Left_Arm
RightShoulderAttachment.Parent = Right_Arm
RightGripAttachment.Parent = Right_Arm
Mesh_3.Parent = Right_Arm
LeftFootAttachment.Parent = Left_Leg
Mesh_4.Parent = Left_Leg
RightFootAttachment.Parent = Right_Leg
Mesh_5.Parent = Right_Leg
HumanoidRootPart.Parent = Puppy
RootAttachment.Parent = HumanoidRootPart
RootJoint.Parent = HumanoidRootPart
Mesh_6.Parent = Part1_2
Mesh_7.Parent = Tail
Mesh_8.Parent = Part1
Humanoid.Parent = Puppy

Puppy.PrimaryPart = HumanoidRootPart

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local PathfindingService = game:GetService("PathfindingService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local Puppy = workspace:WaitForChild("Puppy")
local PuppyHumanoid = Puppy:WaitForChild("Humanoid")
local PuppyRoot = Puppy:WaitForChild("HumanoidRootPart")

local followDistance = 7
local teleportDistance = 75
local teleportDelay = 2
local lastTooFarTime = 0
local followDelay = math.random(5, 10) / 10

local pathInProgress = false
local currentPath
local currentWaypointIndex = 1
local pathConnection
local followOffset = Vector3.new(3,0,-3)

local function setupCharacter(char)
	character = char
	humanoid = character:WaitForChild("Humanoid")

	humanoid.HealthChanged:Connect(function(newHealth)
		if PuppyHumanoid.Health > 0 then
			local healthLost = humanoid.Health - newHealth
			PuppyHumanoid.Health = PuppyHumanoid.Health - healthLost
		end
	end)

	humanoid.Jumping:Connect(function(isJumping)
		if isJumping and PuppyHumanoid.Health > 0 then
			PuppyHumanoid.Jump = true
		end
	end)
end

setupCharacter(character)
player.CharacterAdded:Connect(setupCharacter)

local function getFollowPosition()
	if not character or not character:FindFirstChild("HumanoidRootPart") then return PuppyRoot.Position end
	local root = character.HumanoidRootPart
	return root.Position + root.CFrame.RightVector * followOffset.X + root.CFrame.LookVector * followOffset.Z
end

local function jumpIfBlocked()
	local rayOrigin = PuppyRoot.Position
	local rayDirection = PuppyRoot.CFrame.LookVector * 4
	local rayParams = RaycastParams.new()
	rayParams.FilterDescendantsInstances = {Puppy, character}
	rayParams.FilterType = Enum.RaycastFilterType.Blacklist
	local result = workspace:Raycast(rayOrigin, rayDirection, rayParams)
	if result then
		PuppyHumanoid.Jump = true
	end
end

local function computePath(destination)
	local path = PathfindingService:CreatePath({
		AgentRadius = 2,
		AgentHeight = 5,
		AgentCanJump = true,
		AgentJumpHeight = 8,
		AgentMaxSlope = 45,
	})
	path:ComputeAsync(PuppyRoot.Position, destination)
	return path
end

local function followPlayer()
	if not character or not character:FindFirstChild("HumanoidRootPart") then return end
	if PuppyHumanoid.Health <= 0 then return end
	PuppyHumanoid.WalkSpeed = humanoid.WalkSpeed

	local root = character.HumanoidRootPart
	local distance = (PuppyRoot.Position - root.Position).Magnitude

	if distance > teleportDistance then
		if tick() - lastTooFarTime >= teleportDelay then
			Puppy:SetPrimaryPartCFrame(CFrame.new(getFollowPosition()))
			lastTooFarTime = tick()
			pathInProgress = false
		end
	else
		lastTooFarTime = tick()
		if distance > followDistance and not pathInProgress then
			pathInProgress = true
			local dest = getFollowPosition()
			currentPath = computePath(dest)

			if currentPath.Status == Enum.PathStatus.Success then
				local waypoints = currentPath:GetWaypoints()
				currentWaypointIndex = 1

				if pathConnection then pathConnection:Disconnect() end

				local function moveNextWaypoint()
					if currentWaypointIndex <= #waypoints then
						local wp = waypoints[currentWaypointIndex]
						if wp.Action == Enum.PathWaypointAction.Jump then
							PuppyHumanoid.Jump = true
						end
						PuppyHumanoid:MoveTo(wp.Position)
						currentWaypointIndex += 1
					else
						pathInProgress = false
					end
				end

				pathConnection = PuppyHumanoid.MoveToFinished:Connect(function(reached)
					if reached then
						moveNextWaypoint()
					else
						jumpIfBlocked()
						moveNextWaypoint()
					end
				end)

				moveNextWaypoint()
			else
				PuppyHumanoid:MoveTo(dest)
				pathInProgress = false
			end
		end
	end
end

RunService.Heartbeat:Connect(followPlayer)