{ inputs, ... }: {
  flake.nixosModules.zen-browser = {
    home-manager.users.sahara_surfer = {
      imports = [ inputs.zen-browser.homeModules.beta ];

      programs.zen-browser = {
        enable = true;
        setAsDefaultBrowser = true;

        policies = {
          DisableTelemetry = true;
          DisableAppUpdate = true;
          EnableTrackingProtection = {
            Value = true;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
            EmailTracking = true;
          };

          NoDefaultBookmarks = true;
          SearchEngines = {
            Default = "DuckDuckGo";
            Remove = [
              "Google"
              "Bing"
              "eBay"
              "Ecosia"
              "Perplexity"
              "Qwant"
            ];
          };

          Preferences = {
            "dom.security.https_only_mode" = true;
            "dom.security.https_only_mode_ever_enabled" = true;
            "network.socket.ip_addr_any.disabled" = true;

            "signon.rememberSignons" = false;
            "browser.formfill.enable" = false;

            "browser.startup.page" = 3;
            "browser.startup.homepage" = "";
            "browser.startup.firstrunSkipsHomepage" = true;
            "browser.startup.homepage_override.mstone" = "ignore";

            "browser.aboutConfig.showWarning" = false;
            "browser.aboutwelcome.enabled" = false;
            "browser.shell.checkDefaultBrowser" = false;

            "browser.newtabpage.activity-stream.enabled" = false;
            "browser.ctrlTab.sortByRecentlyUsed" = true;
            "browser.toolbars.bookmarks.visibility" = "always";
            "browser.bookmarks.addedImportButton" = false;

            "browser.urlbar.suggest.history" = false;
            "browser.urlbar.suggest.recentsearches" = false;
            "browser.urlbar.suggest.topsites" = false;
            "browser.urlbar.suggest.openpage" = true;

            "browser.search.update" = false;
            "browser.discovery.enabled" = false;
            
            "extensions.webextensions.restrictedDomains" = "";
            
            "extensions.getAddons.cache.enabled" = false;
            "extensions.getAddons.showPane" = false;
            "extensions.htmlaboutaddons.recommendations.enabled" = false;

            "gfx.webrender.all" = true;
            "widget.dmabuf.force-enabled" = true;
            "network.http.http3.enable" = true;
          };

          OverrideFirstRunPage = "";
          OverridePostUpdatePage = "";

          ExtensionSettings = {
            "uBlock0@raymondhill.net" = {
              installation_mode = "force_installed";
            };
          };

          DisableAccounts = true;
          DisableFirefoxAccounts = true;
          DisableFirefoxScreenshots = true;
          DisableFirefoxStudies = true;
          DisableProfileImport = true;

          AutofillAddressEnabled = false;
          AutofillCreditCardEnabled = false;
          GenerativeAI.Enabled = false;
          PasswordManagerEnabled = false;
          OfferToSaveLogins = false;
          CaptivePortal = false;

          PromptForDownloadLocation = true;
          HardwareAcceleration = true;
        };

        profiles.default.settings = {
          "zen.glance.enabled" = false;
          "zen.tabs.show-newtab-vertical" = false;
          "zen.urlbar.behavior" = "normal";
          "zen.view.compact.enable-at-startup" = false;
          "zen.view.show-newtab-button-top" = false;
          "zen.view.use-single-toolbar" = false;
          "zen.view.window.scheme" = 0;
          "zen.welcome-screen.seen" = true;
          "zen.workspaces.continue-where-left-off" = true;
        };

        profiles.default.mods = [
          "b51ff956-6aea-47ab-80c7-d6c047c0d510"  # Disable Status Bar
          "bd92a9a0-1c00-4187-a66e-94c389fa5a59"  # Sidebar Expand on Hover
          "599a1599-e6ab-4749-ab22-de533860de2c"  # Pimp your PiP
          "72f8f48d-86b9-4487-acea-eb4977b18f21"  # Better CtrlTabPanel
        ];
      };
    };
  };
}
