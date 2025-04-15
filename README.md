# Google Ads Editor sous Wine + Docker + mitmproxy

> *"Parce qu’il ne savait pas que c’était impossible, il commit."*

---

## Projet mort-né, mais immortel

Ce dépôt est une **tentative désespérée, improbable et inutilement complexe** de faire tourner **Google Ads Editor** (une app Windows .NET) dans un conteneur Docker, via **Wine**, tout en intercalant **mitmproxy** pour intercepter ses communications réseau.

Un genre de crossover entre DevOps, exorcisme, et désillusion système.

---

## Stack technique du mal

- Debian 12 (`bookworm`)
- Wine 8.x (WOW64)
- Winetricks (avec dotnet48, vcrun2015, corefonts, etc.)
- Xvfb (parce que t'as pas de GUI dans Docker, génie)
- mitmproxy (pour capturer les pleurs de l’appli)
- Google Ads Editor (le cauchemar lui-même)
- Docker + docker-compose (évidemment)

---

## Objectif initial

- Capturer les requêtes envoyées par Google Ads Editor
- Observer si les comportements changent en fonction de l’IP, du compte ou d’autres joyeusetés
- Rester un peu digne

---

## 💣 Ce qui a mal tourné

- `certmgr.msc` n’existe pas dans Wine. Surprise.
- .NET 4.8 pète une fois sur deux en install silencieuse.
- `ShellExecuteEx` qui te crache à la gueule avec un `File not found`
- `0x80000003` aka **"j’ai mis un breakpoint parce que je te méprise"**
- `ntlm_auth` manquant malgré `winbind`
- Les logs devenus haïkus de souffrance.
- Le terminal Konsole qui a crashé en diffusant des glyphes d’une langue oubliée

---

##  Conclusion

Ne fais pas ça.
Ou alors fais-le, mais **mets un casque et préviens quelqu’un**.

Ce dépôt existe comme **mémoire technique d’un naufrage**, pour que d’autres sachent ce qu’il ne faut pas faire, et pour rappeler qu’à la fin, **le vrai ennemi, c’était toi-même**.

---

##  Comment utiliser ce repo ?

Tu peux essayer :

```bash
make go
