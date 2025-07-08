# About this dotfiles

This dotfiles describes almost everything in nix except AstroNvim. This dotfiles makes home-manager independent from NixOS Modules. Therefore, the parts managed by home-manager are supposed to be available to all linux users. In addition, some NixOS users can make full use of this dotfiles. This dotfiles has been created for successful setup on the ThinkPad X1 Carbon 7th. It has not been tested on other generations of the X1 Carbon, but users with other generations of the X1 Carbon may also be able to set it up successfully.

# Outline

## Environment

|                   |                        |
| ----------------- | ---------------------- |
| Target Hardware   | ThinkPad X1 Carbon 7th |
| Window Manager    | KDE Plasma 6           |
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

## Alias

| command alias       | execute comand                                                           |
| ------------------- | ------------------------------------------------------------------------ |
| ..                  | `cd ../`                                                                 |
| ...                 | `cd ../../`                                                              |
| ....                | `cd ../../../`                                                           |
| ls                  | `eza`                                                                    |
| ll                  | `eza -l`                                                                 |
| tree                | `eza --tree`                                                             |
| size                | `fd --size`                                                              |
| diff                | `delta --side-by-side`                                                   |
| neofetch            | `fastfetch`                                                              |
| nix-develop         | `nix develop -c $SHELL`                                                  |
| hn (for NixOS user) | `cd /etc/nixos && nix run home-manager -- switch --flake .#myHomeConfig` |
| nr (for NixOS user) | `sudo nixos-rebuild switch`                                              |
| gc                  | `nix-collect-garbage`                                                    |
| t                   | `typst watch`                                                            |
| net                 | `speedtest`                                                              |
| mobile              | `scrcpy -d`                                                              |
| clock               | `tty-clock -c -s`                                                        |
| g                   | `lazygit`                                                                |
| d                   | `sudo lazydocker`                                                        |
| clone               | `ghq get`                                                                |
| pdf                 | `tdf`                                                                    |
| tetris              | `bastet`                                                                 |

## Advanced Alias

### nurl

- nl [OPTIONS] [URL] [REV]

[OPTIONS]

`-f` ... Show and copy to clipboard the hash value

`-h` ... Show and copy to clipboard complete results

[URL]

URL to the repository to be fetched

[REV]

The revision or reference to be fetched

### copypath

- copypath

Show and copy pwd results to clickboard

### copyfile

- copyfile [FILE]

Show and copy a file content to clickboard

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

Checking strage device

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
      # nixosModules entorypoint
      baseModules = [
        ./nixos/configuration.nix
      ];
      nixosModules = [
        ./modules/app.nix
      ];
    in
    {
      ## home-manager ##
...
(omitted)
}
```

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
# Create src directory
src
```

### 6. Setup Tailscale

run `tailscale up`

> [!WARNING]
> If you are not tailscale user, you have to comment out `services.tailscale.enable = true;` (`configuration.nix`)

```shell
sudo tailscale up
```

run following command

```shell
hm
```

### 7. Finish!

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
