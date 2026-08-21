{
  self,
  inputs,
  config,
  ...
}: {
  flake.nixosModules.jujutsu = {pkgs, ...}: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.jujutsu
    ];
  };

  perSystem = {pkgs, ...}: {
    packages.jujutsu = inputs.wrapper-modules.wrappers.jujutsu.wrap {
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
