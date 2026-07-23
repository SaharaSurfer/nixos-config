{
  flake.nixosModules.brave = { pkgs, ... }: {
    environment.systemPackages = [
      pkgs.brave
    ];
  };
}
