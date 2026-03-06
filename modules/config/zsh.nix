{ pkgs, ... }:
{
  # Enable zsh shell
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    # Oh My Zsh
    # zsh-completions automatically installed by `programs.zsh.enable = true`
    # Reference: https://github.com/nix-community/nix-zsh-completions
    ohMyZsh = {
      enable = true;
      plugins = [ ];
    };
    # Shell initialization
    shellInit = ''
      # welcome message
      DISTRO=`sed -n -e /^NAME=/p /etc/os-release | cut -c 6-`
      EXCLAMATION="!!!"
      cowsay "Welcome to " ''$DISTRO''$EXCLAMATION | lolcat

      # direnv
      eval "$(direnv hook zsh)"

      # oh-my-zsh
      ZSH_CUSTOM=$HOME/.config/oh-my-zsh

      # zsh-autosuggestions
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#586e75"

      # copy file to clipboard
      function copyfile () {
          cat $1
          xclip -selection clipboard $1
      }

      # copy path to clipboard
      function copypath () {
          result=$(pwd)
          echo "''${result}"
          echo "''${result}" | xclip -selection clipboard
      }

      # dd iso to usb
      ddiso() {
          local iso=""
          local dev=""
          local bs="1M"

          # parse arguments
          while [[ "$#" -gt 0 ]]; do
              case $1 in
                  --iso)
                      iso="$2"
                      shift 2
                      ;;
                  --dev)
                      dev="$2"
                      shift 2
                      ;;
                  --bs)
                      bs="$2"
                      shift 2
                      ;;
                  -h|--help)
                      echo "Usage: ddiso --iso <iso file> --dev <device> (optional: --bs <block size, default: 1M>)"
                      return 0
                      ;;
                  *)
                      echo "Usage: ddiso --iso <iso file> --dev <device> (optional: --bs <block size, default: 1M>)"
                      return 1
                      ;;
              esac
          done

          # validation of arguments
          if [[ -z "$iso" || -z "$dev" ]]; then
              echo "Usage: ddiso --iso <iso file> --dev <device> (optional: --bs <block size, default: 1M>)"
              return 1
          fi

          # check if ISO file exists
          if [[ ! -f "$iso" ]]; then
              echo "Error: ISO not found: $iso"
              return 1
          fi

          # check if device exists and is a block device
          if [[ ! -b "$dev" ]]; then
              echo "Error: Not a block device: $dev"
              return 1
          fi

          # check if device is mounted
          local mount_points=$(lsblk -no MOUNTPOINTS "$dev" 2>/dev/null | grep . | tr '\n' ',' | sed 's/^,//; s/,$//' | sed 's/,/, /g')
          if [[ -n "$mount_points" ]]; then
              echo "Error: Device is mounted at: $mount_points"
              return 1
          fi

          # get ISO file size as bytes
          local size=$(du -b "$iso" | cut -f1)

          # show info and wait for 3 seconds
          echo ">>> Info: "$iso" ("$size" bytes) → "$dev""
          echo ">>> This command will erase all data on "$dev"."
          echo ">>> Make sure you have the correct device!"
          echo ">>> Ctrl+C to abort... (waiting 3 seconds)"
          sleep 3

          # get permission
          echo ">>> Getting sudo permission..."
          sudo -v || return 1

          sudo dd if="$iso" bs="$bs" status=none iflag=fullblock | pv -s "$size" | sudo dd of="$dev" bs="$bs" status=none conv=fsync
      }

      mermaid() {
          # case 1: mermaid hoge.mmd
          if [ $# -eq 1 ] && [[ "$1" == *.mmd ]]; then
              input="$1"
              output="''${input%.*}.png"
          # case 2: mermaid -i hoge.mmd
          elif [ $# -eq 2 ] && [ "$1" = "-i" ] && [[ "$2" == *.mmd ]]; then
              input="$2"
              output="''${input%.*}.png"
          # case 3: mermaid -i hoge.mmd -o hoge.png
          elif [ $# -eq 4 ] && [ "$1" = "-i" ] && [[ "$2" == *.mmd ]] && [ "$3" = "-o" ] && ([[ "$4" == *.png ]] || [[ "$4" == *.svg ]] || [[ "$4" == *.pdf ]]); then
              input="$2"
              output="$4"
          # invalid pattern
          else
              echo "Usage:"
              echo "  mermaid <mmd file (e.g. hoge.mmd)>"
              echo "  mermaid -i <mmd file (e.g. hoge.mmd)>"
              echo "  mermaid -i <mmd file (e.g. hoge.mmd)> -o <png |svg | pdf file>"
              return 1
          fi

          # check input file existence
          if [ ! -f "$input" ]; then
              echo "Error: input file not found: $input"
              return 1
          fi

          # check output file existence
          if [ -f "$output" ]; then
              echo "$output already exists. Overwrite? (y/N)"
              read -r answer
              if [ "$answer" != "y" ] && [ "$answer" != "Y" ]; then
                  echo "Overwrite cancelled."
                  return 0
              fi
          fi

          # execute mermaid-cli
          echo "Generating diagram: $output"
          mmdc -i "$input" -o "$output"
      }

      # nurl alias
      # Reference: https://chitoku.jp/programming/bash-getopts-long-options/
      # Reference: https://future-architect.github.io/articles/20210405/
      # Reference: https://blog.kteru.net/bash-template-for-using-getopts/
      # fetchFromGitHubのsha256の取得用
      # ($1) ... optional option (--hash, --rev, --help)
      # $1 ($2) ... github repository url
      # $2 ($3) ... version
      function nl () {
          local option=""
          local url=""
          local rev=""

          __nl_usage() {
              cat <<EOM
      Usage: nl [OPTIONS] [URL] [REV]
      Arguments:
              [URL]
                      URL to the repository to be fetched
              [REV]
                      The revision or reference to be fetched
      Options:
              --hash
                      Show and copy to clipboard the hash value
              --rev
                      Show the rev value only
      EOM
          }

          case "''${1}" in
              --help)
                  __nl_usage
                  return 0
                  ;;
              --hash)
                  option="hash"
                  url="''${2}"
                  rev="''${3}"
                  ;;
              --rev)
                  option="rev"
                  url="''${2}"
                  rev="''${3}"
                  ;;
              -*)
                  # --hash, --rev, --help 以外のオプションが指定された場合
                  echo "This is unexpected option."
                  echo ""
                  __nl_usage
                  return 1
                  ;;
              *)
                  # オプションなし
                  option=""
                  url="''${1}"
                  rev="''${2}"
                  ;;
          esac

          case "''${option}" in
              hash)
                  result=''$(nurl -H ''${url} ''${rev} 2> /dev/null)
                  echo "''${result}"
                  echo "''${result}" | xclip -selection clipboard
                  ;;
              rev)
                  echo "''${rev}"
                  ;;
              *)
                  result=''$(nurl ''${url} ''${rev} 2> /dev/null)
                  echo "''${result}"
                  echo "''${result}" | xclip -selection clipboard
                  ;;
          esac
      }

      # Terminal Shortcut Keys Helper
      function shell() {
          local BOLD="\e[1m"
          local RESET="\e[0m"
          local CYAN="\e[36m"
          local YELLOW="\e[33m"
          local GREEN="\e[32m"
          local MAGENTA="\e[35m"
          local DIM="\e[2m"
          echo ""
          echo -e "''${BOLD}''${CYAN}╔══════════════════════════════════════════════════════╗''${RESET}"
          echo -e "''${BOLD}''${CYAN}║           zsh Keyboard Shortcuts Cheatsheet          ║''${RESET}"
          echo -e "''${BOLD}''${CYAN}╚══════════════════════════════════════════════════════╝''${RESET}"
          # ── Cursor Movement ──────────────────────────────────────────
          echo ""
          echo -e "''${BOLD}''${YELLOW}  Cursor Movement''${RESET}"
          echo -e "''${DIM}  ──────────────────────────────────────────────────────''${RESET}"
          echo ""
          echo -e "  ''${BOLD}Ctrl+A''${RESET}  Move to beginning of line"
          echo -e "  ''${DIM}  \$ git commit -m \"fix bug\"''${RESET}"
          echo -e "  ''${GREEN}    ^''${RESET}"
          echo -e "  ''${GREEN}    Ctrl+A moves here''${RESET}"
          echo ""
          echo -e "  ''${BOLD}Ctrl+E''${RESET}  Move to end of line"
          echo -e "  ''${DIM}  \$ git commit -m \"fix bug\"''${RESET}"
          echo -e "  ''${GREEN}                           ^''${RESET}"
          echo -e "  ''${GREEN}                           Ctrl+E moves here''${RESET}"
          echo ""
          echo -e "  ''${BOLD}Alt+F / Alt+B''${RESET}  Move forward / backward one word"
          echo -e "  ''${DIM}  \$ git commit -m \"fix bug\"''${RESET}"
          echo -e "  ''${GREEN}    ^   ^       ^  ^   ^   ''${RESET}"
          echo -e "  ''${GREEN}    Jump word by word''${RESET}"
          echo ""
          echo -e "  ''${BOLD}Alt+>''${RESET}  Insert history entry at cursor position"
          echo -e "  ''${DIM}  \$ git commit  \"fix bug\"''${RESET}"
          echo -e "  ''${GREEN}               ^''${RESET}"
          echo -e "  ''${GREEN}               Selected history entry is inserted here''${RESET}"
          # ── Text Editing ──────────────────────────────────────────
          echo ""
          echo -e "''${BOLD}''${YELLOW}  Text Editing''${RESET}"
          echo -e "''${DIM}  ──────────────────────────────────────────────────────''${RESET}"
          echo ""
          printf "  ''${BOLD}%-16s''${RESET} %s\n" "Ctrl+K" "Delete from cursor to end of line"
          echo -e "  ''${DIM}  \$ git commit -m \"fix bug\"''${RESET}"
          echo -e "  ''${DIM}            ^''${RESET}"
          echo -e "  ''${MAGENTA}            ├──────────────┤ ← deleted''${RESET}"
          echo ""
          printf "  ''${BOLD}%-16s''${RESET} %s\n" "Ctrl+U" "Delete entire line"
          echo -e "  ''${DIM}  \$ git commit -m \"fix bug\"''${RESET}"
          echo -e "  ''${MAGENTA}   ├───────────────────────┤ ← all deleted''${RESET}"
          echo ""
          printf "  ''${BOLD}%-16s''${RESET} %s\n" "Ctrl+T" "Swap the two characters before cursor"
          echo -e "  ''${DIM}  \$ git commit -m \"fxi bug\"''${RESET}"
          echo -e "  ''${DIM}                    ^^ cursor''${RESET}"
          echo -e "  ''${GREEN}  \$ git commit -m \"fix bug\"''${RESET}"
          echo -e "  ''${GREEN}                    ^^''${RESET}"
          echo ""
          printf "  ''${BOLD}%-16s''${RESET} %s\n" "Alt+T" "Swap the two words before cursor"
          echo -e "  ''${DIM}  \$ git commit -m \"fix bug\"''${RESET}"
          echo -e "  ''${DIM}    ^───^ cursor''${RESET}"
          echo -e "  ''${GREEN}  \$ commit git -m \"fix bug\"''${RESET}"
          echo -e "  ''${GREEN}    ^──────^''${RESET}"
          echo ""
          printf "  ''${BOLD}%-16s''${RESET} %s\n" "Ctrl+_" "Undo last edit"
          # ── Other ──────────────────────────────────────────────
          echo ""
          echo -e "''${BOLD}''${YELLOW}  Other''${RESET}"
          echo -e "''${DIM}  ──────────────────────────────────────────────────────''${RESET}"
          echo ""
          printf "  ''${BOLD}%-16s''${RESET} %s\n" "Ctrl+L" "Clear screen (history preserved)"
          printf "  ''${BOLD}%-16s''${RESET} %s\n" "Ctrl+E" "Edit current input in editor"
          echo ""
        }

      # ghq
      # Reference: https://zenn.dev/oreo2990/articles/13c80cf34a95af
      function peco-src () {
          local selected_dir=$(ghq list -p | peco --prompt="repositories >" --query "$LBUFFER")
          if [ -n "$selected_dir" ]; then
          BUFFER="cd ''${selected_dir}"
          zle accept-line
          fi
          zle clear-screen
      }
      zle -N peco-src
      bindkey '^g' peco-src
    '';
    # Alias
    shellAliases = {
      ".." = "cd ../";
      "..." = "cd ../../";
      "...." = "cd ../../../";
      "ls" = "eza";
      "ll" = "eza -l";
      "tree" = "eza --tree";
      "size" = "fd --size";
      "diff" = "delta --side-by-side";
      "neofetch" = "fastfetch";
      # Reference: https://discourse.nixos.org/t/using-nix-develop-opens-bash-instead-of-zsh/25075
      "nix-develop" = "nix develop -c $SHELL";
      "hm" = "cd /etc/nixos && nix run home-manager -- switch --flake .#myHomeConfig";
      "nixos" = "sudo nixos-rebuild switch";
      "gc" = "nix-collect-garbage";
      "t" = "typst watch";
      "net" = "speedtest";
      "cf-net" = "firefox https://speed.cloudflare.com/";
      "mobile" = "scrcpy -d";
      "clock" = "tty-clock -c -s";
      "g" = "lazygit";
      "d" = "sudo lazydocker";
      "clone" = "ghq get";
      "pdf" = "tdf";
      "tetris" = "bastet";
      "cpu" = "s-tui";
      "music" = "cava";
    };
  };
}
