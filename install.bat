@echo off
setlocal EnableExtensions
set "DEFAULT=D:\gog\GOG Galaxy\Games\Might and Magic 6"
if not "%~1"=="" set "GAME=%~1"
if not defined GAME set /p "GAME=Enter MM6 folder [default: %DEFAULT%]: "
if not defined GAME set "GAME=%DEFAULT%"
if not exist "%GAME%\MM6.exe" (
    echo MM6.exe was not found in this folder.
    pause
    exit /b 1
)

set "BACKUP=%GAME%\Backup-MM6-Compatibility"
if not exist "%BACKUP%" mkdir "%BACKUP%"
if not exist "%BACKUP%\MM6.exe" copy /Y "%GAME%\MM6.exe" "%BACKUP%\MM6.exe" >nul
if exist "%GAME%\MM6.ini" if not exist "%BACKUP%\MM6.ini" copy /Y "%GAME%\MM6.ini" "%BACKUP%\MM6.ini" >nul
if exist "%GAME%\mm6lang.ini" if not exist "%BACKUP%\mm6lang.ini" copy /Y "%GAME%\mm6lang.ini" "%BACKUP%\mm6lang.ini" >nul
if exist "%GAME%\MM6patch.dll" if not exist "%BACKUP%\MM6patch.dll" copy /Y "%GAME%\MM6patch.dll" "%BACKUP%\MM6patch.dll" >nul
if not exist "%BACKUP%\data" mkdir "%BACKUP%\data"
if exist "%GAME%\data\icons.lod" if not exist "%BACKUP%\data\icons.lod" copy /Y "%GAME%\data\icons.lod" "%BACKUP%\data\icons.lod" >nul
if exist "%GAME%\data\games.lod" if not exist "%BACKUP%\data\games.lod" copy /Y "%GAME%\data\games.lod" "%BACKUP%\data\games.lod" >nul
if not exist "%BACKUP%\Sounds" mkdir "%BACKUP%\Sounds"
if exist "%GAME%\Sounds\Audio.snd" if not exist "%BACKUP%\Sounds\Audio.snd" copy /Y "%GAME%\Sounds\Audio.snd" "%BACKUP%\Sounds\Audio.snd" >nul

for %%F in ("00 patch.icons.lod" "10 LocZHCN.icons.lod" "00 patch.games.lod") do (
    if exist "%GAME%\data\%%F" (
        if not exist "%BACKUP%\data\%%F" copy /Y "%GAME%\data\%%F" "%BACKUP%\data\%%F" >nul
        move /Y "%GAME%\data\%%F" "%GAME%\data\%%F.disabled" >nul
    )
)

robocopy "%~dp0payload" "%GAME%" /E /R:1 /W:1 /NFL /NDL /NP
if errorlevel 8 (
    echo Copy failed. Check folder permissions or run as administrator.
    pause
    exit /b 1
)

echo.
echo Install complete. Start MM6.exe.
echo WASD movement, A/D strafe, mouse look. CapsLock or middle mouse toggles mouse look.
echo F5 quick save, F8 quick load, F2 double speed, F3 autorun.
echo Backup: %BACKUP%
pause
