{ self, inputs, ... }: {
  flake.nixosModules.imv = { pkgs, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.imv
    ];

    xdg.mime = {
      enable = true;
      defaultApplications = {
        "image/*" = "imv.desktop";
      };
    };
  };

  perSystem = { pkgs, ... }: {
    packages.imv = inputs.wrapper-modules.wrappers.imv.wrap {
      inherit pkgs;
      settings = {
        options.overlay = false;

        binds = {
          "<Shift+R>" = "rotate by -90";
          r = "rotate by 90";
          h = "flip horizontal";
          v = "flip vertical";
        };
      };
    };
  };
}
