-- English text strings

Localization.RegisterAddonStrings("itIT", "Localization",
  {
    -- Locales
    enUS      = "Inglese";
    enGB      = "Inglese";
    frFR      = "Francese";
    ruRU      = "Russo";
    zhTW      = "Cinese tradizionale";
    deDE      = "Tedesco";
    ptBR      = "Portoghese";

    -- Frame Strings
    Confirm         = "Confirm";
    Cancel          = "Cancel";
    RemoveUnused    = "Rimuovere locali non utilizzati dalla memoria.";
    SelectPreferred = "Selezionare una localizzazione preferita:";
    AvailLangs      = "Lingue disponibili";

    --Earth Button
    Localization  = "Localization";
    ShowPrompt    = "Show Prompt";
    EarthTooltip  = "Mostra selezione dialogo Locale.";
  },
nil, true) -- Protected

Localization.RegisterAddonStrings("itIT", "Auc-Searcher-Pawn",
  {
    -- Config
    MAIN_TITLE        = "Cerca articoli che Pawn considera un aggiornamento";
    OPTIONS           = "Opzioni:";
    HELP_ID           = "Pawn Searcher";
    HELP_QUESTION     = "Che cosa fa questo ricercatore fare?";
    HELP_ANSWER       = "Questo ricercatore utilizza una scala che è stato definito nel addon Pawn per individuare gli aggiornamenti per i vostri elementi attualmente attrezzate.";
    CONFIG_HEADER     = "Pawn Criteri di ricerca";
    SCALE_SELECT      = "Pawn scala";
    SCALE_SELECT_TIP  = "La scala Pawn che verrà utilizzato per determinare il valore dell'elemento";
    USEABLE_ONLY      = "Oggetti utilizzabili solo";
    USEABLE_ONLY_TIP  = "Solo gli elementi che il tuo personaggio può utilizzare.";
    AFFORD_ONLY       = "Solo quello che mi posso permettere";
    AFFORD_ONLY_TIP   = "Mostra solo ciò che si può attualmente permettersi di acquistare.";
    USE_BUYOUT        = "Utilizzare buyout";
    USE_BUYOUT_TIP    = "Uso buyout invece di offerta quando il controllo dei prezzi d'asta.";
    USE_BESTPRICE        = "Regolare punteggio in base al prezzo.";
    USE_BESTPRICE_TIP    = "Regolare il punteggio restituito dal prezzo del prodotto. Articoli simili, l'elemento più economico sarà più alto nella lista.";
    FORCE2H_WEAP      = "Solo armi a due mani.";
    FORCE2H_TIP       = "Quando si confrontano le armi, in considerazione solo armi a due mani.";
    INCLUDE_IN_SEARCH = "Includere questi slot per la ricerca:";
    SHOW_HEAD         = "Testa";
    SHOW_NECK         = "Collo";
    SHOW_SHOULDER     = "Spalle";
    SHOW_BACK         = "Schiena";
    SHOW_CHEST        = "Torso";
    SHOW_WRIST        = "Polsi";
    SHOW_HANDS        = "Mani";
    SHOW_WAIST        = "Cintura";
    SHOW_LEGS         = "Gambe";
    SHOW_FEET         = "Piedi";
    SHOW_FINGER       = "Dito";
    SHOW_TRINKET      = "Orecchino";
    SHOW_WEAPON       = "Arma";
    SHOW_OFFHAND      = "Mano Secondaria";
    SHOW_RANGED       = "a Distanza";

    --Classes
    WARRIOR      = "Guerriero";
    MONK         = "Monk";
    HUNTER       = "Cacciatore";
    SHAMAN       = "Sciamano";
    ROGUE        = "Ladro";
    DEATH_KNIGHT = "Cavaliere della Morte";

    --Item Types
    ARMOR   = "Armatura";
    TOTEMS  = "Totems";
    LIBRAMS = "Tomi";
    IDOLS   = "Idoli";
    SIGILS  = "Sigilli";

    --Two Handed substr
    TWOHAND = "a Due Mani";  -- used to check if user has a 2handed weapon on or not
    STAVES = "Bastoni";     -- used to check if user has a 2handed weapon on or not
    POLEARMS = "Armi ad Asta"; -- used to check if user has a 2handed weapon on or not

    BOWS = "Archi"; -- used to check if a user wants to evaluate Ranged weapons
    GUNS = "Armi da fuoco"; -- used to check if a user wants to evaluate Ranged weapons
    WANDS = "Bacchette"; -- used to check if a user wants to evaluate Ranged weapons
    CROSSBOWS = "Balestre"; -- used to check if a user wants to evaluate Ranged weapons
    THROWN = "da Lancio"; -- used to check if a user wants to evaluate Ranged weapons

    -- Skill
    DUALWIELD = "Dual Wield";  -- used to see if a shaman or hunter has learned the ability or not
    CRAZED_BERZERKER = "Crazed Berzerker"; -- skill that gives warriors dual wield
    TITANS_GRIP = "Presa del Titano"; -- skill that gives warriors ability to dual wield 2handed weapons

    -- Messages
    BAD_SCALE   = "Please select a valid scale.";
    NOT_WANTED  = "Slot Articolo non voluto";
    NOT_UPGRADE = "Pawn valore è troppo basso.";

    REASON_BUY = "acquistare";
    REASON_BID = "offrire";
  },
nil, true) -- Protected
