{
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
}
