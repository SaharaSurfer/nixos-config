{config, ...}: {
  flake.nixosModules.nix = {pkgs, ...}: {
    nix.settings = {
      trusted-users = [config.preferences.user.name];
      experimental-features = ["nix-command" "flakes"];
    };

    environment.systemPackages = with pkgs; [
      nixd
      statix
      alejandra
    ];
  };
}
