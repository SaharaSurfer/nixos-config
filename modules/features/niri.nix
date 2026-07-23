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
        spawn-at-startup = [
          (lib.getExe self'.packages.noctalia)
        ];        

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        input.keyboard = {
          xkb = {
            layout = "us,ru";
            options = "grp:win_space_toggle";
          };
        };
        
        outputs = {
          "Virtual-1" = {
            mode = "1920x1080@60.000";
            scale = 1.0;
          };
        };

        window-rule = {
          geometry-corner-radius = 10;
          clip-to-geometry = true;
        };

        layout = {
          gaps = 10;

          border = {
            width = 1;
            active-color = "#a5cec2";
            inactive-color = "#a5cec2";
          };

          focus-ring = {
            off = {};
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

        binds = let 
          kittyExe = lib.getExe self'.packages.kitty;
          noctaliaExe = lib.getExe self'.packages.noctalia;
        in {
          "Mod+B".spawn-sh = lib.getExe pkgs.brave;
          "Mod+T".spawn-sh = lib.getExe pkgs.telegram-desktop;
          "Mod+O".spawn-sh = lib.getExe pkgs.obsidian;
          "Mod+K".spawn-sh = lib.getExe self'.packages.kitty;
          "Mod+E".spawn-sh = "${kittyExe} -e yazi";
          "Mod+V".spawn-sh = "code";

          "Mod+M".maximize-column = {};
          "Mod+Q".close-window = {};
          "Mod+L".spawn-sh = "${noctaliaExe} ipc call launcher toggle";
          "Mod+S".spawn-sh = "${noctaliaExe} ipc call settings toggle";
          "Mod+Shift+Q".spawn-sh = "${noctaliaExe} ipc call sessionMenu toggle";
          "Mod+Shift+S".screenshot = {};

          "XF86AudioRaiseVolume".spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
          "XF86AudioLowerVolume".spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          "XF86AudioMute".spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

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
