;=======================================================
;InfoHUD timers and stuff
;=======================================================

org $809490
    JMP $9497    ; skip resetting player 2 inputs

org $8094DF
    PLP          ; patch out resetting of controller 2 buttons and enable debug mode
    RTL

org $80ADB5      ; fix for scroll offset misalignment when going down through door
    JSR ih_fix_scroll_down_offsets

org $80AE29      ; fix for scroll offset misalignment
    JSR ih_fix_scroll_offsets

org $828B4B      ; disable debug functions
    JML ih_debug_routine

org $82EE92      ; runs on START GAME
    JSL startgame_seg_timer

org $828B34      ; reset room timers for first room of Ceres
    JML ceres_start_timers : NOP : NOP
ceres_start_timers_return:

org $90E6BC      ; hijack, runs on gamestate = 08 (main gameplay), handles most updating HUD information
    JSL ih_gamemode_frame

org $9493B8      ; hijack, runs when Samus hits a door BTS
    JSL ih_before_room_transition

org $9493FB      ; hijack, runs when Samus hits a door BTS
    JSL ih_before_room_transition

org $82E764      ; hijack, runs when Samus is coming out of a room transition
    JSL ih_after_room_transition : RTS

org $809B4A      ; hijack, HUD routine (game timer by Quote58)
    JSL ih_hud_code; : NOP

org $8290F6      ; hijack, HUD routine while paused
    JSL ih_hud_code_paused

org $80A16B      ; hijack, adjust room times and update HUD when unpausing
    JSL ih_unpause

org $82894F      ; hijack, main game loop: runs EVERY frame (used for room transition timer)
    JSL ih_game_loop_code

org $84889F      ; hijack, runs every time an item is picked up
    JSL ih_get_item_code

org $8095FC      ; hijack, end of NMI routine to update realtime frames
    JML ih_nmi_end

org $809609      ; inc counter if NMI lag branch
    INC !REALTIME_LAG_COUNTER

org $91DAD8      ; hijack, runs after a shinespark has been charged
    JSL ih_shinespark_code

org $90F1E4      ; hijack, runs when an elevator is activated
    JSL ih_elevator_activation

org $A9F006      ; hijack, runs when the screen locks to start the hopper/baby cutscene
    JSL ih_babyskip_segment

org $A98874      ; update timers after MB1 fight
    JSL ih_mb1_segment

org $A9BE23      ; update timers when baby spawns (off-screen) in MB2 fight
    JSL ih_mb2_segment

org $A0B9D4      ; update timers when Ridley drops spawn
    JML ih_drops_segment

org $A0BA07      ; update timers when Crocomire drops spawn
    JML ih_drops_segment

org $A0BA3A      ; update timers when Phantoon drops spawn
    JML ih_drops_segment

org $A0BA6D      ; update timers when Botwoon drops spawn
    JML ih_drops_segment

org $A0BAA0      ; update timers when Kraid drops spawn
    JML ih_drops_segment

org $A0BAD3      ; update timers when Bomb Torizo drops spawn
    JML ih_drops_segment

org $A0BB06      ; update timers when Golden Torizo drops spawn
    JML ih_drops_segment

org $A0BB39      ; update timers when Spore Spawn drops spawn
    JML ih_drops_segment

org $A0BB6C      ; update timers when Draygon drops spawn
    JML ih_drops_segment

org $AAE582      ; update timers when statue grabs Samus
    JSL ih_chozo_segment

org $89AD0A      ; update timers when Samus escapes Ceres
    JSL ih_ceres_elevator_segment

org $A2AA20      ; update timers when Samus enters ship
    JSL ih_ship_elevator_segment


; Main bank stuff
org !ORG_INFOHUD
print pc, " infohud start"

; List this first since it affects bank $84 where we are trying to minimize change
ih_get_item_code:
{
    PHA
    LDA !ram_timers_autoupdate : BNE .done

    ; calculate lag frames
    LDA !ram_realtime_room : SEC : SBC !ram_transition_counter : STA !ram_last_room_lag

    LDA !ram_gametime_room : STA !ram_last_gametime_room
    LDA !ram_realtime_room : STA !ram_last_realtime_room

    ; save temp variables
    LDA $12 : PHA
    LDA $14 : PHA

    ; check if segment timer should be reset
    LDA !ram_reset_segment_later : BPL .update_HUD
    LDA #$0000 : STA !ram_reset_segment_later : STA !ram_lag_counter
    STA !ram_seg_rt_frames : STA !ram_seg_rt_seconds : STA !ram_seg_rt_minutes

  .update_HUD
    JSL ih_update_hud_code

    ; restore temp variables
    PLA : STA $14
    PLA : STA $12

  .done
    PLA
    JSL $80818E
    RTL
}

ih_debug_routine:
{
    LDA !DEBUG_MODE : BNE .run
    JML $828B54 ; return past debug handler

  .run
    JSL $B49809 ; run debug handler
    JML $828B4F ; return
}

ih_nmi_end:
{
    ; Room timer
    LDA !ram_realtime_room : INC : STA !ram_realtime_room

    ; Segment real timer
    LDA !ram_seg_rt_frames : INC : STA !ram_seg_rt_frames : CMP.w #60 : BNE .done_timer
    LDA #$0000 : STA !ram_seg_rt_frames
    LDA !ram_seg_rt_seconds : INC : STA !ram_seg_rt_seconds : CMP.w #60 : BNE .done_timer
    LDA #$0000 : STA !ram_seg_rt_seconds
    LDA !ram_seg_rt_minutes : INC : STA !ram_seg_rt_minutes

  .done_timer
    LDA !ram_slowdown_mode : BNE .controller2_slowdown
    JMP .done

  .controller2_slowdown
    CMP #$FFFF : BEQ .pause

    LDA !ram_slowdown_frames : BNE .delay
    ; Process next frame
    LDA !ram_slowdown_mode : STA !ram_slowdown_frames
    LDA !ram_slowdown_controller_1 : STA !IH_CONTROLLER_PRI_PREV
    LDA !ram_slowdown_controller_2 : STA !IH_CONTROLLER_SEC_PREV

    JSL $809459 ;  Read controller input
    JMP .done

  .delay
    CMP !ram_slowdown_mode : BNE .dec_timer

    LDA !IH_CONTROLLER_PRI : EOR !IH_CONTROLLER_PRI_NEW : STA !ram_slowdown_controller_1
    LDA !IH_CONTROLLER_SEC : EOR !IH_CONTROLLER_SEC_NEW : STA !ram_slowdown_controller_2

    LDA !ram_slowdown_frames

  .dec_timer
    DEC : STA !ram_slowdown_frames

    ; Skip next frame
    %a8() : LDA #$01 : STA !NMI_REQUEST_FLAG : %a16()
    JMP .done

  .pause
    LDA !ram_slowdown_frames : BNE .check_frame_advance

    INC : STA !ram_slowdown_frames
    LDA !IH_CONTROLLER_PRI : EOR !IH_CONTROLLER_PRI_NEW : STA !ram_slowdown_controller_1
    LDA !IH_CONTROLLER_SEC : EOR !IH_CONTROLLER_SEC_NEW : STA !ram_slowdown_controller_2

    ; Check controller 2 inputs
  .check_frame_advance
    LDA !IH_CONTROLLER_SEC_NEW : CMP !IH_PAUSE : BEQ .frame_advance
    CMP !IH_RESET : BNE .check_freeze_on_load
    ; Resume normal gameplay
    LDA #$0000 : STA !ram_slowdown_mode : STA !ram_slowdown_frames
    JMP .done

    ; Pause after load_state until new inputs
  .check_freeze_on_load
    LDA !ram_freeze_on_load : BEQ .wait_for_next_nmi
    LDA !IH_CONTROLLER_PRI_NEW : BEQ .wait_for_next_nmi
    ; Reset timers and unpause
    LDA #$0000 : STA !ram_reset_segment_later
    STA !ram_seg_rt_frames : STA !ram_seg_rt_seconds
    STA !ram_seg_rt_minutes : STA !ram_slowdown_mode : STA !ram_slowdown_frames
    JMP .done

  .wait_for_next_nmi
    %a8() : LDA #$01 : STA !NMI_REQUEST_FLAG : %a16()
    JMP .done

  .frame_advance
    LDA #$0000 : STA !ram_slowdown_frames
    LDA !ram_slowdown_controller_1 : STA !IH_CONTROLLER_PRI_PREV
    LDA !ram_slowdown_controller_2 : STA !IH_CONTROLLER_SEC_PREV
    JSL $809459 ;  Read controller input

  .done
    PLY
    PLX
    PLA
    PLD
    PLB
    RTI
}

ih_gamemode_frame:
{
    LDA !ram_gametime_room : INC : STA !ram_gametime_room

    ; overwritten code + return
    JML $949B60
}

ih_after_room_transition:
{
    ; update last door times
    LDA !ram_transition_counter : STA !ram_last_door_lag_frames
    LDA !ram_realtime_room : STA !ram_last_realtime_door

    ; clear transition variables
    LDA #$0000 : STA !ram_transition_flag : STA !ram_lag_counter
    STA !REALTIME_LAG_COUNTER

    ; Check if MBHP needs to be disabled
    LDA !sram_display_mode : CMP #!IH_MODE_ROOMSTRAT_INDEX : BNE .segmentTimer
    LDA !sram_room_strat : CMP #!IH_STRAT_MBHP_INDEX : BNE .segmentTimer
    LDA !ROOM_ID : CMP #$DD58 : BEQ .segmentTimer
    LDA #$0000 : STA !sram_display_mode

  .segmentTimer
    LDA !ram_reset_segment_later : AND #$0001 : BEQ .updateHud
    LDA #$0000 : STA !ram_reset_segment_later
    STA !ram_seg_rt_frames : STA !ram_seg_rt_seconds
    STA !ram_seg_rt_minutes

  .updateHud
    JSL ih_update_hud_code

    ; Reset realtime and gametime/transition timers
    LDA #$0000 : STA !ram_realtime_room : STA !ram_transition_counter

    ; original hijacked code
    LDA #$0008 : STA !GAMEMODE
    RTL
}

ih_before_room_transition:
{
    STA !GAMEMODE ; overwritten code

    ; Check if we've already run on this frame
    LDA !ram_transition_flag : BEQ .first_run
    CLC ; overwritten code
    RTL

  .first_run
    ; Lag
    LDA !ram_realtime_room : SEC : SBC !ram_transition_counter : STA !ram_last_room_lag

    ; Room timers
    LDA !ram_gametime_room : STA !ram_last_gametime_room
    LDA !ram_realtime_room : STA !ram_last_realtime_room

    ; Reset variables
    LDA #$0000 : STA !ram_room_has_set_rng
    STA !ram_transition_counter : STA !ram_gametime_room
    STA !ram_realtime_room : STA !ram_last_realtime_door
    LDA #$0001 : STA !ram_transition_flag

    ; Save temp variables
    LDA $12 : PHA
    LDA $14 : PHA

    ; Update HUD
    JSL ih_update_hud_before_transition

    ; Restore temp variables
    PLA : STA $14
    PLA : STA $12

    ; Calculate door alignment time
    LDX !DOOR_ID
    AND #$00FF : %a8() ; Draw3 returns a16
    LDA $830003,X : BIT #$02 : BNE .verticalDoor
    LDA !LAYER1_Y : BRA .checkAlignment
  .verticalDoor
    LDA !LAYER1_X
  .checkAlignment
    BPL .drawDoorLag
    EOR #$FF : INC
  .drawDoorLag
    PHB : PHD : PLB : PLB : PHA
    LDX #$00C2
    LDA !ram_minimap : BEQ .draw3
    LDX #$0054
  .draw3
    PLA : JSR Draw3
    PLB

  .done
    CLC ; overwritten code
    RTL
}

ceres_start_timers:
{
    LDA #$0000
    STA !ram_realtime_room : STA !ram_last_realtime_room
    STA !ram_gametime_room : STA !ram_last_gametime_room
    STA !ram_last_room_lag : STA !ram_last_door_lag_frames : STA !ram_transition_counter

    ; overwritten code
    STZ $0723 : STZ $0725
    
    JML ceres_start_timers_return
}

ih_unpause:
; Adds frames when unpausing (nmi is turned off during vram transfers)
{
    ; RT room
    LDA !ram_realtime_room : CLC : ADC.w #41 : STA !ram_realtime_room

    ; RT seg
    LDA !ram_seg_rt_frames : CLC : ADC.w #41 : STA !ram_seg_rt_frames
    CMP.w #60 : BCC .updateHUD
    SEC : SBC.w #60 : STA !ram_seg_rt_frames

    LDA !ram_seg_rt_seconds : INC : STA !ram_seg_rt_seconds
    CMP.w #60 : BCC .updateHUD
    LDA #$0000 : STA !ram_seg_rt_seconds

    LDA !ram_seg_rt_minutes : INC : STA !ram_seg_rt_minutes

  .updateHUD
    JSL ih_update_hud_early

    ; Replace overwritten logic to enable NMI
    JML $80834B
}

ih_elevator_activation:
{
    PHA
    ; Only update if we're in a room and activate an elevator.
    ; Otherwise this will also run when you enter a room already riding one.
    LDA !GAMEMODE : CMP #$0008 : BNE .done
    LDA !ram_timers_autoupdate : BNE .done

    JSL ih_update_hud_early

  .done
    PLA
    STZ $0A56
    SEC
    RTL
}

ih_babyskip_segment:
{
    ; runs when the screen locks to start the hopper/baby cutscene
    STA $7ECD22 ; overwritten code
    JSL ih_update_hud_early
    RTL
}

ih_mb1_segment:
{
    ; runs during MB1 cutscene when you regain control of Samus, just before music change
    JSL $90F084 ; overwritten code

    JML ih_update_hud_early
}

ih_mb2_segment:
{
    ; runs during baby spawn routine for MB2
    STA $7E7854    ; we overwrote this instruction to get here

    JML ih_update_hud_early
}

ih_drops_segment:
{
    ; runs when boss drops spawn
    JSL ih_update_hud_early
    ; overwritten code
    PLP : PLY : PLX
    RTL
}

ih_chozo_segment:
{
    JSL $8090CB ; overwritten code
    JML ih_update_hud_early
}

ih_ceres_elevator_segment:
{
    JSL $90F084 ; overwritten code
    JML ih_update_hud_early
}

ih_ship_elevator_segment:
{
    JSL ih_update_hud_early
    JML $91E3F6 ; overwritten code
}

ih_update_hud_before_transition:
{
    PHX : PHY
    PHP : PHB
    ; Bank 80
    PEA $8080 : PLB : PLB

    LDA !sram_display_mode : CMP #!IH_MODE_ARMPUMP_INDEX : BNE .start

    ; Report armpump room totals
    LDA !ram_momentum_sum : CLC : ADC !ram_momentum_count : LDX #$0088 : JSR Draw4
    LDA !ram_fail_sum : CLC : ADC !ram_fail_count : LDX #$0092 : JSR Draw4
    LDA #$0000 : STA !ram_momentum_count : STA !ram_fail_count
    STA !ram_momentum_sum : STA !ram_fail_sum : STA !ram_roomstrat_counter

  .start
    BRA ih_update_hud_code_start
}

ih_update_hud_code:
{
    PHX : PHY
    PHP : PHB
    ; Bank 80
    PEA $8080 : PLB : PLB

  .start
    LDA !ram_minimap : BNE .mmHud
    BRL .startUpdate

  .mmVanilla
;    BRL .end

  .mmHud
    ; Map visible, so draw map counter over item%
;    LDA !sram_top_display_mode : CMP !TOP_DISPLAY_VANILLA : BEQ .mmVanilla
    LDA !ram_map_counter : LDX #$0014 : JSR Draw3
    LDA !sram_display_mode : CMP #!IH_MODE_SHINETUNE_INDEX : BNE .mmRoomTimer
    BRL .mmPickTransitionTime

  .mmRoomTimer
    STZ $4205
    LDA !sram_frame_counter_mode : BNE .mmInGameTimer
    LDA !IH_DECIMAL : STA !HUD_TILEMAP+$B4
    LDA !ram_last_realtime_room
    BRA .mmCalculateTimer
  .mmInGameTimer
    LDA !IH_HYPHEN : STA !HUD_TILEMAP+$B4
    LDA !ram_last_gametime_room
  .mmCalculateTimer
    ; Divide time by 60 or 50 and draw seconds and frames
    STA $4204
    %a8()
    LDA #$3C
    STA $4206
    %a16()
    PEA $0000 : PLA ; wait for CPU math
    LDA $4216 : STA $C1
    LDA $4214 : LDX #$0036 : JSR Draw2
;    LDA !IH_DECIMAL : STA !HUD_TILEMAP+$B4
    LDA $C1 : ASL : TAX
    LDA HexToNumberGFX1,X : AND #$0CFF : STA !HUD_TILEMAP+$76
    LDA HexToNumberGFX2,X : AND #$0CFF : STA !HUD_TILEMAP+$78

  .mmPickTransitionTime
    LDA !sram_lag_counter_mode : BNE .mmFullTransitionTime
    LDA !ram_last_door_lag_frames
    BRA .mmDrawTransitionTime
  .mmFullTransitionTime
    LDA !ram_last_realtime_door
  .mmDrawTransitionTime
    LDX #$0054 : JSR Draw3
    BRL .end

  .startUpdate
    LDA #$FFFF : STA !ram_last_hp : STA !ram_enemy_hp

    ; Determine starting point of time display
    LDX #$003C
    LDA !sram_top_display_mode : CMP !TOP_DISPLAY_VANILLA : BNE .pickRoomTimer
    LDX #$003A

  .pickRoomTimer
    STZ $4205
    LDA !sram_frame_counter_mode : BNE .inGameRoomTimer
    LDA !IH_DECIMAL : STA !HUD_TILEMAP+$42
    LDA !ram_last_realtime_room
    BRA .calculateRoomTimer
  .inGameRoomTimer
    LDA !IH_HYPHEN : STA !HUD_TILEMAP+$42
    LDA !ram_last_gametime_room
  .calculateRoomTimer
    ; Divide time by 60 or 50 and draw seconds and frames
    STA $4204
    %a8()
    LDA #$3C
    STA $4206
    %a16()
    PEA $0000 : PLA ; wait for CPU math
    LDA $4216 : STA $C1
    LDA $4214 : JSR Draw3 : TXY
    LDA $C1 : ASL : TAX
    LDA HexToNumberGFX1,X : PHX : TYX : STA !HUD_TILEMAP+$02,X
    PLX : LDA HexToNumberGFX2,X : TYX : STA !HUD_TILEMAP+$04,X

    ; 3 tiles between input display and missile icon
    ; skip item% if display mode = vspeed
    LDA !sram_display_mode : CMP #!IH_MODE_VSPEED_INDEX : BEQ .skipToLag
    LDA !sram_top_display_mode : BNE .skipToLag

    ; Draw Item percent
    ; Max HP and Reserves
    LDA !SAMUS_HP_MAX : CLC : ADC !SAMUS_RESERVE_MAX
    JSR CalcEtank : STA $C1

    ; Max Missiles, Supers & Power Bombs
    LDA !SAMUS_MISSILES_MAX : CLC : ADC !SAMUS_SUPERS_MAX : CLC : ADC !SAMUS_PBS_MAX
    JSR CalcItem : CLC : ADC $C1 : STA $C1

    ; Collected items
    JSR CalcLargeItem : CLC : ADC $C1 : STA $C1

    ; Collected beams and charge
    JSR CalcBeams : CLC : ADC $C1

    ; Percent counter -> decimal form and drawn on HUD
    LDX #$0012 : JSR Draw3
;    LDA !IH_PERCENT : STA !HUD_TILEMAP+$18

  .skipToLag
;    LDA !sram_top_display_mode : CMP !TOP_DISPLAY_VANILLA : BEQ .vanillaLagReserves
    LDA !ram_last_room_lag : LDX #$0080 : JSR Draw4

    ; Skip door lag and segment timer when shinetune enabled
    LDA !sram_display_mode : CMP #!IH_MODE_SHINETUNE_INDEX : BEQ .end

    ; Door lag / transition time
    LDA !sram_lag_counter_mode : BNE .fullTransitionTime
    LDA !ram_last_door_lag_frames
    BRA .drawTransitionTime
  .fullTransitionTime
    LDA !ram_last_realtime_door
  .drawTransitionTime
    LDX #$00C2 : JSR Draw3
; skip segment timer in Subversion
;    BRA .pickSegmentTimer

  .end
    PLB : PLP
    PLY : PLX
    RTL

  .vanillaLagReserves
;    LDA !SAMUS_RESERVE_MODE : CMP #$0001 : BNE .vanillaDrawLag
;
;    ; Draw reserve icon
;    LDY #$998B : LDA !SAMUS_RESERVE_ENERGY : BNE .vanillaDrawReserve
;    LDY #$9997
;  .vanillaDrawReserve
;    LDA $0000,Y : STA !HUD_TILEMAP+$18 : LDA $0002,Y : STA !HUD_TILEMAP+$1A
;    LDA $0004,Y : STA !HUD_TILEMAP+$58 : LDA $0006,Y : STA !HUD_TILEMAP+$5A
;
;  .vanillaDrawLag
;    LDA !ram_last_room_lag : LDX #$007E : JSR Draw4
;
;    ; Skip door lag and segment timer when shinetune enabled
;    LDA !sram_display_mode : CMP #!IH_MODE_SHINETUNE_INDEX : BEQ .end
;
;    ; Door lag / transition time
;    LDA !sram_lag_counter_mode : BNE .vanillaFullTransitionTime
;    LDA !ram_last_door_lag_frames
;    BRA .vanillaDrawTransitiontime
;  .vanillaFullTransitionTime
;    LDA !ram_last_realtime_door
;  .vanillaDrawTransitiontime
;    LDX #$00C2 : JSR Draw2
;
;  .pickSegmentTimer
;    LDA !sram_frame_counter_mode : BNE .inGameSegmentTimer
;    LDA.w #!ram_seg_rt_frames : STA $00
;    LDA.w #!WRAM_BANK : STA $02
;    BRA .drawSegmentTimer
;
;  .inGameSegmentTimer
;    LDA.w #!IGT_FRAMES : STA $00
;    LDA.w #!WRAM_BANK : STA $02
;
;  .drawSegmentTimer
;    ; Frames
;    LDA [$00] : INC $00 : INC $00 : ASL : TAX
;    LDA HexToNumberGFX1,X : STA !HUD_TILEMAP+$BC
;    LDA HexToNumberGFX2,X : STA !HUD_TILEMAP+$BE
;
;    ; Seconds
;    LDA [$00] : INC $00 : INC $00 : ASL : TAX
;    LDA HexToNumberGFX1,X : STA !HUD_TILEMAP+$B6
;    LDA HexToNumberGFX2,X : STA !HUD_TILEMAP+$B8
;
;    ; Minutes
;    LDA [$00] : LDX #$00AE : JSR Draw3
;
;    ; Draw decimal/hyphen seperators
;    LDA !sram_frame_counter_mode : BNE .ingameSeparators
;    LDA !IH_DECIMAL : STA !HUD_TILEMAP+$B4 : STA !HUD_TILEMAP+$BA
;    BRA .blankEnd
;
;  .ingameSeparators
;    LDA !IH_HYPHEN : STA !HUD_TILEMAP+$B4 : STA !HUD_TILEMAP+$BA
;
;  .blankEnd
;    LDA !IH_BLANK : STA !HUD_TILEMAP+$C0
;    BRL .end
}

ih_update_hud_early:
{
    ; calculate lag frames
    LDA !ram_realtime_room : SEC : SBC !ram_transition_counter : STA !ram_last_room_lag

    LDA !ram_gametime_room : STA !ram_last_gametime_room
    LDA !ram_realtime_room : STA !ram_last_realtime_room

    ; update HUD
    LDA $12 : PHA : LDA $14 : PHA
    JSL ih_update_hud_code
    PLA : STA $14 : PLA : STA $12

    RTL
}

ih_hud_vanilla_health:
{
    LDA !SAMUS_HP : STA !SAMUS_LAST_HP : STA $4204
    %a8()
    LDA #$64 : STA $4206
    %a16()
    PEA $0000 : PLA ; wait for CPU math
    LDA $4214 : STA $14
    LDA $4216 : STA $12
    LDA !SAMUS_HP_MAX : STA $4204
    %a8()
    LDA #$64 : STA $4206
    %ai16()
    PHA : PLA : PHA : PLA
    LDY #$0000 : LDA $4214
    INC : STA $16

  .loopTanks
    DEC $16 : BEQ .drawEmptyTanks
    LDX #$3430
    LDA $14 : BEQ .drawTankHealth
    DEC $14 : LDX #$2831
  .drawTankHealth
    TXA : LDX $9CCE,Y : STA !HUD_TILEMAP+$08,X
    INY : INY : CPY #$001C : BMI .loopTanks
    BRA .subtankHealth

  .drawEmptyTanks
     LDA !IH_BLANK
  .loopEmptyTanks
     LDX $9CCE,Y : STA !HUD_TILEMAP+$08,X
     INY : INY : CPY #$001C : BMI .loopEmptyTanks

  .subtankHealth
    LDA $12 : LDX #$0094 : JSR Draw2
    LDA $16 : BNE .subtankWhitespace
    ; Draw the leading zero
    LDA.w NumberGFXTable : STA !HUD_TILEMAP+$94

  .subtankWhitespace
    LDA !IH_BLANK : STA !HUD_TILEMAP+$92 : STA !HUD_TILEMAP+$98
    STA !HUD_TILEMAP+$9A : STA !HUD_TILEMAP+$08 : STA !HUD_TILEMAP+$48

    LDA !SAMUS_RESERVE_MODE : CMP #$0001 : BNE .noReserves

    ; Draw reserve icon
;    LDY #$998B : LDA !SAMUS_RESERVE_ENERGY : BNE .drawReserveIcon
    LDY #$9997
  .drawReserveIcon
    LDA $0000,Y : STA !HUD_TILEMAP+$18 : LDA $0002,Y : STA !HUD_TILEMAP+$1A
    LDA $0004,Y : STA !HUD_TILEMAP+$58 : LDA $0006,Y : STA !HUD_TILEMAP+$5A
    RTS

  .noReserves
    LDA !IH_BLANK : STA !HUD_TILEMAP+$18 : STA !HUD_TILEMAP+$1A
    STA !HUD_TILEMAP+$58 : STA !HUD_TILEMAP+$5A
    RTS
}

ih_hud_code:
{
    ; overwritten code
    STZ $02
    %ai16()

    LDA !sram_top_display_mode : CMP !TOP_DISPLAY_VANILLA : BEQ .vanilla_infohud

    ; -- input display --
    ; -- check if we want to update --
    LDA !ram_frames_held : BNE .frames_help_update
    LDA !IH_CONTROLLER_PRI : CMP !ram_ih_controller : BNE .controller_update
    BRL .status_display

  .frames_help_update
    BRL .framesHeld

  .controller_update
    ; -- read input
    TAY : LDX #$000C
  .controller_row_loop
    TYA : AND ControllerTable1,X
    BEQ .controller_row_1_blank
    LDA ControllerGfx1,X
    BRA .controller_row_1_draw
  .controller_row_1_blank
    LDA !IH_BLANK
  .controller_row_1_draw
    STA !HUD_TILEMAP+$06,X
    TYA : AND ControllerTable2,X
    BEQ .controller_row_2_blank
    LDA ControllerGfx2,X
    BRA .controller_row_2_draw
  .controller_row_2_blank
    LDA !IH_BLANK
  .controller_row_2_draw
    STA !HUD_TILEMAP+$46,X
    DEX : DEX : BNE .controller_row_loop

    TYA : STA !ram_ih_controller
    BRA .status_display

  .vanilla_infohud
    ; Shift infohud status left by one
    LDA !HUD_TILEMAP+$8A : STA !HUD_TILEMAP+$88
    LDA !HUD_TILEMAP+$8C : STA !HUD_TILEMAP+$8A
    LDA !HUD_TILEMAP+$8E : STA !HUD_TILEMAP+$8C
    LDA !HUD_TILEMAP+$90 : STA !HUD_TILEMAP+$8E

  .status_display
    LDA !sram_display_mode : ASL : TAX
    JSR (.status_display_table,X)

    ; Samus' HP
    LDA !SAMUS_HP : CMP !ram_last_hp : BEQ .statusIcons : STA !ram_last_hp
;    LDA !sram_top_display_mode : CMP !TOP_DISPLAY_VANILLA : BEQ .vanilla_draw_health
    LDA !SAMUS_HP : LDX #$0092 : JSR Draw3
    LDA !IH_BLANK : STA !HUD_TILEMAP+$90; : STA !HUD_TILEMAP+$9A
;    BRA .reserves
;
;  .vanilla_check_health
;    LDA !SAMUS_HP : CMP !SAMUS_LAST_HP : BEQ .vanilla_health_end
;  .vanilla_draw_health
;    JSR ih_hud_vanilla_health
;  .vanilla_health_end
;    ; Shift infohud status right by one
;    LDA !HUD_TILEMAP+$8E : STA !HUD_TILEMAP+$90
;    LDA !HUD_TILEMAP+$8C : STA !HUD_TILEMAP+$8E
;    LDA !HUD_TILEMAP+$8A : STA !HUD_TILEMAP+$8C
;    LDA !HUD_TILEMAP+$88 : STA !HUD_TILEMAP+$8A
;    LDA !IH_BLANK : STA !HUD_TILEMAP+$88
;    BRL .end
;
;    ; Reserve energy counter
;  .reserves
;    LDA !sram_top_display_mode : BEQ .statusIcons
;    CMP !TOP_DISPLAY_VANILLA : BEQ .vanilla_check_health
;
;    LDA !SAMUS_RESERVE_MAX : BEQ .noReserves
;    LDA !SAMUS_RESERVE_ENERGY : CMP !ram_reserves_last : BEQ .checkAuto
;    STA !ram_reserves_last : LDX #$0014 : JSR Draw3
;
;  .checkAuto
;    LDA !SAMUS_RESERVE_MODE : CMP #$0001 : BEQ .autoOn
;    LDA !IH_BLANK : STA !HUD_TILEMAP+$1A : BRA .statusIcons
;
;  .autoOn
;    LDA !SAMUS_RESERVE_ENERGY : BEQ .autoEmpty
;    LDA !IH_RESERVE_AUTO : STA !HUD_TILEMAP+$1A : BRA .statusIcons
;
;  .autoEmpty
;    LDA !IH_RESERVE_EMPTY : STA !HUD_TILEMAP+$1A : BRA .statusIcons
;
;  .noReserves
;    LDA !IH_BLANK : STA !HUD_TILEMAP+$14 : STA !HUD_TILEMAP+$16 : STA !HUD_TILEMAP+$18 : STA !HUD_TILEMAP+$1A

    ; Status Icons
  .statusIcons
    LDA !sram_status_icons : BNE .check_healthbomb
    RTL

    ; health bomb
  .check_healthbomb
    LDA $0E1A : BEQ .clear_healthbomb
    LDA !SAMUS_HP : CMP #$0032 : BMI .pink
    LDA !IH_LETTER_E : STA !HUD_TILEMAP+$54
    BRA .check_elevator

  .pink
    LDA !IH_HEALTHBOMB : STA !HUD_TILEMAP+$54
    BRA .check_elevator

  .clear_healthbomb
    LDA !IH_BLANK : STA !HUD_TILEMAP+$54

    ; Elevator
  .check_elevator
    LDA $0E16 : BEQ .clear_elevator
    LDA !IH_ELEVATOR : STA !HUD_TILEMAP+$56
    BRA .check_shinetimer

  .clear_elevator
    LDA !IH_BLANK : STA !HUD_TILEMAP+$56

    ; Shine timer
  .check_shinetimer
    LDA !SAMUS_SHINE_TIMER : BEQ .clear_shinetimer
    LDA !IH_SHINETIMER : STA !HUD_TILEMAP+$58
;    BRA .check_reserves
    BRA .check_morphlock

  .clear_shinetimer
    LDA !IH_BLANK : STA !HUD_TILEMAP+$58

    ; reserve tank
;  .check_reserves
;    LDA !sram_top_display_mode : BNE .check_morphlock
;    LDA !SAMUS_RESERVE_MODE : CMP #$0001 : BNE .clearReserve
;    LDA !SAMUS_RESERVE_ENERGY : BEQ .empty
;    LDA !SAMUS_RESERVE_MAX : BEQ .clearReserve
;
;    LDA !IH_RESERVE_AUTO : STA !HUD_TILEMAP+$1A
;    BRA .end
;
;  .empty
;    LDA !SAMUS_RESERVE_MAX : BEQ .clearReserve
;    LDA !IH_RESERVE_EMPTY : STA !HUD_TILEMAP+$1A
;    BRA .end
;
;  .clearReserve
;    LDA !IH_BLANK : STA !HUD_TILEMAP+$1A

    ; Morph Lock
  .check_morphlock
    LDA $09A1 : AND #$8000 : BEQ .clear_morphlock
    LDA !IH_MORPHBALL : STA $7EC656
    BRA .end

  .clear_morphlock
    LDA !IH_BLANK : STA $7EC656

  .end
    RTL

  .framesHeld
    LDA !IH_CONTROLLER_PRI_NEW : TAY : LDX #$000C
  .clearCountersLoop
    TYA : AND ControllerTable1,X : BEQ .clearCountersRow2
    PHX : LDA FramesHeldTable1,X : TAX
    LDA #$0000 : STA !WRAM_MENU_START,X : PLX
  .clearCountersRow2
    TYA : AND ControllerTable2,X : BEQ .clearCountersNext
    PHX : LDA FramesHeldTable2,X : TAX
    LDA #$0000 : STA !WRAM_MENU_START,X : PLX
  .clearCountersNext
    DEX : DEX : BNE .clearCountersLoop

    LDA !IH_CONTROLLER_PRI : TAY : LDX #$000C
  .drawFramesHeldLoop
    LDA !ram_frames_held : AND ControllerTable1,X : BNE .useFramesHeldRow1
    TYA : AND ControllerTable1,X : BEQ .blankFramesHeldRow1
  .nonBlankFramesHeldRow1
    LDA ControllerGfx1,X
    BRA .drawFramesHeldRow1
  .blankFramesHeldRow1
    LDA !IH_BLANK
  .drawFramesHeldRow1
    STA !HUD_TILEMAP+$06,X
    LDA !ram_frames_held : AND ControllerTable2,X : BNE .useFramesHeldRow2
    TYA : AND ControllerTable2,X : BEQ .blankFramesHeldRow2
  .nonBlankFramesHeldRow2
    LDA ControllerGfx2,X
    BRA .drawFramesHeldRow2
  .blankFramesHeldRow2
    LDA !IH_BLANK
  .drawFramesHeldRow2
    STA !HUD_TILEMAP+$46,X
    DEX : DEX : BNE .drawFramesHeldLoop
    BRL .status_display

  .useFramesHeldRow1
    PHX : TYA : AND ControllerTable1,X : BNE .incFramesHeldRow1
    LDA FramesHeldTable1,X : TAX
    LDA !WRAM_MENU_START,X : BEQ .plxBlankFramesHeldRow1
    CMP #$0042 : BCC .loadFramesHeldRow1
  .plxBlankFramesHeldRow1
    PLX : BRA .blankFramesHeldRow1
  .incFramesHeldRow1
    LDA FramesHeldTable1,X : TAX
    LDA !WRAM_MENU_START,X : INC : STA !WRAM_MENU_START,X
    CMP #$0042 : BCC .loadFramesHeldRow1
    PLX : BRA .nonBlankFramesHeldRow1
  .loadFramesHeldRow1
    ASL : TAX : LDA NumberGFXTable,X : PLX
    BRA .drawFramesHeldRow1

  .useFramesHeldRow2
    PHX : TYA : AND ControllerTable2,X : BNE .incFramesHeldRow2
    LDA FramesHeldTable2,X : TAX
    LDA !WRAM_MENU_START,X : BEQ .plxBlankFramesHeldRow2
    CMP #$0042 : BCC .loadFramesHeldRow2
  .plxBlankFramesHeldRow2
    PLX : BRA .blankFramesHeldRow2
  .incFramesHeldRow2
    LDA FramesHeldTable2,X : TAX
    LDA !WRAM_MENU_START,X : INC : STA !WRAM_MENU_START,X
    CMP #$0042 : BCC .loadFramesHeldRow2
    PLX : BRA .nonBlankFramesHeldRow2
  .loadFramesHeldRow2
    ASL : TAX : LDA NumberGFXTable,X : PLX
    BRA .drawFramesHeldRow2
}

incsrc infohudmodes.asm

;---SUBROUTINES---
Draw2:
{
    STA $4204
    %a8()
    LDA #$0A : STA $4206   ; divide by 10
    %a16()
    PEA $0000 : PLA ; wait for CPU math
    LDA $4214 : STA $16

    ; Ones digit
    LDA $4216 : ASL : TAY : LDA.w NumberGFXTable,Y : STA !HUD_TILEMAP+$02,X

    ; Tens digit
    LDA $16 : BEQ .blanktens : ASL : TAY : LDA.w NumberGFXTable,Y : STA !HUD_TILEMAP+$00,X

  .done
    INX #4
    RTS

  .blanktens
    LDA !IH_BLANK : STA !HUD_TILEMAP+$00,X
    BRA .done
}

Draw3:
{
    STA $4204
    %a8()
    LDA #$0A : STA $4206   ; divide by 10
    %a16()
    PEA $0000 : PLA ; wait for CPU math
    LDA $4214 : STA $16

    ; Ones digit
    LDA $4216 : ASL : TAY : LDA.w NumberGFXTable,Y : STA !HUD_TILEMAP+$04,X

    LDA $16 : BEQ .blanktens
    STA $4204
    %a8()
    LDA #$0A : STA $4206   ; divide by 10
    %a16()
    PEA $0000 : PLA ; wait for CPU math
    LDA $4214 : STA $14

    ; Tens digit
    LDA $4216 : ASL : TAY : LDA.w NumberGFXTable,Y : STA !HUD_TILEMAP+$02,X

    ; Hundreds digit
    LDA $14 : BEQ .blankhundreds : ASL : TAY : LDA.w NumberGFXTable,Y : STA !HUD_TILEMAP+$00,X

  .done
    INX #6
    RTS

  .blanktens
    LDA !IH_BLANK : STA !HUD_TILEMAP+$00,X : STA !HUD_TILEMAP+$02,X
    BRA .done

  .blankhundreds
    LDA !IH_BLANK : STA !HUD_TILEMAP+$00,X
    BRA .done
}

Draw4:
{
    STA $4204
    %a8()
    LDA #$0A : STA $4206   ; divide by 10
    %a16()
    PEA $0000 : PLA ; wait for CPU math
    LDA $4214 : STA $16

    ; Ones digit
    LDA $4216 : ASL : TAY : LDA.w NumberGFXTable,Y : STA !HUD_TILEMAP+$06,X

    LDA $16 : BEQ .blanktens
    STA $4204
    %a8()
    LDA #$0A : STA $4206   ; divide by 10
    %a16()
    PEA $0000 : PLA ; wait for CPU math
    LDA $4214 : STA $14

    ; Tens digit
    LDA $4216 : ASL : TAY : LDA.w NumberGFXTable,Y : STA !HUD_TILEMAP+$04,X

    LDA $14 : BEQ .blankhundreds
    STA $4204
    %a8()
    LDA #$0A : STA $4206   ; divide by 10
    %a16()
    PEA $0000 : PLA ; wait for CPU math
    LDA $4214 : STA $12

    ; Hundreds digit
    LDA $4216 : ASL : TAY : LDA.w NumberGFXTable,Y : STA !HUD_TILEMAP+$02,X

    ; Thousands digit
    LDA $12 : BEQ .blankthousands : ASL : TAY : LDA.w NumberGFXTable,Y : STA !HUD_TILEMAP+$00,X

  .done
    INX #8
    RTS

  .blanktens
    LDA !IH_BLANK : STA !HUD_TILEMAP+$00,X : STA !HUD_TILEMAP+$02,X : STA !HUD_TILEMAP+$04,X
    BRA .done

  .blankhundreds
    LDA !IH_BLANK : STA !HUD_TILEMAP+$00,X : STA !HUD_TILEMAP+$02,X
    BRA .done

  .blankthousands
    LDA !IH_BLANK : STA !HUD_TILEMAP+$00,X
    BRA .done
}

DrawHealthPaused:
{
;    LDA !sram_top_display_mode : BEQ .draw_health
;    CMP !TOP_DISPLAY_VANILLA : BEQ .vanilla_draw_health
;
;    LDA !SAMUS_RESERVE_MAX : BEQ .noReserves
;    LDA !SAMUS_RESERVE_ENERGY : STA !ram_reserves_last : LDX #$0014 : JSR Draw3
;    LDA !SAMUS_RESERVE_MODE : CMP #$0001 : BEQ .autoOn
;    LDA !IH_BLANK : STA !HUD_TILEMAP+$1A : BRA .draw_health
;
;  .autoOn
;    LDA !SAMUS_RESERVE_ENERGY : BEQ .autoEmpty
;    LDA !IH_RESERVE_AUTO : STA !HUD_TILEMAP+$1A : BRA .draw_health
;
;  .autoEmpty
;    LDA !IH_RESERVE_EMPTY : STA !HUD_TILEMAP+$1A : BRA .draw_health
;
;  .noReserves
;    LDA !IH_BLANK : STA !HUD_TILEMAP+$14 : STA !HUD_TILEMAP+$16 : STA !HUD_TILEMAP+$18 : STA !HUD_TILEMAP+$1A
;    LDA !SAMUS_RESERVE_ENERGY : STA !ram_reserves_last

  .draw_health
    LDA !SAMUS_HP : LDX #$0092 : JSR Draw4
    LDA !IH_BLANK : STA !HUD_TILEMAP+$90 : STA !HUD_TILEMAP+$9A
    RTL

;  .vanilla_draw_health
;    JSR ih_hud_vanilla_health
;    RTL
}

Draw4Hex:
{
    STA $12 : AND #$F000              ; get first digit (X000)
    XBA : LSR #3                      ; move it to last digit (000X) and shift left one
    TAY : LDA.w HexGFXTable,Y         ; load tilemap address with 2x digit as index
    STA !HUD_TILEMAP+$00,X                     ; draw digit to HUD

    LDA $12 : AND #$0F00              ; (0X00)
    XBA : ASL
    TAY : LDA.w HexGFXTable,Y
    STA !HUD_TILEMAP+$02,X

    LDA $12 : AND #$00F0              ; (00X0)
    LSR #3 : TAY : LDA.w HexGFXTable,Y
    STA !HUD_TILEMAP+$04,X

    LDA $12 : AND #$000F              ; (000X)
    ASL : TAY : LDA.w HexGFXTable,Y
    STA !HUD_TILEMAP+$06,X
    RTS
}

Draw4Hundredths:
{
    STA $4204
    %a8()
    LDA #$0A : STA $4206   ; divide by 10
    %a16()
    PEA $0000 : PLA

    ; Ones digit ignored, go straight to tens digit
    LDA $4214 : BEQ .zerotens
    STA $4204
    %a8()
    LDA #$0A : STA $4206   ; divide by 10
    %a16()
    PEA $0000 : PLA ; wait for CPU math
    LDA $4214 : STA $14

    ; Tens digit
    LDA $4216 : ASL : TAY : LDA.w NumberGFXTable,Y : STA !HUD_TILEMAP+$06,X

    LDA $14 : BEQ .zerohundreds
    STA $4204
    %a8()
    LDA #$0A : STA $4206   ; divide by 10
    %a16()
    PEA $0000 : PLA ; wait for CPU math
    LDA $4214 : STA $12

    ; Hundreds digit
    LDA $4216 : ASL : TAY : LDA.w NumberGFXTable,Y : STA !HUD_TILEMAP+$04,X

    ; Thousands digit
    LDA $12 : ASL : TAY : LDA.w NumberGFXTable,Y : STA !HUD_TILEMAP+$00,X

  .done
    LDA !IH_DECIMAL : STA !HUD_TILEMAP+$02,X
    INX #8
    RTS

  .zerotens
    LDA !IH_ZERO : STA !HUD_TILEMAP+$00,X : STA !HUD_TILEMAP+$04,X : STA !HUD_TILEMAP+$06,X
    BRA .done

  .zerohundreds
    LDA !IH_ZERO : STA !HUD_TILEMAP+$00,X : STA !HUD_TILEMAP+$04,X
    BRA .done
}

CalcEtank:
{
    STA $4204
    %a8()
    LDA #$64 : STA $4206
    %a16()
    PEA $0000 : PLA ; wait for CPU math
    LDA $4214
    RTS
}

CalcItem:
{
    STZ $4214 : STA $4204
    %a8()
    LDA #$05 : STA $4206
    %a16()
    PEA $0000 : PLA ; wait for CPU math
    LDA $4214
    RTS
}

CalcLargeItem:
{
    LDA !SAMUS_ITEMS_COLLECTED : AND #$F32F ; GT Code adds an unused item (10h)
    LDX #$0000

  .loop
    BIT #$0001 : BEQ .noItem
    INX
  .noItem
    LSR : BNE .loop

    TXA ; return result in A
    RTS
}

CalcBeams:
{
    %a8()
    LDA !SAMUS_BEAMS_COLLECTED
    LDX #$0000

  .loop
    BIT #$01 : BEQ .noItem
    INX
  .noItem
    LSR : BNE .loop

    ; count charge beam
    LDA !SAMUS_BEAMS_COLLECTED+1 : CMP #$10 : BNE .done
    INX

  .done
    %a16()
    TXA ; return result in A
    RTS
}

ih_game_loop_code:
{
    ; inc transition timer
    LDA !ram_transition_counter : INC : STA !ram_transition_counter

    LDA !ram_game_loop_extras : BNE .extrafeatures

  .checkinputs
    LDA !IH_CONTROLLER_SEC_NEW : BNE .handleinputs
    ; overwritten code + return
    JML $808111

  .extrafeatures
    LDA !ram_metronome : BEQ .metronome_done
    JSR metronome
  .metronome_done

    LDA !ram_magic_pants_enabled : XBA : ORA !ram_space_pants_enabled
    BEQ .checkinputs

    BIT #$00FF : BEQ .magicpants    ; if spacepants are disabled, handle magicpants
    BIT #$FF00 : BEQ .spacepants    ; if magicpants are disabled, handle spacepants

    ; both are enabled, check Samus movement type to decide
    LDA !SAMUS_MOVEMENT_TYPE : AND #$00FF : CMP #$0001 : BEQ .magicpants    ; check if running

  .spacepants
    JSR space_pants
    BRA .checkinputs

  .magicpants
    JSR magic_pants
    BRA .checkinputs

  .handleinputs
    CMP !IH_PAUSE : BEQ .toggle_pause
    CMP !IH_SLOWDOWN : BEQ .toggle_slowdown
    CMP !IH_SPEEDUP : BEQ .toggle_speedup
    CMP !IH_RESET : BEQ .reset_slowdown
    CMP !IH_STATUS_R : BEQ .inc_statusdisplay
    CMP !IH_STATUS_L : BEQ .dec_statusdisplay

    JML $808111 ; overwritten code

  .toggle_pause
    TDC : STA !ram_slowdown_frames
    DEC : STA !ram_slowdown_mode
    BRA .done

  .toggle_slowdown
    LDA !ram_slowdown_mode
    INC : STA !ram_slowdown_mode
    BRA .done

  .toggle_speedup
    LDA !ram_slowdown_mode : BEQ .skip_speedup
    DEC : STA !ram_slowdown_mode
  .skip_speedup
    BRA .done

  .reset_slowdown
    TDC
    STA !ram_slowdown_mode
    STA !ram_slowdown_frames
    BRA .done

  .inc_statusdisplay
    LDA !sram_display_mode : INC
    CMP #$0014 : BNE .set_displaymode
    TDC : STA !sram_display_mode
    BRA .update_status

  .done
    ; overwritten code + return
    JML $808111

  .dec_statusdisplay
    LDA !sram_display_mode : DEC
    CMP #$FFFF : BNE .set_displaymode
    LDA #$0013

  .set_displaymode
    STA !sram_display_mode

  .update_status
    TDC
    STA !ram_momentum_sum
    STA !ram_momentum_count
    STA !ram_HUD_check
    STA !ram_roomstrat_counter
    STA !ram_roomstrat_state
    STA !ram_armed_shine_duration
    STA !ram_fail_count
    STA !ram_fail_sum
    INC
    STA !ram_dash_counter
    STA !ram_xpos
    STA !ram_ypos
    STA !ram_horizontal_speed
    STA !ram_vertical_speed
    STA !ram_subpixel_pos
    STA !ram_mb_hp
    STA !ram_enemy_hp
    STA !ram_shine_counter
    BRA .done
}

metronome:
{
    LDA !ram_metronome_counter : INC
    CMP !sram_metronome_tickrate : BEQ .tick
    CMP #$0002 : BEQ .eraseHUD
    STA !ram_metronome_counter
    RTS

  .eraseHUD
    STA !ram_metronome_counter
    LDA !IH_BLANK : STA !HUD_TILEMAP+$62
    RTS

  .tick
    LDA !IH_LETTER_X : STA !HUD_TILEMAP+$62
    LDA #$0000 : STA !ram_metronome_counter
    LDA !sram_metronome_sfx : ASL : TAX
    LDA.l MetronomeSFX,X : JSL !SFX_LIB1
    RTS
}

MetronomeSFX:
    ; missile, click,  beep,   shot,   spazer
    dw #$0003, #$0039, #$0036, #$000B, #$000F

magic_pants:
{
    LDA !SAMUS_ANIMATION_FRAME : CMP #$0009 : BEQ .check
    LDA !ram_magic_pants_state : BEQ .skip_magic_pants
    TDC : STA !ram_magic_pants_state

    LDA !ram_magic_pants_enabled : AND #$0001 : BEQ .skip_magic_pants
    LDA !ram_magic_pants_pal1 : STA $7EC194
    LDA !ram_magic_pants_pal2 : STA $7EC196
    LDA !ram_magic_pants_pal3 : STA $7EC19E
  .skip_magic_pants
    RTS

  .check
    ; Enable magic pants in the following states:
    ; 9: Moving right - not aiming
    ; Ah: Moving left  - not aiming
    ; Bh: Moving right - gun extended
    ; Ch: Moving left  - gun extended
    ; Dh: Moving right - aiming up (unused)
    ; Eh: Moving left  - aiming up (unused)
    ; Fh: Moving right - aiming up-right
    ; 10h: Moving left  - aiming up-left
    ; 11h: Moving right - aiming down-right
    ; 12h: Moving left  - aiming down-left
    LDA !SAMUS_POSE : CMP #$0009 : BCC .done
    CMP #$0013 : BCS .done

    LDA !ram_magic_pants_state : BNE .check_flash_pants

    ; if loudpants are enabled, click
    LDA !ram_magic_pants_enabled : AND #$0002 : BEQ .check_flash_pants
    LDA !sram_metronome_sfx : ASL : TAX
    LDA.l MetronomeSFX,X : JSL !SFX_LIB1

  .check_flash_pants
    ; if flashpants are enabled, flash
    LDA !ram_magic_pants_enabled : AND #$0001 : BEQ .done
    LDA !ram_magic_pants_state : BNE .flash
    ; backup palettes
    LDA $7EC194 : STA !ram_magic_pants_pal1
    LDA $7EC196 : STA !ram_magic_pants_pal2
    LDA $7EC19E : STA !ram_magic_pants_pal3
  .flash
    LDA #$FFFF
    STA $7EC194 : STA $7EC196 : STA $7EC19E

  .done
    LDA #$FFFF : STA !ram_magic_pants_state
    RTS
}

space_pants:
{
    LDA !SAMUS_POSE : CMP #$001B : BEQ .checkFalling
    CMP #$001C : BEQ .checkFalling
    CMP #$0081 : BEQ .done
    CMP #$0082 : BEQ .done
  .reset
    ; restore palettes if needed
    LDA !ram_magic_pants_state : BEQ .done
    TDC : STA !ram_magic_pants_state

    LDA !ram_space_pants_enabled : AND #$0001 : BEQ .done
    LDA !ram_magic_pants_pal1 : STA $7EC194
    LDA !ram_magic_pants_pal2 : STA $7EC196
    LDA !ram_magic_pants_pal3 : STA $7EC198
  .done
    RTS

  .checkFalling
    LDA !SAMUS_Y_DIRECTION : CMP #$0002 : BNE .reset    ; check if falling

  .checkLiquid
    LDA $0AD2 : BNE .SJliquid             ; check if air

  .SJair
    LDA !SAMUS_Y_SPEEDCOMBINED : CMP $909E97 : BMI .reset  ; check against min SJ vspeed for air
    CMP $909E99 : BPL .reset              ; check against max SJ vspeed for air
    BRA .go

  .SJliquid
    LDA !SAMUS_Y_SPEEDCOMBINED : CMP $909E9B : BMI .reset  ; check against min SJ vspeed for liquids
    CMP $909E9D : BPL .reset              ; check against max SJ vspeed for liquids

    ; Screw Attack seems to write new palette data every frame, which overwrites the flash
  .go
    LDA !ram_magic_pants_state : BNE .done

    ; if loudpants are enabled, click
    LDA !ram_space_pants_enabled : AND #$0002 : BEQ .check_flash_pants
    LDA !sram_metronome_sfx : ASL : TAX
    LDA.l MetronomeSFX,X : JSL !SFX_LIB1

  .check_flash_pants
    ; if flashpants are enabled, flash
    LDA !ram_space_pants_enabled : AND #$0001 : BEQ .end
    ; preserve palettes first
    LDA $7EC194 : STA !ram_magic_pants_pal1
    LDA $7EC196 : STA !ram_magic_pants_pal2
    LDA $7EC198 : STA !ram_magic_pants_pal3
    ; then flash
    LDA #$FFFF
    STA $7EC194 : STA $7EC196 : STA $7EC198

  .end
    LDA #$FFFF : STA !ram_magic_pants_state
    RTS
}

ih_shinespark_code:
{
    DEC
    STA !ram_armed_shine_duration
    STA !SAMUS_SHINE_TIMER
    RTL
}

print pc, " infohud end"
;warnpc $F0E000 ; spritefeat.asm


; Stuff that needs to be placed in bank 80
org !ORG_INFOHUD_BANK80
print pc, " infohud bank80 start"

ih_fix_scroll_offsets:
{
    ; Custom doors are defined for incompatible door alignment,
    ; which sometimes breakings the scroll offsets
    ; Per layout.asm, these door definitions begin at 83:C000,
    ; so BIT #$4000 can be used to detect them
    LDA !DOOR_ID : BIT #$4000 : BNE .fix
    LDA !ram_fix_scroll_offsets : BEQ .nofix

  .fix
    LDA $B3 : AND #$FF00 : STA $B3
    LDA $B1 : AND #$FF00
    SEC
    RTS

  .nofix
    LDA $B1 : SEC
    RTS
}

ih_fix_scroll_down_offsets:
{
    ; Same fix as above, except $B3 must end in #$20
    LDA !DOOR_ID : BIT #$4000 : BNE .fix
    LDA !ram_fix_scroll_offsets : BEQ .nofix

  .fix
    LDA $B3 : AND #$FF00 : ORA #$0020 : STA $B3
    LDA $B1 : AND #$FF00
    SEC
    ; From here, we need to jump into the AE29 method
    JMP $AE2C

  .nofix
    LDA $B1 : SEC
    JMP $AE2C
}

ih_hud_code_paused:
{
    ; overwritten code
    PHP
    PHB
    PHK
    PLB
    %a8()
    STZ $02
    %ai16()

    ; Update Samus' HP and reserves
    LDA $7E09C2 : CMP !ram_last_hp : BEQ .check_reserves : STA !ram_last_hp
    BRA .draw_health
  .check_reserves
    LDA $7E09D6 : CMP !ram_reserves_last : BEQ .end
  .draw_health
    PHY : PHX
    LDX #$0092 : JSL DrawHealthPaused
    PLX : PLY

  .end
    LDA $7E09C0 ; overwritten code
    JMP $9BFB
}

NumberGFXTable:
    ;    x0      x1      x2      x3      x4      x5      x6      x7      x8      x9
    dw #$3C00, #$3C01, #$3C02, #$3C03, #$3C04, #$3C05, #$3C06, #$3C07, #$3C08, #$3C09 ; 0x
    dw #$3C10, #$3C71, #$3C12, #$3C13, #$3C14, #$3C15, #$3C16, #$3C17, #$3C18, #$3C19 ; 1x
    dw #$3C76, #$3C77, #$3C78, #$3C79, #$3C7A, #$3C7B, #$3C7C, #$3C7D, #$3C7E, #$3C7F ; 2x
    dw #$3CA9, #$3CAA, #$3CAB, #$3C36, #$3C37, #$3C38, #$3C0C, #$3C39, #$3C3A, #$3C3B ; 3x
    dw #$3C56, #$3C57, #$3C58, #$3C59, #$3C5A, #$3C5B, #$3C5C, #$3C5D, #$3C5E, #$3C5F ; 4x
    dw #$3C60, #$3C61, #$3C62, #$3C63, #$3C64, #$3C65, #$3C66, #$3C67, #$3C68, #$3C69 ; 5x
    dw #$3C6A, #$3C6B, #$3C6C, #$3C6D, #$3C6E, #$3C0D                                 ; 6x

HexGFXTable:
    dw #$3C00, #$3C01, #$3C02, #$3C03, #$3C04, #$3C05, #$3C06, #$3C07, #$3C08, #$3C09
    dw #$3CC0, #$3CC1, #$3CC2, #$3CC3, #$3CC4, #$3CC5

ControllerTable1:
    dw #$0000, #$0020, #$0800, #$0010, #$4000, #$0040, #$2000
ControllerTable2:
    dw #$0000, #$0200, #$0400, #$0100, #$8000, #$0080, #$1000
ControllerGfx1:
      ;          L       ^       R       Y       X       Sl
    dw #$0000, #$3CCB, #$3C71, #$3CD1, #$3CD8, #$3CD7, #$3C74
ControllerGfx2:
      ;          <       v       >       B       A       St
    dw #$0000, #$3C1B, #$3C73, #$3C72, #$3CC1, #$3CC0, #$3C75
FramesHeldTable1:
    dw #$0000, #$00BA, #$00C6, #$00B8, #$00CC, #$00BC, #$00CA
FramesHeldTable2:
    dw #$0000, #$00C2, #$00C4, #$00C0, #$00CE, #$00BE, #$00C8

HexToNumberGFX1:
    dw #$3C00, #$3C00, #$3C00, #$3C00, #$3C00, #$3C00, #$3C00, #$3C00, #$3C00, #$3C00
    dw #$3C01, #$3C01, #$3C01, #$3C01, #$3C01, #$3C01, #$3C01, #$3C01, #$3C01, #$3C01
    dw #$3C02, #$3C02, #$3C02, #$3C02, #$3C02, #$3C02, #$3C02, #$3C02, #$3C02, #$3C02
    dw #$3C03, #$3C03, #$3C03, #$3C03, #$3C03, #$3C03, #$3C03, #$3C03, #$3C03, #$3C03
    dw #$3C04, #$3C04, #$3C04, #$3C04, #$3C04, #$3C04, #$3C04, #$3C04, #$3C04, #$3C04
    dw #$3C05, #$3C05, #$3C05, #$3C05, #$3C05, #$3C05, #$3C05, #$3C05, #$3C05, #$3C05

HexToNumberGFX2:
    dw #$3C00, #$3C01, #$3C02, #$3C03, #$3C04, #$3C05, #$3C06, #$3C07, #$3C08, #$3C09
    dw #$3C00, #$3C01, #$3C02, #$3C03, #$3C04, #$3C05, #$3C06, #$3C07, #$3C08, #$3C09
    dw #$3C00, #$3C01, #$3C02, #$3C03, #$3C04, #$3C05, #$3C06, #$3C07, #$3C08, #$3C09
    dw #$3C00, #$3C01, #$3C02, #$3C03, #$3C04, #$3C05, #$3C06, #$3C07, #$3C08, #$3C09
    dw #$3C00, #$3C01, #$3C02, #$3C03, #$3C04, #$3C05, #$3C06, #$3C07, #$3C08, #$3C09
    dw #$3C00, #$3C01, #$3C02, #$3C03, #$3C04, #$3C05, #$3C06, #$3C07, #$3C08, #$3C09

print pc, " infohud bank80 end"
;warnpc $80FF80 ; cutscenes.asm door transition code

