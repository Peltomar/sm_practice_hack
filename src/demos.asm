
; Allow input instruction lists to be repointed outside bank $91
org $9183C0
DemoInputObjectHandler:
{
    PHB
    ; set DB to match input data
    PEA.w DemoInputInstructionLists>>8 : PLB : PLB

    ; check if demo input enabled
    BIT $0A88 : BPL .return
    ; check if instruction pointer = 0
    LDA $0A7E : BEQ .return

    JSR $83F2 ; Process Demo Input Object

    ; update previous demo inputs
    LDA $0A8C : STA $0DFE
    LDA $0A8E : STA $0E00

    ; update current demo inputs
    LDA $0A84 : STA $8B : STA $0A8C
    LDA $0A86 : STA $8F : STA $0A8E

  .return
    PLB
    RTL
}

NoCodeRTS:
    RTS
warnpc $9183F2


; adds lava damage to demos, replaces dead debug code
if !FEATURE_PAL
org $90E814
    JSR $E9CB ; Handle periodic damage to Samus
else
org $90E817
    JSR $E9CE ; Handle periodic damage to Samus
endif
warnpc $90E81A

if !FEATURE_PAL
org $919DAA
else
org $919E52
endif
DemoObject:
;;; $9E52: Demo input objects - title ;;;
{
; Order does not matter
;        _________________ Initialisation (RTS)
;       |       __________ Pre-instruction (ends demo controller input)
;       |      |       ___ Pointer to input instruction list
;       |      |      |
if !FEATURE_PAL
  .IceBeam
    dw NoCodeRTS, $8A9B, DemoInput_IceBeam
  .LowerNorfairEntrance
    dw NoCodeRTS, $8A9B, DemoInput_LowerNorfairEntrance
  .FireFleaRoom
    dw NoCodeRTS, $8A9B, DemoInput_FireFleaRoom
  .BrinstarDiagonalRoom
    dw NoCodeRTS, $8A9B, DemoInput_BrinstarDiagonalRoom
endif
  .Dachora
    dw NoCodeRTS, $8A9B, DemoInput_Dachora
  .RedBrinstarElevator
    dw NoCodeRTS, $8A9B, DemoInput_RedBrinstarElevator
  .WreckedShipBasement
    dw NoCodeRTS, $8A9B, DemoInput_WreckedShipBasement
  .EyeDoor
    dw NoCodeRTS, $8A9B, DemoInput_EyeDoor
  .Shinespark
    dw NoCodeRTS, $8AB0, DemoInput_Shinespark
  .Kraid
    dw NoCodeRTS, $8A9B, DemoInput_Kraid
  .ScrewAttack
    dw NoCodeRTS, $8A9B, DemoInput_ScrewAttack
  .Unused
    dw NoCodeRTS, $8A9B, DemoInput_Unused
  .GauntletEntrance
    dw NoCodeRTS, $8A9B, DemoInput_GauntletEntrance
  .AdvancedGrappleBeam
    dw NoCodeRTS, $8A9B, DemoInput_AdvancedGrappleBeam
  .IBJ
    dw NoCodeRTS, $8A9B, DemoInput_IBJ
  .SBA
    dw NoCodeRTS, $8A9B, DemoInput_SBA
  .TourianEntrance
    dw NoCodeRTS, $8A9B, DemoInput_TourianEntrance
  .CrystalFlash
    dw NoCodeRTS, $8A9B, DemoInput_CrystalFlash

; custom demos below
  .mockball
    dw NoCodeRTS, $8A9B, DemoInput_mockball
  .lavadive
    dw NoCodeRTS, $8A9B, DemoInput_lavadive
  .redtower
    dw NoCodeRTS, $8A9B, DemoInput_redtower
  .ggg
    dw NoCodeRTS, $8A9B, DemoInput_ggg
  .landingsite
    dw NoCodeRTS, $8A9B, DemoInput_landingsite
  .babyskip
    dw NoCodeRTS, $8A9B, DemoInput_babyskip
if !FEATURE_PAL
else
  .metroid3
    dw NoCodeRTS, $8A9B, DemoInput_metroid3
  .moat
    dw NoCodeRTS, $8A9B, DemoInput_moat
  .frogspeedway
    dw NoCodeRTS, $8A9B, DemoInput_frogspeedway
  .wraparound
    dw NoCodeRTS, $8A9B, DemoInput_wraparound
endif
if !FEATURE_PAL
warnpc $919E3A
else
warnpc $919EE2
endif
}


org $9189FD 
;;; $89FD: Demo Samus setup function pointers ;;;
{
DemoSamusSetup:
    dw DemoSamusSetup_set1, DemoSamusSetup_set2, DemoSamusSetup_set3, DemoSamusSetup_set4

  .set1
    dw DSS_LandingSite ; landingsite
    dw DSS_FacingRight ; mockball
    dw DSS_FacingRight ; redtower
    dw DSS_FacingLeft ; lavadive
    dw DSS_FacingLeft ; ggg
    dw DSS_FacingLeft ; babyskip

  .set2
if !FEATURE_PAL
    dw DSS_FacingLeft ; Ice Beam
    dw DSS_FacingLeft ; FireFlea Room
    dw DSS_FacingRight ; Brinstar Diagonal Room
    dw DSS_FacingLeft ; Lower Norfair Entrance
else
    dw DSS_FacingRight ; metroid3
    dw DSS_FacingRight ; moat
    dw DSS_FacingLeft ; frogspeedway
    dw DSS_FacingLeft ; wraparound
endif
    dw DSS_FacingRight ; Screw Attack
    dw DSS_FallingFacingLeft ; Dachora

 .set3
    dw DSS_FacingLeft ; Pre Phantoon Hall
    dw DSS_Shinespark ; Shinespark
    dw DSS_FacingRight ; Eye Door
    dw DSS_FacingRight ; Red Brinstar Elevator
    dw DSS_FacingRight ; Kraid
    dw DSS_FacingRight ; Tourian Entrance

  .set4
    dw DSS_GauntletSpark ; Gauntlet Entrance
    dw DSS_FacingLeft ; Advanced Grapple Beam
    dw DSS_FacingLeft ; IBJ
    dw DSS_FacingRight ; SBA
    dw DSS_LowEnergyFacingLeft ; Crystal Flash

DSS_LandingSite:
;;; $8A33: Demo Samus setup - landing site ;;;
{
if !FEATURE_PAL
    JSL $91E35B ; Make Samus face forward
    ; Samus drawing handler = default
    LDA #$EB4F : STA $0A5C
else
    JSL $91E3F6 ; Make Samus face forward
    ; Samus drawing handler = default
    LDA #$EB52 : STA $0A5C
endif
    RTS
}

DSS_MorphMovingLeft:
;;; $8A3E: Demo Samus setup - morph ball moving left ;;;
{
    LDA #$001F ; pose = moving left - morph ball - no springball - on ground
    BRA DSS_InitPose
}

DSS_LowEnergyFacingLeft:
;;; $8A43: Demo Samus setup - standing facing left - low health ;;;
{
    LDA #$0014 : STA $09C2 ; Samus health = 20
    ; fallthrough to DSS_FacingLeft
}

DSS_FacingLeft:
;;; $8A49: Demo Samus setup - standing facing left ;;;
{
    LDA #$0002 ; pose = facing left - normal
    BRA DSS_InitPose
}

DSS_FallingFacingLeft:
;;; $8A4E: Demo Samus setup - falling facing left ;;;
{
    LDA #$002A ; pose = facing left - falling
    BRA DSS_InitPose
}

DSS_FacingRight:
;;; $8A53: Demo Samus setup - standing facing right ;;;
{
    LDA #$0001 ; pose = facing right - normal
    ; fallthrough to DSS_InitPose
}

DSS_InitPose:
;;; $8A56: Initialise Samus with pose = [A] ;;;
{
    STA $0A1C ; Samus pose = [A]
if !FEATURE_PAL
    JSL $91F398 ; Initialise Samus pose
    JSL $91FA6D ; Set Samus animation frame if pose changed
    LDA #$EB4F : STA $0A5C ; Samus drawing handler = default
else
    JSL $91F433 ; Initialise Samus pose
    JSL $91FB08 ; Set Samus animation frame if pose changed
    LDA #$EB52 : STA $0A5C ; Samus drawing handler = default
endif
    RTS
}

DSS_Shinespark:
;;; $8A68: Demo Samus setup - shinespark ;;;
{
if !FEATURE_PAL
    LDA #$EB4F : STA $0A5C ; Samus drawing handler = default
    JSL $90CFFA ; Trigger shinespark windup
    LDA #$00CD : STA $0A1C ; pose = facing right - shinespark - diagonal
    JSL $91F398 ; Initialise Samus pose
    JSL $91FA6D ; Set Samus animation frame if pose changed
else
    LDA #$EB52 : STA $0A5C ; Samus drawing handler = default
    JSL $90CFFA ; Trigger shinespark windup
    LDA #$00CD : STA $0A1C ; pose = facing right - shinespark - diagonal
    JSL $91F433 ; Initialise Samus pose
    JSL $91FB08 ; Set Samus animation frame if pose changed
endif
    RTS
}

DSS_GauntletSpark:
;;; $8A81: Demo Samus setup - gauntlet entrance ;;;
{
if !FEATURE_PAL
    LDA #$EB4F : STA $0A5C ; Samus drawing handler = default
    JSL $90CFFA ; Trigger shinespark windup
    LDA #$00CA : STA $0A1C ; pose = facing right - shinespark - diagonal
    JSL $91F398 ; Initialise Samus pose
    JSL $91FA6D ; Set Samus animation frame if pose changed
else
    LDA #$EB52 : STA $0A5C ; Samus drawing handler = default
    JSL $90CFFA ; Trigger shinespark windup
    LDA #$00CA : STA $0A1C ; pose = facing right - shinespark - diagonal
    JSL $91F433 ; Initialise Samus pose
    JSL $91FB08 ; Set Samus animation frame if pose changed
endif
    RTS
}
warnpc $918A9A


org $82876C
DemoRoomData:
{
    dw DemoRoomData_set1, DemoRoomData_set2, DemoRoomData_set3, DemoRoomData_set4

;        _____________________________________________________________ Room pointer
;       |       ______________________________________________________ Door pointer
;       |      |       _______________________________________________ Door slot
;       |      |      |       ________________________________________ Screen X position
;       |      |      |      |       _________________________________ Screen Y position
;       |      |      |      |      |       __________________________ Samus Y offset from top of screen
;       |      |      |      |      |      |       ___________________ Samus X offset from centre of screen
;       |      |      |      |      |      |      |       ____________ Length of demo
;       |      |      |      |      |      |      |      |       _____ Pointer to code
;       |      |      |      |      |      |      |      |      |
  .set1
;    dw $91F8, $896A, $0001, $0400, $0400, $0040, $0001, $04D3, $8925 ; Landing Site
;    dw $9F11, $8EAA, $0001, $0000, $0000, $006B, $FFD2, $0151, $8924 ; Missile Door
;    dw $9D9C, $8DC6, $0000, $0100, $0000, $00BB, $FFE0, $017A, $8924 ; Pre Spore Spawn Hall
;    dw $B106, $970E, $0000, $0700, $0000, $008B, $0048, $01A4, $8924 ; Speed Booster
;    dw $AFFB, $9792, $0001, $0000, $0000, $008B, $FFC2, $01BC, $8924 ; Grapple Beam
;    dw $9D19, $8E7A, $0000, $0200, $0600, $0099, $0027, $0265, $891A ; Pseudo Screw Attack
if !FEATURE_PAL
    dw $91F8, $896A, $0001, $0400, $0400, $0040, $0000, $01E3, $8924 ; PAL landingsite
    dw $9BC8, $8CD6, $0001, $0000, $0100, $005B, $FFCC, $00C4, $8924 ; PAL mockball
    dw $A253, $8F0A, $0001, $0000, $0400, $008B, $FFAD, $023A, $8924 ; PAL redtower
    dw $AF14, $967E, $0001, $0300, $0000, $008B, $0052, $02FA, $8924 ; PAL lavadive
    dw $B2DA, $9906, $0001, $0300, $0000, $008B, $0051, $0100, $8924 ; PAL ggg
    dw $DCB1, $AA2C, $0001, $0300, $0000, $00BB, $003B, $0615, $8924 ; PAL babyskip
else
    dw $91F8, $896A, $0001, $0400, $0400, $0040, $0001, $02C3, $8925 ; landingsite
    dw $9BC8, $8CD6, $0001, $0000, $0100, $005B, $FFCC, $00F6, $8924 ; mockball
    dw $A253, $8F0A, $0001, $0000, $0400, $008B, $FFA5, $027F, $8924 ; redtower
    dw $AF14, $967E, $0001, $0300, $0000, $008B, $005B, $03BC, $8924 ; lavadive
    dw $B2DA, $9906, $0001, $0300, $0000, $008B, $0051, $0100, $8924 ; ggg
    dw $DCB1, $AA2C, $0001, $0300, $0000, $00BB, $003B, $0659, $8924 ; babyskip
endif
    dw $FFFF

  .set2
if !FEATURE_PAL
    dw $A408, $A36C, $0000, $0100, $0100, $008B, $0056, $01FD, $8924 ; Ice Beam
    dw $9C5E, $8CCA, $0003, $0200, $0000, $008B, $0049, $019A, $8924 ; FireFlea Room
    dw $9E52, $8DEA, $0003, $0500, $0300, $00AB, $FFE2, $0117, $8924 ; Brinstar Diagonal Room
    dw $AF14, $967E, $0002, $0300, $0000, $008B, $004B, $03CA, $8924 ; Lower Norfair Entrance
else
    dw $DB7D, $A9CC, $0000, $0000, $0000, $008B, $FFAC, $0188, $8924 ; metroid3
    dw $95FF, $8A36, $0000, $0000, $0000, $008B, $FFAA, $03D8, $8924 ; moat
    dw $B106, $970E, $0001, $0700, $0000, $008B, $0051, $0312, $8924 ; frogspeedway
    dw $91F8, $89B2, $0001, $0800, $0100, $008B, $0055, $02F8, $8924 ; wraparound
endif
    dw $9879, $8982, $0003, $0000, $0000, $00BB, $FFF1, $00D5, $8924 ; Screw Attack
    dw $9CB3, $8DD2, $0001, $0400, $0200, $0080, $0005, $0317, $8924 ; Dachora
    dw $FFFF

  .set3
    dw $CC6F, $A21C, $0003, $0200, $0000, $0060, $0004, $02EF, $8924 ; Pre Phantoon Hall
    dw $91F8, $896A, $0001, $0300, $0400, $00B0, $0000, $00C7, $8925 ; Shinespark
    dw $A56B, $919E, $0001, $0000, $0100, $008B, $FFD2, $02D3, $8924 ; Eye Door
    dw $A322, $90EA, $0000, $0000, $0700, $008B, $FFAA, $0164, $8924 ; Red Brinstar Elevator
    dw $A59F, $91B6, $0001, $0000, $0100, $008B, $FFBF, $013F, $892B ; Kraid
    dw $A66A, $91F2, $0001, $0000, $0000, $008B, $FFB1, $0197, $8932 ; Tourian Entrance
    dw $FFFF

  .set4
    dw $91F8, $890A, $0000, $0600, $0200, $0080, $0030, $0100, $8925 ; Gauntlet Entrance
    dw $D0B9, $A474, $0000, $0200, $0000, $00AB, $0000, $0332, $8924 ; Advanced Grapple Beam
    dw $91F8, $890A, $0000, $0600, $0200, $007B, $0020, $0185, $8925 ; IBJ
    dw $9AD9, $8D42, $0001, $0000, $0400, $008B, $FFB7, $018A, $8924 ; SBA
    dw $91F8, $890A, $0000, $0600, $0200, $008B, $0004, $0200, $8925 ; Crystal Flash
    dw $FFFF
}


org $918885
DemoSamusData:
{
    dw DemoSamusData_set1, DemoSamusData_set2, DemoSamusData_set3, DemoSamusData_set4

;        ______________________________________________________ Equipment
;       |       _______________________________________________ Missiles
;       |      |       ________________________________________ Super missiles
;       |      |      |       _________________________________ Power bombs
;       |      |      |      |       __________________________ Health
;       |      |      |      |      |       ___________________ Collected beams
;       |      |      |      |      |      |       ____________ Equipped beams
;       |      |      |      |      |      |      |       _____ Demo input object pointer
;       |      |      |      |      |      |      |      |
  .set1
;    dw $0000, $0000, $0000, $0000, $0063, $0000, $0000, DemoObject_LandingSite
;    dw $0004, $0005, $0000, $0000, $0063, $0000, $0000, DemoObject_MissileDoor
;    dw $0004, $000F, $0000, $0000, $00C7, $1000, $1000, DemoObject_PreSporeSpawnHall
;    dw $2105, $001E, $0005, $0000, $012B, $1004, $1004, DemoObject_SpeedBooster
;    dw $6105, $001E, $0005, $0005, $018F, $1006, $1006, DemoObject_GrappleBeam
;    dw $0004, $0014, $0000, $0000, $00C7, $1000, $1000, DemoObject_PseudoScrewAttack
if !FEATURE_PAL
    dw $2000, $0000, $0000, $0000, $0063, $0000, $0000, DemoObject_landingsite ; PAL
    dw $1004, $0001, $0000, $0000, $00C7, $0000, $0000, DemoObject_mockball ; PAL
    dw $1004, $0002, $0004, $0000, $00C7, $0000, $0000, DemoObject_redtower ; PAL
    dw $1005, $0002, $0002, $0002, $00C7, $0000, $0000, DemoObject_lavadive ; PAL
    dw $1005, $0002, $0002, $0003, $0021, $0000, $0000, DemoObject_ggg ; PAL
    dw $F33F, $0064, $0014, $0014, $02BC, $100F, $100B, DemoObject_babyskip ; PAL
else
    dw $2000, $0000, $0000, $0000, $0063, $0000, $0000, DemoObject_landingsite
    dw $1004, $0001, $0000, $0000, $00C7, $0000, $0000, DemoObject_mockball
    dw $1004, $0002, $0004, $0000, $00C7, $0000, $0000, DemoObject_redtower
    dw $1005, $0002, $0002, $0002, $012B, $0000, $0000, DemoObject_lavadive
    dw $1005, $0002, $0002, $0003, $001D, $0000, $0000, DemoObject_ggg
    dw $F33F, $0064, $0014, $0014, $02BC, $100F, $100B, DemoObject_babyskip
endif

  .set2
if !FEATURE_PAL
    dw $2105, $001E, $0005, $0000, $012B, $1006, $1006, DemoObject_IceBeam
    dw $0004, $000A, $0000, $0000, $00C7, $0000, $0000, DemoObject_FireFleaRoom
    dw $0004, $0019, $0005, $0000, $00C7, $1000, $1000, DemoObject_BrinstarDiagonalRoom
    dw $E325, $004B, $000F, $000A, $0383, $1000, $1000, DemoObject_LowerNorfairEntrance
else
    dw $F33F, $0064, $0014, $0014, $02BC, $100F, $100B, DemoObject_metroid3
    dw $1004, $0006, $0004, $0001, $0081, $0000, $0000, DemoObject_moat
    dw $1005, $000A, $0005, $0000, $012B, $0005, $0005, DemoObject_frogspeedway
    dw $2000, $000A, $0005, $0005, $012B, $1001, $1001, DemoObject_wraparound
endif
    dw $E32D, $0055, $000F, $000A, $03E7, $0000, $0000, DemoObject_ScrewAttack
    dw $E105, $002D, $0005, $0005, $018F, $1000, $1000, DemoObject_Dachora

  .set3
    dw $E105, $0037, $0005, $0005, $018F, $1000, $1000, DemoObject_WreckedShipBasement
    dw $F33F, $0055, $000F, $000A, $03E7, $100F, $1000, DemoObject_Shinespark
    dw $0104, $0019, $0005, $0000, $012B, $1004, $1004, DemoObject_EyeDoor
    dw $2105, $001E, $0005, $0000, $012B, $0000, $0000, DemoObject_RedBrinstarElevator
    dw $0104, $0019, $0005, $0000, $012B, $0000, $0000, DemoObject_Kraid
    dw $2105, $001E, $0005, $0005, $012B, $1008, $1008, DemoObject_TourianEntrance

  .set4
    dw $F32D, $0055, $000F, $000A, $03E7, $1000, $1000, DemoObject_GauntletEntrance
    dw $F32D, $0055, $000F, $000A, $03E7, $0000, $0000, DemoObject_AdvancedGrappleBeam
    dw $F32D, $0055, $000F, $000A, $03E7, $0000, $0000, DemoObject_IBJ
    dw $F32D, $0055, $000F, $000A, $03E7, $1008, $1008, DemoObject_SBA
    dw $F32D, $0055, $0014, $0014, $03E7, $1000, $1000, DemoObject_CrystalFlash
}


org $83D000 ; $918ACE ; repoint to any bank with WRAM access
print pc, " demos start"
DemoInputInstructionLists:
; Order does not matter

if !FEATURE_PAL
DemoInput_LandingSite:
{
    dw $00E7, $0000, $0000
    dw $0001, $0200, $0200
    dw $0005, $0200, $0000
    dw $0001, $0A00, $0800
    dw $0002, $0A00, $0000
    dw $000F, $0200, $0000
    dw $0001, $0280, $0080
    dw $0020, $0280, $0000
    dw $0028, $0200, $0000
    dw $001D, $0000, $0000
    dw $0001, $0100, $0100
    dw $0004, $0100, $0000
    dw $000C, $0000, $0000
    dw $0001, $0200, $0200
    dw $0004, $0200, $0000
    dw $001B, $0000, $0000
    dw $0001, $0200, $0200
    dw $0048, $0200, $0000
    dw $0004, $0000, $0000
    dw $0001, $0100, $0100
    dw $0004, $0100, $0000
    dw $0037, $0000, $0000
    dw $0001, $0200, $0200
    dw $0002, $0200, $0000
    dw $0001, $8200, $8000
    dw $003A, $8200, $0000
    dw $0001, $8A00, $0800
    dw $0002, $8A00, $0000
    dw $0001, $0200, $0000
    dw $0002, $0000, $0000
    dw $0001, $0100, $0100
    dw $0006, $0100, $0000
    dw $0009, $0000, $0000
    dw $0001, $0010, $0010
    dw $0019, $0010, $0000
    dw $0001, $0210, $0200
    dw $0004, $0210, $0000
    dw $0017, $0010, $0000
    dw $0001, $0200, $0200
    dw $004B, $0200, $0000
    dw $0026, $0000, $0000
    dw $0001, $0200, $0200
    dw $0030, $0200, $0000
    dw $0019, $0000, $0000
    dw $0001, $0100, $0100
    dw $0003, $0100, $0000
    dw $0033, $0000, $0000
    dw $0001, $0200, $0200
    dw $0003, $0200, $0000
    dw $0020, $0000, $0000
    dw $0001, $0040, $0040
    dw $0005, $0040, $0000
    dw $0022, $0000, $0000
    dw $0001, $0200, $0200
    dw $000E, $0200, $0000
    dw $0006, $0000, $0000
    dw $0001, $0200, $0200
    dw $0003, $0200, $0000
    dw $0010, $0100, $0000
    dw $0001, $0140, $0040
    dw $0002, $0140, $0000
    dw $8427 ; Delete

DemoInput_PseudoScrewAttack:
{
    dw $0012, $0000, $0000
    dw $0001, $0800, $0800
    dw $0002, $0800, $0000
    dw $0004, $0000, $0000
    dw $0001, $0800, $0800
    dw $0005, $0800, $0000
    dw $0012, $0000, $0000
    dw $0001, $0200, $0200
    dw $0004, $0200, $0000
    dw $0009, $0000, $0000
    dw $0001, $0040, $0040
    dw $003E, $0040, $0000
    dw $0001, $0240, $0200
    dw $000A, $0240, $0000
    dw $0001, $02C0, $0080
    dw $0010, $02C0, $0000
    dw $0010, $0240, $0000
    dw $001A, $0040, $0000
    dw $0001, $0140, $0100
    dw $000C, $0140, $0000
    dw $0001, $01C0, $0080
    dw $0005, $01C0, $0000
    dw $0002, $00C0, $0000
    dw $0001, $02C0, $0200
    dw $0018, $02C0, $0000
    dw $0006, $0240, $0000
    dw $0005, $0040, $0000
    dw $0001, $0140, $0100
    dw $0009, $0140, $0000
    dw $0001, $01C0, $0080
    dw $0028, $01C0, $0000
    dw $002E, $0140, $0000
    dw $0001, $01C0, $0080
    dw $0020, $01C0, $0000
    dw $0001, $09C0, $0800
    dw $0002, $01C0, $0000
    dw $0006, $00C0, $0000
    dw $000A, $0040, $0000
    dw $0001, $0240, $0200
    dw $0028, $0240, $0000
    dw $0001, $02C0, $0080
    dw $0006, $02C0, $0000
    dw $0001, $0AC0, $0800
    dw $0002, $0AC0, $0000
    dw $0001, $08C0, $0000
    dw $0001, $01C0, $0100
    dw $0020, $01C0, $0000
    dw $000D, $0140, $0000
    dw $0005, $0040, $0000
    dw $0001, $00C0, $0080
    dw $0003, $00C0, $0000
    dw $0001, $00E0, $0020
    dw $000E, $00E0, $0000
    dw $0022, $0020, $0000
    dw $0001, $0120, $0100
    dw $0002, $0120, $0000
    dw $0004, $0100, $0000
    dw $0006, $0000, $0000
    dw $0001, $0100, $0100
    dw $000E, $0100, $0000
    dw $0001, $0180, $0080
    dw $000C, $0180, $0000
    dw $000F, $0100, $0000
    dw $0001, $8100, $8000
    dw $0021, $8100, $0000
    dw $0001, $8180, $0080
    dw $001A, $8180, $0000
    dw $0004, $8080, $0000
    dw $0005, $8000, $0000
    dw $0001, $0200, $0200
    dw $000C, $0200, $0000
    dw $0051, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_SpeedBooster:
{
    dw $001A, $0000, $0000
    dw $0001, $0200, $0200
    dw $0002, $0200, $0000
    dw $0001, $8200, $8000
    dw $00D0, $8200, $0000
    dw $0001, $8A00, $0800
    dw $0002, $8200, $0000
    dw $0001, $8100, $0100
    dw $0012, $0100, $0000
    dw $0027, $0000, $0000
    dw $0001, $0200, $0200
    dw $0004, $0200, $0000
    dw $000F, $0000, $0000
    dw $0001, $0040, $0040
    dw $0006, $0040, $0000
    dw $000E, $0000, $0000
    dw $0001, $0200, $0200
    dw $0016, $0200, $0000
    dw $004F, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_Dachora:
{
    dw $0006, $0000, $0000
    dw $0001, $0200, $0200
    dw $0001, $0200, $0000
    dw $00D5, $0000, $0000
    dw $0001, $0100, $0100
    dw $0003, $0100, $0000
    dw $000E, $0000, $0000
    dw $0001, $0200, $0200
    dw $0003, $0200, $0000
    dw $002D, $0000, $0000
    dw $0001, $0200, $0200
    dw $0130, $0200, $0000
    dw $00E5, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_RedBrinstarElevator:
{
    dw $0048, $0000, $0000
    dw $0001, $0100, $0100
    dw $0008, $0100, $0000
    dw $0001, $0180, $0080
    dw $0005, $0180, $0000
    dw $000E, $0100, $0000
    dw $001A, $0000, $0000
    dw $0001, $0200, $0200
    dw $0001, $0200, $0000
    dw $0001, $0280, $0080
    dw $0010, $0280, $0000
    dw $0002, $0200, $0000
    dw $0010, $0000, $0000
    dw $0001, $0100, $0100
    dw $0003, $0100, $0000
    dw $003A, $0000, $0000
    dw $0001, $0080, $0080
    dw $000E, $0080, $0000
    dw $0001, $0180, $0100
    dw $0008, $0180, $0000
    dw $0012, $0100, $0000
    dw $019A, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_WreckedShipBasement:
{
    dw $0031, $0000, $0000
    dw $0001, $0100, $0100
    dw $0004, $0100, $0000
    dw $000C, $0000, $0000
    dw $0001, $0200, $0200
    dw $0004, $0200, $0000
    dw $001F, $0000, $0000
    dw $0001, $0200, $0200
    dw $0052, $0200, $0000
    dw $0001, $8200, $8000
    dw $0006, $8200, $0000
    dw $003F, $0200, $0000
    dw $0046, $0000, $0000
    dw $0001, $0100, $0100
    dw $0002, $0100, $0000
    dw $0050, $0000, $0000
    dw $0001, $0100, $0100
    dw $003E, $0100, $0000
    dw $0001, $8100, $8000
    dw $0012, $8100, $0000
    dw $0005, $0100, $0000
    dw $0001, $8100, $8000
    dw $0002, $8100, $0000
    dw $0001, $0100, $0000
    dw $0001, $8100, $8000
    dw $0002, $8100, $0000
    dw $002A, $0100, $0000
    dw $0087, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_LowerNorfairEntrance:
{
    dw $000F, $0000, $0000
    dw $0001, $0200, $0200
    dw $001E, $0200, $0000
    dw $0011, $0000, $0000
    dw $0001, $0200, $0200
    dw $0151, $0200, $0000
    dw $0001, $0280, $0080
    dw $0008, $0280, $0000
    dw $0003, $0080, $0000
    dw $0005, $0000, $0000
    dw $0001, $0100, $0100
    dw $000E, $0100, $0000
    dw $0001, $0180, $0080
    dw $000C, $0180, $0000
    dw $0005, $0080, $0000
    dw $0001, $0280, $0200
    dw $0008, $0280, $0000
    dw $0002, $0200, $0000
    dw $0011, $0000, $0000
    dw $0001, $0080, $0080
    dw $000C, $0080, $0000
    dw $0001, $0180, $0100
    dw $000B, $0180, $0000
    dw $0002, $0100, $0000
    dw $0013, $0000, $0000
    dw $0001, $0080, $0080
    dw $0009, $0080, $0000
    dw $0001, $0280, $0200
    dw $000B, $0280, $0000
    dw $0012, $0000, $0000
    dw $0001, $0100, $0100
    dw $0009, $0100, $0000
    dw $0001, $0180, $0080
    dw $000F, $0180, $0000
    dw $0005, $0100, $0000
    dw $0005, $0000, $0000
    dw $0001, $0200, $0200
    dw $000C, $0200, $0000
    dw $0001, $0280, $0080
    dw $001A, $0280, $0000
    dw $002A, $0200, $0000
    dw $0001, $0280, $0080
    dw $001A, $0280, $0000
    dw $0080, $0200, $0000
    dw $8427 ; Delete
}

DemoInput_EyeDoor:
{
    dw $0009, $0100, $0000
    dw $0012, $0000, $0000
    dw $0001, $0040, $0040
    dw $0006, $0040, $0000
    dw $0003, $0000, $0000
    dw $0001, $0100, $0100
    dw $0002, $0100, $0000
    dw $000A, $0000, $0000
    dw $0001, $2000, $2000
    dw $0005, $2000, $0000
    dw $000A, $0000, $0000
    dw $0001, $0100, $0100
    dw $0008, $0100, $0000
    dw $0001, $0180, $0080
    dw $0005, $0180, $0000
    dw $000B, $0100, $0000
    dw $000D, $0000, $0000
    dw $0001, $0100, $0100
    dw $0002, $0100, $0000
    dw $0001, $0180, $0080
    dw $0005, $0180, $0000
    dw $000A, $0100, $0000
    dw $000D, $0000, $0000
    dw $0001, $0100, $0100
    dw $0002, $0100, $0000
    dw $0001, $0180, $0080
    dw $0006, $0180, $0000
    dw $0016, $0100, $0000
    dw $001A, $0000, $0000
    dw $0001, $0100, $0100
    dw $0001, $0180, $0080
    dw $0009, $0180, $0000
    dw $000E, $0100, $0000
    dw $0012, $0000, $0000
    dw $0001, $0100, $0100
    dw $0005, $0100, $0000
    dw $0020, $0000, $0000
    dw $0001, $0100, $0100
    dw $0005, $0100, $0000
    dw $0001, $0180, $0080
    dw $0006, $0180, $0000
    dw $0012, $0100, $0000
    dw $000C, $0000, $0000
    dw $0001, $0080, $0080
    dw $0005, $0080, $0000
    dw $0008, $0000, $0000
    dw $0001, $0040, $0040
    dw $0005, $0040, $0000
    dw $001E, $0000, $0000
    dw $0001, $0200, $0200
    dw $0006, $0200, $0000
    dw $0006, $0000, $0000
    dw $0001, $0100, $0100
    dw $0006, $0100, $0000
    dw $0042, $0000, $0000
    dw $0001, $0080, $0080
    dw $0006, $0080, $0000
    dw $000E, $0000, $0000
    dw $0001, $0040, $0040
    dw $0003, $0040, $0000
    dw $000A, $0000, $0000
    dw $0001, $0080, $0080
    dw $0009, $0080, $0000
    dw $0018, $0000, $0000
    dw $0001, $0040, $0040
    dw $0005, $0040, $0000
    dw $000A, $0000, $0000
    dw $0001, $0080, $0080
    dw $0004, $0080, $0000
    dw $000A, $0000, $0000
    dw $0001, $0040, $0040
    dw $0005, $0040, $0000
    dw $0063, $0000, $0000
    dw $0001, $0200, $0200
    dw $0006, $0200, $0000
    dw $000E, $0000, $0000
    dw $0001, $0100, $0100
    dw $0007, $0100, $0000
    dw $0001, $0140, $0040
    dw $0002, $0140, $0000
    dw $0003, $0100, $0000
    dw $8427 ; Delete
}

DemoInput_Shinespark:
{
    dw $00A5, $0000, $0000
    dw $8448, DemoInput_Shinespark ; Go to DemoInput_Shinespark

    ; The demo timer expires before these inputs are used
    dw $0078, $0000, $0000
    dw $0001, $0200, $0200
    dw $00A3, $0200, $0000
    dw $0001, $8200, $8000
    dw $005E, $8200, $0000
    dw $0002, $8000, $0000
    dw $0001, $8100, $0100
    dw $0092, $8100, $0000
    dw $000A, $0100, $0000
    dw $0001, $0180, $0080
    dw $0005, $0180, $0000
    dw $000B, $0100, $0000
    dw $001D, $0000, $0000
    dw $0001, $2000, $2000
    dw $0004, $2000, $0000
    dw $0009, $0000, $0000
    dw $0001, $2000, $2000
    dw $0003, $2000, $0000
    dw $000B, $0000, $0000
    dw $0001, $0040, $0040
    dw $0006, $0040, $0000
    dw $00C0, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_MissileDoor:
{
    dw $0021, $0000, $0000
    dw $0001, $0100, $0100
    dw $0027, $0100, $0000
    dw $0036, $0000, $0000
    dw $0001, $2000, $2000
    dw $0004, $2000, $0000
    dw $001C, $0000, $0000
    dw $0001, $0040, $0040
    dw $0006, $0040, $0000
    dw $0008, $0000, $0000
    dw $0001, $0040, $0040
    dw $0006, $0040, $0000
    dw $000E, $0000, $0000
    dw $0001, $0040, $0040
    dw $0006, $0040, $0000
    dw $000A, $0000, $0000
    dw $0001, $0040, $0040
    dw $0006, $0040, $0000
    dw $0006, $0000, $0000
    dw $0001, $0040, $0040
    dw $0007, $0040, $0000
    dw $001A, $0000, $0000
    dw $0001, $8100, $8100
    dw $000E, $8100, $0000
    dw $0015, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_Kraid:
{
    dw $019A, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_FireFleaRoom:
{
    dw $0009, $0000, $0000
    dw $0001, $0200, $0200
    dw $003F, $0200, $0000
    dw $0028, $0000, $0000
    dw $0001, $0200, $0200
    dw $000A, $0200, $0000
    dw $0001, $0280, $0080
    dw $000B, $0280, $0000
    dw $000E, $0200, $0000
    dw $0001, $0240, $0040
    dw $0008, $0240, $0000
    dw $0013, $0200, $0000
    dw $0001, $0280, $0080
    dw $0009, $0280, $0000
    dw $000E, $0200, $0000
    dw $000B, $0000, $0000
    dw $0001, $0200, $0200
    dw $0008, $0200, $0000
    dw $0001, $0280, $0080
    dw $000B, $0280, $0000
    dw $0005, $0200, $0000
    dw $0012, $0000, $0000
    dw $0001, $0200, $0200
    dw $0005, $0200, $0000
    dw $0001, $0280, $0080
    dw $0004, $0280, $0000
    dw $0010, $0200, $0000
    dw $000E, $0000, $0000
    dw $0001, $0400, $0400
    dw $000A, $0400, $0000
    dw $0001, $0420, $0020
    dw $008A, $0420, $0000
    dw $8427 ; Delete
}

DemoInput_ScrewAttack:
{
    dw $0030, $0000, $0000
    dw $0001, $8100, $8100
    dw $001E, $8100, $0000
    dw $0001, $8180, $0080
    dw $000C, $8180, $0000
    dw $001C, $8100, $0000
    dw $0001, $8180, $0080
    dw $0017, $8180, $0000
    dw $002B, $8100, $0000
    dw $0001, $0400, $0400
    dw $0003, $0000, $0000
    dw $0001, $0200, $0200
    dw $0001, $0210, $0010
    dw $009D, $0010, $0000
    dw $8427 ; Delete
}

DemoInput_BrinstarDiagonalRoom:
{
    dw $0021, $0000, $0000
    dw $0001, $0100, $0100
    dw $000E, $0100, $0000
    dw $0001, $0180, $0080
    dw $0012, $0180, $0000
    dw $0034, $0100, $0000
    dw $0010, $0000, $0000
    dw $0001, $0010, $0010
    dw $0008, $0010, $0000
    dw $0001, $0050, $0040
    dw $0017, $0050, $0000
    dw $0004, $0040, $0000
    dw $0001, $0440, $0400
    dw $002C, $0440, $0000
    dw $00AF, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_Unused:
{
    dw $0021, $0000, $0000
    dw $0001, $0200, $0200
    dw $0013, $0200, $0000
    dw $000E, $0000, $0000
    dw $0001, $0080, $0080
    dw $0013, $0080, $0000
    dw $0001, $0280, $0200
    dw $0004, $0280, $0000
    dw $000D, $0200, $0000
    dw $001A, $0000, $0000
    dw $0001, $0080, $0080
    dw $0007, $0080, $0000
    dw $0001, $0280, $0200
    dw $0011, $0280, $0000
    dw $0012, $0200, $0000
    dw $0010, $0000, $0000
    dw $0001, $0100, $0100
    dw $0006, $0100, $0000
    dw $0001, $0180, $0080
    dw $0013, $0180, $0000
    dw $0017, $0100, $0000
    dw $000D, $0000, $0000
    dw $0001, $0400, $0400
    dw $0004, $0400, $0000
    dw $0001, $0600, $0200
    dw $0078, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_PreSporeSpawnHall:
{
    dw $0016, $0000, $0000
    dw $0001, $0200, $0200
    dw $0004, $0200, $0000
    dw $000C, $0000, $0000
    dw $0001, $0100, $0100
    dw $0004, $0100, $0000
    dw $000D, $0000, $0000
    dw $0001, $0100, $0100
    dw $000A, $0100, $0000
    dw $0022, $0100, $0000
    dw $0006, $0000, $0000
    dw $0001, $0080, $0080
    dw $0011, $0080, $0000
    dw $0010, $0000, $0000
    dw $0001, $0200, $0200
    dw $000F, $0200, $0000
    dw $000D, $0000, $0000
    dw $0001, $0100, $0100
    dw $0006, $0100, $0000
    dw $0001, $0180, $0080
    dw $000C, $0180, $0000
    dw $0001, $0080, $0000
    dw $0001, $0280, $0200
    dw $0006, $0280, $0000
    dw $0003, $0200, $0000
    dw $0001, $0000, $0000
    dw $0001, $0100, $0100
    dw $0003, $0100, $0000
    dw $0001, $0140, $0040
    dw $0007, $0140, $0000
    dw $0004, $0140, $0000
    dw $001C, $0140, $0000
    dw $002D, $0040, $0000
    dw $0001, $0440, $0400
    dw $0002, $0040, $0000
    dw $0001, $0050, $0010
    dw $0003, $0050, $0000
    dw $006A, $0010, $0000
    dw $8427 ; Delete
}

DemoInput_GrappleBeam:
{
    dw $0010, $0000, $0000
    dw $0001, $2000, $2000
    dw $000C, $0000, $0000
    dw $0001, $2000, $2000
    dw $000C, $0000, $0000
    dw $0001, $2000, $2000
    dw $000C, $0000, $0000
    dw $0001, $2000, $2000
    dw $000C, $0000, $0000
    dw $0001, $0010, $0010
    dw $0022, $0010, $0000
    dw $0001, $0050, $0040
    dw $0010, $0050, $0000
    dw $0001, $0650, $0600
    dw $0006, $0650, $0000
    dw $0008, $0450, $0000
    dw $0001, $0550, $0100
    dw $0004, $0550, $0000
    dw $0012, $0150, $0000
    dw $0004, $0110, $0000
    dw $0001, $0150, $0040
    dw $000A, $0150, $0000
    dw $0001, $0550, $0400
    dw $000C, $0550, $0000
    dw $000A, $0450, $0000
    dw $0001, $0550, $0100
    dw $0005, $0550, $0000
    dw $000B, $0150, $0000
    dw $0004, $0110, $0000
    dw $0001, $0150, $0040
    dw $000A, $0150, $0000
    dw $0001, $0550, $0400
    dw $000C, $0550, $0000
    dw $000E, $0150, $0000
    dw $0008, $0110, $0000
    dw $0001, $0150, $0040
    dw $0008, $0150, $0000
    dw $0001, $0550, $0400
    dw $000C, $0550, $0000
    dw $000E, $0150, $0000
    dw $0008, $0110, $0000
    dw $0001, $0150, $0040
    dw $0008, $0150, $0000
    dw $0001, $0550, $0400
    dw $000D, $0550, $0000
    dw $000E, $0150, $0000
    dw $0008, $0110, $0000
    dw $0001, $0150, $0040
    dw $0006, $0150, $0000
    dw $0001, $0550, $0400
    dw $000C, $0550, $0000
    dw $0008, $0150, $0000
    dw $0004, $0100, $0000
    dw $0020, $0000, $0000
    dw $0001, $0400, $0400
    dw $0005, $0400, $0000
    dw $0001, $0200, $0200
    dw $0005, $0200, $0000
    dw $0028, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_IceBeam:
{
    dw $0021, $0000, $0000
    dw $0001, $0040, $0040
    dw $0005, $0040, $0000
    dw $0006, $0000, $0000
    dw $0001, $0040, $0040
    dw $0005, $0040, $0000
    dw $0012, $0000, $0000
    dw $0001, $0200, $0200
    dw $0017, $0200, $0000
    dw $001C, $0000, $0000
    dw $0001, $0080, $0080
    dw $000E, $0080, $0000
    dw $0001, $0480, $0400
    dw $0005, $0480, $0000
    dw $000B, $0400, $0000
    dw $0001, $0440, $0040
    dw $0006, $0440, $0000
    dw $0008, $0400, $0000
    dw $0007, $0000, $0000
    dw $0001, $0200, $0200
    dw $001D, $0200, $0000
    dw $0009, $0000, $0000
    dw $0001, $0200, $0200
    dw $000E, $0200, $0000
    dw $0001, $0280, $0080
    dw $001D, $0280, $0000
    dw $0038, $0200, $0000
    dw $0001, $0280, $0080
    dw $0016, $0280, $0000
    dw $002B, $0200, $0000
    dw $0001, $0080, $0080
    dw $0010, $0080, $0000
    dw $0001, $0480, $0400
    dw $0008, $0480, $0000
    dw $0005, $0400, $0000
    dw $0001, $0440, $0040
    dw $0008, $0440, $0000
    dw $0008, $0400, $0000
    dw $0008, $0000, $0000
    dw $0001, $0200, $0200
    dw $002B, $0200, $0000
    dw $0001, $0280, $0080
    dw $0010, $0280, $0000
    dw $0012, $0200, $0000
    dw $005D, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_GauntletEntrance:
{
    dw $0012, $0000, $0000
    dw $0001, $0100, $0100
    dw $0004, $0100, $0000
    dw $00CD, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_AdvancedGrappleBeam:
{
    dw $0032, $0000, $0000
    dw $0001, $2000, $2000
    dw $0007, $2000, $0000
    dw $0006, $0000, $0000
    dw $0001, $2000, $2000
    dw $0004, $2000, $0000
    dw $0008, $0000, $0000
    dw $0001, $2000, $2000
    dw $0007, $2000, $0000
    dw $0005, $0000, $0000
    dw $0001, $2000, $2000
    dw $0005, $2000, $0000
    dw $0010, $0000, $0000
    dw $0001, $0200, $0200
    dw $0015, $0200, $0000
    dw $0001, $0000, $0000
    dw $0001, $0100, $0100
    dw $0005, $0100, $0000
    dw $0003, $0000, $0000
    dw $0001, $0040, $0040
    dw $0013, $0040, $0000
    dw $0001, $0440, $0400
    dw $0011, $0440, $0000
    dw $0022, $0040, $0000
    dw $0001, $0240, $0200
    dw $0013, $0240, $0000
    dw $001F, $0040, $0000
    dw $0001, $0140, $0100
    dw $009F, $0140, $0000
    dw $0070, $0100, $0000
    dw $001E, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_IBJ:
{
    dw $0014, $0000, $0000
    dw $0001, $0100, $0100
    dw $001B, $0100, $0000
    dw $0013, $0000, $0000
    dw $0001, $0080, $0080
    dw $0009, $0080, $0000
    dw $0001, $0480, $0400
    dw $0006, $0480, $0000
    dw $0002, $0080, $0000
    dw $0001, $0480, $0400
    dw $0006, $0480, $0000
    dw $0001, $04C0, $0040
    dw $0002, $04C0, $0000
    dw $0008, $00C0, $0000
    dw $0002, $0080, $0000
    dw $001A, $0000, $0000
    dw $0001, $0040, $0040
    dw $0009, $0040, $0000
    dw $0022, $0000, $0000
    dw $0001, $0040, $0040
    dw $0007, $0040, $0000
    dw $001E, $0000, $0000
    dw $0001, $0040, $0040
    dw $0007, $0040, $0000
    dw $0024, $0000, $0000
    dw $0001, $0040, $0040
    dw $0006, $0040, $0000
    dw $0021, $0000, $0000
    dw $0001, $0040, $0040
    dw $0007, $0040, $0000
    dw $0023, $0000, $0000
    dw $0001, $0040, $0040
    dw $0006, $0040, $0000
    dw $0020, $0000, $0000
    dw $0001, $0040, $0040
    dw $0007, $0040, $0000
    dw $001E, $0000, $0000
    dw $0001, $0040, $0040
    dw $0006, $0040, $0000
    dw $0020, $0000, $0000
    dw $0001, $0040, $0040
    dw $0006, $0040, $0000
    dw $0021, $0000, $0000
    dw $0001, $0040, $0040
    dw $0006, $0040, $0000
    dw $0021, $0000, $0000
    dw $0001, $0040, $0040
    dw $0006, $0040, $0000
    dw $0020, $0000, $0000
    dw $0001, $0040, $0040
    dw $0006, $0040, $0000
    dw $001F, $0000, $0000
    dw $0001, $0040, $0040
    dw $0006, $0040, $0000
    dw $0022, $0000, $0000
    dw $0001, $0040, $0040
    dw $0006, $0040, $0000
    dw $0022, $0000, $0000
    dw $0001, $0040, $0040
    dw $0006, $0040, $0000
    dw $0020, $0000, $0000
    dw $0001, $0040, $0040
    dw $0006, $0040, $0000
    dw $0020, $0000, $0000
    dw $0001, $0040, $0040
    dw $0006, $0040, $0000
    dw $000D, $0000, $0000
    dw $0001, $0100, $0100
    dw $0018, $0100, $0000
    dw $0012, $0000, $0000
    dw $0001, $0800, $0800
    dw $0007, $0800, $0000
    dw $0006, $0000, $0000
    dw $0001, $0800, $0800
    dw $0004, $0800, $0000
    dw $0001, $0000, $0000
    dw $0001, $0800, $0800
    dw $0007, $0000, $0000
    dw $0001, $0200, $0200
    dw $0003, $0200, $0000
    dw $009D, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_SBA:
{
    dw $001A, $0000, $0000
    dw $0001, $2000, $2000
    dw $0008, $2000, $0000
    dw $0006, $0000, $0000
    dw $0001, $2000, $2000
    dw $0006, $2000, $0000
    dw $0006, $0000, $0000
    dw $0001, $2000, $2000
    dw $0006, $2000, $0000
    dw $0008, $0000, $0000
    dw $0001, $0080, $0080
    dw $0003, $0080, $0000
    dw $0001, $0180, $0100
    dw $0023, $0180, $0000
    dw $0007, $0100, $0000
    dw $0010, $0000, $0000
    dw $0001, $0080, $0080
    dw $0010, $0080, $0000
    dw $0001, $0280, $0200
    dw $0007, $0280, $0000
    dw $0001, $02C0, $0040
    dw $0004, $02C0, $0000
    dw $000E, $0240, $0000
    dw $0010, $0040, $0000
    dw $0001, $00C0, $0080
    dw $0008, $00C0, $0000
    dw $0001, $01C0, $0100
    dw $000B, $01C0, $0000
    dw $0014, $0140, $0000
    dw $0015, $0040, $0000
    dw $0001, $0440, $0400
    dw $0006, $0440, $0000
    dw $0040, $0040, $0000
    dw $0034, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_TourianEntrance:
{
    dw $0144, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_CrystalFlash:
{
    dw $0016, $0000, $0000
    dw $0001, $0400, $0400
    dw $0004, $0400, $0000
    dw $0004, $0000, $0000
    dw $0001, $0400, $0400
    dw $0006, $0400, $0000
    dw $0007, $0000, $0000
    dw $0001, $2000, $2000
    dw $0005, $2000, $0000
    dw $0005, $0000, $0000
    dw $0001, $2000, $2000
    dw $0004, $2000, $0000
    dw $0006, $0000, $0000
    dw $0001, $2000, $2000
    dw $0006, $2000, $0000
    dw $0027, $0000, $0000
    dw $0001, $0430, $0430
    dw $0007, $0430, $0000
    dw $0001, $0470, $0040
    dw $000D, $0470, $0000
    dw $0018, $0430, $0000
    dw $0001, $0470, $0040
    dw $0098, $0470, $0000
    dw $0002, $0070, $0000
    dw $0001, $0030, $0000
    dw $0001, $0010, $0000
    dw $00FD, $0000, $0000
    dw $8427
}

DemoInput_landingsite:
{
    dw $0106, $0000, $0000
    dw $0001, $8000, $8000
    dw $001F, $8200, $0000
    dw $0001, $0280, $0080
    dw $0001, $0280, $0000
    dw $0001, $0000, $0000
    dw $0001, $0100, $0100
    dw $0026, $0000, $0000
    dw $0001, $0100, $0100
    dw $0001, $0100, $0000
    dw $0001, $0000, $0000
    dw $0001, $0100, $0100
    dw $0008, $0100, $0000
    dw $0002, $0000, $0000
    dw $0001, $0100, $0100
    dw $0004, $0100, $0000
    dw $0001, $8100, $8000
    dw $0002, $8100, $0000
    dw $0011, $0100, $0000
    dw $0001, $8100, $8000
    dw $0002, $8100, $0000
    dw $0011, $0100, $0000
    dw $0001, $8100, $8000
    dw $0004, $8100, $0000
    dw $0006, $0100, $0000
    dw $0001, $8100, $8000
    dw $0001, $8100, $0000
    dw $0001, $8500, $0400
    dw $0001, $8500, $0000
    dw $0002, $0400, $0000
    dw $000F, $0000, $0000
    dw $8427 ; Delete
} ; PAL landingsite

DemoInput_mockball:
{
    dw $003B, $0000, $0000
    dw $0001, $8000, $8000
    dw $0004, $8000, $0000
    dw $0001, $8100, $0100
    dw $0007, $8100, $0000
    dw $0001, $8120, $0020
    dw $0003, $8120, $0000
    dw $0001, $8130, $0010
    dw $0002, $8130, $0000
    dw $0001, $8120, $0000
    dw $0004, $8100, $0000
    dw $0001, $8130, $0030
    dw $0002, $8130, $0000
    dw $0003, $8120, $0000
    dw $0001, $8100, $0000
    dw $0001, $8110, $0010
    dw $0003, $8110, $0000
    dw $0001, $8120, $0020
    dw $0003, $8120, $0000
    dw $0001, $8110, $0010
    dw $0004, $8110, $0000
    dw $0003, $8100, $0000
    dw $0001, $8120, $0020
    dw $0002, $8120, $0000
    dw $0003, $8100, $0000
    dw $0001, $8190, $0090
    dw $0001, $0190, $0000
    dw $0002, $0180, $0000
    dw $0003, $0100, $0000
    dw $0001, $0180, $0080
    dw $0002, $0180, $0000
    dw $0001, $0580, $0400
    dw $0001, $0580, $0000
    dw $0002, $0480, $0000
    dw $0005, $0080, $0000
    dw $0001, $0480, $0400
    dw $0003, $0580, $0000
    dw $0004, $0180, $0000
    dw $0027, $0100, $0000
    dw $0001, $0900, $0800
    dw $0006, $0810, $0000
    dw $0013, $0010, $0000
    dw $0033, $0000, $0000
    dw $8427 ; Delete
} ; PAL mockball

DemoInput_redtower:
{
    dw $002C, $0000, $0000
    dw $0001, $8000, $8000
    dw $000C, $8000, $0000
    dw $0001, $8200, $0200
    dw $0015, $8200, $0000
    dw $0001, $8000, $0000
    dw $0001, $8100, $0100
    dw $0010, $8100, $0000
    dw $0001, $8180, $0080
    dw $001E, $8180, $0000
    dw $0001, $8280, $0200
    dw $0002, $0200, $0000
    dw $0001, $0280, $0080
    dw $0002, $0280, $0000
    dw $0001, $0180, $0100
    dw $0016, $0180, $0000
    dw $0001, $0080, $0000
    dw $0001, $0280, $0200
    dw $0002, $0200, $0000
    dw $0001, $0280, $0080
    dw $000D, $0280, $0000
    dw $0001, $8280, $8000
    dw $0002, $82C0, $0000
    dw $0001, $C6C0, $4400
    dw $0001, $C4C0, $0000
    dw $0002, $84C0, $0000
    dw $0002, $8400, $0000
    dw $0001, $8600, $0200
    dw $000B, $8200, $0000
    dw $0001, $8280, $0080
    dw $0010, $8280, $0000
    dw $0001, $0280, $0000
    dw $0001, $0180, $0100
    dw $0002, $0100, $0000
    dw $0001, $0180, $0080
    dw $000C, $0180, $0000
    dw $0005, $0100, $0000
    dw $0001, $0120, $0020
    dw $0003, $0120, $0000
    dw $0001, $01A0, $0080
    dw $0003, $01A0, $0000
    dw $0007, $0180, $0000
    dw $0001, $0080, $0000
    dw $0001, $0280, $0200
    dw $000F, $0280, $0000
    dw $0001, $0080, $0000
    dw $0001, $0180, $0100
    dw $0001, $0100, $0000
    dw $0001, $0180, $0080
    dw $0001, $0180, $0000
    dw $0001, $0080, $0000
    dw $0001, $0280, $0200
    dw $0004, $0280, $0000
    dw $0003, $0200, $0000
    dw $0001, $0800, $0800
    dw $0008, $0800, $0000
    dw $0001, $8800, $8000
    dw $0009, $8880, $0000
    dw $0021, $8800, $0000
    dw $0001, $8840, $0040
    dw $0001, $8840, $0000
    dw $0001, $8240, $0200
    dw $0001, $8240, $0000
    dw $0001, $8200, $0000
    dw $0001, $0280, $0080
    dw $000C, $0280, $0000
    dw $0001, $0180, $0100
    dw $0002, $0180, $0000
    dw $0002, $0100, $0000
    dw $0001, $0180, $0080
    dw $0009, $0280, $0000
    dw $0001, $0180, $0100
    dw $0001, $0180, $0000
    dw $0003, $0100, $0000
    dw $0001, $0180, $0080
    dw $0001, $0180, $0000
    dw $0001, $0280, $0200
    dw $0007, $0280, $0000
    dw $0001, $0080, $0000
    dw $0001, $0180, $0100
    dw $0001, $0180, $0000
    dw $0001, $0100, $0000
    dw $0001, $0180, $0080
    dw $0002, $0180, $0000
    dw $0001, $0280, $0200
    dw $0009, $0280, $0000
    dw $000E, $0200, $0000
    dw $0001, $0000, $0000
    dw $0001, $0100, $0100
    dw $0003, $0100, $0000
    dw $0001, $0180, $0080
    dw $0001, $0180, $0000
    dw $0001, $0080, $0000
    dw $0001, $0280, $0200
    dw $0002, $0280, $0000
    dw $0006, $0200, $0000
    dw $0001, $0100, $0100
    dw $0002, $0100, $0000
    dw $0001, $0180, $0080
    dw $0003, $0180, $0000
    dw $0001, $0280, $0200
    dw $000C, $0280, $0000
    dw $0001, $0180, $0100
    dw $0002, $0180, $0000
    dw $0002, $0100, $0000
    dw $0001, $0180, $0080
    dw $001D, $0180, $0000
    dw $0001, $0280, $0200
    dw $0001, $0280, $0000
    dw $0002, $0200, $0000
    dw $0001, $0280, $0080
    dw $0001, $0280, $0000
    dw $0001, $0180, $0100
    dw $0006, $0180, $0000
    dw $0001, $0100, $0000
    dw $0001, $0140, $0040
    dw $0004, $0140, $0000
    dw $0001, $8040, $8000
    dw $0003, $8000, $0000
    dw $003E, $0000, $0000
    dw $0001, $4000, $4000
    dw $0000, $4000, $0000
    dw $8427 ; Delete
} ; PAL redtower

DemoInput_lavadive:
{
    dw $0026, $0000, $0000
    dw $0001, $8000, $8000
    dw $0002, $8000, $0000
    dw $0001, $8100, $0100
    dw $001D, $8100, $0000
    dw $0003, $8000, $0000
    dw $0001, $8200, $0200
    dw $0012, $8200, $0000
    dw $0001, $0280, $0080
    dw $0001, $0280, $0000
    dw $0002, $0200, $0000
    dw $0001, $0600, $0400
    dw $0002, $0600, $0000
    dw $0001, $0480, $0080
    dw $0001, $0480, $0000
    dw $0005, $0080, $0000
    dw $0001, $0480, $0400
    dw $0001, $0480, $0000
    dw $0001, $0680, $0200
    dw $0002, $0680, $0000
    dw $00B5, $0200, $0000
    dw $0001, $0280, $0080
    dw $0006, $0280, $0000
    dw $000A, $0200, $0000
    dw $0001, $8200, $8000
    dw $000C, $8200, $0000
    dw $0001, $8220, $0020
    dw $0005, $8220, $0000
    dw $0009, $8200, $0000
    dw $0003, $8000, $0000
    dw $0001, $0000, $0000
    dw $0001, $8000, $8000
    dw $0001, $0000, $0000
    dw $0001, $0200, $0200
    dw $0005, $8200, $0000
    dw $0001, $8280, $0080
    dw $0003, $8280, $0000
    dw $0006, $8200, $0000
    dw $0001, $8220, $0020
    dw $0005, $8220, $0000
    dw $0001, $82A0, $0080
    dw $002C, $8280, $0000
    dw $0007, $8200, $0000
    dw $0001, $8220, $0020
    dw $0004, $8220, $0000
    dw $0004, $8020, $0000
    dw $0001, $8120, $0100
    dw $0003, $8120, $0000
    dw $0009, $8100, $0000
    dw $0001, $8180, $0080
    dw $000A, $0180, $0000
    dw $0001, $0080, $0000
    dw $0001, $0280, $0200
    dw $001B, $0280, $0000
    dw $0001, $0180, $0100
    dw $0001, $0180, $0000
    dw $0001, $0100, $0000
    dw $0001, $0180, $0080
    dw $0068, $0180, $0000
    dw $0004, $0100, $0000
    dw $0001, $0200, $0200
    dw $0002, $0200, $0000
    dw $0001, $0280, $0080
    dw $0002, $0280, $0000
    dw $0001, $0180, $0100
    dw $0008, $0100, $0000
    dw $0001, $0000, $0000
    dw $0001, $0200, $0200
    dw $0002, $0200, $0000
    dw $0001, $0280, $0080
    dw $000B, $0280, $0000
    dw $0001, $0080, $0000
    dw $0001, $0180, $0100
    dw $000A, $0180, $0000
    dw $0001, $0080, $0000
    dw $0001, $0200, $0200
    dw $0001, $0200, $0000
    dw $0001, $0280, $0080
    dw $0026, $0280, $0000
    dw $000E, $0200, $0000
    dw $0001, $0100, $0100
    dw $0001, $0100, $0000
    dw $0001, $0180, $0080
    dw $0002, $0180, $0000
    dw $0001, $0280, $0200
    dw $000A, $0280, $0000
    dw $0004, $0200, $0000
    dw $0001, $0220, $0020
    dw $0002, $0220, $0000
    dw $0002, $0020, $0000
    dw $002E, $0000, $0000
    dw $8427 ; Delete
} ; PAL lavadive

DemoInput_ggg:
{
    dw $002C, $0000, $0000
    dw $0001, $2000, $2000
    dw $0004, $2000, $0000
    dw $0003, $0000, $0000
    dw $0001, $2000, $2000
    dw $0002, $2000, $0000
    dw $0001, $A000, $8000
    dw $0003, $A000, $0000
    dw $000A, $8000, $0000
    dw $0001, $8010, $0010
    dw $001A, $8110, $0000
    dw $0001, $8010, $0000
    dw $0001, $8210, $0200
    dw $001B, $8210, $0000
    dw $0001, $8290, $0080
    dw $0005, $8290, $0000
    dw $000E, $8210, $0000
    dw $0001, $8250, $0040
    dw $0003, $8250, $0000
    dw $0001, $8150, $0100
    dw $0001, $8150, $0000
    dw $000C, $8110, $0000
    dw $0001, $8100, $0000
    dw $0006, $8000, $0000
    dw $0007, $0000, $0000
    dw $0001, $0200, $0200
    dw $0003, $0200, $0000
    dw $0001, $4200, $4000
    dw $0005, $4000, $0000
    dw $0045, $0000, $0000
    dw $8427 ; Delete
} ; PAL ggg

DemoInput_babyskip:
{
    dw $001F, $0000, $0000
    dw $0001, $0040, $0040
    dw $0004, $0040, $0000
    dw $0005, $0000, $0000
    dw $0001, $8000, $8000
    dw $0011, $8000, $0000
    dw $0001, $8200, $0200
    dw $001F, $8200, $0000
    dw $0001, $8280, $0080
    dw $001A, $8280, $0000
    dw $0011, $8200, $0000
    dw $0001, $8280, $0080
    dw $0005, $8280, $0000
    dw $0001, $0100, $0100
    dw $0002, $0100, $0000
    dw $0001, $0180, $0080
    dw $0010, $0180, $0000
    dw $0003, $0100, $0000
    dw $0001, $8100, $8000
    dw $0001, $8100, $0000
    dw $0001, $8000, $0000
    dw $0001, $8200, $0200
    dw $0003, $8200, $0000
    dw $0001, $8600, $0400
    dw $000B, $8400, $0000
    dw $0001, $8100, $0100
    dw $0003, $8100, $0000
    dw $0001, $8800, $0800
    dw $0001, $8200, $0200
    dw $0002, $8200, $0000
    dw $0001, $8600, $0400
    dw $0001, $8000, $0000
    dw $0001, $8100, $0100
    dw $0003, $8100, $0000
    dw $0001, $8400, $0400
    dw $0001, $8200, $0200
    dw $0004, $8200, $0000
    dw $0001, $8100, $0100
    dw $0006, $8100, $0000
    dw $0001, $8400, $0400
    dw $0007, $8400, $0000
    dw $0007, $8000, $0000
    dw $0001, $8400, $0400
    dw $0004, $8400, $0000
    dw $0004, $8000, $0000
    dw $0001, $8400, $0400
    dw $0005, $8400, $0000
    dw $0001, $8500, $0100
    dw $0004, $8100, $0000
    dw $000E, $0100, $0000
    dw $0001, $0140, $0040
    dw $0001, $0140, $0000
    dw $0001, $0040, $0000
    dw $0001, $4000, $4000
    dw $0001, $4000, $0000
    dw $0002, $0000, $0000
    dw $0001, $0800, $0800
    dw $0005, $0800, $0000
    dw $0007, $0000, $0000
    dw $0001, $0200, $0200
    dw $0008, $0200, $0000
    dw $0062, $0000, $0000
    dw $0001, $8000, $8000
    dw $0001, $8200, $0200
    dw $000B, $8200, $0000
    dw $0001, $8000, $0000
    dw $0001, $8100, $0100
    dw $0010, $8100, $0000
    dw $0001, $0180, $0080
    dw $0001, $0180, $0000
    dw $0001, $0100, $0000
    dw $0001, $0200, $0200
    dw $0001, $0200, $0000
    dw $0024, $0000, $0000
    dw $0001, $8000, $8000
    dw $0011, $8000, $0000
    dw $0001, $8100, $0100
    dw $0021, $8100, $0000
    dw $0002, $0100, $0000
    dw $0089, $0000, $0000
    dw $0001, $0200, $0200
    dw $0001, $0200, $0000
    dw $0178, $0000, $0000
    dw $0001, $0040, $0040
    dw $0003, $0040, $0000
    dw $0024, $0000, $0000
    dw $0001, $8000, $8000
    dw $002E, $8000, $0000
    dw $0001, $8200, $0200
    dw $0022, $8200, $0000
    dw $0001, $8280, $0080
    dw $0018, $8280, $0000
    dw $0005, $8200, $0000
    dw $000A, $0200, $0000
    dw $0001, $8200, $8000
    dw $0001, $8280, $0080
    dw $0001, $8280, $0000
    dw $0001, $82C0, $0040
    dw $0002, $82C0, $0000
    dw $0001, $84C0, $0400
    dw $0001, $84C0, $0000
    dw $0003, $0400, $0000
    dw $0001, $8480, $8080
    dw $000B, $8480, $0000
    dw $0007, $8400, $0000
    dw $0001, $8200, $0200
    dw $0005, $8200, $0000
    dw $0001, $8220, $0020
    dw $0007, $8220, $0000
    dw $0001, $8260, $0040
    dw $0002, $8260, $0000
    dw $0002, $8220, $0000
    dw $0002, $8020, $0000
    dw $0001, $8120, $0100
    dw $0001, $8120, $0000
    dw $000A, $8100, $0000
    dw $0001, $8000, $0000
    dw $0001, $8200, $0200
    dw $0006, $8200, $0000
    dw $0001, $8280, $0080
    dw $0014, $8280, $0000
    dw $0003, $8200, $0000
    dw $0002, $0200, $0000
    dw $0001, $8200, $8000
    dw $0014, $8200, $0000
    dw $0001, $8240, $0040
    dw $0006, $8240, $0000
    dw $0008, $8200, $0000
    dw $0001, $8000, $0000
    dw $0001, $8100, $0100
    dw $000F, $8100, $0000
    dw $0001, $8180, $0080
    dw $0002, $8180, $0000
    dw $0001, $8080, $0000
    dw $0001, $8280, $0200
    dw $0011, $8280, $0000
    dw $0003, $8200, $0000
    dw $0001, $0200, $0000
    dw $0001, $8200, $8000
    dw $0005, $8200, $0000
    dw $0001, $8220, $0020
    dw $0009, $8220, $0000
    dw $0001, $8260, $0040
    dw $0006, $8260, $0000
    dw $000D, $8220, $0000
    dw $0001, $8200, $0000
    dw $0001, $8000, $0000
    dw $0001, $8100, $0100
    dw $0012, $8100, $0000
    dw $0002, $8000, $0000
    dw $0001, $8200, $0200
    dw $0001, $8200, $0000
    dw $0001, $8280, $0080
    dw $0012, $8280, $0000
    dw $0001, $8240, $0040
    dw $0005, $8240, $0000
    dw $0013, $8200, $0000
    dw $0001, $8600, $0400
    dw $0005, $8400, $0000
    dw $0001, $8440, $0040
    dw $0005, $8440, $0000
    dw $0004, $8400, $0000
    dw $0001, $8100, $0100
    dw $0004, $8100, $0000
    dw $0007, $8000, $0000
    dw $0001, $8100, $0100
    dw $0004, $8100, $0000
    dw $0001, $8180, $0080
    dw $0002, $8180, $0000
    dw $0001, $8280, $0200
    dw $0018, $8280, $0000
    dw $000A, $8200, $0000
    dw $0010, $0200, $0000
    dw $8427 ; Delete
} ; PAL babyskip
else ; END OF PAL DEMOS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DemoInput_LandingSite:
;;; $8ACE: Instruction list - demo input - landing site ;;;
{
    dw $0121, $0000, $0000
    dw $0001, $0200, $0200 ;       <
    dw $0006, $0200, $0000 ;       <
    dw $0001, $0A00, $0800 ;     ^ <
    dw $0003, $0A00, $0000 ;     ^ <
    dw $0013, $0200, $0000 ;       <
    dw $0001, $0280, $0080 ;       < A
    dw $0028, $0280, $0000 ;       < A
    dw $0032, $0200, $0000 ;       <
    dw $0024, $0000, $0000
    dw $0001, $0100, $0100 ;        >
    dw $0005, $0100, $0000 ;        >
    dw $000F, $0000, $0000
    dw $0001, $0200, $0200 ;       <
    dw $0005, $0200, $0000 ;       <
    dw $0022, $0000, $0000
    dw $0001, $0200, $0200 ;       <
    dw $004A, $0200, $0000 ;       <
    dw $0005, $0000, $0000
    dw $0001, $0100, $0100 ;        >
    dw $0005, $0100, $0000 ;        >
    dw $0045, $0000, $0000
    dw $0001, $0200, $0200 ;       <
    dw $0003, $0200, $0000 ;       <
    dw $0001, $8200, $8000 ; B     <
    dw $0049, $8200, $0000 ; B     <
    dw $0001, $8A00, $0800 ; B   ^ <
    dw $0003, $8A00, $0000 ; B   ^ <
    dw $0001, $0200, $0000 ;       <
    dw $0002, $0000, $0000
    dw $0001, $0100, $0100 ;        >
    dw $0007, $0100, $0000 ;        >
    dw $000B, $0000, $0000
    dw $0001, $0010, $0010 ;            R
    dw $001F, $0010, $0000 ;            R
    dw $0001, $0210, $0200 ;       <    R
    dw $0005, $0210, $0000 ;       <    R
    dw $001D, $0010, $0000 ;            R
    dw $0001, $0200, $0200 ;       <
    dw $005E, $0200, $0000 ;       <
    dw $0030, $0000, $0000
    dw $0001, $0200, $0200 ;       <
    dw $002E, $0200, $0000 ;       <
    dw $001F, $0000, $0000
    dw $0001, $0100, $0100 ;        >
    dw $0004, $0100, $0000 ;        >
    dw $0040, $0000, $0000
    dw $0001, $0200, $0200 ;       <
    dw $0004, $0200, $0000 ;       <
    dw $0028, $0000, $0000
    dw $0001, $0040, $0040 ;          X
    dw $0006, $0040, $0000 ;          X
    dw $002B, $0000, $0000
    dw $0001, $0200, $0200 ;       <
    dw $0011, $0200, $0000 ;       <
    dw $0007, $0000, $0000
    dw $0001, $0200, $0200 ;       <
    dw $0004, $0200, $0000 ;       <
    dw $0014, $0100, $0000 ;        >
    dw $0001, $0140, $0040 ;        > X
    dw $0003, $0140, $0000 ;        > X
    dw $8427 ; Delete
}

DemoInput_PseudoScrewAttack:
;;; $8C3E: Instruction list - demo input - pseudo screw attack ;;;
{
    dw $0016, $0000, $0000
    dw $0001, $0800, $0800 ;     ^
    dw $0003, $0800, $0000 ;     ^
    dw $0005, $0000, $0000
    dw $0001, $0800, $0800 ;     ^
    dw $0006, $0800, $0000 ;     ^
    dw $0016, $0000, $0000
    dw $0001, $0200, $0200 ;       <
    dw $0005, $0200, $0000 ;       <
    dw $000B, $0000, $0000
    dw $0001, $0040, $0040 ;          X
    dw $004E, $0040, $0000 ;          X
    dw $0001, $0240, $0200 ;       <  X
    dw $000D, $0240, $0000 ;       <  X
    dw $0001, $02C0, $0080 ;       < AX
    dw $0014, $02C0, $0000 ;       < AX
    dw $0014, $0240, $0000 ;       <  X
    dw $0020, $0040, $0000 ;          X
    dw $0001, $0140, $0100 ;        > X
    dw $000F, $0140, $0000 ;        > X
    dw $0001, $01C0, $0080 ;        >AX
    dw $0006, $01C0, $0000 ;        >AX
    dw $0002, $00C0, $0000 ;         AX
    dw $0001, $02C0, $0200 ;       < AX
    dw $001E, $02C0, $0000 ;       < AX
    dw $0008, $0240, $0000 ;       <  X
    dw $0006, $0040, $0000 ;          X
    dw $0001, $0140, $0100 ;        > X
    dw $000B, $0140, $0000 ;        > X
    dw $0001, $01C0, $0080 ;        >AX
    dw $0023, $01C0, $0000 ;        >AX
    dw $003A, $0140, $0000 ;        > X
    dw $0001, $01C0, $0080 ;        >AX
    dw $0013, $01C0, $0000 ;        >AX
    dw $0001, $09C0, $0800 ;     ^  >AX
    dw $0002, $01C0, $0000 ;        >AX
    dw $0008, $00C0, $0000 ;         AX
    dw $000D, $0040, $0000 ;          X
    dw $0001, $0240, $0200 ;       <  X
    dw $0029, $0240, $0000 ;       <  X
    dw $0001, $02C0, $0080 ;       < AX
    dw $0007, $02C0, $0000 ;       < AX
    dw $0001, $0AC0, $0800 ;     ^ < AX
    dw $0002, $0AC0, $0000 ;     ^ < AX
    dw $0001, $08C0, $0000 ;     ^   AX
    dw $0001, $01C0, $0100 ;        >AX
    dw $0028, $01C0, $0000 ;        >AX
    dw $0010, $0140, $0000 ;        > X
    dw $0006, $0040, $0000 ;          X
    dw $0001, $00C0, $0080 ;         AX
    dw $0004, $00C0, $0000 ;         AX
    dw $0001, $00E0, $0020 ;         AXL
    dw $0012, $00E0, $0000 ;         AXL
    dw $002A, $0020, $0000 ;           L
    dw $0001, $0120, $0100 ;        >  L
    dw $0002, $0120, $0000 ;        >  L
    dw $0005, $0100, $0000 ;        >
    dw $0008, $0000, $0000
    dw $0001, $0100, $0100 ;        >
    dw $0011, $0100, $0000 ;        >
    dw $0001, $0180, $0080 ;        >A
    dw $000F, $0180, $0000 ;        >A
    dw $0013, $0100, $0000 ;        >
    dw $0001, $8100, $8000 ; B      >
    dw $0029, $8100, $0000 ; B      >
    dw $0001, $8180, $0080 ; B      >A
    dw $0020, $8180, $0000 ; B      >A
    dw $0005, $8080, $0000 ; B       A
    dw $0006, $8000, $0000 ; B
    dw $0001, $0200, $0200 ;       <
    dw $000F, $0200, $0000 ;       <
    dw $0065, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_SpeedBooster:
;;; $8DF0: Instruction list - demo input - speed booster ;;;
{
    dw $0020, $0000, $0000
    dw $0001, $0200, $0200 ;       <
    dw $0002, $0200, $0000 ;       <
    dw $0001, $8200, $8000 ; B     <
    dw $00EE, $8200, $0000 ; B     <
    dw $0001, $8A00, $0800 ; B   ^ <
    dw $0002, $8200, $0000 ; B     <
    dw $0001, $8100, $0100 ; B      >
    dw $0016, $0100, $0000 ;        >
    dw $0031, $0000, $0000
    dw $0001, $0200, $0200 ;       <
    dw $0005, $0200, $0000 ;       <
    dw $0013, $0000, $0000
    dw $0001, $0040, $0040 ;          X
    dw $0008, $0040, $0000 ;          X
    dw $0011, $0000, $0000
    dw $0001, $0200, $0200 ;       <
    dw $001B, $0200, $0000 ;       <
    dw $0063, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_Dachora:
;;; $8E64: Instruction list - demo input - dachora ;;;
{
    dw $0008, $0000, $0000
    dw $0001, $0200, $0200 ;       <
    dw $0001, $0200, $0000 ;       <
    dw $010A, $0000, $0000
    dw $0001, $0100, $0100 ;        >
    dw $0004, $0100, $0000 ;        >
    dw $0011, $0000, $0000
    dw $0001, $0200, $0200 ;       <
    dw $0004, $0200, $0000 ;       <
    dw $0038, $0000, $0000
    dw $0001, $0200, $0200 ;       <
    dw $0164, $0200, $0000 ;       <
    dw $011E, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_RedBrinstarElevator:
;;; $8EB4: Instruction list - demo input - Red Brinstar -> Crateria elevator ;;;
{
    dw $005A, $0000, $0000
    dw $0001, $0100, $0100 ;        >
    dw $000A, $0100, $0000 ;        >
    dw $0001, $0180, $0080 ;        >A
    dw $0006, $0180, $0000 ;        >A
    dw $0011, $0100, $0000 ;        >
    dw $0020, $0000, $0000
    dw $0001, $0200, $0200 ;       <
    dw $0001, $0200, $0000 ;       <
    dw $0001, $0280, $0080 ;       < A
    dw $0014, $0280, $0000 ;       < A
    dw $0003, $0200, $0000 ;       <
    dw $0014, $0000, $0000
    dw $0001, $0100, $0100 ;        >
    dw $0004, $0100, $0000 ;        >
    dw $0048, $0000, $0000
    dw $0001, $0080, $0080 ;         A
    dw $0011, $0080, $0000 ;         A
    dw $0001, $0180, $0100 ;        >A
    dw $000A, $0180, $0000 ;        >A
    dw $0016, $0100, $0000 ;        >
    dw $0200, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_WreckedShipBasement:
;;; $8F3A: Instruction list - demo input - pre Phantoon hall ;;;
{
    dw $003D, $0000, $0000
    dw $0001, $0100, $0100 ;        >
    dw $0005, $0100, $0000 ;        >
    dw $000F, $0000, $0000
    dw $0001, $0200, $0200 ;       <
    dw $0005, $0200, $0000 ;       <
    dw $0027, $0000, $0000
    dw $0001, $0200, $0200 ;       <
    dw $0066, $0200, $0000 ;       <
    dw $0001, $8200, $8000 ; B     <
    dw $0007, $8200, $0000 ; B     <
    dw $004F, $0200, $0000 ;       <
    dw $0057, $0000, $0000
    dw $0001, $0100, $0100 ;        >
    dw $0002, $0100, $0000 ;        >
    dw $0064, $0000, $0000
    dw $0001, $0100, $0100 ;        >
    dw $004E, $0100, $0000 ;        >
    dw $0001, $8100, $8000 ; B      >
    dw $0017, $8100, $0000 ; B      >
    dw $0006, $0100, $0000 ;        >
    dw $0001, $8100, $8000 ; B      >
    dw $0003, $8100, $0000 ; B      >
    dw $0001, $0100, $0000 ;        >
    dw $0001, $8100, $8000 ; B      >
    dw $0002, $8100, $0000 ; B      >
    dw $0034, $0100, $0000 ;        >
    dw $00A9, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_LowerNorfairEntrance:
;;; $8FE4: Instruction list - demo input - Lower Norfair entrance ;;;
{
    dw $0013, $0000, $0000
    dw $0001, $0200, $0200 ;       <
    dw $0012, $0200, $0000 ;       <
    dw $0029, $0000, $0000
    dw $0001, $8000, $8000 ; B
    dw $0015, $8000, $0000 ; B
    dw $000B, $0000, $0000
    dw $0001, $8000, $8000 ; B
    dw $001F, $8000, $0000 ; B
    dw $0001, $8200, $0200 ; B     <
    dw $0030, $8200, $0000 ; B     <
    dw $0003, $8000, $0000 ; B
    dw $0001, $8200, $0200 ; B     <
    dw $0007, $8200, $0000 ; B     <
    dw $0045, $8000, $0000 ; B
    dw $0001, $8200, $0200 ; B     <
    dw $0091, $8200, $0000 ; B     <
    dw $000A, $8000, $0000 ; B
    dw $0001, $8200, $0200 ; B     <
    dw $0006, $8200, $0000 ; B     <
    dw $0036, $8000, $0000 ; B
    dw $0001, $8200, $0200 ; B     <
    dw $0090, $8200, $0000 ; B     <
    dw $0011, $0200, $0000 ;       <
    dw $0001, $0280, $0080 ;       < A
    dw $0017, $0280, $0000 ;       < A
    dw $0008, $0080, $0000 ;         A
    dw $0001, $0180, $0100 ;        >A
    dw $000E, $0180, $0000 ;        >A
    dw $000F, $0100, $0000 ;        >
    dw $0002, $0000, $0000
    dw $0001, $0080, $0080 ;         A
    dw $001C, $0080, $0000 ;         A
    dw $0001, $0280, $0200 ;       < A
    dw $000C, $0280, $0000 ;       < A
    dw $0002, $0200, $0000 ;       <
    dw $000F, $0000, $0000
    dw $0001, $0080, $0080 ;         A
    dw $0011, $0080, $0000 ;         A
    dw $0001, $0180, $0100 ;        >A
    dw $000F, $0180, $0000 ;        >A
    dw $0002, $0080, $0000 ;         A
    dw $0010, $0000, $0000
    dw $0001, $0080, $0080 ;         A
    dw $0001, $0280, $0200 ;       < A
    dw $0014, $0280, $0000 ;       < A
    dw $0015, $0200, $0000 ;       <
    dw $0001, $8200, $8000 ; B     <
    dw $000E, $8200, $0000 ; B     <
    dw $0006, $0200, $0000 ;       <
    dw $0001, $0280, $0080 ;       < A
    dw $0004, $0280, $0000 ;       < A
    dw $0011, $0200, $0000 ;       <
    dw $0001, $8200, $8000 ; B     <
    dw $0024, $8200, $0000 ; B     <
    dw $0002, $0200, $0000 ;       <
    dw $0014, $0200, $0000 ;       <
    dw $0007, $0000, $0000
    dw $0001, $0100, $0100 ;        >
    dw $0009, $0100, $0000 ;        >
    dw $002D, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_EyeDoor:
;;; $9154: Instruction list - demo input - eye door ;;;
{
    dw $000B, $0100, $0000 ;        >
    dw $0017, $0000, $0000
    dw $0001, $0040, $0040 ;          X
    dw $0008, $0040, $0000 ;          X
    dw $0004, $0000, $0000
    dw $0001, $0100, $0100 ;        >
    dw $0002, $0100, $0000 ;        >
    dw $000C, $0000, $0000
    dw $0001, $2000, $2000 ;   s
    dw $0006, $2000, $0000 ;   s
    dw $000D, $0000, $0000
    dw $0001, $0100, $0100 ;        >
    dw $000A, $0100, $0000 ;        >
    dw $0001, $0180, $0080 ;        >A
    dw $0006, $0180, $0000 ;        >A
    dw $000E, $0100, $0000 ;        >
    dw $0010, $0000, $0000
    dw $0001, $0100, $0100 ;        >
    dw $0002, $0100, $0000 ;        >
    dw $0001, $0180, $0080 ;        >A
    dw $0006, $0180, $0000 ;        >A
    dw $000D, $0100, $0000 ;        >
    dw $0010, $0000, $0000
    dw $0001, $0100, $0100 ;        >
    dw $0002, $0100, $0000 ;        >
    dw $0001, $0180, $0080 ;        >A
    dw $0008, $0180, $0000 ;        >A
    dw $001C, $0100, $0000 ;        >
    dw $0020, $0000, $0000
    dw $0001, $0100, $0100 ;        >
    dw $0001, $0180, $0080 ;        >A
    dw $000B, $0180, $0000 ;        >A
    dw $0012, $0100, $0000 ;        >
    dw $0016, $0000, $0000
    dw $0001, $0100, $0100 ;        >
    dw $0006, $0100, $0000 ;        >
    dw $0028, $0000, $0000
    dw $0001, $0100, $0100 ;        >
    dw $0006, $0100, $0000 ;        >
    dw $0001, $0180, $0080 ;        >A
    dw $0008, $0180, $0000 ;        >A
    dw $0017, $0100, $0000 ;        >
    dw $000F, $0000, $0000
    dw $0001, $0080, $0080 ;         A
    dw $0006, $0080, $0000 ;         A
    dw $000A, $0000, $0000
    dw $0001, $0040, $0040 ;          X
    dw $0006, $0040, $0000 ;          X
    dw $0025, $0000, $0000
    dw $0001, $0200, $0200 ;       <
    dw $0007, $0200, $0000 ;       <
    dw $0008, $0000, $0000
    dw $0001, $0100, $0100 ;        >
    dw $0007, $0100, $0000 ;        >
    dw $0052, $0000, $0000
    dw $0001, $0080, $0080 ;         A
    dw $0007, $0080, $0000 ;         A
    dw $0011, $0000, $0000
    dw $0001, $0040, $0040 ;          X
    dw $0004, $0040, $0000 ;          X
    dw $000C, $0000, $0000
    dw $0001, $0080, $0080 ;         A
    dw $000B, $0080, $0000 ;         A
    dw $001E, $0000, $0000
    dw $0001, $0040, $0040 ;          X
    dw $0006, $0040, $0000 ;          X
    dw $000D, $0000, $0000
    dw $0001, $0080, $0080 ;         A
    dw $0005, $0080, $0000 ;         A
    dw $000D, $0000, $0000
    dw $0001, $0040, $0040 ;          X
    dw $0006, $0040, $0000 ;          X
    dw $007C, $0000, $0000
    dw $0001, $0200, $0200 ;       <
    dw $0007, $0200, $0000 ;       <
    dw $0011, $0000, $0000
    dw $0001, $0100, $0100 ;        >
    dw $0009, $0100, $0000 ;        >
    dw $0001, $0140, $0040 ;        > X
    dw $0003, $0140, $0000 ;        > X
    dw $0004, $0100, $0000 ;        >
    dw $8427 ; Delete
}

DemoInput_Shinespark:
;;; $933C: Instruction list - demo input - shinespark ;;;
{
    dw $00A5, $0000, $0000
    dw $8448, DemoInput_Shinespark ; Go to DemoInput_Shinespark

    ; The demo timer expires before these inputs are used
    dw $0096, $0000, $0000
    dw $0001, $0200, $0200 ;       <
    dw $00CC, $0200, $0000 ;       <
    dw $0001, $8200, $8000 ; B     <
    dw $0076, $8200, $0000 ; B     <
    dw $0002, $8000, $0000 ; B
    dw $0001, $8100, $0100 ; B      >
    dw $00B6, $8100, $0000 ; B      >
    dw $000C, $0100, $0000 ;        >
    dw $0001, $0180, $0080 ;        >A
    dw $0006, $0180, $0000 ;        >A
    dw $000E, $0100, $0000 ;        >
    dw $0024, $0000, $0000
    dw $0001, $2000, $2000 ;   s
    dw $0005, $2000, $0000 ;   s
    dw $000B, $0000, $0000
    dw $0001, $2000, $2000 ;   s
    dw $0004, $2000, $0000 ;   s
    dw $000E, $0000, $0000
    dw $0001, $0040, $0040 ;          X
    dw $0007, $0040, $0000 ;          X
    dw $00F0, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_MissileDoor:
;;; $93CC: Instruction list - demo input - missile door ;;;
{
    dw $0029, $0000, $0000
    dw $0001, $0100, $0100 ;        >
    dw $0031, $0100, $0000 ;        >
    dw $0044, $0000, $0000
    dw $0001, $2000, $2000 ;   s
    dw $0005, $2000, $0000 ;   s
    dw $0023, $0000, $0000
    dw $0001, $0040, $0040 ;          X
    dw $0008, $0040, $0000 ;          X
    dw $000A, $0000, $0000
    dw $0001, $0040, $0040 ;          X
    dw $0008, $0040, $0000 ;          X
    dw $0011, $0000, $0000
    dw $0001, $0040, $0040 ;          X
    dw $0007, $0040, $0000 ;          X
    dw $000D, $0000, $0000
    dw $0001, $0040, $0040 ;          X
    dw $0008, $0040, $0000 ;          X
    dw $0007, $0000, $0000
    dw $0001, $0040, $0040 ;          X
    dw $0009, $0040, $0000 ;          X
    dw $0020, $0000, $0000
    dw $0001, $8100, $8100 ; B      >
    dw $0011, $8100, $0000 ; B      >
    dw $001A, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_Kraid:
;;; $9464: Instruction list - demo input - Kraid ;;;
{
    dw $0200, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_FireFleaRoom:
;;; $946C: Instruction list - demo input - fireflea room ;;;
{
    dw $002B, $0000, $0000
    dw $0001, $0200, $0200 ;       <
    dw $0046, $0200, $0000 ;       <
    dw $0037, $0000, $0000
    dw $0001, $0200, $0200 ;       <
    dw $000C, $0200, $0000 ;       <
    dw $0001, $0280, $0080 ;       < A
    dw $0013, $0280, $0000 ;       < A
    dw $0013, $0200, $0000 ;       <
    dw $0001, $0240, $0040 ;       <  X
    dw $000B, $0240, $0000 ;       <  X
    dw $0005, $0200, $0000 ;       <
    dw $0001, $0280, $0080 ;       < A
    dw $0015, $0280, $0000 ;       < A
    dw $0025, $0200, $0000 ;       <
    dw $0001, $0280, $0080 ;       < A
    dw $000E, $0280, $0000 ;       < A
    dw $0021, $0200, $0000 ;       <
    dw $0001, $0280, $0080 ;       < A
    dw $0009, $0280, $0000 ;       < A
    dw $001D, $0200, $0000 ;       <
    dw $0008, $0000, $0000
    dw $0001, $0020, $0020 ;           L
    dw $0001, $0020, $0000 ;           L
    dw $0001, $0420, $0400 ;      v    L
    dw $00C4, $0020, $0000 ;           L
    dw $8427 ; Delete
}

DemoInput_ScrewAttack:
;;; $950A: Instruction list - demo input - screw attack ;;;
{
    dw $0030, $0000, $0000
    dw $0001, $8100, $8100 ; B      >
    dw $001E, $8100, $0000 ; B      >
    dw $0001, $8180, $0080 ; B      >A
    dw $000C, $8180, $0000 ; B      >A
    dw $001C, $8100, $0000 ; B      >
    dw $0001, $8180, $0080 ; B      >A
    dw $0017, $8180, $0000 ; B      >A
    dw $002B, $8100, $0000 ; B      >
    dw $0001, $0400, $0400 ;      v
    dw $0003, $0000, $0000
    dw $0001, $0200, $0200 ;       <
    dw $0001, $0210, $0010 ;       <    R
    dw $009D, $0010, $0000 ;            R
    dw $8427 ; Delete
}

DemoInput_BrinstarDiagonalRoom:
;;; $9560: Instruction list - demo input - Brinstar diagonal room ;;;
{
    dw $0029, $0000, $0000
    dw $0001, $0100, $0100 ;        >
    dw $0012, $0100, $0000 ;        >
    dw $0001, $0180, $0080 ;        >A
    dw $0016, $0180, $0000 ;        >A
    dw $0041, $0100, $0000 ;        >
    dw $0014, $0000, $0000
    dw $0001, $0010, $0010 ;            R
    dw $000A, $0010, $0000 ;            R
    dw $0001, $0050, $0040 ;          X R
    dw $001D, $0050, $0000 ;          X R
    dw $0005, $0040, $0000 ;          X
    dw $0001, $0440, $0400 ;      v   X
    dw $0037, $0440, $0000 ;      v   X
    dw $00DB, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_Unused:
;;; $95BC: Instruction list - demo input - unused ;;;
{
    dw $0029, $0000, $0000
    dw $0001, $0200, $0200 ;       <
    dw $0018, $0200, $0000 ;       <
    dw $0011, $0000, $0000
    dw $0001, $0080, $0080 ;         A
    dw $0018, $0080, $0000 ;         A
    dw $0001, $0280, $0200 ;       < A
    dw $0005, $0280, $0000 ;       < A
    dw $0010, $0200, $0000 ;       <
    dw $0020, $0000, $0000
    dw $0001, $0080, $0080 ;         A
    dw $0009, $0080, $0000 ;         A
    dw $0001, $0280, $0200 ;       < A
    dw $0015, $0280, $0000 ;       < A
    dw $0016, $0200, $0000 ;       <
    dw $0014, $0000, $0000
    dw $0001, $0100, $0100 ;        >
    dw $0007, $0100, $0000 ;        >
    dw $0001, $0180, $0080 ;        >A
    dw $0018, $0180, $0000 ;        >A
    dw $001D, $0100, $0000 ;        >
    dw $0010, $0000, $0000
    dw $0001, $0400, $0400 ;      v
    dw $0005, $0400, $0000 ;      v
    dw $0001, $0600, $0200 ;      v<
    dw $0096, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_PreSporeSpawnHall:
;;; $965A: Instruction list - demo input - pre Spore Spawn hall ;;;
{
    dw $001B, $0000, $0000
    dw $0001, $0200, $0200 ;       <
    dw $0005, $0200, $0000 ;       <
    dw $000F, $0000, $0000
    dw $0001, $0100, $0100 ;        >
    dw $0005, $0100, $0000 ;        >
    dw $0010, $0000, $0000
    dw $0001, $0100, $0100 ;        >
    dw $000D, $0100, $0000 ;        >
    dw $002A, $0100, $0000 ;        >
    dw $0007, $0000, $0000
    dw $0001, $0080, $0080 ;         A
    dw $0015, $0080, $0000 ;         A
    dw $001E, $0000, $0000
    dw $0001, $0200, $0200 ;       <
    dw $0013, $0200, $0000 ;       <
    dw $0010, $0000, $0000
    dw $0001, $0100, $0100 ;        >
    dw $0008, $0100, $0000 ;        >
    dw $0001, $0180, $0080 ;        >A
    dw $000F, $0180, $0000 ;        >A
    dw $0001, $0080, $0000 ;         A
    dw $0001, $0280, $0200 ;       < A
    dw $0007, $0280, $0000 ;       < A
    dw $0004, $0200, $0000 ;       <
    dw $0001, $0000, $0000
    dw $0001, $0100, $0100 ;        >
    dw $0004, $0100, $0000 ;        >
    dw $0001, $0140, $0040 ;        > X
    dw $0009, $0140, $0000 ;        > X
    dw $0005, $0140, $0000 ;        > X
    dw $004C, $0040, $0000 ;          X
    dw $0001, $0440, $0400 ;      v   X
    dw $0003, $0040, $0000 ;          X
    dw $0001, $0050, $0010 ;          X R
    dw $0004, $0050, $0000 ;          X R
    dw $0084, $0010, $0000 ;            R
    dw $8427 ; Delete
}

DemoInput_GrappleBeam:
;;; $973A: Instruction list - demo input - grapple beam ;;;
{
    dw $0010, $0000, $0000
    dw $0001, $2000, $2000 ;   s
    dw $000C, $0000, $0000
    dw $0001, $2000, $2000 ;   s
    dw $000C, $0000, $0000
    dw $0001, $2000, $2000 ;   s
    dw $000C, $0000, $0000
    dw $0001, $2000, $2000 ;   s
    dw $000C, $0000, $0000
    dw $0001, $0010, $0010 ;            R
    dw $0022, $0010, $0000 ;            R
    dw $0001, $0050, $0040 ;          X R
    dw $0010, $0050, $0000 ;          X R
    dw $0001, $0650, $0600 ;      v<  X R
    dw $0006, $0650, $0000 ;      v<  X R
    dw $000C, $0450, $0000 ;      v   X R
    dw $0001, $0550, $0100 ;      v > X R
    dw $0004, $0550, $0000 ;      v > X R
    dw $0012, $0150, $0000 ;        > X R
    dw $0006, $0110, $0000 ;        >   R
    dw $0001, $0150, $0040 ;        > X R
    dw $0007, $0150, $0000 ;        > X R
    dw $0001, $0550, $0400 ;      v > X R
    dw $0004, $0550, $0000 ;      v > X R
    dw $0016, $0450, $0000 ;      v   X R
    dw $0001, $0550, $0100 ;      v > X R
    dw $0005, $0550, $0000 ;      v > X R
    dw $000B, $0150, $0000 ;        > X R
    dw $0007, $0110, $0000 ;        >   R
    dw $0001, $0150, $0040 ;        > X R
    dw $000A, $0150, $0000 ;        > X R
    dw $0001, $0550, $0400 ;      v > X R
    dw $000C, $0550, $0000 ;      v > X R
    dw $000E, $0150, $0000 ;        > X R
    dw $000A, $0110, $0000 ;        >   R
    dw $0001, $0150, $0040 ;        > X R
    dw $0008, $0150, $0000 ;        > X R
    dw $0001, $0550, $0400 ;      v > X R
    dw $000C, $0550, $0000 ;      v > X R
    dw $000E, $0150, $0000 ;        > X R
    dw $000A, $0110, $0000 ;        >   R
    dw $0001, $0150, $0040 ;        > X R
    dw $0008, $0150, $0000 ;        > X R
    dw $0001, $0550, $0400 ;      v > X R
    dw $000D, $0550, $0000 ;      v > X R
    dw $000E, $0150, $0000 ;        > X R
    dw $000A, $0110, $0000 ;        >   R
    dw $0001, $0150, $0040 ;        > X R
    dw $0009, $0150, $0000 ;        > X R
    dw $0001, $0550, $0400 ;      v > X R
    dw $000C, $0550, $0000 ;      v > X R
    dw $0008, $0150, $0000 ;        > X R
    dw $0004, $0100, $0000 ;        >
    dw $0020, $0000, $0000
    dw $0001, $0400, $0400 ;      v
    dw $0005, $0400, $0000 ;      v
    dw $0001, $0200, $0200 ;       <
    dw $0005, $0200, $0000 ;       <
    dw $0028, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_IceBeam:
;;; $989E: Instruction list - demo input - ice beam ;;;
{
    dw $0021, $0000, $0000
    dw $0001, $0040, $0040 ;          X
    dw $0005, $0040, $0000 ;          X
    dw $0006, $0000, $0000
    dw $0001, $0040, $0040 ;          X
    dw $0005, $0040, $0000 ;          X
    dw $0012, $0000, $0000
    dw $0001, $0200, $0200 ;       <
    dw $0017, $0200, $0000 ;       <
    dw $001C, $0000, $0000
    dw $0001, $0080, $0080 ;         A
    dw $000E, $0080, $0000 ;         A
    dw $0001, $0480, $0400 ;      v  A
    dw $0005, $0480, $0000 ;      v  A
    dw $000B, $0400, $0000 ;      v
    dw $0001, $0440, $0040 ;      v   X
    dw $0006, $0440, $0000 ;      v   X
    dw $0008, $0400, $0000 ;      v
    dw $0007, $0000, $0000
    dw $0001, $0200, $0200 ;       <
    dw $001D, $0200, $0000 ;       <
    dw $0009, $0000, $0000
    dw $0001, $0200, $0200 ;       <
    dw $000E, $0200, $0000 ;       <
    dw $0001, $0280, $0080 ;       < A
    dw $001D, $0280, $0000 ;       < A
    dw $0038, $0200, $0000 ;       <
    dw $0001, $0280, $0080 ;       < A
    dw $0016, $0280, $0000 ;       < A
    dw $002B, $0200, $0000 ;       <
    dw $0001, $0080, $0080 ;         A
    dw $0010, $0080, $0000 ;         A
    dw $0001, $0480, $0400 ;      v  A
    dw $0008, $0480, $0000 ;      v  A
    dw $0005, $0400, $0000 ;      v
    dw $0001, $0440, $0040 ;      v   X
    dw $0008, $0440, $0000 ;      v   X
    dw $0008, $0400, $0000 ;      v
    dw $0008, $0000, $0000
    dw $0001, $0200, $0200 ;       <
    dw $002B, $0200, $0000 ;       <
    dw $0001, $0280, $0080 ;       < A
    dw $0010, $0280, $0000 ;       < A
    dw $0012, $0200, $0000 ;       <
    dw $005D, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_GauntletEntrance:
;;; $99AE: Instruction list - demo input - gauntlet entrance ;;;
{
    dw $0016, $0000, $0000
    dw $0001, $0100, $0100 ;        >
    dw $0005, $0100, $0000 ;        >
    dw $0100, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_AdvancedGrappleBeam:
;;; $99C8: Instruction list - demo input - advanced grapple beam ;;;
{
    dw $003F, $0000, $0000
    dw $0001, $0100, $0100 ;        >
    dw $0005, $0100, $0000 ;        >
    dw $001E, $0000, $0000
    dw $0001, $0200, $0200 ;       <
    dw $0005, $0200, $0000 ;       <
    dw $0016, $0000, $0000
    dw $0001, $2000, $2000 ;   s
    dw $0004, $2000, $0000 ;   s
    dw $000D, $0000, $0000
    dw $0001, $2000, $2000 ;   s
    dw $0005, $2000, $0000 ;   s
    dw $0008, $0000, $0000
    dw $0001, $2000, $2000 ;   s
    dw $0006, $2000, $0000 ;   s
    dw $0007, $0000, $0000
    dw $0001, $2000, $2000 ;   s
    dw $0005, $2000, $0000 ;   s
    dw $002F, $0000, $0000
    dw $0001, $0200, $0200 ;       <
    dw $0014, $0200, $0000 ;       <
    dw $0002, $0000, $0000
    dw $0001, $0100, $0100 ;        >
    dw $0006, $0100, $0000 ;        >
    dw $0009, $0000, $0000
    dw $0001, $0040, $0040 ;          X
    dw $0019, $0040, $0000 ;          X
    dw $0001, $0440, $0400 ;      v   X
    dw $0005, $0440, $0000 ;      v   X
    dw $0001, $0540, $0100 ;      v > X
    dw $0002, $0540, $0000 ;      v > X
    dw $0006, $0140, $0000 ;        > X
    dw $0027, $0040, $0000 ;          X
    dw $0001, $0240, $0200 ;       <  X
    dw $000D, $0240, $0000 ;       <  X
    dw $0034, $0040, $0000 ;          X
    dw $0001, $0140, $0100 ;        > X
    dw $0007, $0140, $0000 ;        > X
    dw $0037, $0040, $0000 ;          X
    dw $0001, $0240, $0200 ;       <  X
    dw $000F, $0240, $0000 ;       <  X
    dw $002F, $0040, $0000 ;          X
    dw $0001, $0140, $0100 ;        > X
    dw $00B1, $0140, $0000 ;        > X
    dw $0001, $01C0, $0080 ;        >AX
    dw $000B, $01C0, $0000 ;        >AX
    dw $00BA, $0180, $0000 ;        >A
    dw $0003, $0100, $0000 ;        >
    dw $0046, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_IBJ:
;;; $9AF0: Instruction list - demo input - IBJ ;;;
{
    dw $0019, $0000, $0000
    dw $0001, $0100, $0100 ;        >
    dw $0022, $0100, $0000 ;        >
    dw $0018, $0000, $0000
    dw $0001, $0080, $0080 ;         A
    dw $000B, $0080, $0000 ;         A
    dw $0001, $0480, $0400 ;      v  A
    dw $0007, $0480, $0000 ;      v  A
    dw $0002, $0080, $0000 ;         A
    dw $0001, $0480, $0400 ;      v  A
    dw $0008, $0480, $0000 ;      v  A
    dw $0001, $04C0, $0040 ;      v  AX
    dw $0003, $04C0, $0000 ;      v  AX
    dw $000A, $00C0, $0000 ;         AX
    dw $0002, $0080, $0000 ;         A
    dw $0020, $0000, $0000
    dw $0001, $0040, $0040 ;          X
    dw $000B, $0040, $0000 ;          X
    dw $0025, $0000, $0000
    dw $0001, $0040, $0040 ;          X
    dw $0009, $0040, $0000 ;          X
    dw $0026, $0000, $0000
    dw $0001, $0040, $0040 ;          X
    dw $0009, $0040, $0000 ;          X
    dw $0026, $0000, $0000
    dw $0001, $0040, $0040 ;          X
    dw $0008, $0040, $0000 ;          X
    dw $0027, $0000, $0000
    dw $0001, $0040, $0040 ;          X
    dw $0009, $0040, $0000 ;          X
    dw $0028, $0000, $0000
    dw $0001, $0040, $0040 ;          X
    dw $0008, $0040, $0000 ;          X
    dw $0028, $0000, $0000
    dw $0001, $0040, $0040 ;          X
    dw $0009, $0040, $0000 ;          X
    dw $0026, $0000, $0000
    dw $0001, $0040, $0040 ;          X
    dw $0008, $0040, $0000 ;          X
    dw $0028, $0000, $0000
    dw $0001, $0040, $0040 ;          X
    dw $0007, $0040, $0000 ;          X
    dw $0029, $0000, $0000
    dw $0001, $0040, $0040 ;          X
    dw $0007, $0040, $0000 ;          X
    dw $0029, $0000, $0000
    dw $0001, $0040, $0040 ;          X
    dw $0007, $0040, $0000 ;          X
    dw $0028, $0000, $0000
    dw $0001, $0040, $0040 ;          X
    dw $0008, $0040, $0000 ;          X
    dw $0027, $0000, $0000
    dw $0001, $0040, $0040 ;          X
    dw $0007, $0040, $0000 ;          X
    dw $002A, $0000, $0000
    dw $0001, $0040, $0040 ;          X
    dw $0007, $0040, $0000 ;          X
    dw $002A, $0000, $0000
    dw $0001, $0040, $0040 ;          X
    dw $0007, $0040, $0000 ;          X
    dw $0028, $0000, $0000
    dw $0001, $0040, $0040 ;          X
    dw $0007, $0040, $0000 ;          X
    dw $0028, $0000, $0000
    dw $0001, $0040, $0040 ;          X
    dw $0007, $0040, $0000 ;          X
    dw $0010, $0000, $0000
    dw $0001, $0100, $0100 ;        >
    dw $001E, $0100, $0000 ;        >
    dw $0017, $0000, $0000
    dw $0001, $0800, $0800 ;     ^
    dw $0009, $0800, $0000 ;     ^
    dw $0008, $0000, $0000
    dw $0001, $0800, $0800 ;     ^
    dw $0005, $0800, $0000 ;     ^
    dw $0001, $0000, $0000
    dw $0001, $0800, $0800 ;     ^
    dw $0009, $0000, $0000
    dw $0001, $0200, $0200 ;       <
    dw $0004, $0200, $0000 ;       <
    dw $00C4, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_SBA:
;;; $9CD8: Instruction list - demo input - SBA ;;;
{
    dw $001A, $0000, $0000
    dw $0001, $2000, $2000 ;   s
    dw $0008, $2000, $0000 ;   s
    dw $0006, $0000, $0000
    dw $0001, $2000, $2000 ;   s
    dw $0006, $2000, $0000 ;   s
    dw $0006, $0000, $0000
    dw $0001, $2000, $2000 ;   s
    dw $0006, $2000, $0000 ;   s
    dw $0008, $0000, $0000
    dw $0001, $0080, $0080 ;         A
    dw $0003, $0080, $0000 ;         A
    dw $0001, $0180, $0100 ;        >A
    dw $0023, $0180, $0000 ;        >A
    dw $0007, $0100, $0000 ;        >
    dw $0010, $0000, $0000
    dw $0001, $0080, $0080 ;         A
    dw $0010, $0080, $0000 ;         A
    dw $0001, $0280, $0200 ;       < A
    dw $0007, $0280, $0000 ;       < A
    dw $0001, $02C0, $0040 ;       < AX
    dw $0004, $02C0, $0000 ;       < AX
    dw $000E, $0240, $0000 ;       <  X
    dw $0010, $0040, $0000 ;          X
    dw $0001, $00C0, $0080 ;         AX
    dw $0008, $00C0, $0000 ;         AX
    dw $0001, $01C0, $0100 ;        >AX
    dw $000B, $01C0, $0000 ;        >AX
    dw $0014, $0140, $0000 ;        > X
    dw $0015, $0040, $0000 ;          X
    dw $0001, $0440, $0400 ;      v   X
    dw $0006, $0440, $0000 ;      v   X
    dw $0040, $0040, $0000 ;          X
    dw $0034, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_TourianEntrance:
;;; $9DA6: Instruction list - demo input - Tourian entrance ;;;
{
    dw $0195, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_CrystalFlash:
;;; $9DAE: Instruction list - demo input - crystal flash ;;;
{
    dw $001B, $0000, $0000
    dw $0001, $0400, $0400 ;      v
    dw $0005, $0400, $0000 ;      v
    dw $0005, $0000, $0000
    dw $0001, $0400, $0400 ;      v
    dw $0007, $0400, $0000 ;      v
    dw $0009, $0000, $0000
    dw $0001, $2000, $2000 ;   s
    dw $0006, $2000, $0000 ;   s
    dw $0006, $0000, $0000
    dw $0001, $2000, $2000 ;   s
    dw $0005, $2000, $0000 ;   s
    dw $0008, $0000, $0000
    dw $0001, $2000, $2000 ;   s
    dw $0007, $2000, $0000 ;   s
    dw $0031, $0000, $0000
    dw $0001, $0430, $0430 ;      v    LR
    dw $0009, $0430, $0000 ;      v    LR
    dw $0001, $0470, $0040 ;      v   XLR
    dw $0010, $0470, $0000 ;      v   XLR
    dw $001E, $0430, $0000 ;      v    LR
    dw $0001, $0470, $0040 ;      v   XLR
    dw $00BE, $0470, $0000 ;      v   XLR
    dw $0003, $0070, $0000 ;          XLR
    dw $0001, $0030, $0000 ;           LR
    dw $0001, $0010, $0000 ;            R
    dw $013C, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_mockball:
{
    dw $0018, $0000, $0000
    dw $0001, $8000, $8000
    dw $0006, $8000, $0000
    dw $0001, $8100, $0100
    dw $003D, $8100, $0000
    dw $0001, $8180, $0080
    dw $0003, $0180, $0000
    dw $0003, $0100, $0000
    dw $0001, $0500, $0400
    dw $0001, $0500, $0000
    dw $0001, $0580, $0080
    dw $0003, $0480, $0000
    dw $0006, $0080, $0000
    dw $0001, $0480, $0400
    dw $0002, $0580, $0000
    dw $0008, $0180, $0000
    dw $0030, $0100, $0000
    dw $0001, $0000, $0000
    dw $0001, $0800, $0800
    dw $0008, $0800, $0000
    dw $0041, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_lavadive:
{
    dw $0041, $0000, $0000
    dw $0001, $8000, $8000
    dw $0003, $8000, $0000
    dw $0001, $8100, $0100
    dw $0012, $8100, $0000
    dw $0003, $8000, $0000
    dw $0001, $8200, $0200
    dw $0014, $8200, $0000
    dw $0001, $8280, $0080
    dw $0002, $0280, $0000
    dw $0001, $0200, $0000
    dw $0001, $0600, $0400
    dw $0002, $0600, $0000
    dw $0001, $0400, $0000
    dw $0001, $0480, $0080
    dw $0001, $0480, $0000
    dw $0004, $0080, $0000
    dw $0001, $0480, $0400
    dw $0002, $0480, $0000
    dw $0001, $0680, $0200
    dw $0001, $0680, $0000
    dw $0002, $0280, $0000
    dw $00CA, $0200, $0000
    dw $0001, $0280, $0080
    dw $0005, $0280, $0000
    dw $000B, $0200, $0000
    dw $0001, $8200, $8000
    dw $001D, $8200, $0000
    dw $0001, $8220, $0020
    dw $0007, $8220, $0000
    dw $0001, $8200, $0000
    dw $0001, $8280, $0080
    dw $0006, $8280, $0000
    dw $000C, $8200, $0000
    dw $0001, $8220, $0020
    dw $0006, $8220, $0000
    dw $0001, $82A0, $0080
    dw $0037, $8280, $0000
    dw $0006, $8200, $0000
    dw $0001, $8220, $0020
    dw $000B, $8020, $0000
    dw $0001, $8120, $0100
    dw $0006, $8120, $0000
    dw $0009, $8100, $0000
    dw $0001, $0100, $0000
    dw $0001, $0180, $0080
    dw $000D, $0180, $0000
    dw $0001, $0280, $0200
    dw $000D, $0280, $0000
    dw $0001, $0080, $0000
    dw $0001, $0180, $0100
    dw $0003, $0100, $0000
    dw $0001, $0180, $0080
    dw $0002, $0180, $0000
    dw $0001, $0280, $0200
    dw $000C, $0280, $0000
    dw $0001, $0080, $0000
    dw $0001, $0180, $0100
    dw $0002, $0100, $0000
    dw $0001, $0180, $0080
    dw $0003, $0180, $0000
    dw $0001, $0080, $0000
    dw $0001, $0280, $0200
    dw $0010, $0280, $0000
    dw $0001, $0180, $0100
    dw $0001, $0180, $0000
    dw $0003, $0100, $0000
    dw $0001, $0180, $0080
    dw $005C, $0180, $0000
    dw $0022, $0100, $0000
    dw $0001, $0200, $0200
    dw $0004, $0200, $0000
    dw $0001, $0280, $0080
    dw $0002, $0280, $0000
    dw $0001, $0180, $0100
    dw $0001, $0180, $0000
    dw $000A, $0100, $0000
    dw $0001, $0000, $0000
    dw $0001, $0200, $0200
    dw $0001, $0200, $0000
    dw $0001, $0280, $0080
    dw $0010, $0280, $0000
    dw $0001, $0080, $0000
    dw $0001, $0180, $0100
    dw $000A, $0180, $0000
    dw $0001, $0080, $0000
    dw $0001, $0280, $0200
    dw $0002, $0280, $0000
    dw $0002, $0200, $0000
    dw $0001, $0280, $0080
    dw $002A, $0280, $0000
    dw $0010, $0200, $0000
    dw $0001, $0000, $0000
    dw $0001, $0100, $0100
    dw $0002, $0100, $0000
    dw $0001, $0180, $0080
    dw $0002, $0180, $0000
    dw $0001, $0080, $0000
    dw $0001, $0280, $0200
    dw $000B, $0280, $0000
    dw $0001, $8200, $8000
    dw $0005, $C200, $0000
    dw $0002, $8200, $0000
    dw $0001, $0200, $0000
    dw $0006, $0000, $0000
    dw $8427 ; Delete
} ; lavadive

DemoInput_redtower:
{
    dw $002A, $0000, $0000
    dw $0001, $8200, $8200
    dw $0015, $8200, $0000
    dw $0004, $8000, $0000
    dw $0001, $8100, $0100
    dw $000D, $8100, $0000
    dw $0001, $8180, $0080
    dw $002D, $8180, $0000
    dw $0001, $0000, $0000
    dw $0001, $0200, $0200
    dw $0002, $0200, $0000
    dw $0001, $0280, $0080
    dw $0003, $0280, $0000
    dw $0001, $0180, $0100
    dw $001B, $0180, $0000
    dw $0001, $0080, $0000
    dw $0001, $0200, $0200
    dw $0002, $0200, $0000
    dw $0001, $0280, $0080
    dw $000E, $0280, $0000
    dw $0001, $02C0, $0040
    dw $0003, $02C0, $0000
    dw $0001, $04C0, $0400
    dw $0004, $04C0, $0000
    dw $0001, $0480, $0000
    dw $0002, $0400, $0000
    dw $0001, $0600, $0200
    dw $0001, $0200, $0000
    dw $0001, $8200, $8000
    dw $000A, $8200, $0000
    dw $0001, $8280, $0080
    dw $0014, $8280, $0000
    dw $0001, $0080, $0000
    dw $0001, $0100, $0100
    dw $0001, $0100, $0000
    dw $0001, $0180, $0080
    dw $0010, $0180, $0000
    dw $0006, $0100, $0000
    dw $0001, $0120, $0020
    dw $0005, $0120, $0000
    dw $0001, $01A0, $0080
    dw $0002, $01A0, $0000
    dw $000B, $0180, $0000
    dw $0002, $0080, $0000
    dw $0001, $0280, $0200
    dw $0013, $0280, $0000
    dw $0001, $0080, $0000
    dw $0001, $0100, $0100
    dw $0002, $0100, $0000
    dw $0001, $0180, $0080
    dw $0002, $0180, $0000
    dw $0001, $0080, $0000
    dw $0001, $0280, $0200
    dw $0008, $0280, $0000
    dw $0001, $0A00, $0800
    dw $0001, $0A00, $0000
    dw $0013, $0800, $0000
    dw $0001, $0880, $0080
    dw $0009, $0880, $0000
    dw $001D, $0800, $0000
    dw $0001, $0840, $0040
    dw $0002, $0840, $0000
    dw $0001, $0240, $0200
    dw $0001, $0200, $0000
    dw $0001, $0280, $0080
    dw $000F, $0280, $0000
    dw $0001, $0080, $0000
    dw $0001, $0180, $0100
    dw $0002, $0180, $0000
    dw $0002, $0100, $0000
    dw $0001, $0180, $0080
    dw $0001, $0180, $0000
    dw $0001, $0080, $0000
    dw $0001, $0280, $0200
    dw $0008, $0280, $0000
    dw $0001, $0180, $0100
    dw $0001, $0180, $0000
    dw $0002, $0100, $0000
    dw $0001, $0180, $0080
    dw $0003, $0180, $0000
    dw $0001, $0080, $0000
    dw $0001, $0280, $0200
    dw $0009, $0280, $0000
    dw $0001, $0180, $0100
    dw $0002, $0100, $0000
    dw $0001, $0180, $0080
    dw $0004, $0180, $0000
    dw $0001, $0280, $0200
    dw $000A, $0280, $0000
    dw $0013, $0200, $0000
    dw $0001, $0000, $0000
    dw $0001, $0100, $0100
    dw $0004, $0100, $0000
    dw $0001, $0180, $0080
    dw $0001, $0180, $0000
    dw $0001, $0080, $0000
    dw $0001, $0280, $0200
    dw $0004, $0280, $0000
    dw $0006, $0200, $0000
    dw $0001, $0100, $0100
    dw $0002, $0100, $0000
    dw $0001, $0180, $0080
    dw $0004, $0180, $0000
    dw $0001, $0080, $0000
    dw $0001, $0280, $0200
    dw $000B, $0280, $0000
    dw $0001, $0080, $0000
    dw $0001, $0180, $0100
    dw $0002, $0180, $0000
    dw $0002, $0100, $0000
    dw $0001, $0180, $0080
    dw $0024, $0180, $0000
    dw $0001, $0280, $0200
    dw $0004, $0200, $0000
    dw $0001, $0280, $0080
    dw $0002, $0280, $0000
    dw $0001, $0180, $0100
    dw $0008, $0180, $0000
    dw $0005, $0100, $0000
    dw $0001, $0120, $0020
    dw $0001, $0120, $0000
    dw $0004, $0020, $0000
    dw $0039, $0000, $0000
    dw $8427 ; Delete
} ; redtower

DemoInput_ggg:
{
    dw $002B, $0000, $0000
    dw $0001, $2000, $2000
    dw $000F, $2000, $0000
    dw $000B, $0000, $0000
    dw $0001, $2000, $2000
    dw $0001, $2000, $0000
    dw $0001, $A000, $8000
    dw $0004, $A000, $0000
    dw $0007, $8000, $0000
    dw $0001, $8010, $0010
    dw $0007, $8010, $0000
    dw $0001, $8110, $0100
    dw $001D, $8110, $0000
    dw $0004, $8010, $0000
    dw $0001, $8210, $0200
    dw $001F, $8210, $0000
    dw $0001, $8290, $0080
    dw $0006, $8290, $0000
    dw $000F, $8210, $0000
    dw $0001, $8250, $0040
    dw $0004, $8250, $0000
    dw $0001, $8050, $0000
    dw $0001, $8110, $0100
    dw $0015, $8110, $0000
    dw $0003, $8100, $0000
    dw $0003, $8000, $0000
    dw $0001, $8200, $0200
    dw $0006, $8200, $0000
    dw $0023, $0000, $0000
    dw $8427 ; Delete
}

DemoInput_landingsite:
{
    dw $016D, $0000, $0000
    dw $0001, $8000, $8000
    dw $0020, $8000, $0000
    dw $0001, $8200, $0200
    dw $0020, $8200, $0000
    dw $0001, $0280, $0080
    dw $0001, $0280, $0000
    dw $0001, $0200, $0000
    dw $0001, $0000, $0000
    dw $0001, $0100, $0100
    dw $0002, $0100, $0000
    dw $0023, $0000, $0000
    dw $0001, $8000, $8000
    dw $0002, $8000, $0000
    dw $0001, $8200, $0200
    dw $0003, $8200, $0000
    dw $0001, $0280, $0080
    dw $0001, $0200, $0000
    dw $0002, $0000, $0000
    dw $0001, $0100, $0100
    dw $0001, $0100, $0000
    dw $0038, $0000, $0000
    dw $0001, $0100, $0100
    dw $0002, $0100, $0000
    dw $0002, $0000, $0000
    dw $0001, $0100, $0100
    dw $0005, $0100, $0000
    dw $0002, $0000, $0000
    dw $0001, $0100, $0100
    dw $0009, $0100, $0000
    dw $0001, $8100, $8000
    dw $0002, $8100, $0000
    dw $0016, $0100, $0000
    dw $0001, $8100, $8000
    dw $0002, $8100, $0000
    dw $0012, $0100, $0000
    dw $0001, $8100, $8000
    dw $0002, $8100, $0000
    dw $000D, $0100, $0000
    dw $0001, $8100, $8000
    dw $0002, $8100, $0000
    dw $0001, $8500, $0400
    dw $0001, $8500, $0000
    dw $0003, $8400, $0000
    dw $0048, $0000, $0000
    dw $8427 ; Delete
} ; landingsite

DemoInput_babyskip:
{
    dw $0030, $0000, $0000
    dw $0001, $8040, $8040
    dw $0003, $8040, $0000
    dw $0025, $8000, $0000
    dw $0001, $8200, $0200
    dw $0023, $8200, $0000
    dw $0001, $8280, $0080
    dw $0017, $8280, $0000
    dw $0019, $8200, $0000
    dw $0001, $8280, $0080
    dw $0002, $8280, $0000
    dw $0002, $0280, $0000
    dw $0002, $0000, $0000
    dw $0001, $0100, $0100
    dw $0004, $0100, $0000
    dw $0001, $0180, $0080
    dw $001C, $0180, $0000
    dw $0008, $0100, $0000
    dw $0001, $0000, $0000
    dw $0001, $0200, $0200
    dw $000A, $8200, $0000
    dw $000F, $8000, $0000
    dw $0001, $8200, $0200
    dw $001B, $8200, $0000
    dw $0001, $8000, $0000
    dw $0001, $8100, $0100
    dw $002E, $8100, $0000
    dw $0001, $8000, $0000
    dw $0001, $8200, $0200
    dw $0002, $8200, $0000
    dw $003D, $8000, $0000
    dw $01B4, $0000, $0000
    dw $0001, $0400, $0400
    dw $0004, $0400, $0000
    dw $00CB, $0000, $0000
    dw $0001, $8800, $8800
    dw $0003, $8800, $0000
    dw $0020, $8000, $0000
    dw $0001, $8040, $0040
    dw $0006, $8040, $0000
    dw $0046, $8000, $0000
    dw $0001, $8200, $0200
    dw $0025, $8200, $0000
    dw $0001, $8280, $0080
    dw $0003, $8280, $0000
    dw $0001, $8480, $0400
    dw $004A, $8480, $0000
    dw $0002, $8400, $0000
    dw $0006, $8000, $0000
    dw $0001, $8200, $0200
    dw $000A, $8200, $0000
    dw $0001, $8280, $0080
    dw $0011, $8280, $0000
    dw $0024, $8200, $0000
    dw $0001, $8600, $0400
    dw $0005, $8400, $0000
    dw $0001, $8440, $0040
    dw $0003, $8440, $0000
    dw $0001, $8540, $0100
    dw $0001, $8140, $0000
    dw $000D, $8100, $0000
    dw $0001, $8000, $0000
    dw $0001, $8200, $0200
    dw $0002, $8200, $0000
    dw $0001, $8280, $0080
    dw $0013, $8280, $0000
    dw $001B, $8200, $0000
    dw $0001, $8240, $0040
    dw $0007, $8240, $0000
    dw $0006, $8200, $0000
    dw $0002, $8000, $0000
    dw $0001, $8100, $0100
    dw $0014, $8100, $0000
    dw $0002, $8000, $0000
    dw $0001, $8280, $0280
    dw $0010, $8280, $0000
    dw $0012, $8200, $0000
    dw $0001, $8210, $0010
    dw $0006, $8210, $0000
    dw $0001, $8250, $0040
    dw $0006, $8250, $0000
    dw $0001, $8210, $0000
    dw $0011, $8200, $0000
    dw $0001, $8000, $0000
    dw $0001, $8800, $0800
    dw $0004, $8800, $0000
    dw $0001, $8840, $0040
    dw $0001, $8840, $0000
    dw $0001, $80C0, $0080
    dw $0003, $8080, $0000
    dw $0001, $8480, $0400
    dw $0006, $8480, $0000
    dw $0002, $8080, $0000
    dw $0001, $8480, $0400
    dw $0002, $8480, $0000
    dw $0001, $8680, $0200
    dw $0002, $8280, $0000
    dw $0005, $0280, $0000
    dw $003A, $0200, $0000
    dw $000F, $0000, $0000
    dw $8427 ; Delete
} ; babyskip

DemoInput_metroid3:
{
    dw $0019, $0000, $0000
    dw $0001, $0100, $0100
    dw $000C, $0100, $0000
    dw $0001, $8100, $8000
    dw $0001, $8100, $0000
    dw $0002, $8000, $0000
    dw $0001, $8200, $0200
    dw $000D, $8200, $0000
    dw $0006, $8000, $0000
    dw $0001, $8040, $0040
    dw $0003, $8040, $0000
    dw $0001, $8140, $0100
    dw $0002, $8140, $0000
    dw $0009, $8100, $0000
    dw $0001, $8140, $0040
    dw $0006, $8140, $0000
    dw $000C, $8100, $0000
    dw $0001, $8180, $0080
    dw $0004, $8180, $0000
    dw $0001, $8580, $0400
    dw $0003, $8480, $0000
    dw $000C, $8400, $0000
    dw $0002, $8000, $0000
    dw $0013, $0000, $0000
    dw $0001, $8000, $8000
    dw $001C, $8000, $0000
    dw $000A, $0000, $0000
    dw $0001, $8140, $8140
    dw $0005, $8140, $0000
    dw $0001, $A140, $2000
    dw $0006, $A100, $0000
    dw $0006, $8100, $0000
    dw $0001, $A100, $2000
    dw $0008, $A100, $0000
    dw $0001, $8140, $0040
    dw $0006, $8140, $0000
    dw $0030, $8100, $0000
    dw $0001, $8140, $0040
    dw $0001, $81C0, $0080
    dw $0002, $8180, $0000
    dw $0004, $0180, $0000
    dw $0008, $0100, $0000
    dw $0001, $8100, $8000
    dw $000C, $8100, $0000
    dw $0001, $4100, $4000
    dw $0003, $4100, $0000
    dw $0007, $0100, $0000
    dw $0001, $8180, $8080
    dw $0001, $81C0, $0040
    dw $0002, $81C0, $0000
    dw $0001, $A1C0, $2000
    dw $0003, $A1C0, $0000
    dw $0002, $A180, $0000
    dw $0004, $8180, $0000
    dw $0001, $A1A0, $2020
    dw $0003, $A120, $0000
    dw $0001, $8160, $0040
    dw $0007, $8160, $0000
    dw $0001, $C140, $4000
    dw $0002, $C140, $0000
    dw $000E, $8100, $0000
    dw $0001, $81C0, $00C0
    dw $0004, $81C0, $0000
    dw $0001, $8580, $0400
    dw $0001, $8580, $0000
    dw $0002, $8480, $0000
    dw $0004, $8080, $0000
    dw $0001, $8580, $0500
    dw $0002, $8580, $0000
    dw $0006, $8100, $0000
    dw $0001, $8180, $0080
    dw $000B, $8180, $0000
    dw $000E, $0100, $0000
    dw $8427 ; Delete
} ; metroid3

DemoInput_moat:
{
    dw $0021, $0000, $0000
    dw $0001, $8000, $8000
    dw $0006, $8000, $0000
    dw $0001, $8200, $0200
    dw $000E, $8200, $0000
    dw $0001, $8240, $0040
    dw $000B, $8240, $0000
    dw $0005, $8200, $0000
    dw $0004, $8000, $0000
    dw $0001, $8010, $0010
    dw $000E, $8010, $0000
    dw $0001, $8210, $0200
    dw $0009, $8210, $0000
    dw $0021, $8010, $0000
    dw $0009, $8000, $0000
    dw $0001, $8400, $0400
    dw $0002, $8400, $0000
    dw $0001, $8000, $0000
    dw $0001, $0000, $0000
    dw $0001, $8000, $8000
    dw $0001, $8000, $0000
    dw $0002, $0000, $0000
    dw $0001, $0400, $0400
    dw $0004, $0400, $0000
    dw $000C, $0000, $0000
    dw $0001, $0100, $0100
    dw $000E, $0000, $0000
    dw $0001, $0800, $0800
    dw $0003, $0800, $0000
    dw $0006, $0000, $0000
    dw $0001, $0800, $0800
    dw $0004, $0800, $0000
    dw $0018, $0000, $0000
    dw $0001, $8000, $8000
    dw $0011, $8000, $0000
    dw $0001, $8100, $0100
    dw $0012, $8100, $0000
    dw $0001, $8180, $0080
    dw $0020, $8180, $0000
    dw $0006, $0180, $0000
    dw $0022, $0100, $0000
    dw $0001, $0180, $0080
    dw $003C, $0180, $0000
    dw $0009, $0100, $0000
    dw $0001, $8100, $8000
    dw $0022, $8100, $0000
    dw $0005, $8000, $0000
    dw $0001, $8010, $0010
    dw $000C, $8010, $0000
    dw $0001, $8050, $0040
    dw $0007, $8050, $0000
    dw $000C, $8010, $0000
    dw $0001, $8110, $0100
    dw $0006, $8110, $0000
    dw $0007, $8010, $0000
    dw $0001, $8110, $0100
    dw $0004, $8110, $0000
    dw $0008, $8010, $0000
    dw $0001, $8210, $0200
    dw $0005, $8210, $0000
    dw $0004, $8010, $0000
    dw $0016, $8000, $0000
    dw $0001, $8200, $0200
    dw $0017, $8200, $0000
    dw $0001, $8280, $0080
    dw $0006, $8280, $0000
    dw $0001, $8680, $0400
    dw $0002, $8480, $0000
    dw $0005, $8080, $0000
    dw $0001, $8480, $0400
    dw $0001, $8680, $0200
    dw $0008, $8680, $0000
    dw $0006, $8280, $0000
    dw $0023, $8200, $0000
    dw $0003, $8000, $0000
    dw $0001, $8100, $0100
    dw $0001, $8100, $0000
    dw $0003, $0100, $0000
    dw $0001, $8100, $8000
    dw $0002, $8100, $0000
    dw $0009, $8000, $0000
    dw $0025, $0000, $0000
    dw $0001, $0040, $0040
    dw $0005, $0040, $0000
    dw $0006, $0000, $0000
    dw $0001, $0100, $0100
    dw $0001, $0100, $0000
    dw $0029, $0000, $0000
    dw $0001, $0040, $0040
    dw $0005, $0040, $0000
    dw $0002, $0000, $0000
    dw $0001, $0200, $0200
    dw $000E, $0200, $0000
    dw $0001, $0240, $0040
    dw $0006, $0240, $0000
    dw $0012, $0200, $0000
    dw $0001, $0100, $0100
    dw $0001, $0100, $0000
    dw $0002, $0000, $0000
    dw $0001, $0040, $0040
    dw $0005, $0040, $0000
    dw $000F, $0000, $0000
    dw $0001, $0040, $0040
    dw $0005, $0040, $0000
    dw $0012, $0000, $0000
    dw $0001, $0100, $0100
    dw $0016, $0100, $0000
    dw $0001, $0900, $0800
    dw $0001, $0900, $0000
    dw $0002, $0100, $0000
    dw $0001, $0900, $0800
    dw $000C, $0900, $0000
    dw $0012, $0100, $0000
    dw $0039, $0000, $0000
    dw $0001, $8000, $8000
    dw $000D, $8000, $0000
    dw $0001, $8100, $0100
    dw $0002, $8100, $0000
    dw $0012, $0100, $0000
    dw $8427 ; Delete
} ; moat

DemoInput_frogspeedway:
{
    dw $002C, $0000, $0000
    dw $0001, $8200, $8200
    dw $00AA, $8200, $0000
    dw $0002, $8000, $0000
    dw $0001, $8010, $0010
    dw $000F, $8010, $0000
    dw $0001, $8050, $0040
    dw $0007, $8050, $0000
    dw $0008, $8010, $0000
    dw $0001, $8050, $0040
    dw $0008, $8050, $0000
    dw $0007, $8010, $0000
    dw $0001, $8050, $0040
    dw $0008, $8050, $0000
    dw $0007, $8010, $0000
    dw $0001, $8050, $0040
    dw $0007, $8050, $0000
    dw $0007, $8010, $0000
    dw $0001, $8050, $0040
    dw $0007, $8050, $0000
    dw $0007, $8010, $0000
    dw $0001, $8050, $0040
    dw $0005, $8050, $0000
    dw $0001, $8250, $0200
    dw $0002, $8250, $0000
    dw $0008, $8210, $0000
    dw $0001, $8250, $0040
    dw $0007, $8250, $0000
    dw $0006, $8210, $0000
    dw $0001, $8250, $0040
    dw $0007, $8250, $0000
    dw $0008, $8210, $0000
    dw $0001, $8250, $0040
    dw $0007, $8250, $0000
    dw $0005, $8210, $0000
    dw $0001, $8250, $0040
    dw $0007, $8250, $0000
    dw $0007, $8210, $0000
    dw $0001, $8250, $0040
    dw $0007, $8250, $0000
    dw $0007, $8210, $0000
    dw $0001, $8250, $0040
    dw $0006, $8250, $0000
    dw $0007, $8210, $0000
    dw $0001, $8250, $0040
    dw $0006, $8250, $0000
    dw $0007, $8210, $0000
    dw $0001, $8250, $0040
    dw $0007, $8250, $0000
    dw $0007, $8210, $0000
    dw $0001, $8250, $0040
    dw $0007, $8250, $0000
    dw $0006, $8210, $0000
    dw $0001, $8250, $0040
    dw $0007, $8250, $0000
    dw $0007, $8210, $0000
    dw $0001, $8250, $0040
    dw $0007, $8250, $0000
    dw $0006, $8210, $0000
    dw $0001, $8250, $0040
    dw $0007, $8250, $0000
    dw $0006, $8210, $0000
    dw $0001, $8250, $0040
    dw $0006, $8250, $0000
    dw $0004, $8210, $0000
    dw $0033, $8200, $0000
    dw $0001, $A200, $2000
    dw $0007, $A200, $0000
    dw $002A, $8200, $0000
    dw $0001, $8000, $0000
    dw $0001, $8030, $0030
    dw $0006, $8030, $0000
    dw $0001, $8070, $0040
    dw $0005, $8070, $0000
    dw $0001, $8030, $0000
    dw $000A, $8020, $0000
    dw $0004, $8000, $0000
    dw $0001, $0200, $0200
    dw $0001, $0200, $0000
    dw $0001, $4200, $4000
    dw $0004, $4200, $0000
    dw $0001, $8200, $8000
    dw $004C, $8200, $0000
    dw $0001, $8240, $0040
    dw $0006, $8240, $0000
    dw $0035, $8200, $0000
    dw $8427 ; Delete
} ; frogspeedway

DemoInput_wraparound:
{
    dw $0031, $0000, $0000
    dw $0001, $8000, $8000
    dw $0003, $8000, $0000
    dw $0001, $8040, $0040
    dw $001A, $8040, $0000
    dw $0001, $8140, $0100
    dw $001E, $8140, $0000
    dw $0002, $8040, $0000
    dw $0001, $8240, $0200
    dw $003C, $8240, $0000
    dw $0001, $8040, $0000
    dw $0001, $8140, $0100
    dw $0005, $8140, $0000
    dw $0001, $8060, $0020
    dw $000F, $8060, $0000
    dw $0001, $8260, $0200
    dw $000D, $8260, $0000
    dw $0001, $8060, $0000
    dw $0001, $8160, $0100
    dw $0005, $8160, $0000
    dw $0019, $8060, $0000
    dw $0001, $8160, $0100
    dw $0002, $8160, $0000
    dw $0038, $8060, $0000
    dw $0001, $8160, $0100
    dw $0001, $8160, $0000
    dw $0020, $8060, $0000
    dw $0004, $8020, $0000
    dw $0001, $8120, $0100
    dw $0001, $8120, $0000
    dw $003C, $8100, $0000
    dw $0001, $8000, $0000
    dw $0001, $8200, $0200
    dw $0002, $8200, $0000
    dw $0001, $0200, $0000
    dw $0008, $0000, $0000
    dw $0001, $0200, $0200
    dw $0012, $0200, $0000
    dw $0001, $8200, $8000
    dw $0055, $8200, $0000
    dw $0001, $8400, $0400
    dw $006A, $8400, $0000
    dw $0001, $8480, $0080
    dw $0001, $0280, $0200
    dw $0001, $0280, $0000
    dw $0001, $0800, $0800
    dw $0004, $0800, $0000
    dw $0001, $0A00, $0200
    dw $0002, $0A00, $0000
    dw $0003, $0200, $0000
    dw $0001, $4280, $4080
    dw $0009, $4280, $0000
    dw $0004, $0200, $0000
    dw $006B, $0000, $0000
    dw $8427 ; Delete
} ; wraparound
endif
print pc, " demos end"
