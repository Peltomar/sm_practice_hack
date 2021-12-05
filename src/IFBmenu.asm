; ----------
; Firebat Menu   IFBMenu:
; ----------

IFBMenu:
    dw #ifb_customizemenu
    dw #$FFFF
    dw #ifb_soundtest
    dw #$FFFF
    dw #ifb_presetrando
    dw #$FFFF
    dw #ifb_healthalarm
    if !FEATURE_EXTRAS
        dw #ifb_noclip
        dw #ifb_nosteam
    endif
    dw #$FFFF
    dw #ifb_debugteleport
    dw #ifb_lockout
    dw #ifb_factory_reset
    dw #ifb_credits
    dw #$0000
    %cm_header("CUSTOM ROMS ONLY")
    %cm_footer("MODIFIED BY INSANEFIREBAT")

ifb_soundtest:
    %cm_submenu("Sound Test", #SoundTestMenu)

ifb_presetrando:
    %cm_submenu("Preset Randomizer", #PresetRandoMenu)

ifb_debugteleport:
    %cm_submenu("Hidden Dev Load Stations", #DebugTeleportMenu)

if !FEATURE_EXTRAS
    ifb_noclip:
        %cm_toggle("Walk Through Walls", !ram_noclip, #$0001, #0)

    ifb_nosteam:
        %cm_toggle("No Steam Collision", !ram_steamcollision, #$0001, #0)
endif

ifb_healthalarm:
    %cm_toggle("Low Health Alarm", !sram_healthalarm, #$0001, #0)

ifb_lockout:
    %cm_submenu("Trigger Piracy Warning", #LockoutConfirm)

ifb_credits:
    %cm_submenu("InfoHUD Credits", #CreditsMenu)

ifb_dummy_on:
    %cm_toggle("Example Toggle", !sram_dummy_on, #$0001, #0)

ifb_dummy_off:
    %cm_toggle("Example Toggle", !sram_dummy_off, #$0001, #0)

ifb_dummy_hexnum:
    %cm_numfield_hex("Example Hex Number", !sram_dummy_num, 0, 255, 1, 8, #0)

ifb_dummy_num:
    %cm_numfield("Example Number", !sram_dummy_num, 0, 255, 1, 8, #0)


; ----------
; Custom Palettes
; ----------

incsrc customizemenu.asm

action_palette_randomizer:
{
    LDA $05E5 : STA !sram_custompalette_menuborder : DEC $05E5
    JSL $808111 : STA !sram_custompalette_menuheaderoutline : INC $05E5
    JSL $808111 : STA !sram_custompalette_menutext : AND #$FECD : STA $05E5
    JSL $808111 : STA !sram_custompalette_menubackground : INC $05E5
    JSL $808111 : STA !sram_custompalette_menunumoutline : DEC $05E5
    JSL $808111 : STA !sram_custompalette_menunumfill
    JSL $808111 : STA !sram_custompalette_menutoggleon : AND #$DEAD : STA $05E5
    JSL $808111 : STA !sram_custompalette_menuseltext : DEC $05E5
    JSL $808111 : STA !sram_custompalette_menuseltextbg : AND #$BEEF : STA $05E5
    JSL $808111 : STA !sram_custompalette_menunumseloutline : INC $05E5
    JSL $808111 : STA !sram_custompalette_menunumsel

    ; split hi and lo bytes into separate addresses
    %ai8()
    LDX #$00

  .loop
    ; load lo, then hi
    LDA !sram_custompalette_menuborder,X : XBA
    INX : LDA !sram_custompalette_menuborder,X
    ; store hi, then lo
    INX : STA !sram_custompalette_menuborder,X
    INX #2 : XBA : STA !sram_custompalette_menuborder,X
    ; next word
    INX #2 : CPX #$42 : BNE .loop

    ; play a happy sound and refresh current profile
    %ai16()
    JSR PrepMenuPalette_customPalette
    JSR action_custompalettes_refresh
    %sfxbubble()
    RTS
}


; ----------
; Lockout Menu
; ----------

LockoutConfirm:
    dw #ifb_lockout_abort
    dw #ifb_lockout_piracy
    dw #$0000
    %cm_header("THIS IS A FORCED RESET")
    %cm_footer("REMEMBER TO CENTER CAMERA!")

ifb_lockout_abort:
    %cm_jsr("ABORT", #action_text, #$0000)

ifb_lockout_piracy:
    %cm_jsr("NINTENDO CAUGHT ME", #action_lockout, #$0000)

action_lockout:
{
    JSL $8086E3
}


; ----------
; Debug Teleport Menu
; ----------

DebugTeleportMenu:
    dw #ifb_debugteleport_crateria
    dw #ifb_debugteleport_brinstar
    dw #ifb_debugteleport_norfair
    dw #ifb_debugteleport_wreckedship
    dw #ifb_debugteleport_maridia
    dw #ifb_debugteleport_tourian
    dw #ifb_debugteleport_extra
    dw #$0000
    %cm_header("DEBUG LOAD POINTS")

ifb_debugteleport_crateria:
    %cm_submenu("Crateria", #DebugTeleportCrateriaMenu)

ifb_debugteleport_brinstar:
    %cm_submenu("Brinstar", #DebugTeleportBrinstarMenu)

ifb_debugteleport_norfair:
    %cm_submenu("Norfair", #DebugTeleportNorfairMenu)

ifb_debugteleport_wreckedship:
    %cm_submenu("Wrecked Ship", #DebugTeleportWreckedShipMenu)

ifb_debugteleport_maridia:
    %cm_submenu("Maridia", #DebugTeleportMaridiaMenu)

ifb_debugteleport_tourian:
    %cm_submenu("Tourian", #DebugTeleportTourianMenu)

ifb_debugteleport_extra:
    %cm_submenu("Extras", #DebugTeleportExtraMenu)

DebugTeleportCrateriaMenu:
    dw #tel_crat_08
    dw #tel_crat_09
    dw #tel_crat_0A
    dw #tel_crat_0B
    dw #tel_crat_0C
    dw #tel_crat_10
    dw #tel_crat_11
    dw #tel_crat_12
    dw #$0000
    %cm_header("CRATERIA DEBUG LOAD")

tel_crat_08:
    %cm_jsr("Crateria 08", #action_teleport, #$0008)

tel_crat_09:
    %cm_jsr("Crateria 09", #action_teleport, #$0009)

tel_crat_0A:
    %cm_jsr("Crateria 0A", #action_teleport, #$000A)

tel_crat_0B:
    %cm_jsr("Crateria 0B", #action_teleport, #$000B)

tel_crat_0C:
    %cm_jsr("Crateria 0C", #action_teleport, #$000C)

tel_crat_10:
    %cm_jsr("Crateria 10", #action_teleport, #$0010)

tel_crat_11:
    %cm_jsr("Crateria 11", #action_teleport, #$0011)

tel_crat_12:
    %cm_jsr("Crateria 12", #action_teleport, #$0012)

DebugTeleportBrinstarMenu:
    dw #tel_brin_08
    dw #tel_brin_09
    dw #tel_brin_0A
    dw #tel_brin_0B
    dw #tel_brin_11
    dw #tel_brin_12
    dw #$0000
    %cm_header("BRINSTAR DEBUG LOAD")

tel_brin_08:
    %cm_jsr("Brinstar 08", #action_teleport, #$0108)

tel_brin_09:
    %cm_jsr("Brinstar 09", #action_teleport, #$0109)

tel_brin_0A:
    %cm_jsr("Brinstar 0A", #action_teleport, #$010A)

tel_brin_0B:
    %cm_jsr("Brinstar 0B", #action_teleport, #$010B)

tel_brin_11:
    %cm_jsr("Brinstar 11", #action_teleport, #$0111)

tel_brin_12:
    %cm_jsr("Brinstar 12", #action_teleport, #$0112)

DebugTeleportNorfairMenu:
    dw #tel_norf_08
    dw #tel_norf_09
    dw #tel_norf_0A
    dw #tel_norf_11
    dw #tel_norf_12
    dw #tel_norf_13
    dw #tel_norf_14
    dw #tel_norf_15
    dw #tel_norf_16
    dw #$0000
    %cm_header("NORFAIR DEBUG LOAD")

tel_norf_08:
    %cm_jsr("Norfair 08", #action_teleport, #$0208)

tel_norf_09:
    %cm_jsr("Norfair 09", #action_teleport, #$0209)

tel_norf_0A:
    %cm_jsr("Norfair 0A", #action_teleport, #$020A)

tel_norf_11:
    %cm_jsr("Norfair 11", #action_teleport, #$0211)

tel_norf_12:
    %cm_jsr("Norfair 12", #action_teleport, #$0212)

tel_norf_13:
    %cm_jsr("Norfair 13", #action_teleport, #$0213)

tel_norf_14:
    %cm_jsr("Norfair 14", #action_teleport, #$0214)

tel_norf_15:
    %cm_jsr("Norfair 15", #action_teleport, #$0215)

tel_norf_16:
    %cm_jsr("Norfair 16", #action_teleport, #$0216)

DebugTeleportWreckedShipMenu:
    dw #tel_ship_10
    dw #tel_ship_11
    dw #$0000
    %cm_header("WRECKED SHIP DEBUG LOAD")

tel_ship_10:
    %cm_jsr("Wrecked Ship 10", #action_teleport, #$0310)

tel_ship_11:
    %cm_jsr("Wrecked Ship 11", #action_teleport, #$0311)

DebugTeleportMaridiaMenu:
    dw #tel_mari_08
    dw #tel_mari_10
    dw #tel_mari_11
    dw #tel_mari_12
    dw #tel_mari_13
    dw #$0000
    %cm_header("MARIDIA DEBUG LOAD")

tel_mari_08:
    %cm_jsr("Maridia 08", #action_teleport, #$0408)

tel_mari_10:
    %cm_jsr("Maridia 10", #action_teleport, #$0410)

tel_mari_11:
    %cm_jsr("Maridia 11", #action_teleport, #$0411)

tel_mari_12:
    %cm_jsr("Maridia 12", #action_teleport, #$0412)

tel_mari_13:
    %cm_jsr("Maridia 13", #action_teleport, #$0413)


DebugTeleportTourianMenu:
    dw #tel_tour_08
    dw #tel_tour_10
    dw #tel_tourianbbyskip
    dw #$0000
    %cm_header("TOURIAN DEBUG LOAD")

tel_tour_08:
    %cm_jsr("Tourian 08", #action_teleport, #$0508)

tel_tour_10:
    %cm_jsr("Tourian 10", #action_teleport, #$0510)

DebugTeleportExtraMenu:
    dw #tel_ceres
    dw #tel_debug
    dw #$0000
    %cm_header("EXTRA DEBUG LOAD")

tel_ceres:
    %cm_jsr("Ceres Station", #action_teleport, #$0600)

tel_debug:
    %cm_jsr("Debug Room CRASH", #action_teleport, #$0700)


; ------------
; Preset Rando
; ------------

PresetRandoMenu:
    dw #presetrando_enable
    dw #$FFFF
    dw #presetrando_morph
    dw #presetrando_charge
    dw #presetrando_beampref
    dw #$FFFF
    dw #presetrando_etanks
    dw #presetrando_reserves
    dw #presetrando_missiles
    dw #presetrando_supers
    dw #presetrando_pbs
    dw #$0000
    %cm_header("RANDOMIZE PRESET EQUIP")

presetrando_enable: 
    %cm_toggle("Equipment Rando", !sram_presetrando, #$0001, #0)

presetrando_morph:
    %cm_toggle("Force Morph Ball", !sram_presetrando_morph, #$0001, #0)

presetrando_charge:
    %cm_toggle("Force Charge Beam", !sram_presetrando_charge, #$0001, #0)

presetrando_beampref:
    dw !ACTION_CHOICE
    dl #!sram_presetrando_beampref
    dw #$0000
    db #$28, "Beam Preference", #$FF
        db #$28, "     RANDOM", #$FF
        db #$28, "     SPAZER", #$FF
        db #$28, "     PLASMA", #$FF
    db #$FF

presetrando_etanks: 
    %cm_numfield("Max Energy Tanks", !sram_presetrando_max_etanks, 0, 14, 1, 2, #0)

presetrando_reserves: 
    %cm_numfield("Max Reserve Tanks", !sram_presetrando_max_reserves, 0, 4, 1, 1, #0)

presetrando_missiles: 
    %cm_numfield("Max Missile Pickups", !sram_presetrando_max_missiles, 0, 50, 1, 5, #0)

presetrando_supers: 
    %cm_numfield("Max Super Pickups", !sram_presetrando_max_supers, 0, 50, 1, 5, #0)

presetrando_pbs: 
    %cm_numfield("Max Power Bomb Pickups", !sram_presetrando_max_pbs, 0, 50, 1, 5, #0)


; ----------
; Sound Test
; ----------

SoundTestMenu:
    dw #ifb_soundtest_goto_music
    dw #game_music_toggle
    dw #$FFFF
    dw #ifb_soundtest_lib1_sound
    dw #ifb_soundtest_lib2_sound
    dw #ifb_soundtest_lib3_sound
    dw #ifb_soundtest_silence
    dw #$0000
    %cm_header("SOUND TEST MENU")
    %cm_footer("PRESS Y TO PLAY SOUNDS")

ifb_soundtest_lib1_sound:
    %cm_numfield_sound("Library One Sound", !ram_soundtest_lib1, 1, 66, 1, #action_soundtest_lib1_play)

action_soundtest_lib1_play:
{
    LDA !ram_soundtest_lib1 : JSL !SFX_LIB1
    RTS
}

ifb_soundtest_lib2_sound:
    %cm_numfield_sound("Library Two Sound", !ram_soundtest_lib2, 1, 127, 1, #action_soundtest_lib2_play)

action_soundtest_lib2_play:
{
    LDA !ram_soundtest_lib2 : JSL !SFX_LIB2
    RTS
}

ifb_soundtest_lib3_sound:
    %cm_numfield_sound("Library Three Sound", !ram_soundtest_lib3, 1, 47, 1, #action_soundtest_lib3_play)

action_soundtest_lib3_play:
{
    LDA !ram_soundtest_lib3 : JSL !SFX_LIB3
    RTS
}

ifb_soundtest_silence:
    %cm_jsr("Silence Sound FX", #action_soundtest_silence, #$0002)
    
action_soundtest_silence:
{
    ; silence all 3 libs at once
    TYA : JSL !SFX_LIB1
    LDA #$0071 : JSL !SFX_LIB2
    LDA #$0001 : JSL !SFX_LIB3
    RTS
}

ifb_soundtest_goto_music:
    %cm_submenu("Music Selection", #MusicSelectMenu1)

MusicSelectMenu1:
    dw #ifb_soundtest_music_title1
    dw #ifb_soundtest_music_title2
    dw #ifb_soundtest_music_intro
    dw #ifb_soundtest_music_ceres
    dw #ifb_soundtest_music_escape
    dw #ifb_soundtest_music_rainstorm
    dw #ifb_soundtest_music_spacepirate
    dw #ifb_soundtest_music_samustheme
    dw #ifb_soundtest_music_greenbrinstar
    dw #ifb_soundtest_music_redbrinstar
    dw #ifb_soundtest_music_uppernorfair
    dw #ifb_soundtest_music_lowernorfair
    dw #ifb_soundtest_music_easternmaridia
    dw #ifb_soundtest_music_westernmaridia
    dw #ifb_soundtest_music_wreckedshipoff
    dw #ifb_soundtest_music_wreckedshipon
    dw #ifb_soundtest_music_hallway
    dw #ifb_soundtest_music_goldenstatue
    dw #ifb_soundtest_music_tourian
    dw #ifb_soundtest_music_goto_2
    dw #$0000
    %cm_header("PLAY MUSIC - PAGE ONE")

ifb_soundtest_music_title1:
    %cm_jsr("Title Theme Part 1", #action_soundtest_playmusic, #$0305)

ifb_soundtest_music_title2:
    %cm_jsr("Title Theme Part 2", #action_soundtest_playmusic, #$0306)

ifb_soundtest_music_intro:
    %cm_jsr("Intro", #action_soundtest_playmusic, #$3605)

ifb_soundtest_music_ceres:
    %cm_jsr("Ceres Station", #action_soundtest_playmusic, #$2D06)

ifb_soundtest_music_escape:
    %cm_jsr("Escape Sequence", #action_soundtest_playmusic, #$2407)

ifb_soundtest_music_rainstorm:
    %cm_jsr("Zebes Rainstorm", #action_soundtest_playmusic, #$0605)

ifb_soundtest_music_spacepirate:
    %cm_jsr("Space Pirate Theme", #action_soundtest_playmusic, #$0905)

ifb_soundtest_music_samustheme:
    %cm_jsr("Samus Theme", #action_soundtest_playmusic, #$0C05)

ifb_soundtest_music_greenbrinstar:
    %cm_jsr("Green Brinstar", #action_soundtest_playmusic, #$0F05)

ifb_soundtest_music_redbrinstar:
    %cm_jsr("Red Brinstar", #action_soundtest_playmusic, #$1205)

ifb_soundtest_music_uppernorfair:
    %cm_jsr("Upper Norfair", #action_soundtest_playmusic, #$1505)

ifb_soundtest_music_lowernorfair:
    %cm_jsr("Lower Norfair", #action_soundtest_playmusic, #$1805)

ifb_soundtest_music_easternmaridia:
    %cm_jsr("Eastern Maridia", #action_soundtest_playmusic, #$1B05)

ifb_soundtest_music_westernmaridia:
    %cm_jsr("Western Maridia", #action_soundtest_playmusic, #$1B06)

ifb_soundtest_music_wreckedshipoff:
    %cm_jsr("Wrecked Ship Unpowered", #action_soundtest_playmusic, #$3005)

ifb_soundtest_music_wreckedshipon:
    %cm_jsr("Wrecked Ship", #action_soundtest_playmusic, #$3006)

ifb_soundtest_music_hallway:
    %cm_jsr("Hallway to Statue", #action_soundtest_playmusic, #$0004)

ifb_soundtest_music_goldenstatue:
    %cm_jsr("Golden Statue", #action_soundtest_playmusic, #$0906)

ifb_soundtest_music_tourian:
    %cm_jsr("Tourian", #action_soundtest_playmusic, #$1E05)

ifb_soundtest_music_goto_2:
    %cm_submenu("GOTO PAGE TWO", #MusicSelectMenu2)

MusicSelectMenu2:
    dw #ifb_soundtest_music_preboss1
    dw #ifb_soundtest_music_preboss2
    dw #ifb_soundtest_music_miniboss
    dw #ifb_soundtest_music_smallboss
    dw #ifb_soundtest_music_bigboss
    dw #ifb_soundtest_music_motherbrain
    dw #ifb_soundtest_music_credits
    dw #ifb_soundtest_music_itemroom
    dw #ifb_soundtest_music_itemfanfare
    dw #ifb_soundtest_music_spacecolony
    dw #ifb_soundtest_music_zebesexplodes
    dw #ifb_soundtest_music_loadsave
    dw #ifb_soundtest_music_death
    dw #ifb_soundtest_music_lastmetroid
    dw #ifb_soundtest_music_galaxypeace
    dw #ifb_soundtest_music_goto_1
    dw #$0000
    %cm_header("PLAY MUSIC - PAGE TWO")

ifb_soundtest_music_preboss1:
    %cm_jsr("Chozo Statue Awakens", #action_soundtest_playmusic, #$2406)

ifb_soundtest_music_preboss2:
    %cm_jsr("Approaching Confrontation", #action_soundtest_playmusic, #$2706)

ifb_soundtest_music_miniboss:
    %cm_jsr("Miniboss Fight", #action_soundtest_playmusic, #$2A05)

ifb_soundtest_music_smallboss:
    %cm_jsr("Small Boss Confrontation", #action_soundtest_playmusic, #$2705)

ifb_soundtest_music_bigboss:
    %cm_jsr("Big Boss Confrontation", #action_soundtest_playmusic, #$2405)

ifb_soundtest_music_motherbrain:
    %cm_jsr("Mother Brain Fight", #action_soundtest_playmusic, #$2105)

ifb_soundtest_music_credits:
    %cm_jsr("Credits", #action_soundtest_playmusic, #$3C05)

ifb_soundtest_music_itemroom:
    %cm_jsr("Item - Elevator Room", #action_soundtest_playmusic, #$0003)

ifb_soundtest_music_itemfanfare:
    %cm_jsr("Item Fanfare", #action_soundtest_playmusic, #$0002)

ifb_soundtest_music_spacecolony:
    %cm_jsr("Arrival at Space Colony", #action_soundtest_playmusic, #$2D05)

ifb_soundtest_music_zebesexplodes:
    %cm_jsr("Zebes Explodes", #action_soundtest_playmusic, #$3305)

ifb_soundtest_music_loadsave:
    %cm_jsr("Samus Appears", #action_soundtest_playmusic, #$0001)

ifb_soundtest_music_death:
    %cm_jsr("Death", #action_soundtest_playmusic, #$3905)

ifb_soundtest_music_lastmetroid:
    %cm_jsr("Last Metroid in Captivity", #action_soundtest_playmusic, #$3F05)

ifb_soundtest_music_galaxypeace:
    %cm_jsr("The Galaxy is at Peace", #action_soundtest_playmusic, #$4205)

ifb_soundtest_music_goto_1:
    %cm_submenu("GOTO PAGE ONE", #MusicSelectMenu1)

action_soundtest_playmusic:
{
    PHY
    LDA #$0000 : JSL !MUSIC_ROUTINE                  ; always load silence first
    PLY : TYA
    %a8() : STA !ram_soundtest_music
    XBA : %a16()
    STA $07CB                                       ; store data index to the room
    ORA #$FF00 : JSL !MUSIC_ROUTINE                  ; play from negative data index
    LDA !ram_soundtest_music : JSL !MUSIC_ROUTINE    ; play from track index
    RTS
}

ifb_soundtest_music_toggle:
    %cm_toggle("Music", !sram_music_toggle, #$0001, MusicToggle)

MusicToggle:
{
    BIT #$0001 : BEQ .noMusic
    LDA $07F5 : STA $2140
    RTS

  .noMusic
    LDA #$0000 
    STA $0629
    STA $062B
    STA $062D
    STA $062F
    STA $0631
    STA $0633
    STA $0635
    STA $0637
    STA $063F
    STA $2140
    RTS
}

ifb_factory_reset:
    %cm_jsr("Factory Reset", .routine, #FactoryResetConfirm)
  .routine
    LDA #$0000 : LDX !WRAM_SIZE-2
-   STA !WRAM_START,X
    DEX #2 : BPL -

    LDX #$01FE
-   STA $F02100,X
    DEX #2 : BPL -

    LDA #$FFFF : STA !sram_initialized
    JSL init_sram_long
    %sfxquake()
    JMP action_submenu

FactoryResetConfirm:
    dw #ifb_factory_reset_keep_presets
    dw #ifb_factory_reset_delete_presets
    dw #$0000
    %cm_header("KEEP CUSTOM PRESETS?")
    %cm_footer("TECHNICALLY REVERSABLE")

ifb_factory_reset_keep_presets:
    %cm_jsr("Yes, keep my presets", .routine, #$0000)
  .routine
    JSR cm_go_back
    JSR cm_calculate_max
    RTS

ifb_factory_reset_delete_presets:
    %cm_jsr("No, mark them as empty", .routine, #$0000)
  .routine
    TYX : TXA
-   STA !PRESET_SLOTS,X ; overwrite "5AFE" words
    INY : TYA : ASL : XBA : TAX
    CPY #$0020 : BNE -
    %sfxquake()
    JSR cm_go_back
    JSR cm_calculate_max
    RTS


CreditsMenu:
    dw #ab_text_orig_author
    dw #$FFFF
    dw #ab_text_total
    dw #$FFFF
    dw #$FFFF
    dw #ab_text_v2_author
    dw #$FFFF
    dw #ab_text_pinkus
    dw #$FFFF
    dw #$FFFF
    dw #ab_text_contributors
    dw #$FFFF
    dw #ab_text_unhchabo
    dw #ab_text_idlechild
    dw #ab_text_insanefirebat
    dw #$FFFF
    dw #$FFFF
    dw #ab_text_website_header
    dw #$FFFF
    dw #ab_text_website
    dw #$0000
    %cm_header("     INFOHUD CREDITS")


ab_text_orig_author:
    %cm_jsr("     ORIGINAL AUTHOR      ", #action_text, #$0000)

ab_text_total:
    %cm_jsr("          Total           ", #action_text, #$0000)

ab_text_v2_author:
    %cm_jsr("    V2 REWRITE AUTHOR     ", #action_text, #$0000)

ab_text_pinkus:
    %cm_jsr("          Pinkus          ", #action_text, #$0000)

ab_text_contributors:
    %cm_jsr("       CONTRIBUTORS       ", #action_text, #$0000)

ab_text_unhchabo:
    %cm_jsr("         UNHchabo         ", #action_text, #$0000)

ab_text_idlechild:
    %cm_jsr("         idlechild        ", #action_text, #$0000)

ab_text_insanefirebat:
    %cm_jsr("       InsaneFirebat      ", #action_text, #$0000)

ab_text_website_header:
    %cm_jsr("         WEBSITE          ", #action_text, #$0000)

ab_text_website:
    %cm_jsr("  smpractice.speedga.me   ", #action_text, #$0000)

action_text:
{
    ; do nothing
    RTS
}
