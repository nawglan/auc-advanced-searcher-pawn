--[[
  Auctioneer Advanced - Search UI - Searcher Pawn
  Version: 1.1.10
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

lib.tabname = "Pawn"

-- Set our defaults
default("search.pawn.scalename", "")
default("search.pawn.current", false)
default("search.pawn.canuse", false)
default("search.pawn.forcemh", false)
default("search.pawn.debug", false)

local function TEXT(key) return Localization.GetClientString("Auc-Searcher-Pawn", key) end


local pclass = UnitClass("player")
local plevel = UnitLevel("player")
local scaletable = {}

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
    4, -- [1] mainslot
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
    17, -- [2] otherslot
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
    0, -- [1] mainslot
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

local function Debug(Reason, Text)
  local showdbg = get("search.pawn.debug")
  local showfalse = get("search.pawn.debugfalse")
  local showtrue = get("search.pawn.debugtrue")

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


function updateScales()
  local scalecopy = {}
  scaletable = PawnGetAllScales()

  table.insert(scalecopy, { 1, "" })

  for i,j in pairs(scaletable) do
    table.insert(scalecopy, { i+1, j })
  end

  return scalecopy
end

-- This function is automatically called when we need to create our search generals
function lib:MakeGuiConfig(gui)
  -- Get our tab and populate it with our controls
  local id = gui:AddTab(lib.tabname, "Searchers")

  -- Add the help
  gui:AddSearcher("Pawn", TEXT("MAIN_TITLE"), 100)
  gui:AddHelp(id, TEXT("HELP_ID"), TEXT("HELP_QUESTION"), TEXT("HELP_ANSWER"))

  gui:AddControl(id, "Header", 0, TEXT("CONFIG_HEADER"))
  local last = gui:GetLast(id)
  gui:AddControl(id, "Selectbox",  0, 1, updateScales, "search.pawn.scalename", TEXT("SCALE_SELECT"))
  gui:AddTip(id, TEXT("SCALE_SELECT_TIP"))
  local cont = gui:GetLast(id)
  last = cont
  gui:SetLast(id, last)
  gui:AddControl(id, "Checkbox",   0.25, 0, "search.pawn.current", TEXT("CHECK_CURRENT"))
  gui:AddTip(id, TEXT("CHECK_CURRENT_TIP"))
  last = gui:GetLast(id)
  gui:SetLast(id, last)
  gui:AddControl(id, "Checkbox",   0.25, 0, "search.pawn.canuse", TEXT("USEABLE_ONLY"))
  gui:AddTip(id, TEXT("USEABLE_ONLY_TIP"))
  last = gui:GetLast(id)
  gui:AddControl(id, "Checkbox",   0.25, 0, "search.pawn.forcemh", TEXT("FORCE_MAIN"))
  gui:AddTip(id, TEXT("FORCE_MAIN_TIP"))
  last = gui:GetLast(id)
  gui:AddControl(id, "Checkbox",   0.25, 0, "search.pawn.impoor", TEXT("AFFORD_ONLY"))
  gui:AddTip(id, TEXT("AFFORD_ONLY_TIP"))
  last = gui:GetLast(id)
  gui:AddControl(id, "Checkbox",   0.25, 0, "search.pawn.buyout", TEXT("USE_BUYOUT"))
  gui:AddTip(id, TEXT("USE_BUYOUT_TIP"))
  last = gui:GetLast(id)
  gui:AddControl(id, "Checkbox",   0.25, 0, "search.pawn.debug", TEXT("SHOW_DEBUG"))
  gui:AddTip(id, TEXT("SHOW_DEBUG_TIP"))
  last = gui:GetLast(id)
  gui:AddControl(id, "Checkbox",   0.28, 0, "search.pawn.debugfalse", TEXT("ONLY_FALSE"))
  gui:AddTip(id, TEXT("ONLY_FALSE_TIP"))
  last = gui:GetLast(id)
  gui:AddControl(id, "Checkbox",   0.28, 0, "search.pawn.debugtrue", TEXT("ONLY_TRUE"))
  gui:AddTip(id, TEXT("ONLY_TRUE_TIP"))
end

local function RGBPercToHex(r, g, b)
  r = r <= 1 and r >= 0 and r or 0
  g = g <= 1 and g >= 0 and g or 0
  b = b <= 1 and b >= 0 and b or 0
  return string.format("%02x%02x%02x", r*255, g*255, b*255)
end

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

-- Convert between auctioneer equip positions and Pawn equip positions
local function ConvertSlot(pos,itype,subtype)
  local mainslot, otherslot

  local candual = 0
  local hasammo = 0
  local forcemh = get("search.pawn.forcemh")

  -- Limit one-handed weapon checks to main hand unless class can dual wield
  if (pclass == TEXT("WARRIOR") or pclass == TEXT("HUNTER") and plevel >= 20) then
    candual = 1
  end
  if (pclass == TEXT("SHAMAN") and plevel >= 40) then
    candual = 1
  end
  if (pclass == TEXT("ROGUE") and plevel >= 10) then
    candual = 1
  end
  if (pclass == TEXT("DEATH_KNIGHT")) then
    candual = 1
  end

  local slots = convertSlot[pos]
  mainslot = slots[1]
  otherslot = slots[2]
  if otherslot == -1 then
    otherslot = nil
  end

  if pos == 13 then -- One Hand Weapon
    if candual and not forcemh then
      otherslot = 17
    end
  end

  if pos == 22 then -- Off hand
    if forcemh then
      mainslot = 16
    end
  end

  if pos == 23 then -- Holdable
    if forcemh then
      mainslot = 16
    end
  end

  if (itype == TEXT("ARMOR")) and ((subtype == TEXT("TOTEMS")) or (subtype == TEXT("LIBRAMS")) or (subtype == TEXT("IDOLS")) or (subtype == TEXT("SIGILS"))) then -- Relics
    mainslot = 18
  end

  return mainslot, otherslot
end

function lib.Search(itemData)
  local link = itemData[Const.LINK]
  local itype = itemData[Const.ITYPE]
  local ipos  = itemData[Const.IEQUIP]
  local iname = itemData[Const.NAME]
  local subtype = itemData[Const.ISUB]
  local bid = itemData[Const.MINBID]
  local buyout = itemData[Const.BUYOUT]
  local debugfalse = get("search.pawn.debugfalse")
  local debugtrue = get("search.pawn.debugtrue")
  local pmoney = GetMoney()

  -- Must have ipos
  if ipos == nil then return end

  -- Set name to blank for nil names.  This is only used for debugging.
  if not iname then iname = " " end

  -- Don't let bags through
  if ipos == 18 then return end

  -- Realtime search support
  if type(ipos) == "string" then
    ipos = Const.InvTypes[ipos]
  end

  -- Did the user pick a scale
  local scalenum = get("search.pawn.scalename")
  local scalename = ""

  if not scalenum then
    Debug(false, TEXT("NO_SCALE_DBG"))
    return false, TEXT("NO_SCALE")
  end

  -- Does the stored scale exist
  for i, j in pairs(scaletable) do
    if i == (scalenum - 1) then -- subtract 1, due to offset introduced in menu
      scalename = j
      break
    end
  end

  if scalename == "" then
    Debug(false, TEXT("SCALE_BLANK_DBG"))
    return false, TEXT("SCALE_BLANK")
  end

  local scalefound = PawnDoesScaleExist(scalename)
  if not scalefound or scalefound ~= true then
    Debug(false, string.format("%s [%s]", TEXT("SCALE_NOT_FOUND_DBG"), scalename))
    return false, TEXT("SCALE_NOT_FOUND")
  end

  -- Does the item have a link
  if not link then
    Debug(false, TEXT("NO_LINK_DBG"))
    return false, TEXT("NO_LINK")
  end

  -- Don't show Ammo/thrown for non ammo classes
  if ((pclass ~= TEXT("HUNTER") and pclass ~= TEXT("ROGUE") and pclass ~= TEXT("WARRIOR")) and (ipos == 24 or ipos == 25)) then
    Debug(false, string.format("%s [%s]", TEXT("CANNOT_USE_DBG"), iname))
    return false, TEXT("CANNOT_USE")
  end

  -- Only filter stuff that can be equipped
  if (not IsEquippableItem(link)) then
    Debug(false, string.format("%s [%s]", TEXT("NOT_EQUIPPABLE_DBG"), iname))
    return false, TEXT("NOT_EQUIPPABLE")
  end

  -- Check to see if we can use the item
  local canuse = get("search.pawn.canuse")
  local icanuse = CanUse(link)

  if canuse and icanuse ~= true then
    Debug(false, string.format("%s [%s]", TEXT("CANNOT_USE_DBG"), iname))
    return false, TEXT("CANNOT_USE")
  end

  -- Check to see if we can afford the item
  local impoor = get("search.pawn.impoor")
  local usebuyout = get("search.pawn.buyout")

  if impoor then
    if usebuyout and pmoney < buyout then
      Debug(false, string.format("%s %s ahPrice[%d] pMoney[%d]", TEXT("CANNOT_AFFORD_DBG"), iname, buyout, pmoney))
      return false, TEXT("CANNOT_AFFORD_BUYOUT")
    end
    if not usebuyout and pmoney < bid then
      Debug(false, string.format("%s %s ahPrice[%d] pMoney[%d]", TEXT("CANNOT_AFFORD_DBG"), iname, bid, pmoney))
      return false, TEXT("CANNOT_AFFORD_BID")
    end
  end

  local reason = TEXT("REASON_BUY")
  if (not usebuyout) then
    reason = TEXT("REASON_BID")
  end

  -----------------------------------------------------------------
  --Ok At this point we can use the item and possibly can afford it
  -----------------------------------------------------------------

  -- Get the signature of this item and find it's stats.
  local item = PawnGetItemData(link)

  if not item then
    Debug(false, string.format("%s: %s", TEXT("NO_ITEM_DBG"), iname))
    return false, TEXT("NO_ITEM")
  end

  local aValE, aVal = PawnGetSingleValueFromItem(item, scalename)

  if aVal == nil then
    aVal = 0
  end
  if aValE == nil then
    aValE = 0
  end

  local aStr = string.format("%07.2f", aVal)
  local aStrE = string.format("(E)%07.2f", aValE)

  -- Get value of equivalent slot(s).
  local mainslot, otherslot = ConvertSlot(ipos,itype,subtype)
  local mItem = PawnGetItemDataForInventorySlot(mainslot)

  -- If there is no item equipped in that slot, then any item is an upgrade
  if not mItem then
    Debug(true, string.format("DBG:(%d)%s aVal[%07.2f] > %s", ipos,iname,aVal, TEXT("EMPTY_SLOT")))
    --return aStr,nil,nil
    return reason,nil,aVal,aStr
  end

  -- Grab the values for the item equipped in the main slot
  local mValE, mVal = PawnGetSingleValueFromItem(mItem, scalename)
  local oItem = nil
  local oVal = 0
  local oValE = 0

  if (otherslot) then
    oItem = PawnGetItemDataForInventorySlot(otherslot)
    if oItem then
      oValE, oVal = PawnGetSingleValueFromItem(oItem, scalename)
    end
  end

  -- ensure we have valid values for comparisons

  if mVal == nil then
    mVal = 0
  end
  if mValE == nil then
    mValE = 0
  end
  if oVal == nil then
    oVal = 0
  end
  if oValE == nil then
    oValE = 0
  end

  local current = get("search.pawn.current")

  -- use the bigger of the two numbers for items that are equipped.
  -- This will assume that you intend to socket items with appropriate
  -- gems.  Pawn will fill in values for sockets that are empty when
  -- calculating the unenchanted value of the item.  If that value is
  -- bigger, use that.
  local mainValue = 0
  local offValue = 0
  local bValue = 0

  if current then
    mainValue = mValE
    offValue = oValE
    bValue = mValE + oValE
  else
    mainValue = mVal
    offValue = oVal
    bValue = mVal + oVal
  end

  local slots = convertSlot[ipos]
  local retval = false
  local dStr = ""

  -- If current is checked, check it first.
  if (enchant) then
    -- compare 2-handed weapons against both main hand and off hand
    if ipos == 17 then
      if aValE > bValue then
        dStr = string.format("%07.2f", aValE - bValue)
	retval = true
        Debug(retval, string.format("DBG:(%d)%s aVal[%07.2f] > bValue[%07.2f]", ipos, iname, aValE, bValue))
      end
    else
      if aValE > mainValue then
        dStr = ("%07.2f"):format(aValE - mainValue)
	retval = true
        Debug(retval, string.format("DBG:(%d)%s aVal[%07.2f] > mainValue[%07.2f]", ipos, iname, aValE, mainValue))
      end
      if otherslot and aValE > offValue then
        dStr = ("%07.2f"):format(aValE - offValue)
	retval = true
        Debug(retval, string.format("DBG:(%d)%s aVal[%07.2f] > offValue[%07.2f]", ipos, iname, aValE, offValue))
      end
    end
  else
    -- compare 2-handed weapons against both main hand and off hand
    if ipos == 17 then
      if aVal > bValue then
        dStr = ("%07.2f"):format(aVal - bValue)
        retval = true
        Debug(retval, string.format("DBG:(%d)%s aVal[%07.2f] > bValue[%07.2f]", ipos, iname, aVal, bValue))
      end
    else
      if aVal > mainValue then
        dStr = ("%07.2f"):format(aVal - mainValue)
	retval = true
        Debug(retval, string.format("DBG:(%d)%s aVal[%07.2f] > mainValue[%07.2f]", ipos, iname, aVal, mainValue))
      else
        if otherslot and aVal > offValue then
          dStr = ("%07.2f"):format(aVal - offValue)
	  retval = true
          Debug(retval, string.format("DBG:(%d)%s aVal[%07.2f] > offValue[%07.2f]", ipos, iname, aVal, offValue))
        end
      end
    end
  end

  Debug(retval, string.format("DBG: iPos: %d mSlot: %d oSlot: %d", ipos, slots[1], slots[2]))

  if retval then
    if not AucAdvanced.Modules.Util.PriceLevel then
      return reason,nil,0,dStr
    else
      return reason,nil,nil,dStr
    end
  else
    Debug(false, string.format("%s: (%d)%s aVal[%07.2f]", TEXT("NOT_UPGRADE_DBG"), ipos,iname,aVal))
    return false, TEXT("NOT_UPGRADE")
  end

end

