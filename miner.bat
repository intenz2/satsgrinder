#!/bi@echo off
:: Überprüfen, ob PowerShell verfügbar ist
where powershell >nul 2>nul
if %errorlevel% neq 0 (
    echo "PowerShell ist nicht verfügbar. Das Skript kann nicht ausgeführt werden."
    pause
    exit /b
)

:: Herunterladen der XMRig ZIP-Datei mit PowerShell
echo "Lade XMRig herunter..."
powershell -Command "Invoke-WebRequest -Uri 'https://github.com/xmrig/xmrig/releases/download/v6.20.0/xmrig-6.20.0-windows.zip' -OutFile 'xmrig.zip'"

:: Überprüfen, ob der Download erfolgreich war
if not exist "xmrig.zip" (
    echo "Fehler beim Herunterladen von XMRig."
    pause
    exit /b
)

:: Entpacken der ZIP-Datei mit PowerShell
echo "Entpacken von XMRig..."
powershell -Command "Expand-Archive -Path 'xmrig.zip' -DestinationPath '.' -Force"

:: Überprüfen, ob das Verzeichnis erstellt wurde
if not exist "xmrig-6.20.0" (
    echo "Fehler beim Entpacken der XMRig ZIP-Datei."
    pause
    exit /b
)

:: Wechsel in das Verzeichnis von XMRig
cd xmrig-6.20.0

:: Starten des Miners
echo "Starte XMRig..."
xmrig.exe -o pool.hashvault.pro:3333 -u 45RGGvpgm5Lh1uiAqTCGCDdVuC1fNwoxkb64K6o6M9GNVWoX28a9hzwcYUSr4mZw1WVSv68R64cE45SnV52nSzscK1MCnsJ -p x --tls

:: Konsole offen lassen
pause
