{
  flake.nixosModules.obsidian = { pkgs, ... }: {
    /*
    Obsidian configuration is stored along with the
    vault in .obsidian directory
    */
    environment.systemPackages = [
      pkgs.obsidian
    ];
  };
}
