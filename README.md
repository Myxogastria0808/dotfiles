Some NixOS users can make full use of this dotfiles. This dotfiles has been created for successful setup on the ThinkPad X1 Carbon 7th. It has not been tested on other generations of the X1 Carbon, but users with other generations of the X1 Carbon may also be able to set it up successfully.

# Outline

## Environment

|                   |                        |
| ----------------- | ---------------------- |
| Target Hardware   | ThinkPad X1 Carbon 7th |
| Window Manager    | Hyprland (default)     |
| Terminal Emulator | Ghostty                |
| Shell             | zsh                    |
| Vim               | NixVim                 |
| Prompt            | starship               |
| Fingerprint       | Disable                |
| Bluetooth         | Enable                 |
| KDE connect       | Enable                 |
| Docker            | Enable                 |
| Japanese Input    | skk                    |
| TimeZone          | Asia/Tokyo             |
| i18n              | en_US.UTF-8            |

## Display Manager

This dotfiles uses **SDDM** as the display manager. The three desktop environments/compositors (KDE, COSMIC, Hyprland) are designed to run **independently** — only one should be active at a time. **Hyprland is the current default.**

> [!WARNING]
> Enabling multiple desktop environments simultaneously may cause conflicts (environment variable collisions, portal backend mismatches, session misconfiguration). Activate only one environment at a time.

```
modules/display-manager/
├── default.nix    # Shared config: SDDM, XWayland, xdg-portal, keyboard layout
│                  # Controls which environment is active via imports
├── kde/           # KDE Plasma 6
├── cosmic/        # COSMIC Desktop (by System76)
└── hyprland/      # Hyprland (Wayland compositor) ← currently active
```

### Switching Environments

The active desktop environment is controlled by a **single variable** in `flake.nix`. Changing it automatically selects the correct NixOS module, SDDM default session, and home-manager config — no manual import editing required.

**Edit `flake.nix`** and change `desktopEnvironment`:

```nix
# Valid options: "hyprland" | "kde" | "cosmic"
desktopEnvironment = "hyprland";
```

**Then apply:**

```shell
nixos
hm
```

| Value        | NixOS module loaded                 | SDDM default session | home-manager hyprland config |
| ------------ | ----------------------------------- | -------------------- | ---------------------------- |
| `"hyprland"` | `modules/display-manager/hyprland/` | `hyprland-uwsm`      | loaded                       |
| `"kde"`      | `modules/display-manager/kde/`      | `plasma`             | not loaded                   |
| `"cosmic"`   | `modules/display-manager/cosmic/`   | `cosmic`             | not loaded                   |

> For KDE, `defaultSession = "plasma"` selects the Wayland session. To use the X11 session instead, manually set `defaultSession = "plasmax11"` in `modules/display-manager/default.nix`.

### Sessions

| Session         | Type    | Environment | Description                                                                   |
| --------------- | ------- | ----------- | ----------------------------------------------------------------------------- |
| `plasmax11`     | X11     | KDE         | KDE Plasma 6 on X11                                                           |
| `plasma`        | Wayland | KDE         | KDE Plasma 6 on Wayland                                                       |
| `cosmic`        | Wayland | COSMIC      | Wayland-native DE by System76                                                 |
| `hyprland-uwsm` | Wayland | Hyprland    | Hyprland via UWSM (recommended) — **current default session**                 |
| `hyprland`      | Wayland | Hyprland    | Hyprland standalone (no UWSM) — **stability not guaranteed**, avoid if unsure |

### Key Points

- **SDDM runs on X11.** That is why `services.xserver.enable = true` is required even on a Wayland-first setup. SDDM itself starts as an X11 process; the selected session then launches as Wayland independently.

- **Only one environment should be active at a time.** Each environment sets its own `XDG_CURRENT_DESKTOP`, portal backends, and session variables. Enabling multiple simultaneously will produce conflicting system-wide environment variables and unpredictable behavior.

- **XWayland** (`programs.xwayland.enable = true`) allows legacy X11 applications to run inside any Wayland session (KDE Wayland, COSMIC, or Hyprland). Without it, X11-only apps will not start.

- **xdg-portal** is required for sandboxed apps (Flatpak) to access file dialogs, screenshots, screen sharing, and other desktop integration features. KDE and COSMIC configure their own portal backends automatically; Hyprland uses `xdg-desktop-portal-hyprland` (provided automatically by the NixOS Hyprland module from nixpkgs).

- **Hyprland + UWSM** (`withUWSM = true`): When launched through UWSM (Universal Wayland Session Manager), Hyprland runs as a proper systemd user session. This handles session lifecycle, environment variable propagation, and `systemd --user` integration automatically. **Always use the `hyprland-uwsm` session** from the SDDM login screen. A standalone Hyprland session (`hyprland`) is also registered automatically by the NixOS module and appears in the SDDM session list, but running it **bypasses UWSM entirely** — its stability is not guaranteed and it is not supported by this dotfiles.

- **Hyprland home-manager config is loaded automatically.** The `./config/hyprland` import in `home/apps.nix` (Waybar, keybindings, Hyprland tools) is included only when `desktopEnvironment = "hyprland"` is set in `flake.nix`. Switching to KDE or COSMIC automatically excludes it — no manual editing required.

- **COSMIC Greeter is intentionally left disabled.** `cosmic-greeter` is a greetd-based login screen built specifically for the COSMIC desktop. It does not have proper support for non-COSMIC sessions (KDE, Hyprland). Enabling it would replace SDDM entirely and would likely prevent other sessions from appearing or launching correctly. Keep SDDM.

> For Hyprland keybindings and detailed settings, see [home/config/hyprland/README.md](home/config/hyprland/README.md).

## NixVim

Neovim is managed as a standalone NixVim flake maintained in a separate repository and consumed here as a flake input.

- **Flake input:** `github:Myxogastria0808/nix-flakes-nixvim`
- **Full documentation (plugins, LSP, keybindings):** [nix-flakes-nixvim README](https://github.com/Myxogastria0808/nix-flakes-nixvim#readme)

Key features at a glance: Tokyo Night theme, neo-tree, LSP for 20+ languages, conform.nvim format-on-save, GitHub Copilot, toggleterm, Markdown preview, and Lean 4 support.

### First-time Setup

Some features require a one-time authentication step after the first launch.

#### GitHub Copilot

Run `:Copilot auth` inside Neovim and follow the device-flow prompt to authenticate with your GitHub account.

```
:Copilot auth
```

This only needs to be done once. The token is stored in `~/.config/github-copilot/`.

## How to manage repositories with ghq and peco

- clone repository

`clone` is alias of `ghq get`

```shell
clone <repository URI>
```

- move repository directory

type `Ctrl + g` on a terminal -> be showed selection menu of repositories.

## Alias

| command alias          | execute command                                                          |
| ---------------------- | ------------------------------------------------------------------------ |
| ..                     | `cd ../`                                                                 |
| ...                    | `cd ../../`                                                              |
| ....                   | `cd ../../../`                                                           |
| ls                     | `eza`                                                                    |
| ll                     | `eza -l`                                                                 |
| tree                   | `eza --tree`                                                             |
| size                   | `fd --size`                                                              |
| diff                   | `delta --side-by-side`                                                   |
| neofetch               | `fastfetch`                                                              |
| nix-develop            | `nix develop -c $SHELL`                                                  |
| hm (for NixOS user)    | `cd /etc/nixos && nix run home-manager -- switch --flake .#myHomeConfig` |
| nixos (for NixOS user) | `sudo nixos-rebuild switch`                                              |
| gc                     | `nix-collect-garbage`                                                    |
| t                      | `typst watch`                                                            |
| net                    | `speedtest`                                                              |
| cf-net                 | `firefox https://speed.cloudflare.com/`                                  |
| mobile                 | `scrcpy -d`                                                              |
| clock                  | `tty-clock -c -s`                                                        |
| g                      | `lazygit`                                                                |
| d                      | `sudo lazydocker`                                                        |
| clone                  | `ghq get`                                                                |
| pdf                    | `tdf`                                                                    |
| tetris                 | `bastet`                                                                 |
| cpu                    | `s-tui`                                                                  |
| music                  | `cava`                                                                   |

## Advanced Alias

### nurl

- nl [OPTIONS] [URL] [REV]

[OPTIONS]

`--hash` ... Show and copy to clipboard the hash value

`--rev` ... Show the rev value only

[URL]

URL to the repository to be fetched

[REV]

The revision or reference to be fetched

### shell

- shell (help command for terminal shortcut keys)

Show terminal shortcut keys

### copypath

- copypath

Show and copy pwd results to clipboard

### copyfile

- copyfile [FILE]

Show and copy a file content to clipboard

### ddiso

- ddiso --iso [ISO FILE] --dev [DEVICE] (optional: --bs [BLOCK SIZE, default: 1M])

Make install media

### mermaid

- mermaid [MERMAID FILE (.mmd file)]

optional: mermaid -i [MERMAID FILE (.mmd file)] -o [SVG | PNG | PDF FILE]

Generate a mermaid diagram png file from a mermaid file

# How to setup (NixOS)

> [!WARNING]
> Please note that some commands have not been checked for execution results.

### 1. Make Install Media

access following site: https://nixos.org/download/

select "Minimal ISO image"

```shell
dd if=<iso path> of=<install media path> bs=1M
```

dd sample

```shell
dd if=./nixos-minimal-24.05.3444.cf05eeada35e-x86_64-linux.iso of=/dev/sda bs=1M
```

When you don't know the storage device name of the install media, you can check it with the following command.

```shell
lsblk
```

### 2. Boot NixOS

Insert the install media into the target PC to be set up and boot NixOS from the install media.

### 3. Setup NixOS

When you want to know more about the following commands, please refer to the NixOS Manual.

enter root

```shell
sudo -i
```

Networking in the installer

```shell
systemctl start wpa_supplicant
wpa_cli

> add_network
0
> set_network 0 ssid "myhomenetwork"
OK
> set_network 0 psk "mypassword"
OK
> set_network 0 key_mgmt WPA-PSK
OK
> enable_network 0
OK
...
(omitted)
> quit
```

Editing `/etc/resolv.conf`

```shell
nano /etc/resolv.conf
```

editing `/etc/resolv.conf` following

```
nameserver 1.1.1.1
options edns0
```

Checking storage device

This command views available storage devices

In this case, the storage device name is described as `nvme0n1`

```shell
lsblk
```

Partitioning

```shell
parted /dev/nvme0n1 -- mklabel gpt
parted /dev/nvme0n1 -- mkpart root ext4 512MB -8GB
parted /dev/nvme0n1 -- mkpart swap linux-swap -8GB 100%
parted /dev/nvme0n1 -- mkpart ESP fat32 1MB 512MB
parted /dev/nvme0n1 -- set 3 esp on
```

Formatting

```shell
mkfs.ext4 -L nixos /dev/nvme0n1p1
mkswap -L swap /dev/nvme0n1p2
mkfs.fat -F 32 -n boot /dev/nvme0n1p3
```

Installing

```shell
mount /dev/nvme0n1p1 /mnt
mkdir -p /mnt/boot
mount -o umask=077 /dev/nvme0n1p3 /mnt/boot
swapon /dev/nvme0n1p2
```

Generate configuration files

```shell
nixos-generate-config --root /mnt
```

Setup dotfiles

```shell
# install git
nix-env -i git
# Change directory to /etc
cd /etc
# Clone this repository
git clone --recursive https://github.com/Myxogastria0808/dotfiles.git
# Delete the original nixos directory
rm -rf /etc/nixos
# Symlink the dotfiles directory to /etc/nixos
ln -s dotfiles nixos
```

Edit `configuration.nix` if you change initial user password or user name

cf: This dotfiles's initial user password is `sakura`

cf: This dotfiles's user name is `hello`

editing `flake.nix` following

```shell
nano /mnt/etc/nixos/flake.nix
```

edit `flake.nix` to set your `username`, `GitHub username`, and `GitHub email`

```
{
...
(omitted)
  outputs =
    inputs:
    let
      # username
      username = "hello";
      # GitHub username
      githubUsername = "Myxogastria0808";
      # GitHub email
      githubEmail = "r.rstudio.c@gmail.com";
      # (Optional) WireGuard VPN — comment out if you do not use WireGuard
      # wireGuardVPNConfigFilePath = "/home/hello/Documents/Myxogastria0808-NixOS.conf";
      # Base NixOS system configuration entry point
      baseModules = [
        ./nixos/configuration.nix
      ];
      nixosModules = [
        ./modules/app.nix
      ];
    in
    {
...
(omitted)
      specialArgs = {
        inherit inputs;
        username = username;
        githubUsername = githubUsername;
        githubEmail = githubEmail;
        # (Optional) WireGuard VPN — comment out if you do not use WireGuard
        # wireGuardVPNConfigFilePath = wireGuardVPNConfigFilePath;
      };
...
(omitted)
}
```

Before running `nixos-install`, comment out the optional services in `nixos/configuration.nix` as shown below.

If you do not use **Tailscale**, comment out:

```nix
# services.tailscale.enable = true;
# tailscale # CLI tools for managing Tailscale connections
# "tailscale0" # Tailscale virtual NIC - fully trusted for mesh VPN traffic
# config.services.tailscale.port # Tailscale (dynamic port, read from service config)
```

**WireGuard must always be commented out at this stage**, even if you plan to use it. The `.conf` file cannot exist yet because the home directory has not been created. Comment out:

```nix
# networking.wg-quick.interfaces.wg0.configFile = "${wireGuardVPNConfigFilePath}";
# 51820 # WireGuard VPN
```

> [!WARNING]
> Leaving the WireGuard lines active will cause `nixos-install` to fail, because NixOS evaluates the config file path at build time and the file does not exist yet.
>
> See step 6 for Tailscale setup and step 7 for WireGuard setup after the first boot.

Install NixOS

```shell
cd /mnt/etc/dotfiles/
nixos-install --flake .#nixos
```

Reboot

```shell
reboot now
```

### 4. Relocation of dotfiles

setup dotfiles

```shell
# Change directory to home
cd $HOME
# Clone dotfiles repository
git clone https://github.com/Myxogastria0808/dotfiles.git
# Change directory to dotfiles
cd dotfiles
# Remove previous nixos settings
sudo rm -rf /etc/nixos
# Symlink dotfiles to /etc/nixos
sudo ln -s $HOME/dotfiles /etc/nixos
# Switch to home-manager configuration
nix run home-manager -- switch --flake .#myHomeConfig
```

reboot

```shell
sudo reboot now
```

### 5. Setup GitHub

login gitHub

```shell
gh auth login
```

create a directory to be managed by ghq

```shell
# Change directory to home
cd $HOME
# Create src directory (used as ghq root: ~/src)
mkdir src
```

### 6. Setup Tailscale (Optional)

> [!NOTE]
> Skip this step if you do not use Tailscale.

**1.** Uncomment the Tailscale lines in `nixos/configuration.nix` that you commented out in step 3:

```nix
services.tailscale.enable = true;
tailscale # CLI tools for managing Tailscale connections
"tailscale0" # Tailscale virtual NIC - fully trusted for mesh VPN traffic
config.services.tailscale.port # Tailscale (dynamic port, read from service config)
```

**2.** Apply the change:

```shell
nixos
```

**3.** Connect to Tailscale:

```shell
sudo tailscale up
```

**4.** Apply home-manager to pick up any user-level changes:

```shell
hm
```

### 7. Setup WireGuard VPN (Optional)

> [!NOTE]
> Skip this step if you do not use WireGuard.

> [!WARNING]
> A WireGuard `.conf` file contains **private keys and peer secrets**. It is highly sensitive and **must never be committed to this repository or any public repository**. Always keep it outside the dotfiles directory.

**1.** Obtain your WireGuard `.conf` file from your VPN provider or generate one, then place it at a private path on your machine (e.g. `~/Documents/my-vpn.conf`).

**2.** Uncomment and update `wireGuardVPNConfigFilePath` in `flake.nix` to point to that file:

```nix
wireGuardVPNConfigFilePath = "/home/yourname/Documents/my-vpn.conf";
```

Also uncomment the `specialArgs` entry in the same file:

```nix
wireGuardVPNConfigFilePath = wireGuardVPNConfigFilePath;
```

**3.** Uncomment the corresponding lines in `nixos/configuration.nix`:

```nix
networking.wg-quick.interfaces.wg0.configFile = "${wireGuardVPNConfigFilePath}";
```

```nix
51820 # WireGuard VPN
```

**4.** Apply the change:

```shell
nixos
```

### 8. Finish!

## How to manage repositories with ghq and peco

- clone repository

`clone` is alias of `ghq get`

```shell
clone <repository URI>
```

- move repository directory

type `Ctrl + g` on a terminal -> be showed selection menu of repositories.

## DeepWiki

> [!WARNING]
> The accuracy of the contents of generated deepwiki has not been verified by me.

https://deepwiki.com/Myxogastria0808/dotfiles/

**Reference Site**

https://nixos.org/manual/nixos/stable/

https://wiki.gentoo.org/wiki/Handbook:AMD64/Full/Installation/ja#.E3.82.A4.E3.83.B3.E3.82.B9.E3.83.88.E3.83.BC.E3.83.AB.E4.BD.9C.E6.A5.AD.E3.81.AE.E9.A0.86.E5.BA.8F

https://zenn.dev/nixos/articles/ff1cc62ff04de0

https://zenn.dev/nixos/articles/ff1cc62ff04de0#%E3%82%AA%E3%83%97%E3%82%B7%E3%83%A7%E3%83%B3%E5%90%8D%E3%82%84%E6%A9%9F%E8%83%BD%E5%90%8D%E3%81%AE%E8%8B%B1%E5%8D%98%E8%AA%9E%E3%81%8B%E3%82%89%E5%AE%89%E6%98%93%E3%81%AB%E5%BD%B9%E5%89%B2%E3%82%92%E6%8E%A8%E6%B8%AC%E3%81%97%E3%81%AA%E3%81%84%E3%81%93%E3%81%A8
