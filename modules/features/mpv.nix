{ self, inputs, ... }: {
  flake.nixosModules.mpv = { pkgs, ... }: {
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

  perSystem = { pkgs, ... }: {
    packages.mpv = inputs.wrapper-modules.wrappers.mpv.wrap {
      inherit pkgs;
      
      # TODO: configure appearance and gpu acceleration
      # iamscum.wordpress.com/guides/videoplayback-guide/mpv-conf/
      script = {
        modernz = {
          path = pkgs.mpvScripts.modernz;
        };

        mpris = {
          path = pkgs.mpvScripts.mpris;
        };

        thumbfast = {
          path = pkgs.mpvScripts.thumbfast;
        };
      };
    };
  };
}
