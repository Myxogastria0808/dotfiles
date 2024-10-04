{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
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
      "prettier.documentSelectors" = ["**/*.astro"];
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
      "workbench.iconTheme" = "material-icon-theme";
      "terminal.integrated.commandsToSkipShell" = ["language-julia.interrupt"];
      "julia.symbolCacheDownload" = "true";
      "julia.enableTelemetry" =  "true";
      "editor.minimap.enabled" = "false";
      "prisma.showPrismaDataPlatformNotification" = "false";
      "material-ui-snippets.showNotesOnStartup" = "false";
      "github.copilot.enable" = {
        "*" = "true";
      };
    };
  };
}
