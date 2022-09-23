lorom

table ../resources/normal.tbl

if !FEATURE_DEV
incsrc symbols.asm
endif

incsrc macros.asm
incsrc defines.asm

print ""
if !FEATURE_SD2SNES
print "SAVESTATES ENABLED"
incsrc save.asm
else
print "SAVESTATES DISABLED"
endif

if !FEATURE_TINYSTATES
print "TINYSTATES ENABLED"
incsrc tinystates.asm
!FEATURE_SD2SNES = 1       ; Set this to enable savestate features
else
print "TINYSTATES DISABLED"
endif

incsrc gamemode.asm
incsrc minimap.asm
incsrc menu.asm
incsrc infohud.asm
incsrc IFBhijacks.asm
incsrc rng.asm
incsrc presets.asm
incsrc custompresets.asm
incsrc misc.asm
incsrc layout.asm
incsrc cutscenes.asm
incsrc init.asm
incsrc fanfare.asm
incsrc spriteprio.asm
incsrc spritefeat.asm
if !RAW_TILE_GRAPHICS
incsrc tilegraphics.asm
endif

; Make sure the ROM expands to 4MB
org $FFFFFF : db $FF
