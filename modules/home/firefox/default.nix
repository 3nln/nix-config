{
  pkgs,
  lib,
  ...
}: let
  addons = pkgs.nur.repos.rycee.firefox-addons;

  fromAMO = {
    pname,
    addonId,
    slug,
    sha256,
  }:
    addons.buildFirefoxXpiAddon {
      inherit pname addonId sha256;
      version = "latest";
      url = "https://addons.mozilla.org/firefox/downloads/latest/${slug}/addon-latest.xpi";
      meta = {};
    };

  whatfont = fromAMO {
    pname = "whatfont";
    addonId = "armishiaverduzcot200168@hotmail.com";
    slug = "whatfont";
    sha256 = "01rgp8q1zzncqdpzvpaqszc28da9x3vmh8y609vkfwz7jnq9a77l";
  };

  colorzilla = fromAMO {
    pname = "colorzilla";
    addonId = "{6AC85730-7D0F-4de0-B3FA-21142DD85326}";
    slug = "colorzilla";
    sha256 = "16g9bxjdz8m8gq7lk1dl6rs4yflzrf7q1haymlmbl57rvcssyyvm";
  };

  mobile-simulator = fromAMO {
    pname = "mobile-simulator";
    addonId = "{edfc63b3-fc9b-4b6b-b9bf-4561ad548044}";
    slug = "simulateur-mobile";
    sha256 = "02fiz893ynm55xrjsy97z2s2af84q828ph2k4i2bf301p70vs3p8";
  };

  locatorjs = fromAMO {
    pname = "locatorjs";
    addonId = "{330c9655-a428-407c-9613-9b62a7b06416}";
    slug = "locatorjs";
    sha256 = "1zvf08f02ky2phjkk2f01i7vli9imv3sfjizkvs60crzgxfygaxd";
  };

  temp-mail = fromAMO {
    pname = "temp-mail";
    addonId = "{2d97895d-fcd3-41ab-82e6-6a1d4d2243f6}";
    slug = "temp-mail";
    sha256 = "05c6nlyrj1aqh41b1b7n05w7xlir336gbvczn7lwayjaxb4bxksl";
  };

  cors-everywhere = fromAMO {
    pname = "cors-everywhere";
    addonId = "cors-everywhere@spenibus";
    slug = "cors-everywhere";
    sha256 = "0s9w0ncybn73rjpg5icl3jw63wnwpa9q079i6cfpb0x452my3ksp";
  };

  adguard = fromAMO {
    pname = "adguard-adblocker";
    addonId = "adguardadblocker@adguard.com";
    slug = "adguard-adblocker";
    sha256 = "1a9p2d83b3ah0m11fwl2n2qbz8f4aij1lg9kh66brzbvgp38hqx5";
  };

  unhook = fromAMO {
    pname = "unhook";
    addonId = "myallychou@gmail.com";
    slug = "youtube-recommended-videos";
    sha256 = "058dfiwfmagsn9k665vmqak7s6j0zqy7hlj19vjfrj28vyw6hvdv";
  };
in {
  programs.firefox = {
    enable = true;

    profiles.default = {
      id = 0;
      isDefault = true;

      extensions.packages = with addons; [
        # Dev tools
        vue-js-devtools
        react-devtools
        locatorjs

        # Design / inspection
        whatfont # pinned
        wappalyzer # pinned
        fake-filler
        colorzilla # pinned
        mobile-simulator # pinned

        # Utility
        temp-mail # pinned
        cors-everywhere # pinned
        adguard
        unhook # pinned

        # Content blocking
        sponsorblock
        ublock-origin

        # System
        plasma-integration
      ];

      settings = {
        # Privacy
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;

        # Vertical tabs (Firefox 131+)
        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;

        # UI
        "browser.startup.page" = 1;
        "browser.newtabpage.enabled" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.tabs.warnOnClose" = false;
        "browser.toolbars.bookmarks.visibility" = "never";

        # Toolbar layout — pinned extensions in nav-bar
        "browser.uiCustomization.state" = builtins.toJSON {
          placements = {
            nav-bar = [
              "back-button"
              "forward-button"
              "stop-reload-button"
              "urlbar-container"
              "downloads-button"
              "armishiaverduzcot200168_hotmail_com-browser-action" # WhatFont
              "_a26db6c8-c3a4-4f45-8da2-c9fa17f44148_-browser-action" # Wappalyzer
              "_6ac85730-7d0f-4de0-b3fa-21142dd85326_-browser-action" # ColorZilla
              "_edfc63b3-fc9b-4b6b-b9bf-4561ad548044_-browser-action" # Mobile Simulator
              "_2d97895d-fcd3-41ab-82e6-6a1d4d2243f6_-browser-action" # Temp Mail
              "cors-everywhere_spenibus-browser-action" # CORS Everywhere
              "myallychou_gmail_com-browser-action" # Unhook
              "unified-extensions-button"
            ];
            unified-extensions-area = [];
          };
          currentVersion = 20;
          newElementCount = 0;
        };
      };

      search = {
        force = true;
        default = "google";
        privateDefault = "DuckDuckGo";
      };
    };
  };
}
