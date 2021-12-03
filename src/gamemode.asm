; $82:8963 AD 98 09    LDA $0998  [$7E:0998]
; $82:8966 29 FF 00    AND #$00FF
org $828963
    ; gamemode_shortcuts will either CLC or SEC
    ; to control if normal gameplay will happen on this frame
    JSL gamemode_start : BCS end_of_normal_gameplay

org $82896E
    end_of_normal_gameplay:

if !FEATURE_SD2SNES
org $82E526
    JSL gamemode_door_transition : NOP

org $858136
    JMP messagebox_wait_for_lag_frame
endif


org $85F800
print pc, " gamemode start"

gamemode_start:
{
    PHB
    PHK : PLB

    JSR gamemode_shortcuts
    %ai16()
    PHP

    ; don't load presets if we're in credits
    LDA $0998 : CMP #$0027 : BEQ ++

    LDA !ram_custom_preset : BNE +
    LDA !ram_load_preset : BEQ ++

+   JSL preset_load

++  LDA $0998 : AND #$00FF
    PLP
    PLB
    RTL
}

gamemode_shortcuts:
{
    LDA !IH_CONTROLLER_PRI_NEW : BNE +

    ; No shortcuts configured, CLC so we won't skip normal gameplay
    CLC : RTS

if !FEATURE_SD2SNES
  + LDA !IH_CONTROLLER_PRI : CMP !sram_ctrl_save_state : BNE +
    AND !IH_CONTROLLER_PRI_NEW : BEQ +
    JMP .save_state

  + LDA !IH_CONTROLLER_PRI : CMP !sram_ctrl_load_state : BNE +
    AND !IH_CONTROLLER_PRI_NEW : BEQ +
    JMP .load_state
endif

  + LDA !IH_CONTROLLER_PRI : AND !sram_ctrl_load_last_preset : CMP !sram_ctrl_load_last_preset : BNE +
    AND !IH_CONTROLLER_PRI_NEW : BEQ +
    JMP .load_last_preset

  + LDA !IH_CONTROLLER_PRI : AND !sram_ctrl_random_preset : CMP !sram_ctrl_random_preset : BNE +
    AND !IH_CONTROLLER_PRI_NEW : BEQ +
    JMP .random_preset

  + LDA !IH_CONTROLLER_PRI : AND !sram_ctrl_save_custom_preset : CMP !sram_ctrl_save_custom_preset : BNE +
    AND !IH_CONTROLLER_PRI_NEW : BEQ +
    JMP .save_custom_preset

  + LDA !IH_CONTROLLER_PRI : AND !sram_ctrl_load_custom_preset : CMP !sram_ctrl_load_custom_preset : BNE +
    AND !IH_CONTROLLER_PRI_NEW : BEQ +
    JMP .load_custom_preset

    ; Check if any less common shortcuts are configured
  + LDA !ram_game_mode_extras : BNE +
    JMP .check_menu

  + LDA !IH_CONTROLLER_PRI : AND !sram_ctrl_inc_custom_preset : CMP !sram_ctrl_inc_custom_preset : BNE +
    AND !IH_CONTROLLER_PRI_NEW : BEQ +
    JMP .next_preset_slot

  + LDA !IH_CONTROLLER_PRI : AND !sram_ctrl_dec_custom_preset : CMP !sram_ctrl_dec_custom_preset : BNE +
    AND !IH_CONTROLLER_PRI_NEW : BEQ +
    JMP .prev_preset_slot

  + LDA !IH_CONTROLLER_PRI : AND !sram_ctrl_full_equipment : CMP !sram_ctrl_full_equipment : BNE +
    AND !IH_CONTROLLER_PRI_NEW : BEQ +
    JMP .full_equipment

  + LDA !IH_CONTROLLER_PRI : AND !sram_ctrl_kill_enemies : CMP !sram_ctrl_kill_enemies : BNE +
    AND !IH_CONTROLLER_PRI_NEW : BEQ +
    JMP .kill_enemies

  + LDA !IH_CONTROLLER_PRI : AND !sram_ctrl_reset_segment_timer : CMP !sram_ctrl_reset_segment_timer : BNE +
    AND !IH_CONTROLLER_PRI_NEW : BEQ +
    JMP .reset_segment_timer

  + LDA !IH_CONTROLLER_PRI : AND !sram_ctrl_reset_segment_later : CMP !sram_ctrl_reset_segment_later : BNE +
    AND !IH_CONTROLLER_PRI_NEW : BEQ +
    JMP .reset_segment_later

  + LDA !IH_CONTROLLER_PRI : AND !sram_ctrl_toggle_tileviewer : CMP !sram_ctrl_toggle_tileviewer : BNE +
    AND !IH_CONTROLLER_PRI_NEW : BEQ +
    JMP .toggle_tileviewer

    ; Custom build shortcuts without priority
  + LDA !IH_CONTROLLER_PRI : AND !sram_ctrl_reveal_damage : CMP !sram_ctrl_reveal_damage : BNE +
    AND !IH_CONTROLLER_PRI_NEW : BEQ +
    JMP .reveal_damage

  + LDA !IH_CONTROLLER_PRI : AND !sram_ctrl_randomize_rng : CMP !sram_ctrl_randomize_rng : BNE +
    AND !IH_CONTROLLER_PRI_NEW : BEQ +
    JMP .randomize_rng

  + LDA !IH_CONTROLLER_PRI : AND !sram_ctrl_force_stand : CMP !sram_ctrl_force_stand : BNE +
    AND !IH_CONTROLLER_PRI_NEW : BEQ +
    JMP .force_stand

  .check_menu
  + LDA !IH_CONTROLLER_PRI : AND !sram_ctrl_menu : CMP !sram_ctrl_menu : BNE +
    AND !IH_CONTROLLER_PRI_NEW : BEQ +
    JMP .menu

    ; No shortcuts matched, CLC so we won't skip normal gameplay
  + CLC : RTS

if !FEATURE_SD2SNES
; This if statement is to prevent an assembler error from an unknown method. The one on the call to this
; prevents the button combo from being intercepted by the non-sd2snes rom
  .save_state
    JSL save_state
    ; SEC to skip normal gameplay for one frame after saving state
    SEC : RTS

  .load_state
    JSL load_state
    ; SEC to skip normal gameplay for one frame after loading state
    SEC : RTS
endif

  .kill_enemies
    JSL kill_enemies
    %sfxgrapple()
    ; CLC to continue normal gameplay after killing enemies
    CLC : RTS

  .load_last_preset
    LDA !sram_last_preset : BEQ + : STA !ram_load_preset
    ; SEC to skip normal gameplay for one frame after loading preset
    SEC : RTS
    ; Choose a random preset if zero
+   JMP .random_preset

  .reset_segment_timer
    LDA #$0000 : STA !ram_seg_rt_frames
    STA !ram_seg_rt_seconds : STA !ram_seg_rt_minutes
    %sfxquake()
    ; CLC to continue normal gameplay after resetting segment timer
    CLC : RTS

  .reset_segment_later
    LDA #$7FFF : STA !ram_reset_segment_later
    %sfxquake()
    ; CLC to continue normal gameplay after resetting segment timer
    CLC : RTS

  .full_equipment
    LDA $7E09C4 : STA $7E09C2 ; health
    LDA $7E09C8 : CMP $7E09C6 : BCC + : STA $7E09C6 ; missiles
+   LDA $7E09CC : CMP $7E09CA : BCC + : STA $7E09CA ; supers
+   LDA $7E09D0 : CMP $7E09CE : BCC + : STA $7E09CE ; pbs
+   LDA $7E09D4 : STA $7E09D6 ; reserves
    STZ $0CD2  ; reset bomb counter
    %sfxenergy() ; play sound effect
    ; CLC to continue normal gameplay after equipment refill
    CLC : RTS

  .reveal_damage
    LDA !sram_display_mode : CMP #$0012 : BEQ + : STA !ram_display_backup
    LDA #$0012 : STA !sram_display_mode
    JSL ForceCountDamage
    %sfxdoor()
    CLC : RTS

+   LDA !ram_display_backup : STA !sram_display_mode
    %sfxship()
    CLC : RTS

  .save_custom_preset
    JSL custom_preset_save
    ; CLC to continue normal gameplay after saving preset
    %sfxconfirm()
    CLC : RTS

  .load_custom_preset
    ; check if slot is populated first
    LDA !sram_custom_preset_slot
    ASL : XBA : TAX
    LDA $F03000,X : CMP #$5AFE : BEQ .safe
    %sfxgoback()
    ; CLC to continue normal gameplay after failing to load preset
    CLC : RTS

  .safe
    STA !ram_custom_preset
    JSL preset_load
    ; SEC to skip normal gameplay for one frame after loading preset
    SEC : RTS

  .next_preset_slot
    LDA !sram_custom_preset_slot : CMP #$0027 ; total slots minus one
    BNE + : LDA #$FFFF
+   INC : STA !sram_custom_preset_slot
    ASL : TAX : LDA.l NumberGFXTable,X : STA $7EC67C
    %sfxnumber()
    ; CLC to continue normal gameplay after incrementing preset slot
    CLC : RTS

  .prev_preset_slot
    LDA !sram_custom_preset_slot : BNE +
    LDA #$0028 ; total slots
+   DEC : STA !sram_custom_preset_slot
    ASL : TAX : LDA.l NumberGFXTable,X : STA $7EC67C
    %sfxnumber()
    ; CLC to continue normal gameplay after decrementing preset slot
    CLC : RTS

  .random_preset
    JSL LoadRandomPreset
    ; SEC to skip normal gameplay for one frame after loading preset
    SEC : RTS

  .randomize_rng
    LDA $7E1842 : AND #$00FF : STA $12
    LDA $05B6 : AND #$FF00 : ORA $12 : STA $05B5 ; little extra for Phantoon
    LDA $7E05E5 : AND #$0FF0 : ASL #4
    ORA $12 : STA $7E05E5
    JSL $808111
    %sfxbeep()
    ; CLC to continue normal gameplay after reseeding RNG
    CLC : RTS

  .toggle_tileviewer
    LDA !ram_oob_watch_active : BEQ .turnOn
    LDA #$0000 : STA !ram_oob_watch_active : STA !ram_sprite_features_active
    ; CLC to continue normal gameplay after disabling OOB Tile Viewer
    CLC : RTS

  .turnOn
    LDA #$0001 : STA !ram_oob_watch_active : STA !ram_sprite_features_active
    JSL upload_sprite_oob_tiles
    ; CLC to continue normal gameplay after enabling OOB Tile Viewer
    CLC : RTS

  .force_stand
    JSL $90E2D4
    %sfxconfirm()
    ; CLC to continue normal gameplay after forced stand
    CLC : RTS

  .menu
    ; Set IRQ vector
    LDA $AB : PHA
    LDA #$0004 : STA $AB

    ; Enter MainMenu
    JSL cm_start

    ; Restore IRQ vector
    PLA : STA $AB

    ; SEC to skip normal gameplay for one frame after handling the menu
    SEC : RTS
}

if !FEATURE_SD2SNES
gamemode_door_transition:
{
  .checkloadstate
    LDA !IH_CONTROLLER_PRI : BEQ .checktransition
    CMP !sram_ctrl_load_state : BNE .checktransition
    PHB : PHK : PLB
    JML load_state

  .checktransition
    LDA $0931 : BPL .checkloadstate
    RTL
}

messagebox_wait_for_lag_frame:
{
    PHP
    %a8()
  .wait_for_auto_joypad_read
    LDA $4212 : BIT #$01 : BNE .wait_for_auto_joypad_read

    %a16()
    LDA $4218 : BEQ .wait_for_lag_frame
    CMP !sram_ctrl_load_state : BNE .wait_for_lag_frame
    PHB : PHK : PLB
    JML load_state

  .wait_for_lag_frame
    PLP
    ; Intentional fall through to vanilla_wait_for_lag_frame
}

vanilla_wait_for_lag_frame:
{
    PHP
    %a8()
    LDA $05B8
  .wait_loop
    CMP $05B8 : BEQ .wait_loop
    PLP
    RTS
}
endif

print pc, " gamemode end"
warnpc $85FD00
