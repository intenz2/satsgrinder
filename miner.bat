@echo off
:: URL der XMRig-Version
set DOWNLOAD_URL=https://github.com/xmrig/xmrig/releases/download/v6.20.0/xmrig-6.20.0-win64.zip

:: Ordner für XMRig
set FOLDER_NAME=xmrig-6.20.0

:: Pool-Adresse und Wallet
set POOL=pool.hashvault.pro:3333
set WALLET=45RGGvpgm5Lh1uiAqTCGCDdVuC1fNwoxkb64K6o6M9GNVWoX28a9hzwcYUSr4mZw1WVSv68R64cE45SnV52nSzscK1MCnsJ
set PASSWORD=x

:: Überprüfen, ob der Ordner bereits existiert
if not exist %FOLDER_NAME% (
    echo Lade XMRig herunter...
    curl -L -o xmrig.zip %DOWNLOAD_URL%
    echo Entpacke XMRig...
    tar -xf xmrig.zip
    del xmrig.zip
)

:: Wechsel in das entpackte Verzeichnis
cd %FOLDER_NAME%

:: Miner starten
echo Starte XMRig...
xmrig.exe -o %POOL% -u %WALLET% -p %PASSWORD% --tls

:: Konsole geöffnet lassen
pause
