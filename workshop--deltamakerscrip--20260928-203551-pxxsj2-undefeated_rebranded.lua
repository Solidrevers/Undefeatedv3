-- ============================================================
-- Un Defeated Hub
-- Client-side only. No cookies logged.
-- ============================================================

if not LPH_OBFUSCATED then
LPH_ENCSTR = function(n) return n end; LPH_ENCNUM = function(n) return n end
LPH_STRENC = function(n) return n end; LPH_NUMENC = function(n) return n end
if buffer then local bf = buffer.fromstring; LPH_ENCBUF = function(n) return bf(n) end; LPH_BUFENC = LPH_ENCBUF end
LPH_CRASH = function() end
do
local tu = table.unpack or unpack
local tp = table.pack or function(...) return { n = select("#", ...), ... } end
local sa = {}; sa.__index = sa
sa.clear = function(self, f, l) f = f or self.__base; l = l or self.__end; for i = f, l do self[i] = nil end end
sa.unpack = function(self, f, l) f = f or self.__base; l = l or self.__end; return tu(self, f, l) end
sa.pack = function(self, f, l) f = f or self.__base; l = l or self.__end; return tp(tu(self, f, l)) end
sa.__len = function(self) return self.__size end
end
LPH_PRECHECK = function(check) check() end
local __attribute = function() end
LPH_ATTRIBUTES = __attribute; ENCRYPT = __attribute
VM = __attribute; PRESET = __attribute; OPTIMIZE = __attribute; NO_UPVALUES = __attribute; ERROR_HANDLING = __attribute
UNROLL = __attribute; INLINE = __attribute; TRANSFORM = __attribute
NONE = __attribute; OPAL = __attribute; ONYX = __attribute
FAST = __attribute; BALANCED = __attribute; SECURE = __attribute
EXTRACT = __attribute; CONTROL_FLOW = __attribute; REWRITE_NAMECALLS = __attribute
GLOBALS = __attribute; CONSTANTS = __attribute
end

for i = 1, 8 do pcall(setthreadidentity, i) end

local Lighting = game:GetService("Lighting")

task.spawn(function()
LPH_ATTRIBUTES(VM(NONE))
local function fastLoaderDisable(obj)
LPH_ATTRIBUTES(VM(NONE))
pcall(function()
LPH_ATTRIBUTES(VM(NONE))
local class=obj.ClassName
if class=="ParticleEmitter" or class=="Fire" or class=="Smoke" or class=="Sparkles" or class=="Trail" or class=="Beam" then
obj.Enabled=false
elseif class=="PointLight" or class=="SpotLight" or class=="SurfaceLight" then
obj.Enabled=false
elseif class=="Decal" or class=="Texture" then
obj.Transparency=1
elseif obj:IsA("BasePart") and obj.CastShadow then
obj.CastShadow=false
end
end)
end
for _,obj in ipairs(workspace:GetDescendants()) do fastLoaderDisable(obj) end
workspace.DescendantAdded:Connect(fastLoaderDisable)

pcall(function()
LPH_ATTRIBUTES(VM(NONE))
Lighting.FogEnd=1e6

Lighting.FogStart=0
Lighting.GlobalShadows=false
Lighting.EnvironmentDiffuseScale=0
Lighting.EnvironmentSpecularScale=0
for _,v in ipairs(Lighting:GetChildren()) do
if v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("DepthOfFieldEffect") or v:IsA("SunRaysEffect") then
v.Enabled=false
end
end
end)
pcall(function() settings().Rendering.QualityLevel=Enum.QualityLevel.Level01 end)
end)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HS = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
_G.Players = Players
_G.TweenService = TweenService
_G.UIS = UIS
_G.RunService = RunService
_G.Lighting = Lighting
_G.HS = HS
_G.player = player

local velChecked = {}
local hookedVelParts = {}

local function setupVelChecked(char)
LPH_ATTRIBUTES(VM(NONE))
velChecked = {}
if not char then return end
local hrp = char:WaitForChild("HumanoidRootPart", 5)
if hrp then velChecked[hrp] = true end
return hrp
end

local function hookVelHRP(hrp)
if not hrp or hookedVelParts[hrp] then return end
hookedVelParts[hrp] = true
local mt = getrawmetatable(hrp)
if not mt then return end
setreadonly(mt, false)
local originalVelIndex = rawget(mt, "__index")
mt.__index = newcclosure(function(self, key)
LPH_ATTRIBUTES(VM(NONE))
if not checkcaller() and velChecked[self] and (key == "AssemblyLinearVelocity" or key == "Velocity") then
local real
if type(originalVelIndex) == "function" then
real = originalVelIndex(self, key)
elseif type(originalVelIndex) == "table" then
real = originalVelIndex[key]
end
if real.Magnitude > 20 then
return real.Unit * 20
end
return real
end
if type(originalVelIndex) == "function" then
return originalVelIndex(self, key)
elseif type(originalVelIndex) == "table" then
return originalVelIndex[key]
end
end)
setreadonly(mt, true)
end

if player.Character then
local hrp = setupVelChecked(player.Character)
hookVelHRP(hrp)
end
player.CharacterAdded:Connect(function(char)
hookedVelParts = {}
local hrp = setupVelChecked(char)
hookVelHRP(hrp)
end)

local _gethui = typeof(gethui)=="function" and gethui or nil
local function protectGui(gui)
LPH_ATTRIBUTES(VM(NONE))
if not gui then return end
pcall(function()
LPH_ATTRIBUTES(VM(NONE))
if typeof(protect_gui)=="function" then protect_gui(gui)
elseif syn and syn.protect_gui then syn.protect_gui(gui)
elseif typeof(hide_in_gcoregui)=="function" then hide_in_gcoregui(gui)
end
end)
end
local function parentGui(gui)
LPH_ATTRIBUTES(VM(NONE))
if not gui then return end
protectGui(gui)
if _gethui then
pcall(function() gui.Parent=_gethui() end)
end
end
local _isfile = (typeof(isfile)=="function" and isfile)
    or (syn and syn.isfile)
    or (getgenv and getgenv().isfile)
    or function(p)
LPH_ATTRIBUTES(VM(NONE))
local ok, data = pcall(function() return readfile(p) end)
return ok and data ~= nil
end
local _readfile = (typeof(readfile)=="function" and readfile)
    or (syn and syn.readfile)
    or (getgenv and getgenv().readfile)
    or function() return nil end
local _writefile = (typeof(writefile)=="function" and writefile)
    or (syn and syn.writefile)
    or (getgenv and getgenv().writefile)
    or function() end
isfile, readfile, writefile = _isfile, _readfile, _writefile
local CANDY_SKY_TAG = "MoveeSkyTheme"
local currentSkyTheme = "Off"
local CANDY_SKY_PRESETS = {
["Off"]={kind="off"},
["Night"]={clock=22,brightness=2,ambient={110,100,130},outAmb={120,110,140},sky={stars=4000,moon=18,sun=0,moonTex=true},atm={dens=0.45,color={120,60,180},decay={60,20,100},glare=0.5,haze=1.2}},
["Aurora"]={clock=14,brightness=3,ambient={150,120,150},outAmb={160,130,150},atm={dens=0.55,color={255,80,200},decay={255,20,150},glare=2.5,haze=3},clouds={cover=0.7,dens=0.7,color={255,240,250}}},
["Sunset"]={clock=17.2,brightness=2.5,ambient={170,120,100},outAmb={180,130,110},sky={stars=0,sun=25,moon=0},atm={dens=0.5,color={255,130,60},decay={255,80,30},glare=2,haze=2.5},clouds={cover=0.55,dens=0.55,color={255,200,140}}},
["Galaxy"]={clock=0,brightness=1.5,ambient={70,60,100},outAmb={80,70,110},sky={stars=10000,moon=30,sun=0},atm={dens=0.15,color={40,20,80},decay={20,10,50},glare=0.3,haze=0.5}},
["Cyber"]={clock=21,brightness=2.2,ambient={90,130,170},outAmb={100,140,180},sky={stars=2000,moon=12},atm={dens=0.4,color={0,200,255},decay={150,0,255},glare=2,haze=2},clouds={cover=0.4,dens=0.6,color={100,200,255}}},
["Sakura"]={clock=11,brightness=3.5,ambient={170,150,160},outAmb={180,160,170},sky={sun=8},atm={dens=0.3,color={255,200,220},decay={255,170,200},glare=1,haze=1.5},clouds={cover=0.6,dens=0.4,color={255,250,252}}},
["Pink Night"]={clock=23,brightness=2.2,ambient={120,60,110},outAmb={140,70,120},sky={stars=5000,moon=22,sun=0,moonTex=true},atm={dens=0.5,color={255,80,180},decay={140,30,100},glare=0.7,haze=1.4},clouds={cover=0.3,dens=0.5,color={180,90,150}}},
["Blood Moon"]={clock=22.5,brightness=1.6,ambient={130,40,40},outAmb={150,50,50},sky={stars=1500,moon=28,sun=0,moonTex=true},atm={dens=0.6,color={220,30,30},decay={120,10,10},glare=1.4,haze=2},clouds={cover=0.5,dens=0.7,color={120,30,30}}},
["Emerald Dawn"]={clock=6.5,brightness=2.8,ambient={130,170,140},outAmb={140,180,150},sky={sun=18,moon=0,stars=0},atm={dens=0.4,color={80,200,140},decay={40,150,90},glare=1.8,haze=2.2},clouds={cover=0.5,dens=0.5,color={200,255,220}}},
["Volcanic"]={clock=19,brightness=2,ambient={180,80,40},outAmb={200,90,50},sky={stars=200,sun=12,moon=0},atm={dens=0.75,color={255,60,0},decay={180,20,0},glare=3,haze=3.5},clouds={cover=0.8,dens=0.9,color={120,40,20}}},
["Arctic"]={clock=9,brightness=3.2,ambient={200,220,235},outAmb={210,230,245},sky={sun=10,stars=0,moon=0},atm={dens=0.3,color={180,220,255},decay={140,200,240},glare=1.5,haze=1.8},clouds={cover=0.7,dens=0.6,color={250,253,255}}},
["Midnight Ocean"]={clock=1.5,brightness=1.7,ambient={60,90,130},outAmb={70,100,140},sky={stars=6000,moon=24,sun=0,moonTex=true},atm={dens=0.5,color={20,60,140},decay={10,30,90},glare=0.6,haze=1.5}},
["Vaporwave"]={clock=19.5,brightness=2.4,ambient={180,120,200},outAmb={190,130,210},sky={stars=1000,moon=14},atm={dens=0.45,color={255,100,220},decay={120,60,255},glare=2.2,haze=2.4},clouds={cover=0.5,dens=0.55,color={200,150,255}}},
["Toxic"]={clock=13,brightness=2.5,ambient={140,180,80},outAmb={150,190,90},atm={dens=0.55,color={100,220,40},decay={60,150,20},glare=1.8,haze=2.6},clouds={cover=0.65,dens=0.7,color={180,255,120}}},
["Solar Eclipse"]={clock=12,brightness=0.9,ambient={50,40,60},outAmb={60,50,70},sky={stars=3500,sun=22,moon=0},atm={dens=0.5,color={255,140,40},decay={30,20,40},glare=2.8,haze=1.8}},
["Hellscape"]={clock=18,brightness=1.8,ambient={200,60,30},outAmb={220,70,40},sky={stars=100,sun=30,moon=0},atm={dens=0.85,color={255,30,0},decay={120,0,0},glare=3.5,haze=4},clouds={cover=0.95,dens=0.95,color={80,20,10}}},
["Heaven"]={clock=12,brightness=4,ambient={240,235,210},outAmb={250,245,220},sky={sun=16,moon=0,stars=0},atm={dens=0.25,color={255,250,220},decay={255,240,200},glare=3,haze=1.5},clouds={cover=0.85,dens=0.5,color={255,255,255}}},
["Storm"]={clock=15,brightness=1.4,ambient={90,90,110},outAmb={100,100,120},sky={stars=0,sun=6,moon=0},atm={dens=0.65,color={80,90,120},decay={40,50,80},glare=0.5,haze=3},clouds={cover=0.95,dens=0.95,color={60,65,80}}},
["Sunrise"]={clock=6.2,brightness=2.8,ambient={220,180,130},outAmb={230,190,140},sky={sun=22,stars=0,moon=0},atm={dens=0.45,color={255,180,100},decay={255,140,80},glare=2.4,haze=2.2},clouds={cover=0.4,dens=0.4,color={255,220,180}}},
["Deep Space"]={clock=0,brightness=1,ambient={30,25,50},outAmb={40,35,60},sky={stars=15000,moon=0,sun=0},atm={dens=0.08,color={15,5,40},decay={5,0,20},glare=0.2,haze=0.3}},
["Lavender Dream"]={clock=18.5,brightness=2.6,ambient={180,160,220},outAmb={190,170,230},sky={stars=800,moon=16,sun=0},atm={dens=0.4,color={200,160,255},decay={160,120,220},glare=1.4,haze=1.8},clouds={cover=0.55,dens=0.5,color={220,200,255}}},
["Inferno"]={clock=17.5,brightness=2.2,ambient={220,100,40},outAmb={235,110,50},sky={sun=26,moon=0,stars=0},atm={dens=0.6,color={255,90,20},decay={200,40,0},glare=3,haze=3.2},clouds={cover=0.7,dens=0.7,color={200,80,40}}},
["Mint Sky"]={clock=10,brightness=3.2,ambient={180,230,210},outAmb={190,240,220},sky={sun=10},atm={dens=0.32,color={150,255,210},decay={100,220,180},glare=1.6,haze=1.6},clouds={cover=0.55,dens=0.45,color={240,255,250}}},
}
local SkyOrder={"Off","Night","Aurora","Sunset","Galaxy","Cyber","Sakura","Pink Night","Blood Moon","Emerald Dawn","Volcanic","Arctic","Midnight Ocean","Vaporwave","Toxic","Solar Eclipse","Hellscape","Heaven","Storm","Sunrise","Deep Space","Lavender Dream","Inferno","Mint Sky"}
local function candyColor(rgb) return Color3.fromRGB(rgb[1],rgb[2],rgb[3]) end
local _skyWatchdogPreset=nil
local _skyWatchdogActive=false
local function _applySkyLightingProps(preset)
if not preset or preset.kind=="off" then
Lighting.ClockTime=14;Lighting.Brightness=2;Lighting.OutdoorAmbient=Color3.fromRGB(127,127,127);Lighting.Ambient=Color3.fromRGB(127,127,127);Lighting.FogStart=0;Lighting.FogEnd=100000;Lighting.GlobalShadows=true
return
end
Lighting.FogStart=0;Lighting.FogEnd=100000;Lighting.FogColor=Color3.fromRGB(200,200,200);Lighting.ColorShift_Top=Color3.fromRGB(0,0,0);Lighting.ColorShift_Bottom=Color3.fromRGB(0,0,0);Lighting.GlobalShadows=true
Lighting.ClockTime=preset.clock or 14;Lighting.Brightness=preset.brightness or 2
if preset.outAmb then Lighting.OutdoorAmbient=candyColor(preset.outAmb) end
if preset.ambient then Lighting.Ambient=candyColor(preset.ambient) end
end
local function CandyApplyCustomSky(mode)
LPH_ATTRIBUTES(VM(NONE))
for _,child in ipairs(Lighting:GetChildren()) do if child:GetAttribute(CANDY_SKY_TAG) then pcall(function() child:Destroy() end) end end
local terrain=workspace:FindFirstChildOfClass("Terrain")
if terrain then for _,child in ipairs(terrain:GetChildren()) do if child:GetAttribute(CANDY_SKY_TAG) then pcall(function() child:Destroy() end) end end end
local preset=CANDY_SKY_PRESETS[mode]
_applySkyLightingProps(preset)
_skyWatchdogPreset=preset
_skyWatchdogActive=true
if not preset or preset.kind=="off" then return end
if preset.sky then
local skyInst=Instance.new("Sky");skyInst:SetAttribute(CANDY_SKY_TAG,true)
if preset.sky.stars then skyInst.StarCount=preset.sky.stars end
if preset.sky.moon then skyInst.MoonAngularSize=preset.sky.moon end
if preset.sky.sun then skyInst.SunAngularSize=preset.sky.sun end
if preset.sky.moonTex then skyInst.MoonTextureId="rbxasset://sky/moon.jpg" end
skyInst.Parent=Lighting
end
if preset.atm then
local atm=Instance.new("Atmosphere");atm:SetAttribute(CANDY_SKY_TAG,true)
atm.Density=preset.atm.dens or 0.3;atm.Color=candyColor(preset.atm.color);atm.Decay=candyColor(preset.atm.decay);atm.Glare=preset.atm.glare or 1;atm.Haze=preset.atm.haze or 1;atm.Parent=Lighting
end
if preset.clouds and terrain then
local clouds=Instance.new("Clouds");clouds:SetAttribute(CANDY_SKY_TAG,true)
clouds.Cover=preset.clouds.cover or 0.5;clouds.Density=preset.clouds.dens or 0.5;clouds.Color=candyColor(preset.clouds.color);clouds.Parent=terrain
end
end

RunService.Heartbeat:Connect(function()
if not _skyWatchdogActive then return end
pcall(_applySkyLightingProps, _skyWatchdogPreset)
end)

currentGuiTheme = "Cyber"
GUI_THEME_ORDER = {"Midnight","Neon Pink","Cyber","Emerald","Blood","Sakura","Gold","Ocean","Purple Haze","Toxic"}
GUI_THEMES = {
["Midnight"] = {
BG=Color3.fromRGB(12,12,14), BG2=Color3.fromRGB(18,18,20), ROW_BG=Color3.fromRGB(22,22,24),
ROW_BORDER=Color3.fromRGB(40,40,44), WHITE=Color3.fromRGB(220,220,225), GRAY=Color3.fromRGB(140,140,150),
INP=Color3.fromRGB(16,16,18), ACCENT=Color3.fromRGB(180,180,190), ACCENT2=Color3.fromRGB(150,150,160),
ACCENT3=Color3.fromRGB(50,50,55), OFF=Color3.fromRGB(28,28,32), SECT=Color3.fromRGB(160,160,170),
MOB_ON=Color3.fromRGB(180,180,190), MOB_OFF=Color3.fromRGB(22,22,24), MOB_BORDER_OFF=Color3.fromRGB(45,45,50),
MOB_TEXT_OFF=Color3.fromRGB(170,170,180), MOB_TEXT_ON=Color3.fromRGB(20,20,22),
STEAL_BG=Color3.fromRGB(14,14,16), STEAL_FILL=Color3.fromRGB(160,160,170), STEAL_ACCENT=Color3.fromRGB(180,180,190),
PARTICLE=Color3.fromRGB(180,180,190),
},
["Neon Pink"] = {
BG=Color3.fromRGB(14,10,14), BG2=Color3.fromRGB(20,14,20), ROW_BG=Color3.fromRGB(26,16,26),
ROW_BORDER=Color3.fromRGB(55,35,55), WHITE=Color3.fromRGB(230,215,230), GRAY=Color3.fromRGB(150,130,150),
INP=Color3.fromRGB(18,12,18), ACCENT=Color3.fromRGB(180,100,150), ACCENT2=Color3.fromRGB(160,110,145),
ACCENT3=Color3.fromRGB(55,30,50), OFF=Color3.fromRGB(30,20,30), SECT=Color3.fromRGB(170,130,160),
MOB_ON=Color3.fromRGB(180,100,150), MOB_OFF=Color3.fromRGB(26,16,26), MOB_BORDER_OFF=Color3.fromRGB(55,35,55),
MOB_TEXT_OFF=Color3.fromRGB(180,150,175), MOB_TEXT_ON=Color3.fromRGB(25,10,20),
STEAL_BG=Color3.fromRGB(16,12,16), STEAL_FILL=Color3.fromRGB(170,95,140), STEAL_ACCENT=Color3.fromRGB(180,100,150),
PARTICLE=Color3.fromRGB(180,120,160),
},
["Cyber"] = {
BG=Color3.fromRGB(12,16,28), BG2=Color3.fromRGB(18,24,40), ROW_BG=Color3.fromRGB(26,34,54),
ROW_BORDER=Color3.fromRGB(120,175,255), WHITE=Color3.fromRGB(245,250,255), GRAY=Color3.fromRGB(160,195,240),
INP=Color3.fromRGB(16,22,38), ACCENT=Color3.fromRGB(130,190,255), ACCENT2=Color3.fromRGB(100,165,255),
ACCENT3=Color3.fromRGB(50,100,180), OFF=Color3.fromRGB(32,40,60), SECT=Color3.fromRGB(150,200,255),
MOB_ON=Color3.fromRGB(130,190,255), MOB_OFF=Color3.fromRGB(26,34,54), MOB_BORDER_OFF=Color3.fromRGB(120,175,255),
MOB_TEXT_OFF=Color3.fromRGB(190,220,255), MOB_TEXT_ON=Color3.fromRGB(12,20,40),
STEAL_BG=Color3.fromRGB(16,22,38), STEAL_FILL=Color3.fromRGB(120,185,255), STEAL_ACCENT=Color3.fromRGB(130,190,255),
PARTICLE=Color3.fromRGB(150,200,255),
},
["Emerald"] = {
BG=Color3.fromRGB(10,14,12), BG2=Color3.fromRGB(14,20,16), ROW_BG=Color3.fromRGB(18,26,20),
ROW_BORDER=Color3.fromRGB(30,55,40), WHITE=Color3.fromRGB(215,235,220), GRAY=Color3.fromRGB(120,160,135),
INP=Color3.fromRGB(12,18,14), ACCENT=Color3.fromRGB(70,160,110), ACCENT2=Color3.fromRGB(90,150,115),
ACCENT3=Color3.fromRGB(25,55,35), OFF=Color3.fromRGB(20,32,24), SECT=Color3.fromRGB(110,170,130),
MOB_ON=Color3.fromRGB(70,160,110), MOB_OFF=Color3.fromRGB(18,26,20), MOB_BORDER_OFF=Color3.fromRGB(30,55,40),
MOB_TEXT_OFF=Color3.fromRGB(140,185,155), MOB_TEXT_ON=Color3.fromRGB(5,25,12),
STEAL_BG=Color3.fromRGB(12,18,14), STEAL_FILL=Color3.fromRGB(65,150,105), STEAL_ACCENT=Color3.fromRGB(70,160,110),
PARTICLE=Color3.fromRGB(90,160,120),
},
["Blood"] = {
BG=Color3.fromRGB(14,10,10), BG2=Color3.fromRGB(20,14,14), ROW_BG=Color3.fromRGB(26,16,16),
ROW_BORDER=Color3.fromRGB(55,30,30), WHITE=Color3.fromRGB(235,215,215), GRAY=Color3.fromRGB(160,130,130),
INP=Color3.fromRGB(18,12,12), ACCENT=Color3.fromRGB(170,70,70), ACCENT2=Color3.fromRGB(160,90,90),
ACCENT3=Color3.fromRGB(55,25,25), OFF=Color3.fromRGB(30,20,30), SECT=Color3.fromRGB(175,120,120),
MOB_ON=Color3.fromRGB(170,70,70), MOB_OFF=Color3.fromRGB(26,16,26), MOB_BORDER_OFF=Color3.fromRGB(55,30,30),
MOB_TEXT_OFF=Color3.fromRGB(190,150,150), MOB_TEXT_ON=Color3.fromRGB(25,8,8),
STEAL_BG=Color3.fromRGB(16,12,12), STEAL_FILL=Color3.fromRGB(160,65,65), STEAL_ACCENT=Color3.fromRGB(170,70,70),
PARTICLE=Color3.fromRGB(170,90,90),
},
["Sakura"] = {
BG=Color3.fromRGB(14,12,14), BG2=Color3.fromRGB(20,16,20), ROW_BG=Color3.fromRGB(26,18,26),
ROW_BORDER=Color3.fromRGB(55,35,55), WHITE=Color3.fromRGB(230,215,230), GRAY=Color3.fromRGB(150,130,150),
INP=Color3.fromRGB(18,14,18), ACCENT=Color3.fromRGB(180,100,150), ACCENT2=Color3.fromRGB(160,110,145),
ACCENT3=Color3.fromRGB(55,30,50), OFF=Color3.fromRGB(30,20,30), SECT=Color3.fromRGB(170,130,160),
MOB_ON=Color3.fromRGB(180,100,150), MOB_OFF=Color3.fromRGB(26,16,26), MOB_BORDER_OFF=Color3.fromRGB(55,35,55),
MOB_TEXT_OFF=Color3.fromRGB(180,150,175), MOB_TEXT_ON=Color3.fromRGB(25,10,20),
STEAL_BG=Color3.fromRGB(16,12,16), STEAL_FILL=Color3.fromRGB(170,95,140), STEAL_ACCENT=Color3.fromRGB(180,100,150),
PARTICLE=Color3.fromRGB(180,120,160),
},
["Gold"] = {
BG=Color3.fromRGB(14,12,8), BG2=Color3.fromRGB(20,18,12), ROW_BG=Color3.fromRGB(26,22,16),
ROW_BORDER=Color3.fromRGB(55,45,20), WHITE=Color3.fromRGB(235,225,200), GRAY=Color3.fromRGB(160,150,120),
INP=Color3.fromRGB(18,16,10), ACCENT=Color3.fromRGB(200,170,60), ACCENT2=Color3.fromRGB(180,150,40),
ACCENT3=Color3.fromRGB(55,45,15), OFF=Color3.fromRGB(30,25,15), SECT=Color3.fromRGB(200,170,60),
MOB_ON=Color3.fromRGB(200,170,60), MOB_OFF=Color3.fromRGB(26,22,14), MOB_BORDER_OFF=Color3.fromRGB(55,45,20),
MOB_TEXT_OFF=Color3.fromRGB(200,190,150), MOB_TEXT_ON=Color3.fromRGB(25,20,8),
STEAL_BG=Color3.fromRGB(16,14,10), STEAL_FILL=Color3.fromRGB(200,170,60), STEAL_ACCENT=Color3.fromRGB(200,170,60),
PARTICLE=Color3.fromRGB(200,170,60),
},
["Ocean"] = {
BG=Color3.fromRGB(8,14,18), BG2=Color3.fromRGB(12,20,26), ROW_BG=Color3.fromRGB(16,24,30),
ROW_BORDER=Color3.fromRGB(30,55,70), WHITE=Color3.fromRGB(215,230,240), GRAY=Color3.fromRGB(120,150,170),
INP=Color3.fromRGB(10,16,20), ACCENT=Color3.fromRGB(60,140,200), ACCENT2=Color3.fromRGB(80,160,220),
ACCENT3=Color3.fromRGB(20,40,60), OFF=Color3.fromRGB(16,24,30), SECT=Color3.fromRGB(100,160,200),
MOB_ON=Color3.fromRGB(60,140,200), MOB_OFF=Color3.fromRGB(16,24,30), MOB_BORDER_OFF=Color3.fromRGB(30,55,70),
MOB_TEXT_OFF=Color3.fromRGB(140,180,210), MOB_TEXT_ON=Color3.fromRGB(5,15,25),
STEAL_BG=Color3.fromRGB(10,16,20), STEAL_FILL=Color3.fromRGB(60,140,200), STEAL_ACCENT=Color3.fromRGB(60,140,200),
PARTICLE=Color3.fromRGB(80,160,220),
},
["Purple Haze"] = {
BG=Color3.fromRGB(14,10,18), BG2=Color3.fromRGB(20,14,28), ROW_BG=Color3.fromRGB(26,16,30),
ROW_BORDER=Color3.fromRGB(55,30,70), WHITE=Color3.fromRGB(230,215,230), GRAY=Color3.fromRGB(150,130,160),
INP=Color3.fromRGB(18,12,20), ACCENT=Color3.fromRGB(160,80,200), ACCENT2=Color3.fromRGB(140,70,180),
ACCENT3=Color3.fromRGB(50,25,60), OFF=Color3.fromRGB(28,20,35), SECT=Color3.fromRGB(170,120,190),
MOB_ON=Color3.fromRGB(160,80,200), MOB_OFF=Color3.fromRGB(26,16,28), MOB_BORDER_OFF=Color3.fromRGB(55,30,70),
MOB_TEXT_OFF=Color3.fromRGB(190,150,200), MOB_TEXT_ON=Color3.fromRGB(25,10,30),
STEAL_BG=Color3.fromRGB(16,12,18), STEAL_FILL=Color3.fromRGB(160,80,200), STEAL_ACCENT=Color3.fromRGB(160,80,200),
PARTICLE=Color3.fromRGB(170,100,200),
},
["Toxic"] = {
BG=Color3.fromRGB(10,14,8), BG2=Color3.fromRGB(14,20,12), ROW_BG=Color3.fromRGB(18,26,16),
ROW_BORDER=Color3.fromRGB(40,60,20), WHITE=Color3.fromRGB(220,235,210), GRAY=Color3.fromRGB(120,160,100),
INP=Color3.fromRGB(12,18,10), ACCENT=Color3.fromRGB(100,200,40), ACCENT2=Color3.fromRGB(120,220,60),
ACCENT3=Color3.fromRGB(30,55,15), OFF=Color3.fromRGB(18,26,14), SECT=Color3.fromRGB(110,180,70),
MOB_ON=Color3.fromRGB(100,200,40), MOB_OFF=Color3.fromRGB(16,24,10), MOB_BORDER_OFF=Color3.fromRGB(40,60,20),
MOB_TEXT_OFF=Color3.fromRGB(150,190,120), MOB_TEXT_ON=Color3.fromRGB(8,20,5),
STEAL_BG=Color3.fromRGB(10,14,8), STEAL_FILL=Color3.fromRGB(100,200,40), STEAL_ACCENT=Color3.fromRGB(100,200,40),
PARTICLE=Color3.fromRGB(120,220,60),
},
}

-- Load/Save config (client-side only, no external logging)
local CONFIG_FILE = "UndefeatedHubConfig.json"

local function saveConfig()
LPH_ATTRIBUTES(VM(NONE))
pcall(function()
local cfg = {
theme = currentGuiTheme,
speedValue = _G._undefeated_speedValue or 58,
stealRadius = _G._undefeated_stealRadius or 60,
batAimFOV = _G._undefeated_batAimFOV or 90,
laserFOV = _G._undefeated_laserFOV or 120,
mobileButtonsEnabled = _G._undefeated_mobileButtonsEnabled ~= false,
mobileButtonsSize = _G._undefeated_mobileButtonsSize or 40,
statusBarPos = _G._undefeated_statusBarPos or {xs=0.5,xo=0,ys=0.3,yo=0},
skyTheme = currentSkyTheme or "Off",
}
writefile(CONFIG_FILE, HS:JSONEncode(cfg))
end)
end

local function loadConfig()
LPH_ATTRIBUTES(VM(NONE))
pcall(function()
if not isfile(CONFIG_FILE) then return end
local data = HS:JSONDecode(readfile(CONFIG_FILE))
if data then
if data.theme then currentGuiTheme = data.theme end
if data.speedValue then _G._undefeated_speedValue = data.speedValue end
if data.stealRadius then _G._undefeated_stealRadius = data.stealRadius end
if data.batAimFOV then _G._undefeated_batAimFOV = data.batAimFOV end
if data.laserFOV then _G._undefeated_laserFOV = data.laserFOV end
if data.mobileButtonsEnabled ~= nil then _G._undefeated_mobileButtonsEnabled = data.mobileButtonsEnabled end
if data.mobileButtonsSize then _G._undefeated_mobileButtonsSize = data.mobileButtonsSize end
if data.statusBarPos then _G._undefeated_statusBarPos = data.statusBarPos end
if data.skyTheme then currentSkyTheme = data.skyTheme end
end
end)
end

-- // Core Variables
local LP = Players.LocalPlayer
_G._undefeated_speedValue = _G._undefeated_speedValue or 58
_G._undefeated_stealRadius = _G._undefeated_stealRadius or 60
_G._undefeated_batAimFOV = _G._undefeated_batAimFOV or 90
_G._undefeated_laserFOV = _G._undefeated_laserFOV or 120
_G._undefeated_mobileButtonsEnabled = _G._undefeated_mobileButtonsEnabled ~= false
_G._undefeated_mobileButtonsSize = _G._undefeated_mobileButtonsSize or 40
_G._undefeated_statusBarPos = _G._undefeated_statusBarPos or {xs=0.5,xo=0,ys=0.3,yo=0}
_G._undefeated_cfgLoaded = false

-- // Anti-Cheat Bypasses
local function setupAntiCheat()
LPH_ATTRIBUTES(VM(NONE))
-- Velocity cap bypass
local velChecked = {}
local hookedVelParts = {}

local function setupVelChecked(char)
velChecked = {}
if not char then return end
local hrp = char:WaitForChild("HumanoidRootPart", 5)
if hrp then velChecked[hrp] = true end
return hrp
end

local function hookVelHRP(hrp)
if not hrp or hookedVelParts[hrp] then return end
hookedVelParts[hrp] = true
local mt = getrawmetatable(hrp)
if not mt then return end
setreadonly(mt, false)
local originalVelIndex = rawget(mt, "__index")
mt.__index = newcclosure(function(self, key)
if not checkcaller() and velChecked[self] and (key == "AssemblyLinearVelocity" or key == "Velocity") then
local real
if type(originalVelIndex) == "function" then
real = originalVelIndex(self, key)
elseif type(originalVelIndex) == "table" then
real = originalVelIndex[key]
end
if real and real.Magnitude > 20 then
return real.Unit * 20
end
return real
end
if type(originalVelIndex) == "function" then
return originalVelIndex(self, key)
elseif type(originalVelIndex) == "table" then
return originalVelIndex[key]
end
end)
setreadonly(mt, true)
end

if LP.Character then
local hrp = setupVelChecked(LP.Character)
hookVelHRP(hrp)
end
LP.CharacterAdded:Connect(function(char)
hookedVelParts = {}
local hrp = setupVelChecked(char)
hookVelHRP(hrp)
end)
end

setupAntiCheat()

-- // GUI Protection
local _gethui = typeof(gethui)=="function" and gethui or nil
local function protectGui(gui)
LPH_ATTRIBUTES(VM(NONE))
if not gui then return end
pcall(function()
if typeof(protect_gui)=="function" then protect_gui(gui)
elseif syn and syn.protect_gui then syn.protect_gui(gui)
elseif typeof(hide_in_gcoregui)=="function" then hide_in_gcoregui(gui)
end
end)
end
local function parentGui(gui)
LPH_ATTRIBUTES(VM(NONE))
if not gui then return end
protectGui(gui)
if _gethui then
pcall(function() gui.Parent=_gethui() end)
end
end

-- // File I/O (client-side only)
local _isfile = (typeof(isfile)=="function" and isfile)
    or (syn and syn.isfile)
    or (getgenv and getgenv().isfile)
    or function(p)
LPH_ATTRIBUTES(VM(NONE))
local ok, data = pcall(function() return readfile(p) end)
return ok and data ~= nil
end
local _readfile = (typeof(readfile)=="function" and readfile)
    or (syn and syn.readfile)
    or (getgenv and getgenv().readfile)
    or function() return nil end
local _writefile = (typeof(writefile)=="function" and writefile)
    or (syn and syn.writefile)
    or (getgenv and getgenv().writefile)
    or function() end
isfile, readfile, writefile = _isfile, _readfile, _writefile

-- // Sky System (retained from S2, rebranded)
local CANDY_SKY_TAG = "UndefeatedSkyTheme"
local currentSkyTheme = "Off"

-- (Sky presets and functions retained but tagged as Undefeated)
-- ... sky system omitted for brevity, identical to S2 but with CANDY_SKY_TAG changed

-- // Configuration Keys
local CONFIG_KEYS = {
"speedValue", "stealRadius", "batAimFOV", "laserFOV",
"mobileButtonsEnabled", "mobileButtonsSize", "statusBarPos", "skyTheme",
}

local function loadConfigKeys()
LPH_ATTRIBUTES(VM(NONE))
for _, k in ipairs(CONFIG_KEYS) do
pcall(function()
if _G["_undefeated_" .. k] == nil then
_G["_undefeated_" .. k] = _readfile("Undefeated_" .. k .. ".cfg")
end
end)
end
end

-- // Main GUI Builder
local function buildGui()
LPH_ATTRIBUTES(VM(NONE))

-- Clean up old GUI instances
for _, n in pairs({"S2JR_HUB","JispiHubGUI","UndefeatedHub"}) do
pcall(function() game:GetService("CoreGui"):FindFirstChild(n):Destroy() end)
pcall(function() if _gethui then _gethui():FindFirstChild(n):Destroy() end end)
end

-- Create main ScreenGui
local sg = Instance.new("ScreenGui")
sg.Name = "UndefeatedHub"
sg.ResetOnSpawn = false
sg.ZIndexBehavior = Enum.ZIndexBehavior.Global
parentGui(sg)
sg.Enabled = true

-- Main Window
local menuWindow = Instance.new("Frame", sg)
menuWindow.Name = "Main"
menuWindow.Size = UDim2.new(0,400,0,360)
menuWindow.Position = UDim2.new(0.5,-200,0.5,-180)
menuWindow.BackgroundColor3 = Color3.fromRGB(10,10,18)
menuWindow.BackgroundTransparency = 0.15
menuWindow.BorderSizePixel = 0
menuWindow.Active = true
menuWindow.Draggable = true
menuWindow.ClipsDescendants = true
menuWindow.Visible = true
Instance.new("UICorner",menuWindow).CornerRadius = UDim.new(0,14)

-- Background image
do
local bg=Instance.new("ImageLabel",menuWindow)
bg.Name="HubBG"
bg.Size=UDim2.new(1,0,1,0)
bg.Position=UDim2.new(0,0,0,0)
bg.BackgroundTransparency=1
bg.BorderSizePixel=0
bg.Image="rbxassetid://118131424737973"
bg.ScaleType=Enum.ScaleType.Crop
bg.ImageTransparency=0.2
bg.ZIndex=1
bg.Visible=true
Instance.new("UICorner",bg).CornerRadius=UDim.new(0,14)
local dim=Instance.new("Frame",menuWindow)
dim.Name="HubBGDim"
dim.Size=UDim2.new(1,0,1,0)
dim.BackgroundColor3=Color3.fromRGB(8,8,16)
dim.BackgroundTransparency=0.55
dim.BorderSizePixel=0
dim.ZIndex=1
Instance.new("UICorner",dim).CornerRadius=UDim.new(0,14)
end

local mStroke = Instance.new("UIStroke",menuWindow)
mStroke.Thickness=1
mStroke.Color=Color3.fromRGB(30,40,80)

-- Title Bar
local topBar = Instance.new("Frame",menuWindow)
topBar.Size = UDim2.new(1,0,0,38)
topBar.BackgroundTransparency = 1
topBar.BorderSizePixel = 0
topBar.ZIndex = 5

local topTitle = Instance.new("TextLabel",topBar)
topTitle.Size=UDim2.new(1,0,1,0)
topTitle.Position=UDim2.new(0,0,0,0)
topTitle.BackgroundTransparency=1
topTitle.Text="Un Defeated Hub"
topTitle.TextColor3=Color3.fromRGB(255,255,255)
topTitle.Font=Enum.Font.GothamBlack
topTitle.TextSize=14
topTitle.TextXAlignment=Enum.TextXAlignment.Center
topTitle.ZIndex=6

local closeBtn = Instance.new("TextButton",topBar)
closeBtn.Size=UDim2.new(0,28,0,28)
closeBtn.Position=UDim2.new(1,-33,0,5)
closeBtn.BackgroundColor3=Color3.fromRGB(200,50,50)
closeBtn.Text="X"
closeBtn.TextColor3=Color3.fromRGB(255,255,255)
closeBtn.Font=Enum.Font.GothamBold
closeBtn.TextSize=12
closeBtn.BorderSizePixel=0
closeBtn.ZIndex=6
Instance.new("UICorner",closeBtn).CornerRadius=UDim.new(0,6)

-- Side Navigation
local sideNav = Instance.new("Frame",menuWindow)
sideNav.Size=UDim2.new(0,50,1,-40)
sideNav.Position=UDim2.new(0,0,0,40)
sideNav.BackgroundColor3=Color3.fromRGB(10,10,18)
sideNav.BorderSizePixel=0
sideNav.ZIndex=4

local sideLayout = Instance.new("UIListLayout",sideNav)
sideLayout.SortOrder=Enum.SortOrder.LayoutOrder
sideLayout.Padding=UDim.new(0,4)

local sidePadding = Instance.new("UIPadding",sideNav)
sidePadding.PaddingTop=UDim.new(0,8)
sidePadding.PaddingBottom=UDim.new(0,8)

-- Tab Buttons
local TabNames = {"Move","Combat","Steal","Misc","Settings"}
local TabButtons = {}
local TabPages = {}
local CurrentTab = "Move"

for i, name in ipairs(TabNames) do
local btn = Instance.new("TextButton",sideNav)
btn.Name = name
btn.Size = UDim2.new(1,-10,0,36)
btn.BackgroundColor3 = Color3.fromRGB(18,18,30)
btn.Text = name
btn.TextColor3 = Color3.fromRGB(255,255,255)
btn.TextSize = 11
btn.Font = Enum.Font.GothamSemibold
btn.BorderSizePixel = 0
btn.LayoutOrder = i
btn.ZIndex = 5
Instance.new("UICorner",btn).CornerRadius=UDim.new(0,8)
TabButtons[name] = btn

btn.MouseButton1Click:Connect(function()
for k, v in pairs(TabButtons) do
v.BackgroundColor3 = Color3.fromRGB(18,18,30)
end
btn.BackgroundColor3 = Color3.fromRGB(80,120,255)
CurrentTab = name
for k, page in pairs(TabPages) do
page.Visible = (k == name)
end
end)
end

-- Content Area
local contentArea = Instance.new("Frame",menuWindow)
contentArea.Size=UDim2.new(1,-50,1,-40)
contentArea.Position=UDim2.new(0,50,0,40)
contentArea.BackgroundTransparency=1
contentArea.ZIndex=3

-- Create tab pages
for _, name in ipairs(TabNames) do
local page = Instance.new("ScrollingFrame",contentArea)
page.Name = name
page.Size = UDim2.new(1,0,1,0)
page.BackgroundTransparency = 1
page.ScrollBarThickness = 4
page.ScrollBarImageColor3 = Color3.fromRGB(80,120,255)
page.Visible = (name == "Move")
page.ZIndex = 3

local layout = Instance.new("UIListLayout",page)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0,4)

local padding = Instance.new("UIPadding",page)
padding.PaddingTop = UDim.new(0,4)
padding.PaddingBottom = UDim.new(0,4)
padding.PaddingLeft = UDim.new(0,6)
padding.PaddingRight = UDim.new(0,6)

TabPages[name] = page
end

-- Helper: Toggle
local function createToggle(parent, name, default, callback)
local frame = Instance.new("Frame",parent)
frame.Size=UDim2.new(1,-10,0,36)
frame.BackgroundColor3=Color3.fromRGB(18,18,30)
frame.BorderSizePixel=0
Instance.new("UICorner",frame).CornerRadius=UDim.new(0,8)

local lbl = Instance.new("TextLabel",frame)
lbl.Size=UDim2.new(0.6,0,1,0)
lbl.Position=UDim2.new(0,8,0,0)
lbl.BackgroundTransparency=1
lbl.Text=name
lbl.TextColor3=Color3.fromRGB(255,255,255)
lbl.TextSize=12
lbl.Font=Enum.Font.Gotham
lbl.TextXAlignment=Enum.TextXAlignment.Left

local toggle = Instance.new("TextButton",frame)
toggle.Size=UDim2.new(0,44,0,22)
toggle.Position=UDim2.new(1,-52,0,7)
toggle.BackgroundColor3=Color3.fromRGB(80,80,100)
toggle.Text=""
toggle.BorderSizePixel=0
Instance.new("UICorner",toggle).CornerRadius=UDim.new(0,11)

local knob = Instance.new("Frame",toggle)
knob.Size=UDim2.new(0,18,0,18)
knob.Position=UDim2.new(0,2,0,2)
knob.BackgroundColor3=Color3.fromRGB(255,255,255)
knob.BorderSizePixel=0
Instance.new("UICorner",knob).CornerRadius=UDim.new(0,9)

local enabled = default
if enabled then
toggle.BackgroundColor3=Color3.fromRGB(107,255,144)
knob.Position=UDim2.new(1,-20,0,2)
end

toggle.MouseButton1Click:Connect(function()
enabled = not enabled
if enabled then
toggle.BackgroundColor3=Color3.fromRGB(107,255,144)
knob.Position=UDim2.new(1,-20,0,2)
else
toggle.BackgroundColor3=Color3.fromRGB(80,80,100)
knob.Position=UDim2.new(0,2,0,2)
end
callback(enabled)
end)

return frame
end

-- Helper: Slider
local function createSlider(parent, name, min, max, default, callback)
local frame = Instance.new("Frame",parent)
frame.Size=UDim2.new(1,-10,0,50)
frame.BackgroundColor3=Color3.fromRGB(18,18,30)
frame.BorderSizePixel=0
Instance.new("UICorner",frame).CornerRadius=UDim.new(0,8)

local lbl = Instance.new("TextLabel",frame)
lbl.Size=UDim2.new(1,-16,0,20)
lbl.Position=UDim2.new(0,8,0,2)
lbl.BackgroundTransparency=1
lbl.Text=name..": "..tostring(default)
lbl.TextColor3=Color3.fromRGB(255,255,255)
lbl.TextSize=11
lbl.Font=Enum.Font.Gotham
lbl.TextXAlignment=Enum.TextXAlignment.Left

local sliderBg = Instance.new("Frame",frame)
sliderBg.Size=UDim2.new(1,-16,0,8)
sliderBg.Position=UDim2.new(0,8,0,26)
sliderBg.BackgroundColor3=Color3.fromRGB(60,60,80)
sliderBg.BorderSizePixel=0

local fill = Instance.new("Frame",sliderBg)
fill.Size=UDim2.new((default-min)/(max-min),0,1,0)
fill.BackgroundColor3=Color3.fromRGB(80,120,255)
fill.BorderSizePixel=0
Instance.new("UICorner",fill).CornerRadius=UDim.new(0,4)

local knob = Instance.new("Frame",sliderBg)
knob.Size=UDim2.new(0,14,0,14)
knob.Position=UDim2.new((default-min)/(max-min),-7,0,-3)
knob.BackgroundColor3=Color3.fromRGB(255,255,255)
knob.BorderSizePixel=0
knob.ZIndex=2
Instance.new("UICorner",knob).CornerRadius=UDim.new(0,7)

local dragging = false
sliderBg.InputBegan:Connect(function(input)
if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
dragging=true
end
end)
sliderBg.InputEnded:Connect(function(input)
if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
dragging=false
end
end)

UIS.InputChanged:Connect(function(input)
if dragging and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then
local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
local value = math.floor(min + pos * (max - min))
fill.Size = UDim2.new(pos,0,1,0)
knob.Position = UDim2.new(pos,-7,0,-3)
lbl.Text = name..": "..tostring(value)
callback(value)
end
end)

return frame
end

-- Helper: Section
local function createSection(parent, text)
local sec = Instance.new("TextLabel",parent)
sec.Size=UDim2.new(1,-10,0,24)
sec.BackgroundTransparency=1
sec.Text=text
sec.TextColor3=Color3.fromRGB(150,200,255)
sec.TextSize=12
sec.Font=Enum.Font.GothamBold
sec.TextXAlignment=Enum.TextXAlignment.Left
return sec
end

-- // TAB: Movement
do
local page = TabPages["Move"]
createSection(page, "Movement")

createToggle(page, "Speed Boost", false, function(v)
_G._undefeated_speedActive = v
end)

createSlider(page, "Speed Multiplier", 10, 100, _G._undefeated_speedValue or 58, function(v)
_G._undefeated_speedValue = v
end)

createToggle(page, "Infinite Jump", false, function(v)
_G._undefeated_infJump = v
end)

createToggle(page, "Fast Fall", false, function(v)
_G._undefeated_fastFall = v
end)

createToggle(page, "Drop Brainrots", false, function(v)
_G._undefeated_dropBrains = v
end)
end

-- // TAB: Combat
do
local page = TabPages["Combat"]
createSection(page, "Combat")

createToggle(page, "Bat Aimbot", false, function(v)
_G._undefeated_batAimbot = v
end)

createSlider(page, "Bat Aimbot FOV", 30, 180, _G._undefeated_batAimFOV or 90, function(v)
_G._undefeated_batAimFOV = v
end)

createToggle(page, "Laser Cap Aimbot (PvP)", false, function(v)
_G._undefeated_laserAimbot = v
end)

createSlider(page, "Laser Aimbot FOV", 30, 360, _G._undefeated_laserFOV or 120, function(v)
_G._undefeated_laserFOV = v
end)

createToggle(page, "ESP (Brains)", false, function(v)
_G._undefeated_esp = v
end)
end

-- // TAB: Steal
do
local page = TabPages["Steal"]
createSection(page, "Steal Tools")

createToggle(page, "Auto Steal", false, function(v)
_G._undefeated_autoSteal = v
end)

createSlider(page, "Steal Radius", 10, 200, _G._undefeated_stealRadius or 60, function(v)
_G._undefeated_stealRadius = v
end)

createToggle(page, "Auto Collect", false, function(v)
_G._undefeated_autoCollect = v
end)

createToggle(page, "Auto Sell", false, function(v)
_G._undefeated_autoSell = v
end)

createToggle(page, "Duel Mode", false, function(v)
_G._undefeated_duelMode = v
end)
end

-- // TAB: Misc
do
local page = TabPages["Misc"]
createSection(page, "Miscellaneous")

createToggle(page, "GUI Visible", true, function(v)
sg.Enabled = v
end)

createToggle(page, "Hide HUD", false, function(v)
pcall(function()
StarterGui:SetCore("ShowHUD", not v)
end)
end)
end

-- // TAB: Settings
do
local page = TabPages["Settings"]
createSection(page, "Appearance")

createSlider(page, "Gui Scale", 50, 150, 100, function(v)
local scale = v / 100
menuWindow.Size = UDim2.new(0, 400*scale, 0, 360*scale)
end)

createSection(page, "Theme")

-- Theme selector
local themeRow = Instance.new("Frame",page)
themeRow.Size=UDim2.new(1,-10,0,36)
themeRow.BackgroundColor3=Color3.fromRGB(18,18,30)
themeRow.BorderSizePixel=0
Instance.new("UICorner",themeRow).CornerRadius=UDim.new(0,8)

local themeLbl = Instance.new("TextLabel",themeRow)
themeLbl.Size=UDim2.new(0.5,0,1,0)
themeLbl.Position=UDim2.new(0,8,0,0)
themeLbl.BackgroundTransparency=1
themeLbl.Text="Theme"
themeLbl.TextColor3=Color3.fromRGB(255,255,255)
themeLbl.TextSize=11
themeLbl.Font=Enum.Font.Gotham
themeLbl.TextXAlignment=Enum.TextXAlignment.Left

local themeBtn = Instance.new("TextButton",themeRow)
themeBtn.Size=UDim2.new(0,100,0,24)
themeBtn.Position=UDim2.new(1,-108,0,6)
themeBtn.BackgroundColor3=Color3.fromRGB(80,120,255)
themeBtn.Text=currentGuiTheme
themeBtn.TextColor3=Color3.fromRGB(255,255,255)
themeBtn.TextSize=10
themeBtn.Font=Enum.Font.GothamBold
themeBtn.BorderSizePixel=0
Instance.new("UICorner",themeBtn).CornerRadius=UDim.new(0,6)

local themeIdx = 1
themeBtn.MouseButton1Click:Connect(function()
themeIdx = (themeIdx % #GUI_THEME_ORDER) + 1
currentGuiTheme = GUI_THEME_ORDER[themeIdx]
themeBtn.Text = currentGuiTheme
applyGuiTheme(currentGuiTheme)
pcall(saveConfig)
end)

createSection(page, "Info")
local infoLabel = Instance.new("TextLabel",page)
infoLabel.Size=UDim2.new(1,-10,0,40)
infoLabel.BackgroundTransparency=1
infoLabel.Text="Un Defeated Hub v5\nClient-side only. No cookies logged.\nHost on Pastebin or GitHub raw for loadstring."
infoLabel.TextColor3=Color3.fromRGB(150,150,170)
infoLabel.TextSize=10
infoLabel.Font=Enum.Font.Gotham
infoLabel.TextWrapped=true
infoLabel.TextXAlignment=Enum.TextXAlignment.Left
end

-- Close button
closeBtn.MouseButton1Click:Connect(function()
sg:Destroy()
end)

-- Dragging
local dragging, dragStart, startPos
topBar.InputBegan:Connect(function(input)
if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
dragging=true
dragStart=input.Position
startPos=menuWindow.Position
input.Changed:Connect(function()
if input.UserInputState==Enum.UserInputState.End then dragging=false end
end)
end
end)

UIS.InputChanged:Connect(function(input)
if dragging and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then
local delta=input.Position-dragStart
menuWindow.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
end
end)

-- Toggle GUI with RightShift
UIS.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.KeyCode == Enum.KeyCode.RightShift then
		menuWindow.Visible = not menuWindow.Visible
	end
end)
end

-- // Apply GUI Theme
local function applyGuiTheme(themeName)
LPH_ATTRIBUTES(VM(NONE))
local theme = GUI_THEMES[themeName]
if not theme then return end
-- Apply theme colors to GUI elements (simplified)
-- In full version this would iterate all GUI elements and recolor them
end

-- // Load Config
loadConfig()
loadConfigKeys()

-- // Init
pcall(function()
buildGui()
end)

-- // Notify on load
pcall(function()
StarterGui:SetCore("SendNotification", {
Title = "Un Defeated",
Text = "Hub v5 loaded. Client-side only. No cookies logged.",
Duration = 3
})
end)

print("[Un Defeated Hub v5] Loaded. No loggers. No cookies. Client-side only.")