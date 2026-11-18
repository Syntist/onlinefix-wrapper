# onlinefix wrapper

`onlinefix` helps launch Proton games through UMU with the running host Steam client, including games launched outside Steam. It can be used with OnlineFix, [ReFix](https://github.com/Coronitaa/ReFix), and FreeTP. It works with Faugus and does not require adding a game to Steam or patching UMU. Compatibility depends on the game and fix; not every combination has been tested.

The wrapper uses the Proton runner selected by Faugus, creates a temporary compatibility-tool wrapper, and removes it when the launch finishes. The temporary wrapper passes the host Steam path to Proton after UMU has set up its environment and sets `UMU_USE_STEAM=0`. The launcher sets these Wine DLL overrides to native first, builtin second (`n,b`):

```text
winmm, winhttp, version, OnlineFix, OnlineFix64, SteamFix, SteamFix64,
EpicFix, EpicFix64, SteamOverlay, SteamOverlay64, steam_api, steam_api64,
StubDRM, StubDRM64, dnet, Custom, nrsc
```

Existing overrides for other DLLs are preserved; overrides for the names above are replaced. Some fixes use game-specific DLLs and may need additional overrides. These defaults may not be appropriate for every game.

## Install

Requires Python 3.9 or later, UMU, an installed Proton runner, and a running, signed-in native Steam client. To download and install the latest version directly from GitHub, run:

```sh
curl -fsSL https://raw.githubusercontent.com/Syntist/onlinefix-wrapper/main/install.sh | bash
```

This requires `curl`. If you cloned or downloaded the repository, install from its folder instead:

```sh
bash install.sh
```

This copies the executable to `~/.local/bin/onlinefix`. To uninstall, remove that file.

## Use in Faugus

Select an installed Proton runner and set the game's prefix normally. Add this command to the game's launch arguments, after any environment-variable lines:

```text
/home/YOUR_USER/.local/bin/onlinefix
```

Replace `YOUR_USER` with your Linux username, or use the full path printed by the installer. Start Steam and sign in, then launch the game through Faugus. Faugus passes its UMU command to `onlinefix` automatically.

The default Steam path is `~/.local/share/Steam`. If yours differs, put this environment variable before the wrapper command in the Faugus launch arguments:

```text
ONLINEFIX_STEAM_PATH=/path/to/Steam
```

The selected Steam directory must contain `legacycompat`. UMU's debug log may show an empty `STEAM_COMPAT_CLIENT_INSTALL_PATH`: the temporary Proton wrapper sets it afterward, before Proton starts. Steam initialization and individual games' online fixes can still vary with the Proton version, launcher, prefix, and game; a successful launch alone does not prove multiplayer works.

For direct use, supply the selected Proton path and prefix, followed by UMU and the game executable:

```sh
PROTONPATH="/path/to/Proton" WINEPREFIX="$HOME/Games/my-prefix" \
  ~/.local/bin/onlinefix umu-run "/path/to/game.exe"
```
