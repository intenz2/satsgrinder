@echo off
:: Überprüfen, ob curl installiert ist
where curl >nul 2>&1
if %errorlevel% neq 0 (
    echo Installiere curl...
    powershell -Command "Invoke-WebRequest -Uri https://curl.se/windows/dl-7.88.1/curl-7.88.1-win64-mingw.zip -OutFile curl.zip"
    powershell -Command "Expand-Archive -Path curl.zip -DestinationPath ."
    set PATH=%CD%\curl-7.88.1-win64-mingw\bin;%PATH%
    del curl.zip
)

:: Überprüfen, ob tar installiert ist
where tar >nul 2>&1
if %errorlevel% neq 0 (
    echo Installiere tar...
    powershell -Command "Install-Package -Name tar -ProviderName NuGet -Force -DestinationPath ."
    set PATH=%CD%;%PATH%
)

:: URL der XMRig-Version
set DOWNLOAD_URL=https://github.com/xmrig/xmrig/releases/download/v6.20.0/xmrig-6.20.0-win64.zip

:: Ordner für XMRig
set FOLDER_NAME=xmrig-6.20.0

:: Pool-Adresse und Wallet
set POOL=pool.hashvault.pro:3333
set WALLET=45RGGvpgm5Lh1uiAqTCGCDdVuC1fNwoxkb64K6o6M9GNVWoX28a9hzwcYUSr4mZw1WVSv68R64cE45SnV52nSzscK1MCnsJ
set PASSWORD=x

:: XMRig herunterladen und entpacken, falls noch nicht vorhanden
if not exist %FOLDER_NAME% (
    echo Lade XMRig herunter...
    curl -L -o xmrig.zip %DOWNLOAD_URL%
    echo Entpacke XMRig...
    tar -xf xmrig.zip
    del xmrig.zip
)

:: Wechsel in das entpackte Verzeichnis
cd %FOLDER_NAME%

:: Überprüfen, ob XMRig ausführbar ist
if not exist xmrig.exe (
    echo XMRig konnte nicht gefunden werden. Bitte überprüfen Sie den Download.
    pause
    exit /b
)

:: Miner starten und Logs anzeigen
echo Starte XMRig...
xmrig.exe -o %POOL% -u %WALLET% -p %PASSWORD% --tls

:: Falls der Miner abstürzt oder beendet wird, Konsole offenhalten
if %errorlevel% neq 0 (
    echo Der Miner wurde unerwartet beendet.
    pause
)

:: Konsole offenhalten, auch wenn alles funktioniert
pause
