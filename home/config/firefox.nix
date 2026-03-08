{
  # Ref: https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265
  # Ref: https://stackoverflow.com/questions/55496793/how-to-get-the-link-to-the-latest-version-of-firefox-addon
  # To find the Extension ID of an installed add-on: about:debugging#/runtime/this-firefox
  programs.firefox = {
    enable = true;
    policies = {
      # Force-install extensions on all profiles (users cannot uninstall them)
      ExtensionSettings = {
        "*".installation_mode = "allowed";
        # Bitwarden - password manager
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/addon-12533945-latest.xpi";
          installation_mode = "force_installed";
        };
        # Dark Reader - dark mode for all websites
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/addon-13299734-latest.xpi";
          installation_mode = "force_installed";
        };
        # Enhancer for YouTube - extra controls and ad-skip features
        "enhancerforyoutube@maximerf.addons.mozilla.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/enhancer-for-youtube/addon-6294433-latest.xpi";
          installation_mode = "force_installed";
        };
        # Flagfox - shows country flag of the current website's server
        "{1018e4d6-728f-4b20-ad56-37578a4de76b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/flagfox/addon-235431-latest.xpi";
          installation_mode = "force_installed";
        };
        # Google Lighthouse - web performance and accessibility auditing
        "{cf3dba12-a848-4f68-8e2d-f9fadc0721de}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/google-lighthouse/addon-15665282-latest.xpi";
          installation_mode = "force_installed";
        };
        # New Tab Override - customize the new tab page URL
        "newtaboverride@agenedia.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/new-tab-override/addon-1351101-latest.xpi";
          installation_mode = "force_installed";
        };
        # Search Result Previews - inline preview of search results
        "admin@fastaddons.com_SearchResultPreviews" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/search_result_previews/addon-12626983-latest.xpi";
          installation_mode = "force_installed";
        };
        # Tab Session Manager - save and restore tab sessions
        "Tab-Session-Manager@sienori" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/tab-session-manager/addon-13310420-latest.xpi";
          installation_mode = "force_installed";
        };
        # Tree Style Tab - display tabs in a vertical sidebar tree
        "treestyletab@piro.sakura.ne.jp" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/tree-style-tab/addon-9480-latest.xpi";
          installation_mode = "force_installed";
        };
        # TWP (Translate Web Pages) - in-page translation
        "{036a55b4-5e72-4d05-a06c-cba2dfcc134a}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/traduzir-paginas-web/addon-15610759-latest.xpi";
          installation_mode = "force_installed";
        };
        # Wappalyzer - detect technologies used by websites
        "wappalyzer@crunchlabz.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/wappalyzer/addon-3609035-latest.xpi";
          installation_mode = "force_installed";
        };
        # YouTube Comment Translate - translate YouTube comments inline
        "{3f156905-a637-4fc4-8e5d-2b2814b7c59b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/youtube-comment-translate/addon-17706105-latest.xpi";
          installation_mode = "force_installed";
        };
        # Keepa - Amazon price history tracker
        "amptra@keepa.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepa/addon-5824618-latest.xpi";
          installation_mode = "force_installed";
        };
        # Livemarks - RSS/Atom feed bookmarks
        "{c5867acc-54c9-4074-9574-04d8818d53e8}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/livemarks/addon-5650259-latest.xpi";
          installation_mode = "force_installed";
        };
      };
      # about:config preference overrides applied via policy
      Preferences = {
        "security.dialog_enable_delay" = 0; # Remove the install confirmation delay
        "browser.search.openintab" = true; # Open search results in a new tab
        "browser.urlbar.trimURLs" = false; # Show full URL including scheme (https://)
        "layout.spellcheckDefault" = 2; # Enable spellcheck in all text fields
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true; # Enable userChrome.css
        "browser.tabs.loadBookmarksInTabs" = true; # Open bookmarks in new tabs
        "browser.toolbars.bookmarks.visibility" = "always"; # Always show bookmarks toolbar
        "browser.tabs.inTitlebar" = 0; # Show native window title bar
      };
    };
    # Hide the native tab bar and sidebar header when using Tree Style Tab
    # Ref: https://blog.halpas.com/archives/11879
    profiles.options.userChrome = ''
      /* Hide top tab bar - tabs are shown in Tree Style Tab sidebar instead */
      #TabsToolbar {
        visibility: collapse !important;
      }
      /* Hide sidebar header to save vertical space */
      #sidebar-header {
        display: none;
      }
    '';
  };
}
