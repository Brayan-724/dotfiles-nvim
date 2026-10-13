; TODO: apply @markup.heading.? for headings as described in
;       https://wiki.bedrock.dev/commands/mcfunctions#comments-style-guide

(comment) @comment

(int)            @number
(float)          @number.float
["true" "false"] @boolean

(score) @variable

[
 "<"
 "<="
 "="
 ">"
 ">="
 "+="
 "-="
 "*="
 "/="
 "*/"
 "<>"
]      @operator
("!")  @operator
("/")  @operator
("..") @punctuation.delimiter
(",")  @punctuation.delimiter
("=")  @punctuation.delimiter
("[")  @punctuation.bracket
("]")  @punctuation.bracket

(string)        @string
(quoted_string) @string
(emoji)         @string.escape
(style)         @string.escape ; TODO: use @markup.strong etc for §l etc
(filepath)      @string.special.path
(message)       @string
(message)       @spell


;; Subcommands

[
 "actionbar"
 "title"
 "subtitle"
 "times"
] @keyword

;;; `execute` options

[
 "in"
 "positioned"
 "as"
 "at"
 "rotated"
 "facing"
 "entity" ; FIXME: also part of `replaceitem entity`
 "align"
] @keyword.modifier
["if" "unless"] @keyword.conditional
("run") @keyword
("matches") @keyword.operator


;; Commands

["help" "?"] @keyword.debug
("function") @function.call
[
 "tag"
 "camera"
 "script"
 "connect"
 "stop"
 "transfer"
 "clear"
 "aimassist"
 "time"
 "camerashake"
 "clearspawnpoint"
 "clone"
 "controlscheme"
 "damage"
 "daylock"
 "alwaysday"
 "deop"
 "dialogue"
 "difficulty"
 "effect"
 "event"
 "execute"
 "fill"
 "fog"
 ;"function"
 "gamemode"
 "gamerule"
 "gametest"
 "gettopsolidblock"
 "give"
 ;"help"
 ;"?"
 "hud"
 "inputpermission"
 "kick"
 "kill"
 "list"
 "listd"
 "structure"
 "locate"
 "loot"
 "me"
 "mobevent"
 "music"
 "op"
 "particle"
 "reload"
 "permission"
 "ops"
 "place"
 "playanimation"
 "playsound"
 "querytarget"
 "replaceitem"
 "ride"
 "say"
 "tickingarea"
 "schedule"
 "scoreboard"
 "scriptevent"
 "setblock"
 "setmaxplayers"
 "setworldspawn"
 "spawnpoint"
 "spreadplayers"
 "stopsound"
 "save"
 "summon"
 "teleport"
 "tp"
 "tell"
 "w"
 "msg"
 "tellraw"
 "testforblock"
 "testforblocks"
 "testfor"
 "title"
 "titleraw"
 "toggledownfall"
 "weather"
 "wsserver"
 "xp"
 "recipe"
 "project"
 "agent"
 "codebuilder_actorinfo"
 "enchant"
 "clearrealmevents"
 "allowlist"
 "whitelist"
 "reloadpacketlimitconfig"
 "changesetting"
 "sendshowstoreoffer"
 "reloadconfig"
] @keyword

(selector_arg_key) @property
(selector_variable) @string.special.symbol
(player_selector) @string.special

(block_state_value) @property
