{
  pkgs,
  inputs,
  username,
  ...
}:
{
  programs.vscode = {
    enable = true;
    # extensions = with inputs.nix-vscode-extensions.extensions."x86_64-linux".vscode-marketplace; [
    #   # Astro
    #   astro-build.astro-vscode
    #   # AI
    #   phind.phind
    #   github.copilot
    #   # Docker
    #   ms-azuretools.vscode-docker
    #   # Nix
    #   jnoortheen.nix-ide
    #   mkhl.direnv
    #   arrterian.nix-env-selector
    #   # C C++ Makefile
    #   # ms-vscode.cpptools <- cannot install from nix
    #   ms-vscode.cpptools-themes
    #   ms-vscode.cmake-tools
    #   ms-vscode.makefile-tools
    #   twxs.cmake
    #   # Rust
    #   tamasfe.even-better-toml
    #   rust-lang.rust-analyzer
    #   # python
    #   ms-python.python
    #   ms-python.debugpy
    #   kevinrose.vsc-python-indent
    #   visualstudioexptteam.vscodeintellicode
    #   visualstudioexptteam.intellicode-api-usage-examples
    #   # JavaScript Typscript
    #   esbenp.prettier-vscode
    #   # mermaid
    #   bierner.markdown-mermaid
    #   bpruitt-goddard.mermaid-markdown-syntax-highlighting
    #   # mdx
    #   unifiedjs.vscode-mdx
    #   # pdf
    #   tomoki1207.pdf
    #   # Quarto
    #   quarto.quarto
    #   # Jupyter
    #   ms-toolsai.jupyter
    #   # csv
    #   mechatroner.rainbow-csv
    #   # typst
    #   nvarner.typst-lsp
    #   # others
    #   oderwat.indent-rainbow
    # ] ;
    userSettings = {
      "editor.formatOnSave" = "true";
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "editor.fontFamily" = "\"0xProto\"";
      "editor.fontLigatures" = "true";
      "workbench.startupEditor" = "none";
      "css.lint.unknownAtRules" = "ignore";
      "indentRainbow.colors" = [
        "rgba(128, 64, 64, 0.15)"
        "rgba(128, 96, 32, 0.15)"
        "rgba(128, 128, 32, 0.15)"
        "rgba( 32, 128, 32, 0.15)"
        "rgba( 32, 64, 128, 0.15)"
        "rgba(128, 64, 128, 0.15)"
      ];
      "workbench.editorAssociations" = {
        "*.mp4" = "vscode.videoPreview";
        "*.zip" = "default";
        "*.pdf" = "analyticsignal.preview-pdf";
      };
      "editor.renderWhitespace" = "boundary";
      "workbench.settings.useSplitJSON" = "true";
      "editor.mouseWheelZoom" = "true";
      #pythonの設定
      "[python]" = {
        "editor.formatOnType" = "true";
      };
      #rustの設定
      "[rust]" = {
        "editor.defaultFormatter" = "rust-lang.rust-analyzer";
        "editor.formatOnSave" = "true";
        "editor.formatOnPaste" = "true";
        "editor.formatOnType" = "true";
      };
      "rust-analyzer.check.command" = "clippy";
      "emmet.includeLanguages" = {
        "rust" = "html";
      };
      #astroの設定
      "prettier.documentSelectors" = [ "**/*.astro" ];
      "[astro]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      #dockerの設定
      "[dockerfile]" = {
        "editor.defaultFormatter" = "ms-azuretools.vscode-docker";
      };
      #prismaの設定
      "[prisma]" = {
        "editor.defaultFormatter" = "Prisma.prisma";
      };
      #nixの設定
      "[nix]" = {
        "editor.defaultFormatter" = "jnoortheen.nix-ide";
      };
      "workbench.iconTheme" = "material-icon-theme";
      "terminal.integrated.commandsToSkipShell" = [ "language-julia.interrupt" ];
      "julia.symbolCacheDownload" = "true";
      "julia.enableTelemetry" = "true";
      "editor.minimap.enabled" = "false";
      "prisma.showPrismaDataPlatformNotification" = "false";
      "material-ui-snippets.showNotesOnStartup" = "false";
      "github.copilot.enable" = {
        "*" = "true";
      };
      "typst-lsp.experimentalFormatterMode" = "on";
      "typst-lsp.exportPdf" = "onSave";
      "typst-lsp.rootPath" = null;
      "typst-lsp.semanticTokens" = "enable";
      "typst-lsp.trace.server" = "on";
      "typst-lsp.serverPath" = "/home/${username}/.nix-profile/bin/typst-lsp";
    };
  };
}
