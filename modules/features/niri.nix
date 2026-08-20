{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.niri;
    };
  };  

  perSystem = { pkgs, lib, self', ... }: {
    packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      
      settings = {
        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        spawn-at-startup = [
          (lib.getExe self'.packages.noctalia)
        ];

        hotkey-overlay = {
          skip-at-startup = {};
        };

        input.keyboard = {
          numlock = {};
          xkb = {
            layout = "us,ru";
            options = "grp:caps_toggle";
          };
        };

        input.touchpad = {
          tap = {};
          natural-scroll = {};
        };
        
        gestures = {
          hot-corners = {
            off = {};
          };
        };

        layout = {
          gaps = 10;
          focus-ring.off = {};

          border = {
            width = 1;
            active-color = "#a5cec2";
            inactive-color = "#a5cec2";
          };

          shadow = {
            on = {};
            softness = 7;
            spread = 1;
            offset = _: {
              props = { x = 0; y = 0; };
            };
            color = "#a5cec2";
            inactive-color = "#000000";
          };
        };

        # Per window layout overrides
        window-rules = [
          { # General settings
            geometry-corner-radius = 10;
            clip-to-geometry = true;
          }
          { # Screencast indication
            matches = [
              {
                is-window-cast-target = true;
              }
            ];

            border = {
              width = 1;
              active-color = "#f38ba8";
              inactive-color = "#f38ba8";
            };

            shadow = {
              on = {};
              softness = 7;
              spread = 1;
              offset = _: {
                props = { x = 0; y = 0; };
              };
              color = "#f38ba8";
              inactive-color = "#000000";
            };
          }
        ];

        binds = let 
          kittyExe = lib.getExe self'.packages.kitty;
          noctaliaExe = lib.getExe self'.packages.noctalia;
        in {
          "Mod+B".spawn-sh = "zen-beta";
          "Mod+T".spawn-sh = lib.getExe pkgs.telegram-desktop;
          "Mod+O".spawn-sh = lib.getExe pkgs.obsidian;
          "Mod+K".spawn-sh = lib.getExe self'.packages.kitty;
          "Mod+E".spawn-sh = "${kittyExe} -e yazi";
          "Mod+Escape".spawn-sh = "${kittyExe} -e btop";
          "Mod+V".spawn-sh = "code";

          "Mod+M".maximize-column = {};
          "Mod+Q".close-window = {};
          "Mod+S".spawn-sh = "${noctaliaExe} msg settings-toggle";
          "Mod+L".spawn-sh = "${noctaliaExe} msg panel-toggle launcher";
          "Mod+C".spawn-sh = "${noctaliaExe} msg panel-toggle clipboard";
          "Mod+Shift+Q".spawn-sh = "${noctaliaExe} msg panel-toggle session";
          "Mod+Shift+S".spawn-sh = "${noctaliaExe} msg screenshot-region";

          /*
          Currently there is no way to instantly change screencasted window
          on a click. Proper binds will arrive once PR(s) below is merged
          or similar functionality implemented.

                    https://github.com/niri-wm/niri/pull/4189
                    https://github.com/niri-wm/niri/pull/4388

          "Mod+Ctrl+MouseLeft".set-dynamic-cast-window = {};
          "Mod+Ctrl+MouseRight".set-dynamic-cast-monitor = {};
          "Mod+Ctrl+MouseMiddle".clear-dynamic-cast-target = {};
          */

          "XF86AudioRaiseVolume".spawn-sh = "${noctaliaExe} msg volume-up 5%";
          "XF86AudioLowerVolume".spawn-sh = "${noctaliaExe} msg volume-down 5%";
          "XF86AudioMute".spawn-sh = "${noctaliaExe} msg volume-mute";

          # TODO: fix these binds (Fn+F3 and Fn+F4 doesn't work)
          "XF86MonBrightnessUp".spawn-sh = "${noctaliaExe} msg brightness-up 5%";
          "XF86MonBrightnessDown".spawn-sh = "${noctaliaExe} msg brightness-down 5%";

          "Mod+Up".focus-window-up = {};
          "Mod+Down".focus-window-down = {};
          "Mod+Left".focus-column-left = {};
          "Mod+Right".focus-column-right = {};

          "Mod+Ctrl+Up".move-window-up = {};
          "Mod+Ctrl+Down".move-window-down = {};
          "Mod+Ctrl+Left".move-column-left = {};
          "Mod+Ctrl+Right".move-column-right = {};

          "Mod+Shift+Up".set-window-height = "+5%";
          "Mod+Shift+Down".set-window-height = "-5%";
          "Mod+Shift+Left".set-window-width = "-5%";
          "Mod+Shift+Right".set-window-width = "+5%";

          "Mod+1".focus-workspace = 1;
          "Mod+2".focus-workspace = 2;
          "Mod+3".focus-workspace = 3;
          "Mod+4".focus-workspace = 4;
          "Mod+5".focus-workspace = 5;

          "Mod+Ctrl+1".move-column-to-workspace = 1;
          "Mod+Ctrl+2".move-column-to-workspace = 2;
          "Mod+Ctrl+3".move-column-to-workspace = 3;
          "Mod+Ctrl+4".move-column-to-workspace = 4;
          "Mod+Ctrl+5".move-column-to-workspace = 5;
        };
      };
    };
  };
}
