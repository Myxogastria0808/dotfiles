# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Apply Changes

```bash
# Apply home-manager changes (user-level config, works on any Linux)
hm
# Equivalent: cd /etc/nixos && nix run home-manager -- switch --flake .#myHomeConfig

# Apply NixOS system-level changes
nixos
# Equivalent: sudo nixos-rebuild switch

# Garbage collect old generations
gc
```

## Architecture

This is a NixOS + home-manager dotfiles repo targeting a ThinkPad X1 Carbon 7th running KDE Plasma 6.

**`flake.nix`** is the root entry point. It defines two outputs:
- `homeConfigurations.myHomeConfig` — home-manager config entry point at `home/home.nix`
- `nixosConfigurations.nixos` — NixOS system config entry point at `nixos/configuration.nix`

Top-level variables (`username`, `githubUsername`, `githubEmail`) are set in `flake.nix` and passed via `specialArgs`/`extraSpecialArgs` to all modules.

**Key design principle**: home-manager is intentionally kept independent from NixOS. The `home/` directory manages user-level config that works on any Linux, while `modules/` manages NixOS system-level config.

### Directory Layout

| Path | Purpose |
|------|---------|
| `home/home.nix` | home-manager entry point |
| `home/apps.nix` | Home packages and imports (ghostty, skk, firefox) |
| `home/config/` | Per-app home-manager configs |
| `modules/app.nix` | NixOS system packages entry point |
| `modules/config/` | NixOS system module configs (zsh, git, starship, fonts, audio, virtualisation, etc.) |
| `modules/desktop-manager/` | Desktop environment configs (display manager, KDE Plasma 6, COSMIC) |
| `nixos/configuration.nix` | Main NixOS system config (bootloader, services, networking, users) |
| `nixos/hardware-configuration.nix` | Hardware-specific config (auto-generated) |
| `scripts/` | One-off setup scripts (install, tailscale, waydroid, portainer) |

### Adding Packages

- **User packages** (home-manager): add to `home/apps.nix` under `home.packages`
- **System packages** (NixOS): add to `modules/app.nix` under `environment.systemPackages`
- **New module** (NixOS): create in `modules/config/` and import in `modules/app.nix`
- **New module** (home-manager): create in `home/config/` and import in `home/apps.nix`

### nixpkgs Channel

Uses `nixpkgs-unstable`. The home-manager `stateVersion` is set to `"25.11"` with `enableNixpkgsReleaseCheck = false` to suppress release mismatch warnings.

### External Flake Inputs

- `home-manager` — user environment management
- `zen-browser` — Zen Browser (currently commented out)
- `nixvimConfig` — NixVim config from a separate flake (`Myxogastria0808/nix-flakes-nixvim`)

### Nix Helper: `nl` (nurl wrapper)

Used to fetch hashes/revs when adding new packages via `fetchFromGitHub`:
```bash
nl [URL] [REV]          # fetch and copy full nurl output
nl --hash [URL] [REV]   # fetch and copy hash only
nl --rev [URL] [REV]    # show rev only
```
