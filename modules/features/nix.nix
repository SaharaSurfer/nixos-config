{
  flake.nixosModules.nix = {pkgs, ...}: {
    nix.settings = {
      trusted-users = ["sahara_surfer"]; # Allows to add cache servers
      experimental-features = ["nix-command" "flakes"];
    };

    environment.systemPackages = with pkgs; [
      nixd
      statix
      alejandra
    ];
  };
}
