{
  #参考サイト: https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265
  #参考サイト: https://stackoverflow.com/questions/55496793/how-to-get-the-link-to-the-latest-version-of-firefox-addon
  #Extension ID: about:debugging#/runtime/this-firefox
  programs.firefox = {
    enable = true;
    policies = {
      #Addons
      ExtensionSettings = {
        "*".installation_mode = "allowed";
        # Bitwarden
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/addon-12533945-latest.xpi";
          installation_mode = "force_installed";
        };
        # Dark Reader
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/addon-13299734-latest.xpi";
          installation_mode = "force_installed";
        };
        # Double-click Image Downloader
        "jid1-xgtdawe3yyUeBQ@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/double-click-image-download/addon-4545060-latest.xpi";
          installation_mode = "force_installed";
        };
        # Enhancer for YouTube™
        "enhancerforyoutube@maximerf.addons.mozilla.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/enhancer-for-youtube/addon-6294433-latest.xpi";
          installation_mode = "force_installed";
        };
        # Flagfox
        "{1018e4d6-728f-4b20-ad56-37578a4de76b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/flagfox/addon-235431-latest.xpi";
          installation_mode = "force_installed";
        };
        # Google Lighthouse
        "{cf3dba12-a848-4f68-8e2d-f9fadc0721de}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/google-lighthouse/addon-15665282-latest.xpi";
          installation_mode = "force_installed";
        };
        # New Tab Override
        "newtaboverride@agenedia.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/new-tab-override/addon-1351101-latest.xpi";
          installation_mode = "force_installed";
        };
        # React Developer Tools
        "@react-devtools" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/react-devtools/addon-13300647-latest.xpi";
          installation_mode = "force_installed";
        };
        # Search Result Previews
        "admin@fastaddons.com_SearchResultPreviews" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/search_result_previews/addon-12626983-latest.xpi";
          installation_mode = "force_installed";
        };
        # Tab Session Manager
        "Tab-Session-Manager@sienori" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/tab-session-manager/addon-13310420-latest.xpi";
          installation_mode = "force_installed";
        };
        # Tree Style Tab
        "treestyletab@piro.sakura.ne.jp" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/tree-style-tab/addon-9480-latest.xpi";
          installation_mode = "force_installed";
        };
        # TWP
        "{036a55b4-5e72-4d05-a06c-cba2dfcc134a}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/traduzir-paginas-web/addon-15610759-latest.xpi";
          installation_mode = "force_installed";
        };
        # uBlock Origin
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/addon-11423598-latest.xpi";
          installation_mode = "force_installed";
        };
        # Wappalyzer
        "wappalyzer@crunchlabz.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/wappalyzer/addon-3609035-latest.xpi";
          installation_mode = "force_installed";
        };
        # YouTube™ Comment Translate
        "{3f156905-a637-4fc4-8e5d-2b2814b7c59b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/youtube-comment-translate/addon-17706105-latest.xpi";
          installation_mode = "force_installed";
        };
        #Keepa
        "amptra@keepa.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepa/addon-5824618-latest.xpi";
          installation_mode = "force_installed";
        };

      };
      #about:config
      Preferences = {
        "security.dialog_enable_delay" = 0;
        "browser.search.openintab" = true;
        "browser.urlbar.trimURLs" = false;
        "layout.spellcheckDefault" = 2;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.tabs.loadBookmarksInTabs" = true;
        "browser.toolbars.bookmarks.visibility" = "always";
        "browser.tabs.inTitlebar" = 0;
      };
    };
    #参考サイト: https://blog.halpas.com/archives/11879
    profiles.options.userChrome = ''
      /* Hidden Firefox Top TabBar & SideBar Header - https://blog.halpas.com/archives/11879 */
      #TabsToolbar {
        visibility: collapse !important;
      }
      #sidebar-header {
        display: none;
      }
    '';
  };
}
