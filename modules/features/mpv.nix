{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.mpv = {pkgs, ...}: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.mpv
    ];

    xdg.mime = {
      enable = true;
      defaultApplications = {
        "video/*" = "mpv.desktop";
      };
    };
  };

  perSystem = {pkgs, ...}: {
    packages.mpv = inputs.wrapper-modules.wrappers.mpv.wrap {
      inherit pkgs;

      "mpv.conf".content = ''
        profile=high-quality
        vo=gpu-next
        gpu-api=opengl

        force-window=immediate
        fullscreen=yes
        keep-open=yes
        save-position-on-quit=yes
        autocreate-playlist=same
        cursor-autohide=500

        osc=no
        border=no
        osd-bar=no
        osd-level=1

        # Recommended by modernz dev
        watch-later-options-remove=sub-pos
        watch-later-options-remove=osd-margin-y

        volume=50
        volume-max=100
        audio-file-auto=fuzzy

        screenshot-sw=yes
        screenshot-format=png
        screenshot-high-bit-depth=yes
        screenshot-png-compression=7
        screenshot-directory="~/Pictures/"
        screenshot-template="SPOILER_%f-%wH.%wM.%wS.%wT"
      '';

      "mpv.input".content = ''
        SPACE cycle pause
        LEFT seek -5
        RIGHT seek 5
        UP add volume 5
        DOWN add volume -5

        f cycle fullscreen
        m cycle mute
        s screenshot
        q quit
        v cycle sub-visibility
      '';

      script = {
        thumbfast = {
          path = pkgs.mpvScripts.thumbfast;
        };

        mpris = {
          path = pkgs.mpvScripts.mpris;
        };

        modernz = {
          path = pkgs.mpvScripts.modernz;
          opts = {
            layout = "default";
            icon_theme = "fluent";
            icon_style = "outline";
            seekbar_height = "medium";

            window_controls = "no";
            info_button = "no";
            ontop_button = "no";
            screenshot_button = "no";

            seekbarfg_color = "#FFFFFF";
            seekbarbg_color = "#FFFFFF";
            seek_handle_color = "#FFFFFF";
            seek_handle_border_color = "#FFFFFF";
            hover_effect_color = "#C8C8C8";
            hover_effect = "color";

            deadzonesize = 0.0;
          };
        };
      };
    };
  };
}
