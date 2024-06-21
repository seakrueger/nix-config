{ config, pkgs, lib, profile, userSettings, systemSettings, inputs, ... }:

let
  preferredSettings = {
    "app.normandy.enabled" = false;
    "app.normandy.first_run" = false;

    # Disable Firefox Sync account
    "identity.fxaccounts.enabled" = false;

    # Needed for userchrome.css
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

    # -- Home --
    "browser.sessionstore.resuming_after_os_restart" = true;
    # Enables "Open previous windows and tabs"
    "browser.startup.page" = 3;
    "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
    "browser.newtabpage.activity-stream.feeds.topsites" = false;
    "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;
    "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.searchEngines" = "";
    "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
    "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
    "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
    "browser.newtabpage.activity-stream.showSponsored" = false;
    "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
    "browser.newtabpage.pinned" = "";
    "browser.download.panel.shown" = true;
    # DRM content playback
    "media.eme.enabled" = true;

    # -- Search --
    "browser.bookmarks.restore_default_bookmarks" = false;
    "browser.urlbar.quicksuggest.scenario" = "offline";
    "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
    "browser.urlbar.suggest.quicksuggest.sponsored" = false;
    "browser.urlbar.suggest.pocket" = false;
    "browser.urlbar.suggest.weather" = false;
    "browser.urlbar.suggest.yelp" = false;
    "browser.urlbar.shortcuts.bookmarks" = false;
    "browser.urlbar.shortcuts.history" = false;
    "browser.urlbar.shortcuts.tabs" = false;

    # -- Privacy & Security --
    "privacy.annotate_channels.strict_list.enabled" = true;
    "privacy.donottrackheader.enabled" = true;
    "privacy.globalprivacycontrol.enabled" = true;
    "signon.autofillForms" = false;
    "signon.generation.enabled" = false;
    "signon.rememberSignons" = false;
    "dom.forms.autocomplete.formautofill" = true;
    "dom.security.https_only_mode" = true;
    "network.predictor.enabled" = false;
    "network.dns.disablePrefetch" = true;
    "network.prefetch-next" = false;
    # Sets DNS over HTTPS to use Increased Protection
    "network.trr.mode" = 2;
    "app.shield.optoutstudies.enabled" = false;
  };

  preferredUI = {
    "browser.uiCustomization.state" = "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[\"jid1-mnnxcxisbpnsxq_jetpack-browser-action\",\"_74145f27-f039-47ce-a470-a662b129930a_-browser-action\",\"idcac-pub_guus_ninja-browser-action\"],\"nav-bar\":[\"back-button\",\"forward-button\",\"stop-reload-button\",\"urlbar-container\",\"downloads-button\",\"fxa-toolbar-menu-button\",\"ublock0_raymondhill_net-browser-action\",\"_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action\",\"_contain-facebook-browser-action\",\"unified-extensions-button\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"PersonalToolbar\":[]},\"seen\":[\"save-to-pocket-button\",\"developer-button\",\"_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action\",\"_74145f27-f039-47ce-a470-a662b129930a_-browser-action\",\"_contain-facebook-browser-action\",\"idcac-pub_guus_ninja-browser-action\",\"jid1-mnnxcxisbpnsxq_jetpack-browser-action\",\"ublock0_raymondhill_net-browser-action\"],\"dirtyAreaCache\":[\"nav-bar\",\"PersonalToolbar\",\"unified-extensions-area\",\"toolbar-menubar\",\"TabsToolbar\"],\"currentVersion\":20,\"newElementCount\":9}";
  };
in
{
  programs.firefox.enable = true;

  programs.firefox.profiles.${profile} = {
    isDefault = true;

    search = {
      default = "Google";
      force = true;
      engines = {
        "nixpkgs" = {
          urls = [{
            template = "https://search.nixos.org/packages";
            params = [
              { name = "type"; value = "packages"; }
              { name = "query"; value = "{searchTerms}"; }
            ];
          }];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@nixpkgs" ];
        };
        "DuckDuckGo".metaData.hidden = true;
        "Amazon.com".metaData.hidden = true;
        "Bing".metaData.hidden = true;
        "eBay".metaData.hidden = true;
      };
    };

    /*
    userChrome = if userSettings.firefox.manage.UI
      then ''
        #urlbar .search-one-offs:not([hidden]) {
          display: none !important;
        }
      '' else '' '';
      */

    extensions = with inputs.firefox-addons.packages.${systemSettings.system}; lib.optionals (userSettings.firefox.manage.extensions) [
      ublock-origin
      bitwarden
      privacy-badger
      istilldontcareaboutcookies
      clearurls
      facebook-container
    ];
    
    settings = lib.mkMerge [
      (lib.mkIf (userSettings.firefox.manage.settings) preferredSettings)
      (lib.mkIf (userSettings.firefox.manage.UI) preferredUI)
    ];
  };
}
