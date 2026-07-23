{ self, inputs, ... }: {
  flake.nixosModules.kitty = { pkgs, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.kitty
    ];
  };

  perSystem = { pkgs, ... }: {
    packages.kitty = inputs.wrapper-modules.wrappers.kitty.wrap {
      inherit pkgs;
      settings = {
        confirm_os_window_close = 0;

        font_family = "SFMono Nerd Font";
        font_size = 14.0;

        cursor = "#d8caac";

        background = "#323d43";
        foreground = "#d8caac";

        selection_background = "#303030";
        selection_foreground = "#d9bb80";

        color0 = "#3c474d";
        color8 = "#868d80";

        # red
        color1 = "#e68183";
        color9 = "#e68183";

        # green
        color2 = "#a7c080";
        color10 = "#a7c080";
        
        # yellow
        color3 = "#d9bb80";
        color11 = "#d9bb80";

        # blue
        color4 = "#83b6af";
        color12 = "#83b6af";

        # magenta
        color5 = "#d39bb6";
        color13 = "#d39bb6";

        # cyan
        color6 = "#87c095";
        color14 = "#87c095";

        # gray
        color7 = "#868d80";
        color15 = "#868d80";
      };
    };
  };
}
