!ram_tilemap_buffer = $7E5800

org $85FD00
print pc, " menu bank85 start"

wait_for_lag_frame_long:
    JSR $8136
    RTL

initialize_ppu_long:
    PHP : %a16()
    LDA $7E33EA : STA !ram_cgram_cache+$2E
    PLP
    JSR $8143
    RTL

restore_ppu_long:
    JSR $861A
    PHP : %a16()
    LDA !ram_cgram_cache+$2E : STA $7E33EA
    PLP
    RTL

play_music_long:
    JSR $8574
    RTL

maybe_trigger_pause_long:
    JSR $80FA
    RTL

print pc, " menu bank85 end"
warnpc $85FE00


org $B88000
print pc, " menu start"

cm_start:
{
    PHP
    PHB
    PHX
    PHY
    PHK : PLB

    %a8()
    STZ $420C
    LDA #$80 : STA $2100
    LDA #$A1 : STA $4200
    LDA #$09 : STA $2105
    LDA #$0F : STA $2100

    %a16()

    JSR cm_init

    JSL $82BE17               ; Cancel sound effects
    JSL initialize_ppu_long   ; Initialise PPU for message boxes

    JSR cm_transfer_custom_tileset
    JSR cm_transfer_custom_cgram
    JSR cm_draw         ; Initialise message box

    JSL play_music_long ; Play 2 lag frames of music and sound effects

    LDA $05E5 : STA !ram_cm_rng

    JSR cm_loop         ; Handle message box interaction

    LDA !ram_cm_rng : STA $05E5

    JSR cm_transfer_original_tileset
    JSR cm_transfer_original_cgram

    ; Update HUD (in case we added missiles etc.)
    LDA !ram_gametime_room : STA $C1
    LDA !ram_last_gametime_room : STA $C3
    JSL $809A79
    LDA $C1 : STA !ram_gametime_room
    LDA $C3 : STA !ram_last_gametime_room
    JSL $809B44
    JSR GameLoopExtras            ; check if game_loop_extras needs to be disabled

    ; I think the above subroutines erases some of infohud, so we make sure we redraw it.
    JSL ih_update_hud_code

    JSL restore_ppu_long          ; Restore PPU
    JSL $82BE2F                   ; Queue Samus movement sound effects
    JSL play_music_long           ; Play 2 lag frames of music and sound effects
    JSL maybe_trigger_pause_long  ; Maybe trigger pause screen or return save confirmation selection

    PLY
    PLX
    PLB
    PLP
    RTL
}

cm_init:
{
    ; Set up menu state
    LDA #$0000
    STA !ram_cm_stack_index
    STA !ram_cm_cursor_stack
    STA !ram_cm_leave
    STA !ram_load_preset
    STA !ram_cm_ctrl_mode
    STA !ram_cm_ctrl_timer
    STA $8F
    STA $8B
    LDA $05B6 : STA !ram_cm_input_counter

    LDA.w #MainMenu
    STA.l !ram_cm_menu_stack
    LDA.w #MainMenu>>16
    STA.l !ram_cm_menu_bank

    JSR cm_calculate_max
    JSR cm_set_etanks_and_reserve
}

cm_set_etanks_and_reserve:
{
    LDA $09C4 : JSR cm_divide_100 : STA !ram_cm_etanks
    LDA $09D4 : JSR cm_divide_100 : STA !ram_cm_reserve
    RTS
}


; ----------
; Drawing
; ----------

cm_transfer_custom_tileset:
{
    PHP
    %a16()
    LDA !ROOM_ID : CMP #$A59F : BEQ .kraid_vram

    ; Load custom vram to normal location
    %a8()
    LDA #$04 : STA $210C
    LDA #$80 : STA $2115 ; word-access, incr by 1
    LDX #$4000 : STX $2116 ; VRAM address (8000 in vram)
    LDX #cm_hud_table : STX $4302 ; Source offset
    LDA #cm_hud_table>>16 : STA $4304 ; Source bank
    LDX #$1000 : STX $4305 ; Size (0x10 = 1 tile)
    LDA #$01 : STA $4300 ; word, normal increment (DMA MODE)
    LDA #$18 : STA $4301 ; destination (VRAM write)
    LDA #$01 : STA $420B ; initiate DMA (channel 1)
    PLP
    RTS

  .kraid_vram
    ; Load custom vram to kraid location
    %a8()
    LDA #$02 : STA $210C
    LDA #$80 : STA $2115 ; word-access, incr by 1
    LDX #$2000 : STX $2116 ; VRAM address (4000 in vram)
    LDX #cm_hud_table : STX $4302 ; Source offset
    LDA #cm_hud_table>>16 : STA $4304 ; Source bank
    LDX #$0900 : STX $4305 ; Size (0x10 = 1 tile)
    LDA #$01 : STA $4300 ; word, normal increment (DMA MODE)
    LDA #$18 : STA $4301 ; destination (VRAM write)
    LDA #$01 : STA $420B ; initiate DMA (channel 1)
    PLP
    RTS
}

cm_transfer_original_tileset:
{
    PHP
    %a16()
    LDA !ROOM_ID : CMP #$A59F : BEQ .kraid_vram

    %a8()
    LDA !ram_minimap : CMP #$00 : BNE .minimap_vram

    ; Load in normal vram to normal location
    LDA #$04 : STA $210C
    LDA #$80 : STA $2115 ; word-access, incr by 1
    LDX #$4000 : STX $2116 ; VRAM address (8000 in vram)
    LDX #$B200 : STX $4302 ; Source offset
    LDA #$9A : STA $4304 ; Source bank
    LDX #$1000 : STX $4305 ; Size (0x10 = 1 tile)
    LDA #$01 : STA $4300 ; word, normal increment (DMA MODE)
    LDA #$18 : STA $4301 ; destination (VRAM write)
    LDA #$01 : STA $420B ; initiate DMA (channel 1)
    PLP
    RTS

  .kraid_vram
    ; Load in normal vram to kraid location
    %a8()
    LDA #$02 : STA $210C
    LDA #$80 : STA $2115 ; word-access, incr by 1
    LDX #$2000 : STX $2116 ; VRAM address (4000 in vram)
    LDX #$B200 : STX $4302 ; Source offset
    LDA #$9A : STA $4304 ; Source bank
    LDX #$1000 : STX $4305 ; Size (0x10 = 1 tile)
    LDA #$01 : STA $4300 ; word, normal increment (DMA MODE)
    LDA #$18 : STA $4301 ; destination (VRAM write)
    LDA #$01 : STA $420B ; initiate DMA (channel 1)
    PLP
    RTS

  .minimap_vram
    ; Load in minimap vram to normal location
    LDA #$04 : STA $210C
    LDA #$80 : STA $2115 ; word-access, incr by 1
    LDX #$4000 : STX $2116 ; VRAM address (8000 in vram)
    LDX #$D500 : STX $4302 ; Source offset
    LDA #$DF : STA $4304 ; Source bank
    LDX #$1000 : STX $4305 ; Size (0x10 = 1 tile)
    LDA #$01 : STA $4300 ; word, normal increment (DMA MODE)
    LDA #$18 : STA $4301 ; destination (VRAM write)
    LDA #$01 : STA $420B ; initiate DMA (channel 1)
    PLP
    RTS
}

cm_transfer_custom_cgram:
{
    ; $0A = Border & OFF   $7277
    ; $12 = Header         $48F3
    ; $1A = Num            $0000, $7FFF
    ; $32 = ON / Sel Num   $4376
    ; $34 = Selected item  $761F
    ; $3A = Sel Num        $0000, $761F
    PHP
    %a16()
    LDA $7EC00A : STA !ram_cgram_cache
    LDA $7EC00E : STA !ram_cgram_cache+2
    LDA $7EC012 : STA !ram_cgram_cache+4
    LDA $7EC014 : STA !ram_cgram_cache+6
    LDA $7EC016 : STA !ram_cgram_cache+8
    LDA $7EC01A : STA !ram_cgram_cache+10
    LDA $7EC01C : STA !ram_cgram_cache+12
    LDA $7EC032 : STA !ram_cgram_cache+14
    LDA $7EC034 : STA !ram_cgram_cache+16
    LDA $7EC036 : STA !ram_cgram_cache+18
    LDA $7EC03A : STA !ram_cgram_cache+20
    LDA $7EC03C : STA !ram_cgram_cache+22

    JSR PrepMenuPalette

    LDA #$0000 : STA $7EC000
    LDA !ram_custompalette_menuborder : STA $7EC00A
    LDA !ram_custompalette_menuheaderoutline : STA $7EC012
    LDA !ram_custompalette_menutext : STA $7EC014
    LDA !ram_custompalette_menubackground : STA $7EC016 : STA $7EC00E
    LDA !ram_custompalette_menunumoutline : STA $7EC01A
    LDA !ram_custompalette_menunumfill : STA $7EC01C
    LDA !ram_custompalette_menutoggleon : STA $7EC032
    LDA !ram_custompalette_menuseltext : STA $7EC034
    LDA !ram_custompalette_menuseltextbg : STA $7EC036
    LDA !ram_custompalette_menunumseloutline : STA $7EC03A
    LDA !ram_custompalette_menunumsel : STA $7EC03C

    JSL transfer_cgram_long
    PLP
    RTS
}

cm_transfer_original_cgram:
{
    PHP
    %a16()
    LDA !ram_cgram_cache : STA $7EC00A
    LDA !ram_cgram_cache+2 : STA $7EC00E
    LDA !ram_cgram_cache+4 : STA $7EC012
    LDA !ram_cgram_cache+6 : STA $7EC014
    LDA !ram_cgram_cache+8 : STA $7EC016
    LDA !ram_cgram_cache+10 : STA $7EC01A
    LDA !ram_cgram_cache+12 : STA $7EC01C
    LDA !ram_cgram_cache+14 : STA $7EC032
    LDA !ram_cgram_cache+16 : STA $7EC034
    LDA !ram_cgram_cache+18 : STA $7EC036
    LDA !ram_cgram_cache+20 : STA $7EC03A
    LDA !ram_cgram_cache+22 : STA $7EC03C

    JSL transfer_cgram_long
    PLP
    RTS
}

PrepMenuPalette:
{
    LDA !sram_custompalette_profile : ASL : TAX
    BEQ .customPalette
    LDA.w PaletteProfileTables,X : STA $12

    LDY #$0000 : LDA ($12),Y : STA !ram_custompalette_menuborder
    LDY #$0002 : LDA ($12),Y : STA !ram_custompalette_menuheaderoutline
    LDY #$0004 : LDA ($12),Y : STA !ram_custompalette_menutext
    LDY #$0006 : LDA ($12),Y : STA !ram_custompalette_menubackground
    LDY #$0008 : LDA ($12),Y : STA !ram_custompalette_menunumoutline
    LDY #$000A : LDA ($12),Y : STA !ram_custompalette_menunumfill
    LDY #$000C : LDA ($12),Y : STA !ram_custompalette_menutoggleon
    LDY #$000E : LDA ($12),Y : STA !ram_custompalette_menuseltext
    LDY #$0010 : LDA ($12),Y : STA !ram_custompalette_menuseltextbg
    LDY #$0012 : LDA ($12),Y : STA !ram_custompalette_menunumseloutline
    LDY #$0014 : LDA ($12),Y : STA !ram_custompalette_menunumsel
    RTS
    
  .customPalette
    LDA !sram_custompalette_menuborder : STA !ram_custompalette_menuborder
    LDA !sram_custompalette_menuheaderoutline : STA !ram_custompalette_menuheaderoutline
    LDA !sram_custompalette_menutext : STA !ram_custompalette_menutext
    LDA !sram_custompalette_menubackground : STA !ram_custompalette_menubackground
    LDA !sram_custompalette_menunumoutline : STA !ram_custompalette_menunumoutline
    LDA !sram_custompalette_menunumfill : STA !ram_custompalette_menunumfill
    LDA !sram_custompalette_menutoggleon : STA !ram_custompalette_menutoggleon
    LDA !sram_custompalette_menuseltext : STA !ram_custompalette_menuseltext
    LDA !sram_custompalette_menuseltextbg : STA !ram_custompalette_menuseltextbg
    LDA !sram_custompalette_menunumseloutline : STA !ram_custompalette_menunumseloutline
    LDA !sram_custompalette_menunumsel : STA !ram_custompalette_menunumsel
    RTS

PaletteProfileTables:
    dw #CustomProfileTable        ; 0
    dw #TwitchProfileTable        ; 1
    dw #DefaultProfileTable       ; 2
    dw #FirebatProfileTable       ; 3
    dw #wardrinkerProfileTable    ; 4
    dw #mm2ProfileTable           ; 5
    dw #ptoilProfileTable         ; 6
    dw #ZohdinProfileTable        ; 7
    dw #DarkXoaProfileTable       ; 8
    dw #MelonaxProfileTable       ; 9
    dw #TopsyTurveProfileTable    ; A
    dw #OSTProfileTable           ; B
    dw #GreyProfileTable          ; C
    dw #RedProfileTable           ; D
    dw #PurpleProfileTable        ; E
    dw #HUDProfileTable           ; F
    dw #$0000

; border, headeroutline, text, background, numoutline, numfill, toggleon, seltext, seltextbg, numseloutline, numsel
CustomProfileTable: ; custom always first
    dw $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000

TwitchProfileTable:
    dw $550D, $550D, $7FFF, $0000, $0000, $7FFF, $550D, $550D, $0000, $550D, $7FFF

DefaultProfileTable:
    dw $7277, $48F3, $7FFF, $0000, $0000, $7FFF, $4376, $761F, $0000, $0000, $761F

FirebatProfileTable:
    dw $000E, $000E, $0A20, $0000, $0A20, $0002, $0680, $000F, $0005, $0A20, $000F

wardrinkerProfileTable:
    dw $7277, $7FFF, $7A02, $0000, $0000, $9200, $7277, $7F29, $0000, $0000, $7F29

mm2ProfileTable:
    dw $001A, $0000, $7C80, $0000, $0000, $7FFF, $03E0, $7F44, $0842, $0000, $7FFF

ptoilProfileTable:
    dw $5CAA, $14A5, $01EF, $0000, $0000, $5294, $4376, $03FF, $0000, $0000, $7FFF

ZohdinProfileTable:
    dw $7BFF, $0402, $0300, $0060, $0100, $9700, $7B64, $7BFF, $94A6, $2051, $09BF

DarkXoaProfileTable:
    dw $24C4, $45A8, $24C4, $0000, $0000, $24C4, $45A8, $45A8, $0000, $1505, $45A8

MelonaxProfileTable:
    dw $7FFF, $0000, $3DEF, $0C63, $0000, $7FFF, $266B, $3DFE, $0C63, $0000, $266B

TopsyTurveProfileTable:
    dw $7264, $7264, $7FFF, $0000, $0000, $7FFF, $7264, $7264, $0000, $0000, $7264

OSTProfileTable:
    dw $7FFF, $7FFF, $0010, $0000, $0010, $7FFF, $001F, $001E, $0000, $7FFF, $001E

GreyProfileTable:
    dw $0012, $1CE7, $3DEF, $0C63, $1CE7, $3DEF, $0EE3, $0012, $0C63, $1CE7, $3DEF

RedProfileTable:
    dw $0010, $0000, $0010, $0000, $0010, $0000, $001F, $001F, $0000, $001F, $0010

PurpleProfileTable:
    dw $602F, $0000, $602F, $0000, $0000, $602F, $0338, $0338, $0000, $602F, $0338

HUDProfileTable:
    dw $3D46, $48FB, $7FFF, $0000, $44E5, $7FFF, $4A52, $318C, $0000, $02DF, $001F
}

cm_draw:
{
    PHP
    %ai16()
    JSR cm_tilemap_clear
    JSR cm_tilemap_bg
    JSR cm_tilemap_menu
    JSR cm_tilemap_transfer
    PLP
    RTS
}

cm_tilemap_clear:
{
    ; top left corner  = $042
    ; top right corner = $07C
    ; bot left corner  = $682
    ; bot right corner = $6BC
	; Empty out !ram_tilemap_buffer
    LDX #$07FE
    LDA #$000E

-   STA !ram_tilemap_buffer,X
    DEX #2 : BPL -
    RTS
}

cm_tilemap_bg:
{
    ; Vertical edges
    LDX #$0000
    LDY #$0019

-   LDA.w #$647A : STA !ram_tilemap_buffer+$082,X
    LDA.w #$247A : STA !ram_tilemap_buffer+$0BC,X
    TXA : CLC : ADC #$0040 : TAX
    DEY : BPL -

    ; Horizontal edges
    LDX.w #$0000
    LDY.w #$001B

-   LDA.w #$A47B : STA !ram_tilemap_buffer+$044,X
    LDA.w #$247B : STA !ram_tilemap_buffer+$704,X

    INX #2
    DEY : BPL -

    ; Interior
    ; background is optional
    LDA !sram_menu_background : BNE .fill_interior
    ; fill if paused
    LDA !GAMEMODE : CMP #$000C : BMI .check_ceres
    BEQ .fill_interior : CMP #$0012 : BMI .fill_interior
    ; fill if Ceres
  .check_ceres
    LDA $079F : CMP #$0006 : BMI .done
    ; transparent otherwise ------^
  .fill_interior
    LDX.w #$0000
    LDY.w #$001B
    LDA.w #$281F

      .interior_loop
    STA !ram_tilemap_buffer+$004,X
    STA !ram_tilemap_buffer+$084,X
    STA !ram_tilemap_buffer+$0C4,X
    STA !ram_tilemap_buffer+$104,X
    STA !ram_tilemap_buffer+$144,X
    STA !ram_tilemap_buffer+$184,X
    STA !ram_tilemap_buffer+$1C4,X
    STA !ram_tilemap_buffer+$204,X
    STA !ram_tilemap_buffer+$244,X
    STA !ram_tilemap_buffer+$284,X
    STA !ram_tilemap_buffer+$2C4,X
    STA !ram_tilemap_buffer+$304,X
    STA !ram_tilemap_buffer+$344,X
    STA !ram_tilemap_buffer+$384,X
    STA !ram_tilemap_buffer+$3C4,X
    STA !ram_tilemap_buffer+$404,X
    STA !ram_tilemap_buffer+$444,X
    STA !ram_tilemap_buffer+$484,X
    STA !ram_tilemap_buffer+$4C4,X
    STA !ram_tilemap_buffer+$504,X
    STA !ram_tilemap_buffer+$544,X
    STA !ram_tilemap_buffer+$584,X
    STA !ram_tilemap_buffer+$5C4,X
    STA !ram_tilemap_buffer+$604,X
    STA !ram_tilemap_buffer+$644,X
    STA !ram_tilemap_buffer+$684,X
    STA !ram_tilemap_buffer+$6C4,X

    INX #2
    DEY : BPL .interior_loop

  .done
    RTS
}

cm_tilemap_menu:
{
    ; $00[0x4] = menu indices
    ; $04[0x4] = current menu item index
    ; $0E[0x2] = palette ORA for tilemap entry (for indicating selected menu)
    LDX !ram_cm_stack_index
    LDA !ram_cm_menu_stack,X : STA $00
    LDA !ram_cm_menu_bank : STA $02
    LDA !ram_cm_menu_bank : STA $06

    LDY #$0000
  .loop
    TYA : CMP !ram_cm_cursor_stack,X : BEQ .selected
    LDA #$0000
    BRA .continue

  .selected
    LDA #$0010

  .continue
    STA $0E

    LDA [$00],Y : BEQ .header
    CMP #$FFFF : BEQ .blank
    STA $04

    PHY : PHX

    ; X = action index (action type)
    LDA [$04] : TAX

    ; $02 points to data after the action type index
    INC $04 : INC $04

    JSR (cm_draw_action_table,X)

    PLX : PLY

  .blank
    ; skip drawing blank lines
    INY : INY
    BRA .loop

  .header
    ; Draw menu header
    STZ $0E
    TYA : CLC : ADC $00 : INC #2 : STA $04
    LDX #$00C6
    JSR cm_draw_text

    ; Optional footer
    TYA : CLC : ADC $04 : INC : STA $04
    LDA [$04] : CMP #$F007 : BNE .done

    INC $04 : INC $04 : STZ $0E
    LDX #$0686
    JSR cm_draw_text
    RTS

  .done
    DEC $04 : DEC $04
    RTS
}

cm_tilemap_transfer:
{
    JSL wait_for_lag_frame_long  ; Wait for lag frame

    REP #$20
    LDA #$5800
    STA $2116
    LDA #$1801
    STA $4310
    LDA.w #!ram_tilemap_buffer
    STA $4312
    LDA.w #!ram_tilemap_buffer>>16
    STA $4314
    LDA #$0800
    STA $4315
    STZ $4317
    STZ $4319
    SEP #$20
    LDA #$80
    STA $2115
    LDA #$02
    STA $420B
    JSL $808F0C
    JSL $8289EF
    REP #$20
    RTS
}

macro item_index_to_vram_index()
    ; Find screen position from Y (item number)
    TYA : ASL #5
    CLC : ADC #$0146 : TAX
endmacro

cm_draw_action_table:
{
    dw draw_toggle
    dw draw_toggle_bit
    dw draw_jsr
    dw draw_numfield
    dw draw_choice
    dw draw_ctrl_shortcut
    dw draw_numfield_hex
    dw draw_numfield_word
    dw draw_toggle_inverted
    dw draw_numfield_color
    dw draw_numfield_hex_word
    dw draw_numfield_sound
    dw draw_controller_input

    draw_toggle:
    {
        ; grab the memory address (long)
        LDA [$04] : INC $04 : INC $04 : STA $08
        LDA [$04] : INC $04 : STA $0A

        ; grab the toggle value
        LDA [$04] : AND #$00FF : INC $04 : STA $0C

        ; increment past JSR
        INC $04 : INC $04

        ; Draw the text
        %item_index_to_vram_index()
        PHX : JSR cm_draw_text : PLX

        ; Set position for ON/OFF
        TXA : CLC : ADC #$002E : TAX

        %a8()
        ; set palette
        LDA $0E
        STA !ram_tilemap_buffer+1,X
        STA !ram_tilemap_buffer+3,X
        STA !ram_tilemap_buffer+5,X

        ; grab the value at that memory address
        LDA [$08] : CMP $0C : BEQ .checked

        ; Off
        %a16()
        LDA #$244B : STA !ram_tilemap_buffer+0,X
        LDA #$244D : STA !ram_tilemap_buffer+2,X
        LDA #$244D : STA !ram_tilemap_buffer+4,X
        RTS

      .checked
        ; On
        %a16()
        LDA #$384B : STA !ram_tilemap_buffer+2,X
        LDA #$384C : STA !ram_tilemap_buffer+4,X
        RTS
    }

    draw_toggle_inverted:
    {
        ; grab the memory address (long)
        LDA [$04] : INC $04 : INC $04 : STA $08
        LDA [$04] : INC $04 : STA $0A

        ; grab the toggle value
        LDA [$04] : AND #$00FF : INC $04 : STA $0C

        ; increment past JSR
        INC $04 : INC $04

        ; Draw the text
        %item_index_to_vram_index()
        PHX : JSR cm_draw_text : PLX

        ; Set position for ON/OFF
        TXA : CLC : ADC #$002E : TAX

        %a8()
        ; set palette
        LDA $0E
        STA !ram_tilemap_buffer+1,X
        STA !ram_tilemap_buffer+3,X
        STA !ram_tilemap_buffer+5,X

        ; grab the value at that memory address
        LDA [$08] : CMP $0C : BNE .checked

        ; Off
        %a16()
        LDA #$244B : STA !ram_tilemap_buffer+0,X
        LDA #$244D : STA !ram_tilemap_buffer+2,X
        LDA #$244D : STA !ram_tilemap_buffer+4,X
        RTS

      .checked
        ; On
        %a16()
        LDA #$384B : STA !ram_tilemap_buffer+2,X
        LDA #$384C : STA !ram_tilemap_buffer+4,X
        RTS
    }

    draw_toggle_bit:
    {
        ; grab the memory address (long)
        LDA [$04] : INC $04 : INC $04 : STA $08
        LDA [$04] : INC $04 : STA $0A

        ; grab bitmask
        LDA [$04] : INC $04 : INC $04 : STA $0C

        ; increment past JSR
        INC $04 : INC $04

        ; Draw the text
        %item_index_to_vram_index()
        PHX : JSR cm_draw_text : PLX

        ; Set position for ON/OFF
        TXA : CLC : ADC #$002E : TAX

        ; grab the value at that memory address
        LDA [$08] : AND $0C : BNE .checked

        ; Off
        LDA #$244B : STA !ram_tilemap_buffer+0,X
        LDA #$244D : STA !ram_tilemap_buffer+2,X
        LDA #$244D : STA !ram_tilemap_buffer+4,X
        RTS

      .checked
        ; On
        %a16()
        LDA #$384B : STA !ram_tilemap_buffer+2,X
        LDA #$384C : STA !ram_tilemap_buffer+4,X
        RTS
    }

    draw_jsr:
    {
        ; skip JSR address
        INC $04 : INC $04

        ; skip argument
        INC $04 : INC $04

        ; draw text normally
        %item_index_to_vram_index()
        JSR cm_draw_text
        RTS
    }

    draw_numfield:
    {
        ; grab the memory address (long)
        LDA [$04] : INC $04 : INC $04 : STA $08
        LDA [$04] : INC $04 : STA $0A

        ; skip bounds and increment values
        INC $04 : INC $04 : INC $04; : INC $04

        ; increment past JSR
        INC $04 : INC $04

        ; Draw the text
        %item_index_to_vram_index()
        PHX : JSR cm_draw_text : PLX

        ; set position for the number
        TXA : CLC : ADC #$002E : TAX
        LDA [$08] : AND #$00FF : JSR cm_hex2dec
        ; Clear out the area (black tile)
        LDA #$281F : STA !ram_tilemap_buffer+0,X
                     STA !ram_tilemap_buffer+2,X
                     STA !ram_tilemap_buffer+4,X

        ; Set palette
        %a8()
        LDA.b #$24 : ORA $0E : STA $0F
        LDA.b #$70 : STA $0E
        ; Draw numbers
        %a16()
        ; ones
        LDA !ram_hex2dec_third_digit : CLC : ADC $0E : STA !ram_tilemap_buffer+4,X
        ; tens
        LDA !ram_hex2dec_second_digit : ORA !ram_hex2dec_first_digit : BEQ .done
        LDA !ram_hex2dec_second_digit : CLC : ADC $0E : STA !ram_tilemap_buffer+2,X
        LDA !ram_hex2dec_first_digit : BEQ .done
        CLC : ADC $0E : STA !ram_tilemap_buffer,X
      .done
        RTS
    }

    draw_numfield_word:
    {
        ; grab the memory address (long)
        LDA [$04] : INC $04 : INC $04 : STA $08
        LDA [$04] : INC $04 : STA $0A

        ; skip bounds and increment values
        INC $04 : INC $04 : INC $04; : INC $04
        INC $04 : INC $04 : INC $04; : INC $04

        ; increment past JSR
        INC $04 : INC $04

        ; Draw the text
        %item_index_to_vram_index()
        PHX : JSR cm_draw_text : PLX

        ; set position for the number
        TXA : CLC : ADC #$002C : TAX

        LDA [$08] : JSR cm_hex2dec

        ; Clear out the area (black tile)
        LDA #$281F : STA !ram_tilemap_buffer+0,X
                     STA !ram_tilemap_buffer+2,X
                     STA !ram_tilemap_buffer+4,X
                     STA !ram_tilemap_buffer+6,X

        ; Set palette
        %a8()
        LDA.b #$24 : ORA $0E : STA $0F
        LDA.b #$70 : STA $0E

        ; Draw numbers
        %a16()
        ; ones
        LDA !ram_hex2dec_third_digit : CLC : ADC $0E : STA !ram_tilemap_buffer+6,X

        ; tens
        LDA !ram_hex2dec_second_digit : ORA !ram_hex2dec_first_digit
        ORA !ram_hex2dec_rest : BEQ .done
        LDA !ram_hex2dec_second_digit : CLC : ADC $0E : STA !ram_tilemap_buffer+4,X

        LDA !ram_hex2dec_first_digit : ORA !ram_hex2dec_rest : BEQ .done
        LDA !ram_hex2dec_first_digit : CLC : ADC $0E : STA !ram_tilemap_buffer+2,X

        LDA !ram_hex2dec_rest : BEQ .done
        CLC : ADC $0E : STA !ram_tilemap_buffer,X

      .done
        RTS
    }

    draw_numfield_hex:
    draw_numfield_sound:
    {
        ; grab the memory address (long)
        LDA [$04] : INC $04 : INC $04 : STA $08
        LDA [$04] : INC $04 : STA $0A

        ; skip bounds and increment values
        INC $04 : INC $04 : INC $04; : INC $04

        ; increment past JSR
        INC $04 : INC $04

        ; Draw the text
        %item_index_to_vram_index()
        PHX : JSR cm_draw_text : PLX

        ; set position for the number
        TXA : CLC : ADC #$0030 : TAX

        LDA [$08] : AND #$00FF : STA !ram_tmp_2

        ; Clear out the area (black tile)
        LDA #$281F : STA !ram_tilemap_buffer+0,X
                     STA !ram_tilemap_buffer+2,X

        ; Draw numbers
        ; (00X0)
        LDA !ram_tmp_2 : AND #$00F0 : LSR #3 : TAY
        LDA.w HexMenuGFXTable,Y : STA !ram_tilemap_buffer,X
        
        ; (000X)
        LDA !ram_tmp_2 : AND #$000F : ASL : TAY
        LDA.w HexMenuGFXTable,Y : STA !ram_tilemap_buffer+2,X

      .done
        RTS
    }

    draw_numfield_hex_word:
    {
        ; grab the memory address (long)
        LDA [$04] : INC $04 : INC $04 : STA $08
        LDA [$04] : INC $04 : STA $0A

        ; Draw the text
        %item_index_to_vram_index()
        PHX : JSR cm_draw_text : PLX

        ; set position for the number
        TXA : CLC : ADC #$002C : TAX

        LDA [$08] : STA !ram_tmp_2

        ; Clear out the area (black tile)
        LDA #$281F : STA !ram_tilemap_buffer+0,X
                     STA !ram_tilemap_buffer+2,X
                     STA !ram_tilemap_buffer+4,X
                     STA !ram_tilemap_buffer+6,X

        ; Draw numbers
        ; (X000)
        LDA !ram_tmp_2 : AND #$F000 : XBA : LSR #3 : TAY
        LDA.w HexMenuGFXTable,Y : STA !ram_tilemap_buffer,X
        
        ; (0X00)
        LDA !ram_tmp_2 : AND #$0F00 : XBA : ASL : TAY
        LDA.w HexMenuGFXTable,Y : STA !ram_tilemap_buffer+2,X

        ; (00X0)
        LDA !ram_tmp_2 : AND #$00F0 : LSR #3 : TAY
        LDA.w HexMenuGFXTable,Y : STA !ram_tilemap_buffer+4,X
        
        ; (000X)
        LDA !ram_tmp_2 : AND #$000F : ASL : TAY
        LDA.w HexMenuGFXTable,Y : STA !ram_tilemap_buffer+6,X

      .done
        RTS
    }

    draw_numfield_color:
    {
        ; grab the memory address (long)
        LDA [$04] : INC $04 : INC $04 : STA $08
        LDA [$04] : INC $04 : STA $0A

        ; increment past JSR
        INC $04 : INC $04

        ; Draw the text
        %item_index_to_vram_index()
        PHX : JSR cm_draw_text : PLX

        ; set position for the number
        TXA : CLC : ADC #$0030 : TAX

        LDA [$08] : AND #$00FF : STA !ram_tmp_2

        ; Clear out the area (black tile)
        LDA #$281F : STA !ram_tilemap_buffer+0,X
                     STA !ram_tilemap_buffer+2,X

        ; Draw numbers
        ; (00X0)
        LDA !ram_tmp_2 : AND #$001E : TAY
        LDA.w HexMenuGFXTable,Y : STA !ram_tilemap_buffer,X

        ; (000X)
        LDA !ram_tmp_2 : AND #$0001 : ASL #4 : STA $0E
        LDA !ram_tmp_2 : AND #$001C : LSR : CLC : ADC $0E : TAY
        LDA.w HexMenuGFXTable,Y : STA !ram_tilemap_buffer+2,X

      .done
        RTS
    }

    draw_choice:
    {
        ; $04[0x3] = address
        ; $08[0x2] = jsr target

        ; grab the memory address (long)
        LDA [$04] : INC $04 : INC $04 : STA $08
        LDA [$04] : INC $04 : STA $0A

        ; grab JSR target
        LDA [$04] : INC $04 : INC $04 : STA $0C

        ; Draw the text first
        %item_index_to_vram_index()
        PHX : JSR cm_draw_text : PLX

        ; set position for choice
        TXA : CLC : ADC #$001E : TAX

        LDY #$0000
        LDA #$0000

        ; grab the value at that memory address
        LDA [$08] : TAY

        ; find the correct text that should be drawn (the selected choice)
        INY : INY ; uh, skipping the first text that we already drew..
      .loop_choices
        DEY : BEQ .found

      .loop_text
        LDA [$04] : %a16() : INC $04 : %a8()
        CMP.b #$FF : BEQ .loop_choices
        BRA .loop_text

      .found
        %a16()
        JSR cm_draw_text

        %a16()
        RTS
    }

    draw_ctrl_shortcut:
    {
        LDA [$04] : INC $04 : INC $04 : STA $08
        LDA [$04] : STA $0A : INC $04

        %item_index_to_vram_index()
        PHX
        JSR cm_draw_text
        PLA : CLC : ADC #$0022 : TAX

        LDA [$08]
        JSR menu_ctrl_input_display

        RTS
    }

    draw_controller_input:
    {
        ; grab the memory address (long)
        LDA [$04] : INC $04 : INC $04 : STA $08
        STA !ram_cm_ctrl_assign
        LDA [$04] : INC $04 : STA $0A

        ; grab JSR target
        LDA [$04] : INC $04 : INC $04 : STA $0C

        ; skip JSR argument
        INC $04 : INC $04

        ; Draw the text
        %item_index_to_vram_index()
        PHX : JSR cm_draw_text : PLX

        ; set position for the input
        TXA : CLC : ADC #$0020 : TAX

        LDA ($08) : AND #$E0F0 : BEQ .unbound

        ; Draw input
        TAY : AND #$0080 : BEQ + : LDY #$0000 : BRA .draw
+       TYA : AND #$8000 : BEQ + : LDY #$0002 : BRA .draw
+       TYA : AND #$0040 : BEQ + : LDY #$0004 : BRA .draw
+       TYA : AND #$4000 : BEQ + : LDY #$0006 : BRA .draw
+       TYA : AND #$0020 : BEQ + : LDY #$0008 : BRA .draw
+       TYA : AND #$0010 : BEQ + : LDY #$000A : BRA .draw
+       TYA : AND #$2000 : BEQ .unbound : LDY #$000C

      .draw
        LDA.w CtrlMenuGFXTable,Y : STA !ram_tilemap_buffer,X
        RTS

      .unbound
        LDA #$281F : STA !ram_tilemap_buffer,X
        RTS

    CtrlMenuGFXTable:
        ;  A      B      X      Y      L      R      Select
        ;  0080   8000   0040   4000   0020   0010   2000
        dw $288F, $2887, $288E, $2886, $288D, $288C, $2885
    }
}

cm_draw_text:
    ; X = pointer to tilemap area (STA !ram_tilemap_buffer,X)
    ; $04[0x3] = address
  %a8()
    LDY #$0000
    ; terminator
    LDA [$04],Y : INY : CMP #$FF : BEQ .end
    ; ORA with palette info
    ORA $0E : STA $0E

  .loop
    LDA [$04],Y : CMP #$FF : BEQ .end           ; terminator
    STA !ram_tilemap_buffer,X : INX             ; tile
    LDA $0E : STA !ram_tilemap_buffer,X : INX   ; palette
    INY : JMP .loop

  .end
    %a16()
    RTS

; --------------
; Input Display
; --------------

menu_ctrl_input_display:
{
    ; X = pointer to tilemap area (STA !ram_tilemap_buffer,X)
    ; A = Controller word
    JSR menu_ctrl_clear_input_display

    XBA
    LDY #$0000
  .loop
    PHA
    BIT #$0001 : BEQ .no_draw

    TYA : CLC : ADC #$0080
    XBA : ORA $0E : XBA
    STA !ram_tilemap_buffer,X : INX : INX

  .no_draw
    PLA
    INY : LSR : BNE .loop

  .done
    RTS
}


menu_ctrl_clear_input_display:
{
    ; X = pointer to tilemap area
    PHA
    LDA #$281F
    STA !ram_tilemap_buffer+0,X
    STA !ram_tilemap_buffer+2,X
    STA !ram_tilemap_buffer+4,X
    STA !ram_tilemap_buffer+6,X
    STA !ram_tilemap_buffer+8,X
    STA !ram_tilemap_buffer+10,X
    STA !ram_tilemap_buffer+12,X
    STA !ram_tilemap_buffer+14,X
    STA !ram_tilemap_buffer+16,X
    PLA
    RTS
}


; ---------
; Logic
; ---------

cm_loop:
{
  .inputLoop
    %ai16()

    JSL $808111 ; Let the RNG flow

    JSL wait_for_lag_frame_long  ; Wait for lag frame

    JSL $808F0C ; Music queue
    JSL $8289EF ; Sound fx queue

    LDA !ram_cm_leave : BEQ +
    JMP .done

+   LDA !ram_cm_ctrl_mode : BEQ +
    JSR cm_ctrl_mode
    BRA .inputLoop

; repeating the cgram transfer for flash carts...
    ; don't do it if paused
;    LDA $7E0998 : CMP #$000C : BMI .check_stack
;    CMP #$0012 : BPL .check_stack
;    BRA .skip_cgram

;  .check_stack
    ; this is how I find out if you're on the customization menu
;    LDA !ram_cm_cursor_stack : CMP #$0014 : BNE .update_cgram
    ; ensure that "Customize Menu Palette" is the second option in the "Extras" menu
;    LDA !ram_cm_cursor_stack+2 : CMP #$0002 : BEQ .skip_cgram

  .update_cgram
+   JSR cm_transfer_original_cgram
    JSR cm_transfer_custom_cgram

  .skip_cgram
    JSR cm_get_inputs : STA !ram_cm_controller : BEQ .inputLoop

    BIT #$0080 : BEQ + : JMP .pressedA ; more wiggle room with branch limits...
+   BIT #$8000 : BEQ + : JMP .pressedB
;    BIT #$0040 : BNE .pressedX
+   BIT #$4000 : BNE .pressedY
    BIT #$2000 : BNE .pressedSelect
    BIT #$1000 : BNE .pressedStart
    BIT #$0800 : BNE .pressedUp
    BIT #$0400 : BNE .pressedDown
    BIT #$0100 : BNE .pressedRight
    BIT #$0200 : BNE .pressedLeft
    BIT #$0020 : BNE .pressedL
    BIT #$0010 : BNE .pressedR

    JMP .inputLoop

  .pressedB
    JSR cm_go_back
    JSR cm_calculate_max
    BRA .redraw

  .pressedDown
    LDA #$0002
    JSR cm_move
    BRA .redraw

  .pressedUp
    LDA #$FFFE
    JSR cm_move
    BRA .redraw

  .pressedL
    LDX !ram_cm_stack_index
    LDA #$0000 : STA !ram_cm_cursor_stack,X
    %sfxmove()
    BRA .redraw

  .pressedR
    LDX !ram_cm_stack_index
    LDA !ram_cm_cursor_max : DEC #2 : STA !ram_cm_cursor_stack,X
    %sfxmove()
    BRA .redraw

  .pressedA
;  .pressedX
  .pressedY
  .pressedLeft
  .pressedRight
    JSR cm_execute
    BRA .redraw

  .pressedStart
  .pressedSelect
    BRA .done

  .redraw
    JSR cm_draw
    JMP .inputLoop

  .done
    RTS    

  .restartLoop
    JMP .inputLoop
}

cm_ctrl_mode:
{
    JSL $809459
    LDA $8B

    %a8() : LDA #$28 : STA $0E : %a16()

    LDA $8B : BEQ .clear_and_draw
    CMP !ram_cm_ctrl_last_input : BNE .clear_and_draw

    ; Holding an input for more than one second
    LDA !ram_cm_ctrl_timer : INC : STA !ram_cm_ctrl_timer : CMP.w #0060 : BNE .next_frame

    LDA $8B : STA [$C5]
    JSL GameModeExtras
    %sfxstatue()
    BRA .exit

  .clear_and_draw
    STA !ram_cm_ctrl_last_input
    LDA #$0000 : STA !ram_cm_ctrl_timer

    ; Put text cursor in X
    LDX !ram_cm_stack_index
    LDA !ram_cm_cursor_stack,X : ASL #5 : CLC : ADC #$0168 : TAX

    ; Input display
    LDA $8B
    JSR menu_ctrl_input_display
    JSR cm_tilemap_transfer

  .next_frame
    RTS

  .exit
    LDA #$0000
    STA !ram_cm_ctrl_last_input
    STA !ram_cm_ctrl_mode
    STA !ram_cm_ctrl_timer
    JSR cm_draw
    RTS
}

cm_go_back:
{
    ; make sure next time we go to a submenu, we start on the first line.
    LDX !ram_cm_stack_index
    LDA #$0000 : STA !ram_cm_cursor_stack,X

    ; make sure we dont set a negative number
    LDA !ram_cm_stack_index : DEC #2 : BPL .done

    ; leave menu 
    LDA #$0001 : STA !ram_cm_leave

    LDA #$0000
  .done
    STA !ram_cm_stack_index    
    LDA !ram_cm_stack_index
    BNE .end
    LDA.w #MainMenu>>16       ; Reset submenu bank when back at main menu
    STA.l !ram_cm_menu_bank

  .end
    %sfxgoback()
    RTS
}

cm_calculate_max:
{
    LDX !ram_cm_stack_index
    LDA !ram_cm_menu_stack,X : STA $00
    LDA !ram_cm_menu_bank : STA $02

    LDX #$0000
  .loop
    LDA [$00] : BEQ .done
    INC $00 : INC $00
    INX #2
    BRA .loop

  .done
    TXA : STA !ram_cm_cursor_max
    RTS
}

cm_get_inputs:
{
    ; Make sure we don't read joysticks twice in the same frame
    LDA $05B6 : CMP !ram_cm_input_counter : PHP : STA !ram_cm_input_counter : PLP : BNE +

    JSL $809459 ; Read controller input

+   LDA $8F : BEQ .check_holding

    ; Initial delay of $0E frames
    LDA #$000E : STA !ram_cm_input_timer

    ; Return the new input
    LDA $8F
    RTS

  .check_holding
    ; Check if we're holding the dpad
    LDA $8B : AND #$0F00 : BEQ .noinput

    ; Decrement delay timer and check if it's zero
    LDA !ram_cm_input_timer : DEC : STA !ram_cm_input_timer : BNE .noinput

    ; Set new delay to two frames and return the input we're holding
    LDA !sram_cm_scroll_delay : STA !ram_cm_input_timer
    LDA $8B : AND #$4F00 : ORA !IH_INPUT_HELD
    RTS

  .noinput
    LDA $8B : AND #$0000 ; allow Y to pass
    RTS
}

cm_move:
{
    STA $12
    LDX !ram_cm_stack_index
    CLC : ADC !ram_cm_cursor_stack,X : BPL .positive
    LDA !ram_cm_cursor_max : DEC #2 : BRA .inBounds

  .positive
    CMP !ram_cm_cursor_max : BNE .inBounds
    LDA #$0000

  .inBounds
    STA !ram_cm_cursor_stack,X : TAY

    ; check for blank menu line ($FFFF)
    LDA [$00],Y : CMP #$FFFF : BNE .end

    LDA $12 : BRA cm_move

  .end
    %sfxmove()
    RTS
}


; --------
; Execute
; --------

cm_execute:
{
    ; $00 = submenu item
    LDX !ram_cm_stack_index
    LDA !ram_cm_menu_stack,X : STA $00
    LDA !ram_cm_menu_bank : STA $02
    LDA !ram_cm_cursor_stack,X : TAY
    LDA [$00],Y : STA $00

    ; Increment past the action index
    LDA [$00] : INC $00 : INC $00 : TAX

    ; Safety net incase blank line selected
    CPX #$FFFF : BEQ +

    ; Execute action
    JSR (cm_execute_action_table,X)
+   RTS
}

cm_execute_action_table:
{
    dw execute_toggle
    dw execute_toggle_bit
    dw execute_jsr
    dw execute_numfield
    dw execute_choice
    dw execute_ctrl_shortcut
    dw execute_numfield_hex
    dw execute_numfield_word
    dw execute_toggle
    dw execute_numfield_color
    dw execute_numfield_hex_word
    dw execute_numfield_sound
    dw execute_controller_input

    execute_toggle:
    {
        ; Grab address
        LDA [$00] : INC $00 : INC $00 : STA $04
        LDA [$00] : INC $00 : STA $06

        ; Grab toggle value
        LDA [$00] : INC $00 : AND #$00FF : STA $08

        ; Grab JSR target
        LDA [$00] : INC $00 : INC $00 : STA $0A

        %a8()
        LDA [$04] : CMP $08 : BEQ .toggleOff

        LDA $08 : STA [$04]
        BRA .jsr

      .toggleOff
        LDA #$00 : STA [$04]

      .jsr
        %a16()
        LDA $0A : BEQ .end
        LDA [$04]
        LDX #$0000
        JSR ($000A,X)

      .end
        %sfxtoggle()
        RTS
    }

    execute_toggle_bit:
    {
        ; Load the address
        LDA [$00] : INC $00 : INC $00 : STA $04
        LDA [$00] : INC $00 : STA $06

        ; Load which bit(s) to toggle
        LDA [$00] : INC $00 : INC $00 : STA $08

        ; Load JSR target
        LDA [$00] : INC $00 : INC $00 : STA $0A

        ; Toggle the bit
        LDA [$04] : EOR $08 : STA [$04]

        LDA $0A : BEQ .end

        LDA [$04]
        LDX #$0000
        JSR ($000A,X)

      .end
        %sfxtoggle()
        RTS
    }

    execute_jsr:
    {
        ; <, > and X should do nothing here
        ; also ignore input held flag
        LDA !ram_cm_controller : BIT #$0341 : BNE .end

        ; $02 = JSR target
        LDA [$00] : INC $00 : INC $00 : STA $04

        ; Y = Argument
        LDA [$00] : TAY

        LDX #$0000
        JSR ($0004,X)

      .end
        RTS
    }

    execute_numfield:
    execute_numfield_hex:
    {
        ; $04[0x3] = memory address to manipulate
        ; $08[0x1] = min
        ; $0A[0x1] = max
        ; $0C[0x1] = increment (normal)
        ; $0C[0x1] = increment (input held)
        ; $20[0x2] = JSR target
        LDA [$00] : INC $00 : INC $00 : STA $04
        LDA [$00] : INC $00 : STA $06

        LDA [$00] : INC $00 : AND #$00FF : STA $08
        LDA [$00] : INC $00 : AND #$00FF : INC : STA $0A ; INC for convenience
        LDA [$00] : INC $00 : AND #$00FF : STA $0C

        ; 4x scroll speed if Y held
        LDA !IH_CONTROLLER_PRI : AND !sram_cm_scroll_button : BEQ +
        LDA $0C : ASL #2 : STA $0C

        ; "hold dpad to fast-scroll" is disabled here
;        LDA !ram_cm_controller : BIT !IH_INPUT_HELD : BNE .input_held
;        LDA [$00] : INC $00 : INC $00; : AND #$00FF : STA $0C
;        BRA .load_jsr_target

      .input_held
;        INC $00 : LDA [$00] : INC $00 : AND #$00FF : STA $0C

      .load_jsr_target
+       LDA [$00] : INC $00 : INC $00 : STA $20

        LDA !ram_cm_controller : BIT #$0200 : BNE .pressed_left

        LDA [$04] : CLC : ADC $0C

        CMP $0A : BCS .set_to_min

        STA [$04] : BRA .jsr

      .pressed_left
        LDA [$04] : SEC : SBC $0C : BMI .set_to_max

        CMP $0A : BCS .set_to_max

        STA [$04] : BRA .jsr

      .set_to_min
        LDA $08 : STA [$04] : CLC : BRA .jsr

      .set_to_max
        LDA $0A : DEC : STA [$04] : CLC

      .jsr
        LDA $20 : BEQ .end

        LDA [$04]
        LDX #$0000
        JSR ($0020,X)

      .end
        %sfxnumber()
        RTS
    }

    execute_numfield_sound:
    {
        ; $04[0x3] = memory address to manipulate
        ; $08[0x1] = min
        ; $0A[0x1] = max
        ; $0C[0x1] = increment
        ; $20[0x2] = JSR target
        LDA [$00] : INC $00 : INC $00 : STA $04
        LDA [$00] : INC $00 : STA $06

        LDA [$00] : INC $00 : AND #$00FF : STA $08
        LDA [$00] : INC $00 : AND #$00FF : INC : STA $0A ; INC for convenience
        LDA [$00] : INC $00 : AND #$00FF : STA $0C

        ; 4x scroll speed if Y held
        LDA !IH_CONTROLLER_PRI : AND !sram_cm_scroll_button : BEQ +
        LDA $0C : ASL #2 : STA $0C

+       LDA [$00] : INC $00 : INC $00 : STA $20

        LDA !ram_cm_controller : BIT #$4000 : BNE .jsr ; check for Y pressed
        LDA !ram_cm_controller : BIT #$0200 : BNE .pressed_left

        LDA [$04] : CLC : ADC $0C

        CMP $0A : BCS .set_to_min

        STA [$04] : BRA .end

      .pressed_left
        LDA [$04] : SEC : SBC $0C : BMI .set_to_max

        CMP $0A : BCS .set_to_max

        STA [$04] : BRA .end

      .set_to_min
        LDA $08 : STA [$04] : CLC : BRA .end

      .set_to_max
        LDA $0A : DEC : STA [$04] : CLC : BRA .end

      .jsr
        LDA $20 : BEQ .end

        LDA [$04]
        LDX #$0000
        JSR ($0020,X)

      .end
;        %sfxnumber()
        RTS
    }

    execute_numfield_word:
    {
        ; $04[0x3] = memory address to manipulate
        ; $08[0x2] = min
        ; $0A[0x2] = max
        ; $0C[0x2] = increment (normal)
        ; $0C[0x2] = increment (input held)
        ; $20[0x2] = JSR target
        LDA [$00] : INC $00 : INC $00 : STA $04
        LDA [$00] : INC $00 : STA $06

        LDA [$00] : INC $00 : INC $00 : STA $08
        LDA [$00] : INC $00 : INC $00 : INC : STA $0A ; INC for convenience
        LDA [$00] : INC $00 : INC $00 : STA $0C

        ; 4x scroll speed if Y held
        LDA !IH_CONTROLLER_PRI : AND !sram_cm_scroll_button : BEQ +
        LDA $0C : ASL #2 : STA $0C

        ; "hold dpad to fast-scroll" is disabled here
;        LDA !ram_cm_controller : BIT !IH_INPUT_HELD : BNE .input_held
;        LDA [$00] : INC $00 : INC $00; : AND #$00FF : STA $0C
;        BRA .load_jsr_target

      .input_held
;        INC $00 : LDA [$00] : INC $00 : AND #$00FF : STA $0C

      .load_jsr_target
+       LDA [$00] : INC $00 : INC $00 : STA $20

        LDA !ram_cm_controller : BIT #$0200 : BNE .pressed_left

        LDA [$04] : CLC : ADC $0C

        CMP $0A : BCS .set_to_min

        STA [$04] : BRA .jsr

      .pressed_left
        LDA [$04] : SEC : SBC $0C : BMI .set_to_max

        CMP $0A : BCS .set_to_max

        STA [$04] : BRA .jsr

      .set_to_min
        LDA $08 : STA [$04] : CLC : BRA .jsr

      .set_to_max
        LDA $0A : DEC : STA [$04] : CLC

      .jsr
        LDA $20 : BEQ .end

        LDA [$04]
        LDX #$0000
        JSR ($0020,X)

      .end
        %sfxnumber()
        RTS
    }

    execute_numfield_color:
    {
        ; $04[0x3] = memory address to manipulate
        ; $20[0x2] = JSR target
        LDA [$00] : INC $00 : INC $00 : STA $04
        LDA [$00] : INC $00 : STA $06

        LDA [$00] : INC $00 : INC $00 : STA $20

        LDA !ram_cm_controller : BIT #$0200 : BNE .pressed_left

        LDA [$04] : INC : CMP #$0020 : BCS .set_to_min
        STA [$04] : LDA !ram_cm_controller : BIT !IH_INPUT_LEFT : BEQ .jsr

        LDA [$04] : INC : CMP #$0020 : BCS .set_to_min
        STA [$04] : BRA .jsr

      .pressed_left
        LDA [$04] : DEC : BMI .set_to_max
        STA [$04] : LDA !ram_cm_controller : BIT !IH_INPUT_LEFT : BEQ .jsr

        LDA [$04] : DEC : BMI .set_to_max
        STA [$04] : BRA .jsr

      .set_to_min
        LDA #$0000 : STA [$04] : CLC : BRA .jsr

      .set_to_max
        LDA #$001F : STA [$04] : CLC

      .jsr
        LDA $20 : BEQ .end

        LDA [$04]
        LDX #$0000
        JSR ($0020,X)

      .end
        %sfxnumber()
        RTS
    }

    execute_choice:
    {
        ; $04[0x3] = memory to manipulate
        ; $08[0x2] = jsr target
        %a16()
        LDA [$00] : INC $00 : INC $00 : STA $04
        LDA [$00] : INC $00 : STA $06

        LDA [$00] : INC $00 : INC $00 : STA $08

        ; we either increment or decrement
        LDA !ram_cm_controller : BIT #$0200 : BNE .pressed_left
        LDA [$04] : INC : BRA .bounds_check

      .pressed_left
        LDA [$04] : DEC

      .bounds_check
        TAX         ; X = new value
        LDY #$0000  ; Y will be set to max

        %a8()
      .loop_choices
        LDA [$00] : %a16() : INC $00 : %a8() : CMP.b #$FF : BEQ .loop_done

      .loop_text
        LDA [$00] : %a16() : INC $00 : %a8()
        CMP.b #$FF : BNE .loop_text
        INY : BRA .loop_choices

      .loop_done
        ; X = new value (might be out of bounds)
        ; Y = maximum + 2
        ; We need to make sure X is between 0-maximum.

        ; for convenience so we can use BCS. We do one more DEC in `.set_to_max`
        ; below, so we get the actual max.
        DEY

        %a16()
        TXA : BMI .set_to_max
        STY $0A
        CMP $0A : BCS .set_to_zero

        BRA .store

      .set_to_zero
        LDA #$0000 : BRA .store

      .set_to_max
        TYA : DEC

      .store
        STA [$04]

        LDA $08 : BEQ .end

        LDA [$04]
        LDX #$0000
        JSR ($0008,X)

      .end
        %sfxtoggle()
        RTS
    }

    execute_ctrl_shortcut:
    {
        ; < and > should do nothing here
        ; also ignore the input held flag
        LDA !ram_cm_controller : BIT #$0301 : BNE .end

        LDA [$00] : STA $C5 : INC $00 : INC $00
        LDA [$00] : STA $C7 : INC $00

        LDA !ram_cm_controller : BIT #$0040 : BNE .reset_shortcut

        LDA #$0001 : STA !ram_cm_ctrl_mode
        LDA #$0000 : STA !ram_cm_ctrl_timer
        RTS

      .reset_shortcut
        LDA.w #!sram_ctrl_menu : CMP $C5 : BEQ .end
        %sfxconfirm()

        LDA #$0000 : STA [$C5]

        .end
        RTS
    }

    execute_controller_input:
    {
        ; <, > and X should do nothing here
        ; also ignore input held flag
        LDA !ram_cm_controller : BIT #$0341 : BNE .end

        ; store long address as short address for now
        LDA [$00] : INC $00 : INC $00 : INC $00
        STA !ram_cm_ctrl_assign

        ; $02 = JSR target
        LDA [$00] : INC $00 : INC $00 : STA $04

        ; Y = Argument
        LDA [$00] : TAY

        LDX #$0000
        JSR ($0004,X)

      .end
        RTS
    }

    execute_numfield_hex_word:
    {
        ; do nothing
        RTS
    }
}

cm_hex2dec:
{
    STA $4204

    %a8()
    LDA #$64 : STA $4206
    PHA : PLA : PHA : PLA

    %a16()
    LDA $4214 : STA !ram_hex2dec_rest
    LDA $4216 : STA $4204

    %a8()
    LDA #$0A : STA $4206
    PHA : PLA : PHA : PLA

    %a16()
    LDA $4214 : STA !ram_hex2dec_second_digit
    LDA $4216 : STA !ram_hex2dec_third_digit
    LDA !ram_hex2dec_rest : STA $4204

    %a8()
    LDA #$0A : STA $4206
    PHA : PLA : PHA : PLA

    %a16()
    LDA $4214 : STA !ram_hex2dec_rest
    LDA $4216 : STA !ram_hex2dec_first_digit

    RTS
}

cm_divide_100:
{
    STA $4204 : SEP #$20
    LDA #$64 : STA $4206
    PHA : PLA : PHA : PLA : REP #$20
    LDA $4214 : ADC !ram_tmp_1 : STA !ram_tmp_1
    LDA $4214
    RTS
}


; -----------
; Main menu
; -----------

incsrc mainmenu.asm


; ----------
; Resources
; ----------

cm_hud_table:
    incbin ../resources/cm_gfx.bin

HexMenuGFXTable:
    dw $2C70, $2C71, $2C72, $2C73, $2C74, $2C75, $2C76, $2C77, $2C78, $2C79, $2C50, $2C51, $2C52, $2C53, $2C54, $2C55

print pc, " menu end"
