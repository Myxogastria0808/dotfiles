{ pkgs, ... }: {
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
            plugins = [];
        };
        # Shell initialization
        shellInit = ''
            # welcome message
            DISTRO=`sed -n -e /^NAME=/p /etc/os-release | cut -c 6-`
            EXCLAMATION="!!!"
            cowsay "Welcome to " ''$DISTRO''$EXCLAMATION | lolcat

            # IHP (Integrated Haskell Platform)
            # https://ihp.digitallyinduced.com
            eval "$(direnv hook bash)"

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

            # nurl alias
            #参考サイト: https://chitoku.jp/programming/bash-getopts-long-options/
            #参考サイト: https://future-architect.github.io/articles/20210405/
            #参考サイト: https://blog.kteru.net/bash-template-for-using-getopts/
            # fetchFromGitHubのsha256の取得用
            # ($1) ... optional option (-h, -f)
            # $1 ($2) ... github repository url
            # $2 ($3) ... version
            function nl () {
                while getopts ":h:f" opt; do
                case $opt in
                    h)
                    # -h が指定された場合
                    result=''$(nurl -H ''${2} ''${3} 2> /dev/null)
                    echo "''${result}"
                    echo "''${result}" | xclip -selection clipboard
                    ;;
                    f)
                    # -f が指定された場合
                    result=''$(nurl ''${2} ''${3} 2> /dev/null)
                    echo "''${result}"
                    echo "''${result}" | xclip -selection clipboard
                    ;;
                    ?)
                    # -h, -f 以外のオプションが指定された場合
                    cat <<EOM
            This is unexpected option.

            Usage: nl [OPTIONS] [URL] [REV]

            Arguments:
                    [URL]
                            URL to the repository to be fetched

                    [REV]
                            The revision or reference to be fetched

            Options:
                    -h
                            Show and copy to clipboard the hash value
                    -f
                            Show and copy to clipboard complete results
            EOM
                    ;;
                esac
                done
            }

            # ghq
            # 参考サイト: https://zenn.dev/oreo2990/articles/13c80cf34a95af
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
            "nr" = "sudo nixos-rebuild switch";
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
        };
    };
}
