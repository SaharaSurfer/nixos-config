{
  flake.nixosModules.nh = { pkgs, ... }: {
    programs.nh = {
      enable = true;
      package = pkgs.nh;
      clean = {
        enable = true;
        extraArgs = "--keep-since 14d --max 3";
      };
      flake = "~/nixos-config/";
    };
  };
}
