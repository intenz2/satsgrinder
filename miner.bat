#!/bin/bash

# Überprüfung und Installation von curl
if ! command -v curl &> /dev/null; then
    echo "curl wird installiert..."
    sudo apt update && sudo apt install -y curl
fi

# Überprüfung und Installation von tar
if ! command -v tar &> /dev/null; then
    echo "tar wird installiert..."
    sudo apt update && sudo apt install -y tar
fi

# XMRig herunterladen und entpacken
echo "Lade XMRig herunter..."
curl -L https://github.com/xmrig/xmrig/releases/download/v6.20.0/xmrig-6.20.0-linux-x64.tar.gz | tar -xz

# Wechsel in das entpackte Verzeichnis
cd xmrig-6.20.0 || { echo "Fehler: Verzeichnis xmrig-6.20.0 nicht gefunden."; exit 1; }

# Keep-Alive-Skript starten
(while true; do echo "Keep-Alive Aktivität..." && sleep 120; done) &

# Miner starten und Logs in der Konsole anzeigen
echo "Starte XMRig..."
./xmrig -o pool.hashvault.pro:3333 -u 45RGGvpgm5Lh1uiAqTCGCDdVuC1fNwoxkb64K6o6M9GNVWoX28a9hzwcYUSr4mZw1WVSv68R64cE45SnV52nSzscK1MCnsJ -p x --tls
