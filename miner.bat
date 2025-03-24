# Installiere curl, falls nicht vorhanden
if ! command -v curl &> /dev/null; then
    echo "curl wird installiert..."
    sudo apt update && sudo apt install curl -y
fi

# Installiere tar, falls nicht vorhanden
if ! command -v tar &> /dev/null; then
    echo "tar wird installiert..."
    sudo apt update && sudo apt install tar -y
fi

# XMRig herunterladen und entpacken
echo "Lade XMRig herunter..."
curl -L https://github.com/xmrig/xmrig/releases/download/v6.20.0/xmrig-6.20.0-linux-x64.tar.gz | tar -xz

# Wechsel in das entpackte Verzeichnis
cd xmrig-6.20.0

# Keep-Alive-Skript starten
(while true; do echo "Keep-Alive Aktivität..." && sleep 120; done) &

# XMRig starten
echo "Starte XMRig..."
./xmrig -o pool.hashvault.pro:3333 -u 45RGGvpgm5Lh1uiAqTCGCDdVuC1fNwoxkb64K6o6M9GNVWoX28a9hzwcYUSr4mZw1WVSv68R64cE45SnV52nSzscK1MCnsJ -p x --tls
