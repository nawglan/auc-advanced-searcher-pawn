﻿-- Russian text strings

Localization.RegisterAddonStrings("ruRU", "Localization",
  {
    -- Locales
    enUS  = "English";
    enGB  = "English";
    frFR  = "French";
    ruRU  = "Русский";
    zhTW  = "Китайский традиционный";
    deDE  = "German";
    ptBR  = "португальский";

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
    USEABLE_ONLY      = "Только подходящие вещи";
    USEABLE_ONLY_TIP  = "Только вещи которые может использовать ваш персонаж.";
    AFFORD_ONLY       = "Только то что я могу купить";
    AFFORD_ONLY_TIP   = "Отображать только те вещи которые я могу купить.";
    USE_BUYOUT        = "Ипользовать выкуп";
    USE_BUYOUT_TIP    = "Ипользовать метод выкупа вместо ставок при просмотре цен аукциона";
    USE_BESTPRICE        = "Отрегулируйте оценка основана на цене.";
    USE_BESTPRICE_TIP    = "Отрегулируйте оценка по стоимости товара. Для подобных изделий, дешевле пункт будет выше в списке.";
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

    --Armor Preference
    ARMORPREF_SELECT_TIP = "При поиске брони, показывают только выбранный тип брони в результатах поиска. Отфильтровать все другие типы брони.";
    ARMOR_PREFERENCE = "Броня предпочтения";
    NO_PREF   = "Без предпочтений";
    CLOTH     = "Ткань";
    LEATHER   = "Кожа";
    MAIL      = "Кольчуга";
    PLATE     = "Латы";

    --Item Types
    ARMOR   = "Броня";
    TOTEMS  = "Тотемы";
    LIBRAMS = "Манускрипты";
    IDOLS   = "Идолы";
    SIGILS  = "Печати";
    SHIELDS = "Щиты";
    MISC    = "Разное";

    --Two Handed substr
    TWOHAND = "Двуручное";  -- used to check if user has a 2handed weapon on or not
    STAVES = "Посохи";     -- used to check if user has a 2handed weapon on or not
    POLEARMS = "Древковое"; -- used to check if user has a 2handed weapon on or not

    BOWS = "Луки"; -- used to check if a user wants to evaluate Ranged weapons
    GUNS = "Огнестрельное"; -- used to check if a user wants to evaluate Ranged weapons
    WANDS   = "Жезлы"; -- used to check if a user wants to evaluate Ranged weapons
    CROSSBOWS = "Арбалеты"; -- used to check if a user wants to evaluate Ranged weapons
    THROWN = "Метательное"; -- used to check if a user wants to evaluate Ranged weapons

    -- Messages
    BAD_SCALE   = "Пожалуйста, выберите Шкалу Pawn";
    NOT_WANTED  = "Данный слот не нужен";
    NOT_UPGRADE = "Значение Pawn очень низкое";

    REASON_BUY = "Выкуп";
    REASON_BID = "Ставка";
  },
nil, true) -- Protected
