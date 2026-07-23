{ self, inputs, ... }: {
  flake.nixosModules.fastfetch = { pkgs, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.fastfetch
    ];
  };

  perSystem = { pkgs, ... }: {
    packages.fastfetch = inputs.wrapper-modules.wrappers.fastfetch.wrap {
      inherit pkgs;
      settings = 
        (builtins.fromJSON
          (builtins.readFile ./config.jsonc));
    };
  };
}
