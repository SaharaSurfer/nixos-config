{ self, inputs, withSystem, ... }: {
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.laptopConfiguration

      /*
      Pattern used below is documented at
      https://flake.parts/system#approach-2-configure-pkgs-once-in-persystem
      however line `inputs.nixpkgs.nixosModules.readOnlyPkgs` causes
      infinite recursion and thus omitted here.

      Relevant github sources:
      - https://github.com/hercules-ci/flake-parts/issues/339
      - read-only.nix at https://github.com/NixOS/nixpkgs (commit 28096cc)
      */
      ({ config, ... }: {
        nixpkgs.pkgs = withSystem config.nixpkgs.hostPlatform.system (
          {pkgs, ... }: pkgs
        );
      })
    ];
  };
}
