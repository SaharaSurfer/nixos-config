{
  flake.nixosModules.starship = { pkgs, ...}: {
    programs.starship = {
      enable = true;
      package = pkgs.starship;
      presets = [ "pure-preset" ];
    };
  };
}

