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

	--SHOW_DEBUG        = "Отображать информацию отладки";
    --SHOW_DEBUG_TIP    = "Внимание: при включении отладки вы получите огромное количество информации (возможно ненужной) в чате.";
    --ONLY_FALSE        = "только false";
    --ONLY_FALSE_TIP    = "Отображать отладочную информацию только для вещей которые НЕ подошли.";
    --ONLY_TRUE         = "только true";
    --ONLY_TRUE_TIP     = "Отображать отладочную информацию только для вещей которые подошли.";

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

    -- Messages
    NO_SCALE     = "Нет названия шкалы";
    NO_SCALE_DBG = "DBG: Шкала не определена, выберите шкалу из списка.  Если нет ни одной шкалы то нужно создать шкалу сначала.";

    SCALE_BLANK     = "Шкала пуста";
    SCALE_BLANK_DBG = "DBG: Шкала не определена, выберите шкалу из списка.  Если шкала не заполена значениями то нужно заполнить шкалу сначала.";

    SCALE_NOT_FOUND     = "Шкала не найдена";
    SCALE_NOT_FOUND_DBG = "DBG: Ошибка! Шкала Pawn не найдена";

    NO_LINK     = "Нет линка";
    NO_LINK_DBG = "DBG: нет линка";

    CANNOT_USE     = "Не используется";
    CANNOT_USE_DBG = "DBG: Нельзя использовать эту вещь";

    NOT_EQUIPPABLE     = "Не одеваемое";
    NOT_EQUIPPABLE_DBG = "DBG: Нельзя одеть эту вещь";

    CANNOT_AFFORD_BUYOUT = "Нельзя выкупить";
    CANNOT_AFFORD_BID    = "Нельзя сделать ставку";
    CANNOT_AFFORD_DBG    = "DBG: Нельзя сделать ставку/выкупить эту вещь";

    REASON_BUY = "выкуп";
    REASON_BID = "ставка";

    NO_ITEM     = "Нет вещи";
    NO_ITEM_DBG = "DBG: У Pawn нет данных на эту вещь";

    EMPTY_SLOT = "Пусто";

    NOT_UPGRADE     = "Значение Pawn слишком мало.";
    NOT_UPGRADE_DBG = "DBG: Не улучшение. Значние Pawn слишком мало";
  },
nil, true) -- Protected
