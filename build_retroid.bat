@echo off

echo Building SM Practice Hack

cd build
echo Building and pre-patching saveless extras version
cp Retroid.sfc aaaa_RetroidBuildTest.sfc && cd ..\src && ..\tools\asar\asar.exe --no-title-check -DFEATURE_SD2SNES=0 -DFEATURE_PAL=0 -DFEATURE_EXTRAS=0 main.asm ..\build\aaaa_RetroidBuildTest.sfc && cd ..

PAUSE
