RegisterAddonMessagePrefix("VersHPUpdate") RegisterAddonMessagePrefix("VersHPUpdate2") RegisterAddonMessagePrefix("TKA1")
TitleFont = "Fonts\\ARIALN.ttf"
Vers_Settings = {
	MinimapPos = 70; -- default position of the minimap icon in degrees
}
DM = { {}, {}, {}, {}, {}, {}, {}}
DM1 = { {}, {}, {}, {}, {}, {}, {}}
DM2 = { {}, {}, {}, {}, {}, {}, {}}
DM3 = { {}, {}, {}, {}, {}, {}, {}}
Skills2 = {}
local DMBlock = {
	Eneminput = {},
	Enembox = {},
	OffDC = {},
	DefDC = {},
	OffDCBox = {},
	DefDCBox = {},
	HPInput = {},
	HPBox = {},
	HPAdd = {},
	HPSub = {},
	MHPInput = {},
	MHPBox = {},
	Clear = {}
}
local Skills3 = {}
local RaidMembers = {}
-- Prepopulating Variables with Ints
	if VERSDC == nil then VERSDC = 0 end
	if VersHealthPoints == nil then VersHealthPoints = 5 end
	local DmgMsg = 1
	local TKAGlobal = 0
	local TKAGlobPush = 0
	local TKAWhispPush = 0
	local d100t = 0
	local d100 = 0
	local tkabgheight = 145
	local tkabars = 0

	for i=1,20 do
		Skills3["VERSSK"..i.."Temp"] = 0
	end

-- Prepopulating Variables with Strings
	local tkabutton1 = "VersButtonTemplate"
	local tkabutton2 = "VersButtonTemplate2"
	local Output = ""
	local Target = ""
	local playerTarget = "<No Target>"
	local TKAGlobMagic = false
	local TKADMGlobMagic = "All"
	if VERSTar == nil then VERSTar = "No Target" end
	if menuset == nil then menuset = "False" end
	local SUser = UnitName("Player")
	local VERSVersion = GetAddOnMetadata("TKAAddon", "Version")
	TarCol = "FFFFFFFF"
	if tkatoggleshow == nil then tkatoggleshow = "True" end
	if tkaminimapshow == nil then tkaminimapshow = "True" end

	local TKAPlayer = "<No Player Selected>"
	local TKAPlayerOut = "<No Player Selected>"

local ClassColorTable = {
	{ class = "Death Knight", color="FFC41F3B" },
	{ class = "Demon Hunter", color="FFA330C9" },
	{ class = "Druid", color="FFFF7D0A" },
	{ class = "Hunter", color="FFABD473" },
	{ class = "Mage", color="FF69CCF0" },
	{ class = "Paladin", color="FFF58CBA" },
	{ class = "Priest", color="FFFFFFFF" },
	{ class = "Rogue", color="FFFFF569" },
	{ class = "Shaman", color="FF0070DE" },
	{ class = "Warlock", color="FF9482C9" },
	{ class = "Warrior", color="FFC79C6E" }
}

--- NPC Stats

local vars = CreateFrame("Frame")
vars:SetScript("OnEvent",function(self,event,...)
	function Vers_MinimapButton_Reposition()
		Vers_MinimapButton:SetPoint("TOPLEFT","Minimap","TOPLEFT",52-(80*cos(Vers_Settings.MinimapPos)),(80*sin(Vers_Settings.MinimapPos))-52)
	end
	if not Vers_Settings.purge then
		DM1 = { {}, {}, {}, {}, {}, {}, {}}
		DM2 = { {}, {}, {}, {}, {}, {}, {}}
		DM3 = { {}, {}, {}, {}, {}, {}, {}}
		Vers_Settings.purge = true
	end
	if Vers_Settings.AbMod == nil then Vers_Settings.AbMod = 0 end
	if Vers_Settings.AbType == nil then Vers_Settings.AbType = "" end
	if Vers_Settings.AbTxt == nil then Vers_Settings.AbTxt = "No Ability Set" end
	if Vers_Settings.ArmorMod == nil then Vers_Settings.ArmorMod = 0 end
	if Vers_Settings.OffMod == nil then Vers_Settings.OffMod = 1 end
	if Vers_Settings.DefMod == nil then Vers_Settings.DefMod = 1 end
	if Vers_Settings.SocMod == nil then Vers_Settings.SocMod = 1 end
	if Vers_Settings.KnoMod == nil then Vers_Settings.KnoMod = 1 end
	if Vers_Settings.tkabreadtotal == nil then Vers_Settings.tkabreadtotal = 0 end
	if Vers_Settings.VRaidHigh == nil then Vers_Settings.VRaidHigh = 8 end
	if Vers_Settings.VRaidLow == nil then Vers_Settings.VRaidLow = 1 end
	if Vers_Settings.VerLatChk then Vers_Settings.VerLat = 2.5 else Vers_Settings.VerLat = 1 end
	for i=1,20 do
		if Skills2["VERSSKILL"..i] == nil then Skills2["VERSSKILL"..i] = "" end
		if Skills2["VERSSK"..i] == nil then Skills2["VERSSK"..i] = 0 end
	end
	for i=1,7 do
		if DM[i]["EnemyName"] == nil then DM[i]["EnemyName"] = "" end
		if DM[i]["OffDC"] == nil then DM[i]["OffDC"] = 0 end
		if DM[i]["DefDC"] == nil then DM[i]["DefDC"] = 0 end
		if DM[i]["EnemyHP"] == nil then DM[i]["EnemyHP"] = 0 end
		if DM[i]["EnemyMaxHP"] == nil then DM[i]["EnemyMaxHP"] = 0 end
	end
	for i=1,7 do
		if DM1[i]["EnemyName"] == nil then DM1[i]["EnemyName"] = "" end
		if DM1[i]["OffDC"] == nil then DM1[i]["OffDC"] = 0 end
		if DM1[i]["DefDC"] == nil then DM1[i]["DefDC"] = 0 end
		if DM1[i]["EnemyHP"] == nil then DM1[i]["EnemyHP"] = 0 end
		if DM1[i]["EnemyMaxHP"] == nil then DM1[i]["EnemyMaxHP"] = 0 end
	end
	for i=1,7 do
		if DM2[i]["EnemyName"] == nil then DM2[i]["EnemyName"] = "" end
		if DM2[i]["OffDC"] == nil then DM2[i]["OffDC"] = 0 end
		if DM2[i]["DefDC"] == nil then DM2[i]["DefDC"] = 0 end
		if DM2[i]["EnemyHP"] == nil then DM2[i]["EnemyHP"] = 0 end
		if DM2[i]["EnemyMaxHP"] == nil then DM2[i]["EnemyMaxHP"] = 0 end
	end
	for i=1,7 do
		if DM3[i]["EnemyName"] == nil then DM3[i]["EnemyName"] = "" end
		if DM3[i]["OffDC"] == nil then DM3[i]["OffDC"] = 0 end
		if DM3[i]["DefDC"] == nil then DM3[i]["DefDC"] = 0 end
		if DM3[i]["EnemyHP"] == nil then DM3[i]["EnemyHP"] = 0 end
		if DM3[i]["EnemyMaxHP"] == nil then DM3[i]["EnemyMaxHP"] = 0 end
	end
end)
vars:RegisterEvent("VARIABLES_LOADED")

Backdrop6 = {
	bgFile = "Interface\\ACHIEVEMENTFRAME\\UI-GuildAchievement-Parchment-Horizontal-Desaturated",  -- path to the background texture
	edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",  -- path to the border texture
	tile = true,    -- true to repeat the background texture to fill the frame, false to scale it
	tileSize = 32,  -- size (width or height) of the square repeating background tiles (in pixels)
	edgeSize = 32,  -- thickness of edge segments and square size of edge corners (in pixels)
	insets = {    -- distance from the edges of the frame to those of the background texture (in pixels)
		left = 11,
		right = 11,
		top = 11,  --12
		bottom = 10
	}
}
Backdrop = {
	bgFile = "Interface\\ACHIEVEMENTFRAME\\UI-GuildAchievement-Parchment-Horizontal-Desaturated",  -- path to the background texture
	edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Gold-Border",  -- path to the border texture
	tile = false,    -- true to repeat the background texture to fill the frame, false to scale it
	tileSize = 32,  -- size (width or height) of the square repeating background tiles (in pixels)
	edgeSize = 32,  -- thickness of edge segments and square size of edge corners (in pixels)
	insets = {    -- distance from the edges of the frame to those of the background texture (in pixels)
		left = 11,
		right = 11,
		top = 11,  --12
		bottom = 10
	}
}
Backdrop5 = {
	bgFile = "Interface\\ACHIEVEMENTFRAME\\UI-GuildAchievement-Parchment-Horizontal-Desaturated",  -- path to the background texture
	--bgFile = "Interface\\AddOns\\VERSAddon\\Backdrop\\Purp-Bg-1.blp",  -- path to the background texture
	--edgeFile = "Interface\\ACHIEVEMENTFRAME\\UI-Achievement-WoodBorder",  -- path to the border texture
	edgeFile = "Interface\\AddOns\\TKAAddon\\Backdrop\\Blue-Wood-Border.blp",  -- path to the border texture
	tile = false,    -- true to repeat the background texture to fill the frame, false to scale it
	tileSize = 32,  -- size (width or height) of the square repeating background tiles (in pixels)
	edgeSize = 32,  -- thickness of edge segments and square size of edge corners (in pixels)
	insets = {    -- distance from the edges of the frame to those of the background texture (in pixels)
		left = 11,
		right = 11,
		top = 10,  --12
		bottom = 11
	}
}

tkabread = math.random(100)
local VLocale = GetLocale()

if VLocale == "deDE" then rstring = "würfelt. Ergebnis:"
	elseif VLocale == "esES" then rstring = "tira los dados y obtiene"
	elseif Vlocale == "esMX" then rstring = "tira los dados y obtiene"
	elseif Vlocale == "frFR" then rstring = "obtient un"
	elseif Vlocale == "itIT" then rstring = "tira"
	elseif Vlocale == "ptBR" then rstring = "tira"
	else rstring = "rolls"
end

local f = CreateFrame("Frame")
f:SetScript("OnEvent",function(self,event,...)
	local arg1 = select(1,...)
	if arg1 then
		name,roll,minRoll,maxRoll = arg1:match("^(.+) "..rstring.." (%d+) %((%d+)%-(%d+)%)$")
		if maxRoll == "100" and name == SUser then d100 = tonumber(roll) end
		if d100 == tkabread then
			RaidNotice_AddMessage(RaidWarningFrame,"You found A Bread!",ChatTypeInfo["RAID_WARNING"]);
			tkabread = math.random(100)
			Vers_Settings.tkabreadtotal = Vers_Settings.tkabreadtotal + 1
			PlaySound(124)
		end
	end
end)
f:RegisterEvent("CHAT_MSG_SYSTEM")

local function contains(table, val)
   for i=1,#table do
      if table[i] == val then
         return true
      end
   end
   return false
end

local function getRaidMembers()
	local RaidNumber = GetNumGroupMembers()
	for i = 1,RaidNumber do
		local name = GetRaidRosterInfo(i)
		RaidMembers[i] = name
	end
end

local function dmString(Value,Type)
	return string.format("Global Modifier set to %s for %s Rolls.",Value,Type)
end

local function buttonLock()
	local v = 10
	if tkaroll2bg then v = 20 end
	for i=1,v do Skills3["skill"..i]:Disable() end
	RegularRoll:Disable()
	AbilityRoll:Disable()
end

local function buttonUnlock()
	local v = 10
	if tkaroll2bg then v = 20 end
	for i=1,v do Skills3["skill"..i]:Enable() end
	RegularRoll:Enable()
	AbilityRoll:Enable()
end

local function formatModifier(modifier)
  if modifier == 0 then return "" end;
  if modifier < 0 then return modifier end;
  return string.format("+%i", modifier);
end

local function formatOutput(roll, totalRoll, Skill, Ability, Armor, Temp, Global)
	if roll == totalRoll then return roll end
	return string.format("%s%s%s%s%s%s=%s",roll,Skill,Ability,Armor,Temp,Global,totalRoll)
end

local function formatOutputMessage(reCalc, skillName, abType, target, dcCheck, output, killMessage)
	return string.format("%sRolling %s%s%s. %s(%s)%s",reCalc,skillName,abType,target,dcCheck,output,killMessage)
end

local function formatAbilityOutput(roll, totalRoll, Ability, Global)
	if roll == totalRoll then return roll end
	return string.format("%s%s%s=%s",roll,Ability,Global,totalRoll)
end

local function formatAbilityOutputMessage(output, reCalc, abType, target, dcCheck)
	if abType == "" and TKAGlobal ~= 0 then return string.format("%sRolling D100 with Global Modifier! %s",reCalc,output) end
	if string.len(output)<=3 then return string.format("%sRolling D100! Result is: %s",reCalc,output) end
	local Ability = string.gsub(abType,"(%A)","")
	return string.format("%sRolling %s%s. %s(%s)",reCalc,Ability,target,dcCheck,output)
end

local function SendOutputMessage(Message)
	if IsInRaid() then
		SendChatMessage(Message, "RAID");
		return;
	end;
	if IsInGroup(LE_PARTY_CATEGORY_HOME) then
		SendChatMessage(Message, "PARTY");
		return;
	end;
	print(Message)
end

local function DMSave(saveData)
	for i=1,7 do
		saveData[i]["EnemyName"] = DM[i]["EnemyName"]
		saveData[i]["OffDC"] = DM[i]["OffDC"]
		saveData[i]["DefDC"] = DM[i]["DefDC"]
		saveData[i]["EnemyHP"] = DM[i]["EnemyHP"]
		saveData[i]["EnemyMaxHP"] = DM[i]["EnemyMaxHP"]
	end
end

local function DMLoad(loadData)
	for i=1,7 do
		DM[i]["EnemyName"] = loadData[i]["EnemyName"]
		DM[i]["OffDC"] = loadData[i]["OffDC"]
		DM[i]["DefDC"] = loadData[i]["DefDC"]
		DM[i]["EnemyHP"] = loadData[i]["EnemyHP"]
		DM[i]["EnemyMaxHP"] = loadData[i]["EnemyMaxHP"]
		DMBlock["Eneminput"][i]:SetText(DM[i]["EnemyName"])
		DMBlock["OffDC"][i]:SetText(DM[i]["OffDC"])
		DMBlock["DefDC"][i]:SetText(DM[i]["DefDC"])
		DMBlock["HPInput"][i]:SetText(DM[i]["EnemyHP"])
		DMBlock["MHPInput"][i]:SetText(DM[i]["EnemyMaxHP"])
	end
end

local function Tooltip(TipTxt,Parent)
	GameTooltip:SetOwner(Parent, "ANCHOR_NONE")
	GameTooltip:SetPoint("TOPLEFT",Parent,"TOPRIGHT",0,0)
	GameTooltip:SetText(TipTxt, nil, nil, nil, nil, true)
	GameTooltip:Show()
end

local function roll()
	if d100 > 0 and IsControlKeyDown() then
		d100 = d100 ReCalc = "(ReCalc)"
	else RandomRoll(1, 100) ReCalc = "" end
end

local function getArmorMod(Armor, Spell)
	if Spell then return Armor end
	return 0
end

local function getGlobalMod(Spell)
	if TKAGlobMagic and Spell then return TKAGlobal end
	if TKAGlobMagic and not Spell then return 0 end
	return TKAGlobal
end

local function getTargetString()
	if VERSTar == "" then return "" end
	return " on "..VERSTar
end

local function getPassFail(totalRoll,killToggle)
	local Outcome = "Fail"
	local outcomeString = ""
	local killString = ""
	local target = ""
	if VERSTar ~= "" then target = " on "..VERSTar end
	if totalRoll >= VERSDC then Outcome = "Pass" end
	if VERSDC ~= 0 then outcomeString = string.format("%s on DC%s.",Outcome,VERSDC) end
	if killToggle and Outcome == "Pass" then killString = string.format("(%s Damage%s)",DmgMsg,target) end
	return outcomeString,killString
end

local function rollcalc(SkillMod, TempMod, KillTog, SkillName, SpellTog)
	local Armour = getArmorMod(Vers_Settings.ArmorMod, SpellTog)
	local Global = getGlobalMod(SpellTog)
	local d100t = d100 + SkillMod + TempMod + Vers_Settings.AbMod + Armour + Global
	local Target = getTargetString()
	if d100t < 0 then d100t = 0 end
	local Outcome, KillMessage = getPassFail(d100t,KillTog)
	local ArmorTxt = formatModifier(Armour);
	local AbModTxt = formatModifier(Vers_Settings.AbMod);
	local TempTxt = formatModifier(TempMod);
	local GlobTxt = formatModifier(Global);
	local SkillTxt = formatModifier(SkillMod);
	local Output = formatOutput(d100, d100t, SkillTxt, AbModTxt, ArmorTxt, TempTxt, GlobTxt)
	local OutMsg = formatOutputMessage(ReCalc,SkillName,Vers_Settings.AbType,Target,Outcome,Output,KillMessage)
	SendOutputMessage(OutMsg)
	buttonUnlock()
end

local function abilityrollcalc()
	local Global = getGlobalMod()
	local d100t = d100 + Vers_Settings.AbMod + Global
	local Target = getTargetString()
	if d100t < 0 then d100t = 0 end
	local Outcome = getPassFail(d100t)
	local AbModTxt = formatModifier(Vers_Settings.AbMod);
	local GlobTxt = formatModifier(Global);
	local Output = formatAbilityOutput(d100, d100t, AbModTxt, GlobTxt)
	local OutMsg = formatAbilityOutputMessage(Output,ReCalc,Vers_Settings.AbType,Target,Outcome)
	SendOutputMessage(OutMsg)
	buttonUnlock()
end

local function tempModClear(Value)
	Skills3["VERSSK"..Value.."Temp"] = 0
	Skills3["sk"..Value.."tinput"]:SetText(Skills3["VERSSK"..Value.."Temp"])
end

local function getTargetName()
	playerTarget = UnitName("Target")
	if playerTarget == nil then playerTarget = "<No Target>" end
end

SLASH_TKARESET1 = '/tkareset';
function SlashCmdList.TKARESET(msg, editbox)
	tkabutton:ClearAllPoints()
	tkabutton:SetPoint("CENTER",0,0)
	menuset = "False"
	tkatoggleshow = "True"
	tkaminimapshow = "True"
	tkabutton:Show()
	Vers_MinimapButton:Show()
end

SLASH_TKABIND1 = '/tkabind';
function SlashCmdList.TKABIND(msg, editbox)
	if menuset == "True" then menuset = "False" else menuset = "True" end
	if menuset == "True" then menumsg = "The panels is now detached from the main button." else menumsg = "The panels is now bound to the main button." end
	print(menumsg)
end

SLASH_TKA1 = '/tka';
function SlashCmdList.TKA(msg, editbox)
	tkabutton:Click("LeftMouseButton",down)
end

tkabutton = CreateFrame("Button","tkabutton",UIParent,"VersButtonTemplate2")
tkabutton:SetFrameStrata("LOW")
tkabutton:SetFrameLevel(3)
tkabutton:SetHeight(35)
tkabutton:SetWidth(35)
tkabutton:SetPoint("CENTER",0,0)
tkabutton:SetMovable(true)
tkabutton:EnableMouse(true)
tkabutton:RegisterForDrag("LeftButton")
tkabutton:SetScript("OnDragStart", tkabutton.StartMoving)
tkabutton:SetScript("OnDragStop", tkabutton.StopMovingOrSizing)
tkabutton:SetNormalTexture("Interface\\Icons\\Spell_Holy_MagicalSentry")
tkabutton:SetScript("OnUpdate", function()
	if tkaminimapshow == "True" then Vers_MinimapButton:Show() else Vers_MinimapButton:Hide() end
	if tkatoggleshow == "True" then tkabutton:Show() else tkabutton:Hide() end
	end)
tkabutton:SetScript("OnClick",function()
	if tkamenubg then
    tkamenubg:Hide()
    tkamenubg = nil;
	else

	tkabutton1 = "VersButtonTemplate"
	tkabutton2 = "VersButtonTemplate2"
	tkabutton3 = "GameMenuButtonTemplate"

	tkamenubg = CreateFrame("Frame","tkamenubg",UIParent)
	tinsert(UISpecialFrames,"tkamenubg")
	tkamenubg:SetFrameStrata("LOW")
	tkamenubg:SetFrameLevel(5)
	tkamenubg:ClearAllPoints()
	tkamenubg:SetBackdrop(Backdrop6)
	tkamenubg:SetBackdropBorderColor(0,0.22,0.56,1)
	tkamenubg:SetBackdropColor(0,0.22,0.56,1)
	tkamenubg:SetHeight(130)
	tkamenubg:SetWidth(165)
	tkamenubg:SetScale(0.9)
	if menuset == "False" then tkamenubg:SetPoint("TOPLEFT",tkabutton,"TOPRIGHT",0,0) else tkamenubg:SetPoint("CENTER",UIParent,"BOTTOMLEFT",Vers_Settings.tkamenubgx,Vers_Settings.tkamenubgy) end
	tkamenubg:SetScript("OnHide", function() tkamenubg = nil tkabars = 0 end )
	tkamenubg:SetScript("OnUpdate", function() if tkamenubg == "Hide" then tkamenubg:Hide() tkamenubg = nil; end end)
	tkamenubg:SetMovable(true)
	tkamenubg:EnableMouse(true)
	tkamenubg:RegisterForDrag("LeftButton")
	tkamenubg:SetScript("OnDragStart", tkamenubg.StartMoving)
	tkamenubg:SetScript("OnDragStop", tkamenubg.StopMovingOrSizing)
	tkamenubg:SetScript("OnUpdate", function() Vers_Settings.tkamenubgx, Vers_Settings.tkamenubgy = tkamenubg:GetCenter() end)

	KAADDON = tkamenubg:CreateFontString(nil, "High", "GameTooltipText")
	KAADDON:SetPoint("TOP","tkamenubg",0,-12)
	KAADDON:SetText("|cffffffffKirin Aran Addon|r")
	KAADDON:SetFont("Fonts\\SKURRI.ttf", 14, "OUTLINE")

	VerTxt = tkamenubg:CreateFontString(nil, "High", "GameTooltipText")
	VerTxt:SetPoint("TOP","tkamenubg",0,-24)
	VerTxt:SetText("|cffffffffVersion "..VERSVersion.."|r")
	VerTxt:SetFont(TitleFont, 12, "OUTLINE")

	tkaroll = CreateFrame("Button","tkaroll",tkamenubg,tkabutton2)
	tkaroll:SetFrameStrata("LOW")
	tkaroll:SetPoint("TOP",tkamenubg,"TOP",0,-40)
	tkaroll:SetWidth(145)
	tkaroll:SetHeight(25)
	tkaroll:SetText("Roll Panel")
	tkaroll:SetScript("PreClick",function()
		if tkarolltog then
		tkarolltog = false else
		tkarolltog = true end
		end)
	tkaroll:SetScript("OnClick",function()
		if tkarollbg then
			tkarollbg:Hide()
			tkarollbg = nil;
		else

		sk2bar = 0

		for i=1,10 do
			if Skills2["VERSSKILL"..i] ~= "" then tkabars = tkabars + 25 end
		end
		for i=11,20 do
			if Skills2["VERSSKILL"..i] ~= "" then sk2bar = 25 end
		end

		tkarollbg = CreateFrame("Frame","tkarollbg",tkamenubg)
		tinsert(UISpecialFrames,"tkarollbg")
		tkarollbg:SetFrameStrata("low")
		tkarollbg:SetFrameLevel(10)
		tkarollbg:ClearAllPoints()
		tkarollbg:SetBackdrop(Backdrop6)
		tkarollbg:SetBackdropBorderColor(0,0.19,0.46,1)
		tkarollbg:SetBackdropColor(0,0.19,0.46,1)
		tkarollbg:SetHeight(tkabgheight+tkabars+sk2bar+115)
		tkarollbg:SetWidth(200)
		tkarollbg:SetScript("OnHide", function() tkarollbg = nil tkabars = 0 end )
		tkarollbg:SetScript("OnUpdate", function() if tkarollbg == "Hide" then tkarollbg:Hide() tkarollbg = nil; end end)
		tkarollbg:SetMovable(true)
		tkarollbg:EnableMouse(true)
		tkarollbg:RegisterForDrag("LeftButton")
		if menuset == "False" then tkarollbg:SetPoint("TOPLEFT",tkamenubg,"TOPRIGHT",0,0) else tkarollbg:SetPoint("CENTER",UIParent,"BOTTOMLEFT",Vers_Settings.tkarollx,Vers_Settings.tkarolly) end
		tkarollbg:SetScript("OnUpdate", function() Vers_Settings.tkarollx, Vers_Settings.tkarolly = tkarollbg:GetCenter() end)
		tkarollbg:SetScript("OnDragStart", tkarollbg.StartMoving)
		tkarollbg:SetScript("OnDragStop", tkarollbg.StopMovingOrSizing)

		tkadcinput = CreateFrame("Button","tkadcinput",tkarollbg,tkabutton2)
		tkadcinput:SetFrameStrata("LOW")
		tkadcinput:SetPoint("TOPLEFT",50,-45)
		tkadcinput:SetWidth(29)
		tkadcinput:SetHeight(25)
		tkadcinput:SetText(VERSDC)
		tkadcinput:SetScript("PostClick", function() tkadcinput:Show() end)
		tkadcinput:SetScript("OnClick",function()
			tkadcbox = CreateFrame("EditBox","tkadcbox",tkarollbg,"TKAEditBox")
			tkadcbox:SetFrameStrata("MEDIUM")
			tkadcbox:SetFontObject("CombatLogFont")
			tkadcbox:SetWidth(20)
			tkadcbox:SetHeight(25)
			tkadcbox:SetPoint("CENTER",tkadcinput,"CENTER",0,0)
			tkadcbox:SetScript("OnEscapePressed",function()
				tkadcbox:Hide()
				tkadcinput:Show()
			end)
			tkadcbox:SetScript("OnEnterPressed",function()
				VERSDC = tkadcbox:GetNumber()
				tkadcbox:Hide()
				tkadcinput:Show()
				tkadcinput:SetText(VERSDC)
			end)
		end)

		tkadcadd = CreateFrame("Button","tkadcadd",tkarollbg,tkabutton2)
		tkadcadd:SetFrameStrata("LOW")
		tkadcadd:SetPoint("LEFT",tkadcinput,"RIGHT",-3,0)
		tkadcadd:SetWidth(22)
		tkadcadd:SetHeight(25)
		tkadcadd:SetText("+")
		tkadcadd:SetScript("OnEnter",function()
			Tooltip("Click to increase by 10. Shift+Click to increase by 5. Ctrl+Click to increase by 1.",tkarollbg)
		end)
		tkadcadd:SetScript("OnLeave",function()
			GameTooltip:Hide()
		end)
		tkadcadd:SetScript("OnClick",function()
			IsShiftKeyDown()
			if IsShiftKeyDown() then VERSDC = VERSDC + 5
			elseif IsControlKeyDown() then VERSDC = VERSDC + 1 else
			VERSDC = VERSDC + 10 end
			if IsControlKeyDown() then VERSDC = VERSDC else VERSDC = math.floor(VERSDC/5)*5 end
			tkadcinput:SetText(VERSDC)
		end)

		tkadcsub = CreateFrame("Button","tkadcsub",tkarollbg,tkabutton2)
		tkadcsub:SetFrameStrata("LOW")
		tkadcsub:SetPoint("RIGHT",tkadcinput,"LEFT",3,0)
		tkadcsub:SetWidth(22)
		tkadcsub:SetHeight(25)
		tkadcsub:SetText("-")
		tkadcsub:SetScript("OnEnter",function()
			Tooltip("Click to decrease by 10. Shift+Click to decrease by 5. Ctrl+Click to decrease by 1.",tkarollbg)
		end)
		tkadcsub:SetScript("OnLeave",function()
			GameTooltip:Hide()
		end)
		tkadcsub:SetScript("OnClick",function()
			if IsShiftKeyDown()then VERSDC = VERSDC - 5
			elseif IsControlKeyDown() then VERSDC = VERSDC - 1 else
			VERSDC = VERSDC - 10 end
			if IsControlKeyDown() then VERSDC = VERSDC else VERSDC = math.floor(VERSDC/5)*5 end
			if VERSDC < 0 then VERSDC = 0 end
			tkadcinput:SetText(VERSDC)
		end)

		VERSDCTX = tkarollbg:CreateFontString(nil, "High", "GameTooltipText")
		VERSDCTX:SetPoint("RIGHT","tkadcsub","LEFT",2,0)
		VERSDCTX:SetText("DC:")
		VERSDCTX:SetFont("Fonts\\ARIALN.ttf", 11, "OUTLINE")

		tkahpinput = CreateFrame("Button","tkahpinput",tkarollbg,tkabutton2)
		tkahpinput:SetFrameStrata("LOW")
		tkahpinput:SetPoint("LEFT",tkadcinput,"RIGHT",60,0)
		tkahpinput:SetWidth(29)
		tkahpinput:SetHeight(25)
		tkahpinput:SetText(VersHealthPoints)
		tkahpinput:SetScript("PostClick", function() tkahpinput:Show()end)
		tkahpinput:SetScript("OnClick",function()
			tkahpbox = CreateFrame("EditBox","tkahpbox",tkarollbg,"TKAEditBox")
			tkahpbox:SetFrameStrata("MEDIUM")
			tkahpbox:SetFontObject("CombatLogFont")
			tkahpbox:SetWidth(20)
			tkahpbox:SetHeight(25)
			tkahpbox:SetPoint("CENTER",tkahpinput,"CENTER",0,0)
			tkahpbox:SetScript("OnEscapePressed",function()
				tkahpbox:Hide()
				tkahpinput:Show()
			end)
			tkahpbox:SetScript("OnEnterPressed",function()
				VersHealthPoints = tkahpbox:GetNumber()
				tkahpbox:Hide()
				tkahpinput:Show()
				tkahpinput:SetText(VersHealthPoints)
				end)
			end)

		tkahpadd = CreateFrame("Button","tkahpadd",tkarollbg,tkabutton2)
		tkahpadd:SetFrameStrata("LOW")
		tkahpadd:SetPoint("LEFT",tkahpinput,"RIGHT",-3,0)
		tkahpadd:SetWidth(22)
		tkahpadd:SetHeight(25)
		tkahpadd:SetText("+")
		tkahpadd:SetScript("OnClick",function()
			VersHealthPoints = VersHealthPoints + 1
			tkahpinput:SetText(VersHealthPoints)
		end)

		tkahpsub = CreateFrame("Button","tkahpsub",tkarollbg,tkabutton2)
		tkahpsub:SetFrameStrata("LOW")
		tkahpsub:SetPoint("RIGHT",tkahpinput,"LEFT",3,0)
		tkahpsub:SetWidth(22)
		tkahpsub:SetHeight(25)
		tkahpsub:SetText("-")
		tkahpsub:SetScript("OnClick",function()
			VersHealthPoints = VersHealthPoints - 1
			if VersHealthPoints < 0 then VersHealthPoints = 0 end
			tkahpinput:SetText(VersHealthPoints)
		end)

		VEHPTX = tkarollbg:CreateFontString(nil, "High", "GameTooltipText")
		VEHPTX:SetPoint("RIGHT",tkahpsub,"LEFT",2,0)
		VEHPTX:SetText("HP:")
		VEHPTX:SetJustifyH("RIGHT")
		VEHPTX:SetFont("Fonts\\ARIALN.ttf", 11, "OUTLINE")

		tkaglobin = CreateFrame("Button","tkaglobin",tkarollbg,tkabutton2)
		tkaglobin:SetFrameStrata("LOW")
		tkaglobin:SetPoint("BOTTOMRIGHT",tkahpadd,"TOPRIGHT",0,5)
		tkaglobin:SetWidth(35)
		tkaglobin:SetHeight(25)
		tkaglobin:SetText(TKAGlobal)
		tkaglobin:SetScript("OnEnter",function()
			Tooltip("For use when you have an eventwide Modifier to your Rolls. (Can be set by Raid Leader and Assist from the DM Panel.)",tkarollbg)
		end)
		tkaglobin:SetScript("OnLeave",function()
			GameTooltip:Hide()
		end)
		tkaglobin:SetScript("OnClick",function()
			tkaglobbox = CreateFrame("EditBox","tkaglobbox",tkarollbg,"TKAEditBox")
			tkaglobbox:SetFrameStrata("MEDIUM")
			tkaglobbox:SetFontObject("CombatLogFont")
			tkaglobbox:SetWidth(25)
			tkaglobbox:SetHeight(25)
			tkaglobbox:SetPoint("CENTER",tkaglobin,"CENTER",0,0)
			tkaglobbox:SetScript("OnEnterPressed",function()
				TKAGlobal = tkaglobbox:GetNumber()
				tkaglobbox:Hide()
				tkaglobin:SetText(TKAGlobal)
				end)
			end)

		GLOBTX = tkarollbg:CreateFontString(nil, "High", "GameTooltipText")
		GLOBTX:SetPoint("RIGHT",tkaglobin,"LEFT",0,0)
		GLOBTX:SetText("Global Roll\nModifier:")
		GLOBTX:SetFont("Fonts\\ARIALN.ttf", 11, "OUTLINE")

		tkaglobmagic = CreateFrame("CheckButton",tkaglobmagic,tkarollbg,"ChatConfigBaseCheckButtonTemplate")
		tkaglobmagic:SetFrameStrata("LOW")
		tkaglobmagic:SetPoint("RIGHT",tkaglobin,"LEFT",-60,0)
		tkaglobmagic:SetWidth(30)
		tkaglobmagic:SetHeight(30)
		if TKAGlobMagic then tkaglobmagic:SetChecked(true) else tkaglobmagic:SetChecked(false) end
		tkaglobmagic:SetScript("OnEnter",function()
			Tooltip("Toggle to ensure the Global Modifier is only applied to Magic Rolls.",tkarollbg)
		end)
		tkaglobmagic:SetScript("OnLeave",function()
			GameTooltip:Hide()
		end)
		tkaglobmagic:SetScript("OnClick", function()
			if TKAGlobMagic then
				TKAGlobMagic = false
			else
				TKAGlobMagic = true
			end
		end)

		GLOBSPTX = tkarollbg:CreateFontString(nil, "High", "GameTooltipText")
		GLOBSPTX:SetPoint("RIGHT",tkaglobmagic,"LEFT",0,0)
		GLOBSPTX:SetText("Magic\nToggle:")
		GLOBSPTX:SetFont("Fonts\\ARIALN.ttf", 11, "OUTLINE")

		tkatarinput = CreateFrame("Button","tkatarinput",tkarollbg,tkabutton2)
		tkatarinput:SetFrameStrata("LOW")
		tkatarinput:SetNormalFontObject("GameFontWhiteSmall")
		tkatarinput:SetPoint("TOPLEFT",tkadcinput,"BOTTOMLEFT",0,0)
		tkatarinput:SetWidth(137)
		tkatarinput:SetHeight(25)
		tkatarinput:SetText(VERSTar)
		tkatarinput:SetScript("PostClick", function() tkatarinput:Show() end)
		tkatarinput:SetScript("OnClick",function()
			tkatarbox = CreateFrame("EditBox","tkatarbox",tkarollbg,"TKAEditBox")
			tkatarbox:SetFrameStrata("MEDIUM")
			tkatarbox:SetFontObject("CombatLogFont")
			tkatarbox:SetWidth(137)
			tkatarbox:SetHeight(25)
			tkatarbox:SetPoint("CENTER",tkatarinput,"CENTER",0,0)
			tkatarbox:SetScript("OnEnterPressed",function()
				VERSTar = tkatarbox:GetText()
				tkatarbox:Hide()
				tkatarinput:Show()
				tkatarinput:SetText(VERSTar)
			end)
		end)

		tkatarreset = CreateFrame("Button","tkatarreset",tkarollbg,tkabutton2)
		tkatarreset:SetFrameStrata("LOW")
		tkatarreset:SetPoint("TOPRIGHT","tkatarinput","BOTTOMRIGHT",0,0)
		tkatarreset:SetWidth(137)
		tkatarreset:SetHeight(25)
		tkatarreset:SetText("Clear Target & DC")
		tkatarreset:SetScript("OnClick",function()
			VERSTar = ""
			VERSDC = 0
			tkatarinput:SetText(VERSTar)
			tkadcinput:SetText(VERSDC)
		end)

		VERSTART = tkarollbg:CreateFontString(nil, "High", "GameTooltipText")
		VERSTART:SetPoint("RIGHT","tkatarinput","LEFT",1,0)
		VERSTART:SetText("Target:")
		VERSTART:SetFont("Fonts\\ARIALN.ttf", 11, "OUTLINE")

		local RollBars = -2
			for i=1,10 do

			Skills3["RollBars"..i] = RollBars
			Skills3["skill"..i] = CreateFrame("Button",Skills3["skill"..i],tkarollbg,tkabutton2)
			Skills3["skill"..i]:SetFrameStrata("LOW")
			Skills3["skill"..i]:SetPoint("TOPRIGHT",tkatarreset,"BOTTOMRIGHT",0,Skills3["RollBars"..i])
			Skills3["skill"..i]:SetWidth(145)
			Skills3["skill"..i]:SetHeight(25)
			Skills3["skill"..i]:SetText(Skills2["VERSSKILL"..i])
			if Skills2["VERSSKILL"..i] == "" then Skills3["skill"..i]:Hide() end
			Skills3["skill"..i]:SetScript("OnClick", function()
				buttonLock()
				roll()
				C_Timer.After(Vers_Settings.VerLat, function()
					rollcalc(Skills2["VERSSK"..i], Skills3["VERSSK"..i.."Temp"], Skills2["skill"..i.."k"], Skills2["VERSSKILL"..i], Skills2["skill"..i.."s"])
					tempModClear(i)
					buttonUnlock()
				end )
			end )

			Skills3["sk"..i.."tinput"] = CreateFrame("Button",Skills3["sk"..i.."tinput"],tkarollbg,tkabutton2)
			Skills3["sk"..i.."tinput"]:SetFrameStrata("LOW")
			Skills3["sk"..i.."tinput"]:SetPoint("RIGHT",Skills3["skill"..i],"LEFT",0,0)
			Skills3["sk"..i.."tinput"]:SetWidth(30)
			Skills3["sk"..i.."tinput"]:SetHeight(25)
			Skills3["sk"..i.."tinput"]:SetText(Skills3["VERSSK"..i.."Temp"])
			if Skills2["VERSSKILL"..i] == "" then Skills3["sk"..i.."tinput"]:Hide() end
			Skills3["sk"..i.."tinput"]:SetScript("OnClick",function()
				Skills3["sk"..i.."tbox"] = CreateFrame("EditBox",Skills3["sk"..i.."tbox"],tkarollbg,"TKAEditBox")
				Skills3["sk"..i.."tbox"]:SetFrameStrata("MEDIUM")
				Skills3["sk"..i.."tbox"]:SetFontObject("CombatLogFont")
				Skills3["sk"..i.."tbox"]:SetWidth(20)
				Skills3["sk"..i.."tbox"]:SetHeight(25)
				Skills3["sk"..i.."tbox"]:SetPoint("CENTER",Skills3["sk"..i.."tinput"],"CENTER",0,0)
				Skills3["sk"..i.."tbox"]:SetScript("OnEnterPressed",function()
					Skills3["VERSSK"..i.."Temp"] = Skills3["sk"..i.."tbox"]:GetNumber()
					Skills3["sk"..i.."tbox"]:Hide()
					Skills3["sk"..i.."tinput"]:SetText(Skills3["VERSSK"..i.."Temp"])
					end)
				end)

			RollBars = RollBars - 25

		end

		VERSMOD = tkarollbg:CreateFontString(nil, "High", "GameTooltipText")
		VERSMOD:SetPoint("BOTTOM",Skills3["sk1tinput"],"TOP",2,0)
		VERSMOD:SetText("Temp\n Mod:")
		VERSMOD:SetFont("Fonts\\ARIALN.ttf", 11, "OUTLINE")

		hpupdate = CreateFrame("Button","hpupdate",tkarollbg,tkabutton1)
		hpupdate:SetFrameStrata("LOW")
		hpupdate:SetPoint("Bottom","tkarollbg",0,15)
		hpupdate:SetWidth(175)
		hpupdate:SetHeight(25)
		hpupdate:SetText("HP Report")
		hpupdate:SetScript("OnClick", function()
			if tkahpstatframe then
			tkahpstatframe:Hide()
			tkahpstatframe = nil;
			else
				tkahpstatframe = CreateFrame("Frame","tkahpstatframe",tkarollbg)
				tkahpstatframe:SetFrameStrata("LOW")
				tkahpstatframe:SetSize(140,320)
				tkahpstatframe:SetPoint("BOTTOMLEFT",tkarollbg,"BOTTOMRIGHT",0,0)
				tkahpstatframe:SetBackdrop(Backdrop6)
				tkahpstatframe:SetBackdropColor(0,0,0,0.8)
				tkahpstatframe:SetBackdropBorderColor(0.8,0.8,0.8,0.8)
				tkahpstatframe:SetMovable(true)
				tkahpstatframe:EnableMouse(true)
				tkahpstatframe:RegisterForDrag("LeftButton")
				tkahpstatframe:SetScript("OnDragStart", tkahpstatframe.StartMoving)
				tkahpstatframe:SetScript("OnDragStop", tkahpstatframe.StopMovingOrSizing)
				tkahpstatframe:SetScript("OnHide", function() tkahpstatframe = nil end )

				tkahpstatframe2 = CreateFrame("MessageFrame","tkahpstatframe2",tkahpstatframe)
				tkahpstatframe2:SetFrameStrata("LOW")
				tkahpstatframe2:SetSize(110,180)
				tkahpstatframe2:SetScale(1.3)
				tkahpstatframe2:SetFontObject("GameFontWhiteSmall")
				--tkahpstatframe2:SetFont("Fonts\\ARIALN.ttf", 12)
				tkahpstatframe2:SetPoint("TOP","tkahpstatframe",0,-13)
				tkahpstatframe2:SetInsertMode("BOTTOM")
				tkahpstatframe2:SetTimeVisible(60)

				tkahpupdate2 = CreateFrame("Button","tkahpupdate2",tkahpstatframe,tkabutton1)
				tkahpupdate2:SetFrameStrata("LOW")
				tkahpupdate2:SetPoint("BOTTOM",tkahpstatframe,"BOTTOM",0,10)
				tkahpupdate2:SetWidth(110)
				tkahpupdate2:SetHeight(20)
				tkahpupdate2:SetText("Update")
				tkahpupdate2:SetScript("PreClick", function()
					SendAddonMessage("VersHPUpdate","Msg","RAID") end)
				end
		end)

		tkaroll2 = CreateFrame("Button","tkaroll2",tkarollbg,tkabutton1)
		tkaroll2:SetFrameStrata("LOW")
		tkaroll2:SetPoint("BOTTOMLEFT",hpupdate,"TOPLEFT",0,0)
		tkaroll2:SetWidth(175)
		tkaroll2:SetHeight(25)
		tkaroll2:SetText("More Skills")
		tkaroll2:Hide()
		if sk2bar ~= 0 then tkaroll2:Show() end
		tkaroll2:SetScript("PreClick",function()
			if tkaroll2tog == "True" then
			tkaroll2tog = "False" else
			tkaroll2tog = "True" end
			end)
		tkaroll2:SetScript("OnClick",function()
			if tkaroll2bg then
			tkaroll2bg:Hide()
			tkaroll2bg = nil;
			else
			local tkabars2 = 9

			for i=11,20 do
				if Skills2["VERSSKILL"..i] ~= "" then tkabars2 = tkabars2 + 25 end
			end

			tkaroll2bg = CreateFrame("Frame","tkaroll2bg",tkarollbg)
			tkaroll2bg:SetFrameStrata("low")
			tkaroll2bg:SetFrameLevel(15)
			tkaroll2bg:ClearAllPoints()
			tkaroll2bg:SetBackdrop(Backdrop6)
			tkaroll2bg:SetBackdropBorderColor(0,0.19,0.46,1)
			tkaroll2bg:SetBackdropColor(0,0.19,0.46,1)
			tkaroll2bg:SetHeight(tkabars2)
			tkaroll2bg:SetWidth(200)
			tkaroll2bg:SetScript("OnHide", function() tkaroll2bg = nil tkabars = 0 end )
			tkaroll2bg:SetScript("OnUpdate", function() if tkaroll2bg == "Hide" then tkaroll2bg:Hide() tkaroll2bg = nil; end end)
			tkaroll2bg:SetMovable(true)
			tkaroll2bg:EnableMouse(true)
			tkaroll2bg:RegisterForDrag("LeftButton")
			if menuset == "False" then tkaroll2bg:SetPoint("TOPLEFT",tkarollbg,"TOPRIGHT",0,0) else tkaroll2bg:SetPoint("CENTER",UIParent,"BOTTOMLEFT",Vers_Settings.tkaroll2x,Vers_Settings.tkaroll2y) end
			tkaroll2bg:SetScript("OnUpdate", function() Vers_Settings.tkaroll2x, Vers_Settings.tkaroll2y = tkaroll2bg:GetCenter() end)
			tkaroll2bg:SetScript("OnDragStart", tkaroll2bg.StartMoving)
			tkaroll2bg:SetScript("OnDragStop", tkaroll2bg.StopMovingOrSizing)
			local Roll2Bars = -13
				for i=11,20 do

				Skills3["Roll2Bars"..i] = Roll2Bars
				Skills3["skill"..i] = CreateFrame("Button",Skills3["skill"..i],tkaroll2bg,tkabutton2)
				Skills3["skill"..i]:SetFrameStrata("LOW")
				Skills3["skill"..i]:SetPoint("TOPRIGHT",tkaroll2bg,"TOPRIGHT",-14,Skills3["Roll2Bars"..i])
				Skills3["skill"..i]:SetWidth(145)
				Skills3["skill"..i]:SetHeight(25)
				Skills3["skill"..i]:SetText(Skills2["VERSSKILL"..i])
				if Skills2["VERSSKILL"..i] == "" then Skills3["skill"..i]:Hide() end
				Skills3["skill"..i]:SetScript("OnClick", function()
					buttonLock()
					roll()
					C_Timer.After(Vers_Settings.VerLat, function()
						rollcalc(Skills2["VERSSK"..i], Skills3["VERSSK"..i.."Temp"], Skills2["skill"..i.."k"], Skills2["VERSSKILL"..i], Skills2["skill"..i.."s"])
						tempModClear(i)
						buttonUnlock()
					end )
				end )

				Skills3["sk"..i.."tinput"] = CreateFrame("Button",Skills3["sk"..i.."tinput"],tkaroll2bg,tkabutton2)
				Skills3["sk"..i.."tinput"]:SetFrameStrata("LOW")
				Skills3["sk"..i.."tinput"]:SetPoint("RIGHT",Skills3["skill"..i],"LEFT",0,0)
				Skills3["sk"..i.."tinput"]:SetWidth(30)
				Skills3["sk"..i.."tinput"]:SetHeight(25)
				Skills3["sk"..i.."tinput"]:SetText(Skills3["VERSSK"..i.."Temp"])
				if Skills2["VERSSKILL"..i] == "" then Skills3["sk"..i.."tinput"]:Hide() end
				Skills3["sk"..i.."tinput"]:SetScript("OnClick",function()
					Skills3["sk"..i.."tbox"] = CreateFrame("EditBox",Skills3["sk"..i.."tbox"],tkaroll2bg,"TKAEditBox")
					Skills3["sk"..i.."tbox"]:SetFrameStrata("MEDIUM")
					Skills3["sk"..i.."tbox"]:SetFontObject("CombatLogFont")
					Skills3["sk"..i.."tbox"]:SetWidth(20)
					Skills3["sk"..i.."tbox"]:SetHeight(25)
					Skills3["sk"..i.."tbox"]:SetPoint("CENTER",Skills3["sk"..i.."tinput"],"CENTER",0,0)
					Skills3["sk"..i.."tbox"]:SetScript("OnEnterPressed",function()
						Skills3["VERSSK"..i.."Temp"] = Skills3["sk"..i.."tbox"]:GetNumber()
						Skills3["sk"..i.."tbox"]:Hide()
						Skills3["sk"..i.."tinput"]:SetText(Skills3["VERSSK"..i.."Temp"])
						end)
					end)

				Roll2Bars = Roll2Bars - 23

				end
			end
		end)

		RegularRoll = CreateFrame("Button","RegularRoll",tkarollbg,tkabutton2)
		RegularRoll:SetFrameStrata("LOW")
		if sk2bar ~= 0 then RegularRoll:SetPoint("BOTTOMLEFT",tkaroll2,"TOPLEFT",0,0) else RegularRoll:SetPoint("BOTTOMLEFT",hpupdate,"TOPLEFT",0,0) end
		RegularRoll:SetWidth(87.5)
		RegularRoll:SetHeight(25)
		RegularRoll:SetText("D100 Roll")
		RegularRoll:SetScript("OnClick", function()
			roll()
			C_Timer.After(Vers_Settings.VerLat, function()
				local OutMsg = formatAbilityOutputMessage(d100,ReCalc,"")
				SendOutputMessage(OutMsg)
				buttonUnlock()
			end )
		end )

		AbilityRoll = CreateFrame("Button","AbilityRoll",tkarollbg,tkabutton2)
		AbilityRoll:SetFrameStrata("LOW")
		AbilityRoll:SetPoint("LEFT","RegularRoll","RIGHT",0,0)
		AbilityRoll:SetWidth(87.5)
		AbilityRoll:SetHeight(25)
		AbilityRoll:SetText("Ability Roll")
		AbilityRoll:SetScript("OnClick", function()
			roll()
			C_Timer.After(Vers_Settings.VerLat, function()
				abilityrollcalc()
			end )
		end )

		SocRoll = CreateFrame("Button","SocRoll",tkarollbg,tkabutton2)
		SocRoll:SetFrameStrata("LOW")
		SocRoll:SetPoint("BOTTOMLEFT",RegularRoll,"TOPLEFT",0,0)
		SocRoll:SetWidth(61)
		SocRoll:SetHeight(25)
		SocRoll:SetText("Social")
		SocRoll:SetNormalFontObject("GameFontWhiteSmall")
		SocRoll:SetHighlightFontObject("GameFontWhiteSmall")
		SocRoll:SetScript("OnClick",function()
			Vers_Settings.AbMod = Vers_Settings.SocMod
			Vers_Settings.AbType = "(Social)"
			Vers_Settings.AbTxt = "Social ("..Vers_Settings.SocMod..")"
			AbModTxt:SetText(Vers_Settings.AbTxt)
		end)

		KnoRoll = CreateFrame("Button","KnoRoll",tkarollbg,tkabutton2)
		KnoRoll:SetFrameStrata("LOW")
		KnoRoll:SetPoint("LEFT",SocRoll,"RIGHT",0,0)
		KnoRoll:SetWidth(63)
		KnoRoll:SetHeight(25)
		KnoRoll:SetText("Knowledge")
		KnoRoll:SetNormalFontObject("GameFontWhiteSmall")
		KnoRoll:SetHighlightFontObject("GameFontWhiteSmall")
		KnoRoll:SetScript("OnClick",function()
			Vers_Settings.AbMod = Vers_Settings.KnoMod
			Vers_Settings.AbType = "(Knowledge)"
			Vers_Settings.AbTxt = "Knowledge ("..Vers_Settings.KnoMod..")"
			AbModTxt:SetText(Vers_Settings.AbTxt)
		end)

		OffRoll = CreateFrame("Button","OffRoll",tkarollbg,tkabutton2)
		OffRoll:SetFrameStrata("LOW")
		OffRoll:SetPoint("BOTTOM",SocRoll,"TOP",0,0)
		OffRoll:SetWidth(61)
		OffRoll:SetHeight(25)
		OffRoll:SetText("Attack")
		OffRoll:SetNormalFontObject("GameFontWhiteSmall")
		OffRoll:SetHighlightFontObject("GameFontWhiteSmall")
		OffRoll:SetScript("OnClick",function()
			Vers_Settings.AbMod = Vers_Settings.OffMod
			Vers_Settings.AbType = "(Attack)"
			Vers_Settings.AbTxt = "Attack ("..Vers_Settings.OffMod..")"
			AbModTxt:SetText(Vers_Settings.AbTxt)
		end)

		DefRoll = CreateFrame("Button","DefRoll",tkarollbg,tkabutton2)
		DefRoll:SetFrameStrata("LOW")
		DefRoll:SetPoint("LEFT",OffRoll,"RIGHT",0,0)
		DefRoll:SetWidth(63)
		DefRoll:SetHeight(25)
		DefRoll:SetText("Defense")
		DefRoll:SetNormalFontObject("GameFontWhiteSmall")
		DefRoll:SetHighlightFontObject("GameFontWhiteSmall")
		DefRoll:SetScript("OnClick",function()
			Vers_Settings.AbMod = Vers_Settings.DefMod
			Vers_Settings.AbType = "(Defense)"
			Vers_Settings.AbTxt = "Defense ("..Vers_Settings.DefMod..")"
			AbModTxt:SetText(Vers_Settings.AbTxt)
		end)

		ClrRoll = CreateFrame("Button","DefRoll",tkarollbg,tkabutton2)
		ClrRoll:SetFrameStrata("LOW")
		ClrRoll:SetPoint("TOPLEFT",DefRoll,"TOPRIGHT",0,0)
		ClrRoll:SetWidth(50)
		ClrRoll:SetHeight(50)
		ClrRoll:SetText("No\nAbility")
		ClrRoll:SetScript("OnClick",function()
			Vers_Settings.AbMod = 0
			Vers_Settings.AbType = ""
			Vers_Settings.AbTxt = "No Ability Set"
			AbModTxt:SetText(Vers_Settings.AbTxt)
		end)

		AbModTxt = tkarollbg:CreateFontString(nil, "High", "GameTooltipText")
		AbModTxt:SetPoint("BOTTOM",DefRoll,"TOP",0,4)
		AbModTxt:SetText(Vers_Settings.AbTxt)
		AbModTxt:SetFont("Fonts\\FRIZQT__.ttf", 14, "OUTLINE")

		end
	end)

	tkadm = CreateFrame("Button","tkadm",tkamenubg,tkabutton1)
	tkadm:SetFrameStrata("LOW")
	tkadm:SetPoint("TOP","tkaroll","BOTTOM",0,0)
	tkadm:SetWidth(145)
	tkadm:SetHeight(25)
	tkadm:SetText("DM Tools")
	tkadm:SetScript("PreClick",function()
		if tkadmtog then
		tkadmtog = false else
		tkadmtog = true end
		end)
	tkadm:SetScript("OnClick",function()
		if tkadmbg then
			tkadmbg:Hide()
			tkadmbg = nil;
		else
		getTargetName()
		tkadmbg = CreateFrame("Frame","tkadmbg",tkamenubg)
		tkadmbg:SetFrameStrata("LOW")
		tkadmbg:SetFrameLevel(20)
		tkadmbg:ClearAllPoints()
		tkadmbg:SetBackdrop(Backdrop5)
		tkadmbg:SetBackdropColor(0,0.19,0.46,1)
		tkadmbg:SetHeight(390)
		tkadmbg:SetWidth(440)
		tkadmbg:SetScript("OnHide", function() tkadmbg = nil end )
		tkadmbg:SetScript("OnUpdate", function() if tkadm == "Hide" then tkadmbg:Hide() tkadmbg = nil; end end)
		tkadmbg:SetMovable(true)
		tkadmbg:EnableMouse(true)
		if menuset == "False" then tkadmbg:SetPoint("BOTTOMLEFT",tkamenubg,"TOPLEFT",0,0) else tkadmbg:SetPoint("CENTER",UIParent,"BOTTOMLEFT",Vers_Settings.tkadmx,Vers_Settings.tkadmy) end
		tkadmbg:SetScript("OnUpdate", function() Vers_Settings.tkadmx, Vers_Settings.tkadmy = tkadmbg:GetCenter() end)
		tkadmbg:RegisterForDrag("LeftButton")
		tkadmbg:SetScript("OnDragStart", tkadmbg.StartMoving)
		tkadmbg:SetScript("OnDragStop", tkadmbg.StopMovingOrSizing)

		local dmvert = -48
		for i=1,7 do

			DMBlock["Eneminput"][i] = CreateFrame("Button",DMBlock["Eneminput"][i],tkadmbg,tkabutton2)
			DMBlock["Eneminput"][i]:SetFrameStrata("LOW")
			DMBlock["Eneminput"][i]:SetNormalFontObject("GameFontWhiteSmall")
			DMBlock["Eneminput"][i]:SetHighlightFontObject("GameFontHighlight")
			DMBlock["Eneminput"][i]:SetPoint("TOPLEFT",tkadmbg,15,dmvert)
			DMBlock["Eneminput"][i]:SetWidth(180)
			DMBlock["Eneminput"][i]:SetHeight(25)
			DMBlock["Eneminput"][i]:SetText(DM[i]["EnemyName"])
			DMBlock["Eneminput"][i]:SetScript("OnClick",function()
				DMBlock["Enembox"][i] = CreateFrame("EditBox",DMBlock["Enembox"][i],tkadmbg,"TKAEditBox")
				DMBlock["Enembox"][i]:SetFrameStrata("MEDIUM")
				DMBlock["Enembox"][i]:SetFontObject("CombatLogFont")
				DMBlock["Enembox"][i]:SetWidth(175)
				DMBlock["Enembox"][i]:SetHeight(25)
				DMBlock["Enembox"][i]:SetPoint("CENTER",DMBlock["Eneminput"][i],0,0)
				DMBlock["Enembox"][i]:SetScript("OnEnterPressed",function()
					DM[i]["EnemyName"] = DMBlock["Enembox"][i]:GetText()
					DMBlock["Enembox"][i]:Hide()
					DMBlock["Eneminput"][i]:SetText(DM[i]["EnemyName"])
					end)
				end)

			DMBlock["OffDC"][i] = CreateFrame("Button",DMBlock["OffDC"][i],tkadmbg,tkabutton2)
			DMBlock["OffDC"][i]:SetFrameStrata("LOW")
			DMBlock["OffDC"][i]:SetPoint("LEFT",DMBlock["Eneminput"][i],"RIGHT",5,0)
			DMBlock["OffDC"][i]:SetWidth(35)
			DMBlock["OffDC"][i]:SetHeight(25)
			DMBlock["OffDC"][i]:SetText(DM[i]["OffDC"])
			DMBlock["OffDC"][i]:SetScript("OnClick",function()
				DMBlock["OffDCBox"][i] = CreateFrame("EditBox",DMBlock["OffDCBox"][i],tkadmbg,"TKAEditBox")
				DMBlock["OffDCBox"][i]:SetFrameStrata("MEDIUM")
				DMBlock["OffDCBox"][i]:SetFontObject("CombatLogFont")
				DMBlock["OffDCBox"][i]:SetWidth(30)
				DMBlock["OffDCBox"][i]:SetHeight(25)
				DMBlock["OffDCBox"][i]:SetPoint("CENTER",DMBlock["OffDC"][i],0,0)
				DMBlock["OffDCBox"][i]:SetScript("OnEnterPressed",function()
					DM[i]["OffDC"] = DMBlock["OffDCBox"][i]:GetNumber()
					DMBlock["OffDCBox"][i]:Hide()
					if DM[i]["OffDC"] < 0 then DM[i]["OffDC"] = 0 end
					DMBlock["OffDC"][i]:SetText(DM[i]["OffDC"])
					end)
				end)

			DMBlock["DefDC"][i] = CreateFrame("Button",DMBlock["DefDC"][i],tkadmbg,tkabutton2)
			DMBlock["DefDC"][i]:SetFrameStrata("LOW")
			DMBlock["DefDC"][i]:SetPoint("LEFT",DMBlock["OffDC"][i],"RIGHT",5,0)
			DMBlock["DefDC"][i]:SetWidth(35)
			DMBlock["DefDC"][i]:SetHeight(25)
			DMBlock["DefDC"][i]:SetText(DM[i]["DefDC"])
			DMBlock["DefDC"][i]:SetScript("PostClick", function() DMBlock["DefDC"][i]:Show()end)
			DMBlock["DefDC"][i]:SetScript("OnClick",function()
				DMBlock["DefDCBox"][i] = CreateFrame("EditBox",DMBlock["DefDCBox"][i],tkadmbg,"TKAEditBox")
				DMBlock["DefDCBox"][i]:SetFrameStrata("MEDIUM")
				DMBlock["DefDCBox"][i]:SetFontObject("CombatLogFont")
				DMBlock["DefDCBox"][i]:SetWidth(30)
				DMBlock["DefDCBox"][i]:SetHeight(25)
				DMBlock["DefDCBox"][i]:SetPoint("CENTER",DMBlock["DefDC"][i],0,0)
				DMBlock["DefDCBox"][i]:SetScript("OnEnterPressed",function()
					DM[i]["DefDC"] = DMBlock["DefDCBox"][i]:GetNumber()
					DMBlock["DefDCBox"][i]:Hide()
					if DM[i]["DefDC"] < 0 then DM[i]["DefDC"] = 0 end
					DMBlock["DefDC"][i]:SetText(DM[i]["DefDC"])
					end)
				end)

			DMBlock["HPInput"][i] = CreateFrame("Button",DMBlock["HPInput"][i],tkadmbg,tkabutton2)
			DMBlock["HPInput"][i]:SetFrameStrata("LOW")
			DMBlock["HPInput"][i]:SetPoint("LEFT",DMBlock["DefDC"][i],"RIGHT",30,0)
			DMBlock["HPInput"][i]:SetWidth(30)
			DMBlock["HPInput"][i]:SetHeight(25)
			DMBlock["HPInput"][i]:SetText(DM[i]["EnemyHP"])
			DMBlock["HPInput"][i]:SetScript("OnClick",function()
				DMBlock["HPBox"][i] = CreateFrame("EditBox",DMBlock["HPBox"][i],tkadmbg,"TKAEditBox")
				DMBlock["HPBox"][i]:SetFrameStrata("MEDIUM")
				DMBlock["HPBox"][i]:SetFontObject("CombatLogFont")
				DMBlock["HPBox"][i]:SetWidth(30)
				DMBlock["HPBox"][i]:SetHeight(25)
				DMBlock["HPBox"][i]:SetPoint("CENTER",DMBlock["HPInput"][i],0,0)
				DMBlock["HPBox"][i]:SetScript("OnEnterPressed",function()
					DM[i]["EnemyHP"] = DMBlock["HPBox"][i]:GetNumber()
					DMBlock["HPBox"][i]:Hide()
					if DM[i]["EnemyHP"] < 0 then DM[i]["EnemyHP"] = 0 end
					DMBlock["HPInput"][i]:SetText(DM[i]["EnemyHP"])
					end)
				end)

			DMBlock["HPAdd"][i] = CreateFrame("Button",DMBlock["HPAdd"][i],tkadmbg,tkabutton2)
			DMBlock["HPAdd"][i]:SetFrameStrata("LOW")
			DMBlock["HPAdd"][i]:SetPoint("LEFT",DMBlock["HPInput"][i],"RIGHT",-3,0)
			DMBlock["HPAdd"][i]:SetWidth(25)
			DMBlock["HPAdd"][i]:SetHeight(25)
			DMBlock["HPAdd"][i]:SetText("+")
			DMBlock["HPAdd"][i]:SetScript("OnClick",function()
				if IsShiftKeyDown() then DM[i]["EnemyHP"] = DM[i]["EnemyHP"] + 5 else
				DM[i]["EnemyHP"] = DM[i]["EnemyHP"] + 1 end
				DMBlock["HPInput"][i]:SetText(DM[i]["EnemyHP"])
			end)

			DMBlock["HPSub"][i] = CreateFrame("Button",DMBlock["HPSub"][i],tkadmbg,tkabutton2)
			DMBlock["HPSub"][i]:SetFrameStrata("LOW")
			DMBlock["HPSub"][i]:SetPoint("RIGHT",DMBlock["HPInput"][i],"LEFT",3,0)
			DMBlock["HPSub"][i]:SetWidth(25)
			DMBlock["HPSub"][i]:SetHeight(25)
			DMBlock["HPSub"][i]:SetText("-")
			DMBlock["HPSub"][i]:SetScript("OnClick",function()
				if IsShiftKeyDown() then DM[i]["EnemyHP"] = DM[i]["EnemyHP"] - 5 else
				DM[i]["EnemyHP"] = DM[i]["EnemyHP"] - 1 end
				if DM[i]["EnemyHP"] < 0 then DM[i]["EnemyHP"] = 0 end
				DMBlock["HPInput"][i]:SetText(DM[i]["EnemyHP"])
			end)

			DMBlock["MHPInput"][i] = CreateFrame("Button",DMBlock["MHPInput"][i],tkadmbg,tkabutton2)
			DMBlock["MHPInput"][i]:SetFrameStrata("LOW")
			DMBlock["MHPInput"][i]:SetPoint("LEFT",DMBlock["HPAdd"][i],"RIGHT",5,0)
			DMBlock["MHPInput"][i]:SetWidth(30)
			DMBlock["MHPInput"][i]:SetHeight(25)
			DMBlock["MHPInput"][i]:SetText(DM[i]["EnemyMaxHP"])
			DMBlock["MHPInput"][i]:SetScript("OnClick",function()
				DMBlock["MHPBox"][i] = CreateFrame("EditBox",DMBlock["MHPBox"][i],tkadmbg,"TKAEditBox")
				DMBlock["MHPBox"][i]:SetFrameStrata("MEDIUM")
				DMBlock["MHPBox"][i]:SetFontObject("CombatLogFont")
				DMBlock["MHPBox"][i]:SetWidth(30)
				DMBlock["MHPBox"][i]:SetHeight(25)
				DMBlock["MHPBox"][i]:SetPoint("CENTER",DMBlock["MHPInput"][i],0,0)
				DMBlock["MHPBox"][i]:SetScript("OnEnterPressed",function()
					DM[i]["EnemyMaxHP"] = DMBlock["MHPBox"][i]:GetNumber()
					DMBlock["MHPBox"][i]:Hide()
					DMBlock["MHPInput"][i]:SetText(DM[i]["EnemyMaxHP"])
					end)
				end)

			DMBlock["Clear"][i] = CreateFrame("Button",DMBlock["Clear"][i],tkadmbg,tkabutton2)
			DMBlock["Clear"][i]:SetFrameStrata("LOW")
			DMBlock["Clear"][i]:SetPoint("LEFT",DMBlock["MHPInput"][i],"RIGHT",5,0)
			DMBlock["Clear"][i]:SetWidth(25)
			DMBlock["Clear"][i]:SetHeight(25)
			DMBlock["Clear"][i]:SetText("X")
			DMBlock["Clear"][i]:SetScript("OnClick",function()
				DM[i]["EnemyName"] = ""
				DM[i]["OffDC"] = 0
				DM[i]["DefDC"] = 0
				DM[i]["EnemyHP"] = 0
				DM[i]["EnemyMaxHP"] = 0
				DMBlock["Eneminput"][i]:SetText(DM[i]["EnemyName"])
				DMBlock["OffDC"][i]:SetText(DM[i]["OffDC"])
				DMBlock["DefDC"][i]:SetText(DM[i]["DefDC"])
				DMBlock["HPInput"][i]:SetText(DM[i]["EnemyHP"])
				DMBlock["MHPInput"][i]:SetText(DM[i]["EnemyMaxHP"])
			 end)

			dmvert = dmvert - 26
			end

		DMENEM = tkadmbg:CreateFontString(nil, "High", "GameTooltipText")
		DMENEM:SetPoint("BOTTOMLEFT",DMBlock["Eneminput"][1],"TOPLEFT",2,0)
		DMENEM:SetText("Target:")
		DMENEM:SetFont("Fonts\\ARIALN.ttf", 11)

		DMDC = tkadmbg:CreateFontString(nil, "High", "GameTooltipText")
		DMDC:SetPoint("BOTTOMRIGHT",DMBlock["Eneminput"][1],"TOPRIGHT",-2,0)
		DMDC:SetText("DC to")
		DMDC:SetFont("Fonts\\ARIALN.ttf", 11)

		DMOFFDC = tkadmbg:CreateFontString(nil, "High", "GameTooltipText")
		DMOFFDC:SetPoint("BOTTOM",DMBlock["OffDC"][1],"TOP",0,0)
		DMOFFDC:SetText("Hit:")
		DMOFFDC:SetFont("Fonts\\ARIALN.ttf", 11)

		DMDEFDC = tkadmbg:CreateFontString(nil, "High", "GameTooltipText")
		DMDEFDC:SetPoint("BOTTOM",DMBlock["DefDC"][1],"TOP",0,0)
		DMDEFDC:SetText("Avoid:")
		DMDEFDC:SetFont("Fonts\\ARIALN.ttf", 11)

		DMCURHP = tkadmbg:CreateFontString(nil, "High", "GameTooltipText")
		DMCURHP:SetPoint("BOTTOMLEFT",DMBlock["HPInput"][1],"TOPLEFT",0,0)
		DMCURHP:SetText("Current & Max HP:")
		DMCURHP:SetFont("Fonts\\ARIALN.ttf", 11)

		--Save/Load Feature

		tkasave1 = CreateFrame("Button","tkasave1",tkadmbg,tkabutton2)
		tkasave1:SetFrameStrata("LOW")
		tkasave1:SetPoint("TOP",tkadmbg,"TOPLEFT",42,-13)
		tkasave1:SetWidth(60)
		tkasave1:SetHeight(25)
		tkasave1:SetText("Save #1")
		tkasave1:SetScript("OnClick",function()
			DMSave(DM1)
		end)

		tkaload1 = CreateFrame("Button","tkaload1",tkadmbg,tkabutton2)
		tkaload1:SetFrameStrata("LOW")
		tkaload1:SetPoint("LEFT",tkasave1,"RIGHT",0,0)
		tkaload1:SetWidth(60)
		tkaload1:SetHeight(25)
		tkaload1:SetText("Load #1")
		tkaload1:SetScript("OnClick",function()
			DMLoad(DM1)
		end)

		tkasave2 = CreateFrame("Button","tkasave2",tkadmbg,tkabutton2)
		tkasave2:SetFrameStrata("LOW")
		tkasave2:SetPoint("TOPRIGHT",tkadmbg,"TOP",0,-13)
		tkasave2:SetWidth(60)
		tkasave2:SetHeight(25)
		tkasave2:SetText("Save #2")
		tkasave2:SetScript("OnClick",function()
			DMSave(DM2)
		end)

		tkaload2 = CreateFrame("Button","tkaload2",tkadmbg,tkabutton2)
		tkaload2:SetFrameStrata("LOW")
		tkaload2:SetPoint("LEFT",tkasave2,"RIGHT",0,0)
		tkaload2:SetWidth(60)
		tkaload2:SetHeight(25)
		tkaload2:SetText("Load #2")
		tkaload2:SetScript("OnClick",function()
			DMLoad(DM2)
		end)

		tkasave3 = CreateFrame("Button","tkasave3",tkadmbg,tkabutton2)
		tkasave3:SetFrameStrata("LOW")
		tkasave3:SetPoint("TOPRIGHT",tkadmbg,-72,-13)
		tkasave3:SetWidth(60)
		tkasave3:SetHeight(25)
		tkasave3:SetText("Save #3")
		tkasave3:SetScript("OnClick",function()
			DMSave(DM3)
		end)

		tkaload3 = CreateFrame("Button","tkaload2",tkadmbg,tkabutton2)
		tkaload3:SetFrameStrata("LOW")
		tkaload3:SetPoint("LEFT",tkasave3,"RIGHT",0,0)
		tkaload3:SetWidth(60)
		tkaload3:SetHeight(25)
		tkaload3:SetText("Load #3")
		tkaload3:SetScript("OnClick",function()
			DMLoad(DM3)
		end)

		tkadmreport = CreateFrame("Button","tkadmreport",tkadmbg,tkabutton2)
		tkadmreport:SetFrameStrata("LOW")
		tkadmreport:SetPoint("TOPLEFT",DMBlock["Eneminput"][7],"BOTTOMLEFT",0,-5)
		tkadmreport:SetWidth(135)
		tkadmreport:SetHeight(25)
		tkadmreport:SetText("Full Report")
		tkadmreport:SetScript("OnClick",function()
			local s = 0
			for i, v in ipairs(DM) do
				local DMOut = {};
				if v.EnemyName ~= "" then
					table.insert(DMOut, string.format("Target: %s.", v.EnemyName));
					if v.OffDC > 0 and v.DefDC > 0 then
						table.insert(DMOut, string.format("DC: %s to Hit. DC: %s to Avoid.", v.OffDC, v.DefDC));
					elseif v.OffDC > 0 or v.DefDC > 0 then
						table.insert(DMOut, string.format("DC: %s.", v.OffDC+v.DefDC));
					end
					if v.EnemyHP > 0 and v.EnemyMaxHP > 0 then
						table.insert(DMOut, string.format(" HP: %i/%i.", v.EnemyHP, v.EnemyMaxHP));
					elseif v.EnemyHP > 0 then
						table.insert(DMOut, string.format(" HP: %i.", v.EnemyHP));
					end
					local DMOutStr = table.concat(DMOut, " ")
					SendOutputMessage(DMOutStr)
				else
					s = s + 1
				end
				if s == #DM then print ("No Enemies Detected.") end
			end
		end)

		tkadmhpreport = CreateFrame("Button","tkadmhpreport",tkadmbg,tkabutton2)
		tkadmhpreport:SetFrameStrata("LOW")
		tkadmhpreport:SetPoint("LEFT",tkadmreport,"RIGHT",2,0)
		tkadmhpreport:SetWidth(135)
		tkadmhpreport:SetHeight(25)
		tkadmhpreport:SetText("Condensed Report")
		tkadmhpreport:SetScript("OnClick",function()
			local s = 0
			for i, v in ipairs(DM) do
				local DMOut = {};
				if v.EnemyName ~= "" then
					table.insert(DMOut, string.format("Target: %s.", v.EnemyName));
					if v.EnemyHP > 0 and v.EnemyMaxHP > 0 then
						table.insert(DMOut, string.format(" HP: %i/%i.", v.EnemyHP, v.EnemyMaxHP));
					elseif v.EnemyHP > 0 then
						table.insert(DMOut, string.format(" HP: %i.", v.EnemyHP));
					end
					local DMOutStr = table.concat(DMOut, " ")
					SendOutputMessage(DMOutStr)
				else
					s = s + 1
				end
				if s == #DM then print ("No Enemies Detected.") end
			end
		end)

		tkadmclear = CreateFrame("Button","tkadmclear",tkadmbg,tkabutton2)
		tkadmclear:SetFrameStrata("LOW")
		tkadmclear:SetPoint("LEFT",tkadmhpreport,"RIGHT",2,0)
		tkadmclear:SetWidth(135)
		tkadmclear:SetHeight(25)
		tkadmclear:SetText("Clear All")
		tkadmclear:SetScript("OnClick",function()
			for i=1,7 do
				DM[i]["EnemyName"] = ""
				DM[i]["OffDC"] = 0
				DM[i]["DefDC"] = 0
				DM[i]["EnemyHP"] = 0
				DM[i]["EnemyMaxHP"] = 0
				DMBlock["Eneminput"][i]:SetText(DM[i]["EnemyName"])
				DMBlock["OffDC"][i]:SetText(DM[i]["OffDC"])
				DMBlock["DefDC"][i]:SetText(DM[i]["DefDC"])
				DMBlock["HPInput"][i]:SetText(DM[i]["EnemyHP"])
				DMBlock["MHPInput"][i]:SetText(DM[i]["EnemyMaxHP"])
			end
		end)

		tkadmrandpick = CreateFrame("Button","tkadmrandpick",tkadmbg,tkabutton2)
		tkadmrandpick:SetFrameStrata("LOW")
		tkadmrandpick:SetPoint("TOPLEFT",tkadmreport,"BOTTOMLEFT",0,-5)
		tkadmrandpick:SetWidth(155)
		tkadmrandpick:SetHeight(25)
		tkadmrandpick:SetText("Pick a Random Player")
		tkadmrandpick:SetScript("OnClick",function()
			local KAGrpMem = GetNumGroupMembers()
			local TKAPlayerPrev = TKAPlayer
			local TKARaid = {}
			local VMem = 0
			for i = 1,KAGrpMem do
				local name, rank, subgroup, level, class, fileName, zone, online = GetRaidRosterInfo(i)
				if subgroup <= Vers_Settings.VRaidHigh and subgroup >= Vers_Settings.VRaidLow and name ~= TKAPlayerPrev and online then
					VMem = VMem + 1
					TKARaid[VMem] = name
				end
			end
			TKAClass = ""
			TKAPlayer = ""
			if #TKARaid > 0 then
				TKAPlayer = TKARaid[math.random(#TKARaid)]
				TKAClass = UnitClass(TKAPlayer)
				TKAPlayerOut = TKAPlayer
				for _, v in ipairs(ClassColorTable) do
					if v.class == TKAClass then
						TarCol = v.color
					end
				end
			else
				TarCol = "FFFFFFFF"
				TKAPlayerOut = "No Player in Range"
			end
			VERSEL:SetText("Player: |c"..TarCol..TKAPlayerOut.."|r")
			local RandOutStr = "Random Player: "..TKAPlayerOut
			if IsShiftKeyDown() then SendOutputMessage(RandOutStr) end
		end)

		VERSEL = tkadmbg:CreateFontString(nil, "High", "GameTooltipText")
		VERSEL:SetPoint("LEFT",tkadmrandpick,"RIGHT",4,0)
		VERSEL:SetText("Player: |c"..TarCol..TKAPlayerOut.."|r")
		VERSEL:SetFont("Fonts\\ARIALN.ttf", 13)

		tkagrplowinput = CreateFrame("Button","tkagrplowinput",tkadmbg,tkabutton2)
		tkagrplowinput:SetFrameStrata("LOW")
		tkagrplowinput:SetPoint("TOP",tkadmrandpick,"BOTTOM",40,-2)
		tkagrplowinput:SetWidth(30)
		tkagrplowinput:SetHeight(25)
		tkagrplowinput:SetText(Vers_Settings.VRaidLow)
		tkagrplowinput:SetScript("PostClick", function() tkagrplowinput:Show()end)
		tkagrplowinput:SetScript("OnClick",function()
			tkagrplowbox = CreateFrame("EditBox","tkagrplowbox",tkadmbg,"TKAEditBox")
			tkagrplowbox:SetFrameStrata("MEDIUM")
			tkagrplowbox:SetFontObject("CombatLogFont")
			tkagrplowbox:SetWidth(25)
			tkagrplowbox:SetHeight(25)
			tkagrplowbox:SetPoint("CENTER",tkagrplowinput,0,0)
			tkagrplowbox:SetScript("OnEnterPressed",function()
				Vers_Settings.VRaidLow = tkagrplowbox:GetNumber()
				tkagrplowbox:Hide()
				tkagrplowinput:Show()
				tkagrplowinput:SetText(Vers_Settings.VRaidLow)
				end)
			end)

		tkagrphighinput = CreateFrame("Button","tkagrphighinput",tkadmbg,tkabutton2)
		tkagrphighinput:SetFrameStrata("LOW")
		tkagrphighinput:SetPoint("LEFT",tkagrplowinput,"RIGHT",15,0)
		tkagrphighinput:SetWidth(30)
		tkagrphighinput:SetHeight(25)
		tkagrphighinput:SetText(Vers_Settings.VRaidHigh)
		tkagrphighinput:SetScript("PostClick", function() tkagrphighinput:Show()end)
		tkagrphighinput:SetScript("OnClick",function()
			tkagrphighbox = CreateFrame("EditBox","tkagrphighbox",tkadmbg,"TKAEditBox")
			tkagrphighbox:SetFrameStrata("MEDIUM")
			tkagrphighbox:SetFontObject("CombatLogFont")
			tkagrphighbox:SetWidth(25)
			tkagrphighbox:SetHeight(25)
			tkagrphighbox:SetPoint("CENTER",tkagrphighinput,0,0)
			tkagrphighbox:SetScript("OnEnterPressed",function()
				Vers_Settings.VRaidHigh = tkagrphighbox:GetNumber()
				tkagrphighbox:Hide()
				tkagrphighinput:Show()
				tkagrphighinput:SetText(Vers_Settings.VRaidHigh)
				end)
			end)

		VERGRP = tkadmbg:CreateFontString(nil, "High", "GameTooltipText")
		VERGRP:SetPoint("RIGHT","tkagrplowinput","LEFT",0,0)
		VERGRP:SetText("Group Range From:")
		VERGRP:SetFont("Fonts\\ARIALN.ttf", 11)

		VERGRPTO = tkadmbg:CreateFontString(nil, "High", "GameTooltipText")
		VERGRPTO:SetPoint("RIGHT","tkagrphighinput","LEFT",-1,0)
		VERGRPTO:SetText("To")
		VERGRPTO:SetFont("Fonts\\ARIALN.ttf", 11)

		tkaturn = CreateFrame("Button","tkaturn",tkadmbg,tkabutton2)
		tkaturn:SetFrameStrata("LOW")
		tkaturn:SetPoint("TOPLEFT",tkadmrandpick,"BOTTOMLEFT",0,-60)
		tkaturn:SetWidth(135)
		tkaturn:SetHeight(25)
		tkaturn:SetText("Kirin Aran Turn")
		tkaturn:SetScript("OnClick",function()
			SendChatMessage("** KIRIN ARAN COMBAT TURN **","RAID_WARNING")
		end)

		tkaenturn = CreateFrame("Button","tkaenturn",tkadmbg,tkabutton2)
		tkaenturn:SetFrameStrata("LOW")
		tkaenturn:SetPoint("LEFT",tkaturn,"RIGHT",2,0)
		tkaenturn:SetWidth(135)
		tkaenturn:SetHeight(25)
		tkaenturn:SetText("Enemy Turn")
		tkaenturn:SetScript("OnClick",function()
			SendChatMessage("** ENEMY TURN **","RAID_WARNING")
		end)

		tkareadychk = CreateFrame("Button","tkareadychk",tkadmbg,tkabutton2)
		tkareadychk:SetFrameStrata("LOW")
		tkareadychk:SetPoint("LEFT",tkaenturn,"RIGHT",2,0)
		tkareadychk:SetWidth(135)
		tkareadychk:SetHeight(25)
		tkareadychk:SetText("Ready Check")
		tkareadychk:SetScript("OnClick",function()
			DoReadyCheck()
		end)

		tkadmpause = CreateFrame("Button","tkadmpause",tkadmbg,tkabutton2)
		tkadmpause:SetFrameStrata("LOW")
		tkadmpause:SetPoint("BOTTOMRIGHT",tkaturn,"TOPRIGHT",0,5)
		tkadmpause:SetWidth(135)
		tkadmpause:SetHeight(25)
		tkadmpause:SetText("Pause!")
		tkadmpause:SetScript("OnClick", function()
			SendChatMessage("** PAUSE! **","RAID_WARNING")
		end)

		tkamodpush = CreateFrame("Button","tkamodpush",tkadmbg,tkabutton2)
		tkamodpush:SetFrameStrata("LOW")
		tkamodpush:SetPoint("BOTTOMLEFT",tkareadychk,"TOPLEFT",0,5)
		tkamodpush:SetWidth(135)
		tkamodpush:SetHeight(25)
		tkamodpush:SetText("Send Modifier to Raid")
		tkamodpush:SetScript("OnClick",function()
			local DMString = dmString(TKAGlobPush,TKADMGlobMagic)
			if UnitLeadsAnyGroup("player") or UnitIsRaidOfficer("player") then
				SendAddonMessage("TKA1",TKAGlobPush..TKADMGlobMagic,"RAID")
				if IsInRaid() then SendChatMessage(DMString,"RAID_WARNING") end
			else
				print("You need to be Raid Leader or Assist.")
			end
		end)

		tkamodin = CreateFrame("Button","tkamodin",tkadmbg,tkabutton2)
		tkamodin:SetFrameStrata("LOW")
		tkamodin:SetPoint("RIGHT",tkamodpush,"LEFT",0,0)
		tkamodin:SetWidth(35)
		tkamodin:SetHeight(25)
		tkamodin:SetText(TKAGlobPush)
		tkamodin:SetScript("OnClick",function()
			tkamodbox = CreateFrame("EditBox","tkamodbox",tkadmbg,"TKAEditBox")
			tkamodbox:SetFrameStrata("MEDIUM")
			tkamodbox:SetFontObject("CombatLogFont")
			tkamodbox:SetWidth(25)
			tkamodbox:SetHeight(25)
			tkamodbox:SetPoint("CENTER",tkamodin,0,0)
			tkamodbox:SetScript("OnEnterPressed",function()
				TKAGlobPush = tkamodbox:GetNumber()
				tkamodbox:Hide()
				tkamodin:SetText(TKAGlobPush)
				end)
			end)

		WHISPTXT = tkadmbg:CreateFontString(nil, "High", "GameTooltipText")
		WHISPTXT:SetText("Send to "..playerTarget)
		WHISPTXT:SetWidth(123)
		WHISPTXT:SetWordWrap(disable)
		WHISPTXT:SetFontObject(GameFontNormal)

		tkamodwhisper = CreateFrame("Button","tkamodwhisper",tkadmbg,tkabutton2)
		tkamodwhisper:SetFrameStrata("LOW")
		tkamodwhisper:SetPoint("BOTTOMLEFT",tkamodpush,"TOPLEFT",0,5)
		tkamodwhisper:SetWidth(135)
		tkamodwhisper:SetHeight(25)
		tkamodwhisper:SetFontString(WHISPTXT)
		tkamodwhisper:SetScript("OnEvent", function(self,event,...)
			getTargetName()
			WHISPTXT:SetText("Send to "..playerTarget)
		end)
		tkamodwhisper:RegisterEvent("PLAYER_TARGET_CHANGED")
		tkamodwhisper:SetScript("OnClick",function()
			local DMString = dmString(TKAWhispPush,TKADMGlobMagic)
			if playerTarget ~= "<No Target>" then
				if UnitLeadsAnyGroup("player") or UnitIsRaidOfficer("player") then
					SendAddonMessage("TKA1",TKAWhispPush..TKADMGlobMagic,"WHISPER",playerTarget)
					SendChatMessage(DMString,"WHISPER",nil,playerTarget)
				else
					print("You need to be Raid Leader or Assist.")
				end
			else
				print("Please select a Target.")
			end
		end)

		tkamodin2 = CreateFrame("Button","tkamodin2",tkadmbg,tkabutton2)
		tkamodin2:SetFrameStrata("LOW")
		tkamodin2:SetPoint("RIGHT",tkamodwhisper,"LEFT",0,0)
		tkamodin2:SetWidth(35)
		tkamodin2:SetHeight(25)
		tkamodin2:SetText(TKAWhispPush)
		tkamodin2:SetScript("OnClick",function()
			tkamodbox = CreateFrame("EditBox","tkamodbox",tkadmbg,"TKAEditBox")
			tkamodbox:SetFrameStrata("MEDIUM")
			tkamodbox:SetFontObject("CombatLogFont")
			tkamodbox:SetWidth(25)
			tkamodbox:SetHeight(25)
			tkamodbox:SetPoint("CENTER",tkamodin2,"CENTER",0,0)
			tkamodbox:SetScript("OnEnterPressed",function()
				TKAWhispPush = tkamodbox:GetNumber()
				tkamodbox:Hide()
				tkamodin2:SetText(TKAWhispPush)
				end)
			end)

		tkadmglobmagic = CreateFrame("CheckButton",tkadmglobmagic,tkadmbg,"ChatConfigBaseCheckButtonTemplate")
		tkadmglobmagic:SetFrameStrata("LOW")
		tkadmglobmagic:SetPoint("RIGHT",tkamodin,"LEFT",0,0)
		tkadmglobmagic:SetWidth(30)
		tkadmglobmagic:SetHeight(30)
		if TKADMGlobMagic == "Magic" then tkadmglobmagic:SetChecked(true) else tkadmglobmagic:SetChecked(false) end
		tkadmglobmagic:SetScript("OnEnter",function()
			Tooltip("Toggle to ensure the Global Modifier is only applied to Magic Rolls.",tkadmglobmagic)
		end)
		tkadmglobmagic:SetScript("OnLeave",function()
			GameTooltip:Hide()
		end)
		tkadmglobmagic:SetScript("OnClick", function()
			if TKADMGlobMagic == "Magic" then
				TKADMGlobMagic = "All"
			else
				TKADMGlobMagic = "Magic"
			end
		end)

		GLOBSPTX = tkadmbg:CreateFontString(nil, "High", "GameTooltipText")
		GLOBSPTX:SetPoint("RIGHT",tkadmglobmagic,"LEFT",0,0)
		GLOBSPTX:SetText("Magic Toggle:")
		GLOBSPTX:SetFont("Fonts\\ARIALN.ttf", 11, "OUTLINE")

		end
	end)

	tkasettings = CreateFrame("Button","tkasettings",tkamenubg,tkabutton1)
	tkasettings:SetFrameStrata("LOW")
	tkasettings:SetPoint("TOP","tkadm","BOTTOM",0,0)
	tkasettings:SetWidth(145)
	tkasettings:SetHeight(25)
	tkasettings:SetText("Character Sheet")
	tkasettings:SetScript("OnClick",function()
		if tkasettingsbg then
			tkasettingsbg:Hide()
			tkasettingsbg = nil;
		else

		tkasettingsbg = CreateFrame("Frame","tkasettingsbg",tkamenubg)
		tkasettingsbg:SetFrameStrata("LOW")
		tkasettingsbg:SetFrameLevel(25)
		tkasettingsbg:ClearAllPoints()
		tkasettingsbg:SetBackdrop(Backdrop5)
		tkasettingsbg:SetBackdropColor(0,0.19,0.46,1)
		tkasettingsbg:SetHeight(448)
		tkasettingsbg:SetWidth(278)
		tkasettingsbg:SetPoint("CENTER",UIParent,0,0)
		tkasettingsbg:SetScript("OnHide", function() tkasettingsbg = nil end )
		tkasettingsbg:SetScript("OnUpdate", function() if tkasettings == "Hide" then tkasettingsbg:Hide() tkasettingsbg = nil; end end)
		tkasettingsbg:SetMovable(true)
		tkasettingsbg:EnableMouse(true)
		tkasettingsbg:RegisterForDrag("LeftButton")
		tkasettingsbg:SetScript("OnDragStart", tkasettingsbg.StartMoving)
		tkasettingsbg:SetScript("OnDragStop", tkasettingsbg.StopMovingOrSizing)

		local skvert = -47
		for i=1,10 do
			Skills3["skvert" .. i] = skvert

			Skills3["sk"..i.."input"] = CreateFrame("Button",Skills3["sk"..i.."input"],tkasettingsbg,tkabutton2)
			Skills3["sk"..i.."input"]:SetFrameStrata("LOW")
			Skills3["sk"..i.."input"]:SetPoint("TOPLEFT",tkasettingsbg,"TOPLEFT",15,Skills3["skvert" .. i])
			Skills3["sk"..i.."input"]:SetWidth(30)
			Skills3["sk"..i.."input"]:SetHeight(25)
			Skills3["sk"..i.."input"]:SetText(Skills2["VERSSK"..i])
			Skills3["sk"..i.."input"]:SetScript("OnClick",function()
				Skills3["sk"..i.."box"] = CreateFrame("EditBox",Skills3["sk"..i.."box"],tkasettingsbg,"TKAEditBox")
				Skills3["sk"..i.."box"]:SetFrameStrata("MEDIUM")
				Skills3["sk"..i.."box"]:SetFrameLevel(4)
				Skills3["sk"..i.."box"]:SetFontObject("CombatLogFont")
				Skills3["sk"..i.."box"]:SetWidth(20)
				Skills3["sk"..i.."box"]:SetHeight(25)
				Skills3["sk"..i.."box"]:SetPoint("CENTER",Skills3["sk"..i.."input"],0,0)
				Skills3["sk"..i.."box"]:SetScript("OnEnterPressed",function()
					Skills2["VERSSK"..i] = Skills3["sk"..i.."box"]:GetNumber()
					Skills3["sk"..i.."box"]:Hide()
					Skills3["sk"..i.."input"]:SetText(Skills2["VERSSK"..i])
					end)
				end)

			Skills3["skill"..i.."input"] = CreateFrame("Button",Skills3["skill"..i.."input"],tkasettingsbg,tkabutton2)
			Skills3["skill"..i.."input"]:SetFrameStrata("LOW")
			Skills3["skill"..i.."input"]:SetNormalFontObject("GameFontWhiteSmall")
			Skills3["skill"..i.."input"]:SetHighlightFontObject("GameFontHighlight")
			Skills3["skill"..i.."input"]:SetPoint("LEFT",Skills3["sk"..i.."input"],"RIGHT",0,0)
			Skills3["skill"..i.."input"]:SetWidth(150)
			Skills3["skill"..i.."input"]:SetHeight(25)
			Skills3["skill"..i.."input"]:SetText(Skills2["VERSSKILL"..i])
			Skills3["skill"..i.."input"]:SetScript("OnClick",function()
				Skills3["skill"..i.."box"] = CreateFrame("EditBox",Skills3["skill"..i.."box"],tkasettingsbg,"TKAEditBox")
				Skills3["skill"..i.."box"]:SetFrameStrata("MEDIUM")
				Skills3["skill"..i.."box"]:SetFrameLevel(4)
				Skills3["skill"..i.."box"]:SetFontObject("CombatLogFont")
				Skills3["skill"..i.."box"]:SetWidth(150)
				Skills3["skill"..i.."box"]:SetHeight(25)
				Skills3["skill"..i.."box"]:SetPoint("CENTER",Skills3["skill"..i.."input"],0,0)
				Skills3["skill"..i.."box"]:SetScript("OnEnterPressed",function()
					Skills2["VERSSKILL"..i] = Skills3["skill"..i.."box"]:GetText()
					Skills3["skill"..i.."box"]:Hide()
					Skills3["skill"..i.."input"]:Show()
					Skills3["skill"..i.."input"]:SetText(Skills2["VERSSKILL"..i])
					end)
				end)

			Skills3["skill"..i.."kill"] = CreateFrame("CheckButton",Skills3["skill"..i.."kill"],tkasettingsbg,"ChatConfigBaseCheckButtonTemplate")
			Skills3["skill"..i.."kill"]:SetFrameStrata("LOW")
			Skills3["skill"..i.."kill"]:SetPoint("LEFT",Skills3["skill"..i.."input"],"RIGHT",2,0)
			Skills3["skill"..i.."kill"]:SetWidth(30)
			Skills3["skill"..i.."kill"]:SetHeight(30)
			Skills3["skill"..i.."kill"]:SetChecked(Skills2["skill"..i.."k"])
			Skills3["skill"..i.."kill"]:SetScript("OnClick", function()
			if Skills2["skill"..i.."k"] then
				Skills2["skill"..i.."k"] = false else
				Skills2["skill"..i.."k"] = true end
			end)

			Skills3["skill"..i.."spell"] = CreateFrame("CheckButton",Skills3["skill"..i.."spell"],tkasettingsbg,"ChatConfigBaseCheckButtonTemplate")
			Skills3["skill"..i.."spell"]:SetFrameStrata("LOW")
			Skills3["skill"..i.."spell"]:SetPoint("LEFT",Skills3["skill"..i.."kill"],"RIGHT",2,0)
			Skills3["skill"..i.."spell"]:SetWidth(30)
			Skills3["skill"..i.."spell"]:SetHeight(30)
			Skills3["skill"..i.."spell"]:SetChecked(Skills2["skill"..i.."s"])
			Skills3["skill"..i.."spell"]:SetScript("OnClick", function()
			if Skills2["skill"..i.."s"] then
				Skills2["skill"..i.."s"] = false else
				Skills2["skill"..i.."s"] = true end
			end)
			skvert = skvert - 25
		end

		CHARSHEET = tkasettingsbg:CreateFontString(nil, "High", "GameTooltipText")
		CHARSHEET:SetPoint("TOP","tkasettingsbg",0,-16)
		CHARSHEET:SetText("|cffffffffCharacter Sheet|r")
		CHARSHEET:SetFont(TitleFont, 14, "OUTLINE")

		SETMOD = tkasettingsbg:CreateFontString(nil, "High", "GameTooltipText")
		SETMOD:SetPoint("BOTTOM",Skills3["sk1input"],"TOP",0,0)
		SETMOD:SetText("Mod:")
		SETMOD:SetFont("Fonts\\ARIALN.ttf", 11)

		SETSKILL = tkasettingsbg:CreateFontString(nil, "High", "GameTooltipText")
		SETSKILL:SetPoint("BOTTOM",Skills3["skill1input"],"TOP",0,0)
		SETSKILL:SetText("Skills:")
		SETSKILL:SetFont("Fonts\\ARIALN.ttf", 11)

		SETKILLS = tkasettingsbg:CreateFontString(nil, "High", "GameTooltipText")
		SETKILLS:SetPoint("BOTTOM",Skills3["skill1kill"],"TOP",0,0)
		SETKILLS:SetText("Dmg:")
		SETKILLS:SetFont("Fonts\\ARIALN.ttf", 11)

		SETSPELL = tkasettingsbg:CreateFontString(nil, "High", "GameTooltipText")
		SETSPELL:SetPoint("BOTTOM",Skills3["skill1spell"],"TOP",0,0)
		SETSPELL:SetText("Magic:")
		SETSPELL:SetFont("Fonts\\ARIALN.ttf", 11)

		tkasettings2 = CreateFrame("Button","tkasettings2",tkasettingsbg,tkabutton1)
		tkasettings2:SetFrameStrata("LOW")
		tkasettings2:SetPoint("TOPRIGHT",Skills3["skill10spell"],"BOTTOMRIGHT",-2,0)
		tkasettings2:SetWidth(125)
		tkasettings2:SetHeight(25)
		tkasettings2:SetText("More Skills")
		tkasettings2:SetScript("OnClick",function()
			if tkasettings2bg then
			tkasettings2bg:Hide()
			tkasettings2bg = nil;
			else

			tkasettings2bg = CreateFrame("Frame","tkasettings2bg",tkasettingsbg)
			tkasettings2bg:SetFrameStrata("LOW")
			tkasettings2bg:SetFrameLevel(30)
			tkasettings2bg:Raise()
			tkasettings2bg:ClearAllPoints()
			tkasettings2bg:SetBackdrop(Backdrop5)
			tkasettings2bg:SetBackdropColor(0,0.19,0.46,1)
			tkasettings2bg:SetHeight(290)
			tkasettings2bg:SetWidth(278)
			tkasettings2bg:SetPoint("TOPLEFT","tkasettingsbg","TOPRIGHT",0,0)
			tkasettings2bg:SetScript("OnHide", function() tkasettings2bg = nil end )
			tkasettings2bg:SetScript("OnUpdate", function() if tkasettings2 == "Hide" then tkasettings2bg:Hide() tkasettings2bg = nil; end end)
			tkasettings2bg:SetMovable(true)
			tkasettings2bg:EnableMouse(true)
			tkasettings2bg:RegisterForDrag("LeftButton")
			tkasettings2bg:SetScript("OnDragStart", tkasettings2bg.StartMoving)
			tkasettings2bg:SetScript("OnDragStop", tkasettings2bg.StopMovingOrSizing)

			local sk2vert = -25
				for i=11,20 do
					Skills3["sk2vert" .. i] = sk2vert

					Skills3["sk"..i.."input"] = CreateFrame("Button",Skills3["sk"..i.."input"],tkasettings2bg,tkabutton2)
					Skills3["sk"..i.."input"]:SetFrameStrata("LOW")
					Skills3["sk"..i.."input"]:SetPoint("TOPLEFT",tkasettings2bg,"TOPLEFT",15,Skills3["sk2vert" .. i])
					Skills3["sk"..i.."input"]:SetWidth(30)
					Skills3["sk"..i.."input"]:SetHeight(25)
					Skills3["sk"..i.."input"]:SetText(Skills2["VERSSK"..i])
					Skills3["sk"..i.."input"]:SetScript("OnClick",function()
						Skills3["sk"..i.."box"] = CreateFrame("EditBox",Skills3["sk"..i.."box"],tkasettings2bg,"TKAEditBox")
						Skills3["sk"..i.."box"]:SetFrameStrata("MEDIUM")
						Skills3["sk"..i.."box"]:SetFontObject("CombatLogFont")
						Skills3["sk"..i.."box"]:SetWidth(20)
						Skills3["sk"..i.."box"]:SetHeight(25)
						Skills3["sk"..i.."box"]:SetPoint("CENTER",Skills3["sk"..i.."input"],0,0)
						Skills3["sk"..i.."box"]:SetScript("OnEnterPressed",function()
							Skills2["VERSSK"..i] = Skills3["sk"..i.."box"]:GetNumber()
							Skills3["sk"..i.."box"]:Hide()
							Skills3["sk"..i.."input"]:SetText(Skills2["VERSSK"..i])
						end)
					end)

					Skills3["skill"..i.."input"] = CreateFrame("Button",Skills3["skill"..i.."input"],tkasettings2bg,tkabutton2)
					Skills3["skill"..i.."input"]:SetFrameStrata("LOW")
					Skills3["skill"..i.."input"]:SetNormalFontObject("GameFontWhiteSmall")
					Skills3["skill"..i.."input"]:SetHighlightFontObject("GameFontHighlight")
					Skills3["skill"..i.."input"]:SetPoint("LEFT",Skills3["sk"..i.."input"],"RIGHT",0,0)
					Skills3["skill"..i.."input"]:SetWidth(150)
					Skills3["skill"..i.."input"]:SetHeight(25)
					Skills3["skill"..i.."input"]:SetText(Skills2["VERSSKILL"..i])
					Skills3["skill"..i.."input"]:SetScript("OnClick",function()
						Skills3["skill"..i.."box"] = CreateFrame("EditBox",Skills3["skill"..i.."box"],tkasettings2bg,"TKAEditBox")
						Skills3["skill"..i.."box"]:SetFrameStrata("MEDIUM")
						Skills3["skill"..i.."box"]:SetFontObject("CombatLogFont")
						Skills3["skill"..i.."box"]:SetWidth(150)
						Skills3["skill"..i.."box"]:SetHeight(25)
						Skills3["skill"..i.."box"]:SetPoint("CENTER",Skills3["skill"..i.."input"],0,0)
						Skills3["skill"..i.."box"]:SetScript("OnEnterPressed",function()
							Skills2["VERSSKILL"..i] = Skills3["skill"..i.."box"]:GetText()
							Skills3["skill"..i.."box"]:Hide()
							Skills3["skill"..i.."input"]:SetText(Skills2["VERSSKILL"..i])
						end)
					end)

					Skills3["skill"..i.."kill"] = CreateFrame("CheckButton",Skills3["skill"..i.."kill"],tkasettings2bg,"ChatConfigBaseCheckButtonTemplate")
					Skills3["skill"..i.."kill"]:SetFrameStrata("LOW")
					Skills3["skill"..i.."kill"]:SetPoint("LEFT",Skills3["skill"..i.."input"],"RIGHT",5,0)
					Skills3["skill"..i.."kill"]:SetWidth(30)
					Skills3["skill"..i.."kill"]:SetHeight(30)
					Skills3["skill"..i.."kill"]:SetChecked(Skills2["skill"..i.."k"])
					Skills3["skill"..i.."kill"]:SetScript("OnClick", function()
						if Skills2["skill"..i.."k"] then
						Skills2["skill"..i.."k"] = false else
						Skills2["skill"..i.."k"] = true end
					end)

					Skills3["skill"..i.."spell"] = CreateFrame("CheckButton",Skills3["skill"..i.."spell"],tkasettings2bg,"ChatConfigBaseCheckButtonTemplate")
					Skills3["skill"..i.."spell"]:SetFrameStrata("LOW")
					Skills3["skill"..i.."spell"]:SetPoint("LEFT",Skills3["skill"..i.."kill"],"RIGHT",3,0)
					Skills3["skill"..i.."spell"]:SetWidth(30)
					Skills3["skill"..i.."spell"]:SetHeight(30)
					if Skills2["skill"..i.."s"] then Skills3["skill"..i.."spell"]:SetChecked(true) else Skills3["skill"..i.."spell"]:SetChecked(false) end
					Skills3["skill"..i.."spell"]:SetScript("OnClick", function()
						if Skills2["skill"..i.."s"] then
						Skills2["skill"..i.."s"] = false else
						Skills2["skill"..i.."s"] = true end
					end)

					sk2vert = sk2vert - 25
				end

					SETMOD2 = tkasettings2bg:CreateFontString(nil, "High", "GameTooltipText")
					SETMOD2:SetPoint("BOTTOM",Skills3["sk11input"],"TOP",0,0)
					SETMOD2:SetText("Mod:")
					SETMOD2:SetFont("Fonts\\ARIALN.ttf", 11)

					SETSKILL2 = tkasettings2bg:CreateFontString(nil, "High", "GameTooltipText")
					SETSKILL2:SetPoint("BOTTOM",Skills3["skill11input"],"TOP",0,0)
					SETSKILL2:SetText("Skills:")
					SETSKILL2:SetFont("Fonts\\ARIALN.ttf", 11)

					SETKILLS2 = tkasettings2bg:CreateFontString(nil, "High", "GameTooltipText")
					SETKILLS2:SetPoint("BOTTOM",Skills3["skill11kill"],"TOP",0,0)
					SETKILLS2:SetText("Dmg:")
					SETKILLS2:SetFont("Fonts\\ARIALN.ttf", 11)

					SETSPELL2 = tkasettings2bg:CreateFontString(nil, "High", "GameTooltipText")
					SETSPELL2:SetPoint("BOTTOM",Skills3["skill11spell"],"TOP",0,0)
					SETSPELL2:SetText("Magic:")
					SETSPELL2:SetFont("Fonts\\ARIALN.ttf", 11)

				end
			end)

		offinput = CreateFrame("Button","offinput",tkasettingsbg,tkabutton2)
		offinput:SetFrameStrata("LOW")
		offinput:SetPoint("TOPLEFT",Skills3["sk10input"],"BOTTOMRIGHT",-5,-30)
		offinput:SetWidth(35)
		offinput:SetHeight(25)
		offinput:SetText(Vers_Settings.OffMod)
		offinput:SetScript("OnClick",function()
			offbox = CreateFrame("EditBox","offbox",tkasettingsbg,"TKAEditBox")
			offbox:SetFrameStrata("MEDIUM")
			offbox:SetFontObject("CombatLogFont")
			offbox:SetWidth(30)
			offbox:SetHeight(25)
			offbox:SetPoint("CENTER",offinput,0,0)
			offbox:SetScript("OnEnterPressed",function()
				Vers_Settings.OffMod = offbox:GetNumber()
				offbox:Hide()
				offinput:SetText(Vers_Settings.OffMod)
				end)
			end)

		OffTxt = tkasettingsbg:CreateFontString(nil, "High", "GameTooltipText")
		OffTxt:SetPoint("RIGHT","offinput","LEFT",-2,0)
		OffTxt:SetText("Att:")
		OffTxt:SetFont("Fonts\\ARIALN.ttf", 11)

		definput = CreateFrame("Button","definput",tkasettingsbg,tkabutton2)
		definput:SetFrameStrata("LOW")
		definput:SetPoint("LEFT",offinput,"RIGHT",25,0)
		definput:SetWidth(35)
		definput:SetHeight(25)
		definput:SetText(Vers_Settings.DefMod)
		definput:SetScript("OnClick",function()
			defbox = CreateFrame("EditBox","defbox",tkasettingsbg,"TKAEditBox")
			defbox:SetFrameStrata("MEDIUM")
			defbox:SetFontObject("CombatLogFont")
			defbox:SetWidth(30)
			defbox:SetHeight(25)
			defbox:SetPoint("CENTER",definput,0,0)
			defbox:SetScript("OnEnterPressed",function()
				Vers_Settings.DefMod = defbox:GetNumber()
				defbox:Hide()
				definput:SetText(Vers_Settings.DefMod)
				end)
			end)

		DefTxt = tkasettingsbg:CreateFontString(nil, "High", "GameTooltipText")
		DefTxt:SetPoint("RIGHT","definput","LEFT",-1,0)
		DefTxt:SetText("Def:")
		DefTxt:SetFont("Fonts\\ARIALN.ttf", 11)

		socinput = CreateFrame("Button","socinput",tkasettingsbg,tkabutton2)
		socinput:SetFrameStrata("LOW")
		socinput:SetPoint("LEFT",definput,"RIGHT",25,0)
		socinput:SetWidth(35)
		socinput:SetHeight(25)
		socinput:SetText(Vers_Settings.SocMod)
		socinput:SetScript("OnClick",function()
			socbox = CreateFrame("EditBox","socbox",tkasettingsbg,"TKAEditBox")
			socbox:SetFrameStrata("MEDIUM")
			socbox:SetFontObject("CombatLogFont")
			socbox:SetWidth(30)
			socbox:SetHeight(25)
			socbox:SetPoint("CENTER",socinput,0,0)
			socbox:SetScript("OnEnterPressed",function()
				Vers_Settings.SocMod = socbox:GetNumber()
				socbox:Hide()
				socinput:SetText(Vers_Settings.SocMod)
				end)
			end)

		SocTxt = tkasettingsbg:CreateFontString(nil, "High", "GameTooltipText")
		SocTxt:SetPoint("RIGHT","socinput","LEFT",-1,0)
		SocTxt:SetText("Soc:")
		SocTxt:SetFont("Fonts\\ARIALN.ttf", 11)

		knoinput = CreateFrame("Button","knoinput",tkasettingsbg,tkabutton2)
		knoinput:SetFrameStrata("LOW")
		knoinput:SetPoint("LEFT",socinput,"RIGHT",25,0)
		knoinput:SetWidth(35)
		knoinput:SetHeight(25)
		knoinput:SetText(Vers_Settings.KnoMod)
		knoinput:SetScript("OnClick",function()
			knobox = CreateFrame("EditBox","knobox",tkasettingsbg,"TKAEditBox")
			knobox:SetFrameStrata("MEDIUM")
			knobox:SetFontObject("CombatLogFont")
			knobox:SetWidth(30)
			knobox:SetHeight(25)
			knobox:SetPoint("CENTER",knoinput,0,0)
			knobox:SetScript("OnEnterPressed",function()
				Vers_Settings.KnoMod = knobox:GetNumber()
				knobox:Hide()
				knoinput:SetText(Vers_Settings.KnoMod)
				end)
			end)

		KnoTxt = tkasettingsbg:CreateFontString(nil, "High", "GameTooltipText")
		KnoTxt:SetPoint("RIGHT","knoinput","LEFT",-1,0)
		KnoTxt:SetText("Kno:")
		KnoTxt:SetFont("Fonts\\ARIALN.ttf", 11)

		armorinput = CreateFrame("Button","armorinput",tkasettingsbg,tkabutton2)
		armorinput:SetFrameStrata("LOW")
		armorinput:SetPoint("TOPRIGHT",knoinput,"BOTTOMRIGHT",0,-5)
		armorinput:SetWidth(35)
		armorinput:SetHeight(25)
		armorinput:SetText(Vers_Settings.ArmorMod)
		armorinput:SetScript("OnClick",function()
			armorbox = CreateFrame("EditBox","armorbox",tkasettingsbg,"TKAEditBox")
			armorbox:SetFrameStrata("MEDIUM")
			armorbox:SetFontObject("CombatLogFont")
			armorbox:SetWidth(25)
			armorbox:SetHeight(25)
			armorbox:SetPoint("CENTER",armorinput,0,0)
			armorbox:SetScript("OnEnterPressed",function()
				Vers_Settings.ArmorMod = armorbox:GetNumber()
				if Vers_Settings.ArmorMod > 0 then Vers_Settings.ArmorMod = -Vers_Settings.ArmorMod end
				armorbox:Hide()
				armorinput:SetText(Vers_Settings.ArmorMod)
				end)
			end)

		ArmTxt = tkasettingsbg:CreateFontString(nil, "High", "GameTooltipText")
		ArmTxt:SetPoint("RIGHT","armorinput","LEFT",-2,0)
		ArmTxt:SetText("Equipped Armour Magic Modifier:")
		ArmTxt:SetFont("Fonts\\ARIALN.ttf", 11)

		tkatoggleshowch = CreateFrame("CheckButton","tkatoggleshowch",tkasettingsbg,"ChatConfigBaseCheckButtonTemplate")
		tkatoggleshowch:SetFrameStrata("LOW")
		tkatoggleshowch:SetPoint("TOP","definput","BOTTOM",-3,-30)
		tkatoggleshowch:SetWidth(30)
		tkatoggleshowch:SetHeight(30)
		if tkatoggleshow == "True" then tkatoggleshowch:SetChecked(true) else tkatoggleshowch:SetChecked(false) end
		tkatoggleshowch:SetScript("OnClick", function()
		if tkatoggleshow == "True" then
			tkatoggleshow = "False"
			tkabutton:Hide() else
			tkatoggleshow = "True"
			tkabutton:Show() end
		end)

		tkatoggleshowtx = tkasettingsbg:CreateFontString(nil, "High", "GameTooltipText")
		tkatoggleshowtx:SetPoint("RIGHT","tkatoggleshowch","LEFT",-1,1)
		tkatoggleshowtx:SetText("Main Button:")
		tkatoggleshowtx:SetFont("Fonts\\ARIALN.ttf", 11)

		tkabindtog = CreateFrame("CheckButton","tkabindtog",tkasettingsbg,"ChatConfigBaseCheckButtonTemplate")
		tkabindtog:SetFrameStrata("MEDIUM")
		tkabindtog:SetPoint("TOP","tkatoggleshowch","BOTTOM",0,5)
		tkabindtog:SetWidth(30)
		tkabindtog:SetHeight(30)
		tkabindtog:SetScript("OnEnter",function()
			Tooltip("This option unbinds the various panels. You can place them where you want and they'll remember that position.",tkabindtog)
		end)
		if menuset == "True" then tkabindtog:SetChecked(true) else tkabindtog:SetChecked(false) end
		tkabindtog:SetScript("OnClick", function()
			if menuset == "True" then menuset = "False" else menuset = "True" end
			if menuset == "True" then menumsg = "The panels is now detached from the main button." else menumsg = "The panels window is now bound to the main button." end
			print(menumsg)
		end)

		tksbindtogtx = tkasettingsbg:CreateFontString(nil, "High", "GameTooltipText")
		tksbindtogtx:SetPoint("RIGHT","tkabindtog","LEFT",-1,1)
		tksbindtogtx:SetText("Bind Mode:")
		tksbindtogtx:SetFont("Fonts\\ARIALN.ttf", 11)

		tkaminimapshowch = CreateFrame("CheckButton","tkaminimapshowch",tkasettingsbg,"ChatConfigBaseCheckButtonTemplate")
		tkaminimapshowch:SetFrameStrata("MEDIUM")
		tkaminimapshowch:SetPoint("TOPRIGHT","armorinput","BOTTOMRIGHT",0,0)
		tkaminimapshowch:SetWidth(30)
		tkaminimapshowch:SetHeight(30)
		if tkaminimapshow == "True" then tkaminimapshowch:SetChecked(true) else tkaminimapshowch:SetChecked(false) end
		tkaminimapshowch:SetScript("OnClick", function()
		if tkaminimapshow == "True" then
			tkaminimapshow = "False"
			Vers_MinimapButton:Hide() else
			tkaminimapshow = "True"
			Vers_MinimapButton:Show() end
		end)

		tkaminimapshowtx = tkasettingsbg:CreateFontString(nil, "High", "GameTooltipText")
		tkaminimapshowtx:SetPoint("RIGHT","tkaminimapshowch","LEFT",-1,1)
		tkaminimapshowtx:SetText("Minimap Button:")
		tkaminimapshowtx:SetFont("Fonts\\ARIALN.ttf", 11)

		tkalatencyshowch = CreateFrame("CheckButton","tkalatencyshowch",tkasettingsbg,"ChatConfigBaseCheckButtonTemplate")
		tkalatencyshowch:SetFrameStrata("MEDIUM")
		tkalatencyshowch:SetPoint("TOP","tkaminimapshowch","BOTTOM",0,5)
		tkalatencyshowch:SetWidth(30)
		tkalatencyshowch:SetHeight(30)
		tkalatencyshowch:SetScript("OnEnter",function()
			Tooltip("Use if you're experiencing very high latency(1000ms or above).",tkalatencyshowch)
		end)
		if Vers_Settings.VerLatChk then tkalatencyshowch:SetChecked(true) else tkalatencyshowch:SetChecked(false) end
		tkalatencyshowch:SetScript("OnClick", function()
		if Vers_Settings.VerLatChk then
			Vers_Settings.VerLatChk = false
			Vers_Settings.VerLat = 1
			else
			Vers_Settings.VerLatChk = true
			Vers_Settings.VerLat = 2.5
			end
		end)

		tkalatencyshowtx = tkasettingsbg:CreateFontString(nil, "High", "GameTooltipText")
		tkalatencyshowtx:SetPoint("RIGHT","tkalatencyshowch","LEFT",-1,1)
		tkalatencyshowtx:SetText("High Latency Mode:")
		tkalatencyshowtx:SetFont("Fonts\\ARIALN.ttf", 11)
		end
	end)

	if tkarolltog then tkaroll:Click("LeftMouseButton",down) tkarolltog = true end
	if tkadmtog then tkadm:Click("LeftMouseButton",down) tkadmtog = true  end

	end
	end)

-- Only while the button is dragged this is called every frame
function Vers_MinimapButton_DraggingFrame_OnUpdate()

	local xpos,ypos = GetCursorPosition()
	local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom()

	xpos = xmin-xpos/UIParent:GetScale()+70 -- get coordinates as differences from the center of the minimap
	ypos = ypos/UIParent:GetScale()-ymin-70

	Vers_Settings.MinimapPos = math.deg(math.atan2(ypos,xpos)) -- save the degrees we are relative to the minimap center
	Vers_MinimapButton_Reposition() -- move the button
end

-- Put your code that you want on a minimap button click here.  arg1="LeftButton", "RightButton", etc
function Vers_MinimapButton_OnClick()
	tkabutton:Click("LeftMouseButton",down)
end

local addhp = CreateFrame("Frame")
addhp:SetScript("OnEvent",function(self,event,...)
	tkapre, tkamsg = select(1,...)
		if tkapre == "VersHPUpdate" then
			SendAddonMessage("VersHPUpdate2",SUser.." "..VersHealthPoints.."HP","RAID")
			if tkahpstatframe then tkahpstatframe2:AddMessage("-----Updating-----",1,1,1,1) end
		elseif tkapre == "VersHPUpdate2" and tkahpstatframe then
			tkahpstatframe2:AddMessage(tkamsg,1,1,1,1)
		end
	end)
addhp:RegisterEvent("CHAT_MSG_ADDON")

local tkaglobupdate = CreateFrame("Frame")
tkaglobupdate:SetScript("OnEvent",function(self,event,...)
	local Prefix, Message, Channel, Sender  = select(1,...)
	if Prefix == "TKA1" then
		local Sender2 = string.match(Sender,"%a+")
		getRaidMembers()
		local isRaidMember = contains(RaidMembers,Sender2)
		if isRaidMember then
			local DMMod = string.match(Message, "%d+")
			local DMMagic = string.match(Message, "%a+")
			TKAGlobal = tonumber(DMMod)
			if DMMagic == "Magic" then TKAGlobMagic = true else TKAGlobMagic = false end
			if tkarollbg then tkaglobin:SetText(TKAGlobal) tkaglobmagic:SetChecked(TKAGlobMagic) end
		end
	end
end)
tkaglobupdate:RegisterEvent("CHAT_MSG_ADDON")
