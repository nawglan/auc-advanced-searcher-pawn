-- English text strings

Localization.RegisterAddonStrings("ptBR", "Localization",
  {
    -- Locales
    enUS      = "Inglês";
    enGB      = "Inglês";
    frFR      = "Francês";
    deDE      = "Alemão";
    ruRU      = "Russo";
    zhTW      = "Chinês Tradicional";
    ptBR      = "Português";

    -- Frame Strings
    Confirm         = "Confirmar";
    Cancel          = "Cancelar";
    RemoveUnused    = "Remover da memoria localizações não usadas.";
    SelectPreferred = "Seleccione um o idioma preferido:";
    AvailLangs      = "Idiomas disponíveis";

    --Earth Button
    Localization  = "Localização";
    ShowPrompt    = "Mostrar aviso";
    EarthTooltip  = "Mostrar dialogo de selecção local."
  },
nil, true) -- Protected

Localization.RegisterAddonStrings("ptBR", "Auc-Searcher-Pawn",
  {
    -- Config
    MAIN_TITLE        = "Procurar for itens que o Pawn considera um melhoramento";
    OPTIONS           = "Opções:";
    HELP_ID           = "Pesquisador do Pawn";
    HELP_QUESTION     = "O que faz este pesquisador?";
    HELP_ANSWER       = "Esta procura irá usar a escala que foi definida no addon Pawn para localizar upgrades para o equipamento que tem equipado.";
    CONFIG_HEADER     = "Critérios de procura do Pawn";
    SCALE_SELECT      = "Escala do Pawn";
    SCALE_SELECT_TIP  = "A escala do Pawn que que vai ser usada para determinar o valor do item";
    USEABLE_ONLY      = "Apenas itens que possa usar";
    USEABLE_ONLY_TIP  = "Apenas itens que o seu personagem possa usar.";
    AFFORD_ONLY       = "Apenas o que consigo comprar";
    AFFORD_ONLY_TIP   = "Mostra apenas o que consegue comprar de momento com o dinheiro disponível.";
    USE_BUYOUT        = "Usar Arremate";
    USE_BUYOUT_TIP    = "Usar Arremate em vez de Lance quando verificar os preços dos leilões.";
    USE_BESTPRICE     = "Ajustar o 'score' baseado no preço.";
    USE_BESTPRICE_TIP = "Ajustar o 'score' mostrado pelo preço do item. Para itens similares, o mais barato ficará acima na lista.";
    FORCE2H_WEAP      = "Apenas Armas 2M";
    FORCE2H_TIP       = "Ao comparar armas, considerar apenas Armas de Duas mãos";
    INCLUDE_IN_SEARCH = "Incluir estas caixas ao procurar:";
    SHOW_HEAD         = "Cabeça";
    SHOW_NECK         = "Pescoço";
    SHOW_SHOULDER     = "Ombro";
    SHOW_BACK         = "Costas";
    SHOW_CHEST        = "Torso";
    SHOW_WRIST        = "Pulsos";
    SHOW_HANDS        = "Mãos";
    SHOW_WAIST        = "Cintura";
    SHOW_LEGS         = "Pernas";
    SHOW_FEET         = "Pés";
    SHOW_FINGER       = "Dedo";
    SHOW_TRINKET      = "Berloque";
    SHOW_WEAPON       = "Arma";
    SHOW_OFFHAND      = "Mão Secundária";
    SHOW_RANGED       = "Arremesso";

    --Classes
    WARRIOR      = "Gerreiro";
    HUNTER       = "Caçador";
    SHAMAN       = "Shamã";
    ROGUE        = "Ladino";
    DEATH_KNIGHT = "Cavaleiro da Morte";

    --Item Types
    ARMOR   = "Armadura";
    TOTEMS  = "Totems";
    LIBRAMS = "Librams";
    IDOLS   = "Ídolos";
    SIGILS  = "Sigils";

    --Two Handed substr
    TWOHAND = "Duas Mãos";  -- used to check if user has a 2handed weapon on or not
    STAVES = "Cajados";     -- used to check if user has a 2handed weapon on or not
    POLEARMS = "Arma de Haste"; -- used to check if user has a 2handed weapon on or not

    -- Skill
    DUALWIELD = "Dual Wield";  -- used to see if a hunter has learned the ability or not

    -- Messages
    BAD_SCALE   = "Por favor seleccione uma escala válida.";
    NOT_WANTED  = "Caixa de item não incluída";
    NOT_UPGRADE = "O valor do Pawn é muito baixo.";

    REASON_BUY = "comprar";
    REASON_BID = "lance";
  },
nil, true) -- Protected
