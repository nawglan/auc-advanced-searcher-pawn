--[[
  Auctioneer Advanced - Search UI - Searcher Pawn
  Version: 1.2.1 (Xit)
  Revision: $Id: SearcherPawn.lua 1.2.1 20101119 Xit $
  URL: http://wow.curse.com/downloads/wow-addons/details/auc-advanced-searcher-pawn.aspx

  This is a plugin module for the SearchUI that assists in searching by evaluating items with Pawn

  License:
    This program is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License
    as published by the Free Software Foundation; either version 2
    of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program(see GPL.txt); if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

  Note:
    This AddOn's source code is specifically designed to work with
    World of Warcraft's interpreted AddOn system.
    You have an implicit license to use this AddOn with these facilities
    since that is its designated purpose as per:
    http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat
--]]
-- Create a new instance of our lib with our parent
local lib, parent, private = AucSearchUI.NewSearcher("Pawn-Ru")

if not lib then
  return
end

local print,decode,_,_,replicate,empty,_,_,_,debugPrint,fill = AucAdvanced.GetModuleLocals()
local get,set,default,Const = AucSearchUI.GetSearchLocals()

Localization.SetAddonDefault("Auc-Searcher-Pawn", "enUS");

-------------------------------------------------------------------
-- Set the name of the Auctioneer Search Option
lib.tabname = "Pawn"
-------------------------------------------------------------------

-------------------------------------------------------------------
-- Set our defaults
default("search.pawn.scalenum", "")
default("search.pawn.canuse", false)
default("search.pawn.force2h", false)
default("search.pawn.head", true)
default("search.pawn.neck", true)
default("search.pawn.shoulder", true)
default("search.pawn.back", true)
default("search.pawn.chest", true)
default("search.pawn.wrist", true)
default("search.pawn.hands", true)
default("search.pawn.waist", true)
default("search.pawn.legs", true)
default("search.pawn.feet", true)
default("search.pawn.finger", true)
default("search.pawn.trinket", true)
default("search.pawn.weapon", true)
default("search.pawn.offhand", true)
default("search.pawn.ranged", true)
-------------------------------------------------------------------

local function TEXT(key) return Localization.GetClientString("Auc-Searcher-Pawn", key) end

-------------------------------------------------------------------
-- DEBUGGING
local showdbg = false -- set to true to enable debugging
local showfalse = false
local showtrue = false

-- Sprinkle these throughout the code to debug.
-- Debug(false, string.format("%s [%s]", somevar, somevar))
-- Debug(true, string.format("%s [%s]", somevar, somevar))
--
-- Items with false for first debug message only get printed if showfalse above is true
-- Items with true for first debug message only get printed if showtrue above is true
-------------------------------------------------------------------

-------------------------------------------------------------------
-- Cache the Scale Table from Pawn
local scaletable = {}
-------------------------------------------------------------------

-------------------------------------------------------------------
-- Map between Auctioneer ipos and Pawn slot values
-------------------------------------------------------------------

local convertSlot = {
  {
    "HeadSlot", -- [1] mainslot
    nil, -- [2] otherslot
  }, -- [1] head
  {
    "NeckSlot", -- [1] mainslot
    nil, -- [2] otherslot
  }, -- [2] neck
  {
    "ShoulderSlot", -- [1] mainslot
    nil, -- [2] otherslot
  }, -- [3] shoulder
  {
    nil, -- [1] mainslot
    nil, -- [2] otherslot
  }, -- [4] shirt
  {
    "ChestSlot", -- [1] mainslot
    nil, -- [2] otherslot
  }, -- [5] chest
  {
    "WaistSlot", -- [1] mainslot
    nil, -- [2] otherslot
  }, -- [6] waist
  {
    "LegsSlot", -- [1] mainslot
    nil, -- [2] otherslot
  }, -- [7] legs
  {
    "FeetSlot", -- [1] mainslot
    nil, -- [2] otherslot
  }, -- [8] feet
  {
    "WristSlot", -- [1] mainslot
    nil, -- [2] otherslot
  }, -- [9] wrist
  {
    "HandsSlot", -- [1] mainslot
    nil, -- [2] otherslot
  }, -- [10] hand
  {
    "Finger0Slot", -- [1] mainslot
    "Finger1Slot", -- [2] otherslot
  }, -- [11] finger
  {
    "Trinket0Slot", -- [1] mainslot
    "Trinket1Slot", -- [2] otherslot
  }, -- [12] trinket
  {
    "MainHandSlot", -- [1] mainslot
    "SecondaryHandSlot", -- [2] otherslot
  }, -- [13] weapon
  {
    "SecondaryHandSlot", -- [1] mainslot
    nil, -- [2] otherslot
  }, -- [14] shield
  {
    "RangedSlot", -- [1] mainslot
    nil, -- [2] otherslot
  }, -- [15] rangedright
  {
    "BackSlot", -- [1] mainslot
    nil, -- [2] otherslot
  }, -- [16] cloak
  {
    "MainHandSlot", -- [1] mainslot
    nil, -- [2] otherslot
  }, -- [17] 2hweapon
  {
    nil, -- [1] mainslot
    nil, -- [2] otherslot
  }, -- [18] bag
  {
    nil, -- [1] mainslot
    nil, -- [2] otherslot
  }, -- [19] tabard
  {
    "ChestSlot", -- [1] mainslot
    nil, -- [2] otherslot
  }, -- [20] robe
  {
    "MainHandSlot", -- [1] mainslot
    nil, -- [2] otherslot
  }, -- [21] weaponmainhand
  {
    "SecondaryHandSlot", -- [1] mainslot
    nil, -- [2] otherslot
  }, -- [22] weaponoffhand
  {
    "SecondaryHandSlot", -- [1] mainslot
    nil, -- [2] otherslot
  }, -- [23] holdable
  {
    nil, -- [1] mainslot
    nil, -- [2] otherslot
  }, -- [24] ammo deprecated
  {
    "RangedSlot", -- [1] mainslot
    nil, -- [2] otherslot
  }, -- [25] thrown
  {
    "RangedSlot", -- [1] mainslot
    nil, -- [2] otherslot
  }, -- [26] ranged
}
-------------------------------------------------------------------

-------------------------------------------------------------------
-- Debug Output Function
-------------------------------------------------------------------
local function Debug(Reason, Text)
  if Text == nil then
    Text = "nil value"
  end

  if not showdbg then
    return
  end

  if not showfalse and Reason == false then
    return
  end

  if not showtrue and Reason == true then
    return
  end

  print(string.format("%s", Text))
end

-------------------------------------------------------------------
-- Cache for valid scales
local validScales = {}
-------------------------------------------------------------------

-------------------------------------------------------------------
-- Refetch Pawn Scales
-------------------------------------------------------------------
function updateScales()
  -- reset the valid scale cache
  validScales = {}

  local scalecopy = {}
  scaletable = PawnGetAllScales()

  table.insert(scalecopy, { 1, "" })

  for i,j in pairs(scaletable) do
    table.insert(scalecopy, { i+1, j })
  end

  return scalecopy
end

-------------------------------------------------------------------
-- This function is automatically called when we need to create
-- our search configuration
-------------------------------------------------------------------
function lib:MakeGuiConfig(gui)
  -- Get our tab and populate it with our controls
  local id = gui:AddTab(lib.tabname, "Searchers")

  -- Add the help
  gui:AddSearcher("Pawn", TEXT("MAIN_TITLE"), 100)
  gui:AddHelp(id, TEXT("HELP_ID"), TEXT("HELP_QUESTION"), TEXT("HELP_ANSWER"))

  -- Add Header
  gui:AddControl(id, "Header", 0, TEXT("CONFIG_HEADER"))

  -- Store Top of Column position
  local last = gui:GetLast(id)
  gui:AddControl(id, "Subhead", 0, TEXT("OPTIONS"))
  gui:AddControl(id, "Subhead", 0, TEXT("SCALE_SELECT"))
  gui:AddControl(id, "Selectbox",  0, 1, updateScales, "search.pawn.scalenum", "")
  gui:AddTip(id, TEXT("SCALE_SELECT_TIP"))
  gui:AddControl(id, "Checkbox",   0, 0, "search.pawn.canuse", TEXT("USEABLE_ONLY"))
  gui:AddTip(id, TEXT("USEABLE_ONLY_TIP"))
  gui:AddControl(id, "Checkbox",   0, 0, "search.pawn.impoor", TEXT("AFFORD_ONLY"))
  gui:AddTip(id, TEXT("AFFORD_ONLY_TIP"))
  gui:AddControl(id, "Checkbox",   0, 0, "search.pawn.buyout", TEXT("USE_BUYOUT"))
  gui:AddTip(id, TEXT("USE_BUYOUT_TIP"))

  -- Reposition to top for next column
  gui:SetLast(id,last)
  gui:AddControl(id, "Subhead", 0.40, TEXT("INCLUDE_IN_SEARCH"))

  -- Store new Top of Column position
  last = gui:GetLast(id)
  gui:AddControl(id, "Checkbox",   0.40, 0, "search.pawn.head", TEXT("SHOW_HEAD"))
  gui:AddControl(id, "Checkbox",   0.40, 0, "search.pawn.neck", TEXT("SHOW_NECK"))
  gui:AddControl(id, "Checkbox",   0.40, 0, "search.pawn.shoulder", TEXT("SHOW_SHOULDER"))
  gui:AddControl(id, "Checkbox",   0.40, 0, "search.pawn.back", TEXT("SHOW_BACK"))
  gui:AddControl(id, "Checkbox",   0.40, 0, "search.pawn.chest", TEXT("SHOW_CHEST"))
  gui:AddControl(id, "Checkbox",   0.40, 0, "search.pawn.wrist", TEXT("SHOW_WRIST"))
  gui:AddControl(id, "Checkbox",   0.40, 0, "search.pawn.hands", TEXT("SHOW_HANDS"))
  gui:AddControl(id, "Checkbox",   0.40, 0, "search.pawn.waist", TEXT("SHOW_WAIST"))

  -- Reposition to top for next column
  gui:SetLast(id,last)
  gui:AddControl(id, "Checkbox",   0.65, 0, "search.pawn.legs", TEXT("SHOW_LEGS"))
  gui:AddControl(id, "Checkbox",   0.65, 0, "search.pawn.feet", TEXT("SHOW_FEET"))
  gui:AddControl(id, "Checkbox",   0.65, 0, "search.pawn.finger", TEXT("SHOW_FINGER"))
  gui:AddControl(id, "Checkbox",   0.65, 0, "search.pawn.trinket", TEXT("SHOW_TRINKET"))
  gui:AddControl(id, "Checkbox",   0.65, 0, "search.pawn.weapon", TEXT("SHOW_WEAPON"))
  gui:AddControl(id, "Checkbox",   0.65, 2, "search.pawn.force2h", TEXT("FORCE2H_WEAP"))
  gui:AddTip(id, TEXT("FORCE2H_TIP"))
  gui:AddControl(id, "Checkbox",   0.65, 0, "search.pawn.offhand", TEXT("SHOW_OFFHAND"))
  gui:AddControl(id, "Checkbox",   0.65, 0, "search.pawn.ranged", TEXT("SHOW_RANGED"))
end

-------------------------------------------------------------------
-- Global cache
local _scalename = ""
-------------------------------------------------------------------

-------------------------------------------------------------------
-- Return the name of the scale
-------------------------------------------------------------------
function GetScaleName(scalenum)
  local scalename = ""

  -- Does the stored scale exist
  for i, j in pairs(scaletable) do
    if i == (scalenum - 1) then -- subtract 1, due to offset introduced in menu
      scalename = j
      break
    end
  end

  -- Store in cache for faster lookups later
  _scalename = scalename

  return _scalename
end

-------------------------------------------------------------------
-- Validate the user's choice of scale
-------------------------------------------------------------------
function ValidateScale()
  -- Did the user pick a scale
  local scalenum = get("search.pawn.scalenum")

  -- Error, undefined
  if not scalenum then
    return false
  end

  local isValid = validScales[scalenum]
  -- Check cache first, if we have validated this before
  -- we don't need to validate it now.
  if not isValid then
    local scalename = GetScaleName(scalenum)

    -- Error, undefined
    if scalename == "" then
      return false
    end

    local scalefound = PawnDoesScaleExist(scalename)
    -- Error, Pawn doesn't recognize the scale number
    if not scalefound or scalefound ~= true then
      return false
    end

    -- Cache validation if true
    validScales[scalenum] = true
  end

  return true
end

-------------------------------------------------------------------
-- Convert RGB to Hex
-------------------------------------------------------------------
local function RGBPercToHex(r, g, b)
  r = r <= 1 and r >= 0 and r or 0
  g = g <= 1 and g >= 0 and g or 0
  b = b <= 1 and b >= 0 and b or 0
  return string.format("%02x%02x%02x", r*255, g*255, b*255)
end

-------------------------------------------------------------------
-- Create and scan a tooltip looking for red text.
-------------------------------------------------------------------
local function CanUse(link)
  MyScanningTooltip:ClearLines()
  MyScanningTooltip:SetHyperlink(link)
  local retval = true

  for i=1,MyScanningTooltip:NumLines() do
    --Check left side text to see if it is red, if so, can't use
    local mytext = getglobal("MyScanningTooltipTextLeft" .. i)
    local text = mytext:GetText()
    if (text) then
      local r,g,b,a = mytext:GetTextColor()
      local hex = RGBPercToHex(r,g,b)
      if (hex == "fe1f1f") then
        retval = false
      end
    end

    --Check right side text to see if it is red, if so, can't use
    local mytextr = getglobal("MyScanningTooltipTextRight" .. i)
    local textr = mytextr:GetText()
    if (textr) then
      local r,g,b,a = mytextr:GetTextColor()
      local hex = RGBPercToHex(r,g,b)
      if (hex == "fe1f1f") then
        retval = false
      end
    end
  end

  return retval
end

-------------------------------------------------------------------
-- Limit one-handed weapon checks to main hand unless class can dual wield
-------------------------------------------------------------------
local function CanDualWield()

  local pclass = UnitClass("player")
  local plevel = UnitLevel("player")

-- ShadowVall
-- Q:Do Warrior and Shaman get dualwield by specialization on level 10?
-- Q:How to manage Warrior talant Titan Grip for 2hweapon?

  if (pclass == TEXT("DEATH_KNIGHT") and plevel >= 20) then
    return true
  end

  if (pclass == TEXT("HUNTER") and plevel >= 20) then
    return true
  end

  if (pclass == TEXT("ROGUE") and plevel >= 1) then
    return true
  end

  if (pclass == TEXT("SHAMAN") and plevel >= 20) then
    return true
  end

  if (pclass == TEXT("WARRIOR") and plevel >= 20) then
    return true
  end

  return false
end

local slotCache = {};


local function CheckOrAddCacheSlot(SlotName)

-- TODO some error protection here

	if not slotCache[SlotName] then
		local slotId, textureName = GetInventorySlotInfo(SlotName)
		slotCache[SlotName] = slotId
	end
end -- function CheckOrAddCacheSlot(SlotName)
--------------------------------------------------------------------
-- Get Slot info, store it in cache and return
--------------------------------------------------------------------
local function GetCachedSlot(SlotName)

-- TODO some error protection here

	CheckOrAddCacheSlot(SlotName)

	return slotCache[SlotName]
end

-------------------------------------------------------------------
-- Convert between auctioneer equip positions and Pawn equip positions
-------------------------------------------------------------------
local function ConvertSlot(ipos,itype,subtype)
  local mainslot = nil
  local otherslot = nil

  -- Relics
  if (itype == TEXT("ARMOR")) and ((subtype == TEXT("TOTEMS")) or
                                   (subtype == TEXT("LIBRAMS")) or
                                   (subtype == TEXT("IDOLS")) or
                                   (subtype == TEXT("SIGILS")))
  then
	mainslot = GetCachedSlot("RangedSlot")
  else -- Not Relics
    local candual = CanDualWield()

    local slots = convertSlot[ipos]
    mainslot = slots[1]
    otherslot = slots[2]

    -- Ensure they can dual wield before
    -- allowing them to compare against offhand
	-- ShadowVall: Sorry, I dont understand code below:(  ipos=22 is offhand weapon. why You erase mainslot?
	if ipos == 22 and not candual then -- ipos=22 is "weaponoffhand"
      mainslot = nil
    end
    if ipos == 13 and not candual then -- ipos=13 is "weapon"
      otherslot = nil
    end
	-- end of misunderstanding

    if type(mainslot) == "string" then
		mainslot = GetCachedSlot(mainslot)
    end

    if type(otherslot) == "string" then
		otherslot = GetCachedSlot(otherslot)
    end

    local is2hweap = Is2hEquipped()
    local force2h = get("search.pawn.force2h")

    -- Check cache first
    if not slotCache["SecondaryHandSlot"] then
      local slotId, textureName = GetInventorySlotInfo("SecondaryHandSlot")
      -- store in cache
      slotCache["SecondaryHandSlot"] = slotId
    end

    -- Don't allow offhand items to show up in the search if the
    -- user has a 2h weapon equipped and they have force2h checked
	-- ShadowVal: I think first condition "has a 2h weapon equipped" NOT needed. I can wear 1H now and WANT to wear 2H so I checked force2h in options.

    -- We do this to limit hits to stuff that is better than what we have equipped
    -- If we did not do this, then level 10 green items would be hits for a level
    -- 80 player (due to item matching against an empty slot)

	-- If it is an off-hand item and the user has a 2h weapon equipped
	-- change the mainslot to be that of the main hand.
    if mainslot == slotCache["SecondaryHandSlot"] and is2hweap and not force2h then
		mainslot = GetCachedSlot("MainHandSlot")
    else

		if is2hweap and force2h and mainslot == offhand then
			mainslot = nil
		end

		-- Ensure they can dual wield before
		-- allowing them to compare against offhand
		if ipos == 13 and not candual then -- ipos=13 is "weapon"
			otherslot = nil
		end
	end

	end -- not relics

  return mainslot, otherslot
end -- function ConvertSlot(ipos,itype,subtype)

-------------------------------------------------------------------
-- Check to see if the user checked the box for this slot
-------------------------------------------------------------------
function SlotOK(slot)
  -- short-circuit if slot is out of bounds

  -- ShadowVall
  -- I know it will sound strangly, but what you think about BAG upgrades? "BAG for 22 slots" is BETTER than equipped "BAG for 18". Is it UPGRADE?:) But pawn can't tell us this information... But our mind can:)

  if slot == nil or slot < 0 or slot > 18 then
    return false
  end

  -- Build table so that we avoid a large if/else
  local slotOK = {
      get("search.pawn.head"),     -- [1] head
      get("search.pawn.neck"),     -- [2] neck
      get("search.pawn.shoulder"), -- [3] shoulder
      false,                      -- [4] shirt
      get("search.pawn.chest"),    -- [5] chest
      get("search.pawn.waist"),    -- [6] waist
      get("search.pawn.legs"),     -- [7] legs
      get("search.pawn.feet"),     -- [8] feet
      get("search.pawn.wrist"),    -- [9] wrist
      get("search.pawn.hands"),    -- [10] hand
      get("search.pawn.finger"),   -- [11] finger
      get("search.pawn.finger"),   -- [12] finger
      get("search.pawn.trinket"),  -- [13] trinket
      get("search.pawn.trinket"),  -- [14] trinket
      get("search.pawn.back"),     -- [15] cloak
      get("search.pawn.weapon"),   -- [16] weapon
      get("search.pawn.offhand"),  -- [17] offhand
      get("search.pawn.ranged"),   -- [18] ranged
  }

  -- See if the user wants the slot that this item would occupy
  local retval = slotOK[slot]

  -- sanity check the result
  if retval == nil then
    retval = false
  else
    if type(retval) ~= "boolean" then
      retval = false
    end
  end

  return retval
end

-------------------------------------------------------------------
-- Ensure that we have a valid ipos from Auctioneer
-------------------------------------------------------------------
function ConvertIpos(ipos)
  -- Must have ipos
  if ipos == nil then
    return nil
  end

  -- Realtime search support
  if type(ipos) == "string" then
    ipos = Const.InvTypes[ipos]
  end

  return ipos
end

-------------------------------------------------------------------
-- See if the user can afford the item
-------------------------------------------------------------------
function FilterPrice(itemData)
  local impoor = get("search.pawn.impoor")

  if impoor then
    local pmoney = GetMoney()
    local usebuyout = get("search.pawn.buyout")
    local buyout = itemData[Const.BUYOUT]
    local bid = itemData[Const.MINBID]

    if usebuyout then
      if pmoney < buyout then
        return false
      end
    else
      if pmoney < bid then
        return false
      end
    end
  end

  return true
end

-------------------------------------------------------------------
-- Returns true if the user has a 2h weapon equipped
-------------------------------------------------------------------
function Is2hEquipped()
  -- Check cache first
  if not slotCache["MainHandSlot"] then
    local slotId, textureName = GetInventorySlotInfo("MainHandSLot")
    -- store in cache
    slotCache["MainHandSlot"] = slotId
  end
  local mItem = PawnGetItemDataForInventorySlot(slotCache["MainHandSlot"])

  -- No weapon equipped
  if mItem == nil then
    return false
  end

  -- Check weapon stats as returned by Pawn
  -- If it's a 2handed item, it will list
  -- 2handed dps in the stats
  if mItem.Stats then
    for StatName, Value in pairs(mItem.Stats) do
      if StatName == TEXT("TWOHANDDPS") then
        return true
      end
    end
  end

  return false
end

-------------------------------------------------------------------
-- Filter out an item if
--
-- 1) ipos from Auctioneer is undefined
-- 2) if the item does not have a link
-- 3) if the item is a bag
-- 4) if the item cannot be equipped
-- 5) if the user checked "Only What I Can Use" and the item is not useable
-- 6) if the object doesn't go to a slot we care about (nil / ignore slot)
-- 7) if the user only wants 2h weapons and we get a weapon that isn't 2h
-- 8) if the user unchecked the slot
-- 9) if the user cannot afford the item and they only want to see what they can afford
-------------------------------------------------------------------
function FilterItem(itemData)

  local link = itemData[Const.LINK]
  local iname = itemData[Const.NAME]
  local ipos  = ConvertIpos(itemData[Const.IEQUIP])
  local itype = itemData[Const.ITYPE]
  local subtype = itemData[Const.ISUB]

  -- Must have ipos
  if ipos == nil then
    return false
  end

  -- Does the item have a link
  if not link then
    return false
  end

  -- Only filter items that can be equipped (not materials, scrolls etc)
  if (not IsEquippableItem(link)) then
    return false
  end

  -- Check to see if we can use the item by the user choice
  local canuse = get("search.pawn.canuse")
  if canuse then
    local icanuse = CanUse(link)
    if icanuse ~= true then
      return false
    end
  end

  local mainslot, otherslot = ConvertSlot(ipos,itype,subtype)
  -- Is there a slot to be compared
  if not mainslot and not otherslot then
    return false
  end

  local force2h = get("search.pawn.force2h")
  CheckOrAddCacheSlot("MainHandSlot")

  if not slotCache["MainHandSlot"] then
    local slotId, textureName = GetInventorySlotInfo("MainHandSlot")
    slotCache["MainHandSlot"] = slotId
  end

  if force2h and mainslot == slotCache["MainHandSlot"] and ipos ~= 17 then
    return false
  end

  -- Check to see if item is wanted
  local wanted = SlotOK(mainslot)
  if not wanted then
    -- check other slot
    wanted = SlotOK(otherslot)
    if not wanted then
      return false
    end
  end

  -- Check to see if we can afford the item
  if not FilterPrice(itemData) then
    return false
  end

  return true
end

-------------------------------------------------------------------
-- Returns pawn values for a given equipped slot
-------------------------------------------------------------------
function GetPawnValueEquipped(slot)
  local mItem = PawnGetItemDataForInventorySlot(slot,false)

  local mVal = 0 -- ShadowVall: pawnscore (NO enchants, gems setup by pawn. should use this value for comparison!
  local mValE = 0 -- ShadowVall: enchantedpawnscore (current player enchants, current player gems) not useful for comparison ????

  -- If there is no item equipped in that slot, then any item is an upgrade
  if not mItem then
    return mValE, mVal
  end

  -- Grab the values for the item equipped in the main slot
  -- PawnGetSingleValueFromItem(Item, ScaleName)
  -- return Value, UnenchantedValue
  mValE, mVal = PawnGetSingleValueFromItem(mItem, _scalename) -- return Value, UnenchantedValue

  -- ensure we have valid values
  if mVal == nil then
    mVal = 0
  end

  if mValE == nil then
    mValE = 0
  end

  return mValE, mVal
end -- function GetPawnValueEquipped(slot)

-------------------------------------------------------------------
-- Returns pawn values from a itemData structure
-------------------------------------------------------------------
function GetPawnValueItem(itemData)
  local iname = itemData[Const.NAME]
  local link = itemData[Const.LINK]

  -- Set name to blank for nil names.
  if not iname then iname = " " end

  -- Get the signature of this item and find it's stats.
  local item = PawnGetItemData(link)

  -- ensure we get an item structure from Pawn
  if not item then
    return false
  end

  -- Grab the values for the item from Auctioneer
  local aValE, aVal = PawnGetSingleValueFromItem(item, _scalename)

  -- ensure we have valid values
  if aVal == nil then
    aVal = 0
  end

  if aValE == nil then
    aValE = 0
  end

  return aValE, aVal
end -- function GetPawnValueItem(itemData)

-------------------------------------------------------------------
-- Returns true if the user has a 2h weapon equipped
-------------------------------------------------------------------
function Is2hEquipped()
  --local mainslot = 16 -- Main Hand Inventory Slot ShadowVall: I think we should use global const "MainHandSlot" and function GetInventorySlotId
  local mItem = PawnGetItemDataForInventorySlot(16)

	if mitem then
		if mItem.Stats then
			for StatName, Value in pairs(mItem.Stats) do
				if StatName == "TwoHandDps" then
					return true
				end
			end -- for
		end
	end
  return false

end -- function Is2hEquipped()

-------------------------------------------------------------------
-- Check to see if the item is an upgrade or not
-------------------------------------------------------------------
function IsUpgrade(itemData)
  local iname = itemData[Const.NAME]

  -- Get value of Item in Search Results
  local aValE, aVal = GetPawnValueItem(itemData)

  -- Get value of equivalent slot(s).
  local itype = itemData[Const.ITYPE]
  local ipos  = ConvertIpos(itemData[Const.IEQUIP])
  local subtype = itemData[Const.ISUB]
  -- we can assume mainslot is defined and otherslot might be defined at this point
  -- but we will double check just in case
  local mainslot, otherslot = ConvertSlot(ipos,itype,subtype)

  local is2hweap = Is2hEquipped()

	-- Don't allow offhand items to show up in the search if the
	-- user has a 2h weapon equipped

	-- ShadowVall: WHY? if offHand weapon is BETTER than gray 2H on low level character? should check "want 2 hand" instead!

	-- if is2hweap and mainslot == 17 and then
	if mainslot == 17 and get("search.pawn.force2h")==true then
		return false, ""
	end

  -- Get value for main slot
  local mValE, mVal = GetPawnValueEquipped(mainslot)
  local oVal = 0
  local oValE = 0

  -- Get value for other slot
  if (otherslot) then
    oValE, oVal = GetPawnValueEquipped(otherslot)
  end

  local retval = false
  local dStr = ""

  -- Using the values from Pawn
  local mainValue = mValE
  local otherValue = oValE -- this will be 0 when users have 2h weapon equipped

  -- ShadowVall:
  -- I dont like the code below - difficult to understand:(
  -- seem there is missed dualwield characters?

  -- compare 2-handed weapons against both main hand and off hand
  if ipos == 17 then -- ipos=17 is "2HWeapon"
    -- If user has 2h equipped, mainValue will have it's value and otherValue will be 0 so it compares 2h with 2h
    -- If user has 1h equipped, and nothing in otherValue, it's same as above.
    -- If user has 1h equipped and something in otherValue, then 2h will compare with combined total of both hands
	-- ShadowVall: seem it is ok
    local bValue = mainValue + otherValue
    if aValE > bValue then
      dStr = string.format("%07.2f", aValE - bValue)
      retval = true
    end
  else
    -- We are not checking a 2h weapon
    -- Check for Main Slot
    if mainslot and aValE > mainValue then
	  dStr = ("%07.2f"):format(aValE - mainValue)
      retval = true
    else -- Check Other Slot
      -- when checking 1h weapons, only check the offhand slot
      -- if the user does not have a 2h weapon equipped
      -- otherwise always check offhand/alternate slot (rings/trinkets)
      if mainslot ~= 16 or (mainslot == 16 and not is2hweap) then
        -- ShadowVall: example
		-- aucitem is the best iLvL=200 "dagger", can be equipped in both hand
		-- CharClass warlock, equipped some "tome" score=0 in offhand.
		-- dagger is better, but i can not use it in offhand:(
		if otherslot and aValE > otherValue then
          dStr = ("%07.2f"):format(aValE - otherValue)
          retval = true
        end
      end
    end
  end

  -- example output
  -- if false: return back false, ""
  -- if true: return back true, "20.5204"

  return retval, dStr
end -- function IsUpgrade(itemData)

-------------------------------------------------------------------
-- Auctioneer interface.  Each search result is passed into this function
-- Return values:
--      boolean - true / false
--      reason - string if boolean is false, nil otherwise
--             ####  The following return values are only present if boolean is true
--      profit - 0 if AucAdvanced.Modules.Util.PriceLevel is not loaded, nil otherwise
--      delta -  zero padded pawn delta
-------------------------------------------------------------------
function lib.Search(itemData)
  local usebuyout = get("search.pawn.buyout")

  -- What kind of choice should we present
  local reason = TEXT("REASON_BID")
  if usebuyout then
    reason = TEXT("REASON_BUY")
  end

  -- Ensure we have a valid scale chosen
  if not ValidateScale() then
    return false, TEXT("BAD_SCALE")
  end

  -- Check to see if the item is valid and that the user wants it evaluated
  if not FilterItem(itemData) then
    return false, TEXT("NOT_WANTED")
  end

  -- Ok At this point we can use the item and possibly can afford it
  -- Check to see if it is an upgrade
  local isUpgrade, dStr = IsUpgrade(itemData)
  if isUpgrade then
    if not AucAdvanced.Modules.Util.PriceLevel then
      return reason,nil,0,dStr
    else
      return reason,nil,nil,dStr
    end
  else
    return false, TEXT("NOT_UPGRADE")
  end

end -- function lib.Search(itemData)
