;=======================================================
;Patches to support the minimap
;=======================================================

org $809B51
    JMP $9BFB    ; skip drawing auto reserve icon and normal energy numbers and tanks during HUD routine

org $82AED9      ; routine to draw auto reserve icon on HUD from equip screen
    NOP : NOP : NOP

org $82AEAF      ; routine to remove auto reserve icon on HUD from equip screen
    NOP : NOP : NOP

org $809AF3
    JSL mm_initialize_minimap

org $90A91B
    LDA !ram_minimap : BNE .update_minimap
    RTL
  .update_minimap
    JMP mm_update_minimap

org $90A97E
    JMP mm_inc_tile_count_helper

org $90A7EE      ; only clear minimap if it is visible
    LDA !ram_minimap : BEQ .skip_minimap
    JMP mm_clear_boss_room_tiles_helper

org $90A80A      ; normally runs after minimap grid has been drawn
    .skip_minimap

org $8282E5      ; write and clear tiles to VRAM
    JSR mm_write_and_clear_hud_tiles_helper
    BRA .write_next_tiles

org $828305
    .write_next_tiles

org $828EB8      ; write and clear tiles to VRAM
    JSR mm_write_and_clear_hud_tiles_helper
    PLP
    RTL

org $82E488      ; write tiles to VRAM
    JMP mm_write_hud_tiles_during_door_transition


org $9AB200      ; graphics for HUD
incbin ../resources/hudgfx.bin


; Place minimap graphics in bank FF
org $FFD000
print pc, " minimap bankFF start"
;incbin ../resources/mapgfx.bin
if !FEATURE_REDESIGN
incbin ../resources/RedesignMapGFX.bin
else
incbin ../resources/AxeilMapGFX.bin
endif

; Next block needs to be all zeros to clear a tilemap
fillbyte $00
fill 4096
print pc, " minimap bankFF end"


; The default HUD minimap should be cleared
org $8098FF    ; row 1
    dw #$2C0F, #$2C0F, #$2C0F, #$2C0F, #$2C0F

org $80993F    ; row 2
    dw #$2C0F, #$2C0F, #$2C0F, #$2C0F, #$2C0F

org $80997F    ; row 3
    dw #$2C0F, #$2C0F, #$2C0F, #$2C0F, #$2C0F

; The default energy 0 text should be cleared
org $80994D
    dw #$2C0F, #$2C0F, #$2C0F, #$2C0F, #$2C0F, #$2C0F


; Placed in bank 82 so that the jumps work
; Using helper functions cause bank 82 is full of Axeil code
;org $FDE000
org $82FED0
print pc, " minimap bank82 start"
mm_write_and_clear_hud_tiles_helper:
{
    JSL mm_write_and_clear_hud_tiles
    RTS
}

org $81F200
mm_write_and_clear_hud_tiles:
{
    %i16()
    LDA !ram_minimap : BNE .minimap_vram

    ; Load in normal vram
    LDA #$80 : STA $2115 ; word-access, incr by 1
    LDX #$4000 : STX $2116 ; VRAM address (8000 in vram)
    LDX #$B200 : STX $4302 ; Source offset
    LDA #$9A : STA $4304 ; Source bank
    LDX #$2000 : STX $4305 ; Size (0x10 = 1 tile)
    LDA #$01 : STA $4300 ; word, normal increment (DMA MODE)
    LDA #$18 : STA $4301 ; destination (VRAM write)
    LDA #$01 : STA $420B ; initiate DMA (channel 1)
    %i8()
    RTL

  .minimap_vram
    LDA #$80 : STA $2115 ; word-access, incr by 1
    LDX #$4000 : STX $2116 ; VRAM address (8000 in vram)
    LDX #$D000 : STX $4302 ; Source offset
    LDA #$FF : STA $4304 ; Source bank
    LDX #$2000 : STX $4305 ; Size (0x10 = 1 tile)
    LDA #$01 : STA $4300 ; word, normal increment (DMA MODE)
    LDA #$18 : STA $4301 ; destination (VRAM write)
    LDA #$01 : STA $420B ; initiate DMA (channel 1)
    %i8()
    RTL
}

org $82E675
mm_write_hud_tiles_during_door_transition:
{
    LDA !ram_minimap : BNE .minimap_vram

    ; Load in normal vram
    JSR $E039
    dl $9AB200
    dw $4000
    dw $1000
    JMP $E492  ; resume logic

  .minimap_vram
    JSR $E039
    dl $FDE000
    dw $4000
    dw $1000
    JMP $E492  ; resume logic
}
warnpc $82E6A1

print pc, " minimap bank82 end"
;warnpc $82FA00


; Placed in bank 90 so that the jumps work
;org $90F640
org $90FF6B
print pc, " minimap bank90-pt1 start"

mm_initialize_minimap:
{
    ; If we just left Ceres, increment segment timer
    LDA $0998 : AND #$00FF : CMP #$0006 : BNE .init_minimap
    LDA #$0000 : STA $12 : STA $14 : STA !ram_room_has_set_rng
    STA $09DA : STA $09DC : STA $09DE : STA $09E0
    STA !ram_realtime_room : STA !ram_last_realtime_room
    STA !ram_gametime_room : STA !ram_last_gametime_room
    STA !ram_last_room_lag : STA !ram_last_door_lag_frames : STA !ram_transition_counter

    ; adding 1:13 to seg timer to account for missed frames between Ceres and Zebes
    LDA !ram_seg_rt_frames : CLC : ADC #$000D : STA !ram_seg_rt_frames
    CMP #$003C : BMI .add_seconds
    SEC : SBC #$003C : STA !ram_seg_rt_frames : INC $12

  .add_seconds
    LDA !ram_seg_rt_seconds : CLC : ADC #$0001 : ADC $12 : STA !ram_seg_rt_seconds
    CMP #$003C : BMI .add_minutes
    SEC : SBC #$003C : STA !ram_seg_rt_seconds : INC $14

  .add_minutes
    LDA $14 : BEQ .init_minimap : CLC : ADC !ram_seg_rt_minutes : STA !ram_seg_rt_minutes

  .init_minimap
    LDA !ram_minimap : BEQ .skip_minimap
    JMP $A8EF  ; resume original logic

  .skip_minimap
    RTL
}
print pc, " minimap bank90-pt1 end"

org $90F861
print pc, " minimap bank90-pt2 start"
mm_update_minimap:
{
    PHP
    %ai16()
    LDA $05F7 : BNE .skip_minimap
    JMP $A925  ; minimap is enabled

  .skip_minimap
    PLP
    RTL
}
print pc, " minimap bank90-pt2 end"

org $90F72A
print pc, " minimap bank90-pt3 start"
; bank 90 is full of Axeil code
mm_inc_tile_count_helper:
    JML mm_inc_tile_count

mm_clear_boss_room_tiles_helper:
    JML mm_clear_boss_room_tiles
print pc, " minimap bank90-pt3 end"

org $92F530
mm_inc_tile_count:
{
    ; Check if tile is already set
    LDA $07F7,X
    ORA $AC04,Y
    CMP $07F7,X : BEQ .done

    ; Set tile and increment counter
    STA $07F7,X
    REP #$20
    LDA !ram_map_counter : INC A : STA !ram_map_counter
    SEP #$20

  .done
    JML $90A987  ; resume original logic
}

mm_clear_boss_room_tiles:
{
    LDA #$2C1F
    LDX #$0000
  .loop
    STA $7EC63C,X
    STA $7EC67C,X
    STA $7EC6BC,X
    INX : INX : CPX #$000A : BMI .loop
    JML $90A80A
}


