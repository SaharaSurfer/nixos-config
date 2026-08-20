{
  flake.nixosModules.nh = {pkgs, ...}: {
    programs.nh = {
      enable = true;
      package = pkgs.nh;
      clean = {
        enable = true;
        extraArgs = "--keep-since 14d --max 3";
      };
    };

    environment.sessionVariables = {
      NH_FLAKE = "$HOME/nixos-config";
    };
  };
}
