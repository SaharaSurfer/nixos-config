{
  self,
  inputs,
  config,
  ...
}: {
  flake.nixosModules.git = {pkgs, ...}: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.git
    ];
  };

  perSystem = {pkgs, ...}: {
    packages.git = inputs.wrapper-modules.wrappers.git.wrap {
      inherit pkgs;
      settings = {
        user = {
          name = config.preferences.user.gitName;
          email = config.preferences.user.email;
        };
      };
    };
  };
}
