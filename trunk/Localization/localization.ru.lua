-- Russian text strings

Localization.RegisterAddonStrings("ruRU", "Localization",
  {
    -- Locales
    enUS      = "English";
    enGB      = "English";
    frFR      = "French";
    deDE      = "German";
    ruRU      = "Русский";

    -- Frame Strings
    Confirm         = "Подтвердить";
    Cancel          = "Отмена";
    RemoveUnused    = "Удалить неиспользуемые локали из памяти.";
    SelectPreferred = "Выберите локализацию:";
    AvailLangs      = "Доступные языки";

    --Earth Button
    Localization  = "Локализация";
    ShowPrompt    = "Паказать запрос";
    EarthTooltip  = "Показать диалог выбора локали."
  },
nil, true) -- Protected

Localization.RegisterAddonStrings("ruRU", "Auc-Searcher-Pawn",
  {
    -- Config
    MAIN_TITLE        = "Искать вещи которые Pawn считает улучшением";
	OPTIONS           = "Настройки:";
    HELP_ID           = "Поисковик Auc Searcher Pawn";
    HELP_QUESTION     = "Что делает поисковик?";
    HELP_ANSWER       = "Этот поисковик ищет улучшения для одетых вещей используя шкалы аддона Pawn.";
    CONFIG_HEADER     = "Критерии поиска";
    SCALE_SELECT      = "Имя шкалы Pawn";
    SCALE_SELECT_TIP  = "Шкала Pawn будет ипользована для определения значения вещи";
    CHECK_CURRENT     = "Использовать текущее значение";
    CHECK_CURRENT_TIP = "Если обозначено, вещи будут рассчитываться 'как есть'.  Пустые сокеты будут игнорироваться.  Будут применяться все инчанты.  Если не обозначено, вещи будут рассчитываться без инчантов и для пустых сокетов будут использоваться значения заданные в шкале Pawn.";
    USEABLE_ONLY      = "Только подходящие вещи";
    USEABLE_ONLY_TIP  = "Только вещи которые может использовать ваш персонаж.";
    FORCE_MAIN        = "Использовать правую руку";
    FORCE_MAIN_TIP    = "Вещи с левой руки будут сравниваться только с вещью из правой руки.";
    AFFORD_ONLY       = "Только то что я могу купить";
    AFFORD_ONLY_TIP   = "Отображать только те вещи которые я могу купить.";
    USE_BUYOUT        = "Ипользовать выкуп";
    USE_BUYOUT_TIP    = "Ипользовать метод выкупа вместо ставок при просмотре цен аукциона";
    FORCE2H_WEAP      = "только 2H";
    FORCE2H_TIP       = "Вы хотите найти ДВУРУЧНОЕ оружие, которое будет лучше чем то, что вами используется в данный момент.";

	INCLUDE_IN_SEARCH = "Искать предметы из отмеченных слотов:";
    SHOW_HEAD         = "Голова";
    SHOW_NECK         = "Шея";
    SHOW_SHOULDER     = "Плечи";
    SHOW_BACK         = "Спина";
    SHOW_CHEST        = "Грудь";
    SHOW_WRIST        = "Запястья";
    SHOW_HANDS        = "Перчатки";
    SHOW_WAIST        = "Пояс";
    SHOW_LEGS         = "Ноги";
    SHOW_FEET         = "Обувь";
    SHOW_FINGER       = "Кольца";
    SHOW_TRINKET      = "Аксессуары";
    SHOW_WEAPON       = "Правая рука";
    SHOW_OFFHAND      = "Левая рука";
    SHOW_RANGED       = "Дальний бой";

    --Classes
    WARRIOR      = "Воин";
    HUNTER       = "Охотник";
    SHAMAN       = "Шаман";
    ROGUE        = "Разбойник";
    DEATH_KNIGHT = "Рыцарь смерти";

    --Item Types
    ARMOR   = "Броня";
    TOTEMS  = "Тотемы";
    LIBRAMS = "Манускрипты";
    IDOLS   = "Идолы";
    SIGILS  = "Печати";

	--Stat
    TWOHANDDPS = "DPS Двуручного оружия"; -- This is the text from Pawn.  Not sure if it is localized or not

	-- Skill
    DUALWIELD = "Бой двумя оружиями";  -- used to see if a hunter has learned the ability or not

    -- Messages
	BAD_SCALE   = "Пожалуйста, выберите Шкалу Pawn";
    NOT_WANTED  = "Данный слот не нужен";
    NOT_UPGRADE = "Значение Pawn очень низкое";

    REASON_BUY = "Buy";
    REASON_BID = "Bid";

  },
nil, true) -- Protected
