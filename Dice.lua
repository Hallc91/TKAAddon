RegisterAddonMessagePrefix("VersHPUpdate") RegisterAddonMessagePrefix("VersHPUpdate2") RegisterAddonMessagePrefix("MSP")
TitleFont = "Fonts\\ARIALN.ttf"
Vers_Settings = {
	MinimapPos = 45; -- default position of the minimap icon in degrees
}
Vers_DM1 = {}
Vers_DM2 = {}
Vers_DM3 = {}
Skills3 = {}
Skills2 = {}
-- Prepopulating Variables with Ints
	if VERSDC == nil then VERSDC = 0 end
	if DCInc == nil then DCInc = 0 end
	if utilposx == nil then utilposx = 0 end
	if utilposy == nil then utilposy = 0 end

	if VersHealthPoints == nil then VersHealthPoints = 5 end
	if AbMod == nil then AbMod = 0 end
	if AbType == nil then AbType = "" end
	DmgMsg = 1
	d100t = 0
	tdmg = 0
	d100 = 0
	versbgheight = 115
	versbars = 0
	CustBars = 0

	for i=1,20 do
	_G["VERSSK"..i.."Temp"] = 0
	end

-- Prepopulating Variables with Strings
	if VERSTar == nil then VERSTar = "No Target" end
	if menuset == nil then menuset = "False" end
	SUser = UnitName("Player")
	VERSVersion = GetAddOnMetadata("TKAAddon", "Version")
	killsmsg = ""
	versjoin = " against "
	TarCol = "FFFFFFFF"
	if AbTxt == nil then AbTxt = "Select Ability" end

	if verstoggleshow == nil then verstoggleshow = "True" end
	if versminimapshow == nil then versminimapshow = "True" end

	VersPlayer = "<No Player Selected>"
	VersPlayerOut = "<No Player Selected>"

VEMembers = {}

lagcheck = function()
	local down, up, lagHome, lagWorld = GetNetStats(); 
	Vers_Settings.VerLat = 0.9 + (lagWorld / 1000)
end

local ClassColorTable = {
	{ class = "Death Knight", color="FFC41F3B" },
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

local SkillTable = function()
	VersSkills = {
		{ name=Skills2.VERSSKILL1, value=Skills2.VERSSK1 },
		{ name=Skills2.VERSSKILL2, value=Skills2.VERSSK2 },
		{ name=Skills2.VERSSKILL3, value=Skills2.VERSSK3 },
		{ name=Skills2.VERSSKILL4, value=Skills2.VERSSK4 },
		{ name=Skills2.VERSSKILL5, value=Skills2.VERSSK5 },
		{ name=Skills2.VERSSKILL6, value=Skills2.VERSSK6 },
		{ name=Skills2.VERSSKILL7, value=Skills2.VERSSK7 },
		{ name=Skills2.VERSSKILL8, value=Skills2.VERSSK8 },
		{ name=Skills2.VERSSKILL9, value=Skills2.VERSSK9 },
		{ name=Skills2.VERSSKILL10, value=Skills2.VERSSK10 },
		{ name=Skills2.VERSSKILL11, value=Skills2.VERSSK11 },
		{ name=Skills2.VERSSKILL12, value=Skills2.VERSSK12 },
		{ name=Skills2.VERSSKILL13, value=Skills2.VERSSK13 },
		{ name=Skills2.VERSSKILL14, value=Skills2.VERSSK14 },
		{ name=Skills2.VERSSKILL15, value=Skills2.VERSSK15 },
		{ name=Skills2.VERSSKILL16, value=Skills2.VERSSK16 },
		{ name=Skills2.VERSSKILL17, value=Skills2.VERSSK17 },
		{ name=Skills2.VERSSKILL18, value=Skills2.VERSSK18 },
		{ name=Skills2.VERSSKILL19, value=Skills2.VERSSK19 },
		{ name=Skills2.VERSSKILL20, value=Skills2.VERSSK20 }
	}
end


--- NPC Stats

local vars = CreateFrame("Frame")
vars:SetScript("OnEvent",function(self,event,...)
	function Vers_MinimapButton_Reposition()
	Vers_MinimapButton:SetPoint("TOPLEFT","Minimap","TOPLEFT",52-(80*cos(Vers_Settings.MinimapPos)),(80*sin(Vers_Settings.MinimapPos))-52)
	end
	
	if Vers_Settings.OffMod == nil then Vers_Settings.OffMod = 1 end
	if Vers_Settings.DefMod == nil then Vers_Settings.DefMod = 1 end
	if Vers_Settings.SocMod == nil then Vers_Settings.SocMod = 1 end
	if Vers_Settings.KnoMod == nil then Vers_Settings.KnoMod = 1 end
	
	if Vers_Settings.VERSENEM1 == nil then Vers_Settings.VERSENEM1 = "" end
	if Vers_Settings.VERSENEMDMG1 == nil then Vers_Settings.VERSENEMDMG1 = 0 end
	if Vers_Settings.VERSENEMOFFDC1 == nil then Vers_Settings.VERSENEMOFFDC1 = 0 end
	if Vers_Settings.VERSENEMDEFDC1 == nil then Vers_Settings.VERSENEMDEFDC1 = 0 end
	if Vers_Settings.VersEnemyHP1 == nil then Vers_Settings.VersEnemyHP1 = 0 end
	if Vers_Settings.VersEnemyMaxHP1 == nil then Vers_Settings.VersEnemyMaxHP1 = 0 end
	if Vers_Settings.VERSENEM2 == nil then Vers_Settings.VERSENEM2 = "" end
	if Vers_Settings.VERSENEMDMG2 == nil then Vers_Settings.VERSENEMDMG2 = 0 end
	if Vers_Settings.VERSENEMOFFDC2 == nil then Vers_Settings.VERSENEMOFFDC2 = 0 end
	if Vers_Settings.VERSENEMDEFDC2 == nil then Vers_Settings.VERSENEMDEFDC2 = 0 end
	if Vers_Settings.VersEnemyHP2 == nil then Vers_Settings.VersEnemyHP2 = 0 end
	if Vers_Settings.VersEnemyMaxHP2 == nil then Vers_Settings.VersEnemyMaxHP2 = 0 end
	if Vers_Settings.VERSENEM3 == nil then Vers_Settings.VERSENEM3 = "" end
	if Vers_Settings.VERSENEMDMG3 == nil then Vers_Settings.VERSENEMDMG3 = 0 end
	if Vers_Settings.VERSENEMOFFDC3 == nil then Vers_Settings.VERSENEMOFFDC3 = 0 end
	if Vers_Settings.VERSENEMDEFDC3 == nil then Vers_Settings.VERSENEMDEFDC3 = 0 end
	if Vers_Settings.VersEnemyHP3 == nil then Vers_Settings.VersEnemyHP3 = 0 end
	if Vers_Settings.VersEnemyMaxHP3 == nil then Vers_Settings.VersEnemyMaxHP3 = 0 end
	if Vers_Settings.VERSENEM4 == nil then Vers_Settings.VERSENEM4 = "" end
	if Vers_Settings.VERSENEMDMG4 == nil then Vers_Settings.VERSENEMDMG4 = 0 end
	if Vers_Settings.VERSENEMOFFDC4 == nil then Vers_Settings.VERSENEMOFFDC4 = 0 end
	if Vers_Settings.VERSENEMDEFDC4 == nil then Vers_Settings.VERSENEMDEFDC4 = 0 end
	if Vers_Settings.VersEnemyHP4 == nil then Vers_Settings.VersEnemyHP4 = 0 end
	if Vers_Settings.VersEnemyMaxHP4 == nil then Vers_Settings.VersEnemyMaxHP4 = 0 end
	if Vers_Settings.VERSENEM5 == nil then Vers_Settings.VERSENEM5 = "" end
	if Vers_Settings.VERSENEMDMG5 == nil then Vers_Settings.VERSENEMDMG5 = 0 end
	if Vers_Settings.VERSENEMOFFDC5 == nil then Vers_Settings.VERSENEMOFFDC5 = 0 end
	if Vers_Settings.VERSENEMDEFDC5 == nil then Vers_Settings.VERSENEMDEFDC5 = 0 end
	if Vers_Settings.VersEnemyHP5 == nil then Vers_Settings.VersEnemyHP5 = 0 end
	if Vers_Settings.VersEnemyMaxHP5 == nil then Vers_Settings.VersEnemyMaxHP5 = 0 end
	if Vers_Settings.VERSENEM6 == nil then Vers_Settings.VERSENEM6 = "" end
	if Vers_Settings.VERSENEMDMG6 == nil then Vers_Settings.VERSENEMDMG6 = 0 end
	if Vers_Settings.VERSENEMOFFDC6 == nil then Vers_Settings.VERSENEMOFFDC6 = 0 end
	if Vers_Settings.VERSENEMDEFDC6 == nil then Vers_Settings.VERSENEMDEFDC6 = 0 end
	if Vers_Settings.VersEnemyHP6 == nil then Vers_Settings.VersEnemyHP6 = 0 end
	if Vers_Settings.VersEnemyMaxHP6 == nil then Vers_Settings.VersEnemyMaxHP6 = 0 end
	if Vers_Settings.VERSENEM7 == nil then Vers_Settings.VERSENEM7 = "" end
	if Vers_Settings.VERSENEMDMG7 == nil then Vers_Settings.VERSENEMDMG7 = 0 end
	if Vers_Settings.VERSENEMOFFDC7 == nil then Vers_Settings.VERSENEMOFFDC7 = 0 end
	if Vers_Settings.VERSENEMDEFDC7 == nil then Vers_Settings.VERSENEMDEFDC7 = 0 end
	if Vers_Settings.VersEnemyHP7 == nil then Vers_Settings.VersEnemyHP7 = 0 end
	if Vers_Settings.VersEnemyMaxHP7 == nil then Vers_Settings.VersEnemyMaxHP7 = 0 end
	if Vers_Settings.unskill == nil then Vers_Settings.unskill = "False" end
	if Vers_Settings.tkabreadtotal == nil then Vers_Settings.tkabreadtotal = 0 end
	if Vers_Settings.VERSATTDC == nil then Vers_Settings.VERSATTDC = 0 end
	if Vers_Settings.VERSATTMOD == nil then Vers_Settings.VERSATTMOD = 0 end

	if Vers_Settings.VRaidHigh == nil then Vers_Settings.VRaidHigh = 8 end
	if Vers_Settings.VRaidLow == nil then Vers_Settings.VRaidLow = 1 end
	
	if Vers_Settings.VerLatChk == true then Vers_Settings.VerLat = 2.5 else Vers_Settings.VerLat = 1 end
		for i=1,10 do
			if Skills2["VERSSKILL"..i] == nil then Skills2["VERSSKILL"..i] = "" end
			if Skills2["VERSSK"..i] == nil then Skills2["VERSSK"..i] = 0 end
		end
		for i=11,20 do
			if Skills2["VERSSKILL"..i] == nil then Skills2["VERSSKILL"..i] = "" end
			if Skills2["VERSSK"..i] == nil then Skills2["VERSSK"..i] = 0 end
		end
		for i=1,7 do 
			if Vers_DM1["VERSENEM"..i] == nil then Vers_DM1["VERSENEM"..i] = "" end
			if Vers_DM1["VERSENEMDMG"..i] == nil then Vers_DM1["VERSENEMDMG"..i] = 0 end
			if Vers_DM1["VERSENEMOFFDC"..i] == nil then Vers_DM1["VERSENEMOFFDC"..i] = 0 end
			if Vers_DM1["VERSENEMDEFDC"..i] == nil then Vers_DM1["VERSENEMDEFDC"..i] = 0 end
			if Vers_DM1["VersEnemyHP"..i] == nil then Vers_DM1["VersEnemyHP"..i] = 0 end
			if Vers_DM1["VersEnemyMaxHP"..i] == nil then Vers_DM1["VersEnemyMaxHP"..i] = 0 end
		end
		for i=1,7 do 
			if Vers_DM2["VERSENEM"..i] == nil then Vers_DM2["VERSENEM"..i] = "" end
			if Vers_DM2["VERSENEMDMG"..i] == nil then Vers_DM2["VERSENEMDMG"..i] = 0 end
			if Vers_DM2["VERSENEMOFFDC"..i] == nil then Vers_DM2["VERSENEMOFFDC"..i] = 0 end
			if Vers_DM2["VERSENEMDEFDC"..i] == nil then Vers_DM2["VERSENEMDEFDC"..i] = 0 end
			if Vers_DM2["VersEnemyHP"..i] == nil then Vers_DM2["VersEnemyHP"..i] = 0 end
			if Vers_DM2["VersEnemyMaxHP"..i] == nil then Vers_DM2["VersEnemyMaxHP"..i] = 0 end
		end
		for i=1,7 do 
			if Vers_DM3["VERSENEM"..i] == nil then Vers_DM3["VERSENEM"..i] = "" end
			if Vers_DM3["VERSENEMDMG"..i] == nil then Vers_DM3["VERSENEMDMG"..i] = 0 end
			if Vers_DM3["VERSENEMOFFDC"..i] == nil then Vers_DM3["VERSENEMOFFDC"..i] = 0 end
			if Vers_DM3["VERSENEMDEFDC"..i] == nil then Vers_DM3["VERSENEMDEFDC"..i] = 0 end
			if Vers_DM3["VersEnemyHP"..i] == nil then Vers_DM3["VersEnemyHP"..i] = 0 end
			if Vers_DM3["VersEnemyMaxHP"..i] == nil then Vers_DM3["VersEnemyMaxHP"..i] = 0 end
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
	Backdrop3 = {
        bgFile = "Interface\\Garrison\\GarrisonShipMissionParchment",  -- path to the background texture
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",  -- path to the border texture
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
	Backdrop2 = {
        bgFile = "Interface\\ACHIEVEMENTFRAME\\UI-GuildAchievement-Parchment-Horizontal-Desaturated",  -- path to the background texture
        edgeFile = "Interface\\ACHIEVEMENTFRAME\\UI-Achievement-WoodBorder",  -- path to the border texture
        tile = false,    -- true to repeat the background texture to fill the frame, false to scale it
        tileSize = 128,  -- size (width or height) of the square repeating background tiles (in pixels)
        edgeSize = 32,  -- thickness of edge segments and square size of edge corners (in pixels)
        insets = {    -- distance from the edges of the frame to those of the background texture (in pixels)
            left = 11,
            right = 11,
            top = 10,  --12
            bottom = 11
        }
    }
	Backdrop4 = {
        bgFile = "Interface\\TabardFrame\\TabardFrameBackground",  -- path to the background texture
        edgeFile = "Interface\\LFGFRAME\\LFGBorder",  -- path to the border texture
        tile = false,    -- true to repeat the background texture to fill the frame, false to scale it
        tileSize = 32,  -- size (width or height) of the square repeating background tiles (in pixels)
        edgeSize = 32,  -- thickness of edge segments and square size of edge corners (in pixels)
        insets = {    -- distance from the edges of the frame to those of the background texture (in pixels)
            left = 11,
            right = 11,
            top = 11,  --12
            bottom = 11
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
    Backdrop7 = {
        bgFile = "Interface\\ACHIEVEMENTFRAME\\UI-GuildAchievement-Parchment-Horizontal-Desaturated",  -- path to the background texture
        edgeFile = "Interface\\LFGFRAME\\LFGBorder",  -- path to the border texture
        tile = false,    -- true to repeat the background texture to fill the frame, false to scale it
        tileSize = 32,  -- size (width or height) of the square repeating background tiles (in pixels)
        edgeSize = 32,  -- thickness of edge segments and square size of edge corners (in pixels)
        insets = {    -- distance from the edges of the frame to those of the background texture (in pixels)
            left = 11,
            right = 11,
            top = 11,  --12
            bottom = 11
        }
    }


local function contains(table, val)
   for i=1,#table do
      if table[i] == val then 
         return true
      end
   end
   return false
end

tkabread = math.random(100)
VLocale = GetLocale()

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
--    print(arg1)
    name,roll,minRoll,maxRoll = arg1:match("^(.+) "..rstring.." (%d+) %((%d+)%-(%d+)%)$")
	if maxRoll == "100" and name == SUser then d100 = tonumber(roll) end
	--if maxRoll == "100" and name == SUser then d100 = tkabread end
	if maxRoll == "20" and name == SUser then d20 = tonumber(roll) d20tbl[d20] = d20tbl[d20] + 1 end
	--if maxRoll == "20" and name == SUser then d20 = 20 end
	if d100 == tkabread then 
		RaidNotice_AddMessage(RaidWarningFrame,"You found A Bread!",ChatTypeInfo["RAID_WARNING"]); 
		tkabread = math.random(100) 
		Vers_Settings.tkabreadtotal = Vers_Settings.tkabreadtotal + 1 
		PlaySound(124) end 
	end
end)
f:RegisterEvent("CHAT_MSG_SYSTEM")

local function roll()
	if d100 > 0 and IsControlKeyDown() then d100 = d100 ReCalc = "(ReCalc)" else RandomRoll(1, 100) ReCalc = "" end		
end

local function rollcalc(SkillMod, TempMod, KillTog, SkillName)
	d100t = d100 + SkillMod + TempMod + AbMod
	if VERSTar == "" then versjoin = "" else versjoin = " against " end
	if d100t < 0 then d100t = 0 end
	if d100t >= VERSDC then
		OutC = "Pass" else
		OutC = "Fail"
	end
	if KillTog == "True" and OutC == "Pass" then killsmsg = "("..DmgMsg.." Damage on "..VERSTar..")" else killsmsg = "" end
	if VERSDC == 0 then DCCheck = "" killsmsg = "" else DCCheck = OutC.." on DC"..VERSDC..". " end
	if TempMod == 0 then TempTxt = "" elseif TempMod < 0 then TempTxt = TempMod else TempTxt = "+"..TempMod end
	AbModTx = "+"..AbMod
	OutMsg = ReCalc .. "Rolling "..SkillName..AbType..versjoin..VERSTar..". "..DCCheck.."("..d100.."+"..SkillMod..AbModTx..TempTxt.."="..d100t..")"..killsmsg
	if IsInRaid() then SendChatMessage(OutMsg, "RAID") elseif
		IsInGroup(LE_PARTY_CATEGORY_HOME) then SendChatMessage(OutMsg, "PARTY") else
		print(OutMsg)
	end
end

SLASH_VERSRESET1 = '/versreset';
function SlashCmdList.VERSRESET(msg, editbox)
	versbutton:ClearAllPoints()
	versbutton:SetPoint("CENTER",0,0)
	menuset = "False"
	verstoggleshow = "True"
	versminimapshow = "True"
	versbutton:Show()
	Vers_MinimapButton:Show()
end

SLASH_VERSBIND1 = '/versbind';
function SlashCmdList.VERSBIND(msg, editbox)
	if menuset == "True" then menuset = "False" else menuset = "True" end
	if menuset == "True" then menumsg = "The Roll window is now detached from the main button." else menumsg = "The Roll window is now bound to the main button." end
	print(menumsg)
end

versbutton = CreateFrame("Button","versbutton",UIParent,"VersButtonTemplate2")
versbutton:SetFrameStrata("Medium")
versbutton:SetHeight(35)
versbutton:SetWidth(35)
versbutton:SetPoint("CENTER",0,0)
versbutton:SetMovable(true)
versbutton:EnableMouse(true)
versbutton:RegisterForDrag("LeftButton")
versbutton:SetScript("OnDragStart", versbutton.StartMoving)
versbutton:SetScript("OnDragStop", versbutton.StopMovingOrSizing)
versbutton:SetNormalTexture("Interface\\Icons\\Spell_Holy_MagicalSentry")
versbutton:SetScript("OnUpdate", function()
	if versminimapshow == "True" then Vers_MinimapButton:Show() else Vers_MinimapButton:Hide() end
	if verstoggleshow == "True" then versbutton:Show() else versbutton:Hide() end
	end)
versbutton:SetScript("OnClick",function()
	if versmenubg then
    versmenubg:Hide()
    versmenubg = nil;
	else

	versbutton1 = "VersButtonTemplate" 
	versbutton2 = "VersButtonTemplate2" 
	versbutton3 = "GameMenuButtonTemplate" 

	versmenubg = CreateFrame("Frame","versmenubg",UIParent)
	tinsert(UISpecialFrames,"versmenubg")
	versmenubg:SetFrameStrata("low")
	versmenubg:ClearAllPoints()
	versmenubg:SetBackdrop(Backdrop6)
	versmenubg:SetBackdropBorderColor(0,0.22,0.56,1)
	versmenubg:SetBackdropColor(0,0.22,0.56,1)
	versmenubg:SetScale(1.25)
	versmenubg:SetHeight(100)
	versmenubg:SetWidth(133)
	if menuset == "False" then versmenubg:SetPoint("TOPLEFT",versbutton,"TOPRIGHT",0,0) else versmenubg:SetPoint("CENTER",UIParent,"BOTTOMLEFT",Vers_Settings.versmenubgx,Vers_Settings.versmenubgy) end
	versmenubg:SetScript("OnHide", function() versmenubg = nil versbars = 0 end )
	versmenubg:SetScript("OnUpdate", function() if versmenubg == "Hide" then versmenubg:Hide() versmenubg = nil; end end)
	versmenubg:SetMovable(true)
	versmenubg:EnableMouse(true)
	versmenubg:RegisterForDrag("LeftButton")
	versmenubg:SetScript("OnDragStart", versmenubg.StartMoving)
	versmenubg:SetScript("OnDragStop", versmenubg.StopMovingOrSizing)
	versmenubg:SetScript("OnUpdate", function() Vers_Settings.versmenubgx, Vers_Settings.versmenubgy = versmenubg:GetCenter() end)

		SSKILL = versmenubg:CreateFontString(nil, "High", "GameTooltipText")
		SSKILL:SetPoint("TOP","versmenubg",0,-12)
		SSKILL:SetText("|cffffffffKirin Aran Addon|r")
		SSKILL:SetFont("Fonts\\SKURRI.ttf", 12, "OUTLINE")
		
		VerTxt = versmenubg:CreateFontString(nil, "High", "GameTooltipText")
		VerTxt:SetPoint("TOP","versmenubg",0,-24)
		VerTxt:SetText("|cffffffffVersion "..VERSVersion.."|r")
		VerTxt:SetFont(TitleFont, 10, "OUTLINE")

		versroll = CreateFrame("Button","versroll",versmenubg,versbutton2)
		versroll:SetFrameStrata("LOW")
		versroll:SetPoint("TOP",versmenubg,"TOP",0,-45)
		versroll:SetScale(0.75)
		versroll:SetWidth(145)
		versroll:SetHeight(25)
		versroll:SetText("Skills")
		versroll:SetAlpha(0.95)
		versroll:SetScript("PreClick",function()
			if versrolltog == "True" then
			versrolltog = "False" else
			versrolltog = "True" end
			end)
		versroll:SetScript("OnClick",function()
			if versrollbg then
			versrollbg:Hide()
			versrollbg = nil;
			else

			versbutton1 = "VersButtonTemplate" 
			versbutton2 = "VersButtonTemplate2"
			
			sk2bar = 0

			for i=1,10 do
				if Skills2["VERSSKILL"..i] ~= "" then versbars = versbars + 19 end
			end
			for i=11,20 do
				if Skills2["VERSSKILL"..i] ~= "" then sk2bar = 19 end
			end

			versrollbg = CreateFrame("Frame","versrollbg",versmenubg)
			tinsert(UISpecialFrames,"versrollbg")
			versrollbg:SetFrameStrata("low")
			versrollbg:ClearAllPoints()
			versrollbg:SetBackdrop(Backdrop6)
			versrollbg:SetBackdropBorderColor(0,0.19,0.46,1)
			versrollbg:SetBackdropColor(0,0.19,0.46,1)
			versrollbg:SetScale(1)
			versrollbg:SetHeight(versbgheight+versbars+sk2bar+38)
			versrollbg:SetWidth(160)
			--if menuset == "False" then versrollbg:SetPoint("TOPLEFT",versmenubg,"TOPRIGHT",0,0) else versrollbg:SetPoint("CENTER",UIParent,"BOTTOMLEFT",utilposx,utilposy) end
			--versrollbg:SetPoint("TOPLEFT",versmenubg,"TOPRIGHT",0,0)
			versrollbg:SetScript("OnHide", function() versrollbg = nil versbars = 0 end )
			versrollbg:SetScript("OnUpdate", function() if versrollbg == "Hide" then versrollbg:Hide() versrollbg = nil; end end)
			versrollbg:SetMovable(true)
			versrollbg:EnableMouse(true)
			versrollbg:RegisterForDrag("LeftButton")
			if menuset == "False" then versrollbg:SetPoint("TOPLEFT",versmenubg,"TOPRIGHT",0,0) else versrollbg:SetPoint("CENTER",UIParent,"BOTTOMLEFT",Vers_Settings.versrollx,Vers_Settings.versrolly) end
			versrollbg:SetScript("OnUpdate", function() Vers_Settings.versrollx, Vers_Settings.versrolly = versrollbg:GetCenter() end)
			versrollbg:SetScript("OnDragStart", versrollbg.StartMoving)
			versrollbg:SetScript("OnDragStop", versrollbg.StopMovingOrSizing)

			versdcinput = CreateFrame("Button","versdcinput",versrollbg,versbutton2)
			versdcinput:SetFrameStrata("LOW")
			versdcinput:SetPoint("TOPLEFT",58,-15)
			versdcinput:SetScale(0.72)
			versdcinput:SetWidth(29)
			versdcinput:SetHeight(25)
			versdcinput:SetText(VERSDC)
			versdcinput:SetAlpha(0.95)
			versdcinput:SetScript("PostClick", function() versdcinput:Hide() end)
			versdcinput:SetScript("OnClick",function()
				versdcbox = CreateFrame("EditBox","versdcbox",versrollbg,"InputBoxTemplate")
				versdcbox:SetFrameStrata("LOW")
				versdcbox:SetFontObject("CombatLogFont")
				versdcbox:SetScale(0.72)
				versdcbox:SetWidth(20)
				versdcbox:SetHeight(25)
				versdcbox:SetPoint("TOPLEFT",60,-15)
				versdcbox:SetScript("OnEnterPressed",function()
					VERSDC = versdcbox:GetNumber()
					versdcbox:Hide()
					versdcinput:Show()
					versdcinput:SetText(VERSDC)
								end)
					end)

			versdcadd = CreateFrame("Button","versdcadd",versrollbg,versbutton2)
			versdcadd:SetFrameStrata("LOW")
			versdcadd:SetPoint("LEFT",versdcinput,"RIGHT",-1,0)
			versdcadd:SetScale(0.72)
			versdcadd:SetWidth(22)
			versdcadd:SetHeight(25)
			versdcadd:SetText("+")
			versdcadd:SetBackdropColor(0,0,0,0)
			versdcadd:SetAlpha(0.95)
			versdcadd:SetScript("OnClick",function()
				versshiftdown = IsShiftKeyDown()
				if versshiftdown == true then VERSDC = VERSDC + 5 else
				VERSDC = VERSDC + 10 end
				VERSDC = math.floor(VERSDC/5)*5
				versdcinput:SetText(VERSDC)
			end)

			versdcsub = CreateFrame("Button","versdcsub",versrollbg,versbutton2)
			versdcsub:SetFrameStrata("LOW")
			versdcsub:SetPoint("RIGHT",versdcinput,"LEFT",1,0)
			versdcsub:SetScale(0.72)
			versdcsub:SetWidth(22)
			versdcsub:SetHeight(25)
			versdcsub:SetText("-")
			versdcsub:SetBackdropColor(0,0,0,0)
			versdcsub:SetAlpha(0.95)
			versdcsub:SetScript("OnClick",function()
				versshiftdown = IsShiftKeyDown()
				if versshiftdown == true then VERSDC = VERSDC - 5 else
				VERSDC = VERSDC - 10 end
				VERSDC = math.ceil(VERSDC/5)*5
				if VERSDC < 0 then VERSDC = 0 end
				versdcinput:SetText(VERSDC)
			end)

			VERSDCTX = versrollbg:CreateFontString(nil, "High", "GameTooltipText")
				VERSDCTX:SetPoint("RIGHT","versdcsub","LEFT",2,0)
				VERSDCTX:SetText("DC:")
				VERSDCTX:SetFont("Fonts\\ARIALN.ttf", 9, "OUTLINE")

			vershpinput = CreateFrame("Button","vershpinput",versrollbg,versbutton2)
			vershpinput:SetFrameStrata("LOW")
			vershpinput:SetPoint("LEFT",versdcinput,"RIGHT",60,0)
			vershpinput:SetScale(0.75)
			vershpinput:SetWidth(29)
			vershpinput:SetHeight(25)
			vershpinput:SetText(VersHealthPoints)
			vershpinput:SetBackdropColor(0,0,0,0)
			vershpinput:SetAlpha(0.95)
			vershpinput:SetScript("PostClick", function() vershpinput:Hide()end)
			vershpinput:SetScript("OnClick",function()
				vershpbox = CreateFrame("EditBox","vershpbox",versrollbg,"InputBoxTemplate")
				vershpbox:SetFrameStrata("LOW")
				vershpbox:SetFontObject("CombatLogFont")
				vershpbox:SetScale(0.75)
				vershpbox:SetWidth(20)
				vershpbox:SetHeight(25)
				vershpbox:SetPoint("LEFT",versdcinput,"RIGHT",60,0)
				vershpbox:SetScript("OnEnterPressed",function()
					VersHealthPoints = vershpbox:GetNumber()
					vershpbox:Hide()
					vershpinput:Show()
					vershpinput:SetText(VersHealthPoints)
					end)
				end)

			vershpadd = CreateFrame("Button","vershpadd",versrollbg,versbutton2)
			vershpadd:SetFrameStrata("LOW")
			vershpadd:SetPoint("LEFT",vershpinput,"RIGHT",-1,0)
			vershpadd:SetScale(0.72)
			vershpadd:SetWidth(22)
			vershpadd:SetHeight(25)
			vershpadd:SetText("+")
			vershpadd:SetBackdropColor(0,0,0,0)
			vershpadd:SetAlpha(0.95)
			vershpadd:SetScript("OnClick",function()
				versshiftdown = IsShiftKeyDown()
				if versshiftdown == true then VersHealthPoints = VersHealthPoints + 5 else
				VersHealthPoints = VersHealthPoints + 1 end
				vershpinput:SetText(VersHealthPoints)
			end)

			vershpsub = CreateFrame("Button","vershpsub",versrollbg,versbutton2)
			vershpsub:SetFrameStrata("LOW")
			vershpsub:SetPoint("RIGHT",vershpinput,"LEFT",1,0)
			vershpsub:SetScale(0.75)
			vershpsub:SetWidth(22)
			vershpsub:SetHeight(25)
			vershpsub:SetText("-")
			vershpsub:SetBackdropColor(0,0,0,0)
			vershpsub:SetAlpha(0.95)
			vershpsub:SetScript("OnClick",function()
				versshiftdown = IsShiftKeyDown()
				if versshiftdown == true then VersHealthPoints = VersHealthPoints - 5 else
				VersHealthPoints = VersHealthPoints - 1 end
				if VersHealthPoints < 0 then VersHealthPoints = 0 end
				vershpinput:SetText(VersHealthPoints)
			end)

			VEHPTX = versrollbg:CreateFontString(nil, "High", "GameTooltipText")
			VEHPTX:SetPoint("RIGHT",vershpsub,"LEFT",2,0)
			VEHPTX:SetText("HP:")
			VEHPTX:SetFont("Fonts\\ARIALN.ttf", 9, "OUTLINE")

			verstarinput = CreateFrame("Button","verstarinput",versrollbg,versbutton2)
			verstarinput:SetFrameStrata("LOW")
			verstarinput:SetNormalFontObject("GameFontWhiteSmall")
			verstarinput:SetPoint("TOPLEFT",versdcinput,"BOTTOMLEFT",0,0)
			verstarinput:SetScale(0.75)
			verstarinput:SetWidth(137)
			verstarinput:SetHeight(25)
			verstarinput:SetText(VERSTar)
			verstarinput:SetBackdropColor(0,0,0,0)
			verstarinput:SetAlpha(0.95)
			verstarinput:SetScript("PostClick", function() verstarinput:Hide() end)
			verstarinput:SetScript("OnClick",function()
				verstarbox = CreateFrame("EditBox","verstarbox",versrollbg,"InputBoxTemplate")
				verstarbox:SetFrameStrata("LOW")
				verstarbox:SetFontObject("CombatLogFont")
				verstarbox:SetScale(0.75)
				verstarbox:SetWidth(137)
				verstarbox:SetHeight(25)
				verstarbox:SetPoint("TOPLEFT",versdcinput,"BOTTOMLEFT",0,0)
				verstarbox:SetScript("OnEnterPressed",function()
					VERSTar = verstarbox:GetText()
					verstarbox:Hide()
					verstarinput:Show()
					verstarinput:SetText(VERSTar)
					end)
				end)

			verstarreset = CreateFrame("Button","verstarreset",versrollbg,versbutton2)
			verstarreset:SetFrameStrata("LOW")
			verstarreset:SetPoint("TOPRIGHT","verstarinput","BOTTOMRIGHT",0,0)
			verstarreset:SetScale(0.75)
			verstarreset:SetWidth(137)
			verstarreset:SetHeight(25)
			verstarreset:SetText("Clear Target & DC")
			verstarreset:SetBackdropColor(0,0,0,0)
			verstarreset:SetAlpha(0.95)
			verstarreset:SetScript("OnClick",function()
				VERSTar = ""
				VERSDC = 0
				verstarinput:SetText(VERSTar)
				versdcinput:SetText(VERSDC)
			end)

			VERSTART = versrollbg:CreateFontString(nil, "High", "GameTooltipText")
			VERSTART:SetPoint("RIGHT","verstarinput","LEFT",1,0)
			VERSTART:SetText("Target:")
			VERSTART:SetFont("Fonts\\ARIALN.ttf", 9, "OUTLINE")

			Skill1 = CreateFrame("Button","Skill1",versrollbg,versbutton2)
			Skill1:SetFrameStrata("LOW")
			Skill1:SetPoint("TOPRIGHT",verstarinput,"BOTTOMRIGHT",0,-24)
			Skill1:SetScale(0.75)
			Skill1:SetWidth(145)
			Skill1:SetHeight(25)
			Skill1:SetText(Skills2.VERSSKILL1)
			Skill1:SetBackdropColor(0,0,0,0)
			Skill1:SetAlpha(0.95)
			if Skills2.VERSSKILL1 == "" then Skill1:Hide() end
			Skill1:SetScript("OnClick", function()
				roll()
				C_Timer.After(Vers_Settings.VerLat, function()
					local i = 1
					rollcalc(Skills2["VERSSK"..i], _G["VERSSK"..i.."Temp"], Skills2["skill"..i.."k"], Skills2["VERSSKILL"..i])
					VERSSK1Temp = 0
					sk1tinput:SetText(VERSSK1Temp)
				end)
			end) 

			sk1tinput = CreateFrame("Button","sk1tinput",versrollbg,versbutton2)
			sk1tinput:SetFrameStrata("LOW")
			sk1tinput:SetPoint("RIGHT",Skill1,"LEFT",0,0)
			sk1tinput:SetScale(0.75)
			sk1tinput:SetWidth(30)
			sk1tinput:SetHeight(25)
			sk1tinput:SetText(VERSSK1Temp)
			sk1tinput:SetBackdropColor(0,0,0,0)
			sk1tinput:SetAlpha(0.95)
			if Skills2.VERSSKILL1 == "" then sk1tinput:Hide() end
			sk1tinput:SetScript("PostClick", function() sk1tinput:Hide()end)
			sk1tinput:SetScript("OnClick",function()
				sk1tbox = CreateFrame("EditBox","sk1tbox",versrollbg,"InputBoxTemplate")
				sk1tbox:SetFrameStrata("LOW")
				sk1tbox:SetFontObject("CombatLogFont")
				sk1tbox:SetScale(0.75)
				sk1tbox:SetWidth(20)
				sk1tbox:SetHeight(25)
				sk1tbox:SetPoint("RIGHT",Skill1,"LEFT",0,0)
				sk1tbox:SetScript("OnEnterPressed",function()
					VERSSK1Temp = sk1tbox:GetNumber()
					sk1tbox:Hide()
					sk1tinput:Show()
					sk1tinput:SetText(VERSSK1Temp)
					end)
				end)

			VERSMOD = versrollbg:CreateFontString(nil, "High", "GameTooltipText")
				VERSMOD:SetPoint("BOTTOM","sk1tinput","TOP",2,0)
				VERSMOD:SetText("Temp\n Mod:")
				VERSMOD:SetFont("Fonts\\ARIALN.ttf", 9, "OUTLINE")

			Skill2 = CreateFrame("Button","Skill2",versrollbg,versbutton2)
			Skill2:SetFrameStrata("LOW")
			Skill2:SetPoint("TOPRIGHT",Skill1,"BOTTOMRIGHT",0,0)
			Skill2:SetScale(0.75)
			Skill2:SetWidth(145)
			Skill2:SetHeight(25)
			Skill2:SetText(Skills2.VERSSKILL2)
			Skill2:SetBackdropColor(0,0,0,0)
			Skill2:SetAlpha(0.95)
			if Skills2.VERSSKILL2 == "" then Skill2:Hide() end
			Skill2:SetScript("OnClick", function()
				roll()
				C_Timer.After(Vers_Settings.VerLat, function()
					local i = 2
					rollcalc(Skills2["VERSSK"..i], _G["VERSSK"..i.."Temp"], Skills2["skill"..i.."k"], Skills2["VERSSKILL"..i])
					VERSSK2Temp = 0
					sk2tinput:SetText(VERSSK2Temp)
				end)
			end)

			sk2tinput = CreateFrame("Button","sk2tinput",versrollbg,versbutton2)
			sk2tinput:SetFrameStrata("LOW")
			sk2tinput:SetPoint("RIGHT",Skill2,"LEFT",0,0)
			sk2tinput:SetScale(0.75)
			sk2tinput:SetWidth(30)
			sk2tinput:SetHeight(25)
			sk2tinput:SetText(VERSSK2Temp)
			sk2tinput:SetBackdropColor(0,0,0,0)
			sk2tinput:SetAlpha(0.95)
			if Skills2.VERSSKILL2 == "" then sk2tinput:Hide() end
			sk2tinput:SetScript("PostClick", function() sk2tinput:Hide()end)
			sk2tinput:SetScript("OnClick",function()
				sk2tbox = CreateFrame("EditBox","sk2tbox",versrollbg,"InputBoxTemplate")
				sk2tbox:SetFrameStrata("LOW")
				sk2tbox:SetFontObject("CombatLogFont")
				sk2tbox:SetScale(0.75)
				sk2tbox:SetWidth(20)
				sk2tbox:SetHeight(25)
				sk2tbox:SetPoint("RIGHT",Skill2,"LEFT",0,0)
				sk2tbox:SetScript("OnEnterPressed",function()
					VERSSK2Temp = sk2tbox:GetNumber()
					sk2tbox:Hide()
					sk2tinput:Show()
					sk2tinput:SetText(VERSSK2Temp)
					end)
				end)

			Skill3 = CreateFrame("Button","Skill3",versrollbg,versbutton2)
			Skill3:SetFrameStrata("LOW")
			Skill3:SetPoint("TOPRIGHT",Skill2,"BOTTOMRIGHT",0,0)
			Skill3:SetScale(0.75)
			Skill3:SetWidth(145)
			Skill3:SetHeight(25)
			Skill3:SetText(Skills2.VERSSKILL3)
			Skill3:SetBackdropColor(0,0,0,0)
			Skill3:SetAlpha(0.95)
			if Skills2.VERSSKILL3 == "" then Skill3:Hide() end
			Skill3:SetScript("OnClick", function()
				roll()
				C_Timer.After(Vers_Settings.VerLat, function()
					local i = 3
					rollcalc(Skills2["VERSSK"..i], _G["VERSSK"..i.."Temp"], Skills2["skill"..i.."k"], Skills2["VERSSKILL"..i])
					VERSSK3Temp = 0
					sk3tinput:SetText(VERSSK3Temp)
				end)
			end)

			sk3tinput = CreateFrame("Button","sk3tinput",versrollbg,versbutton2)
			sk3tinput:SetFrameStrata("LOW")
			sk3tinput:SetPoint("RIGHT",Skill3,"LEFT",0,0)
			sk3tinput:SetScale(0.75)
			sk3tinput:SetWidth(30)
			sk3tinput:SetHeight(25)
			sk3tinput:SetText(VERSSK3Temp)
			sk3tinput:SetBackdropColor(0,0,0,0)
			sk3tinput:SetAlpha(0.95)
			if Skills2.VERSSKILL3 == "" then sk3tinput:Hide() end
			sk3tinput:SetScript("PostClick", function() sk3tinput:Hide()end)
			sk3tinput:SetScript("OnClick",function()
				sk3tbox = CreateFrame("EditBox","sk3tbox",versrollbg,"InputBoxTemplate")
				sk3tbox:SetFrameStrata("LOW")
				sk3tbox:SetFontObject("CombatLogFont")
				sk3tbox:SetScale(0.75)
				sk3tbox:SetWidth(20)
				sk3tbox:SetHeight(25)
				sk3tbox:SetPoint("RIGHT",Skill3,"LEFT",0,0)
				sk3tbox:SetScript("OnEnterPressed",function()
					VERSSK3Temp = sk3tbox:GetNumber()
					sk3tbox:Hide()
					sk3tinput:Show()
					sk3tinput:SetText(VERSSK3Temp)
					end)
				end)

			Skill4 = CreateFrame("Button","Skill4",versrollbg,versbutton2)
			Skill4:SetFrameStrata("LOW")
			Skill4:SetPoint("TOPRIGHT",Skill3,"BOTTOMRIGHT",0,0)
			Skill4:SetScale(0.75)
			Skill4:SetWidth(145)
			Skill4:SetHeight(25)
			Skill4:SetText(Skills2.VERSSKILL4)
			Skill4:SetBackdropColor(0,0,0,0)
			Skill4:SetAlpha(0.95)
			if Skills2.VERSSKILL4 == "" then Skill4:Hide() end
			Skill4:SetScript("OnClick", function()
				roll()
				C_Timer.After(Vers_Settings.VerLat, function()
					local i = 4
					rollcalc(Skills2["VERSSK"..i], _G["VERSSK"..i.."Temp"], Skills2["skill"..i.."k"], Skills2["VERSSKILL"..i])
					VERSSK4Temp = 0
					sk4tinput:SetText(VERSSK4Temp)
				end)
			end)

			sk4tinput = CreateFrame("Button","sk4tinput",versrollbg,versbutton2)
			sk4tinput:SetFrameStrata("LOW")
			sk4tinput:SetPoint("RIGHT",Skill4,"LEFT",0,0)
			sk4tinput:SetScale(0.75)
			sk4tinput:SetWidth(30)
			sk4tinput:SetHeight(25)
			sk4tinput:SetText(VERSSK4Temp)
			sk4tinput:SetBackdropColor(0,0,0,0)
			sk4tinput:SetAlpha(0.95)
			if Skills2.VERSSKILL4 == "" then sk4tinput:Hide() end
			sk4tinput:SetScript("PostClick", function() sk4tinput:Hide()end)
			sk4tinput:SetScript("OnClick",function()
				sk4tbox = CreateFrame("EditBox","sk4tbox",versrollbg,"InputBoxTemplate")
				sk4tbox:SetFrameStrata("LOW")
				sk4tbox:SetFontObject("CombatLogFont")
				sk4tbox:SetScale(0.75)
				sk4tbox:SetWidth(20)
				sk4tbox:SetHeight(25)
				sk4tbox:SetPoint("RIGHT",Skill4,"LEFT",0,0)
				sk4tbox:SetScript("OnEnterPressed",function()
					VERSSK4Temp = sk4tbox:GetNumber()
					sk4tbox:Hide()
					sk4tinput:Show()
					sk4tinput:SetText(VERSSK4Temp)
					end)
				end)

			Skill5 = CreateFrame("Button","Skill5",versrollbg,versbutton2)
			Skill5:SetFrameStrata("LOW")
			Skill5:SetPoint("TOPRIGHT",Skill4,"BOTTOMRIGHT",0,0)
			Skill5:SetScale(0.75)
			Skill5:SetWidth(145)
			Skill5:SetHeight(25)
			Skill5:SetText(Skills2.VERSSKILL5)
			Skill5:SetBackdropColor(0,0,0,0)
			Skill5:SetAlpha(0.95)
			if Skills2.VERSSKILL5 == "" then Skill5:Hide() end
			Skill5:SetScript("OnClick", function()
				roll()
				C_Timer.After(Vers_Settings.VerLat, function()
					local i = 5
					rollcalc(Skills2["VERSSK"..i], _G["VERSSK"..i.."Temp"], Skills2["skill"..i.."k"], Skills2["VERSSKILL"..i])
					VERSSK5Temp = 0
					sk5tinput:SetText(VERSSK5Temp)
				end)
			end)

			sk5tinput = CreateFrame("Button","sk5tinput",versrollbg,versbutton2)
			sk5tinput:SetFrameStrata("LOW")
			sk5tinput:SetPoint("RIGHT",Skill5,"LEFT",0,0)
			sk5tinput:SetScale(0.75)
			sk5tinput:SetWidth(30)
			sk5tinput:SetHeight(25)
			sk5tinput:SetText(VERSSK5Temp)
			sk5tinput:SetBackdropColor(0,0,0,0)
			sk5tinput:SetAlpha(0.95)
			if Skills2.VERSSKILL5 == "" then sk5tinput:Hide() end
			sk5tinput:SetScript("PostClick", function() sk5tinput:Hide()end)
			sk5tinput:SetScript("OnClick",function()
				sk5tbox = CreateFrame("EditBox","sk5tbox",versrollbg,"InputBoxTemplate")
				sk5tbox:SetFrameStrata("LOW")
				sk5tbox:SetFontObject("CombatLogFont")
				sk5tbox:SetScale(0.75)
				sk5tbox:SetWidth(20)
				sk5tbox:SetHeight(25)
				sk5tbox:SetPoint("RIGHT",Skill5,"LEFT",0,0)
				sk5tbox:SetScript("OnEnterPressed",function()
					VERSSK5Temp = sk5tbox:GetNumber()
					sk5tbox:Hide()
					sk5tinput:Show()
					sk5tinput:SetText(VERSSK5Temp)
					end)
				end)

			Skill6 = CreateFrame("Button","Skill6",versrollbg,versbutton2)
			Skill6:SetFrameStrata("LOW")
			Skill6:SetPoint("TOPRIGHT",Skill5,"BOTTOMRIGHT",0,0)
			Skill6:SetScale(0.75)
			Skill6:SetWidth(145)
			Skill6:SetHeight(25)
			Skill6:SetText(Skills2.VERSSKILL6)
			Skill6:SetBackdropColor(0,0,0,0)
			Skill6:SetAlpha(0.95)
			if Skills2.VERSSKILL6 == "" then Skill6:Hide() end
			Skill6:SetScript("OnClick", function()
				roll()
				C_Timer.After(Vers_Settings.VerLat, function()
					local i = 6
					rollcalc(Skills2["VERSSK"..i], _G["VERSSK"..i.."Temp"], Skills2["skill"..i.."k"], Skills2["VERSSKILL"..i])
					VERSSK6Temp = 0
					sk6tinput:SetText(VERSSK6Temp)
				end)
			end)

			sk6tinput = CreateFrame("Button","sk6tinput",versrollbg,versbutton2)
			sk6tinput:SetFrameStrata("LOW")
			sk6tinput:SetPoint("RIGHT",Skill6,"LEFT",0,0)
			sk6tinput:SetScale(0.75)
			sk6tinput:SetWidth(30)
			sk6tinput:SetHeight(25)
			sk6tinput:SetText(VERSSK6Temp)
			sk6tinput:SetBackdropColor(0,0,0,0)
			sk6tinput:SetAlpha(0.95)
			if Skills2.VERSSKILL6 == "" then sk6tinput:Hide() end
			sk6tinput:SetScript("PostClick", function() sk6tinput:Hide()end)
			sk6tinput:SetScript("OnClick",function()
				sk6tbox = CreateFrame("EditBox","sk6tbox",versrollbg,"InputBoxTemplate")
				sk6tbox:SetFrameStrata("LOW")
				sk6tbox:SetFontObject("CombatLogFont")
				sk6tbox:SetScale(0.75)
				sk6tbox:SetWidth(20)
				sk6tbox:SetHeight(25)
				sk6tbox:SetPoint("RIGHT",Skill6,"LEFT",0,0)
				sk6tbox:SetScript("OnEnterPressed",function()
					VERSSK6Temp = sk6tbox:GetNumber()
					sk6tbox:Hide()
					sk6tinput:Show()
					sk6tinput:SetText(VERSSK6Temp)
					end)
				end)

			Skill7 = CreateFrame("Button","Skill7",versrollbg,versbutton2)
			Skill7:SetFrameStrata("LOW")
			Skill7:SetPoint("TOPRIGHT",Skill6,"BOTTOMRIGHT",0,0)
			Skill7:SetScale(0.75)
			Skill7:SetWidth(145)
			Skill7:SetHeight(25)
			Skill7:SetText(Skills2.VERSSKILL7)
			Skill7:SetBackdropColor(0,0,0,0)
			Skill7:SetAlpha(0.95)
			if Skills2.VERSSKILL7 == "" then Skill7:Hide() end
			Skill7:SetScript("OnClick", function()
				roll()
				C_Timer.After(Vers_Settings.VerLat, function()
					local i = 7
					rollcalc(Skills2["VERSSK"..i], _G["VERSSK"..i.."Temp"], Skills2["skill"..i.."k"], Skills2["VERSSKILL"..i])
					VERSSK7Temp = 0
					sk7tinput:SetText(VERSSK7Temp)
				end)
			end)
				
			sk7tinput = CreateFrame("Button","sk7tinput",versrollbg,versbutton2)
			sk7tinput:SetFrameStrata("LOW")
			sk7tinput:SetPoint("RIGHT",Skill7,"LEFT",0,0)
			sk7tinput:SetScale(0.75)
			sk7tinput:SetWidth(30)
			sk7tinput:SetHeight(25)
			sk7tinput:SetText(VERSSK7Temp)
			sk7tinput:SetBackdropColor(0,0,0,0)
			sk7tinput:SetAlpha(0.95)
			if Skills2.VERSSKILL7 == "" then sk7tinput:Hide() end
			sk7tinput:SetScript("PostClick", function() sk7tinput:Hide()end)
			sk7tinput:SetScript("OnClick",function()
				sk7tbox = CreateFrame("EditBox","sk7tbox",versrollbg,"InputBoxTemplate")
				sk7tbox:SetFrameStrata("LOW")
				sk7tbox:SetFontObject("CombatLogFont")
				sk7tbox:SetScale(0.75)
				sk7tbox:SetWidth(20)
				sk7tbox:SetHeight(25)
				sk7tbox:SetPoint("RIGHT",Skill7,"LEFT",0,0)
				sk7tbox:SetScript("OnEnterPressed",function()
					VERSSK7Temp = sk7tbox:GetNumber()
					sk7tbox:Hide()
					sk7tinput:Show()
					sk7tinput:SetText(VERSSK7Temp)
					end)
				end)

			Skill8 = CreateFrame("Button","Skill8",versrollbg,versbutton2)
			Skill8:SetFrameStrata("LOW")
			Skill8:SetPoint("TOPRIGHT",Skill7,"BOTTOMRIGHT",0,0)
			Skill8:SetScale(0.75)
			Skill8:SetWidth(145)
			Skill8:SetHeight(25)
			Skill8:SetText(Skills2.VERSSKILL8)
			Skill8:SetBackdropColor(0,0,0,0)
			Skill8:SetAlpha(0.95)
			if Skills2.VERSSKILL8 == "" then Skill8:Hide() end
			Skill8:SetScript("OnClick", function()
				roll()
				C_Timer.After(Vers_Settings.VerLat, function()
					local i = 8
					rollcalc(Skills2["VERSSK"..i], _G["VERSSK"..i.."Temp"], Skills2["skill"..i.."k"], Skills2["VERSSKILL"..i])
					VERSSK8Temp = 0
					sk8tinput:SetText(VERSSK8Temp)
				end)
			end)

			sk8tinput = CreateFrame("Button","sk8tinput",versrollbg,versbutton2)
			sk8tinput:SetFrameStrata("LOW")
			sk8tinput:SetPoint("RIGHT",Skill8,"LEFT",0,0)
			sk8tinput:SetScale(0.75)
			sk8tinput:SetWidth(30)
			sk8tinput:SetHeight(25)
			sk8tinput:SetText(VERSSK8Temp)
			sk8tinput:SetBackdropColor(0,0,0,0)
			sk8tinput:SetAlpha(0.95)
			if Skills2.VERSSKILL8 == "" then sk8tinput:Hide() end
			sk8tinput:SetScript("PostClick", function() sk8tinput:Hide()end)
			sk8tinput:SetScript("OnClick",function()
				sk8tbox = CreateFrame("EditBox","sk8tbox",versrollbg,"InputBoxTemplate")
				sk8tbox:SetFrameStrata("LOW")
				sk8tbox:SetFontObject("CombatLogFont")
				sk8tbox:SetScale(0.75)
				sk8tbox:SetWidth(20)
				sk8tbox:SetHeight(25)
				sk8tbox:SetPoint("RIGHT",Skill8,"LEFT",0,0)
				sk8tbox:SetScript("OnEnterPressed",function()
					VERSSK8Temp = sk8tbox:GetNumber()
					sk8tbox:Hide()
					sk8tinput:Show()
					sk8tinput:SetText(VERSSK8Temp)
					end)
				end)

			Skill9 = CreateFrame("Button","Skill9",versrollbg,versbutton2)
			Skill9:SetFrameStrata("LOW")
			Skill9:SetPoint("TOPRIGHT",Skill8,"BOTTOMRIGHT",0,0)
			Skill9:SetScale(0.75)
			Skill9:SetWidth(145)
			Skill9:SetHeight(25)
			Skill9:SetText(Skills2.VERSSKILL9)
			Skill9:SetBackdropColor(0,0,0,0)
			Skill9:SetAlpha(0.95)
			if Skills2.VERSSKILL9 == "" then Skill9:Hide() end
			Skill9:SetScript("OnClick", function()
				roll()
				C_Timer.After(Vers_Settings.VerLat, function()
					local i = 9
					rollcalc(Skills2["VERSSK"..i], _G["VERSSK"..i.."Temp"], Skills2["skill"..i.."k"], Skills2["VERSSKILL"..i])
					VERSSK9Temp = 0
					sk9tinput:SetText(VERSSK9Temp)
				end)
			end)

			sk9tinput = CreateFrame("Button","sk9tinput",versrollbg,versbutton2)
			sk9tinput:SetFrameStrata("LOW")
			sk9tinput:SetPoint("RIGHT",Skill9,"LEFT",0,0)
			sk9tinput:SetScale(0.75)
			sk9tinput:SetWidth(30)
			sk9tinput:SetHeight(25)
			sk9tinput:SetText(VERSSK9Temp)
			sk9tinput:SetBackdropColor(0,0,0,0)
			sk9tinput:SetAlpha(0.95)
			if Skills2.VERSSKILL9 == "" then sk9tinput:Hide() end
			sk9tinput:SetScript("PostClick", function() sk9tinput:Hide()end)
			sk9tinput:SetScript("OnClick",function()
				sk9tbox = CreateFrame("EditBox","sk9tbox",versrollbg,"InputBoxTemplate")
				sk9tbox:SetFrameStrata("LOW")
				sk9tbox:SetFontObject("CombatLogFont")
				sk9tbox:SetScale(0.75)
				sk9tbox:SetWidth(20)
				sk9tbox:SetHeight(25)
				sk9tbox:SetPoint("RIGHT",Skill9,"LEFT",0,0)
				sk9tbox:SetScript("OnEnterPressed",function()
					VERSSK9Temp = sk9tbox:GetNumber()
					sk9tbox:Hide()
					sk9tinput:Show()
					sk9tinput:SetText(VERSSK9Temp)
					end)
				end)

			Skill10 = CreateFrame("Button","Skill10",versrollbg,versbutton2)
			Skill10:SetFrameStrata("LOW")
			Skill10:SetPoint("TOPRIGHT",Skill9,"BOTTOMRIGHT",0,0)
			Skill10:SetScale(0.75)
			Skill10:SetWidth(145)
			Skill10:SetHeight(25)
			Skill10:SetText(Skills2.VERSSKILL10)
			Skill10:SetBackdropColor(0,0,0,0)
			Skill10:SetAlpha(0.95)
			if Skills2.VERSSKILL10 == "" then Skill10:Hide() end
			Skill10:SetScript("OnClick", function()
				roll()
				C_Timer.After(Vers_Settings.VerLat, function()
					local i = 10
					rollcalc(Skills2["VERSSK"..i], _G["VERSSK"..i.."Temp"], Skills2["skill"..i.."k"], Skills2["VERSSKILL"..i])
					VERSSK10Temp = 0
					sk10tinput:SetText(VERSSK10Temp)
				end)
			end)

			sk10tinput = CreateFrame("Button","sk10tinput",versrollbg,versbutton2)
			sk10tinput:SetFrameStrata("LOW")
			sk10tinput:SetPoint("RIGHT",Skill10,"LEFT",0,0)
			sk10tinput:SetScale(0.75)
			sk10tinput:SetWidth(30)
			sk10tinput:SetHeight(25)
			sk10tinput:SetText(VERSSK10Temp)
			sk10tinput:SetBackdropColor(0,0,0,0)
			sk10tinput:SetAlpha(0.95)
			if Skills2.VERSSKILL10 == "" then sk10tinput:Hide() end
			sk10tinput:SetScript("PostClick", function() sk10tinput:Hide()end)
			sk10tinput:SetScript("OnClick",function()
				sk10tbox = CreateFrame("EditBox","sk10tbox",versrollbg,"InputBoxTemplate")
				sk10tbox:SetFrameStrata("LOW")
				sk10tbox:SetFontObject("CombatLogFont")
				sk10tbox:SetScale(0.75)
				sk10tbox:SetWidth(20)
				sk10tbox:SetHeight(25)
				sk10tbox:SetPoint("RIGHT",Skill10,"LEFT",0,0)
				sk10tbox:SetScript("OnEnterPressed",function()
					VERSSK10Temp = sk10tbox:GetNumber()
					sk10tbox:Hide()
					sk10tinput:Show()
					sk10tinput:SetText(VERSSK10Temp)
					end)
				end)

			vershpupdate = CreateFrame("Button","vershpupdate",versrollbg,versbutton1)
			vershpupdate:SetFrameStrata("LOW")
			vershpupdate:SetPoint("Bottom","versrollbg",0,15)
			vershpupdate:SetScale(0.75)
			vershpupdate:SetWidth(175)
			vershpupdate:SetHeight(25)
			vershpupdate:SetText("HP Report")
			vershpupdate:SetBackdropColor(0,0,0,0)
			vershpupdate:SetAlpha(0.95)
			vershpupdate:SetScript("OnClick", function()
				if vershpstatframe then
				vershpstatframe:Hide()
				vershpstatframe = nil;
				else
					vershpstatframe = CreateFrame("Frame","vershpstatframe",versrollbg)
					vershpstatframe:SetFrameStrata("LOW")
					vershpstatframe:SetSize(130,240)
					vershpstatframe:SetPoint("BOTTOMLEFT",versrollbg,"BOTTOMRIGHT",0,0)
					vershpstatframe:SetBackdrop(Backdrop6)
					vershpstatframe:SetBackdropColor(0,0,0,0.8)
					vershpstatframe:SetBackdropBorderColor(0.8,0.8,0.8,0.8)
					vershpstatframe:SetMovable(true)
					vershpstatframe:EnableMouse(true)
					vershpstatframe:RegisterForDrag("LeftButton")
					vershpstatframe:SetScript("OnDragStart", vershpstatframe.StartMoving)
					vershpstatframe:SetScript("OnDragStop", vershpstatframe.StopMovingOrSizing)
					vershpstatframe:SetScript("OnHide", function() vershpstatframe = nil end )

					vershpstatframe2 = CreateFrame("MessageFrame","vershpstatframe2",vershpstatframe)
					vershpstatframe2:SetFrameStrata("LOW")
					vershpstatframe2:SetSize(110,180)
					vershpstatframe2:SetFontObject("GameFontWhiteSmall")
					vershpstatframe2:SetPoint("TOP",0,-10)
					vershpstatframe2:SetInsertMode("BOTTOM")
					vershpstatframe2:SetTimeVisible(60)

					vershpupdate2 = CreateFrame("Button","vershpupdate2",vershpstatframe2,"GameMenuButtonTemplate")
					vershpupdate2:SetFrameStrata("LOW")
					vershpupdate2:SetPoint("BOTTOM",vershpstatframe,"BOTTOM",0,15)
					vershpupdate2:SetScale(0.75)
					vershpupdate2:SetWidth(110)
					vershpupdate2:SetHeight(25)
					vershpupdate2:SetText("Update")
					vershpupdate2:SetBackdropColor(0,0,0,0)
					vershpupdate2:SetAlpha(0.95)
					vershpupdate2:SetScript("PreClick", function()
						SendAddonMessage("VersHPUpdate","Msg","RAID") end)
				end
			end)

			VersLuck = CreateFrame("Button","VersLuck",versrollbg,versbutton2)
			VersLuck:SetFrameStrata("LOW")
			VersLuck:SetPoint("Bottom","vershpupdate","TOP",0,0)
			VersLuck:SetScale(0.75)
			VersLuck:SetWidth(175)
			VersLuck:SetHeight(25)
			VersLuck:SetText("D100 Roll")
			VersLuck:SetBackdropColor(0,0,0,0)
			VersLuck:SetAlpha(0.95)
			VersLuck:SetScript("OnClick", function()
				roll()
				C_Timer.After(Vers_Settings.VerLat, function()
					OutMsg = "Rolling D100! Result is "..d100.."."
					if IsInRaid() then SendChatMessage(OutMsg, "RAID") elseif
						IsInGroup(LE_PARTY_CATEGORY_HOME) then SendChatMessage(OutMsg, "PARTY") else
						print(OutMsg)
					end
				end )
			end )

			versroll2 = CreateFrame("Button","versroll2",versrollbg,versbutton2)
			versroll2:SetFrameStrata("LOW")
			versroll2:SetPoint("BOTTOM",VersLuck,"TOP",0,0)
			versroll2:SetScale(0.75)
			versroll2:SetWidth(175)
			versroll2:SetHeight(25)
			versroll2:SetText("More Skills")
			versroll2:SetAlpha(0.95)
			versroll2:Hide()
			if sk2bar == 19 then versroll2:Show() end
			versroll2:SetScript("PreClick",function()
				if versroll2tog == "True" then
				versroll2tog = "False" else
				versroll2tog = "True" end
				end)
			versroll2:SetScript("OnClick",function()
				if versroll2bg then
				versroll2bg:Hide()
				versroll2bg = nil;
				else
				versbars2 = 19
				
				for i=11,20 do 
					if Skills2["VERSSKILL"..i] ~= "" then versbars2 = versbars2 + 18 end
				end

				versroll2bg = CreateFrame("Frame","versroll2bg",versrollbg)
				versroll2bg:SetFrameStrata("low")
				versroll2bg:ClearAllPoints()
				versroll2bg:SetBackdrop(Backdrop6)
				versroll2bg:SetBackdropBorderColor(0,0.19,0.46,1)
				versroll2bg:SetBackdropColor(0,0.19,0.46,1)
				versroll2bg:SetScale(1)
				versroll2bg:SetHeight(versbars2)
				versroll2bg:SetWidth(153)
				versroll2bg:SetScript("OnHide", function() versroll2bg = nil versbars = 0 end )
				versroll2bg:SetScript("OnUpdate", function() if versroll2bg == "Hide" then versroll2bg:Hide() versroll2bg = nil; end end)
				versroll2bg:SetMovable(true)
				versroll2bg:EnableMouse(true)
				versroll2bg:RegisterForDrag("LeftButton")
				if menuset == "False" then versroll2bg:SetPoint("TOPLEFT",versrollbg,"TOPRIGHT",0,0) else versroll2bg:SetPoint("CENTER",UIParent,"BOTTOMLEFT",Vers_Settings.versroll2x,Vers_Settings.versroll2y) end
				versroll2bg:SetScript("OnUpdate", function() Vers_Settings.versroll2x, Vers_Settings.versroll2y = versroll2bg:GetCenter() end)
				versroll2bg:SetScript("OnDragStart", versroll2bg.StartMoving)
				versroll2bg:SetScript("OnDragStop", versroll2bg.StopMovingOrSizing)
				Roll2Bars = -13
					for i=11,20 do
					
					Skills3["Roll2Bars"..i] = Roll2Bars
					Skills3["skill"..i] = CreateFrame("Button",Skills3["skill"..i],versroll2bg,versbutton2)
					Skills3["skill"..i]:SetFrameStrata("LOW")
					Skills3["skill"..i]:SetPoint("TOPRIGHT",versroll2bg,"TOPRIGHT",-14,Skills3["Roll2Bars"..i])
					Skills3["skill"..i]:SetScale(0.75)
					Skills3["skill"..i]:SetWidth(145)
					Skills3["skill"..i]:SetHeight(25)
					Skills3["skill"..i]:SetText(Skills2["VERSSKILL"..i])
					Skills3["skill"..i]:SetBackdropColor(0,0,0,0)
					Skills3["skill"..i]:SetAlpha(0.95)
					if Skills2["VERSSKILL"..i] == "" then Skills3["skill"..i]:Hide() end
					Skills3["skill"..i]:SetScript("OnClick", function()
						roll()
						C_Timer.After(Vers_Settings.VerLat, function()
							rollcalc(Skills2["VERSSK"..i], _G["VERSSK"..i.."Temp"], Skills2["skill"..i.."k"], Skills2["VERSSKILL"..i])
							_G["VERSSK"..i.."Temp"] = 0
							Skills3["sk"..i.."tinput"]:SetText(_G["VERSSK"..i.."Temp"])
						end )
					end )
						
					Skills3["sk"..i.."tinput"] = CreateFrame("Button",Skills3["sk"..i.."tinput"],versroll2bg,versbutton2)
					Skills3["sk"..i.."tinput"]:SetFrameStrata("LOW")
					Skills3["sk"..i.."tinput"]:SetPoint("RIGHT",Skills3["skill"..i],"LEFT",0,0)
					Skills3["sk"..i.."tinput"]:SetScale(0.75)
					Skills3["sk"..i.."tinput"]:SetWidth(30)
					Skills3["sk"..i.."tinput"]:SetHeight(25)
					Skills3["sk"..i.."tinput"]:SetText(_G["VERSSK"..i.."Temp"])
					Skills3["sk"..i.."tinput"]:SetBackdropColor(0,0,0,0)
					Skills3["sk"..i.."tinput"]:SetAlpha(0.95)
					if Skills2["VERSSKILL"..i] == "" then Skills3["sk"..i.."tinput"]:Hide() end
					Skills3["sk"..i.."tinput"]:SetScript("PostClick", function() Skills3["sk"..i.."tinput"]:Hide()end)
					Skills3["sk"..i.."tinput"]:SetScript("OnClick",function()
						Skills3["sk"..i.."tbox"] = CreateFrame("EditBox",Skills3["sk"..i.."tbox"],versroll2bg,"InputBoxTemplate")
						Skills3["sk"..i.."tbox"]:SetFrameStrata("LOW")
						Skills3["sk"..i.."tbox"]:SetFontObject("CombatLogFont")
						Skills3["sk"..i.."tbox"]:SetScale(0.75)
						Skills3["sk"..i.."tbox"]:SetWidth(20)
						Skills3["sk"..i.."tbox"]:SetHeight(25)
						Skills3["sk"..i.."tbox"]:SetPoint("RIGHT",Skills3["skill"..i],"LEFT",0,0)
						Skills3["sk"..i.."tbox"]:SetScript("OnEnterPressed",function()
							_G["VERSSK"..i.."Temp"] = Skills3["sk"..i.."tbox"]:GetNumber()
							Skills3["sk"..i.."tbox"]:Hide()
							Skills3["sk"..i.."tinput"]:Show()
							Skills3["sk"..i.."tinput"]:SetText(_G["VERSSK"..i.."Temp"])
							end)
						end)
					
					
					Roll2Bars = Roll2Bars - 23
					
					
					end
				end
			end)
						
			AbModTxt = versrollbg:CreateFontString(nil, "High", "GameTooltipText")
			if sk2bar == 19 then AbModTxt:SetPoint("BOTTOM",versroll2,"TOP",0,25) else AbModTxt:SetPoint("BOTTOM",VersLuck,"TOP",0,25) end
			AbModTxt:SetText(AbTxt)
			AbModTxt:SetFont("Fonts\\FRIZQT__.ttf", 11, "OUTLINE")
			
			OffRoll = CreateFrame("Button","OffRoll",versrollbg,versbutton2)
			OffRoll:SetFrameStrata("LOW")
			if sk2bar == 19 then OffRoll:SetPoint("BOTTOMLEFT",versroll2,"TOPLEFT",0,0) else OffRoll:SetPoint("BOTTOMLEFT",VersLuck,"TOPLEFT",0,0) end
			OffRoll:SetScale(0.75)
			OffRoll:SetWidth(44)
			OffRoll:SetHeight(25)
			OffRoll:SetText("Att")
			OffRoll:SetAlpha(0.95)
			OffRoll:SetScript("OnClick",function()
				AbMod = Vers_Settings.OffMod
				AbType = "(Attack)"
				AbTxt = "Attack ("..Vers_Settings.OffMod..")"
				AbModTxt:SetText(AbTxt)
			end)
			
			DefRoll = CreateFrame("Button","DefRoll",versrollbg,versbutton2)
			DefRoll:SetFrameStrata("LOW")
			DefRoll:SetPoint("LEFT",OffRoll,"RIGHT",0,0)
			DefRoll:SetScale(0.75)
			DefRoll:SetWidth(44)
			DefRoll:SetHeight(25)
			DefRoll:SetText("Def")
			DefRoll:SetAlpha(0.95)
			DefRoll:SetScript("OnClick",function()
				AbMod = Vers_Settings.DefMod
				AbType = "(Defense)"
				AbTxt = "Defense ("..Vers_Settings.DefMod..")"
				AbModTxt:SetText(AbTxt)
			end)			
			
			SocRoll = CreateFrame("Button","SocRoll",versrollbg,versbutton2)
			SocRoll:SetFrameStrata("LOW")
			SocRoll:SetPoint("LEFT",DefRoll,"RIGHT",0,0)
			SocRoll:SetScale(0.75)
			SocRoll:SetWidth(44)
			SocRoll:SetHeight(25)
			SocRoll:SetText("Soc")
			SocRoll:SetAlpha(0.95)
			SocRoll:SetScript("OnClick",function()
				AbMod = Vers_Settings.SocMod
				AbType = "(Social)"
				AbTxt = "Social ("..Vers_Settings.SocMod..")"
				AbModTxt:SetText(AbTxt)
			end)	
			
			KnoRoll = CreateFrame("Button","KnoRoll",versrollbg,versbutton2)
			KnoRoll:SetFrameStrata("LOW")
			KnoRoll:SetPoint("LEFT",SocRoll,"RIGHT",0,0)
			KnoRoll:SetScale(0.75)
			KnoRoll:SetWidth(44)
			KnoRoll:SetHeight(25)
			KnoRoll:SetText("Kno")
			KnoRoll:SetAlpha(0.95)
			KnoRoll:SetScript("OnClick",function()
				AbMod = Vers_Settings.KnoMod
				AbType = "(Knowledge)"
				AbTxt = "Knowledge ("..Vers_Settings.KnoMod..")"
				AbModTxt:SetText(AbTxt)
			end)

			end
		end)

		versdm = CreateFrame("Button","versdm",versmenubg,versbutton1)
		versdm:SetFrameStrata("LOW")
		versdm:SetPoint("TOP","versroll","BOTTOM",0,0)
		versdm:SetScale(0.75)
		versdm:SetWidth(145)
		versdm:SetHeight(25)
		versdm:SetText("DM Tools")
		versdm:SetBackdropColor(0,0,0,0)
		versdm:SetAlpha(0.95)
		versdm:SetScript("PreClick",function()
			if versdmtog == "True" then
			versdmtog = "False" else
			versdmtog = "True" end
			end)
		versdm:SetScript("OnClick",function()
			if versdmbg then
			versdmbg:Hide()
			versdmbg = nil;
			else

			versdmbg = CreateFrame("Frame","versdmbg",versmenubg)
			versdmbg:SetFrameStrata("LOW")
			versdmbg:ClearAllPoints()
			versdmbg:SetBackdrop(Backdrop5)
			versdmbg:SetBackdropColor(0,0.19,0.46,1)
			versdmbg:SetHeight(253)
			versdmbg:SetWidth(310)
			versdmbg:SetAlpha(0.95)
			--versdmbg:SetPoint("BOTTOMRIGHT",versmenubg,"TOPRIGHT",0,0)
			versdmbg:SetScript("OnHide", function() versdmbg = nil end )
			versdmbg:SetScript("OnUpdate", function() if versdm == "Hide" then versdmbg:Hide() versdmbg = nil; end end)
			versdmbg:SetMovable(true)
			versdmbg:EnableMouse(true)
			if menuset == "False" then versdmbg:SetPoint("BOTTOMLEFT",versmenubg,"TOPLEFT",0,0) else versdmbg:SetPoint("CENTER",UIParent,"BOTTOMLEFT",Vers_Settings.versdmx,Vers_Settings.versdmy) end
			versdmbg:SetScript("OnUpdate", function() Vers_Settings.versdmx, Vers_Settings.versdmy = versdmbg:GetCenter() end)
			versdmbg:RegisterForDrag("LeftButton")
			versdmbg:SetScript("OnDragStart", versdmbg.StartMoving)
			versdmbg:SetScript("OnDragStop", versdmbg.StopMovingOrSizing)

				enem1input = CreateFrame("Button","enem1input",versdmbg,versbutton2)
				enem1input:SetFrameStrata("LOW")
				enem1input:SetNormalFontObject("GameFontWhiteSmall")
				enem1input:SetHighlightFontObject("GameFontHighlight")
				enem1input:SetPoint("TOPLEFT",versdmbg,15,-50)
				enem1input:SetScale(0.75)
				enem1input:SetWidth(180)
				enem1input:SetHeight(25)
				enem1input:SetText(Vers_Settings.VERSENEM1)
				enem1input:SetBackdropColor(0,0,0,0)
				enem1input:SetAlpha(0.95)
				enem1input:SetScript("PostClick", function() enem1input:Hide() end)
				enem1input:SetScript("OnClick",function()
					enem1box = CreateFrame("EditBox","enem1box",versdmbg,"InputBoxTemplate")
					enem1box:SetFrameStrata("LOW")
					enem1box:SetFontObject("CombatLogFont")
					enem1box:SetScale(0.75)
					enem1box:SetWidth(175)
					enem1box:SetHeight(25)
					enem1box:SetPoint("TOPLEFT",versdmbg,16,-51)
					enem1box:SetScript("OnEnterPressed",function()
						Vers_Settings.VERSENEM1 = enem1box:GetText()
						enem1box:Hide()
						enem1input:Show()
						enem1input:SetText(Vers_Settings.VERSENEM1)
						end)
					end)

				enemoffdc1input = CreateFrame("Button","enemoffdc1input",versdmbg,versbutton2)
				enemoffdc1input:SetFrameStrata("LOW")
				enemoffdc1input:SetPoint("LEFT",enem1input,"RIGHT",0,0)
				enemoffdc1input:SetScale(0.75)
				enemoffdc1input:SetWidth(35)
				enemoffdc1input:SetHeight(25)
				enemoffdc1input:SetText(Vers_Settings.VERSENEMOFFDC1)
				enemoffdc1input:SetBackdropColor(0,0,0,0)
				enemoffdc1input:SetAlpha(0.95)
				enemoffdc1input:SetScript("PostClick", function() enemoffdc1input:Hide()end)
				enemoffdc1input:SetScript("OnClick",function()
					enemoffdc1box = CreateFrame("EditBox","enemoffdc1box",versdmbg,"InputBoxTemplate")
					enemoffdc1box:SetFrameStrata("LOW")
					enemoffdc1box:SetFontObject("CombatLogFont")
					enemoffdc1box:SetScale(0.75)
					enemoffdc1box:SetWidth(30)
					enemoffdc1box:SetHeight(25)
					enemoffdc1box:SetPoint("LEFT",enem1input,"RIGHT",0,0)
					enemoffdc1box:SetScript("OnEnterPressed",function()
						Vers_Settings.VERSENEMOFFDC1 = enemoffdc1box:GetNumber()
						enemoffdc1box:Hide()
						enemoffdc1input:Show()
						enemoffdc1input:SetText(Vers_Settings.VERSENEMOFFDC1)
						end)
					end)

				enemdefdc1input = CreateFrame("Button","enemdefdc1input",versdmbg,versbutton2)
				enemdefdc1input:SetFrameStrata("LOW")
				enemdefdc1input:SetPoint("LEFT",enemoffdc1input,"RIGHT",0,0)
				enemdefdc1input:SetScale(0.75)
				enemdefdc1input:SetWidth(35)
				enemdefdc1input:SetHeight(25)
				enemdefdc1input:SetText(Vers_Settings.VERSENEMDEFDC1)
				enemdefdc1input:SetBackdropColor(0,0,0,0)
				enemdefdc1input:SetAlpha(0.95)
				enemdefdc1input:SetScript("PostClick", function() enemdefdc1input:Hide()end)
				enemdefdc1input:SetScript("OnClick",function()
					enemdefdc1box = CreateFrame("EditBox","enemdefdc1box",versdmbg,"InputBoxTemplate")
					enemdefdc1box:SetFrameStrata("LOW")
					enemdefdc1box:SetFontObject("CombatLogFont")
					enemdefdc1box:SetScale(0.75)
					enemdefdc1box:SetWidth(30)
					enemdefdc1box:SetHeight(25)
					enemdefdc1box:SetPoint("LEFT",enemoffdc1input,"RIGHT",0,0)
					enemdefdc1box:SetScript("OnEnterPressed",function()
						Vers_Settings.VERSENEMDEFDC1 = enemdefdc1box:GetNumber()
						enemdefdc1box:Hide()
						enemdefdc1input:Show()
						enemdefdc1input:SetText(Vers_Settings.VERSENEMDEFDC1)
						end)
					end)

				versenemhp1input = CreateFrame("Button","versenemhp1input",versdmbg,versbutton2)
				versenemhp1input:SetFrameStrata("LOW")
				versenemhp1input:SetPoint("LEFT",enemdefdc1input,"RIGHT",25,0)
				versenemhp1input:SetScale(0.75)
				versenemhp1input:SetWidth(30)
				versenemhp1input:SetHeight(25)
				versenemhp1input:SetText(Vers_Settings.VersEnemyHP1)
				versenemhp1input:SetBackdropColor(0,0,0,0)
				versenemhp1input:SetAlpha(0.95)
				versenemhp1input:SetScript("PostClick", function() versenemhp1input:Hide()end)
				versenemhp1input:SetScript("OnClick",function()
					versenemhp1box = CreateFrame("EditBox","versenemhp1box",versdmbg,"InputBoxTemplate")
					versenemhp1box:SetFrameStrata("LOW")
					versenemhp1box:SetFontObject("CombatLogFont")
					versenemhp1box:SetScale(0.75)
					versenemhp1box:SetWidth(30)
					versenemhp1box:SetHeight(25)
					versenemhp1box:SetPoint("LEFT",enemdefdc1input,"RIGHT",25,0)
					versenemhp1box:SetScript("OnEnterPressed",function()
						Vers_Settings.VersEnemyHP1 = versenemhp1box:GetNumber()
						versenemhp1box:Hide()
						versenemhp1input:Show()
						versenemhp1input:SetText(Vers_Settings.VersEnemyHP1)
						end)
					end)

				versenemhp1add = CreateFrame("Button","versenemhp1add",versdmbg,versbutton2)
				versenemhp1add:SetFrameStrata("LOW")
				versenemhp1add:SetPoint("LEFT",versenemhp1input,"RIGHT",-1,0)
				versenemhp1add:SetScale(0.72)
				versenemhp1add:SetWidth(25)
				versenemhp1add:SetHeight(25)
				versenemhp1add:SetText("+")
				versenemhp1add:SetBackdropColor(0,0,0,0)
				versenemhp1add:SetAlpha(0.95)
				versenemhp1add:SetScript("OnClick",function()
					versshiftdown = IsShiftKeyDown()
					if versshiftdown == true then Vers_Settings.VersEnemyHP1 = Vers_Settings.VersEnemyHP1 + 5 else
					Vers_Settings.VersEnemyHP1 = Vers_Settings.VersEnemyHP1 + 1 end
					versenemhp1input:SetText(Vers_Settings.VersEnemyHP1)
				end)

				versenemhp1sub = CreateFrame("Button","versenemhp1sub",versdmbg,versbutton2)
				versenemhp1sub:SetFrameStrata("LOW")
				versenemhp1sub:SetPoint("RIGHT",versenemhp1input,"LEFT",1,0)
				versenemhp1sub:SetScale(0.75)
				versenemhp1sub:SetWidth(25)
				versenemhp1sub:SetHeight(25)
				versenemhp1sub:SetText("-")
				versenemhp1sub:SetBackdropColor(0,0,0,0)
				versenemhp1sub:SetAlpha(0.95)
				versenemhp1sub:SetScript("OnClick",function()
					versshiftdown = IsShiftKeyDown()
					if versshiftdown == true then Vers_Settings.VersEnemyHP1 = Vers_Settings.VersEnemyHP1 - 5 else
					Vers_Settings.VersEnemyHP1 = Vers_Settings.VersEnemyHP1 - 1 end
					if Vers_Settings.VersEnemyHP1 < 0 then Vers_Settings.VersEnemyHP1 = 0 end
					versenemhp1input:SetText(Vers_Settings.VersEnemyHP1)
				end)

				versenemmaxhp1input = CreateFrame("Button","versenemmaxhp1input",versdmbg,versbutton2)
				versenemmaxhp1input:SetFrameStrata("LOW")
				versenemmaxhp1input:SetPoint("LEFT",versenemhp1add,"RIGHT",0,0)
				versenemmaxhp1input:SetScale(0.75)
				versenemmaxhp1input:SetWidth(30)
				versenemmaxhp1input:SetHeight(25)
				versenemmaxhp1input:SetText(Vers_Settings.VersEnemyMaxHP1)
				versenemmaxhp1input:SetBackdropColor(0,0,0,0)
				versenemmaxhp1input:SetAlpha(0.95)
				versenemmaxhp1input:SetScript("PostClick", function() versenemmaxhp1input:Hide()end)
				versenemmaxhp1input:SetScript("OnClick",function()
					versenemmaxhp1box = CreateFrame("EditBox","versenemmaxhp1box",versdmbg,"InputBoxTemplate")
					versenemmaxhp1box:SetFrameStrata("LOW")
					versenemmaxhp1box:SetFontObject("CombatLogFont")
					versenemmaxhp1box:SetScale(0.75)
					versenemmaxhp1box:SetWidth(30)
					versenemmaxhp1box:SetHeight(25)
					versenemmaxhp1box:SetPoint("LEFT",versenemhp1add,"RIGHT",0,0)
					versenemmaxhp1box:SetScript("OnEnterPressed",function()
						Vers_Settings.VersEnemyMaxHP1 = versenemmaxhp1box:GetNumber()
						versenemmaxhp1box:Hide()
						versenemmaxhp1input:Show()
						versenemmaxhp1input:SetText(Vers_Settings.VersEnemyMaxHP1)
						end)
					end)

				versenem1clear = CreateFrame("Button","versenem1clear",versdmbg,versbutton2)
				versenem1clear:SetFrameStrata("LOW")
				versenem1clear:SetPoint("LEFT",versenemmaxhp1input,"RIGHT",0,0)
				versenem1clear:SetScale(0.75)
				versenem1clear:SetWidth(25)
				versenem1clear:SetHeight(25)
				versenem1clear:SetText("X")
				versenem1clear:SetBackdropColor(0,0,0,0)
				versenem1clear:SetAlpha(0.95)
				versenem1clear:SetScript("OnClick",function()
					Vers_Settings.VERSENEM1 = ""
					Vers_Settings.VERSENEMOFFDC1 = 0
					Vers_Settings.VERSENEMDEFDC1 = 0
					Vers_Settings.VersEnemyHP1 = 0
					Vers_Settings.VersEnemyMaxHP1 = 0
					enem1input:SetText(Vers_Settings.VERSENEM1)
					enemoffdc1input:SetText(Vers_Settings.VERSENEMOFFDC1)
					enemdefdc1input:SetText(Vers_Settings.VERSENEMDEFDC1)
					versenemhp1input:SetText(Vers_Settings.VersEnemyHP1)
					versenemmaxhp1input:SetText(Vers_Settings.VersEnemyMaxHP1)
				end)

				DMENEM = versdmbg:CreateFontString(nil, "High", "GameTooltipText")
				DMENEM:SetPoint("BOTTOMLEFT","enem1input","TOPLEFT",2,0)
				DMENEM:SetText("Enemy Name:")
				DMENEM:SetFont("Fonts\\ARIALN.ttf", 9)
				
				DMDC = versdmbg:CreateFontString(nil, "High", "GameTooltipText")
				DMDC:SetPoint("BOTTOMRIGHT","enem1input","TOPRIGHT",-2,0)
				DMDC:SetText("DC to")
				DMDC:SetFont("Fonts\\ARIALN.ttf", 9)

				DMOFFDC = versdmbg:CreateFontString(nil, "High", "GameTooltipText")
				DMOFFDC:SetPoint("BOTTOM","enemoffdc1input","TOP",0,0)
				DMOFFDC:SetText("Hit:")
				DMOFFDC:SetFont("Fonts\\ARIALN.ttf", 9)

				DMDEFDC = versdmbg:CreateFontString(nil, "High", "GameTooltipText")
				DMDEFDC:SetPoint("BOTTOM","enemdefdc1input","TOP",0,0)
				DMDEFDC:SetText("Avoid:")
				DMDEFDC:SetFont("Fonts\\ARIALN.ttf", 9)

				DMCURHP = versdmbg:CreateFontString(nil, "High", "GameTooltipText")
				DMCURHP:SetPoint("BOTTOMLEFT","versenemhp1input","TOPLEFT",0,0)
				DMCURHP:SetText("Curr/Max HP:")
				DMCURHP:SetFont("Fonts\\ARIALN.ttf", 9)

				enem2input = CreateFrame("Button","enem2input",versdmbg,versbutton2)
				enem2input:SetFrameStrata("LOW")
				enem2input:SetNormalFontObject("GameFontWhiteSmall")
				enem2input:SetHighlightFontObject("GameFontHighlight")
				enem2input:SetPoint("TOP",enem1input,"BOTTOM",0,0)
				enem2input:SetScale(0.75)
				enem2input:SetWidth(180)
				enem2input:SetHeight(25)
				enem2input:SetText(Vers_Settings.VERSENEM2)
				enem2input:SetBackdropColor(0,0,0,0)
				enem2input:SetAlpha(0.95)
				enem2input:SetScript("PostClick", function() enem2input:Hide() end)
				enem2input:SetScript("OnClick",function()
					enem2box = CreateFrame("EditBox","enem2box",versdmbg,"InputBoxTemplate")
					enem2box:SetFrameStrata("LOW")
					enem2box:SetFontObject("CombatLogFont")
					enem2box:SetScale(0.75)
					enem2box:SetWidth(175)
					enem2box:SetHeight(25)
					enem2box:SetPoint("TOP",enem1input,"BOTTOM",0,0)
					enem2box:SetScript("OnEnterPressed",function()
						Vers_Settings.VERSENEM2 = enem2box:GetText()
						enem2box:Hide()
						enem2input:Show()
						enem2input:SetText(Vers_Settings.VERSENEM2)
						end)
					end)

				enemoffdc2input = CreateFrame("Button","enemoffdc2input",versdmbg,versbutton2)
				enemoffdc2input:SetFrameStrata("LOW")
				enemoffdc2input:SetPoint("LEFT",enem2input,"RIGHT",0,0)
				enemoffdc2input:SetScale(0.75)
				enemoffdc2input:SetWidth(35)
				enemoffdc2input:SetHeight(25)
				enemoffdc2input:SetText(Vers_Settings.VERSENEMOFFDC2)
				enemoffdc2input:SetBackdropColor(0,0,0,0)
				enemoffdc2input:SetAlpha(0.95)
				enemoffdc2input:SetScript("PostClick", function() enemoffdc2input:Hide()end)
				enemoffdc2input:SetScript("OnClick",function()
					enemoffdc2box = CreateFrame("EditBox","enemoffdc2box",versdmbg,"InputBoxTemplate")
					enemoffdc2box:SetFrameStrata("LOW")
					enemoffdc2box:SetFontObject("CombatLogFont")
					enemoffdc2box:SetScale(0.75)
					enemoffdc2box:SetWidth(30)
					enemoffdc2box:SetHeight(25)
					enemoffdc2box:SetPoint("LEFT",enem2input,"RIGHT",0,0)
					enemoffdc2box:SetScript("OnEnterPressed",function()
						Vers_Settings.VERSENEMOFFDC2 = enemoffdc2box:GetNumber()
						enemoffdc2box:Hide()
						enemoffdc2input:Show()
						enemoffdc2input:SetText(Vers_Settings.VERSENEMOFFDC2)
						end)
					end)

				enemdefdc2input = CreateFrame("Button","enemdefdc2input",versdmbg,versbutton2)
				enemdefdc2input:SetFrameStrata("LOW")
				enemdefdc2input:SetPoint("LEFT",enemoffdc2input,"RIGHT",0,0)
				enemdefdc2input:SetScale(0.75)
				enemdefdc2input:SetWidth(35)
				enemdefdc2input:SetHeight(25)
				enemdefdc2input:SetText(Vers_Settings.VERSENEMDEFDC2)
				enemdefdc2input:SetBackdropColor(0,0,0,0)
				enemdefdc2input:SetAlpha(0.95)
				enemdefdc2input:SetScript("PostClick", function() enemdefdc2input:Hide()end)
				enemdefdc2input:SetScript("OnClick",function()
					enemdefdc2box = CreateFrame("EditBox","enemdefdc2box",versdmbg,"InputBoxTemplate")
					enemdefdc2box:SetFrameStrata("LOW")
					enemdefdc2box:SetFontObject("CombatLogFont")
					enemdefdc2box:SetScale(0.75)
					enemdefdc2box:SetWidth(30)
					enemdefdc2box:SetHeight(25)
					enemdefdc2box:SetPoint("LEFT",enemoffdc2input,"RIGHT",0,0)
					enemdefdc2box:SetScript("OnEnterPressed",function()
						Vers_Settings.VERSENEMDEFDC2 = enemdefdc2box:GetNumber()
						enemdefdc2box:Hide()
						enemdefdc2input:Show()
						enemdefdc2input:SetText(Vers_Settings.VERSENEMDEFDC2)
						end)
					end)

				versenemhp2input = CreateFrame("Button","versenemhp2input",versdmbg,versbutton2)
				versenemhp2input:SetFrameStrata("LOW")
				versenemhp2input:SetPoint("LEFT",enemdefdc2input,"RIGHT",25,0)
				versenemhp2input:SetScale(0.75)
				versenemhp2input:SetWidth(30)
				versenemhp2input:SetHeight(25)
				versenemhp2input:SetText(Vers_Settings.VersEnemyHP2)
				versenemhp2input:SetBackdropColor(0,0,0,0)
				versenemhp2input:SetAlpha(0.95)
				versenemhp2input:SetScript("PostClick", function() versenemhp2input:Hide()end)
				versenemhp2input:SetScript("OnClick",function()
					versenemhp2box = CreateFrame("EditBox","versenemhp2box",versdmbg,"InputBoxTemplate")
					versenemhp2box:SetFrameStrata("LOW")
					versenemhp2box:SetFontObject("CombatLogFont")
					versenemhp2box:SetScale(0.75)
					versenemhp2box:SetWidth(30)
					versenemhp2box:SetHeight(25)
					versenemhp2box:SetPoint("LEFT",enemdefdc2input,"RIGHT",25,0)
					versenemhp2box:SetScript("OnEnterPressed",function()
						Vers_Settings.VersEnemyHP2 = versenemhp2box:GetNumber()
						versenemhp2box:Hide()
						versenemhp2input:Show()
						versenemhp2input:SetText(Vers_Settings.VersEnemyHP2)
						end)
					end)

				versenemhp2add = CreateFrame("Button","versenemhp2add",versdmbg,versbutton2)
				versenemhp2add:SetFrameStrata("LOW")
				versenemhp2add:SetPoint("LEFT",versenemhp2input,"RIGHT",-1,0)
				versenemhp2add:SetScale(0.72)
				versenemhp2add:SetWidth(25)
				versenemhp2add:SetHeight(25)
				versenemhp2add:SetText("+")
				versenemhp2add:SetBackdropColor(0,0,0,0)
				versenemhp2add:SetAlpha(0.95)
				versenemhp2add:SetScript("OnClick",function()
					versshiftdown = IsShiftKeyDown()
					if versshiftdown == true then Vers_Settings.VersEnemyHP2 = Vers_Settings.VersEnemyHP2 + 5 else
					Vers_Settings.VersEnemyHP2 = Vers_Settings.VersEnemyHP2 + 1 end
					versenemhp2input:SetText(Vers_Settings.VersEnemyHP2)
				end)

				versenemhp2sub = CreateFrame("Button","versenemhp2sub",versdmbg,versbutton2)
				versenemhp2sub:SetFrameStrata("LOW")
				versenemhp2sub:SetPoint("RIGHT",versenemhp2input,"LEFT",1,0)
				versenemhp2sub:SetScale(0.75)
				versenemhp2sub:SetWidth(25)
				versenemhp2sub:SetHeight(25)
				versenemhp2sub:SetText("-")
				versenemhp2sub:SetBackdropColor(0,0,0,0)
				versenemhp2sub:SetAlpha(0.95)
				versenemhp2sub:SetScript("OnClick",function()
					versshiftdown = IsShiftKeyDown()
					if versshiftdown == true then Vers_Settings.VersEnemyHP2 = Vers_Settings.VersEnemyHP2 - 5 else
					Vers_Settings.VersEnemyHP2 = Vers_Settings.VersEnemyHP2 - 1 end
					if Vers_Settings.VersEnemyHP2 < 0 then Vers_Settings.VersEnemyHP2 = 0 end
					versenemhp2input:SetText(Vers_Settings.VersEnemyHP2)
				end)

				versenemmaxhp2input = CreateFrame("Button","versenemmaxhp2input",versdmbg,versbutton2)
				versenemmaxhp2input:SetFrameStrata("LOW")
				versenemmaxhp2input:SetPoint("LEFT",versenemhp2add,"RIGHT",0,0)
				versenemmaxhp2input:SetScale(0.75)
				versenemmaxhp2input:SetWidth(30)
				versenemmaxhp2input:SetHeight(25)
				versenemmaxhp2input:SetText(Vers_Settings.VersEnemyMaxHP2)
				versenemmaxhp2input:SetBackdropColor(0,0,0,0)
				versenemmaxhp2input:SetAlpha(0.95)
				versenemmaxhp2input:SetScript("PostClick", function() versenemmaxhp2input:Hide()end)
				versenemmaxhp2input:SetScript("OnClick",function()
					versenemmaxhp2box = CreateFrame("EditBox","versenemmaxhp2box",versdmbg,"InputBoxTemplate")
					versenemmaxhp2box:SetFrameStrata("LOW")
					versenemmaxhp2box:SetFontObject("CombatLogFont")
					versenemmaxhp2box:SetScale(0.75)
					versenemmaxhp2box:SetWidth(30)
					versenemmaxhp2box:SetHeight(25)
					versenemmaxhp2box:SetPoint("LEFT",versenemhp2add,"RIGHT",0,0)
					versenemmaxhp2box:SetScript("OnEnterPressed",function()
						Vers_Settings.VersEnemyMaxHP2 = versenemmaxhp2box:GetNumber()
						versenemmaxhp2box:Hide()
						versenemmaxhp2input:Show()
						versenemmaxhp2input:SetText(Vers_Settings.VersEnemyMaxHP2)
						end)
					end)

				versenem2clear = CreateFrame("Button","versenem2clear",versdmbg,versbutton2)
				versenem2clear:SetFrameStrata("LOW")
				versenem2clear:SetPoint("LEFT",versenemmaxhp2input,"RIGHT",0,0)
				versenem2clear:SetScale(0.75)
				versenem2clear:SetWidth(25)
				versenem2clear:SetHeight(25)
				versenem2clear:SetText("X")
				versenem2clear:SetBackdropColor(0,0,0,0)
				versenem2clear:SetAlpha(0.95)
				versenem2clear:SetScript("OnClick",function()
					Vers_Settings.VERSENEM2 = ""
					Vers_Settings.VERSENEMOFFDC2 = 0
					Vers_Settings.VERSENEMDEFDC2 = 0
					Vers_Settings.VersEnemyHP2 = 0
					Vers_Settings.VersEnemyMaxHP2 = 0
					enem2input:SetText(Vers_Settings.VERSENEM2)
					enemoffdc2input:SetText(Vers_Settings.VERSENEMOFFDC2)
					enemdefdc2input:SetText(Vers_Settings.VERSENEMDEFDC2)
					versenemhp2input:SetText(Vers_Settings.VersEnemyHP2)
					versenemmaxhp2input:SetText(Vers_Settings.VersEnemyMaxHP2)
				end)

				enem3input = CreateFrame("Button","enem3input",versdmbg,versbutton2)
				enem3input:SetFrameStrata("LOW")
				enem3input:SetNormalFontObject("GameFontWhiteSmall")
				enem3input:SetHighlightFontObject("GameFontHighlight")
				enem3input:SetPoint("TOP",enem2input,"BOTTOM",0,0)
				enem3input:SetScale(0.75)
				enem3input:SetWidth(180)
				enem3input:SetHeight(25)
				enem3input:SetText(Vers_Settings.VERSENEM3)
				enem3input:SetBackdropColor(0,0,0,0)
				enem3input:SetAlpha(0.95)
				enem3input:SetScript("PostClick", function() enem3input:Hide() end)
				enem3input:SetScript("OnClick",function()
					enem3box = CreateFrame("EditBox","enem3box",versdmbg,"InputBoxTemplate")
					enem3box:SetFrameStrata("LOW")
					enem3box:SetFontObject("CombatLogFont")
					enem3box:SetScale(0.75)
					enem3box:SetWidth(175)
					enem3box:SetHeight(25)
					enem3box:SetPoint("TOP",enem2input,"BOTTOM",0,0)
					enem3box:SetScript("OnEnterPressed",function()
						Vers_Settings.VERSENEM3 = enem3box:GetText()
						enem3box:Hide()
						enem3input:Show()
						enem3input:SetText(Vers_Settings.VERSENEM3)
						end)
					end)

				enemoffdc3input = CreateFrame("Button","enemoffdc3input",versdmbg,versbutton2)
				enemoffdc3input:SetFrameStrata("LOW")
				enemoffdc3input:SetPoint("LEFT",enem3input,"RIGHT",0,0)
				enemoffdc3input:SetScale(0.75)
				enemoffdc3input:SetWidth(35)
				enemoffdc3input:SetHeight(25)
				enemoffdc3input:SetText(Vers_Settings.VERSENEMOFFDC3)
				enemoffdc3input:SetBackdropColor(0,0,0,0)
				enemoffdc3input:SetAlpha(0.95)
				enemoffdc3input:SetScript("PostClick", function() enemoffdc3input:Hide()end)
				enemoffdc3input:SetScript("OnClick",function()
					enemoffdc3box = CreateFrame("EditBox","enemoffdc3box",versdmbg,"InputBoxTemplate")
					enemoffdc3box:SetFrameStrata("LOW")
					enemoffdc3box:SetFontObject("CombatLogFont")
					enemoffdc3box:SetScale(0.75)
					enemoffdc3box:SetWidth(30)
					enemoffdc3box:SetHeight(25)
					enemoffdc3box:SetPoint("LEFT",enem3input,"RIGHT",0,0)
					enemoffdc3box:SetScript("OnEnterPressed",function()
						Vers_Settings.VERSENEMOFFDC3 = enemoffdc3box:GetNumber()
						enemoffdc3box:Hide()
						enemoffdc3input:Show()
						enemoffdc3input:SetText(Vers_Settings.VERSENEMOFFDC3)
						end)
					end)

				enemdefdc3input = CreateFrame("Button","enemdefdc3input",versdmbg,versbutton2)
				enemdefdc3input:SetFrameStrata("LOW")
				enemdefdc3input:SetPoint("LEFT",enemoffdc3input,"RIGHT",0,0)
				enemdefdc3input:SetScale(0.75)
				enemdefdc3input:SetWidth(35)
				enemdefdc3input:SetHeight(25)
				enemdefdc3input:SetText(Vers_Settings.VERSENEMDEFDC3)
				enemdefdc3input:SetBackdropColor(0,0,0,0)
				enemdefdc3input:SetAlpha(0.95)
				enemdefdc3input:SetScript("PostClick", function() enemdefdc3input:Hide()end)
				enemdefdc3input:SetScript("OnClick",function()
					enemdefdc3box = CreateFrame("EditBox","enemdefdc3box",versdmbg,"InputBoxTemplate")
					enemdefdc3box:SetFrameStrata("LOW")
					enemdefdc3box:SetFontObject("CombatLogFont")
					enemdefdc3box:SetScale(0.75)
					enemdefdc3box:SetWidth(30)
					enemdefdc3box:SetHeight(25)
					enemdefdc3box:SetPoint("LEFT",enemoffdc3input,"RIGHT",0,0)
					enemdefdc3box:SetScript("OnEnterPressed",function()
						Vers_Settings.VERSENEMDEFDC3 = enemdefdc3box:GetNumber()
						enemdefdc3box:Hide()
						enemdefdc3input:Show()
						enemdefdc3input:SetText(Vers_Settings.VERSENEMDEFDC3)
						end)
					end)

				versenemhp3input = CreateFrame("Button","versenemhp3input",versdmbg,versbutton2)
				versenemhp3input:SetFrameStrata("LOW")
				versenemhp3input:SetPoint("LEFT",enemdefdc3input,"RIGHT",25,0)
				versenemhp3input:SetScale(0.75)
				versenemhp3input:SetWidth(30)
				versenemhp3input:SetHeight(25)
				versenemhp3input:SetText(Vers_Settings.VersEnemyHP3)
				versenemhp3input:SetBackdropColor(0,0,0,0)
				versenemhp3input:SetAlpha(0.95)
				versenemhp3input:SetScript("PostClick", function() versenemhp3input:Hide()end)
				versenemhp3input:SetScript("OnClick",function()
					versenemhp3box = CreateFrame("EditBox","versenemhp3box",versdmbg,"InputBoxTemplate")
					versenemhp3box:SetFrameStrata("LOW")
					versenemhp3box:SetFontObject("CombatLogFont")
					versenemhp3box:SetScale(0.75)
					versenemhp3box:SetWidth(30)
					versenemhp3box:SetHeight(25)
					versenemhp3box:SetPoint("LEFT",enemdefdc3input,"RIGHT",25,0)
					versenemhp3box:SetScript("OnEnterPressed",function()
						Vers_Settings.VersEnemyHP3 = versenemhp3box:GetNumber()
						versenemhp3box:Hide()
						versenemhp3input:Show()
						versenemhp3input:SetText(Vers_Settings.VersEnemyHP3)
						end)
					end)

				versenemhp3add = CreateFrame("Button","versenemhp3add",versdmbg,versbutton2)
				versenemhp3add:SetFrameStrata("LOW")
				versenemhp3add:SetPoint("LEFT",versenemhp3input,"RIGHT",-1,0)
				versenemhp3add:SetScale(0.72)
				versenemhp3add:SetWidth(25)
				versenemhp3add:SetHeight(25)
				versenemhp3add:SetText("+")
				versenemhp3add:SetBackdropColor(0,0,0,0)
				versenemhp3add:SetAlpha(0.95)
				versenemhp3add:SetScript("OnClick",function()
					versshiftdown = IsShiftKeyDown()
					if versshiftdown == true then Vers_Settings.VersEnemyHP3 = Vers_Settings.VersEnemyHP3 + 5 else
					Vers_Settings.VersEnemyHP3 = Vers_Settings.VersEnemyHP3 + 1 end
					versenemhp3input:SetText(Vers_Settings.VersEnemyHP3)
				end)

				versenemhp3sub = CreateFrame("Button","versenemhp3sub",versdmbg,versbutton2)
				versenemhp3sub:SetFrameStrata("LOW")
				versenemhp3sub:SetPoint("RIGHT",versenemhp3input,"LEFT",1,0)
				versenemhp3sub:SetScale(0.75)
				versenemhp3sub:SetWidth(25)
				versenemhp3sub:SetHeight(25)
				versenemhp3sub:SetText("-")
				versenemhp3sub:SetBackdropColor(0,0,0,0)
				versenemhp3sub:SetAlpha(0.95)
				versenemhp3sub:SetScript("OnClick",function()
					versshiftdown = IsShiftKeyDown()
					if versshiftdown == true then Vers_Settings.VersEnemyHP3 = Vers_Settings.VersEnemyHP3 - 5 else
					Vers_Settings.VersEnemyHP3 = Vers_Settings.VersEnemyHP3 - 1 end
					if Vers_Settings.VersEnemyHP3 < 0 then Vers_Settings.VersEnemyHP3 = 0 end
					versenemhp3input:SetText(Vers_Settings.VersEnemyHP3)
				end)

				versenemmaxhp3input = CreateFrame("Button","versenemmaxhp3input",versdmbg,versbutton2)
				versenemmaxhp3input:SetFrameStrata("LOW")
				versenemmaxhp3input:SetPoint("LEFT",versenemhp3add,"RIGHT",0,0)
				versenemmaxhp3input:SetScale(0.75)
				versenemmaxhp3input:SetWidth(30)
				versenemmaxhp3input:SetHeight(25)
				versenemmaxhp3input:SetText(Vers_Settings.VersEnemyMaxHP3)
				versenemmaxhp3input:SetBackdropColor(0,0,0,0)
				versenemmaxhp3input:SetAlpha(0.95)
				versenemmaxhp3input:SetScript("PostClick", function() versenemmaxhp3input:Hide()end)
				versenemmaxhp3input:SetScript("OnClick",function()
					versenemmaxhp3box = CreateFrame("EditBox","versenemmaxhp3box",versdmbg,"InputBoxTemplate")
					versenemmaxhp3box:SetFrameStrata("LOW")
					versenemmaxhp3box:SetFontObject("CombatLogFont")
					versenemmaxhp3box:SetScale(0.75)
					versenemmaxhp3box:SetWidth(30)
					versenemmaxhp3box:SetHeight(25)
					versenemmaxhp3box:SetPoint("LEFT",versenemhp3add,"RIGHT",0,0)
					versenemmaxhp3box:SetScript("OnEnterPressed",function()
						Vers_Settings.VersEnemyMaxHP3 = versenemmaxhp3box:GetNumber()
						versenemmaxhp3box:Hide()
						versenemmaxhp3input:Show()
						versenemmaxhp3input:SetText(Vers_Settings.VersEnemyMaxHP3)
						end)
					end)

				versenem3clear = CreateFrame("Button","versenem3clear",versdmbg,versbutton2)
				versenem3clear:SetFrameStrata("LOW")
				versenem3clear:SetPoint("LEFT",versenemmaxhp3input,"RIGHT",0,0)
				versenem3clear:SetScale(0.75)
				versenem3clear:SetWidth(25)
				versenem3clear:SetHeight(25)
				versenem3clear:SetText("X")
				versenem3clear:SetBackdropColor(0,0,0,0)
				versenem3clear:SetAlpha(0.95)
				versenem3clear:SetScript("OnClick",function()
					Vers_Settings.VERSENEM3 = ""
					Vers_Settings.VERSENEMOFFDC3 = 0
					Vers_Settings.VERSENEMDEFDC3 = 0
					Vers_Settings.VersEnemyHP3 = 0
					Vers_Settings.VersEnemyMaxHP3 = 0
					enem3input:SetText(Vers_Settings.VERSENEM3)
					enemoffdc3input:SetText(Vers_Settings.VERSENEMOFFDC3)
					enemdefdc3input:SetText(Vers_Settings.VERSENEMDEFDC3)
					versenemhp3input:SetText(Vers_Settings.VersEnemyHP3)
					versenemmaxhp3input:SetText(Vers_Settings.VersEnemyMaxHP3)
				end)

				enem4input = CreateFrame("Button","enem4input",versdmbg,versbutton2)
				enem4input:SetFrameStrata("LOW")
				enem4input:SetNormalFontObject("GameFontWhiteSmall")
				enem4input:SetHighlightFontObject("GameFontHighlight")
				enem4input:SetPoint("TOP",enem3input,"BOTTOM",0,0)
				enem4input:SetScale(0.75)
				enem4input:SetWidth(180)
				enem4input:SetHeight(25)
				enem4input:SetText(Vers_Settings.VERSENEM4)
				enem4input:SetBackdropColor(0,0,0,0)
				enem4input:SetAlpha(0.95)
				enem4input:SetScript("PostClick", function() enem4input:Hide() end)
				enem4input:SetScript("OnClick",function()
					enem4box = CreateFrame("EditBox","enem4box",versdmbg,"InputBoxTemplate")
					enem4box:SetFrameStrata("LOW")
					enem4box:SetFontObject("CombatLogFont")
					enem4box:SetScale(0.75)
					enem4box:SetWidth(175)
					enem4box:SetHeight(25)
					enem4box:SetPoint("TOP",enem3input,"BOTTOM",0,0)
					enem4box:SetScript("OnEnterPressed",function()
						Vers_Settings.VERSENEM4 = enem4box:GetText()
						enem4box:Hide()
						enem4input:Show()
						enem4input:SetText(Vers_Settings.VERSENEM4)
						end)
					end)

				enemoffdc4input = CreateFrame("Button","enemoffdc4input",versdmbg,versbutton2)
				enemoffdc4input:SetFrameStrata("LOW")
				enemoffdc4input:SetPoint("LEFT",enem4input,"RIGHT",0,0)
				enemoffdc4input:SetScale(0.75)
				enemoffdc4input:SetWidth(35)
				enemoffdc4input:SetHeight(25)
				enemoffdc4input:SetText(Vers_Settings.VERSENEMOFFDC4)
				enemoffdc4input:SetBackdropColor(0,0,0,0)
				enemoffdc4input:SetAlpha(0.95)
				enemoffdc4input:SetScript("PostClick", function() enemoffdc4input:Hide()end)
				enemoffdc4input:SetScript("OnClick",function()
					enemoffdc4box = CreateFrame("EditBox","enemoffdc4box",versdmbg,"InputBoxTemplate")
					enemoffdc4box:SetFrameStrata("LOW")
					enemoffdc4box:SetFontObject("CombatLogFont")
					enemoffdc4box:SetScale(0.75)
					enemoffdc4box:SetWidth(30)
					enemoffdc4box:SetHeight(25)
					enemoffdc4box:SetPoint("LEFT",enem4input,"RIGHT",0,0)
					enemoffdc4box:SetScript("OnEnterPressed",function()
						Vers_Settings.VERSENEMOFFDC4 = enemoffdc4box:GetNumber()
						enemoffdc4box:Hide()
						enemoffdc4input:Show()
						enemoffdc4input:SetText(Vers_Settings.VERSENEMOFFDC4)
						end)
					end)

				enemdefdc4input = CreateFrame("Button","enemdefdc4input",versdmbg,versbutton2)
				enemdefdc4input:SetFrameStrata("LOW")
				enemdefdc4input:SetPoint("LEFT",enemoffdc4input,"RIGHT",0,0)
				enemdefdc4input:SetScale(0.75)
				enemdefdc4input:SetWidth(35)
				enemdefdc4input:SetHeight(25)
				enemdefdc4input:SetText(Vers_Settings.VERSENEMDEFDC4)
				enemdefdc4input:SetBackdropColor(0,0,0,0)
				enemdefdc4input:SetAlpha(0.95)
				enemdefdc4input:SetScript("PostClick", function() enemdefdc4input:Hide()end)
				enemdefdc4input:SetScript("OnClick",function()
					enemdefdc4box = CreateFrame("EditBox","enemdefdc4box",versdmbg,"InputBoxTemplate")
					enemdefdc4box:SetFrameStrata("LOW")
					enemdefdc4box:SetFontObject("CombatLogFont")
					enemdefdc4box:SetScale(0.75)
					enemdefdc4box:SetWidth(30)
					enemdefdc4box:SetHeight(25)
					enemdefdc4box:SetPoint("LEFT",enemoffdc4input,"RIGHT",0,0)
					enemdefdc4box:SetScript("OnEnterPressed",function()
						Vers_Settings.VERSENEMDEFDC4 = enemdefdc4box:GetNumber()
						enemdefdc4box:Hide()
						enemdefdc4input:Show()
						enemdefdc4input:SetText(Vers_Settings.VERSENEMDEFDC4)
						end)
					end)

				versenemhp4input = CreateFrame("Button","versenemhp4input",versdmbg,versbutton2)
				versenemhp4input:SetFrameStrata("LOW")
				versenemhp4input:SetPoint("LEFT",enemdefdc4input,"RIGHT",25,0)
				versenemhp4input:SetScale(0.75)
				versenemhp4input:SetWidth(30)
				versenemhp4input:SetHeight(25)
				versenemhp4input:SetText(Vers_Settings.VersEnemyHP4)
				versenemhp4input:SetBackdropColor(0,0,0,0)
				versenemhp4input:SetAlpha(0.95)
				versenemhp4input:SetScript("PostClick", function() versenemhp4input:Hide()end)
				versenemhp4input:SetScript("OnClick",function()
					versenemhp4box = CreateFrame("EditBox","versenemhp4box",versdmbg,"InputBoxTemplate")
					versenemhp4box:SetFrameStrata("LOW")
					versenemhp4box:SetFontObject("CombatLogFont")
					versenemhp4box:SetScale(0.75)
					versenemhp4box:SetWidth(30)
					versenemhp4box:SetHeight(25)
					versenemhp4box:SetPoint("LEFT",enemdefdc4input,"RIGHT",25,0)
					versenemhp4box:SetScript("OnEnterPressed",function()
						Vers_Settings.VersEnemyHP4 = versenemhp4box:GetNumber()
						versenemhp4box:Hide()
						versenemhp4input:Show()
						versenemhp4input:SetText(Vers_Settings.VersEnemyHP4)
						end)
					end)

				versenemhp4add = CreateFrame("Button","versenemhp4add",versdmbg,versbutton2)
				versenemhp4add:SetFrameStrata("LOW")
				versenemhp4add:SetPoint("LEFT",versenemhp4input,"RIGHT",-1,0)
				versenemhp4add:SetScale(0.72)
				versenemhp4add:SetWidth(25)
				versenemhp4add:SetHeight(25)
				versenemhp4add:SetText("+")
				versenemhp4add:SetBackdropColor(0,0,0,0)
				versenemhp4add:SetAlpha(0.95)
				versenemhp4add:SetScript("OnClick",function()
					versshiftdown = IsShiftKeyDown()
					if versshiftdown == true then Vers_Settings.VersEnemyHP4 = Vers_Settings.VersEnemyHP4 + 5 else
					Vers_Settings.VersEnemyHP4 = Vers_Settings.VersEnemyHP4 + 1 end
					versenemhp4input:SetText(Vers_Settings.VersEnemyHP4)
				end)

				versenemhp4sub = CreateFrame("Button","versenemhp4sub",versdmbg,versbutton2)
				versenemhp4sub:SetFrameStrata("LOW")
				versenemhp4sub:SetPoint("RIGHT",versenemhp4input,"LEFT",1,0)
				versenemhp4sub:SetScale(0.75)
				versenemhp4sub:SetWidth(25)
				versenemhp4sub:SetHeight(25)
				versenemhp4sub:SetText("-")
				versenemhp4sub:SetBackdropColor(0,0,0,0)
				versenemhp4sub:SetAlpha(0.95)
				versenemhp4sub:SetScript("OnClick",function()
					versshiftdown = IsShiftKeyDown()
					if versshiftdown == true then Vers_Settings.VersEnemyHP4 = Vers_Settings.VersEnemyHP4 - 5 else
					Vers_Settings.VersEnemyHP4 = Vers_Settings.VersEnemyHP4 - 1 end
					if Vers_Settings.VersEnemyHP4 < 0 then Vers_Settings.VersEnemyHP4 = 0 end
					versenemhp4input:SetText(Vers_Settings.VersEnemyHP4)
				end)

				versenemmaxhp4input = CreateFrame("Button","versenemmaxhp4input",versdmbg,versbutton2)
				versenemmaxhp4input:SetFrameStrata("LOW")
				versenemmaxhp4input:SetPoint("LEFT",versenemhp4add,"RIGHT",0,0)
				versenemmaxhp4input:SetScale(0.75)
				versenemmaxhp4input:SetWidth(30)
				versenemmaxhp4input:SetHeight(25)
				versenemmaxhp4input:SetText(Vers_Settings.VersEnemyMaxHP4)
				versenemmaxhp4input:SetBackdropColor(0,0,0,0)
				versenemmaxhp4input:SetAlpha(0.95)
				versenemmaxhp4input:SetScript("PostClick", function() versenemmaxhp4input:Hide()end)
				versenemmaxhp4input:SetScript("OnClick",function()
					versenemmaxhp4box = CreateFrame("EditBox","versenemmaxhp4box",versdmbg,"InputBoxTemplate")
					versenemmaxhp4box:SetFrameStrata("LOW")
					versenemmaxhp4box:SetFontObject("CombatLogFont")
					versenemmaxhp4box:SetScale(0.75)
					versenemmaxhp4box:SetWidth(30)
					versenemmaxhp4box:SetHeight(25)
					versenemmaxhp4box:SetPoint("LEFT",versenemhp4add,"RIGHT",0,0)
					versenemmaxhp4box:SetScript("OnEnterPressed",function()
						Vers_Settings.VersEnemyMaxHP4 = versenemmaxhp4box:GetNumber()
						versenemmaxhp4box:Hide()
						versenemmaxhp4input:Show()
						versenemmaxhp4input:SetText(Vers_Settings.VersEnemyMaxHP4)
						end)
					end)

				versenem4clear = CreateFrame("Button","versenem4clear",versdmbg,versbutton2)
				versenem4clear:SetFrameStrata("LOW")
				versenem4clear:SetPoint("LEFT",versenemmaxhp4input,"RIGHT",0,0)
				versenem4clear:SetScale(0.75)
				versenem4clear:SetWidth(25)
				versenem4clear:SetHeight(25)
				versenem4clear:SetText("X")
				versenem4clear:SetBackdropColor(0,0,0,0)
				versenem4clear:SetAlpha(0.95)
				versenem4clear:SetScript("OnClick",function()
					Vers_Settings.VERSENEM4 = ""
					Vers_Settings.VERSENEMOFFDC4 = 0
					Vers_Settings.VERSENEMDEFDC4 = 0
					Vers_Settings.VersEnemyHP4 = 0
					Vers_Settings.VersEnemyMaxHP4 = 0
					enem4input:SetText(Vers_Settings.VERSENEM4)
					enemoffdc4input:SetText(Vers_Settings.VERSENEMOFFDC4)
					enemdefdc4input:SetText(Vers_Settings.VERSENEMDEFDC4)
					versenemhp4input:SetText(Vers_Settings.VersEnemyHP4)
					versenemmaxhp4input:SetText(Vers_Settings.VersEnemyMaxHP4)
				end)

				enem5input = CreateFrame("Button","enem5input",versdmbg,versbutton2)
				enem5input:SetFrameStrata("LOW")
				enem5input:SetNormalFontObject("GameFontWhiteSmall")
				enem5input:SetHighlightFontObject("GameFontHighlight")
				enem5input:SetPoint("TOP",enem4input,"BOTTOM",0,0)
				enem5input:SetScale(0.75)
				enem5input:SetWidth(180)
				enem5input:SetHeight(25)
				enem5input:SetText(Vers_Settings.VERSENEM5)
				enem5input:SetBackdropColor(0,0,0,0)
				enem5input:SetAlpha(0.95)
				enem5input:SetScript("PostClick", function() enem5input:Hide() end)
				enem5input:SetScript("OnClick",function()
					enem5box = CreateFrame("EditBox","enem5box",versdmbg,"InputBoxTemplate")
					enem5box:SetFrameStrata("LOW")
					enem5box:SetFontObject("CombatLogFont")
					enem5box:SetScale(0.75)
					enem5box:SetWidth(175)
					enem5box:SetHeight(25)
					enem5box:SetPoint("TOP",enem4input,"BOTTOM",0,0)
					enem5box:SetScript("OnEnterPressed",function()
						Vers_Settings.VERSENEM5 = enem5box:GetText()
						enem5box:Hide()
						enem5input:Show()
						enem5input:SetText(Vers_Settings.VERSENEM5)
						end)
					end)

				enemoffdc5input = CreateFrame("Button","enemoffdc5input",versdmbg,versbutton2)
				enemoffdc5input:SetFrameStrata("LOW")
				enemoffdc5input:SetPoint("LEFT",enem5input,"RIGHT",0,0)
				enemoffdc5input:SetScale(0.75)
				enemoffdc5input:SetWidth(35)
				enemoffdc5input:SetHeight(25)
				enemoffdc5input:SetText(Vers_Settings.VERSENEMOFFDC5)
				enemoffdc5input:SetBackdropColor(0,0,0,0)
				enemoffdc5input:SetAlpha(0.95)
				enemoffdc5input:SetScript("PostClick", function() enemoffdc5input:Hide()end)
				enemoffdc5input:SetScript("OnClick",function()
					enemoffdc5box = CreateFrame("EditBox","enemoffdc5box",versdmbg,"InputBoxTemplate")
					enemoffdc5box:SetFrameStrata("LOW")
					enemoffdc5box:SetFontObject("CombatLogFont")
					enemoffdc5box:SetScale(0.75)
					enemoffdc5box:SetWidth(30)
					enemoffdc5box:SetHeight(25)
					enemoffdc5box:SetPoint("LEFT",enem5input,"RIGHT",0,0)
					enemoffdc5box:SetScript("OnEnterPressed",function()
						Vers_Settings.VERSENEMOFFDC5 = enemoffdc5box:GetNumber()
						enemoffdc5box:Hide()
						enemoffdc5input:Show()
						enemoffdc5input:SetText(Vers_Settings.VERSENEMOFFDC5)
						end)
					end)

				enemdefdc5input = CreateFrame("Button","enemdefdc5input",versdmbg,versbutton2)
				enemdefdc5input:SetFrameStrata("LOW")
				enemdefdc5input:SetPoint("LEFT",enemoffdc5input,"RIGHT",0,0)
				enemdefdc5input:SetScale(0.75)
				enemdefdc5input:SetWidth(35)
				enemdefdc5input:SetHeight(25)
				enemdefdc5input:SetText(Vers_Settings.VERSENEMDEFDC5)
				enemdefdc5input:SetBackdropColor(0,0,0,0)
				enemdefdc5input:SetAlpha(0.95)
				enemdefdc5input:SetScript("PostClick", function() enemdefdc5input:Hide()end)
				enemdefdc5input:SetScript("OnClick",function()
					enemdefdc5box = CreateFrame("EditBox","enemdefdc5box",versdmbg,"InputBoxTemplate")
					enemdefdc5box:SetFrameStrata("LOW")
					enemdefdc5box:SetFontObject("CombatLogFont")
					enemdefdc5box:SetScale(0.75)
					enemdefdc5box:SetWidth(30)
					enemdefdc5box:SetHeight(25)
					enemdefdc5box:SetPoint("LEFT",enemoffdc5input,"RIGHT",0,0)
					enemdefdc5box:SetScript("OnEnterPressed",function()
						Vers_Settings.VERSENEMDEFDC5 = enemdefdc5box:GetNumber()
						enemdefdc5box:Hide()
						enemdefdc5input:Show()
						enemdefdc5input:SetText(Vers_Settings.VERSENEMDEFDC5)
						end)
					end)

				versenemhp5input = CreateFrame("Button","versenemhp5input",versdmbg,versbutton2)
				versenemhp5input:SetFrameStrata("LOW")
				versenemhp5input:SetPoint("LEFT",enemdefdc5input,"RIGHT",25,0)
				versenemhp5input:SetScale(0.75)
				versenemhp5input:SetWidth(30)
				versenemhp5input:SetHeight(25)
				versenemhp5input:SetText(Vers_Settings.VersEnemyHP5)
				versenemhp5input:SetBackdropColor(0,0,0,0)
				versenemhp5input:SetAlpha(0.95)
				versenemhp5input:SetScript("PostClick", function() versenemhp5input:Hide()end)
				versenemhp5input:SetScript("OnClick",function()
					versenemhp5box = CreateFrame("EditBox","versenemhp5box",versdmbg,"InputBoxTemplate")
					versenemhp5box:SetFrameStrata("LOW")
					versenemhp5box:SetFontObject("CombatLogFont")
					versenemhp5box:SetScale(0.75)
					versenemhp5box:SetWidth(30)
					versenemhp5box:SetHeight(25)
					versenemhp5box:SetPoint("LEFT",enemdefdc5input,"RIGHT",27,0)
					versenemhp5box:SetScript("OnEnterPressed",function()
						Vers_Settings.VersEnemyHP5 = versenemhp5box:GetNumber()
						versenemhp5box:Hide()
						versenemhp5input:Show()
						versenemhp5input:SetText(Vers_Settings.VersEnemyHP5)
						end)
					end)

				versenemhp5add = CreateFrame("Button","versenemhp5add",versdmbg,versbutton2)
				versenemhp5add:SetFrameStrata("LOW")
				versenemhp5add:SetPoint("LEFT",versenemhp5input,"RIGHT",-1,0)
				versenemhp5add:SetScale(0.72)
				versenemhp5add:SetWidth(25)
				versenemhp5add:SetHeight(25)
				versenemhp5add:SetText("+")
				versenemhp5add:SetBackdropColor(0,0,0,0)
				versenemhp5add:SetAlpha(0.95)
				versenemhp5add:SetScript("OnClick",function()
					versshiftdown = IsShiftKeyDown()
					if versshiftdown == true then Vers_Settings.VersEnemyHP5 = Vers_Settings.VersEnemyHP5 + 5 else
					Vers_Settings.VersEnemyHP5 = Vers_Settings.VersEnemyHP5 + 1 end
					versenemhp5input:SetText(Vers_Settings.VersEnemyHP5)
				end)

				versenemhp5sub = CreateFrame("Button","versenemhp5sub",versdmbg,versbutton2)
				versenemhp5sub:SetFrameStrata("LOW")
				versenemhp5sub:SetPoint("RIGHT",versenemhp5input,"LEFT",1,0)
				versenemhp5sub:SetScale(0.75)
				versenemhp5sub:SetWidth(25)
				versenemhp5sub:SetHeight(25)
				versenemhp5sub:SetText("-")
				versenemhp5sub:SetBackdropColor(0,0,0,0)
				versenemhp5sub:SetAlpha(0.95)
				versenemhp5sub:SetScript("OnClick",function()
					versshiftdown = IsShiftKeyDown()
					if versshiftdown == true then Vers_Settings.VersEnemyHP5 = Vers_Settings.VersEnemyHP5 - 5 else
					Vers_Settings.VersEnemyHP5 = Vers_Settings.VersEnemyHP5 - 1 end
					if Vers_Settings.VersEnemyHP5 < 0 then Vers_Settings.VersEnemyHP5 = 0 end
					versenemhp5input:SetText(Vers_Settings.VersEnemyHP5)
				end)

				versenemmaxhp5input = CreateFrame("Button","versenemmaxhp5input",versdmbg,versbutton2)
				versenemmaxhp5input:SetFrameStrata("LOW")
				versenemmaxhp5input:SetPoint("LEFT",versenemhp5add,"RIGHT",0,0)
				versenemmaxhp5input:SetScale(0.75)
				versenemmaxhp5input:SetWidth(30)
				versenemmaxhp5input:SetHeight(25)
				versenemmaxhp5input:SetText(Vers_Settings.VersEnemyMaxHP5)
				versenemmaxhp5input:SetBackdropColor(0,0,0,0)
				versenemmaxhp5input:SetAlpha(0.95)
				versenemmaxhp5input:SetScript("PostClick", function() versenemmaxhp5input:Hide()end)
				versenemmaxhp5input:SetScript("OnClick",function()
					versenemmaxhp5box = CreateFrame("EditBox","versenemmaxhp5box",versdmbg,"InputBoxTemplate")
					versenemmaxhp5box:SetFrameStrata("LOW")
					versenemmaxhp5box:SetFontObject("CombatLogFont")
					versenemmaxhp5box:SetScale(0.75)
					versenemmaxhp5box:SetWidth(30)
					versenemmaxhp5box:SetHeight(25)
					versenemmaxhp5box:SetPoint("LEFT",versenemhp5add,"RIGHT",0,0)
					versenemmaxhp5box:SetScript("OnEnterPressed",function()
						Vers_Settings.VersEnemyMaxHP5 = versenemmaxhp5box:GetNumber()
						versenemmaxhp5box:Hide()
						versenemmaxhp5input:Show()
						versenemmaxhp5input:SetText(Vers_Settings.VersEnemyMaxHP5)
						end)
					end)

				versenem5clear = CreateFrame("Button","versenem5clear",versdmbg,versbutton2)
				versenem5clear:SetFrameStrata("LOW")
				versenem5clear:SetPoint("LEFT",versenemmaxhp5input,"RIGHT",0,0)
				versenem5clear:SetScale(0.75)
				versenem5clear:SetWidth(25)
				versenem5clear:SetHeight(25)
				versenem5clear:SetText("X")
				versenem5clear:SetBackdropColor(0,0,0,0)
				versenem5clear:SetAlpha(0.95)
				versenem5clear:SetScript("OnClick",function()
					Vers_Settings.VERSENEM5 = ""
					Vers_Settings.VERSENEMOFFDC5 = 0
					Vers_Settings.VERSENEMDEFDC5 = 0
					Vers_Settings.VersEnemyHP5 = 0
					Vers_Settings.VersEnemyMaxHP5 = 0
					enem5input:SetText(Vers_Settings.VERSENEM5)
					enemoffdc5input:SetText(Vers_Settings.VERSENEMOFFDC5)
					enemdefdc5input:SetText(Vers_Settings.VERSENEMDEFDC5)
					versenemhp5input:SetText(Vers_Settings.VersEnemyHP5)
					versenemmaxhp5input:SetText(Vers_Settings.VersEnemyMaxHP5)
				end)

				enem6input = CreateFrame("Button","enem6input",versdmbg,versbutton2)
				enem6input:SetFrameStrata("LOW")
				enem6input:SetNormalFontObject("GameFontWhiteSmall")
				enem6input:SetHighlightFontObject("GameFontHighlight")
				enem6input:SetPoint("TOP",enem5input,"BOTTOM",0,0)
				enem6input:SetScale(0.75)
				enem6input:SetWidth(180)
				enem6input:SetHeight(25)
				enem6input:SetText(Vers_Settings.VERSENEM6)
				enem6input:SetBackdropColor(0,0,0,0)
				enem6input:SetAlpha(0.95)
				enem6input:SetScript("PostClick", function() enem6input:Hide() end)
				enem6input:SetScript("OnClick",function()
					enem6box = CreateFrame("EditBox","enem6box",versdmbg,"InputBoxTemplate")
					enem6box:SetFrameStrata("LOW")
					enem6box:SetFontObject("CombatLogFont")
					enem6box:SetScale(0.75)
					enem6box:SetWidth(175)
					enem6box:SetHeight(25)
					enem6box:SetPoint("TOP",enem5input,"BOTTOM",0,0)
					enem6box:SetScript("OnEnterPressed",function()
						Vers_Settings.VERSENEM6 = enem6box:GetText()
						enem6box:Hide()
						enem6input:Show()
						enem6input:SetText(Vers_Settings.VERSENEM6)
						end)
					end)

				enemoffdc6input = CreateFrame("Button","enemoffdc6input",versdmbg,versbutton2)
				enemoffdc6input:SetFrameStrata("LOW")
				enemoffdc6input:SetPoint("LEFT",enem6input,"RIGHT",0,0)
				enemoffdc6input:SetScale(0.75)
				enemoffdc6input:SetWidth(35)
				enemoffdc6input:SetHeight(25)
				enemoffdc6input:SetText(Vers_Settings.VERSENEMOFFDC6)
				enemoffdc6input:SetBackdropColor(0,0,0,0)
				enemoffdc6input:SetAlpha(0.95)
				enemoffdc6input:SetScript("PostClick", function() enemoffdc6input:Hide()end)
				enemoffdc6input:SetScript("OnClick",function()
					enemoffdc6box = CreateFrame("EditBox","enemoffdc6box",versdmbg,"InputBoxTemplate")
					enemoffdc6box:SetFrameStrata("LOW")
					enemoffdc6box:SetFontObject("CombatLogFont")
					enemoffdc6box:SetScale(0.75)
					enemoffdc6box:SetWidth(30)
					enemoffdc6box:SetHeight(25)
					enemoffdc6box:SetPoint("LEFT",enem6input,"RIGHT",0,0)
					enemoffdc6box:SetScript("OnEnterPressed",function()
						Vers_Settings.VERSENEMOFFDC6 = enemoffdc6box:GetNumber()
						enemoffdc6box:Hide()
						enemoffdc6input:Show()
						enemoffdc6input:SetText(Vers_Settings.VERSENEMOFFDC6)
						end)
					end)

				enemdefdc6input = CreateFrame("Button","enemdefdc6input",versdmbg,versbutton2)
				enemdefdc6input:SetFrameStrata("LOW")
				enemdefdc6input:SetPoint("LEFT",enemoffdc6input,"RIGHT",0,0)
				enemdefdc6input:SetScale(0.75)
				enemdefdc6input:SetWidth(35)
				enemdefdc6input:SetHeight(25)
				enemdefdc6input:SetText(Vers_Settings.VERSENEMDEFDC6)
				enemdefdc6input:SetBackdropColor(0,0,0,0)
				enemdefdc6input:SetAlpha(0.95)
				enemdefdc6input:SetScript("PostClick", function() enemdefdc6input:Hide()end)
				enemdefdc6input:SetScript("OnClick",function()
					enemdefdc6box = CreateFrame("EditBox","enemdefdc6box",versdmbg,"InputBoxTemplate")
					enemdefdc6box:SetFrameStrata("LOW")
					enemdefdc6box:SetFontObject("CombatLogFont")
					enemdefdc6box:SetScale(0.75)
					enemdefdc6box:SetWidth(30)
					enemdefdc6box:SetHeight(25)
					enemdefdc6box:SetPoint("LEFT",enemoffdc6input,"RIGHT",0,0)
					enemdefdc6box:SetScript("OnEnterPressed",function()
						Vers_Settings.VERSENEMDEFDC6 = enemdefdc6box:GetNumber()
						enemdefdc6box:Hide()
						enemdefdc6input:Show()
						enemdefdc6input:SetText(Vers_Settings.VERSENEMDEFDC6)
						end)
					end)

				versenemhp6input = CreateFrame("Button","versenemhp6input",versdmbg,versbutton2)
				versenemhp6input:SetFrameStrata("LOW")
				versenemhp6input:SetPoint("LEFT",enemdefdc6input,"RIGHT",25,0)
				versenemhp6input:SetScale(0.75)
				versenemhp6input:SetWidth(30)
				versenemhp6input:SetHeight(25)
				versenemhp6input:SetText(Vers_Settings.VersEnemyHP6)
				versenemhp6input:SetBackdropColor(0,0,0,0)
				versenemhp6input:SetAlpha(0.95)
				versenemhp6input:SetScript("PostClick", function() versenemhp6input:Hide()end)
				versenemhp6input:SetScript("OnClick",function()
					versenemhp6box = CreateFrame("EditBox","versenemhp6box",versdmbg,"InputBoxTemplate")
					versenemhp6box:SetFrameStrata("LOW")
					versenemhp6box:SetFontObject("CombatLogFont")
					versenemhp6box:SetScale(0.75)
					versenemhp6box:SetWidth(30)
					versenemhp6box:SetHeight(25)
					versenemhp6box:SetPoint("LEFT",enemdefdc6input,"RIGHT",27,0)
					versenemhp6box:SetScript("OnEnterPressed",function()
						Vers_Settings.VersEnemyHP6 = versenemhp6box:GetNumber()
						versenemhp6box:Hide()
						versenemhp6input:Show()
						versenemhp6input:SetText(Vers_Settings.VersEnemyHP6)
						end)
					end)

				versenemhp6add = CreateFrame("Button","versenemhp6add",versdmbg,versbutton2)
				versenemhp6add:SetFrameStrata("LOW")
				versenemhp6add:SetPoint("LEFT",versenemhp6input,"RIGHT",-1,0)
				versenemhp6add:SetScale(0.72)
				versenemhp6add:SetWidth(25)
				versenemhp6add:SetHeight(25)
				versenemhp6add:SetText("+")
				versenemhp6add:SetBackdropColor(0,0,0,0)
				versenemhp6add:SetAlpha(0.95)
				versenemhp6add:SetScript("OnClick",function()
					versshiftdown = IsShiftKeyDown()
					if versshiftdown == true then Vers_Settings.VersEnemyHP6 = Vers_Settings.VersEnemyHP6 + 5 else
					Vers_Settings.VersEnemyHP6 = Vers_Settings.VersEnemyHP6 + 1 end
					versenemhp6input:SetText(Vers_Settings.VersEnemyHP6)
				end)

				versenemhp6sub = CreateFrame("Button","versenemhp6sub",versdmbg,versbutton2)
				versenemhp6sub:SetFrameStrata("LOW")
				versenemhp6sub:SetPoint("RIGHT",versenemhp6input,"LEFT",1,0)
				versenemhp6sub:SetScale(0.75)
				versenemhp6sub:SetWidth(25)
				versenemhp6sub:SetHeight(25)
				versenemhp6sub:SetText("-")
				versenemhp6sub:SetBackdropColor(0,0,0,0)
				versenemhp6sub:SetAlpha(0.95)
				versenemhp6sub:SetScript("OnClick",function()
					versshiftdown = IsShiftKeyDown()
					if versshiftdown == true then Vers_Settings.VersEnemyHP6 = Vers_Settings.VersEnemyHP6 - 5 else
					Vers_Settings.VersEnemyHP6 = Vers_Settings.VersEnemyHP6 - 1 end
					if Vers_Settings.VersEnemyHP6 < 0 then Vers_Settings.VersEnemyHP6 = 0 end
					versenemhp6input:SetText(Vers_Settings.VersEnemyHP6)
				end)

				versenemmaxhp6input = CreateFrame("Button","versenemmaxhp6input",versdmbg,versbutton2)
				versenemmaxhp6input:SetFrameStrata("LOW")
				versenemmaxhp6input:SetPoint("LEFT",versenemhp6add,"RIGHT",0,0)
				versenemmaxhp6input:SetScale(0.75)
				versenemmaxhp6input:SetWidth(30)
				versenemmaxhp6input:SetHeight(25)
				versenemmaxhp6input:SetText(Vers_Settings.VersEnemyMaxHP6)
				versenemmaxhp6input:SetBackdropColor(0,0,0,0)
				versenemmaxhp6input:SetAlpha(0.95)
				versenemmaxhp6input:SetScript("PostClick", function() versenemmaxhp6input:Hide()end)
				versenemmaxhp6input:SetScript("OnClick",function()
					versenemmaxhp6box = CreateFrame("EditBox","versenemmaxhp6box",versdmbg,"InputBoxTemplate")
					versenemmaxhp6box:SetFrameStrata("LOW")
					versenemmaxhp6box:SetFontObject("CombatLogFont")
					versenemmaxhp6box:SetScale(0.75)
					versenemmaxhp6box:SetWidth(30)
					versenemmaxhp6box:SetHeight(25)
					versenemmaxhp6box:SetPoint("LEFT",versenemhp6add,"RIGHT",0,0)
					versenemmaxhp6box:SetScript("OnEnterPressed",function()
						Vers_Settings.VersEnemyMaxHP6 = versenemmaxhp6box:GetNumber()
						versenemmaxhp6box:Hide()
						versenemmaxhp6input:Show()
						versenemmaxhp6input:SetText(Vers_Settings.VersEnemyMaxHP6)
						end)
					end)

				versenem6clear = CreateFrame("Button","versenem6clear",versdmbg,versbutton2)
				versenem6clear:SetFrameStrata("LOW")
				versenem6clear:SetPoint("LEFT",versenemmaxhp6input,"RIGHT",0,0)
				versenem6clear:SetScale(0.75)
				versenem6clear:SetWidth(25)
				versenem6clear:SetHeight(25)
				versenem6clear:SetText("X")
				versenem6clear:SetBackdropColor(0,0,0,0)
				versenem6clear:SetAlpha(0.96)
				versenem6clear:SetScript("OnClick",function()
					Vers_Settings.VERSENEM6 = ""
					Vers_Settings.VERSENEMOFFDC6 = 0
					Vers_Settings.VERSENEMDEFDC6 = 0
					Vers_Settings.VersEnemyHP6 = 0
					Vers_Settings.VersEnemyMaxHP6 = 0
					enem6input:SetText(Vers_Settings.VERSENEM6)
					enemoffdc6input:SetText(Vers_Settings.VERSENEMOFFDC6)
					enemdefdc6input:SetText(Vers_Settings.VERSENEMDEFDC6)
					versenemhp6input:SetText(Vers_Settings.VersEnemyHP6)
					versenemmaxhp6input:SetText(Vers_Settings.VersEnemyMaxHP6)
				end)

				enem7input = CreateFrame("Button","enem7input",versdmbg,versbutton2)
				enem7input:SetFrameStrata("LOW")
				enem7input:SetNormalFontObject("GameFontWhiteSmall")
				enem7input:SetHighlightFontObject("GameFontHighlight")
				enem7input:SetPoint("TOP",enem6input,"BOTTOM",0,0)
				enem7input:SetScale(0.75)
				enem7input:SetWidth(180)
				enem7input:SetHeight(25)
				enem7input:SetText(Vers_Settings.VERSENEM7)
				enem7input:SetBackdropColor(0,0,0,0)
				enem7input:SetAlpha(0.95)
				enem7input:SetScript("PostClick", function() enem7input:Hide() end)
				enem7input:SetScript("OnClick",function()
					enem7box = CreateFrame("EditBox","enem7box",versdmbg,"InputBoxTemplate")
					enem7box:SetFrameStrata("LOW")
					enem7box:SetFontObject("CombatLogFont")
					enem7box:SetScale(0.75)
					enem7box:SetWidth(175)
					enem7box:SetHeight(25)
					enem7box:SetPoint("TOP",enem6input,"BOTTOM",0,0)
					enem7box:SetScript("OnEnterPressed",function()
						Vers_Settings.VERSENEM7 = enem7box:GetText()
						enem7box:Hide()
						enem7input:Show()
						enem7input:SetText(Vers_Settings.VERSENEM7)
						end)
					end)

				enemoffdc7input = CreateFrame("Button","enemoffdc7input",versdmbg,versbutton2)
				enemoffdc7input:SetFrameStrata("LOW")
				enemoffdc7input:SetPoint("LEFT",enem7input,"RIGHT",0,0)
				enemoffdc7input:SetScale(0.75)
				enemoffdc7input:SetWidth(35)
				enemoffdc7input:SetHeight(25)
				enemoffdc7input:SetText(Vers_Settings.VERSENEMOFFDC7)
				enemoffdc7input:SetBackdropColor(0,0,0,0)
				enemoffdc7input:SetAlpha(0.95)
				enemoffdc7input:SetScript("PostClick", function() enemoffdc7input:Hide()end)
				enemoffdc7input:SetScript("OnClick",function()
					enemoffdc7box = CreateFrame("EditBox","enemoffdc7box",versdmbg,"InputBoxTemplate")
					enemoffdc7box:SetFrameStrata("LOW")
					enemoffdc7box:SetFontObject("CombatLogFont")
					enemoffdc7box:SetScale(0.75)
					enemoffdc7box:SetWidth(30)
					enemoffdc7box:SetHeight(25)
					enemoffdc7box:SetPoint("LEFT",enem7input,"RIGHT",0,0)
					enemoffdc7box:SetScript("OnEnterPressed",function()
						Vers_Settings.VERSENEMOFFDC7 = enemoffdc7box:GetNumber()
						enemoffdc7box:Hide()
						enemoffdc7input:Show()
						enemoffdc7input:SetText(Vers_Settings.VERSENEMOFFDC7)
						end)
					end)

				enemdefdc7input = CreateFrame("Button","enemdefdc7input",versdmbg,versbutton2)
				enemdefdc7input:SetFrameStrata("LOW")
				enemdefdc7input:SetPoint("LEFT",enemoffdc7input,"RIGHT",0,0)
				enemdefdc7input:SetScale(0.75)
				enemdefdc7input:SetWidth(35)
				enemdefdc7input:SetHeight(25)
				enemdefdc7input:SetText(Vers_Settings.VERSENEMDEFDC7)
				enemdefdc7input:SetBackdropColor(0,0,0,0)
				enemdefdc7input:SetAlpha(0.95)
				enemdefdc7input:SetScript("PostClick", function() enemdefdc7input:Hide()end)
				enemdefdc7input:SetScript("OnClick",function()
					enemdefdc7box = CreateFrame("EditBox","enemdefdc7box",versdmbg,"InputBoxTemplate")
					enemdefdc7box:SetFrameStrata("LOW")
					enemdefdc7box:SetFontObject("CombatLogFont")
					enemdefdc7box:SetScale(0.75)
					enemdefdc7box:SetWidth(30)
					enemdefdc7box:SetHeight(25)
					enemdefdc7box:SetPoint("LEFT",enemoffdc7input,"RIGHT",0,0)
					enemdefdc7box:SetScript("OnEnterPressed",function()
						Vers_Settings.VERSENEMDEFDC7 = enemdefdc7box:GetNumber()
						enemdefdc7box:Hide()
						enemdefdc7input:Show()
						enemdefdc7input:SetText(Vers_Settings.VERSENEMDEFDC7)
						end)
					end)

				versenemhp7input = CreateFrame("Button","versenemhp7input",versdmbg,versbutton2)
				versenemhp7input:SetFrameStrata("LOW")
				versenemhp7input:SetPoint("LEFT",enemdefdc7input,"RIGHT",25,0)
				versenemhp7input:SetScale(0.75)
				versenemhp7input:SetWidth(30)
				versenemhp7input:SetHeight(25)
				versenemhp7input:SetText(Vers_Settings.VersEnemyHP7)
				versenemhp7input:SetBackdropColor(0,0,0,0)
				versenemhp7input:SetAlpha(0.95)
				versenemhp7input:SetScript("PostClick", function() versenemhp7input:Hide()end)
				versenemhp7input:SetScript("OnClick",function()
					versenemhp7box = CreateFrame("EditBox","versenemhp7box",versdmbg,"InputBoxTemplate")
					versenemhp7box:SetFrameStrata("LOW")
					versenemhp7box:SetFontObject("CombatLogFont")
					versenemhp7box:SetScale(0.75)
					versenemhp7box:SetWidth(30)
					versenemhp7box:SetHeight(25)
					versenemhp7box:SetPoint("LEFT",enemdefdc7input,"RIGHT",27,0)
					versenemhp7box:SetScript("OnEnterPressed",function()
						Vers_Settings.VersEnemyHP7 = versenemhp7box:GetNumber()
						versenemhp7box:Hide()
						versenemhp7input:Show()
						versenemhp7input:SetText(Vers_Settings.VersEnemyHP7)
						end)
					end)

				versenemhp7add = CreateFrame("Button","versenemhp7add",versdmbg,versbutton2)
				versenemhp7add:SetFrameStrata("LOW")
				versenemhp7add:SetPoint("LEFT",versenemhp7input,"RIGHT",-1,0)
				versenemhp7add:SetScale(0.72)
				versenemhp7add:SetWidth(25)
				versenemhp7add:SetHeight(25)
				versenemhp7add:SetText("+")
				versenemhp7add:SetBackdropColor(0,0,0,0)
				versenemhp7add:SetAlpha(0.95)
				versenemhp7add:SetScript("OnClick",function()
					versshiftdown = IsShiftKeyDown()
					if versshiftdown == true then Vers_Settings.VersEnemyHP7 = Vers_Settings.VersEnemyHP7 + 5 else
					Vers_Settings.VersEnemyHP7 = Vers_Settings.VersEnemyHP7 + 1 end
					versenemhp7input:SetText(Vers_Settings.VersEnemyHP7)
				end)

				versenemhp7sub = CreateFrame("Button","versenemhp7sub",versdmbg,versbutton2)
				versenemhp7sub:SetFrameStrata("LOW")
				versenemhp7sub:SetPoint("RIGHT",versenemhp7input,"LEFT",1,0)
				versenemhp7sub:SetScale(0.75)
				versenemhp7sub:SetWidth(25)
				versenemhp7sub:SetHeight(25)
				versenemhp7sub:SetText("-")
				versenemhp7sub:SetBackdropColor(0,0,0,0)
				versenemhp7sub:SetAlpha(0.95)
				versenemhp7sub:SetScript("OnClick",function()
					versshiftdown = IsShiftKeyDown()
					if versshiftdown == true then Vers_Settings.VersEnemyHP7 = Vers_Settings.VersEnemyHP7 - 5 else
					Vers_Settings.VersEnemyHP7 = Vers_Settings.VersEnemyHP7 - 1 end
					if Vers_Settings.VersEnemyHP7 < 0 then Vers_Settings.VersEnemyHP7 = 0 end
					versenemhp7input:SetText(Vers_Settings.VersEnemyHP7)
				end)

				versenemmaxhp7input = CreateFrame("Button","versenemmaxhp7input",versdmbg,versbutton2)
				versenemmaxhp7input:SetFrameStrata("LOW")
				versenemmaxhp7input:SetPoint("LEFT",versenemhp7add,"RIGHT",0,0)
				versenemmaxhp7input:SetScale(0.75)
				versenemmaxhp7input:SetWidth(30)
				versenemmaxhp7input:SetHeight(25)
				versenemmaxhp7input:SetText(Vers_Settings.VersEnemyMaxHP7)
				versenemmaxhp7input:SetBackdropColor(0,0,0,0)
				versenemmaxhp7input:SetAlpha(0.95)
				versenemmaxhp7input:SetScript("PostClick", function() versenemmaxhp7input:Hide()end)
				versenemmaxhp7input:SetScript("OnClick",function()
					versenemmaxhp7box = CreateFrame("EditBox","versenemmaxhp7box",versdmbg,"InputBoxTemplate")
					versenemmaxhp7box:SetFrameStrata("LOW")
					versenemmaxhp7box:SetFontObject("CombatLogFont")
					versenemmaxhp7box:SetScale(0.75)
					versenemmaxhp7box:SetWidth(30)
					versenemmaxhp7box:SetHeight(25)
					versenemmaxhp7box:SetPoint("LEFT",versenemhp7add,"RIGHT",0,0)
					versenemmaxhp7box:SetScript("OnEnterPressed",function()
						Vers_Settings.VersEnemyMaxHP7 = versenemmaxhp7box:GetNumber()
						versenemmaxhp7box:Hide()
						versenemmaxhp7input:Show()
						versenemmaxhp7input:SetText(Vers_Settings.VersEnemyMaxHP7)
						end)
					end)

				versenem7clear = CreateFrame("Button","versenem7clear",versdmbg,versbutton2)
				versenem7clear:SetFrameStrata("LOW")
				versenem7clear:SetPoint("LEFT",versenemmaxhp7input,"RIGHT",0,0)
				versenem7clear:SetScale(0.75)
				versenem7clear:SetWidth(25)
				versenem7clear:SetHeight(25)
				versenem7clear:SetText("X")
				versenem7clear:SetBackdropColor(0,0,0,0)
				versenem7clear:SetAlpha(0.97)
				versenem7clear:SetScript("OnClick",function()
					Vers_Settings.VERSENEM7 = ""
					Vers_Settings.VERSENEMOFFDC7 = 0
					Vers_Settings.VERSENEMDEFDC7 = 0
					Vers_Settings.VersEnemyHP7 = 0
					Vers_Settings.VersEnemyMaxHP7 = 0
					enem7input:SetText(Vers_Settings.VERSENEM7)
					enemoffdc7input:SetText(Vers_Settings.VERSENEMOFFDC7)
					enemdefdc7input:SetText(Vers_Settings.VERSENEMDEFDC7)
					versenemhp7input:SetText(Vers_Settings.VersEnemyHP7)
					versenemmaxhp7input:SetText(Vers_Settings.VersEnemyMaxHP7)
				end)

--Save/Load Feature

				verssave1 = CreateFrame("Button","verssave1",versdmbg,versbutton2)
				verssave1:SetFrameStrata("LOW")
				verssave1:SetPoint("TOP",versdmbg,"TOPLEFT",40,-13)
				verssave1:SetScale(0.75)
				verssave1:SetWidth(60)
				verssave1:SetHeight(25)
				verssave1:SetText("Save #1")
				verssave1:SetBackdropColor(0,0,0,0)
				verssave1:SetAlpha(0.95)
				verssave1:SetScript("OnClick",function()
					Vers_DM1.VERSENEM1 = Vers_Settings.VERSENEM1
					Vers_DM1.VERSENEMDMG1 = Vers_Settings.VERSENEMDMG1
					Vers_DM1.VERSENEMOFFDC1 = Vers_Settings.VERSENEMOFFDC1
					Vers_DM1.VERSENEMDEFDC1 = Vers_Settings.VERSENEMDEFDC1
					Vers_DM1.VersEnemyHP1 = Vers_Settings.VersEnemyHP1
					Vers_DM1.VersEnemyMaxHP1 = Vers_Settings.VersEnemyMaxHP1
					Vers_DM1.VERSENEM2 = Vers_Settings.VERSENEM2
					Vers_DM1.VERSENEMDMG2 = Vers_Settings.VERSENEMDMG2
					Vers_DM1.VERSENEMOFFDC2 = Vers_Settings.VERSENEMOFFDC2
					Vers_DM1.VERSENEMDEFDC2 = Vers_Settings.VERSENEMDEFDC2
					Vers_DM1.VersEnemyHP2 = Vers_Settings.VersEnemyHP2
					Vers_DM1.VersEnemyMaxHP2 = Vers_Settings.VersEnemyMaxHP2
					Vers_DM1.VERSENEM3 = Vers_Settings.VERSENEM3
					Vers_DM1.VERSENEMDMG3 = Vers_Settings.VERSENEMDMG3
					Vers_DM1.VERSENEMOFFDC3 = Vers_Settings.VERSENEMOFFDC3
					Vers_DM1.VERSENEMDEFDC3 = Vers_Settings.VERSENEMDEFDC3
					Vers_DM1.VersEnemyHP3 = Vers_Settings.VersEnemyHP3
					Vers_DM1.VersEnemyMaxHP3 = Vers_Settings.VersEnemyMaxHP3
					Vers_DM1.VERSENEM4 = Vers_Settings.VERSENEM4
					Vers_DM1.VERSENEMDMG4 = Vers_Settings.VERSENEMDMG4
					Vers_DM1.VERSENEMOFFDC4 = Vers_Settings.VERSENEMOFFDC4
					Vers_DM1.VERSENEMDEFDC4 = Vers_Settings.VERSENEMDEFDC4
					Vers_DM1.VersEnemyHP4 = Vers_Settings.VersEnemyHP4
					Vers_DM1.VersEnemyMaxHP4 = Vers_Settings.VersEnemyMaxHP4
					Vers_DM1.VERSENEM5 = Vers_Settings.VERSENEM5
					Vers_DM1.VERSENEMDMG5 = Vers_Settings.VERSENEMDMG5
					Vers_DM1.VERSENEMOFFDC5 = Vers_Settings.VERSENEMOFFDC5
					Vers_DM1.VERSENEMDEFDC5 = Vers_Settings.VERSENEMDEFDC5
					Vers_DM1.VersEnemyHP5 = Vers_Settings.VersEnemyHP5
					Vers_DM1.VersEnemyMaxHP5 = Vers_Settings.VersEnemyMaxHP5
					Vers_DM1.VERSENEM6 = Vers_Settings.VERSENEM6
					Vers_DM1.VERSENEMDMG6 = Vers_Settings.VERSENEMDMG6
					Vers_DM1.VERSENEMOFFDC6 = Vers_Settings.VERSENEMOFFDC6
					Vers_DM1.VERSENEMDEFDC6 = Vers_Settings.VERSENEMDEFDC6
					Vers_DM1.VersEnemyHP6 = Vers_Settings.VersEnemyHP6
					Vers_DM1.VersEnemyMaxHP6 = Vers_Settings.VersEnemyMaxHP6
					Vers_DM1.VERSENEM7 = Vers_Settings.VERSENEM7
					Vers_DM1.VERSENEMDMG7 = Vers_Settings.VERSENEMDMG7
					Vers_DM1.VERSENEMOFFDC7 = Vers_Settings.VERSENEMOFFDC7
					Vers_DM1.VERSENEMDEFDC7 = Vers_Settings.VERSENEMDEFDC7
					Vers_DM1.VersEnemyHP7 = Vers_Settings.VersEnemyHP7
					Vers_DM1.VersEnemyMaxHP7 = Vers_Settings.VersEnemyMaxHP7
				end)

				versload1 = CreateFrame("Button","versload1",versdmbg,versbutton2)
				versload1:SetFrameStrata("LOW")
				versload1:SetPoint("LEFT",verssave1,"RIGHT",0,0)
				versload1:SetScale(0.75)
				versload1:SetWidth(60)
				versload1:SetHeight(25)
				versload1:SetText("Load #1")
				versload1:SetBackdropColor(0,0,0,0)
				versload1:SetAlpha(0.95)
				versload1:SetScript("OnClick",function()
					Vers_Settings.VERSENEM1 = Vers_DM1.VERSENEM1
					Vers_Settings.VERSENEMDMG1 = Vers_DM1.VERSENEMDMG1
					Vers_Settings.VERSENEMOFFDC1 = Vers_DM1.VERSENEMOFFDC1
					Vers_Settings.VERSENEMDEFDC1 = Vers_DM1.VERSENEMDEFDC1
					Vers_Settings.VersEnemyHP1 = Vers_DM1.VersEnemyHP1
					Vers_Settings.VersEnemyMaxHP1 = Vers_DM1.VersEnemyMaxHP1
					Vers_Settings.VERSENEM2 = Vers_DM1.VERSENEM2
					Vers_Settings.VERSENEMDMG2 = Vers_DM1.VERSENEMDMG2
					Vers_Settings.VERSENEMOFFDC2 = Vers_DM1.VERSENEMOFFDC2
					Vers_Settings.VERSENEMDEFDC2 = Vers_DM1.VERSENEMDEFDC2
					Vers_Settings.VersEnemyHP2 = Vers_DM1.VersEnemyHP2
					Vers_Settings.VersEnemyMaxHP2 = Vers_DM1.VersEnemyMaxHP2
					Vers_Settings.VERSENEM3 = Vers_DM1.VERSENEM3
					Vers_Settings.VERSENEMDMG3 = Vers_DM1.VERSENEMDMG3
					Vers_Settings.VERSENEMOFFDC3 = Vers_DM1.VERSENEMOFFDC3
					Vers_Settings.VERSENEMDEFDC3 = Vers_DM1.VERSENEMDEFDC3
					Vers_Settings.VersEnemyHP3 = Vers_DM1.VersEnemyHP3
					Vers_Settings.VersEnemyMaxHP3 = Vers_DM1.VersEnemyMaxHP3
					Vers_Settings.VERSENEM4 = Vers_DM1.VERSENEM4
					Vers_Settings.VERSENEMDMG4 = Vers_DM1.VERSENEMDMG4
					Vers_Settings.VERSENEMOFFDC4 = Vers_DM1.VERSENEMOFFDC4
					Vers_Settings.VERSENEMDEFDC4 = Vers_DM1.VERSENEMDEFDC4
					Vers_Settings.VersEnemyHP4 = Vers_DM1.VersEnemyHP4
					Vers_Settings.VersEnemyMaxHP4 = Vers_DM1.VersEnemyMaxHP4
					Vers_Settings.VERSENEM5 = Vers_DM1.VERSENEM5
					Vers_Settings.VERSENEMDMG5 = Vers_DM1.VERSENEMDMG5
					Vers_Settings.VERSENEMOFFDC5 = Vers_DM1.VERSENEMOFFDC5
					Vers_Settings.VERSENEMDEFDC5 = Vers_DM1.VERSENEMDEFDC5
					Vers_Settings.VersEnemyHP5 = Vers_DM1.VersEnemyHP5
					Vers_Settings.VersEnemyMaxHP5 = Vers_DM1.VersEnemyMaxHP5
					Vers_Settings.VERSENEM6 = Vers_DM1.VERSENEM6
					Vers_Settings.VERSENEMDMG6 = Vers_DM1.VERSENEMDMG6
					Vers_Settings.VERSENEMOFFDC6 = Vers_DM1.VERSENEMOFFDC6
					Vers_Settings.VERSENEMDEFDC6 = Vers_DM1.VERSENEMDEFDC6
					Vers_Settings.VersEnemyHP6 = Vers_DM1.VersEnemyHP6
					Vers_Settings.VersEnemyMaxHP6 = Vers_DM1.VersEnemyMaxHP6
					Vers_Settings.VERSENEM7 = Vers_DM1.VERSENEM7
					Vers_Settings.VERSENEMDMG7 = Vers_DM1.VERSENEMDMG7
					Vers_Settings.VERSENEMOFFDC7 = Vers_DM1.VERSENEMOFFDC7
					Vers_Settings.VERSENEMDEFDC7 = Vers_DM1.VERSENEMDEFDC7
					Vers_Settings.VersEnemyHP7 = Vers_DM1.VersEnemyHP7
					Vers_Settings.VersEnemyMaxHP7 = Vers_DM1.VersEnemyMaxHP7
					enem1input:SetText(Vers_Settings.VERSENEM1)
					enemoffdc1input:SetText(Vers_Settings.VERSENEMOFFDC1)
					enemdefdc1input:SetText(Vers_Settings.VERSENEMDEFDC1)
					versenemhp1input:SetText(Vers_Settings.VersEnemyHP1)
					versenemmaxhp1input:SetText(Vers_Settings.VersEnemyMaxHP1)
					enem2input:SetText(Vers_Settings.VERSENEM2)
					enemoffdc2input:SetText(Vers_Settings.VERSENEMOFFDC2)
					enemdefdc2input:SetText(Vers_Settings.VERSENEMDEFDC2)
					versenemhp2input:SetText(Vers_Settings.VersEnemyHP2)
					versenemmaxhp2input:SetText(Vers_Settings.VersEnemyMaxHP2)
					enem3input:SetText(Vers_Settings.VERSENEM3)
					enemoffdc3input:SetText(Vers_Settings.VERSENEMOFFDC3)
					enemdefdc3input:SetText(Vers_Settings.VERSENEMDEFDC3)
					versenemhp3input:SetText(Vers_Settings.VersEnemyHP3)
					versenemmaxhp3input:SetText(Vers_Settings.VersEnemyMaxHP3)
					enem4input:SetText(Vers_Settings.VERSENEM4)
					enemoffdc4input:SetText(Vers_Settings.VERSENEMOFFDC4)
					enemdefdc4input:SetText(Vers_Settings.VERSENEMDEFDC4)
					versenemhp4input:SetText(Vers_Settings.VersEnemyHP4)
					versenemmaxhp4input:SetText(Vers_Settings.VersEnemyMaxHP4)
					enem5input:SetText(Vers_Settings.VERSENEM5)
					enemoffdc5input:SetText(Vers_Settings.VERSENEMOFFDC5)
					enemdefdc5input:SetText(Vers_Settings.VERSENEMDEFDC5)
					versenemhp5input:SetText(Vers_Settings.VersEnemyHP5)
					versenemmaxhp5input:SetText(Vers_Settings.VersEnemyMaxHP5)
					enem6input:SetText(Vers_Settings.VERSENEM6)
					enemoffdc6input:SetText(Vers_Settings.VERSENEMOFFDC6)
					enemdefdc6input:SetText(Vers_Settings.VERSENEMDEFDC6)
					versenemhp6input:SetText(Vers_Settings.VersEnemyHP6)
					versenemmaxhp6input:SetText(Vers_Settings.VersEnemyMaxHP6)
					enem7input:SetText(Vers_Settings.VERSENEM7)
					enemoffdc7input:SetText(Vers_Settings.VERSENEMOFFDC7)
					enemdefdc7input:SetText(Vers_Settings.VERSENEMDEFDC7)
					versenemhp7input:SetText(Vers_Settings.VersEnemyHP7)
					versenemmaxhp7input:SetText(Vers_Settings.VersEnemyMaxHP7)
				end)

				verssave2 = CreateFrame("Button","verssave2",versdmbg,versbutton2)
				verssave2:SetFrameStrata("LOW")
				verssave2:SetPoint("LEFT",versload1,"RIGHT",15,0)
				verssave2:SetScale(0.75)
				verssave2:SetWidth(60)
				verssave2:SetHeight(25)
				verssave2:SetText("Save #2")
				verssave2:SetBackdropColor(0,0,0,0)
				verssave2:SetAlpha(0.95)
				verssave2:SetScript("OnClick",function()
					Vers_DM2.VERSENEM1 = Vers_Settings.VERSENEM1
					Vers_DM2.VERSENEMDMG1 = Vers_Settings.VERSENEMDMG1
					Vers_DM2.VERSENEMOFFDC1 = Vers_Settings.VERSENEMOFFDC1
					Vers_DM2.VERSENEMDEFDC1 = Vers_Settings.VERSENEMDEFDC1
					Vers_DM2.VersEnemyHP1 = Vers_Settings.VersEnemyHP1
					Vers_DM2.VersEnemyMaxHP1 = Vers_Settings.VersEnemyMaxHP1
					Vers_DM2.VERSENEM2 = Vers_Settings.VERSENEM2
					Vers_DM2.VERSENEMDMG2 = Vers_Settings.VERSENEMDMG2
					Vers_DM2.VERSENEMOFFDC2 = Vers_Settings.VERSENEMOFFDC2
					Vers_DM2.VERSENEMDEFDC2 = Vers_Settings.VERSENEMDEFDC2
					Vers_DM2.VersEnemyHP2 = Vers_Settings.VersEnemyHP2
					Vers_DM2.VersEnemyMaxHP2 = Vers_Settings.VersEnemyMaxHP2
					Vers_DM2.VERSENEM3 = Vers_Settings.VERSENEM3
					Vers_DM2.VERSENEMDMG3 = Vers_Settings.VERSENEMDMG3
					Vers_DM2.VERSENEMOFFDC3 = Vers_Settings.VERSENEMOFFDC3
					Vers_DM2.VERSENEMDEFDC3 = Vers_Settings.VERSENEMDEFDC3
					Vers_DM2.VersEnemyHP3 = Vers_Settings.VersEnemyHP3
					Vers_DM2.VersEnemyMaxHP3 = Vers_Settings.VersEnemyMaxHP3
					Vers_DM2.VERSENEM4 = Vers_Settings.VERSENEM4
					Vers_DM2.VERSENEMDMG4 = Vers_Settings.VERSENEMDMG4
					Vers_DM2.VERSENEMOFFDC4 = Vers_Settings.VERSENEMOFFDC4
					Vers_DM2.VERSENEMDEFDC4 = Vers_Settings.VERSENEMDEFDC4
					Vers_DM2.VersEnemyHP4 = Vers_Settings.VersEnemyHP4
					Vers_DM2.VersEnemyMaxHP4 = Vers_Settings.VersEnemyMaxHP4
					Vers_DM2.VERSENEM5 = Vers_Settings.VERSENEM5
					Vers_DM2.VERSENEMDMG5 = Vers_Settings.VERSENEMDMG5
					Vers_DM2.VERSENEMOFFDC5 = Vers_Settings.VERSENEMOFFDC5
					Vers_DM2.VERSENEMDEFDC5 = Vers_Settings.VERSENEMDEFDC5
					Vers_DM2.VersEnemyHP5 = Vers_Settings.VersEnemyHP5
					Vers_DM2.VersEnemyMaxHP5 = Vers_Settings.VersEnemyMaxHP5
					Vers_DM2.VERSENEM6 = Vers_Settings.VERSENEM6
					Vers_DM2.VERSENEMDMG6 = Vers_Settings.VERSENEMDMG6
					Vers_DM2.VERSENEMOFFDC6 = Vers_Settings.VERSENEMOFFDC6
					Vers_DM2.VERSENEMDEFDC6 = Vers_Settings.VERSENEMDEFDC6
					Vers_DM2.VersEnemyHP6 = Vers_Settings.VersEnemyHP6
					Vers_DM2.VersEnemyMaxHP6 = Vers_Settings.VersEnemyMaxHP6
					Vers_DM2.VERSENEM7 = Vers_Settings.VERSENEM7
					Vers_DM2.VERSENEMDMG7 = Vers_Settings.VERSENEMDMG7
					Vers_DM2.VERSENEMOFFDC7 = Vers_Settings.VERSENEMOFFDC7
					Vers_DM2.VERSENEMDEFDC7 = Vers_Settings.VERSENEMDEFDC7
					Vers_DM2.VersEnemyHP7 = Vers_Settings.VersEnemyHP7
					Vers_DM2.VersEnemyMaxHP7 = Vers_Settings.VersEnemyMaxHP7
				end)

				versload2 = CreateFrame("Button","versload2",versdmbg,versbutton2)
				versload2:SetFrameStrata("LOW")
				versload2:SetPoint("LEFT",verssave2,"RIGHT",0,0)
				versload2:SetScale(0.75)
				versload2:SetWidth(60)
				versload2:SetHeight(25)
				versload2:SetText("Load #2")
				versload2:SetBackdropColor(0,0,0,0)
				versload2:SetAlpha(0.95)
				versload2:SetScript("OnClick",function()
					Vers_Settings.VERSENEM1 = Vers_DM2.VERSENEM1
					Vers_Settings.VERSENEMDMG1 = Vers_DM2.VERSENEMDMG1
					Vers_Settings.VERSENEMOFFDC1 = Vers_DM2.VERSENEMOFFDC1
					Vers_Settings.VERSENEMDEFDC1 = Vers_DM2.VERSENEMDEFDC1
					Vers_Settings.VersEnemyHP1 = Vers_DM2.VersEnemyHP1
					Vers_Settings.VersEnemyMaxHP1 = Vers_DM2.VersEnemyMaxHP1
					Vers_Settings.VERSENEM2 = Vers_DM2.VERSENEM2
					Vers_Settings.VERSENEMDMG2 = Vers_DM2.VERSENEMDMG2
					Vers_Settings.VERSENEMOFFDC2 = Vers_DM2.VERSENEMOFFDC2
					Vers_Settings.VERSENEMDEFDC2 = Vers_DM2.VERSENEMDEFDC2
					Vers_Settings.VersEnemyHP2 = Vers_DM2.VersEnemyHP2
					Vers_Settings.VersEnemyMaxHP2 = Vers_DM2.VersEnemyMaxHP2
					Vers_Settings.VERSENEM3 = Vers_DM2.VERSENEM3
					Vers_Settings.VERSENEMDMG3 = Vers_DM2.VERSENEMDMG3
					Vers_Settings.VERSENEMOFFDC3 = Vers_DM2.VERSENEMOFFDC3
					Vers_Settings.VERSENEMDEFDC3 = Vers_DM2.VERSENEMDEFDC3
					Vers_Settings.VersEnemyHP3 = Vers_DM2.VersEnemyHP3
					Vers_Settings.VersEnemyMaxHP3 = Vers_DM2.VersEnemyMaxHP3
					Vers_Settings.VERSENEM4 = Vers_DM2.VERSENEM4
					Vers_Settings.VERSENEMDMG4 = Vers_DM2.VERSENEMDMG4
					Vers_Settings.VERSENEMOFFDC4 = Vers_DM2.VERSENEMOFFDC4
					Vers_Settings.VERSENEMDEFDC4 = Vers_DM2.VERSENEMDEFDC4
					Vers_Settings.VersEnemyHP4 = Vers_DM2.VersEnemyHP4
					Vers_Settings.VersEnemyMaxHP4 = Vers_DM2.VersEnemyMaxHP4
					Vers_Settings.VERSENEM5 = Vers_DM2.VERSENEM5
					Vers_Settings.VERSENEMDMG5 = Vers_DM2.VERSENEMDMG5
					Vers_Settings.VERSENEMOFFDC5 = Vers_DM2.VERSENEMOFFDC5
					Vers_Settings.VERSENEMDEFDC5 = Vers_DM2.VERSENEMDEFDC5
					Vers_Settings.VersEnemyHP5 = Vers_DM2.VersEnemyHP5
					Vers_Settings.VersEnemyMaxHP5 = Vers_DM2.VersEnemyMaxHP5
					Vers_Settings.VERSENEM6 = Vers_DM2.VERSENEM6
					Vers_Settings.VERSENEMDMG6 = Vers_DM2.VERSENEMDMG6
					Vers_Settings.VERSENEMOFFDC6 = Vers_DM2.VERSENEMOFFDC6
					Vers_Settings.VERSENEMDEFDC6 = Vers_DM2.VERSENEMDEFDC6
					Vers_Settings.VersEnemyHP6 = Vers_DM2.VersEnemyHP6
					Vers_Settings.VersEnemyMaxHP6 = Vers_DM2.VersEnemyMaxHP6
					Vers_Settings.VERSENEM7 = Vers_DM2.VERSENEM7
					Vers_Settings.VERSENEMDMG7 = Vers_DM2.VERSENEMDMG7
					Vers_Settings.VERSENEMOFFDC7 = Vers_DM2.VERSENEMOFFDC7
					Vers_Settings.VERSENEMDEFDC7 = Vers_DM2.VERSENEMDEFDC7
					Vers_Settings.VersEnemyHP7 = Vers_DM2.VersEnemyHP7
					Vers_Settings.VersEnemyMaxHP7 = Vers_DM2.VersEnemyMaxHP7
					enem1input:SetText(Vers_Settings.VERSENEM1)
					enemoffdc1input:SetText(Vers_Settings.VERSENEMOFFDC1)
					enemdefdc1input:SetText(Vers_Settings.VERSENEMDEFDC1)
					versenemhp1input:SetText(Vers_Settings.VersEnemyHP1)
					versenemmaxhp1input:SetText(Vers_Settings.VersEnemyMaxHP1)
					enem2input:SetText(Vers_Settings.VERSENEM2)
					enemoffdc2input:SetText(Vers_Settings.VERSENEMOFFDC2)
					enemdefdc2input:SetText(Vers_Settings.VERSENEMDEFDC2)
					versenemhp2input:SetText(Vers_Settings.VersEnemyHP2)
					versenemmaxhp2input:SetText(Vers_Settings.VersEnemyMaxHP2)
					enem3input:SetText(Vers_Settings.VERSENEM3)
					enemoffdc3input:SetText(Vers_Settings.VERSENEMOFFDC3)
					enemdefdc3input:SetText(Vers_Settings.VERSENEMDEFDC3)
					versenemhp3input:SetText(Vers_Settings.VersEnemyHP3)
					versenemmaxhp3input:SetText(Vers_Settings.VersEnemyMaxHP3)
					enem4input:SetText(Vers_Settings.VERSENEM4)
					enemoffdc4input:SetText(Vers_Settings.VERSENEMOFFDC4)
					enemdefdc4input:SetText(Vers_Settings.VERSENEMDEFDC4)
					versenemhp4input:SetText(Vers_Settings.VersEnemyHP4)
					versenemmaxhp4input:SetText(Vers_Settings.VersEnemyMaxHP4)
					enem5input:SetText(Vers_Settings.VERSENEM5)
					enemoffdc5input:SetText(Vers_Settings.VERSENEMOFFDC5)
					enemdefdc5input:SetText(Vers_Settings.VERSENEMDEFDC5)
					versenemhp5input:SetText(Vers_Settings.VersEnemyHP5)
					versenemmaxhp5input:SetText(Vers_Settings.VersEnemyMaxHP5)
					enem6input:SetText(Vers_Settings.VERSENEM6)
					enemoffdc6input:SetText(Vers_Settings.VERSENEMOFFDC6)
					enemdefdc6input:SetText(Vers_Settings.VERSENEMDEFDC6)
					versenemhp6input:SetText(Vers_Settings.VersEnemyHP6)
					versenemmaxhp6input:SetText(Vers_Settings.VersEnemyMaxHP6)
					enem7input:SetText(Vers_Settings.VERSENEM7)
					enemoffdc7input:SetText(Vers_Settings.VERSENEMOFFDC7)
					enemdefdc7input:SetText(Vers_Settings.VERSENEMDEFDC7)
					versenemhp7input:SetText(Vers_Settings.VersEnemyHP7)
					versenemmaxhp7input:SetText(Vers_Settings.VersEnemyMaxHP7)
				end)

				verssave3 = CreateFrame("Button","verssave3",versdmbg,versbutton2)
				verssave3:SetFrameStrata("LOW")
				verssave3:SetPoint("LEFT",versload2,"RIGHT",15,0)
				verssave3:SetScale(0.75)
				verssave3:SetWidth(60)
				verssave3:SetHeight(25)
				verssave3:SetText("Save #3")
				verssave3:SetBackdropColor(0,0,0,0)
				verssave3:SetAlpha(0.95)
				verssave3:SetScript("OnClick",function()
					Vers_DM3.VERSENEM1 = Vers_Settings.VERSENEM1
					Vers_DM3.VERSENEMDMG1 = Vers_Settings.VERSENEMDMG1
					Vers_DM3.VERSENEMOFFDC1 = Vers_Settings.VERSENEMOFFDC1
					Vers_DM3.VERSENEMDEFDC1 = Vers_Settings.VERSENEMDEFDC1
					Vers_DM3.VersEnemyHP1 = Vers_Settings.VersEnemyHP1
					Vers_DM3.VersEnemyMaxHP1 = Vers_Settings.VersEnemyMaxHP1
					Vers_DM3.VERSENEM2 = Vers_Settings.VERSENEM2
					Vers_DM3.VERSENEMDMG2 = Vers_Settings.VERSENEMDMG2
					Vers_DM3.VERSENEMOFFDC2 = Vers_Settings.VERSENEMOFFDC2
					Vers_DM3.VERSENEMDEFDC2 = Vers_Settings.VERSENEMDEFDC2
					Vers_DM3.VersEnemyHP2 = Vers_Settings.VersEnemyHP2
					Vers_DM3.VersEnemyMaxHP2 = Vers_Settings.VersEnemyMaxHP2
					Vers_DM3.VERSENEM3 = Vers_Settings.VERSENEM3
					Vers_DM3.VERSENEMDMG3 = Vers_Settings.VERSENEMDMG3
					Vers_DM3.VERSENEMOFFDC3 = Vers_Settings.VERSENEMOFFDC3
					Vers_DM3.VERSENEMDEFDC3 = Vers_Settings.VERSENEMDEFDC3
					Vers_DM3.VersEnemyHP3 = Vers_Settings.VersEnemyHP3
					Vers_DM3.VersEnemyMaxHP3 = Vers_Settings.VersEnemyMaxHP3
					Vers_DM3.VERSENEM4 = Vers_Settings.VERSENEM4
					Vers_DM3.VERSENEMDMG4 = Vers_Settings.VERSENEMDMG4
					Vers_DM3.VERSENEMOFFDC4 = Vers_Settings.VERSENEMOFFDC4
					Vers_DM3.VERSENEMDEFDC4 = Vers_Settings.VERSENEMDEFDC4
					Vers_DM3.VersEnemyHP4 = Vers_Settings.VersEnemyHP4
					Vers_DM3.VersEnemyMaxHP4 = Vers_Settings.VersEnemyMaxHP4
					Vers_DM3.VERSENEM5 = Vers_Settings.VERSENEM5
					Vers_DM3.VERSENEMDMG5 = Vers_Settings.VERSENEMDMG5
					Vers_DM3.VERSENEMOFFDC5 = Vers_Settings.VERSENEMOFFDC5
					Vers_DM3.VERSENEMDEFDC5 = Vers_Settings.VERSENEMDEFDC5
					Vers_DM3.VersEnemyHP5 = Vers_Settings.VersEnemyHP5
					Vers_DM3.VersEnemyMaxHP5 = Vers_Settings.VersEnemyMaxHP5
					Vers_DM3.VERSENEM6 = Vers_Settings.VERSENEM6
					Vers_DM3.VERSENEMDMG6 = Vers_Settings.VERSENEMDMG6
					Vers_DM3.VERSENEMOFFDC6 = Vers_Settings.VERSENEMOFFDC6
					Vers_DM3.VERSENEMDEFDC6 = Vers_Settings.VERSENEMDEFDC6
					Vers_DM3.VersEnemyHP6 = Vers_Settings.VersEnemyHP6
					Vers_DM3.VersEnemyMaxHP6 = Vers_Settings.VersEnemyMaxHP6
					Vers_DM3.VERSENEM7 = Vers_Settings.VERSENEM7
					Vers_DM3.VERSENEMDMG7 = Vers_Settings.VERSENEMDMG7
					Vers_DM3.VERSENEMOFFDC7 = Vers_Settings.VERSENEMOFFDC7
					Vers_DM3.VERSENEMDEFDC7 = Vers_Settings.VERSENEMDEFDC7
					Vers_DM3.VersEnemyHP7 = Vers_Settings.VersEnemyHP7
					Vers_DM3.VersEnemyMaxHP7 = Vers_Settings.VersEnemyMaxHP7
				end)

				versload2 = CreateFrame("Button","versload2",versdmbg,versbutton2)
				versload2:SetFrameStrata("LOW")
				versload2:SetPoint("LEFT",verssave3,"RIGHT",0,0)
				versload2:SetScale(0.75)
				versload2:SetWidth(60)
				versload2:SetHeight(25)
				versload2:SetText("Load #3")
				versload2:SetBackdropColor(0,0,0,0)
				versload2:SetAlpha(0.95)
				versload2:SetScript("OnClick",function()
					Vers_Settings.VERSENEM1 = Vers_DM3.VERSENEM1
					Vers_Settings.VERSENEMDMG1 = Vers_DM3.VERSENEMDMG1
					Vers_Settings.VERSENEMOFFDC1 = Vers_DM3.VERSENEMOFFDC1
					Vers_Settings.VERSENEMDEFDC1 = Vers_DM3.VERSENEMDEFDC1
					Vers_Settings.VersEnemyHP1 = Vers_DM3.VersEnemyHP1
					Vers_Settings.VersEnemyMaxHP1 = Vers_DM3.VersEnemyMaxHP1
					Vers_Settings.VERSENEM2 = Vers_DM3.VERSENEM2
					Vers_Settings.VERSENEMDMG2 = Vers_DM3.VERSENEMDMG2
					Vers_Settings.VERSENEMOFFDC2 = Vers_DM3.VERSENEMOFFDC2
					Vers_Settings.VERSENEMDEFDC2 = Vers_DM3.VERSENEMDEFDC2
					Vers_Settings.VersEnemyHP2 = Vers_DM3.VersEnemyHP2
					Vers_Settings.VersEnemyMaxHP2 = Vers_DM3.VersEnemyMaxHP2
					Vers_Settings.VERSENEM3 = Vers_DM3.VERSENEM3
					Vers_Settings.VERSENEMDMG3 = Vers_DM3.VERSENEMDMG3
					Vers_Settings.VERSENEMOFFDC3 = Vers_DM3.VERSENEMOFFDC3
					Vers_Settings.VERSENEMDEFDC3 = Vers_DM3.VERSENEMDEFDC3
					Vers_Settings.VersEnemyHP3 = Vers_DM3.VersEnemyHP3
					Vers_Settings.VersEnemyMaxHP3 = Vers_DM3.VersEnemyMaxHP3
					Vers_Settings.VERSENEM4 = Vers_DM3.VERSENEM4
					Vers_Settings.VERSENEMDMG4 = Vers_DM3.VERSENEMDMG4
					Vers_Settings.VERSENEMOFFDC4 = Vers_DM3.VERSENEMOFFDC4
					Vers_Settings.VERSENEMDEFDC4 = Vers_DM3.VERSENEMDEFDC4
					Vers_Settings.VersEnemyHP4 = Vers_DM3.VersEnemyHP4
					Vers_Settings.VersEnemyMaxHP4 = Vers_DM3.VersEnemyMaxHP4
					Vers_Settings.VERSENEM5 = Vers_DM3.VERSENEM5
					Vers_Settings.VERSENEMDMG5 = Vers_DM3.VERSENEMDMG5
					Vers_Settings.VERSENEMOFFDC5 = Vers_DM3.VERSENEMOFFDC5
					Vers_Settings.VERSENEMDEFDC5 = Vers_DM3.VERSENEMDEFDC5
					Vers_Settings.VersEnemyHP5 = Vers_DM3.VersEnemyHP5
					Vers_Settings.VersEnemyMaxHP5 = Vers_DM3.VersEnemyMaxHP5
					Vers_Settings.VERSENEM6 = Vers_DM3.VERSENEM6
					Vers_Settings.VERSENEMDMG6 = Vers_DM3.VERSENEMDMG6
					Vers_Settings.VERSENEMOFFDC6 = Vers_DM3.VERSENEMOFFDC6
					Vers_Settings.VERSENEMDEFDC6 = Vers_DM3.VERSENEMDEFDC6
					Vers_Settings.VersEnemyHP6 = Vers_DM3.VersEnemyHP6
					Vers_Settings.VersEnemyMaxHP6 = Vers_DM3.VersEnemyMaxHP6
					Vers_Settings.VERSENEM7 = Vers_DM3.VERSENEM7
					Vers_Settings.VERSENEMDMG7 = Vers_DM3.VERSENEMDMG7
					Vers_Settings.VERSENEMOFFDC7 = Vers_DM3.VERSENEMOFFDC7
					Vers_Settings.VERSENEMDEFDC7 = Vers_DM3.VERSENEMDEFDC7
					Vers_Settings.VersEnemyHP7 = Vers_DM3.VersEnemyHP7
					Vers_Settings.VersEnemyMaxHP7 = Vers_DM3.VersEnemyMaxHP7
					enem1input:SetText(Vers_Settings.VERSENEM1)
					enemoffdc1input:SetText(Vers_Settings.VERSENEMOFFDC1)
					enemdefdc1input:SetText(Vers_Settings.VERSENEMDEFDC1)
					versenemhp1input:SetText(Vers_Settings.VersEnemyHP1)
					versenemmaxhp1input:SetText(Vers_Settings.VersEnemyMaxHP1)
					enem2input:SetText(Vers_Settings.VERSENEM2)
					enemoffdc2input:SetText(Vers_Settings.VERSENEMOFFDC2)
					enemdefdc2input:SetText(Vers_Settings.VERSENEMDEFDC2)
					versenemhp2input:SetText(Vers_Settings.VersEnemyHP2)
					versenemmaxhp2input:SetText(Vers_Settings.VersEnemyMaxHP2)
					enem3input:SetText(Vers_Settings.VERSENEM3)
					enemoffdc3input:SetText(Vers_Settings.VERSENEMOFFDC3)
					enemdefdc3input:SetText(Vers_Settings.VERSENEMDEFDC3)
					versenemhp3input:SetText(Vers_Settings.VersEnemyHP3)
					versenemmaxhp3input:SetText(Vers_Settings.VersEnemyMaxHP3)
					enem4input:SetText(Vers_Settings.VERSENEM4)
					enemoffdc4input:SetText(Vers_Settings.VERSENEMOFFDC4)
					enemdefdc4input:SetText(Vers_Settings.VERSENEMDEFDC4)
					versenemhp4input:SetText(Vers_Settings.VersEnemyHP4)
					versenemmaxhp4input:SetText(Vers_Settings.VersEnemyMaxHP4)
					enem5input:SetText(Vers_Settings.VERSENEM5)
					enemoffdc5input:SetText(Vers_Settings.VERSENEMOFFDC5)
					enemdefdc5input:SetText(Vers_Settings.VERSENEMDEFDC5)
					versenemhp5input:SetText(Vers_Settings.VersEnemyHP5)
					versenemmaxhp5input:SetText(Vers_Settings.VersEnemyMaxHP5)
					enem6input:SetText(Vers_Settings.VERSENEM6)
					enemoffdc6input:SetText(Vers_Settings.VERSENEMOFFDC6)
					enemdefdc6input:SetText(Vers_Settings.VERSENEMDEFDC6)
					versenemhp6input:SetText(Vers_Settings.VersEnemyHP6)
					versenemmaxhp6input:SetText(Vers_Settings.VersEnemyMaxHP6)
					enem7input:SetText(Vers_Settings.VERSENEM7)
					enemoffdc7input:SetText(Vers_Settings.VERSENEMOFFDC7)
					enemdefdc7input:SetText(Vers_Settings.VERSENEMDEFDC7)
					versenemhp7input:SetText(Vers_Settings.VersEnemyHP7)
					versenemmaxhp7input:SetText(Vers_Settings.VersEnemyMaxHP7)
				end)

				versdmreport = CreateFrame("Button","versdmreport",versdmbg,versbutton2)
				versdmreport:SetFrameStrata("LOW")
				versdmreport:SetPoint("TOPLEFT",enem7input,"BOTTOMLEFT",0,0)
				versdmreport:SetScale(0.75)
				versdmreport:SetWidth(135)
				versdmreport:SetHeight(25)
				versdmreport:SetText("Full Report")
				versdmreport:SetBackdropColor(0,0,0,0)
				versdmreport:SetAlpha(0.95)
				versdmreport:SetScript("PreClick",function()
					if IsInRaid() then VersChat = "RAID" elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then VersChat = "PARTY" else VersChat = nil end
					DMOut = {}
				end)
				versdmreport:SetScript("OnClick",function()
					for i=1,7 do 
						if Vers_Settings["VERSENEM"..i] ~= "" then DMOut["VersEnem"..i.."String"] = "Enemy: "..Vers_Settings["VERSENEM"..i]..". DC"..Vers_Settings["VERSENEMOFFDC"..i].." to Hit. DC"..Vers_Settings["VERSENEMDEFDC"..i].." to Avoid. HP: "..Vers_Settings["VersEnemyHP"..i].."/"..Vers_Settings["VersEnemyMaxHP"..i] 
						else DMOut["VersEnem"..i.."String"] = "" end
					end
					VersDMRepString = DMOut.VersEnem1String .. DMOut.VersEnem2String .. DMOut.VersEnem3String .. DMOut.VersEnem4String .. DMOut.VersEnem5String .. DMOut.VersEnem6String .. DMOut.VersEnem7String
					if VersDMRepString == "" then print("No Enemies Set.") 
					elseif VersChat then
						for i=1,7 do
							if DMOut["VersEnem"..i.."String"] ~= "" then SendChatMessage(DMOut["VersEnem"..i.."String"],VersChat) end
						end
					else 
						for i=1,7 do
							if DMOut["VersEnem"..i.."String"] ~= "" then print(DMOut["VersEnem"..i.."String"]) end
						end
					end
				end)

				versdmhpreport = CreateFrame("Button","versdmhpreport",versdmbg,versbutton2)
				versdmhpreport:SetFrameStrata("LOW")
				versdmhpreport:SetPoint("LEFT",versdmreport,"RIGHT",0,0)
				versdmhpreport:SetScale(0.75)
				versdmhpreport:SetWidth(135)
				versdmhpreport:SetHeight(25)
				versdmhpreport:SetText("Condensed Report")
				versdmhpreport:SetBackdropColor(0,0,0,0)
				versdmhpreport:SetAlpha(0.95)
				versdmhpreport:SetScript("PreClick",function()
					if IsInRaid() then VersChat = "RAID" elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then VersChat = "PARTY" else VersChat = nil end end)
				versdmhpreport:SetScript("OnClick",function()
					local s = 7
					DMOut = ""
					for i=1,7 do
						if Vers_Settings["VERSENEM"..i] ~= "" then 
							if Vers_Settings["VersEnemyHP"..i] > 0 then
								DMOut = "Enemy: "..Vers_Settings["VERSENEM"..i]..". HP: "..Vers_Settings["VersEnemyHP"..i].."/"..Vers_Settings["VersEnemyMaxHP"..i] else
								DMOut = "Enemy: "..Vers_Settings["VERSENEM"..i]
							end
							if VersChat ~= nil then
								SendChatMessage(DMOut,VersChat)
							else
								print(DMOut)
							end
						else
							s = s - 1 
						end
						if s == 0 then print("No Enemies Set.") end
					end
				end)

				versdmclear = CreateFrame("Button","versdmclear",versdmbg,versbutton2)
				versdmclear:SetFrameStrata("LOW")
				versdmclear:SetPoint("LEFT",versdmhpreport,"RIGHT",0,0)
				versdmclear:SetScale(0.75)
				versdmclear:SetWidth(110)
				versdmclear:SetHeight(25)
				versdmclear:SetText("Clear All")
				versdmclear:SetBackdropColor(0,0,0,0)
				versdmclear:SetAlpha(0.95)
				versdmclear:SetScript("OnClick",function()
					Vers_Settings.VERSENEM1 = ""
					Vers_Settings.VERSENEMOFFDC1 = 0
					Vers_Settings.VERSENEMDEFDC1 = 0
					Vers_Settings.VersEnemyHP1 = 0
					Vers_Settings.VersEnemyMaxHP1 = 0
					Vers_Settings.VERSENEM2 = ""
					Vers_Settings.VERSENEMOFFDC2 = 0
					Vers_Settings.VERSENEMDEFDC2 = 0
					Vers_Settings.VersEnemyHP2 = 0
					Vers_Settings.VersEnemyMaxHP2 = 0
					Vers_Settings.VERSENEM3 = ""
					Vers_Settings.VERSENEMOFFDC3 = 0
					Vers_Settings.VERSENEMDEFDC3 = 0
					Vers_Settings.VersEnemyHP3 = 0
					Vers_Settings.VersEnemyMaxHP3 = 0
					Vers_Settings.VERSENEM4 = ""
					Vers_Settings.VERSENEMOFFDC4 = 0
					Vers_Settings.VERSENEMDEFDC4 = 0
					Vers_Settings.VersEnemyHP4 = 0
					Vers_Settings.VersEnemyMaxHP4 = 0
					Vers_Settings.VERSENEM5 = ""
					Vers_Settings.VERSENEMOFFDC5 = 0
					Vers_Settings.VERSENEMDEFDC5 = 0
					Vers_Settings.VersEnemyHP5 = 0
					Vers_Settings.VersEnemyMaxHP5 = 0
					Vers_Settings.VERSENEM6 = ""
					Vers_Settings.VERSENEMOFFDC6 = 0
					Vers_Settings.VERSENEMDEFDC6 = 0
					Vers_Settings.VersEnemyHP6 = 0
					Vers_Settings.VersEnemyMaxHP6 = 0
					Vers_Settings.VERSENEM7 = ""
					Vers_Settings.VERSENEMOFFDC7 = 0
					Vers_Settings.VERSENEMDEFDC7 = 0
					Vers_Settings.VersEnemyHP7 = 0
					Vers_Settings.VersEnemyMaxHP7 = 0
					enem1input:SetText(Vers_Settings.VERSENEM1)
					enemoffdc1input:SetText(Vers_Settings.VERSENEMOFFDC1)
					enemdefdc1input:SetText(Vers_Settings.VERSENEMDEFDC1)
					versenemhp1input:SetText(Vers_Settings.VersEnemyHP1)
					versenemmaxhp1input:SetText(Vers_Settings.VersEnemyMaxHP1)
					enem2input:SetText(Vers_Settings.VERSENEM2)
					enemoffdc2input:SetText(Vers_Settings.VERSENEMOFFDC2)
					enemdefdc2input:SetText(Vers_Settings.VERSENEMDEFDC2)
					versenemhp2input:SetText(Vers_Settings.VersEnemyHP2)
					versenemmaxhp2input:SetText(Vers_Settings.VersEnemyMaxHP2)
					enem3input:SetText(Vers_Settings.VERSENEM3)
					enemoffdc3input:SetText(Vers_Settings.VERSENEMOFFDC3)
					enemdefdc3input:SetText(Vers_Settings.VERSENEMDEFDC3)
					versenemhp3input:SetText(Vers_Settings.VersEnemyHP3)
					versenemmaxhp3input:SetText(Vers_Settings.VersEnemyMaxHP3)
					enem4input:SetText(Vers_Settings.VERSENEM4)
					enemoffdc4input:SetText(Vers_Settings.VERSENEMOFFDC4)
					enemdefdc4input:SetText(Vers_Settings.VERSENEMDEFDC4)
					versenemhp4input:SetText(Vers_Settings.VersEnemyHP4)
					versenemmaxhp4input:SetText(Vers_Settings.VersEnemyMaxHP4)
					enem5input:SetText(Vers_Settings.VERSENEM5)
					enemoffdc5input:SetText(Vers_Settings.VERSENEMOFFDC5)
					enemdefdc5input:SetText(Vers_Settings.VERSENEMDEFDC5)
					versenemhp5input:SetText(Vers_Settings.VersEnemyHP5)
					versenemmaxhp5input:SetText(Vers_Settings.VersEnemyMaxHP5)
					enem6input:SetText(Vers_Settings.VERSENEM6)
					enemoffdc6input:SetText(Vers_Settings.VERSENEMOFFDC6)
					enemdefdc6input:SetText(Vers_Settings.VERSENEMDEFDC6)
					versenemhp6input:SetText(Vers_Settings.VersEnemyHP6)
					versenemmaxhp6input:SetText(Vers_Settings.VersEnemyMaxHP6)
					enem7input:SetText(Vers_Settings.VERSENEM7)
					enemoffdc7input:SetText(Vers_Settings.VERSENEMOFFDC7)
					enemdefdc7input:SetText(Vers_Settings.VERSENEMDEFDC7)
					versenemhp7input:SetText(Vers_Settings.VersEnemyHP7)
					versenemmaxhp7input:SetText(Vers_Settings.VersEnemyMaxHP7)
				end)

				versdmrandpick = CreateFrame("Button","versdmrandpick",versdmbg,versbutton2)
				versdmrandpick:SetFrameStrata("LOW")
				versdmrandpick:SetPoint("TOPLEFT",versdmreport,"BOTTOMLEFT",0,0)
				versdmrandpick:SetScale(0.75)
				versdmrandpick:SetWidth(155)
				versdmrandpick:SetHeight(25)
				versdmrandpick:SetText("Pick a Random Player")
				versdmrandpick:SetBackdropColor(0,0,0,0)
				versdmrandpick:SetAlpha(0.95)
				versdmrandpick:SetScript("PreClick",function()
					versshiftdown = IsShiftKeyDown()
					InRaid = IsInRaid()
					InParty = IsInGroup(LE_PARTY_CATEGORY_HOME)
					if IsInRaid() then VersChat = "RAID" elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then VersChat = "PARTY" else VersChat = nil end
					VGrpMem = GetNumGroupMembers()
				end)
				versdmrandpick:SetScript("OnClick",function()
					VersPlayerPrev = VersPlayer
					VersRaid = {}
					VMem = 0
					-- for VGrpTar = 1,VGrpMem do
						-- local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML = GetRaidRosterInfo(VGrpTar)
						-- msp:Request( name, "NA" )
					-- end
					for VGrpTar = 1,VGrpMem do
						local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML = GetRaidRosterInfo(VGrpTar)
						if subgroup <= Vers_Settings.VRaidHigh and subgroup >= Vers_Settings.VRaidLow and name ~= VersPlayerPrev and online == true then
							VMem = VMem + 1
							VersRaid[VMem] = name
						end
					end
					VersClass = ""
					VersPlayer = ""
					if #VersRaid > 0 then VersPlayer = VersRaid[math.random(#VersRaid)]
					VersClass = UnitClass(VersPlayer)
					VersPlayerOut = VersPlayer
					for _, v in ipairs(ClassColorTable) do
						if v.class == VersClass then
							TarCol = v.color
						end
					end
					else TarCol = "FFFFFFFF"
					VersPlayerOut = "No Player in Range" end
					trpname = VEMembers[VersPlayer]
					if trpname == nil then trpname = "" end
					trpcol = trpname:match("|c%x%x%x%x%x%x%x%x")
					if trpname ~= "" then VersPlayerOut = trpname
					if trpcol == nil then VERSEL:SetText("Player: |c"..TarCol..VersPlayerOut.."|r") else
					VERSEL:SetText("Player: "..VersPlayerOut) end else
					VERSEL:SetText("Player: |c"..TarCol..VersPlayerOut.."|r") end
					if versshiftdown == true then SendChatMessage("Random Player: "..VersPlayerOut,VersChat) end
				end)

				versdmpause = CreateFrame("Button","versdmpause",versdmbg,versbutton2)
				versdmpause:SetFrameStrata("LOW")
				versdmpause:SetPoint("TOPLEFT",versdmrandpick,"BOTTOMLEFT",0,0)
				versdmpause:SetScale(0.75)
				versdmpause:SetWidth(100)
				versdmpause:SetHeight(25)
				versdmpause:SetText("Pause!")
				versdmpause:SetBackdropColor(0,0,0,0)
				versdmpause:SetAlpha(0.95)			
				versdmpause:SetScript("OnClick", function()
					SendChatMessage("Pause!","RAID_WARNING")
				end)
				
				VERSEL = versdmbg:CreateFontString(nil, "High", "GameTooltipText")
				VERSEL:SetPoint("LEFT",versdmrandpick,"RIGHT",0,-1)
				VERSEL:SetText("Player: |c"..TarCol..VersPlayerOut.."|r")
				VERSEL:SetFont("Fonts\\ARIALN.ttf", 11)				
				
				versgrplowinput = CreateFrame("Button","versgrplowinput",versdmbg,versbutton2)
				versgrplowinput:SetFrameStrata("LOW")
				versgrplowinput:SetPoint("LEFT",versdmpause,"RIGHT",200,0)
				versgrplowinput:SetScale(0.75)
				versgrplowinput:SetWidth(30)
				versgrplowinput:SetHeight(25)
				versgrplowinput:SetText(Vers_Settings.VRaidLow)
				versgrplowinput:SetBackdropColor(0,0,0,0)
				versgrplowinput:SetAlpha(0.95)
				versgrplowinput:SetScript("PostClick", function() versgrplowinput:Hide()end)
				versgrplowinput:SetScript("OnClick",function()
					versgrplowbox = CreateFrame("EditBox","versgrplowbox",versdmbg,"InputBoxTemplate")
					versgrplowbox:SetFrameStrata("LOW")
					versgrplowbox:SetFontObject("CombatLogFont")
					versgrplowbox:SetScale(0.75)
					versgrplowbox:SetWidth(25)
					versgrplowbox:SetHeight(25)
					versgrplowbox:SetPoint("BOTTOMRIGHT",versdmclear,"TOP",-5,0)
					versgrplowbox:SetScript("OnEnterPressed",function()
						Vers_Settings.VRaidLow = versgrplowbox:GetNumber()
						versgrplowbox:Hide()
						versgrplowinput:Show()
						versgrplowinput:SetText(Vers_Settings.VRaidLow)
						end)
					end)

				versgrphighinput = CreateFrame("Button","versgrphighinput",versdmbg,versbutton2)
				versgrphighinput:SetFrameStrata("LOW")
				versgrphighinput:SetPoint("LEFT",versgrplowinput,"RIGHT",15,0)
				versgrphighinput:SetScale(0.75)
				versgrphighinput:SetWidth(30)
				versgrphighinput:SetHeight(25)
				versgrphighinput:SetText(Vers_Settings.VRaidHigh)
				versgrphighinput:SetBackdropColor(0,0,0,0)
				versgrphighinput:SetAlpha(0.95)
				versgrphighinput:SetScript("PostClick", function() versgrphighinput:Hide()end)
				versgrphighinput:SetScript("OnClick",function()
					versgrphighbox = CreateFrame("EditBox","versgrphighbox",versdmbg,"InputBoxTemplate")
					versgrphighbox:SetFrameStrata("LOW")
					versgrphighbox:SetFontObject("CombatLogFont")
					versgrphighbox:SetScale(0.75)
					versgrphighbox:SetWidth(25)
					versgrphighbox:SetHeight(25)
					versgrphighbox:SetPoint("LEFT",versgrplowinput,"RIGHT",15,0)
					versgrphighbox:SetScript("OnEnterPressed",function()
						Vers_Settings.VRaidHigh = versgrphighbox:GetNumber()
						versgrphighbox:Hide()
						versgrphighinput:Show()
						versgrphighinput:SetText(Vers_Settings.VRaidHigh)
						end)
					end)

				VERGRP = versdmbg:CreateFontString(nil, "High", "GameTooltipText")
				VERGRP:SetPoint("RIGHT","versgrplowinput","LEFT",0,0)
				VERGRP:SetText("Group Range From:")
				VERGRP:SetFont("Fonts\\ARIALN.ttf", 9)

				VERGRPTO = versdmbg:CreateFontString(nil, "High", "GameTooltipText")
				VERGRPTO:SetPoint("RIGHT","versgrphighinput","LEFT",-1,0)
				VERGRPTO:SetText("To")
				VERGRPTO:SetFont("Fonts\\ARIALN.ttf", 9)

				versveturn = CreateFrame("Button","versveturn",versdmbg,versbutton2)
				versveturn:SetFrameStrata("LOW")
				versveturn:SetPoint("TOPLEFT",versdmpause,"BOTTOMLEFT",0,0)
				versveturn:SetScale(0.75)
				versveturn:SetWidth(135)
				versveturn:SetHeight(25)
				versveturn:SetText("The Kirin Aran Turn")
				versveturn:SetBackdropColor(0,0,0,0)
				versveturn:SetAlpha(0.95)
				versveturn:SetScript("OnClick",function()
					SendChatMessage("** KIRIN ARAN COMBAT TURN **","RAID_WARNING")
				end)

				versenturn = CreateFrame("Button","versenturn",versdmbg,versbutton2)
				versenturn:SetFrameStrata("LOW")
				versenturn:SetPoint("LEFT",versveturn,"RIGHT",0,0)
				versenturn:SetScale(0.75)
				versenturn:SetWidth(135)
				versenturn:SetHeight(25)
				versenturn:SetText("Enemy Turn")
				versenturn:SetBackdropColor(0,0,0,0)
				versenturn:SetAlpha(0.95)
				versenturn:SetScript("OnClick",function()
					SendChatMessage("** ENEMY TURN **","RAID_WARNING")
				end)

				versreadychk = CreateFrame("Button","versreadychk",versdmbg,versbutton2)
				versreadychk:SetFrameStrata("LOW")
				versreadychk:SetPoint("LEFT",versenturn,"RIGHT",0,0)
				versreadychk:SetScale(0.75)
				versreadychk:SetWidth(110)
				versreadychk:SetHeight(25)
				versreadychk:SetText("Ready Check")
				versreadychk:SetBackdropColor(0,0,0,0)
				versreadychk:SetAlpha(0.95)
				versreadychk:SetScript("OnClick",function()
					DoReadyCheck()
				end)
				
				-- VGrpMem = GetNumGroupMembers()
				-- for VGrpTar = 1,VGrpMem do
					-- local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML = GetRaidRosterInfo(VGrpTar)
					-- msp:Request( name, "NA" )
				-- end

			end
		end)

		verssettings = CreateFrame("Button","verssettings",versmenubg,versbutton1)
		verssettings:SetFrameStrata("LOW")
		verssettings:SetPoint("TOP","versdm","BOTTOM",0,0)
		verssettings:SetScale(0.75)
		verssettings:SetWidth(145)
		verssettings:SetHeight(25)
		verssettings:SetText("Settings")
		verssettings:SetBackdropColor(0,0,0,0)
		verssettings:SetAlpha(0.95)
		verssettings:SetScript("OnClick",function()
			if verssettingsbg then
			verssettingsbg:Hide()
			verssettingsbg = nil;
			else

			verssettingsbg = CreateFrame("Frame","verssettingsbg",versmenubg)
			verssettingsbg:SetFrameStrata("LOW")
			verssettingsbg:ClearAllPoints()
			verssettingsbg:SetBackdrop(Backdrop5)
			verssettingsbg:SetBackdropColor(0,0.19,0.46,1)
			verssettingsbg:SetHeight(260)
			verssettingsbg:SetWidth(200)
			verssettingsbg:SetAlpha(0.95)
			verssettingsbg:SetPoint("CENTER",UIParent,0,0)
			verssettingsbg:SetScript("OnHide", function() verssettingsbg = nil end )
			verssettingsbg:SetScript("OnUpdate", function() if verssettings == "Hide" then verssettingsbg:Hide() verssettingsbg = nil; end end)
			verssettingsbg:SetMovable(true)
			verssettingsbg:EnableMouse(true)
			verssettingsbg:RegisterForDrag("LeftButton")
			verssettingsbg:SetScript("OnDragStart", verssettingsbg.StartMoving)
			verssettingsbg:SetScript("OnDragStop", verssettingsbg.StopMovingOrSizing)

				verssettings2 = CreateFrame("Button","verssettings2",verssettingsbg,versbutton1)
				verssettings2:SetFrameStrata("LOW")
				verssettings2:SetPoint("TOPRIGHT","verssettingsbg","TOPRIGHT",-16,-14)
				verssettings2:SetScale(0.75)
				verssettings2:SetWidth(125)
				verssettings2:SetHeight(25)
				verssettings2:SetText("More Skills")
				verssettings2:SetBackdropColor(0,0,0,0)
				verssettings2:SetAlpha(0.95)
				verssettings2:SetScript("OnClick",function()
					if verssettings2bg then
					verssettings2bg:Hide()
					verssettings2bg = nil;
					else

					verssettings2bg = CreateFrame("Frame","verssettings2bg",verssettingsbg)
					verssettings2bg:SetFrameStrata("LOW")
					verssettings2bg:Raise()
					verssettings2bg:ClearAllPoints()
					verssettings2bg:SetBackdrop(Backdrop5)
					verssettings2bg:SetBackdropColor(0,0.19,0.46,1)
					verssettings2bg:SetHeight(190)
					verssettings2bg:SetWidth(180)
					verssettings2bg:SetAlpha(0.95)
					verssettings2bg:SetPoint("TOPLEFT","verssettingsbg","TOPRIGHT",0,0)
					verssettings2bg:SetScript("OnHide", function() verssettings2bg = nil end )
					verssettings2bg:SetScript("OnUpdate", function() if verssettings2 == "Hide" then verssettings2bg:Hide() verssettings2bg = nil; end end)
					verssettings2bg:SetMovable(true)
					verssettings2bg:EnableMouse(true)
					verssettings2bg:RegisterForDrag("LeftButton")
					verssettings2bg:SetScript("OnDragStart", verssettings2bg.StartMoving)
					verssettings2bg:SetScript("OnDragStop", verssettings2bg.StopMovingOrSizing)

					SETMOD2 = verssettings2bg:CreateFontString(nil, "High", "GameTooltipText")
					SETMOD2:SetPoint("TOPLEFT","verssettings2bg",14,-15)
					SETMOD2:SetText("Mod:")
					SETMOD2:SetFont("Fonts\\ARIALN.ttf", 9)

					SETSKILL2 = verssettings2bg:CreateFontString(nil, "High", "GameTooltipText")
					SETSKILL2:SetPoint("LEFT","SETMOD2","RIGHT",31,0)
					SETSKILL2:SetText("Chosen Skill:")
					SETSKILL2:SetFont("Fonts\\ARIALN.ttf", 9)

					SETKILLS2 = verssettings2bg:CreateFontString(nil, "High", "GameTooltipText")
					SETKILLS2:SetPoint("LEFT","SETSKILL2","RIGHT",33,0)
					SETKILLS2:SetText("Dmg:")
					SETKILLS2:SetFont("Fonts\\ARIALN.ttf", 9)

					sk2vert = -32
						for i=11,20 do
							Skills3["sk2vert" .. i] = sk2vert

							Skills3["sk"..i.."input"] = CreateFrame("Button",Skills3["sk"..i.."input"],verssettings2bg,versbutton2)
							Skills3["sk"..i.."input"]:SetFrameStrata("MEDIUM")
							Skills3["sk"..i.."input"]:SetFrameLevel(4)
							Skills3["sk"..i.."input"]:SetPoint("TOPLEFT",verssettings2bg,"TOPLEFT",15,Skills3["sk2vert" .. i])
							Skills3["sk"..i.."input"]:SetScale(0.75)
							Skills3["sk"..i.."input"]:SetWidth(30)
							Skills3["sk"..i.."input"]:SetHeight(25)
							Skills3["sk"..i.."input"]:SetText(Skills2["VERSSK"..i])
							Skills3["sk"..i.."input"]:SetBackdropColor(0,0,0,0)
							Skills3["sk"..i.."input"]:SetAlpha(0.95)
							Skills3["sk"..i.."input"]:SetScript("PostClick", function() Skills3["sk"..i.."input"]:Hide()end)
							Skills3["sk"..i.."input"]:SetScript("OnClick",function()
								Skills3["sk"..i.."box"] = CreateFrame("EditBox",Skills3["sk"..i.."box"],verssettings2bg,"InputBoxTemplate")
								Skills3["sk"..i.."box"]:SetFrameStrata("MEDIUM")
								Skills3["sk"..i.."box"]:SetFrameLevel(4)
								Skills3["sk"..i.."box"]:SetFontObject("CombatLogFont")
								Skills3["sk"..i.."box"]:SetScale(0.75)
								Skills3["sk"..i.."box"]:SetWidth(20)
								Skills3["sk"..i.."box"]:SetHeight(25)
								Skills3["sk"..i.."box"]:SetPoint("TOPLEFT",verssettings2bg,"TOPLEFT",19,Skills3["sk2vert" .. i])
								Skills3["sk"..i.."box"]:SetScript("OnEnterPressed",function()
									Skills2["VERSSK"..i] = Skills3["sk"..i.."box"]:GetNumber()
									Skills3["sk"..i.."box"]:Hide()
									Skills3["sk"..i.."input"]:Show()
									Skills3["sk"..i.."input"]:SetText(Skills2["VERSSK"..i])
									end)
								end)

							Skills3["skill"..i.."input"] = CreateFrame("Button",Skills3["skill"..i.."input"],verssettings2bg,versbutton2)
							Skills3["skill"..i.."input"]:SetFrameStrata("MEDIUM")
							Skills3["skill"..i.."input"]:SetFrameLevel(4)
							Skills3["skill"..i.."input"]:SetNormalFontObject("GameFontWhiteSmall")
							Skills3["skill"..i.."input"]:SetHighlightFontObject("GameFontHighlight")
							Skills3["skill"..i.."input"]:SetPoint("LEFT",Skills3["sk"..i.."input"],"RIGHT",0,0)
							Skills3["skill"..i.."input"]:SetScale(0.75)
							Skills3["skill"..i.."input"]:SetWidth(150)
							Skills3["skill"..i.."input"]:SetHeight(25)
							Skills3["skill"..i.."input"]:SetText(Skills2["VERSSKILL"..i])
							Skills3["skill"..i.."input"]:SetBackdropColor(0,0,0,0)
							Skills3["skill"..i.."input"]:SetAlpha(0.95)
							Skills3["skill"..i.."input"]:SetScript("PostClick", function() Skills3["skill"..i.."input"]:Hide() end)
							Skills3["skill"..i.."input"]:SetScript("OnClick",function()
								Skills3["skill"..i.."box"] = CreateFrame("EditBox",Skills3["skill"..i.."box"],verssettings2bg,"InputBoxTemplate")
								Skills3["skill"..i.."box"]:SetFrameStrata("MEDIUM")
								Skills3["skill"..i.."box"]:SetFrameLevel(4)
								Skills3["skill"..i.."box"]:SetFontObject("CombatLogFont")
								Skills3["skill"..i.."box"]:SetScale(0.75)
								Skills3["skill"..i.."box"]:SetWidth(150)
								Skills3["skill"..i.."box"]:SetHeight(25)
								Skills3["skill"..i.."box"]:SetPoint("LEFT",Skills3["sk"..i.."input"],"RIGHT",3,0)
								Skills3["skill"..i.."box"]:SetScript("OnEnterPressed",function()
									Skills2["VERSSKILL"..i] = Skills3["skill"..i.."box"]:GetText()
									Skills3["skill"..i.."box"]:Hide()
									Skills3["skill"..i.."input"]:Show()
									Skills3["skill"..i.."input"]:SetText(Skills2["VERSSKILL"..i])
									end)
								end)

							Skills3["skill"..i.."kill"] = CreateFrame("CheckButton",Skills3["skill"..i.."kill"],verssettings2bg,"ChatConfigCheckButtonTemplate")
							Skills3["skill"..i.."kill"]:SetFrameStrata("LOW")
							Skills3["skill"..i.."kill"]:SetPoint("LEFT",Skills3["skill"..i.."input"],"RIGHT",1,0)
							Skills3["skill"..i.."kill"]:SetWidth(20)
							Skills3["skill"..i.."kill"]:SetHeight(20)
							Skills3["skill"..i.."kill"]:SetScript("OnUpdate", function()
							if Skills2["skill"..i.."k"] == "True" then Skills3["skill"..i.."kill"]:SetChecked(true) else Skills3["skill"..i.."kill"]:SetChecked(false) end
							end)
							Skills3["skill"..i.."kill"]:SetScript("OnClick", function()
							if Skills2["skill"..i.."k"] == "True" then
								Skills2["skill"..i.."k"] = "False" else
								Skills2["skill"..i.."k"] = "True" end
							end)
							sk2vert = sk2vert - 20
						end
					end
				end)

				SETMOD = verssettingsbg:CreateFontString(nil, "High", "GameTooltipText")
				SETMOD:SetPoint("TOPLEFT","verssettingsbg",14,-30)
				SETMOD:SetText("Mod:")
				SETMOD:SetFont("Fonts\\ARIALN.ttf", 9)

				SETSKILL = verssettingsbg:CreateFontString(nil, "High", "GameTooltipText")
				SETSKILL:SetPoint("LEFT","SETMOD","RIGHT",31,0)
				SETSKILL:SetText("Chosen Skill:")
				SETSKILL:SetFont("Fonts\\ARIALN.ttf", 9)

				SETKILLS = verssettingsbg:CreateFontString(nil, "High", "GameTooltipText")
				SETKILLS:SetPoint("LEFT","SETSKILL","RIGHT",38,0)
				SETKILLS:SetText("Dmg:")
				SETKILLS:SetFont("Fonts\\ARIALN.ttf", 9)
			
				skvert = -52
				for i=1,10 do
					Skills3["skvert" .. i] = skvert

					Skills3["sk"..i.."input"] = CreateFrame("Button",Skills3["sk"..i.."input"],verssettingsbg,versbutton2)
					Skills3["sk"..i.."input"]:SetFrameStrata("MEDIUM")
					Skills3["sk"..i.."input"]:SetFrameLevel(4)
					Skills3["sk"..i.."input"]:SetPoint("TOPLEFT",verssettingsbg,"TOPLEFT",15,Skills3["skvert" .. i])
					Skills3["sk"..i.."input"]:SetScale(0.75)
					Skills3["sk"..i.."input"]:SetWidth(30)
					Skills3["sk"..i.."input"]:SetHeight(25)
					Skills3["sk"..i.."input"]:SetText(Skills2["VERSSK"..i])
					Skills3["sk"..i.."input"]:SetBackdropColor(0,0,0,0)
					Skills3["sk"..i.."input"]:SetAlpha(0.95)
					Skills3["sk"..i.."input"]:SetScript("PostClick", function() Skills3["sk"..i.."input"]:Hide()end)
					Skills3["sk"..i.."input"]:SetScript("OnClick",function()
						Skills3["sk"..i.."box"] = CreateFrame("EditBox",Skills3["sk"..i.."box"],verssettingsbg,"InputBoxTemplate")
						Skills3["sk"..i.."box"]:SetFrameStrata("MEDIUM")
						Skills3["sk"..i.."box"]:SetFrameLevel(4)
						Skills3["sk"..i.."box"]:SetFontObject("CombatLogFont")
						Skills3["sk"..i.."box"]:SetScale(0.75)
						Skills3["sk"..i.."box"]:SetWidth(20)
						Skills3["sk"..i.."box"]:SetHeight(25)
						Skills3["sk"..i.."box"]:SetPoint("TOPLEFT",verssettingsbg,"TOPLEFT",17,Skills3["skvert" .. i])
						Skills3["sk"..i.."box"]:SetScript("OnEnterPressed",function()
							Skills2["VERSSK"..i] = Skills3["sk"..i.."box"]:GetNumber()
							Skills3["sk"..i.."box"]:Hide()
							Skills3["sk"..i.."input"]:Show()
							Skills3["sk"..i.."input"]:SetText(Skills2["VERSSK"..i])
							end)
						end)

					Skills3["skill"..i.."input"] = CreateFrame("Button",Skills3["skill"..i.."input"],verssettingsbg,versbutton2)
					Skills3["skill"..i.."input"]:SetFrameStrata("MEDIUM")
					Skills3["skill"..i.."input"]:SetFrameLevel(4)
					Skills3["skill"..i.."input"]:SetNormalFontObject("GameFontWhiteSmall")
					Skills3["skill"..i.."input"]:SetHighlightFontObject("GameFontHighlight")
					Skills3["skill"..i.."input"]:SetPoint("LEFT",Skills3["sk"..i.."input"],"RIGHT",0,0)
					Skills3["skill"..i.."input"]:SetScale(0.75)
					Skills3["skill"..i.."input"]:SetWidth(150)
					Skills3["skill"..i.."input"]:SetHeight(25)
					Skills3["skill"..i.."input"]:SetText(Skills2["VERSSKILL"..i])
					Skills3["skill"..i.."input"]:SetBackdropColor(0,0,0,0)
					Skills3["skill"..i.."input"]:SetAlpha(0.95)
					Skills3["skill"..i.."input"]:SetScript("PostClick", function() Skills3["skill"..i.."input"]:Hide() end)
					Skills3["skill"..i.."input"]:SetScript("OnClick",function()
						Skills3["skill"..i.."box"] = CreateFrame("EditBox",Skills3["skill"..i.."box"],verssettingsbg,"InputBoxTemplate")
						Skills3["skill"..i.."box"]:SetFrameStrata("MEDIUM")
						Skills3["skill"..i.."box"]:SetFrameLevel(4)
						Skills3["skill"..i.."box"]:SetFontObject("CombatLogFont")
						Skills3["skill"..i.."box"]:SetScale(0.75)
						Skills3["skill"..i.."box"]:SetWidth(150)
						Skills3["skill"..i.."box"]:SetHeight(25)
						Skills3["skill"..i.."box"]:SetPoint("LEFT",Skills3["sk"..i.."input"],"RIGHT",3,0)
						Skills3["skill"..i.."box"]:SetScript("OnEnterPressed",function()
							Skills2["VERSSKILL"..i] = Skills3["skill"..i.."box"]:GetText()
							Skills3["skill"..i.."box"]:Hide()
							Skills3["skill"..i.."input"]:Show()
							Skills3["skill"..i.."input"]:SetText(Skills2["VERSSKILL"..i])
							end)
						end)

					Skills3["skill"..i.."kill"] = CreateFrame("CheckButton",Skills3["skill"..i.."kill"],verssettingsbg,"ChatConfigCheckButtonTemplate")
					Skills3["skill"..i.."kill"]:SetFrameStrata("LOW")
					Skills3["skill"..i.."kill"]:SetPoint("LEFT",Skills3["skill"..i.."input"],"RIGHT",5,0)
					Skills3["skill"..i.."kill"]:SetWidth(20)
					Skills3["skill"..i.."kill"]:SetHeight(20)
					Skills3["skill"..i.."kill"]:SetScript("OnUpdate", function()
					if Skills2["skill"..i.."k"] == "True" then Skills3["skill"..i.."kill"]:SetChecked(true) else Skills3["skill"..i.."kill"]:SetChecked(false) end
					end)
					Skills3["skill"..i.."kill"]:SetScript("OnClick", function()
					if Skills2["skill"..i.."k"] == "True" then
						Skills2["skill"..i.."k"] = "False" else
						Skills2["skill"..i.."k"] = "True" end
					end)
					skvert = skvert - 20
				end
				
				offinput = CreateFrame("Button","offinput",verssettingsbg,versbutton2)
				offinput:SetFrameStrata("LOW")
				offinput:SetPoint("TOPLEFT",Skills3["sk10input"],"BOTTOMRIGHT",-5,-5)
				offinput:SetScale(0.75)
				offinput:SetWidth(30)
				offinput:SetHeight(25)
				offinput:SetText(Vers_Settings.OffMod)
				offinput:SetBackdropColor(0,0,0,0)
				offinput:SetAlpha(0.95)
				offinput:SetScript("PostClick", function() offinput:Hide()end)
				offinput:SetScript("OnClick",function()
					offbox = CreateFrame("EditBox","offbox",verssettingsbg,"InputBoxTemplate")
					offbox:SetFrameStrata("LOW")
					offbox:SetFontObject("CombatLogFont")
					offbox:SetScale(0.75)
					offbox:SetWidth(20)
					offbox:SetHeight(25)
					offbox:SetPoint("TOPLEFT",Skills3["sk10input"],"BOTTOMRIGHT",-5,-5)
					offbox:SetScript("OnEnterPressed",function()
						Vers_Settings.OffMod = offbox:GetNumber()
						offbox:Hide()
						offinput:Show()
						offinput:SetText(Vers_Settings.OffMod)
						end)
					end)

				VERSPETSTR = verssettingsbg:CreateFontString(nil, "High", "GameTooltipText")
				VERSPETSTR:SetPoint("RIGHT","offinput","LEFT",-2,0)
				VERSPETSTR:SetText("Att:")
				VERSPETSTR:SetFont("Fonts\\ARIALN.ttf", 9)

				definput = CreateFrame("Button","definput",verssettingsbg,versbutton2)
				definput:SetFrameStrata("LOW")
				definput:SetPoint("LEFT",offinput,"RIGHT",30,0)
				definput:SetScale(0.75)
				definput:SetWidth(30)
				definput:SetHeight(25)
				definput:SetText(Vers_Settings.DefMod)
				definput:SetBackdropColor(0,0,0,0)
				definput:SetAlpha(0.95)
				definput:SetScript("PostClick", function() definput:Hide()end)
				definput:SetScript("OnClick",function()
					defbox = CreateFrame("EditBox","defbox",verssettingsbg,"InputBoxTemplate")
					defbox:SetFrameStrata("LOW")
					defbox:SetFontObject("CombatLogFont")
					defbox:SetScale(0.75)
					defbox:SetWidth(20)
					defbox:SetHeight(25)
					defbox:SetPoint("LEFT",offinput,"RIGHT",31,0)
					defbox:SetScript("OnEnterPressed",function()
						Vers_Settings.DefMod = defbox:GetNumber()
						defbox:Hide()
						definput:Show()
						definput:SetText(Vers_Settings.DefMod)
						end)
					end)

				VERSPETAGI = verssettingsbg:CreateFontString(nil, "High", "GameTooltipText")
				VERSPETAGI:SetPoint("RIGHT","definput","LEFT",-1,0)
				VERSPETAGI:SetText("Def:")
				VERSPETAGI:SetFont("Fonts\\ARIALN.ttf", 9)

				socinput = CreateFrame("Button","socinput",verssettingsbg,versbutton2)
				socinput:SetFrameStrata("LOW")
				socinput:SetPoint("LEFT",definput,"RIGHT",30,0)
				socinput:SetScale(0.75)
				socinput:SetWidth(30)
				socinput:SetHeight(25)
				socinput:SetText(Vers_Settings.SocMod)
				socinput:SetBackdropColor(0,0,0,0)
				socinput:SetAlpha(0.95)
				socinput:SetScript("PostClick", function() socinput:Hide()end)
				socinput:SetScript("OnClick",function()
					socbox = CreateFrame("EditBox","socbox",verssettingsbg,"InputBoxTemplate")
					socbox:SetFrameStrata("LOW")
					socbox:SetFontObject("CombatLogFont")
					socbox:SetScale(0.75)
					socbox:SetWidth(20)
					socbox:SetHeight(25)
					socbox:SetPoint("LEFT",definput,"RIGHT",31,0)
					socbox:SetScript("OnEnterPressed",function()
						Vers_Settings.SocMod = socbox:GetNumber()
						socbox:Hide()
						socinput:Show()
						socinput:SetText(Vers_Settings.SocMod)
						end)
					end)

				VERSPETSTA = verssettingsbg:CreateFontString(nil, "High", "GameTooltipText")
				VERSPETSTA:SetPoint("RIGHT","socinput","LEFT",-1,0)
				VERSPETSTA:SetText("Soc:")
				VERSPETSTA:SetFont("Fonts\\ARIALN.ttf", 9)

				knoinput = CreateFrame("Button","knoinput",verssettingsbg,versbutton2)
				knoinput:SetFrameStrata("LOW")
				knoinput:SetPoint("LEFT",socinput,"RIGHT",30,0)
				knoinput:SetScale(0.75)
				knoinput:SetWidth(30)
				knoinput:SetHeight(25)
				knoinput:SetText(Vers_Settings.KnoMod)
				knoinput:SetBackdropColor(0,0,0,0)
				knoinput:SetAlpha(0.95)
				knoinput:SetScript("PostClick", function() knoinput:Hide()end)
				knoinput:SetScript("OnClick",function()
					knobox = CreateFrame("EditBox","knobox",verssettingsbg,"InputBoxTemplate")
					knobox:SetFrameStrata("LOW")
					knobox:SetFontObject("CombatLogFont")
					knobox:SetScale(0.75)
					knobox:SetWidth(20)
					knobox:SetHeight(25)
					knobox:SetPoint("LEFT",socinput,"RIGHT",31,0)
					knobox:SetScript("OnEnterPressed",function()
						Vers_Settings.KnoMod = knobox:GetNumber()
						knobox:Hide()
						knoinput:Show()
						knoinput:SetText(Vers_Settings.KnoMod)
						end)
					end)

				VERSPETINT = verssettingsbg:CreateFontString(nil, "High", "GameTooltipText")
				VERSPETINT:SetPoint("RIGHT","knoinput","LEFT",-1,0)
				VERSPETINT:SetText("Kno:")
				VERSPETINT:SetFont("Fonts\\ARIALN.ttf", 9)

				verstoggleshowch = CreateFrame("CheckButton","verstoggleshowch",verssettingsbg,"ChatConfigCheckButtonTemplate")
				verstoggleshowch:SetFrameStrata("LOW")
				verstoggleshowch:SetPoint("TOP","definput","BOTTOM",-3,0)
				verstoggleshowch:SetWidth(20)
				verstoggleshowch:SetHeight(20)
				verstoggleshowch:SetScript("OnUpdate", function()
				if verstoggleshow == "True" then verstoggleshowch:SetChecked(true) else verstoggleshowch:SetChecked(false) end
				end)
				verstoggleshowch:SetScript("OnClick", function()
				if verstoggleshow == "True" then
					verstoggleshow = "False"
					versbutton:Hide() else
					verstoggleshow = "True"
					versbutton:Show() end
				end)

				verstoggleshowtx = verssettingsbg:CreateFontString(nil, "High", "GameTooltipText")
				verstoggleshowtx:SetPoint("RIGHT","verstoggleshowch","LEFT",-1,1)
				verstoggleshowtx:SetText("Main Button:")
				verstoggleshowtx:SetFont("Fonts\\ARIALN.ttf", 9)

				versminimapshowch = CreateFrame("CheckButton","versminimapshowch",verssettingsbg,"ChatConfigCheckButtonTemplate")
				versminimapshowch:SetFrameStrata("MEDIUM")
				versminimapshowch:SetPoint("TOP","knoinput","BOTTOM",0,0)
				versminimapshowch:SetWidth(20)
				versminimapshowch:SetHeight(20)
				versminimapshowch:SetScript("OnUpdate", function()
				if versminimapshow == "True" then versminimapshowch:SetChecked(true) else versminimapshowch:SetChecked(false) end
				end)
				versminimapshowch:SetScript("OnClick", function()
				if versminimapshow == "True" then
					versminimapshow = "False"
					Vers_MinimapButton:Hide() else
					versminimapshow = "True"
					Vers_MinimapButton:Show() end
				end)

				versminimapshowtx = verssettingsbg:CreateFontString(nil, "High", "GameTooltipText")
				versminimapshowtx:SetPoint("RIGHT","versminimapshowch","LEFT",-1,1)
				versminimapshowtx:SetText("Minimap Button:")
				versminimapshowtx:SetFont("Fonts\\ARIALN.ttf", 9)

				verslatencyshowch = CreateFrame("CheckButton","verslatencyshowch",verssettingsbg,"ChatConfigCheckButtonTemplate")
				verslatencyshowch:SetFrameStrata("MEDIUM")
				verslatencyshowch:SetPoint("TOP","versminimapshowch","BOTTOM",0,5)
				verslatencyshowch:SetWidth(20)
				verslatencyshowch:SetHeight(20)
				verslatencyshowch:SetScript("OnUpdate", function()
				if Vers_Settings.VerLatChk == true then verslatencyshowch:SetChecked(true) else verslatencyshowch:SetChecked(false) end end)
				verslatencyshowch:SetScript("OnClick", function()
				if Vers_Settings.VerLatChk == true then
					Vers_Settings.VerLatChk = false 
					Vers_Settings.VerLat = 1
					else
					Vers_Settings.VerLatChk = true 
					Vers_Settings.VerLat = 2.5
					end
				end)

				verslatencyshowtx = verssettingsbg:CreateFontString(nil, "High", "GameTooltipText")
				verslatencyshowtx:SetPoint("RIGHT","verslatencyshowch","LEFT",-1,1)
				verslatencyshowtx:SetText("High Latency Mode:")
				verslatencyshowtx:SetFont("Fonts\\ARIALN.ttf", 9)
		end
		end)

		if versrolltog == "True" then versroll:Click("LeftMouseButton",down) versrolltog = "True" end
		if versdmtog == "True" then versdm:Click("LeftMouseButton",down) versdmtog = "True"  end

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
	versbutton:Click("LeftMouseButton",down)
end

local addhp = CreateFrame("Frame")
addhp:SetScript("OnEvent",function(self,event,...)
	verspre, versmsg = select(1,...)
		if verspre then
			if verspre == "VersHPUpdate" then SendAddonMessage("VersHPUpdate2",SUser.." "..VersHealthPoints.."HP","RAID")
				if vershpstatframe then vershpstatframe2:AddMessage("-----Updating-----",1,1,1,1) end
			end
			if vershpstatframe then
				if verspre == "VersHPUpdate2" then
					vershpstatframe2:AddMessage(versmsg,1,1,1,1)
				end
			end
		end
	end)
addhp:RegisterEvent("CHAT_MSG_ADDON")
