-- English text strings

Localization.RegisterAddonStrings("enUS", "Localization", 
  {
    -- Locales
    enUS      = "English";
    enGB      = "English";
    frFR      = "French";
    deDE      = "German";
    
    -- Frame Strings
    Confirm         = "Confirm";
    Cancel          = "Cancel";
    RemoveUnused    = "Remove unused locales from memory.";
    SelectPreferred = "Select a preferred localization:";
    AvailLangs      = "Available Languages";
    
    --Earth Button
    Localization  = "Localization";
    ShowPrompt    = "Show Prompt";
    EarthTooltip  = "Show Locale Sellection Dialogue."
  },
nil, true) -- Protected

Localization.RegisterAddonStrings("enUS", "Auc-Searcher-Pawn", 
  {
    -- Config
    MAIN_TITLE        = "Search for items which Pawn considers an upgrade";
    HELP_ID           = "Pawn Searcher";
    HELP_QUESTION     = "What does this searcher do?";
    HELP_ANSWER       = "This searcher will use a scale that has been defined in the Pawn addon to locate upgrades for your currently equipped items.";
    CONFIG_HEADER     = "Pawn Search Criteria";
    SCALE_SELECT      = "Pawn scale name";
    SCALE_SELECT_TIP  = "The Pawn scale that will be used to determine the item value";
    CHECK_CURRENT     = "Check current value";
    CHECK_CURRENT_TIP = "If checked, items will be calculated 'as is'.  Empty sockets will be ignored.  All enchants applied.  If unchecked, items will be calculated without any enchantments and all empty sockets will use the value you set in the Pawn scale.";
    USEABLE_ONLY      = "Useable items only";
    USEABLE_ONLY_TIP  = "Only items that your character can use.";
    FORCE_MAIN        = "Force main hand";
    FORCE_MAIN_TIP    = "Off-hand items will only be compared to your main hand slot.";
    AFFORD_ONLY       = "Only what I can afford";
    AFFORD_ONLY_TIP   = "Only show what you can currently afford to buy.";
    USE_BUYOUT        = "Use buyout";
    USE_BUYOUT_TIP    = "Use buyout instead of bid when checking auction prices.";
    SHOW_DEBUG        = "Show debug messages";
    SHOW_DEBUG_TIP    = "WARNING: Produces lots of output.";
    ONLY_FALSE        = "Only false";
    ONLY_FALSE_TIP    = "Only show debug messages for items that do not match.";
    ONLY_TRUE         = "Only true";
    ONLY_TRUE_TIP     = "Only show debug messages for items that match.";

    --Classes
    WARRIOR      = "Warrior";
    HUNTER       = "Hunter";
    SHAMAN       = "Shaman";
    ROGUE        = "Rogue";
    DEATH_KNIGHT = "Death Knight";

    --Item Types
    ARMOR   = "Armor";
    TOTEMS  = "Totems";
    LIBRAMS = "Librams";
    IDOLS   = "Idols";
    SIGILS  = "Sigils";

    -- Messages
    NO_SCALE     = "No scale name";
    NO_SCALE_DBG = "DBG: No scale defined, please pick a scale from the dropdown list.  If none exist you will need to define a scale in Pawn first.";

    SCALE_BLANK     = "Scale left blank";
    SCALE_BLANK_DBG = "DBG: No scale defined, please pick a scale from the dropdown list.  If none exist you will need to define a scale in Pawn first.";

    SCALE_NOT_FOUND     = "Scale not found";
    SCALE_NOT_FOUND_DBG = "DBG: Error! Pawn cannot find scale";

    NO_LINK     = "No link";
    NO_LINK_DBG = "DBG: No link";

    CANNOT_USE     = "Can't use";
    CANNOT_USE_DBG = "DBG: Can't use this item";

    NOT_EQUIPPABLE     = "Not Equippable";
    NOT_EQUIPPABLE_DBG = "DBG: This item is not equippable";

    CANNOT_AFFORD_BUYOUT = "Can't afford buyout";
    CANNOT_AFFORD_BID    = "Can't afford bid";
    CANNOT_AFFORD_DBG    = "DBG: Can't afford this item";

    REASON_BUY = "buy";
    REASON_BID = "bid";

    NO_ITEM     = "No item";
    NO_ITEM_DBG = "DBG: Pawn has no data for this item";

    EMPTY_SLOT = "Empty Slot";

    NOT_UPGRADE     = "Pawn value is too low.";
    NOT_UPGRADE_DBG = "DBG: Not an upgrade.  Pawn value is too low";
  },
nil, true) -- Protected
