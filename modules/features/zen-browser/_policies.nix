{
  DisableTelemetry = true;
  DisableAppUpdate = true;
  DontCheckDefaultBrowser = true;

  EnableTrackingProtection = {
    Value = true;
    Locked = true;
    Cryptomining = true;
    Fingerprinting = true;
    EmailTracking = true;
  };

  SanitizeOnShutdown = {
    Cache = true;
    FormData = true;
    Cookies = false;
    History = false;
    Sessions = false;
    SiteSettings = false;
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

  HttpsOnlyMode = "force_enabled";
  DNSOverHTTPS = {
    Enabled = true;
    ProviderURL = "https://dns.dnswarden.com/00000000000000000000028";
    Fallback = true;
  };

  SkipTermsOfUse = true;
  OverrideFirstRunPage = "";
  OverridePostUpdatePage = "";
  
  Homepage = {
    StartPage = "previous-session";
    NewTabOnRestore = false;
  };

  Preferences = {
    "browser.aboutConfig.showWarning" = false;

    "browser.ctrlTab.sortByRecentlyUsed" = true;
    "browser.bookmarks.addedImportButton" = false;
    "browser.toolbars.bookmarks.visibility" = "always";

    "browser.urlbar.suggest.history" = false;
    "browser.urlbar.suggest.recentsearches" = false;
    "browser.urlbar.suggest.topsites" = false;
    "browser.urlbar.suggest.openpage" = true;
  };
    
  ExtensionSettings = {
    "uBlock0@raymondhill.net" = {
      installation_mode = "force_installed";
    };
  };
  
  DisableProfileImport = true;
  DisableFirefoxScreenshots = true;
  DisableFirefoxStudies = true;
  
  DisableFormHistory = true;
  AutofillAddressEnabled = false;
  AutofillCreditCardEnabled = false;

  GenerativeAI = {
    Enabled = false;
    Chatbot = false;
    LinkPreviews = false;
    TabGroups = false;
  };

  PasswordManagerEnabled = false;
  OfferToSaveLogins = false;
  
  PromptForDownloadLocation = true;
  HardwareAcceleration = true;
}
