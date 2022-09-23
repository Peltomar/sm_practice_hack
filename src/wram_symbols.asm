TEMP_00 = $00
TEMP_02 = $02
TEMP_04 = $04
TEMP_06 = $06
TEMP_08 = $08
TEMP_0A = $0A
TEMP_0C = $0C
TEMP_0E = $0E
TEMP_10 = $10
TEMP_12 = $12
TEMP_14 = $14
TEMP_16 = $16
TEMP_18 = $18
TEMP_1A = $1A
TEMP_1C = $1C
TEMP_1E = $1E
TEMP_20 = $20
TEMP_22 = $22
TEMP_24 = $24
TEMP_16Bit_Mult_A = $26
TEMP_16Bit_Mult_B = $28
TEMP_32Bit_Product_A = $2A
TEMP_32Bit_Product_B = $2C
TEMP_2E = $2E

DP36_UpdateTiles_80A9DE = $36

DP3C_Samus_HalfTiles_Definition = $3C

DP47_Decomp_Src = $47
DP4A_Decomp_Dest = $4A

REG_2100_Brightness = $51
REG_2101_Sprite_Size_Addr = $52
REG_2102_OAM_Addr_Prio = $53
REG_2105_BG_Mode_Size = $55
REG_2105_FAKE_BG_Mode_Size = $56
REG_2106_Mosaic = $57
REG_2107_BG1_Tilemap = $58
REG_2108_BG2_Tilemap = $59
REG_2109_BG3_Tilemap = $5A
REG_2109_Gameplay_BG3_Tilemap = $5B
REG_210A_BG4_Tilemap = $5C
REG_210B_BG_Tileset_Addr = $5D
REG_211A_Mode7_Settings = $5F
REG_2123_Window_Settings_BG12 = $60
REG_2124_Window_Settings_BG34 = $61
REG_2125_Window_Sprites_Color = $62
REG_2126_Window_1_Left = $63
REG_2127_Window_1_Right = $64
REG_2128_Window_2_Left = $65
REG_2129_Window_2_Right = $66
REG_212A_Window_BG_Logic = $67
REG_212B_Window_Sprites_Color_Logic = $68
REG_212C_MainScreen = $69
REG_212C_Gameplay_MainScreen = $6A
REG_212D_SubScreen = $6B
REG_212E_Window_MainScreen = $6C
REG_212F_Window_SubScreen = $6D
REG_2130_Gameplay_Next_ColorMathA = $6E
REG_2130_ColorMathA_Control = $6F
REG_2130_Gameplay_ColorMathA = $70
REG_2131_Gameplay_Next_ColorMathB = $71
REG_2131_ColorMathB_Control = $72
REG_2131_Gameplay_ColorMathB = $73
REG_2132_ColorMath_SubScreen_1 = $74
REG_2132_ColorMath_SubScreen_2 = $75
REG_2132_ColorMath_SubScreen_3 = $76
REG_2133_Resolution = $77
REG_211B_Mode7_MatrixA = $78
REG_211C_Mode7_MatrixB = $7A
REG_211D_Mode7_MatrixC = $7C
REG_211E_Mode7_MatrixD = $7E
REG_211F_Mode7_CenterX = $80
REG_2120_Mode7_CenterY = $82
REG_4200_IRQ_AutoJoy = $84
REG_420C_HDMA_Enable = $85
REG_420D_ROM_Speed = $86

AutoPress_InitialDelay = $87
AutoPress_SubsequentDelay = $89
Controller1_Inputs = $8B
Controller2_Inputs = $8D
Controller1_NewInputs = $8F
Controller2_NewInputs = $91
Controller1_FAKE_NewINputs = $93
Controller2_FAKE_NewINputs = $95
Controller1_PrevInputs = $97
Controller2_PrevInputs = $99
Controller1_AutoPress_Timer = $A3
Controller2_AutoPress_Timer = $A5

Next_IRQ_Cmd = $A7
RoomLoading_IRQ_Cmd = $A9
IRQ_Cmd = $AB
AD_Return_Pointer = $AD
FX_Table = $AF

REG_210D_BG1_Scroll_X = $B1
REG_210E_BG1_Scroll_Y = $B3
REG_210F_BG2_Scroll_X = $B5
REG_2110_BG2_Scroll_Y = $B7
REG_2111_BG3_Scroll_X = $B9
REG_2112_BG3_Scroll_Y = $BB
REG_2113_BG4_Scroll_X = $BD
REG_2114_BG4_Scroll_Y = $BF

D0_Table_Size = $D0
D0_Table_Src = $D2
D0_Table_Dest = $D5

Mode7_Transfer_Table_Ctrl = $02D0
Mode7_Transfer_Table_Src = $02D1
Mode7_Transfer_Table_Size = $02D4
Mode7_Transfer_Table_Dest = $02D6
Mode7_Transfer_Table_IncMode = $02D8

VRAM_Transfer_Table_StackPointer = $0330
Mode7_Transfer_Table_StackPointer = $0334
VRAM_Read_Table_Src = $0340
VRAM_Read_Table_DMA_Ctrl = $0342
VRAM_Read_Table_DMA_Target = $0343
VRAM_Read_Table_Dest = $0344
VRAM_Read_Table_Size = $0347
VRAM_Read_Table_StackPointer = $0360

OAM_Table_Low = $0370
OAM_Table_High = $0570
OAM_StackPointer = $0590

PB_Explosion_Status = $0592
ScrollingSky_SetTo_E0 = $059A
ScrollingSky_SetTo_0 = $059C
ScrollingSky_HUDBG2_X = $059E
Contracting_Flag = $05A0

MessageBox_Y_Radius = $05A2
MessageBox_Bottom_1 = $05A4
MessageBox_Bottom_2 = $05A6
MessageBox_Top_1 = $05A8
MessageBox_Top_2 = $05AA

Map_Min_Scroll_X = $05AC
Map_Max_Scroll_X = $05AE
Map_Min_Scroll_Y = $05B0
Map_Max_Scroll_Y = $05B2

NMI_Request_Flag = $05B4
Frame_Counter_8bit = $05B5
Frame_Counter = $05B6
NMI_Counter = $05B8
Lag_Counter = $05BA
Maximum_Lag = $05BB

DoorTransition_VRAM_Flag = $05BC
DoorTransition_VRAM_Dest = $05BE
DoorTransition_VRAM_Src = $05C0
DoorTransition_VRAM_Size = $05C3

Controller1_Debug_SelectL = $05C5
Controller1_Debug_SelectR = $05C7

Debug_Missiles_Swap = $05C9
Debug_Supers_Swap = $05CA
Debug_PowerBombs_Swap = $05CC
Debug_Options = $05CE
Debug_Mode_Flag = $05D1
Debug_SaveLoad_Scroll_Toggle = $05D3
Debug_SaveLoad_Scroll_X = $05D5
Debug_SaveLoad_Scroll_Y = $05D7

Previous_Held_Input = $05D9
TimedHeld_Input_Timer = $05DB
TimedHeld_Input_Timer_Reset = $05DD
TimedHeld_Input = $05DF
TimedHeld_NewInput = $05E1
TimedHeld_PrevInput = $05E3

Random_Number = $05E5
Bitmask_05E7 = $05E7
MultA_05E9_16bit = $05E9
MultB_05EB_16bit = $05EB
Product_05F1_32bit = $05F1
Disable_Sounds_Flag = $05F5

MapScroll_Timer = $05FB
MapScroll_Direction = $05FD
MapScroll_Speed = $05FF

Pause_Hook = $0601
Unpause_Hook = $0604
Earthquake_SFX_Index = $0607
Earthquake_SFX_Timer = $0609

Enemy_Spritemaps_Remaining = $060B
Enemy_Hitboxes_Remaining = $060D
Projectiles_Checks_Remaining = $060F

Uploading_to_APU_Flag = $0617
MusicQueue_List = $0619
MusicQueue_Timers = $0629
MusicQueue_NextIndex = $0639
MusicQueue_StartIndex = $063B
Music_Entry = $063D
Music_Timer = $063F
APU_Attempts_Remaining = $0641
SoundQueue_StartIndex_Lib1 = $0643
SoundQueue_StartIndex_Lib2 = $0644
SoundQueue_StartIndex_Lib3 = $0645
SoundQueue_NextIndex_Lib1 = $0646
SoundQueue_NextIndex_Lib2 = $0647
SoundQueue_NextIndex_Lib3 = $0648
Sound_State_Lib1 = $0649
Sound_State_Lib2 = $064A
Sound_State_Lib3 = $064B
Current_Music_Track = $064C
Current_SFX_Lib1 = $064D
Current_SFX_Lib2 = $064E
Current_SFX_Lib3 = $064F
Clear_SFX_Lib1 = $0650
Clear_SFX_Lib2 = $0651
Clear_SFX_Lib3 = $0652
SFX_MaxQueue_Lib1 = $0653
SFX_MaxQueue_Lib2 = $0654
SFX_MaxQueue_Lib3 = $0655
SoundQueue_Lib1 = $0656
SoundQueue_Lib2 = $0666
SoundQueue_Lib3 = $0676
Sound_Handler_Downtime = $0686

Unused_Timer_808577 = $071C

SamusTop_Transfer_Flag = $071D
SamusBottom_Transfer_Flag = $071E
SamusTop_Definition = $071F
SamusBottom_Definition = $0721

Screen_Fade_Delay = $0723
Screen_Fade_Counter = $0725

Menu_Index = $0727
Menu_StartLR_ButtonPressed_Highlight_Timer = $0729
Menu_LR_Highlight_Timer = $072B
Menu_Item_Selector_Timer = $072D
Menu_Reserve_Timer = $072F
Menu_Unused_Timer_1 = $0731
Menu_MapScroll_UpArrow_Timer = $0733
Menu_MapScroll_DownArrow_Timer = $0735
Menu_MapScroll_RightArrow_Timer = $0737
Menu_MapScroll_LeftArrow_Timer = $0739
Menu_Palette_Timer = $073B
Menu_Unused_Timer_2 = $073D
Menu_LR_Highlight_Frame = $073F
Menu_Item_Selector_Frame = $0741
Menu_Reserve_Frame = $0743
Menu_Unused_Frame = $0745
Menu_MapScroll_UpArrow_Frame = $0747
Menu_MapScroll_DownArrow_Frame = $0749
Menu_MapScroll_RightArrow_Frame = $074B
Menu_MapScroll_LeftArrow_Frame = $074D
Menu_Palette_Frame = $074F
Menu_Shoulder_ButtonPressed_Highlight = $0751
Menu_Button_Label_Mode = $0753
Menu_Equipment_Category_Index = $0755
Menu_Equipment_Item_Index = $0756
Menu_Reserve_Delay_Counter = $0757
Menu_Unused_Mode = $0759
Menu_MapScroll_UpArrow_Mode = $075B
Menu_MapScroll_DownArrow_Mode = $075D
Menu_MapScroll_RightArrow_Mode = $075F
Menu_MapScroll_LeftArrow_Mode = $0761
Menu_Pause_Screen = $0763
Menu_Backup_58 = $0765
Menu_Backup_59 = $0766
Menu_Backup_5A = $0767
Menu_Backup_5D = $0768
Menu_Backup_52 = $076A
Menu_Backup_B1 = $076B
Menu_Backup_B5 = $076C
Menu_Backup_B9 = $076D
Menu_Backup_B3 = $076E
Menu_Backup_B7 = $076F
Menu_Backup_BB = $0770
Menu_Backup_55 = $0771
Menu_Backup_091B = $0772
Menu_Backup_091C = $0773
Menu_Backup_57 = $0774
Menu_Backup_71 = $0775
Menu_Samus_Indicator_Frame = $0776
Menu_Samus_Indicator_Timer = $0778
Menu_Samus_Indicator_Loop = $077A
Menu_HUD_Palette = $077C

Mode7_Flag = $0783
Mode7_Rotation_Angle = $0785

Area_Map_Collected = $0789
Load_Station_Index = $078B
Door_Pointer = $078D
Door_BTS = $078F
Door_Direction = $0791
Elevator_Door_Properties = $0793
Door_Orientation = $0794
Door_Transition_Flag_Elevator = $0795
Door_Transition_Flag_Enemy = $0797
Elevator_Direction = $0799

Room_ID = $079B
Room_Index = $079D
Area_ID = $079F
Room_X_Coordinate = $07A1
Room_Y_Coordinate = $07A3
Room_Width_Blocks = $07A5
Room_Height_Blocks = $07A7
Room_Width_Scrolls = $07A9
Room_Height_Scrolls = $07AB
Up_Scroller = $07AD
Down_Scroller = $07AF
CRE_PrevBitset = $07B1
CRE_Bitset = $07B3
Door_List_Pointer = $07B5
Event_Pointer = $07B7
Room_Size_Blocks = $07B9
State_Pointer = $07BB
Level_Data_Pointer = $07BD
Tileset_TileTable_Pointer = $07C0
Tileset_Tiles_Pointer = $07C3
Tileset_Palette_Pointer = $07C6
Room_Music_Track_Index = $07C9
Room_Music_Data_Index = $07CB
FX_Pointer = $07CD
Enemy_Population_Pointer = $07CF
Enemy_Set_Pointer = $07D1
Room_MainASM_Pointer = $07DF
RoomASM_07E1 = $07E1
RoomASM_07E3 = $07E3
RoomASM_07E5 = $07E5
RoomASM_07E7 = $07E7

Scrolling_Finished_Hook = $07E9
CeresHDMA_HUD_Floor = $07EB
CeresHDMA_Mode7 = $07EC

Music_Data_Index = $07F3
Music_Track_Index = $07F5

Current_Map_Tiles_Explored = $07F7

Layer1_X_Block = $08F7
Layer1_Y_Block = $08F9
Layer2_X_Block = $08FB
Layer2_Y_Block = $08FD
Layer1_X_Block_Prev = $08FF
Layer1_Y_Block_Prev = $0901
Layer2_X_Block_Prev = $0903
Layer2_Y_Block_Prev = $0905
BG1_X_Block = $0907
BG1_Y_Block = $0909
BG2_X_Block = $090B
BG2_Y_Block = $090D
Layer1_X_Subposition = $090F
Layer1_X_Position = $0911
Layer1_Y_Subposition = $0913
Layer1_Y_Position = $0915
Layer2_X_Position = $0917
Layer2_Y_Position = $0919
Layer2_Scroll_X = $091B
Layer2_Scroll_Y = $091C
BG1_X_Offset = $091D
BG1_Y_Offset = $091F
BG2_X_Offset = $0921
BG2_Y_Offset = $0923

Door_Transition_Frame_Counter = $0925
Door_Dest_X_Pos = $0927
Door_Dest_Y_Pos = $0929
Samus_Subspeed_Door = $092B
Samus_Speed_Door = $092D
Elevator_Down_Delay_Timer = $092F
Door_Transition_Finished_Flag = $0931

VRAM_Block_Update_0933 = $0933
VRAM_Block_X_Blocks_0935 = $0935
VRAM_Block_Update_0937 = $0937
Proposed_Layer1_X = $0939
Block_to_Update = $093B

Ceres_Status = $093F
Camera_Distance_Index = $0941
Timer_Status = $0943
Timer_Centiseconds = $0945
Timer_Seconds = $0946
Timer_Minutes = $0947
Timer_X_Subposition = $0948
Timer_X_Position = $0949
Timer_Y_Subposition = $094A
Timer_Y_Position = $094B

Menu_Map_GameOver_Index = $0950
Save_Slot_Selected = $0952
Non_Empty_Save_Slots = $0954

BG1Column_UnwrappedTilemap_Size = $0956
BG1Column_WrappedTilemap_Size = $0958
BG1Column_UnwrappedTilemap_Dest = $095A
BG1Column_WrappedTilemap_Dest = $095C
BG1Column_WrappedTilemap_LeftSrc = $095E
BG1Column_WrappedTilemap_RightSrc = $0960
BG1Column_Flag = $0962
BG1Row_UnwrappedTilemap_Size = $0964
BG1Row_WrappedTilemap_Size = $0966
BG1Row_UnwrappedTilemap_Dest = $0968
BG1Row_WrappedTilemap_Dest = $096A
BG1Row_WrappedTilemap_LeftSrc = $096C
BG1Row_WrappedTilemap_RightSrc = $096E
BG1Row_Flag = $0970
BG2Column_UnwrappedTilemap_Size = $0972
BG2Column_WrappedTilemap_Size = $0974
BG2Column_UnwrappedTilemap_Dest = $0976
BG2Column_WrappedTilemap_Dest = $0978
BG2Column_WrappedTilemap_LeftSrc = $097A
BG2Column_WrappedTilemap_RightSrc = $097C
BG2Column_Flag = $097E
BG2Row_UnwrappedTilemap_Size = $0980
BG2Row_WrappedTilemap_Size = $0982
BG2Row_UnwrappedTilemap_Dest = $0984
BG2Row_WrappedTilemap_Dest = $0986
BG2Row_WrappedTilemap_LeftSrc = $0988
BG2Row_WrappedTilemap_RightSrc = $098A
BG2Row_Flag = $098C
BG2_Size = $098E
Blocks_to_Update_X = $0990
Blocks_to_Update_Y = $0992
VRAM_Blocks_to_Update_X = $0994
VRAM_Blocks_to_Update_Y = $0996

Game_State = $0998
Door_Transition_Function = $099C
Menu_Option_Index = $099E

Samus_Items_Equipped = $09A2
Samus_Items_Collected = $09A4
Samus_Beams_Equipped = $09A6
Samus_Beams_Collected = $09A8

Controller_Binding_Up = $09AA
Controller_Binding_Down = $09AC
Controller_Binding_Left = $09AE
Controller_Binding_Right = $09B0
Controller_Binding_Shot = $09B2
Controller_Binding_Jump = $09B4
Controller_Binding_Dash = $09B6
Controller_Binding_Cancel = $09B8
Controller_Binding_Select = $09BA
Controller_Binding_AngleDown = $09BC
Controller_Binding_AngleUp = $09BE

Samus_Reserve_Mode = $09C0
Samus_Energy = $09C2
Samus_Energy_Max = $09C4
Samus_Missiles = $09C6
Samus_Missiles_Max = $09C8
Samus_SuperMissiles = $09CA
Samus_SuperMissiles_Max = $09CC
Samus_PowerBombs = $09CE
Samus_PowerBombs_Max = $09D0
Samus_HUD_Item_Index = $09D2
Samus_Reserve_Max = $09D4
Samus_Reserve_Energy = $09D6
Samus_Reserve_Missiles = $09D8
GameTime_Frames = $09DA
GameTime_Seconds = $09DC
GameTime_Minutes = $09DE
GameTime_Hours = $09E0
Japanese_Text_Flag = $09E2
Samus_Moonwalk_Flag = $09E4
Debug_Samus_Positioning_Flag = $09E6
Unused_Flag_09E8 = $09E8
Samus_HUD_AutoCancel_Flag = $09EA
Samus_Unused_09EC_0A01 = $09EC
Samus_Unused_0A02 = $0A02
Samus_HUD_AutoCancel_Index = $0A04
Samus_Prev_Energy_0A06 = $0A06
Samus_Prev_Missiles = $0A08
Samus_Prev_Supers = $0A0A
Samus_Prev_PowerBombs = $0A0C
Samus_Prev_HUD_Item_Index = $0A0E
Samus_Prev_Pose_X_Dir_0A10 = $0A10
Samus_Prev_Move_Type_0A11 = $0A11
Samus_Prev_Energy_0A12 = $0A12
Controller1_Inputs_Backup = $0A14
Controller1_NewInputs_Backup = $0A16
Cleared_in_Bank91_0A18 = $0A18
Samus_Pose = $0A1C
Samus_Pose_Direction = $0A1E
Samus_Movement_Type = $0A1F
Samus_Prev_Pose = $0A20
Samus_Prev_Pose_X_Dir_0A22 = $0A22
Samus_Prev_Move_Type_0A23 = $0A23
Samus_Last_Diff_Pose = $0A24
Samus_Last_Diff_Pose_X_Dir = $0A26
Samus_Last_Diff_Pose_Move_Type = $0A27
Samus_New_Pose_0A28 = $0A28
Samus_New_Pose_0A2A = $0A2A
Samus_New_Pose_0A2C = $0A2C
Momentum_Routine_Index = $0A2E
Samus_Special_Transition_Index = $0A30
JSR_91EC3E_X_Index = $0A32
Solid_Enemy_Collision_Flags = $0A34
Block_Collision_Flags = $0A36
SpaceToMoveSamus_Up_Blocks = $0A38
Samus_Y_Radius_Diffence = $0A3A
SpaceToMoveSamus_Down_Blocks = $0A3C
SpaceToMoveSamus_Up_Enemy = $0A3E
SpaceToMoveSamus_Down_Enemy = $0A40
Samus_Pointer_0A42 = $0A42
Samus_Pointer_0A44 = $0A44
Samus_Horiz_Slope_Flag = $0A46
Samus_Hurt_Flash_Counter = $0A48
Samus_Special_Palette_Flags = $0A4A
Samus_Subunit_Energy = $0A4C
Samus_Periodic_Damage = $0A4E
Samus_Adjusted_Periodic_Damage = $0A50
Samus_Knockback_Dir = $0A52
Samus_Knockback_X_Dir = $0A54
Samus_BombJump_Direction = $0A56
Samus_Movement_Handler = $0A58
Samus_Pointer_0A5A = $0A5A
Samus_Drawing_Handler = $0A5C
Debug_Pointer_0A5E = $0A5E
Controller_Pointer_0A60 = $0A60

Samus_Grappled_Released_Flags = $0A64
Samus_X_Speed_Divisor = $0A66
Samus_Shine_Timer = $0A68
Samus_Health_Warning = $0A6A
Samus_X_Speed_Table_Pointer = $0A6C
Samus_Contact_Damage_Index = $0A6E
UNUSED_0A70 = $0A70
Samus_Visor_Palette_Timer = $0A72
Samus_Visor_Palette_Index = $0A74
Samus_Suit_Palette_Index = $0A76
Samus_Hyper_Beam = $0A76
Samus_Time_Frozen = $0A78
Xray_State = $0A7A
Xray_Angular_Width_Delta = $0A7C
Xray_Angular_Subwidth_Delta = $0A7E
Xray_Max_Width_Flag = $0A80
Xray_Angle_Dir = $0A82
Xray_Angular_Width = $0A84
Xray_Angular_Subwidth = $0A86
Suit_Pickup_HDMA_Table = $0A88 ; 0A88..92
Samus_Animation_Timer = $0A94
Samus_Animation_Frame = $0A96
UNLABELED_0A98 = $0A98
Samus_Animation_Frame_Skip = $0A9A
Samus_Animation_Frame_Buffer = $0A9C
Grapple_Walljump_Timer = $0A9E
CeresElev_Fade_Timer = $0AA0
Samus_Shinespark_Start_Stop_Timer = $0AA2
Samus_Unused_0AA4 = $0AA4
Samus_ArmCannon_Open_Flag = $0AA6
Samus_ArmCannon_Transition_Flag = $0AA7
Samus_ArmCannon_Frame = $0AA8
HUD_Selected_Item_Changed = $0AAA
Samus_ArmCannon_Drawing_Mode = $0AAC
Samus_SpeedEcho_Index = $0AAE
Samus_SpeedEcho_0_X_Pos = $0AB0
Samus_SpeedEcho_1_X_Pos = $0AB2
Samus_SpeedEcho_2_X_Pos = $0AB4
Samus_SpeedEcho_3_X_Pos = $0AB6
Samus_SpeedEcho_0_Y_Pos = $0AB8
Samus_SpeedEcho_1_Y_Pos = $0ABA
Samus_SpeedEcho_2_Y_Pos = $0ABC
Samus_SpeedEcho_3_Y_Pos = $0ABE
Samus_SpeedEcho_0_X_Speed = $0AC0
Samus_SpeedEcho_1_X_Speed = $0AC2
Samus_SpeedEcho_2_X_Speed = $0AC4
Samus_SpeedEcho_3_X_Speed = $0AC6
Samus_TopHalf_Spritemap_Index = $0AC8
Samus_BottomHalf_Spritemap_Index = $0ACA
Samus_Timer_Type_0A68 = $0ACC
Samus_Special_Palette_Frame = $0ACE
Samus_Special_Palette_Timer = $0AD0
Liquid_Physics_Type = $0AD2

AtmosphericGFX_Anim_Timers = $0AD4
AtmosphericGFX_X_Pos = $0ADC
AtmosphericGFX_Y_Pos = $0AE4
Atmospheric_GFX_Type_Frame = $0AEC

Samus_AutoJump_Timer = $0AF4
Samus_X_Pos = $0AF6
Samus_X_Subpos = $0AF8
Samus_Y_Pos = $0AFA
Samus_Y_Subpos = $0AFC
Samus_X_Radius = $0AFE
Samus_Y_Radius = $0B00
Samus_Collision_Dir = $0B02
Samus_Spritemap_X = $0B04
Samus_Spritemap_Y = $0B06
Ideal_Layer1_X = $0B0A
UNUSED_0B0C = $0B0C
Ideal_Layer1_Y = $0B0E
Samus_Prev_X_Pos = $0B10
Samus_Prev_X_Subpos = $0B12
Samus_Prev_Y_Pos = $0B14
Samus_Prev_Y_Subpos = $0B16
Samus_Charge_Glow_Timer = $0B18
Samus_Unused_Collision_Flag = $0B1A
UNUSED_0B1C = $0B1C
UNUSED_0B1E = $0B1E
Samus_Bounce_0B20 = $0B20
Samus_Falling_Flag = $0B22
Samus_Temp_0B24 = $0B24
Samus_Temp_0B26 = $0B26
UNUSED_0B28 = $0B28
UNUSED_0B2A = $0B2A
Samus_Y_Subspeed = $0B2C
Samus_Y_Speed_Combined = $0B2D
Samus_Y_Speed = $0B2E
UNUSED_0B30 = $0B30
Samus_Y_Subaccel_0B32 = $0B32
Samus_Y_Accel_0B34 = $0B34
Samus_Y_Dir = $0B36
Samus_Cleared_When_Landed = $0B38
UNUSED_0B3A = $0B3A
Samus_Momentum_Flag = $0B3C
Samus_Anim_Counter_0B3E = $0B3E
Samus_Dash_Counter = $0B3F
Samus_SpeedEcho_Flag = $0B40
Samus_X_Run_Speed = $0B42
Samus_X_Run_Subspeed = $0B44
Samus_X_Momentum = $0B46
Samus_X_Submomentum = $0B48
Samus_X_Accel_Mode = $0B4A
Samus_X_Decel_Mult = $0B4C
UNUSED_0B4E = $0B4E
UNUSED_0B50 = $0B50
UNUSED_0B52 = $0B52
UNUSED_0B54 = $0B54
Samus_Extra_X_Displacement = $0B56
Samus_Extra_X_Subdisplacement = $0B58
Samus_Extra_Y_Displacement = $0B5A
Samus_Extra_Y_Subdisplacement = $0B5C
Samus_PoseChange_Proj_Dir = $0B5E
Samus_SBA_0B60 = $0B60
Samus_Charge_Palette_Index = $0B62
Samus_Proj_X_Pos = $0B64
Samus_Bomb_X_Pos = $0B6E
Samus_Proj_Y_Pos = $0B78
Samus_Bomb_Y_Pos = $0B82
Samus_Proj_X_Subpos = $0B8C
Samus_Bomb_X_Subpos = $0B96
Samus_Proj_Y_Subpos = $0BA0
Samus_Bomb_Y_Subpos = $0BAA
Samus_Proj_X_Radii = $0BB4
Samus_Bomb_X_Radii = $0BBE
Samus_Proj_Y_Radii = $0BC8
Samus_Bomb_Y_Radii = $0BD2
Samus_Proj_X_Velocities = $0BDC
Samus_Bomb_X_Speeds = $0BE6
Samus_Proj_Y_Velocities = $0BF0
Samus_Bomb_Y_Speeds = $0BFA
Samus_Proj_Dir = $0C04
Samus_Bomb_Dir = $0C0E
Samus_Proj_Types = $0C18
Samus_Bomb_Types = $0C22
Samus_Proj_Damages = $0C2C
Samus_Bomb_Damage = $0C36
Samus_Proj_Instruct_Pointers = $0C40
Samus_Proj_Instruct_Timers = $0C54
Samus_Bomb_Functions = $0C72
Samus_Proj_Vars = $0C7C
Samus_Bomb_Timers = $0786
Samus_Proj_Trail_Timers = $0790
Samus_Bomb_Subspeeds = $079A
Samus_Proj_Spritemap_Pointers = $07B8

Samus_Cooldown = $0CCC
Samus_Proj_Counter = $0CCE
Samus_Charge_Timer = $0CD0
Samus_Bombs_Counter = $0CD2
Samus_Bombs_Charge_Counter = $0CD4
Samus_Flare_Frame_0CD6 = $0CD6
Samus_Flare_Timer_0CD8 = $0CD8
Samus_Flare_Timer_0CDA = $0CDA
Samus_Flare_Timer_0CDC = $0CDC
Samus_Flare_Timer_0CDE = $0CDE
Samus_Flare_Timer_0CE0 = $0CE0

Samus_PB_X = $0CE2
Samus_PB_Y = $0CE4
Samus_PB_X_Offset = $0CE6
Samus_PB_Y_Offset = $0CE8
Samus_PB_Explo_Radius = $0CEA
Samus_PB_Flash_Radius = $0CEC
Samus_PB_Flag = $0CEE
Samus_PB_Flash_Radius_Speed = $0CF0
Samus_PB_Shape_Def_Pointer = $0CF2

Samus_Grapple_Flags = $0CF4
Samus_Grapple_Unknown_0CF6 = $0CF6
Samus_Grapple_SlowScroll = $0CF8
Samus_Grapple_End_Subangle = $0CFA
Samus_Grapple_End_Angle = $0CFB
Samus_Grapple_Mirror_0CFA = $0CFC
Samus_Grapple_Length = $0CFE
Samus_Grapple_Length_Delta = $0D00
Samus_Grapple_Origin_X_Offset = $0D02
Samus_Grapple_Origin_Y_Offset = $0D04
Samus_Grapple_End_X_Subpos = $0D06
Samus_Grapple_End_X_Pos = $0D08
Samus_Grapple_End_Y_Subpos = $0D0A
Samus_Grapple_End_Y_Pos = $0D0C
Samus_Grapple_End_X_Suboffset = $0D0E
Samus_Grapple_End_X_Offset = $0D10
Samus_Grapple_End_Y_Suboffset = $0D12
Samus_Grapple_End_Y_Offset = $0D14
Samus_Grapple_Start_X = $0D16
Samus_Grapple_Start_Y = $0D18
Samus_Grapple_Start_X_Prev = $0D1A
Samus_Grapple_Start_Y_Prev = $0D1C
Samus_Grapple_Unknown_0D1E = $0D1E
Samus_Grapple_Unknown_0D20 = $0D20
Samus_Grapple_Ext_X_Subvelocity = $0D22
Samus_Grapple_Ext_X_Velocity = $0D23
Samus_Grapple_Ext_Y_Subvelocity = $0D24
Samus_Grapple_Ext_Y_Velocity = $0D25
Samus_Grapple_Unknown_0D26 = $0D26
Samus_Grapple_Unknown_0D28 = $0D28
Samus_Grapple_Unknown_0D2A = $0D2A
Samus_Grapple_Unknown_0D2C = $0D2C
Samus_Grapple_Unknown_0D2E = $0D2E
Samus_Grapple_Unknown_0D30 = $0D30
Samus_Grapple_Function = $0D32
Samus_Grapple_Direction = $0D34
Samus_Grapple_Unknown_0D36 = $0D36
Samus_Grapple_Unknown_0D38 = $0D38
Samus_Grapple_Unknown_0D3A = $0D3A
Samus_Grapple_Unknown_0D3C = $0D3C
Samus_Grapple_Point_Anim_Timer = $0D3E
Samus_Grapple_Point_Anim_Pointer = $0D40
Samus_Grapple_Segment_Anim_Timers = $0D42
Samus_Grapple_Segment_Anim_Pointers = $0D62
Samus_Grapple_Temp_0D82 = $0D82
Samus_Grapple_Temp_0D84 = $0D84
Samus_Grapple_Temp_0D86 = $0D86
Samus_Grapple_Temp_0D88 = $0D88
Samus_Grapple_Temp_0D8A = $0D8A
Samus_Grapple_Unknown_0D8C = $0D8C
Samus_Grapple_Unknown_0D8E = $0D8E
Samus_Grapple_Unknown_0D90 = $0D90
Samus_Grapple_Temp_0D92 = $0D92
Samus_Grapple_Temp_0D94 = $0D94
Samus_Grapple_Temp_0D96 = $0D96
UNUSED_0D98 = $0D98
UNUSED_0D9A = $0D9A
UNUSED_0D9C = $0D9C
UNUSED_0D9E = $0D9E
Loop_Counter_EnemyTiles = $0DA0
Samus_X_DistanceMoved_LastFrame = $0DA2
Samus_X_SubDistanceMoved_LastFrame = $0DA4
Samus_Y_DistanceMoved_LastFrame = $0DA6
Samus_Y_SubDistanceMoved_LastFrame = $0DA8
Samus_DistanceMoved_Left = $0DAA
Samus_SubDistanceMoved_Left = $0DAC
Samus_DistanceMoved_Right = $0DAE
Samus_SubDistanceMoved_Right = $0DB0
Samus_DistanceMoved_Up = $0DB2
Samus_SubDistanceMoved_Up = $0DB4
Samus_DistanceMoved_Down = $0DB6
Samus_SubDistanceMoved_Down = $0DB8
Samus_Slope_Adjusted_Flag = $0DBA
Samus_Total_X_Speed = $0DBC
Samus_Total_X_Subspeed = $0DBE
Samus_Resume_ChargingSFX_Flag = $0DC0
Samus_Charge_Counter_Prev = $0DC2
Current_Block_Index = $0DC4
Samus_ProspectivePose_Var_0DC6 = $0DC6
Samus_ProspectivePose_Var_0DC7 = $0DC7
UNUSED_0DC8 = $0DC8
UNUSED_0DCA = $0DCA
UNUSED_0DCC = $0DCC
Samus_Collided_Enemy_Flag = $0DCE
Samus_Collision_Flag_0DD0 = $0DD0
UNUSED_0DD2 = $0DD2
Samus_Collision_Var_0DD4 = $0DD4
Samus_Collision_Var_0DD6 = $0DD6
UNUSED_0DD8 = $0DD8
UNUSED_0DDA = $0DDA
SuitPickup_Widening_Speed = $0DDC
Samus_Projectile_Index = $0DDE
Debug_Invincibility = $0DE0
GameOptions_Screen_Index = $0DE2
UNUSED_0DE4 = $0DE4
UNUSED_0DE6 = $0DE6
UNUSED_0DE8 = $0DE8
Samus_CF_Item_Decrement = $0DEA
SuitPickup_Stage = $0DEC
Samus_Var_0DEE = $0DEE
Samus_Var_0DF0 = $0DF0
Samus_Var_0DF1 = $0DF1
Samus_Var_0DF2 = $0DF2
Samus_Var_0DF3 = $0DF3
Debug_SpareCPU_Flag = $0DF4
UNUSED_0DF6 = $0DF6
UNUSED_0DF8 = $0DF8
UNUSED_0DFA = $0DFA
UNUSED_0DFC = $0DFC
Controller1_PrevInputs_0DFE = $0DFE
Controller1_NewINputs_0E00 = $0E00
Samus_Bottom_Boundary_Pos = $0E02
Samus_Grapple_Eject_Left = $0E04
Samus_Grapple_Eject_Right = $0E06
Samus_Grapple_Eject_Up = $0E08
Samus_Grapple_Eject_Down = $0E0A
UNUSED_0E0C = $0E0C
UNUSED_0E0E = $0E0E
UNUSED_0E10 = $0E10
Debug_Disable_Sprite_Interactions = $0E12
UNUSED_0E14 = $0E14
Elevator_Properties = $0E16
Elevator_Status = $0E18
Samus_Health_Drop_Flag = $0E1A

Enemy_Shake_Index = $0E1C
Enemy_BG2Tilemap_Request_Flag = $0E1E
Misc_Var_0E20 = $0E20
Misc_Var_0E22 = $0E22
Misc_Var_0E24 = $0E24
Misc_Var_0E26 = $0E26
UNUSED_0E28 = $0E28
UNUSED_0E2A = $0E2A
UNUSED_0E2C = $0E2C
Misc_Var_0E2E = $0E2E
UNUSED_0E30 = $0E30
Misc_Var_0E32 = $0E32
Enemy_Drawing_Queue_Index = $0E34
SinCosMult_Whole = $0E36
SinCosMult_Fraction = $0E38
UNUSED_0E3A = $0E3A
UNUSED_0E3C = $0E3C
UNUSED_0E3E = $0E3E
Enemy_Damage_Mult = $0E40
UNUSED_0E42 = $0E42
Enemy_MainRoutine_Counter = $0E44
Enemy_DeterminEnemies_Counter = $0E46
UNUSED_0E48 = $0E48
Enemy_Spawn_Index = $0E4A
Enemy_FirstFree_Index = $0E4C
Enemy_Count = $0E4E
Enemy_Kills_Counter = $0E50
Enemy_Kills_Unlock = $0E52
Enemy_Index = $0E54
Enemy_Index_Backup = $0E56
Enemy_Data_Pointer = $0E58
Enemy_TileData_Size = $0E5A
Enemy_TileData_Pointer = $0E5C
Enemy_TileData_Offset = $0E5F
UNUSED_0E76 = $0E76
UNUSED_0E78 = $0E78
Enemy_TileData_StackPointer = $0E7A
Enemy_Tiles_Src = $0E7C
Enemy_Tiles_Dest = $0E7E
UNUSED_0E80 = $0E80
UNUSED_0E82 = $0E82
Enemy_Drawing_Queue_Layer0 = $0E84
Enemy_Drawing_Queue_Layer1 = $0EA4
Enemy_Drawing_Queue_Layer2 = $0EA6
Enemy_Drawing_Queue_Layer3 = $0EC6
Enemy_Drawing_Queue_Layer4 = $0EC8
Enemy_Drawing_Queue_Layer5 = $0EE8
Enemy_Drawing_Queue_Layer6 = $0F28
Enemy_Drawing_Queue_Layer7 = $0F48
Enemy_Drawing_Queue_Size = $0F68

Enemy_ID = $0F78
Enemy_X_Pos = $0F7A
Enemy_X_Subpos = $0F7C
Enemy_Y_Pos = $0F7E
Enemy_Y_Subpos = $0F80
Enemy_X_Radius = $0F82
Enemy_Y_Radius = $0F84
Enemy_Properties = $0F86
Enemy_Properties_Extra = $0F88
Enemy_AI_Handler = $0F8A
Enemy_HP = $0F8C
Enemy_Spritemap = $0F8E
Enemy_Timer = $0F90
Enemy_Init_Param = $0F92
Enemy_Instr_Timer = $0F94
Enemy_Palette_Index = $0F96
Enemy_VRAM_Tiles_Index = $0F98
Enemy_Layer = $0F9A
Enemy_Flash_Timer = $0F9C
Enemy_Frozen_Timer = $0F9E
Enemy_Invincibility_Timer = $0FA0
Enemy_Shake_Timer = $0FA2
Enemy_Frame_Counter = $0FA4
Enemy_Bank = $0FA6
Enemy_Var_0FA8 = $0FA8
Enemy_Var_0FAA = $0FAA
Enemy_Var_0FAC = $0FAC
Enemy_Var_0FAE = $0FAE
Enemy_Var_0FB0 = $0FB0
Enemy_Var_0FB2 = $0FB2
Enemy_Param_Speed = $0FB4
Enemy_Param_Speed2 = $0FB6
Enemy1_ID = $0FB8
Enemy1_X_Pos = $0FBA
Enemy1_X_Subpos = $0FBC
Enemy1_Y_Pos = $0FBE
Enemy1_Y_Subpos = $0FC0
Enemy1_X_Radius = $0FC2
Enemy1_Y_Radius = $0FC4
Enemy1_Properties = $0FC6
Enemy1_Properties_Extra = $0FC8
Enemy1_AI_Handler = $0FCA
Enemy1_HP = $0FCC
Enemy1_Spritemap = $0FCE
Enemy1_Timer = $0FD0
Enemy1_Init_Param = $0FD2
Enemy1_Instr_Timer = $0FD4
Enemy1_Palette_Index = $0FD6
Enemy1_VRAM_Tiles_Index = $0FD8
Enemy1_Layer = $0FDA
Enemy1_Flash_Timer = $0FDC
Enemy1_Frozen_Timer = $0FDE
Enemy1_Invincibility_Timer = $0FE0
Enemy1_Shake_Timer = $0FE2
Enemy1_Frame_Counter = $0FE4
Enemy1_Bank = $0FE6
Enemy1_Var_0FA8 = $0FE8
Enemy1_Var_0FAA = $0FEA
Enemy1_Var_0FAC = $0FEC
Enemy1_Var_0FAE = $0FEE
Enemy1_Var_0FB0 = $0FF0
Enemy1_Var_0FB2 = $0FF2
Enemy1_Param_Speed = $0FF4
Enemy1_Param_Speed2 = $0FF6

Fireflea_Flashing_Timer = $1778
Fireflea_Flashing_Inxex = $177A
Fireflea_UNUSED_177C = $177C
Fireflea_Flashing_Darkness = $177E
Fireflea_UNUSED_1780 = $1780
Fireflea_UNUSED_1782 = $1782
Enemy_AI_Pointer = $1784
Enemy_AI_Pointer_Backup = $1788
Enemy_GFX_Drawn_Hook = $178C
Enemy_UNUSED_1790 = $1790
Enemy_GFX_Drawn_1794 = $1794
Enemy_GFX_Drawn_1795 = $1795
Enemy_GFX_Drawn_1796 = $1796
Enemy_GFX_Drawn_1797 = $1797
Enemy_GFX_Drawn_1798 = $1798
Enemy_GFX_Drawn_1799 = $1799
Enemy_BG2Tilemap_Size = $179A
Enemy_Boss_ID = $179C
Enemy_UNUSED_179E = $179E
Enemy_UNUSED_17A0 = $17A0
Disable_Drawing_Enemies = $17A2
Enemy_Indices_Active_StackPointer = $17A4
Enemy_Indices_Interactive_StackPointer = $17A6
Enemy_Indices_Active_Index = $17A8
Enemy_Indices_Interactive_Inxex = $17AA
Enemy_Indices_Active = $17AC
Enemy_Indices_Interactive = $17EC
Enemy_Index_Samus_Collide_Left = $182C
Enemy_Index_Samus_Collide_Right = $182E
Enemy_Index_Samus_Collide_Up = $1830
Enemy_Index_Samus_Collide_Down = $1832
Enemy_Distance_Samus_Collide_Left = $1834
Enemy_Distance_Samus_Collide_Right = $1836
Enemy_Distance_Samus_Collide_Up = $1838
Enemy_Distance_Samus_Collide_Down = $183A
Process_All_Enemies_Flag = $183C
Earthquake_Type = $183E
Earthquake_Timer = $1840
Every_Frame_Counter = $1842
Sprite_Object_Index = $1844
Debug_Enemy_Index = $1846
UNUSED_1848 = $1848
Samus_X_Pos_Collide_Enemy = $184A
Samus_X_Subpos_Collide_Enemy = $184C
Enemy_X_Pos_Collide_Enemy = $184E
Enemy_X_Subpos_Collide_Enemy = $1850
Samus_Pos_Delta_Collide_Enemy = $1852
Samus_Subpos_Delta_Collide_Enemy = $1854
Samus_Y_Pos_Collide_Enemy = $1856
Samus_Y_Subpos_Collide_Enemy = $1858
Solid_Enemy_Collision_Type = $185A

Debug_Index = $185C
Debug_Time_Frozen_Enemies = $185E
Debug_Text_Cursor_X = $1860
Debug_Text_Cursor_Y = $1862
Debug_Enemy_Set_Entry_Index = $1864
Debug_Enemy_Population_Pointer = $1866
Debug_Enemy_Spawn_X = $1868
Debug_Enemy_Spawn_Y = $186A
UNUSED_186C = $186C

Enemy_Spritemap_Pointer_Collision = $186E
Enemy_LeftBorder_Collision = $1870
Enemy_BottomBorder_Collision = $1872
Enemy_RightBorder_Collision = $1874
Enemy_TopBorder_Collision = $1876
Enemy_Pointer_1878 = $1878
Enemy_Spritemap_X_Collision = $187A
Enemy_Spritemap_Y_Collision = $187C

Samus_RightBorder_Collision = $187E
Samus_LeftBorder_Collision = $1880
Samus_BottomBorder_Collision = $1882
Samus_TopBorder_Collision = $1884

UNUSED_1886 = $1886
UNUSED_1888 = $1888
UNUSED_188A = $188A
UNUSED_188C = $188C
UNUSED_188E = $188E
UNUSED_1890 = $1890
UNUSED_1892 = $1892
UNUSED_1894 = $1894
UNUSED_1896 = $1896
UNUSED_1898 = $1898

Samus_Target_X_Pos_Collision = $189A
Samus_Target_X_Subpos_Collision = $189C
Samus_Target_Y_Pos_Collision = $189E
Samus_Target_Y_Subpos_Collision = $18A0
Samus_X_Radius_Mirror_Collision = $18A2
Samus_Y_Radius_Mirror_Collision = $18A4
Collision_Index_18A6 = $18A6
Samus_Invulnerability_Timer = $18A8
Samus_Knockback_Timer = $18AA
Proj_Invulnerability_Timer = $18AC
Debug_Disable_Proj_Samus_Interactions = $18AE

HDMAObjects_Flag = $18B0
HDMAObject_Index = $18B2
HDMAObject_Channels_Low = $18B4
HDMAObject_ChannelIndices_Low = $18C0
HDMAObject_InstrList_Pointers = $18CC
HDMAObject_Table_Pointers = $18D8
HDMAObject_Instr_Timers = $18E4
HDMAObject_PreInstr = $18F0
HDMAOBject_PreInstr_Banks = $18FC
HDMAObject_Timers_Low = $1908

UNUSED_1914 = $1914
UNUSED_1916 = $1916
UNUSED_1918 = $1918
UNUSED_191A = $191A
UNUSED_191C = $191C
UNUSED_191E = $191E
UNUSED_1920 = $1920
UNUSED_1922 = $1922
UNUSED_1924 = $1924
UNUSED_1926 = $1926
UNUSED_1928 = $1928
UNUSED_192A = $192A
UNUSED_192C = $192C
UNUSED_192E = $192E
UNUSED_1930 = $1930
UNUSED_1932 = $1932
UNUSED_1934 = $1934
UNUSED_1936 = $1936
UNUSED_1938 = $1938
UNUSED_193A = $193A
UNUSED_193C = $193C
UNUSED_193E = $193E
UNUSED_1940 = $1940
UNUSED_1942 = $1942
UNUSED_1944 = $1944
UNUSED_1946 = $1946
UNUSED_1948 = $1948
UNUSED_194A = $194A
UNUSED_194C = $194C
UNUSED_194E = $194E
UNUSED_1950 = $1950
UNUSED_1952 = $1952
UNUSED_1954 = $1954
UNUSED_1956 = $1956
UNUSED_1958 = $1958
UNUSED_195A = $195A

FX_Y_Subpos = $195C
FX_Y_Pos = $195E
LavaAcid_Y_Subpos = $1960
LavaAcid_Y_Pos = $1962
FX_Tilemap_Pointer = $1964
Current_FX_Entry_Pointer = $1966
Current_FX_Entry_Offset = $1968
Current_FX_PaletteFX_AnimTiles_Bitset = $196A
FX_Rising_Function = $196C
FX_Type = $196E
FX_Y_Suboffset = $1970
FX_Y_Offset = $1972
Tide_Phase = $1974
FX_Base_Y_Subpos = $1976
FX_Base_Y_Pos = $1978
FX_Target_Y_Pos = $197A
FX_Y_Subvelocity = $197C
FX_Y_Velocity = $197D
FX_Liquid_Options = $197E
FX_Timer = $1980
Default_LayerBlending_Config = $1982
FX_Layer3Blending_Config = $1984
LayerBlending_Config = $1986
LayerBlending_Window2_Config = $1987
Phantoon_LayerBlending_1988 = $1988
UNUSED_198A = $198A
UNUSED_198B = $198B
UNUSED_198C = $198C

Enemy_Proj_Flag = $198D
Enemy_Proj_UNUSED_198F = $198F
Enemy_Proj_Index = $1991
Enemy_Proj_Init_Param = $1993
Enemy_Proj_UNUSED_1995 = $1995
Enemy_Proj_IDs = $1997
Enemy_Proj_GFX_Indicies = $19BB
Enemy_Proj_Timers = $19DF
Enemy_Proj_PreInstr = $1A03
Enemy_Proj_Vars_1A27 = $1A27
Enemy_Proj_X_Pos = $1A4B
Enemy_Proj_Vars_1A6F = $1A6F
Enemy_Proj_Y_Pos = $1A93
Enemy_Proj_Vars_1AB7 = $1AB7
Enemy_Proj_Vars_1ADB = $1ADB
Enemy_Proj_Vars_1AFF = $1AFF
Enemy_Proj_Vars_1B23 = $1B23
Enemy_Proj_InstrList_Pointers = $1B47
Enemy_Proj_Spritemap_Pointers = $1B6B
Enemy_Proj_Instr_Timers = $1B8F
Enemy_Proj_Radii = $1BB3
Enemy_Proj_Prop = $1BD7
Enemy_Proj_Table_1BFB = $1BFB

MessageBox_Index = $1C1F
UNUSED_1C21 = $1C21

PLM_Flag = $1C23
PLM_Draw_Tilemap_Index = $1C25
PLM_ID = $1C27
PLM_X_Block = $1C29
PLM_Y_Block = $1C2B
PLM_Item_GFX_Index = $1C2D
PLM_Item_GFX_Pointers = $1C2F
PLM_IDs = $1C37
PLM_Block_Indices = $1C87
PLM_PreInstr = $1CD7
PLM_InstrList_Pointers = $1D27
PLM_Timers = $1D77
PLM_Room_Arguments = $1DC7
PLM_Vars = $1E17

CustomDrawInstr_Number_Blocks = $1E67
CustomDrawInstr_PLM_Block = $1E69
CustomDrawInstr_Zero_Terminator = $1E6B
TourianStatue_Finished_Processing = $1E6D
TourianStatue_Anim_State = $1E6F
Samus_Quicksand_Flag = $1E71
Samus_Inside_Block_Reaction_Point = $1E73

Save_Station_Lockout = $1E75
Current_Slope_BTS = $1E77

PaletteFX_Objects_Flag = $1E79
PaletteFX_Object_Index = $1E7B
PaletteFX_Object_IDs = $1E7D
PaletteFX_Object_Color_Indicies = $1E8D
PaletteFX_Object_Vars = $1E9D
PaletteFX_Object_PreInstr = $1EAD
PaletteFX_Object_InstrList_Pointers = $1EBD
PaletteFX_Object_Instr_Timers = $1ECD
PaletteFX_Object_Timers = $1EDD
PaletteFX_Samus_Heat_Index = $1EED
PaletteFX_Prev_Samus_Heat_Index = $1EEF

AnimTiles_Object_Flag = $1EF1
AnimTiles_Object_Index = $1EF3
AnimTiles_Object_IDs = $1EF5
AnimTiles_Object_Timers = $1F01
AnimTiles_Object_InstrList_Pointers = $1F0D
AnimTiles_Object_Instr_Timers = $1F19
AnimTiles_Object_Src_Addr = $1F25
AnimTiles_Object_Sizes = $1F31
AnimTiles_Object_VRAM_Addr = $1F3D
AnimTiles_Object_Instr = $1F49

Cinimatic_Function = $1F51
Demo_Timer = $1F53
Demo_Set = $1F55
Demo_Scene = $1F57
Total_Demo_Sets = $1F59
