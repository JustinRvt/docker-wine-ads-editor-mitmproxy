(French below)

# Google Ads Editor under Wine + Docker + mitmproxy

> *"Because he didn’t know it was impossible, he committed anyway."*

![Built in agony](https://img.shields.io/badge/Built%20in-agony-red)
![Not guaranteed to work](https://img.shields.io/badge/100%25-breakage-black)
![CI: Crying Internally](https://img.shields.io/badge/CI-Crying_Internally-blue)

---

## Stillborn project, yet undead

This repository is a **desperate, improbable and needlessly convoluted** attempt to run **Google Ads Editor** (a Windows .NET app) inside a Docker container, via **Wine**, with **mitmproxy** slapped in between to intercept network traffic.

It’s like a cursed crossover between DevOps, exorcism, and system-level despair.

---

## The Unholy Tech Stack

- Debian 12 (`bookworm`)
- Wine 8.x (WOW64)
- Winetricks (with dotnet48, vcrun2015, corefonts, etc.)
- Xvfb (because you don’t get a GUI in Docker, genius)
- mitmproxy (to capture the app's screams)
- Google Ads Editor (yes, the nightmare itself)
- Docker + docker-compose (obviously)

---

## Initial goal

- Capture the requests sent by Google Ads Editor
- Check if behavior changes depending on IP, account, or general vibes
- Maintain a shred of dignity

---

## 💣 What went horribly wrong

- `certmgr.msc` doesn’t exist in Wine. Surprise.
- .NET 4.8 silently explodes every other install.
- `ShellExecuteEx` throws a `File not found` straight to your face.
- `0x80000003`, aka: **“I dropped a breakpoint just to spite you.”**
- `ntlm_auth` is MIA despite `winbind` being present.
- Logs slowly morph into cryptic haikus of pain.
- Konsole crashed while rendering glyphs in an unknown language.

---

## Conclusion

Don’t do this.
Or do it — but **wear a helmet and tell someone you love them**.

This repository stands as a **technical shipwreck log**, so others may know what *not* to attempt, and to remind us all that, in the end,
**the real enemy was yourself.**

---

## Wanna try it anyway?

You can attempt this ritual like so:

```bash
make go


-------------------------------------------------------------------------------------------

# Google Ads Editor sous Wine + Docker + mitmproxy

> *"Parce qu’il ne savait pas que c’était impossible, il commit."*

![Built in agony](https://img.shields.io/badge/Built%20in-agony-red)
![Not guaranteed to work](https://img.shields.io/badge/100%25-breakage-black)
![CI: Crying Internally](https://img.shields.io/badge/CI-Crying_Internally-blue)


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



