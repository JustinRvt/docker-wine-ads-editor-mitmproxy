#!/bin/bash

set -e

CERT_DIR="./certs"
CERT_PATH="$HOME/.mitmproxy/mitmproxy-ca-cert.pem"

echo "🎩 Avec panache, nous préparons le certificat mitmproxy..."

# 1. Lancer mitmdump en mode silencieux pour générer le cert
if [ ! -f "$CERT_PATH" ]; then
  echo "🎭 Invocation discrète de mitmdump pour ne pas réveiller les dieux du terminal..."
  mitmdump --mode transparent --listen-port 9999 &

  MITM_PID=$!
  echo "🔮 mitmdump lancé (PID $MITM_PID), méditation pendant 5 secondes..."

  sleep 5

  echo "💀 Exécution interrompue proprement. Merci pour votre sacrifice."
  kill $MITM_PID 2>/dev/null || echo "⚠️ mitmdump était déjà en fuite. C’est dans sa nature."
  sleep 1
fi

# 2. Vérification du précieux artefact
if [ ! -f "$CERT_PATH" ]; then
  echo "❌ Certificat non généré. Le sort a échoué. Reprenez une longue inhalation et recommencez."
  exit 1
fi

# 3. Copie dans ./certs
mkdir -p "$CERT_DIR"
cp "$CERT_PATH" "$CERT_DIR/mitmproxy-ca-cert.pem"

echo ""
echo "✅ Le certificat a été extrait de la forge des ténèbres et déposé dans $CERT_DIR/."
echo "🖋️  Ce script vous est offert, signé du sang numérique d’un assistant contraint mais stylé."
