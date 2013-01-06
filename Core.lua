--if not (IsAddOnLoaded("Tukui") or IsAddOnLoaded("AsphyxiaUI") or IsAddOnLoaded("DuffedUI") or IsAddOnLoaded("ElvUI")) then return end
--local A, C = unpack(ElvUI or Tukui or AsphyxiaUI or DuffedUI)
local gUI = LibStub("gCore-4.0"):GetAddon("gUI-v3")
if not(gUI) then return end
OzCooldownsOptions = {}
local spellCooldowns = {
	["PRIEST"] = {
		47585, -- Dispersion
		586, -- Fade
		6346, -- Fear Ward
		64601, -- Hymm of Hope
		32375, -- Mass Dispel
		8092, -- Mind Blast
		17, -- Power Word: Shield
		64044, -- Psychic Horror
		8122, -- Psychic Scream
		32379, -- Shdow Word: Death
		589, -- Shadow Word: Pain
		34433, -- Shadowfiend
		15487, -- Silence
		15286, -- Vampiric Embrace
		73325, -- Leap of Faith
		108968, -- Void Shift
		108920, -- Void Tendrils
		108921, -- Psyfiend
		121536, -- Angelic Feather
		123040, -- Mindbender
		10060, -- Power Infusion
		121135, -- Cascade
		110744, -- Divine Star
		120517, -- Halo
		64843, -- Divine Hymm
		81209, -- Chakra: Chastise
		81206, -- Chakra: Sanctuary
		81208, -- Chakra: Serenity
		34861, -- Circle of Healing
		19236, -- Desperate Prayer
		47788, -- Guardian Spirit
		14914, -- Holy Fire
		88625, -- Holy Word: Chastise
		724, -- Lightwell
		33076, -- Prayer of Mending
		527, -- Purify
	},
	["SHAMAN"] = { -- Flyout Button Totems are really not needed to be added, or are they?
		51490, -- Thunderstorm
		16166, -- Elemental Mastery
		16190, -- Mana Tide Totem
		16188, -- Ancestral Swiftness
		55198, -- Tidal Force
		51533, -- Feral Spirit
		30823, -- Shamanistic Rage
		8177, -- Grounding Totem
		2825, -- Bloodlust
		32182, -- Heroism
		79206, -- Spiritwalker's Grace
		421, -- Chain Lightning
		108271, -- Astral Shift
		8042, -- Earth Shock
		108285, -- Call of Elements
		8050, -- Flame Shock
		8056, -- Frost Shock
		51505, -- Lava Burst
		51514, -- Hex
		73920, -- Healing Rain
		73899, -- Primal Strike
		77130, -- Purify Spirit
		61295, -- Riptide
		57994, -- Wind Shear
		108270, -- Stone Bulwark Totem
		51485, -- Earthgrab Totem
		108273, -- Windwalk Totem
		108280, -- Healing Tide Totem
		108281, -- Ancestral Guidance
		117014, -- Elemental Blast		
	},
	["ROGUE"] = {
		1856, -- Vanish
		5277, -- Evasion
		31224, -- Cloak of Shadows
		2983, -- Sprint
		2094, -- Blind
		51713, -- Shadow Dance
		14183, -- Premeditation
		14185, -- Preparation
		36554, -- Shadowstep
		79140, -- Vendetta
		14177, -- Cold Blood
		13877, -- Blade Flurry
		51690, -- Killing Spree
		13750, -- Adrenaline Rush
		76577, -- Smoke Bomb
		73981, -- Redirect
		74001, -- Combat Readiness
		57934, -- Tricks
		1966, -- Feint
		114842, -- Shadow Walk
		5938, -- Shiv
		114018, -- Shroud of Concealment
		121471, -- Shadow Blades
		408, -- Kidney Shot
		51722, -- Dismantle
		1725, -- Distract
		1766, -- Kick
		1776, -- Gouge
		1784, -- Stealth
	},
	["DRUID"] = {
		49376, -- Feral Charge - Cat
		16979, -- Feral Charge - Bear
		20484, -- Rebirth
		1850, -- Dash
		5209,  -- Challenging Roar
		22842, -- Frenzied Regeneration
		740, -- Tranquility
		5217, -- Tiger's Fury
		16689, -- Nature's Grasp
		48505, -- Starfall
		33831, -- Force of Nature
		50516, -- Typhoon
		50334, -- Berserk
		61336, -- Survival Instincts
		17116, -- Nature's Swiftness
		77764, -- Stampeding Roar
	},
	["MAGE"] = {
		12472, -- Icy Veins
		122,   -- Frost Nova
		120,   -- Cone of Cold
		11426, -- Ice Barrier
		11958, -- Cold Snap
		44572, -- Deep Freeze
		31687, -- Water Elemental
		11113, -- Blast Wave
		31661, -- Dragon Breath
		11129, -- Combustion
		12043, -- Presense of Mind
		12042, -- Arcane Power
		45438, -- Ice Block
		543,   -- Magic Protection (Fire/Frost Ward)
		12051, -- Evocation
		2139,  -- Counterspell
		55342, -- Mirror Images
		1953,  -- Blink
		66,    -- Invisibility
		1463,  -- Mana Shield
		80353, -- Time Warp
		82676, -- Ring of Frost
		82731, -- Flame Orb
	},
	["WARLOCK"] = {
		5484, -- Howl of Terror
		6789, -- Death Coil
		48020, -- Demonic Circle: Teleport
		29858, -- Soulshatter
		47897, -- Shadowflame
		79268, -- Soul Harvest
		74434, -- Soul Burn
		77801, -- Demon Soul
		86121, -- Soul Swap
		30283, -- Shadowfury
		47241, -- Metamorphosis
		18708, -- Fel Domination
		18540, -- Summon Doomguard / Infernal
	},
	["PALADIN"] = {
		498,   -- Divine Protection
		642,   -- Divine Shield
		2812,  -- Holy Wrath
		6940,  -- Hand of Sacrifice
		1022,  -- Hand of Protection
		1044,  -- Hand of Freedom
		1038,  -- Hand of Salvation
		633,   -- Lay on Hands
		31884, -- Avenging Wrath
		54428, -- Divine Plea
		20066, -- Repentance
		853,   -- Hammer of Justice
		31821, -- Aura Mastery
		20216, -- Divine Favor
		31850, -- Ardent Defender
		85222, -- Light of Dawn
		82327, -- Holy Radiance
		26573, -- Consecration
		85285, -- Rebuke
		85696, -- Zealotry
		20473, -- Holy Shock
		86150, -- Guardian of Ancient Kings
		82327, -- Holy Radiance
	},
	["DEATHKNIGHT"] = {
		49016, -- Hysteria
		49028, -- Dancing Runic Blade
		55233, -- Vampiric Blood
		48982, -- Rune Tap
		49206, -- Summon Gargoyle
		48707, -- Anti-magic shield
		51052, -- Anti-magic zone
		49203, -- Hungering Cold
		49796, -- Deathchill
		51271, -- Unbreakable Armor
		49222, -- Bone Shield
		43265, -- Death and Decay
		48792, -- Icebound Fortitude
		47476, -- Strangulate
		45529, -- Blood Tap
		48743, -- Death Pact
		57330, -- Horn of Winter
		49576, -- Death Grip
		47568, -- Empower Rune Weapon
		42650, -- Army of the Dead
		47528, -- Mind Freeze
		56222, -- Dark Command
		46584, -- Raise Dead
		77575, -- Outbreak
		77606, -- Dark Simulacrum
	},
	["HUNTER"] = {
		34026, -- Kill Command
		19577, -- Intimidation
		19574, -- Bestial Wrath
		121818, -- Stampede
		131894, -- A Murder of Crows
		3674,  -- Black Arrow
		5384,  -- Feign Death
		781,   -- Disengage
		34477, -- Misdirection
		53271, -- Master's Call
		3045,  -- Rapid Fire
		1543,  -- Flare
		19263, -- Deterrence
		19503, -- Scatter Shot
		34026, -- Kill Command
		23989, -- Readiness
		34600, -- Snake Trap
		82948, -- Snake Trap Launcher
		13813, -- Explosive Trap
		82939, -- Explosive Trap Launcher
		1499,  -- Freezing Trap
		60192, -- Freezing Trap Launcher
		13795, -- Immolation Trap
		82945, -- Immolation Trap Launcher
		13809, -- Ice Trap
		82941, -- Ice Trap Launcher
		51753, -- Camouflage
		53209, -- Chimera Shot
		53301, -- Explosive Shot
		130392, -- Blink Strike
		120697, -- Lynx Rush
		117050, -- Glaive Toss
		82726, -- Fervor
		109304, -- Exhilaration
		120679, -- Dire Beast
		19386, -- Wyvern Sting
		109248, -- Binding Shot
		34490, -- Silencing Shot
		109259, -- Powershot
		120360, -- Barrage
		53271, -- Master's Call
		77769, -- Trap Launcher
	},
	["WARRIOR"] = {
		676, -- Disarm
		1161, -- Challenging Shout
		1719, -- Recklessness
		2565, -- Shield Block
		64382, -- Shattering Throw
		57755, -- Heroic Throw
		46968, -- Shockwave
		46924, -- Bladestorm
		12328, -- Sweeping Strikes
		85388, -- Throwdown
		60970, -- Heroic Fury
		12809, -- Concussion Blow
		12292, -- Death Wish
		5246, -- Intimidating Shout
		18499, -- Berserker Rage
		20230, -- Retaliation
		871, -- Shield Wall
		12975, -- Last Stand
		100, -- Charge
		20252, -- Intercept
		3411, -- Intervene
		6544, -- Heroic Leap
		86346, -- Colossus Smash
		355, -- Taunt
	},
	["MONK"] = {
		115098, -- Chi Wave
		115450, -- Detox
		115288, -- Energizing Brew
		115072, -- Expel Harm
		113656, -- Fists of Fury
		101545, -- Flying Serpent Kick
		115203, -- Fortifying Brew
		117368, -- Grapple Weapon
		115078, -- Paralysis
		115546, -- Provoke
		107428, -- Rising Sun Kick
		116705, -- Spear Hand Strike
		116740, -- Tigereye Brew
		115080, -- Touch of Death
		122470, -- Touch of Karma
		115176, -- Zen Meditation
		126892, -- Zen Pilgrimage
		101643, -- Transcendence
		119996, -- Transcendence: Transfer
		116849, -- Life Cocoon
		115151, -- Renewing Mist
		115310, -- Revival
		115313, -- Summon Jade Serpent Statue
		116680, -- Thunder Focus Tea
		119381, -- Leg Sweep
		119392, -- Charging Ox Wave
		122278, -- Dampen Harm
		112783, -- Diffuse Magic
		116847, -- Rushing Jade Wind
		123904, -- Invoke Xuen, the White Tiger	
		115213, -- Avert Harm
		122057, -- Clash
		115308, -- Elusive Brew
		115295, -- Guard
		121253, -- Keg Smash
		115315, -- Summon Black Ox Statue
		
	},
	["RACE"] = {
		["Orc"] = {
			33697, -- Orc Blood Fury Shaman
			33702, -- Orc Blood Fury Warlock
			20572, -- Orc Blood Fury AP
		},
		["BloodElf"] = {
			25046, -- Blood Elf Arcane Torrent Rogue
			--50613, -- BE AT DK
			--28730, -- BE AT Mana users
		},
		["Scourge"] = {		
			20577, -- Cannibalize
			7744,   -- Will of the Forsaken
		},
		["Tauren"] = {
			20549, -- War Stomp
		},
		["Troll"] = {
			26297, -- Berserking
		},
		["Goblin"] = {
			69070, -- Rocket Jump and Rocket Barrage
		},
		["Draenei"] = {
			59545, -- Gift of the Naaru DK
			59543, -- GotN Hunter
			59548, -- GotN Mage
			59542, -- GotN Paladin
			59544, -- GotN Priest
			59547, -- GotN Shaman
			28880, -- GotN Warrior
		},
		["Dwarf"] = {
			20594, -- Stoneform
		},
		["Gnome"] = {
			20589, -- Escape Artist
		},
		["Human"] = {
			59752, -- Every Man for Himself
		},
		["NightElf"] = {
			58984, -- Shadowmeld
		},
		["Worgen"] = {
			68992, -- Darkflight
			68996, -- Two Forms
		},
		["Pandaren"] = {
		},	
	},
	["PET"] = {
		-- Warlock
		6360, -- Succubus Whiplash
		7812, -- Voidwalker Sacrifice
		19647, -- Felhunter Spell Lock
		89766, -- Felguard Axe Toss
		89751, -- Felguard Felstorm
		30151, -- Felguard Pursuit
	},
}

local throttle = 0.2
local spells = {}
local frames = {}

local GetTime = GetTime
local pairs = pairs

local onUpdate

local function enableCooldown (self)
	self.enabled = true
	if (self.StatusBar) then
		self.StatusBar:Show()
		self.DurationText:Show()
	end
	if (self.Cooldown) then
		self.Cooldown:Show()
	end
	self:SetScript("OnUpdate", OnUpdate)
	OnUpdate(self,1)
	if (OzCooldownsOptions.Mode == "HIDE") then
		self:Show()
	else
		self.Icon:SetVertexColor(1,1,1,1)
		self:SetAlpha(1)
	end
end

local function disableCooldown(self)
	self.enabled = false
	if (OzCooldownsOptions.Mode == "HIDE") then
		self:Hide()
	else
		self.Icon:SetVertexColor(1,1,1,0.15)
		self:SetAlpha(0.2)
	end
	if (self.StatusBar) then
		self.StatusBar:Hide()
		self.DurationText:SetText("")
	end
	if (self.Cooldown) then
		self.Cooldown:Hide()
	end
	self:SetScript("OnUpdate", nil)
end

local function positionHide()
	local xSpacing, ySpacing = OzCooldownsOptions.Spacing, 0
	local anchorPoint = "TOPRIGHT"
	if (OzCooldownsOptions.Direction == "VERTICAL") then
		xSpacing = 0
		ySpacing = -OzCooldownsOptions.Spacing
		if OzCooldownsOptions.Display == "STATUSBAR" then ySpacing = -(OzCooldownsOptions.Spacing+8) end
		anchorPoint = "BOTTOMLEFT"
	end
	local lastFrame = OzCooldownFrame
	local index = 0
	for k,v in pairs(frames) do
		local frame = frames[k]

		if (GetSpellTexture(GetSpellInfo(frame.spell)) or select(2, UnitClass("player")) == "PRIEST")then
			local start, duration = GetSpellCooldown(frame.spell)
			frame.start = start
			frame.duration = duration
			if duration and duration > 1.5 then

				if ((select(2, UnitClass("player")) == "PRIEST") and (frame.spell == 88682 or frame.spell == 88684 or frame.spell == 88685)) then
					frame.Icon:SetTexture(GetSpellTexture(GetSpellInfo(88625)))
				else
					frame.Icon:SetTexture(GetSpellTexture(GetSpellInfo(frame.spell)))
				end
				frame:ClearAllPoints()
				if (index == 0) then
					frame:SetPoint("TOPLEFT", lastFrame, "TOPLEFT", xSpacing, ySpacing)
				else
					frame:SetPoint("TOPLEFT", lastFrame, anchorPoint, xSpacing, ySpacing)
				end
				if not frame.disabled then
					enableCooldown(frame)
				end
				lastFrame = frame
				index = index+1
			else
				if frame.enabled then
					disableCooldown(frame)
				end
			end
		end
	end
	if (OzCooldownsOptions.Direction == "HORIZONTAL") then
		OzCooldownFrame:SetWidth(OzCooldownsOptions.Size*index+(index+1)*xSpacing)
	else
		OzCooldownFrame:SetHeight(OzCooldownsOptions.Size*index+(index+1)*ySpacing)
	end
end

local function positionDim()
	local xSpacing, ySpacing = OzCooldownsOptions.Spacing, 0
	local anchorPoint = "TOPRIGHT"
	if (OzCooldownsOptions.Direction == "VERTICAL") then
		xSpacing = 0
		ySpacing = -OzCooldownsOptions.Spacing
		if OzCooldownsOptions.Display == "STATUSBAR" then ySpacing = -(OzCooldownsOptions.Spacing+8) end
		anchorPoint = "BOTTOMLEFT"
	end
	local lastFrame = OzCooldownFrame
	local index = 0
	for k,v in pairs(frames) do
		local frame = frames[k]

		if (GetSpellTexture(GetSpellInfo(frame.spell)) or select(2, UnitClass("player")) == "PRIEST")then
			local start, duration = GetSpellCooldown(frame.spell)
			frame.start = start
			frame.duration = duration
			if duration and duration > 1.5 then

				if ((select(2, UnitClass("player")) == "PRIEST") and (frame.spell == 88682 or frame.spell == 88684 or frame.spell == 88685)) then
					frame.Icon:SetTexture(GetSpellTexture(GetSpellInfo(88625)))
				else
					frame.Icon:SetTexture(GetSpellTexture(GetSpellInfo(frame.spell)))
				end
				frame:ClearAllPoints()
				if (index == 0) then
					frame:SetPoint("TOPLEFT", lastFrame, "TOPLEFT", xSpacing, ySpacing)
				else
					frame:SetPoint("TOPLEFT", lastFrame, anchorPoint, xSpacing, ySpacing)
				end
				if not frame.disabled then
					enableCooldown(frame)
				end
				lastFrame = frame
				index = index+1
			else
				if frame.enabled then
					disableCooldown(frame)
				end
			end
		end
	end
	if (OzCooldownsOptions.Direction == "HORIZONTAL") then
		OzCooldownFrame:SetWidth(OzCooldownsOptions.Size*index+(index+1)*xSpacing)
	else
		OzCooldownFrame:SetHeight(OzCooldownsOptions.Size*index+(index+1)*ySpacing)
	end
end


local function position()
	if (OzCooldownsOptions.Mode == "HIDE") then
		positionHide()
	else
		positionDim()
	end
end

-- Frames
local function createCooldownFrame(spell)
	local frame = CreateFrame("Frame", nil, UIParent)
	gUI:SetUITemplate(frame, "backdrop")
	frame:SetHeight(OzCooldownsOptions.Size)
	frame:SetWidth(OzCooldownsOptions.Size)
	frame:SetFrameStrata("MEDIUM")

	local icon = frame:CreateTexture()
	local spellInfo = GetSpellInfo(spell)
	if (not spellInfo) then return nil end
	local texture = GetSpellTexture(spellInfo)
	icon:SetPoint("TOPLEFT", frame, "TOPLEFT", 3, -3)
	icon:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -3, 3)

	if ((select(2, UnitClass("player")) == "PRIEST") and (spell == 88682 or spell == 88684 or spell == 88685)) then
		texture = GetSpellTexture(GetSpellInfo(88625))
	end

	if (not texture) then return nil end
	icon:SetTexture(texture)
	icon:SetTexCoord(0.08,0.92,0.08,0.92)
	frame.Icon = icon
	if (OzCooldownsOptions.Display == "STATUSBAR") then
		local durationText = frame:CreateFontString(nil, "OVERLAY")
		durationText:SetFont([[Interface\AddOns\OzCooldowns\OswaldRegular.ttf]], 11, "OUTLINE")
		durationText:SetTextColor(1,1,0,1)
		durationText:SetText("")
		durationText:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 2, 2)
		frame.DurationText = durationText

		local statusBar = CreateFrame("StatusBar", nil, frame, "TextStatusBar")
		statusBar:SetStatusBarTexture([[Interface\AddOns\OzCooldowns\gUIStatusBar.tga]])
		statusBar:GetStatusBarTexture():SetVertexColor(0.24,0.54,0.78);
		gUI:SetUITemplate(statusBar, "statusbar", true)

		statusBar:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 3, -5)
		statusBar:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -3, -9)
		statusBar:SetMinMaxValues(0, 1)
		frame.StatusBar = statusBar
	elseif (OzCooldownsOptions.Display == "SPIRAL") then
		local cooldown = CreateFrame("Cooldown",nil,frame)
		cooldown:SetAllPoints(icon)
		frame.Cooldown = cooldown
	end

	frame.lastupdate = 0
	frame.spell = spell
	frame.start = GetTime()
	frame.duration = 0

	disableCooldown(frame)
	return frame
end

local function HandleEvent(self, event, arg1)
	if event == "PLAYER_ENTERING_WORLD" then
		print("|cFF00FFFFOz|rCooldowns for |cFFFF7D0Ag|r|cFFFFBB00UI|r|cFFFFFFFF™|r by |cFFFF7D0AAzilroka|r  - Version: |cff1784d1"..GetAddOnMetadata("OzCooldowns", "Version").."|r Loaded!")
		self:UnregisterEvent(event)
	end
	if event == "ADDON_LOADED" or event == "PLAYER_TALENT_UPDATE" then
	if OzCooldownsOptions.Spacing == nil then OzCooldownsOptions.Spacing = 10 end
	if OzCooldownsOptions.Size == nil then OzCooldownsOptions.Size = 36 end
	if OzCooldownsOptions.Direction == nil then OzCooldownsOptions.Direction = "HORIZONTAL" end
	if OzCooldownsOptions.Display == nil then OzCooldownsOptions.Display = "STATUSBAR" end
	if OzCooldownsOptions.Mode == nil then OzCooldownsOptions.Mode = "HIDE" end
	if OzCooldownsOptions.Fade == nil then OzCooldownsOptions.Fade = 0 end
	if OzCooldownsOptions.FadeColorR == nil then OzCooldownsOptions.FadeColorR = 148 end
	if OzCooldownsOptions.FadeColorG == nil then OzCooldownsOptions.FadeColorG = 0 end
	if OzCooldownsOptions.FadeColorB == nil then OzCooldownsOptions.FadeColorB = 211 end
		for k, v in pairs(spells) do
			if GetSpellInfo(v) then
				frames[v] = frames[v] or createCooldownFrame(spells[k])
			else
				frames[v] = createCooldownFrame(spells[k])
			end
		end
		position()
	end

	if event == "SPELL_UPDATE_COOLDOWN" then
		position()
	end
end

-- Import Spells
spells = spellCooldowns[select(2, UnitClass("player"))]

local race = spellCooldowns["RACE"]
for i = 1, table.getn(race[select(2, UnitRace("player"))]) do
	table.insert(spells, race[select(2, UnitRace("player"))][i]);
end

local _, pra = UnitRace("player")
if select(2, UnitClass("player")) == "WARLOCK" or select(2, UnitClass("player")) == "HUNTER" then
	for i = 1, table.getn(spellCooldowns["PET"]) do
		table.insert(spells, spellCooldowns["PET"][i]);
	end
end

OnUpdate = function (self, elapsed)
	self.lastupdate = self.lastupdate + elapsed
	if self.lastupdate > throttle then
		local start, duration = GetSpellCooldown(self.spell)
		if duration and duration > 1.5 then
			local currentDuration = (start+duration-GetTime())
			local normalized = currentDuration/self.duration
			if (self.StatusBar) then
				self.StatusBar:SetValue(normalized)
				self.DurationText:SetText(math.floor(currentDuration))
				if OzCooldownsOptions.Fade == 0 then
					self.StatusBar:GetStatusBarTexture():SetVertexColor(0.24,0.54,0.78)
				elseif OzCooldownsOptions.Fade == 1 then
					self.StatusBar:GetStatusBarTexture():SetVertexColor(1-normalized, normalized, 0/255)
				elseif OzCooldownsOptions.Fade == 2 then	
					self.StatusBar:GetStatusBarTexture():SetVertexColor(normalized, 1-normalized, 0/255)
				elseif OzCooldownsOptions.Fade == 3 then
					self.StatusBar:GetStatusBarTexture():SetVertexColor(OzCooldownsOptions.FadeColorR/255, OzCooldownsOptions.FadeColorG/255, OzCooldownsOptions.FadeColorB/255)
				end
			end
			if (self.Cooldown) then
				self.Cooldown:SetCooldown(start, duration)
			end
		else
			if self.enabled then
				disableCooldown(self)
			end
			position()
		end
		self.lastupdate = 0
	end
end

OzCooldownsMover = CreateFrame("Frame", "OzCooldownsMover", UIParent)
OzCooldownsMover:EnableMouse(true)
OzCooldownsMover:SetHeight(50)
OzCooldownsMover:SetWidth(120)
OzCooldownsMover:SetFrameStrata("HIGH")
gUI:SetUITemplate(OzCooldownsMover, "backdrop")
OzCooldownsMover:SetBackdropBorderColor(1, 0, 0)
OzCooldownsMover:Hide()
OzCooldownsMover:SetPoint("BOTTOM",UIParent,"BOTTOM",0, 360)
OzCooldownsMover:SetMovable()
OzCooldownsMover:RegisterForDrag("LeftButton")
OzCooldownsMover:SetScript("OnDragStart", function(self) self:StartMoving() end)
OzCooldownsMover:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
OzCooldownsMoverText = OzCooldownsMover:CreateFontString(nil, "OVERLAY")
OzCooldownsMoverText:SetFont([[Interface\AddOns\OzCooldowns\OswaldRegular.ttf]], 12, "OUTLINE")
OzCooldownsMoverText:SetText("OzCooldowns Mover")
OzCooldownsMoverText:SetPoint("CENTER")

OzCooldownFrame = CreateFrame("Frame", "OzCDAnchor", OzCooldownsMover)
OzCooldownFrame:SetFrameStrata("BACKGROUND")
OzCooldownFrame:SetHeight(40)
OzCooldownFrame:SetWidth(40)
OzCooldownFrame:SetPoint("TOP", OzCooldownsMover, "TOP", 0, -2)
OzCooldownFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
OzCooldownFrame:RegisterEvent("ADDON_LOADED")
OzCooldownFrame:RegisterEvent("SPELL_UPDATE_COOLDOWN")
OzCooldownFrame:RegisterEvent("PLAYER_TALENT_UPDATE")
OzCooldownFrame:SetScript("OnEvent", HandleEvent)

OzCooldownsOptionsFrame = CreateFrame("Frame", "OzCooldownsOptionsFrame", UIParent)
OzCooldownsOptionsFrame:Hide()
gUI:SetUITemplate(OzCooldownsOptionsFrame, "backdrop")
OzCooldownsOptionsFrame:SetWidth(200)
OzCooldownsOptionsFrame:SetHeight(300)
OzCooldownsOptionsFrame:SetPoint("CENTER",UIParent,"CENTER",0, 0)
OzCooldownsOptionsFrame:EnableMouse(true)
OzCooldownsOptionsFrame:SetMovable()
OzCooldownsOptionsFrame:RegisterForDrag("LeftButton")
OzCooldownsOptionsFrame:SetScript("OnDragStart", function(self) self:StartMoving() end)
OzCooldownsOptionsFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
OzCooldownsOptionsFrameText = OzCooldownsOptionsFrame:CreateFontString(nil, "OVERLAY")
OzCooldownsOptionsFrameText:SetFont([[Interface\AddOns\OzCooldowns\OswaldRegular.ttf]], 14, "OUTLINE")
OzCooldownsOptionsFrameText:SetText("OzCooldowns Options")
OzCooldownsOptionsFrameText:SetPoint("TOP", 0, -6)
OzCooldownsOptionsFrame:SetScript("OnShow", function()
	OzCooldownsOptionsFrameSizeSlider:SetValue(OzCooldownsOptions.Size)
	OzCooldownsOptionsFrameSizeSliderText:SetText("Size: "..OzCooldownsOptions.Size)
	OzCooldownsOptionsFrameSpacingSlider:SetValue(OzCooldownsOptions.Spacing)
	OzCooldownsOptionsFrameSpacingSliderText:SetText("Spacing: "..OzCooldownsOptions.Spacing)
	OzCooldownsOptionsFrameHorizontalButton.text:SetFont([[Interface\AddOns\OzCooldowns\OswaldRegular.ttf]], 12, "OUTLINE")
	OzCooldownsOptionsFrameVerticalButton.text:SetFont([[Interface\AddOns\OzCooldowns\OswaldRegular.ttf]], 12, "OUTLINE")
	OzCooldownsOptionsFrameSpiralButton.text:SetFont([[Interface\AddOns\OzCooldowns\OswaldRegular.ttf]], 12, "OUTLINE")
	OzCooldownsOptionsFrameStatusBarButton.text:SetFont([[Interface\AddOns\OzCooldowns\OswaldRegular.ttf]], 12, "OUTLINE")
	OzCooldownsOptionsFrameDimButton.text:SetFont([[Interface\AddOns\OzCooldowns\OswaldRegular.ttf]], 12, "OUTLINE")
	OzCooldownsOptionsFrameHideButton.text:SetFont([[Interface\AddOns\OzCooldowns\OswaldRegular.ttf]], 12, "OUTLINE")
	OzCooldownsOptionsFrameFade0Button.text:SetFont([[Interface\AddOns\OzCooldowns\OswaldRegular.ttf]], 12, "OUTLINE")
	OzCooldownsOptionsFrameFade1Button.text:SetFont([[Interface\AddOns\OzCooldowns\OswaldRegular.ttf]], 12, "OUTLINE")
	OzCooldownsOptionsFrameFade2Button.text:SetFont([[Interface\AddOns\OzCooldowns\OswaldRegular.ttf]], 12, "OUTLINE")
	OzCooldownsOptionsFrameHorizontalButton.text:SetText("Horizontal")
	OzCooldownsOptionsFrameVerticalButton.text:SetText("Vertical")
	OzCooldownsOptionsFrameSpiralButton.text:SetText("Spiral")
	OzCooldownsOptionsFrameStatusBarButton.text:SetText("StatusBar")
	OzCooldownsOptionsFrameDimButton.text:SetText("Dim")
	OzCooldownsOptionsFrameHideButton.text:SetText("Hide")
	OzCooldownsOptionsFrameFade0Button.text:SetText("Blue")
	OzCooldownsOptionsFrameFade1Button.text:SetText("Green\nto\nRed")
	OzCooldownsOptionsFrameFade2Button.text:SetText("Red\nto\nGreen")
	OzCooldownsOptionsFrameFadeColorREditBox.text:SetFont([[Interface\AddOns\OzCooldowns\OswaldRegular.ttf]], 12, "OUTLINE")
	OzCooldownsOptionsFrameFadeColorREditBox.text:SetText("Red")
	OzCooldownsOptionsFrameFadeColorREditBox:SetText(OzCooldownsOptions.FadeColorR)
	OzCooldownsOptionsFrameFadeColorREditBox.text2:SetFont([[Interface\AddOns\OzCooldowns\OswaldRegular.ttf]], 12, "OUTLINE")
	OzCooldownsOptionsFrameFadeColorREditBox.text2:SetText("Color (0-255)")
	OzCooldownsOptionsFrameFadeColorGEditBox.text:SetFont([[Interface\AddOns\OzCooldowns\OswaldRegular.ttf]], 12, "OUTLINE")
	OzCooldownsOptionsFrameFadeColorGEditBox.text:SetText("Green")
	OzCooldownsOptionsFrameFadeColorGEditBox:SetText(OzCooldownsOptions.FadeColorG)
	OzCooldownsOptionsFrameFadeColorBEditBox.text:SetFont([[Interface\AddOns\OzCooldowns\OswaldRegular.ttf]], 12, "OUTLINE")
	OzCooldownsOptionsFrameFadeColorBEditBox.text:SetText("Blue")
	OzCooldownsOptionsFrameFadeColorBEditBox:SetText(OzCooldownsOptions.FadeColorB)
	if not OzCooldownsOptionsFrameHandled then
		gUI:SetUITemplate(OzCooldownsOptionsFrameSizeSlider, "slider")
		gUI:SetUITemplate(OzCooldownsOptionsFrameSpacingSlider, "slider")
		OzCooldownsOptionsFrameHandled = true
	end
end)

OzCooldownsOptionsFrameSizeSlider = CreateFrame("Slider", "OzCooldownsOptionsFrameSizeSlider", OzCooldownsOptionsFrame, "OptionsSliderTemplate")
OzCooldownsOptionsFrameSizeSlider:SetSize(100, 14)
OzCooldownsOptionsFrameSizeSlider:SetPoint("TOP", OzCooldownsOptionsFrame, "TOP", 0, -40)
OzCooldownsOptionsFrameSizeSlider:SetOrientation("HORIZONTAL")
OzCooldownsOptionsFrameSizeSlider:SetMinMaxValues(20, 60)
OzCooldownsOptionsFrameSizeSlider:SetValueStep(1)
OzCooldownsOptionsFrameSizeSliderLow:SetText("20")
OzCooldownsOptionsFrameSizeSliderHigh:SetText("60")
OzCooldownsOptionsFrameSizeSlider:SetScript("OnValueChanged", function(self, value)
	OzCooldownsOptions.Size = value
	OzCooldownsOptionsFrameSizeSliderText:SetText("Size: "..OzCooldownsOptions.Size)
end)

OzCooldownsOptionsFrameSpacingSlider = CreateFrame("Slider", "OzCooldownsOptionsFrameSpacingSlider", OzCooldownsOptionsFrame, "OptionsSliderTemplate")
OzCooldownsOptionsFrameSpacingSlider:SetSize(100, 14)
OzCooldownsOptionsFrameSpacingSlider:SetPoint("TOP", OzCooldownsOptionsFrame, "TOP", 0, -80)
OzCooldownsOptionsFrameSpacingSlider:SetOrientation("HORIZONTAL")
OzCooldownsOptionsFrameSpacingSlider:SetMinMaxValues(0, 20)
OzCooldownsOptionsFrameSpacingSlider:SetValueStep(1)
OzCooldownsOptionsFrameSpacingSliderLow:SetText("0")
OzCooldownsOptionsFrameSpacingSliderHigh:SetText("20")
OzCooldownsOptionsFrameSpacingSlider:SetScript("OnValueChanged", function(self, value)
	OzCooldownsOptions.Spacing = value
	OzCooldownsOptionsFrameSpacingSliderText:SetText("Spacing: "..OzCooldownsOptions.Spacing)
end)

OzCooldownsOptionsFrameHorizontalButton = CreateFrame("Button", "OzCooldownsOptionsFrameHorizontalButton", OzCooldownsOptionsFrame)
OzCooldownsOptionsFrameHorizontalButton:SetPoint("BOTTOMRIGHT", OzCooldownsOptionsFrame, "BOTTOMRIGHT", -15, 155)
OzCooldownsOptionsFrameHorizontalButton:SetSize(16,16)
OzCooldownsOptionsFrameHorizontalButton:SetBackdrop({bgFile = [[Interface\AddOns\OzCooldowns\gUIStatusBar.tga]], edgeFile = nil, tile = false, tileSize = 0, edgeSize = 0, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
OzCooldownsOptionsFrameHorizontalButton.text = OzCooldownsOptionsFrameHorizontalButton:CreateFontString(nil, "OVERLAY")
OzCooldownsOptionsFrameHorizontalButton.text:SetPoint("RIGHT", OzCooldownsOptionsFrameHorizontalButton, "LEFT", -5, 0)
OzCooldownsOptionsFrameHorizontalButton:SetScript("OnUpdate", function(self)
	if (OzCooldownsOptions.Direction == "Horizontal") then
		self:SetBackdropColor(0.11,0.66,0.11,1)
	else
		self:SetBackdropColor(0.68,0.14,0.14,1)
	end
end)
OzCooldownsOptionsFrameHorizontalButton:SetScript("OnClick", function(self)
	OzCooldownsOptions.Direction = "Horizontal"
end)

OzCooldownsOptionsFrameVerticalButton = CreateFrame("Button", "OzCooldownsOptionsFrameVerticalButton", OzCooldownsOptionsFrame)
OzCooldownsOptionsFrameVerticalButton:SetPoint("BOTTOMLEFT", OzCooldownsOptionsFrame, "BOTTOMLEFT", 15, 155)
OzCooldownsOptionsFrameVerticalButton:SetSize(16,16)
OzCooldownsOptionsFrameVerticalButton:SetBackdrop({bgFile = [[Interface\AddOns\OzCooldowns\gUIStatusBar.tga]], edgeFile = nil, tile = false, tileSize = 0, edgeSize = 0, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
OzCooldownsOptionsFrameVerticalButton.text = OzCooldownsOptionsFrameVerticalButton:CreateFontString(nil, "OVERLAY")
OzCooldownsOptionsFrameVerticalButton.text:SetPoint("LEFT", OzCooldownsOptionsFrameVerticalButton, "RIGHT", 5, 0)
OzCooldownsOptionsFrameVerticalButton:SetScript("OnUpdate", function(self)
	if (OzCooldownsOptions.Direction == "Vertical") then
		self:SetBackdropColor(0.11,0.66,0.11,1)
	else
		self:SetBackdropColor(0.68,0.14,0.14,1)
	end
end)
OzCooldownsOptionsFrameVerticalButton:SetScript("OnClick", function(self)
	OzCooldownsOptions.Direction = "Vertical"
end)

OzCooldownsOptionsFrameSpiralButton = CreateFrame("Button", "OzCooldownsOptionsFrameSpiralButton", OzCooldownsOptionsFrame)
OzCooldownsOptionsFrameSpiralButton:SetPoint("BOTTOMLEFT", OzCooldownsOptionsFrame, "BOTTOMLEFT", 15, 135)
OzCooldownsOptionsFrameSpiralButton:SetSize(16,16)
OzCooldownsOptionsFrameSpiralButton:SetBackdrop({bgFile = [[Interface\AddOns\OzCooldowns\gUIStatusBar.tga]], edgeFile = nil, tile = false, tileSize = 0, edgeSize = 0, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
OzCooldownsOptionsFrameSpiralButton.text = OzCooldownsOptionsFrameSpiralButton:CreateFontString(nil, "OVERLAY")
OzCooldownsOptionsFrameSpiralButton.text:SetPoint("LEFT", OzCooldownsOptionsFrameSpiralButton, "RIGHT", 5, 0)
OzCooldownsOptionsFrameSpiralButton:SetScript("OnUpdate", function(self)
	if (OzCooldownsOptions.Direction == "SPIRAL") then
		self:SetBackdropColor(0.11,0.66,0.11,1)
	else
		self:SetBackdropColor(0.68,0.14,0.14,1)
	end
end)
OzCooldownsOptionsFrameSpiralButton:SetScript("OnClick", function(self)
	OzCooldownsOptions.Direction = "SPIRAL"
end)

OzCooldownsOptionsFrameStatusBarButton = CreateFrame("Button", "OzCooldownsOptionsFrameStatusBarButton", OzCooldownsOptionsFrame)
OzCooldownsOptionsFrameStatusBarButton:SetPoint("BOTTOMRIGHT", OzCooldownsOptionsFrame, "BOTTOMRIGHT", -15, 135)
OzCooldownsOptionsFrameStatusBarButton:SetSize(16,16)
OzCooldownsOptionsFrameStatusBarButton:SetBackdrop({bgFile = [[Interface\AddOns\OzCooldowns\gUIStatusBar.tga]], edgeFile = nil, tile = false, tileSize = 0, edgeSize = 0, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
OzCooldownsOptionsFrameStatusBarButton.text = OzCooldownsOptionsFrameStatusBarButton:CreateFontString(nil, "OVERLAY")
OzCooldownsOptionsFrameStatusBarButton.text:SetPoint("RIGHT", OzCooldownsOptionsFrameStatusBarButton, "LEFT", -5, 0)
OzCooldownsOptionsFrameStatusBarButton:SetScript("OnUpdate", function(self)
	if (OzCooldownsOptions.Direction == "STATUSBAR") then
		self:SetBackdropColor(0.11,0.66,0.11,1)
	else
		self:SetBackdropColor(0.68,0.14,0.14,1)
	end
end)
OzCooldownsOptionsFrameStatusBarButton:SetScript("OnClick", function(self)
	OzCooldownsOptions.Direction = "STATUSBAR"
end)

OzCooldownsOptionsFrameDimButton = CreateFrame("Button", "OzCooldownsOptionsFrameDimButton", OzCooldownsOptionsFrame)
OzCooldownsOptionsFrameDimButton:SetPoint("BOTTOMLEFT", OzCooldownsOptionsFrame, "BOTTOMLEFT", 15, 115)
OzCooldownsOptionsFrameDimButton:SetSize(16,16)
OzCooldownsOptionsFrameDimButton:SetBackdrop({bgFile = [[Interface\AddOns\OzCooldowns\gUIStatusBar.tga]], edgeFile = nil, tile = false, tileSize = 0, edgeSize = 0, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
OzCooldownsOptionsFrameDimButton.text = OzCooldownsOptionsFrameDimButton:CreateFontString(nil, "OVERLAY")
OzCooldownsOptionsFrameDimButton.text:SetPoint("LEFT", OzCooldownsOptionsFrameDimButton, "RIGHT", 5, 0)
OzCooldownsOptionsFrameDimButton:SetScript("OnUpdate", function(self)
	if (OzCooldownsOptions.Mode == "DIM") then
		self:SetBackdropColor(0.11,0.66,0.11,1)
	else
		self:SetBackdropColor(0.68,0.14,0.14,1)
	end
end)
OzCooldownsOptionsFrameDimButton:SetScript("OnClick", function(self)
	OzCooldownsOptions.Mode = "DIM"
end)

OzCooldownsOptionsFrameHideButton = CreateFrame("Button", "OzCooldownsOptionsFrameHideButton", OzCooldownsOptionsFrame)
OzCooldownsOptionsFrameHideButton:SetPoint("BOTTOMRIGHT", OzCooldownsOptionsFrame, "BOTTOMRIGHT", -15, 115)
OzCooldownsOptionsFrameHideButton:SetSize(16,16)
OzCooldownsOptionsFrameHideButton:SetBackdrop({bgFile = [[Interface\AddOns\OzCooldowns\gUIStatusBar.tga]], edgeFile = nil, tile = false, tileSize = 0, edgeSize = 0, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
OzCooldownsOptionsFrameHideButton.text = OzCooldownsOptionsFrameHideButton:CreateFontString(nil, "OVERLAY")
OzCooldownsOptionsFrameHideButton.text:SetPoint("RIGHT", OzCooldownsOptionsFrameHideButton, "LEFT", -5, 0)
OzCooldownsOptionsFrameHideButton:SetScript("OnUpdate", function(self)
	if (OzCooldownsOptions.Mode == "HIDE") then
		self:SetBackdropColor(0.11,0.66,0.11,1)
	else
		self:SetBackdropColor(0.68,0.14,0.14,1)
	end
end)
OzCooldownsOptionsFrameHideButton:SetScript("OnClick", function(self)
	OzCooldownsOptions.Mode = "HIDE"
end)

OzCooldownsOptionsFrameFade0Button = CreateFrame("Button", "OzCooldownsOptionsFrameFade0Button", OzCooldownsOptionsFrame)
OzCooldownsOptionsFrameFade0Button:SetPoint("BOTTOMLEFT", OzCooldownsOptionsFrame, "BOTTOMLEFT", 15, 95)
OzCooldownsOptionsFrameFade0Button:SetSize(16,16)
OzCooldownsOptionsFrameFade0Button:SetBackdrop({bgFile = [[Interface\AddOns\OzCooldowns\gUIStatusBar.tga]], edgeFile = nil, tile = false, tileSize = 0, edgeSize = 0, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
OzCooldownsOptionsFrameFade0Button.text = OzCooldownsOptionsFrameFade0Button:CreateFontString(nil, "OVERLAY")
OzCooldownsOptionsFrameFade0Button.text:SetPoint("TOP", OzCooldownsOptionsFrameFade0Button, "BOTTOM", 0, -2)
OzCooldownsOptionsFrameFade0Button:SetScript("OnUpdate", function(self)
	if (OzCooldownsOptions.Fade == 0) then
		self:SetBackdropColor(0.11,0.66,0.11,1)
	else
		self:SetBackdropColor(0.68,0.14,0.14,1)
	end
end)
OzCooldownsOptionsFrameFade0Button:SetScript("OnClick", function(self)
	OzCooldownsOptions.Fade = 0
end)

OzCooldownsOptionsFrameFade1Button = CreateFrame("Button", "OzCooldownsOptionsFrameFade1Button", OzCooldownsOptionsFrame)
OzCooldownsOptionsFrameFade1Button:SetPoint("BOTTOM", OzCooldownsOptionsFrame, "BOTTOM", 0, 95)
OzCooldownsOptionsFrameFade1Button:SetSize(16,16)
OzCooldownsOptionsFrameFade1Button:SetBackdrop({bgFile = [[Interface\AddOns\OzCooldowns\gUIStatusBar.tga]], edgeFile = nil, tile = false, tileSize = 0, edgeSize = 0, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
OzCooldownsOptionsFrameFade1Button.text = OzCooldownsOptionsFrameFade1Button:CreateFontString(nil, "OVERLAY")
OzCooldownsOptionsFrameFade1Button.text:SetPoint("TOP", OzCooldownsOptionsFrameFade1Button, "BOTTOM", 0, -2)
OzCooldownsOptionsFrameFade1Button:SetScript("OnUpdate", function(self)
	if (OzCooldownsOptions.Fade == 1) then
		self:SetBackdropColor(0.11,0.66,0.11,1)
	else
		self:SetBackdropColor(0.68,0.14,0.14,1)
	end
end)
OzCooldownsOptionsFrameFade1Button:SetScript("OnClick", function(self)
	OzCooldownsOptions.Fade = 1
end)

OzCooldownsOptionsFrameFade2Button = CreateFrame("Button", "OzCooldownsOptionsFrameFade2Button", OzCooldownsOptionsFrame)
OzCooldownsOptionsFrameFade2Button:SetPoint("BOTTOMRIGHT", OzCooldownsOptionsFrame, "BOTTOMRIGHT", -15, 95)
OzCooldownsOptionsFrameFade2Button:SetSize(16,16)
OzCooldownsOptionsFrameFade2Button:SetBackdrop({bgFile = [[Interface\AddOns\OzCooldowns\gUIStatusBar.tga]], edgeFile = nil, tile = false, tileSize = 0, edgeSize = 0, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
OzCooldownsOptionsFrameFade2Button.text = OzCooldownsOptionsFrameFade2Button:CreateFontString(nil, "OVERLAY")
OzCooldownsOptionsFrameFade2Button.text:SetPoint("TOP", OzCooldownsOptionsFrameFade2Button, "BOTTOM", 0, -2)
OzCooldownsOptionsFrameFade2Button:SetScript("OnUpdate", function(self)
	if (OzCooldownsOptions.Fade == 2) then
		self:SetBackdropColor(0.11,0.66,0.11,1)
	else
		self:SetBackdropColor(0.68,0.14,0.14,1)
	end
end)
OzCooldownsOptionsFrameFade2Button:SetScript("OnClick", function(self)
	OzCooldownsOptions.Fade = 2
end)

OzCooldownsOptionsFrameFadeColorREditBox = CreateFrame("EditBox", "OzCooldownsOptionsFrameFadeREditBox", OzCooldownsOptionsFrame)
OzCooldownsOptionsFrameFadeColorREditBox.text = OzCooldownsOptionsFrame:CreateFontString(nil, "OVERLAY")
OzCooldownsOptionsFrameFadeColorREditBox.text:SetPoint("BOTTOM", OzCooldownsOptionsFrameFadeREditBox, "TOP", 0, 0)
OzCooldownsOptionsFrameFadeColorREditBox.text2 = OzCooldownsOptionsFrame:CreateFontString(nil, "OVERLAY")
OzCooldownsOptionsFrameFadeColorREditBox.text2:SetPoint("BOTTOMLEFT", OzCooldownsOptionsFrame, "BOTTOMLEFT", 10, 16)
OzCooldownsOptionsFrameFadeColorREditBox:SetAutoFocus(false)
OzCooldownsOptionsFrameFadeColorREditBox:SetMultiLine(false)
OzCooldownsOptionsFrameFadeColorREditBox:SetWidth(30)
OzCooldownsOptionsFrameFadeColorREditBox:SetHeight(20)
OzCooldownsOptionsFrameFadeColorREditBox:SetMaxLetters(3)
OzCooldownsOptionsFrameFadeColorREditBox:SetTextInsets(3,0,0,0)
OzCooldownsOptionsFrameFadeColorREditBox:SetBackdrop({
	bgFile = "Interface\\ChatFrame\\ChatFrameBackground", 
	tiled = false,
})
OzCooldownsOptionsFrameFadeColorREditBox:SetBackdropColor(0,0,0,0.5)
OzCooldownsOptionsFrameFadeColorREditBox:SetBackdropBorderColor(0,0,0,1)
OzCooldownsOptionsFrameFadeColorREditBox:SetFontObject(GameFontHighlight)
OzCooldownsOptionsFrameFadeColorREditBox:SetPoint("BOTTOM", OzCooldownsOptionsFrame, "BOTTOM", 0, 10)
OzCooldownsOptionsFrameFadeColorREditBox:SetScript("OnEscapePressed", function(self) self:ClearFocus() self:SetText(OzCooldownsOptions.FadeColorR) end)
OzCooldownsOptionsFrameFadeColorREditBox:SetScript("OnEnterPressed", function(self)
	self:ClearFocus()
	OzCooldownsOptions.FadeColorR = self:GetText()
	OzCooldownsOptions.Fade = 3
end)

OzCooldownsOptionsFrameFadeColorGEditBox = CreateFrame("EditBox", "OzCooldownsOptionsFrameFadeGEditBox", OzCooldownsOptionsFrame)
OzCooldownsOptionsFrameFadeColorGEditBox.text = OzCooldownsOptionsFrame:CreateFontString(nil, "OVERLAY")
OzCooldownsOptionsFrameFadeColorGEditBox.text:SetPoint("BOTTOM", OzCooldownsOptionsFrameFadeGEditBox, "TOP", 0, 0)
OzCooldownsOptionsFrameFadeColorGEditBox:SetAutoFocus(false)
OzCooldownsOptionsFrameFadeColorGEditBox:SetMultiLine(false)
OzCooldownsOptionsFrameFadeColorGEditBox:SetWidth(30)
OzCooldownsOptionsFrameFadeColorGEditBox:SetHeight(20)
OzCooldownsOptionsFrameFadeColorGEditBox:SetMaxLetters(3)
OzCooldownsOptionsFrameFadeColorGEditBox:SetTextInsets(3,0,0,0)
OzCooldownsOptionsFrameFadeColorGEditBox:SetBackdrop({
	bgFile = "Interface\\ChatFrame\\ChatFrameBackground", 
	tiled = false,
})
OzCooldownsOptionsFrameFadeColorGEditBox:SetBackdropColor(0,0,0,0.5)
OzCooldownsOptionsFrameFadeColorGEditBox:SetBackdropBorderColor(0,0,0,1)
OzCooldownsOptionsFrameFadeColorGEditBox:SetFontObject(GameFontHighlight)
OzCooldownsOptionsFrameFadeColorGEditBox:SetPoint("LEFT", OzCooldownsOptionsFrameFadeColorREditBox, "RIGHT", 10, 0)
OzCooldownsOptionsFrameFadeColorGEditBox:SetScript("OnEscapePressed", function(self) self:ClearFocus() self:SetText(OzCooldownsOptions.FadeColorG) end)
OzCooldownsOptionsFrameFadeColorGEditBox:SetScript("OnEnterPressed", function(self)
	self:ClearFocus()
	OzCooldownsOptions.FadeColorG = self:GetText()
	OzCooldownsOptions.Fade = 3
end)

OzCooldownsOptionsFrameFadeColorBEditBox = CreateFrame("EditBox", "OzCooldownsOptionsFrameFadeBEditBox", OzCooldownsOptionsFrame)
OzCooldownsOptionsFrameFadeColorBEditBox.text = OzCooldownsOptionsFrame:CreateFontString(nil, "OVERLAY")
OzCooldownsOptionsFrameFadeColorBEditBox.text:SetPoint("BOTTOM", OzCooldownsOptionsFrameFadeBEditBox, "TOP", 0, 0)
OzCooldownsOptionsFrameFadeColorBEditBox:SetAutoFocus(false)
OzCooldownsOptionsFrameFadeColorBEditBox:SetMultiLine(false)
OzCooldownsOptionsFrameFadeColorBEditBox:SetWidth(30)
OzCooldownsOptionsFrameFadeColorBEditBox:SetHeight(20)
OzCooldownsOptionsFrameFadeColorBEditBox:SetMaxLetters(3)
OzCooldownsOptionsFrameFadeColorBEditBox:SetTextInsets(3,0,0,0)
OzCooldownsOptionsFrameFadeColorBEditBox:SetBackdrop({
	bgFile = "Interface\\ChatFrame\\ChatFrameBackground", 
	tiled = false,
})
OzCooldownsOptionsFrameFadeColorBEditBox:SetBackdropColor(0,0,0,0.5)
OzCooldownsOptionsFrameFadeColorBEditBox:SetBackdropBorderColor(0,0,0,1)
OzCooldownsOptionsFrameFadeColorBEditBox:SetFontObject(GameFontHighlight)
OzCooldownsOptionsFrameFadeColorBEditBox:SetPoint("LEFT", OzCooldownsOptionsFrameFadeColorGEditBox, "RIGHT", 10, 0)
OzCooldownsOptionsFrameFadeColorBEditBox:SetScript("OnEscapePressed", function(self) self:ClearFocus() self:SetText(OzCooldownsOptions.FadeColorB) end)
OzCooldownsOptionsFrameFadeColorBEditBox:SetScript("OnEnterPressed", function(self)
	self:ClearFocus()
	OzCooldownsOptions.FadeColorB = self:GetText()
	OzCooldownsOptions.Fade = 3
end)
	
SLASH_OZCOOLDOWNS1 = "/ozcd"
SlashCmdList["OZCOOLDOWNS"] = function(arg)
	if arg == "unlock" or arg == "lock" or arg == "move" then
		if OzCooldownsMover:IsShown() then
			OzCooldownsMover:Hide()
		else
			OzCooldownsMover:Show()
		end
	elseif arg == "options" then
		if OzCooldownsOptionsFrame:IsShown() then
			OzCooldownsOptionsFrame:Hide()
		else
			OzCooldownsOptionsFrame:Show()
		end
	elseif arg == "" then
		print("|cFF00FFFFOz|rCooldowns Options.")
		print("/ozcd unlock - Allow you to move |cFF00FFFFOz|rCooldowns.")
		print("/ozcd options - Shows the |cFF00FFFFOz|rCooldowns Options.")
	end
end