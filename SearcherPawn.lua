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
-- Map between Auctioneer and Pawn values
local convertSlot = {
  {
    1, -- [1] mainslot
    -1, -- [2] otherslot
  }, -- [1] head
  {
    2, -- [1] mainslot
    -1, -- [2] otherslot
  }, -- [2] neck
  {
    3, -- [1] mainslot
    -1, -- [2] otherslot
  }, -- [3] shoulder
  {
    -1, -- [1] mainslot
    -1, -- [2] otherslot
  }, -- [4] body
  {
    5, -- [1] mainslot
    -1, -- [2] otherslot
  }, -- [5] chest
  {
    6, -- [1] mainslot
    -1, -- [2] otherslot
  }, -- [6] waist
  {
    7, -- [1] mainslot
    -1, -- [2] otherslot
  }, -- [7] legs
  {
    8, -- [1] mainslot
    -1, -- [2] otherslot
  }, -- [8] feet
  {
    9, -- [1] mainslot
    -1, -- [2] otherslot
  }, -- [9] wrist
  {
    10, -- [1] mainslot
    -1, -- [2] otherslot
  }, -- [10] hand
  {
    11, -- [1] mainslot
    12, -- [2] otherslot
  }, -- [11] finger
  {
    13, -- [1] mainslot
    14, -- [2] otherslot
  }, -- [12] trinket
  {
    16, -- [1] mainslot
    17, -- [2] otherslot
  }, -- [13] weapon
  {
    17, -- [1] mainslot
    -1, -- [2] otherslot
  }, -- [14] shield
  {
    18, -- [1] mainslot
    -1, -- [2] otherslot
  }, -- [15] rangedright
  {
    15, -- [1] mainslot
    -1, -- [2] otherslot
  }, -- [16] cloak
  {
    16, -- [1] mainslot
    -1, -- [2] otherslot
  }, -- [17] 2hweapon
  {
    -1, -- [1] mainslot
    -1, -- [2] otherslot
  }, -- [18] bag
  {
    -1, -- [1] mainslot
    -1, -- [2] otherslot
  }, -- [19] tabard
  {
    5, -- [1] mainslot
    -1, -- [2] otherslot
  }, -- [20] robe
  {
    16, -- [1] mainslot
    -1, -- [2] otherslot
  }, -- [21] weaponmainhand
  {
    17, -- [1] mainslot
    -1, -- [2] otherslot
  }, -- [22] weaponoffhand
  {
    17, -- [1] mainslot
    -1, -- [2] otherslot
  }, -- [23] holdable
  {
    -1, -- [1] mainslot
    -1, -- [2] otherslot
  }, -- [24] ammo
  {
    18, -- [1] mainslot
    -1, -- [2] otherslot
  }, -- [25] thrown
  {
    18, -- [1] mainslot
    -1, -- [2] otherslot
  }, -- [26] ranged
}
-------------------------------------------------------------------

-------------------------------------------------------------------
-- Debug Output Function
-------------------------------------------------------------------
local function Debug(Reason, Text)
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
-- This function is automatically called when we need to create our search generals
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
  gui:AddControl(id, "Checkbox",   0, 0, "search.pawn.force2h", TEXT("FORCE2H_WEAP"))
  gui:AddTip(id, TEXT("FORCE2H_TIP"))

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

  _scalename = scalename

  return _scalename
end

-------------------------------------------------------------------
-- Validate the user's choice of scale
-------------------------------------------------------------------
function ValidateScale()
  -- Did the user pick a scale
  local scalenum = get("search.pawn.scalenum")

  if not scalenum then
    Debug(false, TEXT("NO_SCALE_DBG"))
    return false
  end

  local isValid = validScales[scalenum]
  if not isValid then
    local scalename = GetScaleName(scalenum)

    if scalename == "" then
      Debug(false, TEXT("SCALE_BLANK_DBG"))
      return false
    end

    local scalefound = PawnDoesScaleExist(scalename)
    if not scalefound or scalefound ~= true then
      Debug(false, string.format("%s [%s]", TEXT("SCALE_NOT_FOUND_DBG"), scalename))
      return false
    end

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

  if (pclass == TEXT("WARRIOR") or pclass == TEXT("HUNTER") and plevel >= 20) then
    return true
  end
  if (pclass == TEXT("SHAMAN") and plevel >= 40) then
    return true
  end
  if (pclass == TEXT("ROGUE") and plevel >= 10) then
    return true
  end
  if (pclass == TEXT("DEATH_KNIGHT")) then
    return true
  end

  return false
end

-------------------------------------------------------------------
-- Convert between auctioneer equip positions and Pawn equip positions
-------------------------------------------------------------------
local function ConvertSlot(ipos,itype,subtype)
  local mainslot = nil
  local otherslot = nil

  if (itype == TEXT("ARMOR")) and ((subtype == TEXT("TOTEMS")) or (subtype == TEXT("LIBRAMS")) or (subtype == TEXT("IDOLS")) or (subtype == TEXT("SIGILS"))) then -- Relics
    mainslot = 18
  else
    local candual = CanDualWield()

    local slots = convertSlot[ipos]
    mainslot = slots[1]
    otherslot = slots[2]

    if mainslot == -1 then
      mainslot = nil
    end

    if otherslot == -1 then
      otherslot = nil
    end

    -- Ensure they can dual wield before
    -- allowing them to compare against offhand
    if ipos == 13 and not candual then
      otherslot = nil
    end
  end

  return mainslot, otherslot
end

-------------------------------------------------------------------
-- Check to see if the user checked the box for this slot
-------------------------------------------------------------------
function SlotOK(slot)
  -- short-circuit if slot is out of bounds
  if slot == nil or slot < 0 or slot > 18 then
    return false
  end

  -- Build table so that we avoid a large if/else
  local slotOK = {
      get("search.pawn.head"),     -- [1] head
      get("search.pawn.neck"),     -- [2] neck
      get("search.pawn.shoulder"), -- [3] shoulder
      false,                       -- [4] body
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
    Debug(false, string.format("DBG:  Slot %d = nil, setting to false", slot))
    retval = false
  else
    if type(retval) ~= "boolean" then
      Debug(false, string.format("DBG: Retval is not boolean it is %s", type(retval)))
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
-- Ensure that we have a valid ipos from Auctioneer
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
    Debug(false, TEXT("NO_LINK_DBG"))
    return false
  end

  -- Don't let bags through
  if ipos == 18 then
    return false
  end

  -- Don't show Ammo/thrown for non ammo classes
  local pclass = UnitClass("player")
  if ((pclass ~= TEXT("HUNTER") and pclass ~= TEXT("ROGUE") and pclass ~= TEXT("WARRIOR")) and (ipos == 24 or ipos == 25)) then
    return false
  end

  -- Only filter stuff that can be equipped
  if (not IsEquippableItem(link)) then
    return false
  end

  -- Check to see if we can use the item
  local canuse = get("search.pawn.canuse")
  local icanuse = CanUse(link)

  if canuse and icanuse ~= true then
    Debug(false, string.format("%s [%s]", TEXT("CANNOT_USE_DBG"), iname))
    return false
  end

  local mainslot, otherslot = ConvertSlot(ipos,itype,subtype)

  -- Is there a slot to be compared
  if not mainslot and not otherslot then
    return false
  end

  local force2h = get("search.pawn.force2h")
  if force2h and mainslot == 16 and ipos ~= 17 then
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
  local mVal = 0
  local mValE = 0

  -- If there is no item equipped in that slot, then any item is an upgrade
  if not mItem then
    return mValE, mVal
  end

  -- Grab the values for the item equipped in the main slot
  mValE, mVal = PawnGetSingleValueFromItem(mItem, _scalename)

  -- ensure we have valid values
  if mVal == nil then
    mVal = 0
  end
  if mValE == nil then
    mValE = 0
  end

  return mValE, mVal
end

-------------------------------------------------------------------
-- Returns pawn values from a itemData structure
-------------------------------------------------------------------
function GetPawnValueItem(itemData)
  local iname = itemData[Const.NAME]
  local link = itemData[Const.LINK]

  -- Set name to blank for nil names.  This is only used for debugging.
  if not iname then iname = " " end

  -- Get the signature of this item and find it's stats.
  local item = PawnGetItemData(link)

  if not item then
    Debug(false, string.format("%s: %s", TEXT("NO_ITEM_DBG"), iname))
    return false
  end

  local aValE, aVal = PawnGetSingleValueFromItem(item, _scalename)

  if aVal == nil then
    aVal = 0
  end
  if aValE == nil then
    aValE = 0
  end

  return aValE, aVal
end


function Is2hEquipped()
  local mainslot = 16 -- Main Hand Inventory Slot
  local mItem = PawnGetItemDataForInventorySlot(mainslot)
  if mItem.Stats then
    for StatName, Value in pairs(mItem.Stats) do
      if StatName == "TwoHandDps" then
        return true 
      end
    end
  end

  return false
end

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
  local mainslot, otherslot = ConvertSlot(ipos,itype,subtype)
  local is2hweap = Is2hEquipped()

  if is2hweap and mainslot == 17 then
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

  local slots = convertSlot[ipos]

  local retval = false
  local dStr = ""

  local mainValue = mValE
  local otherValue = oValE

  -- compare 2-handed weapons against both main hand and off hand
  if ipos == 17 then
    local bValue = mainValue + otherValue
    if aValE > bValue then
      dStr = string.format("%07.2f", aValE - bValue)
      retval = true
    end
  else
    -- Check Main Slot
    if aValE > mainValue then
      dStr = ("%07.2f"):format(aValE - mainValue)
      retval = true
    else -- Check Other Slot
      if mainslot ~= 16 or (mainslot == 16 and not is2hweap) then
        if otherslot and aValE > otherValue then
          dStr = ("%07.2f"):format(aValE - otherValue)
          retval = true
        end
      end
    end
  end

  return retval, dStr
end

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
  local debugfalse = get("search.pawn.debugfalse")
  local debugtrue = get("search.pawn.debugtrue")
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
end
