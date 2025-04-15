#!/bin/bash
set -e

export WINEPREFIX=/home/dockeruser/.wine
export DISPLAY=:1

echo "🐸 [1/5] Démarrage du serveur X virtuel..."
Xvfb :1 -screen 0 1024x768x16 &

echo "📦 [2/5] Initialisation de Wine (si nécessaire)..."
wineboot -u

# Attente pour s'assurer que le display est prêt
sleep 2

echo "💉 [3/5] Installation du certificat mitmproxy..."
if [ -f "/home/dockeruser/mitmproxy-ca-cert.pem" ]; then
    wine64 reg add "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
    wine64 reg add "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings" /v ProxyServer /t REG_SZ /d 127.0.0.1:8080 /f

    # Tentative d'import automatique du certificat
    CERTUTIL="/home/dockeruser/certutil.exe"
    if [ -f "$CERTUTIL" ]; then
        echo "🔐 Import avec certutil..."
        wine "$CERTUTIL" -addstore "Root" Z:\\home\\dockeruser\\mitmproxy-ca-cert.pem || echo "❌ Certutil a échoué, passe à l’import manuel plus tard"
    else
        echo "⚠️ Certutil manquant, l’import automatique ne fonctionnera pas."
        echo "   Tu peux le copier dans le conteneur comme /home/dockeruser/certutil.exe"
    fi
else
    echo "⚠️ Aucun certificat mitmproxy trouvé à /home/dockeruser/mitmproxy-ca-cert.pem"
fi

echo "🚀 [4/5] Lancement de Google Ads Editor..."
wine google_ads_editor.exe

echo "🧹 [5/5] Nettoyage du serveur X"
killall Xvfb
