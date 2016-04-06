// ===================
// Massta's Custom CFG
// ===================

sv_cheats 1 //Activate cheats for some commands

// =======
// Aliases
// =======

//Testing
alias temp "alias +sc -attack;"
alias +sc "+attack; temp;"
alias -sc "alias +sc +attack;"

//Fast execution
alias auto "exec autoexec;"

//Voicechat
alias "disablevoice" "voice_chat"
alias "voice_chat" "chat_1"
alias "chat_1" "voice_enable 1; playvol buttons\blip1 0.5; echo Voicechat Enabled; alias voice_chat chat_0"
alias "chat_0" "voice_enable 0; playvol buttons\blip2 0.5; echo Voicechat Disabled; alias voice_chat chat_1"


//Custom Graph
alias "+showscores_custom" "+showscores;net_graph 4; cl_showpos 1";
alias "-showscores_custom" "-showscores;net_graph 0; cl_showpos 0";

//Crouchjump
alias +crouchjump "+jump; +duck;"
alias -crouchjump "-jump; -duck;"

//Connects
alias train "connect 94.250.201.9:27015"
alias surf "connect 176.57.141.141:27515"
alias surf2 "connect 176.57.128.36:27025"

//Jumpthrow
alias +jumpthrow "+jump; -attack; -attack2"
alias -jumpthrow -jump

//Middlethrow
alias +middlethrow "+attack; +attack2;"
alias -middlethrow "-attack; -attack2;"

//Drops
alias droptec9 "buy tec9; use weapon_tec9; drop;"

//Flashbang Spam
alias +flashspam "buy flashbang; use weapon_flashbang; +attack;"
alias -flashspam "-attack;"

//Brushview Toggle
alias brushtoggle "toggle r_drawclipbrushes 2 0"

//Showpos Toggle
alias postoggle "toggle cl_showpos 0 1"

//Reload cancel
alias +reload_stop "use weapon_knife"
alias -reload_stop "lastinv"

//Screenmodes
alias screenmode		"fullscreenon"
alias fullscreenon	"mat_setvideomode 1920 1200 0; alias screenmode fullscreenoff;" //Fullscreen
alias fullscreenoff	"mat_setvideomode 1920 1200 1; alias screenmode fullscreenon" //Windowed

//Display Damage with Switch Script
alias displaydamage "displaydamage_on"
alias displaydamage_on "con_filter_text Damage Given To; con_filter_text_out Player:; con_filter_enable 2; developer 1; playvol buttons\blip1 0.5; alias displaydamage "displaydamage_off""
alias displaydamage_off "con_filter_enable 0; developer 0; playvol buttons\blip2 0.5; alias displaydamage "displaydamage_on""

//Show Help Lines
alias "-crosshairsmoke" "cl_crosshairsize 0.5;cl_crosshairdot 1;cl_crosshairgap -4"
alias "+crosshairsmoke" "cl_crosshairsize 1337;cl_crosshairdot 1;cl_crosshairgap 10"
bind "mouse4" "+crosshairsmoke"

//Smokehelp - Switch
alias smokehelp "smokehelpon"
alias smokehelpon "+corsshairsmoke; alias smokehelp smokehelpoff;"
alias smokehelpoff "-corsshairsmoke; alias smokehelp smokehelpon;"



// =====
// Binds
// =====


bind "f1" "killserver"
bind "f2" "disablevoice"
bind "f3" "record temp"
bind "f4" "cl_rebuy"
bind "f5" "displaydamage"
bind "f6" "postoggle"
bind "f7" "brushtoggle"
bind "f8" "screenmode"
bind "f9" "toggleconsole"

bind "p" "noclip"
bind "l" "brushtoggle"
bind "TAB" "+showscores_custom"
bind "mwheeldown" "+jump"
bind "space" "+crouchjump"
bind "mouse3" "+middlethrow"
bind "." "sm_admin"
bind "j" "+jumpthrow"


//Tests/Training
bind "i" "+flashspam"


//Say-binds
bind "enter" "say_team >>GO GO GO!<<"
bind "backspace" "say_team >>SITE IS WEAK! PUSH!<<"

//Numpad: Buymenu 0-9
bind "kp_ins" "buy tec9;"
bind "kp_end" "buy tec9; buy smoke;"
bind "kp_downarrow" "buy galilar; buy famas;"
bind "kp_pgdn" "buy galilar; buy famas;"
bind "kp_leftarrow" "buy galilar; buy famas;"
bind "kp_5" "buy galilar; buy famas;"
bind "kp_rightarrow" "buy galilar; buy famas;"
bind "kp_home" "buy galilar; buy famas;"
bind "kp_uparrow" "buy galilar; buy famas;"
bind "kp_pgup" "buy galilar; buy famas;"

//Standard Binds
bind "1" "slot1"
bind "2" "slot2"
bind "3" "slot3"
bind "4" "slot4"
bind "5" "slot5"
bind "6" "slot6"
bind "w" "+mfwd"
bind "a" "+mleft"
bind "s" "+mback"
bind "d" "+mrught"
bind "e" "+use"
bind "r" "+reload"
bind "u" "say_team"
bind "y" "messagemode"
//bind "q" "invprev"
bind "f" "+lookatweapon"
bind "g" "drop"
bind "b" "buymenu"
bind "m" "teammenu"
bind "e" "+use"
bind "shift" "+speed"
bind "ctrl" "+duck"
//bind "space" "+jump"




// =========
// Crosshair
// =========
cl_crosshair_drawoutline "1"
cl_crosshair_dynamic_maxdist_splitratio "0.0"
cl_crosshair_dynamic_splitalpha_innermod "1"
cl_crosshair_dynamic_splitalpha_outermod "0.300000"
cl_crosshair_dynamic_splitdist "5"
cl_crosshair_outlinethickness "1"
cl_crosshairalpha "235.000000"
cl_crosshaircolor "5"
cl_crosshaircolor_b "0"
cl_crosshaircolor_g "0"
cl_crosshaircolor_r "255"
cl_crosshairdot "1"
cl_crosshairgap "-4.000000"
cl_crosshairgap_useweaponvalue "0"
cl_crosshairscale "0"
cl_crosshairsize "0.500000"
cl_crosshairstyle "5"
cl_crosshairthickness "2.500000"
cl_crosshairusealpha "1"
cl_fixedcrosshairgap "0"
// Bobbing and movement shifting

cl_viewmodel_shift_left_amt "0"
cl_viewmodel_shift_right_amt "0"
cl_bob_lower_amt "0"
cl_bobamt_lat "0"
cl_bobamt_vert "0"
cl_bobcycle "2"


// =====
// Audio
// =====


snd_mixahead "0.05"
snd_musicvolume "0"
snd_headphone_pan_exponent "2.0"
snd_front_headphone_position "45.0"
snd_rear_headphone_position "135.0"

snd_setmixer PlayerFootsteps vol "0.1"
snd_setmixer GlobalFootsteps vol "1.2"
snd_setmixer Ambient vol "0.0"

// =========
// Net Rates
// =========


cl_cmdrate "128"
cl_updaterate "128"
cl_interp_ratio "1"
cl_interp "0"
rate "128000"
cl_lagcompensation "1"
cl_resend "6" //1.5?


// =====
// Mouse
// =====

m_rawinput "1"
m_mouseaccel1 "0"
m_mouseaccel2 "0"
m_customaccel "0"
sensitivity "2.00"


// ====
// Misc
// ====

m_yaw 0.022
cl_disablehtmlmotd "0"
cl_autowepswitch "0"
cl_autohelp "0"
cl_showhelp "0"
cl_righthand "1"
cl_forcepreload "1"
hud_showtargetid "1"
hud_saytext_time 60
mm_dedicated_search_maxping "60"
mat_monitorgamma 1.1
fps_max "300"

// ===========================
// Fig Newton's Fluid Movement
// ===========================


bind w +mfwd
bind s +mback
bind a +mleft
bind d +mright

alias +mfwd "-back;+forward;alias checkfwd +forward"
alias +mback "-forward;+back;alias checkback +back"
alias +mleft "-moveright;+moveleft;alias checkleft +moveleft"
alias +mright "-moveleft;+moveright;alias checkright +moveright"
alias -mfwd "-forward;checkback;alias checkfwd none"
alias -mback "-back;checkfwd;alias checkback none"
alias -mleft "-moveleft;checkright;alias checkleft none"
alias -mright "-moveright;checkleft;alias checkright none"
alias checkfwd none
alias checkback none
alias checkleft none
alias checkright none
alias none ""

ECHO ========[Massta's CFG loaded]========