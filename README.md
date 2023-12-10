# Super Metroid Practice Hack

This page hosts the source material for the Super Metroid Practice Hack. It is intended for users that wish to contribute to the project, customize their own Practice Hacks, adapt it for SM romhacks, or just to see how it works. Visit https://smpractice.speedga.me for details on patching your SM rom with the latest version of InfoHUD.

The assembler, asar, is provided for your convenience. You can download your own copy or build it from its official source at https://github.com/RPGHacker/asar

## Building IPS Patches:

1. Download and install Python 3+ from https://python.org. Windows users will need to set the PATH environmental variable to point to their Python installation folder.
2. Run build.bat to create IPS patch files.
3. Locate the patch files in the \build\ folder.

## Patching Your ROM:

1. Rename your unheadered SM rom to `sm_orig.sfc` and place it in the \build\ folder.
2. (Optional) Edit build_fast.bat to enable "DFEATURES" such as SD2SNES savestates
3. Run build_fast.bat to generate a patched practice rom in \build\ named `FastBuildTest.sfc`.

## Which rom should I use?

The build script will create three IPS patch files for the practice hack. The patch that features "Savestates" in the filename will have the built-in savestate feature enabled. This is only intended for use with the SD2SNES cartridge and will likely cause crashes if used with Everdrives and most emulators (including Virtual Console). The Super NT is compatible, although it may require a firmware update. The patch that features "tinystates" in the filename has a modified version of the savestate feature with wider compatibility with emulators and EverDrives. Virtual Console players (including SNES Classic) will need to use the third option without built-in savestates.

You will need an IPS patcher utility, such as [Lunar IPS](http://fusoya.eludevisibility.org/lips/) or [Floating IPS](https://www.romhacking.net/utilities/1040/), to apply the patch to your vanilla SM rom. Regardless of which tool you use, the process is the same: you select the .IPS file and a copy of your SM ROM file, and it will replace the ROM with a patched practice hack ROM. Then simply load up the patched ROM in your emulator or flash cart of choice. If all goes well, you're done and can delete the .IPS file if you like.
