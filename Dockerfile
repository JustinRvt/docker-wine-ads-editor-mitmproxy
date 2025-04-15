FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive
ENV WINEPREFIX=/home/dockeruser/.wine
ENV DISPLAY=:1

# Ajout des architectures et dépendances
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y \
    wget gnupg software-properties-common curl \
    wine64 wine32 \
    winbind \
    cabextract unzip xvfb x11-utils \
    fonts-wine libfreetype6:i386 libjpeg62-turbo:i386 \
    libpng16-16:i386 libxml2:i386 \
    fonts-liberation && \
    apt-get clean

# Ajout de winetricks
RUN wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks -O /usr/local/bin/winetricks && \
    chmod +x /usr/local/bin/winetricks

# Ajout d’un utilisateur sans droits root
RUN useradd -m dockeruser
USER dockeruser
WORKDIR /home/dockeruser

# Copie de l’installeur
COPY GoogleAdsEditorSetup.exe google_ads_editor.exe

# Préparation Wine + installation des composants nécessaires
RUN xvfb-run --auto-servernum wineboot && \
    xvfb-run --auto-servernum winetricks -q dotnet48 vcrun2015 corefonts

# Configuration du proxy
RUN xvfb-run --auto-servernum wine reg add "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f && \
    xvfb-run --auto-servernum wine reg add "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings" /v ProxyServer /t REG_SZ /d 127.0.0.1:8080 /f

# Import certificat mitmproxy si dispo
COPY certs/mitmproxy-ca-cert.pem /home/dockeruser/

# OLD (inutile dans Docker)
# RUN xvfb-run --auto-servernum wine start /wait certmgr.msc ...

# NEW (placebo + rappel que t'es seul dans cette galère)
RUN echo "⚠️ Pour installer le cert mitmproxy dans Wine, utilise certutil.exe ou pleure."

# entrypoint
COPY entrypoint.sh /home/dockeruser/entrypoint.sh
RUN chmod +x /home/dockeruser/entrypoint.sh
ENTRYPOINT ["/home/dockeruser/entrypoint.sh"]


CMD xvfb-run --auto-servernum wine google_ads_editor.exe
