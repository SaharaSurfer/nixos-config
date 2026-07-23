{ self, inputs, ... }: {
  flake.nixosModules.yazi = { pkgs, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.yazi

      # previews
      pkgs.ffmpeg       # video
      pkgs.jq           # json
      pkgs.poppler      # pdf
      pkgs.resvg        # svg
      pkgs.imagemagick  # fonts, heic, etc.

      # navigation
      pkgs.fd           # file searching
      pkgs.fzf          # subtree navigation
      pkgs.zoxide       # better cd
      pkgs.ripgrep      # file content searching
    ];
  };

  perSystem = { pkgs, ...}: {
    packages.yazi = inputs.wrapper-modules.wrappers.yazi.wrap {
      inherit pkgs;
      package = pkgs.yazi.override {
        _7zz = pkgs._7zz-rar;
      };
    };
  };
}
