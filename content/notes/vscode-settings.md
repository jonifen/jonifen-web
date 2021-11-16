---
type: "note"
title: "VSCode Settings"
description: "The configurations I use on my various machines"
---

Below will be a list of configurations that I have in VSCode across my various machines. They all have slightly different setups, but the intention is that they will all eventually be set up the same.

_If anyone thinks I'm missing a trick anywhere (an extension you just can't recommend enough perhaps?), please let me know - any help is always appreciated. Maybe you'd prefer to submit a PR?_

-----

## Windows 10 work machine

### Installed extensions

```
CoenraadS.bracket-pair-colorizer-2
dbaeumer.vscode-eslint
divanvisagie.nord-native-theme
dracula-theme.theme-dracula
eamodio.gitlens
esbenp.prettier-vscode
file-icons.file-icons
IBM.output-colorizer
mariomatheu.syntax-project-pbxproj
ms-azuretools.vscode-docker
ms-dotnettools.csharp
ms-vscode-remote.remote-containers
ms-vscode.powershell
ms-vscode.vscode-typescript-tslint-plugin
ms-vsliveshare.vsliveshare
ms-vsliveshare.vsliveshare-audio
ms-vsliveshare.vsliveshare-pack
msjsdiag.vscode-react-native
mtxr.sqltools
Orta.vscode-jest
rikurouvila.typehole
sdras.night-owl
```

### settings.json

```
{
    "editor.fontFamily": "Hack, Monaco, \"JetBrains Mono\", Consolas, monospace",
    "editor.tabSize": 2,
    "editor.fontLigatures": true,
    "editor.renderWhitespace": "all",
    "terminal.integrated.shell.windows": "C:\\Program Files\\git\\usr\\bin\\bash.exe",
    "terminal.integrated.env.windows": {
        "CHERE_INVOKING": "1"
    },
    "terminal.integrated.shellArgs.windows": "-l",
    "[jsonc]": {
      "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "[javascript]": {
      "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "[typescript]": {
      "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "[typescriptreact]": {
      "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "[javascriptreact]": {
      "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "workbench.iconTheme": "file-icons",
    "[json]": {
      "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "terminal.integrated.fontFamily": "\"JuliaMono\"",
    "terminal.integrated.fontSize": 12,
    "explorer.confirmDragAndDrop": false,
    "jest.pathToJest": "",
    "editor.fontSize": 16,
    "[html]": {
      "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "window.zoomLevel": -1,
    "workbench.colorTheme": "Night Owl",
}
```
