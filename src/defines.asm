; ---------------
; Compiler Flags
; ---------------

!FEATURE_REDESIGN ?= 0
!FEATURE_SD2SNES ?= 1
!ORIGINAL_MESSAGE_TEXT ?= 0
!PRESERVE_WRAM_DURING_SPACETIME ?= 1

!VERSION_MAJOR = 2
!VERSION_MINOR = 4
!VERSION_BUILD = 0
!VERSION_REV_1 = 0
!VERSION_REV_2 = 4

; ---------
; Work RAM
; ---------

!WRAM_BANK = #$007E
!WRAM_SIZE = #$0200
!WRAM_START = $7EFB00

!ram_load_preset = !WRAM_START+$00
!ram_gametime_room = !WRAM_START+$02
!ram_last_gametime_room = !WRAM_START+$04
!ram_realtime_room = !WRAM_START+$06
!ram_last_realtime_room = !WRAM_START+$08
!ram_last_room_lag = !WRAM_START+$0A
!ram_last_door_lag_frames = !WRAM_START+$0C
!ram_transition_counter = !WRAM_START+$0E
!ram_transition_flag = !WRAM_START+$10
!ram_transition_flag_2 = !WRAM_START+$12

!ram_seg_rt_frames = !WRAM_START+$14
!ram_seg_rt_seconds = !WRAM_START+$16
!ram_seg_rt_minutes = !WRAM_START+$18
!ram_reset_segment_later = !WRAM_START+$1A

!ram_ih_controller = !WRAM_START+$1C
!ram_slowdown_controller_1 = !WRAM_START+$1E
!ram_slowdown_controller_2 = !WRAM_START+$20
!ram_slowdown_frames = !WRAM_START+$22

!ram_tmp_1 = !WRAM_START+$24
!ram_tmp_2 = !WRAM_START+$26
!ram_tmp_3 = !WRAM_START+$28
!ram_tmp_4 = !WRAM_START+$2A

!ram_last_hp = !WRAM_START+$2C
!ram_reserves_last = !WRAM_START+$2E

!ram_pct_1 = !WRAM_START+$30
!ram_pct_2 = !WRAM_START+$32
!ram_armed_shine_duration = !WRAM_START+$34
!ram_minimap = !WRAM_START+$36
!ram_map_counter = !WRAM_START+$38
!ram_vcounter_data = !WRAM_START+$3A

!ram_sprite_samus_hitbox_active = !WRAM_START+$3C
!ram_sprite_enemy_hitbox_active = !WRAM_START+$3E
!ram_sprite_extended_hitbox_active = !WRAM_START+$40
!ram_oob_watch_active = !WRAM_START+$42
!ram_sprite_samusproj_hitbox_active = !WRAM_START+$44
!ram_sprite_enemyproj_hitbox_active = !WRAM_START+$46
!ram_custom_preset = !WRAM_START+$48
!ram_fix_scroll_offsets = !WRAM_START+$4A

; ^ FREE SPACE ^ up to +$4E

!ram_magic_pants_enabled = !WRAM_START+$50
!ram_magic_pants_state = !WRAM_START+$52
!ram_magic_pants_pal1 = !WRAM_START+$54
!ram_magic_pants_pal2 = !WRAM_START+$56
!ram_magic_pants_pal3 = !WRAM_START+$58
!ram_draygon_rng_left = !WRAM_START+$5E
!ram_draygon_rng_right = !WRAM_START+$60

!ram_room_has_set_rng = !WRAM_START+$5A
!ram_kraid_rng = !WRAM_START+$5C
!ram_crocomire_rng = !WRAM_START+$5E
!ram_phantoon_rng_1 = !WRAM_START+$60
!ram_phantoon_rng_2 = !WRAM_START+$62
!ram_phantoon_rng_3 = !WRAM_START+$64
!ram_phantoon_rng_4 = !WRAM_START+$66
!ram_phantoon_rng_5 = !WRAM_START+$68
!ram_botwoon_rng = !WRAM_START+$6A
!ram_draygon_rng_left = !WRAM_START+$6C
!ram_draygon_rng_right = !WRAM_START+$6E

!ram_game_loop_extras = !WRAM_START+$70
!ram_game_mode_extras = !WRAM_START+$72
!ram_sprite_features_active = !WRAM_START+$74

!ram_suits_enemy_damage_check = !WRAM_START+$76
!ram_suits_periodic_damage_check = !WRAM_START+$78

!ram_metronome = !WRAM_START+$7A
!ram_metronome_counter = !WRAM_START+$7C

; ^ FREE SPACE ^ up to +$88

!ram_tel_debug_area = !WRAM_START+$8A
!ram_tel_debug_station = !WRAM_START+$8C

!ram_watch_left_index = !WRAM_START+$88
!ram_watch_right_index = !WRAM_START+$8A
!ram_watch_write_mode = !WRAM_START+$8C
!ram_watch_bank = !WRAM_START+$8E
!ram_watch_left = !WRAM_START+$90
!ram_watch_left_hud = !WRAM_START+$92
!ram_watch_right = !WRAM_START+$94
!ram_watch_right_hud = !WRAM_START+$96
!ram_watch_edit_left = !WRAM_START+$98
!ram_watch_edit_right = !WRAM_START+$9A
!ram_watch_edit_lock_left = !WRAM_START+$9C
!ram_watch_edit_lock_right = !WRAM_START+$9E

!ram_HUD_check = !WRAM_START+$A0
!ram_roomstrat_counter = !WRAM_START+$A2
!ram_roomstrat_state = !WRAM_START+$A4
!ram_enemy_hp = !WRAM_START+$A6
!ram_mb_hp = !WRAM_START+$A8
!ram_shot_timer = !WRAM_START+$AA
!ram_shine_counter = !WRAM_START+$AC
!ram_dash_counter = !WRAM_START+$AE
!ram_shinetune_early_1 = !WRAM_START+$B0
!ram_shinetune_late_1 = !WRAM_START+$B2
!ram_shinetune_early_2 = !WRAM_START+$B4
!ram_shinetune_late_2 = !WRAM_START+$B6
!ram_shinetune_early_3 = !WRAM_START+$B8
!ram_shinetune_late_3 = !WRAM_START+$BA
!ram_shinetune_early_4 = !WRAM_START+$BC
!ram_shinetune_late_4 = !WRAM_START+$BE
!ram_shine_dash_held_late = !WRAM_START+$C0
!ram_xpos = !WRAM_START+$C2
!ram_ypos = !WRAM_START+$C4
!ram_subpixel_pos = !WRAM_START+$C6
!ram_horizontal_speed = !WRAM_START+$C8
!ram_vertical_speed = !WRAM_START+$CA
!ram_quickdrop_counter = !WRAM_START+$CC
!ram_walljump_counter = !WRAM_START+$CE

; ^ FREE SPACE ^ up to +$FC

; -----------------------
; RAM (Bank 7E required)
; -----------------------

!ram_slowdown_mode = $7EFBFE

; ---------
; RAM Menu
; ---------

!WRAM_MENU_START = $7EFC00

!ram_cm_stack_index = $05D5
!ram_cm_menu_stack = !WRAM_MENU_START+$00         ; 16 bytes
!ram_cm_cursor_stack = !WRAM_MENU_START+$10       ; 16 bytes

!ram_cm_cursor_max = !WRAM_MENU_START+$20
!ram_cm_input_timer = !WRAM_MENU_START+$24
!ram_cm_controller = !WRAM_MENU_START+$26
!ram_cm_menu_bank = !WRAM_MENU_START+$28

!ram_cm_etanks = !WRAM_MENU_START+$2A
!ram_cm_reserve = !WRAM_MENU_START+$2C
!ram_cm_leave = !WRAM_MENU_START+$2E
!ram_cm_input_counter = !WRAM_MENU_START+$30
!ram_cm_last_nmi_counter = !WRAM_MENU_START+$32

!ram_cm_ctrl_mode = !WRAM_MENU_START+$34
!ram_cm_ctrl_timer = !WRAM_MENU_START+$36
!ram_cm_ctrl_last_input = !WRAM_MENU_START+$38
!ram_cm_ctrl_assign = !WRAM_MENU_START+$3A
!ram_cm_ctrl_swap = !WRAM_MENU_START+$3C
!ram_cm_botwoon_rng = !WRAM_MENU_START+$3E

!ram_cm_morphlock = !WRAM_MENU_START+$3A
!ram_cm_menu_active = !WRAM_MENU_START+$3C

; ^ FREE SPACE ^ up to +$7E

; ------------------
; Reusable RAM Menu
; ------------------

; The following RAM may be used multiple times,
; as long as it isn't used multiple times on the same menu page

!ram_cm_watch_left_hi = !WRAM_MENU_START+$80
!ram_cm_watch_left_lo = !WRAM_MENU_START+$82
!ram_cm_watch_right_hi = !WRAM_MENU_START+$84
!ram_cm_watch_right_lo = !WRAM_MENU_START+$86
!ram_cm_watch_left_index_lo = !WRAM_MENU_START+$88
!ram_cm_watch_left_index_hi = !WRAM_MENU_START+$8A
!ram_cm_watch_right_index_lo = !WRAM_MENU_START+$8C
!ram_cm_watch_right_index_hi = !WRAM_MENU_START+$8E
!ram_cm_watch_edit_left_hi = !WRAM_MENU_START+$90
!ram_cm_watch_edit_left_lo = !WRAM_MENU_START+$92
!ram_cm_watch_edit_right_hi = !WRAM_MENU_START+$94
!ram_cm_watch_edit_right_lo = !WRAM_MENU_START+$96
!ram_cm_watch_enemy_property = !WRAM_MENU_START+$98
!ram_cm_watch_enemy_index = !WRAM_MENU_START+$9A
!ram_cm_watch_enemy_side = !WRAM_MENU_START+$9C
!ram_cm_watch_bank = !WRAM_MENU_START+$9E
!ram_cm_watch_common_address = !WRAM_MENU_START+$A0

; ^ FREE SPACE ^ up to +$CE

!ram_cgram_cache = !WRAM_MENU_START+$D0         ; 20 bytes

!ram_hex2dec_first_digit = $14
!ram_hex2dec_second_digit = $16
!ram_hex2dec_third_digit = $18
!ram_hex2dec_rest = $1A

!ACTION_TOGGLE          = #$0000
!ACTION_TOGGLE_BIT      = #$0002
!ACTION_JSR             = #$0004
!ACTION_NUMFIELD        = #$0006
!ACTION_CHOICE          = #$0008
!ACTION_CTRL_SHORTCUT   = #$000A
!ACTION_NUMFIELD_HEX    = #$000C
!ACTION_NUMFIELD_WORD   = #$000E
!ACTION_TOGGLE_INVERTED = #$0010
!ACTION_NUMFIELD_COLOR  = #$0012
!ACTION_CTRL_INPUT      = #$0014

!SOUND_MENU_MOVE = $0039
!SOUND_MENU_JSR = $0039
!SOUND_MENU_FAIL = $0007


; ---------
; Pointers
; ---------

!IH_CONTROLLER_PRI = $8B
!IH_CONTROLLER_PRI_NEW = $8F
!IH_CONTROLLER_PRI_PREV = $97

!IH_CONTROLLER_ML = $CB
!IH_CONTROLLER_ML_NEW = $CF
!IH_CONTROLLER_ML_PREV = $C7

!IH_CONTROLLER_SEC = $8D
!IH_CONTROLLER_SEC_NEW = $91
!IH_CONTROLLER_SEC_PREV = $99

!IH_BLANK = #$2C0F
!IH_PERCENT = #$0C0A
!IH_DECIMAL = #$0CCB
!IH_HYPHEN = #$0C60
!IH_RESERVE_AUTO = #$0C32
!IH_RESERVE_EMPTY = #$0C33
!IH_BOMB = #$0058
!IH_MORPHBALL = #$1CC9
!IH_ELEVATOR = #$1CCE
!IH_SHINETIMER = #$00CF
!IH_HEALTHBOMB = #$0847
!IH_LETTER_A = #$0CD8
!IH_LETTER_B = #$0CD9
!IH_LETTER_C = #$0C33
!IH_LETTER_D = #$0C45
!IH_LETTER_E = #$0C47
!IH_LETTER_F = #$0C48
!IH_LETTER_H = #$0CCA
!IH_LETTER_L = #$0C0B
!IH_LETTER_N = #$0CB8
!IH_LETTER_R = #$0C0C
!IH_LETTER_X = #$0CDA
!IH_LETTER_Y = #$0CDB

!IH_PAUSE = #$0100 ; right
!IH_SLOWDOWN = #$0400 ; down
!IH_SPEEDUP = #$0800 ; up
!IH_RESET = #$0200 ; left
!IH_STATUS_R = #$0010 ; r
!IH_STATUS_L = #$0020 ; l

!IH_INPUT_START = #$1000
!IH_INPUT_UP = #$0800
!IH_INPUT_DOWN = #$0400
!IH_INPUT_LEFT = #$0200
!IH_INPUT_RIGHT = #$0100
!IH_INPUT_HELD = #$0001 ; used by menu

!CTRL_B = #$8000
!CTRL_Y = #$4000
!CTRL_SELECT = #$2000
!CTRL_A = #$0080
!CTRL_X = #$0040
!CTRL_L = #$0020
!CTRL_R = #$0010

!IH_INPUT_SHOOT = $7E09B2
!IH_INPUT_JUMP = $7E09B4
!IH_INPUT_RUN = $7E09B6
!IH_INPUT_ITEM_CANCEL = $7E09B8
!IH_INPUT_ITEM_SELECT = $7E09BA
!IH_INPUT_ANGLE_DOWN = $7E09BC
!IH_INPUT_ANGLE_UP = $7E09BE


; --------------
; Vanilla Labels
; --------------

!MUSIC_ROUTINE = $808FC1
!SFX_LIB1 = $80903F
!SFX_LIB2 = $8090C1
!SFX_LIB3 = $809143

!OAM_STACK_POINTER = $0590
!SOUND_TIMER = $0686
!ROOM_ID = $079B
!MUSIC_DATA = $07F3
!MUSIC_TRACK = $07F5
!LAYER1_X = $0911
!LAYER1_Y = $0915
!GAMEMODE = $0998
!SAMUS_ITEMS_EQUIPPED = $09A2
!SAMUS_ITEMS_COLLECTED = $09A4
!SAMUS_BEAMS_EQUIPPED = $09A6
!SAMUS_BEAMS_COLLECTED = $09A8
!SAMUS_RESERVE_MODE = $09C0
!SAMUS_HP = $09C2
!SAMUS_HP_MAX = $09C4
!SAMUS_MISSILES = $09C6
!SAMUS_MISSILES_MAX = $09C8
!SAMUS_SUPERS = $09CA
!SAMUS_SUPERS_MAX = $09CC
!SAMUS_PBS = $09CE
!SAMUS_PBS_MAX = $09D0
!SAMUS_RESERVE_MAX = $09D4
!SAMUS_RESERVE_ENERGY = $09D6
!SAMUS_POSE = $0A1C
!SAMUS_POSE_DIRECTION = $0A1E
!SAMUS_MOVEMENT_TYPE = $0A1F
!SAMUS_X = $0AF6
!SAMUS_X_SUBPX = $0AF8
!SAMUS_Y = $0AFA
!SAMUS_Y_SUBPX = $0AFC
!SAMUS_X_RADIUS = $0AFE
!SAMUS_Y_RADIUS = $0B00
!SAMUS_SPRITEMAP_X = $0B04
!SAMUS_Y_SUBSPEED = $0B2C
!SAMUS_Y_SPEED = $0B2E
!SAMUS_Y_DIRECTION = $0B36
!SAMUS_DASH_COUNTER = $0B3F
!SAMUS_PROJ_X = $0B64
!SAMUS_PROJ_Y = $0B78
!SAMUS_PROJ_RADIUS_X = $0BB4
!SAMUS_PROJ_RADIUS_Y = $0BC8
!SAMUS_COOLDOWN = $0CCC
!SAMUS_CHARGE_TIMER = $0CD0
!ENEMY_X = $0F7A
!ENEMY_Y = $0F7E
!ENEMY_X_RADIUS = $0F82
!ENEMY_Y_RADIUS = $0F84
!ENEMY_PROPERTIES_2 = $0F88
!ENEMY_HP = $0F8C
!ENEMY_SPRITEMAP = $0F8E
!ENEMY_BANK = $0FA6
!SAMUS_IFRAME_TIMER = $18A8
!ENEMY_PROJ_ID = $1997
!ENEMY_PROJ_X = $1A4B
!ENEMY_PROJ_Y = $1A93
!ENEMY_PROJ_RADIUS = $1BB3


; -----
; SRAM
; -----

!sram_initialized = $F02A00

!sram_ctrl_menu = $F02A02
!sram_ctrl_kill_enemies = $F02A04
!sram_ctrl_full_equipment = $F02A06
!sram_ctrl_reset_segment_timer = $F02A08
!sram_ctrl_reset_segment_later = $F02A0A
!sram_ctrl_load_state = $F02A0C
!sram_ctrl_save_state = $F02A0E
!sram_ctrl_load_last_preset = $F02A10
!sram_ctrl_random_preset = $F02A12
!sram_ctrl_save_custom_preset = $F02A14
!sram_ctrl_load_custom_preset = $F02A16
!sram_ctrl_inc_custom_preset = $F02A18
!sram_ctrl_dec_custom_preset = $F02A1A
!sram_ctrl_toggle_tileviewer = $F02A1C
!sram_ctrl_update_timers = $F02A1E

; FREE SPACE ^

!sram_artificial_lag = $F02A20
!sram_rerandomize = $F02A22
!sram_fanfare_toggle = $F02A24
!sram_frame_counter_mode = $F02A26
!sram_display_mode = $F02A28
!sram_music_toggle = $F02A2A
!sram_last_preset = $F02A2C
!sram_save_has_set_rng = $F02A2E
!sram_preset_category = $F02A30
!sram_custom_preset_slot = $F02A32
!sram_room_strat = $F02A34
!sram_sprite_prio_flag = $F02A36
!sram_metronome_tickrate = $F02A38
!sram_metronome_sfx = $F02A3A
!sram_status_icons = $F02A3C
!sram_top_display_mode = $F02A3E
!sram_healthalarm = $F02A40
!sram_room_layout = $F02A42
!sram_cutscenes = $F02A44
!sram_compressed_graphics = $F02A46
!sram_lag_counter_mode = $F02A48

; FREE SPACE ^

!PRESET_SLOTS = $F03000


; ----------
; Save/Load
; ----------

; Savestate code variables
!SS_INPUT_CUR = $8B
!SS_INPUT_NEW = $8F
!SS_INPUT_PREV = $97

!SRAM_DMA_BANK = $770000
!SRAM_SAVED_SP = $774004

; SM specific things
!SRAM_MUSIC_DATA = $701FD0
!SRAM_MUSIC_TRACK = $701FD2
!SRAM_SOUND_TIMER = $701FD4

