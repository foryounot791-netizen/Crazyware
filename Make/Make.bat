@echo off
setlocal enabledelayedexpansion

:: Request admin rights
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

:menu1
for /f %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"
cls
echo Creator           : !ESC![96manotherone!ESC![0m
echo Youtube Channel   : !ESC![96mhttps://www.youtube.com/@anotherone-h9e!ESC![0m
echo Phone Number      : !ESC![96m+62 814-6977-8172!ESC![0m
echo.
echo !ESC![94mYou can type N to cancel, Y to continue!ESC![0m
echo !ESC![94mType "see channel" to open YouTube, "call number" to open WhatsApp!ESC![0m
echo.

set "pilihan="
set /p pilihan=Choose... (Y/N): 

if /i "%pilihan%"=="call number" (
    echo Starting WhatsApp Web...
    timeout /t 3 >nul
    start msedge.exe "https://wa.me/6281469778172"
    exit /b
)
if /i "%pilihan%"=="see channel" (
    echo Starting Microsoft Edge...
    timeout /t 2 >nul
    start msedge.exe "https://www.youtube.com/@anotherone-h9e"
    goto menu1
)
if /i "%pilihan%"=="Y" goto lanjut
if /i "%pilihan%"=="N" exit /b

cls
echo !ESC![91mSyntax Error: "%pilihan%" is not defined!ESC![0m
timeout /t 4 >nul
goto menu1

:lanjut
cls
set "ekstensi="
set /p urat=Make A Folder Or File? (folder/file): 

if /i "%urat%"=="folder" goto nama_folder
if /i "%urat%"=="file" goto pilih_jenis_file

cls
echo !ESC![91mSyntax Error: "%urat%" is not defined!ESC![0m
timeout /t 4 >nul
goto lanjut

:pilih_jenis_file
cls
echo !ESC![97mSelect File Type:!ESC![0m
echo !ESC![92m- txt   = Text Document File!ESC![0m
echo !ESC![92m- bat   = Batch Script File!ESC![0m
echo !ESC![92m- cpp   = C++ Source File!ESC![0m
echo !ESC![92m- py    = Python Script File!ESC![0m
echo !ESC![92m- ps1   = PowerShell Script File!ESC![0m
echo.

set "ekstensi="
set /p pil_jenis=Enter choice: 

if /i "%pil_jenis%"=="txt"  set "ekstensi=.txt"
if /i "%pil_jenis%"=="bat"  set "ekstensi=.bat"
if /i "%pil_jenis%"=="cpp"  set "ekstensi=.cpp"
if /i "%pil_jenis%"=="py"   set "ekstensi=.py"
if /i "%pil_jenis%"=="ps1"  set "ekstensi=.ps1"

if not defined ekstensi (
    cls
    echo !ESC![91mInvalid file type!ESC![0m
    timeout /t 3 >nul
    goto pilih_jenis_file
)

cls
echo !ESC![93mEnter your content below:!ESC![0m
echo !ESC![93m(Type DONE to finish, BACK to go back)!ESC![0m
echo.

del "%temp%\temp_code.txt" 2>nul
:input_kode
set "baris="
set /p "baris=> "
if /i "!baris!"=="DONE" goto simpan_kode
if /i "!baris!"=="BACK" goto lanjut
echo(!baris!>> "%temp%\temp_code.txt"
goto input_kode

:simpan_kode
cls
goto nama_folder

:nama_folder
cls
set "folding="
set /p folding=Enter file/folder name: 

:path
cls
echo !ESC![97mAvailable Locations:!ESC![0m
echo !ESC![92m- Pictures!ESC![0m
echo !ESC![92m- Documents!ESC![0m
echo !ESC![92m- Desktop!ESC![0m
echo !ESC![92m- Downloads!ESC![0m
echo !ESC![92m- Music!ESC![0m
echo !ESC![92m- Videos!ESC![0m
echo.

set "fold=" & set "exam="
set /p pil=Enter location name: 

if /i "%pil%"=="Pictures"   set "fold=%USERPROFILE%\Pictures\%folding%%ekstensi%" & set "exam=Pictures"
if /i "%pil%"=="Documents"  set "fold=%USERPROFILE%\Documents\%folding%%ekstensi%" & set "exam=Documents"
if /i "%pil%"=="Desktop"    set "fold=%USERPROFILE%\Desktop\%folding%%ekstensi%" & set "exam=Desktop"
if /i "%pil%"=="Downloads"  set "fold=%USERPROFILE%\Downloads\%folding%%ekstensi%" & set "exam=Downloads"
if /i "%pil%"=="Music"      set "fold=%USERPROFILE%\Music\%folding%%ekstensi%" & set "exam=Music"
if /i "%pil%"=="Videos"     set "fold=%USERPROFILE%\Videos\%folding%%ekstensi%" & set "exam=Videos"

if not defined fold (
    cls
    echo !ESC![91mSyntax Error: "%pil%" is not defined!ESC![0m
    timeout /t 3 >nul
    goto path
)

if defined ekstensi (
    copy /y "%temp%\temp_code.txt" "%fold%" >nul
    del "%temp%\temp_code.txt" 2>nul
    echo !ESC![92mFile "%folding%%ekstensi%" created successfully in %exam%!ESC![0m
) else (
    if not exist "%fold%" (
        mkdir "%fold%" >nul
        echo !ESC![92mFolder "%folding%" created successfully in %exam%!ESC![0m
    ) else (
        echo !ESC![93mFolder "%folding%" already exists in %exam%!ESC![0m
    )
)

timeout /t 3 >nul
if exist "%fold%" explorer.exe "%fold%"
goto menu1