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
    OPTIONS           = "Options:";
    HELP_ID           = "Pawn Searcher";
    HELP_QUESTION     = "What does this searcher do?";
    HELP_ANSWER       = "This searcher will use a scale that has been defined in the Pawn addon to locate upgrades for your currently equipped items.";
    CONFIG_HEADER     = "Pawn Search Criteria";
    SCALE_SELECT      = "Pawn scale";
    SCALE_SELECT_TIP  = "The Pawn scale that will be used to determine the item value";
    USEABLE_ONLY      = "Useable items only";
    USEABLE_ONLY_TIP  = "Only items that your character can use.";
    AFFORD_ONLY       = "Only what I can afford";
    AFFORD_ONLY_TIP   = "Only show what you can currently afford to buy.";
    USE_BUYOUT        = "Use buyout";
    USE_BUYOUT_TIP    = "Use buyout instead of bid when checking auction prices.";
    FORCE2H_WEAP      = "Only 2H Weapons";
    FORCE2H_TIP       = "When comparing weapons, only consider 2-Handed Weapons.";

    INCLUDE_IN_SEARCH = "Include these slots when searching:";
    SHOW_HEAD         = "Head";
    SHOW_NECK         = "Neck";
    SHOW_SHOULDER     = "Shoulder";
    SHOW_BACK         = "Back";
    SHOW_CHEST        = "Chest";
    SHOW_WRIST        = "Wrist";
    SHOW_HANDS        = "Hands";
    SHOW_WAIST        = "Waist";
    SHOW_LEGS         = "Legs";
    SHOW_FEET         = "Feet";
    SHOW_FINGER       = "Finger";
    SHOW_TRINKET      = "Trinket";
    SHOW_WEAPON       = "Weapon";
    SHOW_OFFHAND      = "Off-Hand";
    SHOW_RANGED       = "Ranged";
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
    NO_SCALE_DBG = "DBG: No scale defined, please pick a scale from the dropdown list.  If none exist you will need to define a scale in Pawn first.";

    SCALE_BLANK_DBG = "DBG: No scale defined, please pick a scale from the dropdown list.  If none exist you will need to define a scale in Pawn first.";

    SCALE_NOT_FOUND_DBG = "DBG: Error! Pawn cannot find scale";

    NO_LINK_DBG = "DBG: No link";

    CANNOT_USE_DBG = "DBG: Can't use this item";

    NOT_WANTED     = "Item slot not wanted";

    REASON_BUY = "buy";
    REASON_BID = "bid";

    NO_ITEM_DBG = "DBG: Pawn has no data for this item";

    NOT_UPGRADE     = "Pawn value is too low.";
  },
nil, true) -- Protected
