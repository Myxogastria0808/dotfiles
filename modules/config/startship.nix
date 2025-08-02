{ ... }: {
  #参考サイト: https://gist.github.com/mIcHyAmRaNe/a6ee5ca3311d61ae6f181e691643925d
  programs.starship = {
    enable = true;
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";
      format = ''
        [┌──''\\(](bold green)''$username❄ ''$hostname[''\\)-''\\[](bold green)''$directory[''\\]](bold green) ''$os ''$git_branch''$git_status''$aws''$azure''$buf''$bun''$c''$cmake''$cobol''$conda''$container''$crystal''$daml''$dart''$deno''$docker_context''$dotnet''$elixir''$elm''$erlang''$fennel''$fossil_branch''$fossil_metrics''$gcloud''$gleam''$go''$guix_shell''$gradle''$haskell''$haxe''$helm''$java''$julia''$kotlin''$kubernetes''$lua''$meson''$hg_branch''$nats''$nim''$nix_shell''$nodejs''$ocaml''$odin''$opa''$openstack''$perl''$php''$pijul_channel''$pulumi''$purescript''$python''$quarto''$rlang''$raku''$red''$ruby''$rust''$scala''$shell''$shlvl''$singularity''$solidity''$spack''$swift''$terraform''$typst''$vagrant''$vlang''$vcsh''$zig''$cmd_duration
        [└─](bold green)[λ ](bold blue)
      '';
      username = {
        style_root = "bold red";
        style_user = "bold blue";
        format = "[$user]($style)";
        show_always = true;
        disabled = false;
      };
      hostname = {
        ssh_only = false;
        ssh_symbol = "";
        trim_at = "";
        format = "[$ssh_symbol$hostname]($style)";
        style = "bold blue";
        disabled = false;
      };
      directory = {
        truncation_length = 1;
        truncate_to_repo = false;
        format = "[$read_only$path]($style)";
        style = "bold blue";
        disabled = false;
        read_only = " ";
        read_only_style = "bold red";
        truncation_symbol = "";
      };
      character = {
        success_symbol = "[](bold blue)";
        error_symbol = "[](bold red)";
        disabled = false;
      };
      continuation_prompt = "[...](bold blue)";
      cmd_duration = {
        min_time = 1000;
        format = "  [$duration]($style)";
        style = "bold yellow";
      };
      git_branch = {
        format = "[$symbol$branch]($style) ";
        symbol = " ";
        disabled = false;
      };
      git_state = {
        disabled = false;
      };
      os = {
        format = "[$symbol]($style)";
        style = "bold green";
        disabled = false;
        symbols = {
          Alpaquita = " ";
          Alpine = " ";
          AlmaLinux = " ";
          Amazon = " ";
          Android = " ";
          Arch = " ";
          Artix = " ";
          CentOS = " ";
          Debian = " ";
          DragonFly = " ";
          Emscripten = " ";
          EndeavourOS = " ";
          Fedora = " ";
          FreeBSD = " ";
          Garuda = "󰛓 ";
          Gentoo = " ";
          HardenedBSD = "󰞌 ";
          Illumos = "󰈸 ";
          Kali = " ";
          Linux = " ";
          Mabox = " ";
          Macos = " ";
          Manjaro = " ";
          Mariner = " ";
          MidnightBSD = " ";
          Mint = " ";
          NetBSD = " ";
          NixOS = " ";
          OpenBSD = "󰈺 ";
          openSUSE = " ";
          OracleLinux = "󰌷 ";
          Pop = " ";
          Raspbian = " ";
          Redhat = " ";
          RedHatEnterprise = " ";
          RockyLinux = " ";
          Redox = "󰀘 ";
          Solus = "󰠳 ";
          SUSE = " ";
          Ubuntu = " ";
          Void = " ";
          Windows = "󰍲 ";
          Unknown = " ";
        };
      };
      #symbol
      package.symbol = "󰏗 ";
      aws.symbol = "  ";
      buf.symbol = " ";
      c.symbol = " ";
      conda.symbol = " ";
      crystal.symbol = " ";
      dart.symbol = " ";
      docker_context.symbol = " ";
      elixir.symbol = " ";
      elm.symbol = " ";
      fennel.symbol = " ";
      fossil_branch.symbol = " ";
      golang.symbol = " ";
      guix_shell.symbol = " ";
      haskell.symbol = " ";
      haxe.symbol = " ";
      hg_branch.symbol = " ";
      java.symbol = " ";
      julia.symbol = " ";
      kotlin.symbol = " ";
      lua.symbol = " ";
      memory_usage.symbol = "󰍛 ";
      meson.symbol = "󰔷 ";
      nim.symbol = "󰆥 ";
      nix_shell.symbol = " ";
      nodejs.symbol = " ";
      ocaml.symbol = " ";
      perl.symbol = " ";
      php.symbol = " ";
      pijul_channel.symbol = " ";
      python.symbol = " ";
      rlang.symbol = "󰟔 ";
      ruby.symbol = " ";
      rust.symbol = "󱘗 ";
      scala.symbol = " ";
      swift.symbol = " ";
      zig.symbol = " ";
    };
  };
}
