; Patch out copy protection
org $008000
    db $FF

; Set SRAM size
org $00FFD8
IF !FEATURE_TINYSTATES
    db $07 ; 128kb
else
    if !FEATURE_SD2SNES
        db $08 ; 256kb
    else
        db $05 ; 64kb
    endif
endif


; Skip intro
; $82:EEDF A9 95 A3    LDA #$A395 (original code)
;  (skip to Ceres)     LDA #$C100 (skip to Ceres)
;  (skip to Zebes)     LDA #$CDAF (skip to Zebes)
;                      LDA #Intro_Skip_to_Zebes
org $82EEDF
    LDA #Intro_Skip_to_Zebes

org !ORG_MISC_BANK8B
print pc, " misc bank8B start"

Intro_Skip_to_Zebes:
{
    %a8()
    LDA #$80 : STA $51
    %a16()
    LDX #$0290
-   STZ $198D,X
    DEX #2 : BPL -

    ; mark Ceres completed
    LDA #$0022 : STA $7ED914
    ; load game next frame
    LDA #$0006 : STA !GAMEMODE
    ; Screen fade delay/counter = 0
    STZ $0723 : STZ $0725
    LDA !SAMUS_HP_MAX : STA !SAMUS_HP
    RTS
}
print pc, " misc bank8B end"


; Enable version display
org $8B8697
    NOP

org $8BF754
    db #$20, #($30+!VERSION_MAJOR)
    db #$2E, #($30+!VERSION_MINOR)
    db #$2E, #($30+!VERSION_BUILD)
if !VERSION_REV_1
    db #$2E, #($30+!VERSION_REV_1)
    db #($30+!VERSION_REV_2)
    db #$20, #$20
else
if !VERSION_REV_2
    db #$2E, #($30+!VERSION_REV_2)
    db #$20, #$20, #$20
else
    db #$20, #$20, #$20, #$20, #$20
endif
endif


; Skips the waiting time after teleporting
org $90E877
    LDA $07F5
    JSL $808FC1 ; queue room music track
    BRA $18


; $82:8BB3 22 69 91 A0 JSL $A09169[$A0:9169]  ; Handles Samus getting hurt?
org $828BB3
    JSL gamemode_end


; Replace unnecessary logic checking controller input to toggle debug CPU brightness
; with logic to collect the v-counter data
org $828AB1
    %a8() : LDA $4201 : ORA #$80 : STA $4201 : %ai16()
    LDA $2137 : LDA $213D : STA !ram_vcounter_data

    ; For efficiency, re-implement the debug brightness logic here
    LDA $0DF4 : BEQ .skip_debug_brightness
    %a8() : LDA $51 : AND #$F0 : ORA #$05 : STA $2100 : %a16()
    BRA .skip_debug_brightness

warnpc $828ADD
org $828ADD       ; Resume original logic
    .skip_debug_brightness


org $CF8BBF       ; Set map scroll beep to high priority
    dw $2A97


; $80:8F24 9C F6 07    STZ $07F6  [$7E:07F6]  ;/
; $80:8F27 8D 40 21    STA $2140  [$7E:2140]  ; APU IO 0 = [music track]
org $808F24
    JSL hook_set_music_track
    NOP #2

; $80:8F65 8D F3 07    STA $07F3  [$7E:07F3]  ;} Music data = [music entry] & FFh
; $80:8F68 AA          TAX                    ; X = [music data]
org $808F65
    JML hook_set_music_data


; swap Enemy HP to MB HP when entering MB's room
;org $83AAD2
;    dw #MotherBrainHP


; Ceres Ridley modified state check to support presets
org $8FE0C0
    dw layout_asm_ceres_ridley_room_state_check

; Ceres Ridley room setup asm when timer is not running
org $8FE0DF
    dw layout_asm_ceres_ridley_room_no_timer


; Continue drawing escape timer after reaching ship
org $90E908
    JSR preserve_escape_timer

; Stop drawing timer when its VRAM is overwritten
org $A2ABFD
    JML clear_escape_timer


;org $8FEA00 ; free space for door asm
org !ORG_MISC_BANK8F
print pc, " misc bank8F start"

layout_asm_ceres_ridley_room_state_check:
{
    LDA $0943 : BEQ .no_timer
    LDA $0001,X : TAX
    JMP $E5E6
  .no_timer
    STZ $093F
    INX : INX : INX
    RTS
}

layout_asm_ceres_ridley_room_no_timer:
{
    ; Same as original setup asm, except force blue background
    PHP
    SEP #$20
    LDA #$66 : STA $5D
    PLP
    JSL $88DDD0
    LDA #$0009 : STA $07EB
    RTS
}

print pc, " misc bank8F end"


org !ORG_MISC_BANK87
print pc, " misc start"

hook_set_music_track:
{
    STZ $07F6
    PHA
    LDA !sram_music_toggle : CMP #$01 : BNE .no_music
    PLA : STA $2140
    RTL

  .no_music
    PLA
    RTL
}

hook_set_music_data:
{
    STA $07F3 : TAX
    LDA !sram_music_toggle : CMP #$0002 : BEQ .fast_no_music
    JML $808F69

  .fast_no_music
    JML $808F89
}

gamemode_end:
{
   ; overwritten logic
    JSL $A09169

    ; If minimap is disabled or shown, we ignore artificial lag
    LDA $05F7 : BNE .endlag
    LDA !ram_minimap : BNE .endlag

    ; Ignore artifical lag if sprite features are active
    LDA !ram_sprite_feature_flags : BNE .endlag

    ; Artificial lag, multiplied by 16 to get loop count
    ; Each loop takes 5 clock cycles (assuming branch taken)
    ; For reference, 41 loops ~= 1 scanline
    LDA !sram_artificial_lag : BEQ .endlag

    ; To account for various changes, we may need to tack on more clock cycles
    ; These can be removed as code is added to maintain CPU parity during normal gameplay
    LDA !sram_top_display_mode : CMP !TOP_DISPLAY_VANILLA : BEQ .vanilla_display_lag_loop
    LDA !sram_artificial_lag
    ASL
    ASL
    ASL
    ASL
if !FEATURE_SD2SNES
; skip 4 (ideally 6) cycles for auto-savestate in doors check
else
    NOP  ; Add 2 more clock cycles
    NOP  ; Add 2 more clock cycles
endif
    TAX
  .lagloop
    DEX : BNE .lagloop
  .endlag
    RTL

  .vanilla_display_lag_loop
    ; Vanilla display logic uses more CPU so reduce artificial lag
    LDA !sram_artificial_lag
    DEC : BEQ .endlag   ; Remove 76 clock cycles
    DEC : BEQ .endlag   ; Remove 76 clock cycles
    ASL
    ASL
    INC  ; Add 4 loops (22 clock cycles including the INC)
    ASL
    ASL
if !FEATURE_SD2SNES
else
    INC  ; Add 1 loop (7 clock cycles including the INC)
endif
    TAX
  .vanilla_lagloop
    DEX : BNE .vanilla_lagloop
    RTL
}

stop_all_sounds:
{
    ; If sounds are not enabled, the game won't clear the sounds
    LDA !DISABLE_SOUNDS : PHA
    STZ !DISABLE_SOUNDS
    JSL $82BE17
    PLA : STA !DISABLE_SOUNDS

    ; Makes the game check Samus' health again, to see if we need annoying sound
    STZ !SAMUS_HEALTH_WARNING
    RTL
}
print pc, " misc end"


if !FEATURE_MORPHLOCK
; ----------
; Morph Lock
; ----------

print pc, " misc morphlock start"
; rewrite morph lock code to allow controller shortcuts and menu navigation
org !ORG_MORPHLOCK
    ; check for menu
    LDA !ram_cm_menu_active : BEQ +
    LDA $4218
    RTS

    ; gamemode.asm will use these
+   LDA $4218 : STA $CB
    EOR $C7 : AND $CB : STA $CF

    ; resume normal morph lock code
    LDA $09A1 : BMI .gameMode
    LDA $4218
    RTS

  .gameMode
    ; checks for gamemodes where morph lock is allowed
    LDA $0998 : CMP #$0008 : BEQ .morphLock
    CMP #$000C : BEQ .morphLock
    CMP #$0012 : BEQ .morphLock
    CMP #$001A : BNE .noMorphLock
    LDA $09A1 : AND #$7FFF : STA $09A1 ; reset flag if dead

  .noMorphLock
    LDA $4218
    RTS

  .morphLock
    LDA $09A2 : AND #$0002 : BNE .springball
    ; no springball, also filter jump
    LDA #$FFFF : EOR $09B4 : AND $4218 ; removes jump input
    BRA .noSpringball

  .springball
    ; springball equipped, allow jump
    LDA $4218

  .noSpringball
    AND #$F7FF ; removes up input
    RTS
print pc, " misc morphlock end"
endif

; general damage hijack
org $A0A862
    JSR EnemyDamage

; shinespark damage
org $A0A54C
    JSR EnemyDamageShinespark

; power bomb damage
org $A0A62B
    JSR EnemyDamagePowerBomb

org !ORG_MISC_BANKA0
print pc, " misc bankA0 start"
EnemyDamage:
{
    LDA !ram_pacifist : BNE .no_damage
    LDA $0F8C,X ; original code
    RTS

  .no_damage
    PLA ; pull return address and jump past storing enemy hp
    JMP $A8BA
}

EnemyDamageShinespark:
{
    LDA !ram_pacifist : BNE .no_damage
    LDA $0F8C,X ; original code
    RTS

  .no_damage
    PLA ; pull return address and jump past storing enemy hp
    JMP $A55A
}

EnemyDamagePowerBomb:
{
    LDA !ram_pacifist : BNE .no_damage
    LDA $0F8C,X ; original code
    RTS

  .no_damage
    PLA ; pull return address and jump past storing enemy hp
    JMP $A63C

print pc, " misc bankA0 end"


org !ORG_MISC_BANK90
print pc, " misc bank90 start"

preserve_escape_timer:
{
    ; check if timer is active
    LDA $0943 : AND #$0006 : BEQ .done
    JSL $809F6C ; Draw timer

  .done
    JMP $EA7F ; overwritten code
}

clear_escape_timer:
{
    ; clear timer status
    STZ $0943

    ; overwritten code
    LDA #$AC1B : STA $0FB2,X
    STZ $0DEC
    RTL
}

warnpc $908EA9 ; overwrites unused vanilla routine
print pc, " misc bank90 end"


if !RAW_TILE_GRAPHICS
org !ORG_MISC_TILE_GRAPHICS
print pc, " misc decompression start"
; Decompression optimization adapted from Kejardon
; Compression format: One byte (XXX YYYYY) or two byte (111 XXX YY-YYYYYYYY) headers
; XXX = instruction, YYYYYYYYYY = counter
optimized_decompression_end:
{
    PLB : PLP
    RTL
}

optimized_decompression:
{
    PHP : %a8() : %i16()
    ; Set bank
    PHB : LDA $49 : PHA : PLB

    STZ $50 : LDY #$0000

  .next_byte
    LDA ($47)
    INC $47 : BNE .read_command_skip_inc
    INC $48 : BNE .read_command_skip_inc
    JSR decompression_increment_bank
  .read_command_skip_inc
    STA $4A
    CMP #$FF : BEQ optimized_decompression_end
    CMP #$E0 : BCC .one_byte_size

    ; Two byte size
    ASL : ASL : ASL
    AND #$E0 : PHA
    LDA $4A : AND #$03 : XBA

    LDA ($47)
    INC $47 : BNE .read_extended_size_skip_inc
    INC $48 : BNE .read_extended_size_skip_inc
    JSR decompression_increment_bank
  .read_extended_size_skip_inc
    BRA .data_read

  .one_byte_size
    AND #$E0 : PHA
    TDC : LDA $4A : AND #$1F

  .data_read
    TAX : INX : PLA
    BMI .option4567 : BEQ .option0
    CMP #$20 : BEQ .option1
    CMP #$40 : BEQ .option2

    ; Option X = 3: Incrementing fill Y bytes starting with next byte
    LDA ($47)
    INC $47 : BNE .option3_read_skip_inc
    INC $48 : BNE .option3_read_skip_inc
    JSR decompression_increment_bank
  .option3_read_skip_inc
    STA [$4C],Y
    INC : INY : DEX : BNE .option3_read_skip_inc
    BRL .next_byte

  .option0:
    ; Option X = 0: Directly copy Y bytes
    LDA ($47)
    INC $47 : BNE .option0_read_skip_inc
    INC $48 : BNE .option0_read_skip_inc
    JSR decompression_increment_bank
  .option0_read_skip_inc
    STA [$4C],Y
    INY : DEX : BNE .option0
    BRL .next_byte

  .option1:
    ; Option X = 1: Copy the next byte Y times
    LDA ($47)
    INC $47 : BNE .option1_read_skip_inc
    INC $48 : BNE .option1_read_skip_inc
    JSR decompression_increment_bank
  .option1_read_skip_inc
    STA [$4C],Y
    INY : DEX : BNE .option1_read_skip_inc
    BRL .next_byte

  .option2:
    ; Option X = 2: Copy the next two bytes, one at a time, for the next Y bytes
    LDA ($47)
    INC $47 : BNE .option2_lsb_read_skip_inc
    INC $48 : BNE .option2_lsb_read_skip_inc
    JSR decompression_increment_bank
  .option2_lsb_read_skip_inc
    XBA : LDA ($47)
    INC $47 : BNE .option2_msb_read_skip_inc
    INC $48 : BNE .option2_msb_read_skip_inc
    JSR decompression_increment_bank
  .option2_msb_read_skip_inc
    XBA : REP #$20
  .option2_loop
    STA [$4C],Y
    INY : DEX : BEQ .option2_end
    INY : DEX : BNE .option2_loop
  .option2_end
    SEP #$20
    BRL .next_byte

  .option4567:
    CMP #$C0 : AND #$20 : STA $4F : BCS .option67

    ; Option X = 4: Copy Y bytes starting from a given address in the decompressed data
    ; Option X = 5: Copy and invert (EOR #$FF) Y bytes starting from a given address in the decompressed data
    LDA ($47)
    INC $47 : BNE .option45_lsb_read_skip_inc
    INC $48 : BNE .option45_lsb_read_skip_inc
    JSR decompression_increment_bank
  .option45_lsb_read_skip_inc
    XBA : LDA ($47)
    INC $47 : BNE .option45_msb_read_skip_inc
    INC $48 : BNE .option45_msb_read_skip_inc
    JSR decompression_increment_bank
  .option45_msb_read_skip_inc
    XBA : REP #$21
    ADC $4C : STY $44 : SEC

  .option_dictionary
    SBC $44 : STA $44
    SEP #$20
    LDA $4E : BCS .skip_carry_subtraction
    DEC
  .skip_carry_subtraction
    STA $46
    LDA $4F : BNE .option5_loop

  .option4_loop
    LDA [$44],Y
    STA [$4C],Y
    INY : DEX : BNE .option4_loop
    BRL .next_byte

  .option5_loop
    LDA [$44],Y
    EOR #$FF
    STA [$4C],Y
    INY : DEX : BNE .option5_loop
    BRL .next_byte

  .option67
    ; Option X = 6: Copy Y bytes starting from a given number of bytes ago in the decompressed data
    ; Option X = 7: Copy and invert (EOR #$FF) Y bytes starting from a given number of bytes ago in the decompressed data
    TDC : LDA ($47)
    INC $47 : BNE .option67_read_skip_inc
    INC $48 : BNE .option67_read_skip_inc
    JSR decompression_increment_bank
  .option67_read_skip_inc
    REP #$20
    STA $44 : LDA $4C
    BRA .option_dictionary
}

decompression_increment_bank:
{
    PHA
    PHB : PLA
    INC
    PHA : PLB
    LDA #$80 : STA $48
    PLA
    RTS
}
print pc, " misc decompression end"
endif

