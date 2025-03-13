@echo off
chcp 65001 >nul
color 0A

:: zmjenne ini
goto start

:start
cls
echo ===================================
echo         UNDER BATCH RPG
echo ===================================
echo 1. Nowa Gra
echo 2. Wyjdz
set /p choice= Wybierz opcje: 
if %choice%==1 goto new_game
if %choice%==2 exit
goto start

:new_game
cls
set /a HP=100
set /a ATK=10
set /a GOLD=0
set /a LVL=1
set /a XP=0

:game_loop
cls
echo ===================================
echo  by helion UNDER BATCH – Poziom %LVL%
echo ===================================
echo 1. Eksploruj lochy
echo 2. Sprawdz statystyki
echo 3. Sklep
echo 4. Wyjdz
set /p choice= Co robisz? 
if %choice%==1 goto explore
if %choice%==2 goto stats
if %choice%==3 goto shop
if %choice%==4 exit
goto game_loop

:explore
cls
echo Przeszukujesz lochy...
timeout /t 2 >nul
set /a event=%random% %% 3
if %event%==0 goto battle
if %event%==1 goto treasure
goto nothing

:battle
cls
echo Spotkales potwora!
set /a enemy_hp=30+%random% %% 20
set /a enemy_atk=5+%random% %% 5
echo Potwor ma %enemy_hp% HP i %enemy_atk% ATK.
echo 1. Walcz
echo 2. Uciekaj
set /p choice= Co robisz? 
if %choice%==1 goto fight
if %choice%==2 goto game_loop
goto battle

:fight
set /a enemy_hp=%enemy_hp% - %ATK%
echo Zadalem %ATK% obrazen! Potwor ma teraz %enemy_hp% HP.
if %enemy_hp% LEQ 0 goto victory
set /a HP=%HP% - %enemy_atk%
echo Potwor zadaje %enemy_atk% obrazen! Masz teraz %HP% HP.
if %HP% LEQ 0 goto game_over
timeout /t 2 >nul
goto fight

:victory
echo Pokonales potwora!
set /a XP=%XP%+10
set /a GOLD=%GOLD%+%random% %% 20 + 10
echo Zdobywasz 10 XP i %GOLD% zlota!
if %XP% GEQ 50 goto level_up
timeout /t 2 >nul
goto game_loop

:level_up
echo Awansowales na poziom %LVL%!
set /a LVL=%LVL%+1
set /a XP=0
set /a ATK=%ATK%+5
set /a HP=100
set /a GOLD=%GOLD%+50
timeout /t 2 >nul
goto game_loop

:treasure
cls
echo Znajdujesz skrzynie ze skarbem!
set /a treasure=%random% %% 100 + 50
set /a GOLD=%GOLD%+%treasure%
echo Zdobywasz %treasure% zlota!
timeout /t 2 >nul
goto game_loop

:nothing
cls
echo Nic nie znalazles...
timeout /t 2 >nul
goto game_loop

:stats
cls
echo ===== Twoje statystyki =====
echo Poziom: %LVL%
echo HP: %HP%
echo ATK: %ATK%
echo Zloto: %GOLD%
echo XP: %XP% / 50
pause
goto game_loop

:shop
cls
echo ===== Sklep =====
echo 1. Kup Miksture HP (20 zlota) [+20 HP]
echo 2. Kup Lepszy Miecz (50 zlota) [+5 ATK]
echo 3. Wyjdz
set /p choice= Co kupujesz? 
if %choice%==1 if %GOLD% GEQ 20 set /a GOLD=%GOLD%-20 & set /a HP=%HP%+20 & goto shop_success
if %choice%==2 if %GOLD% GEQ 50 set /a GOLD=%GOLD%-50 & set /a ATK=%ATK%+5 & goto shop_success
goto game_loop

:shop_success
echo Zakup udany!
timeout /t 2 >nul
goto game_loop

:game_over
cls
echo 💀 Zginales! Gra skonczona.
pause
exit